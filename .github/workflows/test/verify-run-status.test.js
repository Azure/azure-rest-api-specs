import { describe, expect, it, vi } from "vitest";
import { createMockGithub, createMockContext, createMockCore } from "./mocks.js";
import { getCheckRuns, getWorkflowRuns, verifyRunStatusImpl } from "../src/verify-run-status.js";

vi.mock("../src/context.js", () => {
  return {
    extractInputs: vi.fn().mockResolvedValue({
      head_sha: "head_sha",
    }),
  };
});

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

    const actual = await await getCheckRuns(
      githubMock,
      createMockContext(),
      "checkRunName",
      "head_sha",
    );

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

describe("verifyRunStatusImpl", () => {
  it("verifies status when check_run event fires", async () => {
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunsForRepo = vi.fn().mockResolvedValue({
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
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunsForRepo = vi.fn().mockResolvedValue({
      data: {
        workflow_runs: [],
      },
    });

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
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunsForRepo = vi.fn().mockResolvedValue({
      data: {
        workflow_runs: [
          {
            name: "workflowName",
            status: "completed",
            conclusion: "failure",
          },
        ],
      },
    });

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
});
