
import { exit } from "process";
import { updateSdkSuppressionsLabels, PullRequestContext } from "./updateSdkSuppressionsLabel.js";

function getUsage(): string {
    return (
      "parameter missing! \n"
    );
  }

export async function main() {
    const PullRequestContext = process.env.GITHUB_PULL_REQUEST_CONTEXT as unknown as PullRequestContext;
    const GITHUB_TOKEN = process.env.GITHUB_TOKEN;
    console.log(`PullRequestContext: JSON.stringify(${PullRequestContext})`);

    if (PullRequestContext && GITHUB_TOKEN) {
      const changedLabels: {labelsToAdd: String[], labelsToRemove: String[]} = await updateSdkSuppressionsLabels(PullRequestContext, GITHUB_TOKEN);
      console.log(JSON.stringify(changedLabels));
      exit(0);
    } else {
      console.error(getUsage());
      exit(1);
    }
}
  
export { updateSdkSuppressionsLabels };


