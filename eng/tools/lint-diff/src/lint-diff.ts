import { readFile } from "fs/promises";
// import { exec } from "node:child_process";
import { parseArgs, ParseArgsConfig } from "node:util";
import { getOpenapiType, getAllTags, getInputFiles } from "./markdown-utils.js";
import { sep, dirname, join } from "path";
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
} from "./util.js";

// 64 MiB max output buffers for exec
// const MAX_EXEC_BUFFER = 64 * 1024 * 1024;

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
        default: "lint-diff.json",
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
  );
}

export type DiffResult<T> = {
  additions?: T[];
  deletions?: T[];
  changes?: T[];
};

async function runLintDiff(
  beforePath: string,
  afterPath: string,
  changedFilesPath: string,
  outFile: string,
) {
  const dependenciesDir = await getPathToDependency("@microsoft.azure/openapi-validator");

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

  // TODO: Structure legibly
  for (const { path, map } of [
    { path: beforePath, map: beforeMap },
    { path: afterPath, map: afterMap },
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
        // let lintDiffResult = await executeCommand(autorestCommand);
        // console.log("Lint diff result:", lintDiffResult.stdout);
      }
    }
  }

  console.log("Results would be written to: ", outFile);
}

// async function executeCommand(
//   command: string,
//   cwd: string = ".",
// ): Promise<{ error: Error | null; stdout: string; stderr: string }> {
//   return new Promise((resolve) => {
//     exec(
//       command,
//       { cwd, encoding: "utf-8", maxBuffer: MAX_EXEC_BUFFER },
//       (error, stdout, stderr) => {
//         resolve({ error, stdout, stderr });
//       },
//     );
//   });
// }

type State = {
  // Things needed to do the work
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
 * Build a map of changed readmes and tags to scan by examining state of the
 * repo before and after the change
 * @param before before the change
 * @param after after the change
 * @returns a map of readme files and tags to scan
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
