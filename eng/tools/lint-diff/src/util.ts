import { access, constants, readFile } from "node:fs/promises";
import { dirname, join } from "path";
import { fileURLToPath } from "url";

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

// Ignorting test coverage for these utility functions that are specific to
// the engineering setup.
/* v8 ignore start */
export async function getDependencyVersion(dependenciesDir: string): Promise<string> {
  const packageJsonPath = join(dependenciesDir, "package.json");
  const packageJson = JSON.parse(await readFile(packageJsonPath, { encoding: "utf-8" }));
  const version = packageJson.version;
  if (!version) {
    throw new Error(`Version not found in package.json at ${packageJsonPath}`);
  }
  return version;
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
/* v8 ignore stop */

/**
 * Normalize a path to be relative to a given directory.
 * @param path File path with / separators (typically given in swagger $refs)
 * @param from A directory name to treat as the root (e.g. /specification/)
 */
export function relativizePath(path: string, from: string = `/specification/`): string {
  console.log(`Relativizing path: ${path}`);
  const indexOfBy = path.lastIndexOf(from);
  if (indexOfBy === -1) {
    return path;
  }

  return path.substring(indexOfBy);
}

export function isFailure(level: string) {
  return ["error", "fatal"].includes(level.toLowerCase());
}

export function isWarning(level: string) {
  return level.toLowerCase() === "warning";
}
