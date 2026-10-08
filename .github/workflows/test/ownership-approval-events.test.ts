import { describe, expect, it, vi } from "vitest";
import { resolveOwnershipPullRequest } from "../src/ownership-approval-events.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

function setup() {
  const github = createMockGithub();
  const context = createMockContext();
  const core = createMockCore();
  context.eventName = "workflow_run";
  context.payload = {
    workflow_run: { id: 123 },
    repository: { id: 100, name: "example", owner: { login: "Azure" } },
  };
  const run = {
    repository: { id: 100 },
    path: ".github/workflows/ownership-approval-notify.yaml",
    event: "pull_request_review",
    head_sha: "a".repeat(40),
    pull_requests: [{ number: 1, base: { repo: { id: 100 } } }],
  };
  const getRun = vi.fn().mockResolvedValue({ data: run });
  Object.assign(github.rest.actions, { getWorkflowRun: getRun });
  github.rest.pulls.get.mockResolvedValue({
    data: { state: "open", base: { repo: { id: 100 } } },
  });
  return {
    github,
    context,
    core,
    run,
    getRun,
    resolve: () => resolveOwnershipPullRequest({ github, context, core }),
  };
}

describe("ownership approval events", () => {
  it("resolves review events from GitHub's workflow metadata", async () => {
    const f = setup();
    expect(await f.resolve()).toBe(1);
    expect(f.getRun).toHaveBeenCalledWith({ ...f.context.repo, run_id: 123 });
  });

  it("rejects another workflow rather than trusting its PR association", async () => {
    const f = setup();
    f.run.path = ".github/workflows/unrelated.yaml";
    await expect(f.resolve()).rejects.toThrow("Unexpected ownership notification");
    expect(f.github.rest.pulls.get).not.toHaveBeenCalled();
  });

  it("resolves a fork notification with no PR association through a complete GitHub lookup", async () => {
    const f = setup();
    f.run.pull_requests = [];
    f.github.rest.search.issuesAndPullRequests.mockResolvedValue({
      data: { total_count: 1, incomplete_results: false, items: [{ number: 2 }] },
    });
    expect(await f.resolve()).toBe(2);
  });

  it("does not guess when the fork lookup is incomplete", async () => {
    const f = setup();
    f.run.pull_requests = [];
    f.github.rest.search.issuesAndPullRequests.mockResolvedValue({
      data: { total_count: 2, incomplete_results: true, items: [{ number: 2 }] },
    });
    await expect(f.resolve()).rejects.toThrow("Incomplete ownership PR lookup");
  });

  it("requires an explicit PR when notification metadata is ambiguous", async () => {
    const f = setup();
    f.run.pull_requests.push({ number: 2, base: { repo: { id: 100 } } });
    await expect(f.resolve()).rejects.toThrow("Ambiguous ownership PR lookup");
  });

  it("ignores notifications for closed PRs", async () => {
    const f = setup();
    f.github.rest.pulls.get.mockResolvedValue({
      data: { state: "closed", base: { repo: { id: 100 } } },
    });
    expect(await f.resolve()).toBeNull();
  });

  it("supports a refresh command without treating the comment as an approval", async () => {
    const f = setup();
    f.context.eventName = "issue_comment";
    f.context.payload = {
      issue: { number: 42, pull_request: {} },
      comment: { id: 1, body: "/azsdk check-ownership" },
      sender: { type: "User" },
    };
    expect(await f.resolve()).toBe(42);
    expect(f.getRun).not.toHaveBeenCalled();
  });

  it("ignores unrelated comments and bot commands", async () => {
    const f = setup();
    f.context.eventName = "issue_comment";
    f.context.payload = {
      issue: { number: 42, pull_request: {} },
      comment: { id: 1, body: "/azsdk check-ownership" },
      sender: { type: "Bot" },
    };
    expect(await f.resolve()).toBeNull();
  });
});
