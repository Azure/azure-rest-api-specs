import { describe, expect, it } from "vitest";
import { CommitStatusState } from "../../../shared/src/github.js";
import { ArmAutoSignoffLabel } from "../../src/arm-auto-signoff/arm-auto-signoff-labels.js";
import { getLabelActionImpl } from "../../src/arm-auto-signoff/arm-universal-auto-signoff-status.js";
import { LabelAction } from "../../src/label.js";
import { createMockCore, createMockGithub as createMockGithubBase } from "../mocks.js";

const core = createMockCore();
const owner = "TestOwner";
const repo = "TestRepo";
const issueNumber = 123;
const headSha = "abc123";

const successfulStatuses = [
  { context: "Swagger LintDiff", state: CommitStatusState.SUCCESS, updated_at: "2026-01-01" },
  { context: "Swagger Avocado", state: CommitStatusState.SUCCESS, updated_at: "2026-01-01" },
];

/**
 * @param {Object} [options]
 * @param {string[]} [options.labelNames]
 * @param {{context: string, state: string, updated_at: string}[]} [options.statuses]
 * @param {string} [options.currentHeadSha]
 * @param {"open"|"closed"} [options.pullRequestState]
 */
function createMockGithub({
  labelNames = [],
  statuses = successfulStatuses,
  currentHeadSha = headSha,
  pullRequestState = "open",
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
  github.rest.repos.listCommitStatusesForRef.mockResolvedValue({ data: statuses });

  return github;
}

/** @param {ReturnType<typeof createMockGithub>} github */
function run(github) {
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
  it("adds the pilot label when the universal requirements pass", async () => {
    const github = createMockGithub({ labelNames: ["ARMReview"] });

    await expect(run(github)).resolves.toEqual({
      headSha,
      issueNumber,
      labelActions: {
        [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: LabelAction.Add,
      },
    });
  });

  it("does not emit a redundant add when the pilot label already exists", async () => {
    const github = createMockGithub({
      labelNames: ["ARMReview", ArmAutoSignoffLabel.ArmAutoSignedOffTest],
    });

    const result = await run(github);
    expect(result.labelActions[ArmAutoSignoffLabel.ArmAutoSignedOffTest]).toBe(LabelAction.None);
  });

  it("removes the pilot label when reviewer signoff is required", async () => {
    const github = createMockGithub({
      labelNames: [
        "ARMReview",
        ArmAutoSignoffLabel.ArmReviewerSignoffRequired,
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
    expect(github.rest.repos.listCommitStatusesForRef).not.toHaveBeenCalled();
  });
});
