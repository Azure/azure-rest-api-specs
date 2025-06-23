import path from "node:path";
import { existsSync, mkdirSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { BreakingChangesCheckType, Context } from "./types/breaking-change-check.js";
import { getArgumentValue } from "./utils/common-utils.js";
import { Logger } from "./logger.js";
import { createPullRequestProperties } from "./utils/pull-request.js";
import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";

/**
 * Parse the arguments.
 * @returns The runner command input.
 */
export function initContext(): Context {
  const __filename: string = fileURLToPath(import.meta.url);
  const __dirname: string = path.dirname(__filename);

  // Get the arguments passed to the script
  const args: string[] = process.argv.slice(2);
  const localSpecRepoPath: string = path.resolve(
    getArgumentValue(args, "--srp", path.join(__dirname, "..")),
  );
  const swaggerDirs: string[] = ["specification", "dev"];
  const repo: string = getArgumentValue(args, "--repo", "azure/azure-rest-api-specs");
  const prNumber: string = getArgumentValue(args, "--number", "");
  const runType = getArgumentValue(args, "--rt", "SameVersion") as BreakingChangesCheckType;
  const workingFolder: string = path.join(localSpecRepoPath, "..");
  const logFileFolder: string = path.join(workingFolder, "out/logs");

  // Create the log file folder if it does not exist
  if (!existsSync(logFileFolder)) {
    mkdirSync(logFileFolder, { recursive: true });
  }

  const prUrl = `https://github.com/${repo}/pull/${prNumber}`;
  const logger = new Logger(logFileFolder, prUrl);
  return {
    localSpecRepoPath,
    workingFolder,
    swaggerDirs,
    logFileFolder,
    baseBranch: getArgumentValue(args, "--bb", "main"),
    runType,
    checkName: getBreakingChangeCheckName(runType),
    headCommit: getArgumentValue(args, "--hc", "HEAD"),
    repo,
    prNumber,
    prSourceBranch: getArgumentValue(args, "--sb", ""),
    prTargetBranch: getArgumentValue(args, "--tb", ""),
    logger,
    prUrl,
  };
}

/**
 * This set contains labels denoting which kind of review is required.
 *
 * Appropriate labels are added to this set by applyRules() function.
 *
 * This collection is then read by addBreakingChangeLabels().
 */
export const BreakingChangeLabels = new Set<string>();
export let defaultBreakingChangeBaseBranch = "main";
function getBreakingChangeCheckName(runType: BreakingChangesCheckType): string {
  return runType === "SameVersion" ? "Swagger BreakingChange" : "BreakingChange(Cross-Version)";
}

/**
 * Get categorized changed files by calling the shared getCategorizedChangedFiles function.
 * @param options - Options for getting changed files
 * @param options.baseCommitish - Base commit to compare from (default: "HEAD^")
 * @param options.cwd - Current working directory (default: process.cwd())
 * @param options.headCommitish - Head commit to compare to (default: "HEAD")
 * @returns Promise resolving to categorized changed files
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
  renames: { from: string; to: string }[];
  total: number;
}> {
  try {
    // Call the function with compatible options
    const result = await getChangedFilesStatuses({
      baseCommitish: options.baseCommitish,
      cwd: options.cwd,
      headCommitish: options.headCommitish,
    });

    return result;
  } catch (error) {
    console.error("Error getting categorized changed files:", error);
    // Return empty result on error
    return {
      additions: [],
      modifications: [],
      deletions: [],
      renames: [],
      total: 0,
    };
  }
}

/**
 * NOTE: For base branch which not in targetBranches, the breaking change tool compare head branch with master branch.
 * TargetBranches is a set of branches and treat each of them like a service team master branch.
 */
export async function buildPrInfo(context: Context): Promise<void> {
  /**
   * For PR target branch not in `targetBranches`. prepare for switch to master branch,
   * if not the switching to master below would failed
   */
  defaultBreakingChangeBaseBranch = context.baseBranch;
  const prInfo = await createPullRequestProperties(
    context,
    context.runType === "CrossVersion" ? "cross-version" : "same-version",
  );
  if (!prInfo || !prInfo.targetBranch) {
    throw new Error("create PR failed!");
  }
  context.prInfo = prInfo;
}
