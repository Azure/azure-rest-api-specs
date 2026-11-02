import { untilLastSegmentWithParent } from "@azure-tools/specs-shared/path";
import { readdir } from "node:fs/promises";
import { extname, join, resolve } from "pathe";
import type { RuleResult } from "../rule-result.ts";
import type { Rule } from "../rule.ts";

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

  async execute(folder: string): Promise<RuleResult> {
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

    return {
      success: files.length === 0,
      diagnostics: files.sort().map((path) => ({
        severity: "error",
        code: "disallowed-file-type",
        message: `Files with the '${extname(path)}' extension are not allowed in service folders.`,
        path,
        help: "Remove this file or move tooling code outside the service folder.",
      })),
    };
  }
}
