import { describe, expect, it } from "vitest";
import {
  buildSdkReviewSummary,
  syncSdkReviewInlineComments,
  type PublishableRemediationFinding,
} from "../src/sdk-validation-dotnet-review-comments.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

const HEAD_SHA = "1".repeat(40);
const SPEC_FILE = "specification/widget/Widget.Management/models.tsp";

function createFinding(
  overrides: Partial<PublishableRemediationFinding> = {},
): PublishableRemediationFinding {
  return {
    reviewIndex: 0,
    findingIndex: 0,
    severity: "high",
    generatedLocation: {
      file: "sdk/widget/Azure.Widget/src/Generated/Widget.cs",
      line: 12,
    },
    title: "Generic model name",
    evidence: "The generated model lacks service context.",
    remediation: {
      target: "client.tsp",
      suggestion: "Add a C#-scoped @@clientName decorator.",
      confidence: "high",
      sourceLocation: {
        file: SPEC_FILE,
        line: 1,
      },
    },
    ...overrides,
  };
}

describe("syncSdkReviewInlineComments", () => {
  it("publishes only high-confidence exact TypeSpec mappings", async () => {
    const github = createMockGithub();
    const findings = [
      createFinding(),
      createFinding({
        findingIndex: 1,
        remediation: {
          target: "typespec",
          suggestion: "Investigate the model name.",
          confidence: "medium",
          sourceLocation: { file: SPEC_FILE, line: 1 },
        },
      }),
    ];

    const published = await syncSdkReviewInlineComments(
      { github, context: createMockContext(), core: createMockCore() },
      42,
      HEAD_SHA,
      findings,
    );

    expect(published).toEqual([findings[0]]);
    expect(github.rest.pulls.createReviewComment).toHaveBeenCalledTimes(1);
    expect(github.rest.pulls.createReviewComment).toHaveBeenCalledWith(
      expect.objectContaining({
        pull_number: 42,
        commit_id: HEAD_SHA,
        path: SPEC_FILE,
        line: 1,
        side: "RIGHT",
      }),
    );
  });

  it("updates matching bot comments and deletes obsolete managed comments", async () => {
    const github = createMockGithub();
    github.rest.pulls.listReviewComments.mockResolvedValue({
      data: [
        {
          id: 10,
          user: { login: "github-actions[bot]" },
          path: SPEC_FILE,
          line: 1,
          body: "old\n<!-- generated-dotnet-sdk-review-inline:0:0 -->",
        },
        {
          id: 20,
          user: { login: "github-actions[bot]" },
          path: SPEC_FILE,
          line: 2,
          body: "obsolete\n<!-- generated-dotnet-sdk-review-inline:0:1 -->",
        },
        {
          id: 30,
          user: { login: "contributor" },
          path: SPEC_FILE,
          line: 2,
          body: "spoofed\n<!-- generated-dotnet-sdk-review-inline:0:2 -->",
        },
      ],
    });

    await syncSdkReviewInlineComments(
      { github, context: createMockContext(), core: createMockCore() },
      42,
      HEAD_SHA,
      [createFinding()],
    );

    expect(github.rest.pulls.updateReviewComment).toHaveBeenCalledWith(
      expect.objectContaining({ comment_id: 10 }),
    );
    expect(github.rest.pulls.deleteReviewComment).toHaveBeenCalledTimes(1);
    expect(github.rest.pulls.deleteReviewComment).toHaveBeenCalledWith(
      expect.objectContaining({ comment_id: 20 }),
    );
    expect(github.rest.pulls.createReviewComment).not.toHaveBeenCalled();
  });
});

describe("buildSdkReviewSummary", () => {
  it("sanitizes agent-provided Markdown and mentions", () => {
    const finding = createFinding({
      title: "<details>@team *breaking*</details>",
    });
    const summary = buildSdkReviewSummary({
      findings: [finding],
      headSha: HEAD_SHA,
      inlineFindings: [finding],
    });

    expect(summary).not.toContain("<details>");
    expect(summary).not.toContain("@team");
    expect(summary).toContain("@\u200Bteam");
  });
});
