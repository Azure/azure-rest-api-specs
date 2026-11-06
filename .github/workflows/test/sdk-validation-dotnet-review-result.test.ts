import { describe, expect, it } from "vitest";
import { validateSdkReviewResult } from "../src/sdk-validation-dotnet-review-result.ts";

const context = {
  source: {
    specPrNumber: 47625,
    specHeadSha: "38865cd3b650b3510e2a5b8bf9f990d0668a8810",
  },
  canonicalSkill: {
    skillRevision: "0123456789abcdef0123456789abcdef01234567",
  },
  workspaces: [
    {
      baselineCommitSha: "abcdef0123456789abcdef0123456789abcdef01",
      packages: [{ packageName: "Azure.Widget" }],
    },
  ],
};

function createResult() {
  return {
    schemaVersion: 1,
    status: "completed",
    skillRevision: context.canonicalSkill.skillRevision,
    source: { ...context.source },
    reviews: [
      {
        baselineCommitSha: context.workspaces[0].baselineCommitSha,
        packages: ["Azure.Widget"],
        findings: [
          {
            severity: "high",
            file: "sdk/widget/Azure.Widget/src/Generated/WidgetClient.cs",
            line: 42,
            title: "Incorrect generated behavior",
            description: "The generated client sends the wrong value.",
          },
        ],
      },
    ],
  };
}

describe("validateSdkReviewResult", () => {
  it("accepts a complete result and Markdown report", () => {
    expect(() => validateSdkReviewResult(context, createResult(), "# SDK review\n")).not.toThrow();
  });

  it("accepts an explicitly empty findings array", () => {
    const result = createResult();
    result.reviews[0].findings = [];

    expect(() => validateSdkReviewResult(context, result, "# No findings\n")).not.toThrow();
  });

  it("rejects mismatched source identity", () => {
    const result = createResult();
    result.source.specHeadSha = "f".repeat(40);

    expect(() => validateSdkReviewResult(context, result, "# SDK review\n")).toThrow(
      "source identity",
    );
  });

  it("rejects a missing findings array", () => {
    const result = createResult();
    const review = result.reviews[0] as { findings?: unknown[] };
    delete review.findings;

    expect(() => validateSdkReviewResult(context, result, "# SDK review\n")).toThrow(
      "findings must be an array",
    );
  });

  it("rejects malformed findings", () => {
    const result = createResult();
    result.reviews[0].findings[0].line = 0;

    expect(() => validateSdkReviewResult(context, result, "# SDK review\n")).toThrow(
      "invalid line",
    );
  });

  it("rejects an empty Markdown report", () => {
    expect(() => validateSdkReviewResult(context, createResult(), " \n")).toThrow(
      "must not be empty",
    );
  });
});
