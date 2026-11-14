import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { describe, expect, it } from "vitest";
import { parse } from "yaml";
import {
  ARM_INITIAL_REVIEW_REQUESTED_LABEL,
  dispatchArmReview,
} from "../../src/arm-auto-signoff/arm-review-dispatch.ts";
import { createMockCore, createMockGithub } from "../mocks.ts";

const headSha = "a".repeat(40);
const sourceUrl = "https://github.com/Azure/azure-rest-api-specs/actions/runs/456";

function fixture() {
  const github = createMockGithub();
  const core = createMockCore();
  const pull = {
    state: "open",
    draft: false,
    head: { sha: headSha },
    labels: ["ARMReview", "WaitForARMFeedback"].map((name) => ({ name })),
    base: { repo: { default_branch: "main" } },
  };
  github.rest.pulls.get.mockResolvedValue({ data: pull });
  return {
    github,
    core,
    pull,
    run: () =>
      dispatchArmReview(github, core, "Azure", "azure-rest-api-specs", 123, headSha, sourceUrl),
  };
}

describe("per-head automatic ARM review dispatch", () => {
  it.each([0, 1.5])("rejects invalid PR number %s", async (number) => {
    const { github, core } = fixture();
    await expect(
      dispatchArmReview(github, core, "Azure", "azure-rest-api-specs", number, headSha, sourceUrl),
    ).rejects.toThrow("requires a PR number and full head SHA");
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
  });

  it("reserves the marker before status and dispatch", async () => {
    const { github, run } = fixture();
    await run();
    expect(github.rest.issues.addLabels).toHaveBeenCalledExactlyOnceWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      issue_number: 123,
      labels: [ARM_INITIAL_REVIEW_REQUESTED_LABEL],
    });
    expect(github.rest.issues.addLabels.mock.invocationCallOrder[0]).toBeLessThan(
      github.rest.repos.createCommitStatus.mock.invocationCallOrder[0],
    );
    expect(github.rest.repos.createCommitStatus.mock.invocationCallOrder[0]).toBeLessThan(
      github.rest.actions.createWorkflowDispatch.mock.invocationCallOrder[0],
    );
    expect(github.rest.actions.createWorkflowDispatch).toHaveBeenCalledExactlyOnceWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workflow_id: "arm-api-review.lock.yml",
      ref: "main",
      inputs: { pr_number: "123", head_sha: headSha, reservation_url: sourceUrl },
    });
  });

  it("dispatches a marked PR on a new SHA without rewriting the legacy marker", async () => {
    const { github, pull, run } = fixture();
    pull.labels.push({ name: ARM_INITIAL_REVIEW_REQUESTED_LABEL });
    await run();
    expect(github.rest.repos.getCombinedStatusForRef).toHaveBeenCalledWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      ref: headSha,
      per_page: 100,
      page: 1,
    });
    expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(github.rest.actions.createWorkflowDispatch).toHaveBeenCalledOnce();
  });

  it("dispatches fork PRs only in the base repository on its trusted default branch", async () => {
    const { github, pull, run } = fixture();
    github.rest.pulls.get.mockResolvedValue({
      data: {
        ...pull,
        head: {
          sha: headSha,
          ref: "untrusted-branch",
          repo: { full_name: "external-user/fork", default_branch: "untrusted-default" },
        },
        base: { ref: "release-branch", repo: { default_branch: "trusted-main" } },
      },
    });

    await run();

    expect(github.rest.actions.createWorkflowDispatch).toHaveBeenCalledExactlyOnceWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workflow_id: "arm-api-review.lock.yml",
      ref: "trusted-main",
      inputs: { pr_number: "123", head_sha: headSha, reservation_url: sourceUrl },
    });
  });

  it("keeps the expected head when the PR advances after reservation", async () => {
    const { github, pull, run } = fixture();
    github.rest.repos.createCommitStatus.mockImplementationOnce(() => {
      pull.head.sha = "b".repeat(40);
      return Promise.resolve();
    });

    await run();

    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledExactlyOnceWith(
      expect.objectContaining({ sha: headSha, target_url: sourceUrl }),
    );
    expect(github.rest.actions.createWorkflowDispatch).toHaveBeenCalledExactlyOnceWith(
      expect.objectContaining({
        inputs: { pr_number: "123", head_sha: headSha, reservation_url: sourceUrl },
      }),
    );
  });

  it.each([false, true])("fails closed on status API errors with marker: %s", async (marked) => {
    const { github, pull, run } = fixture();
    if (marked) pull.labels.push({ name: ARM_INITIAL_REVIEW_REQUESTED_LABEL });
    github.rest.repos.getCombinedStatusForRef.mockRejectedValue(new Error("Statuses unavailable"));

    await expect(run()).rejects.toThrow("Statuses unavailable");

    expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
  });

  describe.each([false, true])("existing marker: %s", (marked) => {
    it.each([
      { state: "pending", description: "ARM API semantic review is queued" },
      { state: "success", description: "Passed: full review completed" },
      { state: "failure", description: "Changes requested: 1 Blocking finding(s)" },
      { state: "error", description: "Review incomplete: tool-failure" },
      { state: "error", description: "Review incomplete: cancelled" },
      { state: "error", description: "Manual review required: scoped review" },
    ])("does not automatically retry current-head evidence: %j", async (status) => {
      const { github, pull, run } = fixture();
      if (marked) pull.labels.push({ name: ARM_INITIAL_REVIEW_REQUESTED_LABEL });
      github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
        data: {
          statuses: [{ context: "ARM Semantic Review", updated_at: "2026-01-01", ...status }],
          total_count: 1,
        },
      });

      await run();

      expect(github.rest.pulls.get).toHaveBeenCalledOnce();
      expect(github.rest.repos.getCombinedStatusForRef).toHaveBeenCalledOnce();
      expect(github.rest.issues.addLabels).toHaveBeenCalledTimes(marked ? 0 : 1);
      expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
      expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
    });
  });

  it("does not repeat a successful handoff when Summarize Checks runs again", async () => {
    const { github, pull, run } = fixture();
    await run();
    pull.labels.push({ name: ARM_INITIAL_REVIEW_REQUESTED_LABEL });
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: {
        statuses: [
          {
            context: "ARM Semantic Review",
            state: "pending",
            target_url: sourceUrl,
            updated_at: "2026-01-01",
          },
        ],
        total_count: 1,
      },
    });

    await run();

    expect(github.rest.actions.createWorkflowDispatch).toHaveBeenCalledOnce();
    expect(github.rest.issues.addLabels).toHaveBeenCalledOnce();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledOnce();
  });

  it("preserves a concurrent explicit review that starts before reservation", async () => {
    const { github, run } = fixture();
    github.rest.repos.getCombinedStatusForRef
      .mockResolvedValueOnce({ data: { statuses: [], total_count: 0 } })
      .mockResolvedValueOnce({
        data: {
          statuses: [
            {
              context: "ARM Semantic Review",
              state: "pending",
              target_url: `${sourceUrl}/attempts/1`,
              updated_at: "2026-01-01",
            },
          ],
          total_count: 1,
        },
      });

    await run();

    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
  });

  it("fails closed if the final status recheck is unavailable", async () => {
    const { github, run } = fixture();
    github.rest.repos.getCombinedStatusForRef
      .mockResolvedValueOnce({ data: { statuses: [], total_count: 0 } })
      .mockRejectedValueOnce(new Error("Status recheck unavailable"));

    await expect(run()).rejects.toThrow("Status recheck unavailable");

    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
  });

  const queued = ["ARMReview", "WaitForARMFeedback"];
  it.each([
    { state: "closed" },
    { draft: true },
    { head: { sha: "b".repeat(40) } },
    { labels: [{ name: "WaitForARMFeedback" }] },
    { labels: [{ name: "ARMReview" }] },
    ...[
      "ARMChangesRequested",
      "NotReadyForARMReview",
      "ARMManualSignoffRequired",
      "ARMSignedOff",
      "skip-arm-review",
    ].map((hold) => ({ labels: [...queued, hold].map((name) => ({ name })) })),
  ])("skips ineligible or held PRs before reading statuses: %j", async (change) => {
    const { github, pull, run } = fixture();
    github.rest.pulls.get.mockResolvedValue({ data: { ...pull, ...change } });

    await run();

    expect(github.rest.repos.getCombinedStatusForRef).not.toHaveBeenCalled();
    expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
  });

  it.each([
    { head: { sha: "b".repeat(40) } },
    { labels: [...queued, "ARMManualSignoffRequired"].map((name) => ({ name })) },
  ])("rechecks mutable PR state before reservation: %j", async (change) => {
    const { github, pull, run } = fixture();
    github.rest.pulls.get
      .mockResolvedValueOnce({ data: pull })
      .mockResolvedValueOnce({ data: { ...pull, ...change } });
    await run();
    expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
  });

  it("does not dispatch if marker reservation fails", async () => {
    const { github, run } = fixture();
    github.rest.issues.addLabels.mockRejectedValue(new Error("Label write failed"));
    await expect(run()).rejects.toThrow("Label write failed");
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
  });

  it("can retry a failed status write without having dispatched AI", async () => {
    const { github, core, pull, run } = fixture();
    github.rest.repos.createCommitStatus.mockRejectedValueOnce(new Error("Pending write failed"));

    await expect(run()).rejects.toThrow("Pending write failed");

    expect(github.rest.issues.addLabels).toHaveBeenCalledOnce();
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    expect(core.error).toHaveBeenCalledWith(expect.stringContaining("retrying with /arm-review"));
    expect(core.error).toHaveBeenCalledWith(
      expect.stringContaining("No workflow dispatch was attempted; without a saved status"),
    );

    pull.labels.push({ name: ARM_INITIAL_REVIEW_REQUESTED_LABEL });
    await run();

    expect(github.rest.issues.addLabels).toHaveBeenCalledOnce();
    expect(github.rest.actions.createWorkflowDispatch).toHaveBeenCalledOnce();
  });

  it("retains same-head evidence if a failed pending-status response actually saved the status", async () => {
    const { github, pull, run } = fixture();
    github.rest.repos.createCommitStatus.mockImplementationOnce(() => {
      github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
        data: {
          statuses: [
            {
              context: "ARM Semantic Review",
              state: "pending",
              target_url: sourceUrl,
              updated_at: "2026-01-01",
            },
          ],
          total_count: 1,
        },
      });
      return Promise.reject(new Error("Pending response lost"));
    });

    await expect(run()).rejects.toThrow("Pending response lost");

    expect(github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
      expect.objectContaining({ state: "error", target_url: sourceUrl }),
    );
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: {
        statuses: [
          {
            context: "ARM Semantic Review",
            state: "error",
            target_url: sourceUrl,
            updated_at: "2026-01-01",
          },
        ],
        total_count: 1,
      },
    });
    pull.labels.push({ name: ARM_INITIAL_REVIEW_REQUESTED_LABEL });

    await run();

    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledTimes(2);
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
  });

  it("keeps current-head evidence on ambiguous dispatch failure and prevents automatic retries", async () => {
    const { github, core, pull, run } = fixture();
    github.rest.repos.getCombinedStatusForRef
      .mockResolvedValueOnce({ data: { statuses: [], total_count: 0 } })
      .mockResolvedValueOnce({ data: { statuses: [], total_count: 0 } })
      .mockResolvedValueOnce({
        data: {
          statuses: [
            {
              context: "ARM Semantic Review",
              state: "pending",
              target_url: sourceUrl,
              updated_at: "2026-01-01",
            },
          ],
          total_count: 1,
        },
      });
    github.rest.actions.createWorkflowDispatch.mockRejectedValueOnce(new Error("Connection lost"));
    await expect(run()).rejects.toThrow("Connection lost");
    expect(github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
      expect.objectContaining({
        state: "error",
        description: "Review incomplete: reviewer dispatch failed; retry with /arm-review",
      }),
    );
    expect(core.error).toHaveBeenCalledWith(
      expect.stringContaining("Check for a queued or running reviewer before retrying"),
    );
    expect(core.error).toHaveBeenCalledWith(
      expect.stringContaining("The dispatch may have been accepted despite the error"),
    );
    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    pull.labels.push({ name: ARM_INITIAL_REVIEW_REQUESTED_LABEL });
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: {
        statuses: [
          {
            context: "ARM Semantic Review",
            state: "error",
            target_url: sourceUrl,
            updated_at: "2026-01-01",
          },
        ],
        total_count: 1,
      },
    });
    await run();
    expect(github.rest.actions.createWorkflowDispatch).toHaveBeenCalledOnce();
  });

  it.each([
    { state: "pending", target_url: `${sourceUrl}/attempts/1` },
    { state: "success", target_url: sourceUrl },
  ])("does not overwrite a started review's status when dispatch fails: %j", async (status) => {
    const { github, run } = fixture();
    github.rest.repos.getCombinedStatusForRef
      .mockResolvedValueOnce({ data: { statuses: [], total_count: 0 } })
      .mockResolvedValueOnce({ data: { statuses: [], total_count: 0 } })
      .mockResolvedValueOnce({
        data: {
          statuses: [{ context: "ARM Semantic Review", updated_at: "2026-01-01", ...status }],
          total_count: 1,
        },
      });
    github.rest.actions.createWorkflowDispatch.mockRejectedValue(new Error("Timeout"));
    await expect(run()).rejects.toThrow("Timeout");
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledOnce();
  });

  it("surfaces both dispatch and cleanup errors", async () => {
    const { github, run } = fixture();
    github.rest.actions.createWorkflowDispatch.mockRejectedValue(new Error("Dispatch failed"));
    github.rest.repos.getCombinedStatusForRef
      .mockResolvedValueOnce({ data: { statuses: [], total_count: 0 } })
      .mockResolvedValueOnce({ data: { statuses: [], total_count: 0 } })
      .mockRejectedValueOnce(new Error("Status API failed"));
    await expect(run()).rejects.toThrow("dispatch and queued-status cleanup both failed");
  });

  it("isolates label-write permissions and serializes automatic dispatch per PR", async () => {
    const workflow: unknown = parse(
      await readFile(join(import.meta.dirname, "..", "..", "summarize-checks.yaml"), "utf8"),
    );
    expect(workflow).toMatchObject({
      permissions: { contents: "read" },
      jobs: {
        "run-summarize-checks": {
          permissions: {
            actions: "read",
            checks: "read",
            statuses: "write",
            issues: "write",
            "pull-requests": "write",
          },
        },
        "dispatch-arm-review": {
          needs: "run-summarize-checks",
          permissions: { actions: "write", statuses: "write", "pull-requests": "write" },
          concurrency: {
            group:
              "arm-initial-review-dispatch-${{ needs.run-summarize-checks.outputs.issue_number }}",
            "cancel-in-progress": false,
          },
        },
      },
    });
  });
});
