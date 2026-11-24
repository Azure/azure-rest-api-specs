import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import type { GitHub, GitHubScriptArgs, WebhookEvent } from "./github.ts";
import { PULL_REQUEST_EVENT_WORKFLOW } from "./pull-request-event.ts";

/*
  Trusted replacement for the label/PR triggers the gh-aw reviewers used to receive through
  pull_request_target. Runs on workflow_run of the unprivileged "Pull Request Event" intake and
  starts the reviewer with workflow_dispatch.

  Trust model:
  - Trusted: GitHub-set workflow_run fields (triggering_actor, head_sha, head_repository,
    repository) and API reads made here.
  - Untrusted: the intake run-name (`PR #<n> <action>[ <label>]`), which a PR can change. It only
    selects a route; every route re-reads the PR, requires a write-access triggering actor (the
    same gate as gh-aw `roles: [admin, maintainer, write]`), and label routes require the latest
    issue event for that label to match the hinted action and actor.
*/

export const ARM_REVIEW_WORKFLOW = "arm-api-review.lock.yml";
export const DATA_PLANE_REVIEW_WORKFLOW = "data-plane-api-review.lock.yml";
export const HERO_SCENARIOS_WORKFLOW = "hero-scenarios.lock.yml";

export const DATA_PLANE_REVIEW_LABEL = "data-plane-review-requested";
export const HERO_SCENARIOS_LABEL = "hero-scenarios-needed";

export interface IntakeHint {
  issueNumber: number;
  action: string;
  label?: string;
}

export interface PullRequestState {
  state: string;
  draft: boolean;
  headSha: string;
  labels: string[];
}

export interface ReviewerRoute {
  workflow: string;
  inputs: Record<string, string>;
  /** Label event that must be confirmed through the issue events API. */
  labelEvent?: { action: "labeled" | "unlabeled"; label: string };
}

/** Parses the intake run-name. Returns undefined for anything unexpected. */
export function parseIntakeHint(displayTitle: string | undefined): IntakeHint | undefined {
  const match = /^PR #([1-9]\d{0,9}) ([a-z_]+)(?: (.+))?$/.exec(displayTitle ?? "");
  if (!match) {
    return undefined;
  }
  return { issueNumber: Number(match[1]), action: match[2], label: match[3] };
}

/**
 * Chooses the reviewer to dispatch, mirroring the former pull_request_target `if:` gates.
 * `intakeHeadSha` is the GitHub-set head SHA of the intake run.
 */
export function selectReviewerRoute(
  hint: IntakeHint,
  pr: PullRequestState,
  intakeHeadSha: string,
): ReviewerRoute | undefined {
  if (pr.state !== "open") {
    return undefined;
  }
  const number = String(hint.issueNumber);
  const has = (label: string) => pr.labels.includes(label);

  if (!pr.draft) {
    if (hint.action === "labeled" && hint.label === "WaitForARMFeedback" && has(hint.label)) {
      return {
        workflow: ARM_REVIEW_WORKFLOW,
        inputs: { pr_number: number },
        labelEvent: { action: "labeled", label: hint.label },
      };
    }
    if (hint.action === "unlabeled" && hint.label === "ARMChangesRequested" && !has(hint.label)) {
      return {
        workflow: ARM_REVIEW_WORKFLOW,
        inputs: { pr_number: number },
        labelEvent: { action: "unlabeled", label: hint.label },
      };
    }
    if (hint.action === "labeled" && hint.label === DATA_PLANE_REVIEW_LABEL && has(hint.label)) {
      return {
        workflow: DATA_PLANE_REVIEW_WORKFLOW,
        inputs: { item_number: number },
        labelEvent: { action: "labeled", label: hint.label },
      };
    }
    if (
      ["opened", "synchronize", "ready_for_review"].includes(hint.action) &&
      has(DATA_PLANE_REVIEW_LABEL) &&
      pr.headSha === intakeHeadSha
    ) {
      return { workflow: DATA_PLANE_REVIEW_WORKFLOW, inputs: { item_number: number } };
    }
  }
  if (hint.action === "labeled" && hint.label === HERO_SCENARIOS_LABEL && has(hint.label)) {
    return {
      workflow: HERO_SCENARIOS_WORKFLOW,
      inputs: { item_number: number },
      labelEvent: { action: "labeled", label: hint.label },
    };
  }
  return undefined;
}

/** True if the most recent labeled/unlabeled event for the label matches the action and actor. */
export function isLatestLabelEvent(
  events: { event: string; label?: { name: string }; actor?: { login: string } | null }[],
  expected: { action: "labeled" | "unlabeled"; label: string },
  actor: string,
): boolean {
  const latest = events
    .filter(
      (e) => (e.event === "labeled" || e.event === "unlabeled") && e.label?.name === expected.label,
    )
    .at(-1);
  return latest?.event === expected.action && latest.actor?.login === actor;
}

async function hasWriteAccess(
  github: GitHub,
  owner: string,
  repo: string,
  username: string,
): Promise<boolean> {
  try {
    const { data } = await github.rest.repos.getCollaboratorPermissionLevel({
      owner,
      repo,
      username,
    });
    return data.permission === "admin" || data.permission === "write";
  } catch {
    return false;
  }
}

export default async function dispatchReviewer({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<void> {
  const run = (context.payload as WebhookEvent<"workflow-run", "completed">).workflow_run;
  if (
    context.eventName !== "workflow_run" ||
    run?.name !== PULL_REQUEST_EVENT_WORKFLOW ||
    run.event !== "pull_request" ||
    run.conclusion !== "success"
  ) {
    core.info("Not a successful Pull Request Event intake run; nothing to dispatch");
    return;
  }

  const hint = parseIntakeHint(run.display_title);
  if (!hint) {
    core.info(`Unrecognized intake run-name: ${JSON.stringify(run.display_title)}`);
    return;
  }

  const { owner, repo } = context.repo;
  const { data: pull } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: hint.issueNumber,
  });
  // Bind the untrusted PR number to the GitHub-set repositories of the intake run.
  if (pull.base.repo.id !== run.repository.id || pull.head.repo?.id !== run.head_repository?.id) {
    core.info(`PR #${hint.issueNumber} does not belong to the intake run; ignoring`);
    return;
  }

  const route = selectReviewerRoute(
    hint,
    {
      state: pull.state,
      draft: pull.draft ?? false,
      headSha: pull.head.sha,
      labels: pull.labels.map((label) => label.name),
    },
    run.head_sha,
  );
  if (!route) {
    core.info(`No reviewer route for ${JSON.stringify(hint)}`);
    return;
  }

  const actor = run.triggering_actor?.login ?? "";
  if (!actor || !(await hasWriteAccess(github, owner, repo, actor))) {
    core.info(`Triggering actor '${actor}' lacks write access; not dispatching ${route.workflow}`);
    return;
  }

  if (route.labelEvent) {
    const events = await github.paginate(github.rest.issues.listEvents, {
      owner,
      repo,
      issue_number: hint.issueNumber,
      per_page: PER_PAGE_MAX,
    });
    if (!isLatestLabelEvent(events, route.labelEvent, actor)) {
      core.info(
        `Latest '${route.labelEvent.label}' event is not '${route.labelEvent.action}' by '${actor}'; ignoring`,
      );
      return;
    }
  }

  await github.rest.actions.createWorkflowDispatch({
    owner,
    repo,
    workflow_id: route.workflow,
    ref: pull.base.repo.default_branch,
    inputs: route.inputs,
  });
  core.info(`Dispatched ${route.workflow} for PR #${hint.issueNumber} (${hint.action})`);
}
