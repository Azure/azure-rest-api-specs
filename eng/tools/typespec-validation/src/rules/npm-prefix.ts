import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";

export class NpmPrefixRule implements Rule {
  readonly name = "NpmPrefix";
  readonly description = "Verify spec is using root level package.json";

  async execute(host: TsvHost, folder: string): Promise<RuleResult> {
    const git = host.gitOperation(folder);

    let expected_npm_prefix: string | undefined;
    try {
      // If spec folder is inside a git repo, returns repo root
      expected_npm_prefix = host.normalizePath(await git.revparse("--show-toplevel"));
    } catch (err) {
      // If spec folder is outside git repo, or if problem running git, throws error
      return {
        success: false,
        errorOutput: err instanceof Error ? err.message : undefined,
      };
    }

    const actual_npm_prefix = host.normalizePath(
      (await host.runCmd(`npm prefix`, folder))[1].trim(),
    );

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
