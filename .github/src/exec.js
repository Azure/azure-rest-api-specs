// @ts-check

import child_process from "child_process";
import { promisify } from "util";
const exec = promisify(child_process.exec);

/**
 * @param {string} command
 * @param {Object} [options]
 * @param {import('./types.js').ILogger} [options.logger]
 * @param {number} [options.maxBuffer]
 */
export async function execRoot(command, options = {}) {
  // Node default is 1024 * 1024, which is too small for some git commands returning many entities or large file content.
  // To support "git show", should be larger than the largest swagger file in the repo (2.5 MB as of 2/28/2025).
  const defaultMaxBuffer = 16 * 1024 * 1024;

  const { logger, maxBuffer = defaultMaxBuffer } = options;

  logger?.info(`execRoot("${command}")`);

  // TODO: Handle errors
  const result = await exec(command, {
    cwd: process.env.GITHUB_WORKSPACE,
    maxBuffer,
  });

  logger?.debug(`stdout: '${result.stdout}'`);
  logger?.debug(`stderr: '${result.stderr}'`);

  return result.stdout;
}

/**
 * Joins a list of arguments to build a command-line without extra spaces.
 * Ignores null, undefined, and elements that convert to empty or all-whitespace.
 *
 * @param {any[]} args
 * @returns string
 */
export function buildCmd(...args) {
  return (
    args
      // Exclude null and undefined
      .filter((arg) => arg !== null && arg !== undefined)
      // Convert to string
      .map((arg) => String(arg))
      // Exclude empty and all-whitespace
      .filter((str) => str.trim() !== "")
      .join(" ")
  );
}
