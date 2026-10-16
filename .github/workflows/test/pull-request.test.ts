import { describe, expect, it } from "vitest";
import { shouldRunSdkWorkflow } from "../src/pull-request.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

function createCheckRunContext(withPullRequests = true) {
  const context = createMockContext();
  context.eventName = "check_run";
  context.payload = {
    action: "completed",
    repository: { id: 1, name: "repo", owner: { login: "owner" } },
    check_run: {
      head_sha: "checked-sha",
      pull_requests: withPullRequests
        ? [
            { number: 42, head: { sha: "checked-sha" }, base: { repo: { id: 1 } } },
            { number: 43, head: { sha: "checked-sha" }, base: { repo: { id: 2 } } },
          ]
        : [],
    },
  };
  return context;
}

describe("SDK PR preflight", () => {
  it.each([
    { state: "open", allowed: true },
    { state: "closed", allowed: false },
  ])("checks live PR state ($state)", async ({ state, allowed }) => {
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({ data: { state } });

    expect(
      await shouldRunSdkWorkflow({
        github,
        context: createCheckRunContext(),
        core: createMockCore(),
      }),
    ).toBe(allowed);
    expect(github.rest.pulls.get).toHaveBeenCalledExactlyOnceWith({
      owner: "owner",
      repo: "repo",
      pull_number: 42,
    });
    expect(github.rest.repos.listPullRequestsAssociatedWithCommit).not.toHaveBeenCalled();
  });

  it("defers fork payloads without PRs without making discovery calls", async () => {
    const github = createMockGithub();
    const context = createCheckRunContext(false);

    expect(await shouldRunSdkWorkflow({ github, context, core: createMockCore() })).toBe(true);
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
    expect(github.rest.repos.listPullRequestsAssociatedWithCommit).not.toHaveBeenCalled();
  });
});
