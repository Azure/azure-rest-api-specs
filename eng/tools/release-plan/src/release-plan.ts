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
 * Reuses an in-progress or finished plan for the same project and API version, or creates one.
 * @param context The release plan command context containing PR, project, and release info
 * @param runner Function to execute azsdk release-plan commands
 * @returns Result indicating whether plan was found by PR, by path, or newly created
 */
export function ensureReleasePlan(
  context: ReleasePlanCommandContext,
  runner: AzsdkRunner,
): EnsureReleasePlanResult {
  const existingByPath = runGetReleasePlanByPath(
    context.tspProjectPath,
    context.apiVersion,
    context.apiReleaseType,
    runner,
  );
  if (existingByPath) {
    const details = existingByPath.release_plan_details;
    if (typeof details?.SpecAPIVersion !== "string" || typeof details.Status !== "string") {
      throw new Error("Release plan lookup returned a plan without an API version or status.");
    }
    const status = details.Status.trim().toLowerCase();
    if (
      details.SpecAPIVersion.trim().toLowerCase() === context.apiVersion.trim().toLowerCase() &&
      (status === "in progress" || status === "finished")
    ) {
      console.log(
        `Reusing release plan for API version '${details.SpecAPIVersion}' in '${details.Status}' status.`,
      );
      return {
        outcome: "existing_by_path",
        releasePlan: existingByPath,
        details: buildDetails(context),
      };
    }

    console.log(
      `The returned plan has API version '${details.SpecAPIVersion}' and status '${details.Status}'. ` +
        `Creating a release plan for API version '${context.apiVersion}'.`,
    );
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
    specCommitSha: context.specCommitSha,
    apiReleaseType: context.apiReleaseType,
    sdkReleaseType: context.sdkReleaseType,
    targetReleaseMonth: context.targetMonth,
  };
}

/**
 * Retrieves release plan by TypeSpec project path, API version, and API release type.
 * @param tspProjectPath Path to TypeSpec project (relative to workspace)
 * @param apiVersion API version to match
 * @param apiReleaseType API release type (Private Preview, Public Preview, or GA)
 * @param runner Function to execute azsdk commands
 * @returns Release plan object if found, null if not found
 * @throws Error if the lookup fails or returns invalid JSON
 */
function runGetReleasePlanByPath(
  tspProjectPath: string,
  apiVersion: string,
  apiReleaseType: ApiReleaseType,
  runner: AzsdkRunner,
): ReleasePlanData | null {
  const args = [
    "release-plan",
    "get",
    "--typespec-path",
    tspProjectPath,
    "--api-version",
    apiVersion,
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
 * @returns Parsed release plan object if successful, null if not found
 * @throws Error if the lookup fails or returns invalid JSON
 */
function parseReleasePlanResult(result: CommandResult): ReleasePlanData | null {
  let parsed: unknown;
  try {
    parsed = JSON.parse(result.stdout);
  } catch (error) {
    if (result.exitCode !== 0) {
      throw new Error(`Release plan get failed. ${result.stderr || result.stdout}`, {
        cause: error,
      });
    }
    throw new Error(`Failed to parse JSON from azsdk output: ${result.stdout}`, { cause: error });
  }

  if (parsed !== null && typeof parsed === "object" && "response_error" in parsed) {
    // The CLI uses this exact response, with exit code 1, when a lookup finds no plan.
    if (parsed.response_error === "Failed to get release plan details.") {
      return null;
    }
    if (typeof parsed.response_error === "string" && parsed.response_error) {
      throw new Error(`Release plan get failed. ${parsed.response_error}`);
    }
  }
  if (result.exitCode !== 0) {
    throw new Error(`Release plan get failed. ${result.stderr || result.stdout}`);
  }
  if (parsed === null) {
    return null;
  }
  if (typeof parsed !== "object" || Array.isArray(parsed)) {
    throw new Error(`Expected JSON object or null from azsdk output: ${result.stdout}`);
  }
  return parsed as ReleasePlanData;
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
    "--test-release",
    String(context.testReleasePlan),
    ...(context.apiReleaseType === "Private Preview"
      ? []
      : ["--spec-commit-sha", context.specCommitSha]),
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
 * Retrieves a release plan directly by id without running discovery or creation.
 */
export function getReleasePlanResultById(
  releasePlanId: string,
  runner: AzsdkRunner,
): EnsureReleasePlanResult {
  const trimmedId = releasePlanId.trim();
  return {
    outcome: "existing_by_id",
    releasePlan: getReleasePlanById(trimmedId, runner),
    details: { releasePlanId: trimmedId },
  };
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
