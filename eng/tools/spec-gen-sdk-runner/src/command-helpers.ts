import {
  APIViewRequestData,
  SdkName,
  SdkNameSchema,
  SpecGenSdkArtifactInfo,
} from "@azure-tools/specs-shared/sdk-types";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { inspect } from "node:util";
import { LogIssueType, LogLevel, logMessage, setVsoVariable, vsoLogIssue } from "./log.js";
import { groupSpecConfigPaths } from "./spec-helpers.js";
import {
  ExecutionReport,
  SpecGenSdkCmdInput,
  SpecGenSdkRequiredSettings,
  VsoLogs,
} from "./types.js";
import {
  findReadmeFiles,
  getAllTypeSpecPaths,
  getArgumentValue,
  objectToMap,
  SpecConfigs,
} from "./utils.js";

/**
 * Load execution-report.json.
 * @param commandInput - The command input.
 * @returns the execution report JSON
 */
export function getExecutionReport(commandInput: SpecGenSdkCmdInput): ExecutionReport {
  // Read the execution report to determine if the generation was successful
  const executionReportPath = path.join(
    commandInput.workingFolder,
    `${commandInput.sdkRepoName}_tmp/execution-report.json`,
  );
  return JSON.parse(fs.readFileSync(executionReportPath, "utf8")) as ExecutionReport;
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
  if (stagedArtifactsFolder) {
    setVsoVariable("StagedArtifactsFolder", stagedArtifactsFolder);
  }
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
    sdkLanguage: SdkNameSchema.parse(sdkRepoName.replace("-pr", "")),
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
    const logContent = JSON.parse(fs.readFileSync(logPath, "utf8")) as Record<
      string,
      { errors?: string[]; warnings?: string[] }
    >;
    vsoLogs = objectToMap(logContent);
  } catch (error) {
    throw new Error(`Runner: error reading log at ${logPath}:${inspect(error)}`, { cause: error });
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
 * @returns flag of lable breaking change.
 */
export function getBreakingChangeInfo(executionReport: ExecutionReport): boolean {
  for (const packageInfo of executionReport.packages) {
    if (packageInfo.shouldLabelBreakingChange) {
      return true;
    }
  }
  return false;
}

/**
 * Read isSpecGenSdkCheckRequired from the SDK generation output (generateOutput.json).
 * For .NET SDK, the generation script explicitly declares whether the SDK validation
 * check should be required, based on whether the package uses the new mgmt emitter.
 * @param commandInput - The command input.
 * @returns true/false if SDK explicitly declares the value, undefined if the property
 *          is not present (e.g., older SDK script) or the file doesn't exist.
 */
export function readSdkOutputCheckRequired(commandInput: SpecGenSdkCmdInput): boolean | undefined {
  const generateOutputPath = path.join(
    commandInput.workingFolder,
    `${commandInput.sdkRepoName}_tmp/generateOutput.json`,
  );
  if (!fs.existsSync(generateOutputPath)) {
    return undefined;
  }
  try {
    const generateOutput = JSON.parse(fs.readFileSync(generateOutputPath, "utf8")) as {
      isSpecGenSdkCheckRequired?: boolean;
    };
    if (typeof generateOutput.isSpecGenSdkCheckRequired === "boolean") {
      return generateOutput.isSpecGenSdkCheckRequired;
    }
    return undefined;
  } catch (error) {
    logMessage(
      `Runner: failed to parse generateOutput.json at '${generateOutputPath}': ${inspect(error)}. ` +
        `Falling back to legacy inference logic.`,
      LogLevel.Warn,
    );
    return undefined;
  }
}

/**
 * Generate the spec-gen-sdk artifacts.
 * @param commandInput - The command input.
 * @param result - The spec-gen-sdk execution result.
 * @param hasBreakingChange - A flag indicating whether there are breaking changes.
 * @param hasManagementPlaneSpecs - A flag indicating whether there are management plane specs.
 * @param hasTypeSpecProjects - A flag indicating whether there are TypeSpec projects.
 * @param stagedArtifactsFolder - The staged artifacts folder.
 * @param apiViewRequestData - The API view request data.
 * @param sdkGenerationExecuted - A flag indicating whether the SDK generation was executed.
 * @param sdkReportedCheckRequired - Optional value from SDK output indicating whether the check is required.
 * @returns the run status code.
 */
export function generateArtifact(
  commandInput: SpecGenSdkCmdInput,
  result: string,
  hasBreakingChange: boolean,
  hasManagementPlaneSpecs: boolean,
  hasTypeSpecProjects: boolean,
  stagedArtifactsFolder: string,
  apiViewRequestData: APIViewRequestData[],
  sdkGenerationExecuted: boolean = true,
  sdkReportedCheckRequired?: boolean,
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
    let isSpecGenSdkCheckRequired = false;
    if (sdkGenerationExecuted) {
      isSpecGenSdkCheckRequired = getRequiredSettingValue(
        hasManagementPlaneSpecs,
        hasTypeSpecProjects,
        commandInput.sdkLanguage,
        sdkReportedCheckRequired,
      );
    }

    // Write artifact
    const artifactInfo: SpecGenSdkArtifactInfo = {
      language: commandInput.sdkLanguage,
      result,
      headSha: commandInput.specCommitSha,
      prNumber: commandInput.prNumber,
      labelAction: hasBreakingChange,
      isSpecGenSdkCheckRequired,
      apiViewRequestData: apiViewRequestData,
    };
    fs.writeFileSync(
      path.join(commandInput.workingFolder, specGenSdkArtifactPath, specGenSdkArtifactFileName),
      JSON.stringify(artifactInfo, undefined, 2),
    );
    setVsoVariable("SpecGenSdkArtifactName", specGenSdkArtifactName);
    setVsoVariable("SpecGenSdkArtifactPath", specGenSdkArtifactPath);
    setVsoVariable("StagedArtifactsFolder", stagedArtifactsFolder);
    setVsoVariable("HasAPIViewArtifact", apiViewRequestData.length > 0 ? "true" : "false");
  } catch (error) {
    logMessage("Runner: errors occurred while processing breaking change", LogLevel.Group);
    vsoLogIssue(`Runner: errors writing breaking change label artifacts:${inspect(error)}`);
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

/**
 * Get the required setting value for the SDK check based on the spec PR types.
 * @param hasManagementPlaneSpecs - A flag indicating whether there are management plane specs.
 * @param hasTypeSpecProjects - A flag indicating whether there are TypeSpec projects.
 * @param sdkName - The SDK name.
 * @param sdkReportedCheckRequired - Optional value from SDK output indicating whether the check is required.
 * @returns boolean indicating whether the SDK check is required.
 */
export function getRequiredSettingValue(
  hasManagementPlaneSpecs: boolean,
  hasTypeSpecProjects: boolean,
  sdkName: SdkName,
  sdkReportedCheckRequired?: boolean,
): boolean {
  // If the SDK explicitly reported whether the check is required (e.g., .NET SDK
  // reports this based on whether the package uses the new mgmt emitter), use that
  // value directly instead of inferring from the broad hasTypeSpecProjects flag.
  if (sdkName === "azure-sdk-for-net" && sdkReportedCheckRequired !== undefined) {
    return sdkReportedCheckRequired;
  }
  // If the SDK is azure-sdk-for-net, return false if there are no TypeSpec projects.
  if (sdkName === "azure-sdk-for-net" && !hasTypeSpecProjects) {
    return false;
  }
  if (hasManagementPlaneSpecs) {
    return SpecGenSdkRequiredSettings[sdkName].managementPlane;
  } else {
    return SpecGenSdkRequiredSettings[sdkName].dataPlane;
  }
}
