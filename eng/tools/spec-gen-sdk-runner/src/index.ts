import { exit } from "node:process";
import { getArgumentValue } from "./utils.js";
import {
  generateSdkForBatchSpecs,
  generateSdkForSingleSpec,
  generateSdkForSpecPr,
} from "./commands.js";

export async function main() {
  // Get the arguments passed to the script
  const args: string[] = process.argv.slice(2);
  // Log the arguments to the console
  console.log("Arguments passed to the script:", args.join(" "));
  const runMode: string = getArgumentValue(args, "--rm", "");
  const pullRequestNumber: string = getArgumentValue(args, "--pr-number", "");
  let statusCode = 0;
  if (runMode) {
    statusCode = await generateSdkForBatchSpecs(runMode);
  } else if (pullRequestNumber) {
    statusCode = await generateSdkForSpecPr();
  } else {
    statusCode = await generateSdkForSingleSpec();
  }
  exit(statusCode);
}
