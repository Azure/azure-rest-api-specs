import type {
  CheckRuns,
  CommitStatuses,
  Core,
  GitHub,
  GitHubScriptArgs,
  WebhookEvent,
} from "../github.ts";
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
import { execFile } from "../../../shared/src/exec.ts";
import { CheckConclusion, PER_PAGE_MAX } from "../../../shared/src/github.ts";
import {
  details,
  escapeMarkdown,
  inlineCode,
  link,
  paragraph,
  renderMarkdownDoc,
  section,
  table,
  type MarkdownDoc,
} from "../../../shared/src/markdown.ts";
import { intersect } from "../../../shared/src/set.ts";
import { byDate, invert } from "../../../shared/src/sort.ts";
import { parseSignoffDispatchInputs } from "../arm-auto-signoff/arm-signoff-dispatch.ts";
import { commentOrUpdate } from "../comment.ts";
import { statusBadge, type CommentStatus } from "./comment-status.ts";
import { buildSdkBreakingChangesSummary, hasSdkBreakingChanges } from "./sdk-breaking-changes.ts";
import { extractInputs } from "../context.ts";
import { TYPESPEC_SUPPRESSIONS_APPROVED_LABEL } from "../label.ts";
import {
  ImpactAssessmentSchema,
  brChRevApproval,
  getViolatedRequiredLabelsRules,
  processImpactAssessment,
  verRevApproval,
} from "./labelling.ts";
import type { ReviewContext } from "./review-requirements.ts";

import {
  brchTsg,
  checkAndDiagramTsg,
  defaultTsg,
  reqMetCheckTsg,
  typeSpecRequirementArmTsg,
  typeSpecRequirementDataPlaneTsg,
  typeSpecSuppressionsTsg,
  specChangePoliciesTsg,
} from "./tsgs.ts";

import fs from "node:fs/promises";
import os from "node:os";
import path from "node:path";

export type CheckMetadata = {
  precedence: number;
  name: string;
  suppressionLabels: string[];
  troubleshootingGuide: string;
};

export type CheckRunData = {
  name: string;
  status: string;
  conclusion: string | null;
  checkInfo: CheckMetadata;
  url?: string;
};

export type WorkflowRunArtifact = {
  name: string;
  id: number;
  url: string;
  archive_download_url: string;
};

export type WorkflowRunInfo = {
  name: string;
  id: number;
  databaseId: number;
  url: string;
  workflowId: number;
  status: string;
  conclusion: string;
  createdAt: string;
  updatedAt: string;
};

export type RequiredLabelRule = import("./labelling.ts").RequiredLabelRule;

export type CheckRunResult = {
  name: string;
  summary: string;
  result: "pending" | keyof typeof CheckConclusion;
  target_url?: string;
};

export type CommitStatus = CommitStatuses[0];

export type CheckRun = CheckRuns[0];

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
const MAX_IMPACT_ASSESSMENT_BYTES = 16 * 1024 * 1024;

const CHECK_METADATA: CheckMetadata[] = [
  {
    precedence: 0,
    name: "Spec Change Policies",
    suppressionLabels: [],
    troubleshootingGuide: specChangePoliciesTsg,
  },
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
    name: "TypeSpec Suppressions",
    suppressionLabels: [TYPESPEC_SUPPRESSIONS_APPROVED_LABEL],
    troubleshootingGuide: typeSpecSuppressionsTsg,
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
    name: "Package Name Approval",
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

const EXCLUDED_CHECK_NAMES: string[] = [];

// #endregion
// #region core

export default async function summarizeChecks({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<void> {
  const extracted = await extractInputs(github, context, core);
  const { owner, repo } = extracted;
  let { issue_number, head_sha } = extracted;

  // Dispatched by Update Labels, which has no PR payload.
  if (context.eventName === "workflow_dispatch") {
    ({ issue_number, head_sha } = parseSignoffDispatchInputs(
      (context.payload as WebhookEvent<"workflow-dispatch">).inputs,
    ));
  }

  if (!issue_number) {
    core.warning(`No issue number found for this event. Exiting summarize-checks.js early.`);
    return;
  }

  // Publish PR identity as step outputs so the workflow can upload issue-number / head-sha
  // handoff artifacts. Downstream workflow_run consumers (e.g. data-plane review assignment)
  // resolve the PR from these via extractInputs, since labels applied below use the default
  // token and are invisible to `labeled` triggers.
  core.setOutput("issue_number", issue_number);
  if (head_sha) {
    core.setOutput("head_sha", head_sha);
  }

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
    target_url,
  );
}

export function outputRunDetails(
  core: Core,
  requiredCheckRuns: CheckRunData[],
  fyiCheckRuns: CheckRunData[],
) {
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

export async function summarizeChecksImpl(
  github: GitHub,
  core: Core,
  owner: string,
  repo: string,
  issue_number: number,
  head_sha: string,
  event_name: string,
  target_url: string,
): Promise<void> {
  core.info(`Handling ${event_name} event for PR #${issue_number} in ${owner}/${repo}.`);

  const prUrl = `https://github.com/${owner}/${repo}/pull/${issue_number}`;
  core.summary.addRaw(`PR: ${link(prUrl, prUrl)}\n\n`);
  await core.summary.write();
  core.setOutput("summary", process.env.GITHUB_STEP_SUMMARY);

  const { data: pr } = await github.rest.pulls.get({ owner, repo, pull_number: issue_number });
  if (pr.head.sha !== head_sha) {
    core.info(`Skipping summary for ${head_sha}; PR head is now ${pr.head.sha}.`);
    return;
  }
  const reviewContext: ReviewContext = {
    isDraft: pr.draft ?? false,
    targetBranch: pr.base.ref,
  };
  const targetBranch = reviewContext.targetBranch;
  let labelNames = pr.labels.map((label) => (typeof label === "string" ? label : label.name));

  const [requiredCheckRuns, fyiCheckRuns, impactAssessment] = await getCheckRunTuple(
    github,
    core,
    owner,
    repo,
    head_sha,
    targetBranch,
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

  const labelContext = updateLabels(labelNames, impactAssessment, reviewContext);

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

  let sdkBreakingChangesSummary: string | undefined = undefined;
  const hasSdkBreakingChange = hasSdkBreakingChanges(labelNames);
  if (hasSdkBreakingChange) {
    /* check for stale workflow-run handoff SHA */
    const { data: pull } = await github.rest.pulls.get({
      owner,
      repo,
      pull_number: issue_number,
    });
    if (pull.head.sha !== head_sha) {
      core.warning(
        `Skipping SDK breaking-change summary for stale commit ${head_sha}; current PR head is ${pull.head.sha}.`,
      );
    } else {
      const comments = await github.paginate(github.rest.issues.listComments, {
        owner,
        repo,
        issue_number,
        per_page: PER_PAGE_MAX,
      });
      sdkBreakingChangesSummary = buildSdkBreakingChangesSummary(
        labelNames,
        comments ?? [],
        head_sha,
        prUrl,
      );
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
    sdkBreakingChangesSummary,
  );

  automatedChecksMet.target_url = target_url;

  core.info(
    `Updating comment '${NEXT_STEPS_COMMENT_ID}' on ${owner}/${repo}#${issue_number} with body: ${commentBody}`,
  );
  core.summary.addRaw(`\n${commentBody}\n\n`);
  await core.summary.write();

  // this will remain commented until we're comfortable with the change.
  await commentOrUpdate(
    github,
    core,
    owner,
    repo,
    issue_number,
    commentBody,
    NEXT_STEPS_COMMENT_ID,
  );

  // finally, update the "Automated merging requirements met" commit status
  await updateCommitStatus(github, core, owner, repo, head_sha, automatedChecksMet);

  core.info(
    `Summarize checks has identified that status of "${AUTOMATED_CHECK_NAME}" commit status should be updated to: ${JSON.stringify(automatedChecksMet)}.`,
  );
  const statusSummary = section(
    "Automated Checks Met",
    `\`\`\`json\n${JSON.stringify(automatedChecksMet, null, 2)}\n\`\`\``,
  );
  core.summary.addRaw(`${renderMarkdownDoc(statusSummary, 2)}\n\n`);
  await core.summary.write();

  core.setOutput(
    "arm_review_ready",
    impactAssessment !== undefined &&
      !reviewContext.isDraft &&
      labelNames.includes("ARMReview") &&
      labelNames.includes("WaitForARMFeedback"),
  );
}

/**
 * Updates or creates a commit status with the given status
 */
export async function updateCommitStatus(
  github: GitHub,
  core: Core,
  owner: string,
  repo: string,
  head_sha: string,
  checkResult: CheckRunResult,
): Promise<void> {
  // Map CheckRunResult status to commit status state

  let state: "pending" | "success" | "failure" | "error";

  const validStates = [CheckConclusion.SUCCESS, CheckConclusion.FAILURE, "pending"];
  if (validStates.includes(checkResult.result.toLowerCase())) {
    state = checkResult.result.toLowerCase() as "pending" | "success" | "failure";
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

export async function getExistingLabels(
  github: GitHub,
  owner: string,
  repo: string,
  issue_number: number,
): Promise<string[]> {
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

function warnIfLabelSetsIntersect(labelsToAdd: Set<string>, labelsToRemove: Set<string>) {
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

export function updateLabels(
  existingLabels: string[],
  impactAssessment: import("./labelling.ts").ImpactAssessment | undefined,
  context: ReviewContext,
): import("./labelling.ts").LabelContext {
  // logic for this function originally present in:
  //  - private/openapi-kebab/src/bots/pipeline/pipelineBotOnPRLabelEvent.ts
  //  - public/rest-api-specs-scripts/src/prSummary.ts
  // it has since been simplified and moved here to handle all label addition and subtraction given a PR context

  const labelContext: import("./labelling.ts").LabelContext = {
    present: new Set(existingLabels),
    toAdd: new Set(),
    toRemove: new Set(),
  };

  if (impactAssessment) {
    // will further update the label context if necessary
    processImpactAssessment(labelContext, impactAssessment, context);
  }

  warnIfLabelSetsIntersect(labelContext.toAdd, labelContext.toRemove);
  return labelContext;
}

// #endregion
// #region checks
/**
 * Extracts required status check context names from GitHub branch rules response.
 * @param checkResponseObj - The GitHub branch rules API response object
 * @returns Array of required status check context names (e.g., ["license/cla", "Swagger LintDiff"])
 */
export function getRequiredChecksFromBranchRuleOutput(
  checkResponseObj: import("@octokit/rest").RestEndpointMethodTypes["repos"]["getBranchRules"]["response"],
): string[] {
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
 * @param owner - The repository owner.
 * @param repo - The repository name.
 * @param head_sha - The commit SHA to check.
 * @param targetBranch - The current target branch of the pull request.
 */
export async function getCheckRunTuple(
  github: GitHub,
  core: Core,
  owner: string,
  repo: string,
  head_sha: string,
  targetBranch: string,
  excludedCheckNames: string[],
): Promise<
  [CheckRunData[], CheckRunData[], import("./labelling.ts").ImpactAssessment | undefined]
> {
  // This function was originally a version of getRequiredAndFyiAndAutomatedMergingRequirementsMetCheckRuns
  // but has been simplified for clarity and purpose.

  let requiredCheckNames: string[] = [];

  let impactAssessmentWorkflowRun: number | undefined = undefined;

  let impactAssessment: import("./labelling.ts").ImpactAssessment | undefined = undefined;

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

  const allChecks: Array<
    CheckRunData & { _originalData: CheckRun | CommitStatus; _source: string }
  > = [];

  allCheckRuns.forEach((checkRun) => {
    const url = checkRun.details_url || checkRun.html_url;
    allChecks.push({
      name: checkRun.name,
      status: checkRun.status,
      conclusion: checkRun.conclusion || null,
      checkInfo: getCheckInfo(checkRun.name),
      ...(url ? { url } : {}),
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
        checkStatus = "pending";
        conclusion = null;
        break;
    }

    allChecks.push({
      name: status.context,
      status: checkStatus,
      conclusion: conclusion,
      checkInfo: getCheckInfo(status.context),
      ...(status.target_url ? { url: status.target_url } : {}),
      // Store original object for date sorting and data access
      _originalData: status,
      _source: "commitStatus",
    });
  });

  // Group by name and take the latest for each

  const checksByName: Map<
    string,
    Array<CheckRunData & { _originalData: CheckRun | CommitStatus; _source: string }>
  > = new Map();

  allChecks.forEach((check) => {
    const name = check.name;
    const checks = checksByName.get(name);
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
            const originalData = check._originalData as CheckRun;
            // Use the most recent available date, or "1970" (oldest possible) if the data contains no dates
            return originalData.completed_at || originalData.started_at || "1970";
          } else {
            const originalData = check._originalData as CommitStatus;
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
      const originalData = latestCheck._originalData as CheckRun;
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
      ...(latestCheck.url ? { url: latestCheck.url } : {}),
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
      branch: targetBranch,
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

export function checkRunIsSuccessful(checkRun: CheckRunData): boolean | undefined {
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
 */
export function getCheckInfo(checkName: string): CheckMetadata {
  return (
    CHECK_METADATA.find((metadata) => metadata.name === checkName) || {
      precedence: 1000,
      name: checkName,
      suppressionLabels: [],
      troubleshootingGuide: defaultTsg,
    }
  );
}

// #endregion
// #region next steps

export function createNextStepsComment(
  core: Core,
  repo: string,
  labels: string[],
  targetBranch: string | undefined,
  requiredRuns: CheckRunData[],
  fyiRuns: CheckRunData[],
  assessmentCompleted: boolean,
  target_url: string,
  sdkBreakingChangesSummary: string = "",
): [string, CheckRunResult] {
  const failingRequiredChecks = requiredRuns.filter((run) => checkRunIsSuccessful(run) === false);

  const pendingRequiredChecks = requiredRuns.filter(
    (run) => run.status.toLowerCase() !== "completed",
  );

  const failingFyiChecks = fyiRuns.filter((run) => checkRunIsSuccessful(run) === false);
  const completedChecks = [...requiredRuns, ...fyiRuns].filter(
    (run) =>
      run.status.toLowerCase() === "completed" && run.conclusion?.toLowerCase() === "success",
  );

  const [commentBody, automatedChecksMet] = buildNextStepsToMergeCommentBody(
    core,
    labels,
    `${repo}/${targetBranch}`,
    pendingRequiredChecks,
    failingRequiredChecks,
    failingFyiChecks,
    completedChecks,
    assessmentCompleted,
    target_url,
    sdkBreakingChangesSummary,
  );

  return [commentBody, automatedChecksMet];
}

/**
 * @param targetBranch // this is in the format of "repo/branch"
 */
function buildNextStepsToMergeCommentBody(
  core: Core,
  labels: string[],
  targetBranch: string,
  pendingRequiredChecks: CheckRunData[],
  failingRequiredChecks: CheckRunData[],
  failingFyiChecks: CheckRunData[],
  completedChecks: CheckRunData[],
  assessmentCompleted: boolean,
  target_url: string,
  sdkBreakingChangesSummary: string,
): [string, CheckRunResult] {
  const violatedReqLabelsRules = getViolatedRequiredLabelsRules(core, labels, targetBranch);

  // we are "blocked" if we have any violated labelling rules OR if we have any failing required checks
  const anyBlockerPresent = failingRequiredChecks.length > 0 || violatedReqLabelsRules.length > 0;
  const anyFyiPresent = failingFyiChecks.length > 0;
  // we consider requirements met if there are:
  // - no blockers (which includes violated labelling rules in its definition) (anyBlockerPresent)
  // - that none of the required checks are in_progress or queued
  // - and that the assessment is completed. If it is not, we assume we are still evaluating the requirements. Not having
  //   the assessment completed is a blocker, as we may end up having violated labelling rules that would be detected only after
  //   it is completed.
  const requirementsMet =
    !anyBlockerPresent && pendingRequiredChecks.length === 0 && assessmentCompleted;

  // Compose the body based on the current state
  const [commentBody, automatedChecksMet] = getCommentBody(
    requirementsMet,
    anyBlockerPresent,
    anyFyiPresent,
    failingRequiredChecks,
    failingFyiChecks,
    violatedReqLabelsRules,
    buildPendingRequirements(assessmentCompleted, pendingRequiredChecks),
    completedChecks,
    target_url,
    sdkBreakingChangesSummary,
  );

  return [renderMarkdownDoc(section("Next Steps to Merge", commentBody), 2), automatedChecksMet];
}

type RequirementSummary = {
  name: string;
  status: CommentStatus;
  statusLabel?: string;
  nextStep: string;
  guidance?: string;
};

function buildPendingRequirements(
  assessmentCompleted: boolean,
  pendingRequiredChecks: CheckRunData[],
): RequirementSummary[] {
  const pendingItems = pendingRequiredChecks.map((check): RequirementSummary => {
    const state = check.status.toLowerCase();
    return {
      name: formatCheckName(check),
      status: state === "in_progress" ? "running" : "pending",
      nextStep:
        state === "in_progress"
          ? "Wait for this required check to finish."
          : state === "queued"
            ? "Wait for this required check to start."
            : "Wait for this required check's result.",
    };
  });
  if (!assessmentCompleted) {
    pendingItems.unshift({
      name: "PR impact assessment",
      status: "pending",
      nextStep: "Wait; additional requirements may be identified.",
    });
  }
  return pendingItems;
}

/**
 * Gets the proper body content based on requirements status
 * @param requirementsMet - Whether all requirements are met
 * @param anyBlockerPresent - Whether any blockers are present
 * @param anyFyiPresent - Whether any FYI issues are present
 * @param failingRequiredChecks - Failing required checks
 * @param failingFyiChecks - Failing FYI checks
 * @param violatedRequiredLabelsRules - Violated required label rules
 * @param pendingRequirements - Incomplete assessment and required checks
 * @param completedChecks - Successful monitored checks
 * @param target_url - The target URL for the automated checks met run which will be set at the outset of summarize-checks
 * @returns The Markdown body and the automated merging requirements status.
 */
function getCommentBody(
  requirementsMet: boolean,
  anyBlockerPresent: boolean,
  anyFyiPresent: boolean,
  failingRequiredChecks: CheckRunData[],
  failingFyiChecks: CheckRunData[],
  violatedRequiredLabelsRules: RequiredLabelRule[],
  pendingRequirements: RequirementSummary[],
  completedChecks: CheckRunData[],
  target_url: string,
  sdkBreakingChangesSummary: string,
): [MarkdownDoc, CheckRunResult] {
  let status: "pending" | keyof typeof CheckConclusion = "pending";
  let summaryData = "The requirements for merging this PR are still being evaluated. Please wait.";

  const evaluationStatus = pendingRequirements.some(
    (requirement) => requirement.status === "running",
  )
    ? "running"
    : "pending";
  let headline = `${statusBadge(evaluationStatus, "**Still evaluating**")} — merge requirements are not final yet.`;

  if (anyBlockerPresent || anyFyiPresent) {
    if (anyBlockerPresent) {
      const count = failingRequiredChecks.length + violatedRequiredLabelsRules.length;
      headline = `${statusBadge("failed", "**Blocked**")} — ${count} ${count === 1 ? "requirement needs" : "requirements need"} attention.`;
      summaryData =
        "❌ This PR cannot be merged because some requirements are not met. See the details.";
      status = "FAILURE";
    }

    if (anyFyiPresent) {
      if (!anyBlockerPresent && requirementsMet) {
        headline = statusBadge(
          "warning",
          "**Automated requirements met; warnings need attention.**",
        );
        summaryData = renderMarkdownDoc([
          "⚠️ Automated requirements met; warnings need attention.",
          `To merge this PR, refer to ${link("aka.ms/azsdk/specreview/merge", "https://aka.ms/azsdk/specreview/merge")}.`,
        ]);
        status = "SUCCESS";
      }
    }
  } else if (requirementsMet) {
    headline = statusBadge("passed", "**All automated merging requirements have been met.**");
    summaryData = renderMarkdownDoc([
      "✅ All automated merging requirements have been met.",
      `To merge this PR, refer to ${link("aka.ms/azsdk/specreview/merge", "https://aka.ms/azsdk/specreview/merge")}.`,
      "For help, consult comments on this PR and see [aka.ms/azsdk/pr-getting-help](https://aka.ms/azsdk/pr-getting-help).",
    ]);
    status = "SUCCESS";
  }

  const blockingRequirements = [
    ...buildLabelRequirementSummaries(violatedRequiredLabelsRules),
    ...buildFailingCheckSummaries(failingRequiredChecks, "required"),
    ...pendingRequirements,
  ];
  const nonBlockingChecks = buildFailingCheckSummaries(failingFyiChecks, "FYI");
  const guidance = [...blockingRequirements, ...nonBlockingChecks]
    .filter((requirement) => requirement.guidance)
    .map((requirement) => section(requirement.name, requirement.guidance));

  const body: MarkdownDoc = [
    headline,
    buildRequirementsTable(
      blockingRequirements.length > 0
        ? blockingRequirements
        : [
            {
              name: "Automated requirements",
              status: "passed",
              nextStep: "Follow the merge process linked below.",
            },
          ],
    ),
    nonBlockingChecks.length > 0
      ? details(`Warnings (${nonBlockingChecks.length})`, buildRequirementsTable(nonBlockingChecks))
      : undefined,
    completedChecks.length > 0
      ? details(
          `Completed checks (${completedChecks.length})`,
          buildRequirementsTable(
            completedChecks.map((check) => ({
              name: formatCheckName(check),
              status: "passed",
              statusLabel: "Passed",
              nextStep: "No action needed.",
            })),
          ),
        )
      : undefined,
    guidance.length > 0
      ? details("Details and troubleshooting", renderMarkdownDoc(guidance, 3))
      : undefined,
    sdkBreakingChangesSummary
      ? details("SDK breaking-change reports", sdkBreakingChangesSummary)
      : undefined,
    paragraph(
      link("Merge guide", "https://aka.ms/azsdk/specreview/merge"),
      "·",
      link("Get help", "https://aka.ms/azsdk/pr-getting-help"),
      "·",
      link("Workflow run", target_url),
    ),
  ];

  const automatedChecksMet: CheckRunResult = {
    name: AUTOMATED_CHECK_NAME,
    summary: summaryData,
    result: status,
  };

  return [body, automatedChecksMet];
}

function buildRequirementsTable(requirements: RequirementSummary[]): string {
  return table([
    ["Requirement", "Status", "Next step"],
    ...requirements.map(({ name, status, statusLabel, nextStep }) => [
      name,
      statusBadge(status, statusLabel),
      nextStep,
    ]),
  ]);
}

function formatCheckName({ name, url }: Pick<CheckRunData, "name" | "url">): string {
  if (!url || !URL.canParse(url)) return inlineCode(name);
  const target = new URL(url);
  if (target.protocol !== "https:" && target.protocol !== "http:") return inlineCode(name);
  return link(escapeMarkdown(name), `<${target.href}>`);
}

/**
 * Builds next steps text for failing checks
 * @param failingChecks - Array of failing checks
 * @param checkKind - Kind of check (required or FYI)
 * @returns Table entries for all failures in priority order.
 */
function buildFailingCheckSummaries(
  failingChecks: CheckRunData[],
  checkKind: "required" | "FYI",
): RequirementSummary[] {
  return failingChecks
    .toSorted((a, b) => a.checkInfo.precedence - b.checkInfo.precedence)
    .map((check) => ({
      name: formatCheckName(check),
      status: checkKind === "required" ? "failed" : "warning",
      nextStep: "Open the failed check, address its diagnostics, then rerun CI.",
      guidance: check.checkInfo.troubleshootingGuide.trim(),
    }));
}

/**
 * Builds next steps text for violated required label rules
 * @param violatedRequiredLabelsRules - Array of violated required label rules
 * @returns Table entries for all label requirements in priority order.
 */
function buildLabelRequirementSummaries(
  violatedRequiredLabelsRules: RequiredLabelRule[],
): RequirementSummary[] {
  return violatedRequiredLabelsRules
    .toSorted((a, b) => a.precedence - b.precedence)
    .map((rule) => ({
      name: escapeMarkdown(rule.name),
      status: rule.awaitingReview ? "awaiting-review" : "action-required",
      nextStep: rule.nextStep,
      guidance: rule.troubleshootingGuide.trim(),
    }));
}
// #endregion

// #region artifact downloading
/**
 * Downloads the raw summary.json artifact, falling back to legacy job-summary ZIPs.
 * @param runId - The workflow run databaseId
 * @returns The parsed job summary data
 */
export async function getImpactAssessment(
  github: GitHub,
  core: Core,
  owner: string,
  repo: string,
  runId: number,
): Promise<import("./labelling.ts").ImpactAssessment> {
  let jobSummaryArtifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
    owner,
    repo,
    run_id: runId,
    name: "summary.json",
    per_page: PER_PAGE_MAX,
  });

  // Remove the legacy lookup and ZIP reader after the one-month migration:
  // https://github.com/Azure/azure-rest-api-specs/issues/46973.
  if (jobSummaryArtifacts.length === 0) {
    jobSummaryArtifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
      owner,
      repo,
      run_id: runId,
      name: "job-summary",
      per_page: PER_PAGE_MAX,
    });
  }

  // If multiple artifacts with same name, select latest updated
  const jobSummaryArtifact = jobSummaryArtifacts.sort(
    invert(byDate((a) => a.updated_at || "1970")),
  )[0];

  if (!jobSummaryArtifact) {
    throw new Error(
      `Unable to find summary.json or legacy job-summary artifact for run ID: ${runId}.`,
    );
  }

  if (
    jobSummaryArtifact.name === "summary.json" &&
    jobSummaryArtifact.size_in_bytes > MAX_IMPACT_ASSESSMENT_BYTES
  ) {
    throw new Error(`summary.json in artifact ID: ${jobSummaryArtifact.id} exceeds 16 MiB.`);
  }

  const download = await github.rest.actions.downloadArtifact({
    owner,
    repo,
    artifact_id: jobSummaryArtifact.id,
    // The API uses "zip" for both archived and raw artifacts.
    archive_format: "zip",
    // Keep the bytes intact regardless of the artifact's Content-Type.
    request: { parseSuccessResponseBody: false },
  });

  if (!(download.data instanceof ReadableStream)) {
    throw new Error(`Missing download stream for artifact ID: ${jobSummaryArtifact.id}.`);
  }
  const bytes = new Uint8Array(await new Response(download.data).arrayBuffer());

  core.info(
    `Successfully downloaded ${jobSummaryArtifact.name} artifact ID: ${jobSummaryArtifact.id}`,
  );

  if (jobSummaryArtifact.name === "summary.json") {
    if (bytes.byteLength > MAX_IMPACT_ASSESSMENT_BYTES) {
      throw new Error(`summary.json in artifact ID: ${jobSummaryArtifact.id} exceeds 16 MiB.`);
    }
    return ImpactAssessmentSchema.parse(JSON.parse(new TextDecoder().decode(bytes)));
  }

  core.info(`Reading legacy job-summary ZIP artifact for run ID: ${runId}.`);
  const tmpDir = await fs.mkdtemp(
    path.join(process.env.RUNNER_TEMP || os.tmpdir(), "job-summary-"),
  );
  try {
    const tmpZip = path.join(tmpDir, "summary.zip");
    await fs.writeFile(tmpZip, bytes);
    const { stdout } = await execFile("unzip", ["-p", tmpZip, "summary.json"], {
      maxBuffer: MAX_IMPACT_ASSESSMENT_BYTES,
    });

    return ImpactAssessmentSchema.parse(JSON.parse(stdout));
  } finally {
    await fs.rm(tmpDir, { recursive: true, force: true });
  }
}
// #endregion
