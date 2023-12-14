import { access } from "fs/promises";
import { exec } from "child_process";
import defaultPath, { PlatformPath } from "path";

export async function runCmd(cmd: string, cwd: string) {
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

export function normalizePath(folder: string, path: PlatformPath = defaultPath) {
  return path
    .resolve(folder)
    .split(path.sep)
    .join("/")
    .replace(/^([a-z]):/, (_match, driveLetter) => driveLetter.toUpperCase() + ":");
}
