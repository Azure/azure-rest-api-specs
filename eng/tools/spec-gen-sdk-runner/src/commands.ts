import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  findReadmeFiles,
  getArgumentValue,
  runSpecGenSdkCommand,
  getAllTypeSpecPaths,
} from "./utils.js";
import { LogLevel, logMessage, vsoAddAttachment } from "./log.js";
import { SpecGenSdkCmdInput } from "./types.js";

export async function generateSdkForSingleSpec(): Promise<number> {
  // Parse the arguments
  const commandInput: SpecGenSdkCmdInput = parseArguments();
  const specConfigPath = commandInput.tspConfigPath ?? commandInput.readmePath;
  // Construct the spec-gen-sdk command
  const specGenSdkCommand = prepareSpecGenSdkCommand(commandInput);
  logMessage(`Generating SDK from ${specConfigPath}`, LogLevel.Group);
  logMessage(`Command:${specGenSdkCommand.join(" ")}`);
  let statusCode = 0;
  try {
    await runSpecGenSdkCommand(specGenSdkCommand);
    logMessage("Command executed successfully");
  } catch (error) {
    logMessage(`Error executing command:${error}`, LogLevel.Error);
    statusCode = 1;
  }
  // Read the execution report to determine if the generation was successful
  const executionReportPath = path.join(
    commandInput.workingFolder,
    `${commandInput.sdkRepoName}_tmp/execution-report.json`,
  );
  try {
    const executionReport = JSON.parse(fs.readFileSync(executionReportPath, "utf8"));
    // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
    const executionResult = executionReport.packages[0]?.result;
    logMessage(`Execution Result:${executionResult}`);
  } catch (error) {
    logMessage(`Error reading execution report at ${executionReportPath}:${error}`, LogLevel.Error);
    statusCode = 1;
  }
  logMessage("ending group logging", LogLevel.EndGroup);
  return statusCode;
}

/**
 * Generate SDKs for all specs.
 */
export async function generateSdkForBatchSpecs(runMode: string): Promise<number> {
  // Parse the arguments
  const commandInput: SpecGenSdkCmdInput = parseArguments();
  // Construct the spec-gen-sdk command
  const specGenSdkCommand = prepareSpecGenSdkCommand(commandInput);
  // Get the spec paths based on the run mode
  const specConfigPaths = getSpecPaths(runMode, commandInput.localSpecRepoPath);

  // Prepare variables
  let statusCode = 0;
  let markdownContent = "\n";
  let failedContent = `## Specs Failed in Generation\n`;
  let succeededContent = `## Specs Succeeded in Generation\n`;
  let undefinedContent = `## Specs disabled for this language emitter\n`;
  let failedCount = 0;
  let undefinedCount = 0;
  let succeededCount = 0;

  // Generate SDKs for each spec
  for (const specConfigPath of specConfigPaths) {
    logMessage(`Generating SDK from ${specConfigPath}`, LogLevel.Group);
    if (specConfigPath.endsWith("tspconfig.yaml")) {
      specGenSdkCommand.push("--tsp-config-relative-path", specConfigPath);
    } else {
      specGenSdkCommand.push("--readme-relative-path", specConfigPath);
    }
    logMessage(`Command:${specGenSdkCommand.join(" ")}`);
    try {
      await runSpecGenSdkCommand(specGenSdkCommand);
      logMessage("Command executed successfully");
    } catch (error) {
      logMessage(`Error executing command:${error}`, LogLevel.Error);
      statusCode = 1;
    }

    // Pop the spec config path from the command
    specGenSdkCommand.pop();
    specGenSdkCommand.pop();
    // Read the execution report to determine if the generation was successful
    const executionReportPath = path.join(
      commandInput.workingFolder,
      `${commandInput.sdkRepoName}_tmp/execution-report.json`,
    );
    try {
      const executionReport = JSON.parse(fs.readFileSync(executionReportPath, "utf8"));
      // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
      const executionResult = executionReport.packages[0]?.result;
      logMessage(`Execution Result:${executionResult}`);

      if (executionResult === "succeeded") {
        succeededContent += `${specConfigPath},`;
        succeededCount++;
      } else if (executionResult === undefined) {
        undefinedContent += `${specConfigPath},`;
        undefinedCount++;
      } else {
        failedContent += `${specConfigPath},`;
        failedCount++;
      }
    } catch (error) {
      logMessage(
        `Error reading execution report at ${executionReportPath}:${error}`,
        LogLevel.Error,
      );
      statusCode = 1;
    }
    logMessage("ending group logging", LogLevel.EndGroup);
  }
  if (failedCount > 0) {
    markdownContent += `${failedContent}\n`;
  }
  if (undefinedCount > 0) {
    markdownContent += `${undefinedContent}\n`;
  }
  if (succeededCount > 0) {
    markdownContent += `${succeededContent}\n`;
  }
  markdownContent += `## Total Specs Failed\n ${failedCount}\n`;
  markdownContent += `## Total Specs Undefined this Language Emitter\n ${undefinedCount}\n`;
  markdownContent += `## Total Specs Succeeded\n ${succeededCount}\n`;
  markdownContent += `## Total Specs\n ${specConfigPaths.length}\n\n`;

  // Write the markdown content to a file
  const markdownFilePath = path.join(commandInput.workingFolder, "out/logs/generation-summary.md");
  try {
    if (fs.existsSync(markdownFilePath)) {
      fs.rmSync(markdownFilePath);
    }
    fs.writeFileSync(markdownFilePath, markdownContent);
    logMessage(`Markdown file written to ${markdownFilePath}`);
    vsoAddAttachment("Generation Summary", markdownFilePath);
  } catch (error) {
    logMessage(`Error writing markdown file ${markdownFilePath}:${error}`, LogLevel.Error);
    statusCode = 1;
  }
  return statusCode;
}

/**
 * Parse the arguments.
 * @returns The spec-gen-sdk command input.
 */
function parseArguments(): SpecGenSdkCmdInput {
  const __filename: string = fileURLToPath(import.meta.url);
  const __dirname: string = path.dirname(__filename);

  // Get the arguments passed to the script
  const args: string[] = process.argv.slice(2);
  const localSpecRepoPath: string = path.resolve(
    getArgumentValue(args, "--scp", path.join(__dirname, "..", "..")),
  );
  const sdkRepoName: string = getArgumentValue(args, "--lang", "azure-sdk-for-net");
  const localSdkRepoPath: string = path.resolve(
    getArgumentValue(args, "--sdp", path.join(localSpecRepoPath, "..", sdkRepoName)),
  );
  const workingFolder: string = path.resolve(
    getArgumentValue(args, "--wf", path.join(localSpecRepoPath, "..")),
  );
  return {
    workingFolder,
    localSpecRepoPath,
    localSdkRepoPath,
    sdkRepoName,
    isTriggeredByPipeline: getArgumentValue(args, "--tr", "false"),
    tspConfigPath: getArgumentValue(args, "--tsp-config-relative-path", ""),
    readmePath: getArgumentValue(args, "--readme-relative-path", ""),
    prNumber: getArgumentValue(args, "--pr-number", ""),
    specCommitSha: getArgumentValue(args, "--commit", "HEAD"),
    specRepoHttpsUrl: getArgumentValue(args, "--spec-repo-url", ""),
    headRepoHttpsUrl: getArgumentValue(args, "--head-repo-url", ""),
    headBranch: getArgumentValue(args, "--head-branch", ""),
  };
}

/**
 * Prepare the spec-gen-sdk command.
 * @param commandInput The command input.
 * @returns The spec-gen-sdk command.
 */
function prepareSpecGenSdkCommand(commandInput: SpecGenSdkCmdInput): string[] {
  const specGenSdkCommand = [];
  specGenSdkCommand.push(
    "spec-gen-sdk",
    "--scp",
    commandInput.localSpecRepoPath,
    "--sdp",
    commandInput.localSdkRepoPath,
    "--wf",
    commandInput.workingFolder,
    "-l",
    commandInput.sdkRepoName,
    "-c",
    commandInput.specCommitSha,
    "-t",
    commandInput.isTriggeredByPipeline,
  );
  if (commandInput.specRepoHttpsUrl) {
    specGenSdkCommand.push("--spec-repo-url", commandInput.specRepoHttpsUrl);
  }
  if (commandInput.prNumber) {
    specGenSdkCommand.push("--pr-number", commandInput.prNumber);
  }
  if (commandInput.tspConfigPath) {
    specGenSdkCommand.push("--tsp-config-relative-path", commandInput.tspConfigPath);
  }
  if (commandInput.readmePath) {
    specGenSdkCommand.push("--readme-relative-path", commandInput.readmePath);
  }
  if (commandInput.headRepoHttpsUrl) {
    specGenSdkCommand.push("--head-repo-url", commandInput.headRepoHttpsUrl);
  }
  if (commandInput.headBranch) {
    specGenSdkCommand.push("--head-branch", commandInput.headBranch);
  }
  return specGenSdkCommand;
}

/**
 * Get the spec paths based on the run mode.
 * @param runMode The run mode.
 * @param specRepoPath The specification repository path.
 * @returns The spec paths.
 */
function getSpecPaths(runMode: string, specRepoPath: string): string[] {
  const specConfigPaths: string[] = [];
  switch (runMode) {
    case "all-specs": {
      specConfigPaths.push(
        ...getAllTypeSpecPaths(specRepoPath),
        ...findReadmeFiles(path.join(specRepoPath, "specification")),
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
