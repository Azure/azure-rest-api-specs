#!/usr/bin/env node

import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(scriptDir, "../../../../..");
const fixtureRoot = path.resolve(scriptDir, "../fixtures");
const instructionsSource = path.join(repoRoot, ".github", "copilot-instructions.md");
const workspaceFile = path.join(repoRoot, "pnpm-workspace.yaml");
const rootPackageFile = path.join(repoRoot, "package.json");
const instructionsDestination = path.join(
  fixtureRoot,
  "instructions-test",
  "copilot-instructions.md",
);
const fixturePackage = path.join(fixtureRoot, "Microsoft.Widget", "Widget", "package.json");
const fixtureDependencies = [
  "@azure-tools/typespec-autorest",
  "@azure-tools/typespec-azure-core",
  "@azure-tools/typespec-azure-resource-manager",
  "@azure-tools/typespec-azure-rulesets",
  "@azure-tools/typespec-client-generator-core",
  "@typespec/compiler",
  "@typespec/events",
  "@typespec/http",
  "@typespec/openapi",
  "@typespec/openapi3",
  "@typespec/rest",
  "@typespec/sse",
  "@typespec/streams",
  "@typespec/versioning",
];

function hasStringDevDependencies(
  value: unknown,
): value is { devDependencies: Record<string, string> } {
  if (
    typeof value !== "object" ||
    value === null ||
    !("devDependencies" in value) ||
    typeof value.devDependencies !== "object" ||
    value.devDependencies === null
  ) {
    return false;
  }
  return Object.values(value.devDependencies).every((version) => typeof version === "string");
}

for (const requiredFile of [instructionsSource, workspaceFile, rootPackageFile]) {
  if (!fs.existsSync(requiredFile)) {
    throw new Error(`Required fixture input does not exist: ${requiredFile}`);
  }
}

const rootPackage: unknown = JSON.parse(fs.readFileSync(rootPackageFile, "utf8"));
if (!hasStringDevDependencies(rootPackage)) {
  throw new Error(`Root package has invalid devDependencies: ${rootPackageFile}`);
}
if (rootPackage.devDependencies["@azure-tools/typespec-azure-rulesets"]?.startsWith("workspace:")) {
  fixtureDependencies.push("@azure-tools/typespec-azure-rulesets-original");
}

const catalog = new Map<string, string>();
let inCatalog = false;
for (const line of fs.readFileSync(workspaceFile, "utf8").split(/\r?\n/)) {
  if (line === "catalog:") {
    inCatalog = true;
    continue;
  }
  if (inCatalog && /^\S/.test(line)) {
    break;
  }
  if (!inCatalog) {
    continue;
  }
  const match = line.match(/^[ ]{2}"([^"]+)":\s*(\S+)\s*$/);
  if (match) {
    catalog.set(match[1], match[2]);
  }
}

const devDependencies: Record<string, string> = {};
for (const dependency of fixtureDependencies) {
  const rootVersion = rootPackage.devDependencies[dependency];
  const version = rootVersion?.startsWith("workspace:") ? rootVersion : catalog.get(dependency);
  if (!version) {
    throw new Error(`Required dependency is missing from the pnpm catalog: ${dependency}`);
  }
  devDependencies[dependency] = version;
}

fs.mkdirSync(path.dirname(fixturePackage), { recursive: true });
fs.writeFileSync(
  fixturePackage,
  `${JSON.stringify(
    {
      name: "microsoft-widget-eval-fixture",
      private: true,
      type: "module",
      devDependencies,
    },
    null,
    2,
  )}\n`,
);
console.log(`generated ${fixturePackage}`);

fs.mkdirSync(path.dirname(instructionsDestination), { recursive: true });
fs.copyFileSync(instructionsSource, instructionsDestination);
console.log(`copied ${instructionsSource} -> ${instructionsDestination}`);
