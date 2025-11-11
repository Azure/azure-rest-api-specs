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

  describe("v2 compliance enforcement", function () {
    let simpleGitSpy: MockInstance;

    beforeEach(async () => {
      const { simpleGit } = await import("simple-git");
      simpleGitSpy = vi.spyOn({ simpleGit }, "simpleGit");
    });

    it("should enforce v2 compliance when target branch uses v2 structure", async function () {
      vi.mocked(globby.globby).mockImplementation(async () => {
        return ["/foo/bar/tspconfig.yaml"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      // Mock git to simulate target branch having v2 structure
      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        getRemotes: vi.fn().mockResolvedValue([
          { name: "origin", refs: { fetch: "git@github.com:Azure/azure-rest-api-specs.git" } }
        ]),
        raw: vi.fn().mockImplementation((args) => {
          if (args.includes("ls-tree")) {
            return Promise.resolve("data-plane\nresource-manager");
          }
          if (args.includes("merge-base")) {
            return Promise.resolve("abc123");
          }
          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as any);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");
      assert(!result.success);
      assert(result.errorOutput?.includes("must use v2 structure"));
    });

    it("should not enforce v2 compliance when target branch uses v1 structure", async function () {
      vi.mocked(globby.globby).mockImplementation(async () => {
        return ["/foo/bar/tspconfig.yaml"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      // Mock git to simulate target branch having v1 structure
      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        getRemotes: vi.fn().mockResolvedValue([
          { name: "origin", refs: { fetch: "git@github.com:Azure/azure-rest-api-specs.git" } }
        ]),
        raw: vi.fn().mockImplementation((args) => {
          if (args.includes("ls-tree")) {
            return Promise.resolve("Service1\nService2\nShared");
          }
          if (args.includes("merge-base")) {
            return Promise.resolve("abc123");
          }
          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as any);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");
      // Should succeed with v1 validation since target branch is v1
      assert(result.success);
    });

    it("should detect target branch from GITHUB_BASE_REF environment variable", async function () {
      const originalEnv = process.env.GITHUB_BASE_REF;
      process.env.GITHUB_BASE_REF = "main";

      vi.mocked(globby.globby).mockImplementation(async () => {
        return ["/foo/bar/tspconfig.yaml"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        getRemotes: vi.fn().mockResolvedValue([
          { name: "origin", refs: { fetch: "git@github.com:Azure/azure-rest-api-specs.git" } }
        ]),
        raw: vi.fn().mockImplementation((args) => {
          if (args.includes("ls-tree")) {
            return Promise.resolve("data-plane\nresource-manager");
          }
          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as any);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");
      
      // Restore environment
      if (originalEnv !== undefined) {
        process.env.GITHUB_BASE_REF = originalEnv;
      } else {
        delete process.env.GITHUB_BASE_REF;
      }

      assert(!result.success);
      assert(result.errorOutput?.includes("must use v2 structure"));
    });
  });

  describe("v2 structure validation", function () {
    let simpleGitSpy: MockInstance;

    beforeEach(async () => {
      const { simpleGit } = await import("simple-git");
      simpleGitSpy = vi.spyOn({ simpleGit }, "simpleGit");
      
      // Mock git for v2 structure tests
      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "main" }),
      };
      simpleGitSpy.mockReturnValue(mockGit as any);
    });

    it("should fail v2 data-plane with incorrect depth", async function () {
      vi.mocked(globby.globby).mockImplementation(async () => {
        return ["/foo/bar/tspconfig.yaml"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/data-plane",
      );
      assert(!result.success);
      assert(result.errorOutput?.includes("exactly 4 levels deep"));
    });

    it("should fail v2 resource-manager with incorrect depth", async function () {
      vi.mocked(globby.globby).mockImplementation(async () => {
        return ["/foo/bar/tspconfig.yaml"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/resource-manager/Microsoft.Foo",
      );
      assert(!result.success);
      assert(result.errorOutput?.includes("exactly 5 levels deep"));
    });

    it("should fail v2 with invalid service name (not PascalCase)", async function () {
      vi.mocked(globby.globby).mockImplementation(async () => {
        return ["/foo/bar/tspconfig.yaml"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/data-plane/foo-service",
      );
      assert(!result.success);
      assert(result.errorOutput?.includes("PascalCase without any special characters"));
    });

    it("should fail v2 resource-manager with invalid RP namespace", async function () {
      vi.mocked(globby.globby).mockImplementation(async () => {
        return ["/foo/bar/tspconfig.yaml"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/resource-manager/microsoft.foo/FooService",
      );
      assert(!result.success);
      assert(result.errorOutput?.includes("must be in format 'A.B' where A and B are PascalCase"));
    });

    it("should fail v2 with uppercase org name", async function () {
      vi.mocked(globby.globby).mockImplementation(async () => {
        return ["/foo/bar/tspconfig.yaml"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/Foo/data-plane/FooService",
      );
      assert(!result.success);
      assert(result.errorOutput?.includes("must be all lowercase"));
    });
  });

  describe("TypeSpec project detection", function () {
    it("should detect TypeSpec project with tspconfig.yaml", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns) => {
        return patterns[0].includes("tspconfig") ? ["tspconfig.yaml"] : [];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");
      // Should apply TypeSpec-specific validations
      assert(result.errorOutput?.includes("main.tsp or client.tsp"));
    });

    it("should detect TypeSpec project with main.tsp", async function () {
      vi.mocked(globby.globby).mockImplementation(async () => {
        return [];
      });
      fileExistsSpy.mockImplementation(async (path) => {
        return path.includes("main.tsp");
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");
      // Should require examples folder when main.tsp exists
      assert(result.errorOutput?.includes("examples folder"));
    });

    it("should not apply TypeSpec validations to non-TypeSpec projects", async function () {
      vi.mocked(globby.globby).mockImplementation(async () => {
        return [];
      });
      fileExistsSpy.mockResolvedValue(false);
      normalizePathSpy.mockReturnValue("/gitroot");

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");
      // Should succeed for non-TypeSpec projects
      assert(result.success);
    });
  });
});
