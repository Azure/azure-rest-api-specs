import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  findReadmeFiles,
  getArgumentValue,
  getAllTypeSpecPaths,
  objectToMap,
  SpecConfigs,
} from "./utils.js";
import { LogIssueType, LogLevel, logMessage, setVsoVariable, vsoLogIssue } from "./log.js";
import {
  APIViewRequestData,
  SdkName,
  SpecGenSdkArtifactInfo,
  SpecGenSdkCmdInput,
  SpecGenSdkRequiredSettings,
  VsoLogs,
} from "./types.js";
import { groupSpecConfigPaths } from "./spec-helpers.js";

/**
 * Load execution-report.json.
 * @param commandInput - The command input.
 * @returns the execution report JSON
 */
export function getExecutionReport(commandInput: SpecGenSdkCmdInput): any {
  // Read the execution report to determine if the generation was successful
  const executionReportPath = path.join(
    commandInput.workingFolder,
    `${commandInput.sdkRepoName}_tmp/execution-report.json`,
  );
  return JSON.parse(fs.readFileSync(executionReportPath, "utf8"));
}

/**
 * Set the pipeline variables for the SDK pull request.
 * @param stagedArtifactsFolder - The staged artifacts folder.
 * @param skipPrVariables - A flag indicating whether to skip setting PR variables.
 * @param packageName - The package name.
 * @param installationInstructions - The installation instructions.
 */
export function setPipelineVariables(
  stagedArtifactsFolder: string,
  skipPrVariables: boolean = true,
  packageName: string = "",
  installationInstructions: string = "",
): void {
  if (!skipPrVariables) {
    const branchName = `sdkauto/${packageName?.replace("/", "-")}`;
    const prTitle = `[AutoPR ${packageName}]`;
    const prBody = installationInstructions;
    setVsoVariable("PrBranch", branchName);
    setVsoVariable("PrTitle", prTitle);
    setVsoVariable("PrBody", prBody);
  }
  setVsoVariable("StagedArtifactsFolder", stagedArtifactsFolder);
}

/**
 * Parse the arguments.
 * @returns The spec-gen-sdk command input.
 */
export function parseArguments(): SpecGenSdkCmdInput {
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
export function prepareSpecGenSdkCommand(commandInput: SpecGenSdkCmdInput): string[] {
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
 * @returns The specConfigs array.
 */
export function getSpecPaths(batchType: string, specRepoPath: string): SpecConfigs[] {
  let tspconfigs: string[] = [];
  let readmes: string[] = [];
  let skipUnmatchedReadmes = false;
  switch (batchType) {
    case "all-specs": {
      tspconfigs = getAllTypeSpecPaths(specRepoPath);
      readmes = findReadmeFiles(path.join(specRepoPath, "specification"));
      break;
    }
    case "all-typespecs": {
      tspconfigs = getAllTypeSpecPaths(specRepoPath);
      readmes = findReadmeFiles(path.join(specRepoPath, "specification"));
      skipUnmatchedReadmes = true;
      break;
    }
    case "all-mgmtplane-typespecs": {
      tspconfigs = getAllTypeSpecPaths(specRepoPath).filter((p) => p.includes(".Management"));
      readmes = findReadmeFiles(path.join(specRepoPath, "specification")).filter((p) =>
        p.includes("resource-manager"),
      );
      skipUnmatchedReadmes = true;
      break;
    }
    case "all-dataplane-typespecs": {
      tspconfigs = getAllTypeSpecPaths(specRepoPath).filter((p) => !p.includes(".Management"));
      readmes = findReadmeFiles(path.join(specRepoPath, "specification")).filter((p) =>
        p.includes("data-plane"),
      );
      skipUnmatchedReadmes = true;
      break;
    }
    case "all-openapis": {
      readmes = findReadmeFiles(path.join(specRepoPath, "specification"));
      break;
    }
    case "all-mgmtplane-openapis": {
      readmes = findReadmeFiles(path.join(specRepoPath, "specification")).filter((p) =>
        p.includes("resource-manager"),
      );
      break;
    }
    case "all-dataplane-openapis": {
      readmes = findReadmeFiles(path.join(specRepoPath, "specification")).filter((p) =>
        p.includes("data-plane"),
      );
      break;
    }
    case "sample-typespecs": {
      tspconfigs = [
        "specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
        "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
      ];
    }
  }

  return groupSpecConfigPaths(tspconfigs, readmes, skipUnmatchedReadmes);
}

/**
 * Logs issues to Azure DevOps Pipeline *
 * @param logPath - The vso log file path.
 * @param specConfigDisplayText - The display text for the spec configuration.
 */
export function logIssuesToPipeline(logPath: string, specConfigDisplayText: string): void {
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
      const errorTitle =
        `Errors occurred while generating SDK from ${specConfigDisplayText}. ` +
        `Follow the steps at https://aka.ms/azsdk/sdk-automation-faq#how-to-view-the-detailed-sdk-generation-errors to view detailed errors.`;
      logMessage(errorTitle, LogLevel.Group);
      const errorsWithTitle = [errorTitle, ...errors];
      vsoLogIssue(errorsWithTitle.join("%0D%0A"));
      logMessage("ending group logging", LogLevel.EndGroup);
    }
    if (warnings.length > 0) {
      const warningTitle =
        `Warnings occurred while generating SDK from ${specConfigDisplayText}. ` +
        `Follow the steps at https://aka.ms/azsdk/sdk-automation-faq#how-to-view-the-detailed-sdk-generation-errors to view detailed warnings.`;
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
export function getBreakingChangeInfo(executionReport: any): [boolean, string] {
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
 * @param result - The spec-gen-sdk execution result.
 * @param breakingChangeLabel - The breaking change label.
 * @param hasBreakingChange - A flag indicating whether there are breaking changes.
 * @param hasManagementPlaneSpecs - A flag indicating whether there are management plane specs.
 * @returns the run status code.
 */
export function generateArtifact(
  commandInput: SpecGenSdkCmdInput,
  result: string,
  breakingChangeLabel: string,
  hasBreakingChange: boolean,
  hasManagementPlaneSpecs: boolean,
  stagedArtifactsFolder: string,
  apiViewRequestData: APIViewRequestData[],
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
    const artifactInfo: SpecGenSdkArtifactInfo = {
      language: commandInput.sdkLanguage,
      result,
      labelAction: hasBreakingChange,
      isSpecGenSdkCheckRequired:
        hasManagementPlaneSpecs && SpecGenSdkRequiredSettings[commandInput.sdkLanguage as SdkName],
      apiViewRequestData: apiViewRequestData,
    };
    fs.writeFileSync(
      path.join(commandInput.workingFolder, specGenSdkArtifactPath, specGenSdkArtifactFileName),
      JSON.stringify(artifactInfo, undefined, 2),
    );
    setVsoVariable("SpecGenSdkArtifactName", specGenSdkArtifactName);
    setVsoVariable("SpecGenSdkArtifactPath", specGenSdkArtifactPath);
    setVsoVariable("StagedArtifactsFolder", stagedArtifactsFolder);
    setVsoVariable("BreakingChangeLabelAction", hasBreakingChange ? "add" : "remove");
    setVsoVariable("BreakingChangeLabel", breakingChangeLabel);
    setVsoVariable("HasAPIViewArtifact", apiViewRequestData.length > 0 ? "true" : "false");
  } catch (error) {
    logMessage("Runner: errors occurred while processing breaking change", LogLevel.Group);
    vsoLogIssue(`Runner: errors writing breaking change label artifacts:${error}`);
    logMessage("ending group logging", LogLevel.EndGroup);
    return 1;
  }
  return 0;
}

/**
 * Get the service folder path from the spec config path.
 * @param specConfigPath
 * @returns The service folder path.
 */
export function getServiceFolderPath(specConfigPath: string): string {
  if (!specConfigPath || specConfigPath.length === 0) {
    return "";
  }
  const segments = specConfigPath.split("/");
  if (segments.length > 2) {
    return `${segments[0]}/${segments[1]}`;
  }
  return specConfigPath;
}
