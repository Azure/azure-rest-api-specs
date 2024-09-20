// @ts-check

const { promisify } = require("util");

module.exports = {
  addLabelIfNotExists,
  getLabels,
  group,
  hasLabel,
  removeLabelIfExists,
};

/** @type {Map<number, Set<string>>} */
const labelCache = new Map();

/**
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} name
 * @returns {Promise<void>}
 */
async function addLabelIfNotExists(github, context, core, name) {
  await group(`addLabelIfNotExists("${name}")`, async () => {
    if (!context.payload.pull_request) {
      throw new Error("May only run in context of a pull request");
    }

    if (await hasLabel(github, context, name)) {
      console.log(`Already has label '${name}'`);
    }

    core.notice(`Adding label '${name}'`);

    const prNumber = context.payload.pull_request.number;
    const { data: labels } = await github.rest.issues.addLabels({
      owner: context.repo.owner,
      repo: context.repo.repo,
      issue_number: prNumber,
      labels: [name],
    });

    const labelNames = new Set(labels.map((l) => l.name));
    labelCache.set(prNumber, labelNames);
 });
}

/**
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @returns {Promise<Set<string>>} Set of labels associated with the current PR
 */
async function getLabels(github, context) {
  return await group(`getLabels()`, async () => {
    if (!context.payload.pull_request) {
      throw new Error("May only run in context of a pull request");
    }

    const prNumber = context.payload.pull_request.number;

    let labelNames = labelCache.get(prNumber);
    if (!labelNames) {
      const { data: labels } = await github.rest.issues.listLabelsOnIssue({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: prNumber,
      });
      labelNames = new Set(labels.map((l) => l.name));
      labelCache.set(prNumber, labelNames);
    }

    console.log(`Labels: ${Array.from(labelNames).sort()}`);

    return labelNames;
  });
}

/**
 * Wrap an async function in a log group
 *
 * @template T
 * @param {string} name
 * @param {() => Promise<T>} fn
 */
async function group(name, fn) {
  // Uses console.group() instead of @actions/core.group() which doesn't support nesting
  console.group(name);
  try {
    return await fn();
  } finally {
    console.groupEnd();
  }
}

/**
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @param {string} name
 * @returns {Promise<boolean>} True if the current PR contains the named label
 */
async function hasLabel(github, context, name) {
  return await group(`hasLabel("${name}")`, async () => {
    const result = (await getLabels(github, context)).has(name);
    console.log(`returning: ${result}`);
    return result;
  });
}

/**
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} name
 * @returns {Promise<void>}
 */
async function removeLabelIfExists(github, context, core, name) {
  await group(`removeLabelIfExists("${name}")`, async () => {
    if (!context.payload.pull_request) {
      throw new Error("May only run in context of a pull request");
    }

    if (!(await hasLabel(github, context, name))) {
      console.log(`Does not have label '${name}'`);
      return;
    }

    core.notice(`Removing label '${name}'`);

    const prNumber = context.payload.pull_request.number;
    try {
      const {data: labels} = await github.rest.issues.removeLabel({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: prNumber,
        name: name,
      });

      const labelNames = new Set(labels.map((l) => l.name));
      labelCache.set(prNumber, labelNames);
    } catch (error) {
      /** @type {import("@octokit/request-error").RequestError} */
      const requestError = error;

      if (requestError.status == 404) {
        // Label does not exist
      } else {
        throw error;
      }
    }
  });
}
