import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { parse } from "yaml";

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(scriptDir, "../../../../..");
const evalsDir = path.resolve(scriptDir, "../evals");
const nodeModules = process.env.FIXTURE_NODE_MODULES || path.join(repoRoot, "node_modules");
const compileCases = new Set([
  "002002-ARM-define-extension-resource-add-forced",
  "002005-ARM-define-the-resource-forced",
  "006005-dp-version-add-preview-forced",
  "006009-dp-version-property-renamed-forced",
]);

function runTsp(workspace) {
  const executable = path.join(repoRoot, "node_modules", "@typespec", "compiler", "cmd", "tsp.js");
  execFileSync(process.execPath, [executable, "compile", ".", "--pretty", "false"], {
    cwd: workspace,
    stdio: "inherit",
  });
}

function copyEnvironment(evalFile, environment, workspace) {
  for (const file of environment.files ?? []) {
    const source = path.resolve(path.dirname(evalFile), file.src);
    const destination = path.resolve(workspace, file.dest);
    assert.ok(fs.existsSync(source), `missing eval source: ${source}`);
    assert.ok(
      destination.startsWith(`${workspace}${path.sep}`),
      `eval destination escapes workspace: ${file.dest}`,
    );
    fs.mkdirSync(path.dirname(destination), { recursive: true });
    fs.copyFileSync(source, destination);
  }
}

const forced = [];
for (const entry of fs
  .readdirSync(evalsDir)
  .filter((name) => name.endsWith(".eval.yaml"))
  .sort()) {
  const evalFile = path.join(evalsDir, entry);
  const specification = parse(fs.readFileSync(evalFile, "utf8"));
  for (const stimulus of specification.stimuli ?? []) {
    if (stimulus.tags?.mode === "forced") {
      forced.push({ evalFile, stimulus });
    }
  }
}

assert.equal(forced.length, 38, "expected exactly 38 forced authoring cases");
assert.ok(
  forced.every(({ stimulus }) => !stimulus.name.startsWith("007")),
  "naming cases must remain excluded",
);
assert.ok(fs.existsSync(nodeModules), `missing fixture dependencies: ${nodeModules}`);

for (const { evalFile, stimulus } of forced) {
  assert.ok(
    stimulus.environment?.files?.some((file) => path.basename(file.dest) === "tspconfig.yaml"),
    `${stimulus.name} must stage tspconfig.yaml`,
  );
  for (const file of stimulus.environment.files ?? []) {
    assert.ok(!path.isAbsolute(file.dest), `${stimulus.name} has absolute destination`);
    assert.ok(
      !file.dest.split(/[\\/]/).includes(".."),
      `${stimulus.name} has parent traversal in destination`,
    );
  }
}

for (const { evalFile, stimulus } of forced.filter(({ stimulus }) =>
  compileCases.has(stimulus.name),
)) {
  const workspace = fs.mkdtempSync(path.join(os.tmpdir(), `${stimulus.name}-preflight-`));
  try {
    copyEnvironment(evalFile, stimulus.environment, workspace);
    const probe = path.join(workspace, ".write-probe");
    fs.writeFileSync(probe, "writable\n");
    assert.equal(fs.readFileSync(probe, "utf8"), "writable\n");
    fs.rmSync(probe);
    fs.symlinkSync(nodeModules, path.join(workspace, "node_modules"), "junction");
    const tspconfig = stimulus.environment.files.find(
      (file) => path.basename(file.dest) === "tspconfig.yaml",
    );
    runTsp(path.dirname(path.resolve(workspace, tspconfig.dest)));
  } finally {
    fs.rmSync(workspace, { force: true, recursive: true });
  }
}

console.log(
  `Harness preflight passed: ${forced.length} forced cases; ${compileCases.size} historical compile fixtures compiled.`,
);
