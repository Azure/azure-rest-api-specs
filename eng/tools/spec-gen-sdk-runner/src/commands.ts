import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  findReadmeFiles,
  getArgumentValue,
  runSpecGenSdkCommand,
  getAllTypeSpecPaths,
  resetGitRepo,
} from "./utils.js";
import { LogLevel, logMessage, vsoAddAttachment, vsoLogIssue } from "./log.js";
import { CommandLog, SpecGenSdkCmdInput } from "./types.js";
import { detectChangedSpecConfigFiles } from "./change-files.js";

export async function generateSdkForSingleSpec(): Promise<number> {
  // Parse the arguments
  const commandInput: SpecGenSdkCmdInput = parseArguments();
  const specConfigPath = `${commandInput.tspConfigPath} ${commandInput.readmePath}`;
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
    const executionResult = executionReport.executionResult;
    logMessage(`Execution Result:${executionResult}`);
  } catch (error) {
    logMessage(`Error reading execution report at ${executionReportPath}:${error}`, LogLevel.Error);
    statusCode = 1;
  }
  logMessage("ending group logging", LogLevel.EndGroup);

  logIssuesToPipeline(commandInput, specConfigPath);
  
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
  for (const changedSpec of changedSpecs) {
    if (!changedSpec.typespecProject && !changedSpec.readmeMd) {
      logMessage("No spec config file found in the changed files", LogLevel.Warn);
      continue;
    }
    pushedSpecConfigCount = 0;
    if (changedSpec.typespecProject) {
      specGenSdkCommand.push("--tsp-config-relative-path", changedSpec.typespecProject);
      pushedSpecConfigCount++;
    }
    if (changedSpec.readmeMd) {
      specGenSdkCommand.push("--readme-relative-path", changedSpec.readmeMd);
      pushedSpecConfigCount++;
    }
    const changedSpecPath = `${changedSpec.typespecProject} ${changedSpec.readmeMd}`;
    logMessage(`Generating SDK from ${changedSpecPath}`, LogLevel.Group);
    logMessage(`Command:${specGenSdkCommand.join(" ")}`);

    try {
      await resetGitRepo(commandInput.localSdkRepoPath);
      await runSpecGenSdkCommand(specGenSdkCommand);
      logMessage("Command executed successfully");
    } catch (error) {
      logMessage(`Error executing command:${error}`, LogLevel.Error);
      statusCode = 1;
    }
    // Pop the spec config path from specGenSdkCommand
    for (let index = 0; index < pushedSpecConfigCount * 2; index++) {
      specGenSdkCommand.pop();
    }
    // Read the execution report to determine if the generation was successful
    const executionReportPath = path.join(
      commandInput.workingFolder,
      `${commandInput.sdkRepoName}_tmp/execution-report.json`,
    );
    try {
      const executionReport = JSON.parse(fs.readFileSync(executionReportPath, "utf8"));
      // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
      const executionResult = executionReport.executionResult;
      logMessage(`Execution Result:${executionResult}`);
    } catch (error) {
      logMessage(
        `Error reading execution report at ${executionReportPath}:${error}`,
        LogLevel.Error,
      );
      statusCode = 1;
    }
    logMessage("ending group logging", LogLevel.EndGroup);

    logIssuesToPipeline(commandInput, changedSpecPath);
  }
  return statusCode;
}

/**
 * Generate SDKs for batch specs.
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
  let failedContent = `## Spec Failures in the Generation Process\n`;
  let succeededContent = `## Successful Specs in the Generation Process\n`;
  let notEnabledContent = `## Specs with SDK Not Enabled\n`;
  let failedCount = 0;
  let notEnabledCount = 0;
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
      await resetGitRepo(commandInput.localSdkRepoPath);
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
      const executionResult = executionReport.executionResult;
      logMessage(`Execution Result:${executionResult}`);

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
      logMessage(
        `Error reading execution report at ${executionReportPath}:${error}`,
        LogLevel.Error,
      );
      statusCode = 1;
    }
    logMessage("ending group logging", LogLevel.EndGroup);
    
    logIssuesToPipeline(commandInput, specConfigPath || '');
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
      specConfigPaths.push(
        "specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
        "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
      );
    }
  }
  return specConfigPaths;
}

/**
 * Extract and format the prefix from tspConfigPath or readmePath.
 * This function is copied from 'spec-gen-sdk'.
 * Source code: [Azure SDK Tools - spec-gen-sdk](https://github.com/Azure/azure-sdk-tools/blob/main/tools/spec-gen-sdk/src/utils/utils.ts#L171)
 * @param {string | undefined} tspConfigPath The tspConfigPath to extract the prefix from.
 * @param {string | undefined} readmePath The readmePath to extract the prefix from.
 * @returns {string} The formatted prefix.
 */
function extractPathFromSpecConfig(tspConfigPath: string | undefined, readmePath: string | undefined): string {
  let prefix = '';
  if (tspConfigPath) {
    const regex = /specification\/(.+)\/tspconfig\.yaml$/
    const match = regex.exec(tspConfigPath);
    if (match) {
      const segments = match[1].split('/');
      prefix = segments.join('-').toLowerCase().replaceAll('.', '-');
    }
  } else if (readmePath) {
    const regex = /specification\/(.+?)\/readme\.md$/i
    const match = regex.exec(readmePath);
    if (match) {
      const segments = match[1].split('/');
      prefix = segments.join('-').toLowerCase().replaceAll('.', '-');
    }
  }
  return prefix;
}

/**
 * Logs SDK generation issues to Azure DevOps (ADO)
 * @param commandInput 
 * @param specConfigPath 
 */
function logIssuesToPipeline(commandInput: SpecGenSdkCmdInput, specConfigPath: string): void {
  const fileNamePrefix = extractPathFromSpecConfig(commandInput.tspConfigPath, commandInput.readmePath)
  const logFolder = path.join(commandInput.workingFolder, 'out/logs');
  const logPath = path.join(logFolder, `${fileNamePrefix}-filtered.log`);
  let logIssues:CommandLog[] = []
  try {
    const log = JSON.parse(fs.readFileSync(logPath, "utf8"));
    // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
    logIssues = log.logIssues;
  } catch (error) {
    logMessage(`Error reading log at ${logPath}:${error}`, LogLevel.Error);
  }

  if(logIssues.length > 0) {
    logMessage(`Error generating SDK from ${specConfigPath}`, LogLevel.Group);
    const logIssuesList = logIssues.flatMap(entry => [`Get log issues from script ${entry.command} `, ...entry.logIssues]);;
    vsoLogIssue(logIssuesList.join('%0D%0A'));
    logMessage("ending group logging", LogLevel.EndGroup);
  }
}