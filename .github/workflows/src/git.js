// @ts-check

import { execRoot } from "./exec.js";

const defaultConfig = "-c core.quotepath=off";

/**
 * @param {string} baseCommitish
 * @param {string} headCommitish
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} options
 * @returns {Promise<string>}
 */
export async function diff(baseCommitish, headCommitish, core, options = "") {
  return await execRoot(
    `git ${defaultConfig} diff ${options} ${baseCommitish} ${headCommitish}`,
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
  return await execRoot(
    `git ${defaultConfig} ls-tree ${options} ${treeIsh} ${path}`,
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
export async function show(treeIsh, path, core, options = "") {
  return await execRoot(
    `git ${defaultConfig} show ${options} ${treeIsh}:${path}`,
    core,
  );
}
