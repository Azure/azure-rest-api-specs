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

  // it("workflow_run (same repo)", async () => {
  //   const core = createMockCore();

  //   const context = {
  //     eventName: "workflow_run",
  //     payload: {
  //       action: "completed",
  //       workflow_run

  //       repository: {
  //         name: "TestRepoName",
  //         owner: {
  //           login: "TestRepoOwnerLogin",
  //         },
  //       },
  //       pull_request: {
  //         head: {
  //           sha: "abc123",
  //         },
  //         number: 123,
  //       },
  //     },
  //   };

  //   const inputs = await extractInputs(null, context, core);

  //   expect(inputs).toEqual({
  //     owner: "TestRepoOwnerLogin",
  //     repo: "TestRepoName",
  //     head_sha: "abc123",
  //     issue_number: 123,
  //     run_id: NaN,
  //   });
  // });
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
