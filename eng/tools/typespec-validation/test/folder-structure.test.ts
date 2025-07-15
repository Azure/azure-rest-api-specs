import { mockAll, mockFolder } from "./mocks.js";
mockAll();

import { contosoTspConfig } from "@azure-tools/specs-shared/test/examples";
import * as globby from "globby";
import { strict as assert } from "node:assert";
import { afterEach, beforeEach, describe, it, MockInstance, vi } from "vitest";
import { FolderStructureRule } from "../src/rules/folder-structure.js";

import * as utils from "../src/utils.js";

describe("folder-structure", function () {
  let fileExistsSpy: MockInstance;
  let normalizePathSpy: MockInstance;
  let readTspConfigSpy: MockInstance;

  beforeEach(() => {
    fileExistsSpy = vi.spyOn(utils, "fileExists").mockResolvedValue(true);
    normalizePathSpy = vi.spyOn(utils, "normalizePath");
    readTspConfigSpy = vi.spyOn(utils, "readTspConfig").mockResolvedValue(contosoTspConfig);
  });

  afterEach(() => {
    vi.clearAllMocks();
  });

  it("should fail if folder doesn't exist", async function () {
    fileExistsSpy.mockResolvedValue(false);

    const result = await new FolderStructureRule().execute(mockFolder);
    assert(result.errorOutput);
    assert(result.errorOutput.includes("does not exist"));
  });

  it("should fail if tspconfig has incorrect extension", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yml"];
    });

    const result = await new FolderStructureRule().execute(mockFolder);
    assert(result.errorOutput);
    assert(result.errorOutput.includes("Invalid config file"));
  });

  it("should fail if folder under specification/ is capitalized", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute("/gitroot/specification/Foo/Foo");
    assert(result.errorOutput);
    assert(result.errorOutput.includes("must be lower case"));
  });

  it("should succeed if package folder has trailing slash", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo/Foo/");
    assert(result.success);
  });

  it("should fail if package folder is more than 3 levels deep", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/Foo/Foo/Foo",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("3 levels or less"));
  });

  it("should fail if second level folder not capitalized at after each '.' ", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo.foo");
    assert(result.errorOutput);
    assert(result.errorOutput.includes("must be capitalized"));
  });

  it("should fail if second level folder is data-plane", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute("/gitroot/specification/foo/data-plane");
    assert(result.errorOutput);
    assert(result.errorOutput.includes("does not match regex"));
  });

  it("should fail if second level folder is resource-manager", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/resource-manager",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("does not match regex"));
  });

  it("should fail if Shared does not follow Management ", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/Foo.Management.Foo.Shared",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("should follow"));
  });

  it("should fail if folder doesn't contain main.tsp nor client.tsp", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    fileExistsSpy.mockImplementation(async (file: string) => {
      if (file.includes("main.tsp")) {
        return false;
      } else if (file.includes("client.tsp")) {
        return false;
      }
      return true;
    });

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/Foo.Management",
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes("must contain"));
  });

  it("should fail if folder doesn't contain examples when main.tsp exists", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    fileExistsSpy.mockImplementation(async (file: string) => {
      if (file.includes("main.tsp")) {
        return true;
      } else if (file.includes("examples")) {
        return false;
      }
      return true;
    });

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/Foo.Management",
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes("must contain"));
  });

  it("should fail if non-shared folder doesn't contain tspconfig", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    fileExistsSpy.mockImplementation(async (file: string) => {
      if (file.includes("tspconfig.yaml")) {
        return false;
      }
      return true;
    });

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/Foo.Management",
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes("must contain"));
  });

  it("should succeed with resource-manager/Management", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/Foo.Management/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");
    readTspConfigSpy.mockImplementation(
      async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "resource-manager"
`,
    );

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/Foo.Management",
    );

    assert(result.success);
  });

  it("should succeed with data-plane/NoManagement", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/Foo/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");
    readTspConfigSpy.mockImplementation(
      async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
`,
    );

    const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

    assert(result.success);
  });

  it("should fail with resource-manager/NoManagement", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/Foo/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");
    readTspConfigSpy.mockImplementation(
      async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "resource-manager"
`,
    );

    const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

    assert(result.errorOutput);
    assert(result.errorOutput.includes(".Management"));
  });

  it("should fail with data-plane/Management", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/Foo.Management/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");
    readTspConfigSpy.mockImplementation(
      async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
`,
    );

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/Foo.Management",
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes(".Management"));
  });

  it("v2: should fail if no tspconfig.yaml", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["main.tsp"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    fileExistsSpy.mockImplementation(async (file: string) => {
      if (file.includes("tspconfig.yaml")) {
        return false;
      }
      return true;
    });

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/data-plane/Foo",
    );

    assert(result.errorOutput?.includes("must contain"));
  });

  it("v2: should fail if incorrect folder depth", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    let result = await new FolderStructureRule().execute("/gitroot/specification/foo/data-plane");
    assert(result.errorOutput?.includes("level under"));

    result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/data-plane/Foo/too-deep",
    );
    assert(result.errorOutput?.includes("level under"));

    result = await new FolderStructureRule().execute("/gitroot/specification/foo/resource-manager");
    assert(result.errorOutput?.includes("levels under"));

    result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/resource-manager/RP.Namespace",
    );
    assert(result.errorOutput?.includes("levels under"));

    result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/resource-manager/RP.Namespace/FooManagement/too-deep",
    );
    assert(result.errorOutput?.includes("levels under"));
  });

  it("v2: should succeed with data-plane", async function () {
    vi.mocked(globby.globby).mockImplementation(async (patterns) => {
      return patterns[0].includes("tspconfig") ? ["tspconfig.yaml"] : ["main.tsp"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/data-plane/Foo",
    );

    assert(result.success);
  });

  it("v2: should succeed with resource-manager", async function () {
    vi.mocked(globby.globby).mockImplementation(async (patterns) => {
      return patterns[0].includes("tspconfig") ? ["tspconfig.yaml"] : ["main.tsp"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/resource-manager/Microsoft.Foo/FooManagement",
    );

    assert(result.success);
  });
});
