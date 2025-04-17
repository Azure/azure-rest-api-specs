import { execNpm, isExecError } from "@azure-tools/specs-shared/exec";
import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import debug from "debug";
import { access, readFile } from "fs/promises";
import defaultPath, { join, PlatformPath } from "path";
import { simpleGit } from "simple-git";
import { getSuppressions as getSuppressionsImpl, Suppression } from "suppressions";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

// Wraps execNpm() to return error (and coalesce stdout and stderr) instead of throwing
export async function runNpm(
  args: string[],
  cwd?: string,
): Promise<[Error | null, string, string]> {
  try {
    const { stdout, stderr } = await execNpm(args, {
      logger: new ConsoleLogger(),
      maxBuffer: 64 * 1024 * 1024,
      cwd,
    });
    return [null, stdout, stderr];
  } catch (error) {
    if (isExecError(error)) {
      return [error, error.stdout ?? "", error.stderr ?? ""];
    } else {
      throw error;
    }
  }
}

export async function fileExists(file: string) {
  return access(file)
    .then(() => true)
    .catch(() => false);
}

export async function readTspConfig(folder: string) {
  return readFile(join(folder, "tspconfig.yaml"), "utf-8");
}

export async function getSuppressions(path: string): Promise<Suppression[]> {
  return getSuppressionsImpl("TypeSpecValidation", path);
}

export function normalizePath(folder: string, path: PlatformPath = defaultPath) {
  return normalizePathImpl(folder, path);
}

export function normalizePathImpl(folder: string, path: PlatformPath = defaultPath) {
  return path
    .resolve(folder)
    .split(path.sep)
    .join("/")
    .replace(/^([a-z]):/, (_match, driveLetter) => driveLetter.toUpperCase() + ":");
}

export async function gitDiffTopSpecFolder(folder: string) {
  const git = simpleGit(folder);
  let topSpecFolder = folder.replace(/(^.*specification\/[^\/]*)(.*)/, "$1");
  let stdOutput = `Running git diff on folder ${topSpecFolder}`;
  let gitStatus = await git.status(["--porcelain", topSpecFolder]);

  let success = true;
  let errorOutput: string | undefined;

  if (!gitStatus.isClean()) {
    success = false;
    errorOutput = JSON.stringify(await git.status());
    errorOutput += await git.diff();
  }

  return {
    success: success,
    stdOutput: stdOutput,
    errorOutput: errorOutput,
  };
}
