// @ts-check

import { beforeEach, describe, expect, it, vi } from "vitest";
import { defaultLogger } from "../../shared/src/logger.js";
import { getIssueNumber } from "../src/issues.js";
import { asGitHub, createMockGithub, createMockLogger } from "./mocks.js";

/** @typedef {import('@actions/github-script').AsyncFunctionArguments["github"]} GitHub */

const mockGithub = createMockGithub();

describe("getIssueNumber", () => {
  beforeEach(() => {
    // Reset mocks
    vi.clearAllMocks();
  });
  it("should return NaN when head_sha is missing", async () => {
    // Call function and expect it to throw
    await expect(
      getIssueNumber(asGitHub(mockGithub), ""),
    ).rejects.toThrowErrorMatchingInlineSnapshot(
      `[Error: head_sha is required when trying to search a PR.]`,
    );
  });

  it("should handle multiple PRs for the same commit", async () => {
    const mockLogger = createMockLogger();

    // Mock multiple PRs found
    mockGithub.rest.search.issuesAndPullRequests.mockResolvedValue({
      data: {
        total_count: 2,
        items: [
          { number: 123, html_url: "https://github.com/pr/123" },
          { number: 456, html_url: "https://github.com/pr/456" },
        ],
      },
    });

    // Call function
    const result = await getIssueNumber(asGitHub(mockGithub), "abc123", mockLogger);

    // Verify result uses first PR
    expect(result.issueNumber).toBe(123);

    // Verify warning was logged
    expect(mockLogger.warning).toHaveBeenCalledWith(
      expect.stringContaining("Multiple PRs found for commit"),
    );
  });

  it("should handle no PRs found", async () => {
    // Mock no PRs found
    mockGithub.rest.search.issuesAndPullRequests.mockResolvedValue({
      data: {
        total_count: 0,
        items: [],
      },
    });

    // Call function
    const result = await getIssueNumber(asGitHub(mockGithub), "abc123", defaultLogger);

    // Verify result
    expect(result.issueNumber).toBeNaN();
  });

  it("should handle GitHub search API errors", async () => {
    // Mock GitHub API error
    const searchError = new Error("GitHub API failure");
    mockGithub.rest.search.issuesAndPullRequests.mockRejectedValue(searchError);

    // Call function and expect it to throw
    await expect(getIssueNumber(asGitHub(mockGithub), "abc123", defaultLogger)).rejects.toThrow();
  });
});
