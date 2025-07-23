// @ts-check

import debug from "debug";
import { simpleGit } from "simple-git";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

/**
 * @param {Object} [options]
 * @param {string} [options.baseCommitish] Default: "HEAD^".
 * @param {string} [options.cwd] Current working directory.  Default: process.cwd().
 * @param {string} [options.headCommitish] Default: "HEAD".
 * @param {import('./logger.js').ILogger} [options.logger]
 * @returns {Promise<string[]>} List of changed files, using posix paths, relative to options.cwd. Example: ["specification/foo/Microsoft.Foo/main.tsp"].
 */
export async function getChangedFiles(options = {}) {
  const { baseCommitish = "HEAD^", cwd, headCommitish = "HEAD", logger } = options;

  // TODO: If we need to filter based on status, instead of passing an argument to `--diff-filter,
  // consider using "--name-status" instead of "--name-only", and return an array of objects like
  // { name: "/foo/baz.js", status: Status.Renamed, previousName: "/foo/bar.js"}.
  // Then add filter functions to filter based on status.  This is more flexible and lets consumers
  // filter based on status with a single call to `git diff`.
  const result = await simpleGit(cwd).diff(["--name-only", baseCommitish, headCommitish]);

  const files = result.trim().split("\n");

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
          categorizedFiles.additions.push(parts[1]);
          break;
        case "M":
          categorizedFiles.modifications.push(parts[1]);
          break;
        case "D":
          categorizedFiles.deletions.push(parts[1]);
          break;
        case "R":
          categorizedFiles.renames.push({
            from: parts[1],
            to: parts[2],
          });
          break;
        case "C":
          categorizedFiles.additions.push(parts[2]);
          break;
        default:
          categorizedFiles.modifications.push(parts[1]);
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
  return typeof file === "string" && specification(file) && file.includes("/data-plane/");
}

/**
 * @param {string} [file]
 * @returns {boolean}
 */
export function resourceManager(file) {
  // Folder name "resource-manager" should match case for consistency across specs
  return typeof file === "string" && specification(file) && file.includes("/resource-manager/");
}

/**
 * @param {string} [file]
 * @returns {boolean}
 */
export function example(file) {
  // Folder name "examples" should match case for consistency across specs
  return (
    typeof file === "string" && json(file) && specification(file) && file.includes("/examples/")
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
    !example(file) &&
    !scenario(file)
  );
}

/**
 * @param {string} [file]
 * @returns {boolean}
 */
export function scenario(file) {
  return (
    typeof file === "string" && json(file) && specification(file) && file.includes("/scenarios/")
  );
}
