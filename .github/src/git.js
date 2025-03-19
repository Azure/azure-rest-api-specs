// @ts-check

import { buildCmd, execRoot } from "./exec.js";

/**
 * @typedef {import('./types.js').ILogger} ILogger
 */

/**
 * @param {string} baseCommitish
 * @param {string} headCommitish
 * @param {Object} [options]
 * @param {string} [options.args]
 * @param {ILogger} [options.logger]
 * @returns {Promise<string>}
 */
export async function diff(baseCommitish, headCommitish, options = {}) {
  const { args, logger } = options;

  const cmd = buildCmd("diff", args, baseCommitish, headCommitish);

  return await execGit(cmd, {
    logger: logger,
  });
}

/**
 * @param {string} treeIsh
 * @param {string} path
 * @param {Object} [options]
 * @param {string} [options.args]
 * @param {ILogger} [options.logger]
 * @returns {Promise<string>}
 */
export async function lsTree(treeIsh, path, options = {}) {
  const { args, logger } = options;

  const cmd = buildCmd("ls-tree", args, `${treeIsh}:${path}`);

  return await execGit(cmd, {
    logger: logger,
  });
}

/**
 * @param {string} treeIsh
 * @param {string} path
 * @param {Object} [options]
 * @param {string} [options.args]
 * @param {ILogger} [options.logger]
 * @returns {Promise<string>}
 */
export async function show(treeIsh, path, options = {}) {
  const { args, logger } = options;

  const cmd = buildCmd("show", args, `${treeIsh}:${path}`);

  return await execGit(cmd, { logger: logger });
}

/**
 * @param {string} args
 * @param {Object} [options]
 * @param {ILogger} [options.logger]
 * @returns {Promise<string>}
 */
async function execGit(args, options) {
  // Ensure that git displays filenames as they are (without escaping)
  const defaultConfig = "-c core.quotepath=off";

  const cmd = buildCmd("git", defaultConfig, args);

  return await execRoot(cmd, options);
}
