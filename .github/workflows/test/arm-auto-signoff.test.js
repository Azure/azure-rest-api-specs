import { describe, expect, it } from "vitest";
import { getLabelActionImpl } from "../src/arm-auto-signoff.js";
import { LabelAction } from "../src/label.js";
import { createMockCore, createMockGithub as createMockGithubBase } from "./mocks.js";

const core = createMockCore();

/**
 * @param {Object} param0
 * @param {boolean} param0.incrementalTypeSpec
 */
function createMockGithub({ incrementalTypeSpec }) {
  const github = createMockGithubBase();

  github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
    data: {
      workflow_runs: [
        {
          name: "Unrelated Workflow",
          id: 444,
          status: "in_progress",
          conclusion: null,
        },
        {
          name: "ARM Incremental TypeSpec",
          id: 456,
          status: "completed",
          conclusion: "success",
        },
      ],
    },
  });

  github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
    data: {
      artifacts: [{ name: `incremental-typespec=${incrementalTypeSpec}` }],
    },
  });

  return github;
}

describe("getLabelActionImpl", () => {
  it("throws if inputs null", async () => {
    await expect(getLabelActionImpl({})).rejects.toThrow();
  });

  it("throws if no artifact from incremental typespec", async () => {
    const github = createMockGithub({ incrementalTypeSpec: false });
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: { artifacts: [] },
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).rejects.toThrow();
  });

  it("no-ops if no current label ARMAutoSignedOff", async () => {
    const github = createMockGithub({ incrementalTypeSpec: false });
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [],
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual({ labelAction: LabelAction.None, issueNumber: 123 });
  });

  it("removes label if not incremental typespec", async () => {
    const github = createMockGithub({ incrementalTypeSpec: false });
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMAutoSignedOff" }],
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual({ labelAction: LabelAction.Remove, issueNumber: 123 });
  });

  it("no-ops if incremental typespec in progress", async () => {
    const github = createMockGithubBase();
    github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
      data: {
        workflow_runs: [
          {
            name: "ARM Incremental TypeSpec",
            id: 456,
            status: "in_progress",
            conclusion: null,
          },
        ],
      },
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual({ labelAction: LabelAction.None, issueNumber: 123 });
  });

  it("removes label if no runs of incremental typespec", async () => {
    const github = createMockGithubBase();
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMAutoSignedOff" }],
    });
    github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
      data: {
        workflow_runs: [],
      },
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual({ labelAction: LabelAction.Remove, issueNumber: 123 });
  });

  it("uses latest run of incremental typespec", async () => {
    const github = createMockGithubBase();
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMAutoSignedOff" }],
    });
    github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
      data: {
        workflow_runs: [
          {
            name: "ARM Incremental TypeSpec",
            id: 456,
            status: "completed",
            conclusion: "success",
            updated_at: "2020-01-22T19:33:08Z",
          },
          {
            name: "ARM Incremental TypeSpec",
            id: 789,
            status: "completed",
            conclusion: "failure",
            updated_at: "2020-01-23T19:33:08Z",
          },
        ],
      },
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual({ labelAction: LabelAction.Remove, issueNumber: 123 });
  });

  it.each([
    { labels: ["ARMAutoSignedOff"] },
    { labels: ["ARMAutoSignedOff", "ARMReview", "NotReadyForARMReview"] },
    { labels: ["ARMAutoSignedOff", "ARMReview", "SuppressionReviewRequired"] },
  ])("removes label if not all labels match ($labels)", async ({ labels }) => {
    const github = createMockGithub({ incrementalTypeSpec: true });

    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: labels.map((name) => ({ name })),
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual({ labelAction: LabelAction.Remove, issueNumber: 123 });
  });

  it.each(["Swagger Avocado", "Swagger LintDiff"])(
    "removes label if check %s failed",
    async (check) => {
      const github = createMockGithub({ incrementalTypeSpec: true });

      github.rest.issues.listLabelsOnIssue.mockResolvedValue({
        data: [{ name: "ARMAutoSignedOff" }, { name: "ARMReview" }],
      });
      github.rest.checks.listForRef.mockResolvedValue({
        data: {
          check_runs: [
            {
              name: check,
              status: "completed",
              conclusion: "failure",
            },
          ],
        },
      });

      await expect(
        getLabelActionImpl({
          owner: "TestOwner",
          repo: "TestRepo",
          issue_number: 123,
          head_sha: "abc123",
          github: github,
          core: core,
        }),
      ).resolves.toEqual({ labelAction: LabelAction.Remove, issueNumber: 123 });
    },
  );

  it("thows if multiple runs for same check", async () => {
    const github = createMockGithub({ incrementalTypeSpec: true });

    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMReview" }],
    });

    github.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            name: "Swagger LintDiff",
            status: "in_progress",
            conclusion: null,
          },
          {
            name: "Swagger LintDiff",
            status: "in_progress",
            conclusion: null,
          },
        ],
      },
    });
    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).rejects.toThrow();
  });

  it("no-ops if check not found or not completed", async () => {
    const github = createMockGithub({ incrementalTypeSpec: true });

    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMReview" }],
    });

    github.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [],
      },
    });
    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual({ labelAction: LabelAction.None, issueNumber: 123 });

    github.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            name: "Swagger LintDiff",
            status: "in_progress",
            conclusion: null,
          },
        ],
      },
    });
    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual({ labelAction: LabelAction.None, issueNumber: 123 });
  });

  it("adds label if incremental tsp, labels match, and check succeeded", async () => {
    const github = createMockGithub({ incrementalTypeSpec: true });

    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMReview" }],
    });
    github.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            name: "Swagger LintDiff",
            status: "completed",
            conclusion: "success",
          },
          {
            name: "Swagger Avocado",
            status: "completed",
            conclusion: "success",
          },
        ],
      },
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toEqual({ labelAction: LabelAction.Add, issueNumber: 123 });
  });
});
