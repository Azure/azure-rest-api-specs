import fs from "node:fs";
import path from "node:path";
import { runSpecGenSdkCommand, resetGitRepo, SpecConfigs } from "./utils.js";
import { LogLevel, logMessage, vsoAddAttachment, vsoLogIssue } from "./log.js";
import { APIViewRequestData, SpecGenSdkCmdInput } from "./types.js";
import { detectChangedSpecConfigFiles } from "./spec-helpers.js";
import {
  generateArtifact,
  getBreakingChangeInfo,
  getExecutionReport,
  getServiceFolderPath,
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
    setPipelineVariables(
      executionReport.stagedArtifactsFolder,
      false,
      packageName,
      installationInstructions,
    );
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
  const apiViewRequestData: APIViewRequestData[] = [];

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
      changedSpecPathText = changedSpec.readmeMd;
      pushedSpecConfigCount++;
      if (pushedSpecConfigCount === 2) {
        // If both readme and tspconfig are provided, we need to use the service folder path for the log message
        changedSpecPathText = getServiceFolderPath(changedSpec.readmeMd);
      }
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
        for (const pkg of executionReport.packages) {
          if (pkg.apiViewArtifact) {
            apiViewRequestData.push({
              packageName: pkg.packageName,
              filePath: path.relative(stagedArtifactsFolder, pkg.apiViewArtifact),
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
      apiViewRequestData,
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
  if (
    batchType === "all-typespecs" ||
    batchType === "all-mgmtplane-typespecs" ||
    batchType === "all-dataplane-typespecs"
  ) {
    specGenSdkCommand.push("--skip-sdk-gen-from-openapi", "true");
  }

  // Get the spec paths based on the batch run type
  const specConfigsArray: SpecConfigs[] = getSpecPaths(batchType, commandInput.localSpecRepoPath);

  // Prepare variables
  let statusCode = 0;
  let pushedSpecConfigCount;
  let markdownContent = "\n";
  markdownContent += `## Batch Run Type\n ${batchType}\n`;
  let failedContent = `## Spec Failures in the Generation Process\n`;
  let succeededContent = `## Successful Specs in the Generation Process\n`;
  let notEnabledContent = `## Specs with SDK Not Enabled\n`;
  let duplicatedConfigContent = `## Specs with Duplicated SDK Configurations (in 'tspconfig.yaml' and 'readme.md')\n`;
  let failedCount = 0;
  let notEnabledCount = 0;
  let duplicatedConfigCount = 0;
  let succeededCount = 0;
  let executionReport;
  let specConfigPath = "";
  let stagedArtifactsFolder = "";
  let serviceFolderPath = "";

  // Generate SDKs for each spec
  for (const specConfigs of specConfigsArray) {
    if (specConfigs.tspconfigPath && specConfigs.readmePath) {
      serviceFolderPath = getServiceFolderPath(specConfigs.tspconfigPath);
      logMessage(`Generating SDK from ${serviceFolderPath}`, LogLevel.Group);
    } else if (specConfigs.tspconfigPath) {
      logMessage(`Generating SDK from ${specConfigs.tspconfigPath}`, LogLevel.Group);
    } else if (specConfigs.readmePath) {
      logMessage(`Generating SDK from ${specConfigs.readmePath}`, LogLevel.Group);
    }
    pushedSpecConfigCount = 0;
    if (specConfigs.readmePath) {
      specConfigPath = specConfigs.readmePath;
      specGenSdkCommand.push("--readme-relative-path", specConfigs.readmePath);
      pushedSpecConfigCount++;
    }

    if (specConfigs.tspconfigPath) {
      // Override specConfigPath variable for reporting purposes
      // as we only input both tspconfig and readme while selecting typespec options for batch runs
      specConfigPath = specConfigs.tspconfigPath;
      specGenSdkCommand.push("--tsp-config-relative-path", specConfigs.tspconfigPath);
      pushedSpecConfigCount++;
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

    // Pop the spec config path from specGenSdkCommand
    for (let index = 0; index < pushedSpecConfigCount * 2; index++) {
      specGenSdkCommand.pop();
    }

    try {
      // Read the execution report to determine if the generation was successful
      executionReport = getExecutionReport(commandInput);
      const executionResult = executionReport.executionResult;
      if (executionReport.stagedArtifactsFolder) {
        stagedArtifactsFolder = executionReport.stagedArtifactsFolder;
      }
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
      // Check for duplicated SDK configurations,
      // the execution result can be "succeeded" or "warning"
      if (executionReport.isSdkConfigDuplicated) {
        duplicatedConfigContent += `${specConfigPath},`;
        duplicatedConfigCount++;
      }
    } catch (error) {
      logMessage(`Runner: error reading execution-report.json:${error}`, LogLevel.Error);
      statusCode = 1;
    }
    logMessage("ending group logging", LogLevel.EndGroup);
    if (specConfigs.tspconfigPath && specConfigs.readmePath) {
      specConfigPath = serviceFolderPath;
    }
    logIssuesToPipeline(executionReport?.vsoLogPath, specConfigPath);
  }
  if (failedCount > 0) {
    markdownContent += `${failedContent}\n`;
  }
  if (notEnabledCount > 0) {
    markdownContent += `${notEnabledContent}\n`;
  }
  if (duplicatedConfigCount > 0) {
    markdownContent += `${duplicatedConfigContent}\n`;
  }
  if (succeededCount > 0) {
    markdownContent += `${succeededContent}\n`;
  }
  markdownContent += failedCount ? `## Total Failed Specs\n ${failedCount}\n` : "";
  markdownContent += notEnabledCount
    ? `## Total Specs with SDK not enabled in the Configuration\n ${notEnabledCount}\n`
    : "";
  markdownContent += duplicatedConfigCount
    ? `## Total Specs with Duplicated SDK Configurations\n ${duplicatedConfigCount}\n`
    : "";
  markdownContent += succeededCount ? `## Total Successful Specs\n ${succeededCount}\n` : "";
  markdownContent += `## Total Specs Count\n ${specConfigsArray.length}\n\n`;

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
  // Set the pipeline variables for artifacts location
  setPipelineVariables(stagedArtifactsFolder);

  return statusCode;
}
