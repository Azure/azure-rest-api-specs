import { exit } from "process";
import { updateSdkSuppressionsLabels } from "./updateSdkSuppressionsLabel.js";

function getArgsError(args: string[]): string {
  return (
    "Get args lengths: " +
    args.length +
    "\n" +
    "Details: " +
    args.join(", ") +
    "\n" +
    "Usage: node eng/tools/sdk-suppressions/cmd/sdk-suppressions-label.js baseCommitHash headCommitHash prLabels\n" +
    "Returns: {labelsToAdd: [label1, label2],labelsToRemove: [lable3, label4]}\n" +
    "Parameters:\n" +
    "  baseCommitHash: The base commit hash. Example: HEAD^ \n" +
    "  headCommitHash: The head commit hash. Example: HEAD \n" +
    "  prLabels: All pull reqeuest labels have been added, including breaking-language-sdk-suppression. Example: '['BreakingChange-Go-Sdk-Suppression', 'BreakingChange-Python-Sdk-Suppression']'\n"
  );
}

export async function main() {
  const args: string[] = process.argv.slice(2);
  if (args.length === 3) {
    const baseCommitHash: string = args[0];
    const headCommitHash: string = args[1];
    const lables: string = args[2];
    const outputFile = process.env.OUTPUT_FILE as string;
    const changedLabels: { labelsToAdd: String[]; labelsToRemove: String[] } =
      await updateSdkSuppressionsLabels(baseCommitHash, headCommitHash, lables, outputFile);
    console.log(JSON.stringify(changedLabels));
    exit(0);
  } else {
    console.error(getArgsError(args));
    exit(1);
  }
}

export { updateSdkSuppressionsLabels };
