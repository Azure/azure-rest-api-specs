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
    event_name
  });
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
 * @returns {Promise<void>}
 */
export async function summarizeChecksImpl({
  owner,
  repo,
  issue_number,
  head_sha,
  github,
  core,
  event_name,
}) {
  // todo: evaluate whether it is worth it to try to have multiple output types for labeling and pr commenting. Right now the label action
  // does a version of this where the labels that should be adjusted are published as artifacts leveraging the output of the getLabelAction call,
  // then those artifacts as used as inputs to the actual labeling action. If there are clear benefits (as far as speed and token utilization)
  // there, then we will refactor to do the same.

  // if there isn't any real benefit as far as token utilizaxtion, then having everything in code here seems to be more straightforward
  // both in testing and implementation.
  if (event_name in ["labeled", "unlabeled"]) {
    handleLabeledEvent({
      owner,
      repo,
      issue_number,
      head_sha,
      github,
      core,
      event_name
    });

    return;
  }


  //   const { data: user } = await github.rest.users.getAuthenticated();
  //   console.log(`Authenticated as: ${user.login}`);
  //   const { data: runs } = await github.rest.checks.listForRef({
  //       owner,
  //       repo,
  //       ref: head_sha,
  //   });

  // // fetch the combined status for this SHA
  // const { data: status } = await github.rest.repos.getCombinedStatusForRef({
  //   owner,
  //   repo,
  //   ref: head_sha,
  // });

  // // fetch labels on the pull request
  // let labels = [];
  // try {
  //   const { data: labelsData } = await github.rest.issues.listLabelsOnIssue({
  //     owner,
  //     repo,
  //     issue_number,
  //   });
  //   labels = labelsData.map(label => label.name);
  // } catch (e) {
  //   core.warning(`Failed to fetch PR labels: ${e}`);
  // }

  // // Log the collected information for debugging
  // core.info(`Found ${runs.check_runs.length} check runs`);
  // core.info(`Combined status: ${status.state}`);
  // core.info(`PR labels: ${labels.join(', ')}`);

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
 * @returns {Promise<void>}
 */
export async function handleLabeledEvent({
  owner,
  repo,
  issue_number,
  head_sha,
  github,
  core,
  event_name,
}) {

}
