import { simpleGit } from "simple-git";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";

export class GitDiffRule implements Rule {
  readonly name = "GitDiff";
  readonly description = "Checks if previous rules resulted in a git diff";

  async execute(folder: string): Promise<RuleResult> {
    const git = simpleGit(folder);
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
