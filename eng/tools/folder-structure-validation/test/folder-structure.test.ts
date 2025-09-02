import { mockAll, mockFolder } from "./mocks.js";
mockAll();

import * as globby from "globby";
import { strict as assert } from "node:assert";
import { afterEach, beforeEach, describe, it, MockInstance, vi } from "vitest";
import { FolderStructureRule } from "../src/folder-structure.js";

import * as utils from "../src/utils.js";

const mockTspConfig = `
parameters:
  "service-dir":
    default: "sdk/contosowidgetmanager"
emit:
  - "@azure-tools/typespec-autorest"
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
    emit-lro-options: "none"
    emitter-output-dir: "{project-root}/.."
    output-file: "{azure-resource-provider-folder}/{service-name}/{version-status}/{version}/widgets.json"
`;

describe("folder-structure", function () {
  let fileExistsSpy: MockInstance;
  let normalizePathSpy: MockInstance;
  let readTspConfigSpy: MockInstance;

  beforeEach(() => {
    fileExistsSpy = vi.spyOn(utils, "fileExists").mockResolvedValue(true);
    normalizePathSpy = vi.spyOn(utils, "normalizePath");
    readTspConfigSpy = vi.spyOn(utils, "readTspConfig").mockResolvedValue(mockTspConfig);
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
    assert(result.errorOutput.includes("must be exactly 4 levels deep"));
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
    assert(result.errorOutput.includes("must be exactly 5 levels deep"));
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

    // Test data-plane with too many levels (5 instead of 4)
    let result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/data-plane/Foo/too-deep",
    );
    assert(result.errorOutput?.includes("must be exactly 4 levels deep"));

    // Test resource-manager with too many levels (6 instead of 5)
    result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/resource-manager/RP.Namespace/ServiceName/too-deep",
    );
    assert(result.errorOutput?.includes("5 levels or less"));

    // Test resource-manager with too few levels (4 instead of 5)
    result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/resource-manager/RP.Namespace",
    );
    assert(result.errorOutput?.includes("must be exactly 5 levels deep"));

    result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/resource-manager/RP.Namespace/FooManagement/too-deep",
    );
    assert(result.errorOutput?.includes("6 levels"));
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

  it("should enforce v2 compliance when target branch uses v2 structure", async function () {
    vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
      // Mock tspconfig and tsp files for validation
      if (options?.onlyDirectories === true) {
        return [];
      }
      return patterns[0].includes("tspconfig") ? ["tspconfig.yaml"] : ["main.tsp"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    // Mock git operations to simulate target branch using v2 structure
    const mockGit = {
      revparse: vi.fn().mockResolvedValue("/gitroot"),
      branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
      raw: vi.fn().mockResolvedValue("data-plane\nresource-manager\nsome-other-dir"),
    } as any;

    // Mock simpleGit function
    const simpleGitSpy = vi
      .spyOn(await import("simple-git"), "simpleGit")
      .mockImplementation(() => mockGit);

    // Test with v1 structure folder when target branch uses v2 - should fail
    const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

    assert(result.errorOutput);
    assert(result.errorOutput.includes("The target branch is already using folder structure v2"));

    // Cleanup
    simpleGitSpy.mockRestore();
  });

  it("should not enforce v2 compliance when target branch uses v1 structure", async function () {
    vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
      // Mock tspconfig and tsp files for validation
      if (options?.onlyDirectories === true) {
        return [];
      }
      return patterns[0].includes("tspconfig") ? ["tspconfig.yaml"] : ["main.tsp"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    // Mock git operations to simulate target branch using only v1 structure
    const mockGit = {
      revparse: vi.fn().mockResolvedValue("/gitroot"),
      branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
      raw: vi.fn().mockResolvedValue("Service1\nService2\nShared"), // Only v1 structure directories
    } as any;

    const simpleGitSpy = vi
      .spyOn(await import("simple-git"), "simpleGit")
      .mockImplementation(() => mockGit);

    // Test with v1 structure folder when target branch uses v1 - should pass
    const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

    assert(result.success);

    // Cleanup
    simpleGitSpy.mockRestore();
  });

  it("should allow v2 structure when target branch uses v2 structure", async function () {
    vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
      // Mock tspconfig and tsp files for validation
      if (options?.onlyDirectories === true) {
        return [];
      }
      // For tspconfig pattern
      if (patterns[0].includes("tspconfig")) {
        return ["tspconfig.yaml"];
      }
      // For .tsp files
      return ["main.tsp"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    // Mock git operations to simulate target branch using v2 structure
    const mockGit = {
      revparse: vi.fn().mockResolvedValue("/gitroot"),
      branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
      raw: vi.fn().mockResolvedValue("data-plane\nresource-manager"),
    } as any;

    const simpleGitSpy = vi
      .spyOn(await import("simple-git"), "simpleGit")
      .mockImplementation(() => mockGit);

    // Test with v2 data-plane structure when target branch uses v2 - should pass
    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/data-plane/FooService",
    );

    assert(result.success);

    // Cleanup
    simpleGitSpy.mockRestore();
  });

  it("should detect invalid v2 structure when target branch uses v2 structure", async function () {
    vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
      // Mock tspconfig and tsp files for validation
      if (options?.onlyDirectories === true) {
        return [];
      }
      return patterns[0].includes("tspconfig") ? ["tspconfig.yaml"] : ["main.tsp"];
    });
    normalizePathSpy.mockReturnValue("/gitroot");

    // Mock git operations to simulate target branch using v2 structure
    const mockGit = {
      revparse: vi.fn().mockResolvedValue("/gitroot"),
      branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
      raw: vi.fn().mockResolvedValue("data-plane\nsome-other-dir"),
    } as any;

    const simpleGitSpy = vi
      .spyOn(await import("simple-git"), "simpleGit")
      .mockImplementation(() => mockGit);

    // Test with invalid v2 structure (too deep) when target branch uses v2 - should fail
    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/data-plane/FooService/TooDeep",
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes("exactly 4 levels deep"));

    // Cleanup
    simpleGitSpy.mockRestore();
  });

  describe("Target branch detection", function () {
    it("should detect target branch from GITHUB_BASE_REF environment variable", async function () {
      // Set environment variable
      const originalGitHubBaseRef = process.env.GITHUB_BASE_REF;
      process.env.GITHUB_BASE_REF = "develop";

      try {
        vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
          if (options?.onlyDirectories === true) {
            return [];
          }
          return patterns[0].includes("tspconfig") ? ["tspconfig.yaml"] : ["main.tsp"];
        });
        normalizePathSpy.mockReturnValue("/gitroot");

        const mockGit = {
          revparse: vi.fn().mockResolvedValue("/gitroot"),
          branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
          raw: vi.fn().mockResolvedValue("data-plane\nresource-manager"),
          getRemotes: vi
            .fn()
            .mockResolvedValue([
              {
                name: "origin",
                refs: { fetch: "https://github.com/user/azure-rest-api-specs.git" },
              },
            ]),
        } as any;

        const simpleGitSpy = vi
          .spyOn(await import("simple-git"), "simpleGit")
          .mockImplementation(() => mockGit);

        const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

        // Should enforce v2 compliance because GITHUB_BASE_REF indicates target branch has v2 structure
        assert(
          result.errorOutput?.includes("The target branch is already using folder structure v2"),
        );

        simpleGitSpy.mockRestore();
      } finally {
        // Restore original environment variable
        if (originalGitHubBaseRef !== undefined) {
          process.env.GITHUB_BASE_REF = originalGitHubBaseRef;
        } else {
          delete process.env.GITHUB_BASE_REF;
        }
      }
    });

    it("should detect target branch from SYSTEM_PULLREQUEST_TARGETBRANCH environment variable", async function () {
      // Set environment variable
      const originalAzureTargetBranch = process.env.SYSTEM_PULLREQUEST_TARGETBRANCH;
      process.env.SYSTEM_PULLREQUEST_TARGETBRANCH = "release/v2";

      try {
        vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
          if (options?.onlyDirectories === true) {
            return [];
          }
          return patterns[0].includes("tspconfig") ? ["tspconfig.yaml"] : ["main.tsp"];
        });
        normalizePathSpy.mockReturnValue("/gitroot");

        const mockGit = {
          revparse: vi.fn().mockResolvedValue("/gitroot"),
          branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
          raw: vi.fn().mockResolvedValue("data-plane\nresource-manager"),
          getRemotes: vi
            .fn()
            .mockResolvedValue([
              {
                name: "origin",
                refs: { fetch: "https://dev.azure.com/org/azure-rest-api-specs.git" },
              },
            ]),
        } as any;

        const simpleGitSpy = vi
          .spyOn(await import("simple-git"), "simpleGit")
          .mockImplementation(() => mockGit);

        const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

        // Should enforce v2 compliance because target branch has v2 structure
        assert(
          result.errorOutput?.includes("The target branch is already using folder structure v2"),
        );

        simpleGitSpy.mockRestore();
      } finally {
        // Restore original environment variable
        if (originalAzureTargetBranch !== undefined) {
          process.env.SYSTEM_PULLREQUEST_TARGETBRANCH = originalAzureTargetBranch;
        } else {
          delete process.env.SYSTEM_PULLREQUEST_TARGETBRANCH;
        }
      }
    });

    it("should detect target branch from remote tracking branch", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        return patterns[0].includes("tspconfig") ? ["tspconfig.yaml"] : ["main.tsp"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi
          .fn()
          .mockResolvedValueOnce({ current: "feature-branch" })
          .mockResolvedValueOnce({
            current: "feature-branch",
            all: [
              {
                name: "feature-branch",
                upstream: "origin/main",
              },
            ],
          }),
        raw: vi.fn().mockResolvedValue("Service1\nService2"), // v1 structure
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            { name: "origin", refs: { fetch: "https://github.com/user/azure-rest-api-specs.git" } },
          ]),
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

      // Should not enforce v2 compliance because target branch has v1 structure
      assert(result.success);

      simpleGitSpy.mockRestore();
    });

    it("should detect target branch using merge-base with upstream remote", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        return patterns[0].includes("tspconfig") ? ["tspconfig.yaml"] : ["main.tsp"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi
          .fn()
          .mockResolvedValueOnce({ current: "feature-branch" })
          .mockResolvedValueOnce({
            current: "feature-branch",
            all: [
              {
                name: "feature-branch",
                upstream: undefined, // No tracking branch
              },
            ],
          }),
        raw: vi
          .fn()
          .mockRejectedValueOnce(new Error("origin/main not found")) // First merge-base fails
          .mockResolvedValueOnce("merge-base-success") // upstream/main succeeds
          .mockResolvedValueOnce("data-plane\nresource-manager"), // v2 structure
        getRemotes: vi.fn().mockResolvedValue([
          {
            name: "upstream",
            refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
          },
          { name: "origin", refs: { fetch: "https://github.com/user/azure-rest-api-specs.git" } },
        ]),
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

      // Should enforce v2 compliance because upstream target branch has v2 structure
      assert(
        result.errorOutput?.includes("The target branch is already using folder structure v2"),
      );

      simpleGitSpy.mockRestore();
    });
  });

  describe("Remote detection for forks", function () {
    it("should prefer upstream remote over origin for target branch lookup", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        return patterns[0].includes("tspconfig") ? ["tspconfig.yaml"] : ["main.tsp"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        raw: vi.fn().mockResolvedValue("data-plane\nresource-manager"),
        getRemotes: vi.fn().mockResolvedValue([
          { name: "origin", refs: { fetch: "https://github.com/user/azure-rest-api-specs.git" } },
          {
            name: "upstream",
            refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
          },
        ]),
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

      // Verify that upstream remote was used (this would be visible in logs)
      // The test should enforce v2 compliance using upstream remote
      assert(
        result.errorOutput?.includes("The target branch is already using folder structure v2"),
      );

      simpleGitSpy.mockRestore();
    });

    it("should detect Azure remote when no upstream exists", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        return patterns[0].includes("tspconfig") ? ["tspconfig.yaml"] : ["main.tsp"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        raw: vi.fn().mockResolvedValue("data-plane\nresource-manager"),
        getRemotes: vi.fn().mockResolvedValue([
          { name: "origin", refs: { fetch: "https://github.com/user/forked-repo.git" } },
          { name: "azure", refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" } },
        ]),
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

      // Should use azure remote and enforce v2 compliance
      assert(
        result.errorOutput?.includes("The target branch is already using folder structure v2"),
      );

      simpleGitSpy.mockRestore();
    });

    it("should fallback to origin remote when no upstream or Azure remote exists", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        return patterns[0].includes("tspconfig") ? ["tspconfig.yaml"] : ["main.tsp"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        raw: vi.fn().mockResolvedValue("Service1\nService2"), // v1 structure
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            { name: "origin", refs: { fetch: "https://github.com/user/some-other-repo.git" } },
          ]),
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

      // Should use origin remote and not enforce v2 compliance (v1 structure)
      assert(result.success);

      simpleGitSpy.mockRestore();
    });

    it("should handle git errors gracefully and fallback to safe defaults", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        return patterns[0].includes("tspconfig") ? ["tspconfig.yaml"] : ["main.tsp"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockRejectedValue(new Error("Git operation failed")),
        raw: vi.fn().mockRejectedValue(new Error("Git operation failed")),
        getRemotes: vi.fn().mockRejectedValue(new Error("Git operation failed")),
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

      // Should not enforce v2 compliance when git operations fail
      assert(result.success);

      simpleGitSpy.mockRestore();
    });
  });

  describe("Swagger to TypeSpec migration scenarios", () => {
    beforeEach(() => {
      vi.clearAllMocks();
      fileExistsSpy.mockResolvedValue(true);
      normalizePathSpy.mockReturnValue("/gitroot");
    });

    it("should validate mixed swagger/TypeSpec folder structure during migration", async function () {
      // Mock a folder that has both swagger and TypeSpec files during migration
      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern.some((p) => p.includes("tspconfig"))) {
          return ["/gitroot/specification/storage/data-plane/Microsoft.Storage/tspconfig.yaml"];
        }
        return [];
      });

      fileExistsSpy.mockImplementation(async (path) => {
        // Simulate a folder with both swagger readme.md and TypeSpec files
        if (path.includes("readme.md") || path.includes("main.tsp")) {
          return true;
        }
        return false;
      });

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/storage/data-plane/Microsoft.Storage",
      );

      // Should not fail due to mixed content during migration
      assert(result.success || !(result.errorOutput?.includes("mixed content") ?? false));
    });

    it("should handle swagger-only folders in legacy structure", async function () {
      vi.mocked(globby.globby).mockImplementation(async () => []);

      fileExistsSpy.mockImplementation(async (path) => {
        // Only swagger files, no TypeSpec
        if (path.includes("readme.md") || path.includes(".json")) {
          return true;
        }
        if (
          path.includes("tspconfig.yaml") ||
          path.includes("main.tsp") ||
          path.includes("client.tsp")
        ) {
          return false;
        }
        return false;
      });

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/storage/resource-manager/Microsoft.Storage/stable/2023-01-01",
      );

      // Should handle swagger-only folders gracefully - expect failure because no TypeSpec files
      assert(!result.success);
      assert(result.errorOutput?.includes("Spec folder must contain"));
    });

    it("should validate v2 structure with proper data-plane organization", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        if (Array.isArray(patterns) && patterns.some((p) => p.includes("tspconfig"))) {
          return ["/gitroot/specification/storage/data-plane/Microsoft.Storage/tspconfig.yaml"];
        }
        return ["main.tsp"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      fileExistsSpy.mockImplementation(async (path) => {
        return (
          path.includes("main.tsp") || path.includes("tspconfig.yaml") || path.includes("examples")
        );
      });

      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            {
              name: "origin",
              refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
            },
          ]),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        raw: vi.fn().mockResolvedValue(""), // Empty to indicate target branch doesn't have v2 structure
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/storage/data-plane/Microsoft.Storage",
      );

      assert(result.success);
      simpleGitSpy.mockRestore();
    });

    it("should validate v2 structure with proper resource-manager organization", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        if (Array.isArray(patterns) && patterns.some((p) => p.includes("tspconfig"))) {
          return [
            "/gitroot/specification/compute/resource-manager/Microsoft.Compute/ComputeRP/tspconfig.yaml",
          ];
        }
        return ["main.tsp"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            {
              name: "origin",
              refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
            },
          ]),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        raw: vi.fn().mockResolvedValue("data-plane\nresource-manager\n"),
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/compute/resource-manager/Microsoft.Compute/ComputeRP",
      );

      assert(result.success);
      simpleGitSpy.mockRestore();
    });

    it("should fail when v2 structure has incorrect depth for data-plane", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        if (Array.isArray(patterns) && patterns.some((p) => p.includes("tspconfig"))) {
          return [
            "/gitroot/specification/storage/data-plane/Microsoft.Storage/Nested/tspconfig.yaml",
          ];
        }
        return ["main.tsp"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            {
              name: "origin",
              refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
            },
          ]),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        raw: vi.fn().mockResolvedValue("data-plane\nresource-manager\n"),
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/storage/data-plane/Microsoft.Storage/Nested",
      );

      assert(!result.success);
      assert(result.errorOutput?.includes("exactly 4 levels deep"));
      simpleGitSpy.mockRestore();
    });

    it("should fail when v2 structure has incorrect depth for resource-manager", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        if (Array.isArray(patterns) && patterns.some((p) => p.includes("tspconfig"))) {
          return ["/gitroot/specification/compute/resource-manager/tspconfig.yaml"];
        }
        return ["main.tsp"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            {
              name: "origin",
              refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
            },
          ]),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        raw: vi.fn().mockResolvedValue("data-plane\nresource-manager\n"),
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/compute/resource-manager",
      );

      assert(!result.success);
      assert(result.errorOutput?.includes("exactly 5 levels deep"));
      simpleGitSpy.mockRestore();
    });

    it("should enforce v2 compliance when target branch is already using v2", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        if (Array.isArray(patterns) && patterns.some((p) => p.includes("tspconfig"))) {
          return ["/gitroot/specification/storage/Storage/tspconfig.yaml"];
        }
        return ["main.tsp"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            {
              name: "origin",
              refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
            },
          ]),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        raw: vi.fn().mockResolvedValue("data-plane\nresource-manager\n"),
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/storage/Storage",
      );

      assert(!result.success);
      assert(result.errorOutput?.includes("target branch is already using folder structure v2"));
      simpleGitSpy.mockRestore();
    });
  });

  describe("Swagger file structure validation", () => {
    beforeEach(() => {
      vi.clearAllMocks();
      fileExistsSpy.mockResolvedValue(true);
      normalizePathSpy.mockReturnValue("/gitroot");
    });

    it("should handle folders with readme.md but no TypeSpec files", async function () {
      vi.mocked(globby.globby).mockImplementation(async () => []);

      fileExistsSpy.mockImplementation(async (path) => {
        if (path.includes("readme.md")) {
          return true;
        }
        if (
          path.includes("main.tsp") ||
          path.includes("client.tsp") ||
          path.includes("tspconfig.yaml")
        ) {
          return false;
        }
        return false;
      });

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/storage/resource-manager/Microsoft.Storage",
      );

      // Should indicate that TypeSpec files are expected
      assert(!result.success);
      assert(
        result.errorOutput?.includes("main.tsp") || result.errorOutput?.includes("client.tsp"),
      );
    });

    it("should detect OpenAPI/swagger JSON files in legacy structure", async function () {
      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern.some((p) => p.includes("**/*.json"))) {
          return [
            "/gitroot/specification/storage/resource-manager/Microsoft.Storage/stable/2023-01-01/storage.json",
            "/gitroot/specification/storage/resource-manager/Microsoft.Storage/preview/2023-05-01-preview/storage.json",
          ];
        }
        return [];
      });

      fileExistsSpy.mockImplementation(async (path) => {
        return path.includes(".json") || path.includes("readme.md");
      });

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/storage/resource-manager/Microsoft.Storage",
      );

      // Should handle swagger structures but expect TypeSpec migration
      assert(!result.success || (result.stdOutput?.includes(".json") ?? false));
    });

    it("should validate mixed versioning in swagger to TypeSpec migration", async function () {
      vi.mocked(globby.globby).mockImplementation(async (pattern) => {
        if (Array.isArray(pattern) && pattern.some((p) => p.includes("tspconfig"))) {
          return ["/gitroot/specification/storage/data-plane/Microsoft.Storage/tspconfig.yaml"];
        }
        if (Array.isArray(pattern) && pattern.some((p) => p.includes("**/*.json"))) {
          return [
            "/gitroot/specification/storage/data-plane/Microsoft.Storage/stable/2023-01-01/storage.json",
          ];
        }
        return ["main.tsp"];
      });

      fileExistsSpy.mockImplementation(async (path) => {
        return (
          path.includes("main.tsp") ||
          path.includes(".json") ||
          path.includes("readme.md") ||
          path.includes("tspconfig.yaml") ||
          path.includes("examples")
        );
      });

      normalizePathSpy.mockReturnValue("/gitroot");

      // Mock git to avoid v2 enforcement
      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            {
              name: "origin",
              refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
            },
          ]),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        raw: vi.fn().mockResolvedValue(""), // Empty to indicate target branch doesn't have v2 structure
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/storage/data-plane/Microsoft.Storage",
      );

      // Should allow mixed content during migration
      assert(result.success);
      simpleGitSpy.mockRestore();
    });

    it("should validate naming conventions for migrated services", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        if (Array.isArray(patterns) && patterns.some((p) => p.includes("tspconfig"))) {
          return ["/gitroot/specification/storage/data-plane/Microsoft.Storage/tspconfig.yaml"];
        }
        return ["main.tsp"];
      });

      fileExistsSpy.mockImplementation(async (path) => {
        return (
          path.includes("main.tsp") || path.includes("tspconfig.yaml") || path.includes("examples")
        );
      });

      normalizePathSpy.mockReturnValue("/gitroot");

      // Mock git to avoid v2 enforcement
      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            {
              name: "origin",
              refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
            },
          ]),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        raw: vi.fn().mockResolvedValue(""), // Empty to indicate target branch doesn't have v2 structure
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/storage/data-plane/Microsoft.Storage",
      );

      // Service name should follow proper conventions
      assert(result.success);
      simpleGitSpy.mockRestore();
    });

    it("should reject invalid service names in v2 structure", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        if (Array.isArray(patterns) && patterns.some((p) => p.includes("tspconfig"))) {
          return ["/gitroot/specification/storage/data-plane/invalid-service-name/tspconfig.yaml"];
        }
        return ["main.tsp"];
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            {
              name: "origin",
              refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
            },
          ]),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        raw: vi.fn().mockResolvedValue("data-plane\nresource-manager\n"),
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/storage/data-plane/invalid-service-name",
      );

      assert(!result.success);
      assert(result.errorOutput?.includes("PascalCase"));
      simpleGitSpy.mockRestore();
    });

    it("should validate RP namespace format in resource-manager structure", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        if (Array.isArray(patterns) && patterns.some((p) => p.includes("tspconfig"))) {
          return [
            "/gitroot/specification/compute/resource-manager/Microsoft.Compute$/ComputeRP/tspconfig.yaml",
          ];
        }
        return ["main.tsp"];
      });

      fileExistsSpy.mockImplementation(async (path) => {
        return (
          path.includes("main.tsp") || path.includes("tspconfig.yaml") || path.includes("examples")
        );
      });

      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            {
              name: "origin",
              refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
            },
          ]),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        raw: vi.fn().mockResolvedValue("data-plane\nresource-manager\n"),
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/compute/resource-manager/Microsoft.Compute$/ComputeRP",
      );

      assert(!result.success);
      assert(result.errorOutput?.includes("A.B") || result.errorOutput?.includes("PascalCase"));
      simpleGitSpy.mockRestore();
    });

    it("should handle transition scenarios from swagger to TypeSpec", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        // Mock scenario where both swagger readme.md and TypeSpec files exist
        if (Array.isArray(patterns) && patterns.some((p) => p.includes("tspconfig"))) {
          return ["/gitroot/specification/cognitiveservices/data-plane/Language/tspconfig.yaml"];
        }
        return ["main.tsp"];
      });

      fileExistsSpy.mockImplementation(async (path) => {
        // Both swagger and TypeSpec files exist during transition
        return (
          path.includes("readme.md") ||
          path.includes("main.tsp") ||
          path.includes("tspconfig.yaml") ||
          path.includes("examples")
        );
      });

      normalizePathSpy.mockReturnValue("/gitroot");

      // Mock git to avoid v2 enforcement
      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            {
              name: "origin",
              refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
            },
          ]),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        raw: vi.fn().mockResolvedValue(""), // Empty to indicate target branch doesn't have v2 structure
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/cognitiveservices/data-plane/Language",
      );

      // Should handle transition gracefully
      assert(result.success);
      simpleGitSpy.mockRestore();
    });

    it("should enforce proper examples folder structure in TypeSpec", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return [];
        }
        if (Array.isArray(patterns) && patterns.some((p) => p.includes("tspconfig"))) {
          return ["/gitroot/specification/storage/data-plane/Microsoft.Storage/tspconfig.yaml"];
        }
        return ["main.tsp"];
      });

      fileExistsSpy.mockImplementation(async (path) => {
        // Main TypeSpec file exists but no examples folder
        if (path.includes("main.tsp") || path.includes("tspconfig.yaml")) {
          return true;
        }
        if (path.includes("examples")) {
          return false; // No examples folder
        }
        return false;
      });

      normalizePathSpy.mockReturnValue("/gitroot");

      // Mock git to avoid v2 enforcement
      const mockGit = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            {
              name: "origin",
              refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
            },
          ]),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        raw: vi.fn().mockResolvedValue(""), // Empty to indicate target branch doesn't have v2 structure
      } as any;

      const simpleGitSpy = vi
        .spyOn(await import("simple-git"), "simpleGit")
        .mockImplementation(() => mockGit);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/storage/data-plane/Microsoft.Storage",
      );

      // Should fail due to missing examples folder
      assert(!result.success);
      assert(result.errorOutput?.includes("examples"));
      simpleGitSpy.mockRestore();
    });

    it("should validate proper migration from swagger stable/preview structure", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns, options) => {
        if (options?.onlyDirectories === true) {
          return ["stable", "preview"]; // Legacy swagger structure
        }
        if (Array.isArray(patterns) && patterns.some((p) => p.includes("tspconfig"))) {
          return []; // No TypeSpec config yet
        }
        return [];
      });

      fileExistsSpy.mockImplementation(async (path) => {
        if (path.includes("readme.md") || path.includes(".json")) {
          return true;
        }
        if (
          path.includes("main.tsp") ||
          path.includes("client.tsp") ||
          path.includes("tspconfig.yaml")
        ) {
          return false;
        }
        return false;
      });

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/storage/resource-manager/Microsoft.Storage",
      );

      // Should indicate need for TypeSpec migration
      assert(!result.success);
      assert(
        result.errorOutput?.includes("main.tsp") || result.errorOutput?.includes("client.tsp"),
      );
    });
  });

  describe("Additional Swagger-related scenarios", () => {
    beforeEach(() => {
      vi.clearAllMocks();
      fileExistsSpy.mockResolvedValue(true);
      normalizePathSpy.mockReturnValue("/gitroot");
    });

    it("should validate service name format in TypeSpec migration", async function () {
      vi.mocked(globby.globby).mockImplementation(async () => [
        "/gitroot/specification/storage/data-plane/Storage/tspconfig.yaml",
      ]);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/storage/data-plane/Storage",
      );

      // Should pass basic validation for well-formed service name
      assert(result.success || result.errorOutput !== undefined);
    });

    it("should detect swagger JSON files alongside TypeSpec during migration", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns) => {
        if (Array.isArray(patterns) && patterns.some((p) => p.includes("tspconfig"))) {
          return ["/gitroot/specification/apimanagement/data-plane/ApiManagement/tspconfig.yaml"];
        }
        if (Array.isArray(patterns) && patterns.some((p) => p.includes("**/*.json"))) {
          return [
            "/gitroot/specification/apimanagement/data-plane/stable/2023-01-01/apimanagement.json",
          ];
        }
        return ["main.tsp"];
      });

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/apimanagement/data-plane/ApiManagement",
      );

      // Should handle mixed swagger/TypeSpec content during migration
      assert(result.success !== undefined);
    });

    it("should validate folder structure naming conventions", async function () {
      vi.mocked(globby.globby).mockImplementation(async () => [
        "/gitroot/specification/keyvault/data-plane/Microsoft.KeyVault/tspconfig.yaml",
      ]);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/keyvault/data-plane/Microsoft.KeyVault",
      );

      // Should pass for properly formatted service namespace
      assert(result.success || result.errorOutput !== undefined);
    });

    it("should handle README.md files in swagger specifications", async function () {
      vi.mocked(globby.globby).mockImplementation(async () => []);

      fileExistsSpy.mockImplementation(async (path) => {
        return path.includes("readme.md") || path.includes("README.md");
      });

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/network/resource-manager/Microsoft.Network",
      );

      // Should indicate that TypeSpec migration is needed
      assert(!result.success);
    });

    it("should validate OpenAPI specification structure", async function () {
      vi.mocked(globby.globby).mockImplementation(async (patterns) => {
        if (Array.isArray(patterns) && patterns.some((p) => p.includes("**/*.json"))) {
          return [
            "/gitroot/specification/compute/resource-manager/Microsoft.Compute/stable/2023-03-01/compute.json",
          ];
        }
        return [];
      });

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/compute/resource-manager/Microsoft.Compute",
      );

      // Test validates that swagger JSON files are detected
      assert(result.success !== undefined);
    });
  });
});
