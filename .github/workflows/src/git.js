// @ts-check

import { execRoot } from "./exec.js";

/**
 * @param {string} treeIsh
 * @param {string} path
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} options
 * @returns {Promise<string>}
 */
export async function lsTree(treeIsh, path, core, options = "") {
  return await execRoot(`git ls-tree ${options} ${treeIsh} ${path}`, core);
}

/**
 * @param {string} treeIsh
 * @param {string} path
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} options
 * @returns {Promise<string>}
 */
export async function show(treeIsh, path, core, options = "") {
  return await execRoot(`git show ${options} ${treeIsh}:${path}`, core);
}
