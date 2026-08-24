import { extractInputs } from "../context.js";

/**
 * Intake label for data-plane stewardship review. The merge gate keys off the same label
 * (see `.github/workflows/src/summarize-checks/labelling.js`), so intake, assignment, and
 * the gate share one name. Kept as a constant so it can be changed in one place.
 */
export const TRIGGER_LABEL = "data-plane-review-requested";

/**
 * Sign-off label: the durable approval that satisfies the merge gate. It coexists with
 * {@link TRIGGER_LABEL}; this workflow never removes the request label. Who may apply it is
 * enforced centrally by the protected-labels workflow.
 */
export const SIGNOFF_LABEL = "data-plane-review-signoff";

/**
 * GitHub team requested as reviewer on intake. The team has code-review auto-assignment, so
 * GitHub delegates the team request to a member; this workflow only requests the team.
 * Unifying assignment + sign-off authorization onto this team is tracked in #45487.
 */
export const REVIEWER_TEAM = "azure-data-plane-api-reviewers";

/**
 * Assign the stewardship review team.
 *
 * Two entry paths:
 * 1. `pull_request_target: labeled` — a manual {@link TRIGGER_LABEL} requests the team.
 * 2. `workflow_run` on "Summarize Checks" — reconciles the auto-applied {@link TRIGGER_LABEL}
 *    (see {@link assignFromWorkflowRun}).
 *
 * Sign-off and `unlabeled` are not handled: {@link SIGNOFF_LABEL} gates merge on its own, and
 * native delegation owns the individual reviewer.
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function assignReviewers({ github, context, core }) {
  if (context.eventName === "workflow_run") {
    return await assignFromWorkflowRun({ github, context, core });
  }

  const payload = /** @type {import("@octokit/webhooks-types").PullRequestLabeledEvent} */ (
    context.payload
  );

  const targetLabel = payload.label?.name;

  if (targetLabel !== TRIGGER_LABEL) {
    core.info(`Label '${targetLabel}' is not '${TRIGGER_LABEL}', skipping.`);
    return;
  }

  const { owner, repo, issue_number } = await extractInputs(github, context, core);
  await requestReviewerTeam({ github, core, owner, repo, prNumber: issue_number });
}

/**
 * Reconcile the team request after "Summarize Checks" completes. The intake label is
 * auto-applied with the default `GITHUB_TOKEN`, which does not re-trigger `labeled` workflows,
 * so this is the only path that reacts to it.
 *
 * With no label payload, the decision reads live PR state: request only when the PR is open,
 * non-draft, still carries {@link TRIGGER_LABEL}, and is not signed off. All conditions are
 * idempotent, and {@link requestReviewerTeam} dedupes the request itself.
 *
 * @param {Pick<import("@actions/github-script").AsyncFunctionArguments, "github" | "context" | "core">} args
 */
async function assignFromWorkflowRun({ github, context, core }) {
  const { owner, repo, issue_number } = await extractInputs(github, context, core);
  if (!issue_number) {
    core.info("No pull request resolved from the workflow_run event; nothing to assign.");
    return;
  }

  const { data: pr } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: issue_number,
  });

  if (pr.state !== "open" || pr.draft) {
    core.info(
      `PR #${issue_number} is ${pr.draft ? "a draft" : `'${pr.state}'`}; not requesting review.`,
    );
    return;
  }

  const labelNames = (pr.labels ?? []).map((label) =>
    typeof label === "string" ? label : (label?.name ?? ""),
  );

  if (!labelNames.includes(TRIGGER_LABEL)) {
    core.info(`'${TRIGGER_LABEL}' not present on PR #${issue_number}; nothing to assign.`);
    return;
  }

  if (labelNames.includes(SIGNOFF_LABEL)) {
    core.info(`PR #${issue_number} is already signed off; not requesting review.`);
    return;
  }

  await requestReviewerTeam({ github, core, owner, repo, prNumber: issue_number });
}

/**
 * Request {@link REVIEWER_TEAM} so its code-review auto-assignment delegates to a member.
 * Requests at most once per PR: dedupes on the durable `review_requested` timeline event,
 * which survives delegation swapping the team for an individual (the live `requested_teams`
 * is emptied on delegation, so it alone would let a later run re-request and re-notify).
 *
 * @param {object} params
 * @param {import("@actions/github-script").AsyncFunctionArguments["github"]} params.github
 * @param {import("@actions/github-script").AsyncFunctionArguments["core"]} params.core
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {number} params.prNumber
 */
async function requestReviewerTeam({ github, core, owner, repo, prNumber }) {
  const events = await github.paginate(github.rest.issues.listEvents, {
    owner,
    repo,
    issue_number: prNumber,
    per_page: 100,
  });
  const alreadyRequested = events.some((event) => {
    if (event.event !== "review_requested") return false;
    const requestedTeam = /** @type {{ requested_team?: { slug?: string } }} */ (event)
      .requested_team;
    return (requestedTeam?.slug ?? "").toLowerCase() === REVIEWER_TEAM.toLowerCase();
  });
  if (alreadyRequested) {
    core.info(`Team '${REVIEWER_TEAM}' was already requested on PR #${prNumber}; nothing to do.`);
    return;
  }

  await github.rest.pulls.requestReviewers({
    owner,
    repo,
    pull_number: prNumber,
    team_reviewers: [REVIEWER_TEAM],
  });
  core.info(`Requested review from team '${REVIEWER_TEAM}'.`);
}
