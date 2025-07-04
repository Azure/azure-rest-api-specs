import { describe, expect, it } from "vitest";
import { summarizeChecksImpl } from "../src/summarize-checks.js";
import { Octokit } from "@octokit/rest";

import { LabelAction } from "../src/label.js";
import {
  createMockCore,
  createMockGithub as createMockGithubBase,
} from "./mocks.js";

const mockCore = createMockCore();

describe("summarizeChecksImpl", () => {
  describe("integration tests", () => {
    it.skipIf(!process.env.GITHUB_TOKEN)("should fetch real PR data when GITHUB_TOKEN is available", async () => {
      // Create real GitHub client with token
      const github = new Octokit({
        auth: process.env.GITHUB_TOKEN,
      });

    const mockContext = {
        repo: {
            owner: "Azure",
            repo: "azure-rest-api-specs",
        },
        payload: {
            action: "opened",
            pull_request: {
                number: 35629,
                head: {
                    sha: "c12f0191c34212c4e6be88121d132ccb0a7f560c",
                },
            },
        },
        eventName: "pull_request",
    }

      // Use a known PR from the azure-rest-api-specs repo for testing

    const owner = "Azure"
    const repo = "azure-rest-api-specs"
    const issue_number = 35629
    const head_sha = "c12f0191c34212c4e6be88121d132ccb0a7f560c"
    const event_name = "pull_request"
    //     const testParams = {
    //     owner: "scbedd",
    //     repo: "azure-rest-api-specs",
    //     issue_number: 1,
    //     head_sha: "826b0b976479e5c1aa5e66e1cf43a3f9e66a2477",
    //     event_name: "labeled",
    //     github: github,
    //     core: mockCore,
    //     context: {
    //         repo: {
    //             owner: "scbedd",
    //             repo: "azure-rest-api-specs",
    //         },
    //         payload: {
    //             action: LabelAction.Labeled,
    //             label: {
    //             name: "test-label", // Example label, adjust as needed
    //             },
    //         },
    //         eventName: "labeled",
    //     }
    //   };



      // This should not throw and should log information about the PR
      await expect(summarizeChecksImpl({github, context: mockContext, core: mockCore}, owner, repo, issue_number, head_sha, event_name, "main")).resolves.not.toThrow();

      // Note: This test mainly verifies that the API calls work with real data
      // The actual assertions depend on the current state of the specified PR
    }, 600000);

    // it.skipIf(!process.env.GITHUB_TOKEN)("should handle API errors gracefully", async () => {
    //   const github = new Octokit({
    //     auth: process.env.GITHUB_TOKEN,
    //   });

    //   // Use invalid parameters to test error handling
    //   const testParams = {
    //     owner: "Azure",
    //     repo: "azure-rest-api-specs",
    //     issue_number: 999999999, // Non-existent PR
    //     head_sha: "nonexistent-sha",
    //     github: github,
    //     core: mockCore,
    //   };

    //   // Should handle errors gracefully and not crash
    //   await expect(summarizeChecksImpl(testParams)).resolves.not.toThrow();
    // });
  });
});

