// @ts-check

import { extractInputs } from "../../src/context.js";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
export default async function armAutoSignoffPreview({ github, context, core }) {
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

  await armAutoSignoffPreviewImpl({
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
 */
export async function armAutoSignoffPreviewImpl({
  owner,
  repo,
  issue_number,
  head_sha,
  github,
  core,
}) {
  /** @type {boolean?} */
  // true: Add Label
  // false: Remove Label
  // null|undefined: No-op
  var addArmAutoSignoffPreview = null;

  // TODO: Get diff of files changed in PR, use to determine to "rp-service-existing" and "typespec-incremental"

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

  if (allLabelsMatch) {
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

    // No-op if check is missing or not completed, to prevent frequent remove/add label as checks re-run
    if (swaggerLintDiff && swaggerLintDiff.status === "completed") {
      addArmAutoSignoffPreview = swaggerLintDiff.conclusion === "success";
    }
  } else {
    addArmAutoSignoffPreview = false;
  }

  // All values converted to string, so tri-state is preserved
  // true / false / null|undefined -> "true" / "false" / ""
  core.setOutput("addArmAutoSignoffPreview", addArmAutoSignoffPreview);
}
