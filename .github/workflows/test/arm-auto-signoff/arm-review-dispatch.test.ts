import { afterEach, describe, expect, it, vi } from "vitest";
import dispatchArmReview from "../../src/arm-auto-signoff/arm-review-dispatch.ts";
import { PASSED_REVIEW_DESCRIPTION } from "../../src/arm-auto-signoff/arm-semantic-review.ts";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

const headSha = "a".repeat(40);
function fixture() {
  vi.stubEnv("ARM_REVIEW_PR_NUMBER", "123");
  vi.stubEnv("ARM_REVIEW_HEAD_SHA", headSha);
  const github = createMockGithub();
  const core = createMockCore();
  const pull = {
    state: "open",
    draft: false,
    head: { sha: headSha },
    base: { repo: { default_branch: "main" } },
    labels: ["ARMReview", "WaitForARMFeedback"].map((name) => ({ name })),
  };
  github.rest.pulls.get.mockResolvedValue({ data: pull });
  const context = Object.assign(createMockContext(), {
    repo: { owner: "Azure", repo: "azure-rest-api-specs" },
    runId: 100,
    serverUrl: "https://github.com",
  });
  const run = () => dispatchArmReview({ github, core, context });
  return { github, core, pull, run };
}
afterEach(() => vi.unstubAllEnvs());

describe("summary to reviewer handoff", () => {
  it("explicitly dispatches an already-present queue label, bound to the summarized head", async () => {
    const { github, run } = fixture();
    await run();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        sha: headSha,
        state: "pending",
        context: "ARM Semantic Review",
      }),
    );
    expect(github.rest.actions.createWorkflowDispatch).toHaveBeenCalledExactlyOnceWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workflow_id: "arm-api-review.lock.yml",
      ref: "main",
      inputs: { pr_number: "123", head_sha: headSha },
    });
  });

  it.each(["pending", "failure", "error"])(
    "does not dispatch duplicate or looping %s reviews",
    async (state) => {
      const { github, run } = fixture();
      github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
        data: {
          statuses: [{ context: "ARM Semantic Review", state, updated_at: "2026-01-01" }],
          total_count: 1,
        },
      });
      await run();
      expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
      expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
    },
  );

  it("re-evaluates universal approval rather than repeating a completed review", async () => {
    const { github, run } = fixture();
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: {
        statuses: [
          {
            context: "ARM Semantic Review",
            state: "success",
            description: PASSED_REVIEW_DESCRIPTION,
            updated_at: "2026-01-01",
          },
        ],
        total_count: 1,
      },
    });
    await run();
    expect(github.rest.actions.createWorkflowDispatch).toHaveBeenCalledWith(
      expect.objectContaining({
        workflow_id: "arm-universal-auto-signoff.yaml",
        inputs: { pr_number: "123", head_sha: headSha },
      }),
    );
  });

  it.each([
    "stale",
    "closed",
    "draft",
    "unready",
    "signed",
    "changes-requested",
    "skip",
    "modeling",
  ])("does not dispatch after the PR becomes %s", async (condition) => {
    const { github, pull, run } = fixture();
    const added = {
      signed: "ARMSignedOff",
      "changes-requested": "ARMChangesRequested",
      skip: "skip-arm-review",
      modeling: "ARMModelingReviewRequired",
    }[condition];
    github.rest.pulls.get.mockResolvedValue({
      data: {
        ...pull,
        head: { sha: condition === "stale" ? "b".repeat(40) : headSha },
        state: condition === "closed" ? "closed" : "open",
        draft: condition === "draft",
        labels:
          condition === "unready" ? [] : [...pull.labels, ...(added ? [{ name: added }] : [])],
      },
    });
    await run();
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
  });

  it("reports a dispatch failure and allows a later summary to retry it", async () => {
    const { github, run } = fixture();
    github.rest.actions.createWorkflowDispatch.mockRejectedValueOnce(new Error("API unavailable"));
    await expect(run()).rejects.toThrow("API unavailable");
    expect(github.rest.repos.createCommitStatus).toHaveBeenNthCalledWith(
      2,
      expect.objectContaining({
        state: "error",
        description: "Review incomplete: reviewer dispatch failed",
      }),
    );
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: {
        statuses: [
          {
            context: "ARM Semantic Review",
            state: "error",
            description: "Review incomplete: reviewer dispatch failed",
            updated_at: "2026-01-01",
          },
        ],
        total_count: 1,
      },
    });
    await run();
    expect(github.rest.actions.createWorkflowDispatch).toHaveBeenCalledTimes(2);
  });
});
