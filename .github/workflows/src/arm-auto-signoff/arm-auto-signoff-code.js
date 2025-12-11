import { isTrivialPullRequest } from "./pr-changes.js
import incrementalTypeSpec from './arm-incremental-typespec.js';
import checkTrivialChanges from './trivial-changes-check.js';

/**
 * Main entry point for ARM Auto Signoff Code workflow
 * 
 * This module orchestrates all checks to determine if a PR qualifies for auto sign-off.
 * It combines results from:
 * - Incremental TypeSpec check
 * - Trivial changes check
 * 
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<string>} JSON string containing combined results
 */
export default async function armAutoSignoffCode({ github, context, core }) {

  core.info('Starting ARM Auto Signoff Code analysis.');

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
  const qualifiesForAutoSignoff = incrementalTypeSpecResult || isTrivial;

  // Combine results
  const combined = {
    incrementalTypeSpec: incrementalTypeSpecResult,
    trivialChanges: trivialChanges,
    qualifiesForAutoSignoff: qualifiesForAutoSignoff
  };

  core.info(`Combined result: ${JSON.stringify(combined, null, 2)}`);
  core.info(`Qualifies for auto sign-off: ${combined.qualifiesForAutoSignoff}`);

  // Return key-value format: incrementalTypeSpec-true,isTrivial-false,qualifies-true
  return `incrementalTypeSpec-${incrementalTypeSpecResult},isTrivial-${isTrivial},qualifies-${qualifiesForAutoSignoff}`;
}
