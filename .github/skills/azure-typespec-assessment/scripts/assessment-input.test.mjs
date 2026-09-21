import assert from "node:assert/strict";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { spawnSync } from "node:child_process";
import test from "node:test";
import {
  commonSpecificationRoot,
  deriveSparseRoots,
  parseGitHubRepository,
  parsePullRequest,
  resolveAssessmentInput,
} from "./assessment-input.mjs";

function git(repo, ...args) {
  const result = spawnSync("git", ["-C", repo, ...args], {
    encoding: "utf8",
  });
  assert.equal(result.status, 0, result.stderr);
  return result.stdout.trim();
}

test("parses supported pull request identifiers", () => {
  assert.deepEqual(
    parsePullRequest("https://github.com/Azure/azure-rest-api-specs/pull/43718"),
    {
      owner: "Azure",
      repository: "azure-rest-api-specs",
      number: 43718,
    },
  );
  assert.deepEqual(parsePullRequest("Azure/azure-rest-api-specs#43718"), {
    owner: "Azure",
    repository: "azure-rest-api-specs",
    number: 43718,
  });
  assert.deepEqual(
    parsePullRequest(
      "43718",
      "git@github.com:Azure/azure-rest-api-specs.git",
    ),
    {
      owner: "Azure",
      repository: "azure-rest-api-specs",
      number: 43718,
    },
  );
  assert.deepEqual(
    parseGitHubRepository(
      "https://github.com/Azure/azure-rest-api-specs.git",
    ),
    { owner: "Azure", repository: "azure-rest-api-specs" },
  );
});

test("derives sparse and common specification roots", () => {
  const roots = deriveSparseRoots([
    "specification/network/Network/main.tsp",
    "specification/network/Network/models.tsp",
    "specification/storage/Storage/tspconfig.yaml",
    "README.md",
  ]);
  assert.deepEqual(roots, [
    "specification/network",
    "specification/storage",
  ]);
  assert.equal(commonSpecificationRoot(roots), "specification");
  assert.equal(
    commonSpecificationRoot(["specification/network"]),
    "specification/network",
  );
});

test("resolves an explicit head without changing the current checkout", (t) => {
  const repo = fs.mkdtempSync(path.join(os.tmpdir(), "assessment-input-"));
  t.after(() => fs.rmSync(repo, { recursive: true, force: true }));
  git(repo, "init", "-q");
  git(repo, "config", "user.email", "test@example.com");
  git(repo, "config", "user.name", "Test");
  const project = path.join(repo, "specification", "widget", "Widget");
  fs.mkdirSync(project, { recursive: true });
  fs.writeFileSync(path.join(project, "tspconfig.yaml"), "emit: []\n");
  fs.writeFileSync(path.join(project, "main.tsp"), "model Widget {}\n");
  git(repo, "add", ".");
  git(repo, "commit", "-qm", "base");
  const base = git(repo, "rev-parse", "HEAD");
  git(repo, "checkout", "-qb", "feature");
  fs.appendFileSync(path.join(project, "main.tsp"), "model Added {}\n");
  git(repo, "add", ".");
  git(repo, "commit", "-qm", "feature");
  const head = git(repo, "rev-parse", "HEAD");
  git(repo, "checkout", "-q", "--detach", base);

  const resolved = resolveAssessmentInput({
    repo,
    base,
    head,
    output: path.join(repo, "output"),
  });

  assert.equal(resolved.base, base);
  assert.equal(resolved.head, head);
  assert.equal(resolved.includeWorkingTree, false);
  assert.equal(resolved.specification, "specification/widget");
  assert.deepEqual(resolved.sparseRoots, ["specification/widget"]);
  assert.equal(resolved.mergeBaseCommit, base);
  assert.equal(git(repo, "rev-parse", "HEAD"), base);
  assert.equal(resolved.invocation.mode, "commits");
  assert.ok(resolved.invocation.timings.setupExcludingFetchMs < 60_000);
});

test("discovers both service roots for a cross-service TypeSpec rename", (t) => {
  const repo = fs.mkdtempSync(path.join(os.tmpdir(), "assessment-rename-"));
  t.after(() => fs.rmSync(repo, { recursive: true, force: true }));
  git(repo, "init", "-q");
  git(repo, "config", "user.email", "test@example.com");
  git(repo, "config", "user.name", "Test");
  const source = path.join(repo, "specification", "alpha", "Widget");
  const destination = path.join(repo, "specification", "beta", "Widget");
  fs.mkdirSync(source, { recursive: true });
  fs.writeFileSync(path.join(source, "main.tsp"), "model Widget {}\n");
  git(repo, "add", ".");
  git(repo, "commit", "-qm", "base");
  const base = git(repo, "rev-parse", "HEAD");
  fs.mkdirSync(destination, { recursive: true });
  git(
    repo,
    "mv",
    "specification/alpha/Widget/main.tsp",
    "specification/beta/Widget/main.tsp",
  );
  git(repo, "commit", "-qm", "move service");
  const head = git(repo, "rev-parse", "HEAD");

  const resolved = resolveAssessmentInput({
    repo,
    base,
    head,
    output: path.join(repo, "output"),
  });

  assert.deepEqual(resolved.sparseRoots, [
    "specification/alpha",
    "specification/beta",
  ]);
  assert.equal(resolved.specification, "specification");
});

test("exposes pull request metadata for downstream reports", (t) => {
  const repo = fs.mkdtempSync(path.join(os.tmpdir(), "assessment-pr-"));
  t.after(() => fs.rmSync(repo, { recursive: true, force: true }));
  git(repo, "init", "-q");
  git(repo, "config", "user.email", "test@example.com");
  git(repo, "config", "user.name", "Test");
  const project = path.join(repo, "specification", "widget", "Widget");
  fs.mkdirSync(project, { recursive: true });
  fs.writeFileSync(path.join(project, "tspconfig.yaml"), "emit: []\n");
  fs.writeFileSync(path.join(project, "main.tsp"), "model Widget {}\n");
  git(repo, "add", ".");
  git(repo, "commit", "-qm", "base");
  const baseCommit = git(repo, "rev-parse", "HEAD");
  fs.appendFileSync(path.join(project, "main.tsp"), "model Added {}\n");
  git(repo, "add", ".");
  git(repo, "commit", "-qm", "head");
  const headCommit = git(repo, "rev-parse", "HEAD");
  const pullRequest = {
    owner: "Azure",
    repository: "azure-rest-api-specs",
    number: 123,
    url: "https://github.com/Azure/azure-rest-api-specs/pull/123",
    cloneUrl: repo,
    baseRef: "main",
    baseCommit,
    headCommit,
  };

  const resolved = resolveAssessmentInput(
    { repo, pr: "Azure/azure-rest-api-specs#123" },
    { getPullRequest: () => pullRequest },
  );

  assert.deepEqual(resolved.pullRequest, pullRequest);
  assert.deepEqual(resolved.invocation.pullRequest, pullRequest);
});

test("fetches missing explicit refs without checking them out", (t) => {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "assessment-fetch-"));
  t.after(() => fs.rmSync(root, { recursive: true, force: true }));
  const remote = path.join(root, "remote");
  const repo = path.join(root, "consumer");
  fs.mkdirSync(remote);
  git(remote, "init", "-q");
  git(remote, "config", "user.email", "test@example.com");
  git(remote, "config", "user.name", "Test");
  const project = path.join(remote, "specification", "widget", "Widget");
  fs.mkdirSync(project, { recursive: true });
  fs.writeFileSync(path.join(project, "tspconfig.yaml"), "emit: []\n");
  fs.writeFileSync(path.join(project, "main.tsp"), "model Widget {}\n");
  git(remote, "add", ".");
  git(remote, "commit", "-qm", "base");
  git(remote, "branch", "-M", "main");
  git(remote, "checkout", "-qb", "feature");
  fs.appendFileSync(path.join(project, "main.tsp"), "model Added {}\n");
  git(remote, "add", ".");
  git(remote, "commit", "-qm", "feature");

  fs.mkdirSync(repo);
  git(repo, "init", "-q");
  git(repo, "remote", "add", "origin", remote);
  const originalHead = git(repo, "symbolic-ref", "HEAD");
  const resolved = resolveAssessmentInput({
    repo,
    base: "refs/heads/main",
    head: "refs/heads/feature",
    output: path.join(root, "output"),
  });

  assert.equal(resolved.includeWorkingTree, false);
  assert.equal(resolved.specification, "specification/widget");
  assert.deepEqual(resolved.sparseRoots, ["specification/widget"]);
  assert.ok(resolved.invocation.timings.fetchMs > 0);
  assert.ok(resolved.invocation.timings.setupExcludingFetchMs < 60_000);
  assert.equal(git(repo, "symbolic-ref", "HEAD"), originalHead);
});

test("rejects conflicting remote comparison inputs", () => {
  assert.throws(
    () =>
      resolveAssessmentInput({
        repo: process.cwd(),
        pr: "Azure/azure-rest-api-specs#1",
        base: "main",
        output: "out",
      }),
    /cannot be combined/,
  );
  assert.throws(
    () =>
      resolveAssessmentInput({
        repo: process.cwd(),
        head: "feature",
        output: "out",
      }),
    /requires --base/,
  );
});
