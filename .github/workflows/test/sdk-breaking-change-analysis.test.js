import { describe, expect, it } from "vitest";
import { resolveSdkValidationRepository } from "../src/sdk-breaking-change-analysis.js";
import { createMockGithub } from "./mocks.js";

describe("sdk-breaking-change-analysis", () => {
  it("resolves the latest completed SDK Validation repository", async () => {
    const github = createMockGithub();
    github.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            app: { name: "Azure Pipelines" },
            name: "SDK Validation - Go",
            status: "completed",
            completed_at: "2026-09-03T10:00:00Z",
            details_url: "https://dev.azure.com/project/_build/results?buildId=1",
          },
          {
            app: { name: "Azure Pipelines" },
            name: "SDK Validation - Python",
            status: "completed",
            completed_at: "2026-09-03T11:00:00Z",
            details_url: "https://dev.azure.com/project/_build/results?buildId=2",
          },
        ],
      },
    });

    await expect(
      resolveSdkValidationRepository({
        github,
        owner: "owner",
        repo: "repo",
        headSha: "head-sha",
        pullNumber: 42,
      }),
    ).resolves.toBe("azure-sdk-for-python");
  });

  it("rejects SDK Validation checks without a recognized language", async () => {
    await expect(
      resolveSdkValidationRepository({
        github: createMockGithub(),
        owner: "owner",
        repo: "repo",
        headSha: "head-sha",
        pullNumber: 42,
      }),
    ).rejects.toThrow("recognized language");
  });
});