import { describe, expect, it } from "vitest";
import {
  parseTypeSpecRemediationSafeOutput,
  validateTypeSpecRemediationResult,
} from "../src/sdk-validation-typespec-remediation-result.ts";

const HEAD_SHA = "1".repeat(40);
const SKILL_REVISION = "2".repeat(40);
const SPEC_FILE = "specification/widget/Widget.Management/models.tsp";

const reviewContext = {
  source: {
    specPrNumber: 42,
    specHeadSha: HEAD_SHA,
  },
  remediationSkill: {
    skillRevision: SKILL_REVISION,
  },
};

const rawReviewResult = {
  reviews: [
    {
      findings: [
        {
          severity: "high",
          file: "sdk/widget/Azure.Widget/src/Generated/Widget.cs",
          line: 12,
          title: "Generic model name",
          description: "The generated public model name lacks service context.",
        },
      ],
    },
  ],
};

const typeSpecContext = {
  source: {
    specPrNumber: 42,
    specHeadSha: HEAD_SHA,
  },
  files: [
    {
      path: SPEC_FILE,
      roles: ["changed"],
      content: "model Widget {\n  name: string;\n}\n",
      patch: "@@ -1,3 +1,3 @@\n-model OldWidget {\n+model Widget {\n   name: string;\n }",
    },
  ],
};

function createResult() {
  return {
    schemaVersion: 1,
    status: "completed",
    skillRevision: SKILL_REVISION,
    source: {
      specPrNumber: 42,
      specHeadSha: HEAD_SHA,
    },
    findings: [
      {
        reviewIndex: 0,
        findingIndex: 0,
        remediation: {
          target: "client.tsp",
          specSymbol: "Widget",
          suggestion: "Add a C#-scoped @@clientName decorator.",
          confidence: "high",
          sourceLocation: {
            file: SPEC_FILE,
            line: 1,
          },
        },
      },
    ],
  };
}

describe("validateTypeSpecRemediationResult", () => {
  it("normalizes mapping decisions into the publisher contract", () => {
    const normalized = validateTypeSpecRemediationResult(
      reviewContext,
      rawReviewResult,
      typeSpecContext,
      createResult(),
    );

    expect(normalized.result.findings).toEqual([
      {
        reviewIndex: 0,
        findingIndex: 0,
        severity: "high",
        generatedLocation: {
          file: "sdk/widget/Azure.Widget/src/Generated/Widget.cs",
          line: 12,
        },
        title: "Generic model name",
        evidence: "The generated public model name lacks service context.",
        remediation: {
          target: "client.tsp",
          languageScopes: ["csharp"],
          specSymbol: "Widget",
          suggestion: "Add a C#-scoped @@clientName decorator.",
          confidence: "high",
          sourceLocation: {
            file: SPEC_FILE,
            line: 1,
          },
        },
      },
    ]);
    expect(normalized.report).toContain("Validated 1 remediation mapping");
  });

  describe("parseTypeSpecRemediationSafeOutput", () => {
    it("extracts one bounded remediation result", () => {
      const remediationResult = createResult();
      expect(
        parseTypeSpecRemediationSafeOutput({
          items: [
            {
              type: "publish_sdk_review",
              result: JSON.stringify(rawReviewResult),
              remediation_result: JSON.stringify(remediationResult),
            },
          ],
        }),
      ).toEqual(remediationResult);
    });

    it("rejects incomplete, malformed, and oversized output", () => {
      expect(() =>
        parseTypeSpecRemediationSafeOutput({
          items: [{ type: "publish_sdk_review", result: "{}" }],
        }),
      ).toThrow("exactly one complete");
      expect(() =>
        parseTypeSpecRemediationSafeOutput({
          items: [
            {
              type: "publish_sdk_review",
              result: "{}",
              remediation_result: "{",
            },
          ],
        }),
      ).toThrow("valid JSON");
      expect(() =>
        parseTypeSpecRemediationSafeOutput({
          items: [
            {
              type: "publish_sdk_review",
              result: `"${"x".repeat(64 * 1024)}"`,
              remediation_result: "{}",
            },
          ],
        }),
      ).toThrow("exceeds");
    });
  });

  it("requires one classification for every SDK finding", () => {
    const result = createResult();
    result.findings = [];

    expect(() =>
      validateTypeSpecRemediationResult(reviewContext, rawReviewResult, typeSpecContext, result),
    ).toThrow("classify every SDK review finding");
  });

  it("rejects unknown SDK finding references", () => {
    const result = createResult();
    result.findings[0].findingIndex = 1;

    expect(() =>
      validateTypeSpecRemediationResult(reviewContext, rawReviewResult, typeSpecContext, result),
    ).toThrow("unknown or duplicate SDK finding reference");
  });

  it("revalidates canonical fields in normalized publisher artifacts", () => {
    const normalized = validateTypeSpecRemediationResult(
      reviewContext,
      rawReviewResult,
      typeSpecContext,
      createResult(),
    ).result;
    normalized.findings[0].evidence = "Agent-controlled replacement";

    expect(() =>
      validateTypeSpecRemediationResult(
        reviewContext,
        rawReviewResult,
        typeSpecContext,
        normalized,
      ),
    ).toThrow("does not match its canonical SDK finding");
  });

  it("revalidates the C# scope in normalized publisher artifacts", () => {
    const normalized = validateTypeSpecRemediationResult(
      reviewContext,
      rawReviewResult,
      typeSpecContext,
      createResult(),
    ).result;
    const languageScopes: string[] = normalized.findings[0].remediation.languageScopes;
    languageScopes[0] = "python";

    expect(() =>
      validateTypeSpecRemediationResult(
        reviewContext,
        rawReviewResult,
        typeSpecContext,
        normalized,
      ),
    ).toThrow("languageScopes must contain only csharp");
  });

  it("rejects source locations outside changed TypeSpec files", () => {
    const result = createResult();
    result.findings[0].remediation.sourceLocation.file =
      "specification/widget/Widget.Management/client.tsp";

    expect(() =>
      validateTypeSpecRemediationResult(reviewContext, rawReviewResult, typeSpecContext, result),
    ).toThrow("must reference a changed TypeSpec file");
  });

  it("rejects source locations on unchanged lines", () => {
    const result = createResult();
    result.findings[0].remediation.sourceLocation.line = 2;

    expect(() =>
      validateTypeSpecRemediationResult(reviewContext, rawReviewResult, typeSpecContext, result),
    ).toThrow("is not changed by the spec PR");
  });
});
