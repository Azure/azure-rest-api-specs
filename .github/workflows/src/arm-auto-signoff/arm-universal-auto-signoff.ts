import { inspect } from "util";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.ts";
import { byDate, invert } from "../../../shared/src/sort.ts";
import { extractInputs } from "../context.ts";
import type { Core } from "../github.ts";
import { LabelAction } from "../label.ts";
import { ArmAutoSignoffLabel } from "./arm-auto-signoff-labels.ts";

const requiredStatusNames = ["Swagger LintDiff", "Swagger Avocado"];

export type ManagedLabelActions = {
  "ARMAutoSignedOff-Test": LabelAction;
};

function createNoneLabelActions(): ManagedLabelActions {
  return {
    [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: LabelAction.None,
  };
}

/* v8 ignore start */

export default async function getLabelAction({
  github,
  context,
  core,
}: import("../github.ts").WorkflowArguments): Promise<{
  headSha: string;
  issueNumber: number;
  labelActions: ManagedLabelActions;
}> {
  const { owner, repo, head_sha, issue_number } = await extractInputs(github, context, core);

  return await getLabelActionImpl({
    owner,
    repo,
    head_sha,
    issue_number,
    github,
    core,
  });
}
/* v8 ignore stop */

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
  github: import("@octokit/core").Octokit &
    import("@octokit/plugin-rest-endpoint-methods").Api & {
      paginate: import("@octokit/plugin-paginate-rest").PaginateInterface;
    };
  core: Core;
}): Promise<{ headSha: string; issueNumber: number; labelActions: ManagedLabelActions }> {
  const noneResult = {
    headSha: head_sha,
    issueNumber: issue_number,
    labelActions: createNoneLabelActions(),
  };

  if (!Number.isInteger(issue_number) || issue_number <= 0 || !head_sha) {
    core.info("Missing pull request number or head SHA");
    return noneResult;
  }

  // Re-read the PR to prevent a completed check for an older commit from changing current labels.
  const { data: pullRequest } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: issue_number,
  });
  if (pullRequest.state !== "open" || pullRequest.head.sha !== head_sha) {
    core.info("Pull request is closed or its head SHA has changed");
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

  const desiredAction = await getDesiredLabelAction({
    owner,
    repo,
    head_sha,
    labelNames,
    hasAutoSignoff,
    github,
    core,
  });

  return {
    ...noneResult,
    labelActions: {
      [ArmAutoSignoffLabel.ArmAutoSignedOffTest]: desiredAction,
    },
  };
}

async function getDesiredLabelAction({
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
  github: import("@octokit/core").Octokit &
    import("@octokit/plugin-rest-endpoint-methods").Api & {
      paginate: import("@octokit/plugin-paginate-rest").PaginateInterface;
    };
  core: Core;
}): Promise<LabelAction> {
  const labelsAllowSignoff =
    labelNames.includes("ARMReview") &&
    !labelNames.includes("NotReadyForARMReview") &&
    !labelNames.includes(ArmAutoSignoffLabel.ArmManualSignoffRequired) &&
    (!labelNames.includes("SuppressionReviewRequired") ||
      labelNames.includes("Approved-Suppression"));

  if (!labelsAllowSignoff) {
    core.info("Labels do not meet requirements for universal auto-signoff");
    return hasAutoSignoff ? LabelAction.Remove : LabelAction.None;
  }

  const statuses: import("@octokit/plugin-rest-endpoint-methods").RestEndpointMethodTypes["repos"]["listCommitStatusesForRef"]["response"]["data"] =
    await github.paginate(github.rest.repos.listCommitStatusesForRef, {
      owner,
      repo,
      ref: head_sha,
      per_page: PER_PAGE_MAX,
    });

  for (const statusName of requiredStatusNames) {
    // A status context may appear more than once; only the most recently updated result applies.
    const matchingStatuses = statuses
      .filter((status) => status.context.toLowerCase() === statusName.toLowerCase())
      .sort(invert(byDate((status) => status.updated_at)));
    const latestStatus = matchingStatuses[0];

    core.info(`${statusName}: ${latestStatus?.state ?? "missing"}`);
    if (latestStatus?.state !== CommitStatusState.SUCCESS) {
      core.info(`Required status '${statusName}' did not succeed`);
      return hasAutoSignoff ? LabelAction.Remove : LabelAction.None;
    }
  }

  core.info(`Universal auto-signoff pilot requirements met: ${inspect(requiredStatusNames)}`);
  return hasAutoSignoff ? LabelAction.None : LabelAction.Add;
}
