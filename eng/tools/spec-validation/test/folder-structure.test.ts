import { mockAll, mockFolder } from "./mocks.js";
mockAll();

import { contosoTspConfig } from "@azure-tools/specs-shared/test/examples";
import * as globby from "globby";
import { strict as assert } from "node:assert";
import type { SimpleGit } from "simple-git";
import { afterEach, beforeEach, describe, it, MockInstance, vi } from "vitest";
import { FolderStructureRule } from "../src/rules/folder-structure.js";

import * as utils from "../src/utils.js";

function createGitMock(lsTreeOutput = "Foo\nFoo.Management\n"): Record<string, unknown> {
  return {
    revparse: vi.fn().mockResolvedValue("/gitroot"),
    fetch: vi.fn().mockResolvedValue(undefined),
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
      if (args.includes("diff") && args.includes("--name-only")) {
        return Promise.resolve("specification/foo/main.tsp\nspecification/foo/tspconfig.yaml");
      }
      if (args.includes("config")) {
        return Promise.resolve("https://github.com/Azure/azure-rest-api-specs.git");
      }
      if (args.includes("for-each-ref")) {
        return Promise.resolve("refs/remotes/origin/main\n");
      }
      if (args.includes("ls-tree")) {
        return Promise.resolve(lsTreeOutput);
      }
      if (args.includes("merge-base")) {
        return Promise.resolve("abc123");
      }
      return Promise.resolve("main");
    }),
  };
}

let originalGithubBaseRef = process.env.GITHUB_BASE_REF;
let originalSystemPullRequestTargetBranch = process.env.SYSTEM_PULLREQUEST_TARGETBRANCH;

beforeEach(() => {
  originalGithubBaseRef = process.env.GITHUB_BASE_REF;
  originalSystemPullRequestTargetBranch = process.env.SYSTEM_PULLREQUEST_TARGETBRANCH;
  delete process.env.GITHUB_BASE_REF;
  delete process.env.SYSTEM_PULLREQUEST_TARGETBRANCH;
});

afterEach(() => {
  if (originalGithubBaseRef === undefined) {
    delete process.env.GITHUB_BASE_REF;
  } else {
    process.env.GITHUB_BASE_REF = originalGithubBaseRef;
  }

  if (originalSystemPullRequestTargetBranch === undefined) {
    delete process.env.SYSTEM_PULLREQUEST_TARGETBRANCH;
  } else {
    process.env.SYSTEM_PULLREQUEST_TARGETBRANCH = originalSystemPullRequestTargetBranch;
  }
});

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
    const defaultMockGit = createGitMock();
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

  it("should fetch target branch ref when missing", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/bar/tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");

    type GitMock = {
      raw: MockInstance<(args: string[]) => Promise<string>>;
      fetch: MockInstance<
        (remote?: string, branch?: string, options?: string[]) => Promise<void> | void
      >;
    };

    const gitMock = createGitMock() as unknown as GitMock;

    // First show-ref says missing, after fetch it exists.
    let hasRef = false;
    gitMock.fetch.mockImplementation(() => {
      hasRef = true;
    });
    gitMock.raw.mockImplementation((args: string[]) => {
      if (args.includes("for-each-ref")) {
        return hasRef ? Promise.resolve("refs/remotes/origin/main\n") : Promise.resolve("");
      }
      if (args.includes("diff") && args.includes("--name-only")) {
        return Promise.resolve("specification/foo/main.tsp\nspecification/foo/tspconfig.yaml");
      }
      if (args.includes("config")) {
        return Promise.resolve("https://github.com/Azure/azure-rest-api-specs.git");
      }
      if (args.includes("merge-base")) {
        return Promise.resolve("abc123");
      }
      if (args.includes("ls-tree")) {
        return Promise.resolve("Foo\n");
      }
      return Promise.resolve("main");
    });

    simpleGitSpy.mockReturnValue(gitMock as unknown as SimpleGit);
    process.env.GITHUB_BASE_REF = "main";

    const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");
    assert(result.success);
    assert(gitMock.fetch.mock.calls.length >= 1);
  });

  it("should not use unrelated diff changes for service lookup", async function () {
    vi.mocked(globby.globby).mockImplementation((patterns) =>
      Array.isArray(patterns) && String(patterns[0]).includes("tspconfig")
        ? Promise.resolve(["/foo/bar/tspconfig.yaml"])
        : Promise.resolve(["/foo/bar/main.tsp"]),
    );
    normalizePathSpy.mockReturnValue("/gitroot");
    simpleGitSpy.mockReset();

    const mockGit: Record<string, unknown> = {
      revparse: vi.fn().mockResolvedValue("/gitroot"),
      fetch: vi.fn().mockResolvedValue(undefined),
      branch: vi.fn().mockResolvedValue({ current: "feature-branch", all: ["feature-branch"] }),
      status: vi.fn().mockResolvedValue({ modified: [], not_added: [], created: [], deleted: [] }),
      getRemotes: vi
        .fn()
        .mockResolvedValue([
          { name: "origin", refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" } },
        ]),
      raw: vi.fn().mockImplementation((args: string[]) => {
        if (args.includes("config")) {
          return Promise.resolve("https://github.com/Azure/azure-rest-api-specs.git");
        }
        if (args.includes("for-each-ref")) {
          return Promise.resolve("refs/remotes/origin/main\n");
        }
        if (args.includes("merge-base")) {
          return Promise.resolve("abc123");
        }
        if (args.includes("diff") && args.includes("--name-only")) {
          // Diff contains changes under a different service, not the folder being validated.
          return Promise.resolve("specification/other/data-plane/Other/main.tsp\n");
        }
        if (args.includes("ls-tree")) {
          // Target branch has the validated service in v2 layout.
          const refArg = args[1] ?? "";
          if (refArg.includes("origin/main:specification/foo/data-plane/Foo")) {
            return Promise.resolve("main.tsp\ntspconfig.yaml\n");
          }
          return Promise.reject(new Error("Path not found"));
        }
        return Promise.resolve("main");
      }),
    };

    simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);
    process.env.GITHUB_BASE_REF = "main";

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/data-plane/Foo",
    );

    assert(result.success, `Expected success, got: ${result.errorOutput}`);
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
    simpleGitSpy.mockReturnValue(createGitMock("") as unknown as SimpleGit);

    const result = await new FolderStructureRule().execute("/gitroot/specification/foo/data-plane");
    assert(result.errorOutput);
    assert(result.errorOutput.includes("exactly one level under"));
  });

  it("should fail if second level folder is resource-manager", async function () {
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve(["/foo/bar/tspconfig.yaml"]));
    normalizePathSpy.mockReturnValue("/gitroot");
    simpleGitSpy.mockReturnValue(createGitMock("") as unknown as SimpleGit);

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
    simpleGitSpy.mockReturnValue(createGitMock("") as unknown as SimpleGit);

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
    simpleGitSpy.mockReturnValue(createGitMock("") as unknown as SimpleGit);

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
    assert(result.errorOutput?.includes("two levels under 'resource-manager'"));
  });

  it("v2: should succeed with data-plane", async function () {
    vi.mocked(globby.globby).mockImplementation((patterns) =>
      patterns[0].includes("tspconfig")
        ? Promise.resolve(["tspconfig.yaml"])
        : Promise.resolve(["main.tsp"]),
    );
    normalizePathSpy.mockReturnValue("/gitroot");
    simpleGitSpy.mockReturnValue(createGitMock("") as unknown as SimpleGit);

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
    simpleGitSpy.mockReturnValue(createGitMock("") as unknown as SimpleGit);

    const result = await new FolderStructureRule().execute(
      "/gitroot/specification/foo/resource-manager/Microsoft.Foo/FooManagement",
    );

    assert(result.success);
  });

  describe("v2 compliance enforcement", function () {
    let originalGlobalMock: unknown;

    beforeEach(() => {
      // Save the global mock before modifying it
      originalGlobalMock = simpleGitSpy.getMockImplementation();

      // Reset the mock for these specific tests
      simpleGitSpy.mockReset();
    });

    afterEach(() => {
      // Restore the original global mock to prevent state pollution
      if (originalGlobalMock && typeof originalGlobalMock === "function") {
        simpleGitSpy.mockImplementation(originalGlobalMock as (...args: unknown[]) => unknown);
      } else {
        // Fallback: re-setup the global mock
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
              detached: false,
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
              return Promise.resolve(
                "specification/foo/main.tsp\nspecification/foo/tspconfig.yaml",
              );
            }
            return Promise.resolve("");
          }),
        };
        simpleGitSpy.mockReturnValue(defaultMockGit as unknown as SimpleGit);
      }
    });

    it("should enforce v2 compliance when adding new service (service doesn't exist in target branch)", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve(["/gitroot/specification/newservice/NewService/tspconfig.yaml"]);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      // Ensure V1 validation passes so we know failure is due to V2 enforcement
      readTspConfigSpy.mockResolvedValue(`
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
`);

      // Mock git to simulate new service being added (doesn't exist in target branch)
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
          modified: ["specification/newservice/NewService/tspconfig.yaml"],
          not_added: [],
          created: [],
          deleted: [],
        }),
        raw: vi.fn().mockImplementation((args: string[]) => {
          // Handle git config commands
          if (args.includes("config") && args.includes("remote.origin.url")) {
            return Promise.resolve("https://github.com/Azure/azure-rest-api-specs.git");
          }

          // Handle merge-base commands to return a target branch
          if (args.includes("merge-base")) {
            return Promise.resolve("abc123");
          }

          // Handle rev-parse to return the target branch name
          if (args.includes("rev-parse") && args.includes("--abbrev-ref")) {
            return Promise.resolve("main");
          }

          if (args.includes("diff") && args.includes("--name-only")) {
            return Promise.resolve("specification/newservice/NewService/tspconfig.yaml");
          }

          // Handle ls-tree commands - service doesn't exist in target branch
          if (args.includes("ls-tree")) {
            const refArg = args.find((arg) => arg.includes(":"));
            if (refArg?.includes("specification/newservice/NewService")) {
              return Promise.reject(new Error("Path not found"));
            }
            return Promise.resolve("");
          }

          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/newservice/NewService",
      );

      assert(!result.success);
      assert(
        result.errorOutput?.includes("must use v2 structure"),
        `Expected v2 enforcement error for new service, but got: ${result.errorOutput}`,
      );
    });

    it("should enforce v2 compliance when existing service in target branch uses v2 structure", async function () {
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

      // Mock git to simulate existing service with v2 structure in target branch
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

          // Handle merge-base commands to return a target branch
          if (args.includes("merge-base")) {
            return Promise.resolve("abc123");
          }

          // Handle rev-parse to return the target branch name
          if (args.includes("rev-parse") && args.includes("--abbrev-ref")) {
            return Promise.resolve("main");
          }

          if (args.includes("diff") && args.includes("--name-only")) {
            return Promise.resolve("specification/foo/data-plane/Foo/tspconfig.yaml");
          }

          // Handle ls-tree commands - existing service has v2 structure
          if (args.includes("ls-tree")) {
            const argsStr = args.join(" ");
            if (argsStr.includes("specification/foo")) {
              return Promise.resolve("data-plane\nresource-manager");
            }
            return Promise.resolve("");
          }

          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

      assert(!result.success);
      assert(
        result.errorOutput?.includes("must use v2 structure"),
        `Expected v2 enforcement error for existing v2 service, but got: ${result.errorOutput}`,
      );
    });

    it("should handle git operation failures gracefully in v2 compliance check", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve(["/gitroot/specification/foo/Foo/tspconfig.yaml"]);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

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
        status: vi.fn().mockResolvedValue({
          modified: ["specification/foo/bar.ts"],
          not_added: [],
          created: [],
          deleted: [],
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

      // When git operations fail completely, it should enforce v2 for new services (fallback behavior)
      assert(!result.success);
      assert(
        result.errorOutput?.includes("must use v2 structure"),
        `Expected v2 enforcement on git failure for potential new service, but got: ${result.errorOutput}`,
      );
    });

    it("should allow v1 structure when existing service in target branch uses v1 structure", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve(["/gitroot/specification/foo/Foo/tspconfig.yaml"]);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      // Mock git to simulate existing service with v1 structure in target branch
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
          // Handle merge-base commands
          if (args.includes("merge-base")) {
            return Promise.resolve("abc123");
          }

          // Handle rev-parse commands
          if (args.includes("rev-parse") && args.includes("--abbrev-ref")) {
            return Promise.resolve("main");
          }

          // Handle ls-tree commands - existing service has v1 structure (no data-plane/resource-manager)
          if (args.includes("ls-tree")) {
            const argsStr = args.join(" ");
            if (argsStr.includes("specification/foo")) {
              return Promise.resolve("Service1\nService2\nShared");
            }
            return Promise.resolve("");
          }

          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");
      // Should succeed with v1 validation since existing service uses v1 structure
      assert(result.success);
    });

    it("should prevent mixing v1 and v2 structures in the same service", async function () {
      vi.mocked(globby.globby).mockImplementation(() => {
        return Promise.resolve(["/gitroot/specification/foo/data-plane/FooData/tspconfig.yaml"]);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      // Mock git to simulate existing service with v1 structure in target branch
      const mockGit: Record<string, unknown> = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch", all: ["feature-branch"] }),
        getRemotes: vi
          .fn()
          .mockResolvedValue([
            { name: "origin", refs: { fetch: "git@github.com:Azure/azure-rest-api-specs.git" } },
          ]),
        status: vi.fn().mockResolvedValue({
          modified: ["specification/foo/data-plane/FooData/tspconfig.yaml"],
          not_added: [],
          created: [],
          deleted: [],
        }),
        raw: vi.fn().mockImplementation((args: string[]) => {
          // Handle merge-base commands
          if (args.includes("merge-base")) {
            return Promise.resolve("abc123");
          }

          // Handle rev-parse commands
          if (args.includes("rev-parse") && args.includes("--abbrev-ref")) {
            return Promise.resolve("main");
          }

          if (args.includes("diff") && args.includes("--name-only")) {
            return Promise.resolve("specification/foo/data-plane/FooData/tspconfig.yaml");
          }

          // Handle ls-tree commands - existing service has v1 structure but PR tries to add v2
          if (args.includes("ls-tree")) {
            const refArg = args.find((arg) => arg.includes(":"));
            if (!refArg) {
              return Promise.resolve("");
            }
            const [, servicePath] = refArg.split(":");
            if (servicePath === "specification/foo/data-plane/FooData") {
              return Promise.reject(new Error("Path not found"));
            }
            if (servicePath === "specification/foo/FooData") {
              return Promise.resolve("FooData");
            }
            if (servicePath === "specification/foo") {
              return Promise.resolve("Service1\nService2\nShared");
            }
            return Promise.resolve("");
          }

          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute(
        "/gitroot/specification/foo/data-plane/FooData",
      );
      // Should fail because PR is trying to add v2 structure to existing v1 service
      assert(!result.success);
      assert(
        result.errorOutput?.includes(
          "uses v1 structure, but this PR is trying to add v2 structure",
        ),
        `Expected mixed structure error, but got: ${result.errorOutput}`,
      );
    });

    it("should detect target branch from GITHUB_BASE_REF environment variable", async function () {
      const originalBaseRef = process.env.GITHUB_BASE_REF;
      process.env.GITHUB_BASE_REF = "refs/heads/main";

      try {
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
            // Handle merge-base operations to simulate finding target branch
            if (args.includes("merge-base")) {
              return Promise.resolve("abc123");
            }

            // Handle rev-parse to return target branch
            if (args.includes("rev-parse") && args.includes("--abbrev-ref")) {
              return Promise.resolve("main");
            }

            if (args.includes("diff") && args.includes("--name-only")) {
              return Promise.resolve("specification/foo/Foo/tspconfig.yaml");
            }

            // Handle ls-tree to check target branch structure
            if (args.includes("ls-tree")) {
              const refArg = args.find((arg) => arg.includes(":"));
              if (refArg?.includes("specification/foo/Foo")) {
                return Promise.reject(new Error("Path not found"));
              }
              return Promise.resolve("");
            }

            return Promise.resolve("main");
          }),
        };
        simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

        const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

        assert(!result.success);
        assert(result.errorOutput?.includes("must use v2 structure"));
      } finally {
        if (originalBaseRef === undefined) {
          delete process.env.GITHUB_BASE_REF;
        } else {
          process.env.GITHUB_BASE_REF = originalBaseRef;
        }
      }
    });

    it("should enforce v2 compliance when SYSTEM_PULLREQUEST_TARGETBRANCH has refs prefix", async function () {
      const originalSystemBranch = process.env.SYSTEM_PULLREQUEST_TARGETBRANCH;
      process.env.SYSTEM_PULLREQUEST_TARGETBRANCH = "refs/heads/main";

      try {
        vi.mocked(globby.globby).mockImplementation(() => {
          return Promise.resolve(["/gitroot/specification/newservice/NewService/tspconfig.yaml"]);
        });
        normalizePathSpy.mockReturnValue("/gitroot");

        readTspConfigSpy.mockResolvedValue(`
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
`);

        const mockGit: Record<string, unknown> = {
          revparse: vi.fn().mockResolvedValue("/gitroot"),
          branch: vi.fn().mockResolvedValue({
            current: "feature-branch",
            all: ["feature-branch"],
            detached: false,
          }),
          getRemotes: vi.fn().mockResolvedValue([
            {
              name: "origin",
              refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
            },
          ]),
          status: vi.fn().mockResolvedValue({
            modified: ["specification/newservice/NewService/tspconfig.yaml"],
            not_added: [],
            created: [],
            deleted: [],
          }),
          raw: vi.fn().mockImplementation((args: string[]) => {
            if (args.includes("config") && args.includes("remote.origin.url")) {
              return Promise.resolve("https://github.com/Azure/azure-rest-api-specs.git");
            }

            if (args.includes("diff") && args.includes("--name-only")) {
              return Promise.resolve("specification/newservice/NewService/tspconfig.yaml");
            }

            if (args.includes("ls-tree")) {
              const refArg = args.find((arg) => arg.includes(":"));
              if (refArg?.includes("specification/newservice/NewService")) {
                return Promise.reject(new Error("Path not found"));
              }
            }

            if (args.includes("merge-base")) {
              return Promise.resolve("abc123");
            }

            return Promise.resolve("main");
          }),
        };

        simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

        const result = await new FolderStructureRule().execute(
          "/gitroot/specification/newservice/NewService",
        );

        assert(!result.success);
        assert(result.errorOutput?.includes("must use v2 structure"));
      } finally {
        if (originalSystemBranch === undefined) {
          delete process.env.SYSTEM_PULLREQUEST_TARGETBRANCH;
        } else {
          process.env.SYSTEM_PULLREQUEST_TARGETBRANCH = originalSystemBranch;
        }
      }
    });

    it("should not enforce when current branch matches target branch even with refs prefix", async function () {
      const originalSystemBranch = process.env.SYSTEM_PULLREQUEST_TARGETBRANCH;
      process.env.SYSTEM_PULLREQUEST_TARGETBRANCH = "refs/heads/main";

      try {
        vi.mocked(globby.globby).mockImplementation((patterns) =>
          patterns[0].includes("tspconfig")
            ? Promise.resolve(["/gitroot/specification/foo/data-plane/Foo/tspconfig.yaml"])
            : Promise.resolve(["/gitroot/specification/foo/data-plane/Foo/main.tsp"]),
        );
        normalizePathSpy.mockReturnValue("/gitroot");
        readTspConfigSpy.mockResolvedValue(`
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
`);

        const mockGit: Record<string, unknown> = {
          revparse: vi.fn().mockResolvedValue("/gitroot"),
          branch: vi.fn().mockResolvedValue({
            current: "refs/heads/main",
            all: ["refs/heads/main"],
            detached: false,
          }),
          getRemotes: vi.fn().mockResolvedValue([
            {
              name: "origin",
              refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
            },
          ]),
          status: vi.fn().mockResolvedValue({
            modified: ["specification/foo/data-plane/Foo/tspconfig.yaml"],
            not_added: [],
            created: [],
            deleted: [],
          }),
          raw: vi.fn().mockImplementation((args: string[]) => {
            if (args.includes("config") && args.includes("remote.origin.url")) {
              return Promise.resolve("https://github.com/Azure/azure-rest-api-specs.git");
            }
            if (args.includes("diff") && args.includes("--name-only")) {
              return Promise.resolve("specification/foo/data-plane/Foo/tspconfig.yaml");
            }
            return Promise.resolve("main");
          }),
        };

        simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

        const result = await new FolderStructureRule().execute(
          "/gitroot/specification/foo/data-plane/Foo",
        );

        assert(result.success);
      } finally {
        if (originalSystemBranch === undefined) {
          delete process.env.SYSTEM_PULLREQUEST_TARGETBRANCH;
        } else {
          process.env.SYSTEM_PULLREQUEST_TARGETBRANCH = originalSystemBranch;
        }
      }
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
          // Handle git config commands
          if (args.includes("config") && args.includes("remote.origin.url")) {
            return Promise.resolve("https://github.com/user/azure-rest-api-specs.git");
          }

          // Handle merge-base to find target branch
          if (args.includes("merge-base")) {
            return Promise.resolve("abc123");
          }

          // Handle rev-parse for target branch
          if (args.includes("rev-parse") && args.includes("--abbrev-ref")) {
            return Promise.resolve("feature/v2-structure");
          }

          if (args.includes("diff") && args.includes("--name-only")) {
            return Promise.resolve("specification/foo/Foo/tspconfig.yaml");
          }

          // Handle ls-tree commands
          if (args.includes("ls-tree")) {
            const refArg = args.find((arg) => arg.includes(":"));
            if (refArg) {
              const [ref, servicePath] = refArg.split(":");
              if (servicePath === "specification/foo/Foo") {
                return Promise.reject(new Error("Path not found"));
              }
              if (
                ref.includes("upstream/feature/v2-structure") &&
                servicePath === "specification/foo"
              ) {
                return Promise.resolve("data-plane\nresource-manager");
              }
            }
            return Promise.resolve("");
          }

          return Promise.resolve("feature/v2-structure");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

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

    it("should succeed when validating a specification org folder (not a project root)", async function () {
      // This simulates invoking `tsv specification/widget` directly.
      // The folder contains nested TypeSpec projects, but it is not itself a TypeSpec project root.

      // No root tspconfig.* at /gitroot/specification/widget
      vi.mocked(globby.globby).mockImplementation(() => Promise.resolve([]));

      fileExistsSpy.mockImplementation((p: string) => {
        if (p === "/gitroot/specification/widget") return Promise.resolve(true);
        if (p === "/gitroot/specification/widget/tspconfig.yaml") return Promise.resolve(false);
        if (p === "/gitroot/specification/widget/main.tsp") return Promise.resolve(false);
        if (p === "/gitroot/specification/widget/client.tsp") return Promise.resolve(false);
        return Promise.resolve(false);
      });

      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit: Record<string, unknown> = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        fetch: vi.fn().mockResolvedValue(undefined),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch", all: ["feature-branch"] }),
        status: vi
          .fn()
          .mockResolvedValue({ modified: [], not_added: [], created: [], deleted: [] }),
        getRemotes: vi.fn().mockResolvedValue([
          {
            name: "origin",
            refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
          },
        ]),
        raw: vi.fn().mockImplementation((args: string[]) => {
          if (args.includes("for-each-ref")) {
            return Promise.resolve("refs/remotes/origin/main\n");
          }
          if (args.includes("diff") && args.includes("--name-only")) {
            // Any spec change elsewhere should not matter; this folder is not a project root.
            return Promise.resolve("specification/ai/Azure.AI.Projects/suppressions.yaml\n");
          }
          if (args.includes("config")) {
            return Promise.resolve("https://github.com/Azure/azure-rest-api-specs.git");
          }
          if (args.includes("merge-base")) {
            return Promise.resolve("abc123");
          }
          if (args.includes("ls-tree")) {
            // Pretend target branch has v2 under widget; shouldn't cause failure when validating org folder.
            return Promise.resolve("resource-manager\n");
          }
          return Promise.resolve("main");
        }),
      };

      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);
      process.env.GITHUB_BASE_REF = "main";

      const result = await new FolderStructureRule().execute("/gitroot/specification/widget");
      assert(result.success, `Expected success, got: ${result.errorOutput}`);
    });
  });

  describe("v2 enforcement for non-TypeSpec projects", function () {
    it("should enforce v2 structure for new Swagger-only service", async function () {
      // Mock a new Swagger service using v1 structure (no TypeSpec files)
      vi.mocked(globby.globby).mockImplementation(() => Promise.resolve([])); // No TypeSpec files

      fileExistsSpy.mockImplementation((path: string) => {
        if (path === "/gitroot/specification/foo/Foo") return Promise.resolve(true); // Folder exists
        // No TypeSpec files
        return Promise.resolve(false);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit: Record<string, unknown> = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch", all: ["feature-branch"] }),
        getRemotes: vi.fn().mockResolvedValue([
          {
            name: "origin",
            refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
          },
        ]),
        status: vi.fn().mockResolvedValue({
          modified: ["specification/foo/Foo/swagger.json"],
          not_added: [],
          created: [],
          deleted: [],
        }),
        raw: vi.fn().mockImplementation((args: string[]) => {
          if (args[0] === "branch" && args[1] === "-vv") {
            return Promise.resolve("* feature-branch abc123 [origin/main] Commit message");
          }
          if (args.includes("merge-base")) {
            return Promise.resolve("abc123");
          }
          if (args.includes("for-each-ref")) {
            return Promise.resolve("refs/remotes/origin/main\n");
          }
          if (args.includes("diff") && args.includes("--name-only")) {
            return Promise.resolve("specification/foo/Foo/swagger.json");
          }
          if (args.includes("ls-tree")) {
            // New service - doesn't exist in target branch
            return Promise.reject(new Error("path not in tree"));
          }
          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

      // Should enforce v2 structure even for Swagger-only projects
      assert(!result.success);
      assert(
        result.errorOutput?.includes("must use v2 structure"),
        `Expected v2 enforcement for new Swagger service, got: ${result.errorOutput}`,
      );
    });

    it("should allow existing v1 Swagger-only service to remain in v1 structure", async function () {
      // Mock an existing Swagger service using v1 structure
      vi.mocked(globby.globby).mockImplementation(() => Promise.resolve([])); // No TypeSpec files

      fileExistsSpy.mockImplementation((path: string) => {
        if (path === "/gitroot/specification/foo/Foo") return Promise.resolve(true);
        return Promise.resolve(false);
      });
      normalizePathSpy.mockReturnValue("/gitroot");

      const mockGit: Record<string, unknown> = {
        revparse: vi.fn().mockResolvedValue("/gitroot"),
        branch: vi.fn().mockResolvedValue({ current: "feature-branch", all: ["feature-branch"] }),
        getRemotes: vi.fn().mockResolvedValue([
          {
            name: "origin",
            refs: { fetch: "https://github.com/Azure/azure-rest-api-specs.git" },
          },
        ]),
        status: vi.fn().mockResolvedValue({
          modified: ["specification/foo/Foo/swagger.json"],
          not_added: [],
          created: [],
          deleted: [],
        }),
        raw: vi.fn().mockImplementation((args: string[]) => {
          if (args[0] === "branch" && args[1] === "-vv") {
            return Promise.resolve("* feature-branch abc123 [origin/main] Commit message");
          }
          if (args.includes("merge-base")) {
            return Promise.resolve("abc123");
          }
          if (args.includes("for-each-ref")) {
            return Promise.resolve("refs/remotes/origin/main\n");
          }
          if (args.includes("diff") && args.includes("--name-only")) {
            return Promise.resolve("specification/foo/Foo/swagger.json");
          }
          if (args.includes("ls-tree")) {
            // Service exists in target branch with v1 structure
            return Promise.resolve("swagger.json\nreadme.md\n");
          }
          return Promise.resolve("main");
        }),
      };
      simpleGitSpy.mockReturnValue(mockGit as unknown as SimpleGit);

      const result = await new FolderStructureRule().execute("/gitroot/specification/foo/Foo");

      // Should allow v1 structure for existing services
      assert(
        result.success,
        `Expected success for existing v1 Swagger service, got: ${result.errorOutput}`,
      );
    });
  });
});
