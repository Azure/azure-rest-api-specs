import { execFileSync, spawnSync } from "node:child_process";
import { existsSync } from "node:fs";
import { mkdir, mkdtemp, readFile, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { fileURLToPath } from "node:url";
import { afterEach, describe, expect, it } from "vitest";
import { prepareReleasePlanReplay } from "../prepare-release-plan-replay.ts";

const folders: string[] = [];

afterEach(async () => {
  await Promise.all(
    folders.splice(0).map((folder) => rm(folder, { recursive: true, force: true })),
  );
});

async function fixture() {
  const root = await mkdtemp(join(tmpdir(), "release-plan-replay-"));
  folders.push(root);
  const git = (...args: string[]) =>
    execFileSync(
      "git",
      [
        "-c",
        "user.name=Test",
        "-c",
        "user.email=test@example.test",
        "-c",
        "commit.gpgsign=false",
        ...args,
      ],
      { cwd: root, encoding: "utf8", stdio: ["ignore", "pipe", "pipe"] },
    ).trim();
  git("init", "--quiet", "--initial-branch=main");
  git("config", "core.autocrlf", "false");
  await mkdir(join(root, "specification", "service"), { recursive: true });
  await mkdir(join(root, "eng"));
  const version = join(root, "specification", "service", "version.json");
  const removed = join(root, "specification", "service", "removed.json");
  const added = join(root, "specification", "service", "added.json");
  const tooling = join(root, "eng", "tool.txt");
  await writeFile(version, "original version\n");
  await writeFile(removed, "original file\n");
  await writeFile(tooling, "old resolver\n");
  git("add", ".");
  git("commit", "--quiet", "-m", "Original spec");
  const original = git("rev-parse", "HEAD");
  await writeFile(version, "later version\n");
  await rm(removed);
  await writeFile(added, "later file\n");
  await writeFile(tooling, "fixed resolver\n");
  git("add", ".");
  git("commit", "--quiet", "-m", "Updated spec and fixed tooling");
  return {
    root,
    git,
    original,
    current: git("rev-parse", "HEAD"),
    version,
    tooling,
    added,
    removed,
  };
}

describe("historical release-plan replay", () => {
  it("restores the original spec tree but keeps the fixed tooling and checkout commit", async () => {
    const item = await fixture();
    prepareReleasePlanReplay(item.root, item.original);

    expect(await readFile(item.version, "utf8")).toBe("original version\n");
    expect(await readFile(item.removed, "utf8")).toBe("original file\n");
    expect(existsSync(item.added)).toBe(false);
    expect(await readFile(item.tooling, "utf8")).toBe("fixed resolver\n");
    expect(item.git("rev-parse", "HEAD")).toBe(item.current);
    expect(item.git("diff", item.original, "--", "specification")).toBe("");
    expect(item.git("diff", "--", "eng")).toBe("");
  });

  it.each(["", "refs/heads/main", "a".repeat(39), "a".repeat(40) + ";echo injected"])(
    "rejects an invalid explicit commit %j before changing files",
    async (commit) => {
      const item = await fixture();
      expect(() => prepareReleasePlanReplay(item.root, commit)).toThrow(/full 40-character/);
      expect(item.git("status", "--porcelain")).toBe("");
    },
  );

  it("rejects conflicting release-plan and historical-commit inputs", async () => {
    const item = await fixture();
    expect(() => prepareReleasePlanReplay(item.root, item.original, 123)).toThrow(/combined/);
    expect(item.git("status", "--porcelain")).toBe("");
  });

  it("does not overwrite existing specification changes", async () => {
    const item = await fixture();
    await writeFile(item.version, "local changes\n");
    expect(() => prepareReleasePlanReplay(item.root, item.original)).toThrow(/clean specification/);
    expect(await readFile(item.version, "utf8")).toBe("local changes\n");
  });

  it("does not discard untracked specification files", async () => {
    const item = await fixture();
    const untracked = join(item.root, "specification", "untracked.json");
    await writeFile(untracked, "local untracked file\n");
    expect(() => prepareReleasePlanReplay(item.root, item.original)).toThrow(/clean specification/);
    expect(await readFile(untracked, "utf8")).toBe("local untracked file\n");
  });

  it("refuses a commit outside the selected branch history", async () => {
    const item = await fixture();
    item.git("checkout", "--quiet", "-b", "unmerged", item.original);
    await writeFile(item.version, "unmerged version\n");
    item.git("add", ".");
    item.git("commit", "--quiet", "-m", "Unmerged spec");
    const unmerged = item.git("rev-parse", "HEAD");
    item.git("checkout", "--quiet", "main");

    expect(() => prepareReleasePlanReplay(item.root, unmerged)).toThrow(/branch history/);
    expect(item.git("status", "--porcelain")).toBe("");
  });

  it("runs with the pipeline's environment inputs without replacing the tooling revision", async () => {
    const item = await fixture();
    const script = fileURLToPath(new URL("../prepare-release-plan-replay.ts", import.meta.url));
    const child = spawnSync(process.execPath, [script], {
      cwd: item.root,
      encoding: "utf8",
      env: {
        ...process.env,
        RELEASE_PLAN_SPEC_COMMIT_SHA: item.original,
        RELEASE_PLAN_ID: "0",
      },
    });
    expect(child.status, child.stderr).toBe(0);
    expect(child.stdout).toContain(item.current);
    expect(child.stdout).toContain(item.original);
    expect(item.git("rev-parse", "HEAD")).toBe(item.current);
    expect(item.git("diff", item.original, "--", "specification")).toBe("");
  });
});
