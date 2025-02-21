import { spawn, spawnSync, exec } from "node:child_process";
import path from "node:path";
import fs from "node:fs";
import { LogLevel, logMessage } from "./log.js";
import { promisify } from "node:util";

type Dirent = fs.Dirent;

export const execAsync = promisify(exec);

/**
 * Reset unstaged changes in a git repository
 * @param repoPath The path to the git repository
 * @returns A promise that resolves when the reset is complete
 */
export async function resetGitRepo(repoPath: string): Promise<void> {
  try {
    const { stderr } = await execAsync("git reset --hard HEAD", {
      cwd: repoPath,
    });
    if (stderr) {
      logMessage(`Warning during git reset: ${stderr}`, LogLevel.Warn);
    }
    logMessage(`Successfully reset git repo at ${repoPath}`, LogLevel.Info);
  } catch (error) {
    throw new Error(`Failed to reset git repo at ${repoPath}: ${error}`);
  }
}

/*
 * Common function to find files recursively with case-insensitive matching
 */
export function findFilesRecursive(directory: string, fileName: string): string[] {
  let results: string[] = [];
  const list: Dirent[] = fs.readdirSync(directory, { withFileTypes: true });

  for (const dirent of list) {
    const filePath = path.join(directory, dirent.name);
    if (dirent.isDirectory()) {
      results = [...results, ...findFilesRecursive(filePath, fileName)];
    } else if (dirent.isFile() && dirent.name.toLowerCase() === fileName.toLowerCase()) {
      results.push(getRelativePathFromSpecification(filePath));
    }
  }

  return results;
}

export function findReadmeFiles(directory: string): string[] {
  return findFilesRecursive(directory, "readme.md");
}

export function getArgumentValue(args: string[], flag: string, defaultValue: string): string {
  const index = args.indexOf(flag);
  return index !== -1 && args[index + 1] ? args[index + 1] : defaultValue;
}

/*
 * Get the relative path from the specification folder
 */
export function getRelativePathFromSpecification(absolutePath: string): string {
  const specificationIndex = absolutePath.indexOf("specification/");
  if (specificationIndex !== -1) {
    return absolutePath.slice(Math.max(0, specificationIndex));
  }
  return absolutePath;
}

/*
 * Run the spec-gen-sdk command
 */
export async function runSpecGenSdkCommand(specGenSdkCommand: string[]): Promise<void> {
  return new Promise((resolve, reject) => {
    const childProcess = spawn("npx", specGenSdkCommand, {
      shell: false,
      stdio: "inherit",
      env: process.env,
    });
    childProcess.on("error", (error) => {
      reject(new Error(`Failed to start process: ${error.message}`));
    });
    childProcess.on("exit", (code) => {
      if (code === 0) {
        resolve();
      } else {
        reject(new Error(`Process exited with code ${code}`));
      }
    });
  });
}

/*
 * Get the list of all type spec project folder paths
 */
export function getAllTypeSpecPaths(specRepoPath: string): string[] {
  const scriptPath = path.resolve(specRepoPath, "eng/scripts/Get-TypeSpec-Folders.ps1");
  const args = [
    "-NoProfile",
    "-ExecutionPolicy",
    "Bypass",
    "-File",
    scriptPath,
    "-CheckAll",
    "$true",
  ];
  const output = runPowerShellScript(args);
  if (!output) {
    logMessage("Error getting type spec paths", LogLevel.Error);
    return [];
  }
  try {
    const specConfigPaths = output.split("\n").map((line) => path.join(line, "tspconfig.yaml"));
    //remove the last element which is 'true' or 'false'
    specConfigPaths.pop();
    return specConfigPaths;
  } catch (error) {
    logMessage(`Error parsing PowerShell output:${error}`, LogLevel.Error);
    return [];
  }
}

/*
 * Run the PowerShell script
 */
export function runPowerShellScript(args: string[]): string | undefined {
  const result = spawnSync("/usr/bin/pwsh", args, { encoding: "utf8" });
  if (result.error) {
    logMessage(`Error executing PowerShell script:${result.error}`, LogLevel.Error);
    return undefined;
  }
  if (result.stderr) {
    logMessage(`PowerShell script error output:${result.stderr}`, LogLevel.Error);
  }
  return result.stdout?.trim();
}

// Function to call Get-ChangedFiles from PowerShell script
export function getChangedFiles(
  specRepoPath: string,
  baseCommitish: string = "HEAD^",
  targetCommitish: string = "HEAD",
  diffFilter: string = "d",
): string[] | undefined {
  const scriptPath = path.resolve(specRepoPath, "eng/scripts/ChangedFiles-Functions.ps1");
  const args = [
    "-Command",
    `& { . '${scriptPath}'; Get-ChangedFiles '${baseCommitish}' '${targetCommitish}' '${diffFilter}' }`,
  ];

  const output = runPowerShellScript(args);
  if (output) {
    return output
      .split("\n")
      .map((line) => line.trim())
      .filter((line) => line.length > 0);
  }
  return undefined;
}

/*
 * The options for searching related folders
 */
export type FsSearchOptions = {
  searchFileRegex: RegExp;
  treeId: string;
  specFolder: string;
};

export type ListTree = {
  mode: string;
  type: string;
  object: string;
  file: string;
}[];

/**
 * Search for the related folder of a file
 * @param filePath The file path to search
 * @param options The search options
 * @returns The related folder of the file
 */
export const searchRelatedFolder = (filePath: string, options: FsSearchOptions) => {
  let searchPath = filePath;

  while (searchPath !== "." && searchPath !== path.dirname(searchPath)) {
    const fileName = path.basename(searchPath);
    if (options.searchFileRegex.test(fileName)) {
      return searchPath;
    }
    searchPath = path.dirname(searchPath);
  }

  return undefined;
};

/**
 * Search for the shared library folder from peer's folder
 */
export const searchSharedLibrary = (fileList: string[], options: FsSearchOptions) => {
  const result: { [relatedFolder: string]: string[] } = {};
  fileList.sort();
  let lastFolder: string | undefined = undefined;

  for (const filePath of fileList) {
    if (lastFolder !== undefined && filePath.startsWith(lastFolder)) {
      result[lastFolder].push(filePath);
    }
    const relatedFolder = searchRelatedFolder(filePath, options);
    if (relatedFolder === undefined) {
      continue;
    }
    if (result[relatedFolder] === undefined) {
      result[relatedFolder] = [];
    }
    result[relatedFolder].push(filePath);
    lastFolder = relatedFolder;
  }

  return result;
};

/*
 * Search for the related type spec projects from a shared library
 */
export const searchRelatedTypeSpecProjectBySharedLibrary = async (
  sharedLibraries: { [relatedFolder: string]: string[] },
  options: FsSearchOptions,
) => {
  const result: { [relatedFolder: string]: string[] } = {};
  for (const sharedLibrary of Object.keys(sharedLibraries)) {
    const parentFolder = path.dirname(sharedLibrary);
    const fileNames = await getFilesInFolder(parentFolder, options);
    for (const fileName of fileNames) {
      const filePath = path.join(parentFolder, fileName);
      const subFileNames = await getFilesInFolder(filePath, options);
      for (const subFileName of subFileNames) {
        if (options.searchFileRegex.test(subFileName)) {
          if (!result[filePath]) {
            result[filePath] = [];
          }
          result[filePath] = [...result[filePath], ...sharedLibraries[sharedLibrary]];
        }
      }
    }
  }
  return result;
};

/**
 * Search from the parent folders for a list of files
 */
export const searchRelatedParentFolders = async (fileList: string[], options: FsSearchOptions) => {
  const result: { [relatedFolder: string]: string[] } = {};
  fileList.sort();

  for (const filePath of fileList) {
    const relatedParentFolder = await searchRelatedParentFolder(filePath, options);
    if (relatedParentFolder === undefined) {
      continue;
    }
    if (result[relatedParentFolder] === undefined) {
      result[relatedParentFolder] = [];
    }
    result[relatedParentFolder].push(filePath);
  }

  return result;
};

/*
 * Search from a nearest parent folder for the specific file pattern
 */
export const searchRelatedParentFolder = async (filePath: string, options: FsSearchOptions) => {
  let searchPath = filePath;

  while (searchPath !== ".") {
    const fileNames = await getFilesInFolder(searchPath, options);
    for (const fileName of fileNames) {
      if (options.searchFileRegex.test(fileName)) {
        return searchPath;
      }
    }
    searchPath = path.dirname(searchPath);
  }

  return undefined;
};

/*
 * Get the files in a folder
 */
const getFilesInFolder = async (
  searchPath: string,
  options: FsSearchOptions,
): Promise<string[]> => {
  const workingFolder = ".";
  const workPath = path.resolve(process.cwd(), workingFolder, options.specFolder, searchPath);
  // Execute the git command using exec
  const { stdout, stderr } = await execAsync(`git ls-tree ${options.treeId} ${workPath}`);
  if (stderr) {
    throw new Error(`Error executing git ls-tree ${options.treeId} ${workPath}: ${stderr}`);
  }
  const subTree = gitTreeResultToStringArray(stdout);
  if (subTree.length === 0 || (subTree.length > 0 && subTree[0].type !== "tree")) {
    return [];
  }
  const entryPath = path.join(workPath, "/");
  const { stdout: treeEntry, stderr: treeEntryError } = await execAsync(
    `git ls-tree ${options.treeId} ${entryPath}`,
  );
  if (treeEntryError) {
    throw new Error(
      `Error executing git ls-tree ${options.treeId} ${entryPath}: ${treeEntryError}`,
    );
  }
  const subTreeEntry = gitTreeResultToStringArray(treeEntry);
  return subTreeEntry.map((item) => item.file.slice(searchPath.length + 1));
};

/*
 * Convert the git tree result to a string array
 */
export function gitTreeResultToStringArray(treeResult: string): ListTree {
  if (treeResult === "") {
    return [];
  }
  const lines = treeResult.trim().split("\n");
  const resultArray = lines.map((line) => {
    const [mode, type, object, file] = line.split(/\s+/);
    return {
      mode,
      type,
      object,
      file,
    };
  });

  return resultArray;
}
