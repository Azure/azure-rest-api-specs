import { ConsoleLogger, defaultLogger } from "@azure-tools/specs-shared/logger";
import { mkdir, mkdtemp, readFile, realpath, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, resolve } from "pathe";
import { stripVTControlCharacters } from "node:util";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it, vi } from "vitest";
import { gitDiffTopSpecFolder } from "../src/utils.ts";

let root: string;
let folder: string;
beforeEach(async () => {
  root = resolve(await realpath(await mkdtemp(join(tmpdir(), "tsv-generated-"))));
  await writeFile(join(root, ".gitattributes"), "* text=auto eol=lf\n");
  folder = join(root, "specification/service/Project");
  await mkdir(folder, { recursive: true });
  await mkdir(join(root, "specification/service/Sibling"));
  await writeFile(join(folder, "main.tsp"), "original");
  await writeFile(join(root, "unrelated.txt"), "original");
  await simpleGit(root)
    .init()
    .addConfig("user.name", "Test")
    .addConfig("user.email", "test@example.com")
    .addConfig("commit.gpgsign", "false")
    .add(".")
    .commit("Fixture");
});
afterEach(async () => {
  vi.restoreAllMocks();
  vi.unstubAllEnvs();
  await rm(root, { recursive: true, force: true });
});

it.each([false, true])(
  "returns only the service's staged, unstaged and untracked diffs with verbose=%s",
  async (verbose) => {
    await writeFile(join(folder, "main.tsp"), "modified");
    await writeFile(join(folder, "staged.json"), "staged");
    await simpleGit(root).add("specification/service/Project/staged.json");
    await writeFile(join(root, "specification/service/Sibling/output.json"), "{}");
    await writeFile(join(root, "unrelated.txt"), "outside the service");
    const logger = new ConsoleLogger(verbose);
    const debug = vi.spyOn(logger, "debug").mockImplementation(() => {});
    const result = await gitDiffTopSpecFolder(folder, logger);
    expect(result.success).toBe(false);
    expect(result.files.sort()).toEqual([
      "specification/service/Project/main.tsp",
      "specification/service/Project/staged.json",
      "specification/service/Sibling/output.json",
    ]);
    const diff = stripVTControlCharacters(result.diff ?? "");
    expect(diff).toContain("diff --git");
    expect(diff).toContain("+modified");
    expect(diff).toContain("+staged");
    expect(diff).toContain("+{}");
    expect(diff).not.toContain("unrelated.txt");
    const traces = debug.mock.calls.flat().join("\n");
    expect(traces).not.toContain("diff --git");
    expect(traces).not.toContain("unrelated.txt");
    expect(traces.includes('"modified":')).toBe(verbose);
    expect(await readFile(join(folder, "main.tsp"), "utf8")).toBe("modified");
  },
);

it("limits the check to files matching globs relative to the service folder", async () => {
  await mkdir(join(root, "specification/service/Shared"));
  await writeFile(join(folder, "main.tsp"), "modified");
  await writeFile(join(folder, "tspconfig.yaml"), "new");
  await writeFile(join(folder, "output.json"), "{}");
  await writeFile(join(root, "specification/service/Shared/models.tsp"), "new");

  const result = await gitDiffTopSpecFolder(folder, defaultLogger, [
    "**/*.tsp",
    "**/tspconfig.yaml",
  ]);
  expect(result.files.sort()).toEqual([
    "specification/service/Project/main.tsp",
    "specification/service/Project/tspconfig.yaml",
    "specification/service/Shared/models.tsp",
  ]);
  expect(result.diff).not.toContain("output.json");

  await simpleGit(root).raw(["checkout", "--", "."]);
  await rm(join(folder, "tspconfig.yaml"));
  await rm(join(root, "specification/service/Shared"), { recursive: true });
  expect(await gitDiffTopSpecFolder(folder, defaultLogger, ["**/*.tsp"])).toEqual({
    success: true,
    files: [],
  });
});

it("does not fail on changes outside the service or dump a clean repository", async () => {
  await writeFile(join(root, "unrelated.txt"), "keep");
  const logger = new ConsoleLogger(true);
  const debug = vi.spyOn(logger, "debug").mockImplementation(() => {});
  expect(await gitDiffTopSpecFolder(folder, logger)).toEqual({ success: true, files: [] });
  expect(debug).toHaveBeenCalledTimes(1);
});

it.each([false, true])("applies TSV's color setting to Git output (color=%s)", async (color) => {
  vi.stubEnv("NO_COLOR", color ? undefined : "1");
  vi.stubEnv("FORCE_COLOR", "1");
  await simpleGit(root).addConfig("color.ui", "always");
  await writeFile(join(folder, "main.tsp"), "modified");
  await writeFile(join(root, "specification/service/Sibling/output.json"), "{}");

  const result = await gitDiffTopSpecFolder(folder, defaultLogger);
  const diff = result.diff ?? "";
  expect(stripVTControlCharacters(diff)).toContain("+modified");
  expect(stripVTControlCharacters(diff)).toContain("+{}");
  expect(diff.includes("\x1b")).toBe(color);
});
