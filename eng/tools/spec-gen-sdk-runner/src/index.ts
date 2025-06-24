import { exit } from "node:process";
import path from "node:path";
import { existsSync, mkdirSync } from "node:fs";
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
  const batchType: string = getArgumentValue(args, "--batch-type", "");
  const pullRequestNumber: string = getArgumentValue(args, "--pr-number", "");
  console.log("Current working directory:", process.cwd());
  const workingFolder: string = getArgumentValue(args, "--wf", path.join(process.cwd(), ".."));
  const logFolder = path.join(workingFolder, "out/logs");
  if (!existsSync(logFolder)) {
    mkdirSync(logFolder, { recursive: true });
  }
  let statusCode = 0;
  if (batchType) {
    statusCode = await generateSdkForBatchSpecs(batchType);
  } else if (pullRequestNumber) {
    statusCode = await generateSdkForSpecPr();
  } else {
    statusCode = await generateSdkForSingleSpec();
  }
  if (statusCode !== 0) {
    console.log("##vso[task.complete result=Failed;]");
  }
  exit(statusCode);
}
