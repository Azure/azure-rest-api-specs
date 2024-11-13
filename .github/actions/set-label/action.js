// @ts-check

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
module.exports = async ({ github, context, core }) => {
  console.log("context: " + JSON.stringify(context, null, 2));

  let owner = process.env.OWNER;
  let repo = process.env.REPO;
  let issue_number = parseInt(process.env.ISSUE_NUMBER || "");

  if (!owner || !repo || !issue_number) {
    // Add support for more event types as needed
    if (
      context.eventName === "workflow_run" &&
      context.payload.action === "completed"
    ) {
      const payload =
        /** @type {import("@octokit/webhooks-types").WorkflowRunCompletedEvent} */ (
          context.payload
        );

      // Only update vars not already set

      // Owner and repo for the PR target
      owner = owner || payload.workflow_run.repository.owner.login;
      repo = repo || payload.workflow_run.repository.name;

      // Owner and repo for the PR head (may differ from target for fork PRs)
      const head_owner = payload.workflow_run.head_repository.owner.login;
      const head_repo = payload.workflow_run.head_repository.name;

      if (!issue_number) {
        let commit_sha =
          process.env.COMMIT_SHA || payload.workflow_run.head_sha;

        // Must call this API, since 'payload.workflow_run.pull_requests' is empty for fork PRs
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
    } else {
      throw new Error(
        `Invalid context: '${context.eventName}:${context.payload.action}'.  Expected 'workflow_run:completed'.`,
      );
    }
  }

  let name = process.env.NAME;
  if (!name) {
    throw new Error(`Invalid name: '${name}'`);
  }

  let value = process.env.VALUE;
  if (value && value.toLowerCase() === "true") {
    await github.rest.issues.addLabels({
      owner: owner,
      repo: repo,
      issue_number: issue_number,
      labels: [name],
    });
  } else if (value && value.toLowerCase() === "false") {
    await github.rest.issues.removeLabel({
      owner: owner,
      repo: repo,
      issue_number: issue_number,
      name: name,
    });
  } else {
    throw new Error(`Invalid value: '${value}'`);
  }
};
