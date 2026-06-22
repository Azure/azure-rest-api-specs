import { getTypeSpecProjectInfo } from "./typespec-project-info.js";
import { execSync } from "node:child_process";

/**
 * Analyze TypeSpec changes in a PR and set workflow outputs for release-plan generation.
 *
 * @param {Object} params
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} params.github
 * @param {import('@actions/github-script').AsyncFunctionArguments['context']} params.context
 * @param {import('@actions/github-script').AsyncFunctionArguments['core']} params.core
 * @param {number|string|undefined} [params.prNumberRaw]
 * @returns {Promise<void>}
 */
export async function analyzeTypeSpecProjectChanges({ github, context, core, prNumberRaw }) {
  let prNumber;
  if (context.eventName === "pull_request") {
    prNumber = context.payload.pull_request.number;
  } else if (context.eventName === "workflow_dispatch") {
    prNumber = Number.parseInt(String(prNumberRaw ?? ""), 10);
  }

  if (!prNumber || prNumber <= 0) {
    core.warning("Invalid PR number for analyze workflow.");
    core.setOutput("should_create_release_plan", "false");
    core.setOutput("tsp_project_count", "0");
    core.setOutput("api_version_count", "0");
    return;
  }

  const info = await getTypeSpecProjectInfo(github, context, core, { prNumber });

  const shouldCreateReleasePlan = info.tspProjectPaths.length === 1 && info.apiVersions.length > 0;

  core.setOutput("should_create_release_plan", String(shouldCreateReleasePlan));
  core.setOutput("tsp_project_count", String(info.tspProjectPaths.length));
  core.setOutput("api_version_count", String(info.apiVersions.length));

  core.info(`Should create release plan: ${shouldCreateReleasePlan}`);
  core.info(`TypeSpec projects: ${info.tspProjectPaths.length}`);
  core.info(`API versions: ${info.apiVersions.length}`);

  if (info.apiVersions.length > 1) {
    core.info(`Multiple API versions detected; selecting latest: ${info.apiVersions[0]}`);
  }

  if (shouldCreateReleasePlan) {
    core.setOutput("tsp_project_path", info.tspProjectUrls[0]);
    core.setOutput("api_version", info.apiVersions[0]);
    core.setOutput("tsp_project_path_encoded", encodeURIComponent(info.tspProjectUrls[0]));
  }

  if (!shouldCreateReleasePlan && info.tspProjectPaths.length > 1) {
    await github.rest.issues.createComment({
      owner: context.repo.owner,
      repo: context.repo.repo,
      issue_number: prNumber,
      body:
        "Multiple TypeSpec project changes are identified in this PR. " +
        "The release plan cannot be automatically created. " +
        "Please create it manually using the **azsdk agent** in VS Code. " +
        "See [release plan documentation](https://aka.ms/azsdk/releaseplan-dashboard) for details.",
    });
    core.info("Posted comment: multiple TypeSpec projects detected.");
  }
}

/**
 * Computes the target release month as "Month YYYY" for next month.
 *
 * @returns {string}
 */
export function getNextMonthTarget() {
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
 * Determines the API release type based on preview status and repo name.
 *
 * @param {boolean} isPreview
 * @param {string} repoName
 * @returns {string}
 */
export function getApiReleaseType(isPreview, repoName) {
  if (repoName === "azure-rest-api-specs-pr") {
    return "Private Preview";
  }
  return isPreview ? "Public Preview" : "GA";
}

/**
 * Determines the SDK release type based on preview status.
 *
 * @param {boolean} isPreview
 * @returns {string}
 */
export function getSdkReleaseType(isPreview) {
  return isPreview ? "preview" : "stable";
}

/**
 * Validates raw inputs from workflow and sets normalized outputs.
 * Leaves skip=true when validation fails so downstream steps are not executed.
 *
 * @param {Object} params
 * @param {import('@actions/github-script').AsyncFunctionArguments['core']} params.core
 * @param {number|string|undefined} params.prNumberRaw
 * @param {string|undefined} params.tspProjectPathRaw
 * @param {string|undefined} params.apiVersionRaw
 * @returns {Promise<void>}
 */
export async function validateAndSetReleasePlanInputs({
  core,
  prNumberRaw,
  tspProjectPathRaw,
  apiVersionRaw,
}) {
  core.setOutput("skip", "true");

  const prNumber = Number.parseInt(String(prNumberRaw ?? ""), 10);
  const tspProjectPath = String(tspProjectPathRaw ?? "").trim();
  const apiVersion = String(apiVersionRaw ?? "").trim();

  if (!prNumber || prNumber <= 0) {
    core.warning("Invalid PR number.");
    return;
  }

  if (!tspProjectPath) {
    core.warning("Missing TypeSpec project path.");
    return;
  }

  // Allow callers to pass either the project URL or the tspconfig.yaml URL; normalize to project URL.
  const normalizedTspProjectPath = tspProjectPath.replace(/\/tspconfig\.yaml$/, "");

  const tspProjectPathRegex =
    /^https:\/\/github\.com\/Azure\/(?:azure-rest-api-specs|azure-rest-api-specs-pr)\/[A-Za-z0-9\/-]+$/;
  if (!tspProjectPathRegex.test(normalizedTspProjectPath)) {
    core.warning(
      "Invalid TypeSpec project path. Expected URL starting with https://github.com/Azure/azure-rest-api-specs or https://github.com/Azure/azure-rest-api-specs-pr, containing only /, a-z, A-Z, 0-9, -. Optional trailing /tspconfig.yaml is ignored.",
    );
    return;
  }

  if (!apiVersion) {
    core.warning("Missing API version.");
    return;
  }

  const apiVersionRegex = /^\d{4}-\d{2}-\d{2}(?:-preview)?$/;
  if (!apiVersionRegex.test(apiVersion)) {
    core.warning(
      `Invalid api_version '${apiVersion}'. Expected format YYYY-MM-DD or YYYY-MM-DD-preview.`,
    );
    return;
  }

  core.setOutput("skip", "false");
  core.setOutput("pr_number", String(prNumber));
  core.setOutput("tsp_project_path", normalizedTspProjectPath);
  core.setOutput("api_version", apiVersion);
}

/**
 * Creates a release plan from pre-computed inputs and posts a comment on the PR.
 * All inputs are provided directly — no PR checkout or GitHub API file listing required.
 *
 * @param {Object} params
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} params.github
 * @param {import('@actions/github-script').AsyncFunctionArguments['context']} params.context
 * @param {import('@actions/github-script').AsyncFunctionArguments['core']} params.core
 * @param {number|string} params.prNumber
 * @param {string} params.tspProjectPath
 * @param {string} params.apiVersion
 * @param {typeof execSync} [params.execSyncImpl]
 * @returns {Promise<void>}
 */
export async function createReleasePlanWithKnownInputs({
  github,
  context,
  core,
  prNumber,
  tspProjectPath,
  apiVersion,
  execSyncImpl = execSync,
}) {
  const parsedPrNumber = Number.parseInt(String(prNumber), 10);
  const prUrl = `https://github.com/${context.repo.owner}/${context.repo.repo}/pull/${parsedPrNumber}`;
  const isPreview = apiVersion.endsWith("-preview");
  const apiReleaseType = getApiReleaseType(isPreview, context.repo.repo);
  const sdkReleaseType = getSdkReleaseType(isPreview);
  const targetMonth = getNextMonthTarget();
  const env = { ...process.env, PATH: `${process.env.HOME}/bin:${process.env.PATH}` };

  core.info("Creating release plan...");
  core.info(`  TypeSpec project path: ${tspProjectPath}`);
  core.info(`  API version: ${apiVersion}`);
  core.info(`  API release type: ${apiReleaseType}`);
  core.info(`  SDK release type: ${sdkReleaseType}`);
  core.info(`  Target release month: ${targetMonth}`);
  core.info(`  Spec PR URL: ${prUrl}`);

  let createOutput;
  try {
    createOutput = execSyncImpl(
      [
        "azsdk release-plan create",
        `--typespec-path "${tspProjectPath}"`,
        `--api-release-type "${apiReleaseType}"`,
        `--sdk-type "${sdkReleaseType}"`,
        `--release-month "${targetMonth}"`,
        `--pull-request "${prUrl}"`,
        "--force false",
        "--output json",
      ].join(" "),
      { encoding: "utf8", env },
    );
  } catch (err) {
    const message = err instanceof Error ? err.message : String(err);
    core.warning(`Release plan creation failed: ${message}`);
    return;
  }

  /** @type {any} */
  let releasePlan;
  try {
    releasePlan = JSON.parse(createOutput);
  } catch (_err) {
    core.warning(`Failed to parse release plan create output: ${createOutput}`);
    return;
  }

  const planLink =
    releasePlan.release_plan_link ||
    releasePlan.url ||
    releasePlan.link ||
    releasePlan.webUrl ||
    "";
  const planId = releasePlan.ReleasePlanId || releasePlan.id || releasePlan.workItemId || "";

  let body = `### ✅ Release Plan Created\n\n`;
  body += `| Field | Value |\n|-------|-------|\n`;
  if (planLink) {
    body += `| **Release Plan** | [View Release Plan](${planLink}) |\n`;
  }
  if (planId) {
    body += `| **Release Plan ID** | ${planId} |\n`;
  }
  body += `| **API Version** | \`${apiVersion}\` |\n`;
  body += `| **TypeSpec Project** | \`${tspProjectPath}\` |\n`;

  await github.rest.issues.createComment({
    owner: context.repo.owner,
    repo: context.repo.repo,
    issue_number: parsedPrNumber,
    body,
  });

  core.info("Posted release plan comment on PR.");
}
