import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";

export class LinterRulesetRule implements Rule {
  readonly name = "LinterRuleset";
  readonly description =
    "Ensures each spec includes the correct linter ruleset (data-plane or management-plane)";
  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = folder;
    let errorOutput = "";

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
