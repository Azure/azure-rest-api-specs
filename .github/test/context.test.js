import { describe, expect, it, vi } from "vitest";
import { extractInputs } from "../src/context.js";
import { createMockCore, createMockGithub } from "./mocks.js";

describe("extractInputs", () => {
  it("unsupported_event", async () => {
    const context = {
      eventName: "unsupported_event",
      payload: {
        action: "unsupported_action",
      },
    };

    await expect(
      extractInputs(null, context, createMockCore()),
    ).rejects.toThrow();
  });

  it("pull_request", async () => {
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

    await expect(
      extractInputs(null, context, createMockCore()),
    ).resolves.toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: "abc123",
      issue_number: 123,
      run_id: NaN,
    });
  });

  it("issue_comment:edited", async () => {
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({
      data: { head: { sha: "abc123" } },
    });

    const context = {
      eventName: "issue_comment",
      payload: {
        action: "edited",
        repository: {
          name: "TestRepoName",
          owner: {
            login: "TestRepoOwnerLogin",
          },
        },
        issue: {
          number: 123,
        },
      },
    };

    await expect(
      extractInputs(github, context, createMockCore()),
    ).resolves.toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: "abc123",
      issue_number: 123,
      run_id: NaN,
    });

    expect(github.rest.pulls.get).toHaveBeenCalledWith({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      pull_number: 123,
    });
  });

  it("workflow_dispatch", async () => {
    const context = {
      eventName: "workflow_dispatch",
      payload: {
        repository: {
          name: "TestRepoName",
          owner: {
            login: "TestRepoOwnerLogin",
          },
        },
      },
    };

    await expect(
      extractInputs(null, context, createMockCore()),
    ).resolves.toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: "",
      issue_number: NaN,
      run_id: NaN,
    });
  });

  it("workflow_run:unsupported_action", async () => {
    const context = {
      eventName: "workflow_run",
      payload: {
        action: "unsupported_action",
      },
    };

    await expect(
      extractInputs(null, context, createMockCore()),
    ).rejects.toThrow();
  });

  it("workflow_run:completed (same repo)", async () => {
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
      extractInputs(null, context, createMockCore()),
    ).resolves.toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: "abc123",
      issue_number: 123,
      run_id: 456,
    });
  });

  it.each([0, 1, 2])(
    "workflow_run:completed (fork repo, %s PRs)",
    async (numPullRequests) => {
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

      const inputsPromise = extractInputs(github, context, createMockCore());
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
