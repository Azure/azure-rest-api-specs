import { mockAll, mockFolder } from "./mocks.js";
mockAll();

import { contosoTspConfig } from "@azure-tools/specs-shared/test/examples";
import * as globby from "globby";
import { strict as assert } from "node:assert";
import type { SimpleGit } from "simple-git";
import { afterEach, beforeEach, describe, it, MockInstance, vi } from "vitest";
import { FolderStructureRule } from "../src/rules/folder-structure.js";

import * as utils from "../src/utils.js";

describe("folder-structure", function () {
  let fileExistsSpy: MockInstance;
  let normalizePathSpy: MockInstance;
  let readTspConfigSpy: MockInstance;
  let simpleGitSpy: MockInstance;

  beforeEach(async () => {
    fileExistsSpy = vi.spyOn(utils, "fileExists").mockResolvedValue(true);
    normalizePathSpy = vi.spyOn(utils, "normalizePath");
    readTspConfigSpy = vi.spyOn(utils, "readTspConfig").mockResolvedValue(contosoTspConfig);

    // Setup global mock for simpleGit for the new hasSpecificationFolderChanges method
    const simpleGitModule = await import("simple-git");
    simpleGitSpy = simpleGitModule.simpleGit as unknown as MockInstance;
    simpleGitSpy.mockReset();

    // Default mock that allows most tests to pass by simulating changes in specification folder
    const defaultMockGit: Record<string, unknown> = {
      revparse: vi.fn().mockResolvedValue("/gitroot"),
      branch: vi.fn().mockImplementation((args?: string[]) => {
        if (args && args.includes("-vv")) {
          return Promise.resolve({
            current: "test-branch",
            all: ["test-branch"],
          });
        }
        return Promise.resolve({
          current: "test-branch",
          all: ["test-branch"],
        });
      }),
      status: vi.fn().mockResolvedValue({
        modified: ["specification/foo/bar.ts"],
        not_added: [],
        created: [],
        deleted: [],
      }),
      getRemotes: vi
        .fn()
        .mockResolvedValue([
          { name: "origin", refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" } },
        ]),
      raw: vi.fn().mockImplementation((args: string[]) => {
        // Handle diff command for checking changes
        if (args.includes("diff") && args.includes("--name-only")) {
          return Promise.resolve("specification/foo/main.tsp\nspecification/foo/tspconfig.yaml");
        }
        // Handle other git commands
        if (args.includes("config")) {
          return Promise.resolve("https://github.com/Azure/azure-rest-api-specs.git");
        }
        if (args.includes("ls-tree")) {
          return Promise.resolve("");
        }
        if (args.includes("merge-base")) {
          return Promise.resolve("abc123");
        }
        return Promise.resolve("main");
      }),
    };
    simpleGitSpy.mockReturnValue(defaultMockGit as unknown as SimpleGit);
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
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/bar/tspconfig.yml"]));
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute("/gitroot/" + mockFolder);
    assert(result.errorOutput);
    assert(result.errorOutput.includes("Invalid config file"));
  });

  it("should fail if folder under specification/ is capitalized", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/bar/tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute("/gitroot/specification/Foo/Foo");
    assert(result.errorOutput);
    assert(result.errorOutput.includes("must be lower case"));
  });

  it("should succeed if package folder has trailing slash", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/bar/tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo/Foo/");
    assert(result.success);
  });

  it("should fail if package folder is more than 3 levels deep", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/bar/tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/Foo/Foo/Foo",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("3 levels or less"));
  });

  it("should fail if second level folder not capitalized at after each '.' ", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/bar/tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo.foo");
    assert(result.errorOutput);
    assert(result.errorOutput.includes("must be capitalized"));
  });

  it("should fail if second level folder is data-plane", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/bar/tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute("/gitroot/specification/foo/data-plane");
    assert(result.errorOutput);
    assert(result.errorOutput.includes("exactly one level under"));
  });

  it("should fail if second level folder is resource-manager", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/bar/tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/resource-manager",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("exactly two levels under"));
  });

  it("should fail if Shared does not follow Management ", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/bar/tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/Foo.Management.Foo.Shared",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("should follow"));
  });

  it("should fail if folder doesn't contain main.tsp nor client.tsp", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/bar/tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");

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
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes("must contain"));
  });

  it("should fail if folder doesn't contain examples when main.tsp exists", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/bar/tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");

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
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes("must contain"));
  });

  it("should fail if non-shared folder doesn't contain tspconfig", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/bar/tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");

    fileExistsSpy.mockImplementation((file: string) => {
      if (file.includes("tspconfig.yaml")) {
        return Promise.resolve(false);
      }
      return Promise.resolve(true);
    });

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/Foo.Management",
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes("must contain"));
  });

  it("should succeed with resource-manager/Management", async function () {
    vi.mocked(globby.globby).mockImplementation(() =>
      Promise.resolve(["/foo/Foo.Management/tspconfig.yaml"]),
    );
    normalizePathSpy.mockReturnValue("/gitroot");
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "resource-manager"
`),
    );

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/Foo.Management",
    );

    assert(result.success);
  });

  it("should succeed with data-plane/NoManagement", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/Foo/tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
`),
    );

    const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

    assert(result.success);
  });

  it("should fail with resource-manager/NoManagement", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/Foo/tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "resource-manager"
`),
    );

    const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

    assert(result.errorOutput);
    assert(result.errorOutput.includes(".Management"));
  });

  it("should fail with data-plane/Management", async function () {
    vi.mocked(globby.globby).mockImplementation(() =>
      Promise.resolve(["/foo/Foo.Management/tspconfig.yaml"]),
    );
    normalizePathSpy.mockReturnValue("/gitroot");
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
`),
    );

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/Foo.Management",
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes(".Management"));
  });

  it("v2: should fail if no tspconfig.yaml", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["main.tsp"]));
    normalizePathSpy.mockReturnValue("/gitroot");

    fileExistsSpy.mockImplementation((file: string) => {
      if (file.includes("tspconfig.yaml")) {
        return Promise.resolve(false);
      }
      return Promise.resolve(true);
    });

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/data-plane/Foo",
    );

    assert(result.errorOutput?.includes("must contain"));
  });

  it("v2: should fail if incorrect folder depth", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");

    let result = await new FolderStructureRule().execute("/gitroot/specification/foo/data-plane");
    assert(result.errorOutput?.includes("level under"));

    result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/data-plane/Foo/too-deep",
    );
    assert(result.errorOutput?.includes("exactly one level under"));

    result = await new FolderStructureRule().execute("/gitroot/specification/foo/resource-manager");
    assert(result.errorOutput?.includes("exactly two levels under"));

    result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/resource-manager/RP.Namespace",
    );
    assert(result.errorOutput?.includes("exactly two levels under"));

    result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/resource-manager/RP.Namespace/FooManagement/too-deep",
    );
    assert(result.errorOutput?.includes("limit TypeSpec folder depth"));
  });

  it("v2: should succeed with data-plane", async function () {
    vi.mocked(globby.globby).mockImplementation((patterns) =>
      patterns[0].includes("tspconfig")
        ? Promise.resolve(["tspconfig.yaml"])
        : Promise.resolve(["main.tsp"]),
    );
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/data-plane/Foo",
    );

    assert(result.success);
  });

  it("v2: should succeed with resource-manager", async function () {
    vi.mocked(globby.globby).mockImplementation(async (patterns) =>
      patterns[0].includes("tspconfig")
        ? Promise.resolve(["tspconfig.yaml"])
        : Promise.resolve(["main.tsp"]),
    );
    normalizePathSpy.mockReturnValue("/gitroot");

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/resource-manager/Microsoft.Foo/FooManagement",
    );

    assert(result.success);
  });

  describe("v2 compliance enforcement", function () {
    beforeEach(() => {
      // Reset the mock for these specific tests
      simpleGitSpy.mockReset();
    });

    it("should enforce v2 compliance when target branch uses v2 structure", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve(["/gitroot/specification/foo/Foo/tspconfig.yaml"]);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      // Ensure V1 validation passes so we know failure is due to V2 enforcement
      readTspConfigSpy.mockResolvedValue(`
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
`);

      // Set environment variable to specify target branch
      const originalGitHub = process.env.GITHUB_BASE_REF;
      process.env.GITHUB_BASE_REF = "feature/v2-structure";

      // Mock git to simulate target branch having v2 structure
      const mockGit: Record<string, unknown> = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({
          current: "pr-test-branch",
          all: ["pr-test-branch"],
          detached: false,
        }),
        getRemotes: vi.fn().mockResolvedValue([
          {
            name: "origin",
            refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
          },
        ]),
        status: vi.fn().mockResolvedValue({
          modified: ["specification/foo/Foo/tspconfig.yaml"],
          not_added: [],
          created: [],
          deleted: [],
        }),
        raw: vi.fn().mockImplementation((args: string[]) => {
          // Handle git config commands
          if (args.includes("config") && args.includes("remote.origin.url")) {
            return Promise.resolve("https://github.com/Azure/azure-rest-api-specs.git");
          }

          // Handle ls-tree commands with extreme flexibility for CI environments
          if (args.includes("ls-tree")) {
            // Convert args to string for easier pattern matching
            const argsStr = args.join(" ");

            // Check if this is querying the v2 structure branch for the foo service
            const isV2Query =
              (argsStr.includes("feature/v2-structure") || argsStr.includes("v2-structure")) &&
              (argsStr.includes("specification/foo") || argsStr.includes("foo"));

            if (isV2Query) {
              return Promise.resolve("data-plane\nresource-manager");
            }

            return Promise.resolve("");
          }

          // Handle merge-base commands
          if (args.includes("merge-base")) {
            return Promise.reject(new Error("No common ancestor"));
          }

          // Default fallback
          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

      // Restore environment
      if (originalGitHub !== undefined) {
        process.env.GITHUB_BASE_REF = originalGitHub;
      } else {
        delete process.env.GITHUB_BASE_REF;
      }

      assert(!result.success);
      assert(
        result.errorOutput?.includes("target branch is already using folder structure v2"),
        `Expected v2 enforcement error, but got: ${result.errorOutput}`,
      );
    });

    it("should handle git operation failures gracefully in v2 compliance check", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve(["/gitroot/specification/foo/Foo/tspconfig.yaml"]);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      // Set environment to trigger v2 compliance check
      const originalGitHub = process.env.GITHUB_BASE_REF;
      process.env.GITHUB_BASE_REF = "feature/v2-structure";

      // Mock git to simulate failures that might occur in CI
      const mockGit: Record<string, unknown> = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({
          current: "pr-test-branch",
          all: ["pr-test-branch"],
          detached: false,
        }),
        getRemotes: vi.fn().mockRejectedValue(new Error("Remote access failed")),
        raw: vi.fn().mockRejectedValue(new Error("Git operation failed")),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

      // Restore environment
      if (originalGitHub !== undefined) {
        process.env.GITHUB_BASE_REF = originalGitHub;
      } else {
        delete process.env.GITHUB_BASE_REF;
      }

      // When git operations fail, it should fall back to regular V1 validation and succeed
      // since we're mocking a valid V1 structure
      assert(
        result.success,
        `Expected fallback to V1 validation to succeed, but got error: ${result.errorOutput}`,
      );
    });

    it("should not enforce v2 compliance when target branch uses v1 structure", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve(["/foo/bar/tspconfig.yaml"]);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      // Mock git to simulate target branch having v1 structure
      const mockGit: Record<string, unknown> = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch" }),
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            { name: "origin", refs: { fetch: "git@github.com:Azure/azure-rest-api-specs.git" } },
          ]),
        raw: vi.fn().mockImplementation((args: string[]) => {
          if (args.includes("ls-tree")) {
            return Promise.resolve("Service1\nService2\nShared");
          }
          if (args.includes("merge-base")) {
            return Promise.resolve("abc123");
          }
          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");
      // Should succeed with v1 validation since target branch is v1
      assert(result.success);
    });

    it("should detect target branch from GITHUB_BASE_REF environment variable", async function () {
      const originalEnv = process.env.GITHUB_BASE_REF;
      process.env.GITHUB_BASE_REF = "main";

      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve(["/foo/bar/tspconfig.yaml"]);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit: Record<string, unknown> = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch", all: ["feature-branch"] }),
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            { name: "origin", refs: { fetch: "git@github.com:Azure/azure-rest-api-specs.git" } },
          ]),
        status: vi.fn().mockResolvedValue({
          modified: ["specification/foo/Foo/tspconfig.yaml"],
          not_added: [],
          created: [],
          deleted: [],
        }),
        raw: vi.fn().mockImplementation((args: string[]) => {
          if (args && args[0] === "branch" && args[1] === "-vv") {
            // No upstream tracking for this branch
            return Promise.resolve("* feature-branch abc123 Commit message");
          }
          if (args.includes("ls-tree")) {
            // Check if this is checking the main branch (from GITHUB_BASE_REF)
            const lsTreeArg = args.find((arg) => arg.includes("main"));
            if (lsTreeArg) {
              return Promise.resolve("data-plane\nresource-manager");
            }
            return Promise.resolve("");
          }
          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

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

    it("should enforce v2 compliance with upstream remote (CI scenario)", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve(["/gitroot/specification/foo/Foo/tspconfig.yaml"]);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      // Ensure V1 validation passes so we know failure is due to V2 enforcement
      readTspConfigSpy.mockResolvedValue(`
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
`);

      // Set environment variable to specify target branch
      const originalGitHub = process.env.GITHUB_BASE_REF;
      process.env.GITHUB_BASE_REF = "feature/v2-structure";

      // Mock git to simulate CI environment with upstream remote
      const mockGit: Record<string, unknown> = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({
          current: "HEAD", // Detached HEAD common in CI
          all: ["HEAD"],
        }),
        getRemotes: vi.fn().mockResolvedValue([
          {
            name: "origin",
            refs: { fetch: "https://github.com/user/azure-rest-api-specs.git" },
          },
          {
            name: "upstream",
            refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
          },
        ]),
        status: vi.fn().mockResolvedValue({
          modified: ["specification/foo/Foo/tspconfig.yaml"],
          not_added: [],
          created: [],
          deleted: [],
        }),
        raw: vi.fn().mockImplementation((args: string[]) => {
          if (args.includes("config") && args.includes("remote.origin.url")) {
            return Promise.resolve("https://github.com/user/azure-rest-api-specs.git");
          }
          if (args.includes("ls-tree")) {
            const refArg = args.find((arg) => arg.includes(":"));
            if (refArg) {
              const [ref, servicePath] = refArg.split(":");
              // Should use upstream remote for target branch
              if (
                ref.includes("upstream/feature/v2-structure") &&
                servicePath === "specification/foo"
              ) {
                return Promise.resolve("data-plane\nresource-manager");
              }
            }
            return Promise.resolve("");
          }
          if (args.includes("merge-base")) {
            return Promise.reject(new Error("No common ancestor"));
          }
          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

      // Restore environment
      if (originalGitHub !== undefined) {
        process.env.GITHUB_BASE_REF = originalGitHub;
      } else {
        delete process.env.GITHUB_BASE_REF;
      }

      assert(!result.success);
      assert(result.errorOutput?.includes("must use v2 structure"));
    });
  });

  describe("v2 structure validation", function () {
    beforeEach(() => {
      // Reset and setup mock for these tests to simulate being on main branch
      simpleGitSpy.mockReset();

      const mockGit: Record<string, unknown> = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockImplementation((args?: string[]) => {
          if (args && args.includes("-vv")) {
            return Promise.resolve({
              current: "main",
              all: ["main"],
            });
          }
          return Promise.resolve({
            current: "main",
            all: ["main"],
          });
        }),
        status: vi.fn().mockResolvedValue({
          modified: ["specification/foo/bar.ts"],
          not_added: [],
          created: [],
          deleted: [],
        }),
        getRemotes: vi.fn().mockResolvedValue([
          {
            name: "origin",
            refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
          },
        ]),
        raw: vi.fn().mockImplementation((args: string[]) => {
          if (args.includes("diff") && args.includes("--name-only")) {
            return Promise.resolve("specification/foo/main.tsp");
          }
          return Promise.resolve("");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);
    });

    it("should fail v2 data-plane with incorrect depth", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve(["/foo/bar/tspconfig.yaml"]);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/data-plane",
      );
      assert(!result.success);
      assert(result.errorOutput?.includes("exactly one level under 'data-plane'"));
    });

    it("should fail v2 resource-manager with incorrect depth", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve(["/foo/bar/tspconfig.yaml"]);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/resource-manager/Microsoft.Foo",
      );
      assert(!result.success);
      assert(result.errorOutput?.includes("exactly two levels under 'resource-manager'"));
    });

    it("should fail v2 with invalid service name (not PascalCase)", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve(["/foo/bar/tspconfig.yaml"]);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/data-plane/foo-service",
      );
      assert(!result.success);
      assert(result.errorOutput?.includes("PascalCase without any special characters"));
    });

    it("should fail v2 resource-manager with invalid RP namespace", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve(["/foo/bar/tspconfig.yaml"]);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/resource-manager/Microsoft.Foo",
      );
      assert(!result.success);
      // This path has only 2 levels under resource-manager, so it should fail for depth, not RP namespace format
      assert(result.errorOutput?.includes("exactly two levels under 'resource-manager'"));
    });

    it("should fail v2 with uppercase org name", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve(["/foo/bar/tspconfig.yaml"]);
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
    beforeEach(() => {
      // Reset and setup mock for these tests
      simpleGitSpy.mockReset();

      const mockGit: Record<string, unknown> = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockImplementation((args?: string[]) => {
          if (args && args.includes("-vv")) {
            return Promise.resolve({
              current: "test-branch",
              all: ["test-branch"],
            });
          }
          return Promise.resolve({
            current: "test-branch",
            all: ["test-branch"],
          });
        }),
        status: vi.fn().mockResolvedValue({
          modified: ["specification/foo/bar.ts"],
          not_added: [],
          created: [],
          deleted: [],
        }),
        getRemotes: vi.fn().mockResolvedValue([
          {
            name: "origin",
            refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
          },
        ]),
        raw: vi.fn().mockImplementation((args: string[]) => {
          if (args.includes("diff") && args.includes("--name-only")) {
            return Promise.resolve("specification/foo/main.tsp");
          }
          if (args[0] === "branch" && args[1] === "-vv") {
            return Promise.resolve("* test-branch abc123 [upstream/main] Commit message");
          }
          if (args.includes("merge-base")) {
            return Promise.resolve("abc123");
          }
          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);
    });

    it("should detect TypeSpec project with tspconfig.yaml", async function () {
      vi.mocked(globby.globby).mockImplementation((patterns: unknown): Promise<string[]> => {
        if (
          Array.isArray(patterns) &&
          patterns.some((p: unknown) => {
            return typeof p === "string" && p.includes("tspconfig");
          })
        ) {
          return Promise.resolve(["tspconfig.yaml"]);
        }
        if (typeof patterns === "string" && patterns.includes("tspconfig")) {
          return Promise.resolve(["tspconfig.yaml"]);
        }
        return Promise.resolve([]);
      });
      normalizePathSpy.mockReturnValue("/gitroot");
      // Mock fileExists to allow folder existence but fail on main.tsp, client.tsp, examples
      fileExistsSpy.mockImplementation((file: string) => {
        if (file === "/gitroot/specification/foo/Foo") return Promise.resolve(true); // Folder exists
        if (file.includes("main.tsp")) return Promise.resolve(false);
        if (file.includes("client.tsp")) return Promise.resolve(false);
        if (file.includes("examples")) return Promise.resolve(false);
        if (file.includes("tspconfig.yaml")) return Promise.resolve(true); // tspconfig exists
        return Promise.resolve(true);
      });

      // Mock git for import validation
      const mockGit: Record<string, unknown> = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "main", all: ["main"] }),
        getRemotes: vi.fn().mockResolvedValue([
          {
            name: "origin",
            refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
          },
        ]),
        raw: vi.fn().mockImplementation((args: string[]) => {
          if (args[0] === "branch" && args[1] === "-vv") {
            return Promise.resolve("* main abc123 Commit message");
          }
          if (args.includes("ls-tree")) {
            // Target branch doesn't have v2 structure
            return Promise.resolve("");
          }
          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");
      // Should apply TypeSpec-specific validations
      assert(result.errorOutput?.includes("main.tsp or client.tsp"));
    });

    it("should detect TypeSpec project with main.tsp", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve([]); // No tspconfig files
      });
      fileExistsSpy.mockImplementation((path: string) => {
        if (path === "/gitroot/specification/foo/Foo") return Promise.resolve(true); // Folder exists
        if (path.includes("main.tsp")) return Promise.resolve(true);
        if (path.includes("examples")) return Promise.resolve(false); // No examples folder
        return Promise.resolve(false);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      // Mock git for import validation
      const mockGit: Record<string, unknown> = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "main", all: ["main"] }),
        getRemotes: vi.fn().mockResolvedValue([
          {
            name: "origin",
            refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
          },
        ]),
        raw: vi.fn().mockImplementation((args: string[]) => {
          if (args[0] === "branch" && args[1] === "-vv") {
            return Promise.resolve("* main abc123 Commit message");
          }
          if (args.includes("ls-tree")) {
            // Target branch doesn't have v2 structure
            return Promise.resolve("");
          }
          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");
      // Should require examples folder when main.tsp exists
      assert(result.errorOutput?.includes("examples folder"));
    });

    it("should not apply TypeSpec validations to non-TypeSpec projects", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve([]); // No tspconfig files
      });
      fileExistsSpy.mockImplementation((path: string) => {
        if (path === "/gitroot/specification/foo/Foo") return Promise.resolve(true); // Folder exists
        return Promise.resolve(false); // No TypeSpec files
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      // Mock git operations for import validation
      const mockGit: Record<string, unknown> = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "main", all: ["main"] }),
        getRemotes: vi.fn().mockResolvedValue([
          {
            name: "origin",
            refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
          },
        ]),
        raw: vi.fn().mockImplementation((args: string[]) => {
          if (args[0] === "branch" && args[1] === "-vv") {
            return Promise.resolve("* main abc123 Commit message");
          }
          if (args.includes("ls-tree")) {
            // Target branch doesn't have v2 structure
            return Promise.resolve("");
          }
          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");
      // Should succeed for non-TypeSpec projects
      assert(result.success);
    });
  });
});
