import type { RuleResult } from "../src/rule-result.ts";

export function diagnosticText(result: RuleResult): string {
  return (result.diagnostics ?? [])
    .map((diagnostic) =>
      [diagnostic.message, diagnostic.path, diagnostic.help, diagnostic.url, diagnostic.output]
        .filter(Boolean)
        .join("\n"),
    )
    .join("\n");
}
