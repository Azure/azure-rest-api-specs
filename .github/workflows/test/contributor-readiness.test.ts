import { describe, expect, it, vi } from "vitest";
import {
  checkContributorReadiness,
  collectReadinessParticipants,
  renderReadiness,
  resolveReadinessPullRequest,
  type ReadinessFinding,
} from "../src/contributor-readiness.ts";
import {
  createMockContext,
  createMockCore,
  createMockGithub,
  createMockRequestError,
} from "./mocks.ts";

const author = { id: 1, login: "author-example", type: "User" };
const reviewer = { id: 2, login: "reviewer-example", type: "User" };
const repository = { id: 100, name: "example", owner: { login: "Azure" } };
const pr = {
  id: 10,
  number: 1,
  state: "open",
  user: author,
  commits: 1,
  head: { sha: "a".repeat(40) },
  base: { repo: { id: 100 } },
  updated_at: "2026-09-23T10:00:00Z",
};
const marker = "<!-- contributor-readiness -->";

function setup() {
  const github = createMockGithub();
  const context = createMockContext();
  context.eventName = "pull_request_target";
  context.repo.owner = "Azure";
  context.repo.repo = "example";
  context.payload = { pull_request: { number: 1 } };
  const core = createMockCore();
  const listCommits = vi.fn().mockResolvedValue({
    data: [{ sha: pr.head.sha, author, committer: author }],
  });
  const listReviews = vi.fn().mockResolvedValue({
    data: [{ id: 20, state: "APPROVED", user: reviewer }],
  });
  const permission = vi.fn().mockResolvedValue({ data: { permission: "write" } });
  const membership = vi.fn().mockResolvedValue({ status: 204 });
  const createCheck = vi.fn().mockResolvedValue({});
  const getRun = vi.fn().mockResolvedValue({
    data: {
      repository: { id: 100 },
      event: "pull_request_review",
      path: ".github/workflows/contributor-readiness-review.yaml",
      head_sha: pr.head.sha,
      pull_requests: [{ number: 1, base: { repo: { id: 100 } } }],
    },
  });
  Object.assign(github.rest.pulls, { listCommits, listReviews });
  Object.assign(github.rest.repos, { getCollaboratorPermissionLevel: permission });
  Object.assign(github.rest, { orgs: { checkPublicMembershipForUser: membership } });
  Object.assign(github.rest.checks, { create: createCheck });
  Object.assign(github.rest.actions, { getWorkflowRun: getRun });
  github.rest.pulls.get.mockResolvedValue({ data: pr });
  const args = { github, context, core };
  return {
    args,
    github,
    context,
    core,
    listCommits,
    listReviews,
    permission,
    membership,
    createCheck,
    getRun,
    run: () => checkContributorReadiness(args, 1),
  };
}

describe("contributor readiness", () => {
  it("deduplicates authors/committers and includes every submitted reviewer", async () => {
    const f = setup();
    f.listReviews.mockResolvedValue({
      data: [
        { id: 20, state: "APPROVED", user: reviewer },
        { id: 21, state: "COMMENTED", user: { id: 3, login: "commenter", type: "User" } },
        { id: 22, state: "DISMISSED", user: reviewer },
        { id: 23, state: "PENDING", user: { id: 4, login: "draft", type: "User" } },
      ],
    });
    const { data: pullRequest } = await f.github.rest.pulls.get({
      owner: "Azure",
      repo: "example",
      pull_number: 1,
    });
    const participants = await collectReadinessParticipants(
      f.github,
      "Azure",
      "example",
      pullRequest,
      [],
    );
    expect(participants.map((p) => p.login)).toEqual([
      "author-example",
      "commenter",
      "reviewer-example",
    ]);
    expect([...participants[0].roles]).toEqual(["PR author", "commit author", "committer"]);
  });

  it("creates a successful advisory check without a comment on a clean PR", async () => {
    const f = setup();
    await f.run();
    expect(f.createCheck).toHaveBeenCalledWith(
      expect.objectContaining({
        head_sha: pr.head.sha,
        conclusion: "success",
        external_id: "contributor-readiness:1",
      }),
    );
    expect(f.github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(f.core.summary.write).toHaveBeenCalledOnce();
  });

  it("reports private-or-missing membership conditionally, not as an invalid review", async () => {
    const f = setup();
    f.membership.mockRejectedValue(createMockRequestError(404));
    await f.run();
    expect(f.createCheck).toHaveBeenCalledWith(expect.objectContaining({ conclusion: "neutral" }));
    const call = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(call[0].body).toContain("If contributing internally");
    expect(call[0].body).toContain("This alone does not invalidate a review");
    expect(call[0].body).not.toContain("cannot satisfy");
  });

  it("explains reviewer and author access differently", async () => {
    const f = setup();
    f.permission.mockResolvedValue({ data: { permission: "read" } });
    await f.run();
    const [call] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(call.body).toContain("cannot satisfy a required write-access review");
    expect(call.body).toContain("Fork contributions remain possible");
  });

  it.each([
    { permission: "maintain" },
    { permission: "admin" },
    { permission: "custom", user: { permissions: { push: true } } },
  ])("recognizes effective write capability: %j", async (data) => {
    const f = setup();
    f.permission.mockResolvedValue({ data });
    await f.run();
    expect(f.createCheck).toHaveBeenCalledWith(expect.objectContaining({ conclusion: "success" }));
  });

  it.each([403, 404])("does not infer no access from permission lookup HTTP %s", async (code) => {
    const f = setup();
    f.permission.mockRejectedValue(createMockRequestError(code));
    await f.run();
    const [call] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(call.body).toContain("Could not verify");
    expect(call.body).not.toContain("No repository write access");
    expect(f.core.warning).toHaveBeenCalled();
  });

  it("reports unmapped commit accounts and incomplete commit pagination", async () => {
    const f = setup();
    f.github.rest.pulls.get.mockResolvedValue({ data: { ...pr, commits: 300 } });
    f.listCommits.mockResolvedValue({ data: [{ sha: pr.head.sha, author: {}, committer: null }] });
    await f.run();
    const [call] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(call.body).toContain("1 of 300 commits");
    expect(call.body).toContain("Could not associate an author or committer");
  });

  it("does not enforce human onboarding for automation", async () => {
    const f = setup();
    f.listCommits.mockResolvedValue({
      data: [
        {
          sha: pr.head.sha,
          author: { id: 5, login: "example[bot]", type: "Bot" },
          committer: { id: 19864447, login: "web-flow", type: "User" },
        },
      ],
    });
    await f.run();
    expect(f.permission).toHaveBeenCalledTimes(2);
    expect(f.membership).toHaveBeenCalledTimes(4);
  });

  it("publishes incomplete evidence and fails the run on a transient GitHub failure", async () => {
    const f = setup();
    f.listCommits.mockRejectedValue(createMockRequestError(503));
    await expect(f.run()).rejects.toThrow("503");
    expect(f.createCheck).toHaveBeenCalledWith(expect.objectContaining({ conclusion: "neutral" }));
    expect(f.core.error).toHaveBeenCalledOnce();
  });

  it("does not publish when a PR changes during evaluation", async () => {
    const f = setup();
    f.github.rest.pulls.get
      .mockResolvedValueOnce({ data: pr })
      .mockResolvedValueOnce({ data: { ...pr, head: { sha: "b".repeat(40) } } });
    await expect(f.run()).rejects.toThrow("PR changed");
    expect(f.createCheck).not.toHaveBeenCalled();
  });

  it("skips closed PRs", async () => {
    const f = setup();
    f.github.rest.pulls.get.mockResolvedValue({ data: { ...pr, state: "closed" } });
    await f.run();
    expect(f.listCommits).not.toHaveBeenCalled();
    expect(f.createCheck).not.toHaveBeenCalled();
  });

  it("ignores marker spoofing and only resolves its own bot comment", async () => {
    const f = setup();
    f.github.rest.issues.listComments.mockResolvedValue({
      data: [
        { id: 4, user: author, body: marker },
        { id: 5, user: { login: "github-actions[bot]", type: "Bot" }, body: marker },
      ],
    });
    await f.run();
    expect(f.github.rest.issues.updateComment).toHaveBeenCalledWith(
      expect.objectContaining({ comment_id: 5 }),
    );
    expect(f.github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("does not update an unchanged comment", async () => {
    const f = setup();
    f.permission.mockResolvedValue({ data: { permission: "read" } });
    await f.run();
    const [comment] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    f.github.rest.issues.listComments.mockResolvedValue({
      data: [
        {
          id: 5,
          user: { login: "github-actions[bot]", type: "Bot" },
          body: comment.body,
        },
      ],
    });
    await f.run();
    expect(f.github.rest.issues.updateComment).not.toHaveBeenCalled();
  });

  it("allows affected reviewers without write access to refresh", async () => {
    const f = setup();
    f.context.eventName = "issue_comment";
    f.context.payload = {
      issue: { number: 1 },
      comment: { id: 1, body: "/azsdk check-access" },
      sender: reviewer,
    };
    f.permission.mockResolvedValue({ data: { permission: "read" } });
    await f.run();
    expect(f.createCheck).toHaveBeenCalledOnce();
  });

  it("rejects an unrelated commenter without verified write access", async () => {
    const f = setup();
    f.context.eventName = "issue_comment";
    f.context.payload = {
      issue: { number: 1 },
      comment: { id: 1, body: "/azsdk check-access" },
      sender: { id: 55, login: "other", type: "User" },
    };
    f.permission.mockResolvedValue({ data: { permission: "read" } });
    await f.run();
    expect(f.createCheck).not.toHaveBeenCalled();
    expect(f.membership).not.toHaveBeenCalled();
  });

  it("escapes output and explicitly bounds very large reports", () => {
    const findings: ReadinessFinding[] = Array.from({ length: 200 }, () => ({
      subject: "@org/team | <script>",
      message: "Unresolved",
    }));
    const body = renderReadiness([], findings, pr.head.sha);
    expect(body).not.toContain("@org/team");
    expect(body).not.toContain("<script>");
    expect(body).toContain("100 additional findings");
  });
});

describe("readiness trigger resolution", () => {
  it("takes the PR number from a trusted target event", async () => {
    const f = setup();
    expect(await resolveReadinessPullRequest(f.args)).toBe(1);
  });

  it("ignores unrelated comments and ordinary issues", async () => {
    const f = setup();
    f.context.eventName = "issue_comment";
    f.context.payload = {
      issue: { number: 1 },
      comment: { id: 1, body: "/azsdk check-access" },
      sender: author,
    };
    expect(await resolveReadinessPullRequest(f.args)).toBeNull();
  });

  it("resolves the review workflow using server metadata instead of untrusted artifacts", async () => {
    const f = setup();
    f.context.eventName = "workflow_run";
    f.context.payload = { workflow_run: { id: 123 }, repository };
    expect(await resolveReadinessPullRequest(f.args)).toBe(1);
    expect(f.getRun).toHaveBeenCalledWith({ owner: "Azure", repo: "example", run_id: 123 });
    expect(f.github.rest.actions.listWorkflowRunArtifacts).not.toHaveBeenCalled();
  });

  it("uses repository-scoped lookup when GitHub omits fork PR metadata", async () => {
    const f = setup();
    f.context.eventName = "workflow_run";
    f.context.payload = { workflow_run: { id: 123 }, repository };
    f.getRun.mockResolvedValue({
      data: {
        repository: { id: 100 },
        event: "pull_request_review",
        path: ".github/workflows/contributor-readiness-review.yaml",
        head_sha: pr.head.sha,
        pull_requests: [],
      },
    });
    f.github.rest.search.issuesAndPullRequests.mockResolvedValue({
      data: { total_count: 1, incomplete_results: false, items: [{ number: 1 }] },
    });
    expect(await resolveReadinessPullRequest(f.args)).toBe(1);
    expect(f.github.rest.search.issuesAndPullRequests).toHaveBeenCalledWith({
      q: `repo:Azure/example is:pr is:open sha:${pr.head.sha}`,
      per_page: 100,
    });
  });

  it("rejects unexpected workflow paths and events", async () => {
    const f = setup();
    f.context.eventName = "workflow_run";
    f.context.payload = { workflow_run: { id: 123 }, repository };
    f.getRun.mockResolvedValue({
      data: { repository: { id: 100 }, event: "push", path: "untrusted.yaml" },
    });
    await expect(resolveReadinessPullRequest(f.args)).rejects.toThrow("Unexpected");
  });

  it("rejects ambiguous PR associations rather than reporting on an arbitrary PR", async () => {
    const f = setup();
    f.context.eventName = "workflow_run";
    f.context.payload = { workflow_run: { id: 123 }, repository };
    f.getRun.mockResolvedValue({
      data: {
        repository: { id: 100 },
        event: "pull_request_review",
        path: ".github/workflows/contributor-readiness-review.yaml",
        pull_requests: [1, 2].map((number) => ({ number, base: { repo: { id: 100 } } })),
      },
    });
    await expect(resolveReadinessPullRequest(f.args)).rejects.toThrow("multiple PRs");
  });
});
