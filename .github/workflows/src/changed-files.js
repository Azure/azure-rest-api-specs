// @ts-check

import { execRoot } from "./exec.js";

/**
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} [baseCommitish] Defaults to "HEAD^".
 * @param {string} [headCommitish] Defaults to "HEAD".
 * @param {string} [diffFilter] Defaults to "d".
 * @returns {Promise<string[]>}
 */
export async function getChangedFiles(
  core,
  baseCommitish = "HEAD^",
  headCommitish = "HEAD",
  diffFilter = "d",
) {
  return await getChangedFilesImpl(
    `Get-ChangedFiles ${baseCommitish} ${headCommitish} ${diffFilter}"`,
    core,
  );
}

/**
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} [baseCommitish] Defaults to "HEAD^".
 * @param {string} [headCommitish] Defaults to "HEAD".
 * @param {string} [diffFilter] Defaults to "d".
 * @returns {Promise<string[]>}
 */
export async function getChangedSwaggerFiles(
  core,
  baseCommitish = "HEAD^",
  headCommitish = "HEAD",
  diffFilter = "d",
) {
  return await getChangedFilesImpl(
    `Get-ChangedSwaggerFiles(Get-ChangedFiles ${baseCommitish} ${headCommitish} ${diffFilter})`,
    core,
  );
}

/**
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} [baseCommitish] Defaults to "HEAD^".
 * @param {string} [headCommitish] Defaults to "HEAD".
 * @param {string} [diffFilter] Defaults to "d".
 * @returns {Promise<string[]>}
 */
export async function getChangedResourceManagerSwaggerFiles(
  core,
  baseCommitish = "HEAD^",
  headCommitish = "HEAD",
  diffFilter = "d",
) {
  const changedSwaggerFiles = await getChangedSwaggerFiles(
    core,
    "HEAD^",
    "HEAD",
    "",
  );
  const changedResourceManagerSwaggerFiles = changedSwaggerFiles.filter(
    (f) => f.includes("/resource-manager/") && !f.includes("/examples/"),
  );
  core.info(
    `Changed files containing path '/resource-manager/': ${changedResourceManagerSwaggerFiles}`,
  );
  return changedResourceManagerSwaggerFiles;
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
  for (const file of files) {
    core.info(`  ${file}`);
  }
  core.info("");

  return files;
}
