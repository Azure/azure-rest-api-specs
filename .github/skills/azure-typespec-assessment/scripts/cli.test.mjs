import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import { fileURLToPath, pathToFileURL } from "node:url";
import { isMain, readJson } from "./cli.mjs";

/** @typedef {{status: string, sparseCheckout: {roots: string[]}}} NoChangeManifest */
/** @typedef {{status: string}} NoChangeInput */
/** @typedef {{status: string, invocation: {mode: string}, comparison: {headCommit: string}}} ImmutableManifest */

/** @param {string} repo @param {...string} args */
function git(repo, ...args) {
  const result = spawnSync("git", ["-C", repo, ...args], {
    encoding: "utf8",
  });
  assert.equal(result.status, 0, result.stderr);
  return result.stdout.trim();
}

void test("resolves the shared entrypoint at most once across imported modules", (t) => {
  const realpath = t.mock.method(fs, "realpathSync");
  assert.equal(isMain(new URL("./cli.mjs", import.meta.url).href), false);
  assert.equal(isMain(new URL("./git-evidence.mjs", import.meta.url).href), false);
  assert.ok(realpath.mock.callCount() <= 1);
});

void test("detects direct and linked entrypoints without running imported scripts", (t) => {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "assessment-cli-"));
  t.after(() => fs.rmSync(root, { recursive: true, force: true }));
  const actual = path.join(root, "actual");
  const linked = path.join(root, "linked");
  fs.mkdirSync(actual);
  fs.symlinkSync(actual, linked, process.platform === "win32" ? "junction" : "dir");
  const helper = new URL("./cli.mjs", import.meta.url).href;
  fs.writeFileSync(
    path.join(actual, "entry.mjs"),
    [
      `import { isMain } from ${JSON.stringify(helper)};`,
      `console.log(isMain(import.meta.url) ? "main" : "imported");`,
    ].join("\n"),
  );
  for (const entry of [path.join(actual, "entry.mjs"), path.join(linked, "entry.mjs")]) {
    for (const flags of [[], ["--preserve-symlinks-main"]]) {
      const result = spawnSync(process.execPath, [...flags, entry], { encoding: "utf8" });
      assert.equal(result.status, 0, result.stderr);
      assert.equal(result.stdout.trim(), "main");
    }
  }
  const imported = spawnSync(
    process.execPath,
    [
      "--input-type=module",
      "-e",
      `await import(${JSON.stringify(pathToFileURL(path.join(linked, "entry.mjs")).href)});`,
    ],
    { encoding: "utf8" },
  );
  assert.equal(imported.status, 0, imported.stderr);
  assert.equal(imported.stdout.trim(), "imported");
});

void test("linked assessment CLI accepts absolute scope and writes its no-change artifacts", (t) => {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "assessment-linked-cli-"));
  const linked = path.join(root, "installed-skill");
  t.after(() => {
    fs.rmSync(linked, { recursive: true, force: true });
    fs.rmSync(root, { recursive: true, force: true });
  });
  const repo = path.join(root, "repo");
  const scope = path.join(repo, "specification", "widget");
  fs.mkdirSync(scope, { recursive: true });
  fs.writeFileSync(path.join(scope, "main.tsp"), "model Widget {}\n");
  for (const args of [
    ["init", "-q"],
    ["add", "."],
    ["-c", "user.name=Test", "-c", "user.email=test@example.com", "commit", "-qm", "base"],
  ]) {
    const result = spawnSync("git", ["-C", repo, ...args], { encoding: "utf8" });
    assert.equal(result.status, 0, result.stderr);
  }
  fs.symlinkSync(
    fileURLToPath(new URL("..", import.meta.url)),
    linked,
    process.platform === "win32" ? "junction" : "dir",
  );
  const script = path.join(linked, "scripts", "run-assessment-analysis.mjs");
  const missing = spawnSync(process.execPath, [script], { encoding: "utf8" });
  assert.equal(missing.status, 1);
  assert.match(missing.stderr, /Missing required argument --output/);
  for (const [name, specification] of [
    ["absolute", scope],
    ["relative", "specification/widget"],
  ]) {
    const output = path.join(root, name);
    const result = spawnSync(
      process.execPath,
      [
        script,
        "--repo",
        repo,
        "--base",
        "HEAD",
        "--specification",
        specification,
        "--output",
        output,
      ],
      { cwd: root, encoding: "utf8" },
    );
    assert.equal(result.status, 0, result.stderr);
    assert.match(result.stdout, /no-changes:/);
    const manifest = /** @type {NoChangeManifest} */ (
      readJson(path.join(output, "preparation-manifest.json"))
    );
    assert.equal(manifest.status, "no-changes");
    assert.deepEqual(manifest.sparseCheckout.roots, ["specification/widget"]);
    const input = /** @type {NoChangeInput} */ (readJson(path.join(output, "model-input.json")));
    assert.equal(input.status, "no-changes");
  }

  const commit = git(repo, "rev-parse", "HEAD");
  const immutableOutput = path.join(root, "immutable");
  const immutable = spawnSync(
    process.execPath,
    [script, "--repo", repo, "--base", commit, "--head", commit, "--output", immutableOutput],
    { cwd: root, encoding: "utf8" },
  );
  assert.equal(immutable.status, 0, immutable.stderr);
  const immutableManifest = /** @type {ImmutableManifest} */ (
    readJson(path.join(immutableOutput, "preparation-manifest.json"))
  );
  assert.equal(immutableManifest.status, "no-changes");
  assert.equal(immutableManifest.invocation.mode, "commits");
  assert.equal(immutableManifest.comparison.headCommit, commit);
});
