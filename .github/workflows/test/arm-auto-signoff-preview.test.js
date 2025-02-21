import { describe, expect, it } from "vitest";
import { LabelAction } from "../../src/label.js";
import {
  createMockCore,
  createMockGithub as createMockGithubBase,
} from "../../test/mocks.js";
import { getLabelActionImpl } from "../src/arm-auto-signoff-preview.js";

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
          name: "ARM Incremental TypeSpec (Preview)",
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
  it("rejects if inputs null", async () => {
    await expect(getLabelActionImpl({})).rejects.toThrow();
  });

  it("removes label if not incremental typespec", async () => {
    const github = createMockGithub({ incrementalTypeSpec: false });

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
    { labels: [] },
    { labels: ["ARMReview", "NotReadyForARMReview"] },
    { labels: ["ARMReview", "SuppressionReviewRequired"] },
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

  it("removes label if check failed", async () => {
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
