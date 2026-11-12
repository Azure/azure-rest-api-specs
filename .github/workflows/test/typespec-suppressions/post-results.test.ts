import { beforeEach, describe, expect, it, vi } from "vitest";
import type { GitHub } from "../../src/github.ts";
import type { WorkflowRunInfo } from "../../src/typespec-suppressions/suppressions-comment.ts";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

vi.mock("../../src/context.ts", () => ({
  extractInputs: vi.fn(),
}));

vi.mock("../../src/typespec-suppressions/suppressions-comment.ts", async (importOriginal) => ({
  ...(await importOriginal<
    typeof import("../../src/typespec-suppressions/suppressions-comment.ts")
  >()),
  buildSuppressionsComment: vi.fn(),
}));

const { extractInputs } = await import("../../src/context.ts");
const { buildSuppressionsComment } =
  await import("../../src/typespec-suppressions/suppressions-comment.ts");
const { default: postSuppressionsResults } =
  await import("../../src/typespec-suppressions/post-results.ts");

describe("post-results", () => {
  const core = createMockCore();
  const context = createMockContext();
  const identifier = "<!-- TypeSpecSuppressionsReview -->";
  const approvedLabel = "typespec-suppressions-approved";
  const reviewLabel = "typespec-suppressions-review-required";
  const suppression = {
    specPath: "specification/demo",
    sourceKind: "inline" as const,
    ruleName: "rule-one",
    justification: "Legacy contract",
    sourceFile: "specification/demo/main.tsp",
    anchorPath: "model:Demo/property:sku",
    location: { line: 35, column: 3 },
    rawText: "#suppress",
  };
  const report = { requiresApproval: true, newSuppressions: [suppression] };
  const run = {
    id: 123,
    head_sha: "abc123",
    updated_at: "2026-11-06T00:10:00Z",
  } as WorkflowRunInfo;

  function result(
    overrides: Partial<NonNullable<Awaited<ReturnType<typeof buildSuppressionsComment>>>> = {},
  ) {
    return {
      body: "unused",
      requiresApproval: true,
      report,
      run,
      runUrl: "https://test.com/runs/123",
      ...overrides,
    };
  }

  function githubWithLabels(labels: string[] = []) {
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({
      data: { state: "open", head: { sha: "abc123" }, labels: labels.map((name) => ({ name })) },
    });
    return github;
  }

  function approvalEvent(id = 100) {
    context.eventName = "pull_request_target";
    context.payload = {
      action: "labeled",
      label: { name: approvedLabel },
      sender: { login: "reviewer", type: "User" },
    };
    return {
      id,
      event: "labeled",
      label: { name: approvedLabel },
      actor: { login: "reviewer" },
      created_at: "2026-11-06T18:32:00Z",
    };
  }

  function postedBody(github: ReturnType<typeof createMockGithub>): string {
    const client: GitHub = github;
    const body =
      vi.mocked(client.rest.issues.updateComment).mock.lastCall?.[0]?.body ??
      vi.mocked(client.rest.issues.createComment).mock.lastCall?.[0]?.body;
    if (typeof body !== "string") {
      throw new Error("Expected a posted suppression review comment.");
    }
    return body;
  }

  async function approve() {
    const github = githubWithLabels([approvedLabel, reviewLabel]);
    github.rest.issues.listEvents.mockResolvedValue({ data: [approvalEvent()] });
    await postSuppressionsResults({ github, context, core });
    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    const body = postedBody(github);
    expect(body).toContain("✅ Approved");
    expect(body).toContain("TypeSpecSuppressionsApproval:v1:");
    github.rest.issues.listComments.mockResolvedValue({
      data: [{ id: 99, body, user: { login: "github-actions[bot]", type: "Bot" } }],
    });
    github.rest.issues.createComment.mockClear();
    github.rest.issues.updateComment.mockClear();
    github.rest.issues.listEvents.mockClear();
    context.eventName = "workflow_run";
    context.payload = {};
    return github;
  }

  beforeEach(() => {
    vi.clearAllMocks();
    context.eventName = "workflow_run";
    context.payload = {};
    vi.mocked(extractInputs).mockResolvedValue({
      owner: "test-owner",
      repo: "test-repo",
      issue_number: 42,
      head_sha: "abc123",
      run_id: 123,
    });
    vi.mocked(buildSuppressionsComment).mockResolvedValue(result());
  });

  it("records the approved content and preserves it when the same run is rerun", async () => {
    const github = await approve();
    vi.mocked(buildSuppressionsComment).mockResolvedValue(
      result({ run: { ...run, run_attempt: 2, updated_at: "2026-11-09T04:22:00Z" } }),
    );

    await postSuppressionsResults({ github, context, core });

    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    expect(github.rest.issues.updateComment).not.toHaveBeenCalled();
    expect(github.rest.actions.listWorkflowRunsForRepo).not.toHaveBeenCalled();
    expect(github.rest.issues.listEvents).not.toHaveBeenCalled();
  });

  it("preserves approval across unrelated commits and shifted source locations", async () => {
    const github = await approve();
    vi.mocked(buildSuppressionsComment).mockResolvedValue(
      result({
        run: { ...run, id: 456, head_sha: "def456" },
        report: {
          ...report,
          newSuppressions: [{ ...suppression, location: { line: 100, column: 1 } }],
        },
      }),
    );
    vi.mocked(extractInputs).mockResolvedValue({
      owner: "test-owner",
      repo: "test-repo",
      issue_number: 42,
      head_sha: "def456",
      run_id: 456,
    });
    github.rest.pulls.get.mockResolvedValue({
      data: { state: "open", head: { sha: "def456" }, labels: [{ name: approvedLabel }] },
    });

    await postSuppressionsResults({ github, context, core });

    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    expect(postedBody(github)).toContain("✅ Approved");
  });

  it.each([
    { justification: "Different reason" },
    { ruleName: "rule-two" },
    { anchorPath: "model:Demo/property:name" },
  ])("requires reapproval when the suppression changes: %j", async (change) => {
    const github = await approve();
    vi.mocked(buildSuppressionsComment).mockResolvedValue(
      result({ report: { ...report, newSuppressions: [{ ...suppression, ...change }] } }),
    );

    await postSuppressionsResults({ github, context, core });

    expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
      expect.objectContaining({ name: approvedLabel }),
    );
    expect(postedBody(github)).toContain("❌ Approval required");
    expect(postedBody(github)).toContain("reapply");
    expect(postedBody(github)).not.toContain("TypeSpecSuppressionsApproval:v1:");
  });

  it("does not rebind approval when an old label workflow is rerun", async () => {
    const github = await approve();
    github.rest.issues.listEvents.mockResolvedValue({ data: [approvalEvent()] });
    vi.mocked(buildSuppressionsComment).mockResolvedValue(
      result({
        report: { ...report, newSuppressions: [{ ...suppression, justification: "Changed" }] },
      }),
    );

    await postSuppressionsResults({ github, context, core });

    expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
      expect.objectContaining({ name: approvedLabel }),
    );
  });

  it("allows explicit reapproval of changed suppression content", async () => {
    const github = await approve();
    github.rest.issues.listEvents.mockResolvedValue({ data: [approvalEvent(101)] });
    vi.mocked(buildSuppressionsComment).mockResolvedValue(
      result({
        report: { ...report, newSuppressions: [{ ...suppression, justification: "Changed" }] },
      }),
    );

    await postSuppressionsResults({ github, context, core });

    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    expect(postedBody(github)).toContain("✅ Approved");
    expect(postedBody(github)).toContain(":101 -->");
  });

  it("does not bind a report completed after the approval label was applied", async () => {
    const github = githubWithLabels([approvedLabel]);
    github.rest.issues.listEvents.mockResolvedValue({ data: [approvalEvent()] });
    vi.mocked(buildSuppressionsComment).mockResolvedValue(
      result({ run: { ...run, updated_at: "2026-11-09T04:22:00Z" } }),
    );

    await postSuppressionsResults({ github, context, core });

    expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
      expect.objectContaining({ name: approvedLabel }),
    );
  });

  it.each(["removed", "different-actor", "missing"])(
    "does not capture approval from a stale label event: %s",
    async (scenario) => {
      const github = githubWithLabels([approvedLabel]);
      const event = approvalEvent();
      github.rest.issues.listEvents.mockResolvedValue({
        data:
          scenario === "missing"
            ? []
            : [
                {
                  ...event,
                  event: scenario === "removed" ? "unlabeled" : "labeled",
                  actor: { login: scenario === "different-actor" ? "other-reviewer" : "reviewer" },
                },
              ],
      });

      await postSuppressionsResults({ github, context, core });

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: approvedLabel }),
      );
      expect(postedBody(github)).not.toContain("TypeSpecSuppressionsApproval:v1:");
    },
  );

  it("requires reapproval for a preexisting label without a stored fingerprint", async () => {
    const github = githubWithLabels([approvedLabel]);

    await postSuppressionsResults({ github, context, core });

    expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
      expect.objectContaining({ name: approvedLabel }),
    );
    expect(postedBody(github)).toContain("could not be verified");
  });

  it("does not trust approval metadata in a contributor-authored comment", async () => {
    const github = await approve();
    const client: GitHub = github;
    const previous = await client.rest.issues.listComments({
      owner: "test-owner",
      repo: "test-repo",
      issue_number: 42,
    });
    github.rest.issues.listComments.mockResolvedValue({
      data: [{ ...previous.data[0], user: { login: "contributor", type: "User" } }],
    });

    await postSuppressionsResults({ github, context, core });

    expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
      expect.objectContaining({ name: approvedLabel }),
    );
    expect(github.rest.issues.updateComment).not.toHaveBeenCalled();
    expect(github.rest.issues.createComment).toHaveBeenCalled();
  });

  it("requests reapproval when bot comment metadata is malformed", async () => {
    const github = githubWithLabels([approvedLabel]);
    github.rest.issues.listComments.mockResolvedValue({
      data: [
        {
          id: 99,
          body: `${identifier}\n<!-- TypeSpecSuppressionsApproval:v1:invalid:100 -->`,
          user: { login: "github-actions[bot]", type: "Bot" },
        },
      ],
    });

    await postSuppressionsResults({ github, context, core });

    expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
      expect.objectContaining({ name: approvedLabel }),
    );
    expect(postedBody(github)).toContain("could not be verified");
  });

  it("removes unverifiable approval and explains when the report is unavailable", async () => {
    const github = await approve();
    vi.mocked(buildSuppressionsComment).mockResolvedValue(undefined);

    await postSuppressionsResults({ github, context, core });

    expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
      expect.objectContaining({ name: approvedLabel }),
    );
    expect(postedBody(github)).toContain("Analysis unavailable");
    expect(postedBody(github)).toContain("reapply");
  });

  it("leaves pending reviews untouched when no report is available", async () => {
    const github = githubWithLabels([]);
    vi.mocked(buildSuppressionsComment).mockResolvedValue(undefined);

    await postSuppressionsResults({ github, context, core });

    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(core.warning).toHaveBeenCalled();
  });

  it("clears stored approval when the approval label is removed", async () => {
    const github = await approve();
    github.rest.pulls.get.mockResolvedValue({
      data: { state: "open", head: { sha: "abc123" }, labels: [{ name: reviewLabel }] },
    });
    context.eventName = "pull_request_target";
    context.payload = { action: "unlabeled", label: { name: approvedLabel } };

    await postSuppressionsResults({ github, context, core });

    expect(postedBody(github)).toContain("❌ Approval required");
    expect(postedBody(github)).not.toContain("TypeSpecSuppressionsApproval:v1:");
  });

  it.each(["superseded", "closed"])("ignores %s PR results", async (state) => {
    const github = githubWithLabels([approvedLabel]);
    github.rest.pulls.get.mockResolvedValue({
      data: { state: state === "closed" ? "closed" : "open", head: { sha: "new-head" } },
    });

    await postSuppressionsResults({ github, context, core });

    expect(buildSuppressionsComment).not.toHaveBeenCalled();
    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    expect(github.rest.issues.listComments).not.toHaveBeenCalled();
  });

  it("posts pending suppressions and synchronizes the review-required label", async () => {
    const github = githubWithLabels([]);

    await postSuppressionsResults({ github, context, core });

    expect(postedBody(github)).toContain("❌ Approval required");
    expect(github.rest.issues.addLabels).toHaveBeenCalledWith(
      expect.objectContaining({ labels: [reviewLabel] }),
    );
  });

  it("resolves the comment and removes the review-required label when no suppressions remain", async () => {
    const github = githubWithLabels([reviewLabel]);
    github.rest.issues.listComments.mockResolvedValue({
      data: [{ id: 99, body: identifier, user: { login: "github-actions[bot]", type: "Bot" } }],
    });
    vi.mocked(buildSuppressionsComment).mockResolvedValue(
      result({ requiresApproval: false, report: { requiresApproval: false } }),
    );

    await postSuppressionsResults({ github, context, core });

    expect(postedBody(github)).toContain("No TypeSpec suppressions require review");
    expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
      expect.objectContaining({ name: reviewLabel }),
    );
  });

  it("does not create a comment when there are no suppressions or previous reviews", async () => {
    const github = githubWithLabels([]);
    vi.mocked(buildSuppressionsComment).mockResolvedValue(
      result({ requiresApproval: false, report: { requiresApproval: false } }),
    );

    await postSuppressionsResults({ github, context, core });

    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });
});
