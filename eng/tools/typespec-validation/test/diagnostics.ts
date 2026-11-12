import { renderDiagnosticContent } from "../src/diagnostic-content.ts";
import type { Diagnostic, RuleResult } from "../src/rule-result.ts";

export function diagnosticDetails(diagnostic: Diagnostic | undefined): string {
  return diagnostic?.details === undefined ? "" : renderDiagnosticContent(diagnostic.details);
}

export function diagnosticText(result: RuleResult): string {
  return (result.diagnostics ?? [])
    .map((diagnostic) =>
      [
        diagnostic.message,
        diagnostic.path,
        diagnostic.help,
        diagnostic.url,
        diagnosticDetails(diagnostic),
      ]
        .filter(Boolean)
        .join("\n"),
    )
    .join("\n");
}
