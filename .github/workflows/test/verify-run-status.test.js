import { describe, expect, it, vi } from "vitest";
import {
  createMockGithub,
  createMockContext,
  createMockCore,
} from "./mocks.js";
import { getCheckRunStatus, getWorkflowRun, verifyRunStatus } from "../src/verify-run-status.js";

vi.mock("../src/context.js", () => {
  return {
    extractInputs: vi.fn().mockResolvedValue({
      head_sha: "head_sha",
    }),
  };
});

describe("getCheckRunStatus", () => {
  it("returns matching check_run", async ()=> { 
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
      "head_sha"
    );

    expect(actual).toEqual(expect.objectContaining({
      name: "checkRunName",
      status: "completed",
      conclusion: "success",
    }));
  });

  it("returns null when no check matches", async ()=> {
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
      "head_sha"
    );

    expect(actual).toBeNull();
  });

  it("throws when multiple checks match", async ()=> {
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

    await expect(async () => await getCheckRunStatus(
      githubMock,
      createMockContext(), 
      createMockCore(),
      "checkRunName",
      "head_sha"
    )).rejects.toThrow(/Multiple completed check runs with name/);
  });
});

describe("getWorkflowRun", () => {
  it("returns matching workflow_run", async ()=> {
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

    const actual = await getWorkflowRun(
      githubMock,
      createMockContext(), 
      createMockCore(),
      "workflowName",
      "head_sha"
    );

    expect(actual).toEqual(expect.objectContaining({
      name: "workflowName",
      status: "completed",
      conclusion: "success",
    }));
  });

  it("returns null when no workflow matches", async ()=> {
    const githubMock = createMockGithub();
    githubMock.rest.actions.listWorkflowRunsForRepo = vi.fn().mockResolvedValue({
      data: {
        workflow_runs: [
          {
            name: "otherWorkflowName"
          }
        ],
      },
    });

    const actual = await getWorkflowRun(
      githubMock,
      createMockContext(), 
      createMockCore(),
      "workflowName",
      "head_sha"
    );

    expect(actual).toBeNull();
  });

  it("throws when multiple workflows match", async ()=> {
    const githubMock = createMockGithub();
    githubMock.rest.actions.listWorkflowRunsForRepo = vi.fn().mockResolvedValue({
      data: {
        workflow_runs: [
          {
            name: "workflowName",
            status: "completed",
            conclusion: "success",
          },
          {
            name: "workflowName",
            status: "completed",
            conclusion: "success",
          },
        ],
      },
    });

    await expect(async () => await getWorkflowRun(
      githubMock,
      createMockContext(), 
      createMockCore(),
      "workflowName",
      "head_sha"
    )).rejects.toThrow(/Multiple completed workflow runs with name/);
  });
});

describe("verifyRunStatus", () => {
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
      }
    };

    const core = createMockCore();

    await verifyRunStatus(
      { github, context, core },
      "checkRunName",
      "workflowName"
    );

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
        }
      },
    };

    const core = createMockCore();

    await verifyRunStatus(
      { github, context, core },
      "checkRunName",
      "workflowName"
    );

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
        }
      },
    };
    const core = createMockCore();
    await verifyRunStatus(
      { github, context, core },
      "checkRunName",
      "workflowName"
    );
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith("No completed check run with name: checkRunName");
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
      }
    };
    const core = createMockCore();
    await verifyRunStatus(
      { github, context, core },
      "checkRunName",
      "workflowName"
    );
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith("No completed workflow run with name: workflowName");
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
      }
    };
    const core = createMockCore();
    await verifyRunStatus(
      { github, context, core },
      "checkRunName",
      "workflowName"
    );
    expect(core.setFailed).toHaveBeenCalledWith(
      "Check run conclusion (success) does not match workflow run conclusion (failure)"
    );
  });

});