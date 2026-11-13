import { describe, expect, it } from "vitest";
import {
  parseSdkReviewSafeOutput,
  validateSdkReviewResult,
} from "../src/sdk-validation-dotnet-review-result.ts";

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
      packages: [
        {
          packageName: "Azure.Widget",
          changedFiles: ["sdk/widget/Azure.Widget/src/Generated/WidgetClient.cs"],
        },
      ],
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
    expect(validateSdkReviewResult(context, createResult())).toContain(
      "Incorrect generated behavior",
    );
  });

  it("accepts an explicitly empty findings array", () => {
    const result = createResult();
    result.reviews[0].findings = [];

    expect(validateSdkReviewResult(context, result)).toContain(
      "No high-confidence findings were found.",
    );
  });

  it("rejects mismatched source identity", () => {
    const result = createResult();
    result.source.specHeadSha = "f".repeat(40);

    expect(() => validateSdkReviewResult(context, result)).toThrow("source identity");
  });

  it("rejects a missing findings array", () => {
    const result = createResult();
    const review = result.reviews[0] as { findings?: unknown[] };
    delete review.findings;

    expect(() => validateSdkReviewResult(context, result)).toThrow("findings must be an array");
  });

  it("rejects malformed findings", () => {
    const result = createResult();
    result.reviews[0].findings[0].line = 0;

    expect(() => validateSdkReviewResult(context, result)).toThrow("invalid line");
  });

  it("rejects findings outside the declared changed files", () => {
    const result = createResult();
    result.reviews[0].findings[0].file = "sdk/widget/Azure.Widget/README.md";

    expect(() => validateSdkReviewResult(context, result)).toThrow(
      "outside the declared changed files",
    );
  });

  it("generates Markdown from validated findings", () => {
    const report = validateSdkReviewResult(context, createResult());

    expect(report).toContain("Incorrect generated behavior");
    expect(report).not.toContain("No high-confidence findings were found.");
  });
});

describe("parseSdkReviewSafeOutput", () => {
  it("extracts one bounded review result", () => {
    const result = createResult();
    expect(
      parseSdkReviewSafeOutput({
        items: [{ type: "publish_sdk_review", result: JSON.stringify(result) }],
        errors: [],
      }),
    ).toEqual(result);
  });

  it("rejects missing or duplicate review submissions", () => {
    expect(() => parseSdkReviewSafeOutput({ items: [], errors: [] })).toThrow("exactly one");
    expect(() =>
      parseSdkReviewSafeOutput({
        items: [
          { type: "publish_sdk_review", result: "{}" },
          { type: "publish_sdk_review", result: "{}" },
        ],
        errors: [],
      }),
    ).toThrow("exactly one");
  });

  it("rejects malformed or oversized JSON", () => {
    expect(() =>
      parseSdkReviewSafeOutput({
        items: [{ type: "publish_sdk_review", result: "{" }],
        errors: [],
      }),
    ).toThrow("valid JSON");
    expect(() =>
      parseSdkReviewSafeOutput({
        items: [{ type: "publish_sdk_review", result: `"${"x".repeat(64 * 1024)}"` }],
        errors: [],
      }),
    ).toThrow("exceeds");
  });
});
