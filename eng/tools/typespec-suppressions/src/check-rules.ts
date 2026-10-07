import { readFileSync } from "node:fs";
import path from "node:path";

/**
 * Shape of the curated check-rules JSON file. Only `rules` is required.
 */
export interface CheckRulesFile {
  name?: string;
  description?: string;
  rules: string[];
}

/**
 * Loads and parses a check-rules JSON file, returning the list of rule names.
 *
 * Designed to NEVER throw: any failure (missing file, unreadable, invalid JSON,
 * wrong shape) is logged as a warning and resolves to an empty array. Returning
 * `[]` (rather than `undefined`) signals "checked-only mode with zero rules",
 * which results in no required approvals.
 *
 * The path is resolved relative to `process.cwd()` (absolute paths pass
 * through), matching standard CLI file-argument behavior.
 *
 * TODO(revisit): Consider hard-failing when the file is present but INVALID
 * (malformed JSON / wrong shape) instead of degrading to `[]`, to catch config
 * typos. Current behavior intentionally degrades gracefully; reassess after the
 * initial rollout.
 */
export function loadCheckRulesFile(checkRulesFilePath: string): string[] {
  const resolvedPath = path.resolve(process.cwd(), checkRulesFilePath);

  let content: string;
  try {
    content = readFileSync(resolvedPath, "utf-8");
  } catch (error) {
    console.warn(
      `[typespec-suppressions] Could not read check-rules file '${resolvedPath}': ${
        error instanceof Error ? error.message : String(error)
      }. Proceeding with zero check rules (no suppressions will require approval).`,
    );
    return [];
  }

  let parsed: unknown;
  try {
    parsed = JSON.parse(content);
  } catch (error) {
    console.warn(
      `[typespec-suppressions] Check-rules file '${resolvedPath}' is not valid JSON: ${
        error instanceof Error ? error.message : String(error)
      }. Proceeding with zero check rules.`,
    );
    return [];
  }

  const rules = (parsed as Partial<CheckRulesFile> | null)?.rules;
  if (!Array.isArray(rules) || !rules.every((rule) => typeof rule === "string")) {
    console.warn(
      `[typespec-suppressions] Check-rules file '${resolvedPath}' must contain a "rules" array of strings. Proceeding with zero check rules.`,
    );
    return [];
  }

  return rules;
}
