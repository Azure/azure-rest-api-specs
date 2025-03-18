// @ts-check

// Ignore code coverage since code is simple but hard to mock
/* v8 ignore start */

import { execRoot } from "./exec.js";
import { ILogger } from "./logger.js";

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

  return await execGit(`diff ${args} ${baseCommitish} ${headCommitish}`, {
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

  return await execGit(`ls-tree ${args} ${treeIsh} ${path}`, {
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

  return await execGit(`show ${args} ${treeIsh}:${path}`, { logger: logger });
}

/**
 * @param {string} args
 * @param {{logger?: ILogger}} options
 * @returns {Promise<string>}
 */
async function execGit(args, options) {
  // Ensure that git displays filenames as they are (without escaping)
  const defaultConfig = "-c core.quotepath=off";

  return await execRoot(`git ${defaultConfig} ${args}`, options);
}
