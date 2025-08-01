// @ts-check

import { REVIEW_REQUIRED_LABELS } from "../../shared/src/breaking-change.js";
import { PER_PAGE_MAX } from "../../shared/src/github.js";
import { extractInputs } from "./context.js";

/* v8 ignore start */
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
    .filter((wf) => wf.name === "[TEST-IGNORE] Swagger BreakingChange - Analyze Code")
    // Sort by "updated_at" descending
    .sort((a, b) => new Date(b.updated_at).getTime() - new Date(a.updated_at).getTime())[0];

  const latestCrossVersionBreakingChangesRun = workflowRuns
    .filter((wf) => wf.name === "[TEST-IGNORE] Breaking Change(Cross-Version) - Analyze Code")
    // Sort by "updated_at" descending
    .sort((a, b) => new Date(b.updated_at).getTime() - new Date(a.updated_at).getTime())[0];

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

  core.info(`breaking change workflow run: ${latestBreakingChangesRun.url}`);
  core.info(
    `cross-version breaking change workflow run: ${latestCrossVersionBreakingChangesRun.url}`,
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

  core.setOutput("breakingChangeReviewLabelName", REVIEW_REQUIRED_LABELS.BREAKING_CHANGE);
  core.setOutput("breakingChangeReviewLabelValue", breakingChangeReviewLabelValue);
  core.setOutput("versioningReviewLabelName", REVIEW_REQUIRED_LABELS.VERSIONING);
  core.setOutput("versioningReviewLabelValue", versioningReviewLabelValue);
}
