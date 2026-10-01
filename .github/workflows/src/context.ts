import { inspect } from "node:util";
import { isFullGitSha } from "../../shared/src/git.ts";
import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import { CoreLogger } from "./core-logger.ts";
import type { Context, Core, GitHub, WebhookEvent } from "./github.ts";
import { createLogHook, createRateLimitHook } from "./github.ts";
import { getIssueNumber } from "./issues.ts";

export type PullRequest =
  RestEndpointMethodTypes["repos"]["listPullRequestsAssociatedWithCommit"]["response"]["data"][number];

export type RestEndpointMethodTypes =
  import("@octokit/plugin-rest-endpoint-methods").RestEndpointMethodTypes;

export const ARM_API_REVIEW_WORKFLOW_NAME = "ARM API Review: Automated Workflow";

/**
 * Extracts inputs from context based on event name and properties.
 * run_id is only defined for "workflow_run:completed" events.
 */
export async function extractInputs(
  github: GitHub,
  context: Context,
  core: Core,
): Promise<{
  owner: string;
  repo: string;
  head_sha: string;
  issue_number: number;
  run_id: number;
  details_url?: string;
}> {
  core.info("extractInputs()");
  core.info(`  eventName: ${context.eventName}`);
  core.info(`  payload.action: ${context.payload.action}`);

  let workflowRunEvent = "undefined";
  if (context.eventName === "workflow_run") {
    const payload = context.payload as WebhookEvent<"workflow-run">;
    workflowRunEvent = payload.workflow_run?.event;
  }
  core.info(`  payload.workflow_run.event: ${workflowRunEvent}`);

  // Log full context when debug is enabled.  Most workflows should be idempotent and can be re-run
  // with debug enabled to replay the previous context.
  if (core.isDebug()) {
    core.debug(`context: ${JSON.stringify(context)}`);
  }

  const coreLogger = new CoreLogger(core);
  github.hook.before("request", createLogHook(github.request.endpoint, coreLogger));
  github.hook.after("request", createRateLimitHook(coreLogger));

  let inputs: {
    owner: string;
    repo: string;
    head_sha: string;
    issue_number: number;
    run_id: number;
    details_url?: string;
  };

  // Add support for more event types as needed
  if (
    context.eventName === "pull_request" ||
    (context.eventName === "pull_request_target" &&
      // "pull_request_target" is particularly dangerous, so only support actions as needed
      (context.payload.action === "opened" ||
        context.payload.action === "synchronize" ||
        context.payload.action === "reopened" ||
        context.payload.action === "labeled" ||
        context.payload.action === "unlabeled" ||
        context.payload.action === "edited" ||
        context.payload.action === "ready_for_review" ||
        context.payload.action === "converted_to_draft"))
  ) {
    // Most properties on payload should be the same for both pull_request and pull_request_target

    const payload = context.payload as WebhookEvent<"pull-request">;

    inputs = {
      owner: payload.repository.owner.login,
      repo: payload.repository.name,
      head_sha: payload.pull_request.head.sha,
      issue_number: payload.pull_request.number,
      run_id: NaN,
    };
  } else if (context.eventName === "issue_comment" && context.payload.action === "edited") {
    const payload = context.payload as WebhookEvent<"issue-comment", "edited">;

    const owner = payload.repository.owner.login;
    const repo = payload.repository.name;
    const issue_number = payload.issue.number;

    const { data: pr } = await github.rest.pulls.get({
      owner: owner,
      repo: repo,
      pull_number: issue_number,
    });

    inputs = {
      owner: owner,
      repo: repo,
      head_sha: pr.head.sha,
      issue_number: issue_number,
      run_id: NaN,
    };
  } else if (context.eventName === "workflow_dispatch") {
    const payload = context.payload as WebhookEvent<"workflow-dispatch">;
    inputs = {
      owner: payload.repository.owner.login,
      repo: payload.repository.name,
      head_sha: "",
      issue_number: NaN,
      run_id: NaN,
    };
  } else if (context.eventName === "workflow_run" && context.payload.action === "completed") {
    const payload = context.payload as WebhookEvent<"workflow-run", "completed">;

    let issue_number: number;
    let head_sha: string;

    if (
      payload.workflow_run.event === "pull_request" ||
      payload.workflow_run.event == "pull_request_target"
    ) {
      head_sha = payload.workflow_run.head_sha;

      // Other properties on payload.workflow_run should be the same for both pull_request and pull_request_target.

      // Extract the issue number from the payload itself, or by passing the head_sha to an API.
      //
      // For pull_request, do NOT attempt to extract the issue number from an artifact, since this could be modified
      // in a fork PR.
      //
      // For pull_request_target, trusted artifacts carry the PR head SHA because workflow_run.head_sha identifies
      // the base branch commit. The issue number is also read from the artifacts and checked against the event.

      const pullRequest = payload.workflow_run.pull_requests?.find((pr) => pr !== null);
      if (pullRequest) {
        // TODO: Only include PRs to the same repo as the triggering workflow (existing filter below)
        // TODO: Throw if more than one open PR to our repo

        // For non-fork PRs, we should be able to extract the PR number from the payload, which avoids an
        // unnecessary API call.  The listPullRequestsAssociatedWithCommit() API also seems to return
        // empty for non-fork PRs.  This should be the same for pull_request and pull_request_target.
        issue_number = pullRequest.number;
      } else {
        // For fork PRs, we must call an API in the head repository to get the PR number in the base repository

        // Owner and repo for the PR head (at least one should differ from base for fork PRs)
        const { owner: head_owner, repo: head_repo } = getRepositoryInfo(
          payload.workflow_run.head_repository,
        );

        let pullRequests: PullRequest[] = [];

        try {
          core.info(
            `listPullRequestsAssociatedWithCommit(${head_owner}, ${head_repo}, ${head_sha})`,
          );
          pullRequests = (
            await github.paginate(github.rest.repos.listPullRequestsAssociatedWithCommit, {
              owner: head_owner,
              repo: head_repo,
              commit_sha: head_sha,
              per_page: PER_PAGE_MAX,
            })
          ).filter(
            // Only include PRs to the same repo as the triggering workflow.
            //
            // Other unique keys like "full_name" should also work, but "id" is the safest since it's
            // supposed to be guaranteed unique and never change (repos can be renamed or change owners).
            (pr) => pr.base.repo.id === payload.workflow_run.repository.id,
          );
        } catch (error) {
          // Short message always
          core.info(`Error: ${error instanceof Error ? error.message : "unknown"}`);

          // Long message only in debug
          core.debug(`Error: ${inspect(error)}`);
        }

        if (pullRequests.length === 0) {
          // There are three cases where the "commits" REST API called above can return
          // empty, even if there is an open PR from the commit:
          //
          // 1. If the head branch of a fork PR is the default branch of the fork repo, the
          //    API always returns empty. (#33315)
          // 2. If a PR was just merged, the API may return empty for a brief window (#33416).
          // 3. The API may fail occasionally for no known reason (#33417).
          //
          // In any case, the solution is to fall back to the (lower-rate-limit) search API.
          // The search API is confirmed to work in case #1, but has not been tested in #2 or #3.
          issue_number = (await getIssueNumber(github, head_sha, coreLogger)).issueNumber;
        } else if (pullRequests.length === 1) {
          issue_number = pullRequests[0].number;
        } else {
          throw new Error(
            `Unexpected number of pull requests associated with commit '${head_sha}'. ` +
              `Expected: '1'. Actual: '${pullRequests.length}'. PRs:\n` +
              pullRequests.map((pr) => pr.html_url).join("\n"),
          );
        }
        if (!issue_number) {
          core.info(
            `Could not find PR for ${head_sha} in ${head_owner}:${head_repo} from either the "commits" or "search" REST APIs`,
          );
        }
      }

      if (payload.workflow_run.event === "pull_request_target") {
        const artifactInputs = await extractWorkflowRunArtifactInputs({
          github,
          core,
          repository: payload.workflow_run.repository,
          runId: payload.workflow_run.id,
        });
        if (artifactInputs.headSha) {
          head_sha = artifactInputs.headSha;
        } else if (payload.workflow_run.name === ARM_API_REVIEW_WORKFLOW_NAME) {
          head_sha = "";
        }
        if (artifactInputs.issueNumber) {
          if (issue_number && issue_number !== artifactInputs.issueNumber) {
            throw new Error(
              `Workflow artifacts reference PR ${artifactInputs.issueNumber}, but the event references PR ${issue_number}`,
            );
          }
          issue_number = artifactInputs.issueNumber;
        }
      }
    } else if (
      payload.workflow_run.event === "issue_comment" ||
      payload.workflow_run.event == "workflow_run" ||
      payload.workflow_run.event == "check_run" ||
      payload.workflow_run.event == "workflow_dispatch"
    ) {
      // These artifacts can be trusted because these event types run workflows from the default branch.
      const artifactInputs = await extractWorkflowRunArtifactInputs({
        github,
        core,
        repository: payload.workflow_run.repository,
        runId: payload.workflow_run.id,
      });
      head_sha = artifactInputs.headSha;
      issue_number = artifactInputs.issueNumber;
      if (!head_sha) {
        core.info(
          `Could not find 'head-sha' artifact, which is required to associate the triggering workflow run with the head SHA of a PR`,
        );
      }
      if (!issue_number) {
        core.info(
          `Could not find 'issue-number' artifact, which is required to associate the triggering workflow run with a PR`,
        );
      }
    } else {
      throw new Error(
        `Context '${context.eventName}:${context.payload.action}' with 'workflow_run.event=${payload.workflow_run.event} is not yet supported.`,
      );
    }

    if (
      payload.workflow_run.name === ARM_API_REVIEW_WORKFLOW_NAME &&
      (!Number.isSafeInteger(issue_number) || issue_number <= 0 || !isFullGitSha(head_sha))
    ) {
      const match = /^ARM API Review #([1-9]\d*) \(/.exec(payload.workflow_run.display_title ?? "");
      const fallbackIssueNumber = match ? Number(match[1]) : NaN;
      const resolvedIssueNumber =
        Number.isSafeInteger(issue_number) && issue_number > 0 ? issue_number : fallbackIssueNumber;
      if (Number.isSafeInteger(resolvedIssueNumber) && resolvedIssueNumber > 0) {
        const { owner, repo } = getRepositoryInfo(payload.workflow_run.repository);
        const { data: pullRequest } = await github.rest.pulls.get({
          owner,
          repo,
          pull_number: resolvedIssueNumber,
        });
        issue_number = resolvedIssueNumber;
        if (!isFullGitSha(head_sha)) {
          head_sha = pullRequest.head.sha;
        }
      }
    }

    inputs = {
      ...getRepositoryInfo(payload.workflow_run.repository),
      head_sha,
      issue_number,
      run_id: payload.workflow_run.id,
    };
  } else if (context.eventName === "check_run") {
    const payload = context.payload as WebhookEvent<"check-run">;
    const checkRun = payload.check_run;
    const repositoryInfo = getRepositoryInfo(payload.repository);
    inputs = {
      owner: repositoryInfo.owner,
      repo: repositoryInfo.repo,
      head_sha: checkRun.head_sha,
      details_url: checkRun.details_url,
      issue_number: NaN,
      run_id: NaN,
    };
  } else if (context.eventName === "check_suite" && context.payload.action === "completed") {
    const payload = context.payload as WebhookEvent<"check-suite", "completed">;

    const repositoryInfo = getRepositoryInfo(payload.repository);
    inputs = {
      owner: repositoryInfo.owner,
      repo: repositoryInfo.repo,
      head_sha: payload.check_suite.head_sha,

      // These are NaN today because the only consumer of this event needs only
      // the head_sha
      issue_number: NaN,
      run_id: NaN,
    };
  } else {
    throw new Error(
      `Context '${context.eventName}:${context.payload.action}' is not yet supported.`,
    );
  }

  core.info(`inputs: ${JSON.stringify(inputs)}`);
  return inputs;
}

async function extractWorkflowRunArtifactInputs({
  github,
  core,
  repository,
  runId,
}: {
  github: GitHub;
  core: Core;
  repository: Parameters<typeof getRepositoryInfo>[0];
  runId: number;
}): Promise<{ headSha: string; issueNumber: number }> {
  const artifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
    ...getRepositoryInfo(repository),
    run_id: runId,
    per_page: PER_PAGE_MAX,
  });
  const artifactNames = artifacts.map((artifact) => artifact.name);
  core.info(`artifactNames: ${JSON.stringify(artifactNames)}`);

  let headSha = "";
  let issueNumber = NaN;
  for (const artifactName of artifactNames) {
    const firstEquals = artifactName.indexOf("=");
    if (firstEquals === -1) {
      continue;
    }

    const key = artifactName.substring(0, firstEquals);
    const value = artifactName.substring(firstEquals + 1);
    if (key === "head-sha") {
      if (!isFullGitSha(value)) {
        throw new Error(`head-sha is not a valid full git SHA: '${value}'`);
      }
      if (headSha && headSha.toLowerCase() !== value.toLowerCase()) {
        throw new Error(`Conflicting head-sha artifacts: '${headSha}' and '${value}'`);
      }
      headSha = value;
    } else if (key === "issue-number") {
      const parsedValue = /^[1-9]\d*$/.test(value) ? Number(value) : NaN;
      if (Number.isSafeInteger(parsedValue)) {
        if (Number.isSafeInteger(issueNumber) && issueNumber !== parsedValue) {
          throw new Error(
            `Conflicting issue-number artifacts: '${issueNumber}' and '${parsedValue}'`,
          );
        }
        issueNumber = parsedValue;
      } else {
        core.info(`Invalid issue-number artifact: '${value}'`);
        issueNumber = NaN;
      }
    }
  }

  return { headSha, issueNumber };
}

function getRepositoryInfo(
  repository: { name?: string; owner?: { login?: string } | null } | null | undefined,
): {
  owner: string;
  repo: string;
} {
  if (!repository || !repository.owner || !repository.owner.login || !repository.name) {
    throw new Error(
      `Could not extract repository owner or name from context payload: ${JSON.stringify(repository)}`,
    );
  }

  return {
    owner: repository.owner.login,
    repo: repository.name,
  };
}
