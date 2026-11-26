import { beforeEach, describe, expect, it } from "vitest";
import { CheckConclusion, CheckStatus, CommitStatusState } from "../../shared/src/github.ts";
import { fullGitSha } from "../../shared/test/examples.ts";
import {
  getUnverifiedOverrideContexts,
  MONITORED_STATUS_CHECKS,
  selectChecksForEvent,
  setStatusImpl,
  shouldSyncStatusesForEvent,
  syncMonitoredStatusesImpl,
} from "../src/set-status.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

describe("setStatusImpl", () => {
  let core: ReturnType<typeof createMockCore>;

  let github: ReturnType<typeof createMockGithub>;

  beforeEach(() => {
    core = createMockCore();
    github = createMockGithub();
  });

  it("throws if inputs null", async () => {
    await expect(
      setStatusImpl({} as Parameters<typeof setStatusImpl>[0]),
    ).rejects.toMatchInlineSnapshot(`[Error: head_sha is not a valid full git SHA: 'undefined']`);
  });

  it.each([null, undefined, "", "abc123"])("throws when head_sha is %o", async (head_sha) => {
    await expect(
      setStatusImpl({
        owner: "test-owner",
        repo: "test-repo",
        head_sha: head_sha as string,
        issue_number: 123,
        target_url: "https://test.com/set_status_url",
        github,
        core,
        monitoredWorkflowName: "test-workflow",
        requiredStatusName: "test-status",
        overridingLabel: "test-label",
      }),
    ).rejects.toThrow("head_sha is not a valid full git SHA");
  });

  it.each([null, undefined, NaN, 0, -1])("throws when issue_number is %o", async (issue_number) => {
    await expect(
      setStatusImpl({
        owner: "test-owner",
        repo: "test-repo",
        head_sha: fullGitSha,
        issue_number: issue_number as number,
        target_url: "https://test.com/set_status_url",
        github,
        core,
        monitoredWorkflowName: "test-workflow",
        requiredStatusName: "test-status",
        overridingLabel: "test-label",
      }),
    ).rejects.toThrow("issue_number must be a positive integer");
  });

  it("sets success if approved by label", async () => {
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "test" }, { name: "Approved-Avocado" }],
    });

    await expect(
      setStatusImpl({
        owner: "test-owner",
        repo: "test-repo",
        head_sha: fullGitSha,
        issue_number: 123,
        target_url: "https://test.com/set_status_url",
        github,
        core,
        monitoredWorkflowName: "Swagger Avocado - Analyze Code",
        requiredStatusName: "Swagger Avocado",
        overridingLabel: "Approved-Avocado",
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.repos.createCommitStatus).toBeCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: fullGitSha,
      state: CommitStatusState.SUCCESS,
      context: "Swagger Avocado",
      description: "Found label 'Approved-Avocado'",
      target_url: "https://test.com/set_status_url",
    });
  });

  it("links an approved status to the analyzer report", async () => {
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "typespec-suppressions-approved" }],
    });
    github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
      data: [
        {
          id: 456,
          name: "TypeSpec Suppressions - Analyze Code",
          status: CheckStatus.COMPLETED,
          conclusion: CheckConclusion.FAILURE,
          updated_at: "2026-09-29",
          html_url: "https://test.com/typespec-suppressions-report",
        },
      ],
    });
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: [{ name: "job-summary" }],
    });

    await setStatusImpl({
      owner: "test-owner",
      repo: "test-repo",
      head_sha: fullGitSha,
      issue_number: 123,
      target_url: "https://test.com/set_status_url",
      github,
      core,
      monitoredWorkflowName: "TypeSpec Suppressions - Analyze Code",
      requiredStatusName: "TypeSpec Suppressions",
      overridingLabel: "typespec-suppressions-approved",
    });

    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: fullGitSha,
      state: CommitStatusState.SUCCESS,
      context: "TypeSpec Suppressions",
      description: "Found label 'typespec-suppressions-approved'",
      target_url: "https://test.com/typespec-suppressions-report",
    });
  });

  it("sets success with multiple comma-separated labels - first label matches", async () => {
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "test" }, { name: "BreakingChange-Approved-Benign" }],
    });

    await expect(
      setStatusImpl({
        owner: "test-owner",
        repo: "test-repo",
        head_sha: fullGitSha,
        issue_number: 123,
        target_url: "https://test.com/set_status_url",
        github,
        core,
        monitoredWorkflowName: "Swagger BreakingChange - Analyze Code",
        requiredStatusName: "Swagger BreakingChange",
        overridingLabel:
          "BreakingChange-Approved-Benign,BreakingChange-Approved-BugFix,BreakingChange-Approved-UserImpact",
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.repos.createCommitStatus).toBeCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: fullGitSha,
      state: CommitStatusState.SUCCESS,
      context: "Swagger BreakingChange",
      description: "Found label 'BreakingChange-Approved-Benign'",
      target_url: "https://test.com/set_status_url",
    });

    expect(core.setOutput).toBeCalledWith("head_sha", fullGitSha);
    expect(core.setOutput).toBeCalledWith("issue_number", 123);
  });

  it("handles comma-separated labels with whitespace", async () => {
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "test" }, { name: "BreakingChange-Approved-UserImpact" }],
    });

    await expect(
      setStatusImpl({
        owner: "test-owner",
        repo: "test-repo",
        head_sha: fullGitSha,
        issue_number: 123,
        target_url: "https://test.com/set_status_url",
        github,
        core,
        monitoredWorkflowName: "Swagger BreakingChange - Analyze Code",
        requiredStatusName: "Swagger BreakingChange",
        overridingLabel:
          "BreakingChange-Approved-Benign, BreakingChange-Approved-BugFix , BreakingChange-Approved-UserImpact",
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.repos.createCommitStatus).toBeCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: fullGitSha,
      state: CommitStatusState.SUCCESS,
      context: "Swagger BreakingChange",
      description: "Found label 'BreakingChange-Approved-UserImpact'",
      target_url: "https://test.com/set_status_url",
    });
  });

  it("handles comma-separated labels with empty entries", async () => {
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "test" }, { name: "BreakingChange-Approved-Security" }],
    });

    await expect(
      setStatusImpl({
        owner: "test-owner",
        repo: "test-repo",
        head_sha: fullGitSha,
        issue_number: 123,
        target_url: "https://test.com/set_status_url",
        github,
        core,
        monitoredWorkflowName: "Swagger BreakingChange - Analyze Code",
        requiredStatusName: "Swagger BreakingChange",
        overridingLabel: "BreakingChange-Approved-Benign,,BreakingChange-Approved-Security,",
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.repos.createCommitStatus).toBeCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: fullGitSha,
      state: CommitStatusState.SUCCESS,
      context: "Swagger BreakingChange",
      description: "Found label 'BreakingChange-Approved-Security'",
      target_url: "https://test.com/set_status_url",
    });
  });

  it("does not set success when none of the multiple labels match", async () => {
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "test" }, { name: "SomeOtherLabel" }],
    });

    github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
      data: [],
    });

    await expect(
      setStatusImpl({
        owner: "test-owner",
        repo: "test-repo",
        head_sha: fullGitSha,
        issue_number: 123,
        target_url: "https://test.com/set_status_url",
        github,
        core,
        monitoredWorkflowName: "Swagger BreakingChange - Analyze Code",
        requiredStatusName: "Swagger BreakingChange",
        overridingLabel:
          "BreakingChange-Approved-Benign,BreakingChange-Approved-BugFix,BreakingChange-Approved-UserImpact",
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.repos.createCommitStatus).toBeCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: fullGitSha,
      state: CommitStatusState.PENDING,
      context: "Swagger BreakingChange",
      target_url: "https://test.com/set_status_url",
    });
  });

  it("handles empty overriding label", async () => {
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "test" }],
    });

    github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
      data: [],
    });

    await expect(
      setStatusImpl({
        owner: "test-owner",
        repo: "test-repo",
        head_sha: fullGitSha,
        issue_number: 123,
        target_url: "https://test.com/set_status_url",
        github,
        core,
        monitoredWorkflowName: "Swagger BreakingChange - Analyze Code",
        requiredStatusName: "Swagger BreakingChange",
        overridingLabel: "",
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.repos.createCommitStatus).toBeCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: fullGitSha,
      state: CommitStatusState.PENDING,
      context: "Swagger BreakingChange",
      target_url: "https://test.com/set_status_url",
    });
  });

  // TODO: Add tests for "job-summary" artifact
  it.each([
    [
      CheckStatus.COMPLETED,
      CheckConclusion.SUCCESS,
      CommitStatusState.SUCCESS,
      [],
      "https://test.com/workflow_run_html_url",
    ],
    [
      CheckStatus.COMPLETED,
      CheckConclusion.FAILURE,
      CommitStatusState.FAILURE,
      [],
      "https://test.com/job_html_url?pr=123",
    ],
    [
      CheckStatus.COMPLETED,
      CheckConclusion.FAILURE,
      CommitStatusState.FAILURE,
      ["job-status"],
      "https://test.com/workflow_run_html_url",
    ],
    [
      CheckStatus.IN_PROGRESS,
      null,
      CommitStatusState.PENDING,
      [],
      "https://test.com/workflow_run_html_url",
    ],
    [null, null, CommitStatusState.PENDING, [], "https://test.com/set_status_url"],
  ])(
    "(%s, %s, %s, %o) => %s",
    async (checkStatus, checkConclusion, commitStatusState, artifactNames, targetUrl) => {
      if (checkStatus) {
        github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
          data: [
            {
              name: "Swagger Avocado - Analyze Code",
              status: checkStatus,
              conclusion: checkConclusion,
              updated_at: "2025-01-01",
              html_url: "https://test.com/workflow_run_html_url",
            },
          ],
        });

        github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
          data: artifactNames.map((n) => ({
            name: n,
          })),
        });

        if (
          checkConclusion === CheckConclusion.SUCCESS ||
          checkConclusion === CheckConclusion.FAILURE
        ) {
          github.rest.actions.listJobsForWorkflowRun.mockResolvedValue({
            data: [
              {
                conclusion: checkConclusion,
                html_url: "https://test.com/job_html_url",
              },
            ],
          });
        }
      }

      await expect(
        setStatusImpl({
          owner: "test-owner",
          repo: "test-repo",
          head_sha: fullGitSha,
          issue_number: 123,
          target_url: "https://test.com/set_status_url",
          github,
          core,
          monitoredWorkflowName: "Swagger Avocado - Analyze Code",
          requiredStatusName: "Swagger Avocado",
          overridingLabel: "Approved-Avocado",
        }),
      ).resolves.toBeUndefined();

      expect(github.rest.repos.createCommitStatus).toBeCalledWith({
        owner: "test-owner",
        repo: "test-repo",
        sha: fullGitSha,
        state: commitStatusState,
        context: "Swagger Avocado",
        target_url: targetUrl,
      });
    },
  );
});

describe("selectChecksForEvent", () => {
  it("selects all monitored checks on PR open/synchronize/reopened", () => {
    for (const action of ["opened", "synchronize", "reopened"]) {
      const context = Object.assign(createMockContext(), {
        eventName: "pull_request_target",
        payload: { action, pull_request: { state: "open" } },
      });
      expect(selectChecksForEvent(context)).toHaveLength(MONITORED_STATUS_CHECKS.length);
    }
  });

  it("selects only checks matching the changed override label", () => {
    const breakingChangeContext = Object.assign(createMockContext(), {
      eventName: "pull_request_target",
      payload: {
        action: "labeled",
        pull_request: { state: "open" },
        label: { name: "BreakingChange-Approved-Benign" },
      },
    });
    expect(selectChecksForEvent(breakingChangeContext).map((c) => c.requiredStatusName)).toEqual([
      "Swagger BreakingChange",
      "Breaking Change(Cross-Version)",
    ]);

    const unrelatedLabelContext = Object.assign(createMockContext(), {
      eventName: "pull_request_target",
      payload: {
        action: "labeled",
        pull_request: { state: "open" },
        label: { name: "Service Attention" },
      },
    });
    expect(selectChecksForEvent(unrelatedLabelContext)).toEqual([]);
  });

  it("selects only the check matching the completed analyzer workflow (including TEST-IGNORE)", () => {
    const context = Object.assign(createMockContext(), {
      eventName: "workflow_run",
      payload: {
        action: "completed",
        workflow_run: {
          name: "[TEST-IGNORE] Swagger LintDiff - Analyze Code",
          conclusion: CheckConclusion.SUCCESS,
        },
      },
    });
    expect(selectChecksForEvent(context).map((c) => c.requiredStatusName)).toEqual([
      "Swagger LintDiff",
    ]);

    const skippedContext = Object.assign(createMockContext(), {
      eventName: "workflow_run",
      payload: {
        action: "completed",
        workflow_run: {
          name: "Swagger LintDiff - Analyze Code",
          conclusion: CheckConclusion.SKIPPED,
        },
      },
    });
    expect(selectChecksForEvent(skippedContext)).toEqual([]);

    const dispatchContext = Object.assign(createMockContext(), {
      eventName: "workflow_dispatch",
      payload: {},
    });
    expect(selectChecksForEvent(dispatchContext)).toEqual([]);
  });
});

describe("syncMonitoredStatusesImpl", () => {
  it("fetches labels, workflow runs, and statuses once across multiple checks and skips unchanged statuses", async () => {
    const core = createMockCore();
    const github = createMockGithub();
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "Approved-Avocado" }],
    });
    github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
      data: [
        {
          name: "Swagger Avocado - Analyze Code",
          status: CheckStatus.COMPLETED,
          conclusion: CheckConclusion.FAILURE,
          updated_at: "2026-01-01",
          html_url: "https://test.com/avocado-run",
        },
        {
          name: "Swagger LintDiff - Analyze Code",
          status: CheckStatus.COMPLETED,
          conclusion: CheckConclusion.SUCCESS,
          updated_at: "2026-01-01",
          html_url: "https://test.com/lintdiff-run",
        },
      ],
    });
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: [{ name: "job-summary" }],
    });
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: {
        statuses: [
          {
            context: "Swagger LintDiff",
            state: CommitStatusState.SUCCESS,
            description: null,
            target_url: "https://test.com/lintdiff-run",
          },
          {
            context: "Swagger ModelValidation",
            state: CommitStatusState.PENDING,
            description: null,
            target_url: "https://test.com/previous-run",
          },
        ],
        total_count: 2,
      },
    });

    const result = await syncMonitoredStatusesImpl({
      owner: "test-owner",
      repo: "test-repo",
      head_sha: fullGitSha,
      issue_number: 123,
      target_url: "https://test.com/current-run",
      github,
      core,
      checks: MONITORED_STATUS_CHECKS.filter((c) =>
        ["Swagger Avocado", "Swagger LintDiff", "Swagger ModelValidation"].includes(
          c.requiredStatusName,
        ),
      ),
    });

    expect(github.rest.issues.listLabelsOnIssue).toHaveBeenCalledTimes(1);
    expect(github.rest.actions.listWorkflowRunsForRepo).toHaveBeenCalledTimes(1);
    expect(github.rest.repos.getCombinedStatusForRef).toHaveBeenCalledTimes(1);

    // LintDiff (already success) and ModelValidation (already pending fallback) are skipped.
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledTimes(1);
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: fullGitSha,
      state: CommitStatusState.SUCCESS,
      context: "Swagger Avocado",
      description: "Found label 'Approved-Avocado'",
      target_url: "https://test.com/avocado-run",
    });
    expect(result).toEqual({
      changedContexts: ["Swagger Avocado"],
      armSignoffRecheckNeeded: true,
    });
  });

  it("requests ARM signoff recheck when Avocado transitions to pending or on retry with unchanged status", async () => {
    const core = createMockCore();
    const github = createMockGithub();
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: {
        statuses: [
          {
            context: "Swagger Avocado",
            state: CommitStatusState.SUCCESS,
            description: "Found label 'Approved-Avocado'",
            target_url: "https://test.com/avocado-run",
          },
        ],
        total_count: 1,
      },
    });

    // Removing Approved-Avocado while analyzer hasn't finished moves success -> pending.
    const revocation = await syncMonitoredStatusesImpl({
      owner: "test-owner",
      repo: "test-repo",
      head_sha: fullGitSha,
      issue_number: 123,
      target_url: "https://test.com/current-run",
      github,
      core,
      checks: MONITORED_STATUS_CHECKS.filter((c) => c.requiredStatusName === "Swagger Avocado"),
    });
    expect(revocation).toEqual({
      changedContexts: ["Swagger Avocado"],
      armSignoffRecheckNeeded: true,
    });

    // Retrying an Avocado-targeted event after the status was already written still requests recheck.
    github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
      data: [
        {
          name: "Swagger Avocado - Analyze Code",
          status: CheckStatus.COMPLETED,
          conclusion: CheckConclusion.SUCCESS,
          updated_at: "2026-01-01",
          html_url: "https://test.com/avocado-run",
        },
      ],
    });
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: {
        statuses: [
          {
            context: "Swagger Avocado",
            state: CommitStatusState.SUCCESS,
            description: null,
            target_url: "https://test.com/avocado-run",
          },
        ],
        total_count: 1,
      },
    });
    const retry = await syncMonitoredStatusesImpl({
      owner: "test-owner",
      repo: "test-repo",
      head_sha: fullGitSha,
      issue_number: 123,
      target_url: "https://test.com/current-run",
      github,
      core,
      checks: MONITORED_STATUS_CHECKS.filter((c) => c.requiredStatusName === "Swagger Avocado"),
      eventTargetsArmSignoff: true,
    });
    expect(retry).toEqual({
      changedContexts: [],
      armSignoffRecheckNeeded: true,
    });
  });

  it("fails closed on unverified TypeSpec suppression approval and skips extra API calls for already-recorded failed runs", async () => {
    const core = createMockCore();
    const github = createMockGithub();
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "typespec-suppressions-approved" }],
    });
    github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
      data: [
        {
          id: 777,
          name: "TypeSpec Suppressions - Analyze Code",
          status: CheckStatus.COMPLETED,
          conclusion: CheckConclusion.FAILURE,
          updated_at: "2026-01-01",
          html_url: "https://test.com/actions/runs/777",
        },
        {
          id: 888,
          name: "Swagger ModelValidation - Analyze Code",
          status: CheckStatus.COMPLETED,
          conclusion: CheckConclusion.FAILURE,
          updated_at: "2026-01-01",
          html_url: "https://test.com/actions/runs/888",
        },
      ],
    });
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: [{ name: "job-summary" }],
    });
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: {
        statuses: [
          {
            context: "Swagger ModelValidation",
            state: CommitStatusState.FAILURE,
            description: null,
            target_url: "https://test.com/actions/runs/888/job/999?pr=123",
          },
        ],
        total_count: 1,
      },
    });

    const unverified = getUnverifiedOverrideContexts(
      Object.assign(createMockContext(), {
        eventName: "workflow_run",
        payload: {
          action: "completed",
          workflow_run: {
            name: "TypeSpec Suppressions - Analyze Code",
            conclusion: CheckConclusion.FAILURE,
          },
        },
      }),
      { suppressionsJobResult: "success", suppressionsApprovalVerified: "false" },
    );
    expect([...unverified]).toEqual(["TypeSpec Suppressions"]);

    const result = await syncMonitoredStatusesImpl({
      owner: "test-owner",
      repo: "test-repo",
      head_sha: fullGitSha,
      issue_number: 123,
      target_url: "https://test.com/current-run",
      github,
      core,
      checks: MONITORED_STATUS_CHECKS.filter((c) =>
        ["TypeSpec Suppressions", "Swagger ModelValidation"].includes(c.requiredStatusName),
      ),
      unverifiedOverrideContexts: unverified,
    });

    // Only TypeSpec Suppressions queried artifacts (ModelValidation reused its existing failed job URL).
    expect(github.rest.actions.listWorkflowRunArtifacts).toHaveBeenCalledTimes(1);
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledExactlyOnceWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: fullGitSha,
      state: CommitStatusState.FAILURE,
      context: "TypeSpec Suppressions",
      target_url: "https://test.com/actions/runs/777",
    });
    expect(result).toEqual({
      changedContexts: ["TypeSpec Suppressions"],
      armSignoffRecheckNeeded: false,
    });
  });

  it("syncs statuses on open PR and non-skipped workflow_run events, but skips workflow_dispatch", () => {
    expect(
      shouldSyncStatusesForEvent(
        Object.assign(createMockContext(), {
          eventName: "workflow_dispatch",
          payload: {},
        }),
      ),
    ).toBe(false);
    expect(
      shouldSyncStatusesForEvent(
        Object.assign(createMockContext(), {
          eventName: "workflow_run",
          payload: { workflow_run: { conclusion: CheckConclusion.SUCCESS } },
        }),
      ),
    ).toBe(true);
    expect(
      shouldSyncStatusesForEvent(
        Object.assign(createMockContext(), {
          eventName: "pull_request_target",
          payload: { pull_request: { state: "closed" } },
        }),
      ),
    ).toBe(false);
  });
});
