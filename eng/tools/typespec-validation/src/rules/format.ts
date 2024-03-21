import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";

export class FormatRule implements Rule {
  readonly name = "Format";
  readonly description = "Format TypeSpec";

  async execute(host: TsvHost, folder: string): Promise<RuleResult> {
    // Format parent folder to include shared files

    let [err, stdOutput, errorOutput] = await host.runCmd(`npx tsp format "../**/*.tsp"`, folder);
    let success = !err && !errorOutput;
    if (success) {
      const gitDiffResult = await host.gitDiffTopSpecFolder(host, folder);
      stdOutput += gitDiffResult.stdOutput;
      if (!gitDiffResult.success) {
        success = false;
        errorOutput += gitDiffResult.errorOutput;
        errorOutput += `\nFiles has been gerenate/changed after tsp format, please run \`tsp format\` and ensure all files are included in the branch.`;
      }
    }

    // Failing on both err and errorOutput because of known bug in tsp format where it returns 0 on failed formatting
    // https://github.com/microsoft/typespec/issues/2323
    success = success && !errorOutput;
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
