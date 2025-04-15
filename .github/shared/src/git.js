// @ts-check

import { simpleGit } from "simple-git";

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
  const allArgs = [...args, baseCommitish, headCommitish];

  logger?.info(`diff(${JSON.stringify(allArgs)})`);

  const git = simpleGit(cwd);
  const result = await git.diff(allArgs);

  logger?.debug(`result: ${result}`);

  return result;
}

/**
 * @param {string} treeIsh
 * @param {string} path
 * @param {GitOptions} [options]
 * @returns {Promise<string>}
 */
export async function lsTree(treeIsh, path, options = {}) {
  const { args = [], cwd, logger } = options;
  const allArgs = [...args, treeIsh, path];

  logger?.info(`lsTree(${JSON.stringify(allArgs)})`);

  const git = simpleGit(cwd);
  const result = await git.raw(["ls-tree", ...allArgs]);

  logger?.debug(`result: ${result}`);

  return result;
}

/**
 * @param {string} treeIsh
 * @param {string} path
 * @param {GitOptions} [options]
 * @returns {Promise<string>}
 */
export async function show(treeIsh, path, options = {}) {
  const { args = [], cwd, logger } = options;
  const allArgs = [...args, `${treeIsh}:${path}`];

  logger?.info(`show(${JSON.stringify(allArgs)})`);

  const git = simpleGit(cwd);
  const result = await git.show(allArgs);

  logger?.debug(`result: ${result}`);

  return result;
}

/**
 * @param {GitOptions} [options]
 * @returns {Promise<string>}
 */
export async function status(options = {}) {
  const { args = [], cwd, logger } = options;

  logger?.info(`status(${JSON.stringify(args)})`);

  const git = simpleGit(cwd);
  const result = await git.raw(["status", ...args]);

  logger?.debug(`result: ${result}`);

  return result;
}
