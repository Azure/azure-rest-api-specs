// @ts-check

import { extractInputs } from "../../src/context.js";
import { LabelAction } from "../../src/label.js";

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
  const workflowRuns = await github.rest.actions.listWorkflowRunsForRepo({
    owner,
    repo,
    event: "pull_request",
    status: "completed",
    per_page: 100,
    head_sha,
  });

  core.info("Workflow Runs:");
  workflowRuns.data.workflow_runs.forEach((wf) => {
    core.info(`- ${wf.name}: ${wf.conclusion || wf.status}`);
  });

  const wfName = "ARM Incremental Typespec (Preview)";
  const incrementalTspRuns = workflowRuns.data.workflow_runs.filter(
    (wf) => wf.name == wfName,
  );

  if (incrementalTspRuns.length == 0) {
    core.info(
      `Found no completed runs for workflow '${wfName}'.  May still be in-progress.`,
    );
    return LabelAction.None;
  } else if (incrementalTspRuns.length > 1) {
    throw `Unexpected number of runs for workflow '${wfName}': ${incrementalTspRuns.length}`;
  } else {
    const run = incrementalTspRuns[0];

    if (run.conclusion != "success") {
      core.info(
        `Run for workflow '${wfName}' did not succeed: '${run.conclusion}'`,
      );
      return LabelAction.Remove;
    }

    const artifactNames = (
      await github.rest.actions.listWorkflowRunArtifacts({
        owner,
        repo,
        run_id: run.id,
      })
    ).data.artifacts.map((a) => a.name);

    core.info(`artifactNames: ${JSON.stringify(artifactNames)}`);

    if (artifactNames.includes("incremental-typespec=false")) {
      core.info("Spec is not an incremental change to an existing TypeSpec RP");
      return LabelAction.Remove;
    } else if (artifactNames.includes("incremental-typespec=true")) {
      core.info("Spec is an incremental change to an existing TypeSpec RP");
      // Continue checking other requirements
    } else {
      // If workflow succeeded, it should have one workflow or the other
      throw `Workflow artifacts did not contain 'incremental-typespec': ${JSON.stringify(artifactNames)}`;
    }
  }

  // TODO: Try to extract labels from context (when available) to avoid unnecessary API call
  const labels = (
    await github.rest.issues.listLabelsOnIssue({
      owner: owner,
      repo: repo,
      issue_number: issue_number,
    })
  ).data.map((label) => label.name);

  core.info(`Labels: ${labels}`);

  // TODO: Also require label "ARMBestPracticesAcknowledgement"
  const allLabelsMatch =
    labels.includes("ARMReview") &&
    !labels.includes("NotReadyForARMReview") &&
    (!labels.includes("SuppressionReviewRequired") ||
      labels.includes("Approved-Suppression"));

  if (!allLabelsMatch) {
    core.info("Labels do not meet requirement for auto-signoff");
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

  core.info(
    `Swagger LintDiff: Status='${swaggerLintDiff?.status}', Conclusion='${swaggerLintDiff?.conclusion}'`,
  );

  if (swaggerLintDiff && swaggerLintDiff.status === "completed") {
    if (swaggerLintDiff.conclusion === "success") {
      core.info("All requirements met for auto-signoff");
      return LabelAction.Add;
    } else {
      core.info("Swagger LintDiff did not succeed");
      return LabelAction.Remove;
    }
  } else {
    // No-op if check is missing or not completed, to prevent frequent remove/add label as checks re-run
    core.info("Swagger LintDiff is in-progress");
    return LabelAction.None;
  }
}
