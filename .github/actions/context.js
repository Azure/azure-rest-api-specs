// @ts-check

/**
 * Extracts inputs from context based on event name and properties.
 * run_id is only defined for "workflow_run:completed" events.
 * 
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @returns {Promise<{owner: string, repo: string, head_sha: string, issue_number: number, run_id: number }>}
 */
async function extractInputs(github, context, core) {
  core.info(`extractInputs(${context.eventName}, ${context.payload.action})`);

  // Add support for more event types as needed
  if (context.eventName === "pull_request") {
    const payload =
      /** @type {import("@octokit/webhooks-types").PullRequestEvent} */ (
        context.payload
      );

    const inputs = {
      owner: payload.repository.owner.login,
      repo: payload.repository.name,
      head_sha: payload.pull_request.head.sha,
      issue_number: payload.number,
      run_id: NaN
    };
  
    core.info(`inputs: ${JSON.stringify(inputs)}`);
  
    return inputs;
  } else if (
    context.eventName === "workflow_run" &&
    context.payload.action === "completed"
  ) {
    const payload =
      /** @type {import("@octokit/webhooks-types").WorkflowRunCompletedEvent} */ (
        context.payload
      );

    let issue_number;

    const pull_requests = payload.workflow_run.pull_requests;
    if (pull_requests && pull_requests.length > 0) {
      // For non-fork PRs, we should be able to extract the PR number from the payload, which avoids an
      // unnecessary API call.  The listPullRequestsAssociatedWithCommit() API also seems to return
      // empty for non-fork PRs.
      issue_number = pull_requests[0].number;
    } else {
      // For fork PRs, we must call an API in the head repository to get the PR number in the target repository

      // Owner and repo for the PR head (may differ from target for fork PRs)
      const head_owner = payload.workflow_run.head_repository.owner.login;
      const head_repo = payload.workflow_run.head_repository.name;
      const head_sha = payload.workflow_run.head_sha;

      core.info(
        `listPullRequestsAssociatedWithCommit(${head_owner}, ${head_repo}, ${head_sha})`,
      );
      const { data: pullRequests } =
        await github.rest.repos.listPullRequestsAssociatedWithCommit({
          owner: head_owner,
          repo: head_repo,
          commit_sha: head_sha,
        });

      if (pullRequests.length === 1) {
        issue_number = pullRequests[0].number;
      } else {
        throw new Error(
          `Unexpected number of pull requests associated with commit '${head_sha}'. Expected: '1'. Actual '${pullRequests.length}'.`,
        );
      }
    }

    const inputs = {
      owner: payload.workflow_run.repository.owner.login,
      repo: payload.workflow_run.repository.name,
      head_sha: payload.workflow_run.head_sha,
      issue_number: issue_number,
      run_id: payload.workflow_run.id,
    };

    core.info(`inputs: ${JSON.stringify(inputs)}`);

    return inputs;
  } else {
    throw new Error(
      `Invalid context: '${context.eventName}:${context.payload.action}'.  Expected 'workflow_run:completed'.`,
    );
  }
}

module.exports = { extractInputs };
