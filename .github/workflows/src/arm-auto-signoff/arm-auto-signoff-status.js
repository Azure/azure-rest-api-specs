import { inspect } from "util";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.js";
import { equals } from "../../../shared/src/set.js";
import { byDate, invert } from "../../../shared/src/sort.js";
import { extractInputs } from "../context.js";
import { LabelAction } from "../label.js";
import { ArmAutoSignoffLabel } from "./arm-auto-signoff-labels.js";

/** @typedef {import('@octokit/plugin-rest-endpoint-methods').RestEndpointMethodTypes} RestEndpointMethodTypes */
/** @typedef {RestEndpointMethodTypes["issues"]["listLabelsOnIssue"]["response"]["data"][number]} IssueLabel */
/** @typedef {RestEndpointMethodTypes["actions"]["listWorkflowRunsForRepo"]["response"]["data"]["workflow_runs"][number]} WorkflowRun */
/** @typedef {RestEndpointMethodTypes["repos"]["listCommitStatusesForRef"]["response"]["data"][number]} CommitStatus */
/** @typedef {RestEndpointMethodTypes["actions"]["listWorkflowRunArtifacts"]["response"]["data"]["artifacts"][number]} Artifact */

/**
 * The workflow contract is intentionally a fixed set of keys.
 * @typedef {{
 *   "ARMSignedOff": LabelAction,
 *   "ARMAutoSignedOff-IncrementalTSP": LabelAction,
 *   "ARMAutoSignedOff-Trivial-Test": LabelAction,
 * }} ManagedLabelActions
 */

/** @returns {ManagedLabelActions} */
function createNoneLabelActions() {
  return {
    [ArmAutoSignoffLabel.ArmSignedOff]: LabelAction.None,
    [ArmAutoSignoffLabel.ArmAutoSignedOffIncrementalTSP]: LabelAction.None,
    [ArmAutoSignoffLabel.ArmAutoSignedOffTrivialTest]: LabelAction.None,
  };
}

/**
 * The analyze-code workflow uploads empty artifacts named `${name}=${value}`.
 * We treat missing artifacts or non-boolean values as a failure (no auto-signoff).
 *
 * @param {string[]} artifactNames
 * @param {string} key
 * @returns {boolean | null}
 */
function readBooleanArtifactValue(artifactNames, key) {
  const prefix = `${key}=`;
  const match = artifactNames.find((name) => name.startsWith(prefix));
  if (!match) {
    return null;
  }

  const value = match.substring(prefix.length).trim().toLowerCase();
  return value === "true" ? true : value === "false" ? false : null;
}

// TODO: Add tests
/* v8 ignore start */
/**
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<{headSha: string, issueNumber: number, labelActions: ManagedLabelActions}>}
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
 * @returns {Promise<{headSha: string, issueNumber: number, labelActions: ManagedLabelActions}>}
 */
export async function getLabelActionImpl({ owner, repo, issue_number, head_sha, github, core }) {
  /** @type {{headSha: string, issueNumber: number}} */
  const baseResult = {
    headSha: head_sha,
    issueNumber: issue_number,
  };

  const noneLabelActions = createNoneLabelActions();

  // TODO: Try to extract labels from context (when available) to avoid unnecessary API call
  // permissions: { issues: read, pull-requests: read }
  /** @type {IssueLabel[]} */
  const labels = await github.paginate(github.rest.issues.listLabelsOnIssue, {
    owner: owner,
    repo: repo,
    issue_number: issue_number,
    per_page: PER_PAGE_MAX,
  });
  const labelNames = labels.map((label) => label.name);

  // Check if any auto sign-off labels are currently present
  // Only proceed with auto sign-off logic if auto labels exist or we're about to add them
  const hasAutoSignedOffLabels =
    labelNames.includes(ArmAutoSignoffLabel.ArmAutoSignedOff) ||
    labelNames.includes(ArmAutoSignoffLabel.ArmAutoSignedOffIncrementalTSP) ||
    labelNames.includes(ArmAutoSignoffLabel.ArmAutoSignedOffTrivialTest);
  core.info(`Labels: ${inspect(labelNames)}`);
  core.info(`Has auto signed-off labels: ${hasAutoSignedOffLabels}`);

  // permissions: { actions: read }
  /** @type {WorkflowRun[]} */
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

  // Check ARM Auto SignOff - Analyze Code workflow results
  const armAnalysisResult = await checkArmAnalysisWorkflow(workflowRuns, github, owner, repo, core);

  const noneResult = {
    ...baseResult,
    labelActions: noneLabelActions,
  };

  const removeAutoSignedOffLabelsIfPresent = () => {
    if (!hasAutoSignedOffLabels) {
      return noneResult;
    }

    return {
      ...noneResult,
      labelActions: {
        ...noneLabelActions,
        [ArmAutoSignoffLabel.ArmSignedOff]: LabelAction.Remove,
        [ArmAutoSignoffLabel.ArmAutoSignedOffIncrementalTSP]: LabelAction.Remove,
        [ArmAutoSignoffLabel.ArmAutoSignedOffTrivialTest]: LabelAction.Remove,
      },
    };
  };

  // If workflow indicates auto-signoff should not be applied
  if (!armAnalysisResult.qualifiesForAutoSignoff) {
    return removeAutoSignedOffLabelsIfPresent();
  }

  const allLabelsMatch =
    labelNames.includes("ARMReview") &&
    !labelNames.includes("NotReadyForARMReview") &&
    (!labelNames.includes("SuppressionReviewRequired") ||
      labelNames.includes("Approved-Suppression"));

  if (!allLabelsMatch) {
    core.info("Labels do not meet requirement for auto-signoff");
    return removeAutoSignedOffLabelsIfPresent();
  }

  // permissions: { statuses: read }
  /** @type {CommitStatus[]} */
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

  /** @type {CommitStatus[]} */
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
      core.info(`Status '${matchingStatus.context}' did not succeed`);
      return removeAutoSignedOffLabelsIfPresent();
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
    const autoIncrementalTSP = armAnalysisResult.incrementalTypeSpec;
    const autoTrivialTest = armAnalysisResult.isTrivial;

    // Add ARMSignOff label only when the PR is identified as an incremental typespec
    // As the trivial changes sign-off is being released in test mode
    const armSignOffAction = autoIncrementalTSP
      ? LabelAction.Add
      : hasAutoSignedOffLabels
        ? LabelAction.Remove
        : LabelAction.None;
    const autoIncrementalTSPAction = autoIncrementalTSP ? LabelAction.Add : LabelAction.Remove;
    const testTrivialAction = autoTrivialTest ? LabelAction.Add : LabelAction.Remove;

    // Keep labels in sync with current analysis results.
    // When a label is not desired, emit Remove so it gets cleaned up if previously set.
    return {
      ...baseResult,
      labelActions: {
        ...noneLabelActions,
        [ArmAutoSignoffLabel.ArmSignedOff]: armSignOffAction,
        [ArmAutoSignoffLabel.ArmAutoSignedOffIncrementalTSP]: autoIncrementalTSPAction,
        [ArmAutoSignoffLabel.ArmAutoSignedOffTrivialTest]: testTrivialAction,
      },
    };
  }

  // If any statuses are missing or pending, no-op to prevent frequent remove/add label as checks re-run
  core.info("One or more statuses are still pending");
  return noneResult;
}

/**
 * Check ARM Analysis workflow results (combines incremental TypeSpec and trivial changes).
 *
 * @param {WorkflowRun[]} workflowRuns
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {string} owner
 * @param {string} repo
 * @param {import('@actions/github-script').AsyncFunctionArguments['core']} core
 * @returns {Promise<{qualifiesForAutoSignoff: boolean, incrementalTypeSpec: boolean, isTrivial: boolean}>}
 */
async function checkArmAnalysisWorkflow(workflowRuns, github, owner, repo, core) {
  const wfName = "ARM Auto SignOff - Analyze Code";
  const armAnalysisRuns = workflowRuns
    .filter((wf) => wf.name == wfName)
    // Sort by "updated_at" descending
    .sort((a, b) => new Date(b.updated_at).getTime() - new Date(a.updated_at).getTime());

  if (armAnalysisRuns.length == 0) {
    core.info(
      `Found no runs for workflow '${wfName}'.  Assuming workflow trigger was skipped, which should be treated equal to "completed false".`,
    );
    return {
      qualifiesForAutoSignoff: false,
      incrementalTypeSpec: false,
      isTrivial: false,
    };
  }

  // Sorted by "updated_at" descending, so most recent run is at index 0
  const run = armAnalysisRuns[0];

  if (run.status != "completed") {
    core.info(`Workflow '${wfName}' is still in-progress: status='${run.status}'`);
    return {
      qualifiesForAutoSignoff: false,
      incrementalTypeSpec: false,
      isTrivial: false,
    };
  }

  if (run.conclusion != "success") {
    core.info(`Run for workflow '${wfName}' did not succeed: '${run.conclusion}'`);
    return {
      qualifiesForAutoSignoff: false,
      incrementalTypeSpec: false,
      isTrivial: false,
    };
  }

  // permissions: { actions: read }
  /** @type {Artifact[]} */
  const artifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
    owner,
    repo,
    run_id: run.id,
    per_page: PER_PAGE_MAX,
  });

  /** @type {string[]} */
  const artifactNames = artifacts.map((a) => a.name);
  core.info(`${wfName} artifactNames: ${JSON.stringify(artifactNames)}`);

  const incrementalTypeSpec = readBooleanArtifactValue(artifactNames, "incremental-typespec");
  const isTrivial = readBooleanArtifactValue(artifactNames, "trivial-changes");

  // ARM-Auto-SignOff-Code uploads 2 distinct artifacts.
  // If either artifact is missing (or invalid), fail closed: no auto-signoff.
  if (incrementalTypeSpec === null || isTrivial === null) {
    const missing = [
      incrementalTypeSpec === null ? "incremental-typespec" : null,
      isTrivial === null ? "trivial-changes" : null,
    ]
      .filter(Boolean)
      .join(", ");

    core.info(`Missing/invalid ARM analysis artifact(s): ${missing}`);
    return {
      qualifiesForAutoSignoff: false,
      incrementalTypeSpec: false,
      isTrivial: false,
    };
  }

  core.info(
    `ARM analysis results: incrementalTypeSpec=${incrementalTypeSpec}, isTrivial=${isTrivial}`,
  );

  const qualifiesForAutoSignoff = incrementalTypeSpec || isTrivial;
  if (!qualifiesForAutoSignoff) {
    core.info("PR does not qualify for auto sign-off based on ARM analysis");
    return {
      qualifiesForAutoSignoff: false,
      incrementalTypeSpec: false,
      isTrivial: false,
    };
  }

  core.info(`PR qualifies for auto sign-off based on ARM analysis.`);
  return {
    qualifiesForAutoSignoff: true,
    incrementalTypeSpec: incrementalTypeSpec,
    isTrivial: isTrivial,
  };
}
