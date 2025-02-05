import { describe, expect, it } from "vitest";
import { createMockCore, createMockGithub } from "../../test/mocks.js";
import { armAutoSignoffPreviewImpl } from "../src/arm-auto-signoff-preview.js";

describe("armAutoSignoffPreviewImpl", () => {
  it("rejects if inputs null", async () => {
    await expect(armAutoSignoffPreviewImpl({})).rejects.toThrow();
  });

  it.each([
    {
      labels: [],
    },
    {
      labels: ["ARMReview", "ARMBestPractices"],
      swaggerLintDiffConclusion: "failed",
    },
  ])("removes label (%s)", async ({ labels, swaggerLintDiffConclusion }) => {
    const core = createMockCore();

    const github = createMockGithub();
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: labels.map((name) => ({ name })),
    });

    github.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            name: "Swagger LintDiff",
            status: "completed",
            conclusion: swaggerLintDiffConclusion || "success",
          },
        ],
      },
    });

    await expect(
      armAutoSignoffPreviewImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toBeUndefined();

    expect(core.setOutput).toBeCalledWith("addArmAutoSignoffPreview", false);
  });

  it.each([
    {
      labels: ["ARMReview", "ARMBestPractices"],
      // Represents "no check named 'Swagger LintDiff' found"
      swaggerLintDiffStatus: null,
    },
    {
      labels: ["ARMReview", "ARMBestPractices"],
      swaggerLintDiffStatus: "in_progress",
    },
  ])("no-ops (%s)", async ({ labels, swaggerLintDiffStatus }) => {
    const core = createMockCore();

    const github = createMockGithub();
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: labels.map((name) => ({ name })),
    });

    github.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: swaggerLintDiffStatus
          ? [
              {
                name: "Swagger LintDiff",
                status: swaggerLintDiffStatus,
              },
            ]
          : [],
      },
    });

    await expect(
      armAutoSignoffPreviewImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toBeUndefined();

    expect(core.setOutput).toBeCalledWith("addArmAutoSignoffPreview", null);
  });

  it.each([
    {
      labels: ["ARMReview", "ARMBestPractices"],
    },
    {
      labels: [
        "ARMReview",
        "ARMBestPractices",
        "SuppressionReviewRequired",
        "Suppression-Approved",
      ],
    },
  ])("adds label (%s)", async ({ labels }) => {
    const core = createMockCore();

    const github = createMockGithub();

    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: labels.map((name) => ({ name })),
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
      armAutoSignoffPreviewImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toBeUndefined();

    expect(core.setOutput).toBeCalledWith("addArmAutoSignoffPreview", true);

    expect(github.rest.issues.listLabelsOnIssue).toBeCalledWith({
      owner: "TestOwner",
      repo: "TestRepo",
      issue_number: 123,
    });

    expect(github.rest.checks.listForRef).toBeCalledWith({
      owner: "TestOwner",
      repo: "TestRepo",
      ref: "abc123",
    });
  });
});
