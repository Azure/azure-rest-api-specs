
import { exit } from "process";
import { updateSdkSuppressionsLabels, PullRequestContext } from "./updateSdkSuppressionsLabel.js";

function getUsage(): string {
    return (
      "Parameter missing! \n" + 
      "Check GITHUB_PULL_REQUEST_CONTEXT where defined in step: Get GitHub PullRequest Context" +
      "Check OUTPUT_FILE in step env: Run get suppressions label script " +
      "Check The pr has change files in GITHUB_PULL_REQUEST_CHANGE_FILES "
    );
  }

export async function main() {
    const pullRequestContext = process.env.GITHUB_PULL_REQUEST_CONTEXT as string;
    const outputFile = process.env.OUTPUT_FILE as string;
    const prChangeFiles = process.env.GITHUB_PULL_REQUEST_CHANGE_FILES as string;
    if (pullRequestContext && outputFile && prChangeFiles) {
      const _pullRequestContext = JSON.parse(pullRequestContext) as unknown as PullRequestContext;
      const changedLabels: {labelsToAdd: String[], labelsToRemove: String[]} = await updateSdkSuppressionsLabels(_pullRequestContext, prChangeFiles, outputFile);
      console.log(JSON.stringify(changedLabels));
      exit(0);
    } else {
      console.error(getUsage());
      exit(1);
    }
}
  
export { updateSdkSuppressionsLabels };


