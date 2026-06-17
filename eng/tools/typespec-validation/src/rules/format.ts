import { type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import { gitDiffTopSpecFolder, runBin } from "../utils.ts";

export class FormatRule implements Rule {
  readonly name = "Format";
  readonly description = "Format TypeSpec";

  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    let [err, stdout, stderr] = await runBin(
      "tsp",
      // Format parent folder to include shared files
      ["format", "../**/*.tsp"],
      folder,
    );
    if (err) {
      success = false;
      errorOutput += err.message;
    }
    stdOutput += stdout;
    errorOutput += stderr;

    [err, stdout, stderr] = await runBin("prettier", ["--write", "tspconfig.yaml"], folder);
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
        errorOutput += `\nFiles have been changed after \`tsp format\`. Run \`tsp format\` and ensure all files are included in your change.`;
      }
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
