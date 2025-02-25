import { readFile } from "fs/promises";
import { exec } from "node:child_process";
import { parseArgs, ParseArgsConfig } from "node:util";
import { getOpenapiType, getAllTags, getInputFiles } from "./markdown-parser.js";
import { sep, dirname, join } from "path";
import { pathExists, getPathToDependency } from "./util.js";

// 64 MiB max ouptut buffers for exec
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

  if (!beforeArg || !(await pathExists(beforeArg as string))) {
    validArgs = false;
    console.log(`--before must be a valid path. Value passed: ${beforeArg || "<empty>"}`);
  }

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
  // TODO: NEED TO PARSE TAG CHANGES STILL
  // Basic filtering until tag parsing is brought over

  // const ignoreFilesWith = ["/examples/", "/quickstart-templates/", "/scenarios/"];
  const changedFiles = await readFileList(changedFilesPath);
  // TODO: might not be necessary
  // const changedReadMeFiles = changedFiles.filter(
  //   async (file) =>
  //     file.startsWith("specification") &&
  //     file.endsWith(`${sep}readme.md`) &&
  //     !ignoreFilesWith.some((ignore) => file.includes(ignore)) &&
  //     (await pathExists(path.join(targetPath, file))),
  // );

  // TODO: Where to establish full path? (Probably sooner)

  console.log(beforePath, afterPath);
  const affectedReadmes = await getAffectedReadmeFiles(changedFiles, afterPath);
  const affectedTags = await getAffectedTags(affectedReadmes, afterPath);

  console.log(`Affected tags:\n${JSON.stringify(affectedTags)}`);
  // console.log(`Changed files:\n${changedReadMeFiles.join("\n")}`);

  // if (changedReadMeFiles.length === 0) {
  //   console.log("No readme files changed, exiting");
  //   return;
  // }

  const dependenciesDir = await getPathToDependency("@microsoft.azure/openapi-validator");
  const changedFileAndTagsMap = new Map<string, string[]>();
  for (const readmeAndTags of affectedTags) {
    const dedupedTags = await deduplicateTags(
      readmeAndTags.tags,
      await readFile(join(afterPath, readmeAndTags.readme), { encoding: "utf-8" }),
    );

    changedFileAndTagsMap.set(readmeAndTags.readme, dedupedTags);
  }

  // TODO:
  for (const file of changedFileAndTagsMap.keys()) {
    const changedFilePath = `${afterPath}/${file}`;
    console.log(`Linting ${changedFilePath}`);

    let openApiType = await getOpenapiType(changedFilePath);

    // From momentOfTruth.ts:executeAutoRestWithLintDiff
    // This is a quick workaround for https://github.com/Azure/azure-sdk-tools/issues/6549
    // We override the openapi-subtype with the value of openapi-type,
    // to prevent LintDiff from reading openapi-subtype from the AutoRest config file (README)
    // and overriding openapi-type with it.
    let openApiSubType = openApiType;

    // TODO: Is there a more syntactically graceful way to handle empty tags?
    for (const tag of changedFileAndTagsMap.get(file) || [null]) {
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
      let lintDiffResult = await executeCommand(autorestCommand);

      if (lintDiffResult.error) {
        console.error("Error running autorest", lintDiffResult.error);
        process.exit(1);
      }

      // console.log("Lint diff result:", lintDiffResult.stdout);
      console.log("Results would be written to: ", outFile);
    }
  }
}

async function executeCommand(
  command: string,
  cwd: string = ".",
): Promise<{ error: Error | null; stdout: string; stderr: string }> {
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
 * Mostly stands in for getReadmeDiffs in momentOfTruth.ts
 *
 * TODO: TESTS
 * @param changedFiles List of changed files.
 */
async function getAffectedReadmeFiles(changedFiles: string[], repoRoot: string): Promise<string[]> {
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
    while (!visitedFolders.has(dir)) {
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

type ReadmeAndTags = {
  readme: string;
  tags: string[];
};

async function getAffectedTags(
  affectedReadmes: string[],
  rootPath: string,
): Promise<ReadmeAndTags[]> {
  let affectedTags: ReadmeAndTags[] = [];

  for (const readmePath of affectedReadmes) {
    console.log(`Reading ${readmePath}`);
    let content = await readFile(join(rootPath, readmePath), { encoding: "utf-8" });
    // TODO: Refactor?
    let readmeTags = getAllTags(content);
    affectedTags = affectedTags.concat({ readme: readmePath, tags: readmeTags });
  }

  return affectedTags;
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
