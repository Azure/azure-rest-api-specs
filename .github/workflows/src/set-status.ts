import { inspect } from "node:util";
import { isFullGitSha } from "../../shared/src/git.ts";
import {
  CheckConclusion,
  CheckStatus,
  CommitStatusState,
  PER_PAGE_MAX,
} from "../../shared/src/github.ts";
import { byDate, invert } from "../../shared/src/sort.ts";
import { getLatestCommitStatuses, type LatestCommitStatus } from "./commit-statuses.ts";
import { extractInputs } from "./context.ts";
import type {
  Context,
  Core,
  GitHub,
  GitHubScriptArgs,
  WebhookEvent,
  WorkflowRuns,
} from "./github.ts";
import { TYPESPEC_SUPPRESSIONS_APPROVED_LABEL } from "./label.ts";

export type MonitoredStatusCheck = {
  monitoredWorkflowName: string;
  requiredStatusName: string;
  overridingLabels: readonly string[];
};

const BREAKING_CHANGE_OVERRIDING_LABELS = [
  "BreakingChange-Approved-Benign",
  "BreakingChange-Approved-BugFix",
  "BreakingChange-Approved-UserImpact",
  "BreakingChange-Approved-BranchPolicyException",
  "BreakingChange-Approved-Previously",
  "BreakingChange-Approved-Security",
  "BreakingChange-Approved-Retired",
  "Versioning-Approved-Benign",
  "Versioning-Approved-BugFix",
  "Versioning-Approved-PrivatePreview",
  "Versioning-Approved-BranchPolicyException",
  "Versioning-Approved-Previously",
  "Versioning-Approved-Retired",
  "Versioning-Approved-NotReleased",
] as const;

/**
 * Bypassable validation checks whose commit statuses are managed centrally by Summarize Checks.
 * Replaces the individual `*-status.yaml` `pull_request_target` workflows.
 */
export const MONITORED_STATUS_CHECKS: readonly MonitoredStatusCheck[] = [
  {
    monitoredWorkflowName: "Swagger Avocado - Analyze Code",
    requiredStatusName: "Swagger Avocado",
    overridingLabels: ["Approved-Avocado"],
  },
  {
    monitoredWorkflowName: "Swagger BreakingChange - Analyze Code",
    requiredStatusName: "Swagger BreakingChange",
    overridingLabels: BREAKING_CHANGE_OVERRIDING_LABELS,
  },
  {
    monitoredWorkflowName: "Breaking Change(Cross-Version) - Analyze Code",
    requiredStatusName: "Breaking Change(Cross-Version)",
    overridingLabels: BREAKING_CHANGE_OVERRIDING_LABELS,
  },
  {
    monitoredWorkflowName: "Swagger LintDiff - Analyze Code",
    requiredStatusName: "Swagger LintDiff",
    overridingLabels: ["Approved-LintDiff"],
  },
  {
    monitoredWorkflowName: "Swagger ModelValidation - Analyze Code",
    requiredStatusName: "Swagger ModelValidation",
    overridingLabels: ["Approved-ModelValidation"],
  },
  {
    monitoredWorkflowName: "Swagger SemanticValidation - Analyze Code",
    requiredStatusName: "Swagger SemanticValidation",
    overridingLabels: ["Approved-SemanticValidation"],
  },
  {
    monitoredWorkflowName: "TypeSpec Suppressions - Analyze Code",
    requiredStatusName: "TypeSpec Suppressions",
    overridingLabels: [TYPESPEC_SUPPRESSIONS_APPROVED_LABEL],
  },
];

/** Commit statuses whose updates require re-evaluating ARM Universal Auto SignOff. */
const ARM_SIGNOFF_STATUS_CONTEXTS = new Set(["Swagger Avocado", "Swagger LintDiff"]);

const TYPESPEC_SUPPRESSIONS_STATUS_CONTEXT = "TypeSpec Suppressions";
const TYPESPEC_SUPPRESSIONS_WORKFLOW_NAME = "TypeSpec Suppressions - Analyze Code";

const PR_FULL_SYNC_ACTIONS = new Set(["opened", "synchronize", "reopened"]);

function matchesMonitoredWorkflow(
  workflowName: string | null | undefined,
  expected: string,
): boolean {
  return workflowName === expected || workflowName === `[TEST-IGNORE] ${expected}`;
}

/**
 * Determines whether the incoming event should reconcile all monitored check statuses.
 * Because `run-summarize-checks` is serialized per head SHA, reconciling all monitored checks
 * ensures a surviving run catches updates from any pending run superseded by concurrency.
 */
export function shouldSyncStatusesForEvent(
  context: Pick<Context, "eventName" | "payload">,
): boolean {
  if (context.eventName === "workflow_run") {
    const workflowRun = (context.payload as WebhookEvent<"workflow-run">).workflow_run;
    return Boolean(workflowRun && workflowRun.conclusion !== CheckConclusion.SKIPPED);
  }

  if (context.eventName === "pull_request_target") {
    const payload = context.payload as WebhookEvent<"pull-request">;
    return payload.pull_request?.state === "open";
  }

  return false;
}

/**
 * Selects the monitored checks directly targeted by the triggering event (used to determine
 * retry-safe ARM signoff eligibility without creating dispatch cycles).
 */
export function selectChecksForEvent(
  context: Pick<Context, "eventName" | "payload">,
  checks: readonly MonitoredStatusCheck[] = MONITORED_STATUS_CHECKS,
): MonitoredStatusCheck[] {
  if (context.eventName === "workflow_run") {
    const workflowRun = (context.payload as WebhookEvent<"workflow-run">).workflow_run;
    if (!workflowRun || workflowRun.conclusion === CheckConclusion.SKIPPED) {
      return [];
    }
    return checks.filter((check) =>
      matchesMonitoredWorkflow(workflowRun.name, check.monitoredWorkflowName),
    );
  }

  if (context.eventName === "pull_request_target") {
    const payload = context.payload as WebhookEvent<"pull-request">;
    if (payload.pull_request?.state !== "open") {
      return [];
    }
    const action = payload.action;
    if (PR_FULL_SYNC_ACTIONS.has(action)) {
      return [...checks];
    }
    if (action === "labeled" || action === "unlabeled") {
      const labelName = (payload as WebhookEvent<"pull-request", "labeled">).label?.name;
      if (!labelName) {
        return [];
      }
      return checks.filter((check) => check.overridingLabels.includes(labelName));
    }
  }

  return [];
}

/**
 * Returns status contexts whose override labels must not be honored because the upstream
 * approval-invalidation step did not verify them for this analysis run.
 */
export function getUnverifiedOverrideContexts(
  context: Pick<Context, "eventName" | "payload">,
  env: { suppressionsJobResult?: string; suppressionsApprovalVerified?: string },
): Set<string> {
  const unverified = new Set<string>();
  if (context.eventName === "workflow_run") {
    const workflowRun = (context.payload as WebhookEvent<"workflow-run">).workflow_run;
    if (
      matchesMonitoredWorkflow(workflowRun?.name, TYPESPEC_SUPPRESSIONS_WORKFLOW_NAME) &&
      (env.suppressionsJobResult !== "success" || env.suppressionsApprovalVerified !== "true")
    ) {
      unverified.add(TYPESPEC_SUPPRESSIONS_STATUS_CONTEXT);
    }
  }
  return unverified;
}

/* v8 ignore start */

/**
 * Entry point called from Summarize Checks before dependency installation so required check
 * statuses update quickly with zero npm runtime dependencies.
 */
export async function syncMonitoredStatuses({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<void> {
  if (!shouldSyncStatusesForEvent(context)) {
    core.info(
      `Skipping monitored check status sync for event '${context.eventName}:${context.payload.action ?? ""}'.`,
    );
    core.setOutput("arm_signoff_recheck_needed", "false");
    return;
  }

  const { owner, repo, head_sha, issue_number } = await extractInputs(github, context, core);
  if (!issue_number || !head_sha) {
    core.warning(
      `No PR correlation found for event '${context.eventName}:${context.payload.action ?? ""}' ` +
        `(issue_number=${issue_number ?? "missing"}, head_sha=${head_sha || "missing"}); ` +
        `skipping monitored check status sync.`,
    );
    core.setOutput("arm_signoff_recheck_needed", "false");
    return;
  }

  const target_url =
    `https://github.com/${context.repo.owner}/${context.repo.repo}` +
    `/actions/runs/${context.runId}`;

  const unverifiedOverrideContexts = getUnverifiedOverrideContexts(context, {
    suppressionsJobResult: process.env.SUPPRESSIONS_JOB_RESULT,
    suppressionsApprovalVerified: process.env.SUPPRESSIONS_APPROVAL_VERIFIED,
  });
  if (unverifiedOverrideContexts.size > 0) {
    core.warning(
      `Failing closed on unverified override labels for: ${[...unverifiedOverrideContexts].join(", ")}`,
    );
  }

  const eventTargetsArmSignoff = selectChecksForEvent(context).some((check) =>
    ARM_SIGNOFF_STATUS_CONTEXTS.has(check.requiredStatusName),
  );

  const result = await syncMonitoredStatusesImpl({
    owner,
    repo,
    head_sha,
    issue_number,
    target_url,
    github,
    core,
    checks: MONITORED_STATUS_CHECKS,
    eventTargetsArmSignoff,
    unverifiedOverrideContexts,
  });

  core.setOutput("arm_signoff_recheck_needed", String(result.armSignoffRecheckNeeded));
}

export default async function setStatus(
  { github, context, core }: GitHubScriptArgs,
  monitoredWorkflowName: string,
  requiredStatusName: string,
  overridingLabel: string,
): Promise<void> {
  const { owner, repo, head_sha, issue_number } = await extractInputs(github, context, core);

  // Default target is this run itself
  const target_url =
    `https://github.com/${context.repo.owner}/${context.repo.repo}` +
    `/actions/runs/${context.runId}`;

  return await setStatusImpl({
    owner,
    repo,
    head_sha,
    issue_number,
    target_url,
    github,
    core,
    monitoredWorkflowName,
    requiredStatusName,
    overridingLabel,
  });
}
/* v8 ignore stop */

type DesiredCommitStatus = {
  state:
    | typeof CommitStatusState.SUCCESS
    | typeof CommitStatusState.FAILURE
    | typeof CommitStatusState.PENDING;
  description?: string;
  target_url: string;
  hasAnalyzerRun: boolean;
};

function isSameFailedRunTarget(
  existing: LatestCommitStatus | undefined,
  runHtmlUrl: string,
  expectedState: string,
  expectedDescription: string | undefined,
): boolean {
  if (!existing || existing.state !== expectedState) {
    return false;
  }
  if ((existing.description ?? "") !== (expectedDescription ?? "")) {
    return false;
  }
  const url = existing.target_url ?? "";
  return url === runHtmlUrl || url.startsWith(`${runHtmlUrl}/job/`);
}

async function resolveDesiredStatus({
  owner,
  repo,
  issue_number,
  defaultTargetUrl,
  github,
  core,
  prLabels,
  workflowRuns,
  check,
  existing,
  skipUnchanged,
  ignoreOverrides,
}: {
  owner: string;
  repo: string;
  issue_number: number;
  defaultTargetUrl: string;
  github: GitHub;
  core: Core;
  prLabels: readonly string[];
  workflowRuns: WorkflowRuns;
  check: MonitoredStatusCheck;
  existing?: LatestCommitStatus;
  skipUnchanged: boolean;
  ignoreOverrides: boolean;
}): Promise<DesiredCommitStatus> {
  const { monitoredWorkflowName, overridingLabels } = check;
  let target_url = defaultTargetUrl;

  const targetRuns = workflowRuns
    .filter((wf) => matchesMonitoredWorkflow(wf.name, monitoredWorkflowName))
    // Sort by "updated_at" descending
    .sort(invert(byDate((r) => r.updated_at)));

  // Sorted by "updated_at" descending, so most recent run is at index 0.
  const run = targetRuns[0];

  if (!run) {
    console.log(
      `No workflow runs found for '${monitoredWorkflowName}' or '[TEST-IGNORE] ${monitoredWorkflowName}'.`,
    );
  }

  const foundOverridingLabel = ignoreOverrides
    ? undefined
    : overridingLabels.find((label) => prLabels.includes(label));
  const expectedState = foundOverridingLabel
    ? CommitStatusState.SUCCESS
    : run?.status === CheckStatus.COMPLETED
      ? run.conclusion === CheckConclusion.SUCCESS
        ? CommitStatusState.SUCCESS
        : CommitStatusState.FAILURE
      : CommitStatusState.PENDING;
  const expectedDescription = foundOverridingLabel
    ? `Found label '${foundOverridingLabel}'`
    : undefined;

  if (run) {
    /**
     * Update target to the "Analyze Code" run, which contains the meaningful output.
     * @example https://github.com/Azure/azure-rest-api-specs/actions/runs/14509047569
     */
    target_url = run.html_url;

    if (run.conclusion === CheckConclusion.FAILURE) {
      if (
        skipUnchanged &&
        isSameFailedRunTarget(existing, run.html_url, expectedState, expectedDescription)
      ) {
        target_url = existing?.target_url ?? run.html_url;
      } else {
        const jobSummaryArtifactName = "job-summary";

        // Check if run has a custom job summary
        core.info(
          `listWorkflowRunArtifacts(${owner}, ${repo}, ${run.id}, ${jobSummaryArtifactName})`,
        );
        const jobSummaryArtifacts = await github.paginate(
          github.rest.actions.listWorkflowRunArtifacts,
          {
            owner: owner,
            repo: repo,
            run_id: run.id,
            name: jobSummaryArtifactName,
            per_page: PER_PAGE_MAX,
          },
        );

        const hasJobSummary = jobSummaryArtifacts.length > 0;
        core.info(`hasJobSummary: ${hasJobSummary}`);

        if (!hasJobSummary) {
          /**
           * Update target to point directly to the first failed job
           * @example https://github.com/Azure/azure-rest-api-specs/actions/runs/14509047569/job/40703679014?pr=18
           */
          const jobs = await github.paginate(github.rest.actions.listJobsForWorkflowRun, {
            owner,
            repo,
            run_id: run.id,
            per_page: PER_PAGE_MAX,
          });
          const failedJobs = jobs.filter((job) => job.conclusion === CheckConclusion.FAILURE);
          const failedJob = failedJobs[0];
          if (failedJob?.html_url) {
            target_url = `${failedJob.html_url}?pr=${issue_number}`;
          }
        }
      }
    }
  }

  if (foundOverridingLabel) {
    const description = `Found label '${foundOverridingLabel}'`;
    core.info(description);
    return {
      state: CommitStatusState.SUCCESS,
      description,
      target_url,
      hasAnalyzerRun: Boolean(run),
    };
  }

  if (run?.status === CheckStatus.COMPLETED) {
    const state =
      run.conclusion === CheckConclusion.SUCCESS
        ? CommitStatusState.SUCCESS
        : CommitStatusState.FAILURE;
    return {
      state,
      target_url,
      hasAnalyzerRun: true,
    };
  }

  core.info(
    `No workflow runs found for '${monitoredWorkflowName}' or '[TEST-IGNORE] ${monitoredWorkflowName}'.` +
      ` Setting status to ${CommitStatusState.PENDING} for required status: ${check.requiredStatusName}.`,
  );
  return {
    state: CommitStatusState.PENDING,
    target_url,
    hasAnalyzerRun: Boolean(run),
  };
}

function isStatusUnchanged(
  existing: LatestCommitStatus | undefined,
  desired: DesiredCommitStatus,
): boolean {
  if (!existing) {
    return false;
  }
  if (existing.state !== desired.state) {
    return false;
  }
  if ((existing.description ?? "") !== (desired.description ?? "")) {
    return false;
  }
  // Avoid rewriting a pending fallback status solely because this run has a newer run ID.
  if (!desired.hasAnalyzerRun && desired.state === CommitStatusState.PENDING) {
    return true;
  }
  return (existing.target_url ?? "") === desired.target_url;
}

export async function syncMonitoredStatusesImpl({
  owner,
  repo,
  head_sha,
  issue_number,
  target_url,
  github,
  core,
  checks,
  skipUnchanged = true,
  eventTargetsArmSignoff = false,
  unverifiedOverrideContexts,
}: {
  owner: string;
  repo: string;
  head_sha: string;
  issue_number: number;
  target_url: string;
  github: GitHub;
  core: Core;
  checks: readonly MonitoredStatusCheck[];
  skipUnchanged?: boolean;
  eventTargetsArmSignoff?: boolean;
  unverifiedOverrideContexts?: ReadonlySet<string>;
}): Promise<{ changedContexts: string[]; armSignoffRecheckNeeded: boolean }> {
  if (!isFullGitSha(head_sha)) {
    throw new Error(`head_sha is not a valid full git SHA: '${head_sha}'`);
  }
  core.setOutput("head_sha", head_sha);

  if (!Number.isInteger(issue_number) || issue_number <= 0) {
    throw new Error(`issue_number must be a positive integer: ${issue_number}`);
  }
  core.setOutput("issue_number", issue_number);

  if (checks.length === 0) {
    return { changedContexts: [], armSignoffRecheckNeeded: eventTargetsArmSignoff };
  }

  const [labels, workflowRuns, latestStatuses] = await Promise.all([
    github.paginate(github.rest.issues.listLabelsOnIssue, {
      owner: owner,
      repo: repo,
      issue_number: issue_number,
      per_page: PER_PAGE_MAX,
    }),
    github.paginate(github.rest.actions.listWorkflowRunsForRepo, {
      owner,
      repo,
      event: "pull_request",
      head_sha,
      per_page: PER_PAGE_MAX,
    }),
    skipUnchanged ? getLatestCommitStatuses(github, owner, repo, head_sha) : Promise.resolve([]),
  ]);

  const prLabels = labels.map((label) => label.name);
  core.info(`Labels: ${inspect(prLabels)}`);

  core.info("Workflow Runs:");
  workflowRuns.forEach((wf) => {
    core.info(`- ${wf.name}: ${wf.conclusion || wf.status}`);
  });

  const existingByContext = new Map(latestStatuses.map((status) => [status.context, status]));
  const changedContexts: string[] = [];

  for (const check of checks) {
    const existing = existingByContext.get(check.requiredStatusName);
    const desired = await resolveDesiredStatus({
      owner,
      repo,
      issue_number,
      defaultTargetUrl: target_url,
      github,
      core,
      prLabels,
      workflowRuns,
      check,
      existing,
      skipUnchanged,
      ignoreOverrides: Boolean(unverifiedOverrideContexts?.has(check.requiredStatusName)),
    });

    if (skipUnchanged && isStatusUnchanged(existing, desired)) {
      core.info(
        `Status for '${check.requiredStatusName}' is already '${desired.state}'; skipping redundant write.`,
      );
      continue;
    }

    core.info(`Setting status to '${desired.state}' for '${check.requiredStatusName}'`);
    await github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha: head_sha,
      state: desired.state,
      context: check.requiredStatusName,
      ...(desired.description !== undefined ? { description: desired.description } : {}),
      target_url: desired.target_url,
    });

    changedContexts.push(check.requiredStatusName);
  }

  const armSignoffRecheckNeeded =
    eventTargetsArmSignoff ||
    changedContexts.some((context) => ARM_SIGNOFF_STATUS_CONTEXTS.has(context));

  return { changedContexts, armSignoffRecheckNeeded };
}

export async function setStatusImpl({
  owner,
  repo,
  head_sha,
  issue_number,
  target_url,
  github,
  core,
  monitoredWorkflowName,
  requiredStatusName,
  overridingLabel,
}: {
  owner: string;
  repo: string;
  head_sha: string;
  issue_number: number;
  target_url: string;
  github: GitHub;
  core: Core;
  monitoredWorkflowName: string;
  requiredStatusName: string;
  overridingLabel: string;
}): Promise<void> {
  const overridingLabels = overridingLabel
    ? overridingLabel
        .split(",")
        .map((label) => label.trim())
        .filter((label) => label)
    : [];

  await syncMonitoredStatusesImpl({
    owner,
    repo,
    head_sha,
    issue_number,
    target_url,
    github,
    core,
    checks: [{ monitoredWorkflowName, requiredStatusName, overridingLabels }],
    skipUnchanged: false,
  });
}
