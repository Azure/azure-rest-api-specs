import { describe, expect, it } from "vitest";
import { summarizeChecksImpl } from "../src/summarize-checks.js";
import { Octokit } from "@octokit/rest";
import * as core from "@actions/core";

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

      // Use a known PR from the azure-rest-api-specs repo for testing
      const testParams = {
        owner: "Azure",
        repo: "azure-rest-api-specs",
        issue_number: 1,
        head_sha: "main",
        github: github,
        core: mockCore,
      };

      // This should not throw and should log information about the PR
      await expect(summarizeChecksImpl(testParams)).resolves.not.toThrow();

      // Note: This test mainly verifies that the API calls work with real data
      // The actual assertions depend on the current state of the specified PR
    });

    it.skipIf(!process.env.GITHUB_TOKEN)("should handle API errors gracefully", async () => {
      const github = new Octokit({
        auth: process.env.GITHUB_TOKEN,
      });

      // Use invalid parameters to test error handling
      const testParams = {
        owner: "Azure",
        repo: "azure-rest-api-specs",
        issue_number: 999999999, // Non-existent PR
        head_sha: "nonexistent-sha",
        github: github,
        core: mockCore,
      };

      // Should handle errors gracefully and not crash
      await expect(summarizeChecksImpl(testParams)).resolves.not.toThrow();
    });
  });
});

