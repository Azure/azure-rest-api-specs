// @ts-check

import { execRoot } from "./exec";

/**
 * @param {string} treeIsh
 * @param {string} path
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @returns {Promise<string>}
 */
export async function lsTree(treeIsh, path, core) {
  return await execRoot(`git ls-tree ${treeIsh} ${path}`, core);
}
