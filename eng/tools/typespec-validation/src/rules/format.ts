import type { ILogger } from "@azure-tools/specs-shared/logger";
import { reportCommandOutput } from "../command-output.ts";
import { blocks, filePath, indent, lines, verbatim } from "../diagnostic-content.ts";
import { type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import { formatTypeSpec } from "../typespec-compiler.ts";
import { gitDiffTopSpecFolder } from "../utils.ts";

export class FormatRule implements Rule {
  readonly name = "Format";
  readonly description = "Format TypeSpec";

  async execute(folder: string, logger: ILogger): Promise<RuleResult> {
    // Format parent folder to include shared files
    const output = await formatTypeSpec(folder, ["../**/*.tsp", "tspconfig.yaml"]);
    const result = reportCommandOutput("format", "TypeSpec formatting", output, logger);
    if (!result.success) return result;
    const gitDiffResult = await gitDiffTopSpecFolder(folder, logger);
    if (gitDiffResult.success) return result;
    return {
      success: false,
      diagnostics: [
        ...(result.diagnostics ?? []),
        {
          severity: "error",
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
