import type { Suppression } from "@azure-tools/suppressions";
import type { Diagnostic } from "./rule-result.ts";

export function unusedSuppression(
  suppression: Suppression,
  rule: string,
  target: string,
): Diagnostic {
  return {
    severity: "warning",
    code: "unused-suppression",
    message: `Suppression for '${rule}' does not hide a failure in ${target}.`,
    path: suppression.source?.path,
    location: suppression.source && {
      line: suppression.source.line,
      column: suppression.source.column,
    },
    help: "Review this suppression. Other paths or projects covered by the same entry may still need it.",
  };
}
