import { access, stat } from "fs/promises";
import { exec } from "child_process";
import defaultPath, { PlatformPath } from "path";
import { TsvHost } from "./tsv-host.js";

export async function runCmd(cmd: string, cwd?: string) {
  console.log(`run command:${cmd}`);
  const { err, stdout, stderr } = (await new Promise((res) =>
    exec(
      cmd,
      { encoding: "utf8", maxBuffer: 1024 * 1024 * 64, cwd: cwd },
      (err: unknown, stdout: unknown, stderr: unknown) =>
        res({ err: err, stdout: stdout, stderr: stderr }),
    ),
  )) as any;

  return [err, stdout, stderr] as [Error | null, string, string];
}

export async function checkFileExists(file: string) {
  return access(file)
    .then(() => true)
    .catch(() => false);
}

export async function isDirectory(path: string) {
  return (await stat(path)).isDirectory();
}

export function normalizePath(folder: string, path: PlatformPath = defaultPath) {
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
