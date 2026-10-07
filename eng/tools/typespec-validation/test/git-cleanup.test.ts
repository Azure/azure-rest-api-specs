import { ConsoleLogger, debugLogger } from "@azure-tools/specs-shared/logger";
import { execFileSync } from "node:child_process";
import {
  existsSync,
  mkdirSync,
  mkdtempSync,
  readFileSync,
  rmSync,
  symlinkSync,
  writeFileSync,
} from "node:fs";
import { tmpdir } from "node:os";
import { dirname, join } from "pathe";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { z } from "zod";
import { cleanWorktree } from "../src/git-cleanup.ts";

vi.mock("simple-git", { spy: true });

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
  return vi.mocked(console.debug).mock.calls.map(([line]) => {
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
  vi.spyOn(console, "debug").mockImplementation(() => {});
});

afterEach(() => {
  vi.restoreAllMocks();
  rmSync(repo, { recursive: true, force: true });
});

describe("cleanWorktree", () => {
  it("runs only one status query for a clean checkout", async () => {
    const client = simpleGit(repo);
    const restore = vi.spyOn(client, "raw");
    const clean = vi.spyOn(client, "clean");
    vi.mocked(simpleGit).mockReturnValueOnce(client);

    await cleanWorktree(repo, debugLogger);

    expect(commands()).toEqual(["status"]);
    expect(restore).not.toHaveBeenCalled();
    expect(clean).not.toHaveBeenCalled();
  });

  it("finds generated files even when Git config hides untracked files", async () => {
    git("config", "status.showUntrackedFiles", "no");
    write("generated.txt");

    await cleanWorktree(repo, debugLogger);

    expect(existsSync(join(repo, "generated.txt"))).toBe(false);
    expect(status()).toBe("");
  });

  it("restores modified and deleted files and cleans output across the repository", async () => {
    write("project/source.txt", "modified");
    rmSync(join(repo, "outside"), { recursive: true });
    write("project/generated.txt");
    write("other/generated [1]/output.txt");
    write("other/generated [1]/keep.ignored", "keep");
    write("node_modules/dependency/index.js", "keep");

    await cleanWorktree(repo, debugLogger);

    expect(readFileSync(join(repo, "project/source.txt"), "utf8")).toBe("original");
    expect(readFileSync(join(repo, "outside/deleted.txt"), "utf8")).toBe("deleted original");
    expect(existsSync(join(repo, "project/generated.txt"))).toBe(false);
    expect(existsSync(join(repo, "other/generated [1]/output.txt"))).toBe(false);
    expect(readFileSync(join(repo, "other/generated [1]/keep.ignored"), "utf8")).toBe("keep");
    expect(readFileSync(join(repo, "node_modules/dependency/index.js"), "utf8")).toBe("keep");
    expect(status()).toBe("");
    expect(commands()).toEqual(["status", "restore", "clean", "status"]);
  });

  it("handles filenames with spaces, brackets, Unicode, and leading dashes", async () => {
    const paths = ["space name", "[abc]", "-option", "caf\u00e9"];
    for (const path of paths) write(path, "original");
    write("a", "neighbor");
    commit();
    for (const path of paths) write(path, "modified");
    for (const path of paths) write(`generated/${path}`);

    await cleanWorktree(repo, debugLogger);

    for (const path of paths) {
      expect(readFileSync(join(repo, path), "utf8")).toBe("original");
    }
    expect(readFileSync(join(repo, "a"), "utf8")).toBe("neighbor");
    expect(status()).toBe("");
  });

  it.skipIf(process.platform === "win32")(
    "handles filenames with newlines, quotes, whitespace, and pathspec magic",
    async () => {
      const paths = ["line\nbreak", 'a"quote', ":(glob)*", "*literal", " leading", "trailing \n"];
      for (const path of paths) write(path, "original");
      commit();
      for (const path of paths) write(path, "modified");
      for (const path of paths) write(`${path}-generated`);

      await cleanWorktree(repo, debugLogger);

      for (const path of paths) {
        expect(readFileSync(join(repo, path), "utf8")).toBe("original");
      }
      expect(status()).toBe("");
    },
  );

  it("restores from the index but stops if validation leaves staged changes", async () => {
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

    await expect(cleanWorktree(repo, debugLogger)).rejects.toThrow(
      "Git cleanup left a dirty checkout",
    );

    expect(git("ls-files", "--stage")).toBe(index);
    expect(status()).toBe(stagedStatus);
    expect(readFileSync(join(repo, "project/renamed.txt"), "utf8")).toBe("staged content");
    expect(readFileSync(join(repo, "added.txt"), "utf8")).toBe("staged addition");
    expect(existsSync(join(repo, "outside/deleted.txt"))).toBe(false);
  });

  it("does not report a clean checkout when only staged changes remain", async () => {
    write("project/source.txt", "staged");
    git("add", ".");
    const stagedStatus = status();

    await expect(cleanWorktree(repo, debugLogger)).rejects.toThrow(
      "Git cleanup left a dirty checkout",
    );

    expect(status()).toBe(stagedStatus);
    expect(commands()).toEqual(["status", "restore", "clean", "status"]);
  });

  it("treats an unstaged rename as a deletion and an untracked file", async () => {
    write("project/renamed.txt", "original");
    rmSync(join(repo, "project/source.txt"));

    await cleanWorktree(repo, debugLogger);

    expect(readFileSync(join(repo, "project/source.txt"), "utf8")).toBe("original");
    expect(existsSync(join(repo, "project/renamed.txt"))).toBe(false);
    expect(status()).toBe("");
  });

  it.skipIf(process.platform === "win32")("restores file/symlink type changes", async () => {
    rmSync(join(repo, "project/source.txt"));
    symlinkSync("../outside/deleted.txt", join(repo, "project/source.txt"));

    await cleanWorktree(repo, debugLogger);

    expect(readFileSync(join(repo, "project/source.txt"), "utf8")).toBe("original");
    expect(readFileSync(join(repo, "outside/deleted.txt"), "utf8")).toBe("deleted original");
    expect(status()).toBe("");
  });

  it("restores a tracked file replaced by a generated directory", async () => {
    rmSync(join(repo, "project/source.txt"));
    write("project/source.txt/generated.txt");

    await cleanWorktree(repo, debugLogger);

    expect(readFileSync(join(repo, "project/source.txt"), "utf8")).toBe("original");
    expect(status()).toBe("");
  });

  it("restores a tracked directory replaced by a file", async () => {
    rmSync(join(repo, "outside"), { recursive: true });
    write("outside", "generated");

    await cleanWorktree(repo, debugLogger);

    expect(readFileSync(join(repo, "outside/deleted.txt"), "utf8")).toBe("deleted original");
    expect(status()).toBe("");
  });

  it("restores changed ignore rules before cleaning generated files", async () => {
    write(".gitignore", "hidden.txt\n");
    write("project/hidden.txt");

    await cleanWorktree(repo, debugLogger);

    expect(readFileSync(join(repo, ".gitignore"), "utf8")).toBe("node_modules/\n*.ignored\n");
    expect(existsSync(join(repo, "project/hidden.txt"))).toBe(false);
    expect(status()).toBe("");
  });

  it("rejects conflicts before restoring other files", async () => {
    const hash = git("rev-parse", "HEAD:project/source.txt").trim();
    git("update-index", "--force-remove", "project/source.txt");
    execFileSync("git", ["update-index", "--index-info"], {
      cwd: repo,
      input: `100644 ${hash} 1\tproject/source.txt\n100644 ${hash} 2\tproject/source.txt\n100644 ${hash} 3\tproject/source.txt\n`,
    });
    write("outside/deleted.txt", "modified");
    const before = status();

    await expect(cleanWorktree(repo, debugLogger)).rejects.toThrow("unmerged");

    expect(status()).toBe(before);
    expect(readFileSync(join(repo, "outside/deleted.txt"), "utf8")).toBe("modified");
    expect(commands()).toEqual(["status", "restore"]);
  });

  it.each(["nested", "generated/nested"])(
    "protects and reports a nested repository at %s",
    async (path) => {
      write(`${path}/file.txt`);
      git("init", "--quiet", join(repo, path));

      await expect(cleanWorktree(repo, debugLogger)).rejects.toThrow(
        "Git cleanup left a dirty checkout",
      );

      expect(existsSync(join(repo, path, ".git"))).toBe(true);
      expect(existsSync(join(repo, path, "file.txt"))).toBe(true);
    },
  );

  it("ignores nested repositories under ignored dependencies", async () => {
    write("node_modules/nested/file.txt");
    git("init", "--quiet", join(repo, "node_modules/nested"));
    write("generated/file.txt");

    await cleanWorktree(repo, debugLogger);

    expect(existsSync(join(repo, "node_modules/nested/.git"))).toBe(true);
    expect(status()).toBe("");
  });

  it("stops on dirty submodules even when status config ignores them", async () => {
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

    await expect(cleanWorktree(repo, debugLogger)).rejects.toThrow(
      "Git cleanup left a dirty checkout",
    );

    expect(readFileSync(join(repo, "submodule/file.txt"), "utf8")).toBe("modified");
    expect(commands()).toEqual(["status", "restore", "clean", "status"]);
  });

  it("cleans many changed files without constructing path argument lists", async () => {
    for (let i = 0; i < 120; i++) write(`project/${i}-${"x".repeat(100)}`, "original");
    commit();
    for (let i = 0; i < 120; i++) {
      write(`project/${i}-${"x".repeat(100)}`, "modified");
      write(`project/${i}-${"y".repeat(100)}`);
    }

    await cleanWorktree(repo, debugLogger);

    expect(status()).toBe("");
    expect(commands()).toEqual(["status", "restore", "clean", "status"]);
  });

  it.each(["status", "raw", "clean"] as const)("propagates %s failures", async (method) => {
    write("project/source.txt", "modified");
    write("generated.txt");
    const client = simpleGit(repo);
    const command = method === "raw" ? "restore" : method;
    vi.spyOn(client, method).mockRejectedValueOnce(new Error(`${command} failed`));
    vi.mocked(simpleGit).mockReturnValueOnce(client);

    await expect(cleanWorktree(repo, debugLogger)).rejects.toThrow(`${command} failed`);

    expect(commands().at(-1)).toBe(command);
    expect(console.debug).toHaveBeenLastCalledWith(expect.stringContaining('"success":false'));
  });

  it("propagates failures while verifying cleanup", async () => {
    write("generated.txt");
    const client = simpleGit(repo);
    const getStatus = client.status.bind(client);
    vi.spyOn(client, "status")
      .mockImplementationOnce(getStatus)
      .mockRejectedValueOnce(new Error("verification failed"));
    vi.mocked(simpleGit).mockReturnValueOnce(client);

    await expect(cleanWorktree(repo, debugLogger)).rejects.toThrow("verification failed");

    expect(commands()).toEqual(["status", "restore", "clean", "status"]);
    expect(console.debug).toHaveBeenLastCalledWith(expect.stringContaining('"success":false'));
  });

  it("cleans without timing output when debug logging is disabled", async () => {
    write("generated.txt");

    await cleanWorktree(repo, new ConsoleLogger());

    expect(status()).toBe("");
    expect(console.debug).not.toHaveBeenCalled();
  });
});
