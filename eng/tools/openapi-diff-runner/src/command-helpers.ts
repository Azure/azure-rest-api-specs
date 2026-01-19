import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { getChangedFilesStatuses, swagger } from "@azure-tools/specs-shared/changed-files";
import { existsSync, mkdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import path from "node:path";
import { logError, LogLevel, logMessage, setOutput } from "./log.js";
import {
  BreakingChangeReviewRequiredLabel,
  BreakingChangesCheckType,
  Context,
  VersioningReviewRequiredLabel,
} from "./types/breaking-change.js";
import { ResultMessageRecord } from "./types/message.js";
import { createOadMessageProcessor } from "./utils/oad-message-processor.js";
import { createPullRequestProperties } from "./utils/pull-request.js";

/**
 * Interface for parsed CLI arguments
 */
export interface ParsedCliArguments {
  localSpecRepoPath: string;
  targetRepo: string;
  sourceRepo: string;
  prNumber: string;
  runType: BreakingChangesCheckType;
  baseBranch: string;
  headCommit: string;
  prSourceBranch: string;
  prTargetBranch: string;
}

/**
 * Create context from parsed CLI arguments
 */
export function createContextFromParsedArgs(
  parsedArgs: ParsedCliArguments,
  workingFolder: string,
  logFileFolder: string,
): Context {
  const swaggerDirs: string[] = ["specification", "dev"];
  const prUrl = `https://github.com/${parsedArgs.targetRepo}/pull/${parsedArgs.prNumber}`;
  const oadMessageProcessorContext = createOadMessageProcessor(logFileFolder, prUrl);

  return {
    localSpecRepoPath: parsedArgs.localSpecRepoPath,
    workingFolder,
    swaggerDirs,
    logFileFolder,
    baseBranch: parsedArgs.baseBranch,
    runType: parsedArgs.runType,
    checkName: getBreakingChangeCheckName(parsedArgs.runType),
    headCommit: parsedArgs.headCommit,
    targetRepo: parsedArgs.targetRepo,
    sourceRepo: parsedArgs.sourceRepo,
    prNumber: parsedArgs.prNumber,
    prSourceBranch: parsedArgs.prSourceBranch,
    prTargetBranch: parsedArgs.prTargetBranch,
    oadMessageProcessorContext,
    prUrl,
  };
}

/**
 * This set contains labels denoting which kind of review is required.
 *
 * Appropriate labels are added to this set by applyRules() function.
 */
export const BreakingChangeLabelsToBeAdded = new Set<string>();
function getBreakingChangeCheckName(runType: BreakingChangesCheckType): string {
  return runType === BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION
    ? "Swagger BreakingChange"
    : "BreakingChange(Cross-Version)";
}

/**
 * Output the breaking change labels as GitHub Actions environment variables.
 * This function checks the BreakingChangeLabelsToBeAdded set and sets the appropriate outputs.
 * The doc describing breaking change review rules can be found here: https://aka.ms/brch-dev
 */
export function outputBreakingChangeLabelVariables(): void {
  // Output the breaking change labels as GitHub Actions environment variables
  if (BreakingChangeLabelsToBeAdded.size === 0) {
    logMessage("None of the breaking change review labels need to be added.");
    logMessage("Setting default breaking change labels to false.");
    setOutput("breakingChangeReviewLabelName", BreakingChangeReviewRequiredLabel);
    setOutput("breakingChangeReviewLabelValue", "false");
    setOutput("versioningReviewLabelName", VersioningReviewRequiredLabel);
    setOutput("versioningReviewLabelValue", "false");
  } else {
    if (BreakingChangeLabelsToBeAdded.has(BreakingChangeReviewRequiredLabel)) {
      logMessage("'BreakingChangeReviewRequired' label needs to be added.");
      setOutput("breakingChangeReviewLabelName", BreakingChangeReviewRequiredLabel);
      setOutput("breakingChangeReviewLabelValue", "true");
      logMessage("'VersioningReviewRequired' label needs to be deleted.");
      setOutput("versioningReviewLabelName", VersioningReviewRequiredLabel);
      setOutput("versioningReviewLabelValue", "false");
    } else {
      logMessage("'BreakingChangeReviewRequired' label needs to be deleted.");
      setOutput("breakingChangeReviewLabelName", BreakingChangeReviewRequiredLabel);
      setOutput("breakingChangeReviewLabelValue", "false");

      // versioning review label is only set if the breaking change review label is not set
      if (BreakingChangeLabelsToBeAdded.has(VersioningReviewRequiredLabel)) {
        logMessage("'VersioningReviewRequired' label needs to be added.");
        setOutput("versioningReviewLabelName", VersioningReviewRequiredLabel);
        setOutput("versioningReviewLabelValue", "true");
      } else {
        logMessage("'VersioningReviewRequired' label needs to be deleted.");
        setOutput("versioningReviewLabelName", VersioningReviewRequiredLabel);
        setOutput("versioningReviewLabelValue", "false");
      }
    }
  }
}

/**
 * Get categorized changed files by calling the shared getCategorizedChangedFiles function.
 * Filters results to only include Swagger/OpenAPI files using the swagger filter from changed-files.js
 * @param options - Options for getting changed files
 * @param options.baseCommitish - Base commit to compare from (default: "HEAD^")
 * @param options.cwd - Current working directory (default: process.cwd())
 * @param options.headCommitish - Head commit to compare to (default: "HEAD")
 * @returns Promise resolving to categorized changed files filtered for Swagger files only
 */
export async function getSwaggerDiffs(
  options: {
    baseCommitish?: string;
    cwd?: string;
    headCommitish?: string;
  } = {},
): Promise<{
  additions: string[];
  modifications: string[];
  deletions: string[];
  total: number;
}> {
  try {
    // Call the function with compatible options
    const result = await getChangedFilesStatuses({
      baseCommitish: options.baseCommitish,
      cwd: options.cwd,
      headCommitish: options.headCommitish,
      paths: ["specification"],
    });

    // Filter each array to only include Swagger files using the swagger filter from changed-files.js
    const filteredAdditions = result.additions.filter(swagger);
    const filteredModifications = result.modifications.filter(swagger);
    const filteredDeletions = result.deletions.filter(swagger);
    const filteredRenames = result.renames.filter(
      (rename) => swagger(rename.from) && swagger(rename.to),
    );

    // Add renamed files to the additions array and deletions array
    filteredAdditions.push(...filteredRenames.map((rename) => rename.to));
    filteredDeletions.push(...filteredRenames.map((rename) => rename.from));

    return {
      additions: filteredAdditions,
      modifications: filteredModifications,
      deletions: filteredDeletions,
      total: filteredAdditions.length + filteredModifications.length + filteredDeletions.length,
    };
  } catch (error) {
    logError(`Error getting categorized changed files: ${error}`);
    // Return empty result on error
    return {
      additions: [],
      modifications: [],
      deletions: [],
      total: 0,
    };
  }
}

/**
 * NOTE: For base branch which not in targetBranches, the breaking change tool compare head branch with master branch.
 * TargetBranches is a set of branches and treat each of them like a service team master branch.
 */
export async function buildPrInfo(context: Context): Promise<void> {
  const prInfo = await createPullRequestProperties(
    context,
    context.runType === "CrossVersion" ? "cross-version" : "same-version",
  );
  if (!prInfo || !prInfo.targetBranch) {
    throw new Error("create PR failed!");
  }
  context.prInfo = prInfo;
}

// Constants and state for dummy swagger management
const whitelistsBranches = ["ARMCoreRPDev", "rpsaasmaster"];
const createdDummySwagger: string[] = [];

/**
 * Change the base branch for comparison based on context and whitelist rules
 */
export function changeBaseBranch(context: Context): void {
  /*
   * always compare against main
   * we still use the changed files got from the PR, because the main branch may quite different with the PR target branch
   */
  function isBreakingChangeWhiteListBranch() {
    return (
      isSameVersionBreakingType(context.runType) &&
      whitelistsBranches.some((b) => context.prTargetBranch.toLowerCase() === b.toLowerCase())
    );
  }
  // same version breaking change for PR targets to rpaas or armCoreRpDev, will compare with the original target branch.
  if (context.baseBranch !== context.prTargetBranch && !isBreakingChangeWhiteListBranch()) {
    context.prInfo!.baseBranch = context.baseBranch;
    logMessage(`switch target branch to ${context.baseBranch}`);
  }
}

/**
 * Log the full list of OAD messages to console
 */
export function logFullOadMessagesList(msgs: ResultMessageRecord[]): void {
  logMessage("---- Full list of messages ----", LogLevel.Group);
  logMessage("[");
  // Printing the messages one by one because the console.log appears to elide the messages with "... X more items"
  // after approximately 292 messages.
  for (const msg of msgs) {
    logMessage(JSON.stringify(msg, null, 4) + ",");
  }
  logMessage("]");
  logMessage("---- End of full list of messages ----", LogLevel.EndGroup);
}

/**
 * Create a dummy swagger file for comparison purposes
 */
export function createDummySwagger(fromSwagger: string, toSwagger: string): void {
  if (!existsSync(path.dirname(toSwagger))) {
    mkdirSync(path.dirname(toSwagger), { recursive: true });
  }
  const content = readFileSync(fromSwagger).toString();
  const swaggerJson = JSON.parse(content);
  swaggerJson.paths = {};
  if (swaggerJson["x-ms-paths"]) {
    swaggerJson["x-ms-paths"] = {};
  }
  if (swaggerJson["x-ms-parameterized-host"]) {
    delete swaggerJson["x-ms-parameterized-host"];
  }
  swaggerJson.responses = {};
  swaggerJson.parameters = {};
  swaggerJson.definitions = {};
  writeFileSync(toSwagger, JSON.stringify(swaggerJson, null, 2));
  createdDummySwagger.push(toSwagger);
  logMessage(`created a dummy swagger: ${toSwagger} from ${fromSwagger}`);
}

/**
 * Clean up all created dummy swagger files
 */
export function cleanDummySwagger(): void {
  for (const swagger of createdDummySwagger) {
    rmSync(swagger, { recursive: true, force: true });
  }
  // Clear the array after removing files
  createdDummySwagger.length = 0;
}

/**
 * Return true if the type indicates the same version breaking change
 */
export function isSameVersionBreakingType(type: BreakingChangesCheckType): boolean {
  return type === BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION;
}

/**
 * Get the count of created dummy swagger files
 */
export function getCreatedDummySwaggerCount(): number {
  return createdDummySwagger.length;
}
