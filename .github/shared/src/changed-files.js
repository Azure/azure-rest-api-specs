// @ts-check

import debug from "debug";
import { simpleGit } from "simple-git";
import { relativeCwd, resolveCwd } from "./path.js";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

/**
 * @param {Object} [options]
 * @param {string} [options.baseCommitish] Default: "HEAD^".
 * @param {string} [options.cwd] Current working directory.  Default: process.cwd().
 * @param {string} [options.headCommitish] Default: "HEAD".
 * @param {import('./logger.js').ILogger} [options.logger]
 * @returns {Promise<string[]>} List of changed files as platform-specific absolute paths. Example: ["/home/users/specs/specification/foo/Microsoft.Foo/main.tsp"].
 */
export async function getChangedFiles(options = {}) {
  const { baseCommitish = "HEAD^", cwd, headCommitish = "HEAD", logger } = options;

  // TODO: If we need to filter based on status, instead of passing an argument to `--diff-filter,
  // consider using "--name-status" instead of "--name-only", and return an array of objects like
  // { name: "/foo/baz.js", status: Status.Renamed, previousName: "/foo/bar.js"}.
  // Then add filter functions to filter based on status.  This is more flexible and lets consumers
  // filter based on status with a single call to `git diff`.
  const result = await simpleGit(cwd).diff(["--name-only", baseCommitish, headCommitish]);

  const files = result
    .trim()
    .split("\n")
    .map((f) => resolveCwd(f, { cwd }));

  logger?.info("Changed Files:");
  for (const file of files) {
    logger?.info(`  ${file}`);
  }
  logger?.info("");

  return files;
}

/**
 * @param {Object} [options]
 * @param {string} [options.baseCommitish] Default: "HEAD^".
 * @param {string} [options.cwd] Current working directory.  Default: process.cwd().
 * @param {string} [options.headCommitish] Default: "HEAD".
 * @param {import('./logger.js').ILogger} [options.logger]
 * @returns {Promise<{additions: string[], modifications: string[], deletions: string[], renames: {from: string, to: string}[], total: number}>}
 */
export async function getChangedFilesStatuses(options = {}) {
  const { baseCommitish = "HEAD^", cwd, headCommitish = "HEAD", logger } = options;
  const result = await simpleGit(cwd).diff(["--name-status", baseCommitish, headCommitish]);

  const categorizedFiles = {
    additions: /** @type {string[]} */ ([]),
    modifications: /** @type {string[]} */ ([]),
    deletions: /** @type {string[]} */ ([]),
    renames: /** @type {{from: string, to: string}[]} */ ([]),
    total: 0,
  };

  if (result.trim()) {
    const lines = result.trim().split("\n");

    for (const line of lines) {
      const parts = line.split("\t");
      const status = parts[0];

      switch (status[0]) {
        case "A":
          categorizedFiles.additions.push(resolveCwd(parts[1], { cwd }));
          break;
        case "M":
          categorizedFiles.modifications.push(resolveCwd(parts[1], { cwd }));
          break;
        case "D":
          categorizedFiles.deletions.push(resolveCwd(parts[1], { cwd }));
          break;
        case "R":
          categorizedFiles.renames.push({
            from: resolveCwd(parts[1], { cwd }),
            to: resolveCwd(parts[2], { cwd }),
          });
          break;
        case "C":
          categorizedFiles.additions.push(resolveCwd(parts[2], { cwd }));
          break;
        default:
          categorizedFiles.modifications.push(resolveCwd(parts[1], { cwd }));
      }
    }

    categorizedFiles.total =
      categorizedFiles.additions.length +
      categorizedFiles.modifications.length +
      categorizedFiles.deletions.length +
      categorizedFiles.renames.length;
  }

  // Log all changed files by categories
  if (logger) {
    logger.info("Categorized Changed Files:");

    if (categorizedFiles.additions.length > 0) {
      logger.info(`  Additions (${categorizedFiles.additions.length}):`);
      for (const file of categorizedFiles.additions) {
        logger.info(`    + ${file}`);
      }
    }

    if (categorizedFiles.modifications.length > 0) {
      logger.info(`  Modifications (${categorizedFiles.modifications.length}):`);
      for (const file of categorizedFiles.modifications) {
        logger.info(`    M ${file}`);
      }
    }

    if (categorizedFiles.deletions.length > 0) {
      logger.info(`  Deletions (${categorizedFiles.deletions.length}):`);
      for (const file of categorizedFiles.deletions) {
        logger.info(`    - ${file}`);
      }
    }

    if (categorizedFiles.renames.length > 0) {
      logger.info(`  Renames (${categorizedFiles.renames.length}):`);
      for (const rename of categorizedFiles.renames) {
        logger.info(`    R ${rename.from} -> ${rename.to}`);
      }
    }

    logger.info(`  Total: ${categorizedFiles.total} files`);
    logger.info("");
  }

  return categorizedFiles;
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

// Following need repoRoot parameter

/**
 * @param {string} [file]
 * @param {Object} [options]
 * @param {string} [options.repoRoot] Root directory of repository.  Default: process.cwd().
 * @returns {boolean}
 */
export function specification(file, options = {}) {
  // Folder name "specification" should match case, since it already exists in repo
  return (
    typeof file === "string" &&
    relativeCwd(file, { cwd: options.repoRoot }).startsWith("specification/")
  );
}

/**
 * @param {string} [file]
 * @param {Object} [options]
 * @param {string} [options.repoRoot] Root directory of repository.  Default: process.cwd().
 * @returns {boolean}
 */
export function dataPlane(file, options = {}) {
  // Folder name "data-plane" should match case for consistency across specs
  return typeof file === "string" && specification(file, options) && file.includes("/data-plane/");
}

/**
 * @param {string} [file]
 * @param {Object} [options]
 * @param {string} [options.repoRoot] Root directory of repository.  Default: process.cwd().
 * @returns {boolean}
 */
export function resourceManager(file, options = {}) {
  // Folder name "resource-manager" should match case for consistency across specs
  return (
    typeof file === "string" && specification(file, options) && file.includes("/resource-manager/")
  );
}

/**
 * @param {string} [file]
 * @param {Object} [options]
 * @param {string} [options.repoRoot] Root directory of repository.  Default: process.cwd().
 * @returns {boolean}
 */
export function example(file, options = {}) {
  // Folder name "examples" should match case for consistency across specs
  return (
    typeof file === "string" &&
    json(file) &&
    specification(file, options) &&
    file.includes("/examples/")
  );
}

/**
 * @param {string} [file]
 * @param {Object} [options]
 * @param {string} [options.repoRoot] Root directory of repository.  Default: process.cwd().
 * @returns {boolean}
 */
export function swagger(file, options = {}) {
  return (
    typeof file === "string" &&
    json(file) &&
    (dataPlane(file, options) || resourceManager(file, options)) &&
    !example(file, options) &&
    !scenario(file, options)
  );
}

/**
 * @param {string} [file]
 * @param {Object} [options]
 * @param {string} [options.repoRoot] Root directory of repository.  Default: process.cwd().
 * @returns {boolean}
 */
export function scenario(file, options = {}) {
  return (
    typeof file === "string" &&
    json(file) &&
    specification(file, options) &&
    file.includes("/scenarios/")
  );
}
