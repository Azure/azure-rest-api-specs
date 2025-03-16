// @ts-check

import { diff } from "./git.js";

/**
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} [baseCommitish] Defaults to "HEAD^".
 * @param {string} [headCommitish] Defaults to "HEAD".
 * @returns {Promise<string[]>} List of changed files, relative to the repo root.  Example: ["specification/foo/Microsoft.Foo/main.tsp"]
 */
export async function getChangedFiles(
  core,
  baseCommitish = "HEAD^",
  headCommitish = "HEAD",
) {
  // TODO: If we need to filter based on status, instead of passing an argument to `--diff-filter,
  // consider using "--name-status" instead of "--name-only", and return an array of objects like
  // { name: "/foo/baz.js", status: Status.Renamed, previousName: "/foo/bar.js"}.
  // Then add filter functions to filter based on status.  This is more flexible and lets consumers
  // filter based on status with a single call to `git diff`.
  const result = await diff(baseCommitish, headCommitish, core, "--name-only");

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
  // Extension "json" with any case is a valid JSON file
  return typeof file === "string" && file.toLowerCase().endsWith(".json");
}

/**
 * @param {string} [file]
 * @returns {boolean}
 */
export function readme(file) {
  // Filename "readme.md" with any case is a valid README file
  return typeof file === "string" && file.toLowerCase().endsWith("readme.md");
}

/**
 * @param {string} [file]
 * @returns {boolean}
 */
export function specification(file) {
  // Folder name "specification" should match case, since it already exists in repo
  return typeof file === "string" && file.startsWith("specification/");
}

/**
 * @param {string} [file]
 * @returns {boolean}
 */
export function dataPlane(file) {
  // Folder name "data-plane" should match case for consistency across specs
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
  // Folder name "resource-manager" should match case for consistency across specs
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
  // Folder name "examples" should match case for consistency across specs
  return (
    typeof file === "string" &&
    json(file) &&
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
    json(file) &&
    (dataPlane(file) || resourceManager(file)) &&
    !example(file)
  );
}
