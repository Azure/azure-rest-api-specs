import { describe, expect, it } from "vitest";
import { validateTypeSpecRemediationResult } from "../src/sdk-validation-typespec-remediation-result.ts";

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
        severity: "high",
        generatedLocation: {
          file: "sdk/widget/Azure.Widget/src/Generated/Widget.cs",
          line: 12,
          symbol: "Widget",
        },
        category: "naming",
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
    ],
  };
}

describe("validateTypeSpecRemediationResult", () => {
  it("accepts a complete remediation classification", () => {
    expect(() =>
      validateTypeSpecRemediationResult(
        reviewContext,
        rawReviewResult,
        typeSpecContext,
        createResult(),
        "# TypeSpec remediation\n",
      ),
    ).not.toThrow();
  });

  it("requires one classification for every SDK finding", () => {
    const result = createResult();
    result.findings = [];

    expect(() =>
      validateTypeSpecRemediationResult(
        reviewContext,
        rawReviewResult,
        typeSpecContext,
        result,
        "# TypeSpec remediation\n",
      ),
    ).toThrow("classify every SDK review finding");
  });

  it("rejects a translation that changes the SDK finding identity", () => {
    const result = createResult();
    result.findings[0].generatedLocation.line = 99;

    expect(() =>
      validateTypeSpecRemediationResult(
        reviewContext,
        rawReviewResult,
        typeSpecContext,
        result,
        "# TypeSpec remediation\n",
      ),
    ).toThrow("does not match its SDK review finding");
  });

  it("rejects non-C# language scopes", () => {
    const result = createResult();
    result.findings[0].remediation.languageScopes = ["python"];

    expect(() =>
      validateTypeSpecRemediationResult(
        reviewContext,
        rawReviewResult,
        typeSpecContext,
        result,
        "# TypeSpec remediation\n",
      ),
    ).toThrow("languageScopes must contain only csharp");
  });

  it("rejects source locations outside changed TypeSpec files", () => {
    const result = createResult();
    result.findings[0].remediation.sourceLocation.file =
      "specification/widget/Widget.Management/client.tsp";

    expect(() =>
      validateTypeSpecRemediationResult(
        reviewContext,
        rawReviewResult,
        typeSpecContext,
        result,
        "# TypeSpec remediation\n",
      ),
    ).toThrow("must reference a changed TypeSpec file");
  });

  it("rejects source locations on unchanged lines", () => {
    const result = createResult();
    result.findings[0].remediation.sourceLocation.line = 2;

    expect(() =>
      validateTypeSpecRemediationResult(
        reviewContext,
        rawReviewResult,
        typeSpecContext,
        result,
        "# TypeSpec remediation\n",
      ),
    ).toThrow("is not changed by the spec PR");
  });
});
