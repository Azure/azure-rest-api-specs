// @ts-check
import fs from "fs";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import * as artifacts from "../src/artifacts.js";
import * as github from "../src/github.js";
import { setSpecGenSdkStatusImpl } from "../src/spec-gen-sdk-status.js";
import { createMockCore, createMockGithub } from "./mocks.js";

describe("spec-gen-sdk-status", () => {
  let mockGithub;
  let mockCore;
  let getAzurePipelineArtifactMock;
  let writeToActionsSummaryMock;
  let appendFileSyncMock;

  beforeEach(() => {
    // Setup mocks using the helper functions
    mockGithub = createMockGithub();
    mockCore = createMockCore();

    // Setup specific mocks
    getAzurePipelineArtifactMock = vi
      .spyOn(artifacts, "getAzurePipelineArtifact")
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      .mockImplementation(async ({ ado_build_id, ado_project_url, artifactName }) => {
        return {
          artifactData: JSON.stringify({
            language: "test-language",
            result: "succeeded",
            isSpecGenSdkCheckRequired: true,
          }),
        };
      });

    writeToActionsSummaryMock = vi
      .spyOn(github, "writeToActionsSummary")
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      .mockImplementation(async (content, core) => {
        // Implementation that just returns
        return;
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
    writeToActionsSummaryMock.mockRestore();
    appendFileSyncMock.mockRestore();
  });

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
      artifactData: JSON.stringify({
        language: "test-language",
        result: "succeeded",
        isSpecGenSdkCheckRequired: true,
      }),
    });

    // Call the function
    await setSpecGenSdkStatusImpl({
      owner: "testOwner",
      repo: "testRepo",
      head_sha: "testSha",
      target_url: "https://example.com",
      github: mockGithub,
      core: mockCore,
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
    getAzurePipelineArtifactMock.mockImplementation(async ({ ado_build_id }) => {
      if (ado_build_id === "123") {
        return {
          artifactData: JSON.stringify({
            language: "test-language-1",
            result: "succeeded",
            isSpecGenSdkCheckRequired: true,
          }),
        };
      } else {
        return {
          artifactData: JSON.stringify({
            language: "test-language-2",
            result: "failed",
            isSpecGenSdkCheckRequired: true,
          }),
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
    });

    // Verify the right status was set
    expect(mockGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        owner: "testOwner",
        repo: "testRepo",
        sha: "testSha",
        state: "failure",
        description: expect.stringContaining("failed for"),
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
    });

    // Verify summary was written
    expect(writeToActionsSummaryMock).toHaveBeenCalled();
    expect(writeToActionsSummaryMock.mock.calls[0][0]).toContain("SDK Validation CI Checks Result");
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
    getAzurePipelineArtifactMock.mockImplementation(async ({ ado_build_id }) => {
      if (ado_build_id === "123") {
        return {
          artifactData: JSON.stringify({
            language: "test-language-1",
            result: "succeeded",
            isSpecGenSdkCheckRequired: true,
          }),
        };
      } else {
        return {
          artifactData: JSON.stringify({
            language: "test-language-2",
            result: "failed",
            isSpecGenSdkCheckRequired: false, // Not required
          }),
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
});
