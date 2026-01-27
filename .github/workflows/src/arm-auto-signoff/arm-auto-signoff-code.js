import { incrementalTypeSpec } from "./arm-incremental-typespec.js";
import { checkTrivialChanges } from "./trivial-changes-check.js";

/** @typedef {import("./pr-changes.js").PullRequestChanges} PullRequestChanges */

/**
 * Main entry point for ARM Auto Signoff Code workflow.
 *
 * This module orchestrates all checks to determine if a PR qualifies for auto sign-off.
 * It combines results from:
 * - Incremental TypeSpec check
 * - Trivial changes check
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 * @returns {Promise<{ incremental: boolean, trivial: boolean }>}
 */
export default async function armAutoSignoffCode({ core }) {
  core.info("Starting ARM Auto Signoff Code analysis.");

  // Run incremental TypeSpec check
  core.startGroup("Checking for incremental TypeSpec changes");
  const incrementalTypeSpecResult = await incrementalTypeSpec(core);
  core.info(`Incremental TypeSpec result: ${incrementalTypeSpecResult}`);
  core.endGroup();

  // Run trivial changes check
  core.startGroup("Checking for trivial changes");
  const trivialChangesResult = await checkTrivialChanges(core);
  core.endGroup();

  const isTrivial = trivialChangesResult.isTrivial();

  // Combine results
  const combined = {
    incrementalTypeSpec: incrementalTypeSpecResult,
    trivialChanges: trivialChangesResult,
  };

  core.info(`Combined result: ${JSON.stringify(combined, null, 2)}`);

  // Return a JSON object for downstream workflow logic.
  return {
    incremental: incrementalTypeSpecResult,
    trivial: isTrivial,
  };
}
