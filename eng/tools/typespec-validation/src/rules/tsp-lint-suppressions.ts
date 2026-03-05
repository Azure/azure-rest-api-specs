import { readFile } from "fs/promises";
import { globby } from "globby";
import path from "path";
import { RuleResult } from "../rule-result.js";
import { Rule } from "../rule.js";

/**
 * TypeSpec `#suppress` directives that are known technical necessities and
 * are considered valid without requiring additional review.
 * These suppressions allow use of OpenAPI-specific features that TypeSpec
 * does not yet support natively (e.g. `@extension` for `x-ms-long-running-operation-options`).
 */
export const validSuppressionRules: ReadonlySet<string> = new Set([
  "@azure-tools/typespec-azure-core/no-openapi",
]);

/**
 * TypeSpec `#suppress` directives that are risky and require explicit review.
 * These suppressions bypass important TypeSpec Azure linting rules and can
 * indicate API design issues or deviation from Azure API conventions.
 *
 * When a risky suppression is found, this rule fails. The spec owner can
 * override this by adding the spec folder to suppressions.yaml with rule
 * "TspLintSuppressionsCheck".
 */
export const riskySuppressionRules: ReadonlySet<string> = new Set([
  // Overrides auto-generated operation IDs, which can break SDK naming
  // consistency and hide API design issues. Should be explicitly reviewed.
  "@azure-tools/typespec-azure-core/no-operation-id",
]);

/**
 * Matches `#suppress "<rule-id>" "<reason>"` lines in TypeSpec files.
 * Uses `[ \t]*` (horizontal whitespace) rather than `\s*` to avoid
 * matching across newlines, which would corrupt line number calculations.
 */
const suppressRegex = /^[ \t]*#suppress[ \t]+"([^"]+)"[ \t]+"([^"]*)"/gm;

export interface FoundSuppression {
  rule: string;
  reason: string;
  file: string;
  line: number;
}

/**
 * Parses TypeSpec `#suppress` directives from the given file content.
 * @param content - The TypeSpec file content.
 * @param filePath - The path to the file (used in output).
 * @returns Array of found suppressions with their rule, reason, file, and line.
 */
export function parseSuppressions(content: string, filePath: string): FoundSuppression[] {
  const suppressions: FoundSuppression[] = [];
  suppressRegex.lastIndex = 0;
  let match: RegExpExecArray | null;
  while ((match = suppressRegex.exec(content)) !== null) {
    const rule = match[1];
    const reason = match[2];
    const line = content.substring(0, match.index).split("\n").length;
    suppressions.push({ rule, reason, file: filePath, line });
  }
  return suppressions;
}

export class TspLintSuppressionsCheckRule implements Rule {
  readonly name = "TspLintSuppressionsCheck";
  readonly description =
    "Check TypeSpec #suppress directives and flag risky suppressions that require review.";

  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    const tspFiles = await globby("**/*.tsp", { cwd: folder, absolute: false });

    const validSuppressions: FoundSuppression[] = [];
    const riskySuppressions: FoundSuppression[] = [];

    for (const tspFile of tspFiles) {
      const filePath = path.join(folder, tspFile);
      const content = await readFile(filePath, { encoding: "utf8" });
      const found = parseSuppressions(content, tspFile);

      for (const s of found) {
        if (riskySuppressionRules.has(s.rule)) {
          riskySuppressions.push(s);
        } else {
          // Includes both explicitly valid suppressions and all unclassified ones
          validSuppressions.push(s);
        }
      }
    }

    if (validSuppressions.length > 0) {
      stdOutput += "\nValid TypeSpec suppressions (no review required):\n";
      for (const s of validSuppressions) {
        stdOutput += `  ${s.file}:${s.line}: #suppress "${s.rule}" "${s.reason}"\n`;
      }
    }

    if (riskySuppressions.length > 0) {
      success = false;
      errorOutput += "\nRisky TypeSpec suppressions found (require review):\n";
      for (const s of riskySuppressions) {
        errorOutput += `  ${s.file}:${s.line}: #suppress "${s.rule}" "${s.reason}"\n`;
      }
      errorOutput +=
        "\nRisky suppressions bypass important TypeSpec Azure linting rules.\n" +
        "Please review and document why these suppressions are necessary.\n" +
        "To allow these suppressions, add an entry to suppressions.yaml with rule " +
        `"${this.name}".\n`;
    }

    return { success, stdOutput, errorOutput };
  }
}
