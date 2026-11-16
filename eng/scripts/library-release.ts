/**
 * Prepares development versions for the publish-libraries pipeline.
 *
 * Updates the library manifest to <base-version>-dev.<change-count>, counting
 * first-parent Git commits that changed its folder. Reruns and unrelated commits
 * keep the same version; repeat publishing is handled by the publishing job.
 *
 * Run with Node.js 24 or later: node eng/scripts/library-release.ts <library>
 */
import { execFileSync } from "node:child_process";
import { readFile, writeFile } from "node:fs/promises";
import { join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

interface PackageManifest {
  name: string;
  version: string;
}

export function prereleaseVersion(version: string, changeCount: string): string {
  const base = version.split(/[+-]/)[0];
  return `${base}-dev.${changeCount}`;
}

export async function preparePrerelease(packageDirectory: string): Promise<void> {
  const manifestPath = join(packageDirectory, "package.json");
  const manifest = JSON.parse(await readFile(manifestPath, "utf8")) as PackageManifest;
  const changeCount = execFileSync(
    "git",
    ["rev-list", "--first-parent", "--count", "HEAD", "--", "."],
    {
      cwd: packageDirectory,
      encoding: "utf8",
    },
  ).trim();
  manifest.version = prereleaseVersion(manifest.version, changeCount);
  await writeFile(manifestPath, `${JSON.stringify(manifest, null, 2)}\n`);
  console.log(`Prepared ${manifest.name}@${manifest.version}.`);
}

if (process.argv[1] && fileURLToPath(import.meta.url) === resolve(process.argv[1])) {
  const packageDirectory = process.argv[2];
  if (!packageDirectory) {
    throw new Error("Usage: node eng/scripts/library-release.ts <library>");
  }
  preparePrerelease(resolve(packageDirectory)).catch((error: unknown) => {
    console.error(error);
    process.exitCode = 1;
  });
}
