import { TSVRule, TSVRuleResult } from "./TSVRule.js";
import { runCmd } from "./RunCmd.js";

export class FormatRule implements TSVRule {
  readonly name = "Format";
  readonly description = "Format TypeSpec";

  async execute(folder: string): Promise<TSVRuleResult> {
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
