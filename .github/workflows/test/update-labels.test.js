import { describe, expect, it } from "vitest";
import { PER_PAGE_MAX } from "../../shared/src/github.js";
import { fullGitSha } from "../../shared/test/examples.js";
import updateLabels, { updateLabelsImpl } from "../src/update-labels.js";
import { createMockCore, createMockGithub, createMockRequestError } from "./mocks.js";

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
  it("throws if no run_id", async () => {
    const github = createMockGithub();

    await expect(
      updateLabelsImpl({
        owner: "owner",
        repo: "repo",
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
