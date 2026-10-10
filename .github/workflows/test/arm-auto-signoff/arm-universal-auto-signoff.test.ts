import { readFile } from "node:fs/promises";
import { join } from "node:path";
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
const GITHUB_ROOT = join(import.meta.dirname, "..", "..", "..");

const semanticPassed = {
  context: "ARM Semantic Review",
  state: CommitStatusState.SUCCESS,
  description: "Passed: full review completed with no Blocking findings",
  updated_at: "2026-01-01",
};
const deterministicStatuses = [
  { context: "Swagger LintDiff", state: CommitStatusState.SUCCESS, updated_at: "2026-01-01" },
  { context: "Swagger Avocado", state: CommitStatusState.SUCCESS, updated_at: "2026-01-01" },
];
const successfulStatuses = [semanticPassed, ...deterministicStatuses];

function createMockGithub({
  labelNames = [],
  statuses = successfulStatuses,
  currentHeadSha = headSha,
  pullRequestState = "open",
}: {
  labelNames?: string[];
  statuses?: { context: string; state: string; description?: string; updated_at: string }[];
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
  github.rest.repos.listCommitStatusesForRef.mockResolvedValue({ data: statuses });
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
  it("logs a no-op when an indirect trigger has no PR correlation", async () => {
    const loggingCore = createMockCore();
    const github = createMockGithub();

    const result = await getLabelActionImpl({
      owner,
      repo,
      head_sha: "",
      issue_number: Number.NaN,
      github,
      core: loggingCore,
    });

    expect(result).toEqual({
      headSha: "",
      issueNumber: Number.NaN,
      labelActions: {
        [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: LabelAction.None,
        [ArmAutoSignoffLabel.ArmManualSignoffRequired]: LabelAction.None,
      },
    });
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
    expect(loggingCore.info).toHaveBeenCalledWith(
      "Universal auto-signoff no-op: missing correlation " +
        "(issueNumber=missing, headSha=missing)",
    );
  });

  it("adds the pilot label when all universal requirements pass", async () => {
    const github = createMockGithub({ labelNames: ["ARMReview"] });

    await expect(run(github)).resolves.toEqual({
      headSha,
      issueNumber,
      labelActions: {
        [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: LabelAction.Add,
        [ArmAutoSignoffLabel.ArmManualSignoffRequired]: LabelAction.None,
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

  it.each([
    { name: "ARMReview is missing", labelNames: [] as string[] },
    { name: "NotReadyForARMReview is present", labelNames: ["ARMReview", "NotReadyForARMReview"] },
  ])("does not read statuses and removes the pilot label when $name", async ({ labelNames }) => {
    const github = createMockGithub({
      labelNames: [...labelNames, ArmAutoSignoffLabel.ArmAutoSignedOffTest],
    });

    const result = await run(github);
    expect(result.labelActions).toEqual({
      [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: LabelAction.Remove,
      [ArmAutoSignoffLabel.ArmManualSignoffRequired]: LabelAction.None,
    });
    expect(github.rest.repos.listCommitStatusesForRef).not.toHaveBeenCalled();
  });

  it("takes no action when the PR is not ready and has no pilot label", async () => {
    const github = createMockGithub({ labelNames: [] });

    const result = await run(github);
    expect(result.labelActions).toEqual({
      [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: LabelAction.None,
      [ArmAutoSignoffLabel.ArmManualSignoffRequired]: LabelAction.None,
    });
  });
  it("treats a manual signoff label as a hard stop without removing it", async () => {
    const github = createMockGithub({
      labelNames: [
        "ARMReview",
        ArmAutoSignoffLabel.ArmManualSignoffRequired,
        ArmAutoSignoffLabel.ArmAutoSignedOffTest,
      ],
    });

    const result = await run(github);
    expect(result.labelActions).toEqual({
      [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: LabelAction.Remove,
      [ArmAutoSignoffLabel.ArmManualSignoffRequired]: LabelAction.None,
    });
  });

  describe("auto-signoff workflow correlation", () => {
    it("re-evaluates after the ARM API Reviewer publishes its status", async () => {
      const workflow = await readFile(
        join(GITHUB_ROOT, "workflows", "arm-universal-auto-signoff.yaml"),
        "utf8",
      );

      expect(workflow).toContain('"ARM API Review: Automated Workflow"');
      expect(workflow).not.toContain("ARM Semantic Review - Set Status");
    });

    it("always publishes live-head correlation artifacts", async () => {
      const workflow = await readFile(
        join(GITHUB_ROOT, "workflows", "arm-universal-auto-signoff.yaml"),
        "utf8",
      );
      const headArtifact = workflow.indexOf("name: Upload artifact with head SHA");
      const issueArtifact = workflow.indexOf("name: Upload artifact with issue number");

      expect(headArtifact).toBeGreaterThan(-1);
      expect(issueArtifact).toBeGreaterThan(headArtifact);
      expect(workflow.slice(headArtifact - 180, headArtifact)).not.toContain(
        "github.event_name ==",
      );
      expect(workflow.slice(issueArtifact - 180, issueArtifact)).not.toContain(
        "github.event_name ==",
      );
    });
  });

  it("does not sign off while ARMChangesRequested is present", async () => {
    const github = createMockGithub({
      labelNames: ["ARMReview", "ARMChangesRequested", ArmAutoSignoffLabel.ArmAutoSignedOffTest],
    });

    const result = await run(github);
    expect(result.labelActions).toEqual({
      [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: LabelAction.Remove,
      [ArmAutoSignoffLabel.ArmManualSignoffRequired]: LabelAction.None,
    });
  });

  it.each([
    {
      name: "missing",
      status: undefined,
    },
    {
      name: "pending",
      status: {
        context: "ARM Semantic Review",
        state: CommitStatusState.PENDING,
        description: "ARM API semantic review is pending",
        updated_at: "2026-01-01",
      },
    },
    {
      name: "changes requested",
      status: {
        context: "ARM Semantic Review",
        state: CommitStatusState.FAILURE,
        description: "Changes requested: 1 Blocking finding(s)",
        updated_at: "2026-01-01",
      },
    },
  ])(
    "does not sign off or require manual signoff when semantic review is $name",
    async ({ status }) => {
      const github = createMockGithub({
        labelNames: ["ARMReview"],
        statuses: status ? [status, ...deterministicStatuses] : deterministicStatuses,
      });

      const result = await run(github);
      expect(result.labelActions).toEqual({
        [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: LabelAction.None,
        [ArmAutoSignoffLabel.ArmManualSignoffRequired]: LabelAction.None,
      });
    },
  );

  it("does not add manual signoff when semantic review is incomplete", async () => {
    const github = createMockGithub({
      labelNames: ["ARMReview"],
      statuses: [
        {
          context: "ARM Semantic Review",
          state: CommitStatusState.ERROR,
          description: "Review incomplete: workflow concluded with failure",
          updated_at: "2026-01-01",
        },
        ...deterministicStatuses,
      ],
    });

    const result = await run(github);
    expect(result.labelActions).toEqual({
      [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: LabelAction.None,
      [ArmAutoSignoffLabel.ArmManualSignoffRequired]: LabelAction.None,
    });
  });

  it("logs why an existing manual signoff label produces no new action", async () => {
    const loggingCore = createMockCore();
    const github = createMockGithub({
      labelNames: ["ARMReview", ArmAutoSignoffLabel.ArmManualSignoffRequired],
      statuses: [
        {
          context: "ARM Semantic Review",
          state: CommitStatusState.ERROR,
          description: "Manual review required: PR exceeds automated review size limits",
          updated_at: "2026-01-01",
        },
        ...deterministicStatuses,
      ],
    });

    const result = await getLabelActionImpl({
      owner,
      repo,
      head_sha: headSha,
      issue_number: issueNumber,
      github,
      core: loggingCore,
    });

    expect(result.labelActions).toEqual({
      [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: LabelAction.None,
      [ArmAutoSignoffLabel.ArmManualSignoffRequired]: LabelAction.None,
    });
    expect(loggingCore.info).toHaveBeenCalledWith(
      expect.stringContaining('"isReadyForArmReview":true'),
    );
    expect(loggingCore.info).toHaveBeenCalledWith(
      expect.stringContaining(
        '"description":"Manual review required: PR exceeds automated review size limits"',
      ),
    );
    expect(loggingCore.info).toHaveBeenCalledWith(
      "ARM semantic review requires manual signoff; ARMManualSignoffRequired is already present",
    );
    expect(loggingCore.info).toHaveBeenCalledWith(
      'Universal auto-signoff label actions: {"ARMAutoSignedOff-Test":"none","ARMManualSignoffRequired":"none"}',
    );
  });

  it("adds manual signoff when automated coverage was scoped", async () => {
    const github = createMockGithub({
      labelNames: ["ARMReview"],
      statuses: [
        {
          context: "ARM Semantic Review",
          state: CommitStatusState.ERROR,
          description: "Manual review required: automated review was scoped",
          updated_at: "2026-01-01",
        },
        ...deterministicStatuses,
      ],
    });

    const result = await run(github);
    expect(result.labelActions).toEqual({
      [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: LabelAction.None,
      [ArmAutoSignoffLabel.ArmManualSignoffRequired]: LabelAction.Add,
    });
  });

  it("adds manual signoff for scoped coverage even when changes were requested", async () => {
    const github = createMockGithub({
      labelNames: ["ARMReview", "ARMChangesRequested"],
      statuses: [
        {
          context: "ARM Semantic Review",
          state: CommitStatusState.ERROR,
          description: "Manual review required: automated review was scoped",
          updated_at: "2026-01-01",
        },
        ...deterministicStatuses,
      ],
    });

    const result = await run(github);
    expect(result.labelActions[ArmAutoSignoffLabel.ArmManualSignoffRequired]).toBe(LabelAction.Add);
  });

  it("removes the pilot label while a deterministic status is pending", async () => {
    const github = createMockGithub({
      labelNames: ["ARMReview", ArmAutoSignoffLabel.ArmAutoSignedOffTest],
      statuses: [
        semanticPassed,
        { context: "Swagger LintDiff", state: CommitStatusState.SUCCESS, updated_at: "2026-01-01" },
        { context: "Swagger Avocado", state: CommitStatusState.PENDING, updated_at: "2026-01-01" },
      ],
    });

    const result = await run(github);
    expect(result.labelActions[ArmAutoSignoffLabel.ArmAutoSignedOffTest]).toBe(LabelAction.Remove);
  });

  it("removes the pilot label when suppression approval is missing", async () => {
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
