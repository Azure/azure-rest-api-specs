import fs from "node:fs";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { SdkName } from "../../shared/src/sdk-types.ts";
import { createMockSpecGenSdkArtifactInfo } from "../../shared/test/sdk-types.ts";
import * as artifacts from "../src/artifacts.ts";
import * as inputs from "../src/context.ts";
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
        description: "SDK Validation failed for java languages",
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

  it.each([
    ["SDK Validation - JS Libraries", "JS"],
    ["SDK Validation - .NET Libraries", ".NET"],
    ["SDK Validation - JS Provisioning Libraries", "JS Provisioning"],
    ["SDK Validation - .NET Provisioning Libraries", ".NET Provisioning"],
    ["SDK Validation - Python", "Python"],
    ["SDK Validation", "SDK Validation"],
    ["Custom SDK Validation - JS Libraries Extra", "Custom SDK Validation - JS Libraries Extra"],
  ])("should display %s as %s in the summary", async (name, displayName) => {
    mockGithub.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            app: { name: "Azure Pipelines" },
            name,
            status: "completed",
            conclusion: "success",
            details_url: "https://dev.azure.com/project/_build/results?buildId=123",
          },
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
      issue_number: 123,
    });

    const summary: unknown = mockCore.summary.addRaw.mock.calls[0][0];
    expect(summary).toContain("| Check | Status | Required Check |\n");
    expect(summary).toContain(`| ${displayName} | ✅ succeeded | true |\n`);
    expect(mockCore.info).toHaveBeenCalledWith(`Processing check run: ${name} (success)`);
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

  describe("private repository GitHub-only aggregation", () => {
    async function setPrivateStatus() {
      await setSpecGenSdkStatusImpl({
        owner: "Azure",
        repo: "azure-rest-api-specs-pr",
        head_sha: "testSha",
        target_url: "https://example.com",
        github: mockGithub,
        core: mockCore,
        issue_number: 123,
      });
    }

    it("uses configured requiredness without downloading ADO artifacts", async () => {
      mockGithub.rest.checks.listForRef.mockResolvedValue({
        data: {
          check_runs: [
            {
              app: { name: "Azure Pipelines" },
              name: "SDK Validation - Go - PR",
              status: "completed",
              conclusion: "success",
              details_url: null,
            },
            ...["Rust", "JS Provisioning Libraries", ".NET Provisioning Libraries"].map(
              (language) => ({
                app: { name: "Azure Pipelines" },
                name: `SDK Validation - ${language} - PR`,
                status: "completed",
                conclusion: "failure",
              }),
            ),
            {
              app: { name: "Another App" },
              name: "SDK Validation - Go - PR",
              status: "completed",
              conclusion: "failure",
            },
            {
              app: { name: "Azure Pipelines" },
              name: "Other Validation",
              status: "completed",
              conclusion: "failure",
            },
          ],
        },
      });

      await setPrivateStatus();

      expect(mockGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
        expect.objectContaining({ state: "success", sha: "testSha" }),
      );
      expect(mockGithub.rest.checks.listForRef).toHaveBeenCalledWith(
        expect.objectContaining({ ref: "testSha", filter: "latest", per_page: 100 }),
      );
      expect(getAzurePipelineArtifactMock).not.toHaveBeenCalled();
      const summary: unknown = mockCore.summary.addRaw.mock.calls[0][0];
      expect(summary).toContain("| Go | success | true |");
      expect(summary).toContain("| Rust | failure | false |");
      expect(summary).toContain("| JS Provisioning | failure | false |");
      expect(summary).toContain("| .NET Provisioning | failure | false |");
    });

    it.each(["failure", "cancelled", null])(
      "fails a required check with conclusion %s",
      async (conclusion) => {
        mockGithub.rest.checks.listForRef.mockResolvedValue({
          data: {
            check_runs: [
              {
                app: { name: "Azure Pipelines" },
                name: "SDK Validation - .NET - PR",
                status: "completed",
                conclusion,
              },
            ],
          },
        });

        await setPrivateStatus();

        expect(mockGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
          expect.objectContaining({
            state: "failure",
            description: "SDK Validation failed for .NET",
          }),
        );
        expect(getAzurePipelineArtifactMock).not.toHaveBeenCalled();
      },
    );

    it("accepts neutral and skipped required checks", async () => {
      mockGithub.rest.checks.listForRef.mockResolvedValue({
        data: {
          check_runs: [
            {
              app: { name: "Azure Pipelines" },
              name: "SDK Validation - Java - PR",
              status: "completed",
              conclusion: "neutral",
            },
            {
              app: { name: "Azure Pipelines" },
              name: "SDK Validation - Python",
              status: "completed",
              conclusion: "skipped",
            },
          ],
        },
      });

      await setPrivateStatus();

      expect(mockGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
        expect.objectContaining({ state: "success" }),
      );
    });

    it("waits for optional checks to finish too", async () => {
      mockGithub.rest.checks.listForRef.mockResolvedValue({
        data: {
          check_runs: [
            {
              app: { name: "Azure Pipelines" },
              name: "SDK Validation - Go - PR",
              status: "completed",
              conclusion: "success",
            },
            {
              app: { name: "Azure Pipelines" },
              name: "SDK Validation - Rust - PR",
              status: "in_progress",
              conclusion: null,
            },
          ],
        },
      });

      await setPrivateStatus();

      expect(mockGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
        expect.objectContaining({ state: "pending" }),
      );
      expect(getAzurePipelineArtifactMock).not.toHaveBeenCalled();
    });

    it("rejects unconfigured SDK checks instead of silently exempting them", async () => {
      mockGithub.rest.checks.listForRef.mockResolvedValue({
        data: {
          check_runs: [
            {
              app: { name: "Azure Pipelines" },
              name: "SDK Validation - New Language - PR",
              status: "completed",
              conclusion: "success",
            },
          ],
        },
      });

      await expect(setPrivateStatus()).rejects.toThrow("has no policy");
      expect(mockGithub.rest.repos.createCommitStatus).not.toHaveBeenCalled();
      expect(getAzurePipelineArtifactMock).not.toHaveBeenCalled();
    });

    it("reevaluates reopened PRs without an ADO details URL", async () => {
      const extractInputsMock = vi.spyOn(inputs, "extractInputs").mockResolvedValue({
        owner: "Azure",
        repo: "azure-rest-api-specs-pr",
        head_sha: "testSha",
        issue_number: 123,
        run_id: NaN,
      });
      mockGithub.rest.checks.listForRef.mockResolvedValue({
        data: {
          check_runs: [
            {
              app: { name: "Azure Pipelines" },
              name: "SDK Validation - Go - PR",
              status: "completed",
              conclusion: "success",
            },
          ],
        },
      });

      try {
        await setSpecGenSdkStatus({
          github: mockGithub,
          core: mockCore,
          context: createMockContext(),
        });
      } finally {
        extractInputsMock.mockRestore();
      }

      expect(mockGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
        expect.objectContaining({ state: "success", sha: "testSha" }),
      );
    });
  });
});
