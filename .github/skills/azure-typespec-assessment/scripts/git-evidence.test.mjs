import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import {
  collectChanges,
  createSparseWorktree,
  deriveServiceRoot,
  normalizeSparseRoots,
  normalizeSpecification,
  resolveComparison,
} from "./git-evidence.mjs";

/** @param {string} repo @param {...string} args */
function git(repo, ...args) {
  const result = spawnSync("git", ["-C", repo, ...args], { encoding: "utf8" });
  assert.equal(result.status, 0, result.stderr);
  return result.stdout.trim();
}

void test("collectChanges combines committed, staged, unstaged, and untracked TypeSpec", () => {
  const repo = fs.mkdtempSync(path.join(os.tmpdir(), "typespec-git-"));
  git(repo, "init", "-q");
  git(repo, "config", "user.email", "test@example.com");
  git(repo, "config", "user.name", "Test");
  fs.mkdirSync(path.join(repo, "specification", "widget"), { recursive: true });
  fs.writeFileSync(path.join(repo, "specification", "widget", "main.tsp"), "model A {}\n");
  fs.writeFileSync(path.join(repo, "specification", "widget", "staged.tsp"), "model B {}\n");
  git(repo, "add", ".");
  git(repo, "commit", "-qm", "base");
  const base = git(repo, "rev-parse", "HEAD");

  fs.appendFileSync(path.join(repo, "specification", "widget", "main.tsp"), "model C {}\n");
  fs.appendFileSync(path.join(repo, "specification", "widget", "staged.tsp"), "model D {}\n");
  git(repo, "add", "specification/widget/staged.tsp");
  fs.writeFileSync(path.join(repo, "specification", "widget", "new.tsp"), "model E {}\n");

  const comparison = resolveComparison(repo, base);
  const changes = collectChanges(repo, comparison.mergeBaseCommit, "specification/widget");
  assert.deepEqual(
    collectChanges(
      repo,
      comparison.mergeBaseCommit,
      normalizeSpecification(repo, path.join(repo, "specification", "widget")),
    ),
    changes,
  );
  assert.deepEqual(
    changes.map((item) => [item.path, item.origins]),
    [
      ["specification/widget/main.tsp", ["unstaged"]],
      ["specification/widget/new.tsp", ["untracked"]],
      ["specification/widget/staged.tsp", ["staged"]],
    ],
  );
});

void test("collectChanges compares an explicit head without local overlays", () => {
  const repo = fs.mkdtempSync(path.join(os.tmpdir(), "typespec-head-"));
  try {
    git(repo, "init", "-q");
    git(repo, "config", "user.email", "test@example.com");
    git(repo, "config", "user.name", "Test");
    const root = path.join(repo, "specification", "widget");
    fs.mkdirSync(root, { recursive: true });
    fs.writeFileSync(path.join(root, "main.tsp"), "model A {}\n");
    git(repo, "add", ".");
    git(repo, "commit", "-qm", "base");
    const base = git(repo, "rev-parse", "HEAD");
    fs.appendFileSync(path.join(root, "main.tsp"), "model B {}\n");
    git(repo, "add", ".");
    git(repo, "commit", "-qm", "head");
    const head = git(repo, "rev-parse", "HEAD");
    fs.appendFileSync(path.join(root, "main.tsp"), "model Local {}\n");
    fs.writeFileSync(path.join(root, "untracked.tsp"), "model Untracked {}\n");

    const comparison = resolveComparison(repo, base, head);
    const changes = collectChanges(repo, comparison.mergeBaseCommit, "specification/widget", {
      headRef: head,
      includeWorkingTree: false,
    });

    assert.deepEqual(
      changes.map((item) => [item.path, item.origins]),
      [["specification/widget/main.tsp", ["committed"]]],
    );
  } finally {
    fs.rmSync(repo, { recursive: true, force: true });
  }
});

void test("deriveServiceRoot rejects paths outside specification", () => {
  assert.equal(deriveServiceRoot("specification"), "specification");
  assert.equal(
    deriveServiceRoot("specification/widget/resource-manager/Widget"),
    "specification/widget",
  );
  assert.throws(() => deriveServiceRoot("tools/widget"), /specification/);
});

void test("normalizes absolute and relative specification paths within the repository", () => {
  const repo = path.join(os.tmpdir(), "typespec-scope");
  const relative = "specification/widget/resource-manager/Widget";
  assert.equal(normalizeSpecification(repo, path.join(repo, relative)), relative);
  assert.equal(normalizeSpecification(repo, relative), relative);
  assert.equal(normalizeSpecification(repo, `.\\${relative.replaceAll("/", "\\")}\\`), relative);
  assert.equal(normalizeSpecification(repo, "specification"), "specification");
  for (const scope of [
    "../specification/widget",
    path.join(repo, "..", "other", relative),
    "tools/widget",
    "specification/widget/../../tools",
  ]) {
    assert.throws(() => normalizeSpecification(repo, scope), /Specification must be under/);
  }
});

void test("normalizes explicit sparse roots without collapsing them", () => {
  assert.deepEqual(
    normalizeSparseRoots(
      [
        "specification/recoveryservicesbackup/",
        "specification\\recoveryservices",
        "specification/recoveryservices",
      ],
      "specification",
    ),
    ["specification/recoveryservices", "specification/recoveryservicesbackup"],
  );
  assert.deepEqual(
    normalizeSparseRoots(undefined, "specification/widget/resource-manager/Widget"),
    ["specification/widget"],
  );
  assert.deepEqual(
    normalizeSparseRoots(["./specification//widget/./resource-manager/"], "specification/widget"),
    ["specification/widget/resource-manager"],
  );
  for (const root of [
    "../specification/widget",
    "specification/widget/../other",
    "specification/widget/resource-manager/../../other",
    "/specification/widget",
    "C:\\specification\\widget",
  ]) {
    assert.throws(
      () => normalizeSparseRoots([root], "specification/widget"),
      /Sparse roots must be under/,
    );
  }
});

void test("collectChanges classifies both sides of TypeSpec renames across sparse roots", () => {
  const repo = fs.mkdtempSync(path.join(os.tmpdir(), "typespec-renames-"));
  try {
    git(repo, "init", "-q");
    git(repo, "config", "user.email", "test@example.com");
    git(repo, "config", "user.name", "Test");
    const one = path.join(repo, "specification", "one");
    const two = path.join(repo, "specification", "two");
    fs.mkdirSync(one, { recursive: true });
    fs.mkdirSync(two, { recursive: true });
    fs.writeFileSync(path.join(one, "cross.tsp"), "model Cross {}\n");
    fs.writeFileSync(path.join(one, "removed.tsp"), "model Removed {}\n");
    fs.writeFileSync(path.join(two, "promoted.txt"), "model Promoted {}\n");
    git(repo, "add", ".");
    git(repo, "commit", "-qm", "base");
    const base = git(repo, "rev-parse", "HEAD");

    git(repo, "mv", "specification/one/cross.tsp", "specification/two/cross.tsp");
    git(repo, "mv", "specification/one/removed.tsp", "specification/one/removed.txt");
    git(repo, "mv", "specification/two/promoted.txt", "specification/two/promoted.tsp");
    git(repo, "commit", "-qam", "rename files");
    const head = git(repo, "rev-parse", "HEAD");

    const changes = collectChanges(repo, base, ["specification/one", "specification/two"], {
      headRef: head,
      includeWorkingTree: false,
    });

    assert.deepEqual(
      changes.map(({ path: file, previousPath, status }) => ({
        path: file,
        previousPath,
        status,
      })),
      [
        {
          path: "specification/one/removed.txt",
          previousPath: "specification/one/removed.tsp",
          status: "removed",
        },
        {
          path: "specification/two/cross.tsp",
          previousPath: "specification/one/cross.tsp",
          status: "modified",
        },
        {
          path: "specification/two/promoted.tsp",
          previousPath: "specification/two/promoted.txt",
          status: "added",
        },
      ],
    );
  } finally {
    fs.rmSync(repo, { recursive: true, force: true });
  }
});

void test("creates a worktree with multiple sparse roots", () => {
  const repo = fs.mkdtempSync(path.join(os.tmpdir(), "typespec-sparse-source-"));
  const worktreeRoot = fs.mkdtempSync(path.join(os.tmpdir(), "typespec-sparse-worktree-"));
  const destination = path.join(worktreeRoot, "checkout");
  try {
    git(repo, "init", "-q");
    git(repo, "config", "user.email", "test@example.com");
    git(repo, "config", "user.name", "Test");
    for (const service of ["one", "two", "excluded"]) {
      const directory = path.join(repo, "specification", service);
      fs.mkdirSync(directory, { recursive: true });
      fs.writeFileSync(path.join(directory, "main.tsp"), `namespace ${service};\n`);
    }
    git(repo, "add", ".");
    git(repo, "commit", "-qm", "base");
    const commit = git(repo, "rev-parse", "HEAD");

    const roots = createSparseWorktree(
      repo,
      commit,
      ["specification/one", "specification/two"],
      destination,
    );

    assert.deepEqual(roots, ["specification/one", "specification/two"]);
    assert.equal(fs.existsSync(path.join(destination, "specification", "one", "main.tsp")), true);
    assert.equal(fs.existsSync(path.join(destination, "specification", "two", "main.tsp")), true);
    assert.equal(
      fs.existsSync(path.join(destination, "specification", "excluded", "main.tsp")),
      false,
    );
  } finally {
    spawnSync("git", ["-C", repo, "worktree", "remove", "--force", destination]);
    fs.rmSync(repo, { recursive: true, force: true });
    fs.rmSync(worktreeRoot, { recursive: true, force: true });
  }
});
