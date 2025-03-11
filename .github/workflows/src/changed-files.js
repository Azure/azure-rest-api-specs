// @ts-check

import { execRoot } from "./exec.js";

/**
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} [baseCommitish] Defaults to "HEAD^".
 * @param {string} [headCommitish] Defaults to "HEAD".
 * @param {string} [diffFilter] Defaults to "".
 * @returns {Promise<string[]>}
 */
export async function getChangedFiles(
  core,
  baseCommitish = "HEAD^",
  headCommitish = "HEAD",
  diffFilter = "",
) {
  const diffFilterArg = diffFilter ? `--diff-filter=${diffFilter}` : "";

  const result = await execRoot(
    `git -c core.quotepath=off diff --name-only ${diffFilterArg} ${baseCommitish} ${headCommitish}`,
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

// Functions suitable for passing to string[].filter(), ordered roughly in order of increasing specificity

/**
 * @param {string} [file]
 * @returns {boolean}
 */
export function json(file) {
  return typeof file === "string" && file.endsWith(".json");
}

/**
 * @param {string} [file]
 * @returns {boolean}
 */
export function specification(file) {
  return typeof file === "string" && file.includes("/specification/");
}

/**
 * @param {string} [file]
 * @returns {boolean}
 */
export function dataPlane(file) {
  return (
    typeof file === "string" &&
    specification(file) &&
    file.includes("/data-plane/")
  );
}

/**
 * @param {string} [file]
 * @returns {boolean}
 */
export function resourceManager(file) {
  return (
    typeof file === "string" &&
    specification(file) &&
    file.includes("/resource-manager/")
  );
}

/**
 * @param {string} [file]
 * @returns {boolean}
 */
export function example(file) {
  return (
    typeof file === "string" &&
    specification(file) &&
    file.includes("/examples/")
  );
}

/**
 * @param {string} [file]
 * @returns {boolean}
 */
export function swagger(file) {
  return (
    typeof file === "string" &&
    (dataPlane(file) || resourceManager(file)) &&
    !example(file)
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
  const changedSwaggerFiles = await getChangedFiles(
    core,
    baseCommitish,
    headCommitish,
    diffFilter,
  );
  const changedResourceManagerSwaggerFiles = changedSwaggerFiles
    .filter(resourceManager)
    .filter(swagger);

  core.info(
    `Changed files containing path '/resource-manager/': ${changedResourceManagerSwaggerFiles}`,
  );
  return changedResourceManagerSwaggerFiles;
}
