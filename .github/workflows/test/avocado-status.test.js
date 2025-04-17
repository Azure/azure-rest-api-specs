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
        target_url: "https://test.com/target_url",
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
      target_url: "https://test.com/target_url",
    });
  });

  it.each([CheckConclusion.SUCCESS, CheckConclusion.FAILURE])(
    "sets state to code run conclusion: %s",
    async (state) => {
      github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
        data: [
          {
            name: "[TEST-IGNORE] Swagger Avocado - Analyze Code",
            status: CheckStatus.COMPLETED,
            conclusion: state,
            updated_at: "2025-01-01",
            html_url: "https://test.com/workflow_run_html_url",
          },
        ],
      });

      github.rest.actions.listJobsForWorkflowRun.mockResolvedValue({
        data: [
          { conclusion: state, html_url: "https://test.com/job_html_url" },
        ],
      });

      await expect(
        setStatusImpl({
          owner: "test-owner",
          repo: "test-repo",
          head_sha: "test-head-sha",
          issue_number: 123,
          target_url: "https://test.com/target_url",
          github,
          core,
        }),
      ).resolves.toBeUndefined();

      expect(github.rest.repos.createCommitStatus).toBeCalledWith({
        owner: "test-owner",
        repo: "test-repo",
        sha: "test-head-sha",
        state,
        context: "[TEST IGNORE] Swagger Avocado",
        target_url:
          state === CheckConclusion.SUCCESS
            ? "https://test.com/workflow_run_html_url"
            : "https://test.com/job_html_url?pr=123",
      });
    },
  );
});
