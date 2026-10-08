import { inspect } from "node:util";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.ts";
import { byDate, invert } from "../../../shared/src/sort.ts";
import { extractInputs } from "../context.ts";
import type { Core, GitHub, GitHubScriptArgs, WebhookEvent } from "../github.ts";
import { LabelAction } from "../label.ts";
import { ArmAutoSignoffLabel } from "./arm-auto-signoff-labels.ts";
import {
  getLatestSemanticReviewStatus,
  getSemanticReviewOutcome,
  SemanticReviewOutcome,
} from "./arm-semantic-review.ts";

/** Deterministic commit statuses that must be `success`, in addition to the semantic review. */
const requiredStatusNames = ["Swagger LintDiff", "Swagger Avocado"];

/**
 * The labels this workflow manages, each with the action to take. `ARMAutoSignedOff-Test` records
 * the pilot decision. `ARMManualSignoffRequired` is added (and never removed here) when a human
 * must review. `ARMSignedOff` is deliberately not managed: the pilot never changes it.
 */
export type ManagedLabelActions = {
  "ARMAutoSignedOff-Test": LabelAction;
  ARMManualSignoffRequired: LabelAction;
};

/** Returns a label-action set that changes nothing. */
function createNoneLabelActions(): ManagedLabelActions {
  return {
    [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: LabelAction.None,
    [ArmAutoSignoffLabel.ArmManualSignoffRequired]: LabelAction.None,
  };
}

/* v8 ignore start */

/**
 * Workflow entry point. Resolves the PR and head SHA from the triggering event (see
 * `extractInputs`), logs the correlation for diagnosis, and returns the label actions to apply.
 *
 * @returns The correlated head SHA and PR number, which the workflow uploads as artifacts so
 *   `Update Labels` can re-check the live head, and the label actions to apply.
 */
export default async function getLabelAction({ github, context, core }: GitHubScriptArgs): Promise<{
  headSha: string;
  issueNumber: number;
  labelActions: ManagedLabelActions;
}> {
  const workflowRun =
    context.eventName === "workflow_run"
      ? (context.payload as WebhookEvent<"workflow-run">).workflow_run
      : undefined;
  core.info(
    `Universal auto-signoff trigger: ${JSON.stringify({
      eventName: context.eventName,
      action: context.payload.action,
      workflowRun: workflowRun
        ? {
            id: workflowRun.id,
            name: workflowRun.name,
            path: workflowRun.path,
            event: workflowRun.event,
            conclusion: workflowRun.conclusion,
          }
        : undefined,
    })}`,
  );
  const { owner, repo, head_sha, issue_number } = await extractInputs(github, context, core);
  core.info(
    `Universal auto-signoff correlation: ${JSON.stringify({
      owner,
      repo,
      issueNumber: Number.isSafeInteger(issue_number) ? issue_number : "missing",
      headSha: head_sha || "missing",
    })}`,
  );

  const result = await getLabelActionImpl({
    owner,
    repo,
    head_sha,
    issue_number,
    github,
    core,
  });
  core.info(`Universal auto-signoff output: ${JSON.stringify(result)}`);
  return result;
}
/* v8 ignore stop */

/**
 * Decides label actions for a PR head. It first re-reads the PR and takes no action when it is
 * closed or its head is no longer `head_sha`, so a stale event cannot change current labels.
 * Otherwise it reads the PR's labels and the head SHA's commit statuses and defers to
 * `getDesiredLabelActions`.
 *
 * @returns The correlation passed in and the label actions; no action when correlation is missing
 *   or stale.
 */
export async function getLabelActionImpl({
  owner,
  repo,
  head_sha,
  issue_number,
  github,
  core,
}: {
  owner: string;
  repo: string;
  head_sha: string;
  issue_number: number;
  github: GitHub;
  core: Core;
}): Promise<{ headSha: string; issueNumber: number; labelActions: ManagedLabelActions }> {
  const noneResult = {
    headSha: head_sha,
    issueNumber: issue_number,
    labelActions: createNoneLabelActions(),
  };

  if (!Number.isInteger(issue_number) || issue_number <= 0 || !head_sha) {
    core.info(
      `Universal auto-signoff no-op: missing correlation ` +
        `(issueNumber=${Number.isSafeInteger(issue_number) ? issue_number : "missing"}, ` +
        `headSha=${head_sha || "missing"})`,
    );
    return noneResult;
  }

  // Re-read the PR to prevent a completed check for an older commit from changing current labels.
  const { data: pullRequest } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: issue_number,
  });
  if (pullRequest.state !== "open" || pullRequest.head.sha !== head_sha) {
    core.info(
      `Universal auto-signoff no-op: pull request state/head mismatch ` +
        `(state=${pullRequest.state}, expectedHead=${head_sha}, currentHead=${pullRequest.head.sha})`,
    );
    return noneResult;
  }

  const labelNames: string[] = (
    await github.paginate(github.rest.issues.listLabelsOnIssue, {
      owner,
      repo,
      issue_number,
      per_page: PER_PAGE_MAX,
    })
  ).map((label) => label.name);
  const hasAutoSignoff = labelNames.includes(ArmAutoSignoffLabel.ArmAutoSignedOffTest);
  core.info(`Current pull request labels: ${JSON.stringify([...labelNames].sort())}`);

  const labelActions = await getDesiredLabelActions({
    owner,
    repo,
    head_sha,
    labelNames,
    hasAutoSignoff,
    github,
    core,
  });
  core.info(`Universal auto-signoff label actions: ${JSON.stringify(labelActions)}`);

  return {
    ...noneResult,
    labelActions,
  };
}

/**
 * Applies the auto-signoff policy for one head SHA. In order:
 *
 * 1. Not ready for ARM review (`ARMReview` missing or `NotReadyForARMReview` present): no signoff.
 * 2. `ARM Semantic Review` is not `Passed`: no signoff. Only a manual-review hold
 *    (`Manual review required`) also adds `ARMManualSignoffRequired`; a pending, failed, or
 *    incomplete review adds nothing, because a re-run can still pass.
 * 3. Labels block signoff (`ARMChangesRequested`, `ARMManualSignoffRequired`, or an unapproved
 *    `SuppressionReviewRequired`): no signoff.
 * 4. Any required status (`Swagger LintDiff`, `Swagger Avocado`) is not `success`: no signoff.
 * 5. Otherwise add `ARMAutoSignedOff-Test`.
 *
 * Whenever signoff is withheld, an existing `ARMAutoSignedOff-Test` is removed.
 */
async function getDesiredLabelActions({
  owner,
  repo,
  head_sha,
  labelNames,
  hasAutoSignoff,
  github,
  core,
}: {
  owner: string;
  repo: string;
  head_sha: string;
  labelNames: string[];
  hasAutoSignoff: boolean;
  github: GitHub;
  core: Core;
}): Promise<ManagedLabelActions> {
  const labelActions = createNoneLabelActions();
  const hasArmReview = labelNames.includes("ARMReview");
  const hasNotReadyForArmReview = labelNames.includes("NotReadyForARMReview");
  const isReadyForArmReview = hasArmReview && !hasNotReadyForArmReview;
  core.info(
    `ARM review readiness: ${JSON.stringify({
      hasArmReview,
      hasNotReadyForArmReview,
      isReadyForArmReview,
    })}`,
  );

  if (!isReadyForArmReview) {
    core.info("Pull request is not ready for ARM review");
    labelActions[ArmAutoSignoffLabel.ArmAutoSignedOffTest] = hasAutoSignoff
      ? LabelAction.Remove
      : LabelAction.None;
    return labelActions;
  }

  const statuses: import("@octokit/plugin-rest-endpoint-methods").RestEndpointMethodTypes["repos"]["listCommitStatusesForRef"]["response"]["data"] =
    await github.paginate(github.rest.repos.listCommitStatusesForRef, {
      owner,
      repo,
      ref: head_sha,
      per_page: PER_PAGE_MAX,
    });

  const latestSemanticReviewStatus = getLatestSemanticReviewStatus(statuses);
  const semanticReviewOutcome = getSemanticReviewOutcome(latestSemanticReviewStatus);
  core.info(
    `Latest ARM Semantic Review status: ${JSON.stringify({
      state: latestSemanticReviewStatus?.state ?? "missing",
      description: latestSemanticReviewStatus?.description ?? "missing",
      targetUrl: latestSemanticReviewStatus?.target_url ?? "missing",
      updatedAt: latestSemanticReviewStatus?.updated_at ?? "missing",
      outcome: semanticReviewOutcome ?? "missing",
    })}`,
  );

  if (semanticReviewOutcome !== SemanticReviewOutcome.Passed) {
    if (semanticReviewOutcome === SemanticReviewOutcome.ManualReviewRequired) {
      const hasManualSignoffRequired = labelNames.includes(
        ArmAutoSignoffLabel.ArmManualSignoffRequired,
      );
      core.info(
        `ARM semantic review requires manual signoff; ` +
          `${ArmAutoSignoffLabel.ArmManualSignoffRequired} ` +
          `${hasManualSignoffRequired ? "is already present" : "will be added"}`,
      );
      if (!hasManualSignoffRequired) {
        labelActions[ArmAutoSignoffLabel.ArmManualSignoffRequired] = LabelAction.Add;
      }
    } else {
      core.info("ARM semantic review has not passed");
    }
    labelActions[ArmAutoSignoffLabel.ArmAutoSignedOffTest] = hasAutoSignoff
      ? LabelAction.Remove
      : LabelAction.None;
    return labelActions;
  }

  const hasArmChangesRequested = labelNames.includes("ARMChangesRequested");
  const hasManualSignoffRequired = labelNames.includes(
    ArmAutoSignoffLabel.ArmManualSignoffRequired,
  );
  const hasSuppressionReviewRequired = labelNames.includes("SuppressionReviewRequired");
  const hasApprovedSuppression = labelNames.includes("Approved-Suppression");
  const labelsAllowSignoff =
    !hasArmChangesRequested &&
    !hasManualSignoffRequired &&
    (!hasSuppressionReviewRequired || hasApprovedSuppression);
  core.info(
    `Auto-signoff label eligibility: ${JSON.stringify({
      hasArmChangesRequested,
      hasManualSignoffRequired,
      hasSuppressionReviewRequired,
      hasApprovedSuppression,
      labelsAllowSignoff,
    })}`,
  );
  if (!labelsAllowSignoff) {
    core.info("Labels do not meet requirements for universal auto-signoff");
    labelActions[ArmAutoSignoffLabel.ArmAutoSignedOffTest] = hasAutoSignoff
      ? LabelAction.Remove
      : LabelAction.None;
    return labelActions;
  }

  for (const statusName of requiredStatusNames) {
    // A status context may appear more than once; only the most recently updated result applies.
    const matchingStatuses = statuses
      .filter((status) => status.context.toLowerCase() === statusName.toLowerCase())
      .sort(invert(byDate((status) => status.updated_at)));
    const latestStatus = matchingStatuses[0];

    core.info(`${statusName}: ${latestStatus?.state ?? "missing"}`);
    if (latestStatus?.state !== CommitStatusState.SUCCESS) {
      core.info(`Required status '${statusName}' did not succeed`);
      labelActions[ArmAutoSignoffLabel.ArmAutoSignedOffTest] = hasAutoSignoff
        ? LabelAction.Remove
        : LabelAction.None;
      return labelActions;
    }
  }

  core.info(`Universal auto-signoff pilot requirements met: ${inspect(requiredStatusNames)}`);
  labelActions[ArmAutoSignoffLabel.ArmAutoSignedOffTest] = hasAutoSignoff
    ? LabelAction.None
    : LabelAction.Add;
  return labelActions;
}
