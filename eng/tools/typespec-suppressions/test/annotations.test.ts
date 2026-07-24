import { afterEach, describe, expect, it, vi } from "vitest";
import {
  classifySuppression,
  emitSuppressionAnnotations,
  formatSuppressionAnnotation,
} from "../src/annotations.ts";
import type { SuppressionChange, SuppressionRecord } from "../src/types.ts";

function makeRecord(overrides: Partial<SuppressionRecord> = {}): SuppressionRecord {
  return {
    specPath: "specification/contoso/Contoso.Widget",
    sourceKind: "inline",
    ruleName: "@azure-tools/typespec-azure-core/no-enum",
    justification: "Legacy enum kept for backward compatibility",
    sourceFile: "specification/contoso/Contoso.Widget/main.tsp",
    anchorPath: "main.tsp",
    location: { line: 42, column: 3 },
    rawText: "#suppress ...",
    ruleMetadata: {
      documentationUrl:
        "https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-enum",
    },
    ...overrides,
  };
}

describe("classifySuppression", () => {
  it("classifies a justified new suppression as new-suppression", () => {
    expect(classifySuppression(makeRecord(), "new")).toBe("new-suppression");
  });

  it("classifies a justified changed suppression as changed-justification", () => {
    expect(classifySuppression(makeRecord(), "changed")).toBe("changed-justification");
  });

  it("classifies a blank justification as missing-justification regardless of origin", () => {
    expect(classifySuppression(makeRecord({ justification: "   " }), "new")).toBe(
      "missing-justification",
    );
    expect(classifySuppression(makeRecord({ justification: "" }), "changed")).toBe(
      "missing-justification",
    );
  });
});

describe("formatSuppressionAnnotation", () => {
  it("anchors the warning to the source file and location", () => {
    const annotation = formatSuppressionAnnotation(makeRecord(), "new");

    expect(annotation).toContain("file=specification/contoso/Contoso.Widget/main.tsp");
    expect(annotation).toContain("line=42");
    expect(annotation).toContain("col=3");
  });

  it("emits a ::warning with the New Suppression title and reviewer guidance for a justified new suppression", () => {
    const annotation = formatSuppressionAnnotation(makeRecord(), "new");

    expect(annotation).toContain("::warning ");
    expect(annotation).toContain("title=⚠️ New Suppression");
    expect(annotation).toContain(
      "Authors should avoid adding new suppressions and prefer fixing the underlying issue",
    );
  });

  it("emits a ::warning with the Changed Justification title for a justified changed suppression", () => {
    const annotation = formatSuppressionAnnotation(makeRecord(), "changed");

    expect(annotation).toContain("::warning ");
    expect(annotation).toContain("title=⚠️ Changed Justification");
    expect(annotation).toContain("The justification for an existing suppression changed");
  });

  it("emits a ::error with the Missing Justification title when the justification is blank", () => {
    const annotation = formatSuppressionAnnotation(makeRecord({ justification: "   " }), "new");

    expect(annotation).toContain("::error ");
    expect(annotation).not.toContain("::warning ");
    expect(annotation).toContain("title=❌ Missing Justification");
    expect(annotation).toContain("This suppression is missing a justification");
  });

  it("treats a blank justification as ::error even for a changed suppression (missing wins)", () => {
    const annotation = formatSuppressionAnnotation(makeRecord({ justification: "" }), "changed");

    expect(annotation).toContain("::error ");
    expect(annotation).toContain("title=❌ Missing Justification");
    expect(annotation).not.toContain("Changed Justification");
  });

  it("includes the reviewer guidance only in the New Suppression body", () => {
    const guidance =
      "Authors should avoid adding new suppressions and prefer fixing the underlying issue";

    expect(formatSuppressionAnnotation(makeRecord(), "new")).toContain(guidance);
    // Guidance is no longer appended to the other categories.
    expect(formatSuppressionAnnotation(makeRecord(), "changed")).not.toContain(guidance);
    expect(formatSuppressionAnnotation(makeRecord({ justification: "  " }), "new")).not.toContain(
      guidance,
    );
  });

  it("includes the rule docs line when a documentation URL is available", () => {
    const annotation = formatSuppressionAnnotation(makeRecord(), "new");

    expect(annotation).toContain(
      "**Rule docs**: https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-enum",
    );
  });

  it("omits the docs clause when no documentation URL is available", () => {
    const annotation = formatSuppressionAnnotation(makeRecord({ ruleMetadata: undefined }), "new");

    expect(annotation).not.toContain("Rule docs");
  });

  it("omits the rule name and justification text from the body", () => {
    const annotation = formatSuppressionAnnotation(makeRecord(), "new");

    expect(annotation).not.toContain("@azure-tools/typespec-azure-core/no-enum");
    expect(annotation).not.toContain("Legacy enum kept for backward compatibility");
  });

  it("encodes newlines as %0A and never emits a literal newline", () => {
    const annotation = formatSuppressionAnnotation(makeRecord(), "new");

    expect(annotation).toContain("%0A");
    expect(annotation).not.toContain("\n");
  });

  it("escapes newlines and percent signs in the message", () => {
    const annotation = formatSuppressionAnnotation(
      makeRecord({
        ruleMetadata: { documentationUrl: "https://example.com/docs%20guide" },
      }),
      "new",
    );

    expect(annotation).toContain("https://example.com/docs%2520guide");
    expect(annotation).toContain("%0A");
    expect(annotation).not.toContain("\n");
  });
});

describe("emitSuppressionAnnotations", () => {
  afterEach(() => {
    vi.restoreAllMocks();
  });

  it("emits one annotation per new and changed suppression, anchored to the head location", () => {
    const logSpy = vi.spyOn(console, "log").mockImplementation(() => {});

    const changed: SuppressionChange = {
      before: makeRecord({
        justification: "old reason",
        location: { line: 10, column: 1 },
      }),
      after: makeRecord({
        justification: "new reason",
        sourceFile: "specification/contoso/Contoso.Widget/models.tsp",
        location: { line: 55, column: 5 },
      }),
    };

    emitSuppressionAnnotations({
      newSuppressions: [makeRecord()],
      changedSuppressions: [changed],
    });

    expect(logSpy).toHaveBeenCalledTimes(2);
    const [first, second] = logSpy.mock.calls.map((call) => call[0]);
    // New suppression is classified with the New Suppression title.
    expect(first).toContain("file=specification/contoso/Contoso.Widget/main.tsp");
    expect(first).toContain("line=42");
    expect(first).toContain("title=⚠️ New Suppression");
    // Changed suppression is anchored to the head-side (after) location and title.
    expect(second).toContain("file=specification/contoso/Contoso.Widget/models.tsp");
    expect(second).toContain("line=55");
    expect(second).not.toContain("line=10");
    expect(second).toContain("title=⚠️ Changed Justification");
  });

  it("emits nothing when there are no new or changed suppressions", () => {
    const logSpy = vi.spyOn(console, "log").mockImplementation(() => {});

    emitSuppressionAnnotations({ newSuppressions: [], changedSuppressions: [] });

    expect(logSpy).not.toHaveBeenCalled();
  });
});
