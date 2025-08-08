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
// import { commentOrUpdate } from "../comment.js";
import { execFile } from "../../../shared/src/exec.js";
import { CheckConclusion, PER_PAGE_MAX } from "../../../shared/src/github.js";
import { intersect } from "../../../shared/src/set.js";
import {
  brChRevApproval,
  getViolatedRequiredLabelsRules,
  processImpactAssessment,
  verRevApproval,
} from "./labelling.js";

import {
  brchTsg,
  checkAndDiagramTsg,
  defaultTsg,
  diagramTsg,
  reqMetCheckTsg,
  typeSpecRequirementArmTsg,
  typeSpecRequirementDataPlaneTsg,
} from "./tsgs.js";

import fs from "fs/promises";
import os from "os";
import path from "path";

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
 * @typedef {Object} WorkflowRunArtifact
 * @property {string} name
 * @property {number} id
 * @property {string} url
 * @property {string} archive_download_url
 */

/**
 * @typedef {Object} WorkflowRunInfo
 * @property {string} name
 * @property {number} id
 * @property {number} databaseId
 * @property {string} url
 * @property {number} workflowId
 * @property {string} status
 * @property {string} conclusion
 * @property {string} createdAt
 * @property {string} updatedAt
 */

/**
 * @typedef {Object} GraphQLCheckRun
 * @property {string} name
 * @property {string} status
 * @property {string} conclusion
 * @property {boolean} isRequired
 */

/**
 * @typedef {Object} GraphQLCheckSuite
 * @property {GraphQLCheckRun[]} nodes
 */

/**
 * @typedef {Object} GraphQLCheckSuites
 * @property {GraphQLCheckSuite[]} nodes
 */

/**
 * @typedef {Object} GraphQLCommit
 * @property {GraphQLCheckSuites} checkSuites
 */

/**
 * @typedef {Object} GraphQLResource
 * @property {GraphQLCheckSuites} checkSuites
 */

/**
 * @typedef {Object} GraphQLResponse
 * @property {GraphQLResource} resource
 * @property {Object} rateLimit
 * @property {number} rateLimit.limit
 * @property {number} rateLimit.cost
 * @property {number} rateLimit.used
 * @property {number} rateLimit.remaining
 * @property {string} rateLimit.resetAt
 */

/**
 * @typedef {import("./labelling.js").RequiredLabelRule} RequiredLabelRule
 */

/**
 * @typedef {Object} CheckRunResult
 * @property {string} name
 * @property {string} summary
 * @property {"pending" | keyof typeof CheckConclusion} result
 * @property {string} [target_url]
 */

// Placing these configuration items here until we decide another way to pull them in.
const FYI_CHECK_NAMES = [
  "Swagger LintDiff",
  "SDK Validation Status",
  "Swagger BreakingChange",
  "Swagger PrettierCheck",
];
const AUTOMATED_CHECK_NAME = "[TEST-IGNORE] Automated merging requirements met";
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
  let { owner, repo, issue_number, head_sha } = await extractInputs(github, context, core);

  if (!issue_number) {
    core.warning(`No issue number found for this event. Exiting summarize-checks.js early.`);
    return;
  }

  // TODO: This is triggered by pull_request_target AND workflow_run.  If workflow_run, targetBranch will be undefined.
  //       Is this OK? If not, we should be able to get the base ref by calling a GH API to fetch the PR metadata.
  const targetBranch = context.payload.pull_request?.base?.ref;
  core.info(`PR target branch: ${targetBranch}`);

  // Default target is this run itself
  const target_url = `https://github.com/${context.repo.owner}/${context.repo.repo}/actions/runs/${context.runId}`;

  await summarizeChecksImpl(
    github,
    core,
    owner,
    repo,
    issue_number,
    head_sha,
    context.eventName,
    targetBranch,
    target_url,
  );
}

/**
 * @param {typeof import("@actions/core")} core
 * @param {CheckRunData[]} requiredCheckRuns
 * @param {CheckRunData[]} fyiCheckRuns
 */
export function outputRunDetails(core, requiredCheckRuns, fyiCheckRuns) {
  core.info(
    `Observed ${requiredCheckRuns.length} required check runs ${requiredCheckRuns.length > 0 ? ":" : "."}`,
  );
  requiredCheckRuns.forEach((x) => {
    core.info(
      `Required check "${x.name}" with status "${x.status}" and conclusion "${x.conclusion}"`,
    );
  });
  core.info(
    `Observed ${fyiCheckRuns.length} FYI check runs ${fyiCheckRuns.length > 0 ? ":" : "."}`,
  );
  fyiCheckRuns.forEach((x) => {
    core.info(`FYI check "${x.name}" with status "${x.status}" and conclusion "${x.conclusion}"`);
  });
}

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {number} issue_number
 * @param {string} head_sha
 * @param {string} event_name
 * @param {string} targetBranch
 * @param {string} target_url
 * @returns {Promise<void>}
 */
export async function summarizeChecksImpl(
  github,
  core,
  owner,
  repo,
  issue_number,
  head_sha,
  event_name,
  targetBranch,
  target_url,
) {
  core.info(`Handling ${event_name} event for PR #${issue_number} in ${owner}/${repo}.`);

  let labelNames = await getExistingLabels(github, owner, repo, issue_number);

  /** @type {[CheckRunData[], CheckRunData[], import("./labelling.js").ImpactAssessment | undefined]} */
  const [requiredCheckRuns, fyiCheckRuns, impactAssessment] = await getCheckRunTuple(
    github,
    core,
    owner,
    repo,
    head_sha,
    issue_number,
    EXCLUDED_CHECK_NAMES,
  );

  outputRunDetails(core, requiredCheckRuns, fyiCheckRuns);

  if (impactAssessment) {
    core.info(`ImpactAssessment: ${JSON.stringify(impactAssessment)}`);
  } else {
    core.info(
      `No impact assessment found for ${owner}/${repo}#${issue_number}. ` +
        `No labels will be added or removed in this run, and only "pending" status check will be set.`,
    );
  }

  let labelContext = await updateLabels(labelNames, impactAssessment);

  core.info(
    `Summarize checks label actions against ${owner}/${repo}#${issue_number}: \n` +
      `The following labels were present: [${Array.from(labelContext.present).join(", ")}]` +
      `Removing labels [${Array.from(labelContext.toRemove).join(", ")}] then \n` +
      `Adding labels [${Array.from(labelContext.toAdd).join(", ")}]`,
  );

  for (const label of labelContext.toRemove) {
    core.info(`Removing label: ${label} from ${owner}/${repo}#${issue_number}.`);
    // await github.rest.issues.removeLabel({
    //   owner: owner,
    //   repo: repo,
    //   issue_number: issue_number,
    //   name: label,
    // });
  }

  if (labelContext.toAdd.size > 0) {
    core.info(
      `Adding labels: ${Array.from(labelContext.toAdd).join(", ")} to ${owner}/${repo}#${issue_number}.`,
    );
    // await github.rest.issues.addLabels({
    //   owner: owner,
    //   repo: repo,
    //   issue_number: issue_number,
    //   labels: Array.from(labelContext.toAdd),
    // });
  }

  // adjust labelNames based on labelsToAdd/labelsToRemove
  labelNames = labelNames.filter((name) => !labelContext.toRemove.has(name));
  for (const label of labelContext.toAdd) {
    if (!labelNames.includes(label)) {
      labelNames.push(label);
    }
  }

  const [commentBody, automatedChecksMet] = await createNextStepsComment(
    core,
    repo,
    labelNames,
    targetBranch,
    requiredCheckRuns,
    fyiCheckRuns,
    impactAssessment !== undefined,
  );

  automatedChecksMet.target_url = target_url;

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

  // finally, update the "Automated merging requirements met" commit status
  await updateCommitStatus(github, core, owner, repo, head_sha, automatedChecksMet);

  core.info(
    `Summarize checks has identified that status of "[TEST-IGNORE] Automated merging requirements met" commit status should be updated to: ${JSON.stringify(automatedChecksMet)}.`,
  );
}

/**
 * Updates or creates a commit status with the given status
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {string} head_sha
 * @param {CheckRunResult} checkResult
 * @returns {Promise<void>}
 */
export async function updateCommitStatus(github, core, owner, repo, head_sha, checkResult) {
  // Map CheckRunResult status to commit status state
  /** @type {"pending" | "success" | "failure" | "error"} */
  let state;

  const validStates = [CheckConclusion.SUCCESS, CheckConclusion.FAILURE, "pending"];
  if (validStates.includes(checkResult.result.toLowerCase())) {
    state = /** @type {"pending" | "success" | "failure"} */ (checkResult.result.toLowerCase());
  } else {
    state = "error"; // fallback for unexpected values
  }

  // Create commit status instead of check run
  await github.rest.repos.createCommitStatus({
    owner,
    repo,
    sha: head_sha,
    state: state,
    description:
      checkResult.summary.length > 140
        ? checkResult.summary.substring(0, 137) + "..."
        : checkResult.summary,
    context: checkResult.name,
    target_url: checkResult.target_url,
  });

  core.info(
    `Created commit status for ${checkResult.name} with state: ${state} and description: ${checkResult.summary}`,
  );
}

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {string} owner
 * @param {string} repo
 * @param {number} issue_number
 * @param {*} owner
 * @param {*} repo
 * @param {*} issue_number
 * @return {Promise<string[]>}
 */
export async function getExistingLabels(github, owner, repo, issue_number) {
  const labels = await github.paginate(github.rest.issues.listLabelsOnIssue, {
    owner,
    repo,
    issue_number: issue_number,
    per_page: PER_PAGE_MAX,
  });
  return labels.map((label) => label.name);
}

// #endregion
// #region label update
/**
 * @param {Set<string>} labelsToAdd
 * @param {Set<string>} labelsToRemove
 */
function warnIfLabelSetsIntersect(labelsToAdd, labelsToRemove) {
  const intersection = [...intersect(labelsToAdd, labelsToRemove)];
  if (intersection.length > 0) {
    console.warn(
      "ASSERTION VIOLATION! The intersection of labelsToRemove and labelsToAdd is non-empty! " +
        `labelsToAdd: [${[...labelsToAdd].join(", ")}]. ` +
        `labelsToRemove: [${[...labelsToRemove].join(", ")}]. ` +
        `intersection: [${intersection.join(", ")}].`,
    );
  }
}

// * @param {string} eventName
// * @param {string | undefined } changedLabel
/**
 * @param {string[]} existingLabels
 * @param {import("./labelling.js").ImpactAssessment | undefined} impactAssessment
 * @returns {import("./labelling.js").LabelContext}
 */
export function updateLabels(existingLabels, impactAssessment) {
  // logic for this function originally present in:
  //  - private/openapi-kebab/src/bots/pipeline/pipelineBotOnPRLabelEvent.ts
  //  - public/rest-api-specs-scripts/src/prSummary.ts
  // it has since been simplified and moved here to handle all label addition and subtraction given a PR context

  /** @type {import("./labelling.js").LabelContext} */
  const labelContext = {
    present: new Set(existingLabels),
    toAdd: new Set(),
    toRemove: new Set(),
  };

  if (impactAssessment) {
    // will further update the label context if necessary
    processImpactAssessment(labelContext, impactAssessment);
  }

  warnIfLabelSetsIntersect(labelContext.toAdd, labelContext.toRemove);
  return labelContext;
}

// #endregion
// #region checks

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
 * Fetch all check suites for a commit with pagination
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {string} sha
 * @param {number} prNumber
 * @returns {Promise<any>} Complete GraphQL response with all check suites
 */
async function getAllCheckSuites(github, core, owner, repo, sha, prNumber) {
  // First, get the total count using REST API to avoid expensive GraphQL if there are too many suites
  const { data: checkSuitesResponse } = await github.rest.checks.listSuitesForRef({
    owner,
    repo,
    ref: sha,
    per_page: 1, // We only need the count, not the actual data
  });

  const totalCheckSuites = checkSuitesResponse.total_count;

  // Bail if too many check suites to avoid burning GraphQL rate limits
  if (totalCheckSuites > 500) {
    throw new Error(
      `Too many check suites (${totalCheckSuites}) for ${owner}/${repo}#${prNumber}@${sha}. Summarize-Checks ending with error to avoid exhausting graphQL resources.`,
    );
  } else {
    core.info(`Found ${totalCheckSuites} total check suites`);
  }

  // Now proceed with GraphQL pagination
  const resourceUrl = `https://github.com/${owner}/${repo}/commit/${sha}`;
  let allCheckSuites = [];
  let hasNextPage = true;
  let cursor = null;
  let lastResponse = null;

  while (hasNextPage) {
    /** @type {string} */
    const query = `
      {
        resource(url: "${resourceUrl}") {
          ... on Commit {
            checkSuites(first: 100${cursor ? `, after: "${cursor}"` : ""}) {
              pageInfo {
                hasNextPage
                endCursor
              }
              nodes {
                workflowRun {
                  id
                  databaseId
                  workflow {
                    name
                  }
                }
                checkRuns(first: 100) {
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

    /** @type {any} */
    const response = await github.graphql(query);
    lastResponse = response;
    core.info(`GraphQL Rate Limit Information: ${JSON.stringify(response.rateLimit)}`);

    if (response.resource?.checkSuites?.nodes) {
      allCheckSuites.push(...response.resource.checkSuites.nodes);
      hasNextPage = response.resource.checkSuites.pageInfo.hasNextPage;
      cursor = response.resource.checkSuites.pageInfo.endCursor;
    } else {
      hasNextPage = false;
    }
  }

  // Return a response object that matches the original structure
  return {
    resource: {
      checkSuites: {
        nodes: allCheckSuites,
      },
    },
    rateLimit: lastResponse?.rateLimit,
  };
}

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner - The repository owner.
 * @param {string} repo - The repository name.
 * @param {string} head_sha - The commit SHA to check.
 * @param {number} prNumber - The pull request number.
 * @param {string[]} excludedCheckNames
 * @returns {Promise<[CheckRunData[], CheckRunData[], import("./labelling.js").ImpactAssessment | undefined]>}
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

  /** @type {number | undefined} */
  let impactAssessmentWorkflowRun = undefined;

  /** @type { import("./labelling.js").ImpactAssessment | undefined } */
  let impactAssessment = undefined;

  const response = await getAllCheckSuites(github, core, owner, repo, head_sha, prNumber);
  core.info(`GraphQL Rate Limit Information: ${JSON.stringify(response.rateLimit)}`);

  [reqCheckRuns, fyiCheckRuns, impactAssessmentWorkflowRun] =
    extractRunsFromGraphQLResponse(response);

  if (impactAssessmentWorkflowRun) {
    core.info(
      `Impact Assessment Workflow Run ID is present: ${impactAssessmentWorkflowRun}. Downloading job summary artifact`,
    );
    impactAssessment = await getImpactAssessment(
      github,
      core,
      owner,
      repo,
      impactAssessmentWorkflowRun,
    );
  }

  const filteredReqCheckRuns = reqCheckRuns.filter(
    (checkRun) => !excludedCheckNames.includes(checkRun.name),
  );
  const filteredFyiCheckRuns = fyiCheckRuns.filter(
    (checkRun) => !excludedCheckNames.includes(checkRun.name),
  );

  return [filteredReqCheckRuns, filteredFyiCheckRuns, impactAssessment];
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
 * @returns {[CheckRunData[], CheckRunData[], number | undefined]}
 */
export function extractRunsFromGraphQLResponse(response) {
  /** @type {CheckRunData[]} */
  const reqCheckRuns = [];
  /** @type {CheckRunData[]} */
  const fyiCheckRuns = [];

  /** @type {number | undefined} */
  let impactAssessmentWorkflowRun = undefined;

  // Define the automated merging requirements check name

  if (response.resource?.checkSuites?.nodes) {
    response.resource.checkSuites.nodes.forEach(
      /** @param {{ workflowRun?: WorkflowRunInfo, checkRuns?: { nodes?: any[] } }} checkSuiteNode */
      (checkSuiteNode) => {
        if (checkSuiteNode.checkRuns?.nodes) {
          checkSuiteNode.checkRuns.nodes.forEach((checkRunNode) => {
            if (checkRunNode.isRequired) {
              reqCheckRuns.push({
                name: checkRunNode.name,
                status: checkRunNode.status,
                conclusion: checkRunNode.conclusion,
                checkInfo: getCheckInfo(checkRunNode.name),
              });
            }
            // Note the "else" here. It means that:
            // A GH check will be bucketed into "failing FYI check run" if:
            // - It is failing
            // - AND it is is NOT marked as 'required' in GitHub branch policy
            // - AND it is marked as 'FYI' in this file's FYI_CHECK_NAMES array
            else if (FYI_CHECK_NAMES.includes(checkRunNode.name)) {
              fyiCheckRuns.push({
                name: checkRunNode.name,
                status: checkRunNode.status,
                conclusion: checkRunNode.conclusion,
                checkInfo: getCheckInfo(checkRunNode.name),
              });
            }
          });
        }
      },
    );
  }

  // extract the ImpactAssessment check run if it is completed and successful
  if (response.resource?.checkSuites?.nodes) {
    response.resource.checkSuites.nodes.forEach(
      /** @param {{ workflowRun?: WorkflowRunInfo, checkRuns?: { nodes?: any[] } }} checkSuiteNode */
      (checkSuiteNode) => {
        if (checkSuiteNode.checkRuns?.nodes) {
          checkSuiteNode.checkRuns.nodes.forEach((checkRunNode) => {
            if (
              checkRunNode.name === "[TEST-IGNORE] Summarize PR Impact" &&
              checkRunNode.status?.toLowerCase() === "completed" &&
              checkRunNode.conclusion?.toLowerCase() === "success"
            ) {
              // Assign numeric databaseId, not the string node ID
              impactAssessmentWorkflowRun = checkSuiteNode.workflowRun?.databaseId;
            }
          });
        }
      },
    );
  }
  return [reqCheckRuns, fyiCheckRuns, impactAssessmentWorkflowRun];
}
/**
 * Get metadata for a specific check from our index.
 * @param {string} checkName
 * @returns {CheckMetadata}
 */
export function getCheckInfo(checkName) {
  return (
    CHECK_METADATA.find((metadata) => metadata.name === checkName) ||
    /** @type {CheckMetadata} */ ({
      precedence: 1000,
      name: checkName,
      suppressionLabels: [],
      troubleshootingGuide: defaultTsg,
    })
  );
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
 * @param {boolean} assessmentCompleted
 * @returns {Promise<[string, CheckRunResult]>}
 */
export async function createNextStepsComment(
  core,
  repo,
  labels,
  targetBranch,
  requiredRuns,
  fyiRuns,
  assessmentCompleted,
) {
  // select just the metadata that we need about the runs.
  const failingCheckInfos = requiredRuns
    .filter((run) => checkRunIsSuccessful(run) === false)
    .map((run) => run.checkInfo);

  // determine if required runs have any in-progress or queued runs
  // if there are any, we consider the requirements not met.
  // if there are NO required runs, we also consider this to be a "requirements met" situation.
  // there is a possibility that this will be a false positive, but it is better than
  // assuming that the requirements are not met when they actually are.
  const requiredCheckInfosPresent = requiredRuns.every((run) => {
    const status = run.status.toLowerCase();
    return status === "completed";
  });

  const fyiCheckInfos = fyiRuns
    .filter((run) => checkRunIsSuccessful(run) === false)
    .map((run) => run.checkInfo);

  const [commentBody, automatedChecksMet] = await buildNextStepsToMergeCommentBody(
    core,
    labels,
    `${repo}/${targetBranch}`,
    requiredCheckInfosPresent,
    failingCheckInfos,
    fyiCheckInfos,
    assessmentCompleted,
  );

  return [commentBody, automatedChecksMet];
}

/**
 * @param {import("@actions/core")} core
 * @param {string[]} labels
 * @param {string} targetBranch // this is in the format of "repo/branch"
 * @param {boolean} requiredCheckInfosPresent
 * @param {CheckMetadata[]} failingReqChecksInfo
 * @param {CheckMetadata[]} failingFyiChecksInfo
 * @param {boolean} assessmentCompleted
 * @returns {Promise<[string, CheckRunResult]>}
 */
async function buildNextStepsToMergeCommentBody(
  core,
  labels,
  targetBranch,
  requiredCheckInfosPresent,
  failingReqChecksInfo,
  failingFyiChecksInfo,
  assessmentCompleted,
) {
  // Build the comment header
  const commentTitle = `<h2>Next Steps to Merge</h2>`;

  const violatedReqLabelsRules = await getViolatedRequiredLabelsRules(core, labels, targetBranch);

  // we are "blocked" if we have any violated labelling rules OR if we have any failing required checks
  const anyBlockerPresent = failingReqChecksInfo.length > 0 || violatedReqLabelsRules.length > 0;
  const anyFyiPresent = failingFyiChecksInfo.length > 0;
  // we consider requirements met if there are:
  // - no blockers (which includes violated labelling rules in its definition) (anyBlockerPresent)
  // - that none of the required checks are in_progress or queued (requiredCheckInfosPresent)
  // - and that the assessment is completed. If it is not, we assume we are still evaluating the requirements. Not having
  //   the assessment completed is a blocker, as we may end up having violated labelling rules that would be detected only after
  //   it is completed.
  const requirementsMet = !anyBlockerPresent && requiredCheckInfosPresent && assessmentCompleted;

  // Compose the body based on the current state
  const [commentBody, automatedChecksMet] = getCommentBody(
    requirementsMet,
    anyBlockerPresent,
    anyFyiPresent,
    failingReqChecksInfo,
    failingFyiChecksInfo,
    violatedReqLabelsRules,
  );

  return [commentTitle + commentBody, automatedChecksMet];
}

/**
 * Gets the proper body content based on requirements status
 * @param {boolean} requirementsMet - Whether all requirements are met
 * @param {boolean} anyBlockerPresent - Whether any blockers are present
 * @param {boolean} anyFyiPresent - Whether any FYI issues are present
 * @param {CheckMetadata[]} failingReqChecksInfo - Failing required checks info
 * @param {CheckMetadata[]} failingFyiChecksInfo - Failing FYI checks info
 * @param {RequiredLabelRule[]} violatedRequiredLabelsRules - Violated required label rules
 * @returns {[string, CheckRunResult]} The body content HTML and the CheckRunResult that automated checks met should be set to.
 */
function getCommentBody(
  requirementsMet,
  anyBlockerPresent,
  anyFyiPresent,
  failingReqChecksInfo,
  failingFyiChecksInfo,
  violatedRequiredLabelsRules,
) {
  /** @type {"pending" | keyof typeof CheckConclusion} */
  let status = "pending";
  let summaryData = "The requirements for merging this PR are still being evaluated. Please wait.";

  // Generate the comment body using the original logic for backwards compatibility
  let bodyProper = "";

  if (anyBlockerPresent || anyFyiPresent) {
    if (anyBlockerPresent) {
      bodyProper += getBlockerPresentBody(failingReqChecksInfo, violatedRequiredLabelsRules);
      summaryData =
        "❌ This PR cannot be merged because some requirements are not met. See the details.";
      status = "FAILURE";
    }

    if (anyBlockerPresent && anyFyiPresent) {
      bodyProper += "<br/>";
    }

    if (anyFyiPresent) {
      bodyProper += getFyiPresentBody(failingFyiChecksInfo);
      if (!anyBlockerPresent) {
        bodyProper += `If you still want to proceed merging this PR without addressing the above failures, ${diagramTsg(4, false)}.`;
        summaryData =
          `⚠️ Some important automated merging requirements have failed. As of today you can still merge this PR, ` +
          `but soon these requirements will be blocking.` +
          `<br/>See <code>Next Steps to merge</code> comment on this PR for details on how to address them.` +
          `<br/>If you want to proceed with merging this PR without fixing them, refer to ` +
          `<a href="https://aka.ms/azsdk/specreview/merge">aka.ms/azsdk/specreview/merge</a>.`;
        status = "SUCCESS";
      }
    }
  } else if (requirementsMet) {
    bodyProper =
      `✅ All automated merging requirements have been met! ` +
      `To get your PR merged, see <a href="https://aka.ms/azsdk/specreview/merge">aka.ms/azsdk/specreview/merge</a>.`;
    summaryData =
      `✅ All automated merging requirements have been met.` +
      `<br/>To merge this PR, refer to ` +
      `<a href="https://aka.ms/azsdk/specreview/merge">aka.ms/azsdk/specreview/merge</a>.` +
      "<br/>For help, consult comments on this PR and see [aka.ms/azsdk/pr-getting-help](https://aka.ms/azsdk/pr-getting-help).";
    status = "SUCCESS";
  } else {
    bodyProper =
      "⌛ Please wait. Next steps to merge this PR are being evaluated by automation. ⌛";
    // dont need to update the status of the check, as pending is the default state.
  }

  /** @type {CheckRunResult} */
  const automatedChecksMet = {
    name: AUTOMATED_CHECK_NAME,
    summary: summaryData,
    result: status,
  };

  return [bodyProper, automatedChecksMet];
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

// #region artifact downloading
/**
 * Downloads the job-summary artifact for a given workflow run.
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {number} runId - The workflow run databaseId
 * @returns {Promise<import("./labelling.js").ImpactAssessment | undefined>} The parsed job summary data
 */
export async function getImpactAssessment(github, core, owner, repo, runId) {
  try {
    // List artifacts for provided workflow run
    const artifacts = await github.rest.actions.listWorkflowRunArtifacts({
      owner,
      repo,
      run_id: runId,
    });

    // Find the job-summary artifact
    const jobSummaryArtifact = artifacts.data.artifacts.find(
      (artifact) => artifact.name === "job-summary",
    );

    if (!jobSummaryArtifact) {
      core.info("No job-summary artifact found");
      return undefined;
    }

    // Download the artifact as a zip archive
    const download = await github.rest.actions.downloadArtifact({
      owner,
      repo,
      artifact_id: jobSummaryArtifact.id,
      archive_format: "zip",
    });

    core.info(`Successfully downloaded job-summary artifact ID: ${jobSummaryArtifact.id}`);

    // Write zip buffer to temp file and extract JSON
    const tmpZip = path.join(process.env.RUNNER_TEMP || os.tmpdir(), `job-summary-${runId}.zip`);
    // Convert ArrayBuffer to Buffer
    // Convert ArrayBuffer (download.data) to Node Buffer
    const arrayBuffer = /** @type {ArrayBuffer} */ (download.data);
    const zipBuffer = Buffer.from(new Uint8Array(arrayBuffer));
    await fs.writeFile(tmpZip, zipBuffer);
    // Extract JSON content from zip archive
    const { stdout: jsonContent } = await execFile("unzip", ["-p", tmpZip]);
    await fs.unlink(tmpZip);

    /** @type {import("./labelling.js").ImpactAssessment} */
    // todo: we need to zod this to ensure the structure is correct, however we do not have zod installed at time of run
    const impact = JSON.parse(jsonContent);
    return impact;
  } catch (/** @type {any} */ error) {
    core.error(`Failed to download job summary artifact: ${error.message}`);
    return undefined;
  }
}
// #endregion
