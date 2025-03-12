import { describe, expect, it, vi } from "vitest";
import * as changedFiles from "../../src/changed-files.js";
import * as git from "../../src/git.js";
import { contosoReadme } from "../../test/examples.js";
import { createMockCore } from "../../test/mocks.js";
import incrementalTypeSpec from "../src/arm-incremental-typespec-preview.js";

// TODO: Verify args to all calls to spyOn to catch bugs like passing wrong paths

const core = createMockCore();

const swaggerHandWritten = JSON.stringify("foo");

const swaggerTypeSpecGenerated = JSON.stringify({
  info: {
    "x-typespec-generated": [{ emitter: "@azure-tools/typespec-autorest" }],
  },
});

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

    vi.spyOn(git, "show").mockResolvedValue(swaggerHandWritten);

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);
  });

  it("returns false if changed files add a new RP", async () => {
    const swaggerPath =
      "specification/contosowidgetmanager2/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    vi.spyOn(git, "show").mockResolvedValue(swaggerTypeSpecGenerated);

    // "git ls-tree" returns "" if the spec folder doesn't exist in the base branch
    vi.spyOn(git, "lsTree").mockResolvedValue("");

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);
  });

  it("returns false if swagger deleted", async () => {
    const swaggerPath =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    vi.spyOn(git, "show").mockRejectedValue(
      new Error("path contoso.json does not exist in 'HEAD'"),
    );

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);
  });

  it("returns false if swagger cannot be parsed as JSON", async () => {
    const swaggerPath =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    vi.spyOn(git, "show").mockResolvedValue("not } valid { json");

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);
  });

  it("returns false if tsp conversion", async () => {
    const swaggerPath =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    vi.spyOn(git, "show").mockImplementation((treeIsh) =>
      treeIsh == "HEAD" ? swaggerTypeSpecGenerated : swaggerHandWritten,
    );

    vi.spyOn(git, "lsTree").mockImplementation(
      async (_treeIsh, _path, _core, options) => {
        return options?.includes("-r --name-only")
          ? swaggerPath
          : "040000 tree abc123 specification/contosowidgetmanager";
      },
    );

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);
  });

  it("throws if git show returns unknown error", async () => {
    const swaggerPath =
      "specification/contosowidgetmanager2/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    vi.spyOn(git, "show").mockRejectedValue("string error");

    await expect(incrementalTypeSpec({ core })).rejects.toThrowError();
  });

  it("returns true if changed files are incremental changes to an existing TypeSpec RP swagger", async () => {
    const swaggerPath =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([swaggerPath]);

    vi.spyOn(git, "show").mockResolvedValue(swaggerTypeSpecGenerated);

    vi.spyOn(git, "lsTree").mockImplementation(
      async (_treeIsh, _path, _core, options) => {
        return options?.includes("-r --name-only")
          ? swaggerPath
          : "040000 tree abc123 specification/contosowidgetmanager";
      },
    );

    await expect(incrementalTypeSpec({ core })).resolves.toBe(true);
  });

  it("returns true if changed files are incremental changes to an existing TypeSpec RP readme", async () => {
    const specDir =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso";

    const swaggerPath = `${specDir}/preview/2021-10-01-preview/contoso.json`;

    const readmePath =
      "specification/contosowidgetmanager/resource-manager/readme.md";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([readmePath]);

    vi.spyOn(git, "show").mockImplementation(
      async (_treeIsh, path, _core, _options) => {
        if (path === swaggerPath) {
          return swaggerTypeSpecGenerated;
        } else if (path === readmePath) {
          return contosoReadme;
        } else {
          throw new Error("does not exist");
        }
      },
    );

    const lsTreeSpy = vi
      .spyOn(git, "lsTree")
      .mockImplementation(
        async (_treeIsh, _path, _core, _options) => swaggerPath,
      );

    await expect(incrementalTypeSpec({ core })).resolves.toBe(true);

    expect(lsTreeSpy).toHaveBeenCalledWith(
      "HEAD^",
      specDir,
      expect.anything(),
      "-r --name-only",
    );
  });

  it("returns true if changed files are incremental changes to an existing TypeSpec RP example", async () => {
    const swaggerPath =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    const examplesPath =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([examplesPath]);

    vi.spyOn(git, "show").mockImplementation(
      async (_treeIsh, path, _core, _options) => {
        if (path === swaggerPath) {
          return swaggerTypeSpecGenerated;
        } else {
          throw new Error("does not exist");
        }
      },
    );

    vi.spyOn(git, "lsTree").mockImplementation(
      async (_treeIsh, _path, _core, options) => {
        return options?.includes("-r --name-only")
          ? swaggerPath
          : "040000 tree abc123 specification/contosowidgetmanager";
      },
    );

    await expect(incrementalTypeSpec({ core })).resolves.toBe(true);
  });
});
