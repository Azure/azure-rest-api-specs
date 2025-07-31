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
    .filter((wf) => wf.name === "Swagger BreakingChange - Analyze Code")
    // Sort by "updated_at" descending
    .sort((a, b) => new Date(b.updated_at).getTime() - new Date(a.updated_at).getTime())[0];

  const latestCrossVersionBreakingChangesRun = workflowRuns
    .filter((wf) => wf.name === "Breaking Change(Cross-Version) - Analyze Code")
    // Sort by "updated_at" descending
    .sort((a, b) => new Date(b.updated_at).getTime() - new Date(a.updated_at).getTime())[0];

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

  // TODO: What if artifacts disagree?
  core.setOutput("breakingChangeReviewLabelName", REVIEW_REQUIRED_LABELS.BREAKING_CHANGE);
  if (
    breakingChangesArtifactNames.includes(`${REVIEW_REQUIRED_LABELS.BREAKING_CHANGE}=true`) &&
    crossVersionBreakingChangesArtifactNames.includes(
      `${REVIEW_REQUIRED_LABELS.BREAKING_CHANGE}=true`,
    )
  ) {
    core.setOutput("breakingChangeReviewLabelValue", true);
  } else {
    core.setOutput("breakingChangeReviewLabelValue", false);
  }

  // TODO: What if artifacts disagree?
  core.setOutput("versioningReviewLabelName", REVIEW_REQUIRED_LABELS.VERSIONING);
  if (
    breakingChangesArtifactNames.includes(`${REVIEW_REQUIRED_LABELS.VERSIONING}=true`) &&
    crossVersionBreakingChangesArtifactNames.includes(`${REVIEW_REQUIRED_LABELS.VERSIONING}=true`)
  ) {
    core.setOutput("versioningReviewLabelValue", true);
  } else {
    core.setOutput("versioningReviewLabelValue", false);
  }
}
