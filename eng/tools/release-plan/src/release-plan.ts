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
    const existingByPr = runGetReleasePlanByPr(context.prUrl, context.apiReleaseType, runner);
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
    context.apiVersion,
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
    specCommitSha: context.specCommitSha,
    apiReleaseType: context.apiReleaseType,
    sdkReleaseType: context.sdkReleaseType,
    targetReleaseMonth: context.targetMonth,
  };
}

/**
 * Retrieves release plan by pull request URL and API release type.
 * @param prUrl GitHub PR URL (e.g., https://github.com/owner/repo/pull/123)
 * @param apiReleaseType API release type to match
 * @param runner Function to execute azsdk commands
 * @returns Release plan object if found, null if not found or error occurred
 */
function runGetReleasePlanByPr(
  prUrl: string,
  apiReleaseType: ApiReleaseType,
  runner: AzsdkRunner,
): ReleasePlanData | null {
  const args = [
    "release-plan",
    "get",
    "--pull-request",
    prUrl,
    "--api-release-type",
    apiReleaseType,
    "--output",
    "json",
  ];
  return parseReleasePlanResult(runner(args));
}

/**
 * Retrieves release plan by TypeSpec project path, API version, and API release type.
 * @param tspProjectPath Path to TypeSpec project (relative to workspace)
 * @param apiVersion API version to match
 * @param apiReleaseType API release type (Private Preview, Public Preview, or GA)
 * @param runner Function to execute azsdk commands
 * @returns Release plan object if found, null if not found or error occurred
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

const releasePlanLanguageBySdkRepo = new Map([
  ["azure-sdk-for-net", "Dotnet"],
  ["azure-sdk-for-js", "JavaScript"],
  ["azure-sdk-for-python", "Python"],
  ["azure-sdk-for-java", "Java"],
  ["azure-sdk-for-go", "Go"],
]);

const inactiveReleasePlanStates = ["Closed", "Duplicate", "Abandoned", "Finished"];

interface SdkReleasePlanCheck {
  typeSpecConfigPath: string;
  sdkRepoName: string;
  sdkRepoOwner: string;
  sdkCheckoutBranch: string;
  releasePlanWorkItemId: number;
  createPullRequest: boolean;
}

interface ReleasePlanWorkItem {
  id: number;
  fields: Record<string, string | undefined>;
}

export async function assertNoConflictingSdkReleasePlan(
  check: SdkReleasePlanCheck,
  accessToken: string | undefined,
  githubToken?: string,
): Promise<void> {
  const { typeSpecConfigPath, sdkRepoName, releasePlanWorkItemId, createPullRequest } = check;
  const language = releasePlanLanguageBySdkRepo.get(sdkRepoName.toLowerCase().replace(/-pr$/, ""));
  if (!language) {
    console.log(`Release plans do not track SDK pull requests for '${sdkRepoName}'.`);
    return;
  }
  if (
    !Number.isInteger(releasePlanWorkItemId) ||
    releasePlanWorkItemId < 0 ||
    releasePlanWorkItemId > 2_147_483_647
  ) {
    throw new Error("ReleasePlanWorkItemId must be 0 or a positive Azure DevOps work item ID.");
  }
  if (!accessToken) {
    throw new Error("An Azure DevOps access token is required to check SDK release plans.");
  }

  const typeSpecProjectPath = path.posix.dirname(path.posix.normalize(typeSpecConfigPath));
  const inactiveStates = inactiveReleasePlanStates.map((state) => `'${state}'`).join(",");
  const activePlansFilter = `[System.State] NOT IN (${inactiveStates})`;
  // Include an explicitly selected plan even if it is inactive, to verify its project and tags.
  const planFilter = releasePlanWorkItemId
    ? `(${activePlansFilter} OR [System.Id] = ${releasePlanWorkItemId})`
    : activePlansFilter;
  const query = `SELECT [System.Id] FROM WorkItems WHERE [System.TeamProject] = 'Release'
    AND [System.WorkItemType] = 'Release Plan'
    AND [Custom.ApiSpecProjectPath] = '${typeSpecProjectPath.replaceAll("'", "''")}'
    AND ${planFilter}`;
  const { workItems } = (await queryReleasePlanWorkItems("wiql", { query }, accessToken)) as {
    workItems: { id: number }[];
  };

  const pullRequestField = `Custom.SDKPullRequestFor${language}`;
  const releaseStatusField = `Custom.ReleaseStatusFor${language}`;
  const { value: plans } = workItems.length
    ? ((await queryReleasePlanWorkItems(
        "workitemsbatch",
        {
          ids: workItems.map(({ id }) => id),
          fields: ["System.State", "System.Tags", pullRequestField, releaseStatusField],
          errorPolicy: "Fail",
        },
        accessToken,
      )) as { value: ReleasePlanWorkItem[] })
    : { value: [] };

  const selectedPlan = plans.find(({ id }) => id === releasePlanWorkItemId);
  if (releasePlanWorkItemId && !selectedPlan) {
    throw new Error(
      `Could not find release plan work item ${releasePlanWorkItemId} for TypeSpec project '${typeSpecProjectPath}'.`,
    );
  }
  const isTestPlan = (plan?: ReleasePlanWorkItem) =>
    plan?.fields["System.Tags"]
      ?.split(";")
      .some((tag) => tag.trim().toLowerCase() === "release planner app test") ?? false;
  const selectedIsTestPlan = isTestPlan(selectedPlan);
  const conflictingPlan = plans.find(
    (plan) =>
      plan.id !== releasePlanWorkItemId &&
      isTestPlan(plan) === selectedIsTestPlan &&
      plan.fields[pullRequestField]?.trim() &&
      plan.fields[releaseStatusField]?.toLowerCase() !== "released",
  );
  const selectedPullRequest = selectedPlan?.fields[pullRequestField]?.trim();
  const selectedPlanIsActive = !inactiveReleasePlanStates.includes(
    selectedPlan?.fields["System.State"] ?? "",
  );
  if (
    selectedPullRequest &&
    (conflictingPlan ? selectedPlanIsActive : createPullRequest) &&
    (await verifyOpenSdkPullRequestBranch(selectedPullRequest, check, githubToken))
  ) {
    return;
  }

  if (conflictingPlan) {
    throw new Error(
      `SDK generation for '${typeSpecProjectPath}' is blocked because active release plan work item ${conflictingPlan.id} ` +
        `already has an unreleased ${language} SDK pull request. Complete or abandon that plan before generating for a different plan. ` +
        "See https://aka.ms/azsdk/releaseplan-dashboard.",
    );
  }
}

async function verifyOpenSdkPullRequestBranch(
  url: string,
  { sdkRepoName, sdkRepoOwner, sdkCheckoutBranch }: SdkReleasePlanCheck,
  githubToken?: string,
): Promise<boolean> {
  const match = /^https:\/\/github\.com\/Azure\/([\w-]+)\/pull\/(\d+)\/?$/i.exec(url);
  if (!match || match[1].toLowerCase() !== sdkRepoName.toLowerCase()) {
    throw new Error(`The release plan's SDK pull request must be in Azure/${sdkRepoName}.`);
  }
  const headers = new Headers({ Accept: "application/vnd.github+json" });
  if (githubToken) {
    headers.set("Authorization", `Bearer ${githubToken}`);
  }
  const response = await fetch(`https://api.github.com/repos/Azure/${match[1]}/pulls/${match[2]}`, {
    headers,
    redirect: "error",
  });
  if (!response.ok) {
    throw new Error(
      `Could not check the linked SDK pull request: GitHub returned HTTP ${response.status}.`,
    );
  }
  const pullRequest = (await response.json()) as {
    state: "open" | "closed";
    base: { ref: string };
    head: { ref: string; repo: { full_name: string } | null };
  };
  if (pullRequest.state === "closed") {
    return false;
  }
  const headRepo = `${sdkRepoOwner}/${sdkRepoName}`.toLowerCase();
  if (
    pullRequest.state !== "open" ||
    pullRequest.base.ref !== "main" ||
    pullRequest.head.repo?.full_name.toLowerCase() !== headRepo ||
    pullRequest.head.ref === "main"
  ) {
    throw new Error(`The linked SDK pull request #${match[2]} cannot be updated by this pipeline.`);
  }
  if (pullRequest.head.ref !== sdkCheckoutBranch) {
    throw new Error(
      `Set SdkRepoBranch to '${pullRequest.head.ref}' to update the existing SDK pull request #${match[2]}.`,
    );
  }
  return true;
}

async function queryReleasePlanWorkItems(
  endpoint: "wiql" | "workitemsbatch",
  body: object,
  accessToken: string,
): Promise<unknown> {
  const response = await fetch(
    `https://dev.azure.com/azure-sdk/Release/_apis/wit/${endpoint}?api-version=7.1`,
    {
      method: "POST",
      headers: { Authorization: `Bearer ${accessToken}`, "Content-Type": "application/json" },
      body: JSON.stringify(body),
      redirect: "error",
    },
  );
  if (!response.ok) {
    throw new Error(
      `Could not check SDK release plans: Azure DevOps ${endpoint} returned HTTP ${response.status}.`,
    );
  }
  return response.json();
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
