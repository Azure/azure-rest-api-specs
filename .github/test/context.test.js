import { describe, expect, it, vi } from "vitest";
import { extractInputs } from "../src/context.js";

describe("extractInputs", () => {
  it("pull_request", async () => {
    const core = createMockCore();

    const context = {
      eventName: "pull_request",
      payload: {
        repository: {
          name: "TestRepoName",
          owner: {
            login: "TestRepoOwnerLogin",
          },
        },
        pull_request: {
          head: {
            sha: "abc123",
          },
          number: 123,
        },
      },
    };

    const inputs = await extractInputs(null, context, core);

    expect(inputs).toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: "abc123",
      issue_number: 123,
      run_id: NaN,
    });
  });

  it("workflow_run (same repo)", async () => {
    const core = createMockCore();

    const context = {
      eventName: "workflow_run",
      payload: {
        action: "completed",
        workflow_run: {
          head_repository: {
            name: "TestRepoName",
            owner: {
              login: "TestRepoOwnerLogin",
            },
          },
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

    const inputs = await extractInputs(null, context, core);

    expect(inputs).toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: "abc123",
      issue_number: 123,
      run_id: 456,
    });
  });

  // Fork Repo (context.pull_requests null or empty)
  // const github = createMockGithub();
  // github.rest.repos.listPullRequestsAssociatedWithCommit.mockResolvedValue({data: [{number: 123}]})
});

function createMockGithub() {
  return {
    rest: {
      repos: {
        listPullRequestsAssociatedWithCommit: vi
          .fn()
          .mockResolvedValue([{ number: 123 }]),
      },
    },
  };
}

function createMockCore() {
  return {
    debug: vi.fn(console.debug),
    info: vi.fn(console.log),
  };
}
