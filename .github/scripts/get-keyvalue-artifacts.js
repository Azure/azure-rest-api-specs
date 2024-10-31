// @ts-check

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @param {string?} owner The account owner of the repository. The name is not case sensitive.
 * @param {string?} repo The name of the repository without the .git extension. The name is not case sensitive.
 * @param {number?} run_id The unique identifier of the workflow run.
 */
module.exports = async ({ github, context, core }, owner, repo, run_id) => {
  console.log("context: " + JSON.stringify(context, null, 2));

  let params;

  if (owner && repo && run_id) {
    params = {
      owner: owner,
      repo: repo,
      run_id: run_id,
    };
  } else if (!owner && !repo && !run_id) {
    if (context.eventName !== "workflow_run" || context.action == "completed") {
      throw new Error(
        `Invalid context: '${context.eventName}:${context.action}'.  Expected 'workflow_run:completed'.`,
      );
    }

    const payload =
      /** @type {import("@octokit/webhooks-types").WorkflowRunCompletedEvent} */ (
        context.payload
      );

    params = {
      owner: payload.workflow_run.repository.owner.login,
      repo: payload.workflow_run.repository.name,
      run_id: payload.workflow_run.id,
    };
  } else {
    throw new Error(
      "Parameters 'owner', 'repo', and 'run_id' must be all either set or unset",
    );
  }

  const artifacts = await github.rest.actions.listWorkflowRunArtifacts({
    owner: params.owner,
    repo: params.repo,
    run_id: params.run_id,
  });

  console.log("artifacts: " + JSON.stringify(artifacts, null, 2));

  const artifactNames = artifacts.data.artifacts.map((a) => a.name);

  core.exportVariable()

  // const label = "brownfield";
  // if (
  //   artifactNames.includes("spec-lifecycle-data-plane=brownfield") ||
  //   artifactNames.includes("spec-lifecycle-resource-manager=brownfield")
  // ) {
  //   await addLabelIfNotExists(
  //     github,
  //     context,
  //     core,
  //     label,
  //   );
  // } else {
  //   await removeLabelIfExists(github, context, core, label);
  // }
};
