/*
  This file is intended to be used within a github script action. It is intended to replace older probot
  automation bots that were used to summarize the status of checks on a PR.

  It will trigger on:

  - PR label addition / removal
  - when one of a set of workflows completes:

  While handling the incoming trigger, it will:

  - Apply or remove labels from the PR based on the status of the checks and other labels
  - Create or update a comment that summarizes the user's "next steps to merge" on the PR.

  This script is a replacement for the old pipelinebot infrastructure from open-api-alps repository.
*/

import { extractInputs } from "./context.js";

/**
 * @typedef {Object} RunInfo
 * @property {string} status
 * @property {string} conclusion
 * @property {string} name
 * @property {number[]} pullrequests
 */

/**
 * @typedef {Object} CheckRunData
 * @property {string} name
 * @property {string} status
 * @property {string} conclusion
 */

// Placing these configuration items here until we decide another way to pull them in.
const FYI_CHECK_NAMES = [
  "Swagger LintDiff",
  "SDK Validation Status",
  "Swagger BreakingChange",
  "Swagger PrettierCheck"
];

// during renderAutomatedMergingRequirementsMetCheck we resolve the result of
// automated merge requirements met by from the result of and(requiredChecks).
// if any are pending, automated merging requirements is pending. This is ripe for complete removal
// in favor of just honoring the `required` checks results directly.
const EXCLUDED_CHECK_NAMES = []

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


  // Get the target branch of the PR
  const targetBranch = context.payload.pull_request?.base?.ref;
  core.info(`PR target branch: ${targetBranch}`);

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

  const checkRunTuple = await getCheckRunTuple(github, core, owner, repo, head_sha, issue_number, [])

  // topics to examine:
    // private/openapi-kebab/src/bots/pipeline/pipelineEventListener/renderAutomatedMergingRequirementsMetCheck.ts
    // applyRenderAutomatedMergingRequirementsMetCheck (this is what updates the 'Automated Merge Requirements Met' check)
    // I doubt we will keep that around, as the REquired vs NonRequired should really be the method that we go with
    // I'm only keeping this around until I can understand the need of it

  // when processing the nextstepstomerge comment, we actually are checking a couple situations:
  // 1. We process the required labeling rules from the ARM team. This code used to be in openapi-kebab
  //    private/openapi-kebab/src/bots/pipeline/pipelineEventListener/requiredLabelsRules.ts. We need to pull these across
  //    and refactor them to work with the runs and labels we have pulled down.

  // 2. We process the checks that are failed

  // 3. generate markdown from the above outputs and output in a comment on the PR.

  console.log(checkRunTuple);
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

/**
 *
 * @param {string} owner
 * @param {string} repo
 * @param {string} commentId
 * @param {string[]} labels
 * @param {RunInfo[]} runs
 */
export async function createNextStepsCommentBody(owner, repo, commentId, labels, runs) {

}

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export async function logGitHubRateLimitInfo({ github, context, core }) {
  try {
    const rateLimit = await github.rateLimit.get();

    await core.info(`GitHub RateLimit Info: ${JSON.stringify(rateLimit)}`);
  } catch (e) {
    await core.error(`GitHub RateLimit Info: error emitting. Exception: ${e}`);
  }
}

/**
 * A GraphQL query to GitHub API that returns all check runs for given commit, with "isRequired" field for given PR.
 *
 * If you want to see example response, copy the query body into this:
 * https://docs.github.com/en/graphql/overview/explorer
 * Example inputs:
 * resourceUrl: "https://github.com/test-repo-billy/azure-rest-api-specs/commit/c2789c5bde1b3f4fa34f76a8eeaaed479df23c4d"
 * prNumber: 2996
 *
 * Reference:
 * https://docs.github.com/en/graphql/reference/queries#resource
 * https://docs.github.com/en/graphql/guides/using-global-node-ids#3-do-a-direct-node-lookup-in-graphql
 * https://docs.github.com/en/graphql/reference/objects#checkrun
 * Rate limit:
 * https://docs.github.com/en/graphql/overview/resource-limitations#rate-limit
 * https://docs.github.com/en/graphql/reference/objects#ratelimit
 *
 * Note: here, for "checkRuns(first: ..)", maybe we should add a filter that filters to LATEST, per:
 * https://docs.github.com/en/graphql/reference/input-objects#checkrunfilter
 * https://docs.github.com/en/graphql/reference/enums#checkruntype
 **/
/**
 * Returns a GraphQL query string for the given resource URL and PR number.
 *
 * @param {string} owner - The URL of the GitHub resource (commit).
 * @param {string} repo - The URL of the GitHub resource (commit).
 * @param {string} sha - targeted commit. context.pr!.headInfo.sha
 * @param {number} prNumber - The pull request number.
 * @returns {string} The GraphQL query string.
 */
function getGraphQLQuery(owner, repo, sha, prNumber) {
  const resourceUrl = `https://github.com/${owner}/${repo}/commit/${sha}`

  return `
    {
      resource(url: "${resourceUrl}") {
        ... on Commit {
          checkSuites(first: 20) {
            nodes {
              checkRuns(first: 30) {
                nodes {
                  name
                  status
                  conclusion
                  isRequired(pullRequestNumber: ${prNumber})
                }
              }
            }
          }
        }
      }
      rateLimit {
        limit
        cost
        used
        remaining
        resetAt
      }
    }
  `;
}

/**
 * @param {(import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api & { paginate: import("@octokit/plugin-paginate-rest").PaginateInterface; })} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner - The repository owner.
 * @param {string} repo - The repository name.
 * @param {string} head_sha - The commit SHA to check.
 * @param {number} prNumber - The pull request number.
 * @param {string[]} excludedCheckNames
 * @returns {Promise<[CheckRunData[], CheckRunData[], CheckRunData | undefined]>}
 */
// this used to be getRequiredAndFyiAndAutomatedMergingRequirementsMetCheckRuns
export async function getCheckRunTuple(
  github,
  core,
  owner,
  repo,
  head_sha,
  prNumber,
  excludedCheckNames
) {

  /** @type {CheckRunData[]} */
  let reqCheckRuns = []
  /** @type {CheckRunData[]} */
  let fyiCheckRuns = []
  let automatedMergingRequirementsMetCheckRun = undefined
  try {

    // Use GitHub GraphQL API
    const response = await github.graphql(getGraphQLQuery(owner, repo, head_sha, prNumber));
    // Added on 8/13/2023 to monitor if the just-added reliance on obtaining check run statues from GitHub GraphQL API directly
    // will cause problems with reaching rate limits.
    core.info(`Graph QL Rate Limit Information: ${JSON.stringify(response.rateLimit)}`, );

    [reqCheckRuns, fyiCheckRuns, automatedMergingRequirementsMetCheckRun] = extractRunsFromGraphQLResponse(response);

  } catch (error) {
    core.error(`Failed to obtain check runs from GraphQL. prNumber: ${prNumber}, headOid: ${head_sha}, error: '${error}'. `);
  }

  core.info(`requiredCheckRuns: ${JSON.stringify(reqCheckRuns)}, `
    + `fyiCheckRuns: ${JSON.stringify(fyiCheckRuns)}, `
    + `automatedMergingRequirementsMetCheckRun: `
    + `${automatedMergingRequirementsMetCheckRun != undefined ? JSON.stringify(automatedMergingRequirementsMetCheckRun) : undefined}`);

  const filteredReqCheckRuns = reqCheckRuns.filter(
    /**
     * @param {CheckRunData} checkRun
     */
    (checkRun) => !excludedCheckNames.includes(checkRun.name)
  );
  const filteredFyiCheckRuns = fyiCheckRuns.filter(
    /**
     * @param {CheckRunData} checkRun
     */
    (checkRun) => !excludedCheckNames.includes(checkRun.name)
  );

  warnOnMissingPrWorkflowInfo(filteredReqCheckRuns);

  return [filteredReqCheckRuns, filteredFyiCheckRuns, automatedMergingRequirementsMetCheckRun]
}

/**
 * @param {any} response - GraphQL response data
 * @returns {[CheckRunData[], CheckRunData[], CheckRunData | undefined]}
 */
function extractRunsFromGraphQLResponse(response) {
  /** @type {CheckRunData[]} */
  const reqCheckRuns = []
  /** @type {CheckRunData[]} */
  const fyiCheckRuns = []
  /** @type {CheckRunData | undefined} */
  let automatedMergingRequirementsMetCheckRun = undefined

  // Define the automated merging requirements check name
  const automatedMergingRequirementsMetCheckName = "Automated Merging Requirements Met";

  if (response.resource?.checkSuites?.nodes) {
    response.resource.checkSuites.nodes.forEach(
      /** @param {{ checkRuns?: { nodes?: any[] } }} checkSuiteNode */
      (checkSuiteNode) => {
      if (checkSuiteNode.checkRuns?.nodes) {
        checkSuiteNode.checkRuns.nodes.forEach((checkRunNode) => {
          if (checkRunNode.isRequired) {
            reqCheckRuns.push({
              name: checkRunNode.name,
              status: checkRunNode.status,
              conclusion: checkRunNode.conclusion,
            });
          }
          // Note the "else" here. It means that:
          // A GH check will be bucketed into "failing FYI check run" if:
          // - It is failing
          // - AND is is NOT marked as 'required' in GitHub branch policy
          // - AND it is marked as 'FYI' in this file's FYI_CHECK_NAMES array
          else if (FYI_CHECK_NAMES.includes(checkRunNode.name)) {
            fyiCheckRuns.push({
              name: checkRunNode.name,
              status: checkRunNode.status,
              conclusion: checkRunNode.conclusion,
            });
          }
          // Note we return automatedMergingRequirementsMetCheck separately, because we must return it even if it is not marked as 'required'.
          // This case may happen when a PR is targeting a branch which has no checks marked as 'required', e.g. a user dev branch.
          // We obtain reference to this check, even if not 'required', to update the "Next steps to merge" comment.
          if (checkRunNode.name == automatedMergingRequirementsMetCheckName) {
            automatedMergingRequirementsMetCheckRun = {
              name: checkRunNode.name,
              status: checkRunNode.status,
              conclusion: checkRunNode.conclusion,
            }
          }
        });
      }
    });
  }
  return [reqCheckRuns, fyiCheckRuns, automatedMergingRequirementsMetCheckRun]
}

/**
 * @param {CheckRunData[]} filteredCheckRuns
 */
function warnOnMissingPrWorkflowInfo(filteredCheckRuns) {
  // For now, just log the check runs without workflow info validation
  // This would normally reference checksWorkflowInfo which needs to be imported
  console.log(`Check runs found: ${filteredCheckRuns.map(cr => cr.name).join(", ")}`);
}