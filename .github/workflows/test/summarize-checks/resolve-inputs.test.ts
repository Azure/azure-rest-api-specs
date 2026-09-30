import { describe, expect, it, vi } from "vitest";
import { fullGitSha } from "../../../shared/test/examples.ts";
import { resolveSummaryInputs } from "../../src/summarize-checks/resolve-inputs.ts";
import summarizeChecks from "../../src/summarize-checks/summarize-checks.ts";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";
import { summaryResponse } from "./summary-data-fixtures.ts";

const repository = { id: 1, name: "repo", owner: { login: "owner" } };
const expected = { owner: "owner", repo: "repo", issue_number: 123, head_sha: fullGitSha };

describe("summary identity resolution", () => {
  it("resolves a direct PR event without reading mutable policy data", async () => {
    const github = createMockGithub();
    const core = createMockCore();
    const context = createMockContext();
    context.eventName = "pull_request_target";
    context.payload = {
      action: "labeled",
      repository,
      pull_request: { number: 123, head: { sha: fullGitSha } },
    };

    await expect(resolveSummaryInputs({ github, context, core })).resolves.toEqual(expected);

    expect(core.setOutput).toHaveBeenCalledExactlyOnceWith("issue_number", 123);
    expect(github.rest.issues.listLabelsOnIssue).not.toHaveBeenCalled();
    expect(github.rest.issues.listComments).not.toHaveBeenCalled();
    expect(github.rest.checks.listForRef).not.toHaveBeenCalled();
    expect(github.rest.repos.listCommitStatusesForRef).not.toHaveBeenCalled();
  });

  it("resolves fork PR identity from GitHub rather than untrusted artifacts", async () => {
    const github = createMockGithub();
    const core = createMockCore();
    const context = createMockContext();
    context.eventName = "workflow_run";
    context.payload = {
      action: "completed",
      workflow_run: {
        event: "pull_request",
        id: 456,
        head_sha: fullGitSha,
        repository,
        head_repository: { name: "fork", owner: { login: "contributor" } },
        pull_requests: [],
      },
    };
    github.rest.repos.listPullRequestsAssociatedWithCommit.mockResolvedValue({
      data: [{ number: 123, base: { repo: { id: 1 } } }],
    });

    await expect(resolveSummaryInputs({ github, context, core })).resolves.toEqual(expected);

    expect(github.rest.repos.listPullRequestsAssociatedWithCommit).toHaveBeenCalledTimes(1);
    expect(github.rest.actions.listWorkflowRunArtifacts).not.toHaveBeenCalled();
  });

  it("hands trusted artifact identity to the summary job without resolving it twice", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    core.summary.addLink = vi.fn().mockReturnValue(core.summary);
    core.summary.addHeading = vi.fn().mockReturnValue(core.summary);
    core.summary.addCodeBlock = vi.fn().mockReturnValue(core.summary);
    context.eventName = "workflow_run";
    context.payload = {
      action: "completed",
      workflow_run: { event: "check_run", id: 456, repository },
    };
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: { artifacts: [{ name: "issue-number=123" }, { name: `head-sha=${fullGitSha}` }] },
    });
    github.rest.issues.createComment.mockResolvedValue({ data: { id: 42 } });
    github.graphql.mockResolvedValue(summaryResponse({ headSha: fullGitSha }));
    const inputs = await resolveSummaryInputs({ github, context, core });
    expect(inputs).toEqual(expected);
    if (!inputs) throw new Error("Expected resolved inputs");

    await summarizeChecks({ github, context, core }, inputs);

    expect(github.rest.actions.listWorkflowRunArtifacts).toHaveBeenCalledTimes(1);
    expect(github.graphql).toHaveBeenCalledTimes(1);
    expect(github.rest.repos.listCommitStatusesForRef).not.toHaveBeenCalled();
    expect(core.setOutput).toHaveBeenCalledWith("head_sha", fullGitSha);
  });

  it("does not schedule a summary when trusted artifacts have no PR identity", async () => {
    const github = createMockGithub();
    const core = createMockCore();
    const context = createMockContext();
    context.eventName = "workflow_run";
    context.payload = {
      action: "completed",
      workflow_run: { event: "check_run", id: 456, repository },
    };
    await expect(resolveSummaryInputs({ github, context, core })).resolves.toBeNull();
    expect(core.setOutput).not.toHaveBeenCalled();
    expect(core.warning).toHaveBeenCalled();
  });

  it("rejects a known PR with an invalid head SHA", async () => {
    const context = createMockContext();
    context.eventName = "pull_request_target";
    context.payload = {
      action: "opened",
      repository,
      pull_request: { number: 123, head: { sha: "invalid" } },
    };
    await expect(
      resolveSummaryInputs({
        github: createMockGithub(),
        core: createMockCore(),
        context,
      }),
    ).rejects.toThrow("Invalid head SHA");
  });
});
