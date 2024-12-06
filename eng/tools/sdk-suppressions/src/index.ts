
import { exit } from "process";
import { updateSdkSuppressionsLabels, PullRequestContext } from "./updateSdkSuppressionsLabel.js";

function getUsage(): string {
    return (
      "parameter missing! \n"
    );
  }

export async function main() {
    const GITHUB_PULL_REQUEST_CONTEXT = process.env.GITHUB_PULL_REQUEST_CONTEXT as string;
    const GITHUB_TOKEN = process.env.GITHUB_TOKEN as string;
    console.log(`PullRequestContext: (${GITHUB_PULL_REQUEST_CONTEXT})`);
    console.log(`GITHUB_TOKEN: is exist ? ${!!GITHUB_TOKEN}`);
    console.log(`GITHUB_PULL_REQUEST_CONTEXT: is exist ? ${!!GITHUB_PULL_REQUEST_CONTEXT}`);

    if (GITHUB_PULL_REQUEST_CONTEXT && GITHUB_TOKEN) {
      const pullRequestContext = JSON.parse(GITHUB_PULL_REQUEST_CONTEXT) as unknown as PullRequestContext;
      const token = GITHUB_TOKEN;
      const changedLabels: {labelsToAdd: String[], labelsToRemove: String[]} = await updateSdkSuppressionsLabels(pullRequestContext, token);
      console.log(JSON.stringify(changedLabels));
      exit(0);
    } else {
      console.error(getUsage());
      exit(1);
    }
}
  
export { updateSdkSuppressionsLabels };


