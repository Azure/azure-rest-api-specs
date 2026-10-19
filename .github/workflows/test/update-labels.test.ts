import type { GitHubScriptArgs } from "../src/github.ts";
import { describe, expect, it } from "vitest";
import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import { fullGitSha } from "../../shared/test/examples.ts";
import updateLabelsSrc, { updateLabelsImpl } from "../src/update-labels.ts";
import { createMockCore, createMockGithub, createMockRequestError } from "./mocks.ts";

function updateLabels(asyncFunctionArgs: unknown) {
  return updateLabelsSrc(asyncFunctionArgs as GitHubScriptArgs);
}

describe("updateLabels", () => {
  it("loads inputs from context", async () => {
    const core = createMockCore();

    const github = createMockGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [{ name: "label-foo=true" }],
      },
    });

    const context = {
      eventName: "workflow_run",
      payload: {
        action: "completed",
        workflow_run: {
          event: "pull_request",
          head_sha: fullGitSha,
          id: 456,
          repository: {
            name: "TestRepoName",
            owner: {
              login: "TestRepoOwnerLogin",
            },
          },
          pull_requests: [{ number: 123 }],
        },
      },
    };

    await expect(updateLabels({ github, context, core })).resolves.toBeUndefined();

    expect(core.setOutput).toBeCalledWith("head_sha", fullGitSha);
    expect(core.setOutput).toBeCalledWith("issue_number", 123);

    expect(github.rest.actions.listWorkflowRunArtifacts).toBeCalledWith({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      run_id: 456,
      per_page: PER_PAGE_MAX,
    });
    expect(github.rest.issues.addLabels).toBeCalledWith({
      owner: "TestRepoOwnerLogin",
      repo: "TestRepoName",
      issue_number: 123,
      labels: ["foo"],
    });
    expect(github.rest.issues.removeLabel).toBeCalledTimes(0);
  });
});

describe("updateLabelsImpl", () => {
  describe("queued ARM signoff artifacts", () => {
    function fixture() {
      const github = createMockGithub();
      const pull = { state: "open", head: { sha: fullGitSha } };
      github.rest.pulls.get.mockResolvedValue({ data: pull });
      github.rest.issues.listLabelsOnIssue.mockResolvedValue({
        data: [{ name: "ARMReview" }],
      });
      github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
        data: {
          statuses: [
            {
              context: "ARM Semantic Review",
              state: "success",
              description: "Passed: full review completed with no Blocking findings",
              updated_at: "2026-01-01",
            },
            { context: "Swagger LintDiff", state: "success", updated_at: "2026-01-01" },
            { context: "Swagger Avocado", state: "success", updated_at: "2026-01-01" },
          ],
          total_count: 3,
        },
      });
      github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
        data: {
          artifacts: [{ name: "label-ARMSignedOff=true" }, { name: "label-ARMAutoSignedOff=true" }],
        },
      });
      const run = () =>
        updateLabelsImpl({
          owner: "owner",
          repo: "repo",
          head_sha: fullGitSha,
          issue_number: 123,
          run_id: 456,
          github,
          core: createMockCore(),
        });
      return { github, pull, run };
    }

    it("applies approval only after checking the current policy and statuses", async () => {
      const { github, run } = fixture();

      await run();

      expect(github.rest.repos.getCombinedStatusForRef).toHaveBeenCalledOnce();
      expect(github.rest.issues.addLabels).toHaveBeenCalledWith(
        expect.objectContaining({ labels: ["ARMSignedOff", "ARMAutoSignedOff"] }),
      );
    });

    it.each([{ state: "closed" }, { head: { sha: "a".repeat(40) } }])(
      "ignores queued approval after the PR changes: %j",
      async (change) => {
        const { github, pull, run } = fixture();
        github.rest.pulls.get.mockResolvedValue({ data: { ...pull, ...change } });

        await run();

        expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
        expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
        expect(github.rest.issues.listLabelsOnIssue).not.toHaveBeenCalled();
      },
    );

    it("does not approve while a same-head re-review is pending", async () => {
      const { github, run } = fixture();
      github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
        data: {
          statuses: [
            { context: "ARM Semantic Review", state: "pending", updated_at: "2026-01-02" },
          ],
          total_count: 1,
        },
      });

      await run();

      expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
    });

    it("does not take ownership of or revoke an unmarked human approval", async () => {
      const { github, run } = fixture();
      github.rest.issues.listLabelsOnIssue.mockResolvedValue({
        data: [{ name: "ARMReview" }, { name: "ARMSignedOff" }],
      });
      github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
        data: {
          artifacts: [
            { name: "label-ARMSignedOff=false" },
            { name: "label-ARMAutoSignedOff=false" },
          ],
        },
      });

      await run();

      expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
      expect(github.rest.repos.getCombinedStatusForRef).not.toHaveBeenCalled();
    });

    it("keeps non-ARM label actions when discarding stale approval", async () => {
      const { github, pull, run } = fixture();
      github.rest.pulls.get.mockResolvedValue({ data: { ...pull, state: "closed" } });
      github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
        data: {
          artifacts: [{ name: "label-ARMSignedOff=true" }, { name: "label-OtherLabel=true" }],
        },
      });

      await run();

      expect(github.rest.issues.addLabels).toHaveBeenCalledWith(
        expect.objectContaining({ labels: ["OtherLabel"] }),
      );
    });

    it("surfaces failed revalidation without applying approval", async () => {
      const { github, run } = fixture();
      github.rest.repos.getCombinedStatusForRef.mockRejectedValue(
        new Error("Status API unavailable"),
      );

      await expect(run()).rejects.toThrow("Status API unavailable");
      expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
    });
  });

  it("throws if no run_id", async () => {
    const github = createMockGithub();

    await expect(
      updateLabelsImpl({
        owner: "owner",
        repo: "repo",
        head_sha: fullGitSha,
        issue_number: 123,
        run_id: NaN,
        github: github,
        core: createMockCore(),
      }),
    ).rejects.toThrowErrorMatchingInlineSnapshot(
      `[Error: Required input 'run_id' not found in env or context]`,
    );

    expect(github.rest.issues.addLabels).toBeCalledTimes(0);
    expect(github.rest.issues.removeLabel).toBeCalledTimes(0);
  });

  it("handles missing issue_number", async () => {
    const github = createMockGithub();

    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [],
      },
    });

    // No labels to add/remove, so should no-op rather than throw, even if issue_number is missing
    await expect(
      updateLabelsImpl({
        owner: "owner",
        repo: "repo",
        head_sha: fullGitSha,
        issue_number: NaN,
        run_id: 456,
        github: github,
        core: createMockCore(),
      }),
    ).resolves.toBeUndefined();

    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [{ name: "label-foo=true" }],
      },
    });

    // Label to add/remove, but issue_number is missing, so throw
    await expect(
      updateLabelsImpl({
        owner: "owner",
        repo: "repo",
        head_sha: fullGitSha,
        issue_number: NaN,
        run_id: 456,
        github: github,
        core: createMockCore(),
      }),
    ).rejects.toThrow("issue_number");

    expect(github.rest.issues.addLabels).toBeCalledTimes(0);
    expect(github.rest.issues.removeLabel).toBeCalledTimes(0);
  });

  it("adds and removes labels for artifacts", async () => {
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [
          { name: "label-foo=true" },
          { name: "label-bar=true" },
          { name: "label-baz=false" },
          { name: "label-qux=false" },
          { name: "ignoredNoEquals" },
          { name: "=ignoredNoKey" },
          { name: "label=ignoredKeyNotStartsWithLabelDash" },
        ],
      },
    });

    await expect(
      updateLabelsImpl({
        owner: "owner",
        repo: "repo",
        head_sha: fullGitSha,
        issue_number: 123,
        run_id: 456,
        github: github,
        core: createMockCore(),
      }),
    ).resolves.toBeUndefined();

    expect(github.rest.actions.listWorkflowRunArtifacts).toBeCalledWith({
      owner: "owner",
      repo: "repo",
      run_id: 456,
      per_page: PER_PAGE_MAX,
    });
    expect(github.rest.issues.addLabels).toBeCalledWith({
      owner: "owner",
      repo: "repo",
      issue_number: 123,
      labels: ["foo", "bar"],
    });
    expect(github.rest.issues.removeLabel).toBeCalledTimes(2);
    expect(github.rest.issues.removeLabel).nthCalledWith(1, {
      owner: "owner",
      repo: "repo",
      issue_number: 123,
      name: "baz",
    });
    expect(github.rest.issues.removeLabel).nthCalledWith(2, {
      owner: "owner",
      repo: "repo",
      issue_number: 123,
      name: "qux",
    });
  });

  it("throws for invalid label value", async () => {
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [
          { name: "label-foo=true" },
          { name: "label-bar=false" },
          { name: "label-baz=invalid" },
        ],
      },
    });

    await expect(
      updateLabelsImpl({
        owner: "owner",
        repo: "repo",
        head_sha: fullGitSha,
        issue_number: 123,
        run_id: 456,
        github: github,
        core: createMockCore(),
      }),
    ).rejects.toThrowErrorMatchingInlineSnapshot(
      `[Error: Invalid value for label 'baz': invalid.  Expected "true" or "false".]`,
    );

    expect(github.rest.actions.listWorkflowRunArtifacts).toBeCalledWith({
      owner: "owner",
      repo: "repo",
      run_id: 456,
      per_page: PER_PAGE_MAX,
    });

    // Ensure no labels are added or removed if any are invalid
    expect(github.rest.issues.addLabels).toBeCalledTimes(0);
    expect(github.rest.issues.removeLabel).toBeCalledTimes(0);
  });

  it("throws for invalid label name", async () => {
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [
          { name: "label-foo=true" },
          { name: "label-bar=false" },
          { name: "label-=true" },
        ],
      },
    });

    await expect(
      updateLabelsImpl({
        owner: "owner",
        repo: "repo",
        head_sha: fullGitSha,
        issue_number: 123,
        run_id: 456,
        github: github,
        core: createMockCore(),
      }),
    ).rejects.toThrowErrorMatchingInlineSnapshot(`[Error: Invalid value for label name: '']`);

    expect(github.rest.actions.listWorkflowRunArtifacts).toBeCalledWith({
      owner: "owner",
      repo: "repo",
      run_id: 456,
      per_page: PER_PAGE_MAX,
    });

    // Ensure no labels are added or removed if any are invalid
    expect(github.rest.issues.addLabels).toBeCalledTimes(0);
    expect(github.rest.issues.removeLabel).toBeCalledTimes(0);
  });

  it.each([404, 500, 501])("handles error removing label (%s)", async (status) => {
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [{ name: "label-foo=false" }],
      },
    });
    github.rest.issues.removeLabel.mockRejectedValue(createMockRequestError(status));

    const updateLabelsImplPromise = updateLabelsImpl({
      owner: "owner",
      repo: "repo",
      head_sha: fullGitSha,
      issue_number: 123,
      run_id: 456,
      github: github,
      core: createMockCore(),
    });

    if (status == 404) {
      await expect(updateLabelsImplPromise).resolves.toBeUndefined();
    } else {
      await expect(updateLabelsImplPromise).rejects.toThrow();
    }

    expect(github.rest.actions.listWorkflowRunArtifacts).toBeCalledWith({
      owner: "owner",
      repo: "repo",
      run_id: 456,
      per_page: PER_PAGE_MAX,
    });
    expect(github.rest.issues.addLabels).toBeCalledTimes(0);
    expect(github.rest.issues.removeLabel).toBeCalledWith({
      owner: "owner",
      repo: "repo",
      issue_number: 123,
      name: "foo",
    });
  });
});
