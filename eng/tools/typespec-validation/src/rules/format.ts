import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";
import { gitDiffTopSpecFolder } from "../utils.js";

export class FormatRule implements Rule {
  readonly name = "Format";
  readonly description = "Format TypeSpec";

  async execute(host: TsvHost, folder: string): Promise<RuleResult> {
    // Format parent folder to include shared files

    let [err, stdOutput, errorOutput] = await host.runCmd(`npx tsp format "../**/*.tsp"`, folder);

    const gitDiffResult = await gitDiffTopSpecFolder(host, folder);
    stdOutput += gitDiffResult.stdOutput;
    if (!gitDiffResult.success) {
      errorOutput += gitDiffResult.errorOutput;
      errorOutput += `\nFiles has been gerenate/changed after tsp format, please run \`tsp format\` and ensure all files are included in the branch.`;
    }

    // Failing on both err and errorOutput because of known bug in tsp format where it returns 0 on failed formatting
    // https://github.com/microsoft/typespec/issues/2323
    let success = !err && !errorOutput && gitDiffResult.success;
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
