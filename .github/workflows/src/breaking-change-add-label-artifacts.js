// @ts-check

import { REVIEW_REQUIRED_LABELS } from "../../shared/src/breaking-change.js";
import { PER_PAGE_MAX } from "../../shared/src/github.js";
import { byDate, invert } from "../../shared/src/sort.js";
import { extractInputs } from "./context.js";

export const SWAGGER_BREAKING_CHANGE_WORKFLOW_NAME = "Swagger BreakingChange - Analyze Code";
export const CROSS_VERSION_BREAKING_CHANGE_WORKFLOW_NAME =
  "Breaking Change(Cross-Version) - Analyze Code";

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export default async function getLabelActions({ github, context, core }) {
  const { owner, repo, head_sha, issue_number } = await extractInputs(github, context, core);
  const workflowRuns = await github.paginate(github.rest.actions.listWorkflowRunsForRepo, {
    owner,
    repo,
    event: "pull_request",
    head_sha,
    per_page: PER_PAGE_MAX,
  });

  core.info("Workflow Runs:");
  workflowRuns.forEach((wf) => {
    core.info(`- ${wf.name}: ${wf.conclusion || wf.status}`);
  });

  const latestBreakingChangesRun = workflowRuns
    .filter((wf) => wf.name === SWAGGER_BREAKING_CHANGE_WORKFLOW_NAME)
    // Sort by "updated_at" descending
    .sort(invert(byDate((wf) => wf.updated_at)))[0];

  const latestCrossVersionBreakingChangesRun = workflowRuns
    .filter((wf) => wf.name === CROSS_VERSION_BREAKING_CHANGE_WORKFLOW_NAME)
    // Sort by "updated_at" descending
    .sort(invert(byDate((wf) => wf.updated_at)))[0];

  // Add null checks before accessing artifacts
  if (!latestBreakingChangesRun || latestBreakingChangesRun.status !== "completed") {
    core.info("No completed breaking changes workflow run found");
    return;
  }

  if (
    !latestCrossVersionBreakingChangesRun ||
    latestCrossVersionBreakingChangesRun.status !== "completed"
  ) {
    core.info("No completed cross-version breaking changes workflow run found");
    return;
  }

  core.info(`breaking change workflow run: ${latestBreakingChangesRun.html_url}`);
  core.info(
    `cross-version breaking change workflow run: ${latestCrossVersionBreakingChangesRun.html_url}`,
  );
  const breakingChangesArtifactNames = (
    await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
      owner: owner,
      repo: repo,
      run_id: latestBreakingChangesRun.id,
      per_page: PER_PAGE_MAX,
    })
  ).map((a) => a.name);

  const crossVersionBreakingChangesArtifactNames = (
    await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
      owner: owner,
      repo: repo,
      run_id: latestCrossVersionBreakingChangesRun.id,
      per_page: PER_PAGE_MAX,
    })
  ).map((a) => a.name);

  core.setOutput("issue_number", issue_number);

  if (
    breakingChangesArtifactNames.length === 0 &&
    crossVersionBreakingChangesArtifactNames.length === 0
  ) {
    core.info("No artifacts found for breaking changes or cross-version breaking changes");
    return;
  }
  const breakingChangeKey = `${REVIEW_REQUIRED_LABELS.BREAKING_CHANGE}=true`;
  const versioningKey = `${REVIEW_REQUIRED_LABELS.VERSIONING}=true`;

  // Check for labels in both artifact collections
  const hasBreakingChangeReviewLabel =
    breakingChangesArtifactNames.includes(breakingChangeKey) ||
    crossVersionBreakingChangesArtifactNames.includes(breakingChangeKey);

  const hasVersioningReviewLabel =
    breakingChangesArtifactNames.includes(versioningKey) ||
    crossVersionBreakingChangesArtifactNames.includes(versioningKey);

  // Apply precedence rule: breaking change takes precedence over versioning, only one label should be added
  const breakingChangeReviewLabelValue = hasBreakingChangeReviewLabel;
  const versioningReviewLabelValue = hasVersioningReviewLabel && !hasBreakingChangeReviewLabel;
  core.info(`${REVIEW_REQUIRED_LABELS.BREAKING_CHANGE}: ${breakingChangeReviewLabelValue}`);
  core.info(`${REVIEW_REQUIRED_LABELS.VERSIONING}: ${versioningReviewLabelValue}`);
  core.setOutput("breakingChangeReviewLabelName", REVIEW_REQUIRED_LABELS.BREAKING_CHANGE);
  core.setOutput("breakingChangeReviewLabelValue", breakingChangeReviewLabelValue);
  core.setOutput("versioningReviewLabelName", REVIEW_REQUIRED_LABELS.VERSIONING);
  core.setOutput("versioningReviewLabelValue", versioningReviewLabelValue);
}
