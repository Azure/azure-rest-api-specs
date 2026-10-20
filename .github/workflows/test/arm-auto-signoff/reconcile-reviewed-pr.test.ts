import { describe, expect, it, vi } from "vitest";
import { reconcileReviewedPr } from "../../src/arm-auto-signoff/reconcile-reviewed-pr.ts";
import { summarizeChecksImpl } from "../../src/summarize-checks/summarize-checks.ts";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

vi.mock("../../src/summarize-checks/summarize-checks.ts", () => ({
  summarizeChecksImpl: vi.fn(),
}));

const headSha = "a".repeat(40);

function fixture() {
  const github = createMockGithub();
  const core = createMockCore();
  const context = Object.assign(createMockContext(), {
    serverUrl: "https://github.com",
    runId: 456,
    eventName: "workflow_dispatch",
  });
  github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
    data: { artifacts: [{ name: `head-sha=${headSha};issue-number=123` }] },
  });
  return { github, core, context, run: () => reconcileReviewedPr({ github, core, context }) };
}

describe("reviewer completion", () => {
  it("calls the shared reconciler with its own trusted reviewed head, without dispatching", async () => {
    const { github, core, run } = fixture();
    await run();
    expect(summarizeChecksImpl).toHaveBeenCalledWith(
      github,
      core,
      "owner",
      "repo",
      123,
      headSha,
      "workflow_dispatch",
      undefined,
      "https://github.com/owner/repo/actions/runs/456",
    );
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
    expect(github.rest.actions.listWorkflowRunArtifacts).toHaveBeenCalledOnce();
  });

  it("skips a rejected activation without trusted correlation", async () => {
    const { github, core, run } = fixture();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({ data: { artifacts: [] } });
    await run();
    expect(core.info).toHaveBeenCalledWith(
      "No trusted reviewer correlation; PR reconciliation skipped",
    );
  });

  it("rejects conflicting heads instead of substituting the live head", async () => {
    const { github, run } = fixture();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [{ name: `head-sha=${headSha}` }, { name: `head-sha=${"b".repeat(40)}` }],
      },
    });
    await expect(run()).rejects.toThrow("Conflicting head-sha");
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
  });

  it("surfaces reconciliation failures to the workflow", async () => {
    const { run } = fixture();
    vi.mocked(summarizeChecksImpl).mockRejectedValueOnce(new Error("GitHub unavailable"));
    await expect(run()).rejects.toThrow("GitHub unavailable");
  });
});
