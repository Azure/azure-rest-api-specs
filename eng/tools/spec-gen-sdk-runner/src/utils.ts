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
    const { stderr } = await execAsync("git clean -fdx && git reset --hard HEAD", {
      cwd: repoPath,
    });
    if (stderr) {
      logMessage(`Warning during git reset: ${stderr}`, LogLevel.Warn);
    } else {
      logMessage(`Successfully reset git repo at ${repoPath}`, LogLevel.Info);
    }
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
  const specificationIndex = absolutePath.indexOf(path.normalize("specification/"));
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

/**
 * Searches upward from a starting path to find the nearest parent directory containing a file matching the given pattern
 * @param startPath - The directory path to start searching from
 * @param searchFile - Regular expression pattern to match the target file name
 * @param specRepoFolder - The root folder of the repository
 * @param stopAtFolder - Optional boundary directory where the search should stop
 * @returns The path of the directory containing the matching file, or undefined if not found
 */
export function findParentWithFile(
  startPath: string,
  searchFile: RegExp,
  specRepoFolder: string,
  stopAtFolder?: string,
): string | undefined {
  let currentPath = startPath;

  while (currentPath) {
    try {
      const absolutePath = path.resolve(specRepoFolder, currentPath);
      const files = fs.readdirSync(absolutePath);
      if (files.some((file) => searchFile.test(file.toLowerCase()))) {
        return currentPath;
      }
    } catch (error) {
      logMessage(`Error reading directory: ${currentPath} with ${error}`, LogLevel.Warn);
      return undefined;
    }
    currentPath = path.dirname(currentPath);
    if (stopAtFolder && currentPath === stopAtFolder) {
      return undefined;
    }
  }
  return undefined;
}

/**
 * Searches for parent directories containing specific files for a list of files
 * Optimizes the search by grouping files in the same directory to avoid redundant searches
 * @param files - Array of file paths to process
 * @param options - Search configuration options
 * @returns Object mapping parent directory paths to arrays of related files
 */
export function searchRelatedParentFolders(
  files: string[],
  options: { searchFileRegex: RegExp; specRepoFolder: string; stopAtFolder?: string },
): { [folderPath: string]: string[] } {
  const result: { [folderPath: string]: string[] } = {};

  // Group files by their directory path to avoid redundant searches
  // Example: for files ["dir1/a.ts", "dir1/b.ts", "dir2/c.ts"]
  // Creates: { "dir1": ["dir1/a.ts", "dir1/b.ts"], "dir2": ["dir2/c.ts"] }
  // eslint-disable-next-line unicorn/no-array-reduce
  const filesByDir = files.reduce<{ [dir: string]: string[] }>((acc, file) => {
    const dir = path.dirname(file);
    if (!acc[dir]) {
      acc[dir] = [];
    }
    acc[dir].push(file);
    return acc;
  }, {});

  // Search parent folder only once per unique directory
  for (const [dir, dirFiles] of Object.entries(filesByDir)) {
    const parentFolder = findParentWithFile(
      dir,
      options.searchFileRegex,
      options.specRepoFolder,
      options.stopAtFolder,
    );
    if (parentFolder) {
      if (!result[parentFolder]) {
        result[parentFolder] = [];
      }
      result[parentFolder].push(...dirFiles);
    }
  }

  return result;
}

/**
 * Identifies files that are part of a shared library based on their directory names
 * @param files - Array of file paths to check
 * @param options - Search configuration options
 * @returns Array of files that belong to shared libraries
 */
export function searchSharedLibrary(
  files: string[],
  options: { searchFileRegex: RegExp; specRepoFolder: string },
): string[] {
  return files.filter((file) => {
    const dirname = path.dirname(file);
    return options.searchFileRegex.test(dirname);
  });
}

/**
 * Finds peer TypeSpec projects for shared libraries and maps them to their source libraries
 * Assumes all shared libraries are from the same parent folder
 * @param sharedLibraries - Array of shared library file paths (all from same parent)
 * @param options - Search configuration options
 * @returns Object mapping project directory paths to arrays of related shared library files
 */
export function searchRelatedTypeSpecProjectBySharedLibrary(
  sharedLibraries: string[],
  options: { searchFileRegex: RegExp; specRepoFolder: string },
): { [folderPath: string]: string[] } {
  if (sharedLibraries.length === 0) {
    return {};
  }

  const result: { [folderPath: string]: string[] } = {};
  const managementSuffix = ".Management";

  // Get parent directory from first library (all libraries share same parent)
  const parentDir = path.dirname(path.dirname(sharedLibraries[0]));
  const sourceLibDir = path.dirname(sharedLibraries[0]);

  try {
    const absoluteParentPath = path.resolve(options.specRepoFolder, parentDir);
    const peerDirs = fs.readdirSync(absoluteParentPath, { withFileTypes: true });

    // Find all peer directories containing TypeSpec projects
    for (const peerDir of peerDirs) {
      if (
        !peerDir.isDirectory() ||
        peerDir.name.endsWith(managementSuffix) ||
        path.join(parentDir, peerDir.name) === sourceLibDir
      ) {
        continue;
      }

      const peerPath = path.join(parentDir, peerDir.name);
      try {
        const peerFiles = fs.readdirSync(path.resolve(options.specRepoFolder, peerPath));
        if (peerFiles.some((file) => options.searchFileRegex.test(file.toLowerCase()))) {
          result[peerPath] = sharedLibraries;
        }
      } catch {
        logMessage(`Error reading directory: ${peerPath}`, LogLevel.Warn);
      }
    }
  } catch {
    logMessage(`Error reading directory: ${parentDir}`, LogLevel.Warn);
  }

  return result;
}

export function extractServiceName(path: string): string {
  const match = /specification\/([^/]*)\//.exec(path);
  return match ? match[1] : "";
}

export type ServiceFolderInfo = {
  resourceManagerPaths: { path: string; subPath?: string }[];
  dataPlanePaths: { path: string; subFolder?: string }[];
  managementPaths: string[];
  otherTypeSpecPaths: string[];
};

export function groupPathsByService(
  readmeMDResult: { [folderPath: string]: string[] },
  typespecProjectResult: { [folderPath: string]: string[] },
): Map<string, ServiceFolderInfo> {
  const serviceMap = new Map<string, ServiceFolderInfo>();

  // Process readme paths
  for (const folderPath of Object.keys(readmeMDResult)) {
    const serviceName = extractServiceName(folderPath);
    if (!serviceName) continue;

    if (!serviceMap.has(serviceName)) {
      serviceMap.set(serviceName, {
        resourceManagerPaths: [],
        dataPlanePaths: [],
        managementPaths: [],
        otherTypeSpecPaths: [],
      });
    }

    const info = serviceMap.get(serviceName)!;
    if (folderPath.includes("resource-manager")) {
      const subPathMatch = /resource-manager\/([^/]+)/.exec(folderPath);
      info.resourceManagerPaths.push({
        path: folderPath,
        subPath: subPathMatch ? subPathMatch[1] : undefined,
      });
    } else if (folderPath.includes("data-plane")) {
      const subFolderMatch = /data-plane\/([^/]+)/.exec(folderPath);
      info.dataPlanePaths.push({
        path: folderPath,
        subFolder: subFolderMatch ? subFolderMatch[1] : undefined,
      });
    }
  }

  // Process typespec paths
  for (const folderPath of Object.keys(typespecProjectResult)) {
    const serviceName = extractServiceName(folderPath);
    if (!serviceName) continue;

    if (!serviceMap.has(serviceName)) {
      serviceMap.set(serviceName, {
        resourceManagerPaths: [],
        dataPlanePaths: [],
        managementPaths: [],
        otherTypeSpecPaths: [],
      });
    }

    const info = serviceMap.get(serviceName)!;
    if (folderPath.endsWith(".Management")) {
      info.managementPaths.push(folderPath);
    } else {
      info.otherTypeSpecPaths.push(folderPath);
    }
  }

  return serviceMap;
}

export function getLastPathSegment(pathString: string): string {
  if (pathString === "") {
    return "";
  }
  // Normalize path separators and handle both Windows and Unix paths
  const normalized = path.normalize(pathString);
  const segments = normalized.split(path.sep);
  return segments?.pop() ?? "";
}

export type SpecResults = {
  readmeMDResult: { [folderPath: string]: string[] };
  typespecProjectResult: { [folderPath: string]: string[] };
};

export type ChangedSpecs = {
  [K in "readmeMd" | "typespecProject"]?: string;
} & {
  specs: string[];
};

/**
 * Creates combined specs from readme and typespec paths
 * @param readmePath - Path to the readme file
 * @param typespecPaths - Array of typespec paths to combine with
 * @param results - Current state of readme and typespec results
 * @returns Array of specs with combined files
 */
export function createCombinedSpecs(
  readmePath: string,
  typespecPaths: string[],
  results: SpecResults,
): ChangedSpecs[] {
  return typespecPaths.map((tsPath) => ({
    specs: [
      ...(results.readmeMDResult[readmePath] || []),
      ...(results.typespecProjectResult[tsPath] || []),
    ],
    readmeMd: path.join(readmePath, "readme.md"),
    typespecProject: path.join(tsPath, "tspconfig.yaml"),
  }));
}
