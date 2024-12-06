
import { exit } from "process";
import { updateSdkSuppressionsLabels, PullRequestContext } from "./updateSdkSuppressionsLabel.js";

function getUsage(): string {
    return (
      "  Usage: npx get-specs-model <path-to-specs-file-or-directory>\n" +
      "Returns: JSON metadata for the input file or directory.\n" +
      "\n" +
      "The input path:\n" +
      "- Must be an absolute or relative path to local clone of the https://github.com/Azure/azure-rest-api-specs or https://github.com/Azure/azure-rest-api-specs-pr repo.\n" +
      "- Must point to the <local_clone>/specification directory or one of its descendants.\n" +
      "\n" +
      "Example: npx get-specs-model $HOME/repos/azure-rest-api-specs/specification\n" +
      "Returns: JSON with metadata for the entire 'specification' directory of the local clone of 'azure-rest-api-specs' repo.\n"
    );
  }

export async function main() {
    const PullRequestContext = process.env.PullRequestContext as unknown as PullRequestContext;
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


