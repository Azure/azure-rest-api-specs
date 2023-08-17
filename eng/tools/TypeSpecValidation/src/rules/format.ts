import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { runCmd } from "../utils.js";

export class FormatRule implements Rule {
  readonly name = "Format";
  readonly description = "Format TypeSpec";

  async execute(folder: string): Promise<RuleResult> {
    // Format parent folder to include shared files
    let [stdOutput, errorOutput] = await runCmd(`npx tsp format ../**/*.tsp`, folder);

    let success = errorOutput == null ? false : true;
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
