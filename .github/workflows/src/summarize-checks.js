// import { setEquals } from "../../shared/src/equality.js";
import { extractInputs } from "./context.js";
// import { PER_PAGE_MAX } from "./github.js";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export default async function summarizeChecks({ github, context, core }) {
  let owner = process.env.OWNER || "";
  let repo = process.env.REPO || "";
  let issue_number = parseInt(process.env.ISSUE_NUMBER || "");
  let head_sha = process.env.HEAD_SHA || "";
  let event_name = process.env.TRIGGER_EVENT || "";

  logGitHubRateLimitInfo({ github, context, core });

  const { data: user } = await github.rest.users.getAuthenticated();
  console.log(`Authenticated as: ${user.login}`);

  if (!owner || !repo || !issue_number || !head_sha) {
    let inputs = await extractInputs(github, context, core);
    owner = owner || inputs.owner;
    repo = repo || inputs.repo;
    issue_number = issue_number || inputs.issue_number;
    head_sha = head_sha || inputs.head_sha;
    event_name = event_name || context.event_name;
  }

  await summarizeChecksImpl({
    owner,
    repo,
    issue_number,
    head_sha,
    github,
    core,
    event_name,
    context
  });
}

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export async function logGitHubRateLimitInfo({ github, context, core }) {
  try {
    // rateLimit doesn’t include app info. To fetch your GitHub App’s ID:
    const rateLimit = await github.rateLimit.get();

    await core.info(`GitHub RateLimit Info: ${JSON.stringify(rateLimit)}`);
  } catch (e) {
    await core.error(`GitHub RateLimit Info: error emitting. Exception: ${e}`);
  }
}

/**
 * @param {Object} params
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {number} params.issue_number
 * @param {string} params.head_sha
 * @param {string} params.event_name
 * @param {(import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api & { paginate: import("@octokit/plugin-paginate-rest").PaginateInterface; })} params.github
 * @param {typeof import("@actions/core")} params.core
 * @param {import("@actions/github").context} params.context
 * @returns {Promise<void>}
 */
export async function summarizeChecksImpl({
  owner,
  repo,
  issue_number,
  head_sha,
  event_name,
  github,
  core,
  context
}) {
  core.info(`Handling ${event_name} event for PR #${issue_number} in ${owner}/${repo}`);

  // no matter what, we will need the labels for the PR, so let's fetch them first
  const { data: labels } = await github.rest.issues.listLabelsOnIssue({
    owner,
    repo,
    issue_number,
  });
  const labelNames = labels.map(label => label.name);

  // handle our label trigger first, we may bail out early if it's a label action we're reacting to
  if (event_name in ["labeled", "unlabeled"]) {
    handleLabeledEvent({
      owner,
      repo,
      issue_number,
      event_name,
      known_labels: labelNames,
      github,
      core,
      context
    });

    return;
  }

  // now continue on to the handling of the checks statuses
  // if they are not all completed, we should bail out early.
  // Should I look at runs or status?
  const { data: runs } = await github.rest.checks.listForRef({
      owner,
      repo,
      ref: head_sha,
  });
  const { data: status } = await github.rest.repos.getCombinedStatusForRef({
    owner,
    repo,
    ref: head_sha,
  });
}

/**
 * @param {Object} params
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {number} params.issue_number
 * @param {string} params.event_name
 * @param {string[]} params.known_labels
 * @param {(import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api & { paginate: import("@octokit/plugin-paginate-rest").PaginateInterface; })} params.github
 * @param {typeof import("@actions/core")} params.core
 * @param {import("@actions/github").context} params.context
 * @returns {Promise<void>}
 */
export async function handleLabeledEvent({
  owner,
  repo,
  issue_number,
  event_name,
  known_labels,
  github, // this will be utilized as soon as we cut over to actually attempting to remove the label
  core,
  context
}) {

  // logic for this event is based on code directly ripped from pipelinebot:
  // private/openapi-kebab/src/bots/pipeline/pipelineBotOnPRLabelEvent.ts
  const changedLabel = context.payload.label?.name;
  const labelsToAdd = new Set();
  const labelsToRemove = new Set();

  if (event_name === "labeled") {
    if (changedLabel == "ARMChangesRequested") {
      if (known_labels.indexOf("WaitForARMFeedback") !== -1) {
        labelsToRemove.add("WaitForARMFeedback");
      }
    }
    if (changedLabel == "ARMSignedOff") {
      if (known_labels.indexOf("WaitForARMFeedback") !== -1) {
        labelsToRemove.add("WaitForARMFeedback");
      }
      if (known_labels.indexOf("ARMChangesRequested") !== -1) {
        labelsToRemove.add("ARMChangesRequested");
      }
    }

    for (const label of labelsToRemove) {
      core.info(`Removing label: ${label} from ${owner}/${repo}#${issue_number}.`);
      // await github.rest.issues.removeLabel({
      //   owner: owner,
      //   repo: repo,
      //   issue_number: issue_number,
      //   name: label,
      // });
    }
  }
  else if (event_name === "unlabeled") {
      if (changedLabel == "ARMChangesRequested") {
      if (known_labels.indexOf("WaitForARMFeedback") !== -1) {
        labelsToAdd.add("WaitForARMFeedback");
      }
    }

    if (labelsToAdd.size > 0) {
      core.info(`Adding labels: ${Array.from(labelsToAdd).join(", ")} to ${owner}/${repo}#${issue_number}.`);
      // await github.rest.issues.addLabels({
      //   owner: owner,
      //   repo: repo,
      //   issue_number: issue_number,
      //   labels: Array.from(labelsToAdd),
      // });
    }
  }
}
