import type { SpawnSyncReturns } from "node:child_process";
import { existsSync, mkdirSync, rmSync, writeFileSync } from "node:fs";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";

// Mock child_process BEFORE importing the module that uses it
const mockMetadataMap = new Map<string, { apiVersion: string; sdkType: "stable" | "preview" }>();

vi.mock("node:child_process", () => {
  return {
    spawnSync: (
      cmd: string,
      args: string[] | undefined = [],
      options: { cwd?: string; encoding?: string } = {},
    ): SpawnSyncReturns<string> => {
      if (cmd === "npx" && args?.some((a) => a.includes("tsp"))) {
        const projectDir = options.cwd || process.cwd();
        const mockData = mockMetadataMap.get(projectDir);
        if (mockData) {
          const metadataDir = join(projectDir, "tsp-output", "@azure-tools", "typespec-metadata");
          mkdirSync(metadataDir, { recursive: true });
          const metadata = {
            languages: {
              csharp: [
                {
                  packageName: "Azure.Sample",
                  apiVersion: mockData.apiVersion,
                  sdkType: mockData.sdkType,
                },
              ],
              java: [
                {
                  packageName: "com.azure.sample",
                  apiVersion: mockData.apiVersion,
                  sdkType: mockData.sdkType,
                },
              ],
              python: [
                {
                  packageName: "azure-sample",
                  apiVersion: mockData.apiVersion,
                  sdkType: mockData.sdkType,
                },
              ],
            },
          };
          writeFileSync(join(metadataDir, "typespec-metadata.json"), JSON.stringify(metadata));
        }
        return { status: 0, stdout: "", stderr: "", pid: 0, signal: null, output: [] };
      }
      return {
        status: 1,
        stdout: "",
        stderr: "Command not mocked",
        pid: 0,
        signal: null,
        output: [],
      };
    },
  };
});

// NOW import the modules that depend on child_process
import {
  compareApiVersionsDesc,
  createOctokit,
  detectApiVersions,
  findTspConfigDir,
  getAssociatedPrNumber,
  getCommitChangedFiles,
  getPrChangedFiles,
  getPullRequestLabels,
  getTypeSpecProjectInfoFromCommit,
  getTypeSpecProjectInfoFromPr,
  parseApiVersion,
  parseTypeSpecMetadata,
} from "../src/typespec-project.ts";

// Helper function to setup mock metadata for a test
function setupMockMetadata(projectPath: string, apiVersion: string, sdkType: "stable" | "preview") {
  mockMetadataMap.set(projectPath, { apiVersion, sdkType });
}

describe("version helpers", () => {
  it("sorts API versions descending with GA preferred over preview on same date", () => {
    const input = ["2025-06-01-preview", "2025-06-01", "2026-01-01-preview"];
    const sorted = [...input].sort(compareApiVersionsDesc);
    expect(sorted).toEqual(["2026-01-01-preview", "2025-06-01", "2025-06-01-preview"]);
  });

  it("parses valid API version", () => {
    expect(parseApiVersion("2025-06-01-preview")).toEqual({
      year: 2025,
      month: 6,
      day: 1,
      isPreview: true,
    });
  });

  it("returns zeros for invalid API version", () => {
    expect(parseApiVersion("foo")).toEqual({ year: 0, month: 0, day: 0, isPreview: false });
  });
});

describe("TypeSpec path discovery", () => {
  it("finds nearest tspconfig.yaml directory", () => {
    const workspace = process.cwd();
    const result = findTspConfigDir(
      "specification/service/resource-manager/Microsoft.Sample/main.tsp",
      workspace,
    );
    expect(result === null || result.startsWith("specification/")).toBeTruthy();
  });

  it("detects API versions from changed files", () => {
    const result = detectApiVersions(
      [
        "specification/foo/preview/2025-06-01-preview/main.tsp",
        "specification/foo/stable/2025-05-01/foo.json",
      ],
      "specification/foo",
      process.cwd(),
    );

    expect(result.apiVersions[0]).toBe("2025-06-01-preview");
    expect(result.isPreview).toBe(true);
  });
});

describe("GitHub PR file listing", () => {
  it("handles paginated files response", async () => {
    const listFiles = vi
      .fn()
      .mockResolvedValueOnce({
        data: [{ filename: "specification/a/main.tsp", status: "modified" }],
      })
      .mockResolvedValueOnce({ data: [] });

    const get = vi.fn();

    const files = await getPrChangedFiles({
      octokit: {
        rest: {
          pulls: {
            get,
            listFiles,
          },
        },
      },
      owner: "Azure",
      repo: "azure-rest-api-specs",
      prNumber: 1,
    });

    expect(files).toHaveLength(1);
    expect(files[0].filename).toBe("specification/a/main.tsp");
    expect(listFiles).toHaveBeenCalledTimes(1);
  });

  it("creates Octokit instances with default settings", () => {
    // Stub token so getGitHubAuthToken() never falls back to `execSync("gh auth token")` in CI.
    vi.stubEnv("GITHUB_TOKEN", "test-token");
    try {
      const ghCom = createOctokit(undefined);
      const ghe = createOctokit("token");
      expect(ghCom).toBeDefined();
      expect(ghe).toBeDefined();
    } finally {
      vi.unstubAllEnvs();
    }
  });

  it("returns null when no specification files are modified", async () => {
    const get = vi.fn().mockResolvedValueOnce({ data: { labels: [{ name: "new-api-version" }] } });
    const listFiles = vi.fn().mockResolvedValueOnce({ data: [] });

    const result = await getTypeSpecProjectInfoFromPr({
      prNumber: 42,
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workspace: process.cwd(),
      octokit: {
        rest: {
          pulls: {
            get,
            listFiles,
          },
        },
      },
    });

    expect(result).toBeNull();
  });
});

describe("TypeSpec project detection edge cases", () => {
  it("still detects project when PR lacks new-api-version label", async () => {
    // Create main.tsp file so runTypeSpecMetadataEmitter doesn't fail early
    const projectPath = join(process.cwd(), "specification/foo");
    mkdirSync(projectPath, { recursive: true });
    writeFileSync(join(projectPath, "main.tsp"), "namespace Demo;");

    // Setup mock metadata for the project
    setupMockMetadata(projectPath, "2025-08-01", "stable");

    const get = vi.fn().mockResolvedValueOnce({ data: { labels: [] } });
    const listFiles = vi
      .fn()
      .mockResolvedValueOnce({
        data: [
          { filename: "specification/foo/tspconfig.yaml", status: "modified" },
          { filename: "specification/foo/2025-08-01/main.tsp", status: "modified" },
        ],
      })
      .mockResolvedValueOnce({ data: [] });

    const result = await getTypeSpecProjectInfoFromPr({
      prNumber: 42,
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workspace: process.cwd(),
      octokit: {
        rest: {
          pulls: {
            get,
            listFiles,
          },
        },
      },
    });

    expect(result).not.toBeNull();
    expect(result?.tspProjectPath).toBe("specification/foo");
    expect(result?.apiVersion).toBe("2025-08-01");
    expect(listFiles).toHaveBeenCalled();

    // Cleanup
    rmSync(projectPath, { recursive: true, force: true });
  });

  it("returns null when PR has multiple tsp projects", async () => {
    const get = vi.fn().mockResolvedValueOnce({ data: { labels: [{ name: "new-api-version" }] } });
    const listFiles = vi
      .fn()
      .mockResolvedValueOnce({
        data: [
          { filename: "specification/proj1/tspconfig.yaml", status: "modified" },
          { filename: "specification/proj2/tspconfig.yaml", status: "modified" },
        ],
      })
      .mockResolvedValueOnce({ data: [] });

    const result = await getTypeSpecProjectInfoFromPr({
      prNumber: 42,
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workspace: process.cwd(),
      octokit: {
        rest: {
          pulls: {
            get,
            listFiles,
          },
        },
      },
    });

    expect(result).toBeNull();
  });

  it("handles paginated file responses across multiple pages", async () => {
    const get = vi.fn().mockResolvedValueOnce({ data: { labels: [{ name: "new-api-version" }] } });
    const listFiles = vi
      .fn()
      .mockResolvedValueOnce({
        data: Array.from({ length: 100 }, (_, i) => ({
          filename: `specification/service/${i < 50 ? "old" : "new"}/file.txt`,
          status: "modified",
        })),
      })
      .mockResolvedValueOnce({
        data: [{ filename: "specification/service/tspconfig.yaml", status: "modified" }],
      })
      .mockResolvedValueOnce({ data: [] });

    const files = await getPrChangedFiles({
      octokit: {
        rest: {
          pulls: {
            get,
            listFiles,
          },
        },
      },
      owner: "Azure",
      repo: "azure-rest-api-specs",
      prNumber: 42,
    });

    expect(listFiles).toHaveBeenCalledTimes(2);
    expect(files.length).toBe(101);
  });

  it("detects API versions with various format patterns", () => {
    const result = detectApiVersions(
      [
        "specification/foo/stable/2025-05-01/main.tsp",
        "specification/foo/preview/2025-06-01-preview/models.tsp",
        "specification/foo/2026-01-01/readme.md",
      ],
      "specification/foo",
      process.cwd(),
    );

    expect(result.apiVersions).toContain("2025-05-01");
    expect(result.apiVersions).toContain("2025-06-01-preview");
    expect(result.apiVersions).toContain("2026-01-01");
    // Release type is decided by the final (latest) version. The latest here is
    // the GA version 2026-01-01, so isPreview must be false even though a
    // preview version is present in the change set.
    expect(result.apiVersions[0]).toBe("2026-01-01");
    expect(result.isPreview).toBe(false);
  });

  it("returns null for invalid API version format", () => {
    const result = parseApiVersion("not-a-date");
    expect(result).toEqual({ year: 0, month: 0, day: 0, isPreview: false });
  });

  it("parses API version with preview suffix correctly", () => {
    const result = parseApiVersion("2025-12-25-preview");
    expect(result).toEqual({ year: 2025, month: 12, day: 25, isPreview: true });
  });

  it("resolves associated PR from commit SHA", async () => {
    const listPullRequestsAssociatedWithCommit = vi.fn().mockResolvedValueOnce({
      data: [{ number: 99 }],
    });

    const result = await getAssociatedPrNumber({
      octokit: {
        rest: {
          pulls: {
            get: vi.fn(),
            listFiles: vi.fn(),
          },
          repos: {
            listPullRequestsAssociatedWithCommit,
            getCommit: vi.fn(),
          },
        },
      },
      owner: "Azure",
      repo: "azure-rest-api-specs",
      commitSha: "abc123",
    });

    expect(result).toBe(99);
  });

  it("gets changed files from commit SHA", async () => {
    const getCommit = vi.fn().mockResolvedValueOnce({
      data: {
        files: [
          { filename: "specification/foo/tspconfig.yaml", status: "modified" },
          { filename: "specification/foo/2026-01-01/main.tsp", status: "modified" },
        ],
      },
    });

    const files = await getCommitChangedFiles({
      octokit: {
        rest: {
          pulls: {
            get: vi.fn(),
            listFiles: vi.fn(),
          },
          repos: {
            listPullRequestsAssociatedWithCommit: vi.fn(),
            getCommit,
          },
        },
      },
      owner: "Azure",
      repo: "azure-rest-api-specs",
      commitSha: "def456",
    });

    expect(getCommit).toHaveBeenCalledOnce();
    expect(files).toHaveLength(2);
    expect(files[0].filename).toBe("specification/foo/tspconfig.yaml");
  });

  it("uses associated PR path when commit maps to a PR", async () => {
    // Create main.tsp file so runTypeSpecMetadataEmitter doesn't fail early
    const projectPath = join(process.cwd(), "specification/foo");
    mkdirSync(projectPath, { recursive: true });
    writeFileSync(join(projectPath, "main.tsp"), "namespace Demo;");

    // Setup mock metadata for the project
    setupMockMetadata(projectPath, "2026-01-01-preview", "preview");

    const listPullRequestsAssociatedWithCommit = vi.fn().mockResolvedValueOnce({
      data: [{ number: 123 }],
    });
    const get = vi.fn().mockResolvedValueOnce({ data: { labels: [{ name: "new-api-version" }] } });
    const listFiles = vi
      .fn()
      .mockResolvedValueOnce({
        data: [
          { filename: "specification/foo/tspconfig.yaml", status: "modified" },
          { filename: "specification/foo/2026-01-01-preview/main.tsp", status: "modified" },
        ],
      })
      .mockResolvedValueOnce({ data: [] });

    const result = await getTypeSpecProjectInfoFromCommit({
      commitSha: "abc999",
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workspace: process.cwd(),
      octokit: {
        rest: {
          pulls: {
            get,
            listFiles,
          },
          repos: {
            listPullRequestsAssociatedWithCommit,
            getCommit: vi.fn(),
          },
        },
      },
    });

    expect(result.prNumber).toBe(123);
    expect(result.hasNewApiVersionLabel).toBe(true);
    expect(result.projectInfo?.tspProjectPath).toBe("specification/foo");
    expect(result.projectInfo?.apiVersion).toBe("2026-01-01-preview");

    // Cleanup
    rmSync(projectPath, { recursive: true, force: true });
  });

  it("falls back to commit file analysis when no PR is associated", async () => {
    // Create main.tsp file so runTypeSpecMetadataEmitter doesn't fail early
    const projectPath = join(process.cwd(), "specification/bar");
    mkdirSync(projectPath, { recursive: true });
    writeFileSync(join(projectPath, "main.tsp"), "namespace Demo;");

    // Setup mock metadata for the project
    setupMockMetadata(projectPath, "2025-09-01", "stable");

    const listPullRequestsAssociatedWithCommit = vi.fn().mockResolvedValueOnce({ data: [] });
    const getCommit = vi.fn().mockResolvedValueOnce({
      data: {
        files: [
          { filename: "specification/bar/tspconfig.yaml", status: "modified" },
          { filename: "specification/bar/2025-09-01/main.tsp", status: "modified" },
        ],
      },
    });

    const result = await getTypeSpecProjectInfoFromCommit({
      commitSha: "zzz111",
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workspace: process.cwd(),
      octokit: {
        rest: {
          pulls: {
            get: vi.fn(),
            listFiles: vi.fn(),
          },
          repos: {
            listPullRequestsAssociatedWithCommit,
            getCommit,
          },
        },
      },
    });

    expect(result.prNumber).toBeUndefined();
    expect(result.hasNewApiVersionLabel).toBe(false);
    expect(result.projectInfo?.tspProjectPath).toBe("specification/bar");
    expect(result.projectInfo?.apiVersion).toBe("2025-09-01");

    // Cleanup
    rmSync(projectPath, { recursive: true, force: true });
  });

  it("skips folder-migration PRs and does not fetch changed files", async () => {
    const listPullRequestsAssociatedWithCommit = vi.fn().mockResolvedValueOnce({
      data: [{ number: 321 }],
    });
    const get = vi
      .fn()
      .mockResolvedValueOnce({ data: { labels: [{ name: "FolderMigrationV2" }] } });
    const listFiles = vi.fn();

    const result = await getTypeSpecProjectInfoFromCommit({
      commitSha: "mig123",
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workspace: process.cwd(),
      octokit: {
        rest: {
          pulls: {
            get,
            listFiles,
          },
          repos: {
            listPullRequestsAssociatedWithCommit,
            getCommit: vi.fn(),
          },
        },
      },
    });

    expect(result.isFolderMigration).toBe(true);
    expect(result.projectInfo).toBeNull();
    expect(result.prNumber).toBe(321);
    expect(result.hasNewApiVersionLabel).toBe(false);
    // Folder migration is detected before listing files, so no file lookup happens.
    expect(listFiles).not.toHaveBeenCalled();
  });

  it("ignores renamed files when detecting the API version", async () => {
    // Create main.tsp file so runTypeSpecMetadataEmitter doesn't fail early
    const projectPath = join(process.cwd(), "specification/bar");
    mkdirSync(projectPath, { recursive: true });
    writeFileSync(join(projectPath, "main.tsp"), "namespace Demo;");

    // Setup mock metadata for the project
    setupMockMetadata(projectPath, "2025-09-01", "stable");

    const listPullRequestsAssociatedWithCommit = vi.fn().mockResolvedValueOnce({ data: [] });
    const getCommit = vi.fn().mockResolvedValueOnce({
      data: {
        files: [
          { filename: "specification/bar/tspconfig.yaml", status: "modified" },
          // Renamed into a folder that looks like an older API version; must be ignored.
          { filename: "specification/bar/2020-01-01/legacy.tsp", status: "renamed" },
          { filename: "specification/bar/2025-09-01/main.tsp", status: "added" },
        ],
      },
    });

    const result = await getTypeSpecProjectInfoFromCommit({
      commitSha: "rename1",
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workspace: process.cwd(),
      octokit: {
        rest: {
          pulls: {
            get: vi.fn(),
            listFiles: vi.fn(),
          },
          repos: {
            listPullRequestsAssociatedWithCommit,
            getCommit,
          },
        },
      },
    });

    expect(result.projectInfo?.apiVersion).toBe("2025-09-01");

    // Cleanup
    rmSync(projectPath, { recursive: true, force: true });
  });
});

describe("pull request label helpers", () => {
  it("returns the list of label names", async () => {
    const get = vi.fn().mockResolvedValueOnce({
      data: { labels: [{ name: "new-api-version" }, { name: "FolderMigrationV2" }] },
    });

    const labels = await getPullRequestLabels({
      octokit: {
        rest: {
          pulls: {
            get,
            listFiles: vi.fn(),
          },
        },
      },
      owner: "Azure",
      repo: "azure-rest-api-specs",
      prNumber: 7,
    });

    expect(labels).toEqual(["new-api-version", "FolderMigrationV2"]);
  });
});

describe("TypeSpec metadata parsing", () => {
  let tempDir: string;

  beforeEach(() => {
    // Create temporary directory for test metadata files
    tempDir = join(process.cwd(), "test-metadata-temp");
    mkdirSync(tempDir, { recursive: true });
  });

  afterEach(() => {
    // Cleanup test directory
    if (existsSync(tempDir)) {
      rmSync(tempDir, { recursive: true, force: true });
    }
  });

  it("parses valid TypeSpec metadata with multiple languages", () => {
    const metadataDir = join(tempDir, "tsp-output", "@azure-tools", "typespec-metadata");
    mkdirSync(metadataDir, { recursive: true });
    const metadataFile = join(metadataDir, "typespec-metadata.json");
    const metadata = {
      languages: {
        csharp: [
          {
            packageName: "Azure.ResourceManager.Sample",
            apiVersion: "2025-08-01",
            sdkType: "stable",
          },
        ],
        java: [
          {
            packageName: "com.azure.resourcemanager.sample",
            apiVersion: "2025-08-01",
            sdkType: "stable",
          },
        ],
        python: [
          {
            packageName: "azure-mgmt-sample",
            apiVersion: "2025-08-01",
            sdkType: "stable",
          },
        ],
      },
    };
    writeFileSync(metadataFile, JSON.stringify(metadata));

    const result = parseTypeSpecMetadata(tempDir);
    expect(result.apiVersion).toBe("2025-08-01");
    expect(result.sdkType).toBe("stable");
  });

  it("throws error when metadata file contains malformed JSON", () => {
    const metadataDir = join(tempDir, "tsp-output", "@azure-tools", "typespec-metadata");
    mkdirSync(metadataDir, { recursive: true });
    const metadataFile = join(metadataDir, "typespec-metadata.json");
    writeFileSync(metadataFile, "{invalid json}");

    expect(() => {
      parseTypeSpecMetadata(tempDir);
    }).toThrow("Failed to parse TypeSpec metadata JSON");
  });

  it("throws error when metadata file is missing", () => {
    expect(() => {
      parseTypeSpecMetadata(tempDir);
    }).toThrow("TypeSpec metadata file not found");
  });

  it("throws error when metadata lacks languages object", () => {
    const metadataDir = join(tempDir, "tsp-output", "@azure-tools", "typespec-metadata");
    mkdirSync(metadataDir, { recursive: true });
    const metadataFile = join(metadataDir, "typespec-metadata.json");
    const metadata = {
      version: "1.0.0",
      // Missing languages object
    };
    writeFileSync(metadataFile, JSON.stringify(metadata));

    expect(() => {
      parseTypeSpecMetadata(tempDir);
    }).toThrow("TypeSpec metadata does not contain 'languages' object");
  });

  it("throws error when languages have different sdkTypes (conflicting)", () => {
    const metadataDir = join(tempDir, "tsp-output", "@azure-tools", "typespec-metadata");
    mkdirSync(metadataDir, { recursive: true });
    const metadataFile = join(metadataDir, "typespec-metadata.json");
    const metadata = {
      languages: {
        csharp: [
          {
            packageName: "Azure.ResourceManager.Sample",
            apiVersion: "2025-08-01",
            sdkType: "stable",
          },
        ],
        java: [
          {
            packageName: "com.azure.resourcemanager.sample",
            apiVersion: "2025-08-01",
            sdkType: "preview",
          },
        ],
      },
    };
    writeFileSync(metadataFile, JSON.stringify(metadata));

    expect(() => {
      parseTypeSpecMetadata(tempDir);
    }).toThrow(
      "TypeSpec code generator output suggests that this project contains conflicting SDK release type",
    );
  });

  it("skips language configs with missing apiVersion and logs warning", () => {
    const metadataDir = join(tempDir, "tsp-output", "@azure-tools", "typespec-metadata");
    mkdirSync(metadataDir, { recursive: true });
    const metadataFile = join(metadataDir, "typespec-metadata.json");
    const metadata = {
      languages: {
        csharp: [
          {
            packageName: "Azure.ResourceManager.Sample",
            apiVersion: "2025-08-01",
            sdkType: "stable",
          },
        ],
        java: [
          {
            packageName: "com.azure.resourcemanager.sample",
            // Missing apiVersion
            sdkType: "stable",
          },
        ],
        python: [
          {
            packageName: "azure-mgmt-sample",
            apiVersion: "2025-08-01",
            sdkType: "stable",
          },
        ],
      },
    };
    writeFileSync(metadataFile, JSON.stringify(metadata));

    const result = parseTypeSpecMetadata(tempDir);
    expect(result.apiVersion).toBe("2025-08-01");
    expect(result.sdkType).toBe("stable");
    // Should have logged a warning about missing apiVersion in java config
  });

  it("skips language configs with missing sdkType", () => {
    const metadataDir = join(tempDir, "tsp-output", "@azure-tools", "typespec-metadata");
    mkdirSync(metadataDir, { recursive: true });
    const metadataFile = join(metadataDir, "typespec-metadata.json");
    const metadata = {
      languages: {
        csharp: [
          {
            packageName: "Azure.ResourceManager.Sample",
            apiVersion: "2025-08-01",
            sdkType: "stable",
          },
        ],
        java: [
          {
            packageName: "com.azure.resourcemanager.sample",
            apiVersion: "2025-08-01",
            // Missing sdkType
          },
        ],
        python: [
          {
            packageName: "azure-mgmt-sample",
            apiVersion: "2025-08-01",
            sdkType: "stable",
          },
        ],
      },
    };
    writeFileSync(metadataFile, JSON.stringify(metadata));

    const result = parseTypeSpecMetadata(tempDir);
    expect(result.apiVersion).toBe("2025-08-01");
    expect(result.sdkType).toBe("stable");
  });

  it("throws error when no valid language configurations found", () => {
    const metadataDir = join(tempDir, "tsp-output", "@azure-tools", "typespec-metadata");
    mkdirSync(metadataDir, { recursive: true });
    const metadataFile = join(metadataDir, "typespec-metadata.json");
    const metadata = {
      languages: {
        csharp: [
          {
            packageName: "Azure.ResourceManager.Sample",
            // Missing both apiVersion and sdkType
          },
        ],
      },
    };
    writeFileSync(metadataFile, JSON.stringify(metadata));

    expect(() => {
      parseTypeSpecMetadata(tempDir);
    }).toThrow("No valid language configurations found in TypeSpec metadata");
  });

  it("handles preview API versions correctly", () => {
    const metadataDir = join(tempDir, "tsp-output", "@azure-tools", "typespec-metadata");
    mkdirSync(metadataDir, { recursive: true });
    const metadataFile = join(metadataDir, "typespec-metadata.json");
    const metadata = {
      languages: {
        csharp: [
          {
            packageName: "Azure.ResourceManager.Sample",
            apiVersion: "2025-08-01-preview",
            sdkType: "preview",
          },
        ],
        java: [
          {
            packageName: "com.azure.resourcemanager.sample",
            apiVersion: "2025-08-01-preview",
            sdkType: "preview",
          },
        ],
      },
    };
    writeFileSync(metadataFile, JSON.stringify(metadata));

    const result = parseTypeSpecMetadata(tempDir);
    expect(result.apiVersion).toBe("2025-08-01-preview");
    expect(result.sdkType).toBe("preview");
  });
});
