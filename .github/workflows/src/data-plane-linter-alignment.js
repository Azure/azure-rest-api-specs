// @ts-check

import { readFile } from "fs/promises";
import { join } from "path";

/**
 * Path (relative to the repo root) of the data-plane linter interlock file whose
 * header pins the `@azure-tools/typespec-azure-core` version the
 * Data-Plane API Reviewer agent was verified against.
 */
export const COVERAGE_FILE =
  ".github/skills/azure-api-review/references/data-plane-linter-rule-coverage.md";

/** Package whose pinned version the coverage map must stay aligned with. */
export const PACKAGE_NAME = "@azure-tools/typespec-azure-core";

/**
 * Extracts the version of {@link PACKAGE_NAME} pinned in the repo root
 * `package.json` (either dependency section).
 *
 * @param {string} packageJsonContent
 * @returns {string} the pinned version, with any range prefix stripped
 */
export function getPinnedVersion(packageJsonContent) {
  const pkg = JSON.parse(packageJsonContent);
  const spec = pkg.devDependencies?.[PACKAGE_NAME] ?? pkg.dependencies?.[PACKAGE_NAME];

  if (!spec) {
    throw new Error(`${PACKAGE_NAME} is not a dependency of the root package.json`);
  }

  return String(spec).replace(/^[\^~>=<\s]+/, "");
}

/**
 * Extracts the version the coverage map claims to have been verified against,
 * from its `Verified against:` header comment.
 *
 * @param {string} coverageContent
 * @returns {string}
 */
export function getVerifiedVersion(coverageContent) {
  const match = coverageContent.match(
    new RegExp(`${PACKAGE_NAME.replace(/[/\\^$*+?.()|[\]{}]/g, "\\$&")}\\s+([0-9][^\\s]*)`),
  );

  if (!match) {
    throw new Error(
      `Could not find a "${PACKAGE_NAME} <version>" line in the header of ${COVERAGE_FILE}`,
    );
  }

  return match[1];
}

/**
 * Fails when the `@azure-tools/typespec-azure-core` version pinned in the repo
 * root `package.json` differs from the version the data-plane linter coverage
 * map was verified against.
 *
 * A linter bump can flip a rule from agent-owned to linter-enforced. When that
 * happens the coverage map must be re-verified, otherwise the Data-Plane API
 * Reviewer agent starts double-reporting findings CI already surfaces -- the
 * single most reliable way to get a review bot muted.
 *
 * @param {object} options
 * @param {typeof import("@actions/core")} options.core
 * @param {string} [options.rootDir] repo root; defaults to the current working directory
 * @returns {Promise<boolean>} true when aligned
 */
export default async function checkDataPlaneLinterAlignment({ core, rootDir = process.cwd() }) {
  const packageJsonContent = await readFile(join(rootDir, "package.json"), "utf8");
  const coverageContent = await readFile(join(rootDir, COVERAGE_FILE), "utf8");

  const pinned = getPinnedVersion(packageJsonContent);
  const verified = getVerifiedVersion(coverageContent);

  if (pinned === verified) {
    core.info(`${PACKAGE_NAME} ${pinned} matches ${COVERAGE_FILE}`);
    return true;
  }

  core.setFailed(
    [
      `${PACKAGE_NAME} is pinned at ${pinned} in package.json, but ${COVERAGE_FILE}`,
      `was verified against ${verified}.`,
      "",
      "A linter version bump can move rules between the agent-owned and linter-enforced",
      "sets. Re-verify the coverage map before merging:",
      "",
      `  1. Diff the ${PACKAGE_NAME} linter rules and the`,
      "     @azure-tools/typespec-azure-rulesets data-plane ruleset between the two versions.",
      "  2. Move any newly enabled rule to the 🔒 Linted table.",
      "  3. Flip any ⏳ Landing rule that now ships to 🔒 Linted, and add a true-negative",
      "     eval stimulus asserting the agent stays silent on it.",
      `  4. Update the "Upstream alignment" date and the pinned versions in the`,
      `     ${COVERAGE_FILE} header comment.`,
    ].join("\n"),
  );

  return false;
}
