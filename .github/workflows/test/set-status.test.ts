import { strToU8, zipSync } from "fflate";
import { beforeEach, describe, expect, it } from "vitest";
import { CheckConclusion, CheckStatus, CommitStatusState } from "../../shared/src/github.ts";
import { fullGitSha } from "../../shared/test/examples.ts";
import { setStatusImpl } from "../src/set-status.ts";
import { createMockCore, createMockGithub } from "./mocks.ts";

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
          conclusion: CheckConclusion.SUCCESS,
          updated_at: "2026-09-29",
          html_url: "https://test.com/typespec-suppressions-report",
        },
      ],
    });
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: [{ id: 1, name: "typespec-suppressions-report" }],
    });
    github.rest.actions.downloadArtifact.mockResolvedValue({
      data: zipSync({
        "typespec-suppressions-report.json": strToU8(
          JSON.stringify({ checkedSuppressions: { requiresApproval: true } }),
        ),
      }),
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

  describe("suppression approval gate", () => {
    const reportUrl = "https://test.com/typespec-suppressions-report";

    function configureRun({
      status = CheckStatus.COMPLETED,
      conclusion = CheckConclusion.SUCCESS,
      name = "TypeSpec Suppressions - Analyze Code",
    }: { status?: string; conclusion?: string | null; name?: string } = {}) {
      github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
        data: [
          {
            id: 456,
            name,
            status,
            conclusion,
            updated_at: "2026-09-29",
            html_url: reportUrl,
          },
        ],
      });
    }

    function configureReport(content: string) {
      github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
        data: [{ id: 1, name: "typespec-suppressions-report" }],
      });
      github.rest.actions.downloadArtifact.mockResolvedValue({
        data: zipSync({ "typespec-suppressions-report.json": strToU8(content) }),
      });
    }

    function updateStatus() {
      return setStatusImpl({
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
    }

    it.each([
      { report: { requiresApproval: true }, state: CommitStatusState.FAILURE },
      { report: { requiresApproval: false }, state: CommitStatusState.SUCCESS },
      {
        report: { requiresApproval: false, checkedSuppressions: { requiresApproval: true } },
        state: CommitStatusState.FAILURE,
      },
      {
        report: { requiresApproval: true, checkedSuppressions: { requiresApproval: false } },
        state: CommitStatusState.SUCCESS,
      },
    ])(
      "uses report approval requirements rather than analyzer success: $report",
      async ({ report, state }) => {
        configureRun();
        configureReport(JSON.stringify(report));

        await updateStatus();

        expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
          expect.objectContaining({
            state,
            context: "TypeSpec Suppressions",
            target_url: reportUrl,
          }),
        );
      },
    );

    it("turns green on approval and red on revocation without changing the report", async () => {
      configureRun({ name: "[TEST-IGNORE] TypeSpec Suppressions - Analyze Code" });
      configureReport(JSON.stringify({ checkedSuppressions: { requiresApproval: true } }));

      await updateStatus();
      github.rest.issues.listLabelsOnIssue.mockResolvedValue({
        data: [{ name: "typespec-suppressions-approved" }],
      });
      await updateStatus();
      github.rest.issues.listLabelsOnIssue.mockResolvedValue({ data: [] });
      await updateStatus();

      expect(github.rest.repos.createCommitStatus).toHaveBeenCalledTimes(3);
      for (const [index, state] of [
        CommitStatusState.FAILURE,
        CommitStatusState.SUCCESS,
        CommitStatusState.FAILURE,
      ].entries()) {
        expect(github.rest.repos.createCommitStatus).toHaveBeenNthCalledWith(
          index + 1,
          expect.objectContaining({ state, target_url: reportUrl }),
        );
      }
      expect(github.rest.actions.deleteArtifact).not.toHaveBeenCalled();
      expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
    });

    it.each([
      CheckConclusion.FAILURE,
      CheckConclusion.CANCELLED,
      CheckConclusion.TIMED_OUT,
      CheckConclusion.NEUTRAL,
    ])("does not approve an unsuccessful analyzer: %s", async (conclusion) => {
      configureRun({ conclusion });
      github.rest.issues.listLabelsOnIssue.mockResolvedValue({
        data: [{ name: "typespec-suppressions-approved" }],
      });

      await updateStatus();

      expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
        expect.objectContaining({
          state: CommitStatusState.FAILURE,
          description: "Suppression analysis did not complete successfully",
        }),
      );
      expect(github.rest.actions.downloadArtifact).not.toHaveBeenCalled();
    });

    it.each([true, false])(
      "waits for analysis despite approval (run exists: %s)",
      async (hasRun) => {
        if (hasRun) configureRun({ status: CheckStatus.IN_PROGRESS, conclusion: null });
        github.rest.issues.listLabelsOnIssue.mockResolvedValue({
          data: [{ name: "typespec-suppressions-approved" }],
        });

        await updateStatus();

        expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
          expect.objectContaining({ state: CommitStatusState.PENDING }),
        );
      },
    );

    it.each([
      "not json",
      "null",
      "{}",
      '{"requiresApproval":"false"}',
      '{"requiresApproval":false,"checkedSuppressions":null}',
      '{"requiresApproval":false,"checkedSuppressions":{}}',
    ])("blocks and surfaces invalid reports even with approval: %s", async (content) => {
      configureRun();
      configureReport(content);
      github.rest.issues.listLabelsOnIssue.mockResolvedValue({
        data: [{ name: "typespec-suppressions-approved" }],
      });

      await expect(updateStatus()).rejects.toThrow();

      expect(core.error).toHaveBeenCalled();
      expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
        expect.objectContaining({
          state: CommitStatusState.FAILURE,
          target_url: reportUrl,
          description: "Unable to read suppression approval report",
        }),
      );
    });

    it("blocks when a successful analyzer has no report artifact", async () => {
      configureRun();

      await expect(updateStatus()).rejects.toThrow("Unable to find typespec-suppressions-report");

      expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
        expect.objectContaining({ state: CommitStatusState.FAILURE }),
      );
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
