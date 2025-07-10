// @ts-check

/*
  This file is a github script. It will be called directly from a github-script action. This code is a simplified
  amalgamation of logic that previously resided in the `PR Summary` check and various events within the `pipelinebot`.
  Both from openapi-alps repo.

  It will trigger on:

  - label addition / removal to a PR
  - when one of a set of required workflows configured in .github/workflows/summarize-checks.yaml completes

  While handling the incoming trigger, it will:

  - Apply or remove labels from the PR based on the status of the checks and other labels
  - Create or update a comment that summarizes the user's "next steps to merge" on the PR.

  This script is a replacement for the old pipelinebot infrastructure from open-api-alps repository.
*/

// #region imports/constants
import { extractInputs } from "../context.js";
// eslint-disable-next-line no-unused-vars
import { commentOrUpdate } from "../comment.js";
import { PER_PAGE_MAX } from "../github.js";
import { verRevApproval, brChRevApproval, getViolatedRequiredLabelsRules } from "./label-rules.js";

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
  "Swagger PrettierCheck",
];
const AUTOMATED_CHECK_NAME = "Automated merging requirements met";
const NEXT_STEPS_COMMENT_ID = "NextStepsToMerge";

/** @type {CheckMetadata[]} */
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
/** @type {string[]} */
const EXCLUDED_CHECK_NAMES = [];

// #endregion
// #region core
/**
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export default async function summarizeChecks({ github, context, core }) {
  logGitHubRateLimitInfo(github, core);
  let { owner, repo, issue_number, head_sha } = await extractInputs(github, context, core);
  const targetBranch = context.payload.pull_request?.base?.ref;
  core.info(`PR target branch: ${targetBranch}`);

  await summarizeChecksImpl(
    github,
    context,
    core,
    owner,
    repo,
    issue_number,
    head_sha,
    context.eventName,
    targetBranch,
  );
}

/**
 * @param {(import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api & { paginate: import("@octokit/plugin-paginate-rest").PaginateInterface; })} github
 * @param {import('@actions/github').context } context
 * @param {typeof import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {number} issue_number
 * @param {string} head_sha
 * @param {string} event_name
 * @param {string} targetBranch
 * @returns {Promise<void>}
 */
export async function summarizeChecksImpl(
  github,
  context,
  core,
  owner,
  repo,
  issue_number,
  head_sha,
  event_name,
  targetBranch,
) {
  core.info(
    `Handling ${event_name} event for PR #${issue_number} in ${owner}/${repo} with targeted branch ${targetBranch}`,
  );

  const labels = await github.paginate(github.rest.issues.listLabelsOnIssue, {
    owner: owner,
    repo: repo,
    issue_number: issue_number,
    per_page: PER_PAGE_MAX,
  });

  /** @type {string[]} */
  let labelNames = labels.map((/** @type {{ name: string; }} */ label) => label.name);

  // handle our label trigger first, we may bail out early if it's a label action we're reacting to
  // this also implies that if a label action is performed before any workflows complete, we shouldn't
  // accidentally update the next steps to merge with the results of the workflows that haven't completed yet.
  if (event_name in ["labeled", "unlabeled"]) {
    // if anything goes wrong with label actions, the invocation will end within handleLabeledEvent due to localized error handling
    const [labelsToAdd, labelsToRemove] = await handleLabeledEvent(
      github,
      context,
      core,
      owner,
      repo,
      issue_number,
      event_name,
      labelNames,
    );

    // adjust labelNames based on labelsToAdd/labelsToRemove
    labelNames = labelNames.filter((name) => !labelsToRemove.includes(name));
    for (const label of labelsToAdd) {
      if (!labelNames.includes(label)) {
        labelNames.push(label);
      }
    }
  }

  /** @type {[CheckRunData[], CheckRunData[]]} */
  const [requiredCheckRuns, fyiCheckRuns] = await getCheckRunTuple(
    github,
    core,
    owner,
    repo,
    head_sha,
    issue_number,
    EXCLUDED_CHECK_NAMES,
  );

  const commentBody = await createNextStepsComment(
    core,
    repo,
    labelNames,
    targetBranch,
    requiredCheckRuns,
    fyiCheckRuns,
  );

  core.info(
    `Updating comment '${NEXT_STEPS_COMMENT_ID}' on ${owner}/${repo}#${issue_number} with body: ${commentBody}`,
  );
  // this will remain commented until we're comfortable with the change.
  // await commentOrUpdate(
  //   { github, context, core },
  //   owner,
  //   repo,
  //   issue_number,
  //   commentName,
  //   commentBody
  // )
}

/**
 * @param {(import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api & { paginate: import("@octokit/plugin-paginate-rest").PaginateInterface; })} github
 * @param {typeof import("@actions/core")} core
 * @returns {Promise<void>}
 */
export async function logGitHubRateLimitInfo(github, core) {
  try {
    const { data: rateLimit } = await github.rest.rateLimit.get();
    const { data: user } = await github.rest.users.getAuthenticated();
    core.info(`GitHub RateLimit Info for user ${user.login}: ${JSON.stringify(rateLimit)}`);
  } catch (e) {
    core.error(`GitHub RateLimit Info: error emitting. Exception: ${e}`);
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
  const resourceUrl = `https://github.com/${owner}/${repo}/commit/${sha}`;

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
// #region label update
/**
 * @param {(import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api & { paginate: import("@octokit/plugin-paginate-rest").PaginateInterface; })} github
 * @param {import('@actions/github').context } context
 * @param {typeof import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {number} issue_number
 * @param {string} event_name
 * @param {string[]} known_labels
 * @returns {Promise<[string[], string[]]>}
 */
// @ts-ignore: 'github' is currently unused but will be used after necessary changes
export async function handleLabeledEvent(
  github,
  context,
  core,
  owner,
  repo,
  issue_number,
  event_name,
  known_labels,
) {
  // logic for this event is based on code directly ripped from pipelinebot:
  // private/openapi-kebab/src/bots/pipeline/pipelineBotOnPRLabelEvent.ts
  // todo: further enhance with labelling actions from `PR Summary` check.
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
  } else if (event_name === "unlabeled") {
    if (changedLabel == "ARMChangesRequested") {
      if (known_labels.indexOf("WaitForARMFeedback") !== -1) {
        labelsToAdd.add("WaitForARMFeedback");
      }
    }

    if (labelsToAdd.size > 0) {
      core.info(
        `Adding labels: ${Array.from(labelsToAdd).join(", ")} to ${owner}/${repo}#${issue_number}.`,
      );
      // await github.rest.issues.addLabels({
      //   owner: owner,
      //   repo: repo,
      //   issue_number: issue_number,
      //   labels: Array.from(labelsToAdd),
      // });
    }
  }

  return [Array.from(labelsToAdd), Array.from(labelsToRemove)];
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
 * @returns {Promise<[CheckRunData[], CheckRunData[]]>}
 */
export async function getCheckRunTuple(
  github,
  core,
  owner,
  repo,
  head_sha,
  prNumber,
  excludedCheckNames,
) {
  // This function was originally a version of getRequiredAndFyiAndAutomatedMergingRequirementsMetCheckRuns
  // but has been simplified for clarity and purpose.
  /** @type {CheckRunData[]} */
  let reqCheckRuns = [];
  /** @type {CheckRunData[]} */
  let fyiCheckRuns = [];

  const response = await github.graphql(getGraphQLQuery(owner, repo, head_sha, prNumber));
  core.info(`GraphQL Rate Limit Information: ${JSON.stringify(response.rateLimit)}`);

  [reqCheckRuns, fyiCheckRuns] = extractRunsFromGraphQLResponse(response);

  core.info(
    `RequiredCheckRuns: ${JSON.stringify(reqCheckRuns)}, ` +
      `FyiCheckRuns: ${JSON.stringify(fyiCheckRuns)}`,
  );
  const filteredReqCheckRuns = reqCheckRuns.filter(
    /**
     * @param {CheckRunData} checkRun
     */
    (checkRun) => !excludedCheckNames.includes(checkRun.name),
  );
  const filteredFyiCheckRuns = fyiCheckRuns.filter(
    /**
     * @param {CheckRunData} checkRun
     */
    (checkRun) => !excludedCheckNames.includes(checkRun.name),
  );

  return [filteredReqCheckRuns, filteredFyiCheckRuns];
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
 * @returns {[CheckRunData[], CheckRunData[]]}
 */
function extractRunsFromGraphQLResponse(response) {
  /** @type {CheckRunData[]} */
  const reqCheckRuns = [];
  /** @type {CheckRunData[]} */
  const fyiCheckRuns = [];

  // Define the automated merging requirements check name

  if (response.resource?.checkSuites?.nodes) {
    response.resource.checkSuites.nodes.forEach(
      /** @param {{ checkRuns?: { nodes?: any[] } }} checkSuiteNode */
      (checkSuiteNode) => {
        if (checkSuiteNode.checkRuns?.nodes) {
          checkSuiteNode.checkRuns.nodes.forEach((checkRunNode) => {
            // We have some specific guidance for some of the required checks.
            const checkInfo =
              CHECK_METADATA.find((metadata) => metadata.name === checkRunNode.name) ||
              /** @type {CheckMetadata} */ ({
                precedence: 1000,
                name: checkRunNode.name,
                suppressionLabels: [],
                troubleshootingGuide: defaultTsg,
              });

            if (checkRunNode.isRequired) {
              reqCheckRuns.push({
                name: checkRunNode.name,
                status: checkRunNode.status,
                conclusion: checkRunNode.conclusion,
                checkInfo: checkInfo,
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
                checkInfo: checkInfo,
              });
            }
          });
        }
      },
    );
  }
  return [reqCheckRuns, fyiCheckRuns];
}
// #endregion
// #region next steps
/**
 *
 * @param {typeof import("@actions/core")} core
 * @param {string} repo
 * @param {string[]} labels
 * @param {string} targetBranch
 * @param {CheckRunData[]} requiredRuns
 * @param {CheckRunData[]} fyiRuns
 * @returns {Promise<string>}
 */
export async function createNextStepsComment(
  core,
  repo,
  labels,
  targetBranch,
  requiredRuns,
  fyiRuns,
) {
  // select just the metadata that we need about the runs.
  const requiredCheckInfos = requiredRuns
    .filter((run) => checkRunIsSuccessful(run) === false)
    .map((run) => run.checkInfo);
  const requiredCheckInfosPresent = requiredRuns.some((run) => {
    const status = run.status.toLowerCase();
    return status !== "queued" && status !== "in_progress";
  });
  const fyiCheckInfos = fyiRuns
    .filter((run) => checkRunIsSuccessful(run) === false)
    .map((run) => run.checkInfo);

  const commentBody = await buildNextStepsToMergeCommentBody(
    core,
    labels,
    `${repo}/${targetBranch}`,
    requiredCheckInfosPresent,
    requiredCheckInfos,
    fyiCheckInfos,
  );

  return commentBody;
}

/**
 * @param {import("@actions/core")} core
 * @param {string[]} labels
 * @param {string} targetBranch // this is in the format of "repo/branch"
 * @param {boolean} requiredCheckInfosPresent
 * @param {CheckMetadata[]} failingReqChecksInfo
 * @param {CheckMetadata[]} failingFyiChecksInfo
 * @returns {Promise<string>}
 */
async function buildNextStepsToMergeCommentBody(
  core,
  labels,
  targetBranch,
  requiredCheckInfosPresent,
  failingReqChecksInfo,
  failingFyiChecksInfo,
) {
  // Build the comment header
  const commentTitle = `<h2>Next Steps to Merge</h2>`;

  const violatedReqLabelsRules = await getViolatedRequiredLabelsRules(core, labels, targetBranch);

  // this is the first place of adjusted logic. I am treating `requirementsMet` as `no failed required checks`.
  // I do this because the `automatedMergingRequirementsMetCheckRun` WILL NOT BE PRESENT in the new world.
  // The new world we will simply pull all the required checks and if any are failing then we are blocked. If there are
  // no failed checks we can't yet say that everything is met, because a check MIGHT run in the future. To prevent
  // this "no checks run" accidentally evaluating as success, we need to ensure that we have at least one failing check
  // in the required checks to consider the requirements met
  const anyBlockerPresent = failingReqChecksInfo.length > 0 || violatedReqLabelsRules.length > 0;
  const anyFyiPresent = failingFyiChecksInfo.length > 0;
  const requirementsMet = !anyBlockerPresent && requiredCheckInfosPresent;

  // Compose the body based on the current state
  const commentBody = getCommentBody(
    requirementsMet,
    anyBlockerPresent,
    anyFyiPresent,
    failingReqChecksInfo,
    failingFyiChecksInfo,
    violatedReqLabelsRules,
  );

  return commentTitle + commentBody;
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
function getCommentBody(
  requirementsMet,
  anyBlockerPresent,
  anyFyiPresent,
  failingReqChecksInfo,
  failingFyiChecksInfo,
  violatedRequiredLabelsRules,
) {
  let bodyProper = "";

  if (anyBlockerPresent || anyFyiPresent) {
    if (anyBlockerPresent) {
      bodyProper += getBlockerPresentBody(failingReqChecksInfo, violatedRequiredLabelsRules);
    }

    if (anyBlockerPresent && anyFyiPresent) {
      bodyProper += "<br/>";
    }

    if (anyFyiPresent) {
      bodyProper += getFyiPresentBody(failingFyiChecksInfo);
      if (!anyBlockerPresent) {
        bodyProper += `If you still want to proceed merging this PR without addressing the above failures, ${diagramTsg(4, false)}.`;
      }
    }
  } else if (requirementsMet) {
    bodyProper =
      `✅ All automated merging requirements have been met! ` +
      `To get your PR merged, see <a href="https://aka.ms/azsdk/specreview/merge">aka.ms/azsdk/specreview/merge</a>.`;
  } else {
    bodyProper =
      "⌛ Please wait. Next steps to merge this PR are being evaluated by automation. ⌛";
  }
  return bodyProper;
}

/**
 * Gets the body content when blockers are present
 * @param {CheckMetadata[]} failingRequiredChecks - Failing required checks
 * @param {RequiredLabelRule[]} violatedRequiredLabelsRules - Violated required label rules
 * @returns {string} The blocker present body HTML
 */
function getBlockerPresentBody(failingRequiredChecks, violatedRequiredLabelsRules) {
  const failingRequiredChecksNextStepsText = buildFailingChecksNextStepsText(
    failingRequiredChecks,
    "required",
  );
  const violatedReqLabelsRulesNextStepsText = buildViolatedLabelRulesNextStepsText(
    violatedRequiredLabelsRules,
  );
  return (
    "Next steps that must be taken to merge this PR: <br/>" +
    "<ul>" +
    violatedReqLabelsRulesNextStepsText +
    failingRequiredChecksNextStepsText +
    "</ul>"
  );
}

/**
 * Gets the body content when FYI issues are present
 * @param {CheckMetadata[]} failingFyiChecksInfo - Failing FYI checks info
 * @returns {string} The FYI present body HTML
 */
function getFyiPresentBody(failingFyiChecksInfo) {
  return (
    "Important checks have failed. As of today they are not blocking this PR, but in near future they may.<br/>" +
    "Addressing the following failures is highly recommended:<br/>" +
    "<ul>" +
    buildFailingChecksNextStepsText(failingFyiChecksInfo, "FYI") +
    "</ul>"
  );
}

/**
 * Builds next steps text for failing checks
 * @param {CheckMetadata[]} failingChecks - Array of failing checks
 * @param {"required" | "FYI"} checkKind - Kind of check (required or FYI)
 * @returns {string} The failing checks next steps HTML
 */
function buildFailingChecksNextStepsText(failingChecks, checkKind) {
  let failingChecksNextStepsText = "";
  if (failingChecks.length > 0) {
    const minPrecedence = Math.min(...failingChecks.map((check) => check.precedence));
    const checksToDisplay = failingChecks.filter((check) => check.precedence === minPrecedence);

    // assert: checksToDisplay.length > 0
    failingChecksNextStepsText = checksToDisplay
      .map((check) =>
        checkKind === "required"
          ? `<li>❌ The required check named <code>${check.name}</code> has failed. ${check.troubleshootingGuide}</li>`
          : `<li>⚠️ The check named <code>${check.name}</code> has failed. ${check.troubleshootingGuide}</li>`,
      )
      .join("");
  }
  return failingChecksNextStepsText;
}

/**
 * Builds next steps text for violated required label rules
 * @param {RequiredLabelRule[]} violatedRequiredLabelsRules - Array of violated required label rules
 * @returns {string} The violated label rules next steps HTML
 */
function buildViolatedLabelRulesNextStepsText(violatedRequiredLabelsRules) {
  let violatedReqLabelsNextStepsText = "";
  if (violatedRequiredLabelsRules.length > 0) {
    const minPrecedence = Math.min(...violatedRequiredLabelsRules.map((rule) => rule.precedence));
    const rulesToDisplay = violatedRequiredLabelsRules.filter(
      (rule) => rule.precedence == minPrecedence,
    );
    // assert: rulesToDisplay.length > 0
    violatedReqLabelsNextStepsText = rulesToDisplay
      .map((rule) => `<li>❌ ${rule.troubleshootingGuide}</li>`)
      .join("");
  }
  return violatedReqLabelsNextStepsText;
}
// #endregion
