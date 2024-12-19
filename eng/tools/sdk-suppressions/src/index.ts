
import { exit } from "process";
import { updateSdkSuppressionsLabels, PullRequestContext } from "./updateSdkSuppressionsLabel.js";

function getArgsError(): string {
  return (
    "Usage: node eng/tools/sdk-suppressions/cmd/sdk-suppressions-label.js baseCommitHash headCommitHash\n" +
    "Returns: {labelsToAdd: [label1, label2],labelsToRemove: [lable3, label4]}\n" 
  );
}

export async function main() {
  const args: string[] = process.argv.slice(2);
  if (args.length === 2) {
    const baseCommitHash: string = args[0];
    const headCommitHash: string = args[1];
    const pullRequestContext = process.env.GITHUB_PULL_REQUEST_CONTEXT as string;
    const outputFile = process.env.OUTPUT_FILE as string;
    const prChangeFiles = process.env.GITHUB_PULL_REQUEST_CHANGE_FILES as string;
    const _pullRequestContext = JSON.parse(pullRequestContext) as unknown as PullRequestContext;
    const changedLabels: {labelsToAdd: String[], labelsToRemove: String[]} = await updateSdkSuppressionsLabels(_pullRequestContext, prChangeFiles, outputFile, baseCommitHash, headCommitHash);
    console.log(JSON.stringify(changedLabels));
    exit(0);
  } else {
    console.error(getArgsError());
    exit(1);
  }

}
  
export { updateSdkSuppressionsLabels };


