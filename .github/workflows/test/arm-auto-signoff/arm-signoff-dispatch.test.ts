import { describe, expect, it } from "vitest";
import {
  dispatchUniversalSignoff,
  dispatchUpdateLabels,
  parseSignoffDispatchInputs,
} from "../../src/arm-auto-signoff/arm-signoff-dispatch.ts";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";
import getLabelAction from "../../src/arm-auto-signoff/arm-universal-auto-signoff.ts";
import updateLabels from "../../src/update-labels.ts";

const sha = "a".repeat(40);

function fixture() {
  const github = createMockGithub();
  const core = createMockCore();
  const context = Object.assign(createMockContext(), {
    runId: 456,
    repo: { owner: "Azure", repo: "azure-rest-api-specs" },
    payload: { repository: { default_branch: "main" } },
  });
  github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
    data: { artifacts: [{ name: `head-sha=${sha};issue-number=123` }] },
  });
  return { github, core, context, run: () => dispatchUniversalSignoff({ github, context, core }) };
}

describe("reviewer to Universal dispatch", () => {
  it("dispatches using trusted artifacts and the base repository default branch", async () => {
    const { github, run } = fixture();
    await run();
    expect(github.rest.actions.createWorkflowDispatch).toHaveBeenCalledExactlyOnceWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workflow_id: "arm-universal-auto-signoff.yaml",
      ref: "main",
      inputs: { pr_number: "123", head_sha: sha },
    });
    expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("skips runs that never established trusted reviewer correlation", async () => {
    const { github, core, run } = fixture();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({ data: { artifacts: [] } });
    await run();
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith(
      expect.stringContaining("No trusted reviewer correlation"),
    );
  });

  it("rejects conflicting reviewer heads", async () => {
    const { github, run } = fixture();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [
          { name: `head-sha=${sha};issue-number=123` },
          { name: `head-sha=${"b".repeat(40)}` },
        ],
      },
    });
    await expect(run()).rejects.toThrow("Conflicting head-sha");
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
  });

  it("surfaces dispatch failures without changing the review outcome", async () => {
    const { github, run } = fixture();
    github.rest.actions.createWorkflowDispatch.mockRejectedValue(new Error("Dispatch unavailable"));
    await expect(run()).rejects.toThrow("Dispatch unavailable");
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });
});

describe("Universal to Update Labels dispatch", () => {
  it("dispatches Update Labels on the default branch with this run as the source", async () => {
    const { github, core, context } = fixture();
    await dispatchUpdateLabels({ github, context, core });
    expect(github.rest.actions.createWorkflowDispatch).toHaveBeenCalledExactlyOnceWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      workflow_id: "update-labels.yaml",
      ref: "main",
      inputs: { source_run_id: "456" },
    });
  });

  it("refuses to dispatch without the default branch", async () => {
    const { github, core } = fixture();
    const context = Object.assign(createMockContext(), {
      runId: 456,
      repo: { owner: "Azure", repo: "azure-rest-api-specs" },
      payload: {},
    });
    await expect(dispatchUpdateLabels({ github, context, core })).rejects.toThrow(
      "requires the repository default branch",
    );
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
  });
});

describe("Universal dispatch inputs", () => {
  it("preserves the reviewed SHA instead of substituting the live PR head", () => {
    expect(parseSignoffDispatchInputs({ pr_number: "123", head_sha: sha })).toEqual({
      issue_number: 123,
      head_sha: sha,
    });
  });

  describe("explicit handoff preserves Universal eligibility checks", () => {
    it.each([
      { semanticState: "success", currentSha: sha, expectedAdds: 1 },
      { semanticState: "failure", currentSha: sha, expectedAdds: 0 },
      { semanticState: "success", currentSha: "b".repeat(40), expectedAdds: 0 },
    ])(
      "applies Universal's decision through Update Labels: %j",
      async ({ semanticState, currentSha, expectedAdds }) => {
        const { github, core, context } = fixture();
        github.rest.pulls.get.mockResolvedValue({
          data: { state: "open", head: { sha: currentSha } },
        });
        github.rest.issues.listLabelsOnIssue.mockResolvedValue({ data: [{ name: "ARMReview" }] });
        github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
          data: {
            statuses: [
              { context: "ARM Semantic Review", state: semanticState, updated_at: "2026-01-01" },
              { context: "Swagger LintDiff", state: "success", updated_at: "2026-01-01" },
              { context: "Swagger Avocado", state: "success", updated_at: "2026-01-01" },
            ],
            total_count: 3,
          },
        });
        const decision = await getLabelAction({
          github,
          core,
          context: {
            ...context,
            issue: { owner: "Azure", repo: "azure-rest-api-specs", number: 123 },
            eventName: "workflow_dispatch",
            payload: { inputs: { pr_number: "123", head_sha: sha } },
          },
        });
        github.rest.actions.getWorkflowRun.mockResolvedValue({
          data: {
            path: ".github/workflows/arm-universal-auto-signoff.yaml",
            event: "workflow_dispatch",
            status: "in_progress",
            conclusion: null,
          },
        });
        github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
          data: {
            artifacts: [
              { name: `head-sha=${sha};issue-number=123` },
              ...Object.entries(decision.labelActions)
                .filter(([, action]) => action !== "none")
                .map(([name, action]) => ({ name: `label-${name}=${action === "add"}` })),
            ],
          },
        });

        await updateLabels({
          github,
          core,
          context: {
            ...context,
            issue: { owner: "Azure", repo: "azure-rest-api-specs", number: 123 },
            eventName: "workflow_dispatch",
            payload: { inputs: { source_run_id: "456" } },
          },
        });

        expect(github.rest.issues.addLabels).toHaveBeenCalledTimes(expectedAdds);
        if (expectedAdds) {
          expect(github.rest.issues.addLabels).toHaveBeenCalledWith({
            owner: "Azure",
            repo: "azure-rest-api-specs",
            issue_number: 123,
            labels: ["ARMSignedOff", "ARMAutoSignedOff"],
          });
        }
      },
    );
  });

  it.each([
    undefined,
    { pr_number: "0", head_sha: sha },
    { pr_number: "123abc", head_sha: sha },
    { pr_number: "123", head_sha: "short" },
  ])("rejects malformed identity %j", (inputs) => {
    expect(() => parseSignoffDispatchInputs(inputs)).toThrow(
      "positive PR number and full head SHA",
    );
  });
});
