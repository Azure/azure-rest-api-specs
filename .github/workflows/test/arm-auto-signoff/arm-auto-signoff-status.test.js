import { describe, expect, it } from "vitest";
import { CommitStatusState } from "../../../shared/src/github.js";
import { getLabelActionImpl } from "../../src/arm-auto-signoff/arm-auto-signoff-status.js";
import { LabelAction } from "../../src/label.js";
import { createMockCore, createMockGithub as createMockGithubBase } from "../mocks.js";

const core = createMockCore();

const managedLabels = Object.freeze({
  armSignedOff: "ARMSignedOff",
  autoSignedOffIncrementalTsp: "ARMAutoSignedOff-IncrementalTSP",
  autoSignedOffTrivialTest: "ARMAutoSignedOff-Trivial-Test",
});

function createNoneLabelActions() {
  return {
    [managedLabels.armSignedOff]: LabelAction.None,
    [managedLabels.autoSignedOffIncrementalTsp]: LabelAction.None,
    [managedLabels.autoSignedOffTrivialTest]: LabelAction.None,
  };
}

/**
 * @param {string} headSha
 * @param {number} issueNumber
 */
function createNoneResult(headSha, issueNumber) {
  return {
    headSha,
    issueNumber,
    labelActions: createNoneLabelActions(),
  };
}

/**
 * @param {string} headSha
 * @param {number} issueNumber
 */
function createRemoveManagedLabelsResult(headSha, issueNumber) {
  return {
    headSha,
    issueNumber,
    labelActions: {
      ...createNoneLabelActions(),
      [managedLabels.armSignedOff]: LabelAction.Remove,
      [managedLabels.autoSignedOffIncrementalTsp]: LabelAction.Remove,
      [managedLabels.autoSignedOffTrivialTest]: LabelAction.Remove,
    },
  };
}

/**
 * @param {{
 *   headSha: string,
 *   issueNumber: number,
 *   incrementalTypeSpec: boolean,
 *   isTrivial: boolean,
 * }} params
 */
function createSuccessResult({ headSha, issueNumber, incrementalTypeSpec, isTrivial }) {
  return {
    headSha,
    issueNumber,
    labelActions: {
      ...createNoneLabelActions(),
      [managedLabels.armSignedOff]: incrementalTypeSpec ? LabelAction.Add : LabelAction.None,
      [managedLabels.autoSignedOffIncrementalTsp]: incrementalTypeSpec
        ? LabelAction.Add
        : LabelAction.Remove,
      [managedLabels.autoSignedOffTrivialTest]: isTrivial ? LabelAction.Add : LabelAction.Remove,
    },
  };
}

/** @param {{ incrementalTypeSpec: boolean, isTrivial?: boolean }} param0 */
function createMockGithub({ incrementalTypeSpec, isTrivial = false }) {
  const github = createMockGithubBase();

  github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
    data: {
      workflow_runs: [
        {
          name: "Unrelated Workflow",
          id: 444,
          status: "in_progress",
          conclusion: null,
        },
        {
          name: "ARM Auto SignOff - Analyze Code",
          id: 456,
          status: "completed",
          conclusion: "success",
        },
      ],
    },
  });

  // Analyze-code uploads 2 empty artifacts named `${name}=${value}`.
  const incremental = incrementalTypeSpec ? "true" : "false";
  const trivial = isTrivial ? "true" : "false";
  github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
    data: {
      artifacts: [
        {
          name: `incremental-typespec=${incremental}`,
        },
        {
          name: `trivial-changes=${trivial}`,
        },
      ],
    },
  });

  return github;
}

describe("getLabelActionImpl", () => {
  it("throws if inputs null", async () => {
    await expect(
      getLabelActionImpl(/** @type {Parameters<typeof getLabelActionImpl>[0]} */ ({})),
    ).rejects.toThrow();
  });

  it("no-ops if no artifact from incremental typespec", async () => {
    const github = createMockGithub({ incrementalTypeSpec: false });
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: { artifacts: [] },
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual(createNoneResult("abc123", 123));
  });

  it("no-ops if no current label ARMAutoSignedOff", async () => {
    const github = createMockGithub({ incrementalTypeSpec: false });
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [],
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual(createNoneResult("abc123", 123));
  });

  it("removes label if not incremental typespec", async () => {
    const github = createMockGithub({ incrementalTypeSpec: false });
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMAutoSignedOff-IncrementalTSP" }],
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual(createRemoveManagedLabelsResult("abc123", 123));
  });

  it("removes label if analysis artifacts missing (fail closed)", async () => {
    const github = createMockGithub({ incrementalTypeSpec: true });
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMAutoSignedOff-IncrementalTSP" }],
    });

    // Only one of the required artifacts is present.
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [{ name: "incremental-typespec=true" }],
      },
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual(createRemoveManagedLabelsResult("abc123", 123));
  });

  it("no-ops if incremental typespec in progress", async () => {
    const github = createMockGithubBase();
    github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
      data: {
        workflow_runs: [
          {
            name: "ARM Auto SignOff - Analyze Code",
            id: 456,
            status: "in_progress",
            conclusion: null,
          },
        ],
      },
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual(createNoneResult("abc123", 123));
  });

  it("removes label if no runs of incremental typespec", async () => {
    const github = createMockGithubBase();
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMAutoSignedOff-IncrementalTSP" }],
    });
    github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
      data: {
        workflow_runs: [],
      },
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual(createRemoveManagedLabelsResult("abc123", 123));
  });

  it("uses latest run of incremental typespec", async () => {
    const github = createMockGithubBase();
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMAutoSignedOff-IncrementalTSP" }],
    });
    github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
      data: {
        workflow_runs: [
          {
            name: "ARM Auto SignOff - Analyze Code",
            id: 456,
            status: "completed",
            conclusion: "success",
            updated_at: "2020-01-22T19:33:08Z",
          },
          {
            name: "ARM Auto SignOff - Analyze Code",
            id: 789,
            status: "completed",
            conclusion: "failure",
            updated_at: "2020-01-23T19:33:08Z",
          },
        ],
      },
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual(createRemoveManagedLabelsResult("abc123", 123));
  });

  it.each([
    { labels: ["ARMAutoSignedOff-IncrementalTSP"] },
    { labels: ["ARMAutoSignedOff-IncrementalTSP", "ARMReview", "NotReadyForARMReview"] },
    { labels: ["ARMAutoSignedOff-IncrementalTSP", "ARMReview", "SuppressionReviewRequired"] },
  ])("removes label if not all labels match ($labels)", async ({ labels }) => {
    const github = createMockGithub({ incrementalTypeSpec: true });

    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: labels.map((name) => ({ name })),
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual(createRemoveManagedLabelsResult("abc123", 123));
  });

  it.each(["Swagger Avocado", "Swagger LintDiff"])(
    "removes label if check %s failed",
    async (check) => {
      const github = createMockGithub({ incrementalTypeSpec: true });

      github.rest.issues.listLabelsOnIssue.mockResolvedValue({
        data: [{ name: "ARMAutoSignedOff-IncrementalTSP" }, { name: "ARMReview" }],
      });
      github.rest.repos.listCommitStatusesForRef.mockResolvedValue({
        data: [
          {
            context: check,
            state: CommitStatusState.FAILURE,
          },
        ],
      });

      await expect(
        getLabelActionImpl({
          owner: "TestOwner",
          repo: "TestRepo",
          issue_number: 123,
          head_sha: "abc123",
          github: github,
          core: core,
        }),
      ).resolves.toEqual(createRemoveManagedLabelsResult("abc123", 123));
    },
  );

  it.each([
    [
      CommitStatusState.ERROR,
      ["ARMReview", "ARMAutoSignedOff-IncrementalTSP"],
      createRemoveManagedLabelsResult("abc123", 123),
    ],
    [
      CommitStatusState.FAILURE,
      ["ARMReview", "ARMAutoSignedOff-IncrementalTSP"],
      createRemoveManagedLabelsResult("abc123", 123),
    ],
    [CommitStatusState.PENDING, ["ARMReview"], createNoneResult("abc123", 123)],
    [
      CommitStatusState.SUCCESS,
      ["ARMReview"],
      createSuccessResult({
        headSha: "abc123",
        issueNumber: 123,
        incrementalTypeSpec: true,
        isTrivial: false,
      }),
    ],
  ])("uses latest status if multiple (%o)", async (state, labels, expectedResult) => {
    const github = createMockGithub({ incrementalTypeSpec: true });

    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: labels.map((l) => ({
        name: l,
      })),
    });

    github.rest.repos.listCommitStatusesForRef.mockResolvedValue({
      data: [
        {
          context: "Swagger Avocado",
          state: CommitStatusState.SUCCESS,
          updated_at: "2025-01-01",
        },
        {
          context: "Swagger LintDiff",
          state: CommitStatusState.PENDING,
          updated_at: "2025-01-01",
        },
        {
          context: "Swagger LintDiff",
          state,
          updated_at: "2025-01-02",
        },
      ],
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual(expectedResult);
  });

  it("no-ops if check not found or not completed", async () => {
    const github = createMockGithub({ incrementalTypeSpec: true });

    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMReview" }],
    });

    github.rest.repos.listCommitStatusesForRef.mockResolvedValue({
      data: [],
    });
    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual(createNoneResult("abc123", 123));

    github.rest.repos.listCommitStatusesForRef.mockResolvedValue({
      data: [{ context: "Swagger LintDiff", state: CommitStatusState.PENDING }],
    });
    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual(createNoneResult("abc123", 123));
  });

  it("adds label if incremental tsp, labels match, and check succeeded", async () => {
    const github = createMockGithub({ incrementalTypeSpec: true });

    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMReview" }],
    });
    github.rest.repos.listCommitStatusesForRef.mockResolvedValue({
      data: [
        {
          context: "Swagger LintDiff",
          state: CommitStatusState.SUCCESS,
        },
        {
          context: "Swagger Avocado",
          state: CommitStatusState.SUCCESS,
        },
      ],
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual(
      createSuccessResult({
        headSha: "abc123",
        issueNumber: 123,
        incrementalTypeSpec: true,
        isTrivial: false,
      }),
    );
  });

  it("adds trivial test label when PR qualifies only by trivial changes", async () => {
    const github = createMockGithub({ incrementalTypeSpec: false, isTrivial: true });

    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMReview" }],
    });

    github.rest.repos.listCommitStatusesForRef.mockResolvedValue({
      data: [
        {
          context: "Swagger LintDiff",
          state: CommitStatusState.SUCCESS,
        },
        {
          context: "Swagger Avocado",
          state: CommitStatusState.SUCCESS,
        },
      ],
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual(
      createSuccessResult({
        headSha: "abc123",
        issueNumber: 123,
        incrementalTypeSpec: false,
        isTrivial: true,
      }),
    );
  });

  it("removes label if analysis artifacts have invalid boolean value (fail closed)", async () => {
    const github = createMockGithub({ incrementalTypeSpec: true });

    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMAutoSignedOff-IncrementalTSP" }],
    });

    // Invalid boolean value should be treated as missing/invalid.
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [{ name: "incremental-typespec=maybe" }, { name: "trivial-changes=false" }],
      },
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual(createRemoveManagedLabelsResult("abc123", 123));
  });

  it("preserves existing ARMSignedOff and adds trivial test label when PR qualifies by trivial changes only", async () => {
    const github = createMockGithub({ incrementalTypeSpec: false, isTrivial: true });

    // PR already has ARMSignedOff (manually added) and ARMReview, but no auto-signoff labels
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMSignedOff" }, { name: "ARMReview" }],
    });

    // All required checks pass
    github.rest.repos.listCommitStatusesForRef.mockResolvedValue({
      data: [
        {
          context: "Swagger LintDiff",
          state: CommitStatusState.SUCCESS,
        },
        {
          context: "Swagger Avocado",
          state: CommitStatusState.SUCCESS,
        },
      ],
    });

    const result = await getLabelActionImpl({
      owner: "TestOwner",
      repo: "TestRepo",
      issue_number: 123,
      head_sha: "abc123",
      github: github,
      core: core,
    });

    // ARMSignedOff should remain unchanged (LabelAction.None) since it already exists
    // and is not managed by auto-signoff when hasAutoSignedOffLabels is false
    expect(result.labelActions[managedLabels.armSignedOff]).toBe(LabelAction.None);
    // Trivial test label should be added
    expect(result.labelActions[managedLabels.autoSignedOffTrivialTest]).toBe(LabelAction.Add);
    // Incremental TSP label should be removed (not applicable)
    expect(result.labelActions[managedLabels.autoSignedOffIncrementalTsp]).toBe(LabelAction.Remove);
  });

  it("preserves manual ARMSignedOff when trivial test label present and no longer qualifies", async () => {
    const github = createMockGithub({ incrementalTypeSpec: false, isTrivial: false });

    // PR has manually added ARMSignedOff + trivial test label (from previous run)
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [
        { name: "ARMSignedOff" },
        { name: managedLabels.autoSignedOffTrivialTest },
        { name: "ARMReview" },
      ],
    });

    const result = await getLabelActionImpl({
      owner: "TestOwner",
      repo: "TestRepo",
      issue_number: 123,
      head_sha: "abc123",
      github: github,
      core: core,
    });

    // ARMSignedOff was manually added (no IncrementalTSP), so preserve it
    expect(result.labelActions[managedLabels.armSignedOff]).toBe(LabelAction.None);
    // Trivial test label should be removed (no longer qualifies)
    expect(result.labelActions[managedLabels.autoSignedOffTrivialTest]).toBe(LabelAction.Remove);
    // Incremental TSP label was never present, so no-op
    expect(result.labelActions[managedLabels.autoSignedOffIncrementalTsp]).toBe(LabelAction.None);
  });

  it("removes all auto-signoff labels when IncrementalTSP was present and no longer qualifies", async () => {
    const github = createMockGithub({ incrementalTypeSpec: false, isTrivial: false });

    // PR had auto-added ARMSignedOff via IncrementalTSP
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [
        { name: "ARMSignedOff" },
        { name: managedLabels.autoSignedOffIncrementalTsp },
        { name: "ARMReview" },
      ],
    });

    const result = await getLabelActionImpl({
      owner: "TestOwner",
      repo: "TestRepo",
      issue_number: 123,
      head_sha: "abc123",
      github: github,
      core: core,
    });

    // ARMSignedOff was auto-added (IncrementalTSP present), so remove it
    expect(result.labelActions[managedLabels.armSignedOff]).toBe(LabelAction.Remove);
    // Both auto-signoff labels should be removed
    expect(result.labelActions[managedLabels.autoSignedOffTrivialTest]).toBe(LabelAction.Remove);
    expect(result.labelActions[managedLabels.autoSignedOffIncrementalTsp]).toBe(LabelAction.Remove);
  });

  it("transitions from trivial to incremental typespec correctly", async () => {
    const github = createMockGithub({ incrementalTypeSpec: true, isTrivial: false });

    // PR previously had trivial test label, now qualifies via incremental typespec
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: managedLabels.autoSignedOffTrivialTest }, { name: "ARMReview" }],
    });

    github.rest.repos.listCommitStatusesForRef.mockResolvedValue({
      data: [
        { context: "Swagger LintDiff", state: CommitStatusState.SUCCESS },
        { context: "Swagger Avocado", state: CommitStatusState.SUCCESS },
      ],
    });

    const result = await getLabelActionImpl({
      owner: "TestOwner",
      repo: "TestRepo",
      issue_number: 123,
      head_sha: "abc123",
      github: github,
      core: core,
    });

    // Now qualifies via incremental typespec, so add ARMSignedOff
    expect(result.labelActions[managedLabels.armSignedOff]).toBe(LabelAction.Add);
    expect(result.labelActions[managedLabels.autoSignedOffIncrementalTsp]).toBe(LabelAction.Add);
    // Trivial test label should be removed (not applicable)
    expect(result.labelActions[managedLabels.autoSignedOffTrivialTest]).toBe(LabelAction.Remove);
  });

  it("transitions from incremental typespec to trivial correctly", async () => {
    const github = createMockGithub({ incrementalTypeSpec: false, isTrivial: true });

    // PR previously had incremental typespec labels, now qualifies only via trivial
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [
        { name: "ARMSignedOff" },
        { name: managedLabels.autoSignedOffIncrementalTsp },
        { name: "ARMReview" },
      ],
    });

    github.rest.repos.listCommitStatusesForRef.mockResolvedValue({
      data: [
        { context: "Swagger LintDiff", state: CommitStatusState.SUCCESS },
        { context: "Swagger Avocado", state: CommitStatusState.SUCCESS },
      ],
    });

    const result = await getLabelActionImpl({
      owner: "TestOwner",
      repo: "TestRepo",
      issue_number: 123,
      head_sha: "abc123",
      github: github,
      core: core,
    });

    // IncrementalTSP was present, so ARMSignedOff should be removed (it was auto-added)
    expect(result.labelActions[managedLabels.armSignedOff]).toBe(LabelAction.Remove);
    // Incremental TSP label should be removed
    expect(result.labelActions[managedLabels.autoSignedOffIncrementalTsp]).toBe(LabelAction.Remove);
    // Trivial test label should be added
    expect(result.labelActions[managedLabels.autoSignedOffTrivialTest]).toBe(LabelAction.Add);
  });

  it("adds both labels when PR qualifies for both incremental typespec and trivial", async () => {
    const github = createMockGithub({ incrementalTypeSpec: true, isTrivial: true });

    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMReview" }],
    });

    github.rest.repos.listCommitStatusesForRef.mockResolvedValue({
      data: [
        { context: "Swagger LintDiff", state: CommitStatusState.SUCCESS },
        { context: "Swagger Avocado", state: CommitStatusState.SUCCESS },
      ],
    });

    const result = await getLabelActionImpl({
      owner: "TestOwner",
      repo: "TestRepo",
      issue_number: 123,
      head_sha: "abc123",
      github: github,
      core: core,
    });

    // Incremental typespec takes precedence for ARMSignedOff
    expect(result.labelActions[managedLabels.armSignedOff]).toBe(LabelAction.Add);
    expect(result.labelActions[managedLabels.autoSignedOffIncrementalTsp]).toBe(LabelAction.Add);
    // Trivial test label should also be added
    expect(result.labelActions[managedLabels.autoSignedOffTrivialTest]).toBe(LabelAction.Add);
  });

  it("removes only trivial test label when only TrivialTest present and no longer qualifies", async () => {
    const github = createMockGithub({ incrementalTypeSpec: false, isTrivial: false });

    // PR only has trivial test label (no ARMSignedOff, no IncrementalTSP)
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: managedLabels.autoSignedOffTrivialTest }, { name: "ARMReview" }],
    });

    const result = await getLabelActionImpl({
      owner: "TestOwner",
      repo: "TestRepo",
      issue_number: 123,
      head_sha: "abc123",
      github: github,
      core: core,
    });

    // No IncrementalTSP, so ARMSignedOff action is None
    expect(result.labelActions[managedLabels.armSignedOff]).toBe(LabelAction.None);
    // Trivial test label should be removed
    expect(result.labelActions[managedLabels.autoSignedOffTrivialTest]).toBe(LabelAction.Remove);
    // Incremental TSP was never present, so no-op
    expect(result.labelActions[managedLabels.autoSignedOffIncrementalTsp]).toBe(LabelAction.None);
  });
});
