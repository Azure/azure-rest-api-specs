import { execFile, execNpm, isExecError } from "@azure-tools/specs-shared/exec";
import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import debug from "debug";
import { access, readdir, readFile } from "fs/promises";
import defaultPath, { basename, dirname, join, type PlatformPath } from "path";
import { simpleGit } from "simple-git";
import { getSuppressions as getSuppressionsImpl, type Suppression } from "suppressions";
import { context } from "./index.ts";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

// Cache for resolved local binary paths (keyed by binary name)
const localBinCache = new Map<string, string>();

/**
 * Finds a local binary by walking up from a given directory to find node_modules/.bin/<name>.
 * Returns the absolute path to the binary file (symlink or shim JS file).
 * Results are cached by binary name and search directory to avoid redundant filesystem walks.
 */
async function findLocalBin(name: string, searchDir: string): Promise<string> {
  const cacheKey = `${name}:${searchDir}`;
  const cached = localBinCache.get(cacheKey);
  if (cached !== undefined) return cached;

  let dir = searchDir;
  while (true) {
    const candidate = join(dir, "node_modules", ".bin", name);
    try {
      await access(candidate);
      localBinCache.set(cacheKey, candidate);
      return candidate;
    } catch {
      // Not found at this level, walk up
    }
    const parent = dirname(dir);
    if (parent === dir) {
      throw new Error(`Could not find binary '${name}' in any node_modules/.bin directory`);
    }
    dir = parent;
  }
}

/**
 * Runs a local binary from node_modules/.bin directly via node, bypassing npm exec overhead.
 */
export async function runBin(
  name: string,
  args: string[],
  cwd?: string,
): Promise<[Error | null, string, string]> {
  const searchDir = cwd ?? process.cwd();
  const binPath = await findLocalBin(name, searchDir);

  try {
    const { stdout, stderr } = await execFile(process.execPath, [binPath, ...args], {
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
  try {
    // Check if file is visible to process.  Uses case-insensitive match on Windows.
    await access(file);

    // Verify exact case match to avoid false positives on case-insensitive file systems (Windows)
    const dir = dirname(file);
    const base = basename(file);
    const entries = await readdir(dir);
    return entries.includes(base);
  } catch {
    return false;
  }
}

export async function readTspConfig(folder: string) {
  return readFile(join(folder, "tspconfig.yaml"), "utf-8");
}

export async function getSuppressions(path: string): Promise<Suppression[]> {
  return getSuppressionsImpl("TypeSpecValidation", path, context);
}

export function normalizePath(folder: string, path: PlatformPath = defaultPath) {
  return normalizePathImpl(folder, path);
}

export function normalizePathImpl(folder: string, path: PlatformPath = defaultPath) {
  return path
    .resolve(folder)
    .split(path.sep)
    .join("/")
    .replace(/^([a-z]):/, (_match, driveLetter: string) => driveLetter.toUpperCase() + ":");
}

export async function gitDiffTopSpecFolder(folder: string) {
  const git = simpleGit(folder);
  const topSpecFolder = folder.replace(/(^.*specification\/[^/]*)(.*)/, "$1");
  const stdOutput = `Running git diff on folder ${topSpecFolder}`;
  const gitStatus = await git.status(["--porcelain", topSpecFolder]);

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
