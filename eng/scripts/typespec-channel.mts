#!/usr/bin/env node
// Switches the TypeSpec toolchain installed in this checkout.
//
//   node eng/scripts/typespec-channel.mts next
//   node eng/scripts/typespec-channel.mts 1.17.0-dev.10
//   node eng/scripts/typespec-channel.mts next --set @typespec/compiler=<tarball-url>
//   node eng/scripts/typespec-channel.mts stable
//   node eng/scripts/typespec-channel.mts latest --persist
//
// TypeSpec packages are overridden in pnpm-workspace.yaml and installed. The committed
// pnpm-workspace.yaml and pnpm-lock.yaml are backed up under node_modules/ and restored by the
// "stable" channel. The modified files must stay in place while the channel is in use, otherwise
// pnpm reinstalls the committed versions before the next `pnpm exec`/`pnpm run`.
//
// With --clean-checkout (CI), both files are restored right after install so the checkout stays
// clean for `tsv --git-clean`. Invoke tools with `node` afterwards, not through pnpm.
//
// With --persist, the channel is resolved to exact versions that are written to the catalog and
// lockfile. Use it to create the PR that moves main to a new TypeSpec release.
//
// Node >=24 strips the TypeScript types natively. Keep this file to erasable-only TypeScript
// syntax and zero runtime dependencies so it can run before `pnpm install`.

import { spawn } from "node:child_process";
import { appendFile, mkdir, readFile, rm, writeFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { parseArgs } from "node:util";

/** Packages released together by microsoft/typespec and Azure/typespec-azure. */
export const typespecPackages: readonly string[] = [
  "@typespec/asset-emitter",
  "@typespec/compiler",
  "@typespec/events",
  "@typespec/http",
  "@typespec/openapi",
  "@typespec/openapi3",
  "@typespec/prettier-plugin-typespec",
  "@typespec/rest",
  "@typespec/sse",
  "@typespec/streams",
  "@typespec/versioning",
  "@typespec/xml",
  "@azure-tools/typespec-autorest",
  "@azure-tools/typespec-azure-core",
  "@azure-tools/typespec-azure-portal-core",
  "@azure-tools/typespec-azure-resource-manager",
  "@azure-tools/typespec-azure-rulesets",
  "@azure-tools/typespec-client-generator-core",
];

const entryPattern = /^ {2}("?)([^":\s]+)\1:\s*(.*)$/;

/** Reads `key: value` entries of a top-level map in pnpm-workspace.yaml. */
export function readYamlMap(yaml: string, section: string): Map<string, string> {
  const { lines, start, end } = findSection(yaml, section);
  const entries = new Map<string, string>();
  for (const line of lines.slice(start + 1, end)) {
    const match = entryPattern.exec(line);
    if (match) entries.set(match[2], unquote(match[3]));
  }
  return entries;
}

/**
 * Sets entries of a top-level map in pnpm-workspace.yaml, keeping the quoting style of existing
 * values. Missing keys are inserted at the top of the section when `addMissing` is true.
 */
export function setYamlMap(
  yaml: string,
  section: string,
  entries: ReadonlyMap<string, string>,
  addMissing: boolean,
): string {
  const { lines, start, end } = findSection(yaml, section);
  const pending = new Map(entries);
  for (let i = start + 1; i < end; i++) {
    const match = entryPattern.exec(lines[i]);
    if (!match) continue;
    const value = pending.get(match[2]);
    if (value === undefined) continue;
    const quoted = match[3].startsWith('"') || !/^[\w.^~<>=-]+$/.test(value);
    lines[i] = `  ${match[1]}${match[2]}${match[1]}: ${quoted ? JSON.stringify(value) : value}`;
    pending.delete(match[2]);
  }
  if (addMissing) {
    const added = [...pending].map(([key, value]) => `  "${key}": ${JSON.stringify(value)}`);
    lines.splice(start + 1, 0, ...added);
  }
  return lines.join("\n");
}

function findSection(yaml: string, section: string) {
  const lines = yaml.split("\n");
  const start = lines.findIndex((line) => line.trimEnd() === `${section}:`);
  if (start === -1) throw new Error(`pnpm-workspace.yaml has no top-level "${section}:" map`);
  let end = start + 1;
  while (end < lines.length && !/^\S/.test(lines[end])) end++;
  return { lines, start, end };
}

function unquote(value: string): string {
  return value.startsWith('"') ? (JSON.parse(value) as string) : value.replace(/\s+#.*$/, "");
}

/** Parses repeated `--set <package>=<spec>` values. */
export function parseSetOptions(values: readonly string[]): Map<string, string> {
  const result = new Map<string, string>();
  for (const value of values) {
    const separator = value.indexOf("=", 1);
    if (separator === -1) throw new Error(`--set expects <package>=<spec>, got "${value}"`);
    result.set(value.slice(0, separator), value.slice(separator + 1));
  }
  return result;
}

const rootDir: string = join(dirname(fileURLToPath(import.meta.url)), "..", "..");
const backupDir = join(rootDir, "node_modules", ".typespec-channel");

interface Snapshot {
  workspace: string;
  lock: string;
}

async function readSnapshot(dir: string): Promise<Snapshot> {
  return {
    workspace: await readFile(join(dir, "pnpm-workspace.yaml"), "utf8"),
    lock: await readFile(join(dir, "pnpm-lock.yaml"), "utf8"),
  };
}

async function writeSnapshot(dir: string, snapshot: Snapshot): Promise<void> {
  await mkdir(dir, { recursive: true });
  await writeFile(join(dir, "pnpm-workspace.yaml"), snapshot.workspace);
  await writeFile(join(dir, "pnpm-lock.yaml"), snapshot.lock);
}

async function readBackup(): Promise<Snapshot | undefined> {
  try {
    return await readSnapshot(backupDir);
  } catch {
    return undefined;
  }
}

function run(command: string, args: string[], capture = false): Promise<string> {
  return new Promise((resolve, reject) => {
    const child = spawn(command, args, {
      cwd: rootDir,
      stdio: capture ? ["ignore", "pipe", "inherit"] : "inherit",
      shell: process.platform === "win32",
    });
    let stdout = "";
    child.stdout?.on("data", (chunk) => (stdout += chunk));
    child.on("error", reject);
    child.on("close", (code) =>
      code === 0
        ? resolve(stdout)
        : reject(new Error(`\`${command} ${args.join(" ")}\` exited with code ${code}`)),
    );
  });
}

async function resolveVersion(pkg: string, spec: string): Promise<string> {
  const output = JSON.parse(
    await run("pnpm", ["view", `${pkg}@${spec}`, "version", "--json"], true),
  );
  const versions = [output].flat() as string[];
  if (versions.length === 0) throw new Error(`No version of ${pkg} matches "${spec}"`);
  return versions[versions.length - 1];
}

async function installedVersion(pkg: string): Promise<string | undefined> {
  try {
    const manifest = await readFile(join(rootDir, "node_modules", pkg, "package.json"), "utf8");
    return (JSON.parse(manifest) as { version: string }).version;
  } catch {
    return undefined;
  }
}

async function reportVersions(channel: string, committed: Map<string, string>): Promise<void> {
  const rows: string[] = [];
  for (const pkg of typespecPackages) {
    const installed = await installedVersion(pkg);
    if (installed) rows.push(`| ${pkg} | ${committed.get(pkg) ?? "-"} | ${installed} |`);
  }
  const table = [
    `### TypeSpec channel: \`${channel}\``,
    "",
    "| Package | Committed | Installed |",
    "| --- | --- | --- |",
    ...rows,
    "",
  ].join("\n");
  console.log(table);
  if (process.env.GITHUB_STEP_SUMMARY) await appendFile(process.env.GITHUB_STEP_SUMMARY, table);
}

const usage = `Usage: node eng/scripts/typespec-channel.mts <channel> [options]

  <channel>          "stable" (committed versions), an npm dist-tag such as "next", or a version.
  --set <pkg>=<spec> Override one package, e.g. with a tarball URL from a TypeSpec PR build.
  --clean-checkout   Restore pnpm-workspace.yaml and pnpm-lock.yaml right after install (CI).
  --persist          Resolve exact versions and write them to the catalog and lockfile.
  --dry-run          Print the resulting pnpm-workspace.yaml without installing.`;

async function main(): Promise<void> {
  const { values, positionals } = parseArgs({
    allowPositionals: true,
    options: {
      set: { type: "string", multiple: true, default: [] },
      "clean-checkout": { type: "boolean", default: false },
      persist: { type: "boolean", default: false },
      "dry-run": { type: "boolean", default: false },
      help: { type: "boolean", short: "h", default: false },
    },
  });
  if (values.help || positionals.length !== 1) {
    console.log(usage);
    process.exitCode = values.help ? 0 : 1;
    return;
  }

  const channel = positionals[0];
  const pinned = parseSetOptions(values.set);
  const backup = await readBackup();
  const original = backup ?? (await readSnapshot(rootDir));
  const committed = new Map([
    ...readYamlMap(original.workspace, "catalog"),
    ...readYamlMap(original.workspace, "overrides"),
  ]);

  if (channel === "stable" && pinned.size === 0) {
    if (values["dry-run"]) {
      console.log(original.workspace);
      return;
    }
    if (backup) {
      await writeSnapshot(rootDir, backup);
      await rm(backupDir, { recursive: true, force: true });
    }
    await run("pnpm", ["install", "--frozen-lockfile"]);
    await reportVersions(channel, committed);
    return;
  }

  const specs = new Map<string, string>(
    channel === "stable" ? [] : typespecPackages.map((pkg) => [pkg, channel]),
  );
  for (const [pkg, spec] of pinned) specs.set(pkg, spec);

  let workspace: string;
  if (values.persist) {
    const versions = new Map<string, string>();
    for (const [pkg, spec] of specs) {
      if (!committed.has(pkg)) continue;
      versions.set(pkg, await resolveVersion(pkg, spec));
    }
    workspace = setYamlMap(original.workspace, "catalog", versions, false);
    workspace = setYamlMap(workspace, "overrides", versions, false);
  } else {
    workspace = setYamlMap(original.workspace, "overrides", specs, true);
  }

  if (values["dry-run"]) {
    console.log(workspace);
    return;
  }

  const restore = values["clean-checkout"] && !values.persist;
  if (!restore && !values.persist && !backup) await writeSnapshot(backupDir, original);
  await writeSnapshot(rootDir, { workspace, lock: original.lock });
  try {
    await run("pnpm", ["install", "--no-frozen-lockfile", "--prefer-offline"]);
  } finally {
    if (restore) await writeSnapshot(rootDir, original);
  }
  if (values.persist) await rm(backupDir, { recursive: true, force: true });
  await reportVersions(channel, committed);
  if (!restore && !values.persist) {
    console.log(
      "pnpm-workspace.yaml and pnpm-lock.yaml are modified while this channel is in use; do not " +
        "commit them. Run `node eng/scripts/typespec-channel.mts stable` to switch back.",
    );
  }
}

if (import.meta.main) {
  try {
    await main();
  } catch (error) {
    console.error(`typespec-channel: ${(error as Error).message}`);
    process.exitCode = 1;
  }
}
