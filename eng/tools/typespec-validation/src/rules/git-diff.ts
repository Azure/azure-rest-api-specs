import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";

export class GitDiffRule implements Rule {
  readonly name = "GitDiff";
  readonly description = "Checks if previous rules resulted in a git diff";

  async execute(host: TsvHost, folder: string): Promise<RuleResult> {
    const git = host.gitOperation(folder);
    let gitStatusIsClean = (await git.status(["--porcelain"])).isClean();

    let success = true;
    let errorOutput: string | undefined;

    if (!gitStatusIsClean) {
      success = false;
      errorOutput = JSON.stringify(await git.status());
      errorOutput += await git.diff();
    }

    return {
      success: success,
      errorOutput: errorOutput,
    };
  }
}
