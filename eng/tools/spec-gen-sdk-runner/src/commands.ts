import fs from "node:fs";
import path from "node:path";
import { runSpecGenSdkCommand, resetGitRepo } from "./utils.js";
import { LogLevel, logMessage, vsoAddAttachment, vsoLogIssue } from "./log.js";
import { APIViewRequestData, SpecGenSdkCmdInput } from "./types.js";
import { detectChangedSpecConfigFiles } from "./change-files.js";
import {
  generateArtifact,
  getBreakingChangeInfo,
  getExecutionReport,
  getSpecPaths,
  logIssuesToPipeline,
  parseArguments,
  prepareSpecGenSdkCommand,
  setPipelineVariables,
} from "./command-helpers.js";

/**
 * Generate SDK for a single spec.
 * This is for the SDK release scenario.
 * @returns the run status code.
 */
export async function generateSdkForSingleSpec(): Promise<number> {
  // Parse the arguments
  const commandInput: SpecGenSdkCmdInput = parseArguments();
  const specConfigPathText = `${commandInput.tspConfigPath} ${commandInput.readmePath}`;

  // Construct the spec-gen-sdk command
  const specGenSdkCommand = prepareSpecGenSdkCommand(commandInput);
  logMessage(`Generating SDK from ${specConfigPathText}`, LogLevel.Group);
  logMessage(`Runner command:${specGenSdkCommand.join(" ")}`);
  let statusCode = 0;
  try {
    await runSpecGenSdkCommand(specGenSdkCommand);
    logMessage("Runner command executed successfully");
  } catch (error) {
    logMessage(`Runner: error executing command:${error}`, LogLevel.Error);
    statusCode = 1;
  }

  let executionReport;
  try {
    // Read the execution report to determine if the generation was successful
    executionReport = getExecutionReport(commandInput);
    const executionResult = executionReport.executionResult;
    logMessage(`Runner command execution result:${executionResult}`);
  } catch (error) {
    logMessage(`Runner: error reading execution-report.json:${error}`, LogLevel.Error);
    statusCode = 1;
  }

  if (statusCode === 0) {
    // Set the pipeline variables for the SDK pull request
    let packageName: string =
      executionReport.packages[0]?.packageName ??
      commandInput.tspConfigPath ??
      commandInput.readmePath ??
      "missing-package-name";
    packageName = packageName.replace("/", "-");
    const installationInstructions = executionReport.packages[0]?.installationInstructions;
    setPipelineVariables(packageName, installationInstructions);
  }

  logMessage("ending group logging", LogLevel.EndGroup);
  logIssuesToPipeline(executionReport?.vsoLogPath, specConfigPathText);

  return statusCode;
}

/* Generate SDKs for spec pull request */
export async function generateSdkForSpecPr(): Promise<number> {
  // Parse the arguments
  const commandInput: SpecGenSdkCmdInput = parseArguments();
  // Construct the spec-gen-sdk command
  const specGenSdkCommand = prepareSpecGenSdkCommand(commandInput);
  // Get the spec paths from the changed files
  const changedSpecs = detectChangedSpecConfigFiles(commandInput);

  let statusCode = 0;
  let pushedSpecConfigCount;
  let breakingChangeLabel = "";
  let executionReport;
  let changedSpecPathText = "";
  let hasManagementPlaneSpecs = false;
  let overallRunHasBreakingChange = false;
  let currentRunHasBreakingChange = false;
  let overallExecutionResult = "";
  let currentExecutionResult = "";
  let stagedArtifactsFolder = "";
  const apiViewRequestData: APIViewRequestData [] = [];

  for (const changedSpec of changedSpecs) {
    if (!changedSpec.typespecProject && !changedSpec.readmeMd) {
      logMessage("Runner: no spec config file found in the changed files", LogLevel.Warn);
      continue;
    }
    pushedSpecConfigCount = 0;
    changedSpecPathText = "";
    if (changedSpec.typespecProject) {
      specGenSdkCommand.push("--tsp-config-relative-path", changedSpec.typespecProject);
      changedSpecPathText = changedSpec.typespecProject;
      pushedSpecConfigCount++;
      if (changedSpec.typespecProject.includes(".Management")) {
        hasManagementPlaneSpecs = true;
      }
    }
    if (changedSpec.readmeMd) {
      specGenSdkCommand.push("--readme-relative-path", changedSpec.readmeMd);
      changedSpecPathText = changedSpecPathText + " " + changedSpec.readmeMd;
      pushedSpecConfigCount++;
      if (changedSpec.readmeMd.includes("resource-manager")) {
        hasManagementPlaneSpecs = true;
      }
    }
    logMessage(`Generating SDK from ${changedSpecPathText}`, LogLevel.Group);
    logMessage(`Runner command:${specGenSdkCommand.join(" ")}`);

    try {
      await resetGitRepo(commandInput.localSdkRepoPath);
      await runSpecGenSdkCommand(specGenSdkCommand);
      logMessage("Runner command executed successfully");
    } catch (error) {
      logMessage(`Runner: error executing command:${error}`, LogLevel.Error);
      statusCode = 1;
    }
    // Pop the spec config path from specGenSdkCommand
    for (let index = 0; index < pushedSpecConfigCount * 2; index++) {
      specGenSdkCommand.pop();
    }

    try {
      // Read the execution report to aggreate the generation results
      executionReport = getExecutionReport(commandInput);
      currentExecutionResult = executionReport.executionResult;

      if (executionReport.stagedArtifactsFolder) {
        stagedArtifactsFolder = executionReport.stagedArtifactsFolder;
      }

      if (executionReport.stagedArtifactsFolder && executionReport.sdkApiViewArtifactFolder) {
        const apiViewArtifactRelPath = path.relative(executionReport.stagedArtifactsFolder, executionReport.sdkApiViewArtifactFolder);
        for (const pkg of executionReport.packages) {
          if (pkg.apiViewArtifact) {
            const fileName = path.basename(pkg.apiViewArtifact);
            apiViewRequestData.push({
              packageName: pkg.packageName,
              filePath: path.join(apiViewArtifactRelPath, fileName),
            });
          }
        }
      }

      if (overallExecutionResult !== "failed") {
        overallExecutionResult = currentExecutionResult;
      }
      [currentRunHasBreakingChange, breakingChangeLabel] = getBreakingChangeInfo(executionReport);
      overallRunHasBreakingChange = overallRunHasBreakingChange || currentRunHasBreakingChange;
      logMessage(`Runner command execution result:${currentExecutionResult}`);
    } catch (error) {
      logMessage(`Runner: error reading execution-report.json:${error}`, LogLevel.Error);
      statusCode = 1;
      overallExecutionResult = "failed";
    }
    logMessage("ending group logging", LogLevel.EndGroup);
    logIssuesToPipeline(executionReport?.vsoLogPath, changedSpecPathText);
  }
  // Process the spec-gen-sdk artifacts
  statusCode =
    generateArtifact(
      commandInput,
      overallExecutionResult,
      breakingChangeLabel,
      overallRunHasBreakingChange,
      hasManagementPlaneSpecs,
      stagedArtifactsFolder,
      apiViewRequestData
    ) || statusCode;
  return statusCode;
}

/**
 * Generate SDKs for batch specs.
 */
export async function generateSdkForBatchSpecs(batchType: string): Promise<number> {
  // Parse the arguments
  const commandInput: SpecGenSdkCmdInput = parseArguments();
  // Construct the spec-gen-sdk command
  const specGenSdkCommand = prepareSpecGenSdkCommand(commandInput);
  // Get the spec paths based on the batch run type
  const specConfigPaths = getSpecPaths(batchType, commandInput.localSpecRepoPath);

  // Prepare variables
  let statusCode = 0;
  let markdownContent = "\n";
  let failedContent = `## Spec Failures in the Generation Process\n`;
  let succeededContent = `## Successful Specs in the Generation Process\n`;
  let notEnabledContent = `## Specs with SDK Not Enabled\n`;
  let failedCount = 0;
  let notEnabledCount = 0;
  let succeededCount = 0;
  let executionReport;

  // Generate SDKs for each spec
  for (const specConfigPath of specConfigPaths) {
    logMessage(`Generating SDK from ${specConfigPath}`, LogLevel.Group);

    if (specConfigPath.endsWith("tspconfig.yaml")) {
      specGenSdkCommand.push("--tsp-config-relative-path", specConfigPath);
    } else {
      specGenSdkCommand.push("--readme-relative-path", specConfigPath);
    }
    logMessage(`Runner command:${specGenSdkCommand.join(" ")}`);
    try {
      await resetGitRepo(commandInput.localSdkRepoPath);
      await runSpecGenSdkCommand(specGenSdkCommand);
      logMessage("Runner command executed successfully");
    } catch (error) {
      logMessage(`Runner: error executing command:${error}`, LogLevel.Error);
      statusCode = 1;
    }

    // Pop the spec config path from the command
    specGenSdkCommand.pop();
    specGenSdkCommand.pop();

    try {
      // Read the execution report to determine if the generation was successful
      executionReport = getExecutionReport(commandInput);
      const executionResult = executionReport.executionResult;
      logMessage(`Runner: command execution result:${executionResult}`);

      if (executionResult === "succeeded" || executionResult === "warning") {
        succeededContent += `${specConfigPath},`;
        succeededCount++;
      } else if (executionResult === "notEnabled") {
        notEnabledContent += `${specConfigPath},`;
        notEnabledCount++;
      } else {
        failedContent += `${specConfigPath},`;
        failedCount++;
      }
    } catch (error) {
      logMessage(`Runner: error reading execution-report.json:${error}`, LogLevel.Error);
      statusCode = 1;
    }
    logMessage("ending group logging", LogLevel.EndGroup);
    logIssuesToPipeline(executionReport?.vsoLogPath, specConfigPath);
  }
  if (failedCount > 0) {
    markdownContent += `${failedContent}\n`;
  }
  if (notEnabledCount > 0) {
    markdownContent += `${notEnabledContent}\n`;
  }
  if (succeededCount > 0) {
    markdownContent += `${succeededContent}\n`;
  }
  markdownContent += failedCount ? `## Total Failed Specs\n ${failedCount}\n` : "";
  markdownContent += notEnabledCount
    ? `## Total Specs with SDK not enabled in the Configuration\n ${notEnabledCount}\n`
    : "";
  markdownContent += succeededCount ? `## Total Successful Specs\n ${succeededCount}\n` : "";
  markdownContent += `## Total Specs Count\n ${specConfigPaths.length}\n\n`;

  // Write the markdown content to a file
  const markdownFilePath = path.join(commandInput.workingFolder, "out/logs/generation-summary.md");
  try {
    if (fs.existsSync(markdownFilePath)) {
      fs.rmSync(markdownFilePath);
    }
    fs.writeFileSync(markdownFilePath, markdownContent);
    logMessage(`Runner: markdown file written to ${markdownFilePath}`);
    vsoAddAttachment("Generation Summary", markdownFilePath);
  } catch (error) {
    vsoLogIssue(`Runner: error writing markdown file ${markdownFilePath}:${error}`);
    statusCode = 1;
  }
  return statusCode;
}
