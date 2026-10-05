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
  [key: string]: unknown;
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function readManifest(text: string): PackageManifest {
  const manifest: unknown = JSON.parse(text);
  if (
    !isRecord(manifest) ||
    typeof manifest.name !== "string" ||
    !manifest.name ||
    typeof manifest.version !== "string" ||
    !manifest.version
  ) {
    throw new Error("Package manifest must contain a name and version.");
  }
  return { ...manifest, name: manifest.name, version: manifest.version };
}

export function prereleaseVersion(version: string, commit: string, timestamp: string): string {
  const base =
    /^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-[0-9A-Za-z.-]+)?(?:\+[0-9A-Za-z.-]+)?$/.exec(
      version,
    );
  if (!base || !/^[a-f0-9]{40}$/.test(commit) || !/^[1-9]\d*$/.test(timestamp)) {
    throw new Error("A valid package version, full Git commit, and commit timestamp are required.");
  }
  return `${base[1]}.${base[2]}.${base[3]}-dev.${timestamp}.g${commit.slice(0, 12)}`;
}

export async function preparePrerelease(packageDirectory: string): Promise<void> {
  const manifestPath = join(packageDirectory, "package.json");
  const manifest = readManifest(await readFile(manifestPath, "utf8"));
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
  const result = spawnSync("npm", ["view", name, "versions", "--json", "--prefer-online"], {
    encoding: "utf8",
    shell: process.platform === "win32",
    timeout: 120_000,
  });
  if (result.error) {
    throw result.error;
  }
  const metadata: unknown = JSON.parse(result.stdout);
  if (result.status !== 0) {
    if (isRecord(metadata) && isRecord(metadata.error) && metadata.error.code === "E404") {
      return false;
    }
    throw new Error(`Checking ${name}@${version} failed: ${result.stdout}\n${result.stderr}`);
  }
  if (!Array.isArray(metadata) || !metadata.every((item: unknown) => typeof item === "string")) {
    throw new Error(`Checking ${name}@${version} failed: invalid npm registry metadata.`);
  }
  return metadata.includes(version);
}

export async function checkRelease(artifactDirectory: string): Promise<boolean> {
  const packages = (await readdir(artifactDirectory)).filter((file) => file.endsWith(".tgz"));
  if (packages.length !== 1) {
    throw new Error(`Expected exactly one library package, found ${packages.length}.`);
  }
  const manifest = readManifest(
    execFileSync("tar", ["-xzOf", join(artifactDirectory, packages[0]), "package/package.json"], {
      encoding: "utf8",
    }),
  );
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
