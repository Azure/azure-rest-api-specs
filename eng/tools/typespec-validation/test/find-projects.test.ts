import { getChangedFiles } from "@azure-tools/specs-shared/changed-files";
import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { afterEach, beforeEach, expect, it, vi } from "vitest";
import { findChangedProjects } from "../src/find-projects.ts";

vi.mock("@azure-tools/specs-shared/changed-files", () => ({
  getChangedFiles: vi.fn(),
}));

let root: string;
const revisions = { baseCommitish: "base", headCommitish: "head" };

async function addProject(path: string, config = "tspconfig.yaml") {
  const folder = join(root, path);
  await mkdir(folder, { recursive: true });
  await writeFile(join(folder, config), "");
  return folder;
}

beforeEach(async () => {
  root = await mkdtemp(join(tmpdir(), "tsv-find-projects-"));
  vi.mocked(getChangedFiles).mockReset().mockResolvedValue([]);
  vi.spyOn(console, "log").mockImplementation(() => {});
});

afterEach(async () => {
  vi.restoreAllMocks();
  await rm(root, { recursive: true, force: true });
});

it("searches affected services recursively, deduplicates, and sorts projects", async () => {
  const parent = await addProject("specification/service/Project");
  const child = await addProject("specification/service/Project/Nested");
  const last = await addProject("specification/service/ProjectZ", "tspconfig.yml");
  await addProject("specification/service/Project/node_modules/ignored");
  await addProject("specification/unaffected/Other");
  vi.mocked(getChangedFiles).mockResolvedValue([
    "specification/service/readme.md",
    "specification/service/Project/main.tsp",
    "specification/service/Project/client.tsp",
    "specification/service/Project/Nested/tspconfig.yaml",
    "documentation/readme.md",
  ]);

  await expect(findChangedProjects(root, revisions)).resolves.toEqual({
    projects: [parent, child, last],
    checkingAllSpecs: false,
  });
  expect(getChangedFiles).toHaveBeenCalledWith({
    cwd: root,
    gitConfig: ["core.quotepath=false"],
    ...revisions,
    logger: expect.anything() as unknown,
  });
});

it("selects sibling and ancestor projects when only a nested model changes", async () => {
  const parent = await addProject("specification/service/Project");
  const nested = await addProject("specification/service/Project/models/Nested");
  const sibling = await addProject("specification/service/Sibling");
  vi.mocked(getChangedFiles).mockResolvedValue(["specification/service/Project/models/model.tsp"]);

  await expect(findChangedProjects(root, revisions)).resolves.toEqual({
    projects: [parent, nested, sibling],
    checkingAllSpecs: false,
  });
});

it("includes deleted files whose service survives and reports deleted service folders", async () => {
  const existing = await addProject("specification/service/Existing");
  vi.mocked(getChangedFiles).mockResolvedValue([
    "specification/service/Existing/deleted.tsp",
    "specification/removed/Project/main.tsp",
    "specification/removed/Project/tspconfig.yaml",
  ]);

  await expect(findChangedProjects(root, revisions)).resolves.toEqual({
    projects: [existing],
    checkingAllSpecs: false,
  });
  expect(console.log).toHaveBeenCalledExactlyOnceWith(
    "Cannot find directory specification/removed",
  );
});

it.each([
  ".gitattributes",
  ".oxfmtrc.json",
  ".prettierrc.json",
  "pnpm-lock.yaml",
  "pnpm-workspace.yaml",
  "package.json",
  "tsconfig.json",
  "specification/suppressions.yaml",
  "specification/common-types/resource-management/v6/types.json",
  ".github/workflows/typespec-validation.yaml",
  ".github/shared/src/changed-files.ts",
  ".github/arm-leases-other/lease.yaml",
  "eng/tools/typespec-validation/src/index.ts",
  "eng/scripts/Get-TypeSpec-Folders.ps1",
])("validates all projects when %s changes", async (file) => {
  const first = await addProject("specification/first/Project");
  const second = await addProject("specification/second/Project");
  vi.mocked(getChangedFiles).mockResolvedValue([file]);

  await expect(findChangedProjects(root, revisions)).resolves.toEqual({
    projects: [first, second],
    checkingAllSpecs: true,
  });
});

it.each([
  ".github/arm-leases/service/lease.yaml",
  "eng/common/scripts/common.ps1",
  "eng/scripts/ChangedFiles-Functions.ps1",
  "eng/scripts/Tests/ChangedFiles-Functions.Tests.ps1",
  "documentation/README.md",
  "specification/README.md",
  "specification-other/service/main.tsp",
])("does not trigger all-spec validation for %s", async (file) => {
  await addProject("specification/service/Project");
  vi.mocked(getChangedFiles).mockResolvedValue([file]);

  await expect(findChangedProjects(root, revisions)).resolves.toEqual({
    projects: [],
    checkingAllSpecs: false,
  });
});

it("ignores core-file changes without dropping scoped spec changes", async () => {
  const first = await addProject("specification/first/Project");
  await addProject("specification/second/Project");
  vi.mocked(getChangedFiles).mockResolvedValue([
    "package.json",
    ".github/arm-leases/service/lease.yaml",
    "specification/first/Project/main.tsp",
  ]);

  await expect(findChangedProjects(root, { ...revisions, ignoreCoreFiles: true })).resolves.toEqual(
    {
      projects: [first],
      checkingAllSpecs: false,
    },
  );
});

it("returns an empty selection when no files changed", async () => {
  await expect(findChangedProjects(root, revisions)).resolves.toEqual({
    projects: [],
    checkingAllSpecs: false,
  });
});

it("does not turn Git failures into an empty successful selection", async () => {
  const error = new Error("Invalid base commit");
  vi.mocked(getChangedFiles).mockRejectedValue(error);
  await expect(findChangedProjects(root, revisions)).rejects.toBe(error);
});
