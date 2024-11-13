// @ts-check

const { extractInputs } = require('../context');

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
module.exports = async ({ github, context, core }) => {
  let owner = process.env.OWNER;
  let repo = process.env.REPO;
  let run_id = parseInt(process.env.RUN_ID || "");

  if (!owner || !repo || !run_id) {
    let inputsFromContext = await extractInputs(github, context, core);
    owner = owner || inputsFromContext.owner;
    repo = repo || inputsFromContext.repo;
    run_id = run_id || inputsFromContext.run_id;
  }

  const artifacts = await github.rest.actions.listWorkflowRunArtifacts({
    owner: owner,
    repo: repo,
    run_id: run_id,
  });

  const artifactNames = artifacts.data.artifacts.map((a) => a.name);

  for (const artifactName of artifactNames) {
    // If artifactName has format "key=value", add the key and value as env vars.
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
