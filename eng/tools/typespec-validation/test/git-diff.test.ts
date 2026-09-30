import { ConsoleLogger, defaultLogger } from "@azure-tools/specs-shared/logger";
import { mkdir, mkdtemp, rename, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { stripVTControlCharacters } from "node:util";
import { simpleGit, type SimpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it, vi } from "vitest";
import { gitDiffTopSpecFolder } from "../src/utils.ts";

let root: string;
let folder: string;
let git: SimpleGit;
const project = "specification/foo/Foo";

beforeEach(async () => {
  vi.stubEnv("NO_COLOR", "1");
  root = await mkdtemp(join(tmpdir(), "tsv-git-diff-"));
  folder = join(root, project);
  await mkdir(folder, { recursive: true });
  await writeFile(join(folder, "generated.json"), "original\n");
  await writeFile(join(folder, "removed.json"), "removed\n");
  await writeFile(join(folder, "old-name.json"), "renamed\n");
  await writeFile(join(root, "unrelated.json"), "unrelated\n");
  git = simpleGit(root, {
    config: [
      "user.name=TSV Tests",
      "user.email=tsv@example.test",
      "commit.gpgsign=false",
      "core.autocrlf=false",
    ],
  });
  await git.init();
  await git.add(".");
  await git.commit("Initial files");
});

afterEach(async () => {
  vi.restoreAllMocks();
  vi.unstubAllEnvs();
  await rm(root, { recursive: true, force: true });
});

it("ignores changes outside the service folder", async () => {
  await writeFile(join(root, "unrelated.json"), "changed\n");
  await expect(gitDiffTopSpecFolder(folder, defaultLogger)).resolves.toEqual({
    success: true,
    files: [],
  });
});

it("lists modified, staged, renamed, deleted and untracked files across the service", async () => {
  await writeFile(join(folder, "generated.json"), "changed\n");
  await rm(join(folder, "removed.json"));
  await rename(join(folder, "old-name.json"), join(folder, "new-name.json"));
  await writeFile(join(folder, "staged.json"), "staged\n");
  await git.add([`${project}/old-name.json`, `${project}/new-name.json`, `${project}/staged.json`]);
  const sibling = join(root, "specification/foo/Sibling");
  await mkdir(sibling);
  await writeFile(join(sibling, "first.json"), "untracked\n");
  await writeFile(join(sibling, "second file.json"), "untracked\n");
  await writeFile(join(root, "unrelated.json"), "changed\n");

  const result = await gitDiffTopSpecFolder(folder, defaultLogger);

  expect(result.success).toBe(false);
  expect(result.files.sort()).toEqual(
    [
      `${project}/generated.json`,
      `${project}/new-name.json`,
      `${project}/removed.json`,
      `${project}/staged.json`,
      "specification/foo/Sibling/first.json",
      "specification/foo/Sibling/second file.json",
    ].sort(),
  );
  expect(result.diff).toContain("-original\n+changed");
  expect(result.diff).toContain("-removed");
  expect(result.diff).toContain(`rename to ${project}/new-name.json`);
  expect(result.diff).toContain("+staged");
  expect(result.diff).toContain("b/specification/foo/Sibling/first.json");
  expect(result.diff).toContain("b/specification/foo/Sibling/second file.json");
  expect(result.diff?.match(/\+untracked/g)).toHaveLength(2);
  expect(result.diff).not.toContain("unrelated.json");
});

it.each([false, true])("shows only the service diff with verbose=%s", async (verbose) => {
  await writeFile(join(folder, "generated.json"), "changed\n");
  await writeFile(join(root, "unrelated.json"), "changed\n");
  const debug = vi.spyOn(console, "debug").mockImplementation(() => {});

  const result = await gitDiffTopSpecFolder(folder, new ConsoleLogger(verbose));

  expect(result.diff).toContain(`diff --git a/${project}/generated.json`);
  expect(result.diff).not.toContain("unrelated.json");
  const output = debug.mock.calls.flat().join("\n");
  expect(output).not.toContain("diff --git");
  expect(output).not.toContain("unrelated.json");
  if (!verbose) expect(debug).not.toHaveBeenCalled();
});

it.each([
  [{ NO_COLOR: undefined, FORCE_COLOR: "1" }, true],
  [{ NO_COLOR: "", FORCE_COLOR: "1" }, false],
  [{ NO_COLOR: undefined, FORCE_COLOR: "0" }, false],
  [{ NO_COLOR: undefined, FORCE_COLOR: undefined, GITHUB_ACTIONS: "true" }, true],
])("respects TSV color controls for Git diffs with env=%j", async (env, colored) => {
  for (const [name, value] of Object.entries(env)) vi.stubEnv(name, value);
  await git.addConfig("color.ui", "always");
  await git.addConfig("color.diff.old", "red");
  await git.addConfig("color.diff.new", "green");
  await writeFile(join(folder, "generated.json"), "changed\n");
  await writeFile(join(folder, "new.json"), "added\n");

  const result = await gitDiffTopSpecFolder(folder, defaultLogger);
  expect(result.diff).toBeDefined();
  const diff = result.diff!;
  expect(stripVTControlCharacters(diff)).toContain("-original\n+changed");
  expect(stripVTControlCharacters(diff)).toContain("+added");
  if (colored) {
    expect(diff).toContain("\x1b[31m");
    expect(diff).toContain("\x1b[32m");
  } else {
    expect(diff).not.toContain("\x1b");
  }
});
