// @ts-check

import child_process from "child_process";
import { promisify } from "util";
const execFileImpl = promisify(child_process.execFile);

/**
 * @param {string} file
 * @param {string[]} args
 * @param {Object} [options]
 * @param {string} [options.cwd] Current working directory.  Default: process.cwd().
 * @param {import('./logger.js').ILogger} [options.logger]
 * @param {number} [options.maxBuffer]
 */
export async function execFile(file, args, options = {}) {
  const {
    cwd,
    logger,
    // Node default is 1024 * 1024, which is too small for some git commands returning many entities or large file content.
    // To support "git show", should be larger than the largest swagger file in the repo (2.5 MB as of 2/28/2025).
    maxBuffer = 16 * 1024 * 1024,
  } = options;

  logger?.info(`execFile("${file}", ${JSON.stringify(args)})`);

  // TODO: Handle errors
  // execFile(file, args) is more secure than exec(cmd), since the latter is vulnerable to shell injection
  const result = await execFileImpl(file, args, {
    cwd,
    maxBuffer,
  });

  logger?.debug(`stdout: '${result.stdout}'`);
  logger?.debug(`stderr: '${result.stderr}'`);

  return result.stdout;
}
