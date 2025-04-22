import { beforeEach, describe, expect, it } from "vitest";
import { setStatusImpl } from "../src/avocado-status.js";

import {
  CheckConclusion,
  CheckStatus,
  CommitStatusState,
} from "../src/github.js";
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
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.repos.createCommitStatus).toBeCalledWith({
      owner: "test-owner",
      repo: "test-repo",
      sha: "test-head-sha",
      state: CommitStatusState.SUCCESS,
      context: "[TEST IGNORE] Swagger Avocado",
      description: "Found label 'Approved-Avocado'",
      target_url: "https://test.com/set_status_url",
    });
  });

  it.each([
    [
      CheckStatus.COMPLETED,
      CheckConclusion.SUCCESS,
      CommitStatusState.SUCCESS,
      "https://test.com/workflow_run_html_url",
    ],
    [
      CheckStatus.COMPLETED,
      CheckConclusion.FAILURE,
      CommitStatusState.FAILURE,
      "https://test.com/job_html_url?pr=123",
    ],
    [
      CheckStatus.IN_PROGRESS,
      null,
      CommitStatusState.PENDING,
      "https://test.com/workflow_run_html_url",
    ],
    [null, null, CommitStatusState.PENDING, "https://test.com/set_status_url"],
  ])(
    "(%s, %s, %s) => %s",
    async (checkStatus, checkConclusion, commitStatusState, targetUrl) => {
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
        }),
      ).resolves.toBeUndefined();

      expect(github.rest.repos.createCommitStatus).toBeCalledWith({
        owner: "test-owner",
        repo: "test-repo",
        sha: "test-head-sha",
        state: commitStatusState,
        context: "[TEST IGNORE] Swagger Avocado",
        target_url: targetUrl,
      });
    },
  );
});
