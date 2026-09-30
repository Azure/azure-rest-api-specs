import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import { mkdir, mkdtemp, readFile, realpath, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { stripVTControlCharacters } from "node:util";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it, vi } from "vitest";
import { gitDiffTopSpecFolder } from "../src/utils.ts";

let root: string;
let folder: string;
beforeEach(async () => {
  root = await realpath(await mkdtemp(join(tmpdir(), "tsv-generated-")));
  folder = join(root, "specification/service/Project");
  await mkdir(folder, { recursive: true });
  await mkdir(join(root, "specification/service/Sibling"));
  await writeFile(join(folder, "main.tsp"), "original");
  await simpleGit(root)
    .init()
    .addConfig("user.name", "Test")
    .addConfig("user.email", "test@example.com")
    .addConfig("commit.gpgsign", "false")
    .add(".")
    .commit("Fixture");
});
afterEach(async () => {
  await rm(root, { recursive: true, force: true });
});

it.each([false, true])(
  "checks the entire service and returns diffs with verbose=%s",
  async (verbose) => {
    await writeFile(join(folder, "main.tsp"), "modified");
    await writeFile(join(root, "specification/service/Sibling/output.json"), "{}");
    await writeFile(join(root, "unrelated.txt"), "outside the service");
    const logger = new ConsoleLogger(verbose);
    const debug = vi.spyOn(logger, "debug").mockImplementation(() => {});
    const result = await gitDiffTopSpecFolder(folder, logger);
    expect(result.success).toBe(false);
    expect(result.files.sort()).toEqual([
      "specification/service/Project/main.tsp",
      "specification/service/Sibling/output.json",
    ]);
    const diff = stripVTControlCharacters(result.diff ?? "");
    expect(diff).toContain("diff --git");
    expect(diff).toContain("+modified");
    expect(diff).toContain("+{}");
    const traces = debug.mock.calls.flat().join("\n");
    expect(traces).not.toContain("diff --git");
    expect(traces.includes('"modified":')).toBe(verbose);
    expect(await readFile(join(folder, "main.tsp"), "utf8")).toBe("modified");
  },
);

it("does not fail on changes outside the service or dump a clean repository", async () => {
  await writeFile(join(root, "unrelated.txt"), "keep");
  const logger = new ConsoleLogger(true);
  const debug = vi.spyOn(logger, "debug").mockImplementation(() => {});
  expect(await gitDiffTopSpecFolder(folder, logger)).toEqual({ success: true, files: [] });
  expect(debug).toHaveBeenCalledTimes(1);
});
