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

// #region imports/constants

import { extractInputs } from "./context.js";
import { commentOrUpdate } from "./comment.js";

import {
  verRevApproval,
  brChRevApproval,
  getViolatedRequiredLabelsRules
} from "./label-rules.js"

import {
  brchTsg,
  diagramTsg,
  checkAndDiagramTsg,
  defaultTsg,
  reqMetCheckTsg,
  typeSpecRequirementArmTsg,
  typeSpecRequirementDataPlaneTsg,
} from "./tsgs.js";

/**
 * @typedef {Object} CheckMetadata
 * @property {number} precedence
 * @property {string} name
 * @property {string[]} suppressionLabels
 * @property {string} troubleshootingGuide
 */

/**
 * @typedef {Object} CheckRunData
 * @property {string} name
 * @property {string} status
 * @property {string} conclusion
 * @property {CheckMetadata} checkInfo
 */

/**
 * @typedef {import("./label-rules.js").RequiredLabelRule} RequiredLabelRule
 */

// Placing these configuration items here until we decide another way to pull them in.
const FYI_CHECK_NAMES = [
  "Swagger LintDiff",
  "SDK Validation Status",
  "Swagger BreakingChange",
  "Swagger PrettierCheck"
];

const AUTOMATED_CHECK_NAME = "Automated merging requirements met";

/** type {CheckMetadata[]} */
const CHECK_METADATA = [
  {
    precedence: 0,
    name: "TypeSpec Requirement (resource-manager)",
    suppressionLabels: [],
    troubleshootingGuide: typeSpecRequirementArmTsg,
  },
  {
    precedence: 0,
    name: "TypeSpec Requirement (data-plane)",
    suppressionLabels: [],
    troubleshootingGuide: typeSpecRequirementDataPlaneTsg,
  },
  {
    precedence: 0,
    name: "TypeSpec Validation",
    suppressionLabels: [],
    troubleshootingGuide: defaultTsg,
  },
  {
    precedence: 0,
    name: "license/cla",
    suppressionLabels: [],
    troubleshootingGuide: defaultTsg,
  },
  {
    precedence: 1,
    name: "Swagger Avocado",
    suppressionLabels: [],
    troubleshootingGuide: defaultTsg,
  },
  {
    precedence: 1,
    name: "Swagger SpellCheck",
    suppressionLabels: [],
    troubleshootingGuide: defaultTsg,
  },
  {
    precedence: 1,
    name: "Swagger PrettierCheck",
    suppressionLabels: [],
    troubleshootingGuide: defaultTsg,
  },
  {
    precedence: 2,
    name: "Swagger SemanticValidation",
    suppressionLabels: [],
    troubleshootingGuide: defaultTsg,
  },
  {
    precedence: 3,
    name: "Swagger ModelValidation",
    suppressionLabels: [],
    troubleshootingGuide: defaultTsg,
  },
  {
    precedence: 4,
    name: "Swagger BreakingChange",
    suppressionLabels: [verRevApproval, brChRevApproval],
    troubleshootingGuide: brchTsg,
  },
  {
    precedence: 4,
    name: "Breaking Change(Cross-Version)",
    suppressionLabels: [verRevApproval, brChRevApproval],
    troubleshootingGuide: brchTsg,
  },
  {
    precedence: 5,
    name: "Swagger LintDiff",
    suppressionLabels: [],
    troubleshootingGuide: defaultTsg,
  },
  {
    precedence: 5,
    name: "Swagger Lint(RPaaS)",
    suppressionLabels: [],
    troubleshootingGuide: defaultTsg,
  },
  {
    precedence: 6,
    name: "SDK azure-sdk-for-net",
    suppressionLabels: [],
    troubleshootingGuide: checkAndDiagramTsg(3),
  },
  {
    precedence: 6,
    name: "SDK azure-sdk-for-net-track2",
    suppressionLabels: [],
    troubleshootingGuide: checkAndDiagramTsg(3),
  },
  {
    precedence: 6,
    name: "SDK azure-sdk-for-go",
    suppressionLabels: [],
    troubleshootingGuide: checkAndDiagramTsg(3),
  },
  {
    precedence: 6,
    name: "SDK azure-sdk-for-java",
    suppressionLabels: [],
    troubleshootingGuide: checkAndDiagramTsg(3),
  },
  {
    precedence: 6,
    name: "SDK azure-sdk-for-js",
    suppressionLabels: [],
    troubleshootingGuide: checkAndDiagramTsg(3),
  },
  {
    precedence: 6,
    name: "SDK azure-sdk-for-python",
    suppressionLabels: [],
    troubleshootingGuide: checkAndDiagramTsg(3),
  },
  {
    precedence: 6,
    name: "SDK azure-sdk-for-python-track2",
    suppressionLabels: [],
    troubleshootingGuide: checkAndDiagramTsg(3),
  },
  {
    precedence: 10,
    name: AUTOMATED_CHECK_NAME,
    suppressionLabels: [],
    troubleshootingGuide: reqMetCheckTsg,
  },
];

// during renderAutomatedMergingRequirementsMetCheck we resolve the result of
// automated merge requirements met by from the result of and(requiredChecks).
// if any are pending, automated merging requirements is pending. This is ripe for complete removal
// in favor of just honoring the `required` checks results directly.
const EXCLUDED_CHECK_NAMES = []

// #endregion
// #region core
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

  // TODO: replace entirely in favor of
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

  await summarizeChecksImpl(
    {
      github,
      context,
      core
    },
    owner,
    repo,
    issue_number,
    head_sha,
    event_name,
    targetBranch
  );
}

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @param {string} owner
 * @param {string} repo
 * @param {number} issue_number
 * @param {string} head_sha
 * @param {string} event_name
 * @param {string} targetBranch
 * @returns {Promise<void>}
 */
export async function summarizeChecksImpl(
  {
    github,
    core,
    context
  },
  owner,
  repo,
  issue_number,
  head_sha,
  event_name,
  targetBranch
) {
  core.info(`Handling ${event_name} event for PR #${issue_number} in ${owner}/${repo} with targeted branch ${targetBranch}`);

  // no matter what, we will need the labels for the PR, so let's fetch them first
  const resp = await github.rest.issues.listLabelsOnIssue({
    owner,
    repo,
    issue_number,
  });
  /** @type {{ name: string }[]} */
  const labels = resp.data;
  /** @type {string[]} */
  const labelNames = labels.map((label) => label.name);

  // handle our label trigger first, we may bail out early if it's a label action we're reacting to
  // this also implies that if a label action is performed before any workflows complete, we shouldn't
  // accidentally update the next steps to merge with the results of the workflows that haven't completed yet.
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

  // I very very heartily doubt that automatedMergingRequirementsMetCheckRun will stick around
  // but I'm just doing a straight conversion before refactoring it away
  const [
    requiredCheckRuns,
    fyiCheckRuns,
    automatedMergingRequirementsMetCheckRun
  ] = await getCheckRunTuple(
    github,
    core,
    owner,
    repo,
    head_sha,
    issue_number,
    []
  );

  const commentBody = await createNextStepsComment(
    { github, context, core },
    owner,
    repo,
    labelNames,
    issue_number,
    targetBranch,
    requiredCheckRuns,
    fyiCheckRuns,
    automatedMergingRequirementsMetCheckRun
  );

  await core.info(`Updating comment '${commentName}' on ${owner}/${repo}#${context.issue.number} with body: ${commentBody}`);
  // this will remain commented until we're comfortable with the change.
  // await commentOrUpdate(
  //   { github, context, core },
  //   owner,
  //   repo,
  //   issue_number,
  //   commentName,
  //   commentBody
  // );

  console.log(requiredCheckRuns);
  console.log(fyiCheckRuns);
  console.log(automatedMergingRequirementsMetCheckRun);
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

// #endregion
// #region labeling
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

// #endregion
// #region checks

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
    const response = await github.graphql(getGraphQLQuery(owner, repo, head_sha, prNumber));
    core.info(`GraphQL Rate Limit Information: ${JSON.stringify(response.rateLimit)}`, );

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
 * @param {CheckRunData} checkRun
 * @returns {boolean | undefined}
 */
export function checkRunIsSuccessful(checkRun) {
  // If the check is still queued or in progress, return undefined
  const status = checkRun.status.toLowerCase();
  if (status === "queued" || status === "in_progress") {
    return undefined;
  }

  // At this point we expect a completed run, so conclusion should be defined
  const conclusion = checkRun.conclusion?.toLowerCase();
  if (conclusion == null) {
    return undefined;
  }

  // Return true for success or neutral, false for any other conclusion
  return conclusion === "success" || conclusion === "neutral";
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

  if (response.resource?.checkSuites?.nodes) {
    response.resource.checkSuites.nodes.forEach(
      /** @param {{ checkRuns?: { nodes?: any[] } }} checkSuiteNode */
      (checkSuiteNode) => {
      if (checkSuiteNode.checkRuns?.nodes) {
        checkSuiteNode.checkRuns.nodes.forEach((checkRunNode) => {
          // Find check metadata for this check by name
          const checkInfo = CHECK_METADATA.find(metadata => metadata.name === checkRunNode.name);

          if (checkRunNode.isRequired) {
            reqCheckRuns.push({
              name: checkRunNode.name,
              status: checkRunNode.status,
              conclusion: checkRunNode.conclusion,
              checkInfo: checkInfo
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
              checkInfo: checkInfo
            });
          }
          // Note we return automatedMergingRequirementsMetCheck separately, because we must return it even if it is not marked as 'required'.
          // This case may happen when a PR is targeting a branch which has no checks marked as 'required', e.g. a user dev branch.
          // We obtain reference to this check, even if not 'required', to update the "Next steps to merge" comment.
          if (checkRunNode.name == AUTOMATED_CHECK_NAME) {
            automatedMergingRequirementsMetCheckRun = {
              name: checkRunNode.name,
              status: checkRunNode.status,
              conclusion: checkRunNode.conclusion,
              checkInfo: checkInfo
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
// #endregion
// #region next steps
/**
 *
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @param {string} owner
 * @param {string} repo
 * @param {string[]} labels
 * @param {number} issue_number
 * @param {string} targetBranch
 * @param {CheckRunData[]} requiredRuns
 * @param {CheckRunData[]} fyiRuns
 * @param {CheckRunData | undefined} automatedMergingRequirementsMetCheckRun
 * @returns {Promise<string>}
 */
export async function createNextStepsComment({github, context, core}, owner, repo, labels, issue_number, targetBranch, requiredRuns, fyiRuns, automatedMergingRequirementsMetCheckRun) {
  // select just the metadata that we need about the runs.
  const requiredCheckInfos = requiredRuns
    .filter(run => checkRunIsSuccessful(run) === false)
    .map(run => run.checkInfo)
  const fyiCheckInfos = fyiRuns
    .filter(run => checkRunIsSuccessful(run) === false)
    .map(run => run.checkInfo)

  const commentBody = await buildNextStepsToMergeCommentBody({ github, context, core }, labels, `${repo}/${targetBranch}`, requiredCheckInfos, fyiCheckInfos, automatedMergingRequirementsMetCheckRun);

  return commentBody;

}

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @param {string[]} labels
 * @param {string} targetBranch // this is in the format of "repo/branch"
 * @param {CheckMetadata[]} failingReqChecksInfo
 * @param {CheckMetadata[]} failingFyiChecksInfo
 * @param {CheckRunData | undefined} automatedMergingRequirementsMetCheckRun
 * @returns {Promise<string>}
 */
async function buildNextStepsToMergeCommentBody({ github, context, core }, labels, targetBranch, failingReqChecksInfo, failingFyiChecksInfo, automatedMergingRequirementsMetCheckRun) {
  // Build the comment header
  const commentTitle = `<h2>Next Steps to Merge</h2>`;

  const violatedReqLabelsRules = await getViolatedRequiredLabelsRules(
    {
      github,
      context,
      core
    },
    labels,
    targetBranch
  );

  // this is the first place of adjusted logic. I am treating `requirementsMet` as `no failed required checks`.
  // I do this because the `automatedMergingRequirementsMetCheckRun` WILL NOT BE PRESENT in the new world.
  // the new world we will simply pull all the required checks and if any are failing then we are blocked.
  // addendum: pending does not mean failing. We should simply not mention that any pending runs in the next steps to merge comment.
  // if we have any pending runs, we will simply not mention them in the next steps.

  // I am wondering if there is an edge case with this where I am somehow triggered and there are _no_ check
  // runs at all. I don't want the comment to flip to "all requirements met" and then immediately jump to
  // "requirements not met" when the next check run comes in.
  // todo: double check if the comment update waits until there are NO pending jobs to update the comment
  const anyBlockerPresent = failingReqChecksInfo.length > 0 || violatedReqLabelsRules.length > 0;
  const anyFyiPresent = failingFyiChecksInfo.length > 0;
  const requirementsMet = !anyBlockerPresent;

  // Compose the body based on the current state
  const bodyProper = getBodyProper(
    requirementsMet,
    anyBlockerPresent,
    anyFyiPresent,
    failingReqChecksInfo,
    failingFyiChecksInfo,
    violatedReqLabelsRules
  );

  return commentTitle + bodyProper;
}

/**
 * Gets the proper body content based on requirements status
 * @param {boolean} requirementsMet - Whether all requirements are met
 * @param {boolean} anyBlockerPresent - Whether any blockers are present
 * @param {boolean} anyFyiPresent - Whether any FYI issues are present
 * @param {CheckMetadata[]} failingReqChecksInfo - Failing required checks info
 * @param {CheckMetadata[]} failingFyiChecksInfo - Failing FYI checks info
 * @param {RequiredLabelRule[]} violatedRequiredLabelsRules - Violated required label rules
 * @returns {string} The body content HTML
 */
function getBodyProper(
  requirementsMet,
  anyBlockerPresent,
  anyFyiPresent,
  failingReqChecksInfo,
  failingFyiChecksInfo,
  violatedRequiredLabelsRules,
) {
  let bodyProper = "";

  if (anyBlockerPresent || anyFyiPresent) {
    // assert: !requirementsMet

    if (anyBlockerPresent) {
      bodyProper += getBlockerPresentBody(failingReqChecksInfo, violatedRequiredLabelsRules);
    }

    if (anyBlockerPresent && anyFyiPresent) {
      bodyProper += "<br/>"
    }

    if (anyFyiPresent) {
      bodyProper += getFyiPresentBody(failingFyiChecksInfo);
      if (!anyBlockerPresent) {
        bodyProper +=
          `If you still want to proceed merging this PR without addressing the above failures, ${diagramTsg(4, false)}.`
      }
    }

  } else if (requirementsMet) {
    bodyProper = `✅ All automated merging requirements have been met! `
      + `To get your PR merged, see <a href="https://aka.ms/azsdk/specreview/merge">aka.ms/azsdk/specreview/merge</a>.`;
  } else {
    bodyProper = "⌛ Please wait. Next steps to merge this PR are being evaluated by automation. ⌛";
  }
  return bodyProper;
}

function getBlockerPresentBody(
  failingRequiredChecks: CheckWorkflowInfo[],
  violatedRequiredLabelsRules: RequiredLabelRule[]) {

  const failingRequiredChecksNextStepsText = buildFailingChecksNextStepsText(failingRequiredChecks, "required");
  const violatedReqLabelsRulesNextStepsText: string = buildViolatedLabelRulesNextStepsText(violatedRequiredLabelsRules);
  return "Next steps that must be taken to merge this PR: <br/>"
  + "<ul>" + violatedReqLabelsRulesNextStepsText + failingRequiredChecksNextStepsText + "</ul>"
}

function getFyiPresentBody(failingFyiChecksInfo: CheckWorkflowInfo[]) {
  return "Important checks have failed. As of today they are not blocking this PR, but in near future they may.<br/>"
  + "Addressing the following failures is highly recommended:<br/>"
  + "<ul>" + buildFailingChecksNextStepsText(failingFyiChecksInfo, "FYI") +  "</ul>"
}

function buildFailingChecksNextStepsText(failingChecks: CheckWorkflowInfo[], checkKind: "required" | "FYI") {

  let failingChecksNextStepsText: string = "";
  if (failingChecks.length > 0) {

    const minPrecedence: number = Math.min(...failingChecks.map(check => check.precedence));
    const checksToDisplay: CheckWorkflowInfo[] = failingChecks.filter(check => check.precedence == minPrecedence);

    // assert: checksToDisplay.length > 0
    failingChecksNextStepsText =
      checksToDisplay.map(check =>
        (checkKind == "required")
          ? `<li>❌ The required check named <code>${check.name}</code> has failed. ${check.troubleshootingGuide}</li>`
          : `<li>⚠️ The check named <code>${check.name}</code> has failed. ${check.troubleshootingGuide}</li>`
        ).join("")
  }
  return failingChecksNextStepsText
}

function buildViolatedLabelRulesNextStepsText(violatedRequiredLabelsRules: RequiredLabelRule[]) {
  let violatedReqLabelsNextStepsText: string = "";
  if (violatedRequiredLabelsRules.length > 0) {

    const minPrecedence: number = Math.min(...violatedRequiredLabelsRules.map(rule => rule.precedence));
    const rulesToDisplay: RequiredLabelRule[] = violatedRequiredLabelsRules.filter(rule => rule.precedence == minPrecedence);
    // assert: rulesToDisplay.length > 0
    violatedReqLabelsNextStepsText =
      rulesToDisplay.map(rule => `<li>❌ ${rule.troubleshootingGuide}</li>`).join("")
  }
  return violatedReqLabelsNextStepsText;
}

// #endregion
