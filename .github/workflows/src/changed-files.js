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
  const result = await execRoot(
    `git -c core.quotepath=off diff --name-only --diff-filter=${diffFilter} ${baseCommitish} ${headCommitish}`,
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
  return (
    await getChangedFiles(core, baseCommitish, headCommitish, diffFilter)
  ).filter((f) => f.endsWith(".json"));
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
    baseCommitish,
    headCommitish,
    diffFilter,
  );
  const changedResourceManagerSwaggerFiles = changedSwaggerFiles.filter(
    (f) => f.includes("/resource-manager/") && !f.includes("/examples/"),
  );
  core.info(
    `Changed files containing path '/resource-manager/': ${changedResourceManagerSwaggerFiles}`,
  );
  return changedResourceManagerSwaggerFiles;
}
