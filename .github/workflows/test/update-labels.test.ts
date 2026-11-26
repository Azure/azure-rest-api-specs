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
  describe("explicit Universal handoff", () => {
    function fixture() {
      const github = createMockGithub();
      const core = createMockCore();
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
            { name: `head-sha=${fullGitSha}` },
            { name: "issue-number=123" },
            { name: "label-foo=true" },
          ],
        },
      });
      const run = (source = "456") =>
        updateLabels({
          github,
          core,
          context: {
            eventName: "workflow_dispatch",
            repo: { owner: "Azure", repo: "azure-rest-api-specs" },
            payload: { inputs: { source_run_id: source } },
          },
        });
      return { github, core, run };
    }

    it("reads already-uploaded artifacts from the trusted running Universal run", async () => {
      const { github, run } = fixture();
      await run();
      expect(github.rest.actions.getWorkflowRun).toHaveBeenCalledWith({
        owner: "Azure",
        repo: "azure-rest-api-specs",
        run_id: 456,
      });
      expect(github.rest.issues.addLabels).toHaveBeenCalledWith({
        owner: "Azure",
        repo: "azure-rest-api-specs",
        issue_number: 123,
        labels: ["foo"],
      });
    });

    it.each(["", "0", "123abc"])("rejects invalid source ID %j", async (value) => {
      const { github, run } = fixture();
      await expect(run(value)).rejects.toThrow("positive source run ID");
      expect(github.rest.actions.getWorkflowRun).not.toHaveBeenCalled();
    });

    it.each([
      { path: ".github/workflows/untrusted.yaml", event: "workflow_dispatch" },
      { path: ".github/workflows/arm-universal-auto-signoff.yaml", event: "pull_request" },
    ])("rejects untrusted source %j", async (source) => {
      const { github, run } = fixture();
      github.rest.actions.getWorkflowRun.mockResolvedValue({ data: source });
      await expect(run()).rejects.toThrow("must be a Universal signoff run");
      expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
      expect(github.rest.actions.listWorkflowRunArtifacts).not.toHaveBeenCalled();
    });

    it("rejects missing source correlation without applying labels", async () => {
      const { github, run } = fixture();
      github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
        data: { artifacts: [{ name: "label-foo=true" }] },
      });
      await expect(run()).rejects.toThrow("Invalid value for 'issue_number'");
      expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
    });
  });

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
  it("removes ARMSignedOff before its markers so a partial revoke never looks human-owned", async () => {
    const github = createMockGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: {
        artifacts: [{ name: "label-ARMAutoSignedOff=false" }, { name: "label-ARMSignedOff=false" }],
      },
    });
    github.rest.issues.removeLabel.mockRejectedValueOnce(new Error("remove failed"));

    await expect(
      updateLabelsImpl({
        owner: "owner",
        repo: "repo",
        head_sha: fullGitSha,
        issue_number: 123,
        run_id: 456,
        github,
        core: createMockCore(),
      }),
    ).rejects.toThrow("remove failed");

    expect(github.rest.issues.removeLabel).toHaveBeenCalledOnce();
    expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
      expect.objectContaining({ name: "ARMSignedOff" }),
    );
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
