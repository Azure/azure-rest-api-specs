// @ts-check

import { execFile } from "./exec.js";

/**
 * @typedef {import('./logger.js').ILogger} ILogger
 */

/**
 * @typedef {Object} GitOptions
 * @property {string[]} [args]
 * @property {string} [cwd] Current working directory. Default: process.cwd().
 * @property {ILogger} [logger]
 */

/**
 * @param {string} baseCommitish
 * @param {string} headCommitish
 * @param {GitOptions} [options]
 * @returns {Promise<string>}
 */
export async function diff(baseCommitish, headCommitish, options = {}) {
  const { args = [], cwd, logger } = options;

  return await execGit(["diff", ...args, baseCommitish, headCommitish], {
    cwd,
    logger,
  });
}

/**
 * @param {string} treeIsh
 * @param {string} path
 * @param {GitOptions} [options]
 * @returns {Promise<string>}
 */
export async function lsTree(treeIsh, path, options = {}) {
  const { args = [], cwd, logger } = options;

  return await execGit(["ls-tree", ...args, treeIsh, path], { cwd, logger });
}

/**
 * @param {string} treeIsh
 * @param {string} path
 * @param {GitOptions} [options]
 * @returns {Promise<string>}
 */
export async function show(treeIsh, path, options = {}) {
  const { args = [], cwd, logger } = options;

  return await execGit(["show", ...args, `${treeIsh}:${path}`], {
    cwd,
    logger,
  });
}

/**
 * @param {GitOptions} [options]
 * @returns {Promise<string>}
 */
export async function status(options = {}) {
  const { args = [], cwd, logger } = options;

  return await execGit(["status", ...args], {
    cwd,
    logger,
  });
}

/**
 * @param {string[]} args
 * @param {Object} [options]
 * @param {string} [options.cwd] Current working directory. Default: process.cwd().
 * @param {ILogger} [options.logger]
 * @returns {Promise<string>}
 */
async function execGit(args, options = {}) {
  const { cwd, logger } = options;

  // Ensure that git displays filenames as they are (without escaping)
  const defaultArgs = ["-c", "core.quotepath=off"];

  return await execFile("git", [...defaultArgs, ...args], {
    cwd,
    logger,
  });
}
