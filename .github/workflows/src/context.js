// @ts-check

import { PER_PAGE_MAX } from "./github.js";
import { getIssueNumber } from "./issues.js";

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
  core.info(`  payload.action: ${context.eventName}`);
  core.info(`  payload.workflow_run.event: ${context.payload.workflow_run?.event || "undefined"}`);

  // Log full context when debug is enabled.  Most workflows should be idempotent and can be re-run
  // with debug enabled to replay the previous context.
  core.isDebug() && core.debug(`context: ${JSON.stringify(context)}`);

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
        context.payload.action === "unlabeled"))
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

    if (
      payload.workflow_run.event === "pull_request" ||
      payload.workflow_run.event == "pull_request_target"
    ) {
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
        // For non-fork PRs, we should be able to extract the PR number from the payload, which avoids an
        // unnecessary API call.  The listPullRequestsAssociatedWithCommit() API also seems to return
        // empty for non-fork PRs.  This should be the same for pull_request and pull_request_target.
        issue_number = pull_requests[0].number;
      } else {
        // For fork PRs, we must call an API in the head repository to get the PR number in the base repository

        // Owner and repo for the PR head (at least one should differ from base for fork PRs)
        const head_owner = payload.workflow_run.head_repository.owner.login;
        const head_repo = payload.workflow_run.head_repository.name;
        const head_sha = payload.workflow_run.head_sha;

        /** @type {PullRequest[]} */
        let pullRequests = [];

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
          core.debug(`Error: ${error}`);
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
          issue_number = (await getIssueNumber({ head_sha, github, core })).issueNumber;
        } else if (pullRequests.length === 1) {
          issue_number = pullRequests[0].number;
        } else {
          throw new Error(
            `Unexpected number of pull requests associated with commit '${head_sha}'. Expected: '1'. Actual: '${pullRequests.length}'.`,
          );
        }
        if (!issue_number) {
          core.info(
            `Could not find PR for ${head_sha} in ${head_owner}:${head_repo} from either the "commits" or "search" REST APIs`,
          );
        }
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
        // If artifactName has format "issue-number=number", set issue_number
        // Else, if artifactName has format "issue-number=other-string", throw an error
        // Else, if artifactName does not start with "issue-number=", ignore it
        const firstEquals = artifactName.indexOf("=");
        if (firstEquals !== -1) {
          const key = artifactName.substring(0, firstEquals);
          const value = artifactName.substring(firstEquals + 1);

          if (key === "issue-number") {
            const parsedValue = Number.parseInt(value);
            if (parsedValue) {
              issue_number = parsedValue;
              continue;
            } else {
              throw new Error(`Invalid issue-number: '${value}' parsed to '${parsedValue}'`);
            }
          }
        }
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
      head_sha: payload.workflow_run.head_sha,
      issue_number: issue_number,
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
