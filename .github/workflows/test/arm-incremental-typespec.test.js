import { afterEach, describe, expect, it, vi } from "vitest";

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({
    raw: vi.fn().mockResolvedValue(""),
    show: vi.fn().mockResolvedValue(""),
  }),
}));

import * as simpleGit from "simple-git";
import * as changedFiles from "../../shared/src/changed-files.js";
import {
  contosoReadme,
  swaggerHandWritten,
  swaggerTypeSpecGenerated,
} from "../../shared/test/examples.js";
import incrementalTypeSpec from "../src/arm-incremental-typespec.js";
import { createMockCore } from "./mocks.js";

const core = createMockCore();

describe("incrementalTypeSpec", () => {
  afterEach(() => {
    vi.clearAllMocks();
  });

  it("rejects if inputs null", async () => {
    await expect(incrementalTypeSpec({})).rejects.toThrow();
  });

  it("returns false if no changed RM files", async () => {
    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([]);

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);
  });

  it("returns false if a changed file is not typespec-generated", async () => {
    const swaggerPath =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    const showSpy = vi
      .mocked(simpleGit.simpleGit().show)
      .mockResolvedValue(swaggerHandWritten);

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);

    expect(showSpy).toBeCalledWith([`HEAD:${swaggerPath}`]);
  });

  it("returns false if changed files add a new RP", async () => {
    const specDir =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso";
    const swaggerPath = `${specDir}/preview/2021-10-01-preview/contoso.json`;

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    const showSpy = vi
      .mocked(simpleGit.simpleGit().show)
      .mockResolvedValue(swaggerTypeSpecGenerated);

    // "git ls-tree" returns "" if the spec folder doesn't exist in the base branch
    const rawSpy = vi.mocked(simpleGit.simpleGit().raw).mockResolvedValue("");

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);

    expect(showSpy).toBeCalledWith([`HEAD:${swaggerPath}`]);

    expect(rawSpy).toBeCalledWith([
      "ls-tree",
      "-r",
      "--name-only",
      "HEAD^",
      specDir,
    ]);
  });

  it("returns false if swagger deleted", async () => {
    const swaggerPath =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    const showSpy = vi
      .mocked(simpleGit.simpleGit().show)
      .mockRejectedValue(
        new Error("path contoso.json does not exist in 'HEAD'"),
      );

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);

    expect(showSpy).toBeCalledWith([`HEAD:${swaggerPath}`]);
  });

  it("returns false if readme deleted", async () => {
    const readmePath =
      "specification/contosowidgetmanager/resource-manager/readme.md";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([readmePath]);

    const showSpy = vi
      .mocked(simpleGit.simpleGit().show)
      .mockRejectedValue(new Error("path readme.md does not exist in 'HEAD'"));

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);

    expect(showSpy).toBeCalledWith([`HEAD:${readmePath}`]);
  });

  it("returns false if readme contains no input-files", async () => {
    const readmePath =
      "specification/contosowidgetmanager/resource-manager/readme.md";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([readmePath]);

    const showSpy = vi.mocked(simpleGit.simpleGit().show).mockResolvedValue("");

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);

    expect(showSpy).toBeCalledWith([`HEAD:${readmePath}`]);
  });

  it("returns false if swagger cannot be parsed as JSON", async () => {
    const swaggerPath =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    const showSpy = vi
      .mocked(simpleGit.simpleGit().show)
      .mockResolvedValue("not } valid { json");

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);

    expect(showSpy).toBeCalledWith([`HEAD:${swaggerPath}`]);
  });

  it("returns false if tsp conversion", async () => {
    const specDir =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso";
    const swaggerPath = `${specDir}/preview/2021-10-01-preview/contoso.json`;

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    const showSpy = vi
      .mocked(simpleGit.simpleGit().show)
      .mockImplementation(async ([treePath]) =>
        treePath.split(":")[0] == "HEAD"
          ? swaggerTypeSpecGenerated
          : swaggerHandWritten,
      );

    const lsTreeSpy = vi
      .mocked(simpleGit.simpleGit().raw)
      .mockResolvedValue(swaggerPath);

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);

    expect(showSpy).toHaveBeenCalledWith([`HEAD:${swaggerPath}`]);
    expect(showSpy).toHaveBeenCalledWith([`HEAD^:${swaggerPath}`]);

    expect(lsTreeSpy).toBeCalledWith([
      "ls-tree",
      "-r",
      "--name-only",
      "HEAD^",
      specDir,
    ]);
  });

  it("throws if git show for swagger returns unknown error", async () => {
    const swaggerPath =
      "specification/contosowidgetmanager2/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    const showSpy = vi
      .mocked(simpleGit.simpleGit().show)
      .mockRejectedValue("string error");

    await expect(incrementalTypeSpec({ core })).rejects.toThrowError();

    expect(showSpy).toBeCalledWith([`HEAD:${swaggerPath}`]);
  });

  it("throws if git show for readme returns unknown error", async () => {
    const readmePath =
      "specification/contosowidgetmanager/resource-manager/readme.md";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([readmePath]);

    const showSpy = vi
      .mocked(simpleGit.simpleGit().show)
      .mockRejectedValue("string error");

    await expect(incrementalTypeSpec({ core })).rejects.toThrowError();

    expect(showSpy).toBeCalledWith([`HEAD:${readmePath}`]);
  });

  it("returns true if changed files are incremental changes to an existing TypeSpec RP swagger", async () => {
    const specDir =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso";
    const swaggerPath = `${specDir}/preview/2021-10-01-preview/contoso.json`;

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    const showSpy = vi
      .mocked(simpleGit.simpleGit().show)
      .mockResolvedValue(swaggerTypeSpecGenerated);

    const lsTreeSpy = vi
      .mocked(simpleGit.simpleGit().raw)
      .mockResolvedValue(swaggerPath);

    await expect(incrementalTypeSpec({ core })).resolves.toBe(true);

    expect(showSpy).toBeCalledWith([`HEAD:${swaggerPath}`]);
    expect(showSpy).toBeCalledWith([`HEAD^:${swaggerPath}`]);

    expect(lsTreeSpy).toBeCalledWith([
      "ls-tree",
      "-r",
      "--name-only",
      "HEAD^",
      specDir,
    ]);
  });

  it("returns true if changed files are incremental changes to an existing TypeSpec RP readme", async () => {
    const specDir =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso";

    const swaggerPath = `${specDir}/preview/2021-10-01-preview/contoso.json`;

    const readmePath =
      "specification/contosowidgetmanager/resource-manager/readme.md";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([readmePath]);

    const showSpy = vi
      .mocked(simpleGit.simpleGit().show)
      .mockImplementation(async ([treePath]) => {
        const path = treePath.split(":")[1];
        if (path === swaggerPath) {
          return swaggerTypeSpecGenerated;
        } else if (path === readmePath) {
          return contosoReadme;
        } else {
          throw new Error("does not exist");
        }
      });

    const lsTreeSpy = vi
      .mocked(simpleGit.simpleGit().raw)
      .mockResolvedValue(swaggerPath);

    await expect(incrementalTypeSpec({ core })).resolves.toBe(true);

    expect(showSpy).toBeCalledWith([`HEAD:${readmePath}`]);
    expect(showSpy).toBeCalledWith([`HEAD^:${swaggerPath}`]);

    expect(lsTreeSpy).toHaveBeenCalledWith([
      "ls-tree",
      "-r",
      "--name-only",
      "HEAD^",
      specDir,
    ]);
  });

  it("returns true if changed files are incremental changes to an existing TypeSpec RP example", async () => {
    const specDir =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso";
    const swaggerPath = `${specDir}/preview/2021-10-01-preview/contoso.json`;
    const examplesPath =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([examplesPath]);

    const showSpy = vi
      .mocked(simpleGit.simpleGit().show)
      .mockResolvedValue(swaggerTypeSpecGenerated);

    const lsTreeSpy = vi
      .mocked(simpleGit.simpleGit().raw)
      .mockResolvedValue(swaggerPath);

    await expect(incrementalTypeSpec({ core })).resolves.toBe(true);

    expect(showSpy).toBeCalledWith([`HEAD^:${swaggerPath}`]);

    expect(lsTreeSpy).toHaveBeenCalledWith([
      "ls-tree",
      "-r",
      "--name-only",
      "HEAD^",
      specDir,
    ]);
  });
});
