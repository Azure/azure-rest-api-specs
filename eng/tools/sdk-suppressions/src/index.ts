
import { exit } from "process";
import { updateSdkSuppressionsLabels, PullRequestContext } from "./updateSdkSuppressionsLabel.js";

function getUsage(): string {
    return (
      "parameter missing! \n"
    );
  }

export async function main() {
    const _pullRequestContext = process.env.GITHUB_PULL_REQUEST_CONTEXT as string;
    const _githubToken = process.env.GITHUB_TOKEN as string;

    if (_pullRequestContext && _githubToken) {
      const pullRequestContext = JSON.parse(_pullRequestContext) as unknown as PullRequestContext;
      console.log(`PullRequestContext: (${pullRequestContext})`);
      const token = _githubToken;
      const changedLabels: {labelsToAdd: String[], labelsToRemove: String[]} = await updateSdkSuppressionsLabels(pullRequestContext, token);
      console.log(JSON.stringify(changedLabels));
      exit(0);
    } else {
      console.error(getUsage());
      exit(1);
    }
}
  
export { updateSdkSuppressionsLabels };


