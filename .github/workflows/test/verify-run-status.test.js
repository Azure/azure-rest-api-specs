import { describe, expect, it, vi, beforeEach } from "vitest";
import { verifyRunStatusImpl } from "../src/verify-run-status.js";
import { createMockCore, createMockGithub } from "./mocks.js";

vi.mock("../src/context.js", () => {
  return {
    extractInputs: vi.fn().mockResolvedValue({
      head_sha: "head_sha",
    }),
  };
});

vi.mock("../src/github.js", () => {
  return {
    getCheckRuns: vi.fn().mockResolvedValue([]),
    getWorkflowRuns: vi.fn().mockResolvedValue([]),
    getCommitStatuses: vi.fn().mockResolvedValue([]),
  };
});

describe("verifyRunStatusImpl", () => {
  // Reset mock call history before each test
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("verifies status when check_run event fires", async () => {
    const github = createMockGithub();
    const { getWorkflowRuns } = await import("../src/github.js");
    getWorkflowRuns.mockResolvedValue([
      {
        name: "workflowName",
        status: "completed",
        conclusion: "success",
      },
    ]);
    const context = {
      eventName: "check_run",
      payload: {
        check_run: {
          name: "checkRunName",
          conclusion: "success",
        },
      },
    };

    const core = createMockCore();

    vi.stubEnv("CHECK_RUN_NAME", "checkRunName");
    vi.stubEnv("WORKFLOW_NAME", "workflowName");
    await verifyRunStatusImpl({
      github,
      context,
      core,
      checkRunName: "checkRunName",
      workflowName: "workflowName",
    });

    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.notice).toHaveBeenCalledWith(
      "Conclusions match for check run checkRunName and workflow run workflowName",
    );
  });

  it("verifies status when workflow_run event fires", async () => {
    const github = createMockGithub();
    github.rest.checks.listForRef = vi.fn().mockResolvedValue({
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

    const context = {
      eventName: "workflow_run",
      payload: {
        workflow_run: {
          name: "workflowName",
          conclusion: "success",
        },
      },
    };

    const core = createMockCore();

    vi.stubEnv("CHECK_RUN_NAME", "checkRunName");
    vi.stubEnv("WORKFLOW_NAME", "workflowName");
    await verifyRunStatusImpl({
      github,
      context,
      core,
      checkRunName: "checkRunName",
      workflowName: "workflowName",
    });

    expect(core.setFailed).not.toHaveBeenCalled();
  });

  it("returns early during workflow_run event when no matching check_run is found", async () => {
    const github = createMockGithub();
    github.rest.checks.listForRef = vi.fn().mockResolvedValue({
      data: {
        check_runs: [],
      },
    });

    const context = {
      eventName: "workflow_run",
      payload: {
        workflow_run: {
          name: "workflowName",
          conclusion: "success",
        },
      },
    };
    const core = createMockCore();
    await verifyRunStatusImpl({
      github,
      context,
      core,
      checkRunName: "checkRunName",
      workflowName: "workflowName",
    });
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.notice).toHaveBeenCalledWith(
      "No completed check run with name: checkRunName. Not enough information to judge success or failure. Ending with success status.",
    );
  });

  it("returns early during check_run event when no matching workflow_run is found", async () => {
    const { getWorkflowRuns } = await import("../src/github.js");
    getWorkflowRuns.mockResolvedValue([]);

    const context = {
      eventName: "check_run",
      payload: {
        check_run: {
          name: "checkRunName",
          conclusion: "success",
        },
      },
    };
    const core = createMockCore();
    await verifyRunStatusImpl({
      github: createMockGithub(),
      context,
      core,
      checkRunName: "checkRunName",
      workflowName: "workflowName",
    });
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.notice).toHaveBeenCalledWith(
      "No completed workflow run with name: workflowName. Not enough information to judge success or failure. Ending with success status.",
    );
  });

  it("returns early if event is check_run but does not match input name", async () => {
    const github = createMockGithub();
    const context = {
      eventName: "check_run",
      payload: {
        check_run: {
          name: "checkRunName",
          conclusion: "success",
        },
      },
    };
    const core = createMockCore();
    await verifyRunStatusImpl({
      github,
      context,
      core,
      checkRunName: "otherCheckRunName",
      workflowName: "workflowName",
    });
    expect(core.setFailed).toHaveBeenCalledWith(
      "Check run name (checkRunName) does not match input: otherCheckRunName. Ensure job is filtering by github.event.check_run.name.",
    );
  });

  it("throws if check_run conclusion does not match workflow_run conclusion", async () => {
    const { getWorkflowRuns } = await import("../src/github.js");
    getWorkflowRuns.mockResolvedValue([
      {
        name: "workflowName",
        status: "completed",
        conclusion: "failure",
      },
    ]);

    const context = {
      eventName: "check_run",
      payload: {
        check_run: {
          name: "checkRunName",
          conclusion: "success",
        },
      },
    };
    const core = createMockCore();
    await verifyRunStatusImpl({
      github: createMockGithub(),
      context,
      core,
      checkRunName: "checkRunName",
      workflowName: "workflowName",
    });
    expect(core.setFailed).toHaveBeenCalledWith(
      "Check run conclusion (success) does not match workflow run conclusion (failure)",
    );
  });

  it("throws when in check_suite event but no check_run with name is found", async () => {
    const github = createMockGithub();
    github.rest.checks.listForRef = vi.fn().mockResolvedValue({
      data: {
        check_runs: [],
      },
    });

    const context = {
      eventName: "check_suite",
      payload: {
        check_suite: {
          app: {
            name: "checkRunName",
          },
        },
      },
    };
    const core = createMockCore();
    await verifyRunStatusImpl({
      github,
      context,
      core,
      checkRunName: "checkRunName",
      workflowName: "workflowName",
    });
    expect(core.setFailed).toHaveBeenCalledWith(
      "Could not locate check run checkRunName in check suite checkRunName. Ensure job is filtering by github.event.check_suite.app.name.",
    );
  });

  // Tests for commit status comparison functionality
  it("verifies status when status event fires with matching commit status", async () => {
    const { getCheckRuns } = await import("../src/github.js");
    getCheckRuns.mockResolvedValue([
      {
        name: "checkRunName",
        conclusion: "success",
        html_url: "https://example.com/check",
      },
    ]);

    const context = {
      eventName: "status",
      payload: {
        context: "commitStatusName",
        state: "success",
        target_url: "https://example.com/status",
      },
    };

    const core = createMockCore();

    await verifyRunStatusImpl({
      github: createMockGithub(),
      context,
      core,
      checkRunName: "checkRunName",
      commitStatusName: "commitStatusName",
    });

    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.notice).toHaveBeenCalledWith(
      "Conclusions match for check run checkRunName and commit status commitStatusName",
    );
  });

  it("verifies status when neutral check run matches success commit status", async () => {
    const { getCheckRuns } = await import("../src/github.js");
    getCheckRuns.mockResolvedValue([
      {
        name: "checkRunName",
        conclusion: "neutral",
        html_url: "https://example.com/check",
      },
    ]);

    const context = {
      eventName: "status",
      payload: {
        context: "commitStatusName",
        state: "success",
        target_url: "https://example.com/status",
      },
    };

    const core = createMockCore();

    await verifyRunStatusImpl({
      github: createMockGithub(),
      context,
      core,
      checkRunName: "checkRunName",
      commitStatusName: "commitStatusName",
    });

    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.notice).toHaveBeenCalledWith(
      "Conclusions match for check run checkRunName and commit status commitStatusName",
    );
  });

  it("fails when check run conclusion does not match commit status state", async () => {
    const { getCheckRuns } = await import("../src/github.js");
    getCheckRuns.mockResolvedValue([
      {
        name: "checkRunName",
        conclusion: "success",
        html_url: "https://example.com/check",
      },
    ]);

    const context = {
      eventName: "status",
      payload: {
        context: "commitStatusName",
        state: "failure",
        target_url: "https://example.com/status",
      },
    };

    const core = createMockCore();

    await verifyRunStatusImpl({
      github: createMockGithub(),
      context,
      core,
      checkRunName: "checkRunName",
      commitStatusName: "commitStatusName",
    });

    expect(core.setFailed).toHaveBeenCalledWith(
      "Check run conclusion (success) does not match commit status state (failure)",
    );
  });

  it("skips comparison when commit status is pending", async () => {
    const { getCheckRuns } = await import("../src/github.js");
    getCheckRuns.mockResolvedValue([
      {
        name: "checkRunName",
        conclusion: "success",
        html_url: "https://example.com/check",
      },
    ]);

    const context = {
      eventName: "status",
      payload: {
        context: "commitStatusName",
        state: "pending",
        target_url: "https://example.com/status",
      },
    };

    const core = createMockCore();

    await verifyRunStatusImpl({
      github: createMockGithub(),
      context,
      core,
      checkRunName: "checkRunName",
      commitStatusName: "commitStatusName",
    });

    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.notice).toHaveBeenCalledWith(
      "Commit status is in pending state. Skipping comparison with check run conclusion.",
    );
  });

  it("fetches commit status from API when not status event", async () => {
    const { getCheckRuns, getCommitStatuses } = await import("../src/github.js");
    getCheckRuns.mockResolvedValue([
      {
        name: "checkRunName",
        conclusion: "success",
        html_url: "https://example.com/check",
      },
    ]);
    getCommitStatuses.mockResolvedValue([
      {
        context: "commitStatusName",
        state: "success",
        target_url: "https://example.com/status",
      },
    ]);

    const context = {
      eventName: "workflow_run",
      payload: {
        workflow_run: {
          name: "workflowName",
          conclusion: "success",
        },
      },
    };

    const core = createMockCore();

    await verifyRunStatusImpl({
      github: createMockGithub(),
      context,
      core,
      checkRunName: "checkRunName",
      commitStatusName: "commitStatusName",
      workflowName: "workflowName",
    });

    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.notice).toHaveBeenCalledWith(
      "Conclusions match for check run checkRunName and commit status commitStatusName",
    );
  });

  it("handles API error when fetching commit status", async () => {
    const { getCheckRuns, getCommitStatuses } = await import("../src/github.js");
    getCheckRuns.mockResolvedValue([
      {
        name: "checkRunName",
        conclusion: "success",
        html_url: "https://example.com/check",
      },
    ]);
    getCommitStatuses.mockRejectedValue(new Error("API Error"));

    const context = {
      eventName: "workflow_run",
      payload: {
        workflow_run: {
          name: "workflowName",
          conclusion: "success",
        },
      },
    };

    const core = createMockCore();

    await verifyRunStatusImpl({
      github: createMockGithub(),
      context,
      core,
      checkRunName: "checkRunName",
      commitStatusName: "commitStatusName",
      workflowName: "workflowName",
    });

    expect(core.setFailed).toHaveBeenCalledWith("Failed to fetch commit status: API Error");
  });

  it("verifies neutral check run matches success workflow run", async () => {
    const { getCheckRuns } = await import("../src/github.js");
    getCheckRuns.mockResolvedValue([
      {
        name: "checkRunName",
        conclusion: "neutral",
        html_url: "https://example.com/check",
      },
    ]);

    const context = {
      eventName: "workflow_run",
      payload: {
        workflow_run: {
          name: "workflowName",
          conclusion: "success",
        },
      },
    };

    const core = createMockCore();

    await verifyRunStatusImpl({
      github: createMockGithub(),
      context,
      core,
      checkRunName: "checkRunName",
      workflowName: "workflowName",
    });

    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.notice).toHaveBeenCalledWith(
      "Conclusions match for check run checkRunName and workflow run workflowName",
    );
  });
});
