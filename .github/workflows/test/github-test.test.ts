import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import importAllModules from "../src/github-test.ts";
import { createMockCore } from "./mocks.ts";

let workspace: string;

beforeEach(async () => {
  workspace = await mkdtemp(join(tmpdir(), "github-import-profile-"));
  vi.stubEnv("GITHUB_WORKSPACE", workspace);
  await Promise.all(
    [".github/shared/src", ".github/workflows/src", ".github/typespec-import-parser/src"].map(
      (directory) => mkdir(join(workspace, directory), { recursive: true }),
    ),
  );
  await writeFile(join(workspace, ".github/shared/src/helper.ts"), "export const value = 1;\n");
  await writeFile(
    join(workspace, ".github/workflows/src/workflow.ts"),
    "export const value = 2;\n",
  );
  await writeFile(
    join(workspace, ".github/typespec-import-parser/src/index.ts"),
    'throw new Error("TypeSpec compiler dependency is missing");\n',
  );
});

afterEach(async () => {
  vi.unstubAllEnvs();
  await rm(workspace, { recursive: true, force: true });
});

describe("workflow production imports", () => {
  it("imports common automation without loading the TypeSpec parser", async () => {
    await expect(importAllModules({ core: createMockCore() })).resolves.toBeUndefined();
  });

  it("surfaces import failures in the explicitly selected parser package", async () => {
    await expect(
      importAllModules({ core: createMockCore() }, [".github/typespec-import-parser/src"]),
    ).rejects.toThrow("TypeSpec compiler dependency is missing");
  });
});
