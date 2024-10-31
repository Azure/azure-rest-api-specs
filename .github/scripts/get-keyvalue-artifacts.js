// @ts-check

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
module.exports = async ({ github, context, core }) => {
  console.log("context: " + JSON.stringify(context, null, 2));

  let owner = process.env.OWNER;
  let repo = process.env.REPO;
  let run_id = parseInt(process.env.RUN_ID || "");

  if (!owner && !repo && !run_id) {
    if (context.eventName !== "workflow_run" || context.action == "completed") {
      throw new Error(
        `Invalid context: '${context.eventName}:${context.action}'.  Expected 'workflow_run:completed'.`,
      );
    }

    const payload =
      /** @type {import("@octokit/webhooks-types").WorkflowRunCompletedEvent} */ (
        context.payload
      );

    owner = payload.workflow_run.repository.owner.login;
    repo = payload.workflow_run.repository.name;
    run_id = payload.workflow_run.id;
  } else if (!owner || !repo || !run_id) {
    throw new Error(
      "Parameters 'owner', 'repo', and 'run_id' must be all either set or unset",
    );
  }

  const artifacts = await github.rest.actions.listWorkflowRunArtifacts({
    owner: owner,
    repo: repo,
    run_id: run_id,
  });

  console.log("artifacts: " + JSON.stringify(artifacts, null, 2));

  const artifactNames = artifacts.data.artifacts.map((a) => a.name);

  for (const artifactName of artifactNames) {
    // If artifactName has format `key=value`, add the key and value as env vars.
    // If artifactName does not contain "=", ignore.
    // If artifactName contains multiple "=", the key is everything before the first "=",
    // and the value is everything else.
    const firstEquals = artifactName.indexOf("=");
    if (firstEquals !== -1) {
      const key = artifactName.substring(0, firstEquals);
      const value = artifactName.substring(firstEquals + 1);
      core.exportVariable(key, value);
    }
  }
};
