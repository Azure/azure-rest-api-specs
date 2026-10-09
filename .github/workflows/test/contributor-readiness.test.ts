import { readFileSync } from "node:fs";
import { describe, expect, it, vi } from "vitest";
import { isMap, isSeq, parseDocument } from "yaml";
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
  changed_files: 1,
  head: { sha: "a".repeat(40) },
  base: { repo: { id: 100 } },
  updated_at: "2026-09-23T10:00:00Z",
};
const marker = "<!-- contributor-readiness -->";
const notifierPath = ".github/workflows/contributor-readiness-notify.yaml";
const authorImpact = "PR author cannot add labels to this PR.";
const reviewerImpact = "Reviewer approval does not count toward required reviews";

function setup() {
  const github = createMockGithub();
  const context = createMockContext();
  context.eventName = "workflow_run";
  context.repo.owner = "Azure";
  context.repo.repo = "example";
  context.payload = { workflow_run: { id: 123 }, repository };
  const core = createMockCore();
  const listCommits = vi.fn().mockResolvedValue({
    data: [{ sha: pr.head.sha, author, committer: author }],
  });
  const listReviews = vi.fn().mockResolvedValue({
    data: [{ id: 20, state: "APPROVED", user: reviewer }],
  });
  const listFiles = vi.fn().mockResolvedValue({
    data: [{ filename: "specification/widgets/main.tsp", status: "modified" }],
  });
  const permission = vi.fn().mockResolvedValue({ data: { permission: "write" } });
  const membership = vi
    .fn<(params: { org: string; username: string }) => Promise<{ status: number }>>()
    .mockResolvedValue({ status: 204 });
  const createCheck = vi.fn().mockResolvedValue({});
  const getRun = vi.fn().mockResolvedValue({
    data: {
      repository: { id: 100 },
      event: "pull_request_review",
      path: notifierPath,
      head_sha: pr.head.sha,
      pull_requests: [{ number: 1, base: { repo: { id: 100 } } }],
    },
  });
  Object.assign(github.rest.pulls, { listCommits, listReviews, listFiles });
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
    listFiles,
    permission,
    membership,
    createCheck,
    getRun,
    run: () => checkContributorReadiness(args, 1),
  };
}

describe("contributor readiness", () => {
  it("routes PR events through an unprivileged notifier and trusted workflow_run publisher", () => {
    const publisher = parseDocument(
      readFileSync(new URL("../contributor-readiness-report.yaml", import.meta.url), "utf8"),
    );
    const notifier = parseDocument(
      readFileSync(new URL("../contributor-readiness-notify.yaml", import.meta.url), "utf8"),
    );
    expect(publisher.errors).toEqual([]);
    expect(notifier.errors).toEqual([]);
    expect(publisher.hasIn(["on", "pull_request_target"])).toBe(false);
    expect(publisher.hasIn(["on", "pull_request"])).toBe(false);
    expect(notifier.hasIn(["on", "pull_request"])).toBe(true);
    expect(notifier.hasIn(["on", "pull_request_review"])).toBe(true);
    const reviewEvents = notifier.getIn(["on", "pull_request_review", "types"]);
    if (!isSeq(reviewEvents)) throw new Error("Notifier must name its review event types");
    expect(reviewEvents.toJSON()).toEqual(["submitted", "dismissed"]);

    const permissions = notifier.get("permissions");
    if (!isMap(permissions)) throw new Error("Notifier permissions must be explicit");
    expect(permissions.toJSON()).toEqual({});
    const workflows = publisher.getIn(["on", "workflow_run", "workflows"]);
    if (!isSeq(workflows)) throw new Error("Publisher must name its notifier workflows");
    expect(workflows.toJSON()).toEqual([notifier.get("name")]);
  });

  it("grants the publisher permission to comment on pull requests", () => {
    const workflow = parseDocument(
      readFileSync(new URL("../contributor-readiness-report.yaml", import.meta.url), "utf8"),
    );
    expect(workflow.errors).toEqual([]);
    expect(workflow.getIn(["jobs", "report", "permissions", "pull-requests"])).toBe("write");
  });

  it.each(["workflow_run", "issue_comment"])(
    "skips engineering-only PRs for %s before checking accounts",
    async (eventName) => {
      const f = setup();
      f.context.eventName = eventName;
      if (eventName === "issue_comment") {
        f.context.payload = {
          issue: { number: 1 },
          comment: { id: 1, body: "/azsdk check-access" },
          sender: author,
        };
      }
      f.listFiles.mockResolvedValue({ data: [{ filename: "eng/README.md", status: "modified" }] });
      await f.run();
      expect(f.listCommits).not.toHaveBeenCalled();
      expect(f.listReviews).not.toHaveBeenCalled();
      expect(f.membership).not.toHaveBeenCalled();
      expect(f.permission).not.toHaveBeenCalled();
      expect(f.createCheck).not.toHaveBeenCalled();
      expect(f.github.rest.issues.createComment).not.toHaveBeenCalled();
      expect(f.github.rest.issues.updateComment).not.toHaveBeenCalled();
      expect(f.core.info).toHaveBeenCalledWith(
        "Skipping contributor readiness: no changes under specification/.",
      );
    },
  );

  it.each([
    { filename: "specification/widgets/main.tsp", status: "added" },
    { filename: "specification/widgets/main.tsp", status: "removed" },
    {
      filename: "specification/widgets/main.tsp",
      previous_filename: "eng/main.tsp",
      status: "renamed",
    },
    {
      filename: "eng/main.tsp",
      previous_filename: "specification/widgets/main.tsp",
      status: "renamed",
    },
  ])("checks a PR that changes specification content: %j", async (file) => {
    const f = setup();
    f.listFiles.mockResolvedValue({ data: [file] });
    await f.run();
    expect(f.createCheck).toHaveBeenCalledOnce();
  });

  it("includes mixed PRs and inspects the paginated file list", async () => {
    const f = setup();
    f.github.rest.pulls.get.mockResolvedValue({ data: { ...pr, changed_files: 101 } });
    f.listFiles.mockResolvedValue({
      data: [
        ...Array.from({ length: 100 }, (_, index) => ({ filename: `eng/file-${index}.ts` })),
        { filename: "specification/widgets/main.tsp" },
      ],
    });
    const paginate = vi.spyOn(f.github, "paginate");
    await f.run();
    expect(paginate).toHaveBeenCalledWith(f.listFiles, {
      owner: "Azure",
      repo: "example",
      pull_number: 1,
      per_page: 100,
    });
    expect(f.createCheck).toHaveBeenCalledOnce();
  });

  it("does not mistake a similarly named folder for specification/", async () => {
    const f = setup();
    f.listFiles.mockResolvedValue({ data: [{ filename: "specification-tools/check.ts" }] });
    await f.run();
    expect(f.createCheck).not.toHaveBeenCalled();
  });

  it("does not silently skip when GitHub truncates the changed-file list", async () => {
    const f = setup();
    f.github.rest.pulls.get.mockResolvedValue({ data: { ...pr, changed_files: 3001 } });
    f.listFiles.mockResolvedValue({ data: [{ filename: "eng/file.ts" }] });
    await expect(f.run()).rejects.toThrow("Cannot determine specification scope");
    expect(f.membership).not.toHaveBeenCalled();
    expect(f.createCheck).not.toHaveBeenCalled();
  });

  it("propagates file lookup failures instead of claiming the PR is out of scope", async () => {
    const f = setup();
    f.listFiles.mockRejectedValue(createMockRequestError(503));
    await expect(f.run()).rejects.toThrow("503");
    expect(f.membership).not.toHaveBeenCalled();
    expect(f.createCheck).not.toHaveBeenCalled();
  });

  it("deduplicates authors/committers and includes only approving reviewers", async () => {
    const f = setup();
    f.listReviews.mockResolvedValue({
      data: [
        { id: 20, state: "APPROVED", user: reviewer },
        { id: 24, state: "APPROVED", user: reviewer },
        { id: 21, state: "COMMENTED", user: { id: 3, login: "commenter", type: "User" } },
        { id: 22, state: "DISMISSED", user: { id: 5, login: "dismissed", type: "User" } },
        { id: 23, state: "PENDING", user: { id: 4, login: "draft", type: "User" } },
        {
          id: 25,
          state: "CHANGES_REQUESTED",
          user: { id: 6, login: "arm-reviewer", type: "User" },
        },
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
    expect(participants.map((p) => p.login)).toEqual(["author-example", "reviewer-example"]);
    expect([...participants[0].roles]).toEqual(["PR author", "commit author", "committer"]);
    expect([...participants[1].roles]).toEqual(["approved reviewer"]);
  });

  it.each(["COMMENTED", "CHANGES_REQUESTED", "PENDING", "DISMISSED"])(
    "ignores %s reviewers and their unavailable identities before checking access",
    async (state) => {
      const f = setup();
      f.listReviews.mockResolvedValue({
        data: [
          { id: 20, state, user: reviewer },
          { id: 21, state, user: null },
        ],
      });
      f.permission.mockImplementation(({ username }: { username: string }) =>
        Promise.resolve({ data: { permission: username === reviewer.login ? "read" : "write" } }),
      );
      await f.run();
      expect(f.permission).not.toHaveBeenCalledWith(
        expect.objectContaining({ username: reviewer.login }),
      );
      expect(f.membership).not.toHaveBeenCalledWith({
        org: "Azure",
        username: reviewer.login,
      });
      expect(f.createCheck).toHaveBeenCalledWith(
        expect.objectContaining({ conclusion: "success" }),
      );
      expect(f.github.rest.issues.createComment).not.toHaveBeenCalled();
    },
  );

  it("keeps author and commit participants without assigning nonapproved reviewer roles", async () => {
    const f = setup();
    f.listCommits.mockResolvedValue({
      data: [{ sha: pr.head.sha, author, committer: reviewer }],
    });
    f.listReviews.mockResolvedValue({
      data: [
        { id: 20, state: "COMMENTED", user: author },
        { id: 21, state: "CHANGES_REQUESTED", user: reviewer },
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
    expect([...participants[0].roles]).toEqual(["PR author", "commit author"]);
    expect([...participants[1].roles]).toEqual(["committer"]);
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
    expect(f.core.summary.addRaw).not.toHaveBeenCalledWith(expect.stringContaining("<details>"));
  });

  it("requires only Azure membership, not Microsoft membership", async () => {
    const f = setup();
    f.membership.mockImplementation(({ org }: { org: string }) =>
      org === "Microsoft"
        ? Promise.reject(createMockRequestError(404))
        : Promise.resolve({ status: 204 }),
    );
    await f.run();
    expect(f.membership.mock.calls.map(([params]) => params)).toEqual([
      { org: "Azure", username: author.login },
      { org: "Azure", username: reviewer.login },
    ]);
    expect(f.createCheck).toHaveBeenCalledWith(expect.objectContaining({ conclusion: "success" }));
    expect(f.github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("keeps the job summary available when PR comment publication fails", async () => {
    const f = setup();
    f.permission.mockResolvedValue({ data: { permission: "read" } });
    f.github.rest.issues.createComment.mockRejectedValue(createMockRequestError(403));

    await expect(f.run()).rejects.toThrow("403");

    expect(f.createCheck).toHaveBeenCalledOnce();
    expect(f.core.summary.addRaw).toHaveBeenCalledWith(
      expect.stringContaining("No repository write access"),
    );
    expect(f.core.summary.write).toHaveBeenCalledOnce();
  });

  it.each([null, {}])("reports an unavailable PR author as incomplete: %j", async (user) => {
    const f = setup();
    f.github.rest.pulls.get.mockResolvedValue({ data: { ...pr, user } });
    await f.run();
    expect(f.createCheck).toHaveBeenCalledWith(expect.objectContaining({ conclusion: "neutral" }));
    const [comment] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(comment.body).toContain("| 🟡 **PR author** |");
    expect(comment.body).toContain("GitHub account unavailable.");
    expect(f.core.summary.addRaw).toHaveBeenCalledWith(
      expect.stringContaining("GitHub account unavailable."),
    );
  });

  it("reports private-or-missing membership conditionally, not as an invalid review", async () => {
    const f = setup();
    f.membership.mockRejectedValue(createMockRequestError(404));
    await f.run();
    expect(f.createCheck).toHaveBeenCalledWith(expect.objectContaining({ conclusion: "neutral" }));
    const call = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(call[0].body).toContain("Internal contributors:");
    expect(call[0].body).toContain("GitHub review rules still apply");
    expect(call[0].body).toContain("Not determined.");
    expect(call[0].body).not.toContain(authorImpact);
    expect(call[0].body).not.toContain(reviewerImpact);
  });

  it.each([404, 403])(
    "prefills each user's organization People search for membership HTTP %s",
    async (code) => {
      const f = setup();
      f.membership.mockRejectedValue(createMockRequestError(code));
      await f.run();
      const [comment] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
      for (const user of [author, reviewer]) {
        const row = comment.body.split("\n").find((line) => line.includes(`**[${user.login}]`));
        expect(row).toContain(`[Azure](https://github.com/orgs/Azure/people?query=${user.login})`);
      }
      expect(comment.body).not.toContain("Microsoft");
      expect(comment.body).toContain("https://aka.ms/azsdk/access");
      expect(comment.body).toContain(code === 403 ? "🟡" : "🔴");
      expect(comment.body).not.toContain("<details>");
      expect(f.core.summary.addRaw).toHaveBeenCalledWith(comment.body.replace(`\n${marker}`, ""));
    },
  );

  it("explains reviewer and author access differently", async () => {
    const f = setup();
    f.permission.mockResolvedValue({ data: { permission: "read" } });
    await f.run();
    const [call] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    const authorRow = call.body.split("\n").find((line) => line.includes(`**[${author.login}]`));
    const reviewerRow = call.body
      .split("\n")
      .find((line) => line.includes(`**[${reviewer.login}]`));
    expect(authorRow).toContain(authorImpact);
    expect(authorRow).not.toContain("Azure DevOps pipelines");
    expect(authorRow).not.toContain(reviewerImpact);
    expect(reviewerRow).toContain(reviewerImpact);
    expect(reviewerRow).toContain("GitHub's green approval check");
    expect(reviewerRow).toContain("This reviewer must set up or renew their access.");
    expect(reviewerRow).not.toContain(authorImpact);
    expect(call.body).toContain(
      "> [!WARNING]\n> **The access issues below can prevent PR approvals from counting or PR authors from adding labels.**",
    );
    expect(call.body).not.toContain("Internal contributors need Azure organization membership");
    expect(call.body).not.toContain("private membership cannot be verified");
    expect(call.body).toContain("Non-blocking report");
    expect(call.body).toContain("external fork contributions are allowed");
    const report = call.body.replace(`\n${marker}`, "");
    expect(f.core.summary.addRaw).toHaveBeenCalledWith(report);
    const [check] = f.createCheck.mock.calls[0] as [
      { conclusion: string; output: { summary: string } },
    ];
    expect(check.conclusion).toBe("neutral");
    expect(check.output.summary).toBe(report);
  });

  it("shows author and reviewer impacts for a PR author with an approved review", async () => {
    const f = setup();
    f.listReviews.mockResolvedValue({
      data: [{ id: 20, state: "APPROVED", user: author }],
    });
    f.permission.mockResolvedValue({ data: { permission: "read" } });
    await f.run();
    const [comment] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    const rows = comment.body.split("\n").filter((line) => line.startsWith("| 🔴"));
    expect(rows).toHaveLength(1);
    expect(rows[0]).toContain(`${authorImpact}<br>${reviewerImpact}`);
  });

  it("does not assign author or reviewer impacts to commit-only participants", async () => {
    const f = setup();
    const committer = { id: 3, login: "committer-example", type: "User" };
    f.listCommits.mockResolvedValue({
      data: [{ sha: pr.head.sha, author: committer, committer }],
    });
    f.permission.mockImplementation(({ username }: { username: string }) =>
      Promise.resolve({ data: { permission: username === committer.login ? "read" : "write" } }),
    );
    await f.run();
    const [comment] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(comment.body).toContain("**[committer-example]");
    expect(comment.body).toContain("No repository write access. | Not determined.");
    expect(comment.body).not.toContain(authorImpact);
    expect(comment.body).not.toContain(reviewerImpact);
  });

  it("groups each affected user into one short, clearly marked row", async () => {
    const f = setup();
    f.membership.mockRejectedValue(createMockRequestError(404));
    f.permission.mockResolvedValue({ data: { permission: "read" } });
    await f.run();
    const [comment] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    const rows = comment.body.split("\n").filter((line) => line.startsWith("| 🔴"));
    expect(rows).toHaveLength(2);
    expect(rows[0]).toContain("**[author-example](https://github.com/author-example)**");
    expect(rows[1]).toContain("**[reviewer-example](https://github.com/reviewer-example)**");
    expect(rows.every((row) => row.includes("[Azure]"))).toBe(true);
    expect(comment.body).not.toContain("Microsoft");
    expect(comment.body).toContain("https://aka.ms/azsdk/access");
    expect(comment.body).not.toContain("eng.ms");
    expect(comment.body).not.toContain("Evaluated participants");
    expect(comment.body).not.toContain("180 days");
    expect(comment.body.split(/\s+/).length).toBeLessThan(150);
  });

  it("keeps verified users collapsed and distinguishes unavailable checks from confirmed issues", async () => {
    const f = setup();
    f.permission.mockImplementation(({ username }: { username: string }) =>
      username === reviewer.login
        ? Promise.reject(createMockRequestError(403))
        : Promise.resolve({ data: { permission: "write" } }),
    );
    await f.run();
    const [comment] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    const [findings, verified] = comment.body.split("<details>");
    expect(findings).toContain("| 🟡 **[reviewer-example]");
    expect(findings).not.toContain("author-example");
    expect(findings).not.toContain("🔴");
    expect(findings).toContain("Could not verify repository access");
    expect(verified).toContain("<summary>Contributors with verified access (1)</summary>");
    expect(verified).toContain("Public Azure membership and repository write access verified.");
    expect(verified).toContain("[author-example](https://github.com/author-example)");
    expect(verified).toContain("PR author, commit author, committer");
    expect(verified).not.toContain("reviewer-example");
    expect(verified).not.toContain("<details open");
  });

  it("shows passing approved reviewers in details when the author lacks access", async () => {
    const f = setup();
    f.permission.mockImplementation(({ username }: { username: string }) =>
      Promise.resolve({ data: { permission: username === author.login ? "read" : "write" } }),
    );
    await f.run();
    const [comment] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    const [findings, verified] = comment.body.split("<details>");
    expect(findings).toContain(authorImpact);
    expect(findings).not.toContain("reviewer-example");
    expect(verified).toContain("[reviewer-example](https://github.com/reviewer-example)");
    expect(verified).toContain("approved reviewer");
    expect(verified).not.toContain("author-example");
    const report = comment.body.replace(`\n${marker}`, "");
    expect(f.core.summary.addRaw).toHaveBeenCalledWith(report);
    const [check] = f.createCheck.mock.calls[0] as [{ output: { summary: string } }];
    expect(check.output.summary).toBe(report);
  });

  it.each([
    { permission: "write", role_name: "maintain" },
    { permission: "admin", role_name: "admin" },
    { permission: "write", role_name: "custom-reviewer" },
  ])("recognizes effective write capability: %j", async (data) => {
    const f = setup();
    f.permission.mockResolvedValue({ data });
    await f.run();
    expect(f.createCheck).toHaveBeenCalledWith(expect.objectContaining({ conclusion: "success" }));
  });

  it.each([
    { permission: "read", role_name: "triage" },
    { permission: "read", role_name: "custom-reviewer" },
    { permission: "none", role_name: "none" },
  ])("does not grant write access from a role name: %j", async (data) => {
    const f = setup();
    f.permission.mockResolvedValue({ data });
    await f.run();
    expect(f.createCheck).toHaveBeenCalledWith(expect.objectContaining({ conclusion: "neutral" }));
    const [comment] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(comment.body).toContain("No repository write access.");
    expect(comment.body).toContain(reviewerImpact);
  });

  it.each([403, 404])("does not infer no access from permission lookup HTTP %s", async (code) => {
    const f = setup();
    f.permission.mockRejectedValue(createMockRequestError(code));
    await f.run();
    const [call] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(call.body).toContain("Could not verify");
    expect(call.body).not.toContain("No repository write access");
    expect(call.body).not.toContain(authorImpact);
    expect(call.body).not.toContain(reviewerImpact);
    expect(call.body).toContain("Not determined.");
    expect(call.body).not.toContain("<details>");
    expect(f.core.warning).toHaveBeenCalled();
  });

  it("reports unmapped commit accounts and incomplete commit pagination", async () => {
    const f = setup();
    f.github.rest.pulls.get.mockResolvedValue({ data: { ...pr, commits: 300 } });
    f.listCommits.mockResolvedValue({ data: [{ sha: pr.head.sha, author: {}, committer: null }] });
    await f.run();
    const [call] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(call.body).toContain("1 of 300 commits");
    expect(call.body).toContain("Author/committer account unavailable");
  });

  it("groups unresolved commit author/committer identities sharing an email into one finding", async () => {
    const f = setup();
    const email = "contributor@example.com";
    f.github.rest.pulls.get.mockResolvedValue({ data: { ...pr, commits: 2 } });
    f.listCommits.mockResolvedValue({
      data: [
        {
          sha: "1".repeat(40),
          author: null,
          committer: null,
          commit: { author: { email }, committer: { email } },
        },
        {
          sha: "2".repeat(40),
          author: null,
          committer: null,
          commit: { author: { email }, committer: { email } },
        },
      ],
    });
    await f.run();
    const [call] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    const escapedEmail = "contributor&#64;example.com";
    expect(call.body.match(new RegExp(escapedEmail, "g"))).toHaveLength(1);
    expect(call.body).toContain("Affects 2 commits");
    expect(call.body).toContain("111111111111, 222222222222");
  });

  it("keeps commits with different unresolved emails as separate findings", async () => {
    const f = setup();
    f.github.rest.pulls.get.mockResolvedValue({ data: { ...pr, commits: 2 } });
    f.listCommits.mockResolvedValue({
      data: [
        {
          sha: "1".repeat(40),
          author: null,
          committer: null,
          commit: { author: { email: "one@example.com" }, committer: { email: "one@example.com" } },
        },
        {
          sha: "2".repeat(40),
          author: null,
          committer: null,
          commit: { author: { email: "two@example.com" }, committer: { email: "two@example.com" } },
        },
      ],
    });
    await f.run();
    const [call] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(call.body).toContain("one&#64;example.com");
    expect(call.body).toContain("two&#64;example.com");
    expect(call.body).toContain("Affects 1 commit:");
  });

  it.each([null, {}])(
    "reports an unavailable approving reviewer as incomplete: %j",
    async (user) => {
      const f = setup();
      f.listReviews.mockResolvedValue({ data: [{ id: 20, state: "APPROVED", user }] });
      await f.run();
      expect(f.createCheck).toHaveBeenCalledWith(
        expect.objectContaining({ conclusion: "neutral" }),
      );
      const [comment] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
      expect(comment.body).toContain("| 🟡 **Review 20** |");
      expect(comment.body).toContain("Reviewer account unavailable.");
    },
  );

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
    f.permission.mockImplementation(({ username }: { username: string }) =>
      Promise.resolve({ data: { permission: username === author.login ? "read" : "write" } }),
    );
    await f.run();
    expect(f.permission).toHaveBeenCalledTimes(2);
    expect(f.membership).toHaveBeenCalledTimes(2);
    const [comment] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(comment.body).toContain("<summary>Contributors with verified access (1)</summary>");
    expect(comment.body).not.toContain("example[bot]");
    expect(comment.body).not.toContain("web-flow");
  });

  it("publishes incomplete evidence and fails the run on a transient GitHub failure", async () => {
    const f = setup();
    f.listCommits.mockRejectedValue(createMockRequestError(503));
    await expect(f.run()).rejects.toThrow("503");
    expect(f.createCheck).toHaveBeenCalledWith(expect.objectContaining({ conclusion: "neutral" }));
    expect(f.core.error).toHaveBeenCalledOnce();
  });

  it("does not claim unchecked contributors passed when evaluation fails partway through", async () => {
    const f = setup();
    f.permission.mockImplementation(({ username }: { username: string }) =>
      username === reviewer.login
        ? Promise.reject(createMockRequestError(503))
        : Promise.resolve({ data: { permission: "write" } }),
    );
    await expect(f.run()).rejects.toThrow("503");
    const [comment] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(comment.body).toContain("Could not complete checks");
    expect(comment.body).not.toContain("<details>");
  });

  it("does not turn a public membership API failure into a missing-membership finding", async () => {
    const f = setup();
    f.membership.mockRejectedValue(createMockRequestError(503));
    await expect(f.run()).rejects.toThrow("503");
    const [comment] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(comment.body).toContain("Could not complete checks");
    expect(comment.body).not.toContain("membership not public");
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

  it("allows a write-access maintainer who is not a participant to refresh", async () => {
    const f = setup();
    f.context.eventName = "issue_comment";
    f.context.payload = {
      issue: { number: 1 },
      comment: { id: 1, body: "/azsdk check-access" },
      sender: { id: 55, login: "maintainer", type: "User" },
    };
    await f.run();
    expect(f.permission).toHaveBeenCalledWith({
      owner: "Azure",
      repo: "example",
      username: "maintainer",
    });
    expect(f.createCheck).toHaveBeenCalledOnce();
  });

  it("preserves unknown author coverage when a reviewer requests a refresh", async () => {
    const f = setup();
    f.github.rest.pulls.get.mockResolvedValue({ data: { ...pr, user: null } });
    f.context.eventName = "issue_comment";
    f.context.payload = {
      issue: { number: 1 },
      comment: { id: 1, body: "/azsdk check-access" },
      sender: reviewer,
    };
    await f.run();
    expect(f.createCheck).toHaveBeenCalledWith(expect.objectContaining({ conclusion: "neutral" }));
    const [comment] = f.github.rest.issues.createComment.mock.calls[0] as [{ body: string }];
    expect(comment.body).toContain("| 🟡 **PR author** |");
  });

  it("rejects a refresh payload for a different PR before collecting or publishing", async () => {
    const f = setup();
    f.context.eventName = "issue_comment";
    f.context.payload = {
      issue: { number: 2 },
      comment: { id: 1, body: "/azsdk check-access" },
      sender: reviewer,
    };
    await expect(f.run()).rejects.toThrow("Unexpected contributor readiness command");
    expect(f.listCommits).not.toHaveBeenCalled();
    expect(f.createCheck).not.toHaveBeenCalled();
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
    const findings: ReadinessFinding[] = Array.from({ length: 200 }, (_, index) => ({
      subject: `@org/team | <script> ${index}`,
      message: "Unresolved",
    }));
    const body = renderReadiness([], findings);
    expect(body).not.toContain("@org/team");
    expect(body).not.toContain("<script>");
    expect(body).toContain("100 more entries not shown.");
  });

  it("combines duplicate and mixed-severity findings without losing unknown evidence", () => {
    const body = renderReadiness(
      [{ ...reviewer, roles: new Set(["approved reviewer"]) }],
      [
        { subject: reviewer.login, message: "Azure membership not public.", organization: "Azure" },
        { subject: reviewer.login, message: "Azure membership not public.", organization: "Azure" },
        { subject: reviewer.login, message: "Could not verify repository access.", unknown: true },
      ],
    );
    expect(body.split("\n").filter((line) => line.startsWith("| 🔴"))).toHaveLength(1);
    expect(
      body.match(/\[Azure\]\(https:\/\/github.com\/orgs\/Azure\/people\?query=reviewer-example\)/g),
    ).toHaveLength(1);
    expect(body).toContain("Could not verify repository access.");
  });

  it("deduplicates PR impacts across a user's findings", () => {
    const body = renderReadiness(
      [{ ...author, roles: new Set(["PR author", "approved reviewer"]) }],
      [
        { subject: author.login, message: "No repository write access.", impacts: [authorImpact] },
        {
          subject: author.login,
          message: "No repository write access.",
          impacts: [authorImpact, reviewerImpact],
        },
        { subject: author.login, message: "Could not verify Azure membership.", unknown: true },
      ],
    );
    const rows = body.split("\n").filter((line) => line.startsWith("| 🔴"));
    expect(rows).toHaveLength(1);
    expect(rows[0]).toContain(`${authorImpact}<br>${reviewerImpact}`);
    expect(body.split(authorImpact)).toHaveLength(2);
    expect(body).toContain("Could not verify Azure membership.");
  });

  it("escapes untrusted PR impacts without adding cells or mentions", () => {
    const body = renderReadiness(
      [],
      [
        {
          subject: "Unresolved",
          message: "No repository write access.",
          impacts: ["@org/team | <script>\n[approval](https://example.com) `unknown`"],
        },
      ],
    );
    expect(body).toContain("&#64;org/team &#124; &lt;script&gt;");
    expect(body).toContain("\\[approval\\]\\(https://example.com\\) &#96;unknown&#96;");
    expect(body).not.toContain("@org/team");
    expect(body).not.toContain("<script>");
    expect(
      body
        .split("\n")
        .find((line) => line.startsWith("| 🔴"))
        ?.split("|"),
    ).toHaveLength(5);
  });

  it("renders the clean report consistently", () => {
    const verified = { ...author, roles: new Set(["PR author", "committer"]) };
    expect(renderReadiness([verified], [], [verified])).toMatchSnapshot();
  });

  it("renders concise, red-marked user findings", () => {
    const verified = {
      id: 3,
      login: "verified-example",
      type: "User",
      roles: new Set(["committer"]),
    };
    expect(
      renderReadiness(
        [
          { ...author, roles: new Set(["PR author"]) },
          { ...reviewer, roles: new Set(["approved reviewer"]) },
          verified,
        ],
        [
          { subject: author.login, message: "Azure membership not public.", organization: "Azure" },
          {
            subject: author.login,
            message: "No repository write access.",
            impacts: [authorImpact],
          },
          {
            subject: reviewer.login,
            message: "No repository write access.",
            impacts: [
              "Reviewer approval does not count toward required reviews (GitHub's green approval check). This reviewer must set up or renew their access.",
            ],
          },
        ],
        [verified],
      ),
    ).toMatchSnapshot();
  });

  it("escapes and bounds the verified-contributors section", () => {
    const verified = Array.from({ length: 200 }, (_, index) => ({
      id: index,
      login: `verified-${index}`,
      type: "User",
      roles: new Set(["commit | author", "@org/team <script>"]),
    }));
    const body = renderReadiness(
      verified,
      [{ subject: "Commit coverage", message: "Incomplete commit coverage.", unknown: true }],
      verified,
    );
    const details = body.split("<details>")[1];
    expect(details).toContain("<summary>Contributors with verified access (200)</summary>");
    expect(details.split("\n").filter((line) => line.startsWith("| [verified-"))).toHaveLength(100);
    expect(details).toContain("100 more verified contributors not shown.");
    expect(details).toContain("commit &#124; author, &#64;org/team &lt;script&gt;");
    expect(details).not.toContain("@org/team");
    expect(details).not.toContain("<script>");
  });

  it("renders incomplete findings without introducing Markdown or mentions", () => {
    expect(
      renderReadiness(
        [],
        [
          {
            subject: "@org/team | <script>",
            message: "Account [unavailable](https://example.com)\n`unknown`",
            unknown: true,
          },
        ],
      ),
    ).toMatchSnapshot();
  });

  it("escapes arbitrary finding content while adding only a known organization link", () => {
    const body = renderReadiness(
      [],
      [
        {
          subject: "Unresolved",
          message: "Azure [user](https://example.com) <script>@org/team</script>",
          organization: "Azure",
        },
      ],
    );
    expect(body).toContain("[Azure](https://github.com/orgs/Azure/people?query=Unresolved)");
    expect(body).toContain("\\[user\\]\\(https://example.com\\)");
    expect(body).not.toContain("<script>");
    expect(body).not.toContain("@org/team");
  });

  it("encodes the organization search query without allowing extra parameters or Markdown", () => {
    const body = renderReadiness(
      [],
      [
        {
          subject: "user &role=admin#')",
          message: "Azure membership not public.",
          organization: "Azure",
        },
      ],
    );
    expect(body).toContain(
      "[Azure](https://github.com/orgs/Azure/people?query=user+%26role%3Dadmin%23%27%29)",
    );
  });
});

describe("readiness trigger resolution", () => {
  it.each(["pull_request_target", "pull_request"])(
    "rejects a direct %s publisher trigger",
    async (event) => {
      const f = setup();
      f.context.eventName = event;
      f.context.payload = { pull_request: { number: 1 } };
      await expect(resolveReadinessPullRequest(f.args)).rejects.toThrow(
        "Unsupported readiness trigger",
      );
    },
  );

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

  it("resolves a manual PR refresh without requiring a notifier run", async () => {
    const f = setup();
    f.context.eventName = "issue_comment";
    f.context.payload = {
      issue: { number: 1, pull_request: {} },
      comment: { id: 1, body: "/azsdk check-access" },
      sender: reviewer,
    };
    expect(await resolveReadinessPullRequest(f.args)).toBe(1);
    expect(f.getRun).not.toHaveBeenCalled();
  });

  it.each(["pull_request", "pull_request_review"])(
    "resolves %s notifications using server metadata instead of untrusted artifacts",
    async (event) => {
      const f = setup();
      f.getRun.mockResolvedValue({
        data: {
          repository: { id: 100 },
          event,
          path: notifierPath,
          head_sha: pr.head.sha,
          pull_requests: [{ number: 1, base: { repo: { id: 100 } } }],
        },
      });
      expect(await resolveReadinessPullRequest(f.args)).toBe(1);
      expect(f.getRun).toHaveBeenCalledWith({ owner: "Azure", repo: "example", run_id: 123 });
      expect(f.github.rest.actions.listWorkflowRunArtifacts).not.toHaveBeenCalled();
    },
  );

  it.each(["pull_request", "pull_request_review"])(
    "resolves fork %s notifications by bare SHA and publishes readiness",
    async (event) => {
      const f = setup();
      f.context.eventName = "workflow_run";
      f.context.payload = { workflow_run: { id: 123 }, repository };
      f.getRun.mockResolvedValue({
        data: {
          repository: { id: 100 },
          event,
          path: notifierPath,
          head_sha: pr.head.sha,
          pull_requests: [],
        },
      });
      f.github.rest.search.issuesAndPullRequests.mockResolvedValue({
        data: { total_count: 1, incomplete_results: false, items: [{ number: 1 }] },
      });
      const number = await resolveReadinessPullRequest(f.args);
      if (number === null) throw new Error("Expected a resolved fork PR");
      expect(number).toBe(1);
      expect(f.github.rest.search.issuesAndPullRequests).toHaveBeenCalledWith({
        q: `repo:Azure/example is:pr is:open ${pr.head.sha}`,
        per_page: 100,
        advanced_search: "true",
      });
      f.permission.mockResolvedValue({ data: { permission: "read" } });
      await checkContributorReadiness(f.args, number);
      expect(f.createCheck).toHaveBeenCalledWith(
        expect.objectContaining({ head_sha: pr.head.sha, conclusion: "neutral" }),
      );
      expect(f.github.rest.issues.createComment).toHaveBeenCalledWith(
        expect.objectContaining({ issue_number: number }),
      );
    },
  );

  it.each([
    {
      repository: { id: 100 },
      event: "push",
      path: notifierPath,
    },
    {
      repository: { id: 100 },
      event: "pull_request_target",
      path: notifierPath,
    },
    { repository: { id: 100 }, event: "pull_request", path: ".github/workflows/other.yaml" },
    {
      repository: { id: 100 },
      event: "pull_request",
      path: ".github/workflows/contributor-readiness-review.yaml",
    },
    {
      repository: { id: 100 },
      event: "pull_request",
      path: ".github/workflows/contributor-readiness-events.yaml",
    },
    {
      repository: { id: 200 },
      event: "pull_request_review",
      path: notifierPath,
    },
  ])("rejects unexpected notification provenance: %j", async (run) => {
    const f = setup();
    f.context.eventName = "workflow_run";
    f.context.payload = { workflow_run: { id: 123 }, repository };
    f.getRun.mockResolvedValue({ data: run });
    await expect(resolveReadinessPullRequest(f.args)).rejects.toThrow("Unexpected");
  });

  it("rejects an incomplete fork lookup instead of selecting the first match", async () => {
    const f = setup();
    f.getRun.mockResolvedValue({
      data: {
        repository: { id: 100 },
        event: "pull_request",
        path: notifierPath,
        head_sha: pr.head.sha,
        pull_requests: [],
      },
    });
    f.github.rest.search.issuesAndPullRequests.mockResolvedValue({
      data: { total_count: 2, incomplete_results: true, items: [{ number: 1 }] },
    });
    await expect(resolveReadinessPullRequest(f.args)).rejects.toThrow("Incomplete PR lookup");
    expect(f.github.rest.pulls.get).not.toHaveBeenCalled();
  });

  it("does not publish a fork lookup result belonging to another base repository", async () => {
    const f = setup();
    f.getRun.mockResolvedValue({
      data: {
        repository: { id: 100 },
        event: "pull_request",
        path: notifierPath,
        head_sha: pr.head.sha,
        pull_requests: [],
      },
    });
    f.github.rest.search.issuesAndPullRequests.mockResolvedValue({
      data: { total_count: 1, incomplete_results: false, items: [{ number: 1 }] },
    });
    f.github.rest.pulls.get.mockResolvedValue({ data: { ...pr, base: { repo: { id: 200 } } } });
    expect(await resolveReadinessPullRequest(f.args)).toBeNull();
    expect(f.createCheck).not.toHaveBeenCalled();
  });

  it("rejects ambiguous PR associations rather than reporting on an arbitrary PR", async () => {
    const f = setup();
    f.context.eventName = "workflow_run";
    f.context.payload = { workflow_run: { id: 123 }, repository };
    f.getRun.mockResolvedValue({
      data: {
        repository: { id: 100 },
        event: "pull_request_review",
        path: notifierPath,
        pull_requests: [1, 2].map((number) => ({ number, base: { repo: { id: 100 } } })),
      },
    });
    await expect(resolveReadinessPullRequest(f.args)).rejects.toThrow("multiple PRs");
  });
});
