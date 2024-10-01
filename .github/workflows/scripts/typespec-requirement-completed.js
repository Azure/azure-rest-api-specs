// @ts-check

// const { existsSync } = require("fs");
// const { addLabelIfNotExists, removeLabelIfExists } = require("./util");

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
module.exports = async ({ github, context, core }) => {
  console.log("context: " + JSON.stringify(context));

  if (context.eventName !== "workflow_run" || context.action == "completed" ) {
    throw new Error(`Invalid context: '${context.eventName}:${context.action}'.  Expected 'workflow_run:completed'.`);
  }

  const payload = /** @type {import("@octokit/webhooks-types").WorkflowRunCompletedEvent} */ (context.payload);

  const artifacts = await github.rest.actions.listWorkflowRunArtifacts({
    owner: payload.repository.owner.login,
    repo: payload.repository.name,
    run_id: payload.workflow_run.id,
  });

  console.log("artifacts: " + JSON.stringify(artifacts));

  // const specLifecycleDataPlaneBrownfield = existsSync("spec-lifecycle-data-plane-brownfield");
  // const specLifecycleResourceManagerBrownfield = existsSync("spec-lifecycle-resource-manager-brownfield");

  // console.log(`specLifecycleDataPlaneBrownfield: ${specLifecycleDataPlaneBrownfield}`);
  // console.log(`specLifecycleResourceManagerBrownfield: ${specLifecycleResourceManagerBrownfield}`);

  // const label = "brownfield";
  // if (specLifecycleDataPlaneBrownfield || specLifecycleResourceManagerBrownfield) {
  //   await addLabelIfNotExists(github, context, core, label);
  // }
  // else {
  //   await removeLabelIfExists(github, context, core, label);
  // }

  //   const payload = /** @type {import("@octokit/webhooks-types").WorkflowRunCompletedEvent} */ (context.payload);

  //   const owner = payload.workflow_run.head_repository.owner.login;
  //   const repo = payload.workflow_run.head_repository.name;
  //   const sha = payload.workflow_run.head_sha;

  //   console.log(`Finding pull requests for '/${owner}/${repo}/${sha}'`);

  //   // Must call this API, since 'payload.workflow_run.pull_requests' is empty for fork PRs
  //   const { data: pullRequests } =
  //     await github.rest.repos.listPullRequestsAssociatedWithCommit({
  //       owner: owner,
  //       repo: repo,
  //       commit_sha: sha,
  //     });

  //   console.log(`Found ${pullRequests.length}`);
  //   if (pullRequests.length === 0) {
  //     console.log("No pull request associated with this commit.");
  //   } else if (pullRequests.length === 1) {
  //     const prNumber = pullRequests[0].number;
  //     await github.rest.issues.addLabels({
  //       owner: context.repo.owner,
  //       repo: context.repo.repo,
  //       issue_number: prNumber,
  //       labels: ["pull-request-completed"],
  //     });
  //   } else {
  //     console.log("Too many pull requests associated with this commit.");
  //   }
  // } else {
  //   console.log("Not adding label 'pull-request-completed'");
  // }
};