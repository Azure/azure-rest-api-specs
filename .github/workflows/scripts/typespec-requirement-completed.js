// @ts-check

const { addLabelIfNotExists, removeLabelIfExists } = require("./util");

/**
 * @param {import('github-script').AsyncFunctionArguments["github"]} github
 * @param {import('github-script').AsyncFunctionArguments["context"]} context
 * @param {import('github-script').AsyncFunctionArguments["core"]} core
 */
module.exports = async (github, context, core) => {
  console.log("context: " + JSON.stringify(context, null, 2));

  if (context.eventName !== "workflow_run" || context.action == "completed") {
    throw new Error(
      `Invalid context: '${context.eventName}:${context.action}'.  Expected 'workflow_run:completed'.`,
    );
  }

  const payload =
    /** @type {import("@octokit/webhooks-types").WorkflowRunCompletedEvent} */ (
      context.payload
    );

  const artifacts = await github.rest.actions.listWorkflowRunArtifacts({
    owner: payload.workflow_run.repository.owner.login,
    repo: payload.workflow_run.repository.name,
    run_id: payload.workflow_run.id,
  });

  console.log("artifacts: " + JSON.stringify(artifacts, null, 2));

  const artifactNames = artifacts.data.artifacts.map((a) => a.name);

  const label = "brownfield";
  if (
    artifactNames.includes("spec-lifecycle-data-plane=brownfield") ||
    artifactNames.includes("spec-lifecycle-resource-manager=brownfield")
  ) {
    await addLabelIfNotExists(
      github,
      context,
      core,
      label,
    );
  } else {
    await removeLabelIfExists(github, context, core, label);
  }

  //   const owner = payload.workflow_run.head_repository.owner.login;
  //   const repo = payload.workflow_run.head_repository.name;
  //   const sha = payload.workflow_run.head_sha;

  //   console.log(`Finding pull requests for '/${owner}/${repo}/${sha}'`);

  //   (property) listPullRequestsAssociatedWithCommit: {
  //     parameters: RequestParameters & Endpoints["GET /repos/{owner}/{repo}/commits/{commit_sha}/pulls"]["parameters"];
  //     response: Endpoints["GET /repos/{owner}/{repo}/commits/{commit_sha}/pulls"]["response"];
  // }

  // Must call this API, since 'payload.workflow_run.pull_requests' is empty for fork PRs
  // Must use 'head_repository' instead of 'repository',
  // const { data: pullRequests } =
  //   await github.rest.repos.listPullRequestsAssociatedWithCommit({
  //     owner: owner,
  //     repo: repo,
  //     commit_sha: sha,
  //   });

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
