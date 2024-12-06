
import { exit } from "process";
import { updateSdkSuppressionsLabels, PullRequestContext } from "./updateSdkSuppressionsLabel.js";

function getUsage(): string {
    return (
      "parameter missing! \n"
    );
  }

export async function main() {
    const pullRequestContext = process.env.GITHUB_PULL_REQUEST_CONTEXT as string;
    const githubToken = process.env.GITHUB_TOKEN as string;
    if (pullRequestContext && githubToken) {
      const _pullRequestContext = JSON.parse(pullRequestContext) as unknown as PullRequestContext;
      const _token = githubToken;
      const changedLabels: {labelsToAdd: String[], labelsToRemove: String[]} = await updateSdkSuppressionsLabels(_pullRequestContext, _token);
      console.log(JSON.stringify(changedLabels));
      exit(0);
    } else {
      console.error(getUsage());
      exit(1);
    }
}
  
export { updateSdkSuppressionsLabels };


