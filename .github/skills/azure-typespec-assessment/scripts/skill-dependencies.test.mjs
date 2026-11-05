import assert from "node:assert/strict";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import { ensureSkillDependencies, skillDependencyInstallCommand } from "./skill-dependencies.mjs";

function fixture() {
  const workspace = fs.mkdtempSync(path.join(os.tmpdir(), "assessment-skill-dependencies-"));
  const root = path.join(workspace, ".github", "skills", "azure-typespec-assessment");
  fs.mkdirSync(root, { recursive: true });
  fs.writeFileSync(
    path.join(workspace, "package.json"),
    JSON.stringify({ packageManager: "pnpm@11.8.0" }),
  );
  fs.writeFileSync(
    path.join(workspace, "pnpm-workspace.yaml"),
    'packages:\n  - ".github/skills/azure-typespec-assessment"\n',
  );
  fs.writeFileSync(
    path.join(root, "package.json"),
    JSON.stringify({ dependencies: { yaml: "catalog:" } }),
  );
  fs.writeFileSync(
    path.join(workspace, "pnpm-lock.yaml"),
    [
      "lockfileVersion: '9.0'",
      "importers:",
      "  .github/skills/azure-typespec-assessment:",
      "    dependencies:",
      "      yaml:",
      "        specifier: 'catalog:'",
      "        version: 2.9.0",
      "",
    ].join("\n"),
  );
  return root;
}

/** @param {string} root @param {string} [version] */
function installYaml(root, version = "2.9.0") {
  const directory = path.join(root, "node_modules", "yaml");
  fs.mkdirSync(directory, { recursive: true });
  fs.writeFileSync(path.join(directory, "package.json"), JSON.stringify({ name: "yaml", version }));
}

void test("skips installation when locked skill dependencies are ready", async () => {
  const root = fixture();
  installYaml(root);
  const result = await ensureSkillDependencies({
    root,
    runInstall: () => assert.fail("install should not run"),
    log: () => {},
  });
  assert.equal(result.installed, false);
  assert.equal(result.packages.yaml, "2.9.0");
});

void test("installs missing or stale skill dependencies", async () => {
  for (const installed of [undefined, "2.8.0"]) {
    const root = fixture();
    if (installed) installYaml(root, installed);
    let calls = 0;
    const result = await ensureSkillDependencies({
      root,
      runInstall: (target) => {
        calls += 1;
        installYaml(target);
      },
      log: () => {},
    });
    assert.equal(calls, 1);
    assert.equal(result.installed, true);
    assert.equal(fs.existsSync(path.join(root, ".dependency-install.lock")), false);
  }
});

void test("serializes concurrent first-use installation", async () => {
  const root = fixture();
  /** @type {() => void} */
  let releaseInstall = () => {};
  /** @type {() => void} */
  let signalStarted = () => {};
  /** @type {Promise<void>} */
  const started = new Promise((resolve) => {
    signalStarted = resolve;
  });
  /** @type {Promise<void>} */
  const released = new Promise((resolve) => {
    releaseInstall = resolve;
  });
  const first = ensureSkillDependencies({
    root,
    runInstall: async (target) => {
      signalStarted();
      await released;
      installYaml(target);
    },
    log: () => {},
  });
  await started;
  const second = ensureSkillDependencies({
    root,
    runInstall: () => assert.fail("second install should not run"),
    wait: () => new Promise((resolve) => setTimeout(resolve, 1)),
    timeoutMs: 1000,
    log: () => {},
  });
  releaseInstall();
  const [firstResult, secondResult] = await Promise.all([first, second]);
  assert.equal(firstResult.installed, true);
  assert.equal(secondResult.installed, false);
});

void test("cleans the installation lock after failure", async () => {
  const root = fixture();
  await assert.rejects(
    ensureSkillDependencies({
      root,
      runInstall: () => {
        throw new Error("offline");
      },
      log: () => {},
    }),
    /offline/,
  );
  assert.equal(fs.existsSync(path.join(root, ".dependency-install.lock")), false);
});

void test("builds a deterministic lifecycle-script-free skill install", () => {
  assert.deepEqual(skillDependencyInstallCommand({ platform: "win32", managerVersion: "11.8.0" }), {
    executable: "npx.cmd",
    args: ["--yes", "pnpm@11.8.0", "install", "--frozen-lockfile", "--ignore-scripts"],
  });
  assert.deepEqual(skillDependencyInstallCommand({ platform: "linux", managerVersion: "11.8.0" }), {
    executable: "npx",
    args: ["--yes", "pnpm@11.8.0", "install", "--frozen-lockfile", "--ignore-scripts"],
  });
});

void test("requires the skill importer in the workspace lockfile", async () => {
  const root = fixture();
  fs.writeFileSync(
    path.join(root, "..", "..", "..", "pnpm-lock.yaml"),
    "lockfileVersion: '9.0'\nimporters:\n  .: {}\n",
  );
  await assert.rejects(ensureSkillDependencies({ root, log: () => {} }), /pnpm importer/);
});

void test("requires an exact workspace pnpm version", async () => {
  const root = fixture();
  fs.writeFileSync(
    path.join(root, "..", "..", "..", "package.json"),
    JSON.stringify({ packageManager: "pnpm@latest" }),
  );
  await assert.rejects(
    ensureSkillDependencies({ root, log: () => {} }),
    /exact pnpm packageManager/,
  );
});

void test("rejects a skill outside a pnpm workspace", async () => {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "assessment-skill-standalone-"));
  await assert.rejects(
    ensureSkillDependencies({ root, log: () => {} }),
    /pnpm workspace is unavailable/,
  );
});

void test("reads quoted pnpm importer and version values", async () => {
  const root = fixture();
  fs.writeFileSync(
    path.join(root, "..", "..", "..", "pnpm-lock.yaml"),
    [
      "lockfileVersion: '9.0'",
      "importers:",
      "  '.github/skills/azure-typespec-assessment':",
      "    dependencies:",
      "      'yaml':",
      "        version: '2.9.0'",
      "",
    ].join("\n"),
  );
  installYaml(root);
  const result = await ensureSkillDependencies({
    root,
    runInstall: () => assert.fail("install should not run"),
    log: () => {},
  });
  assert.equal(result.packages.yaml, "2.9.0");
});
