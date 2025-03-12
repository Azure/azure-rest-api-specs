import { access, constants, readFile, readdir } from "node:fs/promises";
import { dirname, join, sep, basename } from "node:path";
import { fileURLToPath } from "node:url";

// Temporary workaround until there's a common set of entities
import { getInputFiles, MarkdownType, getRelatedArmRpcFromDoc } from "./markdown-utils.js";
import { ExecException } from "node:child_process";

import $RefParser from "@apidevtools/json-schema-ref-parser";

/**
 * Enumerate files in a directory that match the given string ending
 * @param dir Directory to search
 * @param endsWith String to match at the end of the file
 */
// async function listFiles(dir: string, endsWith: string): Promise<string[]> {
//   const files = await readdir(dir, { recursive: true });
//   return files.filter((file) => file.endsWith(endsWith));
// }

/**
 * Check if a path exists
 * @param path Path to check for existence
 * @returns true if the path exists, false otherwise
 */
export async function pathExists(path: string): Promise<boolean> {
  try {
    await access(path);
    return true;
  } catch {
    return false;
  }
}

/**
 * Given the path to a file return an array of strings where each entry in the
 * array is a line in the file
 *
 * @param changedFilesPath Path to the file containing the list of changed files with one on each line
 * @returns
 */
export async function readFileList(changedFilesPath: string): Promise<string[]> {
  const data = await readFile(changedFilesPath, { encoding: "utf-8" });
  return data
    .split("\n")
    .map((line) => line.trim())
    .filter((line) => line.length > 0);
}

/**
 * Given a root path and directory, find all files whose name ends with a given
 * string. (e.g. ".json")
 * @param rootPath Root path of starting directory
 * @param dir Starting directory
 * @param endsWith a file extension to search for
 * @returns A list of files with paths relative to rootPath
 */
async function enumerateFiles(rootPath: string, dir: string, endsWith: string): Promise<string[]> {
  let results: string[] = [];
  let stack: string[] = [dir];

  while (stack.length > 0) {
    const currentDir = stack.pop()!;
    const list = await readdir(join(rootPath, currentDir), { withFileTypes: true });

    for (const file of list) {
      if (file.isDirectory()) {
        stack.push(join(currentDir, file.name));
      } else {
        if (file.name.endsWith(endsWith)) {
          results.push(join(currentDir, file.name));
        }
      }
    }
  }

  return results;
}

/**
 * Returns the service of a file path of the form "specification/<service>"
 * @param filePath Path to a file of the form "specification/<service>/.../file.json"
 * @returns Service path of the form "specification/<service>"
 */
export async function getService(filePath: string): Promise<string> {
  const splitPath = filePath.split(sep);
  if (splitPath.length >= 2) {
    // TODO: Verify result is a directory or remove async
    return splitPath.slice(0, 2).join(sep);
  }
  return "";
}

// Copied from azure-sdk-tools repo
// TODO: This should probably be moved to another more general location
export async function getPathToDependency(dependency: string): Promise<string> {
  // Example: /home/user/foo/node_modules/@autorest/bar/dist/index.js
  const entrypoint = fileURLToPath(import.meta.resolve(dependency));

  // Walk up directory tree to first folder containing "package.json"
  let currentDir = dirname(entrypoint);
  while (true) {
    const packageJsonFile = join(currentDir, "package.json");
    try {
      // Throws if file cannot be read
      await access(packageJsonFile, constants.R_OK);
      return currentDir;
    } catch {
      const parentDir = dirname(currentDir);
      if (parentDir !== currentDir) {
        currentDir = parentDir;
      } else {
        // Reached fs root but no package.json found
        throw new Error(`Unable to find package.json in folder tree above '${entrypoint}'`);
      }
    }
  }
}

/**
 * Get the list of readme files that are affected by the changed files by
 * searching for readme files in each higher directory up to the "specification/"
 * directory.
 *
 * @param changedFiles List of changed files.
 */
export async function getAffectedReadmes(
  changedFiles: string[],
  repoRoot: string,
): Promise<string[]> {
  const changedFilesInSpecDir = changedFiles.filter((file) =>
    file.startsWith(`specification${sep}`),
  );

  // TODO: Case sensitivity??
  const changedReadmeFiles = [];
  for (const file of changedFilesInSpecDir) {
    if (file.endsWith(`${sep}readme.md`) && (await pathExists(join(repoRoot, file)))) {
      changedReadmeFiles.push(file);
    }
  }

  // TODO: Case sensitivity??
  const changedSpecFiles = changedFilesInSpecDir.filter((f) =>
    [".md", ".json", ".yaml", ".yml"].some((p) => f.endsWith(p)),
  );

  const readmeFiles = new Set<string>(changedReadmeFiles);
  const visitedFolders = new Set<string>();

  // For each changed spec file, walk up the directory tree collecting readme
  // files until reaching the "specification/" directory (already filtered in
  // changedFilesInSpecDir)
  for (const specFile of changedSpecFiles) {
    let dir = dirname(specFile);
    // Exclude '.' as it is outside the specification folder for purposes of
    // this function (avoid including root readme.md file)
    while (!visitedFolders.has(dir) && dir !== "specification") {
      visitedFolders.add(dir);
      // TODO: Case sensitivity??
      const readmeFile = join(repoRoot, dir, "readme.md");
      if (await pathExists(readmeFile)) {
        readmeFiles.add(join(dir, "readme.md"));
      }
      dir = dirname(dir);
    }
  }

  return [...readmeFiles];
}

/**
 * Given a list of changed files return a set of services which the changed
 * files impact (assumes no references across services).
 * For example:
 *  - "specification/service1/file1.json", "specification/service1/file2.json" -> "specification/service1"
 *  - "specification/service1/file1.json", "specification/service2/file1.json" -> "specification/service1", "specification/service2"
 *
 * @param changedFiles a list of changed files
 * @returns A list of "services" that are affected by the changed files
 */
export async function getAffectedServices(changedFiles: string[]) {
  const affectedServices = new Set<string>();
  for (const file of changedFiles) {
    const service = await getService(file);
    if (service) {
      affectedServices.add(service);
    }
  }
  return affectedServices;
}

/**
 * Build a list of swagger dependencies for a given directory. Only list
 * dependencies that are in the same "directory".
 *
 * @param rootPath The root path of the repo
 * @param directory The directory (generally, service directory) to search
 * @returns A map of swagger files to the files upon which they depend
 */
export async function getSwaggerDependenciesMap(
  rootPath: string,
  directory: string,
): Promise<NonNullable<Map<string, Set<string>>>> {
  const swaggerFiles = await enumerateFiles(rootPath, directory, ".json");
  const swaggerDependencies = new Map<string, Set<string>>();
  const rootAndDirectoryPath = join(rootPath, directory);

  for (const file of swaggerFiles) {
    let parsedRefs = await $RefParser.resolve(join(rootPath, file), {
      resolve: { http: false },
    });
    // TODO: filter should exclude URLs
    const refs = parsedRefs
      .paths()
      .filter(
        (ref: string) =>
          ref.startsWith(rootAndDirectoryPath) && // Inside the target directory
          !ref.includes(`${sep}examples${sep}`), // Exclude examples
      )
      // TODO: +1 requires proper handling of trailing slashes
      .map((ref: string) => ref.substring(rootPath.length + 1)) // Relative to rootPath
      .filter((ref: string) => ref !== file); // Exclude self-reference

    swaggerDependencies.set(file, new Set(refs));
  }

  return swaggerDependencies;
}

/**
 * Given a list of changed files and a map of swagger dependencies, return a
 * list of affected swagger files that depend on the given set of changed files.
 * @param changedFiles
 * @param dependencies a map of swagger files to the files upon which those swaggers depend
 * @returns
 */
export function getAffectedSwaggers(
  changedFiles: string[],
  dependencies: Map<string, Set<string>>,
): string[] {
  const affectedSwaggers = new Set<string>(changedFiles);

  for (const changedFile of changedFiles) {
    for (const [file, deps] of dependencies.entries()) {
      if (affectedSwaggers.has(file)) {
        continue;
      }

      if (deps.has(changedFile)) {
        affectedSwaggers.add(file);
      }
    }
  }

  return [...affectedSwaggers];
}

/**
 * Given a list of tags and the content of a readme file, remove tags that are
 * subsets of other tags (reduces number of times autorest is called).
 *
 * @param tags
 * @param readmeContent
 * @returns
 */
export async function deduplicateTags(tags: string[], readmeContent: string) {
  type TagInputFile = { tagName: string; inputFiles: readonly string[] };
  const tagResults: TagInputFile[] = [];
  for (const tag of tags) {
    const inputFiles = (await getInputFiles(readmeContent, tag)) || [];
    if (inputFiles.length > 0) {
      tagResults.push({ tagName: tag, inputFiles });
    }
  }

  // TODO: This was ported straight across and can probably be done more cleanly
  const sortedTags = tagResults.sort((a, b) => a.inputFiles.length - b.inputFiles.length);
  return sortedTags
    .filter((tag, index) => {
      for (const restTag of sortedTags.slice(index + 1)) {
        if (tag.inputFiles.every((file) => restTag.inputFiles.includes(file))) {
          return false;
        }
      }
      return true;
    })
    .map((tag) => tag.tagName);
}

export type AutorestRunResult = {
  autorestCommand: string;
  rootPath: string;

  readme: string;
  tag: string;
  // TODO: Not sure if this is useful, may also require sub type
  openApiType: MarkdownType;

  // TODO: Is there a shorthand way to mix in the output of executeCommand?
  error: ExecException | null;
  stdout: string;
  stderr: string;
};

// TODO: Name
export type BeforeAfter = {
  // TODO: This is nullable
  before: AutorestRunResult | null;
  after: AutorestRunResult;
};

export function logAutorestExecutionErrors(runResult: AutorestRunResult) {
  const errorIsNotNull = runResult.error !== null;
  const autoRestPrefix = `{`;
  const stdoutContainsLevelError = runResult.stdout.includes(`${autoRestPrefix}"level":"error"`);
  const stdoutContainsLevelFatal = runResult.stdout.includes(`${autoRestPrefix}"level":"fatal"`);
  const stderrContainsLevelError = runResult.stderr.includes(`${autoRestPrefix}"level":"error"`);
  const stderrContainsLevelFatal = runResult.stderr.includes(`${autoRestPrefix}"level":"fatal"`);
  if (errorIsNotNull) {
    // TODO: Clean up output formatting to be consistent with new output standards
    console.log(
      `Execution of AutoRest with LintDiff done. ` +
        `Error is not null: ${errorIsNotNull}, ` +
        `stdout contains AutoRest 'error': ${stdoutContainsLevelError}, ` +
        `stdout contains AutoRest 'fatal': ${stdoutContainsLevelFatal}, ` +
        `stderr contains AutoRest 'error': ${stderrContainsLevelError}, ` +
        `stderr contains AutoRest 'fatal': ${stderrContainsLevelFatal}`,
    );
  } else {
    // TODO: Include markdown type?
    console.log(
      `::debug:: Execution completed with no errors for tag: ${runResult.tag}, markdown: ${runResult.readme}, rootPath: ${runResult.rootPath}`,
    );
  }
}

export type Source = {
  document: string;
  position: {
    line: number;
    colomn: number;
  };
};

export type LintingResultMessage = {
  level: string;
  code: string;
  message: string;
  source: Source[];
  validationCategory?: string;
  details: {
    jsonpath: (string | number)[];
    validationCategory?: string;
  };
};

export type LintDiffViolation = LintingResultMessage & {
  groupName?: string;
  filePath?: string;
  lineNumber?: number;
  armRpcs?: string[];
};

// Ensure that diagnostic information emitted by azure-openapi-validator
// to stdout is not interpreted as a diff occurrence.
// Assume that all messages emitted as "information" or "debug" or "verbose" are
// diagnostic output and hence can be excluded, and that all diagnostic output
// is emitted as "information" or "debug" or "verbose", so we don't have to
// exclude anything beyond these levels.
const diagnosticLevelStrings: string[] = [
  '"level":"information"',
  '"level":"debug"',
  '"level":"verbose"',
];

export function getLintDiffViolations(runResult: AutorestRunResult): LintDiffViolation[] {
  const violations: LintDiffViolation[] = [];

  for (const line of (runResult.stderr + runResult.stdout).split("\n")) {
    if (!line.includes('"extensionName":"@microsoft.azure/openapi-validator"')) {
      continue;
    }

    // Ignore all lines that are "diagnostic" output from autorest
    if (diagnosticLevelStrings.some((level) => line.includes(level))) {
      continue;
    }

    const result = JSON.parse(line.trim());
    if (result.code == undefined) {
      // Here we are assuming that lack of code denotes fatal error. For example [1].
      // We must set this to some value because if it would stay undefined, the downstream code would blow up in several places.
      result.code = "FATAL";
    }
    violations.push(result as LintDiffViolation);
  }

  return violations;
}

export interface AutoRestMessage {
  level: "information" | "warning" | "error" | "debug" | "verbose" | "fatal";
  code?: any;
  message: string;
  readme?: string;
  tag?: string;
  groupName?: string;
}

export function isFailure(level: string) {
  if (level === undefined) {
    return false;
  }

  return ["error", "fatal"].includes(level.toLowerCase());
}

export function isWarning(level: string) {
  if (level === undefined) {
    return false;
  }

  return level.toLowerCase() === "warning";
}

export function arrayIsEqual(a: any[], b: any[]) {
  if (a.length !== b.length) {
    return false;
  }
  for (let i = 0; i < a.length; i++) {
    if (a[i] !== b[i]) {
      return false;
    }
  }
  return true;
}

export async function getNewItems(
  before: LintDiffViolation[],
  after: LintDiffViolation[],
): Promise<[LintDiffViolation[], LintDiffViolation[]]> {
  const newItems = [];
  const existingItems = [];

  for (const afterViolation of after) {
    let errorIsNew = true;

    // Always treat fatal errors as new
    if (afterViolation.level.toLowerCase() === "fatal") {
      newItems.push(afterViolation);
      continue;
    }

    // Search through "before" to find a matching violation
    for (const beforeViolation of before) {
      if (
        beforeViolation.level == afterViolation.level &&
        beforeViolation.code == afterViolation.code &&
        beforeViolation.message == afterViolation.message &&
        beforeViolation.source?.length == afterViolation.source?.length &&
        // TODO: this is a direct copy, see if there is a better way
        basename(beforeViolation.source?.[0]?.document) ==
          basename(afterViolation.source?.[0]?.document) &&
        // TODO: details?
        arrayIsEqual(beforeViolation.details?.jsonpath, afterViolation.details?.jsonpath)
      ) {
        errorIsNew = false;
        existingItems.push(afterViolation);
        // Only need to find one match
        break;
      }
    }

    // If no match is found, add to new
    if (errorIsNew) {
      newItems.push(afterViolation);
    }
  }

  for (const newItem of newItems) {
    // TODO: Parallelize
    newItem.armRpcs = await getRelatedArmRpcFromDoc(newItem.code);
  }

  return [newItems, existingItems];
}

// export function getAutorestViolations(runResult: AutorestRunResult) {}
