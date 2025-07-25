import { describe, expect, it, vi } from "vitest";
import { getCheckRuns, getWorkflowRuns, writeToActionsSummary } from "../src/github.js";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.js";

const mockCore = createMockCore();

describe("getCheckRuns", () => {
  it("returns matching check_run", async () => {
    const githubMock = createMockGithub();
    githubMock.rest.checks.listForRef = vi.fn().mockResolvedValue({
      data: {
        check_runs: [
          {
            name: "checkRunName",
            status: "completed",
            conclusion: "success",
          },
        ],
      },
    });

    const actual = await getCheckRuns(
      githubMock,
      createMockContext(),
      createMockCore(),
      "checkRunName",
      "head_sha",
    );

    expect(actual).toEqual([
      expect.objectContaining({
        name: "checkRunName",
        status: "completed",
        conclusion: "success",
      }),
    ]);
  });

  it("returns null when no check matches", async () => {
    const githubMock = createMockGithub();
    githubMock.rest.checks.listForRef = vi.fn().mockResolvedValue({
      data: {
        check_runs: [],
      },
    });

    const actual = await getCheckRuns(githubMock, createMockContext(), "checkRunName", "head_sha");

    expect(actual).toEqual([]);
  });

  it("throws when multiple checks match", async () => {
    const githubMock = createMockGithub();
    const earlierDate = "2025-04-01T00:00:00Z";
    const laterDate = "2025-04-02T00:00:00Z";
    githubMock.rest.checks.listForRef = vi.fn().mockResolvedValue({
      data: {
        check_runs: [
          {
            name: "checkRunName",
            status: "completed",
            conclusion: "success",
            completed_at: earlierDate,
          },
          {
            name: "checkRunName",
            status: "completed",
            conclusion: "success",
            completed_at: laterDate,
          },
        ],
      },
    });

    const actual = await getCheckRuns(githubMock, createMockContext(), "checkRunName", "head_sha");

    expect(actual).toEqual([
      expect.objectContaining({
        name: "checkRunName",
        status: "completed",
        conclusion: "success",
        completed_at: laterDate,
      }),
      expect.objectContaining({
        name: "checkRunName",
        status: "completed",
        conclusion: "success",
        completed_at: earlierDate,
      }),
    ]);
  });
});

describe("getWorkflowRuns", () => {
  it("returns matching workflow_run", async () => {
    const githubMock = createMockGithub();
    githubMock.rest.actions.listWorkflowRunsForRepo = vi.fn().mockResolvedValue({
      data: {
        workflow_runs: [
          {
            name: "workflowName",
            status: "completed",
            conclusion: "success",
          },
        ],
      },
    });

    const actual = await getWorkflowRuns(
      githubMock,
      createMockContext(),
      "workflowName",
      "head_sha",
    );

    expect(actual).toEqual([
      expect.objectContaining({
        name: "workflowName",
        status: "completed",
        conclusion: "success",
      }),
    ]);
  });

  it("returns null when no workflow matches", async () => {
    const githubMock = createMockGithub();
    githubMock.rest.actions.listWorkflowRunsForRepo = vi.fn().mockResolvedValue({
      data: {
        workflow_runs: [
          {
            name: "otherWorkflowName",
          },
        ],
      },
    });

    const actual = await getWorkflowRuns(
      githubMock,
      createMockContext(),
      "workflowName",
      "head_sha",
    );

    expect(actual).toEqual([]);
  });

  it("returns latest when multiple workflows match", async () => {
    const githubMock = createMockGithub();
    const earlyDate = "2025-04-01T00:00:00Z";
    const laterDate = "2025-04-02T00:00:00Z";
    githubMock.rest.actions.listWorkflowRunsForRepo = vi.fn().mockResolvedValue({
      data: {
        workflow_runs: [
          {
            name: "workflowName",
            status: "completed",
            conclusion: "success",
            updated_at: earlyDate,
          },
          {
            name: "workflowName",
            status: "completed",
            conclusion: "success",
            updated_at: laterDate,
          },
        ],
      },
    });

    const actual = await getWorkflowRuns(
      githubMock,
      createMockContext(),
      "workflowName",
      "head_sha",
    );

    expect(actual).toEqual([
      expect.objectContaining({
        updated_at: laterDate,
      }),
      expect.objectContaining({
        updated_at: earlyDate,
      }),
    ]);
  });
});

describe("writeToActionsSummary function", () => {
  it("should add content to the summary and write it", async () => {
    // Call function
    const result = await writeToActionsSummary("Test content", mockCore);

    // Verify result
    expect(result).toBeUndefined();

    // Verify summary methods were called
    expect(mockCore.summary.addRaw).toHaveBeenCalledWith("Test content");
    expect(mockCore.summary.write).toHaveBeenCalled();
  });

  it("should handle exception", async () => {
    // Create a mock with a write method that throws an error
    const mockCoreWithError = createMockCore();
    mockCoreWithError.summary.write.mockRejectedValue(new Error("Mock write error"));

    // Call function and validate it throws
    await expect(writeToActionsSummary("Test content", mockCoreWithError)).rejects.toThrow(
      "Failed to write to the GitHub Actions summary",
    );
  });
});
