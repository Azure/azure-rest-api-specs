import { inspect } from "node:util";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.ts";
import { getLatestCommitStatuses } from "../commit-statuses.ts";
import { extractInputs } from "../context.ts";
import type { Core, GitHub, GitHubScriptArgs, WebhookEvent } from "../github.ts";
import { LabelAction } from "../label.ts";
import { parseSignoffDispatchInputs } from "./arm-signoff-dispatch.ts";
import {
  ArmAutoSignoffLabel,
  autoSignoffMarkers,
  legacyAutoSignoffMarkers,
} from "./arm-auto-signoff-labels.ts";
import {
  getLatestSemanticReviewStatus,
  getSemanticReviewOutcome,
  SemanticReviewOutcome,
} from "./arm-semantic-review.ts";

/** Deterministic commit statuses that must be `success`, in addition to the semantic review. */
const requiredStatusNames = ["Swagger LintDiff", "Swagger Avocado"];

/** The action to take for each auto-signoff label. */
export type ManagedLabelActions = Record<ArmAutoSignoffLabel, LabelAction>;

/** Returns a label-action set that changes nothing. */
function createNoneLabelActions(): ManagedLabelActions {
  return {
    [ArmAutoSignoffLabel.ArmSignedOff]: LabelAction.None,
    [ArmAutoSignoffLabel.ArmManualSignoffRequired]: LabelAction.None,
    [ArmAutoSignoffLabel.ArmAutoSignedOff]: LabelAction.None,
    [ArmAutoSignoffLabel.ArmAutoSignedOffIncrementalTSP]: LabelAction.None,
    [ArmAutoSignoffLabel.ArmAutoSignedOffTrivial]: LabelAction.None,
  };
}

/* v8 ignore start */

/**
 * Workflow entry point. Resolves the PR and head SHA from the triggering event (see
 * `extractInputs`) and decides the label actions, which the workflow uploads as label artifacts
 * for Update Labels to apply.
 *
 * @returns The correlated head SHA and PR number, which the workflow uploads as artifacts on
 *   `workflow_run` triggers so Update Labels can find the PR, and the label actions.
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
  const { owner, repo, head_sha, issue_number } =
    context.eventName === "workflow_dispatch"
      ? {
          ...context.repo,
          ...parseSignoffDispatchInputs(
            (context.payload as WebhookEvent<"workflow-dispatch">).inputs,
          ),
        }
      : await extractInputs(github, context, core);
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
 * Otherwise it reads the PR's labels and, unless a human owns `ARMSignedOff`, the head SHA's
 * commit statuses.
 *
 * Ownership:
 *
 * - `ARMSignedOff` with `ARMAutoSignedOff` is automation-owned: it is added, self-healed, and
 *   revoked by this workflow.
 * - `ARMSignedOff` without a marker is a human approval: it is never changed.
 * - Legacy markers (`ARMAutoSignedOff-IncrementalTSP`, `-Trivial`) also mark automation ownership.
 *   They are always removed; an eligible PR gets `ARMAutoSignedOff` instead.
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
  const labelActions = createNoneLabelActions();
  const result = { headSha: head_sha, issueNumber: issue_number, labelActions };

  if (!Number.isInteger(issue_number) || issue_number <= 0 || !head_sha) {
    core.info(
      `Universal auto-signoff no-op: missing correlation ` +
        `(issueNumber=${Number.isSafeInteger(issue_number) ? issue_number : "missing"}, ` +
        `headSha=${head_sha || "missing"})`,
    );
    return result;
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
    return result;
  }

  const labelNames: string[] = (
    await github.paginate(github.rest.issues.listLabelsOnIssue, {
      owner,
      repo,
      issue_number,
      per_page: PER_PAGE_MAX,
    })
  ).map((label) => label.name);
  core.info(`Current pull request labels: ${JSON.stringify([...labelNames].sort())}`);
  const has = (label: string) => labelNames.includes(label);

  const hasSignedOff = has(ArmAutoSignoffLabel.ArmSignedOff);
  const isAutomationOwned = autoSignoffMarkers.some(has);
  if (hasSignedOff && !isAutomationOwned) {
    core.info(
      `${ArmAutoSignoffLabel.ArmSignedOff} is a human approval (no auto-signoff marker); ` +
        `leaving it unchanged`,
    );
  } else {
    const { eligible, requireManualSignoff } = await evaluateEligibility({
      owner,
      repo,
      head_sha,
      labelNames,
      github,
      core,
    });

    if (requireManualSignoff && !has(ArmAutoSignoffLabel.ArmManualSignoffRequired)) {
      labelActions[ArmAutoSignoffLabel.ArmManualSignoffRequired] = LabelAction.Add;
    }

    if (eligible) {
      // Adding `ARMSignedOff` back when only the marker remains self-heals a partial removal.
      for (const label of [
        ArmAutoSignoffLabel.ArmSignedOff,
        ArmAutoSignoffLabel.ArmAutoSignedOff,
      ]) {
        if (!has(label)) labelActions[label] = LabelAction.Add;
      }
    } else {
      for (const label of [
        ArmAutoSignoffLabel.ArmSignedOff,
        ArmAutoSignoffLabel.ArmAutoSignedOff,
      ]) {
        if (has(label)) labelActions[label] = LabelAction.Remove;
      }
    }
    for (const label of legacyAutoSignoffMarkers) {
      if (has(label)) labelActions[label] = LabelAction.Remove;
    }
  }

  core.info(`Universal auto-signoff label actions: ${JSON.stringify(labelActions)}`);
  return result;
}

/**
 * Applies the auto-signoff policy for one head SHA. In order:
 *
 * 1. Not ready for ARM review (`ARMReview` missing or `NotReadyForARMReview` present): not eligible.
 * 2. `ARM Semantic Review` is not `Passed`: not eligible. Only a manual-review hold
 *    (`Manual review required`) also requires `ARMManualSignoffRequired`; a pending, failed, or
 *    incomplete review does not, because a re-run can still pass.
 * 3. Labels block signoff (`ARMChangesRequested`, `ARMManualSignoffRequired`, or an unapproved
 *    `SuppressionReviewRequired`): not eligible.
 * 4. Any required status (`Swagger LintDiff`, `Swagger Avocado`) is not `success`: not eligible.
 * 5. Otherwise eligible.
 */
async function evaluateEligibility({
  owner,
  repo,
  head_sha,
  labelNames,
  github,
  core,
}: {
  owner: string;
  repo: string;
  head_sha: string;
  labelNames: string[];
  github: GitHub;
  core: Core;
}): Promise<{ eligible: boolean; requireManualSignoff: boolean }> {
  const notEligible = { eligible: false, requireManualSignoff: false };
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
    return notEligible;
  }

  const statuses = await getLatestCommitStatuses(github, owner, repo, head_sha);

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
      return { eligible: false, requireManualSignoff: true };
    }
    core.info(
      `ARM semantic review has not passed: ${semanticReviewOutcome ?? "missing"}` +
        (latestSemanticReviewStatus?.description
          ? ` (${latestSemanticReviewStatus.description})`
          : ""),
    );
    return notEligible;
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
    return notEligible;
  }

  for (const statusName of requiredStatusNames) {
    const latestStatus = statuses.find(
      (status) => status.context.toLowerCase() === statusName.toLowerCase(),
    );

    core.info(`${statusName}: ${latestStatus?.state ?? "missing"}`);
    if (latestStatus?.state !== CommitStatusState.SUCCESS) {
      core.info(`Required status '${statusName}' did not succeed`);
      return notEligible;
    }
  }

  core.info(`Universal auto-signoff requirements met: ${inspect(requiredStatusNames)}`);
  return { eligible: true, requireManualSignoff: false };
}
