import fs from "node:fs";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { SdkName } from "../../shared/src/sdk-types.ts";
import { createMockSpecGenSdkArtifactInfo } from "../../shared/test/sdk-types.ts";
import * as artifacts from "../src/artifacts.ts";
import setSpecGenSdkStatus, { setSpecGenSdkStatusImpl } from "../src/spec-gen-sdk-status.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

describe("spec-gen-sdk-status", () => {
  let mockGithub: ReturnType<typeof createMockGithub>;

  let mockCore: ReturnType<typeof createMockCore>;

  let getAzurePipelineArtifactMock: import("vitest").MockInstance;

  let appendFileSyncMock: import("vitest").MockInstance;

  beforeEach(() => {
    // Setup mocks using the helper functions
    mockGithub = createMockGithub();
    mockGithub.rest.pulls.get.mockResolvedValue({ data: { state: "open" } });
    mockCore = createMockCore();

    // Setup specific mocks
    getAzurePipelineArtifactMock = vi
      .spyOn(artifacts, "getAzurePipelineArtifact")
      // oxlint-disable-next-line eslint/no-unused-vars
      .mockImplementation(async ({ ado_build_id, ado_project_url, artifactName }) => {
        return Promise.resolve({
          artifactData: JSON.stringify(
            createMockSpecGenSdkArtifactInfo({
              language: SdkName.Go,
              result: "succeeded",
              isSpecGenSdkCheckRequired: true,
            }),
          ),
        });
      });

    appendFileSyncMock = vi.spyOn(fs, "appendFileSync").mockImplementation(vi.fn());

    // Reset mock call counts
    vi.clearAllMocks();

    // Mock environment variable
    process.env.GITHUB_STEP_SUMMARY = "/tmp/test-summary.md";
  });

  afterEach(() => {
    // Restore mocks
    getAzurePipelineArtifactMock.mockRestore();
    appendFileSyncMock.mockRestore();
  });

  it("does not publish status or handoff artifacts for a closed PR", async () => {
    mockGithub.rest.pulls.get.mockResolvedValue({ data: { state: "closed" } });
    await setSpecGenSdkStatusImpl({
      owner: "testOwner",
      repo: "testRepo",
      head_sha: "testSha",
      target_url: "https://example.com",
      github: mockGithub,
      core: mockCore,
      issue_number: 123,
    });
    expect(mockGithub.rest.checks.listForRef).not.toHaveBeenCalled();
    expect(mockGithub.rest.repos.createCommitStatus).not.toHaveBeenCalled();
    expect(mockCore.setOutput).not.toHaveBeenCalled();
  });

  it.each([
    { state: "closed", sha: "testSha", repo: "testOwner/testRepo", allowed: false },
    { state: "open", sha: "oldSha", repo: "testOwner/testRepo", allowed: false },
    { state: "open", sha: "testSha", repo: "other/repo", allowed: false },
    { state: "open", sha: "testSha", repo: "testOwner/testRepo", allowed: true },
  ])(
    "handles check_run PR state $state, head $sha, repo $repo",
    async ({ state, sha, repo, allowed }) => {
      mockGithub.rest.repos.listPullRequestsAssociatedWithCommit.mockResolvedValue({
        data: [{ state, head: { sha }, base: { repo: { full_name: repo } } }],
      });
      mockGithub.rest.checks.listForRef.mockResolvedValue({
        data: {
          check_runs: [
            { app: { name: "Azure Pipelines" }, name: "SDK Validation", status: "in_progress" },
          ],
        },
      });
      await setSpecGenSdkStatusImpl({
        owner: "testOwner",
        repo: "testRepo",
        head_sha: "testSha",
        target_url: "https://example.com",
        github: mockGithub,
        core: mockCore,
        issue_number: NaN,
      });
      expect(mockGithub.rest.repos.createCommitStatus).toHaveBeenCalledTimes(allowed ? 1 : 0);
    },
  );

  it("refreshes a reopened PR without a check_run details URL", async () => {
    const context = createMockContext();
    context.eventName = "pull_request_target";
    context.payload = {
      action: "reopened",
      repository: { name: "testRepo", owner: { login: "testOwner" } },
      pull_request: { number: 123, head: { sha: "testSha" } },
    };
    mockGithub.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          { app: { name: "Azure Pipelines" }, name: "SDK Validation", status: "in_progress" },
        ],
      },
    });
    await setSpecGenSdkStatus({ github: mockGithub, context, core: mockCore });
    expect(mockGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "pending", sha: "testSha" }),
    );
  });

  it.each(["open", "closed"])(
    "rechecks PR state after a fork commit needs the search fallback (%s)",
    async (state) => {
      mockGithub.rest.search.issuesAndPullRequests.mockResolvedValue({
        data: { total_count: 1, items: [{ number: 123 }] },
      });
      mockGithub.rest.pulls.get.mockResolvedValue({
        data: { state, head: { sha: "testSha" } },
      });
      mockGithub.rest.checks.listForRef.mockResolvedValue({
        data: {
          check_runs: [
            { app: { name: "Azure Pipelines" }, name: "SDK Validation", status: "in_progress" },
          ],
        },
      });
      await setSpecGenSdkStatusImpl({
        owner: "testOwner",
        repo: "testRepo",
        head_sha: "testSha",
        target_url: "https://example.com",
        github: mockGithub,
        core: mockCore,
        issue_number: NaN,
      });
      expect(mockGithub.rest.search.issuesAndPullRequests).toHaveBeenCalledWith({
        q: "sha:testSha type:pr state:open repo:testOwner/testRepo",
        advanced_search: "true",
      });
      expect(mockGithub.rest.repos.createCommitStatus).toHaveBeenCalledTimes(
        state === "open" ? 1 : 0,
      );
    },
  );

  it("should set pending status when checks are not completed", async () => {
    // Setup GitHub API to return incomplete checks
    mockGithub.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            app: { name: "Azure Pipelines" },
            name: "SDK Validation",
            status: "in_progress",
            conclusion: null,
          },
        ],
      },
    });

    // Call the function
    await setSpecGenSdkStatusImpl({
      owner: "testOwner",
      repo: "testRepo",
      head_sha: "testSha",
      target_url: "https://example.com",
      github: mockGithub,
      core: mockCore,
      issue_number: 123,
    });

    // Verify the right status was set
    expect(mockGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        owner: "testOwner",
        repo: "testRepo",
        sha: "testSha",
        state: "pending",
      }),
    );

    expect(mockCore.setOutput).toBeCalledWith("head_sha", "testSha");
    expect(mockCore.setOutput).toBeCalledWith("issue_number", 123);
  });

  it("should set success status when all checks are completed successfully", async () => {
    // Mock check runs with completed status
    mockGithub.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            app: { name: "Azure Pipelines" },
            name: "SDK Validation",
            status: "completed",
            conclusion: "success",
            details_url: "https://dev.azure.com/project/_build/results?buildId=123",
          },
        ],
      },
    });

    // Mock getAzurePipelineArtifact to return success data
    getAzurePipelineArtifactMock.mockResolvedValue({
      artifactData: JSON.stringify(
        createMockSpecGenSdkArtifactInfo({
          language: SdkName.Go,
          result: "succeeded",
          isSpecGenSdkCheckRequired: true,
        }),
      ),
    });

    // Call the function
    await setSpecGenSdkStatusImpl({
      owner: "testOwner",
      repo: "testRepo",
      head_sha: "testSha",
      target_url: "https://example.com",
      github: mockGithub,
      core: mockCore,
      issue_number: 123,
    });

    // Verify the right status was set
    expect(mockGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        owner: "testOwner",
        repo: "testRepo",
        sha: "testSha",
        state: "success",
        description: "SDK Validation CI checks succeeded",
      }),
    );
  });

  it("should set failure status when required checks fail", async () => {
    // Mock check runs with completed status but failed required checks
    mockGithub.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            app: { name: "Azure Pipelines" },
            name: "SDK Validation",
            status: "completed",
            conclusion: "success",
            details_url: "https://dev.azure.com/project/_build/results?buildId=123",
          },
          {
            app: { name: "Azure Pipelines" },
            name: "SDK Validation",
            status: "completed",
            conclusion: "failure",
            details_url: "https://dev.azure.com/project/_build/results?buildId=456",
          },
        ],
      },
    });

    // Mock getAzurePipelineArtifact to return mixed results
    getAzurePipelineArtifactMock.mockImplementation(({ ado_build_id }) => {
      if (ado_build_id === "123") {
        return {
          artifactData: JSON.stringify(
            createMockSpecGenSdkArtifactInfo({
              language: SdkName.Go,
              result: "succeeded",
              isSpecGenSdkCheckRequired: true,
            }),
          ),
        };
      } else {
        return {
          artifactData: JSON.stringify(
            createMockSpecGenSdkArtifactInfo({
              language: SdkName.Java,
              result: "failed",
              isSpecGenSdkCheckRequired: true,
            }),
          ),
        };
      }
    });

    // Call the function
    await setSpecGenSdkStatusImpl({
      owner: "testOwner",
      repo: "testRepo",
      head_sha: "testSha",
      target_url: "https://example.com",
      github: mockGithub,
      core: mockCore,
      issue_number: 123,
    });

    // Verify the right status was set
    expect(mockGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        owner: "testOwner",
        repo: "testRepo",
        sha: "testSha",
        state: "failure",
        description: expect.stringContaining("failed for") as unknown,
      }),
    );
  });

  it("should write summary to GitHub Actions summary", async () => {
    // Mock check runs
    mockGithub.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            app: { name: "Azure Pipelines" },
            name: "SDK Validation",
            status: "completed",
            conclusion: "success",
            details_url: "https://dev.azure.com/project/_build/results?buildId=123",
          },
        ],
      },
    });

    // Call the function
    await setSpecGenSdkStatusImpl({
      owner: "testOwner",
      repo: "testRepo",
      head_sha: "testSha",
      target_url: "https://example.com",
      github: mockGithub,
      core: mockCore,
      issue_number: 123,
    });

    // Verify summary was written
    expect(mockCore.summary.addRaw).toHaveBeenCalled();
    expect(mockCore.summary.addRaw.mock.calls[0][0]).toContain("SDK Validation CI Checks Result");
    expect(mockCore.summary.write).toHaveBeenCalled();
  });

  it("should handle artifact download failures", async () => {
    // Mock check runs
    mockGithub.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            app: { name: "Azure Pipelines" },
            name: "SDK Validation",
            status: "completed",
            conclusion: "success",
            details_url: "https://dev.azure.com/project/_build/results?buildId=123",
          },
        ],
      },
    });

    // Mock artifact download failure
    getAzurePipelineArtifactMock.mockResolvedValue({ artifactData: "" });

    // Expect the function to throw an error
    await expect(
      setSpecGenSdkStatusImpl({
        owner: "testOwner",
        repo: "testRepo",
        head_sha: "testSha",
        target_url: "https://example.com",
        github: mockGithub,
        core: mockCore,
        issue_number: 123,
      }),
    ).rejects.toThrow("Artifact 'spec-gen-sdk-artifact' not found");
  });

  it("should handle non-required checks that fail", async () => {
    // Mock check runs with completed status but failed non-required checks
    mockGithub.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            app: { name: "Azure Pipelines" },
            name: "SDK Validation",
            status: "completed",
            conclusion: "success",
            details_url: "https://dev.azure.com/project/_build/results?buildId=123",
          },
          {
            app: { name: "Azure Pipelines" },
            name: "SDK Validation",
            status: "completed",
            conclusion: "failure",
            details_url: "https://dev.azure.com/project/_build/results?buildId=456",
          },
        ],
      },
    });

    // Mock getAzurePipelineArtifact to return mixed results
    getAzurePipelineArtifactMock.mockImplementation(({ ado_build_id }) => {
      if (ado_build_id === "123") {
        return {
          artifactData: JSON.stringify(
            createMockSpecGenSdkArtifactInfo({
              language: SdkName.Go,
              result: "succeeded",
              isSpecGenSdkCheckRequired: true,
            }),
          ),
        };
      } else {
        return {
          artifactData: JSON.stringify(
            createMockSpecGenSdkArtifactInfo({
              language: SdkName.Java,
              result: "failed",
              isSpecGenSdkCheckRequired: false, // Not required
            }),
          ),
        };
      }
    });

    // Call the function
    await setSpecGenSdkStatusImpl({
      owner: "testOwner",
      repo: "testRepo",
      head_sha: "testSha",
      target_url: "https://example.com",
      github: mockGithub,
      core: mockCore,
      issue_number: 123,
    });

    // Verify the right status was set (success since only non-required failed)
    expect(mockGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        owner: "testOwner",
        repo: "testRepo",
        sha: "testSha",
        state: "success",
        description: "SDK Validation CI checks succeeded",
      }),
    );
  });

  it("should skip status update when no SDK Validation checks are found", async () => {
    // Simulates a reopened PR with no SDK-relevant changes: no SDK Validation check runs exist.
    mockGithub.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [],
      },
    });

    await setSpecGenSdkStatusImpl({
      owner: "testOwner",
      repo: "testRepo",
      head_sha: "testSha",
      target_url: "https://example.com",
      github: mockGithub,
      core: mockCore,
      issue_number: 123,
    });

    // No status should be set when there are no SDK Validation checks.
    expect(mockGithub.rest.repos.createCommitStatus).not.toHaveBeenCalled();

    // Outputs should still be set for downstream artifact upload steps.
    expect(mockCore.setOutput).toBeCalledWith("head_sha", "testSha");
    expect(mockCore.setOutput).toBeCalledWith("issue_number", 123);
  });
});
