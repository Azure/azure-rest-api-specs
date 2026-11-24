import { beforeEach, describe, expect, it } from "vitest";
import dispatchReviewer, {
  isLatestLabelEvent,
  parseIntakeHint,
  selectReviewerRoute,
  type PullRequestState,
} from "../src/reviewer-dispatch.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

const HEAD = "a".repeat(40);
const openPr = (labels: string[], extra: Partial<PullRequestState> = {}): PullRequestState => ({
  state: "open",
  draft: false,
  headSha: HEAD,
  labels,
  ...extra,
});

describe("parseIntakeHint", () => {
  it.each([
    [
      "PR #42 labeled WaitForARMFeedback",
      { issueNumber: 42, action: "labeled", label: "WaitForARMFeedback" },
    ],
    ["PR #7 synchronize", { issueNumber: 7, action: "synchronize", label: undefined }],
  ])("parses %s", (title, expected) => {
    expect(parseIntakeHint(title)).toEqual(expected);
  });

  it.each([undefined, "", "Update readme", "PR #0 opened", "PR #12 Labeled x", "PR #1"])(
    "rejects %j",
    (title) => {
      expect(parseIntakeHint(title)).toBeUndefined();
    },
  );
});

describe("selectReviewerRoute", () => {
  it("routes WaitForARMFeedback to ARM review with a label-event check", () => {
    expect(
      selectReviewerRoute(
        { issueNumber: 1, action: "labeled", label: "WaitForARMFeedback" },
        openPr(["WaitForARMFeedback"]),
        HEAD,
      ),
    ).toEqual({
      workflow: "arm-api-review.lock.yml",
      inputs: { pr_number: "1" },
      labelEvent: { action: "labeled", label: "WaitForARMFeedback" },
    });
  });

  it("routes ARMChangesRequested removal only when the label is gone", () => {
    const hint = { issueNumber: 1, action: "unlabeled", label: "ARMChangesRequested" };
    expect(selectReviewerRoute(hint, openPr([]), HEAD)?.workflow).toBe("arm-api-review.lock.yml");
    expect(selectReviewerRoute(hint, openPr(["ARMChangesRequested"]), HEAD)).toBeUndefined();
  });

  it("routes data-plane pushes only for the current head", () => {
    const hint = { issueNumber: 3, action: "synchronize" };
    const pr = openPr(["data-plane-review-requested"]);
    expect(selectReviewerRoute(hint, pr, HEAD)).toEqual({
      workflow: "data-plane-api-review.lock.yml",
      inputs: { item_number: "3" },
    });
    expect(selectReviewerRoute(hint, pr, "b".repeat(40))).toBeUndefined();
  });

  it("skips drafts for ARM and data-plane, but not hero scenarios", () => {
    const draft = { draft: true };
    expect(
      selectReviewerRoute(
        { issueNumber: 1, action: "labeled", label: "WaitForARMFeedback" },
        openPr(["WaitForARMFeedback"], draft),
        HEAD,
      ),
    ).toBeUndefined();
    expect(
      selectReviewerRoute(
        { issueNumber: 1, action: "labeled", label: "hero-scenarios-needed" },
        openPr(["hero-scenarios-needed"], draft),
        HEAD,
      )?.workflow,
    ).toBe("hero-scenarios.lock.yml");
  });

  it("ignores hints that contradict current labels and closed PRs", () => {
    expect(
      selectReviewerRoute(
        { issueNumber: 1, action: "labeled", label: "WaitForARMFeedback" },
        openPr([]),
        HEAD,
      ),
    ).toBeUndefined();
    expect(
      selectReviewerRoute(
        { issueNumber: 1, action: "labeled", label: "hero-scenarios-needed" },
        openPr(["hero-scenarios-needed"], { state: "closed" }),
        HEAD,
      ),
    ).toBeUndefined();
  });
});

describe("isLatestLabelEvent", () => {
  const expected = { action: "labeled" as const, label: "WaitForARMFeedback" };
  const ev = (event: string, label: string, login: string) => ({
    event,
    label: { name: label },
    actor: { login },
  });

  it("requires the latest event for the label to match action and actor", () => {
    expect(
      isLatestLabelEvent([ev("labeled", "WaitForARMFeedback", "alice")], expected, "alice"),
    ).toBe(true);
    expect(
      isLatestLabelEvent([ev("labeled", "WaitForARMFeedback", "bob")], expected, "alice"),
    ).toBe(false);
    expect(
      isLatestLabelEvent(
        [
          ev("labeled", "WaitForARMFeedback", "alice"),
          ev("unlabeled", "WaitForARMFeedback", "alice"),
        ],
        expected,
        "alice",
      ),
    ).toBe(false);
    expect(
      isLatestLabelEvent(
        [ev("labeled", "WaitForARMFeedback", "alice"), ev("labeled", "other", "bob")],
        expected,
        "alice",
      ),
    ).toBe(true);
    expect(isLatestLabelEvent([], expected, "alice")).toBe(false);
  });
});

describe("dispatchReviewer", () => {
  const core = createMockCore();
  let github: ReturnType<typeof createMockGithub>;
  let context: ReturnType<typeof createMockContext>;

  function intake(displayTitle: string, overrides: Record<string, unknown> = {}) {
    context.eventName = "workflow_run";
    context.payload = {
      action: "completed",
      workflow_run: {
        name: "Pull Request Event",
        event: "pull_request",
        conclusion: "success",
        display_title: displayTitle,
        head_sha: HEAD,
        repository: { id: 1 },
        head_repository: { id: 2 },
        triggering_actor: { login: "alice" },
        ...overrides,
      },
    };
  }

  beforeEach(() => {
    github = createMockGithub();
    context = createMockContext();
    github.rest.pulls.get.mockResolvedValue({
      data: {
        state: "open",
        draft: false,
        head: { sha: HEAD, repo: { id: 2 } },
        base: { repo: { id: 1, default_branch: "main" } },
        labels: [{ name: "WaitForARMFeedback" }],
      },
    });
    github.rest.repos.getCollaboratorPermissionLevel.mockResolvedValue({
      data: { permission: "write" },
    });
    github.rest.issues.listEvents.mockResolvedValue({
      data: [
        { event: "labeled", label: { name: "WaitForARMFeedback" }, actor: { login: "alice" } },
      ],
    });
  });

  it("dispatches after verifying actor access and the label event", async () => {
    intake("PR #5 labeled WaitForARMFeedback");

    await dispatchReviewer({ github, context, core });

    expect(github.rest.repos.getCollaboratorPermissionLevel).toHaveBeenCalledWith({
      owner: "owner",
      repo: "repo",
      username: "alice",
    });
    expect(github.rest.actions.createWorkflowDispatch).toHaveBeenCalledWith({
      owner: "owner",
      repo: "repo",
      workflow_id: "arm-api-review.lock.yml",
      ref: "main",
      inputs: { pr_number: "5" },
    });
  });

  it("does not dispatch for an actor without write access", async () => {
    intake("PR #5 labeled WaitForARMFeedback");
    github.rest.repos.getCollaboratorPermissionLevel.mockResolvedValue({
      data: { permission: "triage" },
    });

    await dispatchReviewer({ github, context, core });

    expect(github.rest.issues.listEvents).not.toHaveBeenCalled();
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
  });

  it("does not dispatch when a spoofed hint has no matching label event", async () => {
    intake("PR #5 labeled WaitForARMFeedback");
    github.rest.issues.listEvents.mockResolvedValue({
      data: [{ event: "labeled", label: { name: "WaitForARMFeedback" }, actor: { login: "bot" } }],
    });

    await dispatchReviewer({ github, context, core });

    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
  });

  it("does not dispatch for a PR from a different head repository", async () => {
    intake("PR #5 labeled WaitForARMFeedback", { head_repository: { id: 99 } });

    await dispatchReviewer({ github, context, core });

    expect(github.rest.repos.getCollaboratorPermissionLevel).not.toHaveBeenCalled();
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
  });

  it.each([
    { name: "Other Workflow" },
    { event: "pull_request_target" },
    { conclusion: "skipped" },
    { display_title: "Some PR title" },
  ])("makes no API calls for non-intake or unparseable runs: %j", async (overrides) => {
    intake("PR #5 labeled WaitForARMFeedback", overrides);

    await dispatchReviewer({ github, context, core });

    expect(github.rest.pulls.get).not.toHaveBeenCalled();
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
  });
});
