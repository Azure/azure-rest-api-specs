import { describe, expect, it } from "vitest";
import { CommitStatusState } from "../../../shared/src/github.ts";
import { ArmAutoSignoffLabel } from "../../src/arm-auto-signoff/arm-auto-signoff-labels.ts";
import { getLabelActionImpl } from "../../src/arm-auto-signoff/arm-universal-auto-signoff.ts";
import { LabelAction } from "../../src/label.ts";
import { createMockCore, createMockGithub as createMockGithubBase } from "../mocks.ts";

const core = createMockCore();
const owner = "TestOwner";
const repo = "TestRepo";
const issueNumber = 123;
const headSha = "abc123";

const successfulStatuses = [
  { context: "Swagger LintDiff", state: CommitStatusState.SUCCESS, updated_at: "2026-01-01" },
  { context: "Swagger Avocado", state: CommitStatusState.SUCCESS, updated_at: "2026-01-01" },
];

function createMockGithub({
  labelNames = [],
  statuses = successfulStatuses,
  currentHeadSha = headSha,
  pullRequestState = "open",
}: {
  labelNames?: string[];
  statuses?: { context: string; state: string; updated_at: string }[];
  currentHeadSha?: string;
  pullRequestState?: "open" | "closed";
} = {}) {
  const github = createMockGithubBase();
  github.rest.pulls.get.mockResolvedValue({
    data: {
      state: pullRequestState,
      head: { sha: currentHeadSha },
    },
  });
  github.rest.issues.listLabelsOnIssue.mockResolvedValue({
    data: labelNames.map((name) => ({ name })),
  });
  github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
    data: { statuses, total_count: statuses.length },
  });

  return github;
}

function run(github: ReturnType<typeof createMockGithub>) {
  return getLabelActionImpl({
    owner,
    repo,
    head_sha: headSha,
    issue_number: issueNumber,
    github,
    core,
  });
}

describe("getLabelActionImpl", () => {
  it("matches required status contexts regardless of returned casing", async () => {
    const github = createMockGithub({
      labelNames: ["ARMReview"],
      statuses: successfulStatuses.map((status) => ({
        ...status,
        context: status.context.toUpperCase(),
      })),
    });

    const result = await run(github);
    expect(result.labelActions[ArmAutoSignoffLabel.ArmAutoSignedOffTest]).toBe(LabelAction.Add);
  });

  it("ignores failures in unrelated status contexts", async () => {
    const github = createMockGithub({ labelNames: ["ARMReview"] });
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: {
        state: "failure",
        statuses: [...successfulStatuses, { context: "Unrelated", state: "failure" }],
        total_count: 3,
      },
    });

    const result = await run(github);
    expect(result.labelActions[ArmAutoSignoffLabel.ArmAutoSignedOffTest]).toBe(LabelAction.Add);
  });

  it("adds the pilot label when the universal requirements pass", async () => {
    const github = createMockGithub({ labelNames: ["ARMReview"] });

    await expect(run(github)).resolves.toEqual({
      headSha,
      issueNumber,
      labelActions: {
        [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: LabelAction.Add,
      },
    });
    expect(github.rest.repos.getCombinedStatusForRef).toHaveBeenCalledExactlyOnceWith({
      owner,
      repo,
      ref: headSha,
      per_page: 100,
      page: 1,
    });
    expect(github.rest.repos.listCommitStatusesForRef).not.toHaveBeenCalled();
  });

  it("does not emit a redundant add when the pilot label already exists", async () => {
    const github = createMockGithub({
      labelNames: ["ARMReview", ArmAutoSignoffLabel.ArmAutoSignedOffTest],
    });

    const result = await run(github);
    expect(result.labelActions[ArmAutoSignoffLabel.ArmAutoSignedOffTest]).toBe(LabelAction.None);
  });

  it("removes the pilot label when manual signoff is required", async () => {
    const github = createMockGithub({
      labelNames: [
        "ARMReview",
        ArmAutoSignoffLabel.ArmManualSignoffRequired,
        ArmAutoSignoffLabel.ArmAutoSignedOffTest,
      ],
    });

    const result = await run(github);
    expect(result.labelActions[ArmAutoSignoffLabel.ArmAutoSignedOffTest]).toBe(LabelAction.Remove);
  });

  it("removes the pilot label while a mandatory status is pending", async () => {
    const github = createMockGithub({
      labelNames: ["ARMReview", ArmAutoSignoffLabel.ArmAutoSignedOffTest],
      statuses: [
        { context: "Swagger LintDiff", state: CommitStatusState.SUCCESS, updated_at: "2026-01-01" },
        { context: "Swagger Avocado", state: CommitStatusState.PENDING, updated_at: "2026-01-01" },
      ],
    });

    const result = await run(github);
    expect(result.labelActions[ArmAutoSignoffLabel.ArmAutoSignedOffTest]).toBe(LabelAction.Remove);
  });

  it("removes the pilot label when a suppression lacks approval", async () => {
    const github = createMockGithub({
      labelNames: [
        "ARMReview",
        "SuppressionReviewRequired",
        ArmAutoSignoffLabel.ArmAutoSignedOffTest,
      ],
    });

    const result = await run(github);
    expect(result.labelActions[ArmAutoSignoffLabel.ArmAutoSignedOffTest]).toBe(LabelAction.Remove);
  });

  it("ignores a completed workflow for a stale pull request head", async () => {
    const github = createMockGithub({
      labelNames: ["ARMReview", ArmAutoSignoffLabel.ArmAutoSignedOffTest],
      currentHeadSha: "newer-sha",
    });

    const result = await run(github);
    expect(result.labelActions[ArmAutoSignoffLabel.ArmAutoSignedOffTest]).toBe(LabelAction.None);
    expect(github.rest.repos.getCombinedStatusForRef).not.toHaveBeenCalled();
  });
});
