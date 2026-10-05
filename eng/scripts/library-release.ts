/**
 * Prepares and gates library releases for the publish-libraries pipeline.
 *
 * --prepare <library> updates its manifest to a development version derived from
 * the last library-folder commit, keeping the version stable across reruns.
 * --check <artifact-directory> reads the packed manifest and queries npm through
 * the configured, authenticated registry. It emits the ShouldPublish pipeline
 * output so existing versions skip publishing; registry errors fail the check.
 *
 * Run directly with Node.js 24 or later; no compilation is required.
 */
import { execFileSync, spawnSync } from "node:child_process";
import { readFile, readdir, writeFile } from "node:fs/promises";
import { join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { parseArgs } from "node:util";

interface PackageManifest {
  name: string;
  version: string;
}

export function prereleaseVersion(version: string, commit: string, timestamp: string): string {
  const base = version.split(/[+-]/)[0];
  return `${base}-dev.${timestamp}.g${commit.slice(0, 12)}`;
}

export async function preparePrerelease(packageDirectory: string): Promise<void> {
  const manifestPath = join(packageDirectory, "package.json");
  const manifest = JSON.parse(await readFile(manifestPath, "utf8")) as PackageManifest;
  // Use the last library-folder commit so unrelated main commits and reruns keep the same version.
  const revision = execFileSync("git", ["log", "-1", "--format=%H:%ct", "--", "."], {
    cwd: packageDirectory,
    encoding: "utf8",
  }).trim();
  const [commit, timestamp] = revision.split(":");
  manifest.version = prereleaseVersion(manifest.version, commit, timestamp);
  await writeFile(manifestPath, `${JSON.stringify(manifest, null, 2)}\n`);
  console.log(`Prepared ${manifest.name}@${manifest.version}.`);
}

export function isPackagePublished(name: string, version: string): boolean {
  const result = spawnSync(
    "npm",
    ["view", `${name}@${version}`, "version", "--json", "--prefer-online"],
    {
      encoding: "utf8",
      shell: process.platform === "win32",
      timeout: 120_000,
    },
  );
  if (result.error) {
    throw result.error;
  }
  if (result.status !== 0) {
    const { error } = JSON.parse(result.stdout) as { error: { code: string } };
    if (error.code === "E404") {
      return false;
    }
    throw new Error(`Checking ${name}@${version} failed: ${result.stdout}\n${result.stderr}`);
  }
  const publishedVersion = JSON.parse(result.stdout) as string;
  if (publishedVersion !== version) {
    throw new Error(`Checking ${name}@${version} returned an unexpected version.`);
  }
  return true;
}

export async function checkRelease(artifactDirectory: string): Promise<boolean> {
  const packages = (await readdir(artifactDirectory)).filter((file) => file.endsWith(".tgz"));
  if (packages.length !== 1) {
    throw new Error(`Expected exactly one library package, found ${packages.length}.`);
  }
  const manifest = JSON.parse(
    execFileSync("tar", ["-xzOf", join(artifactDirectory, packages[0]), "package/package.json"], {
      encoding: "utf8",
    }),
  ) as PackageManifest;
  const published = isPackagePublished(manifest.name, manifest.version);
  console.log(
    published
      ? `${manifest.name}@${manifest.version} is already published; skipping release.`
      : `${manifest.name}@${manifest.version} needs publishing.`,
  );
  console.log(`##vso[task.setvariable variable=ShouldPublish;isOutput=true]${!published}`);
  return !published;
}

async function main(): Promise<void> {
  const { values } = parseArgs({
    options: { prepare: { type: "string" }, check: { type: "string" } },
  });
  if (values.prepare && !values.check) {
    await preparePrerelease(resolve(values.prepare));
  } else if (values.check && !values.prepare) {
    await checkRelease(resolve(values.check));
  } else {
    throw new Error("Usage: library-release.ts --prepare <library> | --check <artifact-directory>");
  }
}

if (process.argv[1] && fileURLToPath(import.meta.url) === resolve(process.argv[1])) {
  main().catch((error: unknown) => {
    console.error(error);
    process.exitCode = 1;
  });
}
