import { describe, expect, it, vi } from "vitest";
import { createMockCore } from "../../test/mocks.js";
import updateLabels, { updateLabelsImpl } from "../src/update-labels.js";

describe("updateLabels", () => {
  it("loads inputs from env", async () => {
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [{ name: "label-foo=true" }],
      },
    });

    try {
      process.env.OWNER = "TestRepoOwnerLoginEnv";
      process.env.REPO = "TestRepoNameEnv";
      process.env.ISSUE_NUMBER = "123";
      process.env.RUN_ID = "456";

      await expect(
        updateLabels({
          github: github,
          context: null,
          core: createMockCore(),
        }),
      ).resolves.toBeUndefined();
    } finally {
      delete process.env.OWNER;
      delete process.env.REPO;
      delete process.env.ISSUE_NUMBER;
      delete process.env.RUN_ID;
    }

    expect(github.rest.actions.listWorkflowRunArtifacts).toBeCalledWith({
      owner: "TestRepoOwnerLoginEnv",
      repo: "TestRepoNameEnv",
      run_id: 456,
    });
    expect(github.rest.issues.addLabels).toBeCalledWith({
      owner: "TestRepoOwnerLoginEnv",
      repo: "TestRepoNameEnv",
      issue_number: 123,
      labels: ["foo"],
    });
    expect(github.rest.issues.removeLabel).toBeCalledTimes(0);
  });

  it("loads inputs from context", async () => {
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [{ name: "label-foo=true" }],
      },
    });

    const context = {
      eventName: "workflow_run",
      payload: {
        action: "completed",
        workflow_run: {
          head_sha: "abc123",
          id: 456,
          repository: {
            name: "TestRepoName",
            owner: {
              login: "TestRepoOwnerLogin",
            },
          },
          pull_requests: [{ number: 123 }],
        },
      },
    };

    await expect(
      updateLabels({
        github: github,
        context: context,
        core: createMockCore(),
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.actions.listWorkflowRunArtifacts).toBeCalledWith({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      run_id: 456,
    });
    expect(github.rest.issues.addLabels).toBeCalledWith({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      issue_number: 123,
      labels: ["foo"],
    });
    expect(github.rest.issues.removeLabel).toBeCalledTimes(0);
  });

  it("loads inputs from env and context", async () => {
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [{ name: "label-foo=true" }],
      },
    });

    const context = {
      eventName: "workflow_run",
      payload: {
        action: "completed",
        workflow_run: {
          head_sha: "abc123",
          id: 456,
          repository: {
            name: "TestRepoName",
            owner: {
              login: "TestRepoOwnerLogin",
            },
          },
          pull_requests: [{ number: 123 }],
        },
      },
    };

    try {
      process.env.OWNER = "TestRepoOwnerLoginEnv";
      process.env.REPO = "TestRepoNameEnv";

      await expect(
        updateLabels({
          github: github,
          context: context,
          core: createMockCore(),
        }),
      ).resolves.toBeUndefined();
    } finally {
      delete process.env.OWNER;
      delete process.env.REPO;
    }

    expect(github.rest.actions.listWorkflowRunArtifacts).toBeCalledWith({
      owner: "TestRepoOwnerLoginEnv",
      repo: "TestRepoNameEnv",
      run_id: 456,
    });
    expect(github.rest.issues.addLabels).toBeCalledWith({
      owner: "TestRepoOwnerLoginEnv",
      repo: "TestRepoNameEnv",
      issue_number: 123,
      labels: ["foo"],
    });
    expect(github.rest.issues.removeLabel).toBeCalledTimes(0);
  });
});

describe("updateLabelsImpl", () => {
  it("throws if no run_id", async () => {
    const github = createMockGithub();

    await expect(
      updateLabelsImpl({
        owner: "owner",
        repo: "repo",
        issue_number: 123,
        run_id: NaN,
        github: github,
        core: createMockCore(),
      }),
    ).rejects.toThrow();

    expect(github.rest.issues.addLabels).toBeCalledTimes(0);
    expect(github.rest.issues.removeLabel).toBeCalledTimes(0);
  });

  it("adds and removes labels for artifacts", async () => {
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [
          { name: "label-foo=true" },
          { name: "label-bar=true" },
          { name: "label-baz=false" },
          { name: "label-qux=false" },
          { name: "ignoredNoEquals" },
          { name: "=ignoredNoKey" },
          { name: "label=ignoredKeyNotStartsWithLabelDash" },
        ],
      },
    });

    await expect(
      updateLabelsImpl({
        owner: "owner",
        repo: "repo",
        issue_number: 123,
        run_id: 456,
        github: github,
        core: createMockCore(),
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.actions.listWorkflowRunArtifacts).toBeCalledWith({
      owner: "owner",
      repo: "repo",
      run_id: 456,
    });
    expect(github.rest.issues.addLabels).toBeCalledWith({
      owner: "owner",
      repo: "repo",
      issue_number: 123,
      labels: ["foo", "bar"],
    });
    expect(github.rest.issues.removeLabel).toBeCalledTimes(2);
    expect(github.rest.issues.removeLabel).nthCalledWith(1, {
      owner: "owner",
      repo: "repo",
      issue_number: 123,
      name: "baz",
    });
    expect(github.rest.issues.removeLabel).nthCalledWith(2, {
      owner: "owner",
      repo: "repo",
      issue_number: 123,
      name: "qux",
    });
  });

  it("throws for invalid label value", async () => {
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [
          { name: "label-foo=true" },
          { name: "label-bar=false" },
          { name: "label-baz=invalid" },
        ],
      },
    });

    await expect(
      updateLabelsImpl({
        owner: "owner",
        repo: "repo",
        issue_number: 123,
        run_id: 456,
        github: github,
        core: createMockCore(),
      }),
    ).rejects.toThrow();

    expect(github.rest.actions.listWorkflowRunArtifacts).toBeCalledWith({
      owner: "owner",
      repo: "repo",
      run_id: 456,
    });

    // Ensure no labels are added or removed if any are invalid
    expect(github.rest.issues.addLabels).toBeCalledTimes(0);
    expect(github.rest.issues.removeLabel).toBeCalledTimes(0);
  });

  it.each([404, 500, 501])(
    "handles error removing label (%s)",
    async (status) => {
      const github = createMockGithub();
      github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
        data: {
          artifacts: [{ name: "label-foo=false" }],
        },
      });
      github.rest.issues.removeLabel.mockRejectedValue({ status: status });

      const updateLabelsImplPromise = updateLabelsImpl({
        owner: "owner",
        repo: "repo",
        issue_number: 123,
        run_id: 456,
        github: github,
        core: createMockCore(),
      });

      if (status == 404) {
        await expect(updateLabelsImplPromise).resolves.toBeUndefined();
      } else {
        await expect(updateLabelsImplPromise).rejects.toThrow();
      }

      expect(github.rest.actions.listWorkflowRunArtifacts).toBeCalledWith({
        owner: "owner",
        repo: "repo",
        run_id: 456,
      });
      expect(github.rest.issues.addLabels).toBeCalledTimes(0);
      expect(github.rest.issues.removeLabel).toBeCalledWith({
        owner: "owner",
        repo: "repo",
        issue_number: 123,
        name: "foo",
      });
    },
  );
});

function createMockGithub() {
  return {
    rest: {
      actions: {
        listWorkflowRunArtifacts: vi
          .fn()
          .mockResolvedValue({ data: { artifacts: [] } }),
      },
      issues: {
        addLabels: vi.fn(),
        removeLabel: vi.fn(),
      },
    },
  };
}
