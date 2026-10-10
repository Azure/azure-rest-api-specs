import {
  formatDiagnostic as format,
  reportDiagnostics as report,
} from "@azure-tools/specs-shared/diagnostics";
import type { ILogger } from "@azure-tools/specs-shared/logger";
import type { Diagnostic } from "./rule-result.ts";

export {
  exceptionDiagnostic,
  formatRuleStatus,
  formatRuleSummary,
  supportsColor,
  type RuleCounts,
  type RuleStatus,
} from "@azure-tools/specs-shared/diagnostics";

export function formatDiagnostic(
  diagnostic: Diagnostic,
  options: { color?: boolean; cwd?: string } = {},
): string {
  return format(diagnostic, "tsv", options);
}

export function reportDiagnostics(diagnostics: readonly Diagnostic[], logger: ILogger): void {
  report(diagnostics, logger, "tsv");
}
