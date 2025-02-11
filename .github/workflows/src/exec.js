// @ts-check

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
  });

  core.debug(`stdout: '${result.stdout}'`);
  core.debug(`stderr: '${result.stderr}'`);

  return result.stdout;
}
