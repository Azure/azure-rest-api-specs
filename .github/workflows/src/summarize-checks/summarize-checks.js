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
import { execFile } from "../../../shared/src/exec.js";
import { CheckConclusion, PER_PAGE_MAX } from "../../../shared/src/github.js";
import { intersect } from "../../../shared/src/set.js";
import { byDate, invert } from "../../../shared/src/sort.js";
import { commentOrUpdate } from "../comment.js";
import { extractInputs } from "../context.js";
import {
  ImpactAssessmentSchema,
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
 * @property {string | null} conclusion
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
 * @typedef {import("../github.js").WorkflowRuns[0]} WorkflowRunInfo
 */

/**
 * @typedef {Object} TypeSpecRuleMetadata
 * @property {string} [packageName]
 * @property {string} [localRuleName]
 * @property {string} [description]
 * @property {string} [documentationUrl]
 * @property {string[]} [guidelineCodes]
 */

/**
 * @typedef {Object} TypeSpecSourceLocation
 * @property {number} line
 * @property {number} column
 */

/**
 * @typedef {Object} TypeSpecSuppressionRecord
 * @property {string} specPath
 * @property {"inline" | "tspconfig"} sourceKind
 * @property {string} ruleName
 * @property {string} justification
 * @property {string} sourceFile
 * @property {string} anchorPath
 * @property {TypeSpecSourceLocation} location
 * @property {string} rawText
 * @property {TypeSpecRuleMetadata} [ruleMetadata]
 */

/**
 * @typedef {Object} TypeSpecSuppressionChange
 * @property {TypeSpecSuppressionRecord} before
 * @property {TypeSpecSuppressionRecord} after
 */

/**
 * @typedef {Object} TypeSpecCheckedSuppressions
 * @property {string[]} checkRules
 * @property {boolean} requiresApproval
 * @property {TypeSpecSuppressionRecord[]} [newSuppressions]
 * @property {TypeSpecSuppressionRecord[]} [removedSuppressions]
 * @property {TypeSpecSuppressionChange[]} [changedSuppressions]
 */

/**
 * @typedef {Object} TypeSpecSuppressionsReport
 * @property {boolean} [requiresApproval]
 * @property {TypeSpecSuppressionRecord[]} [newSuppressions]
 * @property {TypeSpecSuppressionChange[]} [changedSuppressions]
 * @property {TypeSpecCheckedSuppressions} [checkedSuppressions]
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

/**
 * @typedef {import("../github.js").CheckRuns[0]} CheckRun
 * @typedef {import("../github.js").CommitStatuses[0]} CommitStatus
 */

// Placing these configuration items here until we decide another way to pull them in.
const FYI_CHECK_NAMES = [
  "Swagger LintDiff",
  "SDK Validation Status",
  "Swagger BreakingChange",
  "Swagger PrettierCheck",
];
const AUTOMATED_CHECK_NAME = "Automated merging requirements met";
const IMPACT_CHECK_NAME = "Summarize PR Impact";
const NEXT_STEPS_COMMENT_ID = "NextStepsToMerge";
const TYPESPEC_SUPPRESSIONS_WORKFLOW_NAME = "TypeSpec Suppressions - Analyze Code";
const TYPESPEC_SUPPRESSIONS_REPORT_ARTIFACT_NAME = "typespec-suppressions-report";
const TYPESPEC_SUPPRESSIONS_SECTION_TITLE = "TypeSpec suppressions requiring review";
const APPROVED_SUPPRESSION_LABEL = "Approved-TypeSpecSuppression";
// GitHub caps comment bodies at ~65k characters, so only render a handful of suppressions
// inline per table (new and changed) and link to the analysis log for the full list.
const MAX_SUPPRESSIONS_SHOWN = 5;

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
    precedence: 1,
    name: "Namespace Approval",
    suppressionLabels: [],
    troubleshootingGuide: defaultTsg,
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

  const targetBranch =
    context.eventName === "pull_request_target"
      ? /** @type {import("@octokit/webhooks-types").PullRequestEvent} */ (context.payload)
          .pull_request.base.ref
      : undefined;

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
 * @param {string|undefined} targetBranch
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

  const prUrl = `https://github.com/${owner}/${repo}/pull/${issue_number}`;
  core.summary.addRaw("PR: ");
  core.summary.addLink(prUrl, prUrl);
  await core.summary.write();
  core.setOutput("summary", process.env.GITHUB_STEP_SUMMARY);

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
    targetBranch = impactAssessment.targetBranch;
  } else {
    core.info(
      `No impact assessment found for ${owner}/${repo}#${issue_number}. ` +
        `No labels will be added or removed in this run, and only "pending" status check will be set.`,
    );
  }

  let labelContext = updateLabels(labelNames, impactAssessment);

  core.info(
    `Summarize checks label actions against ${owner}/${repo}#${issue_number}: \n` +
      `The following labels were present: [${Array.from(labelContext.present).join(", ")}]` +
      `Removing labels [${Array.from(labelContext.toRemove).join(", ")}] then \n` +
      `Adding labels [${Array.from(labelContext.toAdd).join(", ")}]`,
  );

  for (const label of labelContext.toRemove) {
    core.info(`Removing label: ${label} from ${owner}/${repo}#${issue_number}.`);
    await github.rest.issues.removeLabel({
      owner: owner,
      repo: repo,
      issue_number: issue_number,
      name: label,
    });
  }

  if (labelContext.toAdd.size > 0) {
    core.info(
      `Adding labels: ${Array.from(labelContext.toAdd).join(", ")} to ${owner}/${repo}#${issue_number}.`,
    );
    await github.rest.issues.addLabels({
      owner: owner,
      repo: repo,
      issue_number: issue_number,
      labels: Array.from(labelContext.toAdd),
    });
  }

  // adjust labelNames based on labelsToAdd/labelsToRemove
  labelNames = labelNames.filter((name) => !labelContext.toRemove.has(name));
  for (const label of labelContext.toAdd) {
    if (!labelNames.includes(label)) {
      labelNames.push(label);
    }
  }

  const [commentBody, automatedChecksMet] = createNextStepsComment(
    core,
    repo,
    labelNames,
    targetBranch,
    requiredCheckRuns,
    fyiCheckRuns,
    impactAssessment !== undefined,
    target_url,
  );
  const typeSpecSuppressionsSection = await getTypeSpecSuppressionsSection(
    github,
    core,
    owner,
    repo,
    head_sha,
    impactAssessment,
    labelNames,
  );
  // Insert the TypeSpec suppressions section before the trailing "Comment generated by ..."
  // footer so the suppressions information is always output before the final attribution line.
  const commentFooter = renderCommentFooter(target_url);
  const mergedCommentBody = typeSpecSuppressionsSection
    ? commentBody.replace(commentFooter, `${typeSpecSuppressionsSection}${commentFooter}`)
    : commentBody;

  automatedChecksMet.target_url = target_url;

  core.info(
    `Updating comment '${NEXT_STEPS_COMMENT_ID}' on ${owner}/${repo}#${issue_number} with body: ${mergedCommentBody}`,
  );
  core.summary.addRaw(`\n${mergedCommentBody}\n\n`);
  await core.summary.write();

  // this will remain commented until we're comfortable with the change.
  await commentOrUpdate(
    github,
    core,
    owner,
    repo,
    issue_number,
    mergedCommentBody,
    NEXT_STEPS_COMMENT_ID,
  );

  // finally, update the "Automated merging requirements met" commit status
  await updateCommitStatus(github, core, owner, repo, head_sha, automatedChecksMet);

  core.info(
    `Summarize checks has identified that status of "${AUTOMATED_CHECK_NAME}" commit status should be updated to: ${JSON.stringify(automatedChecksMet)}.`,
  );
  core.summary.addHeading("Automated Checks Met", 2);
  core.summary.addCodeBlock(JSON.stringify(automatedChecksMet, null, 2));
  await core.summary.write();
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
 * Extracts required status check context names from GitHub branch rules response.
 * @param {import('@octokit/rest').RestEndpointMethodTypes['repos']['getBranchRules']['response']} checkResponseObj - The GitHub branch rules API response object
 * @returns {string[]} Array of required status check context names (e.g., ["license/cla", "Swagger LintDiff"])
 */
export function getRequiredChecksFromBranchRuleOutput(checkResponseObj) {
  const requiredChecks = [];

  // Look through all rules for required_status_checks type
  for (const rule of checkResponseObj.data) {
    if (rule.type === "required_status_checks" && rule.parameters?.required_status_checks) {
      for (const statusCheck of rule.parameters.required_status_checks) {
        requiredChecks.push(statusCheck.context);
      }
    }
  }

  return requiredChecks;
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
  /** @type {string[]} */
  let requiredCheckNames = [];

  /** @type {number | undefined} */
  let impactAssessmentWorkflowRun = undefined;

  /** @type { import("./labelling.js").ImpactAssessment | undefined } */
  let impactAssessment = undefined;

  const allCheckRuns = await github.paginate(github.rest.checks.listForRef, {
    owner: owner,
    repo: repo,
    ref: head_sha,
    per_page: PER_PAGE_MAX,
  });

  const allCommitStatuses = await github.paginate(github.rest.repos.listCommitStatusesForRef, {
    owner: owner,
    repo: repo,
    ref: head_sha,
    per_page: PER_PAGE_MAX,
  });

  // Process allCheckRuns and allCommitStatuses into unified CheckRunData array
  // all checks will be considered as "FYI" until we have an impact assessment, so we can
  // determine the target branch, and from there pull branch protect rulesets to ensure we
  // are marking the required checks correctly.
  /** @type {Array<CheckRunData & {_originalData: CheckRun|CommitStatus, _source: string}>} */
  const allChecks = [];

  allCheckRuns.forEach((checkRun) => {
    allChecks.push({
      name: checkRun.name,
      status: checkRun.status,
      conclusion: checkRun.conclusion || null,
      checkInfo: getCheckInfo(checkRun.name),
      // Store original object for date sorting
      _originalData: checkRun,
      _source: "checkRun",
    });
  });

  allCommitStatuses.forEach((status) => {
    // Map commit status state to check run conclusion
    let conclusion = null;
    let checkStatus = "completed";

    switch (status.state) {
      case "success":
        conclusion = "success";
        break;
      case "failure":
        conclusion = "failure";
        break;
      case "error":
        conclusion = "failure";
        break;
      case "pending":
        checkStatus = "in_progress";
        conclusion = null;
        break;
    }

    allChecks.push({
      name: status.context,
      status: checkStatus,
      conclusion: conclusion,
      checkInfo: getCheckInfo(status.context),
      // Store original object for date sorting and data access
      _originalData: status,
      _source: "commitStatus",
    });
  });

  // Group by name and take the latest for each
  /** @type {Map<string, Array<CheckRunData & {_originalData: CheckRun|CommitStatus, _source: string}>>} */
  const checksByName = new Map();

  allChecks.forEach((check) => {
    const name = check.name;
    let checks = checksByName.get(name);
    if (checks) {
      checks.push(check);
    } else {
      checksByName.set(name, [check]);
    }
  });

  // For each group, sort by date (newest first) and take the first one
  const unifiedCheckRuns = [];
  for (const [, checks] of checksByName) {
    // Sort by date - newest first using invert(byDate(...))
    const sortedChecks = checks.sort(
      invert(
        byDate((check) => {
          if (check._source === "checkRun") {
            const originalData = /** @type {CheckRun} */ (check._originalData);
            // Use the most recent available date, or "1970" (oldest possible) if the data contains no dates
            return originalData.completed_at || originalData.started_at || "1970";
          } else {
            const originalData = /** @type {CommitStatus} */ (check._originalData);
            return originalData.updated_at;
          }
        }),
      ),
    );

    const latestCheck = sortedChecks[0];

    if (
      latestCheck.name === IMPACT_CHECK_NAME &&
      latestCheck.status === "completed" &&
      latestCheck.conclusion === "success"
    ) {
      const originalData = /** @type {CheckRun} */ (latestCheck._originalData);
      const workflowRuns = await github.paginate(github.rest.actions.listWorkflowRunsForRepo, {
        owner,
        repo,
        head_sha: head_sha,
        check_suite_id: originalData.check_suite?.id,
        per_page: PER_PAGE_MAX,
      });

      if (workflowRuns.length === 0) {
        core.warning(`No workflow runs found for check suite ID: ${originalData.check_suite?.id}`);
      } else {
        // Sort by updated_at to get the most recent run
        const sortedRuns = workflowRuns.sort(
          (a, b) => new Date(b.updated_at).getTime() - new Date(a.updated_at).getTime(),
        );
        impactAssessmentWorkflowRun = sortedRuns[0].id;

        if (workflowRuns.length > 1) {
          core.info(
            `Found ${workflowRuns.length} workflow runs for check suite ID: ${originalData.check_suite?.id}, using most recent: ${sortedRuns[0].id}`,
          );
        }
      }
    }

    // Create clean CheckRunData without temporary properties
    unifiedCheckRuns.push({
      name: latestCheck.name,
      status: latestCheck.status,
      conclusion: latestCheck.conclusion,
      checkInfo: latestCheck.checkInfo,
    });
  }

  core.info(
    `Processed ${allCheckRuns.length} check runs and ${allCommitStatuses.length} commit statuses into ${unifiedCheckRuns.length} unified checks`,
  );

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

    const branchRules = await github.rest.repos.getBranchRules({
      owner: owner,
      repo: repo,
      branch: impactAssessment.targetBranch,
    });

    if (branchRules) {
      requiredCheckNames = getRequiredChecksFromBranchRuleOutput(branchRules).filter(
        // "Automated merging requirements met" may be required in repo settings, to ensure PRs cannot be merged unless
        // it's passing.  However, it must be excluded from our list of requiredCheckNames, since it's status is set
        // by our own workflow.  If this check isn't excluded, it creates a deadlock where it can never be set.
        (checkName) => checkName !== AUTOMATED_CHECK_NAME,
      );
    }
  } else {
    requiredCheckNames = [IMPACT_CHECK_NAME];
  }

  const filteredReqCheckRuns = unifiedCheckRuns.filter(
    (checkRun) =>
      !excludedCheckNames.includes(checkRun.name) && requiredCheckNames.includes(checkRun.name),
  );
  const filteredFyiCheckRuns = unifiedCheckRuns.filter(
    (checkRun) =>
      !excludedCheckNames.includes(checkRun.name) &&
      !requiredCheckNames.includes(checkRun.name) &&
      FYI_CHECK_NAMES.includes(checkRun.name),
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
 * @param {string|undefined} targetBranch
 * @param {CheckRunData[]} requiredRuns
 * @param {CheckRunData[]} fyiRuns
 * @param {boolean} assessmentCompleted
 * @param {string} target_url
 * @returns {[string, CheckRunResult]}
 */
export function createNextStepsComment(
  core,
  repo,
  labels,
  targetBranch,
  requiredRuns,
  fyiRuns,
  assessmentCompleted,
  target_url,
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

  const [commentBody, automatedChecksMet] = buildNextStepsToMergeCommentBody(
    core,
    labels,
    `${repo}/${targetBranch}`,
    requiredCheckInfosPresent,
    failingCheckInfos,
    fyiCheckInfos,
    assessmentCompleted,
    target_url,
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
 * @param {string} target_url
 * @returns {[string, CheckRunResult]}
 */
function buildNextStepsToMergeCommentBody(
  core,
  labels,
  targetBranch,
  requiredCheckInfosPresent,
  failingReqChecksInfo,
  failingFyiChecksInfo,
  assessmentCompleted,
  target_url,
) {
  // Build the comment header
  const commentTitle = `<h2>Next Steps to Merge</h2>`;

  const violatedReqLabelsRules = getViolatedRequiredLabelsRules(core, labels, targetBranch);

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
    target_url,
  );

  return [commentTitle + commentBody, automatedChecksMet];
}

/**
 * Renders the trailing footer line attributing the comment to the summarize-checks workflow run.
 * This is always rendered as the last line of the "Next Steps to Merge" comment body.
 * @param {string} target_url - The target URL for the summarize-checks workflow run.
 * @returns {string} The footer HTML.
 */
function renderCommentFooter(target_url) {
  return `<br /><br />Comment generated by <a href="${target_url}">summarize-checks</a> workflow run.`;
}

/**
 * Gets the proper body content based on requirements status
 * @param {boolean} requirementsMet - Whether all requirements are met
 * @param {boolean} anyBlockerPresent - Whether any blockers are present
 * @param {boolean} anyFyiPresent - Whether any FYI issues are present
 * @param {CheckMetadata[]} failingReqChecksInfo - Failing required checks info
 * @param {CheckMetadata[]} failingFyiChecksInfo - Failing FYI checks info
 * @param {RequiredLabelRule[]} violatedRequiredLabelsRules - Violated required label rules
 * @param {string} target_url - The target URL for the automated checks met run which will be set at the outset of summarize-checks
 * @returns {[string, CheckRunResult]} The body content HTML and the CheckRunResult that automated checks met should be set to.
 */
function getCommentBody(
  requirementsMet,
  anyBlockerPresent,
  anyFyiPresent,
  failingReqChecksInfo,
  failingFyiChecksInfo,
  violatedRequiredLabelsRules,
  target_url,
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
      if (!anyBlockerPresent && requirementsMet) {
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

  bodyProper += renderCommentFooter(target_url);

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
 * Downloads a text artifact for a given workflow run.
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {number} runId
 * @param {string} artifactName
 * @returns {Promise<string>}
 */
export async function downloadArtifactText(github, core, owner, repo, runId, artifactName) {
  const artifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
    owner,
    repo,
    run_id: runId,
    name: artifactName,
    per_page: PER_PAGE_MAX,
  });

  const artifact = artifacts.sort(invert(byDate((item) => item.updated_at || "1970")))[0];
  if (!artifact) {
    throw new Error(`Unable to find ${artifactName} artifact for run ID: ${runId}.`);
  }

  const download = await github.rest.actions.downloadArtifact({
    owner,
    repo,
    artifact_id: artifact.id,
    archive_format: "zip",
  });

  core.info(`Successfully downloaded ${artifactName} artifact ID: ${artifact.id}`);

  const tmpZip = path.join(
    process.env.RUNNER_TEMP || os.tmpdir(),
    `${artifactName.replace(/[^A-Za-z0-9_.-]/g, "-")}-${runId}.zip`,
  );
  const arrayBuffer = /** @type {ArrayBuffer} */ (download.data);
  const zipBuffer = Buffer.from(new Uint8Array(arrayBuffer));
  await fs.writeFile(tmpZip, zipBuffer);

  try {
    const { stdout } = await execFile("unzip", ["-p", tmpZip]);
    return stdout;
  } finally {
    await fs.unlink(tmpZip);
  }
}

/**
 * Downloads the job-summary artifact for a given workflow run.
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {number} runId - The workflow run databaseId
 * @returns {Promise<import("./labelling.js").ImpactAssessment>} The parsed job summary data
 */
export async function getImpactAssessment(github, core, owner, repo, runId) {
  // List artifacts for provided workflow run
  const jobSummaryArtifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
    owner,
    repo,
    run_id: runId,
    name: "job-summary",
    per_page: PER_PAGE_MAX,
  });

  // If multiple artifacts with same name, select latest updated
  const jobSummaryArtifact = jobSummaryArtifacts.sort(
    invert(byDate((a) => a.updated_at || "1970")),
  )[0];

  if (!jobSummaryArtifact) {
    throw new Error(
      `Unable to find job-summary artifact for run ID: ${runId}. This should never happen, as this section of code should only run with a valid runId.`,
    );
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
  // Could replace with library like 'fflate' instead of 'exec unzip', but
  // this would require 'npm i', while 'unzip' is pre-installed.
  const { stdout: jsonContent } = await execFile("unzip", ["-p", tmpZip]);

  await fs.unlink(tmpZip);

  return ImpactAssessmentSchema.parse(JSON.parse(jsonContent));
}

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {string} head_sha
 * @returns {Promise<WorkflowRunInfo | undefined>}
 */
async function getLatestTypeSpecSuppressionsWorkflowRun(github, core, owner, repo, head_sha) {
  const workflowRuns = await github.paginate(github.rest.actions.listWorkflowRunsForRepo, {
    owner,
    repo,
    event: "pull_request",
    head_sha,
    per_page: PER_PAGE_MAX,
  });

  const targetRuns = workflowRuns
    .filter(
      (workflowRun) =>
        workflowRun.name === TYPESPEC_SUPPRESSIONS_WORKFLOW_NAME ||
        workflowRun.name === `[TEST-IGNORE] ${TYPESPEC_SUPPRESSIONS_WORKFLOW_NAME}`,
    )
    .sort(invert(byDate((workflowRun) => workflowRun.updated_at)));

  const run = targetRuns[0];
  if (run) {
    core.info(`Using TypeSpec suppressions workflow run ${run.id}.`);
  }
  return run;
}

/**
 * @param {string} value
 * @returns {string}
 */
function escapeHtml(value) {
  return value
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;");
}

/**
 * @param {string} filePath
 * @returns {string}
 */
function getPathSegment(filePath) {
  return filePath.split("/").slice(-4).join("/");
}

/**
 * @param {string} owner
 * @param {string} repo
 * @param {string} sha
 * @param {string} filePath
 * @param {number} line
 * @returns {string}
 */
function getBlobLineLink(owner, repo, sha, filePath, line) {
  const normalizedPath = filePath.startsWith("/") ? filePath.slice(1) : filePath;
  return `https://github.com/${owner}/${repo}/blob/${sha}/${normalizedPath}#L${line}`;
}

/**
 * @param {number} count
 * @param {string} singular
 * @param {string} [plural]
 * @returns {string}
 */
function pluralize(count, singular, plural = `${singular}s`) {
  return `${count} ${count === 1 ? singular : plural}`;
}

/**
 * @param {TypeSpecSuppressionRecord} suppression
 * @returns {string}
 */
function renderRuleLabel(suppression) {
  const label = `<code>${escapeHtml(suppression.ruleName)}</code>`;
  const documentationUrl = suppression.ruleMetadata?.documentationUrl;
  return documentationUrl ? `<a href="${documentationUrl}">${label}</a>` : label;
}

/**
 * @param {string} owner
 * @param {string} repo
 * @param {string} head_sha
 * @param {TypeSpecSuppressionRecord} suppression
 * @returns {string}
 */
function renderSourceLink(owner, repo, head_sha, suppression) {
  const sourceLabel = `${getPathSegment(suppression.sourceFile)}#L${suppression.location.line}`;
  const sourceUrl = getBlobLineLink(
    owner,
    repo,
    head_sha,
    suppression.sourceFile,
    suppression.location.line,
  );
  return `<a href="${sourceUrl}">${escapeHtml(sourceLabel)}</a>`;
}

/**
 * @param {TypeSpecSuppressionRecord} suppression
 * @returns {string}
 */
function renderRuleCell(suppression) {
  const ruleMetadata = suppression.ruleMetadata;
  const description = ruleMetadata?.description
    ? `<br/>${escapeHtml(ruleMetadata.description)}`
    : "";
  const guidance = ruleMetadata?.guidelineCodes?.length
    ? `<br/>Azure guidance: ${ruleMetadata.guidelineCodes
        .map((code) => `<code>${escapeHtml(code)}</code>`)
        .join(", ")}`
    : "";
  return `<strong>${renderRuleLabel(suppression)}</strong>${description}${guidance}`;
}

/**
 * @param {string | undefined} justification
 * @returns {string}
 */
function renderJustificationValue(justification) {
  if (!justification || !justification.trim()) {
    return "<strong>NO JUSTIFICATION PROVIDED, THIS IS A REQUIRED SUPPRESSION COMPONENT</strong>";
  }
  return escapeHtml(justification);
}

/**
 * @param {string} owner
 * @param {string} repo
 * @param {string} head_sha
 * @param {TypeSpecSuppressionRecord} suppression
 * @param {string} statusCell
 * @returns {string}
 */
function renderNewSuppressionRow(owner, repo, head_sha, suppression, statusCell) {
  return (
    `<tr><td align="center">${statusCell}</td>` +
    `<td>${renderRuleCell(suppression)}</td>` +
    `<td>${renderSourceLink(owner, repo, head_sha, suppression)}</td>` +
    `<td>${renderJustificationValue(suppression.justification)}</td></tr>`
  );
}

/**
 * @param {string} owner
 * @param {string} repo
 * @param {string} head_sha
 * @param {TypeSpecSuppressionChange} change
 * @param {string} statusCell
 * @returns {string}
 */
function renderChangedSuppressionRow(owner, repo, head_sha, change, statusCell) {
  return (
    `<tr><td align="center">${statusCell}</td>` +
    `<td>${renderRuleCell(change.after)}</td>` +
    `<td>${renderSourceLink(owner, repo, head_sha, change.after)}</td>` +
    `<td>${renderJustificationValue(change.before.justification)}</td>` +
    `<td>${renderJustificationValue(change.after.justification)}</td></tr>`
  );
}

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {string} head_sha
 * @param {import("./labelling.js").ImpactAssessment | undefined} impactAssessment
 * @param {string[]} [labelNames] - Current PR labels, used to reflect approval status.
 * @returns {Promise<string | undefined>}
 */
export async function getTypeSpecSuppressionsSection(
  github,
  core,
  owner,
  repo,
  head_sha,
  impactAssessment,
  labelNames = [],
) {
  // Reporting is driven by the Analyze Code report artifact, not the shared
  // swagger/README `suppressionReviewRequired` signal. The `impactAssessment`
  // parameter is retained for signature/backward compatibility but no longer
  // gates rendering. Gating (the TypeSpecSuppressionReviewRequired label) is
  // applied separately by summarize-impact and is currently disabled during the
  // initial rollout.
  //
  // Once gating is enabled (the force-off line in summarize-impact's
  // `processTypeSpecSuppression` is removed), this parameter should be used to
  // render the suppressions section only when
  // `impactAssessment.typeSpecSuppressionReviewRequired` is true, so the
  // "Approval required" messaging appears only while the gate is actually active
  // rather than on every PR that touches a checked suppression.
  void impactAssessment;

  const run = await getLatestTypeSpecSuppressionsWorkflowRun(github, core, owner, repo, head_sha);
  if (!run || run.status !== "completed") {
    return undefined;
  }

  let reportContent;
  try {
    reportContent = await downloadArtifactText(
      github,
      core,
      owner,
      repo,
      run.id,
      TYPESPEC_SUPPRESSIONS_REPORT_ARTIFACT_NAME,
    );
  } catch {
    return undefined;
  }

  /** @type {unknown} */
  const parsedReport = JSON.parse(reportContent);
  const report = /** @type {TypeSpecSuppressionsReport} */ (parsedReport);

  // In checked-only mode (a check-rules file was used), render only the checked
  // subset; otherwise fall back to the full diff (legacy behavior). An empty
  // ruleset yields an empty checked subset, so nothing is reported — the same as
  // a PR that added no suppressions.
  const reported = report.checkedSuppressions ?? report;
  if (!reported.requiresApproval) {
    return undefined;
  }

  const newSuppressions = reported.newSuppressions ?? [];
  const changedSuppressions = reported.changedSuppressions ?? [];

  const isApproved = labelNames.includes(APPROVED_SUPPRESSION_LABEL);
  const statusCell = isApproved ? "✅" : "❌";
  const approvalState = isApproved ? "✅ Approved" : "❌ Approval required";

  const totalCount = newSuppressions.length + changedSuppressions.length;

  const summaryParts = [approvalState, pluralize(totalCount, "suppression")];

  const sectionLines = [
    `<br/><br/><details><summary><strong>${TYPESPEC_SUPPRESSIONS_SECTION_TITLE}</strong> — ${summaryParts.join(
      " — ",
    )}</summary>`,
    "",
    "",
    "⚠️ This PR adds or updates the TypeSpec suppressions listed below. <strong>Suppressions are strongly discouraged</strong> — they bypass linter rules that protect API quality and consistency. Authors should avoid adding new suppressions and prefer fixing the underlying issue; reviewers should approve only when there is a clear, compelling justification and no reasonable alternative. Review each linked rule and source location, then apply <code>Approved-TypeSpecSuppression</code> only if every justification is acceptable. The <strong>Status</strong> column shows ✅ once the label is applied and ❌ while approval is pending.",
    "",
  ];

  const shownNew = newSuppressions.slice(0, MAX_SUPPRESSIONS_SHOWN);
  const shownChanged = changedSuppressions.slice(0, MAX_SUPPRESSIONS_SHOWN);
  const shownCount = shownNew.length + shownChanged.length;
  const hiddenCount = totalCount - shownCount;

  if (shownNew.length > 0) {
    sectionLines.push(
      `<strong>New suppressions (${newSuppressions.length})</strong>`,
      "",
      "<table>",
      "<thead><tr><th>Status</th><th>Rule</th><th>Source</th><th>Justification</th></tr></thead>",
      "<tbody>",
      ...shownNew.map((suppression) =>
        renderNewSuppressionRow(owner, repo, head_sha, suppression, statusCell),
      ),
      "</tbody>",
      "</table>",
      "",
    );
  }

  if (shownChanged.length > 0) {
    sectionLines.push(
      `<strong>Changed suppressions (${changedSuppressions.length})</strong>`,
      "",
      "<table>",
      "<thead><tr><th>Status</th><th>Rule</th><th>Source</th><th>Previous justification</th><th>New justification</th></tr></thead>",
      "<tbody>",
      ...shownChanged.map((change) =>
        renderChangedSuppressionRow(owner, repo, head_sha, change, statusCell),
      ),
      "</tbody>",
      "</table>",
      "",
    );
  }

  if (hiddenCount > 0) {
    const runUrl = run.html_url ?? `https://github.com/${owner}/${repo}/actions/runs/${run.id}`;
    sectionLines.push(
      `<em>Showing ${shownCount} of ${totalCount} suppressions. See the <a href="${runUrl}">full analysis log</a> for the complete list.</em>`,
      "",
    );
  }

  sectionLines.push(
    "",
    '💬 Have feedback on the TypeSpec suppression flow? <a href="https://aka.ms/azsdk/tspsuppressionfeedback">Let us know</a>.',
    "</details>",
  );
  return sectionLines.join("\n");
}
// #endregion
