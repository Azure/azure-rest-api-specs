// @ts-check
/**
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @returns {Promise<{owner: string, repo: string, issue_number: number}>}
 */
async function extractInputs(github, context) {
  // Add support for more event types as needed
  if (
    context.eventName === "workflow_run" &&
    context.payload.action === "completed"
  ) {
    const payload =
      /** @type {import("@octokit/webhooks-types").WorkflowRunCompletedEvent} */ (
        context.payload
      );

    // Owner and repo for the PR target
    const owner = payload.workflow_run.repository.owner.login;
    const repo = payload.workflow_run.repository.name;
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

      let commit_sha = process.env.COMMIT_SHA || payload.workflow_run.head_sha;

      const { data: pullRequests } =
        await github.rest.repos.listPullRequestsAssociatedWithCommit({
          owner: head_owner,
          repo: head_repo,
          commit_sha: commit_sha,
        });

      if (pullRequests.length === 1) {
        issue_number = pullRequests[0].number;
      } else {
        throw new Error(
          `Unexpected number of pull requests associated with commit '${commit_sha}'. Expected: '1'. Actual '${pullRequests.length}'.`,
        );
      }
    }

    return { owner: owner, repo: repo, issue_number: issue_number };
  } else {
    throw new Error(
      `Invalid context: '${context.eventName}:${context.payload.action}'.  Expected 'workflow_run:completed'.`,
    );
  }
}

module.exports = { extractInputs };
