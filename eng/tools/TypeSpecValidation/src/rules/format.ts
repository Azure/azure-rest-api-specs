import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { runCmd } from "../utils.js";

export class FormatRule implements Rule {
  readonly name = "Format";
  readonly description = "Format TypeSpec";

  async execute(folder: string): Promise<RuleResult> {
    // Format parent folder to include shared files

    let [err, stdOutput, errorOutput] = await runCmd(`npx tsp format ../**/*.tsp`, folder);
    // Failing on both err and errorOutput because of known bug in tsp format where it returns 0 on failed formatting
    // https://github.com/microsoft/typespec/issues/2323
    let success = !err && !errorOutput;
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
