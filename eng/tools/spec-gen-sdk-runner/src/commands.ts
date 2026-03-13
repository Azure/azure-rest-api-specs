import { APIViewRequestData } from "@azure-tools/specs-shared/sdk-types";
import fs from "node:fs";
import path from "node:path";
import { inspect } from "node:util";
import {
  AzsdkBuildResponse,
  AzsdkGenerateResponse,
  AzsdkPackResponse,
  buildExecutionReport,
  parseAzsdkResponse,
} from "./azsdk-adapter.js";
import {
  generateArtifact,
  getBreakingChangeInfo,
  getExecutionReport,
  getServiceFolderPath,
  getSpecPaths,
  logIssuesToPipeline,
  parseArguments,
  prepareAzsdkBuildCommand,
  prepareAzsdkGenerateCommand,
  prepareAzsdkPackCommand,
  prepareSpecGenSdkCommand,
  resolvePackagePath,
  selectGenerationTool,
  setPipelineVariables,
} from "./command-helpers.js";
import { checkEmitterEnabled, EmitterCheckResult } from "./emitter-check.js";
import { LogLevel, logMessage, vsoAddAttachment, vsoLogIssue } from "./log.js";
import { detectChangedSpecConfigFiles } from "./spec-helpers.js";
import { ExecutionReport, SpecGenSdkCmdInput } from "./types.js";
import { resetGitRepo, runCommandWithOutput, runSpecGenSdkCommand, SpecConfigs } from "./utils.js";

/**
 * Run the azsdk-cli generation flow for a single TypeSpec spec:
 * 1. Check emitter enabled via typespec-metadata
 * 2. Run azsdk pkg generate
 * 3. On success, run azsdk pkg build (skip for Python)
 * 4. On build success, run azsdk pkg pack
 * 5. Build ExecutionReport via adapter
 */
async function runAzsdkGeneration(
  commandInput: SpecGenSdkCmdInput,
  tspConfigRelativePath: string,
): Promise<{ executionReport: ExecutionReport; statusCode: number }> {
  let statusCode = 0;
  const tspConfigDir = path.resolve(
    commandInput.localSpecRepoPath,
    path.dirname(tspConfigRelativePath),
  );

  // Step 1: Check if the language emitter is enabled
  logMessage(`Checking emitter configuration for ${commandInput.sdkRepoName}`, LogLevel.Info);
  const emitterCheck: EmitterCheckResult = await checkEmitterEnabled(
    tspConfigDir,
    commandInput.sdkRepoName,
  );

  if (!emitterCheck.enabled) {
    logMessage(
      `Emitter not enabled for ${commandInput.sdkRepoName}, skipping generation`,
      LogLevel.Info,
    );
    return {
      executionReport: buildExecutionReport(undefined, undefined, emitterCheck),
      statusCode: 0,
    };
  }

  // Step 2: Run azsdk pkg generate
  let generateResponse: AzsdkGenerateResponse | undefined;
  try {
    const generateArgs = prepareAzsdkGenerateCommand(commandInput, tspConfigRelativePath);
    logMessage(`Running: azsdk ${generateArgs.join(" ")}`, LogLevel.Info);
    const generateOutput = await runCommandWithOutput("azsdk", generateArgs);
    generateResponse = parseAzsdkResponse<AzsdkGenerateResponse>(generateOutput);
    logMessage(`azsdk pkg generate result: ${generateResponse.result}`, LogLevel.Info);
  } catch (error) {
    logMessage(`Error running azsdk pkg generate: ${inspect(error)}`, LogLevel.Error);
    statusCode = 1;
  }

  // Step 3 & 4: On success, build (if not Python) then pack
  let packResponse: AzsdkPackResponse | undefined;
  if (generateResponse?.result === "succeeded" && emitterCheck.metadata && emitterCheck.languageKey) {
    const langMeta = emitterCheck.metadata.languages[emitterCheck.languageKey];
    if (langMeta?.outputDir) {
      const packagePath = resolvePackagePath(langMeta.outputDir, commandInput.localSdkRepoPath);
      const isPython = commandInput.sdkRepoName.replace("-pr", "") === "azure-sdk-for-python";
      let buildSucceeded = true;

      // Step 3: Build (skip for Python — interpreted language, no compilation needed)
      if (!isPython) {
        try {
          const buildArgs = prepareAzsdkBuildCommand(packagePath);
          logMessage(`Running: azsdk ${buildArgs.join(" ")}`, LogLevel.Info);
          const buildOutput = await runCommandWithOutput("azsdk", buildArgs);
          const buildResponse = parseAzsdkResponse<AzsdkBuildResponse>(buildOutput);
          logMessage(`azsdk pkg build result: ${buildResponse.result}`, LogLevel.Info);
          if (buildResponse.result !== "succeeded") {
            logMessage(`Build failed, skipping pack step`, LogLevel.Error);
            buildSucceeded = false;
            statusCode = 1;
          }
        } catch (error) {
          logMessage(`Error running azsdk pkg build: ${inspect(error)}`, LogLevel.Error);
          buildSucceeded = false;
          statusCode = 1;
        }
      }

      // Step 4: Pack (only if build succeeded or was skipped)
      if (buildSucceeded) {
        try {
          const packArgs = prepareAzsdkPackCommand(packagePath);
          logMessage(`Running: azsdk ${packArgs.join(" ")}`, LogLevel.Info);
          const packOutput = await runCommandWithOutput("azsdk", packArgs);
          packResponse = parseAzsdkResponse<AzsdkPackResponse>(packOutput);
          logMessage(`azsdk pkg pack result: ${packResponse.result}`, LogLevel.Info);
        } catch (error) {
          logMessage(`Error running azsdk pkg pack: ${inspect(error)}`, LogLevel.Error);
          statusCode = 1;
        }
      }
    }
  }

  // Step 5: Build ExecutionReport via adapter
  const executionReport = buildExecutionReport(generateResponse, packResponse, emitterCheck);
  return { executionReport, statusCode };
}

/**
 * Generate SDK for a single spec.
 * This is for the SDK release scenario.
 * @returns the run status code.
 */
export async function generateSdkForSingleSpec(): Promise<number> {
  // Parse the arguments
  const commandInput: SpecGenSdkCmdInput = parseArguments();
  const specConfigPathText = `${commandInput.tspConfigPath} ${commandInput.readmePath}`;

  const tool = selectGenerationTool(commandInput.tspConfigPath, commandInput.readmePath);
  let statusCode = 0;
  let executionReport: ExecutionReport | undefined;

  if (tool === "azsdk-cli" && commandInput.tspConfigPath) {
    // azsdk-cli path for TypeSpec specs
    logMessage(`Generating SDK (azsdk-cli) from ${specConfigPathText}`, LogLevel.Group);
    const result = await runAzsdkGeneration(commandInput, commandInput.tspConfigPath);
    executionReport = result.executionReport;
    statusCode = result.statusCode;
    logMessage(`Runner command execution result:${executionReport.executionResult}`);
  } else {
    // Existing spec-gen-sdk path
    const specGenSdkCommand = prepareSpecGenSdkCommand(commandInput);
    logMessage(`Generating SDK from ${specConfigPathText}`, LogLevel.Group);
    logMessage(`Runner command:${specGenSdkCommand.join(" ")}`);
    try {
      await runSpecGenSdkCommand(specGenSdkCommand);
      logMessage("Runner command executed successfully");
    } catch (error) {
      logMessage(`Runner: error executing command:${inspect(error)}`, LogLevel.Error);
      statusCode = 1;
    }

    try {
      executionReport = getExecutionReport(commandInput);
      const executionResult = executionReport.executionResult;
      logMessage(`Runner command execution result:${executionResult}`);
    } catch (error) {
      logMessage(`Runner: error reading execution-report.json:${inspect(error)}`, LogLevel.Error);
      statusCode = 1;
    }
  }

  // Always set the pipeline variables for the SDK pull request even if
  // there are failures in the generation process since we allow the PR creation for such cases.
  let packageName: string;
  let installationInstructions: string;
  if (executionReport) {
    packageName =
      executionReport.packages[0]?.packageName ??
      commandInput.tspConfigPath ??
      commandInput.readmePath ??
      "missing-package-name";
    installationInstructions = executionReport.packages[0]?.installationInstructions ?? "";
  } else {
    packageName = commandInput.tspConfigPath ?? commandInput.readmePath ?? "missing-package-name";
    installationInstructions = "";
  }

  packageName = packageName.replace("/", "-");
  setPipelineVariables(
    executionReport?.stagedArtifactsFolder ?? "",
    false,
    packageName,
    installationInstructions,
  );

  logMessage("ending group logging", LogLevel.EndGroup);
  if (executionReport?.vsoLogPath) {
    logIssuesToPipeline(executionReport.vsoLogPath, specConfigPathText);
  }

  return statusCode;
}

/* Generate SDKs for spec pull request */
export async function generateSdkForSpecPr(): Promise<number> {
  // Parse the arguments
  const commandInput: SpecGenSdkCmdInput = parseArguments();
  // Construct the spec-gen-sdk command (used for OpenAPI fallback path)
  const specGenSdkCommand = prepareSpecGenSdkCommand(commandInput);
  // Get the spec paths from the changed files
  const changedSpecs = await detectChangedSpecConfigFiles(commandInput);

  let statusCode = 0;
  let pushedSpecConfigCount: number;
  let executionReport: ExecutionReport | undefined;
  let changedSpecPathText: string;
  let hasManagementPlaneSpecs = false;
  let hasTypeSpecProjects = false;
  let overallRunHasBreakingChange = false;
  let currentRunHasBreakingChange: boolean;
  let sdkGenerationExecuted = true;
  let overallExecutionResult = "";
  let currentExecutionResult: string;
  let stagedArtifactsFolder = "";
  const apiViewRequestData: APIViewRequestData[] = [];

  if (changedSpecs.length === 0) {
    sdkGenerationExecuted = false;
    overallExecutionResult = "succeeded";
  }

  for (const changedSpec of changedSpecs) {
    if (!changedSpec.typespecProject && !changedSpec.readmeMd) {
      logMessage("Runner: no spec config file found in the changed files", LogLevel.Warn);
      continue;
    }

    const tool = selectGenerationTool(changedSpec.typespecProject, changedSpec.readmeMd);
    changedSpecPathText = "";

    if (changedSpec.typespecProject) {
      changedSpecPathText = changedSpec.typespecProject;
      if (changedSpec.typespecProject.includes(".Management")) {
        hasManagementPlaneSpecs = true;
      }
    }
    if (changedSpec.readmeMd) {
      changedSpecPathText = changedSpec.readmeMd;
      if (changedSpec.typespecProject) {
        changedSpecPathText = getServiceFolderPath(changedSpec.readmeMd);
      }
      if (changedSpec.readmeMd.includes("resource-manager")) {
        hasManagementPlaneSpecs = true;
      }
    }

    logMessage(`Generating SDK from ${changedSpecPathText}`, LogLevel.Group);

    if (tool === "azsdk-cli" && changedSpec.typespecProject) {
      // azsdk-cli path for TypeSpec specs
      try {
        await resetGitRepo(commandInput.localSdkRepoPath);
        const result = await runAzsdkGeneration(commandInput, changedSpec.typespecProject);
        executionReport = result.executionReport;
        if (result.statusCode !== 0) {
          statusCode = result.statusCode;
        }
      } catch (error) {
        logMessage(`Runner: error in azsdk generation:${inspect(error)}`, LogLevel.Error);
        statusCode = 1;
      }
    } else {
      // Existing spec-gen-sdk path
      pushedSpecConfigCount = 0;
      if (changedSpec.typespecProject) {
        specGenSdkCommand.push("--tsp-config-relative-path", changedSpec.typespecProject);
        pushedSpecConfigCount++;
      }
      if (changedSpec.readmeMd) {
        specGenSdkCommand.push("--readme-relative-path", changedSpec.readmeMd);
        pushedSpecConfigCount++;
      }
      logMessage(`Runner command:${specGenSdkCommand.join(" ")}`);

      try {
        await resetGitRepo(commandInput.localSdkRepoPath);
        await runSpecGenSdkCommand(specGenSdkCommand);
        logMessage("Runner command executed successfully");
      } catch (error) {
        logMessage(`Runner: error executing command:${inspect(error)}`, LogLevel.Error);
        statusCode = 1;
      }
      // Pop the spec config path from specGenSdkCommand
      for (let index = 0; index < pushedSpecConfigCount * 2; index++) {
        specGenSdkCommand.pop();
      }

      try {
        executionReport = getExecutionReport(commandInput);
      } catch (error) {
        logMessage(`Runner: error reading execution-report.json:${inspect(error)}`, LogLevel.Error);
        statusCode = 1;
        executionReport = undefined;
      }
    }

    // Process execution report (common path for both tools)
    try {
      if (executionReport) {
        currentExecutionResult = executionReport.executionResult;
        if (executionReport.generateFromTypeSpec) {
          hasTypeSpecProjects = true;
        }

        if (executionReport.stagedArtifactsFolder) {
          stagedArtifactsFolder = executionReport.stagedArtifactsFolder;
          for (const pkg of executionReport.packages) {
            if (pkg.apiViewArtifact && pkg.packageName) {
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
        currentRunHasBreakingChange = getBreakingChangeInfo(executionReport);
        overallRunHasBreakingChange = overallRunHasBreakingChange || currentRunHasBreakingChange;
        logMessage(`Runner command execution result:${currentExecutionResult}`);
      } else {
        overallExecutionResult = "failed";
      }
    } catch (error) {
      logMessage(`Runner: error processing execution report:${inspect(error)}`, LogLevel.Error);
      statusCode = 1;
      overallExecutionResult = "failed";
    }
    logMessage("ending group logging", LogLevel.EndGroup);
    if (executionReport?.vsoLogPath) {
      logIssuesToPipeline(executionReport.vsoLogPath, changedSpecPathText);
    }
  }
  // Process the spec-gen-sdk artifacts
  statusCode =
    generateArtifact(
      commandInput,
      overallExecutionResult,
      overallRunHasBreakingChange,
      hasManagementPlaneSpecs,
      hasTypeSpecProjects,
      stagedArtifactsFolder,
      apiViewRequestData,
      sdkGenerationExecuted,
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
  const failedSpecs: string[] = [];

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

    const tool = selectGenerationTool(specConfigs.tspconfigPath, specConfigs.readmePath);

    if (tool === "azsdk-cli" && specConfigs.tspconfigPath) {
      // azsdk-cli path for TypeSpec specs
      specConfigPath = specConfigs.tspconfigPath;
      logMessage(`Using azsdk-cli for ${specConfigPath}`, LogLevel.Info);
      try {
        await resetGitRepo(commandInput.localSdkRepoPath);
        const result = await runAzsdkGeneration(commandInput, specConfigs.tspconfigPath);
        executionReport = result.executionReport;
        if (result.statusCode !== 0) {
          statusCode = result.statusCode;
        }
      } catch (error) {
        logMessage(`Runner: error in azsdk generation:${inspect(error)}`, LogLevel.Error);
        statusCode = 1;
        executionReport = undefined;
      }
    } else {
      // Existing spec-gen-sdk path
      pushedSpecConfigCount = 0;
      if (specConfigs.readmePath) {
        specConfigPath = specConfigs.readmePath;
        specGenSdkCommand.push("--readme-relative-path", specConfigs.readmePath);
        pushedSpecConfigCount++;
      }

      if (specConfigs.tspconfigPath) {
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
        logMessage(`Runner: error executing command:${inspect(error)}`, LogLevel.Error);
        statusCode = 1;
      }

      // Pop the spec config path from specGenSdkCommand
      for (let index = 0; index < pushedSpecConfigCount * 2; index++) {
        specGenSdkCommand.pop();
      }

      try {
        executionReport = getExecutionReport(commandInput);
      } catch (error) {
        logMessage(`Runner: error reading execution-report.json:${inspect(error)}`, LogLevel.Error);
        statusCode = 1;
        executionReport = undefined;
      }
    }

    // Process execution report (common path for both tools)
    try {
      if (executionReport) {
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
          const specIndex = specConfigPath.indexOf("specification/");
          const relativePath = specIndex >= 0 ? specConfigPath.substring(specIndex) : specConfigPath;
          failedSpecs.push(relativePath);
        }
        if (executionReport.isSdkConfigDuplicated) {
          duplicatedConfigContent += `${specConfigPath},`;
          duplicatedConfigCount++;
        }
      }
    } catch (error) {
      logMessage(`Runner: error processing execution report:${inspect(error)}`, LogLevel.Error);
      statusCode = 1;
    }

    logMessage("ending group logging", LogLevel.EndGroup);
    if (specConfigs.tspconfigPath && specConfigs.readmePath) {
      specConfigPath = serviceFolderPath;
    }
    if (executionReport?.vsoLogPath) {
      logIssuesToPipeline(executionReport.vsoLogPath, specConfigPath);
    }
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

  // Emit structured telemetry for Kusto ingestion (only for mgmtplane/dataplane batch types)
  if (batchType === "all-mgmtplane-typespecs" || batchType === "all-dataplane-typespecs") {
    const specType = batchType === "all-mgmtplane-typespecs" ? "management-plane" : "data-plane";
    const telemetry = {
      eventType: "SdkBatchGenerationSummary",
      timestamp: new Date().toISOString(),
      batchType: batchType,
      specType: specType,
      sdkRepoName: commandInput.sdkRepoName,
      language: commandInput.sdkRepoName.replace("azure-sdk-for-", ""),
      totalSpecs: succeededCount + failedCount,
      succeededCount: succeededCount,
      failedCount: failedCount,
      notEnabledCount: notEnabledCount,
      duplicatedConfigCount: duplicatedConfigCount,
      successRate:
        succeededCount + failedCount > 0
          ? Math.round((succeededCount / (succeededCount + failedCount)) * 100)
          : 0,
      buildId: process.env.BUILD_BUILDID ?? "",
      pipelineUrl: `${process.env.SYSTEM_COLLECTIONURI ?? ""}${process.env.SYSTEM_TEAMPROJECT ?? ""}/_build/results?buildId=${process.env.BUILD_BUILDID ?? ""}`,
      failedSpecs: failedSpecs,
    };
    logMessage(`##[SdkBatchGenerationSummary]${JSON.stringify(telemetry)}`);
  }

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
    vsoLogIssue(`Runner: error writing markdown file ${markdownFilePath}:${inspect(error)}`);
    statusCode = 1;
  }
  // Set the pipeline variables for artifacts location
  setPipelineVariables(stagedArtifactsFolder);

  return statusCode;
}
