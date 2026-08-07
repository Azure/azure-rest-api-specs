import { readFile } from "fs/promises";
import yaml from "js-yaml";
import { extractInputs } from "../context.js";
import { removeLabelIfPresent } from "../package-name-approval/labels.js";

/**
 * Intake label for data-plane stewardship review. The merge gate keys off the same label
 * (see `.github/workflows/src/summarize-checks/labelling.js`), so intake, assignment, and
 * the gate share one name. Kept as a constant so it can be changed in one place.
 */
export const TRIGGER_LABEL = "APIStewardshipBoard-ReviewRequested";

/** Path (relative to repo root) to the shared config that also defines the reviewer pool. */
const REVIEWERS_CONFIG_PATH = ".github/protected-labels.yml";

/**
 * Sign-off label — the gated approval that clears the merge gate. Applying it clears the
 * fulfilled {@link TRIGGER_LABEL}. Its authorized-users list in `protected-labels.yml` is
 * also the reviewer pool: the people who can approve are the reviewers, so there is one
 * list to maintain. {@link TRIGGER_LABEL} is machine-applied and not gated.
 */
export const SIGNOFF_LABEL = "APIStewardshipBoard-SignedOff";

/** Label in `protected-labels.yml` whose authorized-users list defines the reviewer pool. */
const POOL_LABEL = SIGNOFF_LABEL;

/**
 * Load the review pool from the shared `protected-labels.yml` config.
 *
 * The pool is the authorized-users list of {@link POOL_LABEL}. That value is either a flat
 * array of logins or an object keyed by plane (`{ "management-plane": [...], "data-plane":
 * [...] }`); both shapes are flattened here.
 *
 * @param {string} [path]
 * @param {string} [label]
 * @returns {Promise<string[]>} Deduplicated list of reviewer logins.
 */
export async function loadReviewerPool(path = REVIEWERS_CONFIG_PATH, label = POOL_LABEL) {
  const content = await readFile(path, "utf8");
  const config = /** @type {Record<string, unknown>} */ (yaml.load(content) ?? {});
  const entry = config[label];

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
 * Assign or remove the stewardship review pool based on a label event.
 *
 * Runs on `pull_request_target` `labeled` / `unlabeled` events. On {@link TRIGGER_LABEL}
 * added: requests every pool member as a reviewer and adds them as assignees (assignment
 * always sends a GitHub notification, even when a review request cannot be created). On
 * {@link TRIGGER_LABEL} removed: removes the pool members the automation added, leaving
 * manually-added reviewers/assignees in place. On {@link SIGNOFF_LABEL} added: clears the
 * fulfilled request label.
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function assignReviewers({ github, context, core }) {
  const payload =
    /** @type {import("@octokit/webhooks-types").PullRequestLabeledEvent | import("@octokit/webhooks-types").PullRequestUnlabeledEvent} */ (
      context.payload
    );

  const targetLabel = payload.label?.name;

  // Sign-off completes the review, so clear the fulfilled request label. Assignees stay in
  // place (a lingering second reviewer in a 2-person pool is fine). Removing the label with
  // the default token does not re-trigger this workflow.
  if (payload.action === "labeled" && targetLabel === SIGNOFF_LABEL) {
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
  const prNumber = issue_number;
  const author = payload.pull_request.user?.login ?? "";

  const pool = await loadReviewerPool();
  if (pool.length === 0) {
    core.warning("Data-plane review pool is empty; nothing to assign.");
    return;
  }

  // A PR author cannot review or be requested to review their own PR.
  const candidates = pool.filter((login) => login.toLowerCase() !== author.toLowerCase());

  if (payload.action === "unlabeled") {
    return await unassignPool({ github, core, owner, repo, prNumber, pool });
  }

  if (candidates.length === 0) {
    core.info(`All pool members are the PR author (${author}); nothing to assign.`);
    return;
  }

  await assignPool({ github, core, owner, repo, prNumber, candidates, payload });
}

/**
 * On sign-off, clear the fulfilled {@link TRIGGER_LABEL} so the request no longer shows as
 * pending. Reviewers/assignees are left in place. No comment is posted, matching the ARM
 * sign-off flows. Safe against the merge gate: once {@link SIGNOFF_LABEL} is present the
 * gate's required-label condition is already satisfied.
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
  const currentLabels = (payload.pull_request.labels ?? []).map((label) => label.name);
  if (!currentLabels.includes(TRIGGER_LABEL)) {
    core.info(`'${TRIGGER_LABEL}' not present on PR #${prNumber}; nothing to clear on sign-off.`);
    return;
  }

  await removeLabelIfPresent(github, owner, repo, prNumber, TRIGGER_LABEL);
  core.info(`Sign-off recorded on PR #${prNumber}; cleared '${TRIGGER_LABEL}'.`);
}

/**
 * @param {object} params
 * @param {import("@actions/github-script").AsyncFunctionArguments["github"]} params.github
 * @param {import("@actions/github-script").AsyncFunctionArguments["core"]} params.core
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {number} params.prNumber
 * @param {string[]} params.candidates
 * @param {import("@octokit/webhooks-types").PullRequestLabeledEvent} params.payload
 */
async function assignPool({ github, core, owner, repo, prNumber, candidates, payload }) {
  // Skip reviewers already requested so repeated label events do not re-notify.
  // requested_reviewers is typed as (User | Team)[]; only Users have a login.
  const requestedReviewers = /** @type {{ login?: string }[]} */ (
    /** @type {unknown} */ (payload.pull_request.requested_reviewers ?? [])
  );
  const alreadyRequested = requestedReviewers.map((reviewer) => reviewer.login ?? "");
  const reviewersToRequest = candidates.filter((login) => !includesLogin(alreadyRequested, login));

  if (reviewersToRequest.length > 0) {
    try {
      await github.rest.pulls.requestReviewers({
        owner,
        repo,
        pull_number: prNumber,
        reviewers: reviewersToRequest,
      });
      core.info(`Requested review from: ${reviewersToRequest.join(", ")}`);
    } catch (error) {
      // requestReviewers 422s if a login is not a collaborator with pull access.
      // Assignment below still notifies them, so this is non-fatal.
      const message = error instanceof Error ? error.message : "unknown error";
      core.warning(`Could not request reviewers (${reviewersToRequest.join(", ")}): ${message}`);
    }
  }

  // Assignees are additive and GitHub ignores logins without access, so no pre-filter is
  // needed; this is a safe notification backstop.
  const alreadyAssigned = (payload.pull_request.assignees ?? []).map(
    (/** @type {{ login?: string }} */ assignee) => assignee.login ?? "",
  );
  const assigneesToAdd = candidates.filter((login) => !includesLogin(alreadyAssigned, login));
  if (assigneesToAdd.length > 0) {
    try {
      await github.rest.issues.addAssignees({
        owner,
        repo,
        issue_number: prNumber,
        assignees: assigneesToAdd,
      });
      core.info(`Assigned: ${assigneesToAdd.join(", ")}`);
    } catch (error) {
      const message = error instanceof Error ? error.message : "unknown error";
      core.warning(`Could not add assignees (${assigneesToAdd.join(", ")}): ${message}`);
    }
  }
}

/**
 * @param {object} params
 * @param {import("@actions/github-script").AsyncFunctionArguments["github"]} params.github
 * @param {import("@actions/github-script").AsyncFunctionArguments["core"]} params.core
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {number} params.prNumber
 * @param {string[]} params.pool
 */
async function unassignPool({ github, core, owner, repo, prNumber, pool }) {
  const { data: pr } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: prNumber,
  });

  const requested = (pr.requested_reviewers ?? []).map(
    (/** @type {{ login?: string }} */ reviewer) => reviewer.login ?? "",
  );
  const reviewersToRemove = requested.filter((login) => includesLogin(pool, login));
  if (reviewersToRemove.length > 0) {
    try {
      await github.rest.pulls.removeRequestedReviewers({
        owner,
        repo,
        pull_number: prNumber,
        reviewers: reviewersToRemove,
      });
      core.info(`Removed review request from: ${reviewersToRemove.join(", ")}`);
    } catch (error) {
      const message = error instanceof Error ? error.message : "unknown error";
      core.warning(`Could not remove requested reviewers: ${message}`);
    }
  }

  // Only remove assignees the automation manages (pool members); never touch
  // manually-added assignees.
  const assignees = (pr.assignees ?? []).map(
    (/** @type {{ login?: string }} */ assignee) => assignee.login ?? "",
  );
  const assigneesToRemove = assignees.filter((login) => includesLogin(pool, login));
  if (assigneesToRemove.length > 0) {
    try {
      await github.rest.issues.removeAssignees({
        owner,
        repo,
        issue_number: prNumber,
        assignees: assigneesToRemove,
      });
      core.info(`Unassigned: ${assigneesToRemove.join(", ")}`);
    } catch (error) {
      const message = error instanceof Error ? error.message : "unknown error";
      core.warning(`Could not remove assignees: ${message}`);
    }
  }
}
