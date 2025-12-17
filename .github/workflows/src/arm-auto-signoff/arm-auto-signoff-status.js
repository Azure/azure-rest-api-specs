import { inspect } from "util";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.js";
import { equals } from "../../../shared/src/set.js";
import { byDate, invert } from "../../../shared/src/sort.js";
import { extractInputs } from "../context.js";
import { LabelAction } from "../label.js";

const LABEL_ARM_SIGNED_OFF = "ARMSignedOff";
const LABEL_ARM_AUTO_SIGNED_OFF = "ARMAutoSignedOff";
const LABEL_AUTO_SIGNED_OFF_INCREMENTAL_TSP = "ARMAutoSignedOff-IncrementalTSP";
const LABEL_AUTO_SIGNED_OFF_TRIVIAL_TEST = "ARMAutoSignedOff-Trivial-Test";

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
    [LABEL_ARM_SIGNED_OFF]: LabelAction.None,
    [LABEL_AUTO_SIGNED_OFF_INCREMENTAL_TSP]: LabelAction.None,
    [LABEL_AUTO_SIGNED_OFF_TRIVIAL_TEST]: LabelAction.None,
  };
}

/** @typedef {{ name: string }} IssueLabel */

/**
 * Minimal subset of workflow run fields used by this workflow.
 * @typedef {{
 *   id: number,
 *   name: string,
 *   status: string,
 *   conclusion: string | null,
 *   updated_at: string,
 * }} WorkflowRun
 */

/**
 * Minimal subset of commit status fields used by this workflow.
 * @typedef {{
 *   context: string,
 *   state: string,
 *   updated_at: string,
 * }} CommitStatus
 */

/** @typedef {{ name: string }} Artifact */

/**
 * @param {string} artifactName
 * @returns {{ incrementalTypeSpec: boolean, isTrivial: boolean, qualifiesForAutoSignoff: boolean } | null}
 */
function parseArmAnalysisArtifact(artifactName) {
  const prefix = "arm-auto-signoff-code-results=";
  if (!artifactName.startsWith(prefix)) {
    return null;
  }

  const value = artifactName.substring(prefix.length);

  // Parse key-value format: incrementalTypeSpec-true,isTrivial-false,qualifies-true
  // Split by comma, then parse each key-value pair.
  /** @type {Record<string, string>} */
  const pairs = Object.fromEntries(
    value
      .split(",")
      .map((p) => p.trim())
      .filter(Boolean)
      .map((p) => {
        const lastDash = p.lastIndexOf("-");
        if (lastDash === -1) {
          return [p, ""]; // will be treated as false
        }
        return [p.substring(0, lastDash), p.substring(lastDash + 1)];
      }),
  );

  return {
    incrementalTypeSpec: pairs.incrementalTypeSpec === "true",
    isTrivial: pairs.isTrivial === "true",
    qualifiesForAutoSignoff: pairs.qualifies === "true",
  };
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
  // TODO: Try to extract labels from context (when available) to avoid unnecessary API call
  // permissions: { issues: read, pull-requests: read }
  const labels = /** @type {IssueLabel[]} */ (
    await github.paginate(github.rest.issues.listLabelsOnIssue, {
      owner: owner,
      repo: repo,
      issue_number: issue_number,
      per_page: PER_PAGE_MAX,
    })
  );
  const labelNames = labels.map((label) => label.name);

  /** @type {{headSha: string, issueNumber: number}} */
  const baseResult = {
    headSha: head_sha,
    issueNumber: issue_number,
  };

  const labelActions = createNoneLabelActions();

  // Check if any auto sign-off labels are currently present
  // Only proceed with auto sign-off logic if auto labels exist or we're about to add them
  const hasAutoSignedOffLabels =
    labelNames.includes(LABEL_ARM_AUTO_SIGNED_OFF) ||
    labelNames.includes(LABEL_AUTO_SIGNED_OFF_INCREMENTAL_TSP);

  core.info(`Labels: ${inspect(labelNames)}`);
  core.info(`Has auto signed-off labels: ${hasAutoSignedOffLabels}`);

  // permissions: { actions: read }
  const workflowRuns = /** @type {WorkflowRun[]} */ (
    await github.paginate(github.rest.actions.listWorkflowRunsForRepo, {
      owner,
      repo,
      event: "pull_request",
      head_sha,
      per_page: PER_PAGE_MAX,
    })
  );

  core.info("Workflow Runs:");
  workflowRuns.forEach((wf) => {
    core.info(`- ${wf.name}: ${wf.conclusion || wf.status}`);
  });

  // Check ARM Auto SignOff - Analyze Code workflow results
  const armAnalysisResult = await checkArmAnalysisWorkflow(workflowRuns, github, owner, repo, core);

  const noneResult = {
    ...baseResult,
    labelActions,
  };

  const removeAutoSignedOffLabelsIfPresent = () => {
    if (!hasAutoSignedOffLabels) {
      return noneResult;
    }

    return {
      ...noneResult,
      labelActions: {
        ...labelActions,
        [LABEL_ARM_SIGNED_OFF]: LabelAction.Remove,
        [LABEL_AUTO_SIGNED_OFF_INCREMENTAL_TSP]: LabelAction.Remove,
        [LABEL_AUTO_SIGNED_OFF_TRIVIAL_TEST]: LabelAction.Remove,
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
  const statuses = /** @type {CommitStatus[]} */ (
    await github.paginate(github.rest.repos.listCommitStatusesForRef, {
      owner: owner,
      repo: repo,
      ref: head_sha,
      per_page: PER_PAGE_MAX,
    })
  );

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

    const autoIncremental = armAnalysisResult.incrementalTypeSpec;
    const autoTrivialTest = armAnalysisResult.isTrivial;

    // Add ARMAutoSignOff label only when the PR is identified as an incremental typespec
    // As the trivial changes sign-off is being released in test mode
    const autoSignOffAction = autoIncremental
      ? LabelAction.Add
      : hasAutoSignedOffLabels
        ? LabelAction.Remove
        : LabelAction.None;
    const autoIncrementalAction = autoIncremental ? LabelAction.Add : LabelAction.Remove;
    const testTrivialAction = autoTrivialTest ? LabelAction.Add : LabelAction.Remove;

    // Keep labels in sync with current analysis results.
    // When a label is not desired, emit Remove so it gets cleaned up if previously set.
    return {
      ...baseResult,
      labelActions: {
        ...labelActions,
        [LABEL_ARM_SIGNED_OFF]: autoSignOffAction,
        [LABEL_AUTO_SIGNED_OFF_INCREMENTAL_TSP]: autoIncrementalAction,
        [LABEL_AUTO_SIGNED_OFF_TRIVIAL_TEST]: testTrivialAction,
      },
    };
  }

  // If any statuses are missing or pending, return empty labels only if we had auto labels before
  // This prevents removing manually-added ARMSignedOff labels
  core.info("One or more statuses are still pending");
  return removeAutoSignedOffLabelsIfPresent();
}

/**
 * Check ARM Analysis workflow results (combines incremental TypeSpec and trivial changes).
 *
 * @param {WorkflowRun[]} workflowRuns
 * @param {(import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api & { paginate: import("@octokit/plugin-paginate-rest").PaginateInterface; })} github
 * @param {string} owner
 * @param {string} repo
 * @param {typeof import("@actions/core")} core
 * @returns {Promise<{qualifiesForAutoSignoff: boolean, incrementalTypeSpec: boolean, isTrivial: boolean, reason: string}>}
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
      reason: `No '${wfName}' workflow runs found`,
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
      reason: `'${wfName}' workflow still in progress`,
    };
  }

  if (run.conclusion != "success") {
    core.info(`Run for workflow '${wfName}' did not succeed: '${run.conclusion}'`);
    return {
      qualifiesForAutoSignoff: false,
      incrementalTypeSpec: false,
      isTrivial: false,
      reason: `'${wfName}' workflow failed`,
    };
  }

  // permissions: { actions: read }
  const artifacts = /** @type {Artifact[]} */ (
    await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
      owner,
      repo,
      run_id: run.id,
      per_page: PER_PAGE_MAX,
    })
  );
  /** @type {string[]} */
  const artifactNames = artifacts.map((a) => a.name);

  core.info(`${wfName} artifactNames: ${JSON.stringify(artifactNames)}`);

  /** @type {{ incrementalTypeSpec: boolean, isTrivial: boolean, qualifiesForAutoSignoff: boolean } | null} */
  const parsed = artifactNames.map(parseArmAnalysisArtifact).find((r) => r !== null) ?? null;

  if (parsed) {
    const { incrementalTypeSpec, isTrivial, qualifiesForAutoSignoff } = parsed;

    core.info(
      `ARM analysis results: incrementalTypeSpec=${incrementalTypeSpec}, isTrivial=${isTrivial}, qualifiesForAutoSignoff=${qualifiesForAutoSignoff}`,
    );

    if (!qualifiesForAutoSignoff) {
      core.info("PR does not qualify for auto sign-off based on ARM analysis");
      return {
        qualifiesForAutoSignoff: false,
        incrementalTypeSpec,
        isTrivial,
        reason: "No qualifying changes detected",
      };
    }

    if (!incrementalTypeSpec && !isTrivial) {
      core.warning(
        `Invalid ARM analysis result: qualifies=true but both incrementalTypeSpec and isTrivial are false.`,
      );
      return {
        qualifiesForAutoSignoff: false,
        incrementalTypeSpec,
        isTrivial,
        reason: "Invalid qualifying result",
      };
    }

    const reason = [
      incrementalTypeSpec ? LABEL_AUTO_SIGNED_OFF_INCREMENTAL_TSP : null,
      isTrivial ? LABEL_AUTO_SIGNED_OFF_TRIVIAL_TEST : null,
    ]
    .filter(Boolean)
    .join(", ");

    core.info(`PR qualifies for auto sign-off: ${reason}`);
    return {
      qualifiesForAutoSignoff: true,
      incrementalTypeSpec,
      isTrivial,
      reason,
    };
  }

  // If we get here, no combined artifact found - treat as not qualifying
  return {
    qualifiesForAutoSignoff: false,
    incrementalTypeSpec: false,
    isTrivial: false,
    reason: "No combined analysis artifact found",
  };
}