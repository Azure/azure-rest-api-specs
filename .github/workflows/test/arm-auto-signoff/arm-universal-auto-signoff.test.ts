import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { describe, expect, it } from "vitest";
import { CommitStatusState } from "../../../shared/src/github.ts";
import { ArmAutoSignoffLabel } from "../../src/arm-auto-signoff/arm-auto-signoff-labels.ts";
import {
  getLabelActionImpl,
  type ManagedLabelActions,
} from "../../src/arm-auto-signoff/arm-universal-auto-signoff.ts";
import { LabelAction } from "../../src/label.ts";
import { createMockCore, createMockGithub as createMockGithubBase } from "../mocks.ts";

const core = createMockCore();
const owner = "TestOwner";
const repo = "TestRepo";
const issueNumber = 123;
const headSha = "abc123";
const GITHUB_ROOT = join(import.meta.dirname, "..", "..", "..");

const {
  ArmSignedOff,
  ArmAutoSignedOff,
  ArmAutoSignedOffIncrementalTSP,
  ArmAutoSignedOffTrivial,
  ArmManualSignoffRequired,
} = ArmAutoSignoffLabel;

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
const manualReviewStatus = {
  context: "ARM Semantic Review",
  state: CommitStatusState.ERROR,
  description: "Manual review required: automated review was scoped",
  updated_at: "2026-01-01",
};

/** Expected label actions: every label `none` unless overridden. */
function actions(overrides: Partial<ManagedLabelActions> = {}): ManagedLabelActions {
  return {
    [ArmSignedOff]: LabelAction.None,
    [ArmManualSignoffRequired]: LabelAction.None,
    [ArmAutoSignedOff]: LabelAction.None,
    [ArmAutoSignedOffIncrementalTSP]: LabelAction.None,
    [ArmAutoSignedOffTrivial]: LabelAction.None,
    ...overrides,
  };
}

const grant = { [ArmSignedOff]: LabelAction.Add, [ArmAutoSignedOff]: LabelAction.Add };
const revoke = { [ArmSignedOff]: LabelAction.Remove, [ArmAutoSignedOff]: LabelAction.Remove };
const autoSignedOff = [ArmSignedOff, ArmAutoSignedOff];

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
  github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
    data: { statuses, total_count: statuses.length },
  });
  return github;
}

function run(github: ReturnType<typeof createMockGithub>, runCore = core) {
  return getLabelActionImpl({
    owner,
    repo,
    head_sha: headSha,
    issue_number: issueNumber,
    github,
    core: runCore,
  });
}

describe("getLabelActionImpl", () => {
  describe("granting", () => {
    it("adds ARMSignedOff and ARMAutoSignedOff when all requirements pass", async () => {
      const github = createMockGithub({ labelNames: ["ARMReview"] });

      await expect(run(github)).resolves.toEqual({
        headSha,
        issueNumber,
        labelActions: actions(grant),
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

    it("matches required status contexts regardless of returned casing", async () => {
      const github = createMockGithub({
        labelNames: ["ARMReview"],
        statuses: successfulStatuses.map((status) => ({
          ...status,
          context: status.context.toUpperCase(),
        })),
      });

      expect((await run(github)).labelActions).toEqual(actions(grant));
    });

    it("ignores failures in unrelated status contexts", async () => {
      const github = createMockGithub({ labelNames: ["ARMReview"] });
      github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
        data: {
          state: "failure",
          statuses: [...successfulStatuses, { context: "Unrelated", state: "failure" }],
          total_count: 4,
        },
      });

      expect((await run(github)).labelActions).toEqual(actions(grant));
    });

    it("does not emit redundant adds when already auto-signed off", async () => {
      const github = createMockGithub({ labelNames: ["ARMReview", ...autoSignedOff] });

      expect((await run(github)).labelActions).toEqual(actions());
    });

    it("self-heals ARMSignedOff when only the marker remains", async () => {
      const github = createMockGithub({ labelNames: ["ARMReview", ArmAutoSignedOff] });

      expect((await run(github)).labelActions).toEqual(
        actions({ [ArmSignedOff]: LabelAction.Add }),
      );
    });

    it("migrates a legacy marker to ARMAutoSignedOff", async () => {
      const github = createMockGithub({
        labelNames: ["ARMReview", ArmSignedOff, ArmAutoSignedOffTrivial],
      });

      expect((await run(github)).labelActions).toEqual(
        actions({
          [ArmAutoSignedOff]: LabelAction.Add,
          [ArmAutoSignedOffTrivial]: LabelAction.Remove,
        }),
      );
    });
  });

  describe("human-owned ARMSignedOff", () => {
    it("never changes a human signoff and does not read statuses", async () => {
      const github = createMockGithub({
        labelNames: ["ARMReview", "ARMChangesRequested", ArmSignedOff],
        statuses: [],
      });

      expect((await run(github)).labelActions).toEqual(actions());
      expect(github.rest.repos.getCombinedStatusForRef).not.toHaveBeenCalled();
    });
  });

  describe("revoking", () => {
    it.each([
      { name: "ARMReview is missing", labelNames: [] as string[] },
      {
        name: "NotReadyForARMReview is present",
        labelNames: ["ARMReview", "NotReadyForARMReview"],
      },
    ])("revokes without reading statuses when $name", async ({ labelNames }) => {
      const github = createMockGithub({ labelNames: [...labelNames, ...autoSignedOff] });

      expect((await run(github)).labelActions).toEqual(actions(revoke));
      expect(github.rest.repos.getCombinedStatusForRef).not.toHaveBeenCalled();
    });

    it.each(["ARMChangesRequested", ArmManualSignoffRequired, "SuppressionReviewRequired"])(
      "revokes when %s blocks signoff",
      async (blocker) => {
        const github = createMockGithub({ labelNames: ["ARMReview", blocker, ...autoSignedOff] });

        expect((await run(github)).labelActions).toEqual(actions(revoke));
      },
    );

    it("allows signoff when suppressions are approved", async () => {
      const github = createMockGithub({
        labelNames: ["ARMReview", "SuppressionReviewRequired", "Approved-Suppression"],
      });

      expect((await run(github)).labelActions).toEqual(actions(grant));
    });

    it("revokes while a deterministic status is pending", async () => {
      const github = createMockGithub({
        labelNames: ["ARMReview", ...autoSignedOff],
        statuses: [
          semanticPassed,
          {
            context: "Swagger LintDiff",
            state: CommitStatusState.SUCCESS,
            updated_at: "2026-01-01",
          },
          {
            context: "Swagger Avocado",
            state: CommitStatusState.PENDING,
            updated_at: "2026-01-01",
          },
        ],
      });

      expect((await run(github)).labelActions).toEqual(actions(revoke));
    });

    it("revokes legacy auto-signoff that has not passed semantic review", async () => {
      const github = createMockGithub({
        labelNames: ["ARMReview", ArmSignedOff, ArmAutoSignedOffIncrementalTSP],
        statuses: deterministicStatuses,
      });

      expect((await run(github)).labelActions).toEqual(
        actions({
          [ArmSignedOff]: LabelAction.Remove,
          [ArmAutoSignedOffIncrementalTSP]: LabelAction.Remove,
        }),
      );
    });

    it("removes an orphaned marker when not eligible", async () => {
      const github = createMockGithub({ labelNames: [ArmAutoSignedOff] });

      expect((await run(github)).labelActions).toEqual(
        actions({ [ArmAutoSignedOff]: LabelAction.Remove }),
      );
    });

    it("revokes and requires manual signoff when semantic review requires it", async () => {
      const github = createMockGithub({
        labelNames: ["ARMReview", ...autoSignedOff],
        statuses: [manualReviewStatus, ...deterministicStatuses],
      });

      expect((await run(github)).labelActions).toEqual(
        actions({ ...revoke, [ArmManualSignoffRequired]: LabelAction.Add }),
      );
    });
  });

  describe("semantic review outcomes", () => {
    it.each([
      { name: "missing", status: undefined },
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
      {
        name: "incomplete",
        status: {
          context: "ARM Semantic Review",
          state: CommitStatusState.ERROR,
          description: "Review incomplete: workflow concluded with failure",
          updated_at: "2026-01-01",
        },
      },
    ])("does not sign off or require manual signoff when $name", async ({ status }) => {
      const github = createMockGithub({
        labelNames: ["ARMReview"],
        statuses: status ? [status, ...deterministicStatuses] : deterministicStatuses,
      });

      expect((await run(github)).labelActions).toEqual(actions());
    });

    it("adds manual signoff for scoped coverage even when changes were requested", async () => {
      const github = createMockGithub({
        labelNames: ["ARMReview", "ARMChangesRequested"],
        statuses: [manualReviewStatus, ...deterministicStatuses],
      });

      expect((await run(github)).labelActions).toEqual(
        actions({ [ArmManualSignoffRequired]: LabelAction.Add }),
      );
    });

    it.each([
      {
        description: "Review incomplete: tool-failure",
        state: CommitStatusState.ERROR,
        log: "ARM semantic review has not passed: review-incomplete (Review incomplete: tool-failure)",
      },
      {
        description: "Changes requested: 2 Blocking finding(s)",
        state: CommitStatusState.FAILURE,
        log: "ARM semantic review has not passed: changes-requested (Changes requested: 2 Blocking finding(s))",
      },
    ])("logs the reason: $description", async ({ description, state, log }) => {
      const loggingCore = createMockCore();
      const github = createMockGithub({
        labelNames: ["ARMReview"],
        statuses: [
          { context: "ARM Semantic Review", state, description, updated_at: "2026-01-01" },
          ...deterministicStatuses,
        ],
      });

      await run(github, loggingCore);
      expect(loggingCore.info).toHaveBeenCalledWith(log);
    });

    it("logs a missing semantic review status", async () => {
      const loggingCore = createMockCore();
      const github = createMockGithub({
        labelNames: ["ARMReview"],
        statuses: deterministicStatuses,
      });

      await run(github, loggingCore);
      expect(loggingCore.info).toHaveBeenCalledWith("ARM semantic review has not passed: missing");
    });

    it("logs why an existing manual signoff label produces no new action", async () => {
      const loggingCore = createMockCore();
      const github = createMockGithub({
        labelNames: ["ARMReview", ArmManualSignoffRequired],
        statuses: [
          { ...manualReviewStatus, description: "Manual review required: PR exceeds limits" },
          ...deterministicStatuses,
        ],
      });

      expect((await run(github, loggingCore)).labelActions).toEqual(actions());
      expect(loggingCore.info).toHaveBeenCalledWith(
        expect.stringContaining('"description":"Manual review required: PR exceeds limits"'),
      );
      expect(loggingCore.info).toHaveBeenCalledWith(
        "ARM semantic review requires manual signoff; ARMManualSignoffRequired is already present",
      );
    });
  });

  describe("stale or missing correlation", () => {
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

      expect(result).toEqual({ headSha: "", issueNumber: Number.NaN, labelActions: actions() });
      expect(github.rest.pulls.get).not.toHaveBeenCalled();
      expect(loggingCore.info).toHaveBeenCalledWith(
        "Universal auto-signoff no-op: missing correlation " +
          "(issueNumber=missing, headSha=missing)",
      );
    });

    it.each([
      { name: "a stale head", currentHeadSha: "newer-sha", pullRequestState: "open" as const },
      { name: "a closed PR", currentHeadSha: headSha, pullRequestState: "closed" as const },
    ])("takes no action for $name", async ({ currentHeadSha, pullRequestState }) => {
      const github = createMockGithub({
        labelNames: ["ARMReview", ...autoSignedOff],
        statuses: [],
        currentHeadSha,
        pullRequestState,
      });

      expect((await run(github)).labelActions).toEqual(actions());
      expect(github.rest.issues.listLabelsOnIssue).not.toHaveBeenCalled();
      expect(github.rest.repos.getCombinedStatusForRef).not.toHaveBeenCalled();
    });
  });
});

describe("ARM Universal Auto SignOff workflow", () => {
  const readWorkflow = (name: string) => readFile(join(GITHUB_ROOT, "workflows", name), "utf8");

  it("re-evaluates after the ARM API Reviewer publishes its status", async () => {
    const workflow = await readWorkflow("arm-universal-auto-signoff.yaml");

    expect(workflow).toContain('"ARM API Review: Automated Workflow"');
    expect(workflow).not.toContain("ARM Semantic Review - Set Status");
  });

  it("re-evaluates on every policy-relevant label", async () => {
    const workflow = await readWorkflow("arm-universal-auto-signoff.yaml");

    for (const label of [
      "Approved-Suppression",
      "ARMAutoSignedOff",
      "ARMManualSignoffRequired",
      "ARMReview",
      "ARMSignedOff",
      "NotReadyForARMReview",
      "SuppressionReviewRequired",
    ]) {
      expect(workflow).toContain(`github.event.label.name == '${label}'`);
    }
    expect(workflow).not.toContain("ARMAutoSignedOff-Test");
  });

  it("does not write labels or statuses, and emits an artifact for every managed label", async () => {
    const workflow = await readWorkflow("arm-universal-auto-signoff.yaml");

    expect(workflow).toContain("issues: read");
    expect(workflow).toContain("pull-requests: read");
    expect(workflow).toContain("actions: write");
    expect(workflow).toContain("statuses: read");
    expect(workflow).not.toContain("pull-requests: write");
    for (const label of Object.values(ArmAutoSignoffLabel)) {
      expect(workflow).toContain(`name: Upload artifact for ${label} label`);
    }
  });

  it("publishes correlation artifacts before dispatching Update Labels, only from a dispatched run", async () => {
    const workflow = await readWorkflow("arm-universal-auto-signoff.yaml");
    const headArtifact = workflow.indexOf("name: Upload artifact with head SHA");
    const issueArtifact = workflow.indexOf("name: Upload artifact with issue number");
    const step = workflow.slice(workflow.indexOf("name: Dispatch Update Labels"));

    expect(headArtifact).toBeGreaterThan(-1);
    expect(issueArtifact).toBeGreaterThan(headArtifact);
    expect(workflow.indexOf("name: Dispatch Update Labels")).toBeGreaterThan(issueArtifact);
    expect(step.slice(0, step.indexOf("uses:"))).toContain(
      "github.event_name == 'workflow_dispatch'",
    );
    expect(workflow).toContain("await dispatchUpdateLabels({ github, context, core });");
  });

  it("is applied by Update Labels, and the legacy workflow is gone", async () => {
    const updateLabels = await readWorkflow("update-labels.yaml");

    expect(updateLabels).toContain('"ARM Universal Auto SignOff"');
    expect(updateLabels).not.toContain("ARM Auto SignOff - Set Status");
  });

  it("dispatches Summarize Checks only from the dispatch route, in its own job", async () => {
    const updateLabels = await readWorkflow("update-labels.yaml");
    const summarize = await readWorkflow("summarize-checks.yaml");
    const dispatchJob = updateLabels.slice(updateLabels.indexOf("  dispatch-summarize-checks:"));

    // Only the dispatching job may write actions; the job that applies labels stays read-only.
    expect(
      updateLabels.slice(0, updateLabels.indexOf("  dispatch-summarize-checks:")),
    ).not.toContain("actions: write");
    expect(dispatchJob).toContain("needs: update-labels");
    expect(dispatchJob).toContain("github.event_name == 'workflow_dispatch'");
    expect(dispatchJob).toContain("actions: write");
    expect(dispatchJob).toContain("dispatchSummarizeChecks(");
    expect(dispatchJob).toContain("prNumber: process.env.PR_NUMBER, headSha: process.env.HEAD_SHA");
    expect(summarize).toMatch(/workflow_dispatch:\s+inputs:\s+pr_number:[\s\S]+head_sha:/);
    expect(summarize).toContain("github.event_name == 'workflow_dispatch' ||");
    // The workflow_run fallback stays, so a dispatch must not be added for that route.
    expect(summarize).toContain('- "Update Labels"');
  });
});
