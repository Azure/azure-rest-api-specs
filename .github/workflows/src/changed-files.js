// @ts-check

import { execRoot } from "./exec.js";

/**
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} [baseCommitish] Defaults to "HEAD^".
 * @param {string} [targetCommitish] Defaults to "HEAD".
 * @param {string} [diffFilter] Defaults to "d".
 * @returns {Promise<string[]>}
 */
export async function getChangedFiles(
  core,
  baseCommitish = "HEAD^",
  targetCommitish = "HEAD",
  diffFilter = "d",
) {
  return await getChangedFilesImpl(
    `Get-ChangedFiles ${baseCommitish} ${targetCommitish} ${diffFilter}"`,
    core,
  );
}

/**
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} [baseCommitish] Defaults to "HEAD^".
 * @param {string} [targetCommitish] Defaults to "HEAD".
 * @param {string} [diffFilter] Defaults to "d".
 * @returns {Promise<string[]>}
 */
export async function getChangedSwaggerFiles(
  core,
  baseCommitish = "HEAD^",
  targetCommitish = "HEAD",
  diffFilter = "d",
) {
  return await getChangedFilesImpl(
    `Get-ChangedSwaggerFiles(Get-ChangedFiles ${baseCommitish} ${targetCommitish} ${diffFilter}")`,
    core,
  );
}

/**
 * @param {string} command
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @returns {Promise<string[]>}
 */
async function getChangedFilesImpl(command, core) {
  const result = await execRoot(
    `pwsh -command ". ./eng/scripts/ChangedFiles-Functions.ps1; ${command}"`,
    core,
  );

  const files = result.trim().split("\n");

  core.info("Changed Files:");
  for (const file in files) {
    core.info(`  $file`);
  }
  core.info("");

  return files;
}
