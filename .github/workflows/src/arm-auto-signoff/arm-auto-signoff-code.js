import incrementalTypeSpec from "./arm-incremental-typespec.js";
import { isTrivialPullRequest } from "./pr-changes.js";
import checkTrivialChanges from "./trivial-changes-check.js";

/** @typedef {import("./pr-changes.js").PullRequestChanges} PullRequestChanges */

/**
 * @param {unknown} value
 * @returns {value is PullRequestChanges}
 */
function isPullRequestChanges(value) {
  if (typeof value !== "object" || value === null) {
    return false;
  }

  /** @type {Record<string, unknown>} */
  const obj = /** @type {Record<string, unknown>} */ (value);

  return (
    typeof obj.rmDocumentation === "boolean" &&
    typeof obj.rmExamples === "boolean" &&
    typeof obj.rmFunctional === "boolean" &&
    typeof obj.rmOther === "boolean" &&
    typeof obj.other === "boolean"
  );
}

/**
 * Main entry point for ARM Auto Signoff Code workflow.
 *
 * This module orchestrates all checks to determine if a PR qualifies for auto sign-off.
 * It combines results from:
 * - Incremental TypeSpec check
 * - Trivial changes check
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 * @returns {Promise<string>} Key-value format string consumed by downstream workflow logic.
 */
export default async function armAutoSignoffCode(args) {
  const { context, core } = args;

  core.info("Starting ARM Auto Signoff Code analysis.");

  // Run incremental TypeSpec check
  core.startGroup("Checking for incremental TypeSpec changes");
  const incrementalTypeSpecResult = await incrementalTypeSpec(args);
  core.info(`Incremental TypeSpec result: ${incrementalTypeSpecResult}`);
  core.endGroup();

  // Run trivial changes check
  core.startGroup("Checking for trivial changes");
  const trivialChangesResultString = await checkTrivialChanges({ core, context });
  /** @type {unknown} */ const parsedTrivialChanges =  (JSON.parse(trivialChangesResultString));
  if (!isPullRequestChanges(parsedTrivialChanges)) {
    throw new Error("Unexpected trivial changes result shape");
  }
  const trivialChanges = parsedTrivialChanges;
  core.info(`Trivial changes result: ${JSON.stringify(trivialChanges)}`);
  core.endGroup();

  // Determine if PR qualifies for auto sign-off
  const isTrivial = isTrivialPullRequest(trivialChanges);
  const qualifiesForAutoSignoff = incrementalTypeSpecResult || isTrivial;

  // Combine results
  const combined = {
    incrementalTypeSpec: incrementalTypeSpecResult,
    trivialChanges: trivialChanges,
    qualifiesForAutoSignoff: qualifiesForAutoSignoff,
  };

  core.info(`Combined result: ${JSON.stringify(combined, null, 2)}`);

  // Return key-value format: incrementalTypeSpec-true,isTrivial-false,qualifies-true
  return `incrementalTypeSpec-${incrementalTypeSpecResult},isTrivial-${isTrivial},qualifies-${qualifiesForAutoSignoff}`;
}
