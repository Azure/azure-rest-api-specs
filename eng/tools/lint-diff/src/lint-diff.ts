import { readFile, readdir } from "fs/promises";
// import { exec } from "node:child_process";
import { parseArgs, ParseArgsConfig } from "node:util";
import { getOpenapiType, getAllTags, getInputFiles } from "./markdown-parser.js";
import { sep, dirname, join } from "path";
import { pathExists, getPathToDependency } from "./util.js";
import $RefParser from "@apidevtools/json-schema-ref-parser";

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
  // TODO: Should filter happen here or upstream? (probably upstream)
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

  for (const rootPath of [beforePath, afterPath]) {
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
      const changedServiceFiles = existingChangedFiles.filter((file) =>
        file.startsWith(serviceDir),
      );
      const serviceDependencyMap = await getSwaggerDependenciesMap(rootPath, serviceDir);

      affectedSwaggerMap.set(
        serviceDir,
        await getAffectedSwaggers(changedServiceFiles, serviceDependencyMap),
      );
    }

    // Use changedSpecFiles (which might not be present in the branch) to get
    // a set of affected readme files.
    // TODO: Is this even useful?
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

    const dependenciesDir = await getPathToDependency("@microsoft.azure/openapi-validator");
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

    if (changedFileAndTagsMap.size === 0) {
      console.log(`No readme or swagger files changed in ${rootPath}`);
      continue;
    }

    for (const [readme, tags] of changedFileAndTagsMap.entries()) {
      const changedFilePath = `${rootPath}/${readme}`;
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
        // TODO: See tag specified in momentOfTruth.ts:executeAutoRestWithLintDiff
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

        // if (lintDiffResult.error) {
        //   console.error("Error running autorest", lintDiffResult.error);
        //   process.exit(1);
        // }

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

async function readFileList(changedFilesPath: string): Promise<string[]> {
  const data = await readFile(changedFilesPath, { encoding: "utf-8" });
  return data
    .split("\n")
    .map((line) => line.trim())
    .filter((line) => line.length > 0);
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

export async function getSwaggerDependenciesMap(
  rootPath: string,
  directory: string,
): Promise<NonNullable<Map<string, Set<string>>>> {
  const swaggerFiles = await enumerateFiles(rootPath, directory, ".json");
  const swaggerDependencies = new Map<string, Set<string>>();
  const rootAndDirectoryPath = join(rootPath, directory);

  for (const file of swaggerFiles) {
    // TODO: Use a single parser?
    let parser = new $RefParser();
    await parser.resolve(join(rootPath, file), {
      resolve: { http: false },
    });
    // TODO: filter should exclude URLs
    const refs = parser.$refs
      .paths()
      .filter(
        (ref) =>
          ref.startsWith(rootAndDirectoryPath) && // Inside the target directory
          !ref.includes(`${sep}examples${sep}`), // Exclude examples
      )
      .map((ref) => ref.substring(rootPath.length + 1)) // Relative to rootPath
      .filter((ref) => ref !== file); // Exclude self-reference

    swaggerDependencies.set(file, new Set(refs));
  }

  return swaggerDependencies;
}

// TODO: Extract to common utils
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
 * Given a list of tags and the content of a readme file, find the input files
 * for that readme
 *
 * @param tags
 * @param readmeContent
 * @returns
 */
async function deduplicateTags(tags: string[], readmeContent: string) {
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
