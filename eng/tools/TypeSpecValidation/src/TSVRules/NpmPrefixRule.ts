import { runCmd } from "./RunCmd.js";
import { TSVRule, TSVRuleResult } from "./TSVRule.js";

export class NpmPrefixRule implements TSVRule {
  readonly name = "NpmPrefix";
  readonly description = "Verify spec is using root level package.json";

  async execute(folder: string): Promise<TSVRuleResult> {
    let expected_npm_prefix = process.cwd();
    const actual_npm_prefix = (await runCmd(`npm prefix`, folder))[0].trim();

    let success = true;
    let stdOutput =
      "Expected npm prefix: " +
      expected_npm_prefix +
      "\n" +
      "Actual npm prefix: " +
      actual_npm_prefix;
    let errorOutput: string | undefined;

    if (expected_npm_prefix !== actual_npm_prefix) {
      success = false;
      errorOutput =
        "TypeSpec folders MUST NOT contain a package.json, and instead MUST rely on the package.json at repo root";
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
