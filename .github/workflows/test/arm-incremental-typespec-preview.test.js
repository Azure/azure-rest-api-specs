import { vol } from "memfs";
import { join } from "path";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { createMockCore } from "../../test/mocks.js";
import incrementalTypeSpec from "../src/arm-incremental-typespec-preview.js";
import * as changedFiles from "../src/changed-files.js";
import * as git from "../src/git.js";

vi.mock("fs/promises", async () => {
  const memfs = await import("memfs");
  return {
    ...memfs.fs.promises,
  };
});

const core = createMockCore();

const swaggerTypeSpecGenerated = JSON.stringify({
  info: {
    "x-typespec-generated": [{ emitter: "@azure-tools/typespec-autorest" }],
  },
});

describe("incrementalTypeSpec", () => {
  beforeEach(() => {
    // TODO: Reset other global mocks like "core"
    vol.reset();
  });

  it("rejects if inputs null", async () => {
    await expect(incrementalTypeSpec({})).rejects.toThrow();
  });

  it("returns false if no changed RM files", async () => {
    vi.spyOn(
      changedFiles,
      "getChangedResourceManagerSwaggerFiles",
    ).mockResolvedValue([]);

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);
  });

  it("returns false if a changed file is not typespec-generated", async () => {
    const swaggerPath =
      "/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(
      changedFiles,
      "getChangedResourceManagerSwaggerFiles",
    ).mockResolvedValue([swaggerPath]);

    vol.fromJSON({
      [join(process.env.GITHUB_WORKSPACE || "", swaggerPath)]: '"foo"',
    });

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);
  });

  it("returns false if changed files add a new RP", async () => {
    const swaggerPath =
      "/specification/contosowidgetmanager2/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(
      changedFiles,
      "getChangedResourceManagerSwaggerFiles",
    ).mockResolvedValue([swaggerPath]);

    vol.fromJSON({
      [join(process.env.GITHUB_WORKSPACE || "", swaggerPath)]:
        swaggerTypeSpecGenerated,
    });

    // "git ls-tree" returns "" if the spec folder doesn't exist in the base branch
    vi.spyOn(git, "lsTree").mockResolvedValue("");

    await expect(incrementalTypeSpec({ core })).resolves.toBe(false);
  });

  it("returns true if changed files are incremental changes to an existing TypeSpec RP", async () => {
    const swaggerPath =
      "/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(
      changedFiles,
      "getChangedResourceManagerSwaggerFiles",
    ).mockResolvedValue([swaggerPath]);

    vol.fromJSON({
      [join(process.env.GITHUB_WORKSPACE || "", swaggerPath)]:
        swaggerTypeSpecGenerated,
    });

    vi.spyOn(git, "lsTree").mockImplementation(
      async (_treeIsh, _path, _core, options) => {
        return options?.includes("-r --name-only")
          ? swaggerPath.substring(1)
          : "040000 tree abc123 specification/contosowidgetmanager";
      },
    );

    vi.spyOn(git, "show").mockImplementation(async (_treeIsh, _path, _core) => {
      return swaggerTypeSpecGenerated;
    });

    await expect(incrementalTypeSpec({ core })).resolves.toBe(true);
  });
});
