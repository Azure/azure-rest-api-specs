import { spawnSync } from "node:child_process";
import path, { join } from "node:path";
import process from "node:process";
import {
  apiReleaseTypeLabel,
  assertApiVersion,
  assertCleanSpecCheckout,
  assertSpecCommitSha,
  compareSpecCommits,
  projectPath,
  releasePlanDetails,
  requiredPlanId,
  runGit,
  type GitRunner,
} from "./spec-target.ts";
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
 * Selects a plan by project, API version and release type, then explicitly confirms its spec target.
 * @param context The release plan command context containing PR, project, and release info
 * @param runner Function to execute azsdk release-plan commands
 * @returns Result indicating whether plan was found by PR, by path, or newly created
 */
export function ensureReleasePlan(
  context: ReleasePlanCommandContext,
  runner: AzsdkRunner,
  allowCreate = true,
  git: GitRunner = runGit,
): EnsureReleasePlanResult {
  assertApiVersion(context.apiVersion);
  assertSpecCommitSha(context.specCommitSha);
  if (!context.prUrl) {
    throw new Error("A merged spec pull request is required to confirm a release target.");
  }
  assertCleanSpecCheckout(context.workspace, context.specCommitSha, git);

  const existingByPr = runGetReleasePlan(context, runner, true);
  if (existingByPr) {
    // With version inputs, the CLI selects by project/version even when a PR is supplied.
    const outcome =
      releasePlanDetails(existingByPr).ActiveSpecPullRequest === context.prUrl
        ? "existing_by_pr"
        : "existing_by_path";
    return confirmExistingPlan(existingByPr, outcome, context, runner, git);
  }

  const existingByPath = runGetReleasePlan(context, runner, false);
  if (existingByPath) {
    return confirmExistingPlan(existingByPath, "existing_by_path", context, runner, git);
  }

  if (!allowCreate) {
    return {
      outcome: "not_found",
      releasePlan: null,
      details: buildDetails(context),
    };
  }

  assertCleanSpecCheckout(context.workspace, context.specCommitSha, git);
  const created = runCreateReleasePlan(context, runner);
  const createdDetails = validateSelectedPlan(created, context, false);
  if (context.apiReleaseType !== "Private Preview") {
    assertSpecCommitSha(createdDetails.SpecCommitSHA);
  }
  if (
    createdDetails.ActiveSpecPullRequest !== context.prUrl ||
    (context.apiReleaseType !== "Private Preview" &&
      createdDetails.SpecCommitSHA!.toLowerCase() !== context.specCommitSha.toLowerCase())
  ) {
    // Create may reuse a plan discovered concurrently. Confirm against that observed pin,
    // with the same ancestry and concurrency checks as an ordinary discovery result.
    const outcome =
      createdDetails.ActiveSpecPullRequest === context.prUrl
        ? "existing_by_pr"
        : "existing_by_path";
    return confirmExistingPlan(created, outcome, context, runner, git);
  }
  const confirmed = getReleasePlanByWorkItemId(
    requiredPlanId(createdDetails.WorkItemId, "WorkItemId"),
    runner,
  );
  validateSelectedPlan(confirmed, context, true);
  validateSamePlan(created, confirmed);
  return {
    outcome: "created",
    releasePlan: confirmed,
    details: buildDetails(context, confirmed),
  };
}

function validateSelectedPlan(
  plan: ReleasePlanData,
  context: ReleasePlanCommandContext,
  requireTarget: boolean,
) {
  const details = releasePlanDetails(plan);
  requiredPlanId(details.WorkItemId, "WorkItemId");
  requiredPlanId(details.ReleasePlanId, "ReleasePlanId");
  if (
    details.SpecAPIVersion !== context.apiVersion ||
    apiReleaseTypeLabel(details.ApiReleaseType) !== context.apiReleaseType ||
    projectPath(details.APISpecProjectPath, context.workspace) !==
      projectPath(context.tspProjectPath, context.workspace)
  ) {
    throw new Error(
      "The returned release plan does not match the selected project, API version and API release type.",
    );
  }
  if (details.SDKReleaseType !== "beta" && details.SDKReleaseType !== "stable") {
    throw new Error("The selected release plan must explicitly set its SDK release type.");
  }
  if (requireTarget) {
    if (context.apiReleaseType !== "Private Preview") {
      assertSpecCommitSha(details.SpecCommitSHA);
      if (details.SpecCommitSHA.toLowerCase() !== context.specCommitSha.toLowerCase()) {
        throw new Error("The confirmed release plan spec commit does not match the event target.");
      }
    }
    if (details.ActiveSpecPullRequest !== context.prUrl) {
      throw new Error("The confirmed release plan spec PR does not match the event target.");
    }
  }
  return details;
}

function validateSamePlan(before: ReleasePlanData, after: ReleasePlanData): void {
  const previous = releasePlanDetails(before);
  const current = releasePlanDetails(after);
  if (
    String(previous.WorkItemId) !== String(current.WorkItemId) ||
    String(previous.ReleasePlanId) !== String(current.ReleasePlanId) ||
    previous.SDKReleaseType !== current.SDKReleaseType
  ) {
    throw new Error(
      "The release plan identity or SDK release type changed during spec target confirmation.",
    );
  }
}

function confirmExistingPlan(
  existing: ReleasePlanData,
  outcome: "existing_by_pr" | "existing_by_path",
  context: ReleasePlanCommandContext,
  runner: AzsdkRunner,
  git: GitRunner,
): EnsureReleasePlanResult {
  const details = validateSelectedPlan(existing, context, false);
  const isPrivatePreview = context.apiReleaseType === "Private Preview";
  const expectedSpecCommitSha = details.SpecCommitSHA || "none";
  const relation =
    !isPrivatePreview && details.SpecCommitSHA
      ? compareSpecCommits(context.workspace, details.SpecCommitSHA, context.specCommitSha, git)
      : undefined;
  if (relation === "stale") {
    return {
      outcome: "stale_event",
      releasePlan: existing,
      details: buildDetails(context, existing),
    };
  }
  if (
    (relation === "same" || isPrivatePreview) &&
    details.ActiveSpecPullRequest === context.prUrl
  ) {
    return { outcome, releasePlan: existing, details: buildDetails(context, existing) };
  }

  assertCleanSpecCheckout(context.workspace, context.specCommitSha, git);
  const workItemId = requiredPlanId(details.WorkItemId, "WorkItemId");
  const response = parseAzdskResponse(
    runner([
      "release-plan",
      "update-spec-pr",
      "--workitem-id",
      workItemId,
      "--typespec-path",
      projectPath(context.tspProjectPath, context.workspace),
      "--pull-request",
      context.prUrl!,
      ...targetArguments(context, expectedSpecCommitSha),
      "--output",
      "json",
    ]),
    "release-plan update-spec-pr",
  );
  if (response?.status !== "Success") {
    throw new Error("azsdk did not confirm a successful spec target update.");
  }
  const confirmed = getReleasePlanByWorkItemId(workItemId, runner);
  validateSelectedPlan(confirmed, context, true);
  validateSamePlan(existing, confirmed);
  return { outcome, releasePlan: confirmed, details: buildDetails(context, confirmed) };
}

function targetArguments(
  context: ReleasePlanCommandContext,
  expectedSpecCommitSha?: string,
): string[] {
  if (context.apiReleaseType === "Private Preview") {
    return [];
  }
  return [
    "--api-version",
    context.apiVersion,
    "--spec-commit-sha",
    context.specCommitSha,
    "--confirm-target",
    ...(expectedSpecCommitSha ? ["--expected-spec-commit-sha", expectedSpecCommitSha] : []),
  ];
}

/**
 * Builds details object for release plan result.
 * @param context The release plan command context
 * @returns Details object with PR, project, version, and release info
 */
function buildDetails(
  context: ReleasePlanCommandContext,
  plan?: ReleasePlanData,
): EnsureReleasePlanResult["details"] {
  return {
    prUrl: context.prUrl ?? "",
    tspProjectPath: context.tspProjectPath,
    apiVersion: context.apiVersion,
    specCommitSha: context.specCommitSha,
    apiReleaseType: context.apiReleaseType,
    sdkReleaseType: plan?.release_plan_details?.SDKReleaseType ?? context.sdkReleaseType,
    targetReleaseMonth: context.targetMonth,
  };
}

/**
 * Both discovery routes constrain project, API version and release type, not strict PR identity.
 */
function runGetReleasePlan(
  context: ReleasePlanCommandContext,
  runner: AzsdkRunner,
  byPr: boolean,
): ReleasePlanData | null {
  const args = [
    "release-plan",
    "get",
    ...(byPr ? ["--pull-request", context.prUrl!] : []),
    "--typespec-path",
    projectPath(context.tspProjectPath, context.workspace),
    "--api-version",
    context.apiVersion,
    "--api-release-type",
    context.apiReleaseType,
    "--output",
    "json",
  ];
  return parseAzdskResponse(runner(args), "release-plan get", true);
}

/**
 * Exit zero alone is not success: confirmation previews and response errors never authorize work.
 * Only the CLI's exact lookup-miss response (or JSON null) permits discovery to continue.
 */
export function parseAzdskResponse(
  result: CommandResult,
  command: string,
  allowNotFound = false,
): ReleasePlanData | null {
  let parsed: unknown;
  try {
    parsed = JSON.parse(result.stdout);
  } catch {
    throw new Error(`Invalid JSON from azsdk ${command}. ${result.stderr || result.stdout}`);
  }
  if (allowNotFound && parsed === null && result.exitCode === 0) {
    return null;
  }
  if (parsed === null || typeof parsed !== "object" || Array.isArray(parsed)) {
    throw new Error(`Expected a JSON object from azsdk ${command}.`);
  }
  const response = parsed as ReleasePlanData;
  if (response.requires_confirmation) {
    throw new Error(`azsdk ${command} requires confirmation; no confirmed target was returned.`);
  }
  if (
    allowNotFound &&
    response.response_error === "Failed to get release plan details." &&
    !response.release_plan_details &&
    (!response.response_errors ||
      (Array.isArray(response.response_errors) && response.response_errors.length === 0))
  ) {
    return null;
  }
  if (
    result.exitCode !== 0 ||
    response.response_error ||
    (response.response_errors &&
      (!Array.isArray(response.response_errors) || response.response_errors.length > 0)) ||
    (response.operation_status !== undefined && response.operation_status !== "Succeeded") ||
    (response.status !== undefined && response.status !== "Success")
  ) {
    throw new Error(`azsdk ${command} failed. ${result.stderr || result.stdout}`);
  }
  return response;
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
    projectPath(context.tspProjectPath, context.workspace),
    "--api-release-type",
    context.apiReleaseType,
    "--release-month",
    context.targetMonth,
    "--pull-request",
    context.prUrl,
    "--test-release",
    String(context.testReleasePlan),
    ...targetArguments(context),
    "--output",
    "json",
  ];

  const response = parseAzdskResponse(runner(args), "release-plan create");
  if (!response) {
    throw new Error("azsdk release-plan create did not return a release plan.");
  }
  return response;
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

  const response = parseAzdskResponse(result, "release-plan get");
  if (!response) {
    throw new Error("azsdk release-plan get did not return a release plan.");
  }
  return response;
}

function getReleasePlanByWorkItemId(workItemId: string, runner: AzsdkRunner): ReleasePlanData {
  const response = parseAzdskResponse(
    runner(["release-plan", "get", "--workitem-id", workItemId, "--output", "json"]),
    "release-plan get",
  );
  if (!response) {
    throw new Error("azsdk release-plan get did not return the confirmed release plan.");
  }
  return response;
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
