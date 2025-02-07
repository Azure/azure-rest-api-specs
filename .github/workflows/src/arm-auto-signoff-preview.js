// @ts-check

import path from "path";
import { extractInputs } from "../../src/context.js";
import { LabelAction } from "../../src/label.js";
import { getChangedSwaggerFiles } from "./changed-files.js";
import { lsTree } from "./git.js";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<LabelAction>}
 */
export default async function getLabelAction({ github, context, core }) {
  let owner = process.env.OWNER || "";
  let repo = process.env.REPO || "";
  let issue_number = parseInt(process.env.ISSUE_NUMBER || "");
  let head_sha = process.env.HEAD_SHA || "";

  if (!owner || !repo || !issue_number || !head_sha) {
    let inputs = await extractInputs(github, context, core);
    owner = owner || inputs.owner;
    repo = repo || inputs.repo;
    issue_number = issue_number || inputs.issue_number;
    head_sha = head_sha || inputs.head_sha;
  }

  return await getLabelActionImpl({
    owner,
    repo,
    issue_number,
    head_sha,
    github,
    core,
  });
}

/**
 * @param {Object} params
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {number} params.issue_number
 * @param {string} params.head_sha
 * @param {(import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api & { paginate: import("@octokit/plugin-paginate-rest").PaginateInterface; })} params.github
 * @param {typeof import("@actions/core")} params.core
 * @returns {Promise<LabelAction>}
 */
export async function getLabelActionImpl({
  owner,
  repo,
  issue_number,
  head_sha,
  github,
  core,
}) {
  if (!(await incrementalChangesToExistingResourceProvider(core))) {
    return LabelAction.Remove;
  }

  // TODO: Try to extract labels from context (when available) to avoid unnecessary API call
  const labels = (
    await github.rest.issues.listLabelsOnIssue({
      owner: owner,
      repo: repo,
      issue_number: issue_number,
    })
  ).data.map((label) => label.name);

  const allLabelsMatch =
    labels.includes("ARMReview") &&
    !labels.includes("NotReadyForARMReview") &&
    labels.includes("ARMBestPractices") &&
    (!labels.includes("SuppressionReviewRequired") ||
      labels.includes("Suppression-Approved"));

  if (!allLabelsMatch) {
    return LabelAction.Remove;
  }

  const checkRuns = (
    await github.rest.checks.listForRef({
      owner: owner,
      repo: repo,
      ref: head_sha,
    })
  ).data.check_runs;

  const swaggerLintDiffs = checkRuns.filter(
    (run) => run.name === "Swagger LintDiff",
  );

  if (swaggerLintDiffs.length > 1) {
    throw new Error(
      `Unexpected number of checks named 'Swagger LintDiff': ${swaggerLintDiffs.length}`,
    );
  }

  const swaggerLintDiff =
    swaggerLintDiffs.length === 1 ? swaggerLintDiffs[0] : undefined;

  if (swaggerLintDiff && swaggerLintDiff.status === "completed") {
    return swaggerLintDiff.conclusion === "success"
      ? LabelAction.Add
      : LabelAction.Remove;
  } else {
    // No-op if check is missing or not completed, to prevent frequent remove/add label as checks re-run
    return LabelAction.None;
  }
}

/**
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @returns {Promise<boolean>} True if PR contains changes to existing RPs, and no new RPs
 */
async function incrementalChangesToExistingResourceProvider(core) {
  core.info("incrementalChangesToExistingResourceProvider()");

  const changedSwaggerFiles = await getChangedSwaggerFiles(
    core,
    "HEAD^",
    "HEAD",
    "",
  );
  const changedRmFiles = changedSwaggerFiles.filter((f) =>
    f.includes("/resource-manager/"),
  );

  core.info(
    `Changed files containing path '/resource-manager/': ${changedRmFiles}`,
  );

  if (changedRmFiles.length == 0) {
    core.info(
      "No changes to swagger files containing path '/resource-manager/'",
    );
    return false;
  } else {
    for (const file of changedRmFiles) {
      if (!(await specFolderExistsInTargetBranch(file, core))) {
        core.info(`Appears to add a new RP: ${file}`);
        return false;
      }
    }
    core.info("Appears to change an existing RPs, but adds no new RPs");
    return true;
  }
}

/**
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} file
 * @returns {Promise<boolean>} True if the spec folder exists in the target branch
 */
async function specFolderExistsInTargetBranch(file, core) {
  core.info(`specFolderExistsInTargetBranch("${file}")`);

  // Example1: specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json
  // Example2: specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/contosoGroup1/preview/2021-10-01-preview/contoso.json

  // Example1: specification/contosowidgetmanager/resource-manager/Microsoft.Contoso
  // Example2: specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/contosoGroup1
  const specDir = path.dirname(path.dirname(path.dirname(file)));
  core.info(`specDir: ${specDir}`);

  const resultString = await lsTree("HEAD^", specDir, core);

  // Command "git ls-tree" returns a nonempty string if the folder exists in the target branch
  const result = Boolean(resultString);
  core.info(`returning: ${result}`);
  return result;
}
