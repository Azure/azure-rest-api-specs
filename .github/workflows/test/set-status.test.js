// @ts-check

import { beforeEach, describe, expect, it } from "vitest";
import { setStatusImpl } from "../src/set-status.js";

import { CheckConclusion, CheckStatus, CommitStatusState } from "../src/github.js";
import { createMockCore, createMockGithub } from "./mocks.js";

describe("setStatusImpl", () => {
  let core;
  let github;

  beforeEach(() => {
    core = createMockCore();
    github = createMockGithub();
  });

  it("throws if inputs null", async () => {
    await expect(setStatusImpl({})).rejects.toThrow();
  });

  it("sets success if approved by label", async () => {
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "test" }, { name: "Approved-Avocado" }],
    });

    await expect(
      setStatusImpl({
        owner: "test-owner",
        repo: "test-repo",
        head_sha: "test-head-sha",
        issue_number: 123,
        target_url: "https://test.com/set_status_url",
        github,
        core,
        monitoredWorkflowName: "[TEST-IGNORE] Swagger Avocado - Analyze Code",
        requiredStatusName: "[TEST-IGNORE] Swagger Avocado",
        overridingLabel: "Approved-Avocado",
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.repos.createCommitStatus).toBeCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: "test-head-sha",
      state: CommitStatusState.SUCCESS,
      context: "[TEST-IGNORE] Swagger Avocado",
      description: "Found label 'Approved-Avocado'",
      target_url: "https://test.com/set_status_url",
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
        head_sha: "test-head-sha",
        issue_number: 123,
        target_url: "https://test.com/set_status_url",
        github,
        core,
        monitoredWorkflowName: "[TEST-IGNORE] Swagger BreakingChange - Analyze Code",
        requiredStatusName: "[TEST-IGNORE] Swagger BreakingChange",
        overridingLabel:
          "BreakingChange-Approved-Benign,BreakingChange-Approved-BugFix,BreakingChange-Approved-UserImpact",
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.repos.createCommitStatus).toBeCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: "test-head-sha",
      state: CommitStatusState.SUCCESS,
      context: "[TEST-IGNORE] Swagger BreakingChange",
      description: "Found label 'BreakingChange-Approved-Benign'",
      target_url: "https://test.com/set_status_url",
    });
  });

  it("handles comma-separated labels with whitespace", async () => {
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "test" }, { name: "BreakingChange-Approved-UserImpact" }],
    });

    await expect(
      setStatusImpl({
        owner: "test-owner",
        repo: "test-repo",
        head_sha: "test-head-sha",
        issue_number: 123,
        target_url: "https://test.com/set_status_url",
        github,
        core,
        monitoredWorkflowName: "[TEST-IGNORE] Swagger BreakingChange - Analyze Code",
        requiredStatusName: "[TEST-IGNORE] Swagger BreakingChange",
        overridingLabel:
          "BreakingChange-Approved-Benign, BreakingChange-Approved-BugFix , BreakingChange-Approved-UserImpact",
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.repos.createCommitStatus).toBeCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: "test-head-sha",
      state: CommitStatusState.SUCCESS,
      context: "[TEST-IGNORE] Swagger BreakingChange",
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
        head_sha: "test-head-sha",
        issue_number: 123,
        target_url: "https://test.com/set_status_url",
        github,
        core,
        monitoredWorkflowName: "[TEST-IGNORE] Swagger BreakingChange - Analyze Code",
        requiredStatusName: "[TEST-IGNORE] Swagger BreakingChange",
        overridingLabel: "BreakingChange-Approved-Benign,,BreakingChange-Approved-Security,",
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.repos.createCommitStatus).toBeCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: "test-head-sha",
      state: CommitStatusState.SUCCESS,
      context: "[TEST-IGNORE] Swagger BreakingChange",
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
        head_sha: "test-head-sha",
        issue_number: 123,
        target_url: "https://test.com/set_status_url",
        github,
        core,
        monitoredWorkflowName: "[TEST-IGNORE] Swagger BreakingChange - Analyze Code",
        requiredStatusName: "[TEST-IGNORE] Swagger BreakingChange",
        overridingLabel:
          "BreakingChange-Approved-Benign,BreakingChange-Approved-BugFix,BreakingChange-Approved-UserImpact",
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.repos.createCommitStatus).toBeCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: "test-head-sha",
      state: CommitStatusState.PENDING,
      context: "[TEST-IGNORE] Swagger BreakingChange",
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
        head_sha: "test-head-sha",
        issue_number: 123,
        target_url: "https://test.com/set_status_url",
        github,
        core,
        monitoredWorkflowName: "[TEST-IGNORE] Swagger BreakingChange - Analyze Code",
        requiredStatusName: "[TEST-IGNORE] Swagger BreakingChange",
        overridingLabel: "",
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.repos.createCommitStatus).toBeCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: "test-head-sha",
      state: CommitStatusState.PENDING,
      context: "[TEST-IGNORE] Swagger BreakingChange",
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
              name: "[TEST-IGNORE] Swagger Avocado - Analyze Code",
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
          head_sha: "test-head-sha",
          issue_number: 123,
          target_url: "https://test.com/set_status_url",
          github,
          core,
          monitoredWorkflowName: "[TEST-IGNORE] Swagger Avocado - Analyze Code",
          requiredStatusName: "[TEST-IGNORE] Swagger Avocado",
          overridingLabel: "Approved-Avocado",
        }),
      ).resolves.toBeUndefined();

      expect(github.rest.repos.createCommitStatus).toBeCalledWith({
        owner: "test-owner",
        repo: "test-repo",
        sha: "test-head-sha",
        state: commitStatusState,
        context: "[TEST-IGNORE] Swagger Avocado",
        target_url: targetUrl,
      });
    },
  );
});
