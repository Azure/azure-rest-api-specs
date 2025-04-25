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

  it("should fail if tspconfig has incorrect extension", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yml"];
    });

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
      mockFolder,
    );
    assert(result.errorOutput);
    assert(result.errorOutput && result.errorOutput.includes("Invalid config file"));
  });

  it("should fail if folder under specification/ is capitalized", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
      "/gitroot/specification/Foo/Foo",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("must be lower case"));
  });

  it("should succeed if package folder has trailing slash", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
      "/gitroot/specification/foo/Foo/Foo/",
    );
    assert(result.success);
  });

  it("should fail if package folder is more than 3 levels deep", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
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

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
      "/gitroot/specification/foo/Foo.foo",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("must be capitalized"));
  });

  it("should fail if second level folder is data-plane", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
      "/gitroot/specification/foo/data-plane",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("must be capitalized"));
  });

  it("should fail if second level folder is resource-manager", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
      "/gitroot/specification/foo/resource-manager",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("must be capitalized"));
  });

  it("should fail if Shared does not follow Management ", async function () {
    vi.mocked(globby.globby).mockImplementation(async () => {
      return ["/foo/bar/tspconfig.yaml"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
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

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
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

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
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

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
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

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
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

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
      "/gitroot/specification/foo/Foo",
    );

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

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
      "/gitroot/specification/foo/Foo",
    );

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

    const result = await new FolderStructureRule({ validateOldStructure: true }).execute(
      "/gitroot/specification/foo/Foo.Management",
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes(".Management"));
  });

  // New Structure Tests
  describe("new structure validation", function () {
    beforeEach(() => {
      normalizePathSpy.mockReturnValue("/gitroot");
    });

    it("should succeed with valid rpnamespace root", async function () {
      fileExistsSpy.mockImplementation(async (file: string) => {
        if (
          file.includes("cspell.yaml") ||
          file.includes("resource-manager") ||
          file.includes("data-plane")
        ) {
          return true;
        }
        return false;
      });

      const result = await new FolderStructureRule({
        validateNewStructure: true,
        validateOldStructure: false,
      }).execute("/gitroot/specification/contoso");

      assert(result.success);
    });

    it("should fail if rpnamespace root doesn't have cspell.yaml", async function () {
      fileExistsSpy.mockImplementation(async (file: string) => {
        if (file.includes("cspell.yaml")) {
          return false;
        }
        return file.includes("resource-manager") || file.includes("data-plane");
      });

      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern[0].includes("contoso/*")) {
          return [
            "/gitroot/specification/contoso/resource-manager/",
            "/gitroot/specification/contoso/data-plane/",
          ];
        }
        return [];
      });

      const result = await new FolderStructureRule({
        validateNewStructure: true,
        validateOldStructure: false,
      }).execute("/gitroot/specification/contoso");

      assert(result.errorOutput);
      assert(result.errorOutput.includes("cspell.yaml"));
    });

    it("should fail if rpnamespace root has no resource-manager or data-plane", async function () {
      fileExistsSpy.mockImplementation(async (file: string) => {
        if (file.includes("resource-manager") || file.includes("data-plane")) {
          return false;
        }
        return file.includes("cspell.yaml");
      });

      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern[0].includes("contoso/*")) {
          return ["/gitroot/specification/contoso/cspell.yaml"];
        }
        return [];
      });

      const result = await new FolderStructureRule({
        validateNewStructure: true,
        validateOldStructure: false,
      }).execute("/gitroot/specification/contoso");

      assert(result.errorOutput);
      assert(
        result.errorOutput.includes(
          "must contain at least one of resource-manager/ or data-plane/",
        ),
      );
    });

    it("should succeed with valid resource-manager root", async function () {
      fileExistsSpy.mockImplementation(async (file: string) => {
        return file.includes("readme.md") || file.includes("operations");
      });

      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern[0].includes("resource-manager/*")) {
          return [
            "/gitroot/specification/contoso/resource-manager/readme.md",
            "/gitroot/specification/contoso/resource-manager/operations/",
            "/gitroot/specification/contoso/resource-manager/widgets/",
          ];
        }
        return [];
      });

      const result = await new FolderStructureRule({
        validateNewStructure: true,
        validateOldStructure: false,
      }).execute("/gitroot/specification/contoso/resource-manager");

      assert(result.success);
    });

    it("should fail if resource-manager root has no readme.md", async function () {
      fileExistsSpy.mockImplementation(async (file: string) => {
        if (file.includes("readme.md")) {
          return false;
        }
        return file.includes("operations");
      });

      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern[0].includes("resource-manager/*")) {
          return [
            "/gitroot/specification/contoso/resource-manager/operations/",
            "/gitroot/specification/contoso/resource-manager/widgets/",
          ];
        }
        return [];
      });

      const result = await new FolderStructureRule({
        validateNewStructure: true,
        validateOldStructure: false,
      }).execute("/gitroot/specification/contoso/resource-manager");

      assert(result.errorOutput);
      assert(result.errorOutput.includes("readme.md"));
    });

    it("should fail if resource-manager root has no operations folder", async function () {
      fileExistsSpy.mockImplementation(async (file: string) => {
        if (file.includes("operations")) {
          return false;
        }
        return file.includes("readme.md");
      });

      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern[0].includes("resource-manager/*")) {
          return [
            "/gitroot/specification/contoso/resource-manager/readme.md",
            "/gitroot/specification/contoso/resource-manager/widgets/",
          ];
        }
        return [];
      });

      const result = await new FolderStructureRule({
        validateNewStructure: true,
        validateOldStructure: false,
      }).execute("/gitroot/specification/contoso/resource-manager");

      assert(result.errorOutput);
      assert(result.errorOutput.includes("operations/"));
    });

    it("should succeed with valid service folder", async function () {
      fileExistsSpy.mockImplementation(async (file: string) => {
        return (
          file.includes("tspconfig.yaml") ||
          file.includes("main.tsp") ||
          file.includes("examples") ||
          file.includes("preview") ||
          file.includes("stable")
        );
      });

      const result = await new FolderStructureRule({
        validateNewStructure: true,
        validateOldStructure: false,
      }).execute("/gitroot/specification/contoso/resource-manager/widgets");

      assert(result.success);
    });

    it("should fail if service folder has no tspconfig.yaml", async function () {
      fileExistsSpy.mockImplementation(async (file: string) => {
        if (file.includes("tspconfig.yaml")) {
          return false;
        }
        return (
          file.includes("main.tsp") ||
          file.includes("examples") ||
          file.includes("preview") ||
          file.includes("stable")
        );
      });

      const result = await new FolderStructureRule({
        validateNewStructure: true,
        validateOldStructure: false,
      }).execute("/gitroot/specification/contoso/resource-manager/widgets");

      assert(result.errorOutput);
      assert(result.errorOutput.includes("tspconfig.yaml"));
    });

    it("should fail if service folder has no main.tsp or client.tsp", async function () {
      fileExistsSpy.mockImplementation(async (file: string) => {
        if (file.includes("main.tsp") || file.includes("client.tsp")) {
          return false;
        }
        return (
          file.includes("tspconfig.yaml") ||
          file.includes("examples") ||
          file.includes("preview") ||
          file.includes("stable")
        );
      });

      const result = await new FolderStructureRule({
        validateNewStructure: true,
        validateOldStructure: false,
      }).execute("/gitroot/specification/contoso/resource-manager/widgets");

      assert(result.errorOutput);
      assert(result.errorOutput.includes("main.tsp or client.tsp"));
    });

    it("should validate preview folder correctly", async function () {
      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern[0].includes("preview/*")) {
          return [
            "/gitroot/specification/contoso/resource-manager/widgets/preview/2022-01-01-preview",
          ];
        }
        return [];
      });

      const result = await new FolderStructureRule({
        validateNewStructure: true,
        validateOldStructure: false,
      }).execute("/gitroot/specification/contoso/resource-manager/widgets/preview");

      assert(result.success);
    });

    it("should fail with invalid preview version format", async function () {
      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern[0].includes("preview/*")) {
          return ["/gitroot/specification/contoso/resource-manager/widgets/preview/invalid-format"];
        }
        return [];
      });

      const result = await new FolderStructureRule({
        validateNewStructure: true,
        validateOldStructure: false,
      }).execute("/gitroot/specification/contoso/resource-manager/widgets/preview");

      assert(result.errorOutput);
      assert(result.errorOutput.includes("must follow the format 'YYYY-MM-DD-preview'"));
    });

    it("should validate stable folder correctly", async function () {
      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern[0].includes("stable/*")) {
          return ["/gitroot/specification/contoso/resource-manager/widgets/stable/2022-01-01"];
        }
        return [];
      });

      const result = await new FolderStructureRule({
        validateNewStructure: true,
        validateOldStructure: false,
      }).execute("/gitroot/specification/contoso/resource-manager/widgets/stable");

      assert(result.success);
    });

    it("should fail with invalid stable version format", async function () {
      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern[0].includes("stable/*")) {
          return ["/gitroot/specification/contoso/resource-manager/widgets/stable/invalid-format"];
        }
        return [];
      });

      const result = await new FolderStructureRule({
        validateNewStructure: true,
        validateOldStructure: false,
      }).execute("/gitroot/specification/contoso/resource-manager/widgets/stable");

      assert(result.errorOutput);
      assert(result.errorOutput.includes("must follow the format 'YYYY-MM-DD'"));
    });
  });

  // Tests for dual validation
  describe("dual validation", function () {
    beforeEach(() => {
      normalizePathSpy.mockReturnValue("/gitroot");
    });

    it("should succeed if at least one validation passes", async function () {
      // Mock to fail old structure but pass new structure
      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern[0].includes("**tspconfig.*")) {
          // Fail old structure with invalid extension
          return ["/foo/bar/tspconfig.yml"];
        } else if (Array.isArray(pattern) && pattern[0].includes("contoso/*")) {
          // Pass new structure with valid folders
          return [
            "/gitroot/specification/contoso/cspell.yaml",
            "/gitroot/specification/contoso/resource-manager/",
            "/gitroot/specification/contoso/data-plane/",
          ];
        }
        return [];
      });

      fileExistsSpy.mockImplementation(async (file: string) => {
        return (
          file.includes("cspell.yaml") ||
          file.includes("resource-manager") ||
          file.includes("data-plane")
        );
      });

      const result = await new FolderStructureRule({
        validateOldStructure: true,
        validateNewStructure: true,
      }).execute("/gitroot/specification/contoso");

      assert(result.success);
      assert(
        result.stdOutput && result.stdOutput.includes("At least one structure validation passed"),
      );
    });

    it("should fail only if both validations fail", async function () {
      // Mock to fail both old and new structure
      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern[0].includes("**tspconfig.*")) {
          // Fail old structure with invalid extension
          return ["/foo/bar/tspconfig.yml"];
        }
        return [];
      });

      // Fail new structure with missing required files/folders
      fileExistsSpy.mockResolvedValue(false);

      const result = await new FolderStructureRule({
        validateOldStructure: true,
        validateNewStructure: true,
      }).execute("/gitroot/specification/contoso");

      assert(!result.success);
      assert(result.errorOutput && result.errorOutput.includes("Invalid config file"));
      assert(result.errorOutput && result.errorOutput.includes("RPNamespace root must contain"));
    });
  });

  // Testing default behavior and explicit options
  describe("options-based structure validation", function () {
    beforeEach(() => {
      normalizePathSpy.mockReturnValue("/gitroot");
    });

    it("should validate old structure by default", async function () {
      // Setup mocks for successful old structure validation
      vi.mocked(globby.globby).mockImplementation(async () => {
        return ["/foo/bar/tspconfig.yaml"];
      });

      // Create rule with default options - should validate old structure only
      const rule = new FolderStructureRule();

      const result = await rule.execute("/gitroot/specification/foo/Foo.Management");

      assert(result.success);
      assert(result.stdOutput && result.stdOutput.includes("Validation mode: Old structure"));
      assert(!result.stdOutput || !result.stdOutput.includes("New structure"));
    });

    it("should use explicit options to enable new structure validation", async function () {
      // Setup mocks for successful new structure validation
      fileExistsSpy.mockImplementation(async (file: string) => {
        if (
          file.includes("cspell.yaml") ||
          file.includes("resource-manager") ||
          file.includes("data-plane")
        ) {
          return true;
        }
        return false;
      });

      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern[0].includes("contoso/*")) {
          return [
            "/gitroot/specification/contoso/cspell.yaml",
            "/gitroot/specification/contoso/resource-manager/",
            "/gitroot/specification/contoso/data-plane/",
          ];
        }
        return [];
      });

      // Create rule with explicit options to enable new structure and disable old structure
      const rule = new FolderStructureRule({
        validateOldStructure: false,
        validateNewStructure: true,
      });

      const result = await rule.execute("/gitroot/specification/contoso");

      assert(result.success);
      assert(result.stdOutput && result.stdOutput.includes("Validation mode: New structure"));
      assert(!result.stdOutput.includes("Old structure"));
    });

    it("should enable both validations when explicitly configured", async function () {
      // Setup mocks for successful validation of both structures
      fileExistsSpy.mockImplementation(async (file: string) => {
        return true;
      });

      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        return ["/gitroot/specification/foo/Foo.Management/tspconfig.yaml"];
      });

      // Create rule with options to enable both old and new structure validation
      const rule = new FolderStructureRule({
        validateOldStructure: true,
        validateNewStructure: true,
      });

      const result = await rule.execute("/gitroot/specification/foo/Foo.Management");

      assert(result.success);
      assert(result.stdOutput && result.stdOutput.includes("Old structure"));
      assert(result.stdOutput.includes("New structure"));
      assert(result.stdOutput.includes("At least one structure validation passed"));
    });
  });
});
