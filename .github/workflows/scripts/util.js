// @ts-check

module.exports = {
  addLabelIfNotExists,
  group,
  removeLabelIfExists,
};

// /** @type {Map<number, Set<string>>} */
// const labelCache = new Map();

/**
 * @param {import('github-script').AsyncFunctionArguments["github"]} github
 * @param {import('github-script').AsyncFunctionArguments["context"]} context
 * @param {import('github-script').AsyncFunctionArguments["core"]} core
 * @param {string} name
 * @returns {Promise<void>}
 */
async function addLabelIfNotExists(github, context, core, name) {
//   await group(`addLabelIfNotExists("${name}")`, async () => {
//     // TODO: Add support for workflow_run from a pull_request context
//     if (!context.payload.pull_request) {
//       throw new Error("May only run in context of a pull request");
//     }

//     if (await hasLabel(github, context, name)) {
//       console.log(`Already has label '${name}'`);
//       return;
//     }

//     core.notice(`Adding label '${name}'`);

//     const prNumber = context.payload.pull_request.number;
//     const { data: labels } = await github.rest.issues.addLabels({
//       owner: context.repo.owner,
//       repo: context.repo.repo,
//       issue_number: prNumber,
//       labels: [name],
//     });

//     const labelNames = new Set(labels.map((l) => l.name));
//     labelCache.set(prNumber, labelNames);
//   });
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
 * @param {import('github-script').AsyncFunctionArguments["github"]} github
 * @param {import('github-script').AsyncFunctionArguments["context"]} context
 * @param {import('github-script').AsyncFunctionArguments["core"]} core
 * @param {string} name
 * @returns {Promise<void>}
 */
async function removeLabelIfExists(github, context, core, name) {
//   await group(`removeLabelIfExists("${name}")`, async () => {
//     if (!context.payload.pull_request) {
//       throw new Error("May only run in context of a pull request");
//     }

//     if (!(await hasLabel(github, context, name))) {
//       console.log(`Does not have label '${name}'`);
//       return;
//     }

//     core.notice(`Removing label '${name}'`);

//     const prNumber = context.payload.pull_request.number;
//     try {
//       const {data: labels} = await github.rest.issues.removeLabel({
//         owner: context.repo.owner,
//         repo: context.repo.repo,
//         issue_number: prNumber,
//         name: name,
//       });

//       const labelNames = new Set(labels.map((l) => l.name));
//       labelCache.set(prNumber, labelNames);
//     } catch (error) {
//       /** @type {import("@octokit/request-error").RequestError} */
//       const requestError = error;

//       if (requestError.status == 404) {
//         // Label does not exist
//       } else {
//         throw error;
//       }
//     }
//   });
}
