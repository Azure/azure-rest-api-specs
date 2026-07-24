import { afterEach, describe, expect, it, vi } from "vitest";
import { emitSuppressionAnnotations, formatSuppressionAnnotation } from "../src/annotations.ts";
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

describe("formatSuppressionAnnotation", () => {
  it("anchors the warning to the source file and location", () => {
    const annotation = formatSuppressionAnnotation(makeRecord());

    expect(annotation).toContain("::warning ");
    expect(annotation).toContain("file=specification/contoso/Contoso.Widget/main.tsp");
    expect(annotation).toContain("line=42");
    expect(annotation).toContain("col=3");
    expect(annotation).toContain("title=New/changed TypeSpec Suppression - REVIEW REQUIRED");
  });

  it("lays out the body as encoded newline-separated lines", () => {
    const annotation = formatSuppressionAnnotation(makeRecord());

    expect(annotation).toContain(
      "Authors should avoid adding new suppressions and prefer fixing the underlying issue",
    );
    expect(annotation).toContain(
      "**Rule docs**: https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-enum",
    );
    // Body lines are joined with newlines and encoded as %0A for the workflow command.
    expect(annotation).toContain("%0A");
    expect(annotation).not.toContain("\n");
  });

  it("omits the rule name and, when justified, the justification text", () => {
    const annotation = formatSuppressionAnnotation(makeRecord());

    expect(annotation).not.toContain("@azure-tools/typespec-azure-core/no-enum");
    expect(annotation).not.toContain("Legacy enum kept for backward compatibility");
    expect(annotation).not.toContain("NO JUSTIFICATION PROVIDED");
  });

  it("omits the docs clause when no documentation URL is available", () => {
    const annotation = formatSuppressionAnnotation(makeRecord({ ruleMetadata: undefined }));

    expect(annotation).not.toContain("Rule docs");
  });

  it("flags a missing justification", () => {
    const annotation = formatSuppressionAnnotation(makeRecord({ justification: "   " }));

    expect(annotation).toContain("NO JUSTIFICATION PROVIDED — a justification is required.");
  });

  it("escapes newlines and percent signs in the message", () => {
    const annotation = formatSuppressionAnnotation(
      makeRecord({
        justification: "   ",
        ruleMetadata: { documentationUrl: "https://example.com/docs%20guide" },
      }),
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

  it("emits one warning per new and changed suppression, anchored to the head location", () => {
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
    expect(first).toContain("file=specification/contoso/Contoso.Widget/main.tsp");
    expect(first).toContain("line=42");
    // Changed suppression is anchored to the head-side (after) location, not the before line.
    expect(second).toContain("file=specification/contoso/Contoso.Widget/models.tsp");
    expect(second).toContain("line=55");
    expect(second).not.toContain("line=10");
  });

  it("emits nothing when there are no new or changed suppressions", () => {
    const logSpy = vi.spyOn(console, "log").mockImplementation(() => {});

    emitSuppressionAnnotations({ newSuppressions: [], changedSuppressions: [] });

    expect(logSpy).not.toHaveBeenCalled();
  });
});
