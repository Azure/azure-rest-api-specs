import { readFile, writeFile } from "fs/promises";
import { exec, ExecException } from "node:child_process";
import { parseArgs, ParseArgsConfig } from "node:util";
import { getOpenapiType, getAllTags, getInputFiles, getDefaultTag } from "./markdown-utils.js";
import { sep, dirname, join } from "path";
import { kebabCase } from "change-case";
import {
  pathExists,
  getPathToDependency,
  readFileList,
  getAffectedServices,
  getSwaggerDependenciesMap,
  getAffectedSwaggers,
  getAffectedReadmes,
  getService,
  deduplicateTags,
  AutorestRunResult,
  logAutorestExecutionErrors,
  BeforeAfter,
  getLintDiffViolations,
  isFailure,
  isWarning,
  getNewItems,
  LintDiffViolation,
} from "./util.js";

// 64 MiB max output buffers for exec
const MAX_EXEC_BUFFER = 64 * 1024 * 1024;

function usage() {
  console.log("TODO: Write up usage");
}

export async function main() {
  let validArgs = true;
  const config: ParseArgsConfig = {
    options: {
      before: {
        type: "string",
        short: "b",
      },
      after: {
        type: "string",
        short: "a",
      },
      "changed-files-path": {
        type: "string",
        short: "c",
      },
      "out-file": {
        type: "string",
        short: "o",
        default: "lint-diff.md",
      },
      "base-branch": {
        type: "string",
        short: "b",
        default: "main",
      },
      "compare-sha": {
        type: "string",
        short: "m",
        default: "main",
      },
    },
    strict: true,
  };

  const {
    values: {
      before: beforeArg,
      after: afterArg,
      "changed-files-path": changedFilesPath,
      "out-file": outFile,
      "base-branch": baseBranch,
      "compare-sha": compareSha,
    },
  } = parseArgs(config);

  // TODO: Handle trailing slashes properly
  if (!beforeArg || !(await pathExists(beforeArg as string))) {
    validArgs = false;
    console.log(`--before must be a valid path. Value passed: ${beforeArg || "<empty>"}`);
  }

  // TODO: Handle trailing slashes properly
  if (!afterArg || !(await pathExists(afterArg as string))) {
    validArgs = false;
    console.log(`--after must be a valid path. Value passed: ${afterArg || "<empty>"}`);
  }

  if (!changedFilesPath || !(await pathExists(changedFilesPath as string))) {
    validArgs = false;
    console.log("--changed-files-path missing");
  }

  if (!validArgs) {
    usage();
    process.exit(1);
  }

  // const versionResult = await executeCommand("npm exec -- autorest --version");
  // if (versionResult.error) {
  //   console.error("Error running autorest --version", versionResult.error);
  //   process.exit(1);
  // }

  // console.log("Autorest version:");
  // console.log(versionResult.stdout);

  await runLintDiff(
    beforeArg as string,
    afterArg as string,
    changedFilesPath as string,
    outFile as string,
    baseBranch as string,
    compareSha as string,
  );
}

async function runLintDiff(
  beforePath: string,
  afterPath: string,
  changedFilesPath: string,
  outFile: string,
  baseBranch: string,
  compareSha: string,
) {
  const dependenciesDir = await getPathToDependency("@microsoft.azure/openapi-validator");
  const dependencyVersion = await getDependencyVersion(dependenciesDir);

  // Read changed files, exclude any files that should be ignored
  const ignoreFilesWith = ["/examples/", "/quickstart-templates/", "/scenarios/"];
  const changedSpecFiles = (await readFileList(changedFilesPath)).filter((file) => {
    // File is in specification/ folder
    if (!file.startsWith(`specification${sep}`)) {
      return false;
    }

    // File is not ignored
    for (const ignore of ignoreFilesWith) {
      if (file.includes(ignore)) {
        return false;
      }
    }
    return true;
  });

  // In the future, the loop involving [beforePath, afterPath] can be eliminated
  // as well as beforeState
  const beforeState = await buildState(changedSpecFiles, beforePath);
  const afterState = await buildState(changedSpecFiles, afterPath);

  // TODO: Name
  const [beforeMap, afterMap] = await reconcileChangedFilesAndTags(beforeState, afterState);

  const reportMap = new Map<"before" | "after", AutorestRunResult[]>();

  // TODO: Structure legibly
  for (const { path, map, state } of [
    { path: beforePath, map: beforeMap, state: "before" },
    { path: afterPath, map: afterMap, state: "after" },
  ]) {
    for (const [readme, tags] of map.entries()) {
      const changedFilePath = join(path, readme);
      console.log(`Linting ${changedFilePath}`);

      let openApiType = await getOpenapiType(changedFilePath);

      // From momentOfTruth.ts:executeAutoRestWithLintDiff
      // This is a quick workaround for https://github.com/Azure/azure-sdk-tools/issues/6549
      // We override the openapi-subtype with the value of openapi-type,
      // to prevent LintDiff from reading openapi-subtype from the AutoRest config file (README)
      // and overriding openapi-type with it.
      let openApiSubType = openApiType;

      // If the tags array is empty run the loop once but with a null tag
      const coalescedTags = tags?.length ? tags : [null];
      for (const tag of coalescedTags) {
        let tagArg = tag ? `--tag=${tag} ` : "";

        let autorestCommand =
          `npm exec --no -- autorest ` +
          `--v3 ` +
          `--spectral ` +
          `--azure-validator ` +
          `--semantic-validator=false ` +
          `--model-validator=false ` +
          `--message-format=json ` +
          `--openapi-type=${openApiType} ` +
          `--openapi-subtype=${openApiSubType} ` +
          `--use=${dependenciesDir} ` +
          `${tagArg} ` +
          `${changedFilePath}`;

        console.log(`autorest command: ${autorestCommand}`);
        const executionResult = await executeCommand(autorestCommand);
        const lintDiffResult = {
          autorestCommand,
          rootPath: path,
          readme,
          tag: tag ? tag : "",
          openApiType,
          ...executionResult,
        };
        logAutorestExecutionErrors(lintDiffResult);
        if (!reportMap.has(state as "before" | "after")) {
          reportMap.set(state as "before" | "after", []);
        }

        reportMap.get(state as "before" | "after")!.push(lintDiffResult);
        console.log("Lint diff result length:", lintDiffResult.stdout.length);
      }
    }
  }

  // Build map of compared readmes and tags from autorest runs. This can be
  // removed when "before" state is removed.
  const runCorrelations = new Map<string, BeforeAfter>();
  for (const results of reportMap.get("after")!) {
    const { readme, tag } = results;
    const key = tag ? `${readme}#${tag}` : readme;
    if (runCorrelations.has(key)) {
      throw new Error(`Duplicate key found correlating autorest runs: ${key}`);
    }

    const beforeCandidates = reportMap
      .get("before")!
      .filter((r) => r.readme === readme && r.tag === tag);
    if (beforeCandidates.length === 1) {
      runCorrelations.set(key, {
        before: beforeCandidates[0],
        after: results,
      });
      continue;
    } else if (beforeCandidates.length > 1) {
      throw new Error(`Multiple before candidates found for key ${key}`);
    }

    // Look for candidates with a matching default tag from the baseline
    const beforeReadmePath = join(beforePath, readme);
    if (await pathExists(beforeReadmePath)) {
      const readmeContent = await readFile(beforeReadmePath, { encoding: "utf-8" });
      const defaultTag = getDefaultTag(readmeContent);
      if (!defaultTag) {
        throw new Error(`No default tag found for readme ${readme} in before state`);
      }
      const beforeDefaultTagCandidates = reportMap
        .get("before")!
        .filter((r) => r.readme === readme && r.tag === defaultTag);

      if (beforeDefaultTagCandidates.length === 1) {
        runCorrelations.set(key, {
          before: beforeDefaultTagCandidates[0],
          after: results,
        });
        continue;
      } else if (beforeDefaultTagCandidates.length > 1) {
        throw new Error(
          `Multiple before candidates found for key ${key} using default tag ${defaultTag}`,
        );
      }

      const beforeReadmeCandidate = reportMap.get("before")!.filter((r) => r.readme === readme);
      if (beforeReadmeCandidate.length === 1) {
        runCorrelations.set(key, {
          before: beforeReadmeCandidate[0],
          after: results,
        });
        continue;
      } else if (beforeReadmeCandidate.length > 1) {
        throw new Error(`Multiple before candidates found for key ${key} using readme ${readme}`);
      }
    }

    console.log(`No before candidates found for key ${key}, using no baseline`);
    runCorrelations.set(key, {
      before: null,
      after: results,
    });
  }

  // See unifiedPipelineHelper.ts:386
  // Compared specs (link to npm package: @microsoft.azure/openapi-validator/v/<version>)
  let outputMarkdown = `| Compared specs ([v${dependencyVersion}](https://www.npmjs.com/package/@microsoft.azure/openapi-validator/v/${dependencyVersion})) | new version | base version |\n`;
  outputMarkdown += `| --- | --- | --- |\n`;

  // Compared Specs | New Version | Base Version
  // <tag name> | link: readme.md#tag-<tag-name> | link: readme.md#tag-<tag-name>
  // ... | ... | ...
  for (const [_, { before, after }] of runCorrelations.entries()) {
    // TODO: DRY
    const afterName = after.tag ? after.tag : "default";
    const beforeName = before?.tag ? before?.tag : "default";
    const afterPath = after.tag ? `${after.readme}#tag-${after.tag}` : after.readme;
    // TODO: Clean this up
    const beforePath = before
      ? before?.tag
        ? `${before?.readme}#tag-${before?.tag}`
        : before?.readme
      : "";

    outputMarkdown += `| ${afterName} | link: [${afterName}](${getFileLink(compareSha, afterPath)}) | link: [${beforeName}](${getFileLink(baseBranch, beforePath)}) |\n`;
  }

  outputMarkdown += `\n\n`;

  const newViolations: LintDiffViolation[] = [];
  const existingViolations: LintDiffViolation[] = [];

  for (const [_, { before, after }] of runCorrelations.entries()) {
    // TODO: May need to do some filtering of unrelated swaggers, see
    // momentOfTruthPostProcessing.ts:421
    // TODO: Trinary, should this happen?
    const beforeViolations = before
      ? getLintDiffViolations(before).filter((v) => isFailure(v.level) || isWarning(v.level))
      : [];
    const afterViolations = getLintDiffViolations(after).filter(
      (v) => isFailure(v.level) || isWarning(v.level),
    );

    const [newitems, existingItems] = await getNewItems(beforeViolations, afterViolations);
    console.log(`New violations: ${newitems.length}`);
    console.log(`Existing violations: ${existingItems.length}`);

    newViolations.push(...newitems);
    existingViolations.push(...existingItems);
  }

  newViolations.sort(compareLintDiffViolations);
  existingViolations.sort(compareLintDiffViolations);

  // MUST FIX Following errors/warnings are introduced by the current PR
  // Rule | Message | Related RPC [For API reviewers]
  if (newViolations.length > 0) {
    outputMarkdown += "**[must fix]The following errors/warnings are intorduced by current PR:**\n";
    if (newViolations.length > 50) {
      // TODO: Const
      outputMarkdown += "Only 50 items are listed, please refer to log for more details.\n";
    }
    outputMarkdown += "\n";

    outputMarkdown += "| Rule | Message | Related RPC [For API reviewers] |\n";
    outputMarkdown += "| ---- | ------- | ------------------------------- |\n";

    for (const violation of newViolations.slice(0, 50)) {
      const { level, code, message } = violation;
      outputMarkdown += `| ${iconFor(level)} [${code}](${getDocUrl(code)}) | ${message}<br />Location: [${getPathSegment(normalizePath(getFile(violation) || ""))}#L${getLine(violation)}](${getFileLink(compareSha, normalizePath(getFile(violation) || ""), getLine(violation))}) | ${violation.armRpcs?.join(", ")} |\n`;
    }

    outputMarkdown += "\n";
  }

  // The following errors/warnings exist before current PR submission
  // Rule | Message | Location (link to file, line # at SHA)
  if (existingViolations.length > 0) {
    outputMarkdown += "**The following errors/warnings exist before current PR submission:**\n";
    if (existingViolations.length > 50) {
      // TODO: Const
      outputMarkdown += "Only 50 items are listed, please refer to log for more details.\n";
    }
    outputMarkdown += "\n";

    // TODO: ensure columns are correct
    outputMarkdown += "| Rule | Message |\n";
    outputMarkdown += "| ---- | ------- |\n";

    for (const violation of existingViolations.slice(0, 50)) {
      const { level, code, message } = violation;
      outputMarkdown += `| ${iconFor(level)} [${code}](${getDocUrl(code)}) | ${message}<br />Location: [${getPathSegment(normalizePath(getFile(violation) || ""))}#L${getLine(violation)}](${getFileLink(compareSha, normalizePath(getFile(violation) || ""), getLine(violation))}) |\n`;
    }

    outputMarkdown += `\n`;
  }

  console.log(`Writing output to ${outFile}`);
  await writeFile(outFile, outputMarkdown);
}

async function executeCommand(
  command: string,
  cwd: string = ".",
): Promise<{ error: ExecException | null; stdout: string; stderr: string }> {
  return new Promise((resolve) => {
    exec(
      command,
      { cwd, encoding: "utf-8", maxBuffer: MAX_EXEC_BUFFER },
      (error, stdout, stderr) => {
        resolve({ error, stdout, stderr });
      },
    );
  });
}

/**
 * Compare two LintDiffViolation objects for sorting. First sort by level with
 * error being higher than warning. Then sort by file name and line number.
 * @param a
 * @param b
 */
export function compareLintDiffViolations(a: LintDiffViolation, b: LintDiffViolation): number {
  // Sort by level
  if (isFailure(a.level) && isWarning(b.level)) {
    return -1;
  } else if (isWarning(a.level) && isFailure(b.level)) {
    return 1;
  }

  // Sort by file name
  if (getFile(a) !== getFile(b)) {
    return getFile(a)!.localeCompare(getFile(b)!);
  }

  // Sort by line number
  const lineA = getLine(a) || 0;
  const lineB = getLine(b) || 0;

  if (lineA < lineB) {
    return -1;
  } else if (lineA > lineB) {
    return 1;
  }

  return 0;
}

/**
 * Normalize a path to be relative to a given directory.
 * @param path File path with separators from the current system
 * @param by A directory name to treat as the root (e.g. /specification/)
 */
// TODO: maybe use a different name so as not to be confused with path normalize
export function normalizePath(path: string, by: string = `${sep}specification${sep}`): string {
  const indexOfBy = path.indexOf(by);
  // TODO: how to handle case where `by` is not found?
  if (indexOfBy === -1) {
    return path;
  }

  return path.substring(indexOfBy);
}

export function getPathSegment(path: string): string {
  return path.split("/").slice(-4).join("/");
}

export function getFileLink(sha: string, path: string, line: number | null = null) {
  // TODO: Ensure proper path separator behavior (including, not including leaidng '/')
  if (line === null) {
    return `https://github.com/Azure/azure-rest-api-specs/blob/${sha}${path}`;
  }

  return `https://github.com/Azure/azure-rest-api-specs/blob/${sha}${path}#L${line}`;
}

export function getDocUrl(id: string) {
  if (id == "FATAL") {
    return `N/A`;
  }

  return `https://github.com/Azure/azure-openapi-validator/blob/main/docs/${kebabCase(id)}.md`;
}

export function getFile(lintDiffViolation: LintDiffViolation) {
  try {
    return lintDiffViolation.source?.[0]?.document;
  } catch (error) {
    return undefined;
  }
}

export function getLine(lintDiffViolation: LintDiffViolation): number | undefined {
  try {
    return lintDiffViolation.source?.[0]?.position?.line;
  } catch (error) {
    return undefined;
  }
}

function iconFor(type: string, num: unknown = undefined) {
  if (num === 0) {
    return ":white_check_mark:";
  }

  if (type.toLowerCase().includes("error")) {
    return ":x:";
  } else {
    return ":warning:";
  }
}

type State = {
  // TODO: Narrow this object to specific properties that are used in later
  // steps.
  rootPath: string;
  existingChangedFiles: string[];
  affectedServiceDirectories: Set<string>;
  affectedSwaggerMap: Map<string, string[]>;
  affectedReadmes: string[];
  readmeTags: Map<string, Set<string>>;

  // Final list of things to work on
  changedFileAndTagsMap: Map<string, string[]>;
};

export async function buildState(changedSpecFiles: string[], rootPath: string): Promise<State> {
  // Filter changed files to include only those that exist in the rootPath
  const existingChangedFiles = [];
  for (const file of changedSpecFiles) {
    if (await pathExists(join(rootPath, file))) {
      existingChangedFiles.push(file);
    }
  }

  // Get affected services from changed files
  // e.g. specification/service1/readme.md -> specification/service1
  const affectedServiceDirectories = await getAffectedServices(existingChangedFiles);

  // Get a map of a service's swagger files and their dependencies
  // TODO: Use set or array?
  const affectedSwaggerMap = new Map<string, string[]>();
  for (const serviceDir of affectedServiceDirectories) {
    const changedServiceFiles = existingChangedFiles.filter((file) => file.startsWith(serviceDir));
    const serviceDependencyMap = await getSwaggerDependenciesMap(rootPath, serviceDir);

    affectedSwaggerMap.set(
      serviceDir,
      await getAffectedSwaggers(changedServiceFiles, serviceDependencyMap),
    );
  }

  // Use changedSpecFiles (which might not be present in the branch) to get
  // a set of affected readme files.
  const affectedReadmes = await getAffectedReadmes(changedSpecFiles, rootPath);

  const readmeTags = new Map<string, Set<string>>();
  for (const readme of affectedReadmes) {
    const readmeService = await getService(readme);
    if (!affectedSwaggerMap.has(readmeService)) {
      continue;
    }

    // TODO: The parser is used twice to get tags and input files. This can be
    // made more efficient.
    const readmeContent = await readFile(join(rootPath, readme), { encoding: "utf-8" });
    for (const tag of getAllTags(readmeContent)) {
      const inputFiles = (await getInputFiles(readmeContent, tag))?.map((file) =>
        join(dirname(readme), file),
      );
      if (inputFiles === undefined || inputFiles.length === 0) {
        continue;
      }

      // Readme + Tag Combo

      // TODO: ensure ! is correct to do here
      for (const swagger of affectedSwaggerMap.get(readmeService)!) {
        if (inputFiles.includes(swagger)) {
          if (!readmeTags.has(readme)) {
            readmeTags.set(readme, new Set<string>());
          }
          readmeTags.get(readme)?.add(tag);
        }
      }
    }
  }

  // TODO: Deduplicate inside or outside state building? It's possible that
  // later processing like that in reconcileChangedFilesAndTags
  const changedFileAndTagsMap = new Map<string, string[]>();
  for (const [readme, tags] of readmeTags.entries()) {
    const dedupedTags = await deduplicateTags(
      [...tags],
      await readFile(join(rootPath, readme), { encoding: "utf-8" }),
    );

    changedFileAndTagsMap.set(readme, dedupedTags);
  }

  // TODO: How do we ensure directly edited readme.md files are handled
  // properly? e.g. is the whole file scanned or is it constrained to
  // specific tags?

  // For readme files that have changed but there are no affected swaggers,
  // add them to the map with no tags
  for (const changedReadme of affectedReadmes) {
    if (!changedFileAndTagsMap.has(changedReadme)) {
      changedFileAndTagsMap.set(changedReadme, []);
    }
  }

  return {
    rootPath,
    existingChangedFiles,
    affectedServiceDirectories,
    affectedSwaggerMap,
    affectedReadmes,
    readmeTags,
    changedFileAndTagsMap,
  };
}

/**
 * Build mappings of changed readmes and tags to scan by examining state of the
 * repo before and after the change. This function is not necessary when
 * "before" is removed.
 * @param before before the change
 * @param after after the change
 * @returns maps of readme files and tags to scan
 */
export async function reconcileChangedFilesAndTags(
  before: State,
  after: State,
): Promise<Map<string, string[]>[]> {
  const beforeFinal = new Map<string, string[]>();
  const afterFinal = new Map<string, string[]>();

  // Clone the maps so that changes to maps do not affect original object
  for (const [readme, tags] of before.changedFileAndTagsMap.entries()) {
    beforeFinal.set(readme, [...tags]);
  }
  for (const [readme, tags] of after.changedFileAndTagsMap.entries()) {
    afterFinal.set(readme, [...tags]);
  }

  // If a tag is deleted in after and exists in before, do NOT scan the tag
  for (const [readme, tags] of beforeFinal.entries()) {
    // TODO: A deleted readme might also be cause to remove from scanning,
    // which this currently does not do.
    if (!afterFinal.has(readme)) {
      continue;
    }

    const afterTags = new Set(afterFinal.get(readme)!);
    beforeFinal.set(
      readme,
      tags.filter((tag) => afterTags.has(tag)),
    );
  }

  return [beforeFinal, afterFinal];
}

export async function getDependencyVersion(dependenciesDir: string): Promise<string> {
  const packageJsonPath = join(dependenciesDir, "package.json");
  const packageJson = JSON.parse(await readFile(packageJsonPath, { encoding: "utf-8" }));
  const version = packageJson.version;
  if (!version) {
    throw new Error(`Version not found in package.json at ${packageJsonPath}`);
  }
  return version;
}
