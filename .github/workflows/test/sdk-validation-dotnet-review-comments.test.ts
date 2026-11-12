import { describe, expect, it } from "vitest";
import {
  buildSdkReviewSummary,
  type PublishableRemediationFinding,
} from "../src/sdk-validation-dotnet-review-comments.ts";

const HEAD_SHA = "1".repeat(40);
const SPEC_FILE = "specification/widget/Widget.Management/models.tsp";
const REPOSITORY_URL = "https://github.com/owner/repo";
const WORKFLOW_URL = "https://github.com/owner/repo/actions/runs/1";

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

describe("buildSdkReviewSummary", () => {
  it("sanitizes agent-provided Markdown and mentions", () => {
    const finding = createFinding({
      title: "<details>@team *breaking*</details>",
    });
    const summary = buildSdkReviewSummary({
      findings: [finding],
      headSha: HEAD_SHA,
      repositoryUrl: REPOSITORY_URL,
      workflowRunUrl: WORKFLOW_URL,
    });

    expect(summary).not.toContain("<details>");
    expect(summary).not.toContain("@team");
    expect(summary).toContain("&#64;team");
  });

  it("includes evidence, exact TypeSpec locations, and the complete workflow link", () => {
    const summary = buildSdkReviewSummary({
      findings: [createFinding()],
      headSha: HEAD_SHA,
      repositoryUrl: REPOSITORY_URL,
      workflowRunUrl: WORKFLOW_URL,
    });

    expect(summary).toContain("Evidence: The generated model lacks service context.");
    expect(summary).toContain(
      `TypeSpec: [\`${SPEC_FILE}:1\`](${REPOSITORY_URL}/blob/${HEAD_SHA}/${SPEC_FILE}#L1)`,
    );
    expect(summary).toContain(`[View complete validated workflow results](${WORKFLOW_URL})`);
  });

  it("preserves copyable TypeSpec decorator syntax", () => {
    const summary = buildSdkReviewSummary({
      findings: [createFinding()],
      headSha: HEAD_SHA,
      repositoryUrl: REPOSITORY_URL,
      workflowRunUrl: WORKFLOW_URL,
    });

    expect(summary).toContain("&#64;&#64;clientName");
    expect(summary).not.toContain("\u200B");
  });
});
