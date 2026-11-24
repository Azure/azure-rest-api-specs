import { beforeEach, describe, expect, it, vi } from "vitest";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

vi.mock("../../src/package-name-approval/validate-approval.ts", () => ({
  validateLabelChange: vi.fn(),
}));
vi.mock("../../src/package-name-approval/status-check.ts", () => ({
  setPackageNameStatus: vi.fn(),
}));

import handlePackageNamePrEvent, {
  selectReopenReplays,
  type IssueEvent,
} from "../../src/package-name-approval/handle-pr-event.ts";
import { setPackageNameStatus } from "../../src/package-name-approval/status-check.ts";
import { validateLabelChange } from "../../src/package-name-approval/validate-approval.ts";

const RUN_AT = "2026-11-24T12:00:00Z";
const at = (minutesBefore: number) =>
  new Date(Date.parse(RUN_AT) - minutesBefore * 60_000).toISOString();
const ev = (event: string, label: string | undefined, login: string, minutesBefore = 1) =>
  ({
    event,
    created_at: at(minutesBefore),
    ...(label ? { label: { name: label } } : {}),
    actor: { login },
  }) as IssueEvent;

describe("selectReopenReplays", () => {
  it("replays the latest change per package-name label since the last close", () => {
    const events = [
      ev("labeled", "package-name-java-approved", "early"),
      ev("closed", undefined, "x"),
      ev("unlabeled", "package-name-java-pending", "eve"),
      ev("labeled", "package-name-python-approved", "amy"),
      ev("unlabeled", "package-name-python-approved", "amy"),
      ev("labeled", "unrelated", "bob"),
      ev("reopened", undefined, "x"),
    ];
    expect(selectReopenReplays(events, 6).map((e) => [e.event, e.label.name])).toEqual([
      ["unlabeled", "package-name-java-pending"],
      ["unlabeled", "package-name-python-approved"],
    ]);
  });

  it("replays removals before approvals so restored pending labels block approval", () => {
    const events = [
      ev("closed", undefined, "x"),
      ev("labeled", "package-name-java-approved", "approver"),
      ev("unlabeled", "package-name-python-pending", "mallory"),
      ev("reopened", undefined, "x"),
    ];
    expect(selectReopenReplays(events, 3).map((e) => [e.event, e.label.name])).toEqual([
      ["unlabeled", "package-name-python-pending"],
      ["labeled", "package-name-java-approved"],
    ]);
  });

  it("skips changes superseded after the reopen", () => {
    const events = [
      ev("closed", undefined, "x"),
      ev("unlabeled", "package-name-java-pending", "eve"),
      ev("reopened", undefined, "x"),
      ev("labeled", "package-name-java-pending", "bot"),
    ];
    expect(selectReopenReplays(events, 2)).toEqual([]);
  });
});

describe("handlePackageNamePrEvent", () => {
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
        created_at: RUN_AT,
        repository: { id: 1 },
        head_repository: { id: 2 },
        triggering_actor: { login: "alice" },
        ...overrides,
      },
    };
  }

  function prLabels(labels: string[], state = "open") {
    github.rest.pulls.get.mockResolvedValue({
      data: {
        state,
        head: { sha: "a".repeat(40), repo: { id: 2 } },
        base: { repo: { id: 1 } },
        labels: labels.map((name) => ({ name })),
      },
    });
  }

  beforeEach(() => {
    vi.clearAllMocks();
    github = createMockGithub();
    context = createMockContext();
    prLabels(["package-name-java-approved", "data-plane"]);
  });

  it("validates a confirmed label change with the actor from the issue events", async () => {
    intake("PR #5 labeled package-name-java-approved");
    github.rest.issues.listEvents.mockResolvedValue({
      data: [ev("labeled", "package-name-java-approved", "alice")],
    });

    await handlePackageNamePrEvent({ github, context, core });

    expect(validateLabelChange).toHaveBeenCalledWith(
      expect.objectContaining({
        change: {
          owner: "owner",
          repo: "repo",
          prNumber: 5,
          action: "labeled",
          targetLabel: "package-name-java-approved",
          actor: "alice",
          labels: ["package-name-java-approved", "data-plane"],
        },
      }),
    );
    expect(setPackageNameStatus).toHaveBeenCalledWith(expect.objectContaining({ prNumber: 5 }));
  });

  it.each([
    ["a different actor", [ev("labeled", "package-name-java-approved", "mallory")]],
    ["a stale event", [ev("labeled", "package-name-java-approved", "alice", 11)]],
    [
      "a superseded event",
      [
        ev("labeled", "package-name-java-approved", "alice"),
        ev("unlabeled", "package-name-java-approved", "alice"),
      ],
    ],
  ])("ignores a forged or replayed hint with %s", async (_name, events) => {
    intake("PR #5 labeled package-name-java-approved");
    github.rest.issues.listEvents.mockResolvedValue({ data: events });

    await handlePackageNamePrEvent({ github, context, core });

    expect(validateLabelChange).not.toHaveBeenCalled();
    expect(setPackageNameStatus).not.toHaveBeenCalled();
  });

  it("ignores a hint that contradicts the current labels", async () => {
    intake("PR #5 labeled package-name-java-approved");
    prLabels([]);
    github.rest.issues.listEvents.mockResolvedValue({
      data: [ev("labeled", "package-name-java-approved", "alice")],
    });

    await handlePackageNamePrEvent({ github, context, core });

    expect(validateLabelChange).not.toHaveBeenCalled();
  });

  it("ignores a PR from a different head repository", async () => {
    intake("PR #5 labeled package-name-java-approved", { head_repository: { id: 99 } });

    await handlePackageNamePrEvent({ github, context, core });

    expect(github.rest.issues.listEvents).not.toHaveBeenCalled();
    expect(validateLabelChange).not.toHaveBeenCalled();
  });

  it("replays label changes made while closed when the PR is reopened", async () => {
    intake("PR #5 reopened");
    github.rest.issues.listEvents.mockResolvedValue({
      data: [
        ev("closed", undefined, "bob", 5),
        ev("unlabeled", "package-name-java-pending", "mallory", 4),
        ev("reopened", undefined, "alice", 1),
      ],
    });

    await handlePackageNamePrEvent({ github, context, core });

    expect(validateLabelChange).toHaveBeenCalledTimes(1);
    expect(validateLabelChange).toHaveBeenCalledWith(
      expect.objectContaining({
        change: expect.objectContaining({
          action: "unlabeled",
          targetLabel: "package-name-java-pending",
          actor: "mallory",
        }),
      }),
    );
  });

  it("ignores a reopened hint without a matching recent reopen", async () => {
    intake("PR #5 reopened");
    github.rest.issues.listEvents.mockResolvedValue({
      data: [ev("closed", undefined, "bob", 30), ev("reopened", undefined, "alice", 20)],
    });

    await handlePackageNamePrEvent({ github, context, core });

    expect(validateLabelChange).not.toHaveBeenCalled();
    expect(setPackageNameStatus).not.toHaveBeenCalled();
  });

  it.each([
    ["PR #5 labeled WaitForARMFeedback", {}],
    ["PR #5 synchronize", {}],
    ["Some PR title", {}],
    ["PR #5 labeled package-name-java-approved", { name: "Other Workflow" }],
    ["PR #5 labeled package-name-java-approved", { conclusion: "skipped" }],
    ["PR #5 labeled package-name-java-approved", { triggering_actor: null }],
  ])("makes no API calls for %s %j", async (title, overrides) => {
    intake(title, overrides);

    await handlePackageNamePrEvent({ github, context, core });

    expect(github.rest.pulls.get).not.toHaveBeenCalled();
    expect(github.rest.issues.listEvents).not.toHaveBeenCalled();
  });
});
