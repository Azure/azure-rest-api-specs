import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.js";

const {
  createReleasePlanWithKnownInputs,
  getNextMonthTarget,
  getApiReleaseType,
  getSdkReleaseType,
} = await import("../src/create-release-plan.js");

describe("createReleasePlanWithKnownInputs", () => {
  /** @type {ReturnType<typeof createMockGithub>} */
  let github;
  /** @type {ReturnType<typeof createMockCore>} */
  let core;
  /** @type {ReturnType<typeof createMockContext>} */
  let context;

  beforeEach(() => {
    github = createMockGithub();
    core = createMockCore();
    context = createMockContext();
    context.payload = {
      pull_request: {
        number: 42,
        html_url: "https://github.com/Azure/azure-rest-api-specs/pull/42",
      },
    };
    github.rest.issues.createComment = vi.fn();
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  it("creates release plan from azsdk create output and comments on PR", async () => {
    const execSyncImpl = vi
      .fn()
      .mockReturnValue(
        JSON.stringify({ release_plan_link: "https://example.test/plan/1", ReleasePlanId: 101 }),
      );

    await createReleasePlanWithKnownInputs({
      github,
      context,
      core,
      prNumber: "42",
      tspProjectPath: "specification/foo/Microsoft.Foo/Service",
      apiVersion: "2025-06-01-preview",
      execSyncImpl,
    });

    expect(execSyncImpl).toHaveBeenCalledWith(
      expect.stringContaining("azsdk release-plan create"),
      expect.objectContaining({ encoding: "utf8" }),
    );
    expect(execSyncImpl).toHaveBeenCalledWith(
      expect.stringContaining("--output json"),
      expect.any(Object),
    );
    expect(github.rest.issues.createComment).toHaveBeenCalledWith(
      expect.objectContaining({
        issue_number: 42,
        body: expect.stringContaining("View Release Plan"),
      }),
    );
  });

  it("does not comment when azsdk create output is invalid JSON", async () => {
    const execSyncImpl = vi.fn().mockReturnValue("not-json");

    await createReleasePlanWithKnownInputs({
      github,
      context,
      core,
      prNumber: "42",
      tspProjectPath: "specification/foo/Microsoft.Foo/Service",
      apiVersion: "2025-06-01",
      execSyncImpl,
    });

    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });
});

describe("getNextMonthTarget", () => {
  it("returns next month in 'Month YYYY' format", () => {
    const result = getNextMonthTarget();
    // Should match "Month YYYY" pattern
    expect(result).toMatch(
      /^(January|February|March|April|May|June|July|August|September|October|November|December) \d{4}$/,
    );
  });

  it("returns a month after current month", () => {
    const result = getNextMonthTarget();
    const now = new Date();
    const expectedMonth = new Date(now.getFullYear(), now.getMonth() + 1, 1);
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    const expected = `${monthNames[expectedMonth.getMonth()]} ${expectedMonth.getFullYear()}`;
    expect(result).toBe(expected);
  });
});

describe("getApiReleaseType", () => {
  it("returns 'Private Preview' for azure-rest-api-specs-pr repo", () => {
    expect(getApiReleaseType(true, "azure-rest-api-specs-pr")).toBe("Private Preview");
    expect(getApiReleaseType(false, "azure-rest-api-specs-pr")).toBe("Private Preview");
  });

  it("returns 'Public Preview' for preview in public repo", () => {
    expect(getApiReleaseType(true, "azure-rest-api-specs")).toBe("Public Preview");
  });

  it("returns 'GA' for non-preview in public repo", () => {
    expect(getApiReleaseType(false, "azure-rest-api-specs")).toBe("GA");
  });
});

describe("getSdkReleaseType", () => {
  it("returns 'preview' for preview versions", () => {
    expect(getSdkReleaseType(true)).toBe("preview");
  });

  it("returns 'stable' for non-preview versions", () => {
    expect(getSdkReleaseType(false)).toBe("stable");
  });
});
