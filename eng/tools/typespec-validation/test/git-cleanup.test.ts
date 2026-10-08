import { debugLogger } from "@azure-tools/specs-shared/logger";
import { execFileSync } from "node:child_process";
import { existsSync, mkdirSync, mkdtempSync, rmSync, writeFileSync } from "node:fs";
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
  write("project/source.txt", "original");
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
    const getStatus = vi.spyOn(client, "status");
    const restore = vi.spyOn(client, "raw");
    const clean = vi.spyOn(client, "clean");
    vi.mocked(simpleGit).mockReturnValueOnce(client);

    await cleanWorktree(repo, debugLogger);

    expect(commands()).toEqual(["status"]);
    expect(getStatus).toHaveBeenCalledExactlyOnceWith([
      "--untracked-files=normal",
      "--ignore-submodules=none",
    ]);
    expect(restore).not.toHaveBeenCalled();
    expect(clean).not.toHaveBeenCalled();
  });

  it("finds generated files even when Git config hides untracked files", async () => {
    git("config", "status.showUntrackedFiles", "no");
    write("generated.txt");

    await cleanWorktree(repo, debugLogger);

    expect(existsSync(join(repo, "generated.txt"))).toBe(false);
    expect(status()).toBe("");
    expect(commands()).toEqual(["status", "restore", "clean", "status"]);
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
});
