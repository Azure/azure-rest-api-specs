import { isFullGitSha } from "../../../shared/src/git.ts";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.ts";
import { getLatestCommitStatuses } from "../commit-statuses.ts";
import { extractInputs } from "../context.ts";
import type { Core, GitHub, GitHubScriptArgs } from "../github.ts";
import { LabelAction } from "../label.ts";
import { ArmAutoSignoffLabel } from "./arm-auto-signoff-labels.ts";
import { armReviewAllowed } from "./arm-review-policy.ts";
import { isLatestArmReviewRun, parseArmReviewRunUrl } from "./arm-review-run.ts";
import {
  getLatestSemanticReviewStatus,
  getSemanticReviewOutcome,
  SemanticReviewOutcome,
} from "./arm-semantic-review.ts";

const requiredStatusNames = ["Swagger LintDiff", "Swagger Avocado"];

export type ManagedLabelActions = {
  ARMSignedOff: LabelAction;
  ARMAutoSignedOff: LabelAction;
  ARMManualSignoffRequired: LabelAction;
};

function createNoneLabelActions(): ManagedLabelActions {
  return {
    ARMSignedOff: LabelAction.None,
    ARMAutoSignedOff: LabelAction.None,
    ARMManualSignoffRequired: LabelAction.None,
  };
}

type Inputs = {
  owner: string;
  repo: string;
  head_sha: string;
  issue_number: number;
  github: GitHub;
  core: Core;
};

type Decision = {
  headSha: string;
  issueNumber: number;
  labelActions: ManagedLabelActions;
  approvalValid: boolean;
};

async function getInputs({ github, context, core }: GitHubScriptArgs) {
  if (context.eventName !== "workflow_dispatch") return extractInputs(github, context, core);
  const issue_number = Number(process.env.ARM_SIGNOFF_PR_NUMBER);
  const head_sha = process.env.ARM_SIGNOFF_HEAD_SHA ?? "";
  if (!Number.isSafeInteger(issue_number) || issue_number <= 0 || !isFullGitSha(head_sha)) {
    throw new Error("Universal signoff dispatch requires a PR number and full head SHA");
  }
  return { ...context.repo, issue_number, head_sha };
}

export default async function getLabelAction({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<Decision> {
  const inputs = await getInputs({ github, context, core });
  return getLabelActionImpl({ ...inputs, github, core });
}

/** A diagnostic marker alone never authorizes removing a human's signoff. */
async function ownsSignoff(
  inputs: Inputs,
  labels: string[],
  requireMarker = true,
): Promise<boolean> {
  if (
    !labels.includes(ArmAutoSignoffLabel.ArmSignedOff) ||
    (requireMarker && !labels.includes(ArmAutoSignoffLabel.ArmAutoSignedOff))
  ) {
    return false;
  }
  const events = await inputs.github.paginate(inputs.github.rest.issues.listEvents, {
    owner: inputs.owner,
    repo: inputs.repo,
    issue_number: inputs.issue_number,
    per_page: PER_PAGE_MAX,
  });
  const latest = events
    .filter(
      (event) =>
        (event.event === "labeled" || event.event === "unlabeled") &&
        "label" in event &&
        event.label?.name === ArmAutoSignoffLabel.ArmSignedOff,
    )
    .sort((a, b) => b.id - a.id)[0];
  return latest?.event === "labeled" && latest.actor?.login === "github-actions[bot]";
}

async function removeLabel(inputs: Inputs, name: string): Promise<void> {
  try {
    await inputs.github.rest.issues.removeLabel({
      owner: inputs.owner,
      repo: inputs.repo,
      issue_number: inputs.issue_number,
      name,
    });
  } catch (error) {
    if (error instanceof Error && "status" in error && error.status === 404) {
      inputs.core.info(`Label ${name} is already absent`);
    } else {
      throw error;
    }
  }
}

async function compensatePublishedSignoff(inputs: Inputs): Promise<ManagedLabelActions> {
  const actions = createNoneLabelActions();
  const { data: pull } = await inputs.github.rest.pulls.get({
    owner: inputs.owner,
    repo: inputs.repo,
    pull_number: inputs.issue_number,
  });
  const labels = pull.labels.map((label) => label.name);
  // We just wrote approval; a competing diagnostic updater may already have removed its marker.
  if (!(await ownsSignoff(inputs, labels, false))) return actions;
  inputs.core.warning("Revoking automatic ARM approval invalidated during publication");
  await removeLabel(inputs, ArmAutoSignoffLabel.ArmSignedOff);
  actions.ARMSignedOff = LabelAction.Remove;
  if (labels.includes(ArmAutoSignoffLabel.ArmAutoSignedOff)) {
    await removeLabel(inputs, ArmAutoSignoffLabel.ArmAutoSignedOff);
    actions.ARMAutoSignedOff = LabelAction.Remove;
  }
  return actions;
}

/**
 * Production approval uses the existing semantic result and deterministic prerequisites.
 * Raw policy holds are checked too, because a NotReadyForARMReview update may be delayed.
 */
export async function getLabelActionImpl(inputs: Inputs): Promise<Decision> {
  const { owner, repo, head_sha, issue_number, github, core } = inputs;
  const result: Decision = {
    headSha: head_sha,
    issueNumber: issue_number,
    labelActions: createNoneLabelActions(),
    approvalValid: false,
  };
  if (!Number.isSafeInteger(issue_number) || issue_number <= 0 || !isFullGitSha(head_sha)) {
    core.info("Universal auto-signoff skipped: missing PR/head correlation");
    return result;
  }
  const { data: pull } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: issue_number,
  });
  if (pull.state !== "open" || pull.head.sha !== head_sha) {
    core.info("Universal auto-signoff skipped: stale or closed PR");
    return result;
  }
  const labels = pull.labels.map((label) => label.name);
  const hasSignoff = labels.includes(ArmAutoSignoffLabel.ArmSignedOff);
  const owned = await ownsSignoff(inputs, labels);
  if (hasSignoff && !owned) {
    core.info("Preserving manual ARM signoff");
    return result;
  }
  const withhold = () => {
    if (owned) {
      result.labelActions.ARMSignedOff = LabelAction.Remove;
      result.labelActions.ARMAutoSignedOff = LabelAction.Remove;
    }
    return result;
  };
  if (pull.draft || !armReviewAllowed(labels)) {
    core.info("Universal auto-signoff withheld: PR readiness or policy hold");
    return withhold();
  }
  if (!hasSignoff && !labels.includes("WaitForARMFeedback")) {
    core.info("Universal auto-signoff withheld: summary has not queued ARM review");
    return withhold();
  }
  const statuses = await getLatestCommitStatuses(github, owner, repo, head_sha);
  const semantic = getLatestSemanticReviewStatus(statuses);
  const outcome = getSemanticReviewOutcome(semantic);
  if (outcome !== SemanticReviewOutcome.Passed) {
    core.info(`ARM semantic review has not passed: ${outcome ?? "missing"}`);
    if (
      outcome === SemanticReviewOutcome.ManualReviewRequired &&
      !labels.includes(ArmAutoSignoffLabel.ArmManualSignoffRequired)
    ) {
      result.labelActions.ARMManualSignoffRequired = LabelAction.Add;
    }
    return withhold();
  }
  if (
    requiredStatusNames.some(
      (name) =>
        statuses.find((status) => status.context.toLowerCase() === name.toLowerCase())?.state !==
        CommitStatusState.SUCCESS,
    )
  ) {
    core.info("Universal auto-signoff withheld: deterministic checks have not passed");
    return withhold();
  }
  const run = parseArmReviewRunUrl(semantic?.target_url, owner, repo);
  if (
    !run ||
    !(await isLatestArmReviewRun({
      github,
      core,
      owner,
      repo,
      headSha: head_sha,
      issueNumber: issue_number,
      ...run,
    }))
  ) {
    core.info("Universal auto-signoff withheld: stale or uncorrelated reviewer result");
    return withhold();
  }
  if (!hasSignoff) {
    result.labelActions.ARMSignedOff = LabelAction.Add;
    result.labelActions.ARMAutoSignedOff = labels.includes(ArmAutoSignoffLabel.ArmAutoSignedOff)
      ? LabelAction.None
      : LabelAction.Add;
  }
  result.approvalValid = true;
  return result;
}

/** Publish here, not in a later workflow_run: that chain can already be three levels deep. */
export async function applyUniversalSignoff({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<Decision> {
  const correlation = await getInputs({ github, context, core });
  const inputs = { ...correlation, github, core };
  const decision = await getLabelActionImpl(inputs);
  if (Object.values(decision.labelActions).every((action) => action === LabelAction.None)) {
    return decision;
  }
  // Re-evaluate at publication, not just at artifact creation. A head, policy, human decision,
  // deterministic status, or newer reviewer attempt can invalidate the earlier decision.
  const fresh = await getLabelActionImpl(inputs);
  if (JSON.stringify(fresh.labelActions) !== JSON.stringify(decision.labelActions)) {
    core.info("Universal auto-signoff decision changed before publication; nothing is applied");
    return { ...fresh, labelActions: createNoneLabelActions() };
  }
  const { data: pull } = await github.rest.pulls.get({
    owner: correlation.owner,
    repo: correlation.repo,
    pull_number: correlation.issue_number,
  });
  const liveLabels = pull.labels.map((label) => label.name);
  if (
    pull.state !== "open" ||
    pull.head.sha !== correlation.head_sha ||
    (fresh.labelActions.ARMSignedOff === LabelAction.Add &&
      (pull.draft ||
        !armReviewAllowed(liveLabels) ||
        !liveLabels.includes("WaitForARMFeedback") ||
        liveLabels.includes("ARMSignedOff"))) ||
    (fresh.labelActions.ARMSignedOff === LabelAction.Remove &&
      !(await ownsSignoff(inputs, liveLabels)))
  ) {
    core.info("PR head or human/policy labels changed at publication; nothing is applied");
    return { ...fresh, labelActions: createNoneLabelActions() };
  }
  const labels = Object.entries(fresh.labelActions)
    .filter(([, action]) => action === LabelAction.Add)
    .map(([label]) => label);
  if (labels.length > 0) {
    await github.rest.issues.addLabels({
      owner: correlation.owner,
      repo: correlation.repo,
      issue_number: correlation.issue_number,
      labels,
    });
  }
  core.setOutput("head_sha", correlation.head_sha);
  core.setOutput("issue_number", correlation.issue_number);
  if (fresh.labelActions.ARMSignedOff === LabelAction.Add) {
    let verified: Decision;
    try {
      verified = await getLabelActionImpl(inputs);
    } catch (error) {
      core.error("ARM approval verification failed after publication; compensating before failing");
      try {
        await compensatePublishedSignoff(inputs);
      } catch (compensationError) {
        throw new AggregateError(
          [error, compensationError],
          "ARM approval verification and compensation both failed",
          { cause: compensationError },
        );
      }
      throw error;
    }
    if (!verified.approvalValid) {
      return {
        ...verified,
        labelActions: await compensatePublishedSignoff(inputs),
      };
    }
  }
  for (const [name, action] of Object.entries(fresh.labelActions)) {
    if (action === LabelAction.Remove) {
      await removeLabel(inputs, name);
    }
  }
  return fresh;
}
