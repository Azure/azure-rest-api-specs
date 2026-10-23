#!/usr/bin/env node
// Installs another TypeSpec version in this checkout by overriding the TypeSpec packages in
// pnpm-workspace.yaml.
//
//   node eng/scripts/typespec-channel.mts next
//   node eng/scripts/typespec-channel.mts next --set @typespec/compiler=1.17.0-dev.10
//   node eng/scripts/typespec-channel.mts next --set @typespec/compiler=<tarball-url>
//   node eng/scripts/typespec-channel.mts stable
//
// pnpm-workspace.yaml and pnpm-lock.yaml stay modified while a channel is in use, otherwise pnpm
// reinstalls the committed versions before the next `pnpm exec`/`pnpm run`. Do not commit them.
// "stable" restores both from git. CI that needs a clean checkout restores them right after this
// script and invokes tools with `node` instead of pnpm.
//
// Runs before `pnpm install`: keep it dependency-free and limited to erasable TypeScript syntax.

import { execFileSync } from "node:child_process";
import { readFile, writeFile } from "node:fs/promises";
import { join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { parseArgs } from "node:util";

/** Packages released together by microsoft/typespec and Azure/typespec-azure. */
const typespecPackages = [
  "@typespec/asset-emitter",
  "@typespec/compiler",
  "@typespec/events",
  "@typespec/http",
  "@typespec/library-linter",
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

const usage = `Usage: node eng/scripts/typespec-channel.mts <channel> [--set <package>=<spec>]...

  <channel>  "stable" restores the committed versions. Otherwise use an npm dist-tag (e.g. "next").
  --set      Override one package with an exact version or a tarball URL from a TypeSpec PR build.`;

/** Replaces or adds `overrides` entries in pnpm-workspace.yaml. */
function setOverrides(yaml: string, overrides: ReadonlyMap<string, string>): string {
  const lines = yaml.split("\n");
  const start = lines.indexOf("overrides:");
  if (start === -1) throw new Error('pnpm-workspace.yaml has no top-level "overrides:" map');
  let end = start + 1;
  while (end < lines.length && !/^\S/.test(lines[end])) end++;
  const kept = lines
    .slice(start + 1, end)
    .filter((line) => !overrides.has(/^ {2}"?([^":\s]+)"?:/.exec(line)?.[1] ?? ""));
  const added = [...overrides].map(([pkg, spec]) => `  "${pkg}": ${JSON.stringify(spec)}`);
  lines.splice(start + 1, end - start - 1, ...added, ...kept);
  return lines.join("\n");
}

function run(command: string, args: string[]): void {
  execFileSync(command, args, { stdio: "inherit", shell: process.platform === "win32" });
}

export async function main(args = process.argv.slice(2)): Promise<void> {
  const { values, positionals } = parseArgs({
    args,
    allowPositionals: true,
    options: { set: { type: "string", multiple: true, default: [] } },
  });
  if (positionals.length !== 1) throw new Error(usage);

  const channel = positionals[0];
  if (!/^[a-zA-Z][a-zA-Z0-9._-]*$/.test(channel) || /^v\d/.test(channel)) {
    throw new Error(
      `Invalid channel "${channel}". Use an npm dist-tag such as "next". ` +
        "TypeSpec packages have different versions; select exact versions with --set <package>=<version>.",
    );
  }
  const overrides = new Map(
    channel === "stable" ? [] : typespecPackages.map((pkg): [string, string] => [pkg, channel]),
  );
  for (const value of values.set) {
    const separator = value.indexOf("=", 1);
    if (separator === -1 || separator === value.length - 1) {
      throw new Error(`--set expects <package>=<spec>, got "${value}"`);
    }
    overrides.set(value.slice(0, separator), value.slice(separator + 1));
  }

  process.chdir(join(import.meta.dirname, "..", ".."));
  run("git", ["restore", "--", "pnpm-workspace.yaml", "pnpm-lock.yaml"]);
  if (overrides.size === 0) {
    run("pnpm", ["install", "--frozen-lockfile"]);
  } else {
    const workspace = await readFile("pnpm-workspace.yaml", "utf8");
    await writeFile("pnpm-workspace.yaml", setOverrides(workspace, overrides));
    run("pnpm", ["install", "--no-frozen-lockfile"]);
    console.log(
      "\npnpm-workspace.yaml and pnpm-lock.yaml must stay modified while this channel is in use. " +
        "Do not commit them. Run `node eng/scripts/typespec-channel.mts stable` to switch back.",
    );
  }
}

if (process.argv[1] && fileURLToPath(import.meta.url) === resolve(process.argv[1])) {
  await main();
}
