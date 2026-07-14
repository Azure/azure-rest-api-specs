import { spawnSync } from "node:child_process";
import path, { join } from "node:path";
import process from "node:process";
import type {
  ApiReleaseType,
  AzsdkRunner,
  CommandResult,
  EnsureReleasePlanResult,
  ReleasePlanCommandContext,
  ReleasePlanData,
} from "./types.ts";

/**
 * Create a runner that invokes azsdk using the AZSDK environment variable when present.
 * @returns Runner function that executes azsdk commands
 */
export function createAzdskRunner(): AzsdkRunner {
  return (args: string[]) => runAzdskCommand(args);
}

/**
 * Ensures release plan exists: by PR first, then by path+release type, else create one.
 * @param context The release plan command context containing PR, project, and release info
 * @param runner Function to execute azsdk release-plan commands
 * @returns Result indicating whether plan was found by PR, by path, or newly created
 */
export function ensureReleasePlan(
  context: ReleasePlanCommandContext,
  runner: AzsdkRunner,
  allowCreate = true,
): EnsureReleasePlanResult {
  if (context.prUrl) {
    const existingByPr = runGetReleasePlanByPr(context.prUrl, runner);
    if (existingByPr) {
      return {
        outcome: "existing_by_pr",
        releasePlan: existingByPr,
        details: buildDetails(context),
      };
    }
  }

  const existingByPath = runGetReleasePlanByPath(
    context.tspProjectPath,
    context.apiReleaseType,
    runner,
  );
  if (existingByPath) {
    return {
      outcome: "existing_by_path",
      releasePlan: existingByPath,
      details: buildDetails(context),
    };
  }

  if (!allowCreate) {
    return {
      outcome: "not_found",
      releasePlan: null,
      details: buildDetails(context),
    };
  }

  const created = runCreateReleasePlan(context, runner);
  return {
    outcome: "created",
    releasePlan: created,
    details: buildDetails(context),
  };
}

/**
 * Builds details object for release plan result.
 * @param context The release plan command context
 * @returns Details object with PR, project, version, and release info
 */
function buildDetails(context: ReleasePlanCommandContext): EnsureReleasePlanResult["details"] {
  return {
    prUrl: context.prUrl ?? "",
    tspProjectPath: context.tspProjectPath,
    apiVersion: context.apiVersion,
    apiReleaseType: context.apiReleaseType,
    sdkReleaseType: context.sdkReleaseType,
    targetReleaseMonth: context.targetMonth,
  };
}

/**
 * Retrieves release plan by pull request URL.
 * @param prUrl GitHub PR URL (e.g., https://github.com/owner/repo/pull/123)
 * @param runner Function to execute azsdk commands
 * @returns Release plan object if found, null if not found or error occurred
 */
function runGetReleasePlanByPr(prUrl: string, runner: AzsdkRunner): ReleasePlanData | null {
  const args = ["release-plan", "get", "--pull-request", prUrl, "--output", "json"];
  return parseReleasePlanResult(runner(args));
}

/**
 * Retrieves release plan by TypeSpec project path and API release type.
 * @param tspProjectPath Path to TypeSpec project (relative to workspace)
 * @param apiReleaseType API release type (Private Preview, Public Preview, or GA)
 * @param runner Function to execute azsdk commands
 * @returns Release plan object if found, null if not found or error occurred
 */
function runGetReleasePlanByPath(
  tspProjectPath: string,
  apiReleaseType: ApiReleaseType,
  runner: AzsdkRunner,
): ReleasePlanData | null {
  const args = [
    "release-plan",
    "get",
    "--typespec-path",
    tspProjectPath,
    "--api-release-type",
    apiReleaseType,
    "--output",
    "json",
  ];
  return parseReleasePlanResult(runner(args));
}

/**
 * Parses release plan command result.
 * @param result Command execution result with exit code and output
 * @returns Parsed release plan object if successful, null if failed or empty
 */
function parseReleasePlanResult(result: CommandResult): ReleasePlanData | null {
  if (result.exitCode !== 0) {
    return null;
  }

  try {
    const parsed: unknown = JSON.parse(result.stdout);
    if (parsed === null) {
      return null;
    }
    if (typeof parsed !== "object" || Array.isArray(parsed)) {
      return null;
    }
    return parsed as ReleasePlanData;
  } catch {
    return null;
  }
}

/**
 * Creates a new release plan.
 * @param context The release plan command context with all required parameters
 * @param runner Function to execute azsdk commands
 * @returns Created release plan object
 * @throws Error if creation fails or output cannot be parsed
 */
function runCreateReleasePlan(
  context: ReleasePlanCommandContext,
  runner: AzsdkRunner,
): ReleasePlanData {
  if (!context.prUrl) {
    throw new Error(
      "No pull request URL could be resolved for this commit; cannot create release plan.",
    );
  }

  const args = [
    "release-plan",
    "create",
    "--typespec-path",
    context.tspProjectPath,
    "--api-release-type",
    context.apiReleaseType,
    "--release-month",
    context.targetMonth,
    "--pull-request",
    context.prUrl,
    "--force",
    "false",
    "--test-release",
    String(context.testReleasePlan),
    "--output",
    "json",
  ];

  const result = runner(args);
  if (result.exitCode !== 0) {
    throw new Error(`Release plan create failed. ${result.stderr || result.stdout}`);
  }

  try {
    const parsed: unknown = JSON.parse(result.stdout);
    if (parsed === null || typeof parsed !== "object" || Array.isArray(parsed)) {
      throw new Error(`Expected JSON object from azsdk output: ${result.stdout}`);
    }
    return parsed as ReleasePlanData;
  } catch {
    throw new Error(`Failed to parse JSON from azsdk output: ${result.stdout}`);
  }
}

/**
 * Run azsdk command synchronously.
 * @param args Command arguments to pass to azsdk
 * @returns Command execution result with exit code and output
 */
export function runAzdskCommand(args: string[]): CommandResult {
  const envPath = process.env.PATH || "";
  const home = process.env.HOME || process.env.USERPROFILE || "";
  const homeBin = home ? join(home, "bin") : "";
  const mergedPath = homeBin ? `${homeBin}${path.delimiter}${envPath}` : envPath;
  const executable = process.env.AZSDK?.trim() || "azsdk";

  const result = spawnSync(executable, args, {
    encoding: "utf8",
    env: {
      ...process.env,
      PATH: mergedPath,
    },
  });

  return {
    exitCode: result.status ?? 1,
    stdout: result.stdout || "",
    stderr: result.stderr || "",
  };
}

/**
 * Retrieves release plan details by release plan id.
 * @param releasePlanId Release plan id
 * @param runner Optional runner used to execute the azsdk command
 * @returns Parsed release plan object
 * @throws Error if command fails or output cannot be parsed
 */
export function getReleasePlanById(releasePlanId: string, runner?: AzsdkRunner): ReleasePlanData {
  const trimmedId = releasePlanId.trim();
  if (!trimmedId) {
    throw new Error("releasePlanId is required.");
  }

  const run: AzsdkRunner = runner ?? ((args: string[]) => runAzdskCommand(args));
  const result = run(["release-plan", "get", "--release-plan-id", trimmedId, "--output", "json"]);

  if (result.exitCode !== 0) {
    throw new Error(`Release plan get failed. ${result.stderr || result.stdout}`);
  }

  try {
    const parsed: unknown = JSON.parse(result.stdout);
    if (parsed === null || typeof parsed !== "object" || Array.isArray(parsed)) {
      throw new Error(`Expected JSON object from azsdk output: ${result.stdout}`);
    }
    return parsed as ReleasePlanData;
  } catch {
    throw new Error(`Failed to parse JSON from azsdk output: ${result.stdout}`);
  }
}

/**
 * Computes the target release month as "Month YYYY" for next month.
 * @returns Target release month string (e.g., "July 2026")
 */
export function getNextMonthTarget(): string {
  const now = new Date();
  const nextMonth = new Date(now.getFullYear(), now.getMonth() + 1, 1);
  const monthNames = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  return `${monthNames[nextMonth.getMonth()]} ${nextMonth.getFullYear()}`;
}

/**
 * Determine API release type based on repo and preview status.
 * Private Preview for azure-rest-api-specs-pr repo, otherwise Public Preview or GA.
 * @param isPreview Whether the API version is a preview version
 * @param repoName Repository name (azure-rest-api-specs or azure-rest-api-specs-pr)
 * @returns API release type (Private Preview, Public Preview, or GA)
 */
export function getApiReleaseType(isPreview: boolean, repoName: string): ApiReleaseType {
  if (repoName === "azure-rest-api-specs-pr") {
    return "Private Preview";
  }
  return isPreview ? "Public Preview" : "GA";
}

/**
 * Determine SDK release type based on preview status.
 * @param isPreview Whether the API version is a preview version
 * @returns SDK release type (beta or stable)
 */
export function getSdkReleaseType(isPreview: boolean): "beta" | "stable" {
  return isPreview ? "beta" : "stable";
}
