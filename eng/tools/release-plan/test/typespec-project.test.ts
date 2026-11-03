import {
  generateTypeSpecMetadata,
  type TypeSpecMetadata,
} from "@azure-tools/specs-shared/typespec-metadata";
import { existsSync, mkdirSync, mkdtempSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";

const { mockMetadataMap, mockLanguagesMap } = vi.hoisted(() => ({
  mockMetadataMap: new Map<string, { apiVersion: string; sdkType: "stable" | "preview" }>(),
  mockLanguagesMap: new Map<string, TypeSpecMetadata["languages"]>(),
}));

vi.mock("node:fs", async (importOriginal) => {
  const actual = await importOriginal<typeof import("node:fs")>();
  return { ...actual, existsSync: vi.fn(actual.existsSync) };
});

vi.mock("@azure-tools/specs-shared/typespec-metadata", () => ({
  generateTypeSpecMetadata: vi.fn((projectDir: string) => {
    const languages = mockLanguagesMap.get(projectDir);
    if (languages) {
      return Promise.resolve(createMetadata(languages));
    }
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
  collectTypeSpecProjectPaths,
  createOctokit,
  findTspConfigDir,
  getAssociatedPrNumber,
  getCommitChangedFiles,
  getPrChangedFiles,
  getPullRequestLabels,
  getTypeSpecProjectInfoFromCommit,
  getTypeSpecProjectVersionFromMetadata,
  resolveTypeSpecMetadata,
} from "../src/typespec-project.ts";

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
  mockLanguagesMap.clear();
  vi.mocked(generateTypeSpecMetadata).mockClear();
  vi.mocked(existsSync).mockClear();
});

afterEach(() => {
  rmSync(workspace, { recursive: true, force: true });
});

describe("TypeSpec path discovery", () => {
  function writeConfig(
    directory: string,
    languages: TypeSpecMetadata["languages"] = {},
    content = "",
    entrypoint: "main.tsp" | "client.tsp" | null = "main.tsp",
  ) {
    const projectPath = join(workspace, directory);
    mkdirSync(projectPath, { recursive: true });
    writeFileSync(join(projectPath, "tspconfig.yaml"), content);
    if (entrypoint) {
      writeFileSync(join(projectPath, entrypoint), "");
    }
    mockLanguagesMap.set(projectPath, languages);
  }

  const service = "specification/security/resource-manager/Microsoft.Security/Security";
  const sdkLanguages = {
    python: [
      {
        emitterName: "python",
        packageName: "azure-mgmt-security",
        apiVersion: "2026-01-01-preview",
      },
    ],
  };

  describe("repository project paths with mocked metadata", () => {
    const compute = "specification/compute/resource-manager/Microsoft.Compute/Compute";
    const bulkActions = "specification/compute/resource-manager/Microsoft.Compute/Bulkactions";

    function writeComputeProjects() {
      writeConfig(compute, sdkLanguages, "", "client.tsp");
      writeConfig(`${compute}/ComputeDisk`);
      writeConfig(`${compute}/Compute`);
    }

    it("identifies Compute and Bulkactions when both services and Compute subservices change", async () => {
      writeComputeProjects();
      writeConfig(bulkActions, sdkLanguages);

      const projects = await collectTypeSpecProjectPaths(
        [
          { filename: `${bulkActions}/tspconfig.yaml`, status: "modified" },
          { filename: `${compute}/tspconfig.yaml`, status: "modified" },
          { filename: `${compute}/ComputeDisk/tspconfig.yaml`, status: "modified" },
          { filename: `${compute}/Compute/tspconfig.yaml`, status: "modified" },
        ],
        workspace,
      );

      expect(projects.toSorted()).toEqual([compute, bulkActions].toSorted());
    });

    it("identifies only Compute when Bulkactions is not in the changed files", async () => {
      writeComputeProjects();

      const projects = await collectTypeSpecProjectPaths(
        [
          { filename: `${compute}/tspconfig.yaml`, status: "modified" },
          { filename: `${compute}/ComputeDisk/tspconfig.yaml`, status: "modified" },
          { filename: `${compute}/Compute/tspconfig.yaml`, status: "modified" },
        ],
        workspace,
      );

      expect(projects).toEqual([compute]);
    });

    it.each([
      {
        project: "specification/healthdataaiservices/data-plane/HealthDataAIServices",
        filename: "tspconfig.yaml",
      },
      {
        project: "specification/mongocluster/resource-manager/Microsoft.DocumentDB/MongoCluster",
        filename: "tspconfig.yaml",
      },
      {
        project:
          "specification/liftrarize/resource-manager/ArizeAi.ObservabilityEval/ObservabilityEval",
        filename: "client.tsp",
      },
      {
        project: "specification/storage/data-plane/FileStorage",
        filename: "client.tsp",
      },
    ])("identifies $project from $filename", async ({ project, filename }) => {
      writeConfig(project, sdkLanguages, "", filename === "client.tsp" ? "client.tsp" : "main.tsp");

      const projects = await collectTypeSpecProjectPaths(
        [{ filename: `${project}/${filename}`, status: "modified" }],
        workspace,
      );

      expect(projects).toEqual([project]);
    });

    it("retains an AutoRest-only project and resolves its version for a private preview", async () => {
      const project = "specification/awsconnector/AcmCertificateSummary.Management";
      const metadataCache = new Map<string, Promise<TypeSpecMetadata>>();
      writeConfig(project, {
        unknown: [{ emitterName: "@azure-tools/typespec-autorest", apiVersion: "2024-12-01" }],
      });

      const projects = await collectTypeSpecProjectPaths(
        [{ filename: `${project}/tspconfig.yaml`, status: "modified" }],
        workspace,
        metadataCache,
      );

      expect(projects).toEqual([project]);

      const projectInfo = await getTypeSpecProjectVersionFromMetadata(
        join(workspace, project),
        project,
        metadataCache,
        true,
      );
      expect(projectInfo).toEqual({
        tspProjectPath: project,
        apiVersion: "2024-12-01",
        isPreview: false,
      });
      expect(generateTypeSpecMetadata).toHaveBeenCalledExactlyOnceWith(join(workspace, project));
    });
  });

  it("finds the SDK parent using emitted languages without service-dir", async () => {
    writeConfig(`${service}/BatchPricingsAPI`);
    writeConfig(service, sdkLanguages);

    expect(await findTspConfigDir(`${service}/BatchPricingsAPI/main.tsp`, workspace)).toBe(service);
  });

  it.each(["main.tsp", "client.tsp"] as const)(
    "skips a config-only partial and finds the SDK parent with %s",
    async (entrypoint) => {
      writeConfig(`${service}/BatchPricingsAPI`, {}, "", null);
      writeConfig(service, sdkLanguages, "", entrypoint);

      expect(await findTspConfigDir(`${service}/BatchPricingsAPI/tspconfig.yaml`, workspace)).toBe(
        service,
      );
      expect(generateTypeSpecMetadata).toHaveBeenCalledExactlyOnceWith(join(workspace, service));
    },
  );

  it("does not treat service-dir alone as SDK configuration", async () => {
    writeConfig(`${service}/BatchPricingsAPI`, {}, "parameters:\n  service-dir: sdk/security\n");
    writeConfig(service, sdkLanguages);

    expect(await findTspConfigDir(`${service}/BatchPricingsAPI/main.tsp`, workspace)).toBe(service);
  });

  it.each(["java", "javascript", "typescript", "csharp", "python", "go"])(
    "accepts %s metadata without requiring a package or API version",
    async (language) => {
      writeConfig(service, sdkLanguages);
      writeConfig(`${service}/BatchPricingsAPI`, {
        [language]: [{ emitterName: language }],
      });

      expect(await findTspConfigDir(`${service}/BatchPricingsAPI/models/main.tsp`, workspace)).toBe(
        `${service}/BatchPricingsAPI`,
      );
      expect(generateTypeSpecMetadata).toHaveBeenCalledTimes(1);
    },
  );

  it("skips unsupported languages and non-SDK emitters", async () => {
    writeConfig(service, sdkLanguages);
    writeConfig(`${service}/BatchPricingsAPI`, {
      unknown: [
        { emitterName: "@azure-tools/typespec-autorest" },
        { emitterName: "@azure-tools/typespec-metadata" },
      ],
      rust: [{ emitterName: "@azure-tools/typespec-rust" }],
      go: [],
    });

    expect(await findTspConfigDir(`${service}/BatchPricingsAPI/main.tsp`, workspace)).toBe(service);
  });

  it("skips intervening directories and empty language arrays", async () => {
    writeConfig(`${service}/BatchPricingsAPI/nested`);
    writeConfig(`${service}/BatchPricingsAPI`, { python: [] });
    writeConfig(service, sdkLanguages);

    expect(
      await findTspConfigDir(`${service}/BatchPricingsAPI/nested/src/main.tsp`, workspace),
    ).toBe(service);
  });

  it("falls back to the initial config for private preview", async () => {
    writeConfig(`${service}/BatchPricingsAPI`);
    writeConfig(service);
    writeConfig("specification", sdkLanguages);
    writeConfig(".", sdkLanguages);

    expect(await findTspConfigDir(`${service}/BatchPricingsAPI/main.tsp`, workspace)).toBe(
      `${service}/BatchPricingsAPI`,
    );
    expect(generateTypeSpecMetadata).not.toHaveBeenCalledWith(join(workspace, "specification"));
    expect(generateTypeSpecMetadata).not.toHaveBeenCalledWith(workspace);
  });

  it("checks the service folder directly below specification", async () => {
    writeConfig("specification/security", sdkLanguages);
    writeConfig(service);

    expect(await findTspConfigDir(`${service}/main.tsp`, workspace)).toBe("specification/security");
  });

  it("returns null when no config exists below specification", async () => {
    writeConfig("specification", sdkLanguages);
    writeConfig(".", sdkLanguages);

    expect(await findTspConfigDir(`${service}/main.tsp`, workspace)).toBeNull();
    expect(await findTspConfigDir("specification-other/main.tsp", workspace)).toBeNull();
    expect(generateTypeSpecMetadata).not.toHaveBeenCalled();
  });

  it("propagates metadata failures instead of silently selecting another project", async () => {
    writeConfig(service);
    vi.mocked(generateTypeSpecMetadata).mockRejectedValueOnce(new Error("Compilation failed"));

    await expect(findTspConfigDir(`${service}/main.tsp`, workspace)).rejects.toThrow(
      "Compilation failed",
    );
  });

  it.each(["main.tsp", "tspconfig.yaml"])(
    "deduplicates multiple changed subprojects sharing an SDK parent (%s)",
    async (filename) => {
      writeConfig(service, sdkLanguages);
      writeConfig(`${service}/BatchPricingsAPI`);
      writeConfig(`${service}/PricingsAPI`);

      expect(
        await collectTypeSpecProjectPaths(
          [
            { filename: `${service}/BatchPricingsAPI/${filename}`, status: "modified" },
            { filename: `${service}/PricingsAPI/${filename}`, status: "modified" },
          ],
          workspace,
        ),
      ).toEqual([service]);
      expect(generateTypeSpecMetadata).toHaveBeenCalledTimes(3);
    },
  );

  it("does not let a changed config hide another changed SDK project", async () => {
    writeConfig(service, sdkLanguages);
    writeConfig("specification/other", sdkLanguages);

    expect(
      await collectTypeSpecProjectPaths(
        [
          { filename: `${service}/tspconfig.yaml`, status: "modified" },
          { filename: "specification/other/main.tsp", status: "modified" },
        ],
        workspace,
      ),
    ).toEqual([service, "specification/other"]);
    expect(
      await collectTypeSpecProjectPaths(
        [
          { filename: `${service}/main.tsp`, status: "modified" },
          { filename: "specification/other/main.tsp", status: "modified" },
        ],
        workspace,
      ),
    ).toEqual([service, "specification/other"]);
  });

  it.each(["main.tsp", "tspconfig.yaml"])(
    "ignores unrelated files in another project when %s changes",
    async (filename) => {
      writeConfig(service, sdkLanguages);
      writeConfig("specification/other", sdkLanguages);

      expect(
        await collectTypeSpecProjectPaths(
          [
            { filename: `${service}/${filename}`, status: "modified" },
            { filename: "specification/other/examples/example.json", status: "modified" },
            { filename: "specification/other/README.md", status: "modified" },
            { filename: "specification/other/custom-tspconfig.yaml", status: "modified" },
          ],
          workspace,
        ),
      ).toEqual([service]);
      expect(generateTypeSpecMetadata).toHaveBeenCalledExactlyOnceWith(join(workspace, service));
    },
  );

  it("does not search directories when only unrelated files change", async () => {
    writeConfig(service, sdkLanguages);

    expect(
      await collectTypeSpecProjectPaths(
        [{ filename: `${service}/examples/example.json`, status: "modified" }],
        workspace,
      ),
    ).toEqual([]);
    expect(existsSync).not.toHaveBeenCalled();
    expect(generateTypeSpecMetadata).not.toHaveBeenCalled();
  });

  it("checks shared ancestors only once across sibling directories", async () => {
    writeConfig(service, sdkLanguages);

    expect(
      await collectTypeSpecProjectPaths(
        [
          { filename: `${service}/models/first/main.tsp`, status: "modified" },
          { filename: `${service}/models/second/main.tsp`, status: "modified" },
          { filename: `${service}/models/main.tsp`, status: "modified" },
          { filename: `${service}/main.tsp`, status: "modified" },
        ],
        workspace,
      ),
    ).toEqual([service]);
    expect(
      vi
        .mocked(existsSync)
        .mock.calls.map(([path]) => path)
        .filter((path) => String(path).endsWith("tspconfig.yaml"))
        .sort(),
    ).toEqual(
      [
        join(workspace, service, "models", "first", "tspconfig.yaml"),
        join(workspace, service, "models", "tspconfig.yaml"),
        join(workspace, service, "tspconfig.yaml"),
        join(workspace, service, "models", "second", "tspconfig.yaml"),
      ].sort(),
    );
    expect(generateTypeSpecMetadata).toHaveBeenCalledTimes(1);
  });

  it("searches descendants before changed ancestors while retaining unrelated projects", async () => {
    const otherService = `${service}Bulk`;
    writeConfig(service, sdkLanguages);
    writeConfig(`${service}/ComputeDisk`);
    writeConfig(otherService, sdkLanguages);

    expect(
      await collectTypeSpecProjectPaths(
        [
          { filename: `${service}/main.tsp`, status: "modified" },
          { filename: `${service}/ComputeDisk/client.tsp`, status: "modified" },
          { filename: `${service}/ComputeDisk/models.tsp`, status: "modified" },
          { filename: `${otherService}/client.tsp`, status: "modified" },
        ],
        workspace,
      ),
    ).toEqual([service, otherService]);
    expect(
      vi
        .mocked(existsSync)
        .mock.calls.map(([path]) => path)
        .filter((path) => String(path).endsWith("tspconfig.yaml")),
    ).toEqual([
      join(workspace, service, "ComputeDisk", "tspconfig.yaml"),
      join(workspace, service, "tspconfig.yaml"),
      join(workspace, otherService, "tspconfig.yaml"),
    ]);
  });

  it("still searches a changed ancestor when an SDK-enabled child stops traversal", async () => {
    writeConfig(service, sdkLanguages);
    writeConfig(`${service}/ComputeDisk`, sdkLanguages);

    expect(
      new Set(
        await collectTypeSpecProjectPaths(
          [
            { filename: `${service}/main.tsp`, status: "modified" },
            { filename: `${service}/ComputeDisk/client.tsp`, status: "modified" },
          ],
          workspace,
        ),
      ),
    ).toEqual(new Set([service, `${service}/ComputeDisk`]));
    expect(generateTypeSpecMetadata).toHaveBeenCalledTimes(2);
  });

  it("preserves each nearest fallback when a cached ancestor has no SDK emitter", async () => {
    writeConfig(service);
    writeConfig(`${service}/BatchPricingsAPI`);
    writeConfig(`${service}/PricingsAPI`);

    expect(
      new Set(
        await collectTypeSpecProjectPaths(
          [
            { filename: `${service}/main.tsp`, status: "modified" },
            { filename: `${service}/BatchPricingsAPI/main.tsp`, status: "modified" },
            { filename: `${service}/PricingsAPI/main.tsp`, status: "modified" },
          ],
          workspace,
        ),
      ),
    ).toEqual(new Set([service, `${service}/BatchPricingsAPI`, `${service}/PricingsAPI`]));
    const checkedPaths = vi.mocked(existsSync).mock.calls.map(([path]) => path);
    expect(new Set(checkedPaths).size).toBe(checkedPaths.length);
    expect(generateTypeSpecMetadata).toHaveBeenCalledTimes(3);
  });

  it("caches unsuccessful ancestor searches across siblings", async () => {
    expect(
      await collectTypeSpecProjectPaths(
        [
          { filename: `${service}/first/main.tsp`, status: "modified" },
          { filename: `${service}/second/main.tsp`, status: "modified" },
        ],
        workspace,
      ),
    ).toEqual([]);
    const checkedPaths = vi.mocked(existsSync).mock.calls.map(([path]) => path);
    expect(new Set(checkedPaths).size).toBe(checkedPaths.length);
    expect(generateTypeSpecMetadata).not.toHaveBeenCalled();
  });

  it("resolves removed subproject configs through the surviving SDK parent", async () => {
    writeConfig(service, sdkLanguages);

    expect(
      await collectTypeSpecProjectPaths(
        [{ filename: `${service}/BatchPricingsAPI/tspconfig.yaml`, status: "removed" }],
        workspace,
      ),
    ).toEqual([service]);
  });

  it("uses parent metadata when a PR modifies multiple subservices", async () => {
    writeConfig(service, sdkLanguages);
    writeConfig(`${service}/BatchPricingsAPI`);
    writeConfig(`${service}/PricingsAPI`);

    const result = await getTypeSpecProjectInfoFromCommit({
      commitSha: "abc123",
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workspace,
      octokit: {
        rest: {
          pulls: {
            get: vi.fn().mockResolvedValue({ data: { labels: [] } }),
            listFiles: vi.fn().mockResolvedValue({
              data: [
                { filename: `${service}/BatchPricingsAPI/main.tsp`, status: "modified" },
                { filename: `${service}/PricingsAPI/main.tsp`, status: "modified" },
              ],
            }),
          },
          repos: {
            getCommit: vi.fn(),
            listPullRequestsAssociatedWithCommit: vi.fn().mockResolvedValue({
              data: [{ number: 42, merged_at: "2026-01-01T00:00:00Z", merge_commit_sha: "abc123" }],
            }),
          },
        },
      },
    });

    expect(result.projectInfo).toEqual({
      tspProjectPath: service,
      apiVersion: "2026-01-01-preview",
      isPreview: true,
    });
    expect(generateTypeSpecMetadata).toHaveBeenCalledTimes(3);
  });

  it.each(["2026-01-01-preview", "all", "multiple-versions", undefined])(
    "resolves private-preview version %s from non-language metadata",
    async (apiVersion) => {
      writeConfig(service, {
        unknown: [{ emitterName: "@azure-tools/typespec-autorest", apiVersion }],
      });
      const result = await getTypeSpecProjectInfoFromCommit({
        commitSha: "abc123",
        owner: "Azure",
        repo: "azure-rest-api-specs-pr",
        workspace,
        octokit: {
          rest: {
            pulls: {
              get: vi.fn().mockResolvedValue({ data: { labels: [] } }),
              listFiles: vi.fn().mockResolvedValue({
                data: [{ filename: `${service}/tspconfig.yaml`, status: "modified" }],
              }),
            },
            repos: {
              getCommit: vi.fn(),
              listPullRequestsAssociatedWithCommit: vi.fn().mockResolvedValue({
                data: [
                  { number: 42, merged_at: "2026-01-01T00:00:00Z", merge_commit_sha: "abc123" },
                ],
              }),
            },
          },
        },
      });

      expect(result.prNumber).toBe(42);
      if (apiVersion) {
        expect(result.projectInfo).toEqual({
          tspProjectPath: service,
          apiVersion,
          isPreview: apiVersion.endsWith("-preview"),
        });
        expect(result.projectError).toBeUndefined();
      } else {
        expect(result.projectInfo).toBeNull();
        expect(result.projectError?.tspProjectPath).toBe(service);
        expect(result.projectError?.message).toContain("No API version found");
      }
      expect(generateTypeSpecMetadata).toHaveBeenCalledTimes(1);
    },
  );

  it.each([true, false])(
    "carries ambiguous paths and reuses changed files (associated PR: %s)",
    async (hasPr) => {
      const paths = [service, "specification/other"];
      for (const path of paths) {
        writeConfig(path, sdkLanguages);
      }
      const files = [
        { filename: `${service}/tspconfig.yaml`, status: "modified" },
        { filename: "specification/other/main.tsp", status: "modified" },
      ];
      const listFiles = vi.fn().mockResolvedValue({ data: files });
      const getCommit = vi.fn().mockResolvedValue({ data: { files } });
      const get = vi.fn().mockResolvedValue({ data: { labels: [{ name: "new-api-version" }] } });

      const result = await getTypeSpecProjectInfoFromCommit({
        commitSha: "abc123",
        owner: "Azure",
        repo: "azure-rest-api-specs",
        workspace,
        octokit: {
          rest: {
            pulls: { get, listFiles },
            repos: {
              getCommit,
              listPullRequestsAssociatedWithCommit: vi.fn().mockResolvedValue({
                data: hasPr
                  ? [{ number: 42, merged_at: "2026-01-01T00:00:00Z", merge_commit_sha: "abc123" }]
                  : [],
              }),
            },
          },
        },
      });

      expect(result.projectInfo).toBeNull();
      expect(result.multipleProjectPaths).toEqual(paths);
      expect(result.changedFiles).toEqual(files);
      expect(result.prNumber).toBe(hasPr ? 42 : undefined);
      expect(listFiles).toHaveBeenCalledTimes(hasPr ? 1 : 0);
      expect(getCommit).toHaveBeenCalledTimes(hasPr ? 0 : 1);
      expect(get).toHaveBeenCalledTimes(hasPr ? 1 : 0);
      expect(generateTypeSpecMetadata).toHaveBeenCalledTimes(2);
    },
  );
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

    const result = await getTypeSpecProjectInfoFromCommit({
      commitSha: "abc123",
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
            getCommit: vi.fn(),
            listPullRequestsAssociatedWithCommit: vi.fn().mockResolvedValue({
              data: [{ number: 42, merged_at: "2026-01-01T00:00:00Z", merge_commit_sha: "abc123" }],
            }),
          },
        },
      },
    });

    expect(result.projectInfo).toBeNull();
  });
});

describe("TypeSpec project detection edge cases", () => {
  it("still detects project when PR lacks new-api-version label", async () => {
    const projectPath = join(workspace, "specification/foo");
    mkdirSync(projectPath, { recursive: true });
    writeFileSync(join(projectPath, "tspconfig.yaml"), "");
    writeFileSync(join(projectPath, "main.tsp"), "namespace Demo;");

    // Setup mock metadata for the project
    setupMockMetadata(projectPath, "2025-08-01", "preview");

    const get = vi.fn().mockResolvedValueOnce({
      data: { labels: [] },
    });
    const listFiles = vi
      .fn()
      .mockResolvedValueOnce({
        data: [
          { filename: "specification/foo/tspconfig.yaml", status: "modified" },
          { filename: "specification/foo/2025-08-01/main.tsp", status: "modified" },
        ],
      })
      .mockResolvedValueOnce({ data: [] });

    const result = await getTypeSpecProjectInfoFromCommit({
      commitSha: "abc123",
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
            getCommit: vi.fn(),
            listPullRequestsAssociatedWithCommit: vi.fn().mockResolvedValue({
              data: [{ number: 42, merged_at: "2026-01-01T00:00:00Z", merge_commit_sha: "abc123" }],
            }),
          },
        },
      },
    });

    expect(result.projectInfo).not.toBeNull();
    expect(result.projectInfo?.tspProjectPath).toBe("specification/foo");
    expect(result.projectInfo?.apiVersion).toBe("2025-08-01");
    expect(result.projectInfo?.isPreview).toBe(false);
    expect(listFiles).toHaveBeenCalled();
  });

  it("returns null when PR has multiple tsp projects", async () => {
    for (const project of ["proj1", "proj2"]) {
      const projectPath = join(workspace, "specification", project);
      mkdirSync(projectPath, { recursive: true });
      writeFileSync(join(projectPath, "tspconfig.yaml"), "");
      setupMockMetadata(projectPath, "2026-01-01", "stable");
    }
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

    const result = await getTypeSpecProjectInfoFromCommit({
      commitSha: "abc123",
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
            getCommit: vi.fn(),
            listPullRequestsAssociatedWithCommit: vi.fn().mockResolvedValue({
              data: [{ number: 42, merged_at: "2026-01-01T00:00:00Z", merge_commit_sha: "abc123" }],
            }),
          },
        },
      },
    });

    expect(result.projectInfo).toBeNull();
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

  it("resolves associated PR from commit SHA", async () => {
    const listPullRequestsAssociatedWithCommit = vi.fn().mockResolvedValueOnce({
      data: [{ number: 99, merged_at: "2026-10-26T00:00:00Z", merge_commit_sha: "abc123" }],
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

  it.each([
    {
      name: "an open PR with a matching provisional merge SHA",
      pullRequests: [{ number: 29284, merged_at: null, merge_commit_sha: "abc123" }],
      expected: undefined,
    },
    {
      name: "a PR merged at a different commit",
      pullRequests: [
        { number: 29284, merged_at: "2026-10-26T00:00:00Z", merge_commit_sha: "def456" },
      ],
      expected: undefined,
    },
    {
      name: "a merged PR without a merge commit SHA",
      pullRequests: [{ number: 29284, merged_at: "2026-10-26T00:00:00Z" }],
      expected: undefined,
    },
    {
      name: "a matching merged PR after unrelated associations",
      pullRequests: [
        { number: 29284, merged_at: null, merge_commit_sha: null },
        { number: 30467, merged_at: "2026-10-25T00:00:00Z", merge_commit_sha: "def456" },
        { number: 30970, merged_at: "2026-10-26T00:00:00Z", merge_commit_sha: "abc123" },
      ],
      expected: 30970,
    },
    {
      name: "a matching merge SHA with different hexadecimal casing",
      pullRequests: [
        { number: 30970, merged_at: "2026-10-26T00:00:00Z", merge_commit_sha: "ABC123" },
      ],
      expected: 30970,
    },
    { name: "no associated PRs", pullRequests: [], expected: undefined },
  ])("resolves only the actual merged PR: $name", async ({ pullRequests, expected }) => {
    const listPullRequestsAssociatedWithCommit = vi.fn().mockResolvedValueOnce({
      data: pullRequests,
    });
    const get = vi.fn();

    const result = await getAssociatedPrNumber({
      octokit: {
        rest: {
          pulls: { get, listFiles: vi.fn() },
          repos: { listPullRequestsAssociatedWithCommit, getCommit: vi.fn() },
        },
      },
      owner: "Azure",
      repo: "azure-rest-api-specs-pr",
      commitSha: "abc123",
    });

    expect(result).toBe(expected);
    expect(listPullRequestsAssociatedWithCommit).toHaveBeenCalledExactlyOnceWith({
      owner: "Azure",
      repo: "azure-rest-api-specs-pr",
      commit_sha: "abc123",
    });
    expect(get).not.toHaveBeenCalled();
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
    writeFileSync(join(projectPath, "tspconfig.yaml"), "");
    writeFileSync(join(projectPath, "main.tsp"), "namespace Demo;");

    // Setup mock metadata for the project
    setupMockMetadata(projectPath, "2026-01-01-preview", "stable");

    const listPullRequestsAssociatedWithCommit = vi.fn().mockResolvedValueOnce({
      data: [
        { number: 29284, merged_at: null, merge_commit_sha: null },
        { number: 123, merged_at: "2026-10-26T00:00:00Z", merge_commit_sha: "abcdef" },
      ],
    });
    const get = vi.fn().mockResolvedValue({
      data: {
        labels: [{ name: "new-api-version" }],
      },
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
      commitSha: "abcdef",
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

    expect(result.prNumber).toBe(123);
    expect(result.hasNewApiVersionLabel).toBe(true);
    expect(result.projectInfo?.tspProjectPath).toBe("specification/foo");
    expect(result.projectInfo?.apiVersion).toBe("2026-01-01-preview");
    expect(result.projectInfo?.isPreview).toBe(true);
    expect(get).toHaveBeenCalledExactlyOnceWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      pull_number: 123,
    });
    expect(listFiles).toHaveBeenCalledExactlyOnceWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      pull_number: 123,
      per_page: 100,
      page: 1,
    });
  });

  it("inspects TypeSpec commit changes when no PR is associated", async () => {
    const projectPath = join(workspace, "specification/bar");
    mkdirSync(projectPath, { recursive: true });
    writeFileSync(join(projectPath, "tspconfig.yaml"), "");
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
      commitSha: "abcdef",
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
    });

    expect(result.prNumber).toBeUndefined();
    expect(result.hasNewApiVersionLabel).toBe(false);
    expect(result.projectInfo?.tspProjectPath).toBe("specification/bar");
    expect(result.projectInfo?.apiVersion).toBe("2025-09-01");
  });

  it("skips folder-migration PRs and does not fetch changed files", async () => {
    const listPullRequestsAssociatedWithCommit = vi.fn().mockResolvedValueOnce({
      data: [{ number: 321, merged_at: "2026-10-26T00:00:00Z", merge_commit_sha: "mig123" }],
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
      data: [{ number: 654, merged_at: "2026-10-26T00:00:00Z", merge_commit_sha: "skip123" }],
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
    writeFileSync(join(projectPath, "tspconfig.yaml"), "");
    writeFileSync(join(projectPath, "main.tsp"), "namespace Demo;");

    // Setup mock metadata for the project
    setupMockMetadata(projectPath, "2025-09-01", "stable");

    const listPullRequestsAssociatedWithCommit = vi.fn().mockResolvedValueOnce({
      data: [{ number: 123, merged_at: "2026-10-26T00:00:00Z", merge_commit_sha: "abcdef" }],
    });
    const get = vi.fn().mockResolvedValue({
      data: { labels: [] },
    });
    const listFiles = vi.fn().mockResolvedValueOnce({
      data: [
        { filename: "specification/bar/tspconfig.yaml", status: "modified" },
        // Renamed into a folder that looks like an older API version; must be ignored.
        { filename: "specification/bar/2020-01-01/legacy.tsp", status: "renamed" },
        { filename: "specification/bar/2025-09-01/main.tsp", status: "added" },
      ],
    });

    const result = await getTypeSpecProjectInfoFromCommit({
      commitSha: "abcdef",
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
  it("prefers existing SDK version resolution over the private-preview fallback", () => {
    const metadata = createMetadata({
      unknown: [{ emitterName: "@azure-tools/typespec-autorest", apiVersion: "all" }],
      python: [
        {
          emitterName: "python",
          apiVersion: "2026-01-01-preview",
          packageName: "azure-mgmt-sample",
        },
      ],
    });

    expect(resolveTypeSpecMetadata(metadata, true)).toEqual({
      apiVersion: "2026-01-01-preview",
    });
  });

  it("does not allow non-language metadata without a package for public releases", () => {
    const metadata = createMetadata({
      unknown: [{ emitterName: "@azure-tools/typespec-autorest", apiVersion: "2026-01-01" }],
    });

    expect(() => resolveTypeSpecMetadata(metadata)).toThrow(
      "No valid language configurations found",
    );
  });

  it.each<TypeSpecMetadata["languages"]>([
    {},
    { unknown: [{ emitterName: "@azure-tools/typespec-autorest" }] },
    { python: [{ emitterName: "python", packageName: "azure-mgmt-sample", apiVersion: "" }] },
  ])("rejects a private preview with no emitter API version", (languages) => {
    expect(() => resolveTypeSpecMetadata(createMetadata(languages), true)).toThrow(
      "No API version found",
    );
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

  it("keeps the existing first-version selection when metadata contains multiple versions", () => {
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

    expect(resolveTypeSpecMetadata(metadata)).toEqual({ apiVersion: "2025-08-01" });
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

  it("keeps the existing concrete version when one language has no version", () => {
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

    expect(resolveTypeSpecMetadata(metadata)).toEqual({ apiVersion: "2025-08-01" });
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

  it("throws error when no valid language configurations found", () => {
    const metadata = createMetadata({
      csharp: [
        {
          emitterName: "csharp",
        },
      ],
    });

    expect(() => {
      resolveTypeSpecMetadata(metadata);
    }).toThrow("No valid language configurations found in TypeSpec metadata");
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

  it.each(["", "latest", "v1"])(
    "accepts metadata API version '%s' without date validation",
    async (apiVersion) => {
      const projectPath = join(workspace, "specification/foo");
      mockMetadataMap.set(projectPath, { apiVersion, sdkType: "stable" });

      await expect(
        getTypeSpecProjectVersionFromMetadata(projectPath, "specification/foo"),
      ).resolves.toEqual({ tspProjectPath: "specification/foo", apiVersion, isPreview: false });
    },
  );
});
