#!/usr/bin/env node
// Bootstrap helper: installs the pnpm version pinned in the root package.json
// `packageManager` field, so a fresh clone (with only Node + npm) can get pnpm before
// pnpm's own self-versioning is able to take over (that only works once pnpm exists).
//
// Run with `npx install-pnpm` (resolves the root package's own bin) or directly with
// `node eng/scripts/install-pnpm.mts`. Node >=24 strips the TypeScript types natively,
// so there is no build step. Keep this file to erasable-only TypeScript syntax and zero
// runtime dependencies.

import { spawn } from "node:child_process";
import { readFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const rootDir: string = join(
  dirname(fileURLToPath(import.meta.url)),
  "..",
  "..",
);
const onWindows: boolean = process.platform === "win32";

function run(
  command: string,
  args: string[],
  capture: boolean,
): Promise<{ code: number; stdout: string }> {
  return new Promise((resolve, reject) => {
    const child = spawn(command, args, {
      stdio: capture ? ["ignore", "pipe", "ignore"] : "inherit",
      shell: onWindows,
    });
    let stdout = "";
    child.stdout?.on("data", (chunk) => (stdout += chunk));
    child.on("error", reject);
    child.on("close", (code) =>
      resolve({ code: code ?? 0, stdout: stdout.trim() }),
    );
  });
}

async function getPinnedPnpmVersion(): Promise<string> {
  const pkg = JSON.parse(await readFile(join(rootDir, "package.json"), "utf8"));
  // e.g. "pnpm@11.5.1" or "pnpm@11.5.1+sha512..." -> "11.5.1"
  return pkg.packageManager.slice("pnpm@".length).split("+")[0];
}

async function getInstalledPnpmVersion(): Promise<string | undefined> {
  try {
    const { code, stdout } = await run("pnpm", ["--version"], true);
    return code === 0 && stdout ? stdout : undefined;
  } catch {
    // pnpm is not installed yet.
    return undefined;
  }
}

const dryRun: boolean =
  process.argv.includes("--dry-run") ||
  process.env.INSTALL_PNPM_DRY_RUN === "1";
const version: string = await getPinnedPnpmVersion();
const npmArgs: string[] = ["install", "-g", `pnpm@${version}`];

if ((await getInstalledPnpmVersion()) === version) {
  console.log(`pnpm@${version} is already installed. Nothing to do.`);
} else if (dryRun) {
  console.log(`[dry-run] Would run: npm ${npmArgs.join(" ")}`);
} else {
  console.log(`Running: npm ${npmArgs.join(" ")}`);
  const { code } = await run("npm", npmArgs, false);
  if (code !== 0) {
    console.error(
      `install-pnpm: \`npm ${npmArgs.join(" ")}\` failed with exit code ${code}.`,
    );
    process.exit(1);
  }
  console.log(
    `Installed pnpm@${version}. Next: run \`pnpm install\` from the repo root.`,
  );
}
