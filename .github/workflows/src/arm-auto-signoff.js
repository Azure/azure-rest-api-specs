import { CommitStatusState, PER_PAGE_MAX } from "../../shared/src/github.js";
import { equals } from "../../shared/src/set.js";
import { byDate, invert } from "../../shared/src/sort.js";
import { extractInputs } from "./context.js";

// TODO: Add tests
/* v8 ignore start */
/**
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<{headSha: string, issueNumber: number, autoSignOffLabels?: string[]}>}
 */
export default async function getLabelAction({ github, context, core }) {
  const { owner, repo, issue_number, head_sha } = await extractInputs(github, context, core);

  return await getLabelActionImpl({
    owner,
    repo,
    issue_number,
    head_sha,
    github,
    core,
  });
}
/* v8 ignore stop */

/**
 * @param {Object} params
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {number} params.issue_number
 * @param {string} params.head_sha
 * @param {(import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api & { paginate: import("@octokit/plugin-paginate-rest").PaginateInterface; })} params.github
 * @param {typeof import("@actions/core")} params.core
 * @returns {Promise<{headSha: string, issueNumber: number, autoSignOffLabels?: string[]}>}
 */
export async function getLabelActionImpl({ owner, repo, issue_number, head_sha, github, core }) {
  // TODO: Try to extract labels from context (when available) to avoid unnecessary API call
  // permissions: { issues: read, pull-requests: read }
  const labels = await github.paginate(github.rest.issues.listLabelsOnIssue, {
    owner: owner,
    repo: repo,
    issue_number: issue_number,
    per_page: PER_PAGE_MAX,
  });
  const labelNames = labels.map((label) => label.name);

  // Check if any auto sign-off labels are currently present
  // Only proceed with auto sign-off logic if auto labels exist or we're about to add them
  const hasAutoSignedOffLabels = labelNames.some(name => 
    name === "ARMAutoSignedOff-Trivial" || 
    name === "ARMAutoSignedOff-IncrementalTSP"
  );

  core.info(`Labels: ${labelNames}`);
  core.info(`Has auto signed-off labels: ${hasAutoSignedOffLabels}`);

  // permissions: { actions: read }
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

  // Check ARM Incremental TypeSpec workflow (which now includes trivial changes)
  const armAnalysisResult = await checkArmAnalysisWorkflow(workflowRuns, github, owner, repo, core);

  // If workflow indicates auto-signoff should not be applied
  if (!armAnalysisResult.shouldAutoSign) {
    return {
      headSha: head_sha,
      issueNumber: issue_number,
      autoSignOffLabels: hasAutoSignedOffLabels ? [] : undefined, // Only remove if we had auto labels before
    };
  }

  // Store the labels for auto sign-off
  const autoSignOffLabels = armAnalysisResult.labelsToAdd || [];

  const allLabelsMatch =
    labelNames.includes("ARMReview") &&
    !labelNames.includes("NotReadyForARMReview") &&
    (!labelNames.includes("SuppressionReviewRequired") ||
      labelNames.includes("Approved-Suppression"));

  if (!allLabelsMatch) {
    core.info("Labels do not meet requirement for auto-signoff");
    return {
      headSha: head_sha,
      issueNumber: issue_number,
      autoSignOffLabels: hasAutoSignedOffLabels ? [] : undefined, // Only remove if we had auto labels before
    };
  }

  // permissions: { statuses: read }
  const statuses = await github.paginate(github.rest.repos.listCommitStatusesForRef, {
    owner: owner,
    repo: repo,
    ref: head_sha,
    per_page: PER_PAGE_MAX,
  });

  core.info("Statuses:");
  statuses.forEach((status) => {
    core.info(`- ${status.context}: ${status.state}`);
  });

  const requiredStatusNames = ["Swagger LintDiff", "Swagger Avocado"];

  /**
   * @type {typeof statuses}
   */
  let requiredStatuses = [];

  for (const statusName of requiredStatusNames) {
    // The "statuses" array may contain multiple statuses with the same "context" (aka "name"),
    // but different states and update times. We only care about the latest.
    const matchingStatuses = statuses
      .filter((status) => status.context.toLowerCase() === statusName.toLowerCase())
      .sort(invert(byDate((status) => status.updated_at)));

    // undefined if matchingStatuses.length === 0 (which is OK)
    const matchingStatus = matchingStatuses[0];

    core.info(`${statusName}: State='${matchingStatus?.state}'`);

    if (
      matchingStatus &&
      (matchingStatus.state === CommitStatusState.ERROR ||
        matchingStatus.state === CommitStatusState.FAILURE)
    ) {
      core.info(`Status '${matchingStatus}' did not succeed`);
      return {
        headSha: head_sha,
        issueNumber: issue_number,
        autoSignOffLabels: hasAutoSignedOffLabels ? [] : undefined, // Only remove if we had auto labels before
      };
    }

    if (matchingStatus) {
      requiredStatuses.push(matchingStatus);
    }
  }

  if (
    equals(
      new Set(requiredStatuses.map((status) => status.context)),
      new Set(requiredStatusNames),
    ) &&
    requiredStatuses.every((status) => status.state === CommitStatusState.SUCCESS)
  ) {
    core.info("All requirements met for auto-signoff");
    return {
      headSha: head_sha,
      issueNumber: issue_number,
      autoSignOffLabels: autoSignOffLabels,
    };
  }

  // If any statuses are missing or pending, return empty labels only if we had auto labels before
  // This prevents removing manually-added ARMSignedOff labels
  core.info("One or more statuses are still pending");
  return {
    headSha: head_sha,
    issueNumber: issue_number,
    autoSignOffLabels: hasAutoSignedOffLabels ? [] : undefined, // undefined means don't touch labels
  };
}

/**
 * Check ARM Analysis workflow results (combines incremental TypeSpec and trivial changes)
 * @param {Array} workflowRuns - Array of workflow runs
 * @param {Object} github - GitHub client
 * @param {string} owner - Repository owner
 * @param {string} repo - Repository name  
 * @param {Object} core - Core logger
 * @returns {Promise<{shouldAutoSign: boolean, reason: string, labelsToAdd?: string[]}>}
 */
async function checkArmAnalysisWorkflow(workflowRuns, github, owner, repo, core) {
  const wfName = "ARM Auto-SignOff Analysis";
  const armAnalysisRuns = workflowRuns
    .filter((wf) => wf.name == wfName)
    // Sort by "updated_at" descending
    .sort((a, b) => new Date(b.updated_at).getTime() - new Date(a.updated_at).getTime());

  if (armAnalysisRuns.length == 0) {
    core.info(
      `Found no runs for workflow '${wfName}'.  Assuming workflow trigger was skipped, which should be treated equal to "completed false".`,
    );
    return { shouldAutoSign: false, reason: "No ARM analysis workflow runs found" };
  }

  // Sorted by "updated_at" descending, so most recent run is at index 0
  const run = armAnalysisRuns[0];

  if (run.status != "completed") {
    core.info(`Workflow '${wfName}' is still in-progress: status='${run.status}'`);
    return { shouldAutoSign: false, reason: "ARM analysis workflow still in progress" };
  }

  if (run.conclusion != "success") {
    core.info(`Run for workflow '${wfName}' did not succeed: '${run.conclusion}'`);
    return { shouldAutoSign: false, reason: "ARM analysis workflow failed" };
  }

  // permissions: { actions: read }
  const artifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
    owner,
    repo,
    run_id: run.id,
    per_page: PER_PAGE_MAX,
  });
  const artifactNames = artifacts.map((a) => a.name);

  core.info(`${wfName} artifactNames: ${JSON.stringify(artifactNames)}`);

  // check for new combined artifact
  const combinedArtifact = artifactNames.find(name => name.startsWith("arm-analysis-results="));
  if (combinedArtifact) {
    try {
      const resultsJson = combinedArtifact.substring("arm-analysis-results=".length);
      const results = JSON.parse(resultsJson);
      
      core.info(`Combined ARM analysis results: ${JSON.stringify(results)}`);
      
      if (results.qualifiesForAutoSignOff) {
        const labelsToAdd = [];
        
        if (results.incrementalTypeSpec) {
          labelsToAdd.push("ARMAutoSignedOff-IncrementalTSP");
        }
        if (results.trivialChanges?.anyTrivialChanges) {
          labelsToAdd.push("ARMAutoSignedOff-Trivial");
        }
        
        const reason = labelsToAdd.join(", ");
        core.info(`PR qualifies for auto sign-off: ${reason}`);
        return { shouldAutoSign: true, reason: reason, labelsToAdd: labelsToAdd };
      } else {
        core.info("PR does not qualify for auto sign-off based on ARM analysis");
        return { shouldAutoSign: false, reason: "No qualifying changes detected" };
      }
    } catch (error) {
      core.warning(`Failed to parse combined ARM analysis results: ${error.message}`);
      // Fall back to legacy artifact checking
    }
  }
}
