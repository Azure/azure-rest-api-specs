import { inspect } from "util";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.ts";
import { equals } from "../../../shared/src/set.ts";
import { byDate, invert } from "../../../shared/src/sort.ts";
import { extractInputs } from "../context.ts";
import type { Core } from "../github.ts";
import { LabelAction } from "../label.ts";
import { ArmAutoSignoffLabel } from "./arm-auto-signoff-labels.ts";

export type RestEndpointMethodTypes =
  import("@octokit/plugin-rest-endpoint-methods").RestEndpointMethodTypes;

export type IssueLabel =
  RestEndpointMethodTypes["issues"]["listLabelsOnIssue"]["response"]["data"][number];

export type WorkflowRun =
  RestEndpointMethodTypes["actions"]["listWorkflowRunsForRepo"]["response"]["data"]["workflow_runs"][number];

export type CommitStatus =
  RestEndpointMethodTypes["repos"]["listCommitStatusesForRef"]["response"]["data"][number];

export type Artifact =
  RestEndpointMethodTypes["actions"]["listWorkflowRunArtifacts"]["response"]["data"]["artifacts"][number];

/**
 * The workflow contract is intentionally a fixed set of keys.
 */
export type ManagedLabelActions = {
  ARMSignedOff: LabelAction;
  "ARMAutoSignedOff-IncrementalTSP": LabelAction;
  "ARMAutoSignedOff-Trivial": LabelAction;
};

function createNoneLabelActions(): ManagedLabelActions {
  return {
    [ArmAutoSignoffLabel.ArmSignedOff]: LabelAction.None,
    [ArmAutoSignoffLabel.ArmAutoSignedOffIncrementalTSP]: LabelAction.None,
    [ArmAutoSignoffLabel.ArmAutoSignedOffTrivial]: LabelAction.None,
  };
}

/**
 * The analyze-code workflow uploads empty artifacts named `${name}=${value}`.
 * We treat missing artifacts or non-boolean values as a failure (no auto-signoff).
 */
function readBooleanArtifactValue(artifactNames: string[], key: string): boolean | null {
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

export default async function getLabelAction({
  github,
  context,
  core,
}: import("@actions/github-script").AsyncFunctionArguments): Promise<{
  headSha: string;
  issueNumber: number;
  labelActions: ManagedLabelActions;
}> {
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

export async function getLabelActionImpl({
  owner,
  repo,
  issue_number,
  head_sha,
  github,
  core,
}: {
  owner: string;
  repo: string;
  issue_number: number;
  head_sha: string;
  github: import("@octokit/core").Octokit &
    import("@octokit/plugin-rest-endpoint-methods").Api & {
      paginate: import("@octokit/plugin-paginate-rest").PaginateInterface;
    };
  core: Core;
}): Promise<{ headSha: string; issueNumber: number; labelActions: ManagedLabelActions }> {
  const baseResult: { headSha: string; issueNumber: number } = {
    headSha: head_sha,
    issueNumber: issue_number,
  };

  const noneLabelActions = createNoneLabelActions();

  // TODO: Try to extract labels from context (when available) to avoid unnecessary API call
  // permissions: { issues: read, pull-requests: read }

  const labels: IssueLabel[] = await github.paginate(github.rest.issues.listLabelsOnIssue, {
    owner: owner,
    repo: repo,
    issue_number: issue_number,
    per_page: PER_PAGE_MAX,
  });
  const labelNames = labels.map((label) => label.name);

  // Check if any auto sign-off labels are currently present.
  // Used to determine whether ARMSignedOff was auto-added (vs manually added)
  // and whether removal is needed when the PR no longer qualifies.
  const hasAutoSignedOffLabels =
    // need to consider the legacy label
    labelNames.includes(ArmAutoSignoffLabel.ArmAutoSignedOff) ||
    labelNames.includes(ArmAutoSignoffLabel.ArmAutoSignedOffIncrementalTSP) ||
    labelNames.includes(ArmAutoSignoffLabel.ArmAutoSignedOffTrivial);
  core.info(`Labels: ${inspect(labelNames)}`);
  core.info(`Has auto signed-off labels: ${hasAutoSignedOffLabels}`);

  // permissions: { actions: read }

  const workflowRuns: WorkflowRun[] = await github.paginate(
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

    // Auto sign-off labels are present, so ARMSignedOff was auto-added. Remove all.
    return {
      ...noneResult,
      labelActions: {
        ...noneLabelActions,
        [ArmAutoSignoffLabel.ArmSignedOff]: LabelAction.Remove,
        [ArmAutoSignoffLabel.ArmAutoSignedOffIncrementalTSP]: LabelAction.Remove,
        [ArmAutoSignoffLabel.ArmAutoSignedOffTrivial]: LabelAction.Remove,
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

  const statuses: CommitStatus[] = await github.paginate(
    github.rest.repos.listCommitStatusesForRef,
    {
      owner: owner,
      repo: repo,
      ref: head_sha,
      per_page: PER_PAGE_MAX,
    },
  );

  core.info("Statuses:");
  statuses.forEach((status) => {
    core.info(`- ${status.context}: ${status.state}`);
  });

  const requiredStatusNames = ["Swagger LintDiff", "Swagger Avocado"];

  const requiredStatuses: CommitStatus[] = [];

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
    const autoIncrementalTSPAction = armAnalysisResult.incrementalTypeSpec
      ? LabelAction.Add
      : LabelAction.Remove;
    const trivialAction = armAnalysisResult.isTrivial ? LabelAction.Add : LabelAction.Remove;

    // Keep labels in sync with current analysis results.
    // When a label is not desired, emit Remove so it gets cleaned up if previously set.
    return {
      ...baseResult,
      labelActions: {
        ...noneLabelActions,
        [ArmAutoSignoffLabel.ArmSignedOff]: LabelAction.Add,
        [ArmAutoSignoffLabel.ArmAutoSignedOffIncrementalTSP]: autoIncrementalTSPAction,
        [ArmAutoSignoffLabel.ArmAutoSignedOffTrivial]: trivialAction,
      },
    };
  }

  // If any statuses are missing or pending, no-op to prevent frequent remove/add label as checks re-run
  core.info("One or more statuses are still pending");
  return noneResult;
}

/**
 * Check ARM Analysis workflow results (combines incremental TypeSpec and trivial changes).
 */
async function checkArmAnalysisWorkflow(
  workflowRuns: WorkflowRun[],
  github: import("@actions/github-script").AsyncFunctionArguments["github"],
  owner: string,
  repo: string,
  core: Core,
): Promise<{ qualifiesForAutoSignoff: boolean; incrementalTypeSpec: boolean; isTrivial: boolean }> {
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

  const artifacts: Artifact[] = await github.paginate(
    github.rest.actions.listWorkflowRunArtifacts,
    {
      owner,
      repo,
      run_id: run.id,
      per_page: PER_PAGE_MAX,
    },
  );

  const artifactNames: string[] = artifacts.map((a) => a.name);
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
