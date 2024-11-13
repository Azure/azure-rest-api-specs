// @ts-check

const { extractInputs } = require('../context');

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
module.exports = async ({ github, context }) => {
  console.log("context: " + JSON.stringify(context, null, 2));

  let owner = process.env.OWNER;
  let repo = process.env.REPO;
  let issue_number = parseInt(process.env.ISSUE_NUMBER || "");

  if (!owner || !repo || !issue_number) {
    let inputsFromContext = await extractInputs(github, context);
    owner = owner || inputsFromContext.owner;
    repo = repo || inputsFromContext.repo;
    issue_number = issue_number || inputsFromContext.issue_number;
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
