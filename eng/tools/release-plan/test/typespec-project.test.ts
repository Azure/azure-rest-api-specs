import type { TypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";
import { generateTypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";
import { mkdirSync, mkdtempSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";

const { mockMetadataMap } = vi.hoisted(() => ({
  mockMetadataMap: new Map<string, { apiVersion: string; sdkType: "stable" | "preview" }>(),
}));

vi.mock("@azure-tools/specs-shared/typespec-metadata", () => ({
  generateTypeSpecMetadata: vi.fn((projectDir: string) => {
    const mockData = mockMetadataMap.get(projectDir);
    if (!mockData) {
      return Promise.reject(new Error(`Metadata not mocked for ${projectDir}`));
    }

    return Promise.resolve(
      createMetadata({
        csharp: [
          {
            emitterName: "csharp",
            packageName: "Azure.ResourceManager.Sample",
            ...mockData,
          },
        ],
        java: [
          {
            emitterName: "java",
            packageName: "com.azure.resourcemanager.sample",
            ...mockData,
          },
        ],
        python: [
          {
            emitterName: "python",
            packageName: "azure-mgmt-sample",
            ...mockData,
          },
        ],
      }),
    );
  }),
}));

import {
  compareApiVersionsDesc,
  createOctokit,
  detectApiVersions,
  findTspConfigDir,
  getAssociatedPrNumber,
  getCommitChangedFiles,
  getPrChangedFiles,
  getMergedSpecCommitSha,
  getPullRequestLabels,
  getTypeSpecProjectInfoFromCommit,
  getTypeSpecProjectInfoFromPr,
  getTypeSpecProjectVersionFromMetadata,
  parseApiVersion,
  resolveTypeSpecMetadata,
} from "../src/typespec-project.ts";
import { cleanGit, OLD_SHA, SPEC_SHA } from "./test-helpers.ts";

function createMetadata(languages: TypeSpecMetadata["languages"]): TypeSpecMetadata {
  return {
    emitterVersion: "0.3.0",
    generatedAt: "2026-08-28T00:00:00.000Z",
    typespec: { namespace: "Sample", type: "management" },
    languages,
  };
}

// Helper function to setup mock metadata for a test
function setupMockMetadata(projectPath: string, apiVersion: string, sdkType: "stable" | "preview") {
  mockMetadataMap.set(projectPath, { apiVersion, sdkType });
}

let workspace: string;

beforeEach(() => {
  workspace = mkdtempSync(join(tmpdir(), "release-plan-typespec-"));
  mockMetadataMap.clear();
});

afterEach(() => {
  rmSync(workspace, { recursive: true, force: true });
});

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
      workspace,
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
      workspace,
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
    const projectPath = join(workspace, "specification/foo");
    mkdirSync(projectPath, { recursive: true });
    writeFileSync(join(projectPath, "main.tsp"), "namespace Demo;");

    // Setup mock metadata for the project
    setupMockMetadata(projectPath, "2025-08-01", "preview");

    const get = vi
      .fn()
      .mockResolvedValue({ data: { labels: [], merged: true, merge_commit_sha: SPEC_SHA } });
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
      workspace,
      git: cleanGit(),
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
    expect(result?.isPreview).toBe(false);
    expect(listFiles).toHaveBeenCalled();
  });

  it("throws when PR has multiple tsp projects rather than selecting the first", async () => {
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

    await expect(
      getTypeSpecProjectInfoFromPr({
        prNumber: 42,
        owner: "Azure",
        repo: "azure-rest-api-specs",
        workspace,
        octokit: {
          rest: {
            pulls: {
              get,
              listFiles,
            },
          },
        },
      }),
    ).rejects.toThrow(/Multiple TypeSpec projects/);
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
      workspace,
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
    const projectPath = join(workspace, "specification/foo");
    mkdirSync(projectPath, { recursive: true });
    writeFileSync(join(projectPath, "main.tsp"), "namespace Demo;");

    // Setup mock metadata for the project
    setupMockMetadata(projectPath, "2026-01-01-preview", "stable");

    const listPullRequestsAssociatedWithCommit = vi.fn().mockResolvedValueOnce({
      data: [{ number: 123 }],
    });
    const get = vi.fn().mockResolvedValue({
      data: { labels: [{ name: "new-api-version" }], merged: true, merge_commit_sha: SPEC_SHA },
    });
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
      commitSha: SPEC_SHA,
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workspace,
      git: cleanGit(),
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
    expect(result.projectInfo?.isPreview).toBe(true);
  });

  it("does not select a release target for TypeSpec changes with no associated merged PR", async () => {
    const projectPath = join(workspace, "specification/bar");
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

    await expect(
      getTypeSpecProjectInfoFromCommit({
        commitSha: "zzz111",
        owner: "Azure",
        repo: "azure-rest-api-specs",
        workspace,
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
      }),
    ).rejects.toThrow(/No merged spec PR/);
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
      workspace,
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

    expect(result.skipReleasePlanAutomation).toBe(true);
    expect(result.projectInfo).toBeNull();
    expect(result.prNumber).toBe(321);
    expect(result.hasNewApiVersionLabel).toBe(false);
    // Folder migration is detected before listing files, so no file lookup happens.
    expect(listFiles).not.toHaveBeenCalled();
  });

  it("skips PRs labeled to opt out of release plan automation", async () => {
    const listPullRequestsAssociatedWithCommit = vi.fn().mockResolvedValueOnce({
      data: [{ number: 654 }],
    });
    const get = vi.fn().mockResolvedValueOnce({
      data: { labels: [{ name: "Skip-ReleasePlan-Automation" }] },
    });
    const listFiles = vi.fn();

    const result = await getTypeSpecProjectInfoFromCommit({
      commitSha: "skip123",
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workspace,
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

    expect(result.skipReleasePlanAutomation).toBe(true);
    expect(result.projectInfo).toBeNull();
    expect(result.prNumber).toBe(654);
    expect(result.hasNewApiVersionLabel).toBe(false);
    expect(listFiles).not.toHaveBeenCalled();
  });

  it("ignores renamed files when detecting the API version", async () => {
    const projectPath = join(workspace, "specification/bar");
    mkdirSync(projectPath, { recursive: true });
    writeFileSync(join(projectPath, "main.tsp"), "namespace Demo;");

    // Setup mock metadata for the project
    setupMockMetadata(projectPath, "2025-09-01", "stable");

    const listPullRequestsAssociatedWithCommit = vi
      .fn()
      .mockResolvedValueOnce({ data: [{ number: 123 }] });
    const listFiles = vi.fn().mockResolvedValueOnce({
      data: [
        { filename: "specification/bar/tspconfig.yaml", status: "modified" },
        // Renamed into a folder that looks like an older API version; must be ignored.
        { filename: "specification/bar/2020-01-01/legacy.tsp", status: "renamed" },
        { filename: "specification/bar/2025-09-01/main.tsp", status: "added" },
      ],
    });

    const result = await getTypeSpecProjectInfoFromCommit({
      commitSha: SPEC_SHA,
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workspace,
      git: cleanGit(),
      octokit: {
        rest: {
          pulls: {
            get: vi.fn().mockResolvedValue({ data: { merged: true, merge_commit_sha: SPEC_SHA } }),
            listFiles,
          },
          repos: {
            listPullRequestsAssociatedWithCommit,
            getCommit: vi.fn(),
          },
        },
      },
    });

    expect(result.projectInfo?.apiVersion).toBe("2025-09-01");
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

describe("TypeSpec metadata resolution", () => {
  const autoRestConfig = {
    emitterName: "@azure-tools/typespec-autorest",
    apiVersion: "2025-08-01",
    sdkType: "stable" as const,
    outputDir: "{project-root}/../resource-manager/Microsoft.Sample",
  };

  it("accepts real-shaped AutoRest metadata without a package alongside an SDK", () => {
    const metadata = createMetadata({
      unknown: [autoRestConfig],
      python: [
        {
          emitterName: "@azure-tools/typespec-python",
          packageName: "azure-mgmt-sample",
          namespace: "azure.mgmt.sample",
          apiVersion: "2025-08-01",
          sdkType: "stable",
        },
      ],
      documentation: [{ emitterName: "documentation", apiVersion: "latest" }],
    });

    expect(resolveTypeSpecMetadata(metadata)).toEqual({ apiVersion: "2025-08-01" });
  });

  it("does not use unknown or unrecognized emitters as the only API-version source", () => {
    expect(() =>
      resolveTypeSpecMetadata(
        createMetadata({ unknown: [autoRestConfig], documentation: [autoRestConfig] }),
      ),
    ).toThrow(/No valid language/);
  });

  it.each(["csharp", "python", "typescript", "javascript", "java", "rust", "swift", "go"])(
    "requires a concrete version and package for the recognized SDK language %s",
    (language) => {
      const config = {
        emitterName: `@azure-tools/typespec-${language}`,
        packageName: "sample-package",
        apiVersion: "2025-08-01",
      };
      expect(resolveTypeSpecMetadata(createMetadata({ [language]: [config] }))).toEqual({
        apiVersion: "2025-08-01",
      });
      for (const packageName of [undefined, "", "   "]) {
        expect(() =>
          resolveTypeSpecMetadata(createMetadata({ [language]: [{ ...config, packageName }] })),
        ).toThrow(/packageName/);
      }
      for (const apiVersion of [undefined, "latest"]) {
        expect(() =>
          resolveTypeSpecMetadata(createMetadata({ [language]: [{ ...config, apiVersion }] })),
        ).toThrow(/API version/);
      }
    },
  );

  it("still rejects a recognized SDK mismatch when AutoRest agrees with the first SDK", () => {
    expect(() =>
      resolveTypeSpecMetadata(
        createMetadata({
          unknown: [autoRestConfig],
          csharp: [
            {
              emitterName: "@azure-typespec/http-client-csharp",
              packageName: "Azure.ResourceManager.Sample",
              apiVersion: "2025-08-01",
            },
          ],
          rust: [
            {
              emitterName: "@azure-tools/typespec-rust",
              packageName: "azure_mgmt_sample",
              apiVersion: "2026-01-01-preview",
            },
          ],
        }),
      ),
    ).toThrow(/Ambiguous API versions/);
  });

  it("parses valid TypeSpec metadata with multiple languages", () => {
    const metadata = createMetadata({
      csharp: [
        {
          emitterName: "csharp",
          packageName: "Azure.ResourceManager.Sample",
          apiVersion: "2025-08-01",
          sdkType: "stable",
        },
      ],
      java: [
        {
          emitterName: "java",
          packageName: "com.azure.resourcemanager.sample",
          apiVersion: "2025-08-01",
          sdkType: "stable",
        },
      ],
      python: [
        {
          emitterName: "python",
          packageName: "azure-mgmt-sample",
          apiVersion: "2025-08-01",
          sdkType: "stable",
        },
      ],
    });

    expect(resolveTypeSpecMetadata(metadata)).toEqual({ apiVersion: "2025-08-01" });
  });

  it("rejects inconsistent API versions instead of selecting the first or latest", () => {
    const metadata = createMetadata({
      csharp: [
        {
          emitterName: "csharp",
          packageName: "Azure.ResourceManager.Sample",
          apiVersion: "2025-08-01",
          sdkType: "stable",
        },
      ],
      java: [
        {
          emitterName: "java",
          packageName: "com.azure.resourcemanager.sample",
          apiVersion: "2026-01-01-preview",
          sdkType: "preview",
        },
      ],
    });

    expect(() => resolveTypeSpecMetadata(metadata)).toThrow(/Ambiguous API versions/);
  });

  it("ignores conflicting SDK types when resolving the API version", () => {
    const metadata = createMetadata({
      csharp: [
        {
          emitterName: "csharp",
          packageName: "Azure.ResourceManager.Sample",
          apiVersion: "2025-08-01",
          sdkType: "stable",
        },
      ],
      java: [
        {
          emitterName: "java",
          packageName: "com.azure.resourcemanager.sample",
          apiVersion: "2025-08-01",
          sdkType: "preview",
        },
      ],
    });

    expect(resolveTypeSpecMetadata(metadata)).toEqual({ apiVersion: "2025-08-01" });
  });

  it("rejects missing apiVersion even when other languages have a concrete version", () => {
    const metadata = createMetadata({
      csharp: [
        {
          emitterName: "csharp",
          packageName: "Azure.ResourceManager.Sample",
          apiVersion: "2025-08-01",
          sdkType: "stable",
        },
      ],
      java: [
        {
          emitterName: "java",
          packageName: "com.azure.resourcemanager.sample",
          sdkType: "stable",
        },
      ],
      python: [
        {
          emitterName: "python",
          packageName: "azure-mgmt-sample",
          apiVersion: "2025-08-01",
          sdkType: "stable",
        },
      ],
    });

    expect(() => resolveTypeSpecMetadata(metadata)).toThrow(/API version/);
  });

  it("uses language configs with missing SDK type", () => {
    const metadata = createMetadata({
      csharp: [
        {
          emitterName: "csharp",
          packageName: "Azure.ResourceManager.Sample",
          apiVersion: "2025-08-01",
        },
      ],
      java: [
        {
          emitterName: "java",
          packageName: "com.azure.resourcemanager.sample",
          apiVersion: "2025-08-01",
        },
      ],
      python: [
        {
          emitterName: "python",
          packageName: "azure-mgmt-sample",
          apiVersion: "2025-08-01",
        },
      ],
    });

    expect(resolveTypeSpecMetadata(metadata)).toEqual({ apiVersion: "2025-08-01" });
  });

  it("throws when the only configuration has no API version", () => {
    const metadata = createMetadata({
      csharp: [
        {
          emitterName: "csharp",
          packageName: "Azure.ResourceManager.Sample",
        },
      ],
    });

    expect(() => {
      resolveTypeSpecMetadata(metadata);
    }).toThrow(/API version/);
  });

  it("handles preview API versions correctly", () => {
    const metadata = createMetadata({
      csharp: [
        {
          emitterName: "csharp",
          packageName: "Azure.ResourceManager.Sample",
          apiVersion: "2025-08-01-preview",
          sdkType: "preview",
        },
      ],
      java: [
        {
          emitterName: "java",
          packageName: "com.azure.resourcemanager.sample",
          apiVersion: "2025-08-01-preview",
          sdkType: "preview",
        },
      ],
    });

    expect(resolveTypeSpecMetadata(metadata)).toEqual({
      apiVersion: "2025-08-01-preview",
    });
  });

  it("rejects API versions outside the stable and preview formats", async () => {
    const projectPath = join(workspace, "specification/foo");
    mockMetadataMap.set(projectPath, { apiVersion: "latest", sdkType: "stable" });

    await expect(
      getTypeSpecProjectVersionFromMetadata(projectPath, "specification/foo"),
    ).rejects.toThrow("API version 'latest' must use YYYY-MM-DD or YYYY-MM-DD-preview format");
  });

  it.each(["all", "latest", "", "2026-01-01-preview,2026-06-01"])(
    "rejects nonconcrete metadata version %s",
    (apiVersion) => {
      expect(() =>
        resolveTypeSpecMetadata(
          createMetadata({
            python: [{ emitterName: "python", packageName: "azure-mgmt-test", apiVersion }],
          }),
        ),
      ).toThrow(/API version/);
    },
  );

  it("rejects multiple versions in a single language configuration array", () => {
    expect(() =>
      resolveTypeSpecMetadata(
        createMetadata({
          python: ["2026-01-01-preview", "2026-06-01"].map((apiVersion) => ({
            emitterName: "python",
            packageName: "azure-mgmt-test",
            apiVersion,
          })),
        }),
      ),
    ).toThrow(/Ambiguous API versions/);
  });

  it("rejects empty metadata", () => {
    expect(() => resolveTypeSpecMetadata(createMetadata({}))).toThrow(/No valid language/);
  });
});

describe("explicit merged event and metadata boundary", () => {
  function boundary() {
    const git = cleanGit();
    const get = vi.fn().mockResolvedValue({ data: { merged: true, merge_commit_sha: SPEC_SHA } });
    const listFiles = vi
      .fn()
      .mockResolvedValue({ data: [{ filename: "specification/foo/tspconfig.yaml" }] });
    return {
      prNumber: 123,
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workspace,
      octokit: { rest: { pulls: { get, listFiles } } },
      git,
    };
  }

  it("uses the resolved PR merge commit and checks checkout before and after metadata", async () => {
    const params = boundary();
    setupMockMetadata(join(workspace, "specification/foo"), "2026-01-01-preview", "preview");
    const result = await getTypeSpecProjectInfoFromPr(params);
    expect(result?.specCommitSha).toBe(SPEC_SHA);
    expect(params.git.mock.calls.map(([, args]) => args[0])).toEqual([
      "rev-parse",
      "status",
      "rev-parse",
      "status",
    ]);
  });

  it.each([
    { merged: false, merge_commit_sha: SPEC_SHA },
    { state: "open", merged_at: null, merge_commit_sha: SPEC_SHA },
  ])("rejects unmerged events before metadata: %j", async (data) => {
    const params = boundary();
    params.octokit.rest.pulls.get.mockResolvedValue({ data });
    const calls = vi.mocked(generateTypeSpecMetadata).mock.calls.length;
    await expect(getTypeSpecProjectInfoFromPr(params)).rejects.toThrow(/requires merged/);
    expect(vi.mocked(generateTypeSpecMetadata).mock.calls).toHaveLength(calls);
    expect(params.git).not.toHaveBeenCalled();
  });

  it("rejects a trigger commit that is not the PR merge commit", async () => {
    await expect(getMergedSpecCommitSha({ ...boundary(), commitSha: OLD_SHA })).rejects.toThrow(
      /Trigger commit/,
    );
  });

  it("rejects a clean workspace at a different HEAD before metadata", async () => {
    const params = boundary();
    const calls = vi.mocked(generateTypeSpecMetadata).mock.calls.length;
    await expect(
      getTypeSpecProjectInfoFromPr({ ...params, git: cleanGit(OLD_SHA) }),
    ).rejects.toThrow(/HEAD/);
    expect(vi.mocked(generateTypeSpecMetadata).mock.calls).toHaveLength(calls);
  });

  it("detects checkout drift during metadata generation", async () => {
    const params = boundary();
    vi.mocked(generateTypeSpecMetadata).mockImplementationOnce(() => {
      params.git.mockReturnValue({ exitCode: 0, stdout: OLD_SHA, stderr: "" });
      return Promise.resolve(
        createMetadata({
          python: [
            {
              emitterName: "python",
              packageName: "azure-mgmt-test",
              apiVersion: "2026-01-01-preview",
            },
          ],
        }),
      );
    });
    await expect(getTypeSpecProjectInfoFromPr(params)).rejects.toThrow(/HEAD/);
  });

  it("propagates ambiguous metadata rather than reporting no changes", async () => {
    const params = boundary();
    vi.mocked(generateTypeSpecMetadata).mockResolvedValueOnce(
      createMetadata({
        python: ["2026-01-01-preview", "2026-06-01"].map((apiVersion) => ({
          emitterName: "python",
          packageName: "azure-mgmt-test",
          apiVersion,
        })),
      }),
    );
    await expect(getTypeSpecProjectInfoFromPr(params)).rejects.toThrow(/Ambiguous API versions/);
  });

  it("propagates compilation failure rather than reporting no changes", async () => {
    const params = boundary();
    vi.mocked(generateTypeSpecMetadata).mockRejectedValueOnce(new Error("compiler diagnostics"));
    await expect(getTypeSpecProjectInfoFromPr(params)).rejects.toThrow(/compiler diagnostics/);
  });
});
