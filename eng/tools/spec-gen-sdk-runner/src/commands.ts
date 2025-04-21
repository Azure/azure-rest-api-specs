import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  findReadmeFiles,
  getArgumentValue,
  runSpecGenSdkCommand,
  getAllTypeSpecPaths,
  resetGitRepo,
  objectToMap,
} from "./utils.js";
import {
  LogIssueType,
  LogLevel,
  logMessage,
  setVsoVariable,
  vsoAddAttachment,
  vsoLogIssue,
} from "./log.js";
import { SpecGenSdkArtifactInfo, SpecGenSdkCmdInput, VsoLogs } from "./types.js";
import { detectChangedSpecConfigFiles } from "./change-files.js";

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
  let managementPlaneSpecType = false;
  let dataPlaneSpecType = false;

  let statusCode = 0;
  let pushedSpecConfigCount;
  let shouldLabelBreakingChange = false;
  let breakingChangeLabel = "";
  let executionReport;
  let changedSpecPathText = "";
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
        managementPlaneSpecType = true;
      } else {
        dataPlaneSpecType = true;
      }
    }
    if (changedSpec.readmeMd) {
      specGenSdkCommand.push("--readme-relative-path", changedSpec.readmeMd);
      changedSpecPathText = changedSpecPathText + " " + changedSpec.readmeMd;
      pushedSpecConfigCount++;
      if (changedSpec.readmeMd.includes("resource-manager")) {
        managementPlaneSpecType = true;
      } else if (changedSpec.readmeMd.includes("data-plane")) {
        dataPlaneSpecType = true;
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
      // Read the execution report to determine if the generation was successful
      executionReport = getExecutionReport(commandInput);
      const executionResult = executionReport.executionResult;
      [shouldLabelBreakingChange, breakingChangeLabel] = getBreakingChangeInfo(executionReport);
      logMessage(`Runner command execution result:${executionResult}`);
    } catch (error) {
      logMessage(`Runner: error reading execution-report.json:${error}`, LogLevel.Error);
      statusCode = 1;
    }
    logMessage("ending group logging", LogLevel.EndGroup);
    logIssuesToPipeline(executionReport?.vsoLogPath, changedSpecPathText);
  }
  // Process the spec-gen-sdk artifacts
  const specGenSdkArtifactInfo: SpecGenSdkArtifactInfo = {
    managementPlane: managementPlaneSpecType,
    dataPlane: dataPlaneSpecType,
  };
  statusCode =
    generateArtifact(
      commandInput,
      specGenSdkArtifactInfo,
      shouldLabelBreakingChange,
      breakingChangeLabel,
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

/**
 * Load execution-report.json.
 * @param commandInput - The command input.
 * @returns the execution report JSON
 */
function getExecutionReport(commandInput: SpecGenSdkCmdInput): any {
  // Read the execution report to determine if the generation was successful
  const executionReportPath = path.join(
    commandInput.workingFolder,
    `${commandInput.sdkRepoName}_tmp/execution-report.json`,
  );
  return JSON.parse(fs.readFileSync(executionReportPath, "utf8"));
}

/**
 * Set the pipeline variables for the SDK pull request.
 * @param packageName - The package name.
 * @param installationInstructions - The installation instructions.
 */
function setPipelineVariables(packageName: string, installationInstructions: string = ""): void {
  const branchName = `sdkauto/${packageName?.replace("/", "_")}`;
  const prTitle = `[AutoPR ${packageName}]`;
  const prBody = installationInstructions;
  setVsoVariable("PrBranch", branchName);
  setVsoVariable("PrTitle", prTitle);
  setVsoVariable("PrBody", prBody);
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

  // Set runMode to "release" by default
  let runMode = "release";
  const batchType: string = getArgumentValue(args, "--batch-type", "");
  const pullRequestNumber: string = getArgumentValue(args, "--pr-number", "");
  if (batchType) {
    runMode = "batch";
  } else if (pullRequestNumber) {
    runMode = "spec-pull-request";
  }

  return {
    workingFolder,
    localSpecRepoPath,
    localSdkRepoPath,
    sdkRepoName,
    sdkLanguage: sdkRepoName.replace("-pr", ""),
    runMode,
    tspConfigPath: getArgumentValue(args, "--tsp-config-relative-path", ""),
    readmePath: getArgumentValue(args, "--readme-relative-path", ""),
    prNumber: getArgumentValue(args, "--pr-number", ""),
    apiVersion: getArgumentValue(args, "--api-version", ""),
    sdkReleaseType: getArgumentValue(args, "--sdk-release-type", ""),
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
    "--rm",
    commandInput.runMode,
  );
  if (commandInput.specRepoHttpsUrl) {
    specGenSdkCommand.push("--spec-repo-https-url", commandInput.specRepoHttpsUrl);
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
  if (commandInput.apiVersion) {
    specGenSdkCommand.push("--api-version", commandInput.apiVersion);
  }
  if (commandInput.sdkReleaseType) {
    specGenSdkCommand.push("--sdk-release-type", commandInput.sdkReleaseType);
  }
  return specGenSdkCommand;
}

/**
 * Get the spec paths based on the batch run type.
 * @param batchType The batch run type.
 * @param specRepoPath The specification repository path.
 * @returns The spec paths.
 */
function getSpecPaths(batchType: string, specRepoPath: string): string[] {
  const specConfigPaths: string[] = [];
  switch (batchType) {
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
      specConfigPaths.push(
        "specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
        "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
      );
    }
  }
  return specConfigPaths;
}

/**
 * Logs issues to Azure DevOps Pipeline *
 * @param logPath - The vso log file path.
 * @param specConfigDisplayText - The display text for the spec configuration.
 */
function logIssuesToPipeline(logPath: string, specConfigDisplayText: string): void {
  let vsoLogs: VsoLogs;
  try {
    const logContent = JSON.parse(fs.readFileSync(logPath, "utf8"));
    vsoLogs = objectToMap(logContent);
  } catch (error) {
    throw new Error(`Runner: error reading log at ${logPath}:${error}`);
  }

  if (vsoLogs) {
    const errors = [...vsoLogs.values()].flatMap((entry) => entry.errors ?? []);
    const warnings = [...vsoLogs.values()].flatMap((entry) => entry.warnings ?? []);
    if (errors.length > 0) {
      const errorTitle = `Errors occurred while generating SDK from ${specConfigDisplayText}`;
      logMessage(errorTitle, LogLevel.Group);
      const errorsWithTitle = [errorTitle, ...errors];
      vsoLogIssue(errorsWithTitle.join("%0D%0A"));
      logMessage("ending group logging", LogLevel.EndGroup);
    }
    if (warnings.length > 0) {
      const warningTitle = `Warnings occurred while generating SDK from ${specConfigDisplayText}`;
      logMessage(warningTitle, LogLevel.Group);
      const warningsWithTitle = [warningTitle, ...warnings];
      vsoLogIssue(warningsWithTitle.join("%0D%0A"), LogIssueType.Warning);
      logMessage("ending group logging", LogLevel.EndGroup);
    }
  }
}

/**
 * Process the breaking change label artifacts.
 *
 * @param executionReport - The spec-gen-sdk execution report.
 * @returns [flag of lable breaking change, breaking change label].
 */
function getBreakingChangeInfo(executionReport: any): [boolean, string] {
  let breakingChangeLabel = "";
  for (const packageInfo of executionReport.packages) {
    breakingChangeLabel = packageInfo.breakingChangeLabel;
    if (packageInfo.shouldLabelBreakingChange) {
      return [true, breakingChangeLabel];
    }
  }
  return [false, breakingChangeLabel];
}

/**
 * Generate the spec-gen-sdk artifacts.
 * @param commandInput - The command input.
 * @param artifactInfo - The spec-gen-sdk artifact information.
 * @param shouldLabelBreakingChange - A flag indicating whether to label breaking changes.
 * @param breakingChangeLabel - The breaking change label.
 * @returns the run status code.
 */
function generateArtifact(
  commandInput: SpecGenSdkCmdInput,
  artifactInfo: SpecGenSdkArtifactInfo,
  shouldLabelBreakingChange: boolean,
  breakingChangeLabel: string,
): number {
  const specGenSdkArtifactName = "spec-gen-sdk-artifact";
  const specGenSdkArtifactFileName = specGenSdkArtifactName + ".json";
  const specGenSdkArtifactPath = "out/spec-gen-sdk-artifact";
  const specGenSdkArtifactAbsoluteFolder = path.join(
    commandInput.workingFolder,
    specGenSdkArtifactPath,
  );
  try {
    if (!fs.existsSync(specGenSdkArtifactAbsoluteFolder)) {
      fs.mkdirSync(specGenSdkArtifactAbsoluteFolder, { recursive: true });
    }
    // Write artifact
    artifactInfo.language = commandInput.sdkLanguage;
    artifactInfo.labelAction = shouldLabelBreakingChange;
    fs.writeFileSync(
      path.join(commandInput.workingFolder, specGenSdkArtifactPath, specGenSdkArtifactFileName),
      JSON.stringify(artifactInfo, undefined, 2),
    );
    setVsoVariable("SpecGenSdkArtifactName", specGenSdkArtifactName);
    setVsoVariable("SpecGenSdkArtifactPath", specGenSdkArtifactPath);
    setVsoVariable("BreakingChangeLabelAction", shouldLabelBreakingChange ? "add" : "remove");
    setVsoVariable("BreakingChangeLabel", breakingChangeLabel);
  } catch (error) {
    logMessage("Runner: errors occurred while processing breaking change", LogLevel.Group);
    vsoLogIssue(`Runner: errors writing breaking change label artifacts:${error}`);
    logMessage("ending group logging", LogLevel.EndGroup);
    return 1;
  }
  return 0;
}
