import { describe, expect, it } from "vitest";
import { PER_PAGE_MAX } from "../../shared/src/github.js";
import { fullGitSha } from "../../shared/test/examples.js";
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
      extractInputs(createMockGithub(), context, createMockCore()),
    ).rejects.toThrowErrorMatchingInlineSnapshot(
      `[Error: Context 'unsupported_event:unsupported_action' is not yet supported.]`,
    );
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

    await expect(extractInputs(createMockGithub(), context, createMockCore())).resolves.toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: "abc123",
      issue_number: 123,
      run_id: NaN,
    });
  });

  it("pull_request_target", async () => {
    const github = createMockGithub();

    const context = {
      eventName: "pull_request_target",
      payload: {
        action: "labeled",
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

    const expected = {
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: "abc123",
      issue_number: 123,
      run_id: NaN,
    };

    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual(expected);

    context.payload.action = "unlabeled";
    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual(expected);

    context.payload.action = "opened";
    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual(expected);

    context.payload.action = "synchronize";
    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual(expected);

    context.payload.action = "reopened";
    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual(expected);

    context.payload.action = "ready_for_review";
    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual(expected);

    context.payload.action = "edited";
    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual(expected);

    context.payload.action = "converted_to_draft";
    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual(expected);

    // Action not yet supported
    context.payload.action = "assigned";
    await expect(
      extractInputs(github, context, createMockCore()),
    ).rejects.toThrowErrorMatchingInlineSnapshot(
      `[Error: Context 'pull_request_target:assigned' is not yet supported.]`,
    );
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

    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual({
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

    await expect(extractInputs(createMockGithub(), context, createMockCore())).resolves.toEqual({
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
      extractInputs(createMockGithub(), context, createMockCore()),
    ).rejects.toThrowErrorMatchingInlineSnapshot(
      `[Error: Context 'workflow_run:unsupported_action' is not yet supported.]`,
    );
  });

  it("workflow_run:completed:pull_request (same repo)", async () => {
    const context = {
      eventName: "workflow_run",
      payload: {
        action: "completed",
        workflow_run: {
          event: "pull_request",
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

    await expect(extractInputs(createMockGithub(), context, createMockCore())).resolves.toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: "abc123",
      issue_number: 123,
      run_id: 456,
    });
  });

  it.each([0, 1, 2, 3])(
    "workflow_run:completed:pull_request (fork repo, %s PRs)",
    async (numPullRequests) => {
      const context = {
        eventName: "workflow_run",
        payload: {
          action: "completed",
          workflow_run: {
            event: "pull_request",
            head_repository: {
              name: "TestRepoName",
              owner: {
                login: "TestRepoOwnerLoginFork",
              },
            },
            head_sha: "abc123",
            id: 456,
            repository: {
              id: 1234,
              name: "TestRepoName",
              owner: {
                login: "TestRepoOwnerLogin",
              },
            },
            pull_requests: [],
          },
        },
      };

      const github = createMockGithub();
      github.rest.repos.listPullRequestsAssociatedWithCommit.mockImplementation(async (args) => {
        console.log(JSON.stringify(args));
        return {
          data: [
            {
              base: {
                repo: { id: 1234 },
              },
              number: 123,
            },
            // Ensure PRs to other repos are excluded
            {
              base: {
                repo: { id: 4567 },
              },
              number: 1,
            },
            // Multiple PRs to triggering repo still causes an error (TODO: #33418)
            {
              base: {
                repo: { id: 1234 },
              },
              number: 124,
            },
          ].slice(0, numPullRequests),
        };
      });

      if (numPullRequests === 0) {
        github.rest.search.issuesAndPullRequests.mockResolvedValue({
          data: { total_count: 0, items: [] },
        });

        await expect(extractInputs(github, context, createMockCore())).resolves.toEqual({
          owner: "TestRepoOwnerLogin",
          repo: "TestRepoName",
          head_sha: "abc123",
          issue_number: NaN,
          run_id: 456,
        });

        github.rest.search.issuesAndPullRequests.mockResolvedValue({
          data: { total_count: 1, items: [{ number: 789 }] },
        });

        await expect(extractInputs(github, context, createMockCore())).resolves.toEqual({
          owner: "TestRepoOwnerLogin",
          repo: "TestRepoName",
          head_sha: "abc123",
          issue_number: 789,
          run_id: 456,
        });

        expect(github.rest.search.issuesAndPullRequests).toHaveBeenCalled();

        // Simulate REST API throwing error, which should be handled, log a warning, and then
        // treat like any other scenario with no pull requests.
        github.rest.repos.listPullRequestsAssociatedWithCommit.mockRejectedValue(
          new Error("test-error"),
        );

        await expect(extractInputs(github, context, createMockCore())).resolves.toEqual({
          owner: "TestRepoOwnerLogin",
          repo: "TestRepoName",
          head_sha: "abc123",
          issue_number: 789,
          run_id: 456,
        });

        // Simulate REST API throwing object, which should be handled, log a warning, and then
        // treat like any other scenario with no pull requests.
        github.rest.repos.listPullRequestsAssociatedWithCommit.mockRejectedValue("test-error");

        await expect(extractInputs(github, context, createMockCore())).resolves.toEqual({
          owner: "TestRepoOwnerLogin",
          repo: "TestRepoName",
          head_sha: "abc123",
          issue_number: 789,
          run_id: 456,
        });
      } else if (numPullRequests === 1 || numPullRequests === 2) {
        // Second PR is to a different repo, so expect same behavior with or without it
        await expect(extractInputs(github, context, createMockCore())).resolves.toEqual({
          owner: "TestRepoOwnerLogin",
          repo: "TestRepoName",
          head_sha: "abc123",
          issue_number: 123,
          run_id: 456,
        });
      } else {
        // Multiple PRs to triggering repo still causes an error (TODO: #33418)
        await expect(extractInputs(github, context, createMockCore())).rejects.toThrow(
          "Unexpected number of pull requests",
        );
      }

      expect(github.rest.repos.listPullRequestsAssociatedWithCommit).toHaveBeenCalledWith({
        owner: "TestRepoOwnerLoginFork",
        repo: "TestRepoName",
        commit_sha: "abc123",
        per_page: PER_PAGE_MAX,
      });

      // For pull_request, do NOT attempt to extract the issue number from an artifact, since this could be modified
      // in a fork PR.
      expect(github.rest.actions.listWorkflowRunArtifacts).toHaveBeenCalledTimes(0);
    },
  );

  it("workflow_run:completed:workflow_run", async () => {
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: { artifacts: [{ name: "issue-number=123" }, { name: `head-sha=${fullGitSha}` }] },
    });

    const context = {
      eventName: "workflow_run",
      payload: {
        action: "completed",
        workflow_run: {
          event: "workflow_run",
          head_sha: "def456",
          id: 456,
          repository: {
            name: "TestRepoName",
            owner: {
              login: "TestRepoOwnerLogin",
            },
          },
        },
      },
    };

    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: fullGitSha,
      issue_number: 123,
      run_id: 456,
    });

    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: { artifacts: [{ name: "head-sha=not-full-git-sha" }] },
    });
    await expect(
      extractInputs(github, context, createMockCore()),
    ).rejects.toThrowErrorMatchingInlineSnapshot(
      `[Error: head-sha is not a valid full git SHA: 'not-full-git-sha']`,
    );

    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: { artifacts: [{ name: "issue-number=not-a-number" }] },
    });
    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: "",
      issue_number: NaN,
      run_id: 456,
    });

    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: { artifacts: [{ name: "issue-number=null" }] },
    });
    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: "",
      issue_number: NaN,
      run_id: 456,
    });

    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: { artifacts: [] },
    });
    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: "",
      issue_number: NaN,
      run_id: 456,
    });
  });

  it("workflow_run:completed:unsupported", async () => {
    const context = {
      eventName: "workflow_run",
      payload: {
        action: "completed",
        workflow_run: {
          event: "unsupported",
        },
      },
    };

    await expect(
      extractInputs(createMockGithub(), context, createMockCore()),
    ).rejects.toThrowErrorMatchingInlineSnapshot(
      `[Error: Context 'workflow_run:completed' with 'workflow_run.event=unsupported is not yet supported.]`,
    );
  });

  it("workflow_run:completed:check_run", async () => {
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: { artifacts: [{ name: `head-sha=${fullGitSha}` }] },
    });

    const context = {
      eventName: "workflow_run",
      payload: {
        action: "completed",
        workflow_run: {
          event: "check_run",
          head_sha: "def456",
          id: 456,
          repository: {
            name: "TestRepoName",
            owner: {
              login: "TestRepoOwnerLogin",
            },
          },
        },
      },
    };

    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      head_sha: fullGitSha,
      issue_number: NaN,
      run_id: 456,
    });
  });

  it("check_run:completed", async () => {
    const github = createMockGithub();
    const context = {
      eventName: "check_run",
      payload: {
        action: "completed",
        check_run: {
          details_url: "https://dev.azure.com/abc/123-456/_build/results?buildId=56789",
          head_sha: "abc123",
        },
        repository: {
          name: "TestRepoName",
          owner: {
            login: "TestRepoOwnerLogin",
          },
        },
      },
    };

    await expect(extractInputs(github, context, createMockCore())).resolves.toEqual({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      issue_number: NaN,
      head_sha: "abc123",
      run_id: NaN,
      details_url: "https://dev.azure.com/abc/123-456/_build/results?buildId=56789",
    });
  });

  it("check_run:completed throw error when the payload is invalid", async () => {
    const github = createMockGithub();
    const context = {
      eventName: "check_run",
      payload: {
        action: "completed",
        check_run: {
          details_url: "https://dev.azure.com/abc/123-456/_build/results?buildId=56789",
          head_sha: "abc123",
        },
        repository: {
          owner: {
            login: "TestRepoOwnerLogin",
          },
        },
      },
    };

    await expect(extractInputs(github, context, createMockCore())).rejects.toThrow(
      "from context payload",
    );
  });
});

it("check_run:completed", async () => {
  const context = {
    eventName: "check_suite",
    payload: {
      action: "completed",
      check_suite: {
        head_sha: "head_sha",
      },
      repository: {
        name: "TestRepoName",
        owner: {
          login: "TestRepoOwnerLogin",
        },
      },
    },
  };

  await expect(extractInputs(createMockGithub(), context, createMockCore())).resolves.toEqual({
    owner: "TestRepoOwnerLogin",
    repo: "TestRepoName",
    head_sha: "head_sha",
    issue_number: NaN,
    run_id: NaN,
  });
});
