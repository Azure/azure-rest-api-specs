import type { RuleResult } from "@azure-tools/specs-shared/rule-result";
import { join } from "pathe";
import type { PrContext } from "../context.ts";

export function evaluateNoJavaScriptOrTypeScript(context: PrContext): RuleResult {
  const files = [
    ...context.changes.additions,
    ...context.changes.renames.map(({ to }) => to),
  ].filter((path) => path.startsWith("specification/") && /\.(?:[cm]?[jt]s|[jt]sx)$/i.test(path));

  if (files.length === 0) {
    return { success: true, skipped: "No JavaScript or TypeScript files added." };
  }

  return {
    success: false,
    diagnostics: files.map((path) => ({
      severity: "error",
      code: "no-javascript-or-typescript",
      message:
        "JavaScript and TypeScript files must not be added under specification/. " +
        "Remove this file or move tooling code outside specification/.",
      path: join(context.root, path),
    })),
  };
}
