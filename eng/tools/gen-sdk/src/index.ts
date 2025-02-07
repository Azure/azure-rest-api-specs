/* eslint-disable @typescript-eslint/restrict-template-expressions */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable unicorn/prefer-ternary */
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { exit } from "node:process";
import {
  findReadmeFiles,
  getArgumentValue,
  runSpecGenSdkCommand,
  getAllTypeSpecPaths,
} from "./utils.js";

export async function main(): Promise<void> {
  const __filename: string = fileURLToPath(import.meta.url);
  const __dirname: string = path.dirname(__filename);

  const args: string[] = process.argv.slice(2);
  const specRepoPath: string = path.resolve(
    getArgumentValue(args, "--scp", path.join(__dirname, "..", ".."))
  );
  const sdkLanguage: string = getArgumentValue(args, "--lang", "azure-sdk-for-net");
  const sdkRepoPath: string = path.resolve(
    getArgumentValue(args, "--sdp", path.join(specRepoPath, "..", sdkLanguage))
  );
  const workingFolder: string = path.resolve(
    getArgumentValue(args, "--wf", path.join(specRepoPath, ".."))
  );
  const triggerByPipeline: string = getArgumentValue(args, "--tr", "false");
  const specRepoCommit: string = getArgumentValue(args, "--commit", "HEAD");
  const runMode: string = getArgumentValue(args, "--rm", "sample-typespecs");

  const specConfigPaths = getSpecPaths(runMode, specRepoPath);
  let markdownContent = "# Generation Summary\n";
  markdownContent += `## Specs Failed in Generation\n`;
  let succeededContent = `## Specs Succeeded in Generation\n`;
  let failedCount = 0;
  for (const specConfigPath of specConfigPaths) {
    console.log(`Generating SDK from ${specConfigPath}`);
    const specGenSdkCommand = [];
    specGenSdkCommand.push(
      "spec-gen-sdk",
      "--scp",
      specRepoPath,
      "--sdp",
      sdkRepoPath,
      "--wf",
      workingFolder,
      "-l",
      sdkLanguage,
      "-c",
      specRepoCommit,
      "-t",
      triggerByPipeline
    );

    if (specConfigPath.endsWith("tspconfig.yaml")) {
      specGenSdkCommand.push("--tsp-config-relative-path", specConfigPath);
    } else {
      specGenSdkCommand.push("--readme-relative-path", specConfigPath);
    }
    console.log("Command:", specGenSdkCommand.join(" "));
    try {
      await runSpecGenSdkCommand(specGenSdkCommand);
      console.log("Command executed successfully");
    } catch (error) {
      console.error("Error executing command:", error);
    }

    const executionReportPath = path.join(workingFolder, `${sdkLanguage}_tmp/executionReport.json`);
    try {
      const executionReport = JSON.parse(fs.readFileSync(executionReportPath, "utf8"));
      // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
      const executionResult = executionReport.packages[0]?.result;
      console.log("Execution Result:", executionResult);

      if (executionResult === "failed") {
        markdownContent += `${specConfigPath},`;
        failedCount++;
      } else {
        succeededContent += `${specConfigPath},`;
      }
    } catch (error) {
      console.error(`Error reading execution report at ${executionReportPath}:`, error);
    }
  }
  markdownContent += `\n${succeededContent}\n`;
  markdownContent += `## Total Specs Failed:\n ${failedCount}\n`;
  markdownContent += `## Total Specs Generated:\n ${specConfigPaths.length}\n\n`;
  const markdownFilePath = path.join(workingFolder, "out/logs/generation-summary.md");
  try {
    if (fs.existsSync(markdownFilePath)) {
      fs.rmSync(markdownFilePath);
    }
    fs.writeFileSync(markdownFilePath, markdownContent);
    console.log(`Markdown file written to ${markdownFilePath}`);
  } catch (error) {
    console.error(`Error writing markdown file ${markdownFilePath}:`, error);
    exit(1);
  }
  exit(0);
}

function getSpecPaths(runMode: string, specRepoPath: string): string[] {
  const specConfigPaths: string[] = [];
  switch (runMode) {
    case "all-specs": {
      specConfigPaths.push(
        ...getAllTypeSpecPaths(specRepoPath),
        ...findReadmeFiles(path.join(specRepoPath, "specification"))
      );
      break;
    }
    case "all-typespecs": {
      specConfigPaths.push(...getAllTypeSpecPaths(specRepoPath));
      break;
    }
    case "all-openapis": {
      specConfigPaths.push(...findReadmeFiles(path.join(specRepoPath, "specification")));
      break;
    }
    case "sample-typespecs": {
      specConfigPaths.push("specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml");
    }
  }
  return specConfigPaths;
}
