import { execFile, execNpm, isExecError } from "@azure-tools/specs-shared/exec";
import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import debug from "debug";
import { access, readdir, readFile, realpath } from "fs/promises";
import defaultPath, { basename, dirname, join, resolve, type PlatformPath } from "path";
import { simpleGit } from "simple-git";
import { getSuppressions as getSuppressionsImpl, type Suppression } from "suppressions";
import { context } from "./index.ts";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

// Cache for resolved local binary paths (keyed by binary name)
const localBinCache = new Map<string, string>();

/**
 * Resolves a .bin shim to the actual JavaScript entry point file so it can be executed
 * directly with `node` (process.execPath).
 *
 * On Unix/Linux/Mac, .bin entries are symlinks to the actual .js file; realpath() resolves them.
 * On Windows, .bin entries are POSIX shell scripts (not executable by node.exe directly).
 * In that case the .cmd shim is parsed to extract the embedded JS path.
 */
async function resolveActualBinScript(shimPath: string): Promise<string> {
  // Try symlink resolution (Unix: .bin/<name> is a symlink -> actual .js file)
  try {
    const real = await realpath(shimPath);
    if (/\.(js|cjs|mjs)$/.test(real)) {
      return real;
    }
  } catch {
    // Not a resolvable symlink
  }

  // Windows fallback: parse the .cmd shim which contains the actual JS path.
  // npm/pnpm generate lines like:
  //   "%_prog%"  "%dp0%\..\@typespec\compiler\cmd\tsp.js" %*
  const cmdPath = shimPath + ".cmd";
  try {
    const content = await readFile(cmdPath, "utf-8");
    const match = content.match(/"%dp0%\\([^"]+\.(?:js|cjs|mjs))"/i);
    if (match) {
      // match[1] is relative to the .bin directory (e.g. "..\@typespec\compiler\cmd\tsp.js")
      return resolve(join(dirname(shimPath), match[1]));
    }
  } catch {
    // .cmd file not found or unreadable
  }

  throw new Error(
    `Could not resolve JavaScript entry point for binary shim: ${shimPath}. ` +
      `The shim is not a symlink to a .js file and no .cmd file was found.`,
  );
}

/**
 * Finds a local binary by walking up from a given directory to find node_modules/.bin/<name>,
 * then resolves the shim to the actual JavaScript entry point.
 * Results are cached by binary name and search directory to avoid redundant filesystem walks.
 */
async function findLocalBin(name: string, searchDir: string): Promise<string> {
  const cacheKey = `${name}:${searchDir}`;
  const cached = localBinCache.get(cacheKey);
  if (cached !== undefined) return cached;

  let dir = searchDir;
  while (true) {
    const shimPath = join(dir, "node_modules", ".bin", name);
    let shimFound = false;
    try {
      await access(shimPath);
      shimFound = true;
    } catch {
      // Not found at this level, walk up
    }

    if (shimFound) {
      const actualPath = await resolveActualBinScript(shimPath);
      localBinCache.set(cacheKey, actualPath);
      return actualPath;
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
