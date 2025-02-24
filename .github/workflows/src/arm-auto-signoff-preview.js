// @ts-check

import { extractInputs } from "../../src/context.js";
import { PER_PAGE_MAX } from "../../src/github.js";
import { LabelAction } from "../../src/label.js";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<{labelAction: LabelAction, issueNumber: number}>}
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
 * @returns {Promise<{labelAction: LabelAction, issueNumber: number}>}
 */
export async function getLabelActionImpl({
  owner,
  repo,
  issue_number,
  head_sha,
  github,
  core,
}) {
  const labelActions = {
    [LabelAction.None]: {
      labelAction: LabelAction.None,
      issueNumber: issue_number,
    },
    [LabelAction.Add]: {
      labelAction: LabelAction.Add,
      issueNumber: issue_number,
    },
    [LabelAction.Remove]: {
      labelAction: LabelAction.Remove,
      issueNumber: issue_number,
    },
  };

  const workflowRuns = await github.paginate(
    github.rest.actions.listWorkflowRunsForRepo,
    {
      owner,
      repo,
      event: "pull_request",
      head_sha,
      per_page: PER_PAGE_MAX,
    },
  );

  core.info("Workflow Runs:");
  workflowRuns.forEach((wf) => {
    core.info(`- ${wf.name}: ${wf.conclusion || wf.status}`);
  });

  const wfName = "ARM Incremental TypeSpec (Preview)";
  const incrementalTspRuns = workflowRuns.filter((wf) => wf.name == wfName);

  if (incrementalTspRuns.length == 0) {
    core.info(
      `Found no runs for workflow '${wfName}'.  Assuming workflow trigger was skipped, which should be treated equal to "completed false".`,
    );
    return labelActions[LabelAction.Remove];
  } else if (incrementalTspRuns.length > 1) {
    throw `Unexpected number of runs for workflow '${wfName}': ${incrementalTspRuns.length}`;
  } else {
    const run = incrementalTspRuns[0];

    if (run.status == "completed") {
      if (run.conclusion != "success") {
        core.info(
          `Run for workflow '${wfName}' did not succeed: '${run.conclusion}'`,
        );
        return labelActions[LabelAction.Remove];
      }

      const artifacts = await github.paginate(
        github.rest.actions.listWorkflowRunArtifacts,
        {
          owner,
          repo,
          run_id: run.id,
          per_page: PER_PAGE_MAX,
        },
      );
      const artifactNames = artifacts.map((a) => a.name);

      core.info(`artifactNames: ${JSON.stringify(artifactNames)}`);

      if (artifactNames.includes("incremental-typespec=false")) {
        core.info(
          "Spec is not an incremental change to an existing TypeSpec RP",
        );
        return labelActions[LabelAction.Remove];
      } else if (artifactNames.includes("incremental-typespec=true")) {
        core.info("Spec is an incremental change to an existing TypeSpec RP");
        // Continue checking other requirements
      } else {
        // If workflow succeeded, it should have one workflow or the other
        throw `Workflow artifacts did not contain 'incremental-typespec': ${JSON.stringify(artifactNames)}`;
      }
    } else {
      core.info(
        `Workflow '${wfName}' is still in-progress: status='${run.status}'`,
      );
      return labelActions[LabelAction.None];
    }
  }

  // TODO: Try to extract labels from context (when available) to avoid unnecessary API call
  const labels = await github.paginate(github.rest.issues.listLabelsOnIssue, {
    owner: owner,
    repo: repo,
    issue_number: issue_number,
    per_page: PER_PAGE_MAX,
  });
  const labelNames = labels.map((label) => label.name);

  core.info(`Labels: ${labelNames}`);

  // TODO: Also require label "ARMBestPracticesAcknowledgement"
  const allLabelsMatch =
    labelNames.includes("ARMReview") &&
    !labelNames.includes("NotReadyForARMReview") &&
    (!labelNames.includes("SuppressionReviewRequired") ||
      labelNames.includes("Approved-Suppression"));

  if (!allLabelsMatch) {
    core.info("Labels do not meet requirement for auto-signoff");
    return labelActions[LabelAction.Remove];
  }

  const checkRuns = await github.paginate(github.rest.checks.listForRef, {
    owner: owner,
    repo: repo,
    ref: head_sha,
    per_page: PER_PAGE_MAX,
  });

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
      return labelActions[LabelAction.Add];
    } else {
      core.info("Swagger LintDiff did not succeed");
      return labelActions[LabelAction.Remove];
    }
  } else {
    // No-op if check is missing or not completed, to prevent frequent remove/add label as checks re-run
    core.info("Swagger LintDiff is in-progress");
    return labelActions[LabelAction.None];
  }
}
