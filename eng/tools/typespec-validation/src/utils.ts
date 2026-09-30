import { execNodeBin, isExecError } from "@azure-tools/specs-shared/exec";
import type { ILogger } from "@azure-tools/specs-shared/logger";
import {
  getSuppressions as getSuppressionsImpl,
  type Suppression,
} from "@azure-tools/suppressions";
import { access, readdir, readFile } from "fs/promises";
import defaultPath, { basename, dirname, join, relative, type PlatformPath } from "path";
import { simpleGit } from "simple-git";
import { context } from "./index.ts";
import { supportsColor } from "./diagnostics.ts";
import type { CommandOutput } from "./command-output.ts";

// Return command failures to the validation rule along with captured output.
export async function runNodeBin(
  packageName: string,
  args: [string, ...string[]],
  logger: ILogger,
  cwd?: string,
): Promise<CommandOutput> {
  const env = { ...process.env };
  if (supportsColor()) {
    delete env.NO_COLOR;
    env.FORCE_COLOR = "1";
  } else {
    delete env.FORCE_COLOR;
    env.NO_COLOR = "1";
  }
  logger.debug(`runNodeBin(${JSON.stringify(packageName)}, ${JSON.stringify(args)})`);
  try {
    const { stdout, stderr } = await execNodeBin(packageName, args, {
      // The calling rule owns captured output, including errors; do not log it twice.
      env,
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

export async function readFileAtCommit(
  folder: string,
  commitish: string,
  file: string,
): Promise<string | undefined> {
  const git = simpleGit(folder);
  await git.revparse(["--verify", `${commitish}^{commit}`]);
  const repositoryRoot = (await git.revparse(["--show-toplevel"])).trim();
  const repositoryPath = relative(repositoryRoot, file).split(defaultPath.sep).join("/");

  try {
    return await git.show([`${commitish}:${repositoryPath}`]);
  } catch {
    return undefined;
  }
}

export async function gitDiffTopSpecFolder(folder: string, logger: ILogger) {
  const git = simpleGit(folder);
  const topSpecFolder = folder.replace(/(^.*specification\/[^/]*)(.*)/, "$1");
  logger.debug(`Checking generated files in ${topSpecFolder}`);
  const gitStatus = await git.status(["--porcelain", topSpecFolder]);
  if (!gitStatus.isClean() && logger.isDebug()) {
    logger.debug(JSON.stringify(await git.status()));
    logger.debug(await git.diff());
  }

  return {
    success: gitStatus.isClean(),
    files: gitStatus.files.map((file) => file.path),
  };
}
