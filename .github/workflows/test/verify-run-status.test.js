import { afterAll, beforeEach, describe, expect, it, vi } from "vitest";
import {
  createMockGithub,
  createMockContext,
  createMockCore,
} from "./mocks.js";
import {
  getCheckRunStatus,
  getWorkflowRun,
  verifyRunStatus,
} from "../src/verify-run-status.js";

vi.mock("../src/context.js", () => {
  return {
    extractInputs: vi.fn().mockResolvedValue({
      head_sha: "head_sha",
    }),
  };
});

describe("getCheckRunStatus", () => {
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

    const actual = await getCheckRunStatus(
      githubMock,
      createMockContext(),
      createMockCore(),
      "checkRunName",
      "head_sha",
    );

    expect(actual).toEqual(
      expect.objectContaining({
        name: "checkRunName",
        status: "completed",
        conclusion: "success",
      }),
    );
  });

  it("returns null when no check matches", async () => {
    const githubMock = createMockGithub();
    githubMock.rest.checks.listForRef = vi.fn().mockResolvedValue({
      data: {
        check_runs: [],
      },
    });

    const actual = await getCheckRunStatus(
      githubMock,
      createMockContext(),
      createMockCore(),
      "checkRunName",
      "head_sha",
    );

    expect(actual).toBeNull();
  });

  it("throws when multiple checks match", async () => {
    const githubMock = createMockGithub();
    githubMock.rest.checks.listForRef = vi.fn().mockResolvedValue({
      data: {
        check_runs: [
          {
            name: "checkRunName",
            status: "completed",
            conclusion: "success",
          },
          {
            name: "checkRunName",
            status: "completed",
            conclusion: "success",
          },
        ],
      },
    });

    await expect(
      async () =>
        await getCheckRunStatus(
          githubMock,
          createMockContext(),
          createMockCore(),
          "checkRunName",
          "head_sha",
        ),
    ).rejects.toThrow(/Multiple completed check runs with name/);
  });
});

describe("getWorkflowRun", () => {
  it("returns matching workflow_run", async () => {
    const githubMock = createMockGithub();
    githubMock.rest.actions.listWorkflowRunsForRepo = vi
      .fn()
      .mockResolvedValue({
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

    const actual = await getWorkflowRun(
      githubMock,
      createMockContext(),
      createMockCore(),
      "workflowName",
      "head_sha",
    );

    expect(actual).toEqual(
      expect.objectContaining({
        name: "workflowName",
        status: "completed",
        conclusion: "success",
      }),
    );
  });

  it("returns null when no workflow matches", async () => {
    const githubMock = createMockGithub();
    githubMock.rest.actions.listWorkflowRunsForRepo = vi
      .fn()
      .mockResolvedValue({
        data: {
          workflow_runs: [
            {
              name: "otherWorkflowName",
            },
          ],
        },
      });

    const actual = await getWorkflowRun(
      githubMock,
      createMockContext(),
      createMockCore(),
      "workflowName",
      "head_sha",
    );

    expect(actual).toBeNull();
  });

  it("returns latest when multiple workflows match", async () => {
    const githubMock = createMockGithub();
    const earlyDate = "2025-04-01T00:00:00Z";
    const laterDate = "2025-04-02T00:00:00Z";
    githubMock.rest.actions.listWorkflowRunsForRepo = vi
      .fn()
      .mockResolvedValue({
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

    const actual = await getWorkflowRun(
      githubMock,
      createMockContext(),
      createMockCore(),
      "workflowName",
      "head_sha",
    );

    expect(actual).toEqual(
      expect.objectContaining({
        name: "workflowName",
        status: "completed",
        conclusion: "success",
        updated_at: laterDate,
      }),
    );
  });
});

describe("verifyRunStatus", () => {
  beforeEach(() => {
    delete process.env.CHECK_RUN_NAME;
    delete process.env.WORKFLOW_NAME;
  });

  afterAll(() => {
    delete process.env.CHECK_RUN_NAME;
    delete process.env.WORKFLOW_NAME;
  });

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

    process.env.CHECK_RUN_NAME = "checkRunName";
    process.env.WORKFLOW_NAME = "workflowName";
    await verifyRunStatus({ github, context, core });

    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith("Checks match");
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

    process.env.CHECK_RUN_NAME = "checkRunName";
    process.env.WORKFLOW_NAME = "workflowName";
    await verifyRunStatus({ github, context, core });

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
    process.env.CHECK_RUN_NAME = "checkRunName";
    process.env.WORKFLOW_NAME = "workflowName";
    await verifyRunStatus({ github, context, core });
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith(
      "No completed check run with name: checkRunName",
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
    process.env.CHECK_RUN_NAME = "checkRunName";
    process.env.WORKFLOW_NAME = "workflowName";
    await verifyRunStatus({ github, context, core });
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith(
      "No completed workflow run with name: workflowName",
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
    process.env.CHECK_RUN_NAME = "otherCheckRunName";
    process.env.WORKFLOW_NAME = "workflowName";
    await verifyRunStatus({ github, context, core });
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith(
      "Check run name (checkRunName) does not match input: otherCheckRunName",
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
    process.env.CHECK_RUN_NAME = "checkRunName";
    process.env.WORKFLOW_NAME = "workflowName";
    await verifyRunStatus({ github, context, core });
    expect(core.setFailed).toHaveBeenCalledWith(
      "Check run conclusion (success) does not match workflow run conclusion (failure)",
    );
  });

  it("throws if CHECK_RUN_NAME is not set", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    process.env.WORKFLOW_NAME = "workflowName";
    await expect(
      async () => await verifyRunStatus({ github, context, core }),
    ).rejects.toThrow();
  });

  it("throws if WORKFLOW_NAME is not set", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    process.env.CHECK_RUN_NAME = "checkRunName";
    await expect(
      async () => await verifyRunStatus({ github, context, core }),
    ).rejects.toThrow();
  });
});
