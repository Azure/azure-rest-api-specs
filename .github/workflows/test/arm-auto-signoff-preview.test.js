import { describe, expect, it, vi } from "vitest";
import { LabelAction } from "../../src/label.js";
import { createMockCore, createMockGithub } from "../../test/mocks.js";
import { getLabelActionImpl } from "../src/arm-auto-signoff-preview.js";
import * as changedFiles from "../src/changed-files.js";
import * as git from "../src/git.js";

// TODO: Test each step in the check in the order of implementation, to simplify tests and also ensure we don't call extra APIs early

vi.spyOn(changedFiles, "getChangedSwaggerFiles").mockResolvedValue([
  "/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
]);

vi.spyOn(git, "lsTree").mockResolvedValue(
  "040000 tree abc123 specification/contosowidgetmanager",
);

describe("getLabelActionImpl", () => {
  it("rejects if inputs null", async () => {
    await expect(getLabelActionImpl({})).rejects.toThrow();
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
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toBe(LabelAction.Remove);
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
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toBe(LabelAction.None);
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
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toBe(LabelAction.Add);

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
