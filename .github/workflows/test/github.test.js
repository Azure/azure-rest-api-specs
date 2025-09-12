import { afterEach } from "node:test";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { add, Duration } from "../../shared/src/time.js";
import {
  createLogHook,
  createRateLimitHook,
  getCheckRuns,
  getWorkflowRuns,
  writeToActionsSummary,
} from "../src/github.js";
import { createMockContext, createMockCore, createMockGithub, createMockLogger } from "./mocks.js";

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

describe("createLogHook", () => {
  it("logs request info with body", () => {
    const mockLogger = createMockLogger();
    const logHook = createLogHook((r) => r, mockLogger);

    expect(
      logHook({
        method: "GET",
        url: "https://test-url.com",
        body: { "test-key": "test-value" },
      }),
    ).toBeUndefined();

    expect(mockLogger.info).toBeCalledTimes(1);
    expect(mockLogger.info.mock.calls[0]).toMatchInlineSnapshot(`
      [
        "[github] GET https://test-url.com {"test-key":"test-value"}",
      ]
    `);
  });

  it("logs request info without body", () => {
    const mockLogger = createMockLogger();
    const logHook = createLogHook((r) => r, mockLogger);

    expect(
      logHook({
        method: "GET",
        url: "https://test-url.com",
      }),
    ).toBeUndefined();

    expect(mockLogger.info).toBeCalledTimes(1);
    expect(mockLogger.info.mock.calls[0]).toMatchInlineSnapshot(`
      [
        "[github] GET https://test-url.com ",
      ]
    `);
  });
});

describe("createRateLimitHook", () => {
  beforeEach(() => {
    vi.useFakeTimers();
    vi.setSystemTime(new Date("2025-01-01T00:00:00Z"));
  });

  afterEach(() => {
    vi.useRealTimers();
  });

  it("logs to debug if missing rate limit header", () => {
    const mockLogger = createMockLogger();
    const ratelimitHook = createRateLimitHook(mockLogger);

    expect(ratelimitHook({ headers: {} })).toBeUndefined();

    expect(mockLogger.info).toBeCalledTimes(0);
    expect(mockLogger.debug).toBeCalledTimes(1);
    expect(mockLogger.debug.mock.calls[0]).toMatchInlineSnapshot(`
      [
        "[github] missing ratelimit header(s) in response",
      ]
    `);
  });

  it("logs to info if all rate limit headers", () => {
    const mockLogger = createMockLogger();
    const ratelimitHook = createRateLimitHook(mockLogger);

    const reset = (add(new Date(), 30 * Duration.Minute).getTime() / Duration.Second).toFixed(0);

    expect(
      ratelimitHook({
        headers: {
          "x-ratelimit-limit": "100",
          "x-ratelimit-remaining": "50",
          "x-ratelimit-reset": reset,
        },
      }),
    ).toBeUndefined();
    expect(mockLogger.info).toBeCalledTimes(1);
    expect(mockLogger.info.mock.calls[0]).toMatchInlineSnapshot(`
      [
        "[github] load: 100%, used: 50, remaining: 50, reset: 00:30:00",
      ]
    `);

    expect(
      ratelimitHook({
        headers: {
          "x-ratelimit-limit": "100",
          "x-ratelimit-remaining": "75",
          "x-ratelimit-reset": reset,
        },
      }),
    ).toBeUndefined();
    expect(mockLogger.info).toBeCalledTimes(2);
    expect(mockLogger.info.mock.calls[1]).toMatchInlineSnapshot(`
      [
        "[github] load: 50%, used: 25, remaining: 75, reset: 00:30:00",
      ]
    `);

    expect(
      ratelimitHook({
        headers: {
          "x-ratelimit-limit": "100",
          "x-ratelimit-remaining": "25",
          "x-ratelimit-reset": reset,
        },
      }),
    ).toBeUndefined();
    expect(mockLogger.info).toBeCalledTimes(3);
    expect(mockLogger.info.mock.calls[2]).toMatchInlineSnapshot(`
      [
        "[github] load: 150%, used: 75, remaining: 25, reset: 00:30:00",
      ]
    `);

    expect(
      ratelimitHook({
        headers: {
          "x-ratelimit-limit": "100",
          "x-ratelimit-remaining": "0",
          "x-ratelimit-reset": reset,
        },
      }),
    ).toBeUndefined();
    expect(mockLogger.info).toBeCalledTimes(4);
    expect(mockLogger.info.mock.calls[3]).toMatchInlineSnapshot(`
      [
        "[github] load: 200%, used: 100, remaining: 0, reset: 00:30:00",
      ]
    `);
  });
});
