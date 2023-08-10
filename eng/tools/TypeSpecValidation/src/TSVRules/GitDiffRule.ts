import { simpleGit } from "simple-git";
import { TSVRule, TSVRuleResult } from "./TSVRule.js";

export class GitDiffRule implements TSVRule {
  readonly name = "GitDiff";
  readonly description = "Checks if previous rules resulted in a git diff";

  async execute(): Promise<TSVRuleResult> {
    const git = simpleGit();
    let gitStatusIsClean = await (await git.status(["--porcelain"])).isClean();

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
