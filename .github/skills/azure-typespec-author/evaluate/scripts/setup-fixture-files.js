#!/usr/bin/env node

import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(scriptDir, "../../../../..");
const fixtureRoot = path.resolve(scriptDir, "../fixtures");
const instructionsSource = path.join(repoRoot, ".github", "copilot-instructions.md");
const workspaceFile = path.join(repoRoot, "pnpm-workspace.yaml");
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

for (const requiredFile of [instructionsSource, workspaceFile]) {
  if (!fs.existsSync(requiredFile)) {
    throw new Error(`Required fixture input does not exist: ${requiredFile}`);
  }
}

/** @type {Map<string, string>} */
const catalog = new Map();
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

/** @type {Record<string, string>} */
const devDependencies = {};
for (const dependency of fixtureDependencies) {
  const version = catalog.get(dependency);
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
