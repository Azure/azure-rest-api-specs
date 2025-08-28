// @ts-check

import { isFullGitSha } from "../../shared/src/git.js";
import { PER_PAGE_MAX } from "../../shared/src/github.js";
import { CoreLogger } from "./core-logger.js";
import { createLogHook, createRateLimitHook } from "./github.js";
import { getPullRequest } from "./pull-request.js";

/**
 * @typedef {import('@octokit/plugin-rest-endpoint-methods').RestEndpointMethodTypes} RestEndpointMethodTypes
 * @typedef {RestEndpointMethodTypes["repos"]["listPullRequestsAssociatedWithCommit"]["response"]["data"][number]} PullRequest
 */

/**
 * Extracts inputs from context based on event name and properties.
 * run_id is only defined for "workflow_run:completed" events.
 *
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {import('@actions/github-script').AsyncFunctionArguments['context']} context
 * @param {import('@actions/github-script').AsyncFunctionArguments['core']} core
 * @returns {Promise<{owner: string, repo: string, head_sha: string, issue_number: number, run_id: number, details_url?: string }>}
 */
export async function extractInputs(github, context, core) {
  core.info("extractInputs()");
  core.info(`  eventName: ${context.eventName}`);
  core.info(`  payload.action: ${context.payload.action}`);
  core.info(`  payload.workflow_run.event: ${context.payload.workflow_run?.event || "undefined"}`);

  // Log full context when debug is enabled.  Most workflows should be idempotent and can be re-run
  // with debug enabled to replay the previous context.
  if (core.isDebug()) {
    core.debug(`context: ${JSON.stringify(context)}`);
  }

  const coreLogger = new CoreLogger(core);
  github.hook.before("request", createLogHook(github.request.endpoint, coreLogger));
  github.hook.after("request", createRateLimitHook(coreLogger));

  /** @type {{ owner: string, repo: string, head_sha: string, issue_number: number, run_id: number, details_url?: string }} */
  let inputs;

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

    const payload = /** @type {import("@octokit/webhooks-types").PullRequestEvent} */ (
      context.payload
    );

    inputs = {
      owner: payload.repository.owner.login,
      repo: payload.repository.name,
      head_sha: payload.pull_request.head.sha,
      issue_number: payload.pull_request.number,
      run_id: NaN,
    };
  } else if (context.eventName === "issue_comment" && context.payload.action === "edited") {
    const payload = /** @type {import("@octokit/webhooks-types").IssueCommentEditedEvent} */ (
      context.payload
    );

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
    const payload = /** @type {import("@octokit/webhooks-types").WorkflowDispatchEvent} */ (
      context.payload
    );
    inputs = {
      owner: payload.repository.owner.login,
      repo: payload.repository.name,
      head_sha: "",
      issue_number: NaN,
      run_id: NaN,
    };
  } else if (context.eventName === "workflow_run" && context.payload.action === "completed") {
    const payload = /** @type {import("@octokit/webhooks-types").WorkflowRunCompletedEvent} */ (
      context.payload
    );

    let issue_number = NaN;
    let head_sha = "";

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
      // For pull_request_target, it might be safe to extract the issue number from an artifact, since the workflow runs
      // on the target branch and can be trusted.  But it should also be unnecessary, since we should be able extract
      // the issue number from the payload itself, just like pull_request.

      const pull_requests = payload.workflow_run.pull_requests;
      if (pull_requests && pull_requests.length > 0) {
        // TODO: Only include PRs to the same repo as the triggering workflow (existing filter below)
        // TODO: Throw if more than one open PR to our repo

        // For non-fork PRs, we should be able to extract the PR number from the payload, which avoids an
        // unnecessary API call.  The listPullRequestsAssociatedWithCommit() API also seems to return
        // empty for non-fork PRs.  This should be the same for pull_request and pull_request_target.
        issue_number = pull_requests[0].number;
      } else {
        issue_number = await getPullRequest(
          github,
          head_sha,
          payload.workflow_run.head_repository,
          payload.workflow_run.repository,
          new CoreLogger(core),
        );
      }
    } else if (
      payload.workflow_run.event === "issue_comment" ||
      payload.workflow_run.event == "workflow_run" ||
      payload.workflow_run.event == "check_run"
    ) {
      // Attempt to extract issue number from artifact.  This can be trusted, because it was uploaded from a workflow that is trusted,
      // because "issue_comment" and "workflow_run" only trigger on workflows in the default branch.
      const artifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
        owner: payload.workflow_run.repository.owner.login,
        repo: payload.workflow_run.repository.name,
        run_id: payload.workflow_run.id,
        per_page: PER_PAGE_MAX,
      });

      const artifactNames = artifacts.map((a) => a.name);

      core.info(`artifactNames: ${JSON.stringify(artifactNames)}`);

      for (const artifactName of artifactNames) {
        // If artifactName has format "head-sha=valid-full-sha", set head_sha=value
        //   Else, if artifactName has format "head-sha=other-string", warn and set head_sha=""
        // Else, if artifactName has format "issue-number=positive-integer", set issue_number=value
        //   Else, if artifactName has format "issue-number=other-string", warn and set issue_number=NaN
        //   - Workflows should probably only set "issue-number" to positive integers, but sometimes set it to "null"
        // Else, if artifactName does not start with "head-sha=" or "issue-number=", ignore it
        const firstEquals = artifactName.indexOf("=");
        if (firstEquals !== -1) {
          const key = artifactName.substring(0, firstEquals);
          if (key === "head-sha") {
            const value = artifactName.substring(firstEquals + 1);
            if (isFullGitSha(value)) {
              head_sha = value;
            } else {
              // Producers must ensure they only set head-sha to valid full git SHA
              throw new Error(`head-sha is not a valid full git SHA: '${value}'`);
            }
            continue;
          } else if (key === "issue-number") {
            const value = artifactName.substring(firstEquals + 1);
            const parsedValue = Number.parseInt(value);
            if (parsedValue > 0) {
              issue_number = parsedValue;
            } else {
              // TODO: Consider throwing instead of warning.  May need to handle `issue-number=null|undefined`,
              // but invalid integers should throw.
              core.info(`Invalid issue-number: '${value}' parsed to '${parsedValue}'`);
              issue_number = NaN;
            }
            continue;
          }
        }
      }
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

    inputs = {
      owner: payload.workflow_run.repository.owner.login,
      repo: payload.workflow_run.repository.name,
      head_sha,
      issue_number,
      run_id: payload.workflow_run.id,
    };
  } else if (context.eventName === "check_run") {
    let checkRun = context.payload.check_run;
    const payload = /** @type {import("@octokit/webhooks-types").CheckRunEvent} */ (
      context.payload
    );
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
    const payload = /** @type {import("@octokit/webhooks-types").CheckSuiteCompletedEvent} */ (
      context.payload
    );

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

/**
 * @param {import("@octokit/webhooks-types").Repository | undefined} repository
 * @returns {{ owner: string, repo: string }}
 */
function getRepositoryInfo(repository) {
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
