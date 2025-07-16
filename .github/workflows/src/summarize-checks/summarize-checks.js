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
import { verRevApproval, brChRevApproval, getViolatedRequiredLabelsRules } from "./labelling.js";

import {
  brchTsg,
  diagramTsg,
  checkAndDiagramTsg,
  defaultTsg,
  reqMetCheckTsg,
  typeSpecRequirementArmTsg,
  typeSpecRequirementDataPlaneTsg,
} from "./tsgs.js";
import { toASCII } from "punycode";

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
 * @typedef {import("./labelling.js").RequiredLabelRule} RequiredLabelRule
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
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
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

  // we always want fresh labels
  // we always need a file list. We are pulling the file list from gh because we won't be in the correct file context
  // to await getChangedFiles, as we run on pull_request_target and workflow_run events. We _aren't_ in the actual PR context
  // as far as files go

  // If there is a check that DOES need PR context, we will need to shift that logic onto a solo workflow that runs on pull_request
  // events, and then we can await getChangedFiles.
  const [labels, files] = await Promise.all([
    github.paginate(
      github.rest.issues.listLabelsOnIssue,
      {
        owner,
        repo,
        issue_number: issue_number,
        per_page: PER_PAGE_MAX
      }
    ),
    github.paginate(
      github.rest.pulls.listFiles,
      {
        owner,
        repo,
        pull_number: issue_number
      }
    )
  ]);

  core.info(JSON.stringify(files));

  /** @type {string[]} */
  let labelNames = labels.map((/** @type {{ name: string; }} */ label) => label.name);

  // /** @type { string | undefined } */
  // const changedLabel = context.payload.label?.name;
  const isDraft = context.payload.pull_request?.draft ?? false;

  // todo: how important is it that we know if we're in draft? I don't want to have to pull the PR details unless we actually need to
  // do we need to pull this from the PR? if triggered from a workflow_run we won't have payload.pullrequest populated
  let labelContext = await updateLabels(targetBranch, isDraft, labelNames);

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
    //   labels: Array.from(labelsToAdd),
    // });
  }

  // adjust labelNames based on labelsToAdd/labelsToRemove
  labelNames = labelNames.filter((name) => !labelContext.toRemove.has(name));
  for (const label of labelContext.toAdd) {
    if (!labelNames.includes(label)) {
      labelNames.push(label);
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
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {import('@actions/github-script').AsyncFunctionArguments['core']} core
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
 *
 * @param {any[]} arr
 * @param {any[]} values
 * @returns
 */
function containsAll(arr, values) {
  return values.every((value) => arr.includes(value));
}

/**
 *
 * @param {any[]} arr
 * @param {any[]} values
 * @returns
 */
function containsNone(arr, values) {
  return values.every((value) => !arr.includes(value));
}

/**
 * @param {Set<string>} labelsToAdd
 * @param {Set<string>} labelsToRemove
 */
function warnIfLabelSetsIntersect(labelsToAdd, labelsToRemove) {
  const intersection = Array.from(labelsToAdd).filter(label => labelsToRemove.has(label));
  if (intersection.length > 0) {
    console.warn("ASSERTION VIOLATION! The intersection of labelsToRemove and labelsToAdd is non-empty! "
    + `labelsToAdd: [${[...labelsToAdd].join(", ")}]. `
    + `labelsToRemove: [${[...labelsToRemove].join(", ")}]. `
    + `intersection: [${intersection.join(", ")}].`)
  }
}


// * @param {string} eventName
// * @param {string | undefined } changedLabel
/**
 * @param {string} targetBranch
 * @param {boolean} isDraft
 * @param {string[]} existingLabels
 * @returns {import("./labelling.js").LabelContext}
 */
export function updateLabels(
  // eventName,
  targetBranch,
  isDraft,
  existingLabels,
  // changedLabel
) {
  // logic for this function originally present in:
  //  - private/openapi-kebab/src/bots/pipeline/pipelineBotOnPRLabelEvent.ts
  //  - public/rest-api-specs-scripts/src/prSummary.ts
  // it has since been simplified and moved here to handle all label addition and subtraction given a PR context

  /** @type {import("./labelling.js").LabelContext} */
  const labelContext = {
    present: new Set(existingLabels),
    toAdd: new Set(),
    toRemove: new Set()
  }
  console.log(targetBranch);
  console.log(isDraft);

  // this is the only labelling that was part of original pipelinebot logic
  processArmReviewLabels(labelContext, existingLabels);

  // // this one SHOULD remain here. It has a lot of the logic around handling ARM review labels
  // const { armReviewLabelShouldBePresent } = await processARMReview(
  //   context,
  //   labelContext,
  //   resourceManagerLabelShouldBePresent,
  //   versioningReviewRequiredLabelShouldBePresent,
  //   breakingChangeReviewRequiredLabelShouldBePresent,
  //   ciNewRPNamespaceWithoutRpaaSLabelShouldBePresent,
  //   rpaasExceptionLabelShouldBePresent,
  //   ciRpaasRPNotInPrivateRepoLabelShouldBePresent,
  //   isDraft,
  // );

  warnIfLabelSetsIntersect(labelContext.toAdd, labelContext.toRemove)
  return labelContext;
}

/**
 * @param {import("./labelling.js").LabelContext} context
 * @param {string[]} existingLabels
 * @returns {void}
 */
export function processArmReviewLabels(
  context,
  existingLabels
) {
  // the important part about how this will work depends how the users use it
  // EG: if they add the "ARMSignedOff" label, we will remove the "ARMChangesRequested" and "WaitForARMFeedback" labels.
  // if they add the "ARMChangesRequested" label, we will remove the "WaitForARMFeedback" label.
  // if they remove the "ARMChangesRequested" label, we will add the "WaitForARMFeedback" label.
  // so if the user or ARM team actually unlabels `ARMChangesRequested`, then we're actually ok
  // if we are signed off, we should remove the "ARMChangesRequested" and "WaitForARMFeedback" labels
  if (containsAll(existingLabels, ["ARMSignedOff"])) {
    if (existingLabels.includes("ARMChangesRequested")) {
      context.toAdd.add("ARMChangesRequested");
    }
    if (existingLabels.includes("WaitForARMFeedback")) {
      context.toRemove.add("WaitForARMFeedback");
    }
  }
  // if there are ARM changes requested, we should remove the "WaitForARMFeedback" label as the presence indicates that ARM has reviewed
  else if (containsAll(existingLabels, ["ARMChangesRequested"]) && containsNone(existingLabels, ["ARMSignedOff"])) {
    if (existingLabels.includes("WaitForARMFeedback")) {
      context.toRemove.add("WaitForARMFeedback");
    }
  }
  // finally, if ARMChangesRequested are not present, and we've gotten here by lac;k of signoff, we should add the "WaitForARMFeedback" label
  else if (containsNone(existingLabels, ["ARMChangesRequested"])) {
    if (!existingLabels.includes("WaitForARMFeedback")) {
      context.toAdd.add("WaitForARMFeedback");
    }
  }
}

/**
This function determines which labels of the ARM review should
be applied to given PR. It adds and removes the labels as appropriate.

This function does the following, **among other things**:

- Adds the "ARMReview" label if all of the following conditions hold:
  - The processed PR "isReleaseBranch" or "isShiftLeftPRWithRPSaaSDev"
  - The PR is not a draft, as determined by "isDraftPR"
  - The PR is labelled with "resource-manager" label, meaning it pertains
    to ARM, as previously determined by the "isManagementPR" function,
    called from the "getPRType" function.

- Calls the "processARMReviewWorkflowLabels" function if "ARMReview" label applies.
*/
// todo: refactor to take context: PRContext as input instead of IValidatorContext.
// All downstream usage appears to be using "context.contextConfig() as PRContext".
async function processARMReview(
  context: IValidatorContext,
  owner: string,
  repo: string,
  issue_number: number,
  labelContext: LabelContext,
  resourceManagerLabelShouldBePresent: boolean,
  versioningReviewRequiredLabelShouldBePresent: boolean,
  breakingChangeReviewRequiredLabelShouldBePresent: boolean,
  ciNewRPNamespaceWithoutRpaaSLabelShouldBePresent: boolean,
  rpaasExceptionLabelShouldBePresent: boolean,
  ciRpaasRPNotInPrivateRepoLabelShouldBePresent: boolean,
  isDraft: boolean,
): Promise<{ armReviewLabelShouldBePresent: boolean }> {
  console.log("ENTER definition processARMReview")

  const armReviewLabel = new Label("ARMReview", labelContext.present);
  // By default this label should not be present. We may determine later in this function that it should be present after all.
  armReviewLabel.shouldBePresent = false;

  const newApiVersionLabel = new Label("new-api-version", labelContext.present);
  // By default this label should not be present. We may determine later in this function that it should be present after all.
  newApiVersionLabel.shouldBePresent = false;

  const branch = (context.contextConfig() as PRContext).targetBranch
  const prTitle = await getPrTitle(owner, repo, prNumber)
  const isReleaseBranchVal: boolean = isReleaseBranch(branch)
  const isShiftLeftPRWithRPSaaSDevVal: boolean = isShiftLeftPRWithRPSaaSDev(prTitle, branch)
  const isBranchInScopeOfSpecReview: boolean = isReleaseBranchVal || isShiftLeftPRWithRPSaaSDevVal
  let isNewApiVersionVal: boolean | "not_computed" = "not_computed"
  let isMissingBaseCommit: boolean | "not_computed" = "not_computed"

  // 'specReviewApplies' means that either ARM or data-plane review applies. Downstream logic
  // determines which kind of review exactly we need.
  let specReviewApplies = !isDraft && isBranchInScopeOfSpecReview
  if (specReviewApplies) {
    isNewApiVersionVal = await isNewApiVersion(context)
    if (isNewApiVersionVal) {
      // Note that in case of data-plane PRs, the addition of this label will result
      // in API stewardship board review being required.
      // See requiredLabelsRules.ts.
      newApiVersionLabel.shouldBePresent = true;
    }

    armReviewLabel.shouldBePresent = resourceManagerLabelShouldBePresent
    await processARMReviewWorkflowLabels(
      labelContext,
      armReviewLabel.shouldBePresent,
      versioningReviewRequiredLabelShouldBePresent,
      breakingChangeReviewRequiredLabelShouldBePresent,
      ciNewRPNamespaceWithoutRpaaSLabelShouldBePresent,
      rpaasExceptionLabelShouldBePresent,
      ciRpaasRPNotInPrivateRepoLabelShouldBePresent)
  }

  newApiVersionLabel.applyStateChange(labelContext.toAdd, labelContext.toRemove)
  armReviewLabel.applyStateChange(labelContext.toAdd, labelContext.toRemove)

  console.log(`RETURN definition processARMReview. `
    + `url: ${new PRKey(owner, repo, prNumber).toUrl()}, owner: ${owner}, repo: ${repo}, pr: ${prNumber}, branch: ${branch}, `
    + `isReleaseBranch: ${isReleaseBranchVal}, `
    + `isShiftLeftPRWithRPSaaSDev: ${isShiftLeftPRWithRPSaaSDevVal}, `
    + `isBranchInScopeOfArmReview: ${isBranchInScopeOfSpecReview}, `
    + `isNewApiVersion: ${isNewApiVersionVal}, `
    + `isMissingBaseCommit: ${isMissingBaseCommit}, `
    + `isDraft: ${isDraft}, `
    + `newApiVersionLabel.shouldBePresent: ${newApiVersionLabel.shouldBePresent}, `
    + `armReviewLabel.shouldBePresent: ${armReviewLabel.shouldBePresent}.`)

  return { armReviewLabelShouldBePresent: armReviewLabel.shouldBePresent }
}

function isReleaseBranch(branchName: string) {
  const branchRegex = [/main/, /RPSaaSMaster/, /release*/, /ARMCoreRPDev/];
  return branchRegex.some((b) => b.test(branchName));
}

// For shift-left review process, if the PR target branch is RPSaaSDev, it still need ARM review
function isShiftLeftPRWithRPSaaSDev(
  prTitle: string,
  branch: string
): boolean {
  const shiftLeftPRTitle = "[AutoSync]";
  const isShiftLeftPR = prTitle.includes(shiftLeftPRTitle) && branch === "RPSaaSDev";
  if (isShiftLeftPR) {
    console.log(
      `The PR is shift-left PR with RPSaaSDev branch. it need ARM review`
    );
  }
  return isShiftLeftPR;
}

async function isNewApiVersion(context: IValidatorContext): Promise<boolean> {
  const pr = await createPullRequestProperties(
    context,
    "pr-summary-new-api-version"
  );
  const handlers: ChangeHandler[] = [];
  let isAddingNewApiVersion = false;
  const apiVersionSet = new Set<string>();

  const rpFolders = new Set<string>();

  const createSwaggerFileHandler = () => {
    return (e: PRChange) => {
      if (e.changeType === "Addition") {
        const apiVersion = getApiVersionFromSwaggerFile(e.filePath);
        if (apiVersion) {
          apiVersionSet.add(apiVersion);
        }
        const rpFolder = getRPFolderFromSwaggerFile(e.filePath);
        if (rpFolder !== undefined) {
          rpFolders.add(rpFolder);
        }
        console.log(`apiVersion: ${apiVersion}, rpFolder: ${rpFolder}`);
      } else if (e.changeType === "Update") {
        const rpFolder = getRPFolderFromSwaggerFile(e.filePath);
        if (rpFolder !== undefined) {
          rpFolders.add(rpFolder);
        }
      }
    };
  };

  handlers.push({ SwaggerFile: createSwaggerFileHandler() });
  await processPrChanges(context, handlers);

  console.log(`rpFolders: ${Array.from(rpFolders).join(",")}`);

  const firstRPFolder = Array.from(rpFolders)[0];

  console.log(`apiVersion: ${Array.from(apiVersionSet).join(",")}`);

  if (firstRPFolder === undefined) {
    console.log("RP folder not found.");
    return false;
  }

  const targetBranchRPFolder = resolve(pr?.workingDir!, firstRPFolder);

  console.log(`targetBranchRPFolder: ${targetBranchRPFolder}`);

  const existingApiVersions =
    getAllApiVersionFromRPFolder(targetBranchRPFolder);

  console.log(`existingApiVersions: ${existingApiVersions.join(",")}`);

  for (const apiVersion of apiVersionSet) {
    if (!existingApiVersions.includes(apiVersion)) {
      console.log(
        `The apiVersion ${apiVersion} is added. and not found in existing ApiVersions`
      );
      isAddingNewApiVersion = true;
    }
  }
  return isAddingNewApiVersion;
}

/**
CODESYNC:
- requiredLabelsRules.ts / requiredLabelsRules
- https://github.com/Azure/azure-rest-api-specs/blob/main/.github/comment.yml

This function determines which label from the ARM review workflow labels
should be present on the PR. It adds and removes the labels as appropriate.

In other words, this function captures the
ARM review workflow label processing logic.

To be exact, this function executes if and only if the PR in question
has been determined to have the "ARMReview" label, denoting given PR
is in scope for ARM review.

The implementation of this function is the source of truth specifying the
desired behavior.

To understand this implementation, the most important constraint to keep in mind
is that if "ARMReview" label is present, then exactly one of the following
labels must be present:

- NotReadyForARMReview
- WaitForARMFeedback
- ARMChangesRequested
- ARMSignedOff

Note that another important place in this codebase where ARM review workflow
labels are being removed or added to a PR is pipelineBotOnPRLabelEvent.ts.
*/
async function processARMReviewWorkflowLabels(
  labelContext: LabelContext,
  armReviewLabelShouldBePresent: boolean,
  versioningReviewRequiredLabelShouldBePresent: boolean,
  breakingChangeReviewRequiredLabelShouldBePresent: boolean,
  ciNewRPNamespaceWithoutRpaaSLabelShouldBePresent: boolean,
  rpaasExceptionLabelShouldBePresent: boolean,
  ciRpaasRPNotInPrivateRepoLabelShouldBePresent: boolean
): Promise<void> {
  console.log("ENTER definition processARMReviewWorkflowLabels");

  const notReadyForArmReviewLabel = new Label(
    "NotReadyForARMReview",
    labelContext.present);

  const waitForArmFeedbackLabel = new Label(
      "WaitForARMFeedback",
      labelContext.present
    );

  const armChangesRequestedLabel = new Label(
      "ARMChangesRequested",
      labelContext.present
    );

  const armSignedOffLabel = new Label("ARMSignedOff", labelContext.present);

  const blockedOnVersioningPolicy = getBlockedOnVersioningPolicy(
    labelContext,
    breakingChangeReviewRequiredLabelShouldBePresent,
    versioningReviewRequiredLabelShouldBePresent
  );

  const blockedOnRpaas = getBlockedOnRpaas(
    ciNewRPNamespaceWithoutRpaaSLabelShouldBePresent,
    rpaasExceptionLabelShouldBePresent,
    ciRpaasRPNotInPrivateRepoLabelShouldBePresent
  );

  const blocked = blockedOnVersioningPolicy || blockedOnRpaas;

  // If given PR is in scope of ARM review and it is blocked for any reason,
  // the "NotReadyForARMReview" label should be present, to the exclusion
  // of all other ARM review workflow labels.
  notReadyForArmReviewLabel.shouldBePresent =
    armReviewLabelShouldBePresent && blocked;

  // If given PR is in scope of ARM review and the review is not blocked,
  // then "ARMSignedOff" label should remain present on the PR if it was
  // already present. This means that labels "ARMChangesRequested"
  // and "WaitForARMFeedback" are invalid and will be removed by automation
  // in presence of "ARMSignedOff".
  armSignedOffLabel.shouldBePresent =
    armReviewLabelShouldBePresent &&
    !blocked &&
    armSignedOffLabel.present;

  // If given PR is in scope of ARM review and the review is not blocked and
  // not signed-off, then the label "ARMChangesRequested" should remain present
  // if it was already present. This means that labels "WaitForARMFeedback"
  // is invalid and will be removed by automation in presence of
  // "WaitForARMFeedback".
  armChangesRequestedLabel.shouldBePresent =
    armReviewLabelShouldBePresent &&
    !blocked &&
    !armSignedOffLabel.shouldBePresent &&
    armChangesRequestedLabel.present;

  // If given PR is in scope of ARM review and the review is not blocked and
  // not signed-off, and ARM reviewer didn't request any changes,
  // then the label "WaitForARMFeedback" should be present on the PR, whether
  // it was present before or not.
  waitForArmFeedbackLabel.shouldBePresent =
    armReviewLabelShouldBePresent &&
    !blocked &&
    !armSignedOffLabel.shouldBePresent &&
    !armChangesRequestedLabel.shouldBePresent &&
    (waitForArmFeedbackLabel.present || true);

  const exactlyOneArmReviewWorkflowLabelShouldBePresent =
    (Number(notReadyForArmReviewLabel.shouldBePresent) +
      Number(armSignedOffLabel.shouldBePresent) +
      Number(armChangesRequestedLabel.shouldBePresent) +
      Number(waitForArmFeedbackLabel.shouldBePresent) ===
    1) || !armReviewLabelShouldBePresent

  if (!exactlyOneArmReviewWorkflowLabelShouldBePresent) {
    console.warn(
      "ASSERTION VIOLATION! exactlyOneArmReviewWorkflowLabelShouldBePresent is false"
    );
  }

  notReadyForArmReviewLabel.applyStateChange(labelContext.toAdd, labelContext.toRemove);
  armSignedOffLabel.applyStateChange(labelContext.toAdd, labelContext.toRemove);
  armChangesRequestedLabel.applyStateChange(labelContext.toAdd, labelContext.toRemove);
  waitForArmFeedbackLabel.applyStateChange(labelContext.toAdd, labelContext.toRemove);

  console.log(
    `RETURN definition processARMReviewWorkflowLabels. ` +
      `presentLabels: ${[...labelContext.present].join(",")}, ` +
      `blockedOnVersioningPolicy: ${blockedOnVersioningPolicy}. ` +
      `blockedOnRpaas: ${blockedOnRpaas}. ` +
      `exactlyOneArmReviewWorkflowLabelShouldBePresent: ${exactlyOneArmReviewWorkflowLabelShouldBePresent}. `
  );
  return;
}

function getBlockedOnVersioningPolicy(
  labelContext: LabelContext,
  breakingChangeReviewRequiredLabelShouldBePresent: boolean,
  versioningReviewRequiredLabelShouldBePresent: boolean
) {
  const pendingVersioningReview =
    versioningReviewRequiredLabelShouldBePresent &&
    !anyApprovalLabelPresent("SameVersion", [...labelContext.present]);

  const pendingBreakingChangeReview =
    breakingChangeReviewRequiredLabelShouldBePresent &&
    !anyApprovalLabelPresent("CrossVersion", [...labelContext.present]);

  const blockedOnVersioningPolicy =
    pendingVersioningReview || pendingBreakingChangeReview
  return blockedOnVersioningPolicy;
}

function getBlockedOnRpaas(
  ciNewRPNamespaceWithoutRpaaSLabelShouldBePresent: boolean,
  rpaasExceptionLabelShouldBePresent: boolean,
  ciRpaasRPNotInPrivateRepoLabelShouldBePresent: boolean
)
{
  return (ciNewRPNamespaceWithoutRpaaSLabelShouldBePresent && !rpaasExceptionLabelShouldBePresent)
  || ciRpaasRPNotInPrivateRepoLabelShouldBePresent
}
// #endregion
// #region checks
/**
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
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
