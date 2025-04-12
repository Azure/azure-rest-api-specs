import { execFile } from "child_process";
import { access, readFile } from "fs/promises";
import defaultPath, { join, PlatformPath } from "path";
import { TsvHost } from "./tsv-host.js";
import { getSuppressions as getSuppressionsImpl, Suppression } from "suppressions";

export async function filterAsync<T>(
  array: T[],
  asyncPredicate: (item: T, index: number, array: T[]) => Promise<boolean>,
): Promise<T[]> {
  const filterResults = await Promise.all(array.map(asyncPredicate));
  return array.filter((_, index) => filterResults[index]);
}

export async function runFile(file: string, args: string[], cwd?: string) {
  console.log(`run command:${file} ${args.join(' ')}`);
  const { err, stdout, stderr } = (await new Promise((res) =>
    // execFile(file, args) is more secure than exec(cmd), since the latter is vulnerable to shell injection
    execFile(
      file,
      args,
      { encoding: "utf8", maxBuffer: 1024 * 1024 * 64, cwd: cwd },
      (err: unknown, stdout: unknown, stderr: unknown) =>
        res({ err: err, stdout: stdout, stderr: stderr }),
    ),
  )) as any;

  return [err, stdout, stderr] as [Error | null, string, string];
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

export async function gitDiffTopSpecFolder(host: TsvHost, folder: string) {
  const git = host.gitOperation(folder);
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
