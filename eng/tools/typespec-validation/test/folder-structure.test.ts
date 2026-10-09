import { defaultLogger } from "@azure-tools/specs-shared/logger";
import { diagnosticText } from "./diagnostics.ts";
import { mockFolder } from "./mocks.ts";

import { contosoTspConfig } from "@azure-tools/specs-shared/test/examples";
import { strict as assert } from "node:assert";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, describe, it, type MockInstance, vi } from "vitest";
import * as nativeGlob from "../src/glob.ts";
import { FolderStructureRule } from "../src/rules/folder-structure.ts";

import * as utils from "../src/utils.ts";

describe("folder-structure", function () {
  let fileExistsSpy: MockInstance;
  let gitRootSpy: MockInstance;
  let readTspConfigSpy: MockInstance;

  beforeEach(() => {
    fileExistsSpy = vi.spyOn(utils, "fileExists").mockResolvedValue(true);
    gitRootSpy = vi.spyOn(simpleGit(), "revparse").mockResolvedValue("");
    readTspConfigSpy = vi.spyOn(utils, "readTspConfig").mockResolvedValue(contosoTspConfig);
  });

  afterEach(() => {
    vi.clearAllMocks();
  });

  describe("v1", function () {
    beforeEach(() => {
      vi.spyOn(utils, "getSuppressions").mockResolvedValue([
        {
          tool: "TypeSpecValidation",
          paths: ["**"],
          reason: "many tests use fsv1",
          rules: ["FolderStructure"],
          subRules: ["MustUseV2"],
        },
      ]);
    });

    it("should have suppressable flag set to true", function () {
      assert.equal(new FolderStructureRule().suppressable, true);
    });

    it("should not suppress when suppression targets a different rule", async function () {
      vi.spyOn(utils, "getSuppressions").mockResolvedValue([
        {
          tool: "TypeSpecValidation",
          paths: ["."],
          reason: "test other reason",
          rules: ["OtherRule"],
        },
      ]);
      fileExistsSpy.mockResolvedValue(false);

      const result = await new FolderStructureRule().execute(mockFolder, defaultLogger);
      assert(!result.success);
    });

    it("should fail if folder doesn't exist", async function () {
      fileExistsSpy.mockResolvedValue(false);

      const result = await new FolderStructureRule().execute(mockFolder, defaultLogger);
      assert(diagnosticText(result));
      assert(diagnosticText(result).includes("does not exist"));
    });

    it("should fail if tspconfig has incorrect extension", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/bar/tspconfig.yml"]),
      );

      const result = await new FolderStructureRule().execute(mockFolder, defaultLogger);
      assert(diagnosticText(result));
      assert(diagnosticText(result).includes("Invalid config file"));
    });

    it("should fail if folder under specification/ is capitalized", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/bar/tspconfig.yaml"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/Foo/Foo",
        defaultLogger,
      );
      assert(diagnosticText(result));
      assert(diagnosticText(result).includes("must be lower case"));
    });

    it("should succeed if package folder has trailing slash", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/bar/tspconfig.yaml"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/Foo/Foo/",
        defaultLogger,
      );
      assert(result.success);
    });

    it("should fail if package folder is more than 3 levels deep", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/bar/tspconfig.yaml"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/Foo/Foo/Foo",
        defaultLogger,
      );
      assert(diagnosticText(result));
      assert(diagnosticText(result).includes("3 levels or less"));
    });

    it("should fail if second level folder not capitalized at after each '.' ", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/bar/tspconfig.yaml"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/Foo.foo",
        defaultLogger,
      );
      assert(diagnosticText(result));
      assert(diagnosticText(result).includes("must be capitalized"));
    });

    it("should fail if second level folder is data-plane", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/bar/tspconfig.yaml"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/data-plane",
        defaultLogger,
      );
      assert(diagnosticText(result));
      assert(diagnosticText(result).includes("does not match regex"));
    });

    it("should fail if second level folder is resource-manager", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/bar/tspconfig.yaml"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/resource-manager",
        defaultLogger,
      );
      assert(diagnosticText(result));
      assert(diagnosticText(result).includes("does not match regex"));
    });

    it("should fail if Shared does not follow Management ", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/bar/tspconfig.yaml"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/Foo.Management.Foo.Shared",
        defaultLogger,
      );
      assert(diagnosticText(result));
      assert(diagnosticText(result).includes("should follow"));
    });

    it("should fail if folder doesn't contain main.tsp nor client.tsp", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/bar/tspconfig.yaml"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");

      fileExistsSpy.mockImplementation((file: string) => {
        if (file.includes("main.tsp")) {
          return Promise.resolve(false);
        } else if (file.includes("client.tsp")) {
          return Promise.resolve(false);
        }
        return Promise.resolve(true);
      });

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/Foo.Management",
        defaultLogger,
      );

      assert(diagnosticText(result));
      assert(diagnosticText(result).includes("must contain"));
    });

    it("should fail if folder doesn't contain examples when main.tsp exists", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/bar/tspconfig.yaml"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");

      fileExistsSpy.mockImplementation((file: string) => {
        if (file.includes("main.tsp")) {
          return Promise.resolve(true);
        } else if (file.includes("examples")) {
          return Promise.resolve(false);
        }
        return Promise.resolve(true);
      });

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/Foo.Management",
        defaultLogger,
      );

      assert(diagnosticText(result));
      assert(diagnosticText(result).includes("must contain"));
    });

    it("should fail if non-shared folder doesn't contain tspconfig", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/bar/tspconfig.yaml"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");

      fileExistsSpy.mockImplementation((file: string) => {
        if (file.includes("tspconfig.yaml")) {
          return Promise.resolve(false);
        }
        return Promise.resolve(true);
      });

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/Foo.Management",
        defaultLogger,
      );

      assert(diagnosticText(result));
      assert(diagnosticText(result).includes("must contain"));
    });

    it("should succeed with resource-manager/Management", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/Foo.Management/tspconfig.yaml"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");
      readTspConfigSpy.mockImplementation(() =>
        Promise.resolve(`
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "resource-manager"
`),
      );

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/Foo.Management",
        defaultLogger,
      );

      assert(result.success);
    });

    it("should succeed with data-plane/NoManagement", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/Foo/tspconfig.yaml"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");
      readTspConfigSpy.mockImplementation(() =>
        Promise.resolve(`
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
`),
      );

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/Foo",
        defaultLogger,
      );

      assert(result.success);
    });

    it("should fail with resource-manager/NoManagement", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/Foo/tspconfig.yaml"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");
      readTspConfigSpy.mockImplementation(() =>
        Promise.resolve(`
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "resource-manager"
`),
      );

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/Foo",
        defaultLogger,
      );

      assert(diagnosticText(result));
      assert(diagnosticText(result).includes(".Management"));
    });

    it("should fail with data-plane/Management", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
        Promise.resolve(["/foo/Foo.Management/tspconfig.yaml"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");
      readTspConfigSpy.mockImplementation(() =>
        Promise.resolve(`
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
`),
      );

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/Foo.Management",
        defaultLogger,
      );

      assert(diagnosticText(result));
      assert(diagnosticText(result).includes(".Management"));
    });

    it("should fail if MustUseV2 not suppressed", async function () {
      vi.spyOn(utils, "getSuppressions").mockResolvedValue([]);

      const result = await new FolderStructureRule().execute(mockFolder, defaultLogger);
      assert(diagnosticText(result));
      assert(diagnosticText(result).includes('must use "folder structure v2'));
    });
  });

  describe("v2", () => {
    it("should fail if no tspconfig.yaml", async function () {
      vi.spyOn(utils, "getSuppressions").mockResolvedValue([]);

      vi.mocked(nativeGlob.globFiles).mockImplementation(() => Promise.resolve(["main.tsp"]));
      gitRootSpy.mockResolvedValue("/gitroot");

      fileExistsSpy.mockImplementation((file: string) => {
        if (file.includes("tspconfig.yaml")) {
          return Promise.resolve(false);
        }
        return Promise.resolve(true);
      });

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/data-plane/Foo",
        defaultLogger,
      );

      assert(diagnosticText(result)?.includes("must contain"));
    });

    it("should fail if incorrect folder depth", async function () {
      vi.spyOn(utils, "getSuppressions").mockResolvedValue([]);

      vi.mocked(nativeGlob.globFiles).mockImplementation(() => Promise.resolve(["tspconfig.yaml"]));
      gitRootSpy.mockResolvedValue("/gitroot");

      let result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/data-plane",
        defaultLogger,
      );
      assert(diagnosticText(result)?.includes("level under"));

      result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/data-plane/Foo/too-deep",
        defaultLogger,
      );
      assert(diagnosticText(result)?.includes("level under"));

      result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/resource-manager",
        defaultLogger,
      );
      assert(diagnosticText(result)?.includes("levels under"));

      result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/resource-manager/RP.Namespace",
        defaultLogger,
      );
      assert(diagnosticText(result)?.includes("levels under"));

      result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/resource-manager/RP.Namespace/FooManagement/too-deep",
        defaultLogger,
      );
      assert(diagnosticText(result)?.includes("levels under"));
    });

    it("should succeed with data-plane", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation((patterns) =>
        patterns[0].includes("tspconfig")
          ? Promise.resolve(["tspconfig.yaml"])
          : Promise.resolve(["main.tsp"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/data-plane/Foo",
        defaultLogger,
      );

      assert(result.success);
    });

    it("should succeed with resource-manager", async function () {
      vi.mocked(nativeGlob.globFiles).mockImplementation(async (patterns) =>
        patterns[0].includes("tspconfig")
          ? Promise.resolve(["tspconfig.yaml"])
          : Promise.resolve(["main.tsp"]),
      );
      gitRootSpy.mockResolvedValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/resource-manager/Microsoft.Foo/FooManagement",
        defaultLogger,
      );

      assert(result.success);
    });
  });
});
