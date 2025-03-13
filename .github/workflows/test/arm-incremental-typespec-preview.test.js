import { describe, expect, it, vi } from "vitest";
import * as changedFiles from "../../src/changed-files.js";
import * as git from "../../src/git.js";
import {
  contosoReadme,
  swaggerHandWritten,
  swaggerTypeSpecGenerated,
} from "../../test/examples.js";
import { createMockCore } from "../../test/mocks.js";
import incrementalTypeSpec from "../src/arm-incremental-typespec-preview.js";

const core = createMockCore();

describe("incrementalTypeSpec", () => {
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

    const showSpy = vi.spyOn(git, "show").mockResolvedValue(swaggerHandWritten);

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);

    expect(showSpy).toBeCalledWith("HEAD", swaggerPath, expect.anything());
  });

  it("returns false if changed files add a new RP", async () => {
    const specDir =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso";
    const swaggerPath = `${specDir}/preview/2021-10-01-preview/contoso.json`;

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    const showSpy = vi
      .spyOn(git, "show")
      .mockResolvedValue(swaggerTypeSpecGenerated);

    // "git ls-tree" returns "" if the spec folder doesn't exist in the base branch
    const lsTreeSpy = vi.spyOn(git, "lsTree").mockResolvedValue("");

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);

    expect(showSpy).toBeCalledWith("HEAD", swaggerPath, expect.anything());

    expect(lsTreeSpy).toBeCalledWith(
      "HEAD^",
      specDir,
      expect.anything(),
      "-r --name-only",
    );
  });

  it("returns false if swagger deleted", async () => {
    const swaggerPath =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    const showSpy = vi
      .spyOn(git, "show")
      .mockRejectedValue(
        new Error("path contoso.json does not exist in 'HEAD'"),
      );

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);

    expect(showSpy).toBeCalledWith("HEAD", swaggerPath, expect.anything());
  });

  it("returns false if readme deleted", async () => {
    const readmePath =
      "specification/contosowidgetmanager/resource-manager/readme.md";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([readmePath]);

    const showSpy = vi
      .spyOn(git, "show")
      .mockRejectedValue(new Error("path readme.md does not exist in 'HEAD'"));

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);

    expect(showSpy).toBeCalledWith("HEAD", readmePath, expect.anything());
  });

  it("returns false if readme contains no input-files", async () => {
    const readmePath =
      "specification/contosowidgetmanager/resource-manager/readme.md";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([readmePath]);

    const showSpy = vi.spyOn(git, "show").mockResolvedValue("");

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);

    expect(showSpy).toBeCalledWith("HEAD", readmePath, expect.anything());
  });

  it("returns false if swagger cannot be parsed as JSON", async () => {
    const swaggerPath =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    const showSpy = vi
      .spyOn(git, "show")
      .mockResolvedValue("not } valid { json");

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);

    expect(showSpy).toBeCalledWith("HEAD", swaggerPath, expect.anything());
  });

  it("returns false if tsp conversion", async () => {
    const specDir =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso";
    const swaggerPath = `${specDir}/preview/2021-10-01-preview/contoso.json`;

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    const showSpy = vi
      .spyOn(git, "show")
      .mockImplementation((treeIsh) =>
        treeIsh == "HEAD" ? swaggerTypeSpecGenerated : swaggerHandWritten,
      );

    const lsTreeSpy = vi.spyOn(git, "lsTree").mockResolvedValue(swaggerPath);

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);

    expect(showSpy).toBeCalledWith("HEAD", swaggerPath, expect.anything());
    expect(showSpy).toBeCalledWith("HEAD^", swaggerPath, expect.anything());

    expect(lsTreeSpy).toBeCalledWith(
      "HEAD^",
      specDir,
      expect.anything(),
      "-r --name-only",
    );
  });

  it("throws if git show for swagger returns unknown error", async () => {
    const swaggerPath =
      "specification/contosowidgetmanager2/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    const showSpy = vi.spyOn(git, "show").mockRejectedValue("string error");

    await expect(incrementalTypeSpec({ core })).rejects.toThrowError();

    expect(showSpy).toBeCalledWith("HEAD", swaggerPath, expect.anything());
  });

  it("throws if git show for readme returns unknown error", async () => {
    const readmePath =
      "specification/contosowidgetmanager/resource-manager/readme.md";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([readmePath]);

    const showSpy = vi.spyOn(git, "show").mockRejectedValue("string error");

    await expect(incrementalTypeSpec({ core })).rejects.toThrowError();

    expect(showSpy).toBeCalledWith("HEAD", readmePath, expect.anything());
  });

  it("returns true if changed files are incremental changes to an existing TypeSpec RP swagger", async () => {
    const specDir =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso";
    const swaggerPath = `${specDir}/preview/2021-10-01-preview/contoso.json`;

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    const showSpy = vi
      .spyOn(git, "show")
      .mockResolvedValue(swaggerTypeSpecGenerated);

    const lsTreeSpy = vi.spyOn(git, "lsTree").mockResolvedValue(swaggerPath);

    await expect(incrementalTypeSpec({ core })).resolves.toBe(true);

    expect(showSpy).toBeCalledWith("HEAD", swaggerPath, expect.anything());
    expect(showSpy).toBeCalledWith("HEAD^", swaggerPath, expect.anything());

    expect(lsTreeSpy).toBeCalledWith(
      "HEAD^",
      specDir,
      expect.anything(),
      "-r --name-only",
    );
  });

  it("returns true if changed files are incremental changes to an existing TypeSpec RP readme", async () => {
    const specDir =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso";

    const swaggerPath = `${specDir}/preview/2021-10-01-preview/contoso.json`;

    const readmePath =
      "specification/contosowidgetmanager/resource-manager/readme.md";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([readmePath]);

    const showSpy = vi
      .spyOn(git, "show")
      .mockImplementation(async (_treeIsh, path, _core, _options) => {
        if (path === swaggerPath) {
          return swaggerTypeSpecGenerated;
        } else if (path === readmePath) {
          return contosoReadme;
        } else {
          throw new Error("does not exist");
        }
      });

    const lsTreeSpy = vi.spyOn(git, "lsTree").mockResolvedValue(swaggerPath);

    await expect(incrementalTypeSpec({ core })).resolves.toBe(true);

    expect(showSpy).toBeCalledWith("HEAD", readmePath, expect.anything());
    expect(showSpy).toBeCalledWith("HEAD^", swaggerPath, expect.anything());

    expect(lsTreeSpy).toHaveBeenCalledWith(
      "HEAD^",
      specDir,
      expect.anything(),
      "-r --name-only",
    );
  });

  it("returns true if changed files are incremental changes to an existing TypeSpec RP example", async () => {
    const specDir =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso";
    const swaggerPath = `${specDir}/preview/2021-10-01-preview/contoso.json`;
    const examplesPath =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([examplesPath]);

    const showSpy = vi
      .spyOn(git, "show")
      .mockResolvedValue(swaggerTypeSpecGenerated);

    const lsTreeSpy = vi.spyOn(git, "lsTree").mockResolvedValue(swaggerPath);

    await expect(incrementalTypeSpec({ core })).resolves.toBe(true);

    expect(showSpy).toBeCalledWith("HEAD^", swaggerPath, expect.anything());

    expect(lsTreeSpy).toHaveBeenCalledWith(
      "HEAD^",
      specDir,
      expect.anything(),
      "-r --name-only",
    );
  });
});
