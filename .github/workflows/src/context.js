// @ts-check

import { PER_PAGE_MAX } from "./github.js";

/**
 * Extracts inputs from context based on event name and properties.
 * run_id is only defined for "workflow_run:completed" events.
 *
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @returns {Promise<{owner: string, repo: string, head_sha: string, issue_number: number, run_id: number }>}
 */
export async function extractInputs(github, context, core) {
  core.info("extractInputs()");
  core.info(`  eventName: ${context.eventName}`);
  core.info(`  payload.action: ${context.eventName}`);
  core.info(
    `  payload.workflow_run.event: ${context.payload.workflow_run?.event || "undefined"}`,
  );

  // Log full context when debug is enabled.  Most workflows should be idempotent and can be re-run
  // with debug enabled to replay the previous context.
  core.isDebug() && core.debug(`context: ${JSON.stringify(context)}`);

  /** @type {{ owner: string, repo: string, head_sha: string, issue_number: number, run_id: number }} */
  let inputs;

  // Add support for more event types as needed
  if (
    context.eventName === "pull_request" ||
    (context.eventName === "pull_request_target" &&
      // "pull_request_target" is particularly dangerous, so only support actions as needed
      (context.payload.action === "labeled" ||
        context.payload.action === "unlabeled"))
  ) {
    // Most properties on payload should be the same for both pull_request and pull_request_target

    const payload =
      /** @type {import("@octokit/webhooks-types").PullRequestEvent} */ (
        context.payload
      );

    inputs = {
      owner: payload.repository.owner.login,
      repo: payload.repository.name,
      head_sha: payload.pull_request.head.sha,
      issue_number: payload.pull_request.number,
      run_id: NaN,
    };
  } else if (
    context.eventName === "issue_comment" &&
    context.payload.action === "edited"
  ) {
    const payload =
      /** @type {import("@octokit/webhooks-types").IssueCommentEditedEvent} */ (
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
    const payload =
      /** @type {import("@octokit/webhooks-types").WorkflowDispatchEvent} */ (
        context.payload
      );

    inputs = {
      owner: payload.repository.owner.login,
      repo: payload.repository.name,
      head_sha: "",
      issue_number: NaN,
      run_id: NaN,
    };
  } else if (
    context.eventName === "workflow_run" &&
    context.payload.action === "completed"
  ) {
    const payload =
      /** @type {import("@octokit/webhooks-types").WorkflowRunCompletedEvent} */ (
        context.payload
      );

    let issue_number;

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

        core.info(
          `listPullRequestsAssociatedWithCommit(${head_owner}, ${head_repo}, ${head_sha})`,
        );
        const pullRequests = await github.paginate(
          github.rest.repos.listPullRequestsAssociatedWithCommit,
          {
            owner: head_owner,
            repo: head_repo,
            commit_sha: head_sha,
            per_page: PER_PAGE_MAX,
          },
        );

        if (pullRequests.length === 1) {
          issue_number = pullRequests[0].number;
        } else {
          // TODO: Consider calling search API in target repo if we get an unexpected result from the head repo (#33005)
          throw new Error(
            `Unexpected number of pull requests associated with commit '${head_sha}'. Expected: '1'. Actual: '${pullRequests.length}'.`,
          );
        }
      }
    } else if (
      payload.workflow_run.event === "issue_comment" ||
      payload.workflow_run.event == "workflow_run"
    ) {
      // Attempt to extract issue number from artifact.  This can be trusted, because it was uploaded from a workflow that is trusted,
      // because "issue_comment" and "workflow_run" only trigger on workflows in the default branch.
      const artifacts = await github.paginate(
        github.rest.actions.listWorkflowRunArtifacts,
        {
          owner: payload.workflow_run.repository.owner.login,
          repo: payload.workflow_run.repository.name,
          run_id: payload.workflow_run.id,
          per_page: PER_PAGE_MAX,
        },
      );

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
              throw new Error(
                `Invalid issue-number: '${value}' parsed to '${parsedValue}'`,
              );
            }
          }
        }
      }

      if (!issue_number) {
        throw new Error(
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
  } else {
    throw new Error(
      `Context '${context.eventName}:${context.payload.action}' is not yet supported.`,
    );
  }

  core.info(`inputs: ${JSON.stringify(inputs)}`);
  return inputs;
}
