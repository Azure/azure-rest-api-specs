import type { ILogger } from "@azure-tools/specs-shared/logger";
import { reportCommandOutput } from "../command-output.ts";
import { blocks, filePath, indent, lines, verbatim } from "../diagnostic-content.ts";
import { type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import { allowGeneratedChanges, gitDiffTopSpecFolder, runNodeBin } from "../utils.ts";

const formattedFiles = ["**/*.tsp", "**/tspconfig.yaml"];

export class FormatRule implements Rule {
  readonly name = "Format";
  readonly description = "Format TypeSpec";

  async execute(folder: string, logger: ILogger): Promise<RuleResult> {
    const output = await runNodeBin(
      "@typespec/compiler",
      // Format parent folder to include shared files
      ["tsp", "format", "../**/*.tsp", "tspconfig.yaml"],
      logger,
      folder,
    );
    const result = reportCommandOutput("format", "TypeSpec formatting", output, logger);
    if (!result.success) return result;
    // Only files the formatter touches, so generated changes allowed by Compile are not reported.
    const gitDiffResult = await gitDiffTopSpecFolder(folder, logger, formattedFiles);
    if (gitDiffResult.success) return result;
    const allowed = allowGeneratedChanges();
    return {
      success: allowed,
      diagnostics: [
        ...(result.diagnostics ?? []),
        {
          severity: allowed ? "warning" : "error",
          code: "format-changed",
          path: folder,
          message: "Files changed by formatting:",
          details: blocks(
            indent(lines(gitDiffResult.files.map(filePath))),
            verbatim(gitDiffResult.diff ?? ""),
          ),
          help: 'Run `pnpm exec tsp format "../**/*.tsp" tspconfig.yaml` from the project folder and include the changes.',
        },
      ],
    };
  }
}
