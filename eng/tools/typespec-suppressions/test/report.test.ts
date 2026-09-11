import { describe, expect, it } from "vitest";
import { renderMarkdownSummary } from "../src/report.ts";
import type { SuppressionChange, SuppressionRecord } from "../src/types.ts";

function makeRecord(overrides: Partial<SuppressionRecord> = {}): SuppressionRecord {
  return {
    specPath: "specification/contoso/Contoso.Widget",
    sourceKind: "inline",
    ruleName: "@azure-tools/typespec-azure-core/no-enum",
    justification: "Legacy enum kept for backward compatibility",
    sourceFile: "specification/contoso/Contoso.Widget/main.tsp",
    anchorPath: "main.tsp",
    location: { line: 42, column: 1 },
    rawText: "#suppress ...",
    ...overrides,
  };
}

describe("renderMarkdownSummary", () => {
  it("renders the empty result when there are no new or changed suppressions", () => {
    const markdown = renderMarkdownSummary({
      baseRevision: "base",
      headRevision: "head",
      specPaths: ["specification/contoso/Contoso.Widget"],
      newSuppressions: [],
      changedSuppressions: [],
    });

    expect(markdown).toContain("No new or changed TypeSpec suppressions were found.");
    expect(markdown).not.toContain("<table>");
  });

  it("renders new suppressions as a table with rule, source, and justification columns", () => {
    const markdown = renderMarkdownSummary({
      baseRevision: "base",
      headRevision: "head",
      specPaths: [],
      newSuppressions: [makeRecord()],
      changedSuppressions: [],
    });

    expect(markdown).toContain("## New suppressions requiring approval (1)");
    expect(markdown).toContain(
      "<thead><tr><th>Rule</th><th>Source</th><th>Justification</th></tr></thead>",
    );
    expect(markdown).toContain("<code>@azure-tools/typespec-azure-core/no-enum</code>");
    expect(markdown).toContain("<code>specification/contoso/Contoso.Widget/main.tsp#L42</code>");
    expect(markdown).toContain("Legacy enum kept for backward compatibility");
  });

  it("renders rule links, description, and Azure guidance when metadata is present", () => {
    const markdown = renderMarkdownSummary({
      baseRevision: "base",
      headRevision: "head",
      specPaths: [],
      newSuppressions: [
        makeRecord({
          ruleMetadata: {
            description: "Avoid raw enums",
            documentationUrl: "https://example.com/no-enum",
            guidelineCodes: ["azure-core-001"],
          },
        }),
      ],
      changedSuppressions: [],
    });

    expect(markdown).toContain('<a href="https://example.com/no-enum">');
    expect(markdown).toContain("Avoid raw enums");
    expect(markdown).toContain("Azure guidance: <code>azure-core-001</code>");
  });

  it("renders the warning when a justification is missing", () => {
    const markdown = renderMarkdownSummary({
      baseRevision: "base",
      headRevision: "head",
      specPaths: [],
      newSuppressions: [makeRecord({ justification: "   " })],
      changedSuppressions: [],
    });

    expect(markdown).toContain(
      "<strong>NO JUSTIFICATION PROVIDED, THIS IS A REQUIRED SUPPRESSION COMPONENT</strong>",
    );
  });

  it("renders changed suppressions as a table with previous and new justifications", () => {
    const change: SuppressionChange = {
      before: makeRecord({ justification: "Old reason" }),
      after: makeRecord({ justification: "New reason" }),
    };

    const markdown = renderMarkdownSummary({
      baseRevision: "base",
      headRevision: "head",
      specPaths: [],
      newSuppressions: [],
      changedSuppressions: [change],
    });

    expect(markdown).toContain("## Changed suppressions requiring approval (1)");
    expect(markdown).toContain("<th>Previous justification</th><th>New justification</th>");
    expect(markdown).toContain("Old reason");
    expect(markdown).toContain("New reason");
  });

  it("escapes HTML-sensitive characters in justifications", () => {
    const markdown = renderMarkdownSummary({
      baseRevision: "base",
      headRevision: "head",
      specPaths: [],
      newSuppressions: [makeRecord({ justification: 'a <b> & "c"' })],
      changedSuppressions: [],
    });

    expect(markdown).toContain("a &lt;b&gt; &amp; &quot;c&quot;");
  });
});
