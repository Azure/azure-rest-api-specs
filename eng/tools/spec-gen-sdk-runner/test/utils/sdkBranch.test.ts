import { execFileSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { afterEach, beforeEach, describe, expect, test, vi } from "vitest";
import * as log from "../../src/log.ts";
import { checkoutMainBranch, checkoutSdkBranch, isValidSdkBranchName } from "../../src/utils.ts";

const temporaryDirectories: string[] = [];

function createRepoWithEmptyOrigin(): string {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "sdk-branch-test-"));
  temporaryDirectories.push(root);
  const remotePath = path.join(root, "remote.git");
  const repoPath = path.join(root, "repo");

  execFileSync("git", ["init", "--bare", remotePath], { stdio: "ignore" });
  execFileSync("git", ["init", repoPath], { stdio: "ignore" });
  execFileSync("git", ["-C", repoPath, "remote", "add", "origin", remotePath], {
    stdio: "ignore",
  });
  return repoPath;
}

function createRepoWithOriginBranch(branch: string): string {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "sdk-branch-test-"));
  temporaryDirectories.push(root);
  const remotePath = path.join(root, "remote.git");
  const seedPath = path.join(root, "seed");
  const repoPath = path.join(root, "repo");

  execFileSync("git", ["init", "--bare", remotePath], { stdio: "ignore" });
  execFileSync("git", ["init", seedPath], { stdio: "ignore" });
  execFileSync("git", ["-C", seedPath, "config", "user.email", "test@example.com"]);
  execFileSync("git", ["-C", seedPath, "config", "user.name", "SDK Branch Test"]);
  fs.writeFileSync(path.join(seedPath, "branch.txt"), "main");
  execFileSync("git", ["-C", seedPath, "add", "branch.txt"]);
  execFileSync("git", ["-C", seedPath, "commit", "-m", "main"], { stdio: "ignore" });
  execFileSync("git", ["-C", seedPath, "branch", "-M", "main"]);
  execFileSync("git", ["-C", seedPath, "remote", "add", "origin", remotePath]);
  execFileSync("git", ["-C", seedPath, "push", "origin", "main"], { stdio: "ignore" });

  execFileSync("git", ["-C", seedPath, "checkout", "-b", branch], { stdio: "ignore" });
  fs.writeFileSync(path.join(seedPath, "branch.txt"), branch);
  execFileSync("git", ["-C", seedPath, "add", "branch.txt"]);
  execFileSync("git", ["-C", seedPath, "commit", "-m", branch], { stdio: "ignore" });
  execFileSync("git", ["-C", seedPath, "push", "origin", branch], { stdio: "ignore" });

  execFileSync("git", ["clone", "--branch", "main", remotePath, repoPath], {
    stdio: "ignore",
  });
  return repoPath;
}

describe("isValidSdkBranchName", () => {
  test.each(["main", "users/alice/feature-x", "feature/foo", "release/1.2.3", "hotfix_1"])(
    "accepts '%s'",
    (branch) => {
      expect(isValidSdkBranchName(branch)).toBe(true);
    },
  );

  test.each([
    "", // empty
    "-x", // leading dash (could be read as a git option)
    "refs/heads/x", // refs/ prefix
    "refs/pull/1/head", // PR ref
    "/x", // leading slash
    "x/", // trailing slash
    "a//b", // double slash
    "a..b", // double dot
    "a.lock", // .lock suffix
    "a.", // trailing dot
    "a\\b", // backslash
    "a b", // whitespace
    "a~b",
    "a^b",
    "a:b",
    "a?b",
    "a*b",
    "a[b]",
  ])("rejects '%s'", (branch) => {
    expect(isValidSdkBranchName(branch)).toBe(false);
  });

  test("rejects names longer than 250 characters", () => {
    expect(isValidSdkBranchName("a".repeat(251))).toBe(false);
    expect(isValidSdkBranchName("a".repeat(250))).toBe(true);
  });
});

describe("checkoutSdkBranch", () => {
  beforeEach(() => {
    vi.restoreAllMocks();
    vi.spyOn(log, "logMessage").mockImplementation(() => {});
  });

  afterEach(() => {
    for (const directory of temporaryDirectories.splice(0)) {
      fs.rmSync(directory, { recursive: true, force: true });
    }
  });

  test("rejects an unsafe branch name without invoking git", async () => {
    await expect(checkoutSdkBranch("/repo", "refs/heads/evil")).rejects.toThrow(
      "unsafe SDK branch name",
    );
  });

  test("returns false only when origin confirms the branch is missing", async () => {
    const repoPath = createRepoWithEmptyOrigin();

    await expect(checkoutSdkBranch(repoPath, "missing-branch")).resolves.toBe(false);
    expect(log.logMessage).toHaveBeenCalledWith(
      "SDK branch 'missing-branch' not found on origin; falling back to 'main'",
      log.LogLevel.Warn,
    );
  });

  test("fetches and checks out an existing SDK branch, then restores main", async () => {
    const repoPath = createRepoWithOriginBranch("feature/test");

    await expect(checkoutSdkBranch(repoPath, "feature/test")).resolves.toBe(true);
    expect(
      execFileSync("git", ["-C", repoPath, "branch", "--show-current"], {
        encoding: "utf8",
      }).trim(),
    ).toBe("feature/test");
    expect(fs.readFileSync(path.join(repoPath, "branch.txt"), "utf8")).toBe("feature/test");

    await expect(checkoutMainBranch(repoPath)).resolves.toBeUndefined();
    expect(
      execFileSync("git", ["-C", repoPath, "branch", "--show-current"], {
        encoding: "utf8",
      }).trim(),
    ).toBe("main");
    expect(fs.readFileSync(path.join(repoPath, "branch.txt"), "utf8")).toBe("main");
  });

  test("rejects when the fetched branch cannot be checked out", async () => {
    const repoPath = createRepoWithOriginBranch("feature/in-use");
    const worktreePath = path.join(path.dirname(repoPath), "worktree");
    execFileSync("git", ["-C", repoPath, "branch", "feature/in-use", "origin/feature/in-use"]);
    execFileSync("git", ["-C", repoPath, "worktree", "add", worktreePath, "feature/in-use"], {
      stdio: "ignore",
    });

    await expect(checkoutSdkBranch(repoPath, "feature/in-use")).rejects.toThrow(
      "Unable to check out SDK branch 'feature/in-use'",
    );
  });

  test("rejects when the remote branch query fails", async () => {
    const missingRepoPath = path.join(os.tmpdir(), `missing-sdk-repo-${Date.now()}`);

    await expect(checkoutSdkBranch(missingRepoPath, "feature/test")).rejects.toThrow(
      "Unable to verify SDK branch 'feature/test' on origin. SDK validation stopped without falling back to 'main'. Check repository access and network connectivity, then retry the pipeline.",
    );
  });

  test("rejects when main branch normalization fails", async () => {
    const missingRepoPath = path.join(os.tmpdir(), `missing-sdk-repo-${Date.now()}`);

    await expect(checkoutMainBranch(missingRepoPath)).rejects.toThrow(
      "Unable to restore the SDK repository to 'main'. SDK validation stopped to prevent the next spec from using the wrong branch.",
    );
  });
});
