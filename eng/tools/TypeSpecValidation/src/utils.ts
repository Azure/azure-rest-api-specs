import { access } from "fs/promises";
import { exec } from "child_process";

export async function runCmd(cmd: string, cwd: string) {
  console.log(`run command:${cmd}`);
  const { err, stdout, stderr } = (await new Promise((res) =>
    exec(
      cmd,
      { encoding: "utf8", maxBuffer: 1024 * 1024 * 64, cwd: cwd },
      (err: unknown, stdout: unknown, stderr: unknown) =>
        res({ err: err, stdout: stdout, stderr: stderr })
    )
  )) as any;

  return [err, stdout, stderr];
}

export async function checkFileExists(file: string) {
  return access(file)
    .then(() => true)
    .catch(() => false);
}
