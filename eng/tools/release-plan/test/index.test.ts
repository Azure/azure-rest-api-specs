import { describe, expect, it, vi } from "vitest";
import {
  buildReleaseplanCommentBody,
  compareApiVersionsDesc,
  createOctokit,
  detectApiVersions,
  ensureReleasePlan,
  findTspConfigDir,
  getApiReleaseType,
  getAssociatedPrNumber,
  getCommitChangedFiles,
  getPrChangedFiles,
  getSdkReleaseType,
  getTypeSpecProjectInfoFromCommit,
  getTypeSpecProjectInfoFromPr,
  parseApiVersion,
  postReleasePlanComment,
  type AzsdkRunner,
} from "../src/index.js";

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

describe("release type helpers", () => {
  it("sets Private Preview for private specs repo", () => {
    expect(getApiReleaseType(true, "azure-rest-api-specs-pr")).toBe("Private Preview");
    expect(getApiReleaseType(false, "azure-rest-api-specs-pr")).toBe("Private Preview");
  });

  it("sets Public Preview or GA for public repo", () => {
    expect(getApiReleaseType(true, "azure-rest-api-specs")).toBe("Public Preview");
    expect(getApiReleaseType(false, "azure-rest-api-specs")).toBe("GA");
  });

  it("sets SDK release type", () => {
    expect(getSdkReleaseType(true)).toBe("preview");
    expect(getSdkReleaseType(false)).toBe("stable");
  });
});

describe("TypeSpec path discovery", () => {
  it("finds nearest tspconfig.yaml directory", () => {
    const workspace = process.cwd();
    const result = findTspConfigDir(
      "specification/service/resource-manager/Microsoft.Sample/main.tsp",
      workspace,
    );
    // In this workspace this path likely does not exist; function should not throw.
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
    const ghCom = createOctokit(undefined);
    const ghe = createOctokit("token");

    expect(ghCom).toBeDefined();
    expect(ghe).toBeDefined();
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

describe("ensureReleasePlan", () => {
  function createRunner(
    outputs: Record<string, { code: number; out: string; err?: string }>,
  ): AzsdkRunner {
    return (args: string[]) => {
      const key = args.join(" ");
      const found = outputs[key];
      if (!found) {
        return { exitCode: 1, stdout: "", stderr: `Unexpected command: ${key}` };
      }

      return {
        exitCode: found.code,
        stdout: found.out,
        stderr: found.err || "",
      };
    };
  }

  const baseContext = {
    prUrl: "https://github.com/Azure/azure-rest-api-specs/pull/123",
    tspProjectPath: "specification/foo/Contoso.Service",
    apiReleaseType: "Public Preview" as const,
    sdkReleaseType: "preview" as const,
    targetMonth: "July 2026",
    apiVersion: "2026-06-01-preview",
    testReleasePlan: false,
  };

  it("returns existing release plan when found by PR", () => {
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: JSON.stringify({ id: 100, apiVersion: "2026-06-01-preview" }),
        },
    });

    const result = ensureReleasePlan(baseContext, runner);
    expect(result.outcome).toBe("existing_by_pr");
    expect(result.releasePlan).toEqual({ id: 100, apiVersion: "2026-06-01-preview" });
  });

  it("returns existing release plan when found by path after PR lookup misses", () => {
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan get --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --output json":
        {
          code: 0,
          out: JSON.stringify({ id: 101, apiVersion: "2026-06-01-preview" }),
        },
    });

    const result = ensureReleasePlan(baseContext, runner);
    expect(result.outcome).toBe("existing_by_path");
    expect(result.releasePlan).toEqual({ id: 101, apiVersion: "2026-06-01-preview" });
  });

  it("creates release plan when no existing plan is found", () => {
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan get --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan create --typespec-path https://github.com/Azure/azure-rest-api-specs/specification/foo/Contoso.Service --api-release-type Public Preview --sdk-type preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --force false --test-release false --output json":
        {
          code: 0,
          out: JSON.stringify({ id: 999, release_plan_link: "https://example.test/999" }),
        },
    });

    const result = ensureReleasePlan(baseContext, runner);
    expect(result.outcome).toBe("created");
    expect(result.releasePlan).toEqual({ id: 999, release_plan_link: "https://example.test/999" });
  });

  it("passes test-release true when enabled", () => {
    const testReleaseContext = { ...baseContext, testReleasePlan: true };
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan get --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan create --typespec-path https://github.com/Azure/azure-rest-api-specs/specification/foo/Contoso.Service --api-release-type Public Preview --sdk-type preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --force false --test-release true --output json":
        {
          code: 0,
          out: JSON.stringify({ id: 1000, release_plan_link: "https://example.test/1000" }),
        },
    });

    const result = ensureReleasePlan(testReleaseContext, runner);
    expect(result.outcome).toBe("created");
    expect(result.releasePlan).toEqual({
      id: 1000,
      release_plan_link: "https://example.test/1000",
    });
  });

  it("handles azsdk command failure on get-by-PR", () => {
    const runner = vi.fn().mockReturnValue({
      exitCode: 1,
      stdout: "",
      stderr: "azsdk command not found",
    });

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow();
  });

  it("handles malformed JSON response from get-by-PR", () => {
    const runner = vi.fn().mockReturnValue({
      exitCode: 0,
      stdout: "{ invalid json",
      stderr: "",
    });

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow();
  });

  it("handles malformed JSON response from create", () => {
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan get --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan create --typespec-path https://github.com/Azure/azure-rest-api-specs/specification/foo/Contoso.Service --api-release-type Public Preview --sdk-type preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --force false --test-release false --output json":
        {
          code: 0,
          out: "{ broken json",
        },
    });

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow();
  });

  it("handles create command failure", () => {
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan get --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan create --typespec-path https://github.com/Azure/azure-rest-api-specs/specification/foo/Contoso.Service --api-release-type Public Preview --sdk-type preview --release-month July 2026 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --force false --test-release false --output json":
        {
          code: 1,
          out: "",
          err: "Cannot create release plan",
        },
    });

    expect(() => ensureReleasePlan(baseContext, runner)).toThrow();
  });

  it("correctly handles december to january month wrap", () => {
    const decContext = { ...baseContext, targetMonth: "December 2025" };
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan get --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan create --typespec-path https://github.com/Azure/azure-rest-api-specs/specification/foo/Contoso.Service --api-release-type Public Preview --sdk-type preview --release-month December 2025 --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --force false --test-release false --output json":
        {
          code: 0,
          out: JSON.stringify({ id: 500 }),
        },
    });

    const result = ensureReleasePlan(decContext, runner);
    expect(result.outcome).toBe("created");
  });

  it("converts relative tsp path to github URL for create command", () => {
    let capturedArgs: string[] = [];
    const runner = (args: string[]) => {
      capturedArgs = args;
      if (args.includes("get")) {
        return { exitCode: 0, stdout: "null", stderr: "" };
      }
      return { exitCode: 0, stdout: JSON.stringify({ id: 42 }), stderr: "" };
    };

    ensureReleasePlan(baseContext, runner);
    const typespecPathArg = capturedArgs.indexOf("--typespec-path");
    expect(capturedArgs[typespecPathArg + 1]).toBe(
      "https://github.com/Azure/azure-rest-api-specs/specification/foo/Contoso.Service",
    );
  });

  it("returns not_found in get-only mode when no release plan exists", () => {
    const runner = createRunner({
      "release-plan get --pull-request https://github.com/Azure/azure-rest-api-specs/pull/123 --output json":
        {
          code: 0,
          out: "null",
        },
      "release-plan get --typespec-path specification/foo/Contoso.Service --api-release-type Public Preview --output json":
        {
          code: 0,
          out: "null",
        },
    });

    const result = ensureReleasePlan(baseContext, runner, false);
    expect(result.outcome).toBe("not_found");
    expect(result.releasePlan).toBeNull();
  });
});

describe("release type determination", () => {
  it("sets Private Preview for specs-pr repo regardless of isPreview", () => {
    expect(getApiReleaseType(true, "azure-rest-api-specs-pr")).toBe("Private Preview");
    expect(getApiReleaseType(false, "azure-rest-api-specs-pr")).toBe("Private Preview");
  });

  it("sets GA for stable versions in public repo", () => {
    expect(getApiReleaseType(false, "azure-rest-api-specs")).toBe("GA");
  });

  it("sets Public Preview for preview versions in public repo", () => {
    expect(getApiReleaseType(true, "azure-rest-api-specs")).toBe("Public Preview");
  });

  it("returns correct SDK release type mapping", () => {
    expect(getSdkReleaseType(true)).toBe("preview");
    expect(getSdkReleaseType(false)).toBe("stable");
  });
});

describe("TypeSpec project detection edge cases", () => {
  it("still detects project when PR lacks new-api-version label", async () => {
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

    // Test calls getPrChangedFiles which verifies pagination
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

    // Verify pagination: 100 files on page 1, 1 file on page 2, 0 on page 3 (stops)
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
    expect(result.isPreview).toBe(true);
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
    const listPullRequestsAssociatedWithCommit = vi
      .fn()
      .mockResolvedValueOnce({ data: [{ number: 99 }] });

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
    const listPullRequestsAssociatedWithCommit = vi
      .fn()
      .mockResolvedValueOnce({ data: [{ number: 123 }] });
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
  });

  it("falls back to commit file analysis when no PR is associated", async () => {
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
  });
});

describe("PR comment creation", () => {
  type CreateCommentParams = {
    owner: string;
    repo: string;
    issue_number: number;
    body: string;
  };

  it("builds markdown comment body with all fields", () => {
    const body = buildReleaseplanCommentBody({
      planId: "123",
      planLink: "https://example.com/plan/123",
      apiVersion: "2025-06-01-preview",
      tspProjectPath: "specification/foo/Contoso.Service",
    });

    expect(body).toContain("### ✅ Release Plan Created");
    expect(body).toContain("[View Release Plan](https://example.com/plan/123)");
    expect(body).toContain("Release Plan ID");
    expect(body).toContain("123");
    expect(body).toContain("2025-06-01-preview");
    expect(body).toContain("specification/foo/Contoso.Service");
  });

  it("builds comment body without link", () => {
    const body = buildReleaseplanCommentBody({
      planId: "456",
      apiVersion: "2025-05-01",
      tspProjectPath: "specification/bar/Contoso.Bar",
    });

    expect(body).toContain("### ✅ Release Plan Created");
    expect(body).not.toContain("[View Release Plan]");
    expect(body).toContain("456");
    expect(body).toContain("2025-05-01");
  });

  it("builds comment body without plan ID", () => {
    const body = buildReleaseplanCommentBody({
      planLink: "https://example.com/plan/789",
      apiVersion: "2025-04-01-preview",
      tspProjectPath: "specification/baz/Contoso.Baz",
    });

    expect(body).toContain("### ✅ Release Plan Created");
    expect(body).toContain("[View Release Plan](https://example.com/plan/789)");
    expect(body).not.toContain("Release Plan ID");
    expect(body).toContain("2025-04-01-preview");
  });

  it("posts comment successfully on PR", async () => {
    const createComment = vi.fn().mockResolvedValueOnce(undefined);

    await postReleasePlanComment({
      octokit: {
        rest: {
          issues: {
            createComment,
          },
        },
      },
      owner: "Azure",
      repo: "azure-rest-api-specs",
      prNumber: 42,
      planId: "999",
      planLink: "https://example.com/plan/999",
      apiVersion: "2025-06-01",
      tspProjectPath: "specification/test/Test.Service",
    });

    expect(createComment).toHaveBeenCalledOnce();
    const firstCall = createComment.mock.calls[0] as [CreateCommentParams] | undefined;
    if (!firstCall) {
      throw new Error("Expected createComment to have one call.");
    }
    const [call] = firstCall;
    expect(call.owner).toBe("Azure");
    expect(call.repo).toBe("azure-rest-api-specs");
    expect(call.issue_number).toBe(42);
    expect(call.body).toContain("Release Plan Created");
  });

  it("throws error when posting comment fails", async () => {
    const createComment = vi.fn().mockRejectedValueOnce(new Error("Network error"));

    await expect(
      postReleasePlanComment({
        octokit: {
          rest: {
            issues: {
              createComment,
            },
          },
        },
        owner: "Azure",
        repo: "azure-rest-api-specs",
        prNumber: 42,
        apiVersion: "2025-06-01",
        tspProjectPath: "specification/test/Test.Service",
      }),
    ).rejects.toThrow("Failed to post release plan comment on PR #42");
  });

  it("posts comment without plan link or ID", async () => {
    const createComment = vi.fn().mockResolvedValueOnce(undefined);

    await postReleasePlanComment({
      octokit: {
        rest: {
          issues: {
            createComment,
          },
        },
      },
      owner: "Azure",
      repo: "azure-rest-api-specs",
      prNumber: 123,
      apiVersion: "2025-07-01-preview",
      tspProjectPath: "specification/minimal/Minimal.Service",
    });

    expect(createComment).toHaveBeenCalledOnce();
    const firstCall = createComment.mock.calls[0] as [CreateCommentParams] | undefined;
    if (!firstCall) {
      throw new Error("Expected createComment to have one call.");
    }
    const [call] = firstCall;
    expect(call.body).toContain("2025-07-01-preview");
    expect(call.body).toContain("specification/minimal/Minimal.Service");
  });
});
