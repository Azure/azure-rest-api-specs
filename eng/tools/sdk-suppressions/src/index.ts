
import { exit } from "process";
import { updateSdkSuppressionsLabels, PullRequestContext } from "./updateSdkSuppressionsLabel.js";

function getUsage(): string {
    return (
      "Parameter missing! \n" + 
      "\n" +
      "Check GITHUB_TOKEN is setting in spec repo setting for action which named SPEC_REPO_TOKEN ! referenece https://docs.github.com/zh/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions\n" +
      "Check GITHUB_PULL_REQUEST_CONTEXT where defined in step: Get GitHub PullRequest Context" +
      "Check OUTPUT_FILE in step env: Run get suppressions label script " +
      "Check The pr has change files in GITHUB_PULL_REQUEST_CHANGE_FILES "
    );
  }

export async function main() {
    const pullRequestContext = process.env.GITHUB_PULL_REQUEST_CONTEXT as string;
    const githubToken = process.env.GITHUB_TOKEN as string;
    const outputFile = process.env.OUTPUT_FILE as string;
    const prChangeFiles = process.env.GITHUB_PULL_REQUEST_CHANGE_FILES as string;
    if (pullRequestContext && githubToken && outputFile && prChangeFiles) {
      const _pullRequestContext = JSON.parse(pullRequestContext) as unknown as PullRequestContext;
      const _token = githubToken;
      const changedLabels: {labelsToAdd: String[], labelsToRemove: String[]} = await updateSdkSuppressionsLabels(_pullRequestContext, _token, prChangeFiles, outputFile);
      console.log(JSON.stringify(changedLabels));
      exit(0);
    } else {
      console.error(getUsage());
      exit(1);
    }
}
  
export { updateSdkSuppressionsLabels };


