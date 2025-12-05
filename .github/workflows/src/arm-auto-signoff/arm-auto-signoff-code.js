import { isTrivialPullRequest } from "../../../shared/src/pr-changes.js";

/**
 * Main entry point for ARM Auto-SignOff Code workflow
 * 
 * This module orchestrates all checks to determine if a PR qualifies for auto sign-off.
 * It combines results from:
 * - Incremental TypeSpec check
 * - Trivial changes check
 * 
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<string>} JSON string containing combined results
 */
export default async function armAutoSignOffCode({ github, context, core }) {
  const { default: incrementalTypeSpec } = await import('./incremental-typespec.js');
  const { default: checkTrivialChanges } = await import('./trivial-changes-check.js');

  core.info('Starting ARM Auto-SignOff Code analysis...');

  // Run incremental TypeSpec check
  core.startGroup('Checking for incremental TypeSpec changes');
  const incrementalTypeSpecResult = await incrementalTypeSpec({ github, context, core });
  core.info(`Incremental TypeSpec result: ${incrementalTypeSpecResult}`);
  core.endGroup();

  // Run trivial changes check
  core.startGroup('Checking for trivial changes');
  const trivialChangesResultString = await checkTrivialChanges({ github, context, core });
  const trivialChanges = JSON.parse(trivialChangesResultString);
  core.info(`Trivial changes result: ${JSON.stringify(trivialChanges)}`);
  core.endGroup();

  // Determine if PR qualifies for auto sign-off
  const isTrivial = isTrivialPullRequest(trivialChanges);
  const qualifiesForAutoSignOff = incrementalTypeSpecResult || isTrivial;

  // Combine results
  const combined = {
    incrementalTypeSpec: incrementalTypeSpecResult,
    trivialChanges: trivialChanges,
    qualifiesForAutoSignOff: qualifiesForAutoSignOff
  };

  core.info(`Combined result: ${JSON.stringify(combined, null, 2)}`);
  core.info(`Qualifies for auto sign-off: ${combined.qualifiesForAutoSignOff}`);

  // Return key-value format: incrementalTypeSpec-true,isTrivial-false,qualifies-true
  return `incrementalTypeSpec-${incrementalTypeSpecResult},isTrivial-${isTrivial},qualifies-${qualifiesForAutoSignOff}`;
}
