import path from "node:path";
import { existsSync, mkdirSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { BreakingChangesCheckType, Context } from "./types/breaking-change-check.js";
import { getArgumentValue } from "./utils.js";
import { Logger } from "./logger.js";

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
  const swaggerDir: string = path.resolve(
    getArgumentValue(args, "--sd", path.join(localSpecRepoPath, "specification")),
  );
  const repo: string = getArgumentValue(args, "--repo", "azure/azure-rest-api-specs");
  const prNumber: string = getArgumentValue(args, "--number", "");
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
    swaggerDir,
    logFileFolder,
    baseBranch: getArgumentValue(args, "--bb", "main"),
    runType: getArgumentValue(args, "--rt", "SameVersion") as BreakingChangesCheckType,
    headCommit: getArgumentValue(args, "--hc", "HEAD"),
    repo,
    prNumber,
    prSourceBranch: getArgumentValue(args, "--sb", ""),
    prTargetBranch: getArgumentValue(args, "--tb", ""),
    logger,
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
