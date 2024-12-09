// @ts-check

const { extractInputs } = require("../context");

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
module.exports = async ({ github, context, core }) => {
  let owner = process.env.OWNER;
  let repo = process.env.REPO;
  let issue_number = parseInt(process.env.ISSUE_NUMBER || "");
  let run_id = parseInt(process.env.RUN_ID || "");

  if (!owner || !repo || !(issue_number || run_id)) {
    let inputs = await extractInputs(github, context, core);
    owner = owner || inputs.owner;
    repo = repo || inputs.repo;
    issue_number = issue_number || inputs.issue_number;
    run_id = run_id || inputs.run_id;
  }

  /** @type {string[]} */
  let artifactNames = [];

  if (run_id) {
    // List artifacts from a single run_id
    core.info(`listWorkflowRunArtifacts(${owner}, ${repo}, ${run_id})`);
    const artifacts = await github.rest.actions.listWorkflowRunArtifacts({
      owner: owner,
      repo: repo,
      run_id: run_id,
    });

    artifactNames = artifacts.data.artifacts.map((a) => a.name);
  } else {
    // TODO: List all artifacts of all workflows associated with issue_number
    throw new Error("Required input 'run_id' not found in env or context");
  }

  core.info(`artifactNames: ${JSON.stringify(artifactNames)}`);

  /** @type {string[]} */
  const labelsToAdd = [];

  /** @type {string[]} */
  const labelsToRemove = [];

  for (const artifactName of artifactNames) {
    // If artifactName has format "label-name=true|false", add or remove the label
    // Else, if artifactName has format "label-name=other-string", throw an error
    // Else, if artifactName does not start with "label-", ignore it
    const firstEquals = artifactName.indexOf("=");
    if (firstEquals !== -1) {
      const key = artifactName.substring(0, firstEquals);
      const value = artifactName.substring(firstEquals + 1);

      if (key.startsWith("label-")) {
        const name = key.substring("label-".length);
        if (value === "true") {
          labelsToAdd.push(name);
        } else if (value === "false") {
          labelsToRemove.push(name);
        } else {
          throw new Error(
            `Invalid value for label '${name}': ${value}.  Expected "true" or "false".`,
          );
        }
      }
    }
  }

  core.info(`labelsToAdd: ${JSON.stringify(labelsToAdd)}`);
  core.info(`labelsToRemove: ${JSON.stringify(labelsToRemove)}`);

  if (labelsToAdd.length > 0) {
    await github.rest.issues.addLabels({
      owner: owner,
      repo: repo,
      issue_number: issue_number,
      labels: labelsToAdd,
    });
  }

  if (labelsToRemove.length > 0) {
    // Must loop over labelsToRemove ourselves, since GitHub doesn't expose a REST API to remove in bulk. 
    for (const name of labelsToRemove) {
      try {
        await github.rest.issues.removeLabel({
          owner: owner,
          repo: repo,
          issue_number: issue_number,
          name: name,
        });
      } catch (error) {
        if (error.status === 404) {
          core.info(`Ignoring error: ${error.status} - ${error.message}`);
        } else {
          throw error;
        }
      }
    }
  }
};
