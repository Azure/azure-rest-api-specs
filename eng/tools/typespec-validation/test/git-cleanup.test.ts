import * as exec from "@azure-tools/specs-shared/exec";
import { execFileSync, spawnSync } from "node:child_process";
import {
  copyFileSync,
  existsSync,
  mkdirSync,
  mkdtempSync,
  readFileSync,
  rmSync,
  symlinkSync,
  writeFileSync,
} from "node:fs";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { pathToFileURL } from "node:url";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { z } from "zod";
import { cleanWorktree } from "../src/git-cleanup.ts";

let repo: string;

function git(...args: string[]): string {
  return execFileSync("git", args, { cwd: repo, encoding: "utf8" });
}

function write(path: string, content = "generated"): void {
  const absolute = join(repo, path);
  mkdirSync(dirname(absolute), { recursive: true });
  writeFileSync(absolute, content);
}

function commit(): void {
  git("add", ".");
  git("commit", "--quiet", "-m", "fixture");
}

function status(): string {
  return git("status", "--porcelain=v1", "--untracked-files=all");
}

function commands(): string[] {
  return vi.mocked(console.log).mock.calls.map(([line]) => {
    const timing = z
      .object({ command: z.string(), durationMs: z.number().nonnegative(), success: z.boolean() })
      .parse(JSON.parse(String(line).slice("TSV cleanup ".length)));
    return timing.command;
  });
}

beforeEach(() => {
  repo = mkdtempSync(join(tmpdir(), "tsv-cleanup-"));
  git("init", "--quiet");
  git("config", "user.name", "Test");
  git("config", "user.email", "test@example.com");
  git("config", "commit.gpgsign", "false");
  git("config", "core.autocrlf", "false");
  write(".gitignore", "node_modules/\n*.ignored\n");
  write("project/source.txt", "original");
  write("outside/deleted.txt", "deleted original");
  commit();
  vi.spyOn(console, "log").mockImplementation(() => {});
});

afterEach(() => {
  vi.restoreAllMocks();
  rmSync(repo, { recursive: true, force: true });
});

describe("cleanWorktree", () => {
  it("runs only one status query for a clean checkout", async () => {
    await cleanWorktree(repo);
    expect(commands()).toEqual(["status"]);
  });

  it("runs the Node entrypoint against the supplied repository, independently of cwd", () => {
    write("project/source.txt", "modified");
    write("outside/generated.txt");
    const result = spawnSync(
      process.execPath,
      [resolve(import.meta.dirname, "../src/git-cleanup.ts"), repo],
      { cwd: tmpdir(), encoding: "utf8" },
    );

    expect(result.stderr).toBe("");
    expect(result.status).toBe(0);
    expect(result.stdout).toContain('TSV cleanup {"command":"status"');
    expect(status()).toBe("");
  });

  it("requires an explicit repository for the Node entrypoint", () => {
    const result = spawnSync(
      process.execPath,
      [resolve(import.meta.dirname, "../src/git-cleanup.ts")],
      { cwd: repo, encoding: "utf8" },
    );

    expect(result.status).not.toBe(0);
    expect(result.stderr).toContain("Usage: node git-cleanup.ts <repository-root>");
  });

  it("restores modified and deleted files and cleans output across the repository", async () => {
    write("project/source.txt", "modified");
    rmSync(join(repo, "outside"), { recursive: true });
    write("project/generated.txt");
    write("other/generated [1]/output.txt");
    write("other/generated [1]/keep.ignored", "keep");
    write("node_modules/dependency/index.js", "keep");

    await cleanWorktree(repo);

    expect(readFileSync(join(repo, "project/source.txt"), "utf8")).toBe("original");
    expect(readFileSync(join(repo, "outside/deleted.txt"), "utf8")).toBe("deleted original");
    expect(existsSync(join(repo, "project/generated.txt"))).toBe(false);
    expect(existsSync(join(repo, "other/generated [1]/output.txt"))).toBe(false);
    expect(readFileSync(join(repo, "other/generated [1]/keep.ignored"), "utf8")).toBe("keep");
    expect(readFileSync(join(repo, "node_modules/dependency/index.js"), "utf8")).toBe("keep");
    expect(status()).toBe("");
    expect(commands()).toEqual(["status", "restore", "clean", "ls-files"]);
  });

  it("uses literal paths for spaces, brackets, Unicode, and leading dashes", async () => {
    const paths = ["space name", "[abc]", "-option", "caf\u00e9"];
    for (const path of paths) write(path, "original");
    write("a", "neighbor");
    commit();
    for (const path of paths) write(path, "modified");
    for (const path of paths) write(`generated/${path}`);

    await cleanWorktree(repo);

    for (const path of paths) {
      expect(readFileSync(join(repo, path), "utf8")).toBe("original");
    }
    expect(readFileSync(join(repo, "a"), "utf8")).toBe("neighbor");
    expect(status()).toBe("");
  });

  it.skipIf(process.platform === "win32")(
    "preserves NUL-delimited paths with newlines, quotes, and pathspec magic",
    async () => {
      const paths = ["line\nbreak", 'a"quote', ":(glob)*", "*literal"];
      for (const path of paths) write(path, "original");
      commit();
      for (const path of paths) write(path, "modified");
      for (const path of paths) write(`${path}-generated`);

      await cleanWorktree(repo);

      for (const path of paths) {
        expect(readFileSync(join(repo, path), "utf8")).toBe("original");
      }
      expect(status()).toBe("");
    },
  );

  it("restores the index version while preserving staged additions, deletions, and renames", async () => {
    write("project/source.txt", "staged content");
    write("added.txt", "staged addition");
    git("rm", "--quiet", "outside/deleted.txt");
    git("mv", "project/source.txt", "project/renamed.txt");
    git("add", ".");
    const index = git("ls-files", "--stage");
    const stagedStatus = status();
    write("project/renamed.txt", "unstaged edit");
    rmSync(join(repo, "added.txt"));
    write("outside/deleted.txt", "recreated after staged deletion");

    await cleanWorktree(repo);

    expect(git("ls-files", "--stage")).toBe(index);
    expect(status()).toBe(stagedStatus);
    expect(readFileSync(join(repo, "project/renamed.txt"), "utf8")).toBe("staged content");
    expect(readFileSync(join(repo, "added.txt"), "utf8")).toBe("staged addition");
    expect(existsSync(join(repo, "outside/deleted.txt"))).toBe(false);
  });

  it("skips restore and clean for staged-only changes", async () => {
    write("project/source.txt", "staged");
    git("add", ".");
    const stagedStatus = status();

    await cleanWorktree(repo);

    expect(status()).toBe(stagedStatus);
    expect(commands()).toEqual(["status"]);
  });

  it("treats an unstaged rename as a deletion and an untracked file", async () => {
    write("project/renamed.txt", "original");
    rmSync(join(repo, "project/source.txt"));

    await cleanWorktree(repo);

    expect(readFileSync(join(repo, "project/source.txt"), "utf8")).toBe("original");
    expect(existsSync(join(repo, "project/renamed.txt"))).toBe(false);
    expect(status()).toBe("");
  });

  it.skipIf(process.platform === "win32")("restores file/symlink type changes", async () => {
    rmSync(join(repo, "project/source.txt"));
    symlinkSync("../outside/deleted.txt", join(repo, "project/source.txt"));

    await cleanWorktree(repo);

    expect(readFileSync(join(repo, "project/source.txt"), "utf8")).toBe("original");
    expect(readFileSync(join(repo, "outside/deleted.txt"), "utf8")).toBe("deleted original");
    expect(status()).toBe("");
  });

  it("rejects a directory replacing a tracked file without deleting its contents", async () => {
    rmSync(join(repo, "project/source.txt"));
    write("project/source.txt/keep.ignored", "keep");

    await expect(cleanWorktree(repo)).rejects.toThrow("tracked file replaced by a directory");

    expect(readFileSync(join(repo, "project/source.txt/keep.ignored"), "utf8")).toBe("keep");
    expect(commands()).toEqual(["status"]);
  });

  it("restores a tracked directory replaced by a file", async () => {
    rmSync(join(repo, "outside"), { recursive: true });
    write("outside", "generated");

    await cleanWorktree(repo);

    expect(readFileSync(join(repo, "outside/deleted.txt"), "utf8")).toBe("deleted original");
    expect(status()).toBe("");
  });

  it.each([".gitignore", "project/.gitignore", "project/.GITIGNORE"])(
    "rejects changed ignore rules at %s that could hide generated output",
    async (path) => {
      write(path, "hidden.txt\n");
      write("project/hidden.txt");

      await expect(cleanWorktree(repo)).rejects.toThrow("changed .gitignore files");

      expect(existsSync(join(repo, "project/hidden.txt"))).toBe(true);
      expect(commands()).toEqual(["status"]);
    },
  );

  it("rejects conflicts before restoring other files", async () => {
    const hash = git("rev-parse", "HEAD:project/source.txt").trim();
    git("update-index", "--force-remove", "project/source.txt");
    execFileSync("git", ["update-index", "--index-info"], {
      cwd: repo,
      input: `100644 ${hash} 1\tproject/source.txt\n100644 ${hash} 2\tproject/source.txt\n100644 ${hash} 3\tproject/source.txt\n`,
    });
    write("outside/deleted.txt", "modified");
    const before = status();

    await expect(cleanWorktree(repo)).rejects.toThrow("Unsafe Git cleanup state");

    expect(status()).toBe(before);
    expect(readFileSync(join(repo, "outside/deleted.txt"), "utf8")).toBe("modified");
    expect(commands()).toEqual(["status"]);
  });

  it("rejects intent-to-add instead of silently dropping an unexpected status", async () => {
    write("intent.txt");
    git("add", "-N", "intent.txt");

    await expect(cleanWorktree(repo)).rejects.toThrow("Unsafe Git cleanup state");

    expect(existsSync(join(repo, "intent.txt"))).toBe(true);
    expect(commands()).toEqual(["status"]);
  });

  it.each(["nested", "generated/nested"])(
    "protects and reports a nested repository at %s",
    async (path) => {
      write(`${path}/file.txt`);
      git("init", "--quiet", join(repo, path));

      await expect(cleanWorktree(repo)).rejects.toThrow("Git cleanup left untracked paths");

      expect(existsSync(join(repo, path, ".git"))).toBe(true);
      expect(existsSync(join(repo, path, "file.txt"))).toBe(true);
    },
  );

  it("ignores nested repositories under ignored dependencies", async () => {
    write("node_modules/nested/file.txt");
    git("init", "--quiet", join(repo, "node_modules/nested"));
    write("generated/file.txt");

    await cleanWorktree(repo);

    expect(existsSync(join(repo, "node_modules/nested/.git"))).toBe(true);
    expect(status()).toBe("");
  });

  it("rejects dirty submodules even when status config ignores them", async () => {
    write("submodule/file.txt");
    git("init", "--quiet", join(repo, "submodule"));
    git("-C", "submodule", "add", ".");
    git(
      "-C",
      "submodule",
      "-c",
      "user.name=Test",
      "-c",
      "user.email=test@example.com",
      "-c",
      "commit.gpgsign=false",
      "commit",
      "--quiet",
      "-m",
      "submodule",
    );
    const hash = git("-C", "submodule", "rev-parse", "HEAD").trim();
    git("update-index", "--add", "--cacheinfo", `160000,${hash},submodule`);
    git("commit", "--quiet", "-m", "gitlink");
    git("config", "diff.ignoreSubmodules", "all");
    write("submodule/file.txt", "modified");

    await expect(cleanWorktree(repo)).rejects.toThrow("Unsafe Git cleanup state");

    expect(readFileSync(join(repo, "submodule/file.txt"), "utf8")).toBe("modified");
    expect(commands()).toEqual(["status"]);
  });

  it("batches long path lists without falling back to full-tree cleanup", async () => {
    for (let i = 0; i < 120; i++) write(`project/${i}-${"x".repeat(100)}`, "original");
    commit();
    for (let i = 0; i < 120; i++) {
      write(`project/${i}-${"x".repeat(100)}`, "modified");
      write(`project/${i}-${"y".repeat(100)}`);
    }

    await cleanWorktree(repo);

    expect(status()).toBe("");
    expect(commands().filter((command) => command === "status")).toHaveLength(1);
    expect(commands().filter((command) => command === "restore").length).toBeGreaterThan(1);
    expect(commands().filter((command) => command === "clean").length).toBeGreaterThan(1);
  });

  it.each(["status", "restore", "clean", "ls-files"])("propagates %s failures", async (command) => {
    write("project/source.txt", "modified");
    write("generated.txt");
    const original = exec.execFile;
    vi.spyOn(exec, "execFile").mockImplementation(async (file, args, options) => {
      if (args?.[1] === command) throw new Error(`${command} failed`);
      return original(file, args, options);
    });

    await expect(cleanWorktree(repo)).rejects.toThrow(`${command} failed`);

    expect(commands().at(-1)).toBe(command);
    expect(console.log).toHaveBeenLastCalledWith(expect.stringContaining('"success":false'));
  });
});

describe("PowerShell validation cleanup", () => {
  beforeEach(() => {
    const sourceRoot = resolve(import.meta.dirname, "../../../..");
    write("eng/scripts/Suppressions-Functions.ps1", "");
    write("eng/scripts/Array-Functions.ps1", "");
    write("eng/scripts/Get-TypeSpec-Folders.ps1", 'return @(@("first", "second"), $false)');
    write(
      "eng/common/scripts/logging.ps1",
      `
function LogGroupStart($message) { Write-Host "Group: $message" }
function LogGroupEnd { Write-Host "End group" }
function LogInfo($message) { Write-Host $message }
function LogError($message) { Write-Host "Error: $message" }
function LogJobFailure { Write-Host "Job failed" }
`,
    );
    copyFileSync(
      join(sourceRoot, "eng/scripts/TypeSpec-Validation.ps1"),
      join(repo, "eng/scripts/TypeSpec-Validation.ps1"),
    );
    const cleanupUrl = pathToFileURL(resolve(import.meta.dirname, "../src/git-cleanup.ts")).href;
    write(
      "eng/tools/typespec-validation/src/git-cleanup.ts",
      `
const { cleanWorktree } = await import(${JSON.stringify(cleanupUrl)});
await cleanWorktree(process.argv[2]);
`,
    );
  });

  function run(...args: string[]) {
    return spawnSync(
      "pwsh",
      ["-NoProfile", "-File", "eng/scripts/TypeSpec-Validation.ps1", ...args],
      {
        cwd: repo,
        encoding: "utf8",
      },
    );
  }

  it("cleans between projects without hiding validation failures", () => {
    write(
      "eng/tools/typespec-validation/cmd/tsv.js",
      `
const fs = require("node:fs");
console.log("Running " + process.argv[2]);
if (fs.readFileSync("project/source.txt", "utf8") !== "original") {
  throw new Error("Previous project contaminated checkout");
}
fs.writeFileSync("project/source.txt", "modified");
fs.writeFileSync("outside/generated.txt", "generated");
process.exitCode = process.argv[2] === "first" ? 1 : 0;
`,
    );
    commit();

    const result = run("-GitClean");

    expect(result.stdout + result.stderr).not.toContain("Previous project contaminated checkout");
    expect(result.stdout).toContain("Running second");
    expect(result.stdout).toContain("TypeSpec Validation failed for project first");
    expect(result.stdout).toContain("TSV validation (process and output drain):");
    expect(result.stdout.match(/TSV cleanup {"command":"status"/g)).toHaveLength(2);
    expect(result.status).toBe(1);
    expect(status()).toBe("");
  });

  it("stops the project loop after a cleanup failure", () => {
    write(
      "eng/tools/typespec-validation/cmd/tsv.js",
      `
const fs = require("node:fs");
const { execFileSync } = require("node:child_process");
console.log("Running " + process.argv[2]);
fs.mkdirSync("nested");
execFileSync("git", ["init", "--quiet", "nested"]);
`,
    );
    commit();

    const result = run("-GitClean");

    expect(result.stdout).toContain("Git cleanup failed after first");
    expect(result.stdout).not.toContain("Running second");
    expect(result.status).toBe(1);
    expect(existsSync(join(repo, "nested/.git"))).toBe(true);
  });

  it("does not clean when GitClean is disabled or DryRun is enabled", () => {
    write("eng/tools/typespec-validation/cmd/tsv.js", 'console.log("Running " + process.argv[2]);');
    commit();
    write("generated.txt");

    for (const args of [[], ["-GitClean", "-DryRun"]]) {
      const result = run(...args);
      expect(result.status).toBe(0);
      expect(result.stdout).not.toContain("TSV cleanup");
      expect(existsSync(join(repo, "generated.txt"))).toBe(true);
    }
  });
});
