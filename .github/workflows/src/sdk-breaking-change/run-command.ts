import spawn from "cross-spawn";
import { createWriteStream } from "node:fs";
import { finished } from "node:stream/promises";

export type RunCommandOptions = {
  command: string;
  args: string[];
  logPath: string;
  outputPath: string;
  env?: NodeJS.ProcessEnv;
  throwOnFailure?: boolean;
};

export async function runCommand({
  command,
  args,
  logPath,
  outputPath,
  env,
  throwOnFailure = true,
}: RunCommandOptions): Promise<boolean> {
  const child = spawn(command, args, {
    env,
    stdio: ["ignore", "pipe", "pipe"],
  });
  const logStream = createWriteStream(logPath, { flags: "a" });
  const outputStream = createWriteStream(outputPath);
  const { stdout, stderr } = child;
  if (!stdout || !stderr) {
    throw new Error(`Failed to capture output from ${command}.`);
  }

  stdout.pipe(process.stdout);
  stdout.pipe(logStream, { end: false });
  stdout.pipe(outputStream);
  stderr.pipe(process.stderr);
  stderr.pipe(logStream, { end: false });

  let commandError: Error | undefined;
  try {
    await new Promise<void>((resolvePromise, reject) => {
      child.once("error", reject);
      child.once("close", (code, signal) => {
        if (code === 0) {
          resolvePromise();
          return;
        }
        reject(
          new Error(
            `${command} exited with ${signal ? `signal ${signal}` : `code ${String(code)}`}.`,
          ),
        );
      });
    });
  } catch (error) {
    commandError = error instanceof Error ? error : new Error(String(error));
  }

  logStream.end();
  await Promise.all([finished(outputStream), finished(logStream)]);
  if (commandError && throwOnFailure) {
    throw commandError;
  }
  return commandError === undefined;
}
