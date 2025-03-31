// @ts-check

import { buildCmd, exec } from "./exec.js";

/**
 * @typedef {import('./types.js').ILogger} ILogger
 */

/**
 * @param {string} baseCommitish
 * @param {string} headCommitish
 * @param {Object} [options]
 * @param {string} [options.args]
 * @param {string} [options.cwd] Current working directory. Default: process.cwd().
 * @param {ILogger} [options.logger]
 * @returns {Promise<string>}
 */
export async function diff(baseCommitish, headCommitish, options = {}) {
  const { args, cwd, logger } = options;

  const cmd = buildCmd("diff", args, baseCommitish, headCommitish);

  return await execGit(cmd, { cwd, logger });
}

/**
 * @param {string} treeIsh
 * @param {string} path
 * @param {Object} [options]
 * @param {string} [options.args]
 * @param {string} [options.cwd] Current working directory.  Default process.cwd().
 * @param {ILogger} [options.logger]
 * @returns {Promise<string>}
 */
export async function lsTree(treeIsh, path, options = {}) {
  const { args, cwd, logger } = options;

  const cmd = buildCmd("ls-tree", args, treeIsh, path);

  return await execGit(cmd, { cwd, logger });
}

/**
 * @param {string} treeIsh
 * @param {string} path
 * @param {Object} [options]
 * @param {string} [options.args]
 * @param {string} [options.cwd] Current working directory. Default: process.cwd().
 * @param {ILogger} [options.logger]
 * @returns {Promise<string>}
 */
export async function show(treeIsh, path, options = {}) {
  const { args, cwd, logger } = options;

  const cmd = buildCmd("show", args, `${treeIsh}:${path}`);

  return await execGit(cmd, { cwd, logger });
}

/**
 * @param {string} args
 * @param {Object} [options]
 * @param {string} [options.cwd] Current working directory. Default: process.cwd().
 * @param {ILogger} [options.logger]
 * @returns {Promise<string>}
 */
async function execGit(args, options = {}) {
  const { cwd, logger } = options;

  // Ensure that git displays filenames as they are (without escaping)
  const defaultConfig = "-c core.quotepath=off";

  const cmd = buildCmd("git", defaultConfig, args);

  return await exec(cmd, { cwd, logger });
}
