// For now, treat all paths as posix, since this is the format returned from git commands
import debug from "debug";
import { simpleGit } from "simple-git";
import { inspect } from "util";
import {
  example,
  getChangedFilesStatuses,
  markdown,
  resourceManager,
  swagger,
} from "../../../shared/src/changed-files.js";
import { CoreLogger } from "../core-logger.js";
import { PullRequestChanges } from "./pr-changes.js";

/** @typedef {import("./pr-changes.js").PullRequestChanges} PullRequestChangesType */

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

/**
 * Non-functional JSON property keys that are safe to change without affecting API behavior
 */
const NON_FUNCTIONAL_PROPERTIES = new Set([
  "description",
  "title",
  "summary",
  "x-ms-summary",
  "x-ms-description",
  "externalDocs",
  "x-ms-examples",
  "x-example",
  "example",
  "examples",
  "x-ms-client-name",
  "tags",
]);

/**
 * Analyzes a PR to determine what types of changes it contains
 * @param {import('@actions/github-script').AsyncFunctionArguments['core']} core
 * @returns {Promise<PullRequestChangesType>} Object with categorized change types
 */
export async function checkTrivialChanges(core) {
  // Create result object once at the top
  const changes = new PullRequestChanges();

  // Compare the pull request merge commit (HEAD) against its first parent (HEAD^).
  const options = {
    cwd: process.env.GITHUB_WORKSPACE,
    logger: new CoreLogger(core),
  };

  const changedFilesStatuses = await getChangedFilesStatuses(options);
  const changedFiles = getFlattenedChangedFilesFromStatuses(changedFilesStatuses);
  const git = simpleGit(options.cwd);

  // Filter to only resource-manager files for ARM auto-signoff
  const changedRmFiles = changedFiles.filter(resourceManager);
  const changedRmFilesStatuses = {
    additions: changedFilesStatuses.additions.filter(resourceManager),
    modifications: changedFilesStatuses.modifications.filter(resourceManager),
    deletions: changedFilesStatuses.deletions.filter(resourceManager),
    renames: changedFilesStatuses.renames.filter(
      (r) => resourceManager(r.to) || resourceManager(r.from),
    ),
  };

  // Check if PR contains non-resource-manager changes
  const hasNonRmChanges = changedFiles.some((file) => !resourceManager(file));
  if (hasNonRmChanges) {
    const nonRmFiles = changedFiles.filter((file) => !resourceManager(file));
    core.info(
      `PR contains ${nonRmFiles.length} non-resource-manager changes - not eligible for ARM auto-signoff. Also, no further validation to resource manager files is performed.`,
    );
    core.info(
      `Non-RM files: ${nonRmFiles.slice(0, 5).join(", ")}${nonRmFiles.length > 5 ? ` ... and ${nonRmFiles.length - 5} more` : ""}`,
    );
    // This workflow reports resource-manager scoped change categories.
    // Mark as non-trivial/blocked because the PR touches files outside resource-manager.
    changes.other = true;
    core.info(`PR Changes: ${JSON.stringify(changes)}`);
    core.info(`Is trivial: ${changes.isTrivial()}`);
    return changes;
  }

  // Early exit if no resource-manager changes
  if (changedRmFiles.length === 0) {
    core.info("No resource-manager changes detected in PR");
    core.info(`PR Changes: ${JSON.stringify(changes)}`);
    core.info(`Is trivial: ${changes.isTrivial()}`);
    return changes;
  }

  // Check for significant file operations (additions, deletions, renames)
  const hasSignificantFileOperationsInPr = hasSignificantFileOperations(
    changedRmFilesStatuses,
    core,
  );

  if (hasSignificantFileOperationsInPr) {
    core.info("Significant file operations detected (new spec files, deletions, or renames)");
    // These are functional changes by policy
    changes.rmFunctional = true;
    core.info(`PR Changes: ${JSON.stringify(changes)}`);
    core.info(`Is trivial: ${changes.isTrivial()}`);
    return changes;
  }

  // Analyze what types of changes are present and update the changes object
  await analyzeAndUpdatePullRequestChanges(changedRmFiles, git, core, changes);

  core.info(`PR Changes: ${JSON.stringify(changes)}`);
  core.info(`Is trivial: ${changes.isTrivial()}`);

  return changes;
}

/**
 * Checks for significant file operations: additions/deletions of spec files, or any renames
 * @param {{additions: string[], modifications: string[], deletions: string[], renames: {from: string, to: string}[]}} changedFilesStatuses - File status information
 * @param {import('@actions/github-script').AsyncFunctionArguments['core']} core - Core logger
 * @returns {boolean} - True if significant operations detected
 */
function hasSignificantFileOperations(changedFilesStatuses, core) {
  // New spec files (non-example JSON) are non-trivial
  const newSpecFiles = changedFilesStatuses.additions.filter(swagger);
  if (newSpecFiles.length > 0) {
    core.info(`Significant: New spec files detected: ${newSpecFiles.join(", ")}`);
    return true;
  }

  // Deleted spec files (non-example JSON) are non-trivial
  const deletedSpecFiles = changedFilesStatuses.deletions.filter(swagger);
  if (deletedSpecFiles.length > 0) {
    core.info(`Significant: Deleted spec files detected: ${deletedSpecFiles.join(", ")}`);
    return true;
  }

  // Any file renames/moves are non-trivial (conservative approach)
  if (changedFilesStatuses.renames.length > 0) {
    core.info(
      `Significant: File renames detected: ${changedFilesStatuses.renames.map((r) => `${r.from} → ${r.to}`).join(", ")}`,
    );
    return true;
  }

  // Deletions of docs/examples are OK, but already filtered above
  return false;
}

/**
 * Analyzes a PR to determine what types of changes it contains and updates the changes object
 * @param {string[]} changedFiles - Array of changed file paths
 * @param {import('simple-git').SimpleGit} git - Git instance
 * @param {import('@actions/github-script').AsyncFunctionArguments['core']} core - Core logger
 * @param {PullRequestChangesType} changes - Changes object to update
 * @returns {Promise<void>}
 */
async function analyzeAndUpdatePullRequestChanges(changedFiles, git, core, changes) {
  // Categorize files by type
  const documentationFiles = changedFiles.filter(markdown);
  const exampleFiles = changedFiles.filter(example);
  const specFiles = changedFiles.filter(swagger);
  const otherFiles = changedFiles.filter(
    (file) => !markdown(file) && !example(file) && !swagger(file),
  );

  core.info(
    `File breakdown: ${documentationFiles.length} docs, ${exampleFiles.length} examples, ${specFiles.length} specs, ${otherFiles.length} other`,
  );

  // Set flags for file types present
  if (documentationFiles.length > 0) {
    changes.rmDocumentation = true;
  }

  if (exampleFiles.length > 0) {
    changes.rmExamples = true;
  }

  if (otherFiles.length > 0) {
    changes.rmOther = true;
  }

  // Analyze spec files to determine if functional or non-functional
  if (specFiles.length > 0) {
    core.info(`Analyzing ${specFiles.length} spec files...`);

    for (const file of specFiles) {
      core.info(`Analyzing file: ${file}`);

      try {
        const hasFunctionalChanges = await hasFunctionalChangesInSpecFile(file, git, core);

        if (hasFunctionalChanges) {
          changes.rmFunctional = true;
          core.info(`File ${file} contains functional changes`);
          return;
        }

        core.info(`File ${file} contains only non-functional changes`);
      } catch (error) {
        core.warning(`Failed to analyze ${file}: ${inspect(error)}`);
        // On error, treat as functional to be conservative
        changes.rmFunctional = true;
        return;
      }
    }
  }
}

/**
 * Analyzes changes in a spec file to determine if they are functional.
 * Note: New files and deletions should already be filtered by hasSignificantFileOperations.
 * @param {string} file
 * @param {import('simple-git').SimpleGit} git - Git instance
 * @param {import('@actions/github-script').AsyncFunctionArguments['core']} core - Core logger
 * @returns {Promise<boolean>} True if changes are functional, false if only non-functional changes are detected
 */
async function hasFunctionalChangesInSpecFile(file, git, core) {
  let baseContent, headContent;

  try {
    // Get file content from base commit (merge commit parent)
    baseContent = await git.show([`HEAD^:${file}`]);
  } catch (e) {
    if (e instanceof Error && e.message.includes("does not exist")) {
      // New file - should have been caught earlier, but treat as functional to be safe
      core.info(`File ${file} is new - treating as functional`);
      return true;
    }
    throw e;
  }

  try {
    headContent = await git.show([`HEAD:${file}`]);
  } catch (e) {
    if (e instanceof Error && e.message.includes("does not exist")) {
      // File deleted - should have been caught earlier, but treat as functional to be safe
      core.info(`File ${file} was deleted - treating as functional`);
      return true;
    }
    throw e;
  }

  /** @type {unknown} */
  let baseJson;

  /** @type {unknown} */
  let headJson;

  try {
    baseJson = /** @type {unknown} */ (JSON.parse(baseContent));
    headJson = /** @type {unknown} */ (JSON.parse(headContent));
  } catch (error) {
    core.warning(`Failed to parse JSON for ${file}: ${inspect(error)}`);
    // Be conservative: if we can't parse, assume functional changes.
    return true;
  }

  return hasFunctionalDifferences(baseJson, headJson, "", core);
}

/**
 * Creates a flat, de-duplicated list of changed files from the status results.
 * Includes both rename endpoints (`from` and `to`) to ensure path-based filters work as expected.
 * @param {{additions: string[], modifications: string[], deletions: string[], renames: {from: string, to: string}[]}} statuses
 * @returns {string[]}
 */
function getFlattenedChangedFilesFromStatuses(statuses) {
  /** @type {Set<string>} */
  const seen = new Set();

  /** @param {string} file */
  const add = (file) => {
    if (typeof file !== "string" || file.length === 0) return;
    seen.add(file);
  };

  for (const file of statuses.additions) add(file);
  for (const file of statuses.modifications) add(file);
  for (const file of statuses.deletions) add(file);
  for (const rename of statuses.renames) {
    add(rename.from);
    add(rename.to);
  }

  return Array.from(seen);
}

/**
 * Recursively analyzes differences between two JSON objects
 * @param {unknown} baseObj - Base object
 * @param {unknown} headObj - Head object
 * @param {string} path - Current path in the object
 * * @param {import('@actions/github-script').AsyncFunctionArguments['core']} core - Core logger
 * @returns {boolean} - True if any functional differences are detected
 */
function hasFunctionalDifferences(baseObj, headObj, path, core) {
  // If types differ, it's a functional change
  if (typeof baseObj !== typeof headObj) {
    core.info(`Type change at ${path || "root"}: ${typeof baseObj} -> ${typeof headObj}`);
    return true;
  }

  // Handle null values
  if (baseObj === null || headObj === null) {
    if (baseObj !== headObj) {
      core.info(`Null value change at ${path || "root"}`);
      return true;
    }
    return false;
  }

  // Handle arrays
  if (Array.isArray(baseObj) && Array.isArray(headObj)) {
    // For arrays, we need to be careful about order and additions/removals
    if (baseObj.length !== headObj.length) {
      // Check if the change is just adding/removing non-functional properties
      const arrayPath = path || "root";
      // For now, treat any array length change as functional unless we can prove otherwise
      core.info(`Array length change at ${arrayPath}: ${baseObj.length} -> ${headObj.length}`);

      // Special case: if arrays contain only strings and changes are in non-functional properties like tags
      return isFunctionalPath(path);
    }

    // Check each element
    for (let i = 0; i < baseObj.length; i++) {
      if (hasFunctionalDifferences(baseObj[i], headObj[i], `${path}[${i}]`, core)) {
        return true;
      }
    }
    return false;
  }

  // Handle objects
  if (
    typeof baseObj === "object" &&
    baseObj !== null &&
    !Array.isArray(baseObj) &&
    typeof headObj === "object" &&
    headObj !== null &&
    !Array.isArray(headObj)
  ) {
    /** @type {Record<string, unknown>} */
    const baseRecord = /** @type {Record<string, unknown>} */ (baseObj);

    /** @type {Record<string, unknown>} */
    const headRecord = /** @type {Record<string, unknown>} */ (headObj);

    const baseKeys = new Set(Object.keys(baseRecord));
    const headKeys = new Set(Object.keys(headRecord));

    // Check for added or removed keys
    for (const key of baseKeys) {
      if (!headKeys.has(key)) {
        const fullPath = path ? `${path}.${key}` : key;
        if (isFunctionalPath(fullPath)) {
          core.info(`Property removed at ${fullPath} (functional)`);
          return true;
        }
        core.info(`Property removed at ${fullPath} (non-functional)`);
      }
    }

    for (const key of headKeys) {
      if (!baseKeys.has(key)) {
        const fullPath = path ? `${path}.${key}` : key;
        if (isFunctionalPath(fullPath)) {
          core.info(`Property added at ${fullPath} (functional)`);
          return true;
        }
        core.info(`Property added at ${fullPath} (non-functional)`);
      }
    }

    // Check changed properties
    for (const key of baseKeys) {
      if (headKeys.has(key)) {
        const fullPath = path ? `${path}.${key}` : key;
        const childHasFunctionalDifferences = hasFunctionalDifferences(
          baseRecord[key],
          headRecord[key],
          fullPath,
          core,
        );

        if (childHasFunctionalDifferences) {
          // If the change is under a non-functional path, treat as non-functional.
          if (isFunctionalPath(fullPath)) {
            return true;
          }
          core.info(`Property changed at ${fullPath} (non-functional)`);
          continue;
        }
      }
    }

    return false;
  }

  // Handle primitive values
  if (baseObj !== headObj) {
    if (isFunctionalPath(path)) {
      core.info(
        `Value changed at ${path || "root"} (functional): ${inspect(baseObj)} -> ${inspect(headObj)}`,
      );
      return true;
    }
    core.info(
      `Value changed at ${path || "root"} (non-functional): ${inspect(baseObj)} -> ${inspect(headObj)}`,
    );
    return false;
  }
  return false;
}

/**
 * Returns true if the current path is under a functional property.
 * Handles array indices (e.g. `tags[0]` -> `tags`).
 * @param {string} path
 * @returns {boolean}
 */
function isFunctionalPath(path) {
  if (typeof path !== "string" || path.length === 0) return true;

  for (const segment of path.split(".")) {
    if (segment.length === 0) continue;
    const key = segment.split("[")[0];
    if (NON_FUNCTIONAL_PROPERTIES.has(key)) return false;
  }

  return true;
}
