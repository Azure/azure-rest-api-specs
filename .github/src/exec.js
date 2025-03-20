// @ts-check

// Ignore code coverage since code is simple but hard to mock
/* v8 ignore start */

import child_process from "child_process";
import { promisify } from "util";
const exec = promisify(child_process.exec);

/**
 * @param {string} command
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 */
export async function execRoot(command, core) {
  core.info(`execRoot("${command}")`);

  // TODO: Handle errors
  const result = await exec(command, {
    cwd: process.env.GITHUB_WORKSPACE,
    // Default is 1024 * 1024, which is too small for some git commands returning many entities or large file content.
    // To support "git show", should be larger than the largest swagger file in the repo (2.5 MB as of 2/28/2025).
    maxBuffer: 16 * 1024 * 1024,
  });

  core.debug(`stdout: '${result.stdout}'`);
  core.debug(`stderr: '${result.stderr}'`);

  return result.stdout;
}
