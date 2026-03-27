import { existsSync, mkdirSync } from "node:fs";
import path from "node:path";
import { exit } from "node:process";
import {
  generateSdkForBatchSpecs,
  generateSdkForSingleSpec,
  generateSdkForSpecPr,
} from "./commands.js";
import { getArgumentValue } from "./utils.js";

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
  let result;
  try {
    if (batchType) {
      result = await generateSdkForBatchSpecs(batchType);
    } else if (pullRequestNumber) {
      result = await generateSdkForSpecPr();
    } else {
      result = await generateSdkForSingleSpec();
    }
  } catch (error) {
    console.error("Unhandled exception in spec-gen-sdk-runner:", error);
    console.log("##vso[task.complete result=Failed;]");
    exit(1);
  }
  if (result.statusCode !== 0) {
    console.log("##vso[task.complete result=Failed;]");
  } else if (result.executionResult === "warning") {
    console.log("##vso[task.complete result=SucceededWithIssues;]");
  }
  exit(result.statusCode);
}
