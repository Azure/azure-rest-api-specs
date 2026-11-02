import type { ILogger } from "@azure-tools/specs-shared/logger";
import { untilLastSegmentWithParent } from "@azure-tools/specs-shared/path";
import { readdir } from "node:fs/promises";
import { extname, join, resolve } from "pathe";
import type { Diagnostic, RuleResult } from "../rule-result.ts";
import type { Rule } from "../rule.ts";
import { getSuppressions } from "../utils.ts";

const DISALLOWED_EXTENSIONS = new Set([
  ".js",
  ".ts",
  ".mjs",
  ".cjs",
  ".mts",
  ".cts",
  ".jsx",
  ".tsx",
]);

export class DisallowedFileTypesRule implements Rule {
  readonly name = "DisallowedFileTypes";
  readonly description = "Reject disallowed file types in the service folder.";

  async execute(folder: string, logger: ILogger): Promise<RuleResult> {
    const serviceFolder = resolve(untilLastSegmentWithParent(folder, "specification") || folder);
    const folders = [serviceFolder];
    const files: string[] = [];
    for (const current of folders) {
      for (const entry of await readdir(current, { withFileTypes: true })) {
        const path = join(current, entry.name);
        if (entry.isDirectory()) {
          if (entry.name !== "node_modules" && entry.name !== ".git") folders.push(path);
        } else if (DISALLOWED_EXTENSIONS.has(extname(entry.name).toLowerCase())) {
          files.push(path);
        }
      }
    }

    const diagnostics: Diagnostic[] = [];
    const reasons = new Set<string>();
    for (const path of files.sort()) {
      const suppression = (await getSuppressions(path)).find(
        (entry) => entry.rules?.includes(this.name) && !entry.subRules?.length,
      );
      if (suppression) {
        logger.debug(`Suppressed ${path}: ${suppression.reason}`);
        reasons.add(suppression.reason);
        continue;
      }
      diagnostics.push({
        severity: "error",
        code: "disallowed-file-type",
        message: `Files with the '${extname(path)}' extension are not allowed in service folders.`,
        path,
        help: "Remove this file or move tooling code outside the service folder.",
      });
    }

    return {
      success: diagnostics.length === 0,
      diagnostics,
      suppressed:
        diagnostics.length === 0 && reasons.size > 0 ? [...reasons].join("; ") : undefined,
    };
  }
}
