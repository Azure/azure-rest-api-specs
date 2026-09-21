import { type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import { gitDiffTopSpecFolder, runPnpm } from "../utils.ts";

export class FormatRule implements Rule {
  readonly name = "Format";
  readonly description = "Format TypeSpec";

  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    let [err, stdout, stderr] = await runPnpm(
      // Format parent folder to include shared files
      ["exec", "tsp", "format", "../**/*.tsp"],
      folder,
    );
    if (err) {
      success = false;
      errorOutput += err.message;
    }
    stdOutput += stdout;
    errorOutput += stderr;

    [err, stdout, stderr] = await runPnpm(["exec", "oxfmt", "--write", "tspconfig.yaml"], folder);
    if (err) {
      success = false;
      errorOutput += err.message;
    }
    stdOutput += stdout;
    errorOutput += stderr;

    if (success) {
      const gitDiffResult = await gitDiffTopSpecFolder(folder);
      stdOutput += gitDiffResult.stdOutput;
      if (!gitDiffResult.success) {
        success = false;
        errorOutput += gitDiffResult.errorOutput;
        errorOutput += `\nFiles have been changed by formatting. Run \`pnpm exec tsp format "../**/*.tsp"\` and \`pnpm exec oxfmt --write tspconfig.yaml\` from the project folder and include the changes.`;
      }
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
