import { PER_PAGE_MAX } from "../../../shared/src/github.ts";
import type { GitHub, GitHubScriptArgs, WebhookEvent } from "../github.ts";
import { PULL_REQUEST_EVENT_WORKFLOW } from "../pull-request-event.ts";
import { parseIntakeHint } from "../reviewer-dispatch.ts";
import { setPackageNameStatus } from "./status-check.ts";
import { validateLabelChange } from "./validate-approval.ts";

/*
  Trusted replacement for the pull_request_target trigger of package-name-approval-validation.
  Runs on workflow_run of the unprivileged "Pull Request Event" intake.

  Trust model:
  - Trusted: GitHub-set workflow_run fields (triggering_actor, created_at, repository,
    head_repository) and API reads made here.
  - Untrusted: the intake run-name (`PR #<n> <action>[ <label>]`). It only selects what to check.
    The label change itself, including its actor, is read from the PR's issue events, must be the
    latest event for that label, must be by the triggering actor, and must be recent. The actor is
    then authorized by validateLabelChange, exactly as for the old pull_request_target payload.
  - The intake only runs for open PRs. Label changes made while a PR was closed are replayed when
    it is reopened, so reopening cannot bypass approvals.
*/

/** Max age of the confirmed issue event relative to the intake run. */
export const EVENT_WINDOW_MS = 10 * 60 * 1000;
/** Allowed clock skew between the issue event and the intake run. */
const EVENT_SKEW_MS = 60 * 1000;

export interface IssueEvent {
  event: string;
  created_at: string;
  label?: { name: string };
  actor?: { login: string } | null;
}

type LabelAction = "labeled" | "unlabeled";

const isLabelEvent = (e: IssueEvent): e is IssueEvent & { label: { name: string } } =>
  (e.event === "labeled" || e.event === "unlabeled") && !!e.label?.name;

export function isPackageNameLabel(label: string | undefined): label is string {
  return !!label?.startsWith("package-name-");
}

export function isWithinWindow(eventCreatedAt: string, runCreatedAt: string): boolean {
  const delta = Date.parse(runCreatedAt) - Date.parse(eventCreatedAt);
  return delta <= EVENT_WINDOW_MS && delta >= -EVENT_SKEW_MS;
}

/** Latest labeled/unlabeled event for the label, or undefined. */
export function latestLabelEvent(events: IssueEvent[], label: string): IssueEvent | undefined {
  return events.filter((e) => isLabelEvent(e) && e.label.name === label).at(-1);
}

/**
 * Package-name label changes to replay for a reopen: for each package-name label, its latest
 * change between the last close and the reopen, if that change is still its latest overall.
 * Removals come first, so an unauthorized removal is restored before any approval is evaluated
 * against the label set. Otherwise chronological.
 */
export function selectReopenReplays(
  events: IssueEvent[],
  reopenIndex: number,
): (IssueEvent & { label: { name: string } })[] {
  const closeIndex = events.findLastIndex((e, i) => i < reopenIndex && e.event === "closed");
  const latestInWindow = new Map<string, number>();
  for (let i = closeIndex + 1; i < reopenIndex; i++) {
    const e = events[i];
    if (isLabelEvent(e) && isPackageNameLabel(e.label.name)) {
      latestInWindow.set(e.label.name, i);
    }
  }
  const rank = (i: number) => (events[i].event === "unlabeled" ? 0 : 1);
  return [...latestInWindow.entries()]
    .filter(([label, i]) => latestLabelEvent(events, label) === events[i])
    .sort(([, a], [, b]) => rank(a) - rank(b) || a - b)
    .map(([, i]) => events[i] as IssueEvent & { label: { name: string } });
}

async function currentLabels(github: GitHub, owner: string, repo: string, prNumber: number) {
  const { data: pull } = await github.rest.pulls.get({ owner, repo, pull_number: prNumber });
  return { pull, labels: pull.labels.map((label) => label.name) };
}

export default async function handlePackageNamePrEvent(args: GitHubScriptArgs): Promise<void> {
  const { github, context, core } = args;
  const run = (context.payload as WebhookEvent<"workflow-run", "completed">).workflow_run;
  if (
    context.eventName !== "workflow_run" ||
    run?.name !== PULL_REQUEST_EVENT_WORKFLOW ||
    run.event !== "pull_request" ||
    run.conclusion !== "success"
  ) {
    core.info("Not a successful Pull Request Event intake run; nothing to do");
    return;
  }

  const hint = parseIntakeHint(run.display_title);
  const isLabelHint =
    (hint?.action === "labeled" || hint?.action === "unlabeled") && isPackageNameLabel(hint.label);
  if (!hint || (!isLabelHint && hint.action !== "reopened")) {
    core.info(`No package-name work for intake run ${JSON.stringify(run.display_title)}`);
    return;
  }

  const actor = run.triggering_actor?.login;
  if (!actor) {
    core.info("Intake run has no triggering actor; ignoring");
    return;
  }

  const { owner, repo } = context.repo;
  const prNumber = hint.issueNumber;
  const { pull } = await currentLabels(github, owner, repo, prNumber);
  // Bind the untrusted PR number to the GitHub-set repositories of the intake run.
  if (pull.base.repo.id !== run.repository.id || pull.head.repo?.id !== run.head_repository?.id) {
    core.info(`PR #${prNumber} does not belong to the intake run; ignoring`);
    return;
  }

  const events: IssueEvent[] = await github.paginate(github.rest.issues.listEvents, {
    owner,
    repo,
    issue_number: prNumber,
    per_page: PER_PAGE_MAX,
  });

  const replay = async (action: LabelAction, targetLabel: string, labelActor: string) => {
    const { labels } = await currentLabels(github, owner, repo, prNumber);
    await validateLabelChange({
      ...args,
      change: { owner, repo, prNumber, action, targetLabel, actor: labelActor, labels },
    });
  };

  if (isLabelHint) {
    const action = hint.action as LabelAction;
    const label = hint.label as string;
    const latest = latestLabelEvent(events, label);
    const present = pull.labels.some((l) => l.name === label);
    if (
      latest?.event !== action ||
      latest.actor?.login !== actor ||
      !isWithinWindow(latest.created_at, run.created_at) ||
      present !== (action === "labeled")
    ) {
      core.info(`Latest '${label}' event is not a recent '${action}' by '${actor}'; ignoring`);
      return;
    }
    await replay(action, label, actor);
  } else {
    const reopenIndex = events.findLastIndex((e) => e.event === "reopened");
    const reopen = events[reopenIndex];
    if (
      !reopen ||
      reopen.actor?.login !== actor ||
      !isWithinWindow(reopen.created_at, run.created_at)
    ) {
      core.info(`Latest reopen is not a recent reopen by '${actor}'; ignoring`);
      return;
    }
    const replays = selectReopenReplays(events, reopenIndex);
    for (const e of replays) {
      if (!e.actor?.login) {
        continue;
      }
      core.info(`Replaying '${e.event} ${e.label.name}' by '${e.actor.login}' from while closed`);
      await replay(e.event as LabelAction, e.label.name, e.actor.login);
    }
  }

  if (pull.state === "open") {
    await setPackageNameStatus({ github, core, owner, repo, prNumber });
  }
}
