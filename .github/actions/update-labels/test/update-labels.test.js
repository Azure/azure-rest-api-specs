import { describe, expect, it, vi } from "vitest";
import { createMockCore } from "../../../test/mocks.js";
import updateLabels, { updateLabelsImpl } from "../src/update-labels.js";

describe("updateLabels", () => {
  it("loads inputs from env", async () => {
    try {
      process.env.OWNER = "TestRepoOwnerLoginEnv";
      process.env.REPO = "TestRepoNameEnv";
      process.env.RUN_ID = "123";

      const github = createMockGithub();

      await expect(
        updateLabels({
          github: github,
          context: null,
          core: createMockCore(),
        }),
      ).resolves.toBeUndefined();

      expect(github.rest.issues.addLabels).toBeCalledTimes(0);
      expect(github.rest.issues.removeLabel).toBeCalledTimes(0);
    } finally {
      delete process.env.OWNER;
      delete process.env.REPO;
      delete process.env.RUN_ID;
    }
  });

  it("loads inputs from context (workflow_run:completed)", async () => {
    const github = createMockGithub();

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

    expect(github.rest.issues.addLabels).toBeCalledTimes(0);
    expect(github.rest.issues.removeLabel).toBeCalledTimes(0);
  });

  //     process.env.ISSUE_NUMBER = "123";
  //     // Listing all artifacts by issue_number is not yet implemented
  //     await expect(
  //       updateLabels({
  //         github: github,
  //         context: null,
  //         core: createMockCore(),
  //       }),
  //     ).rejects.toThrow();
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
