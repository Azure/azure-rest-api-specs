import { describe, expect, it, vi } from "vitest";
import { extractInputs } from "../src/context.js";

describe("extractInputs", () => {
  it("unsupported_event", async () => {
    const core = createMockCore();

    const context = {
      eventName: "unsupported_event",
      payload: {
        action: "unsupported_action",
      },
    };

    await expect(extractInputs(null, context, core)).rejects.toThrow();
  });

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

    await expect(extractInputs(null, context, core)).resolves.toEqual({
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

    await expect(extractInputs(null, context, core)).resolves.toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: "abc123",
      issue_number: 123,
      run_id: 456,
    });
  });

  it.each([0, 1, 2])(
    "workflow_run (fork repo, %s PRs)",
    async (numPullRequests) => {
      const core = createMockCore();

      const context = {
        eventName: "workflow_run",
        payload: {
          action: "completed",
          workflow_run: {
            head_repository: {
              name: "TestRepoName",
              owner: {
                login: "TestRepoOwnerLoginFork",
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
            pull_requests: [],
          },
        },
      };

      const github = {
        rest: {
          repos: {
            listPullRequestsAssociatedWithCommit: vi.fn().mockResolvedValue({
              data: [{ number: 123 }, { number: 124 }].slice(
                0,
                numPullRequests,
              ),
            }),
          },
        },
      };

      const inputsPromise = extractInputs(github, context, core);
      if (numPullRequests === 1) {
        await expect(inputsPromise).resolves.toEqual({
          owner: "TestRepoOwnerLogin",
          repo: "TestRepoName",
          head_sha: "abc123",
          issue_number: 123,
          run_id: 456,
        });
      } else {
        await expect(inputsPromise).rejects.toThrow();
      }

      expect(
        github.rest.repos.listPullRequestsAssociatedWithCommit,
      ).toHaveBeenCalledWith({
        owner: "TestRepoOwnerLoginFork",
        repo: "TestRepoName",
        commit_sha: "abc123",
      });
    },
  );
});

function createMockCore() {
  return {
    debug: vi.fn(console.debug),
    info: vi.fn(console.log),
  };
}
