import { readFile } from "fs/promises";
import yaml from "js-yaml";
import { extractInputs } from "../context.js";
import { removeLabelIfPresent } from "../package-name-approval/labels.js";
import { ALLOWED_BOT_LOGINS } from "../protected-labels/check-label.js";

/**
 * Intake label for data-plane stewardship review. The merge gate keys off the same label
 * (see `.github/workflows/src/summarize-checks/labelling.js`), so intake, assignment, and
 * the gate share one name. Kept as a constant so it can be changed in one place.
 */
export const TRIGGER_LABEL = "APIStewardshipBoard-ReviewRequested";

/** Path (relative to repo root) to the protected-labels config that lists the sign-off approvers. */
const PROTECTED_LABELS_PATH = ".github/protected-labels.yml";

/**
 * Sign-off label — the gated approval that clears the merge gate. Applying it clears the
 * fulfilled {@link TRIGGER_LABEL}. {@link TRIGGER_LABEL} is machine-applied and not gated.
 * Its authorized-users list in `protected-labels.yml` also gates who may apply it.
 */
export const SIGNOFF_LABEL = "APIStewardshipBoard-SignedOff";

/**
 * GitHub team requested as reviewer on intake. The team has code-review auto-assignment
 * enabled, so GitHub replaces the team request with one of
 * its members using the team's routing algorithm; the workflow never picks the individual,
 * it only requests the team. Kept as a constant here; unifying assignment + sign-off
 * authorization onto this team in config is tracked separately (issue #45487).
 */
export const REVIEWER_TEAM = "azure-data-plane-api-reviewers";

/**
 * Read and parse the shared `protected-labels.yml` config.
 *
 * @returns {Promise<Record<string, unknown>>}
 */
async function loadConfig() {
  const content = await readFile(PROTECTED_LABELS_PATH, "utf8");
  return /** @type {Record<string, unknown>} */ (yaml.load(content) ?? {});
}

/**
 * Flatten a config entry into a deduplicated, trimmed list of logins. An entry is either a
 * flat array of logins or an object keyed by plane (`{ "management-plane": [...],
 * "data-plane": [...] }`); both shapes are supported.
 *
 * @param {unknown} entry
 * @returns {string[]}
 */
function extractLogins(entry) {
  /** @type {unknown[]} */
  let logins = [];
  if (Array.isArray(entry)) {
    logins = entry;
  } else if (entry && typeof entry === "object") {
    logins = Object.values(/** @type {Record<string, unknown>} */ (entry)).flatMap((value) =>
      Array.isArray(value) ? /** @type {unknown[]} */ (value) : [],
    );
  }

  return [
    ...new Set(
      logins
        .filter((/** @type {unknown} */ r) => typeof r === "string" && r.trim().length > 0)
        .map((r) => /** @type {string} */ (r).trim()),
    ),
  ];
}

/**
 * Case-insensitive membership test.
 *
 * @param {string[]} list
 * @param {string} login
 */
function includesLogin(list, login) {
  const lower = login.toLowerCase();
  return list.some((entry) => entry.toLowerCase() === lower);
}

/**
 * Users authorized to apply the gated {@link SIGNOFF_LABEL}: its authorized-users list plus
 * the `global-approvers` list from `protected-labels.yml` (the same set that workflow
 * enforces). Trusted bots are handled separately by the caller via {@link ALLOWED_BOT_LOGINS}.
 *
 * @returns {Promise<string[]>}
 */
async function loadAuthorizedSigners() {
  const config = await loadConfig();
  const signers = extractLogins(config[SIGNOFF_LABEL]);
  const globals = extractLogins(config["global-approvers"]);
  return [...new Set([...signers, ...globals])];
}

/**
 * Assign the stewardship review team or complete the review, based on a label event.
 *
 * Runs on `pull_request_target` `labeled` events. On {@link TRIGGER_LABEL} added:
 * requests {@link REVIEWER_TEAM} as a reviewer; the team's code-review auto-assignment
 * then delegates to one member. On {@link SIGNOFF_LABEL} added: clears the fulfilled
 * {@link TRIGGER_LABEL}. Label removal is not handled: the workflow does not subscribe to
 * `unlabeled` events, because native delegation owns the individual reviewer and the
 * automation never removes a reviewer it did not pick.
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function assignReviewers({ github, context, core }) {
  const payload = /** @type {import("@octokit/webhooks-types").PullRequestLabeledEvent} */ (
    context.payload
  );

  const targetLabel = payload.label?.name;

  // Sign-off completes the review, so clear the fulfilled request label.
  if (targetLabel === SIGNOFF_LABEL) {
    const { owner, repo, issue_number } = await extractInputs(github, context, core);
    return await completeReviewOnSignOff({
      github,
      core,
      owner,
      repo,
      prNumber: issue_number,
      payload,
    });
  }

  if (targetLabel !== TRIGGER_LABEL) {
    core.info(`Label '${targetLabel}' is not '${TRIGGER_LABEL}' or '${SIGNOFF_LABEL}', skipping.`);
    return;
  }

  const { owner, repo, issue_number } = await extractInputs(github, context, core);
  await requestReviewerTeam({ github, core, owner, repo, prNumber: issue_number, payload });
}

/**
 * Request {@link REVIEWER_TEAM} as a reviewer so the team's code-review auto-assignment
 * delegates to one member. Skips the request if the team is already pending on the PR so
 * repeated label events do not queue a second delegation.
 *
 * @param {object} params
 * @param {import("@actions/github-script").AsyncFunctionArguments["github"]} params.github
 * @param {import("@actions/github-script").AsyncFunctionArguments["core"]} params.core
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {number} params.prNumber
 * @param {import("@octokit/webhooks-types").PullRequestLabeledEvent} params.payload
 */
async function requestReviewerTeam({ github, core, owner, repo, prNumber, payload }) {
  // requested_teams lists teams whose request is still pending (before delegation swaps the
  // team for a member). If our team is already pending, another run already requested it.
  const requestedTeams = /** @type {{ slug?: string }[]} */ (
    /** @type {unknown} */ (payload.pull_request.requested_teams ?? [])
  );
  const alreadyRequested = requestedTeams.some(
    (t) => (t.slug ?? "").toLowerCase() === REVIEWER_TEAM.toLowerCase(),
  );
  if (alreadyRequested) {
    core.info(`Team '${REVIEWER_TEAM}' is already a requested reviewer; nothing to do.`);
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

/**
 * On sign-off, clear the fulfilled {@link TRIGGER_LABEL} so the request no longer shows as
 * pending. The assigned reviewer is left in place. No comment is posted, matching the ARM
 * sign-off flows. Safe against the merge gate: once {@link SIGNOFF_LABEL} is present the
 * gate's required-label condition is already satisfied.
 *
 * The signer is verified against the authorized approver list first. Because a label removed
 * with the default token does not re-trigger a workflow, an unverified path could let an
 * unauthorized sign-off clear the request label before `protected-labels` reverts the bogus
 * label. Skipping unauthorized signers keeps that reversal the source of truth.
 *
 * This in-workflow authorization check duplicates the protected-labels authorization list
 * only because the clearing action lives in this separate job. Consolidating the clearing
 * into the trusted central label flow removes this duplicate check; tracked in issue #45494.
 *
 * @param {object} params
 * @param {import("@actions/github-script").AsyncFunctionArguments["github"]} params.github
 * @param {import("@actions/github-script").AsyncFunctionArguments["core"]} params.core
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {number} params.prNumber
 * @param {import("@octokit/webhooks-types").PullRequestLabeledEvent} params.payload
 */
async function completeReviewOnSignOff({ github, core, owner, repo, prNumber, payload }) {
  const signer = payload.sender?.login ?? "";
  if (!ALLOWED_BOT_LOGINS.includes(signer)) {
    const authorizedSigners = await loadAuthorizedSigners();
    if (!includesLogin(authorizedSigners, signer)) {
      core.info(
        `'${signer}' is not authorized to apply '${SIGNOFF_LABEL}'; leaving '${TRIGGER_LABEL}' ` +
          `for the protected-labels workflow to reconcile.`,
      );
      return;
    }
  }

  // Read the labels live rather than from the cached event payload.
  const currentLabels = await github.paginate(github.rest.issues.listLabelsOnIssue, {
    owner,
    repo,
    issue_number: prNumber,
    per_page: 100,
  });
  const currentLabelNames = currentLabels.map((label) => label.name);

  if (!currentLabelNames.includes(SIGNOFF_LABEL)) {
    core.info(
      `'${SIGNOFF_LABEL}' is no longer present on PR #${prNumber}; sign-off was retracted before ` +
        `this ran, leaving '${TRIGGER_LABEL}' in place.`,
    );
    return;
  }

  if (!currentLabelNames.includes(TRIGGER_LABEL)) {
    core.info(`'${TRIGGER_LABEL}' not present on PR #${prNumber}; nothing to clear on sign-off.`);
    return;
  }

  await removeLabelIfPresent(github, owner, repo, prNumber, TRIGGER_LABEL);
  core.info(`Sign-off recorded on PR #${prNumber}; cleared '${TRIGGER_LABEL}'.`);
}
