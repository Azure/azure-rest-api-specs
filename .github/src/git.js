// @ts-check

// Ignore code coverage since code is simple but hard to mock
/* v8 ignore start */

import { execRoot } from "./exec.js";

/**
 * @param {string} baseCommitish
 * @param {string} headCommitish
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} options
 * @returns {Promise<string>}
 */
export async function diff(baseCommitish, headCommitish, core, options = "") {
  return await execGit(
    `diff ${options} ${baseCommitish} ${headCommitish}`,
    core,
  );
}

/**
 * @param {string} treeIsh
 * @param {string} path
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} options
 * @returns {Promise<string>}
 */
export async function lsTree(treeIsh, path, core, options = "") {
  return await execGit(`ls-tree ${options} ${treeIsh} ${path}`, core);
}

/**
 * @param {string} treeIsh
 * @param {string} path
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} options
 * @returns {Promise<string>}
 */
export async function show(treeIsh, path, core, options = "") {
  return await execGit(`show ${options} ${treeIsh}:${path}`, core);
}

/**
 * @param {string} args
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @returns {Promise<string>}
 */
async function execGit(args, core) {
  // Ensure that git displays filenames as they are (without escaping)
  const defaultConfig = "-c core.quotepath=off";
  return await execRoot(`git ${defaultConfig} ${args}`, core);
}
