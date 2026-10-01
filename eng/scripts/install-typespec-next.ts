#!/usr/bin/env node

const childProcess: typeof import("node:child_process") = require("node:child_process");
const fs: typeof import("node:fs/promises") = require("node:fs/promises");
const path: typeof import("node:path") = require("node:path");

const rootDir: string = path.join(__dirname, "..", "..");
const lockfilePath: string = path.join(rootDir, "pnpm-lock.yaml");
const pnpmCommand: string = process.platform === "win32" ? "pnpm.cmd" : "pnpm";

function runPnpm(args: string[]): Promise<void> {
  return new Promise((resolve, reject) => {
    const child = childProcess.spawn(pnpmCommand, args, {
      cwd: rootDir,
      stdio: "inherit",
    });
    child.on("error", reject);
    child.on("close", (code) => {
      if (code === 0) {
        resolve();
      } else {
        reject(new Error(`pnpm ${args.join(" ")} failed with exit code ${code}.`));
      }
    });
  });
}

async function main(): Promise<void> {
  const committedLockfile: Buffer = await fs.readFile(lockfilePath);
  try {
    await fs.rm(lockfilePath);
    await runPnpm(["install", "--lockfile-only", "--no-frozen-lockfile"]);
    await runPnpm(["ci", "--prefer-offline"]);
  } finally {
    await fs.writeFile(lockfilePath, committedLockfile);
  }
}

main().catch((error: unknown) => {
  console.error(error instanceof Error ? error.message : error);
  process.exitCode = 1;
});
