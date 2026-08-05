import { resolve } from "node:path";
import { PER_PAGE_MAX } from "../../shared/src/github.js";

const PR_BASE_ROOT = "pull-request-base";

export const SWAGGER_ALL_SUPPRESSION_TOOL = "SwaggerAll";

export const SWAGGER_SUPPRESSION_TOOLS = Object.freeze({
  "Swagger Avocado": "SwaggerAvocado",
  "Swagger LintDiff": "SwaggerLintDiff",
  "Swagger ModelValidation": "SwaggerModelValidation",
  "Swagger SemanticValidation": "SwaggerSemanticValidation",
  "Swagger BreakingChange": "SwaggerBreakingChange",
  "Breaking Change(Cross-Version)": "SwaggerBreakingChangeCrossVersion",
});

/** @typedef {keyof typeof SWAGGER_SUPPRESSION_TOOLS} SwaggerCheckName */
/** @typedef {{rules?: string[], subRules?: string[], reason: string}} SwaggerSuppression */

/**
 * @param {string} checkName
 * @returns {checkName is SwaggerCheckName}
 */
export function isSwaggerCheck(checkName) {
  return Object.hasOwn(SWAGGER_SUPPRESSION_TOOLS, checkName);
}

/**
 * Determine whether every changed specification path has a whole-check suppression.
 *
 * @param {Object} params
 * @param {string[]} params.changedPaths
 * @param {string} params.checkName
 * @param {(tool: string, path: string) => Promise<SwaggerSuppression[]>} params.getSuppressionsForPath
 * @returns {Promise<{skip: false} | {skip: true, reason: string}>}
 */
export async function resolveSwaggerCheckSuppression({
  changedPaths,
  checkName,
  getSuppressionsForPath,
}) {
  if (!isSwaggerCheck(checkName)) {
    return { skip: false };
  }

  const specificationPaths = [
    ...new Set(
      changedPaths.map(normalizeRepoPath).filter((path) => path.startsWith("specification/")),
    ),
  ];
  if (specificationPaths.length === 0) {
    return { skip: false };
  }

  /** @type {Set<string>} */
  const reasons = new Set();
  for (const path of specificationPaths) {
    const toolSuppressions = await getSuppressionsForPath(
      SWAGGER_SUPPRESSION_TOOLS[checkName],
      path,
    );
    const allSuppressions = await getSuppressionsForPath(SWAGGER_ALL_SUPPRESSION_TOOL, path);
    const suppression = [...toolSuppressions, ...allSuppressions].find(
      (item) => !item.rules?.length && !item.subRules?.length,
    );

    if (!suppression) {
      return { skip: false };
    }
    reasons.add(suppression.reason);
  }

  return {
    skip: true,
    reason:
      reasons.size === 1 ? [...reasons][0] : `Matched ${reasons.size} Swagger check suppressions`,
  };
}

/**
 * Resolve a Swagger check suppression from the sparse PR-base checkout.
 *
 * @param {Object} params
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} params.github
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {number} params.pullNumber
 * @param {string} params.checkName
 * @param {(tool: string, path: string, context?: Record<string, unknown>, options?: {allowMissingPath?: boolean}) => Promise<SwaggerSuppression[]>} [params.getSuppressionsImpl]
 * @returns {Promise<{skip: false} | {skip: true, reason: string}>}
 */
export async function getSwaggerCheckSuppression({
  github,
  owner,
  repo,
  pullNumber,
  checkName,
  getSuppressionsImpl,
}) {
  const changedFiles = await github.paginate(github.rest.pulls.listFiles, {
    owner,
    repo,
    pull_number: pullNumber,
    per_page: PER_PAGE_MAX,
  });
  const changedPaths = changedFiles.flatMap((file) =>
    file.previous_filename ? [file.filename, file.previous_filename] : [file.filename],
  );

  getSuppressionsImpl ??= (await import("../../../eng/tools/suppressions/src/suppressions.ts"))
    .getSuppressions;

  return await resolveSwaggerCheckSuppression({
    changedPaths,
    checkName,
    getSuppressionsForPath: async (tool, path) =>
      await getSuppressionsImpl(
        tool,
        resolve(PR_BASE_ROOT, path),
        {},
        {
          allowMissingPath: true,
        },
      ),
  });
}

/**
 * @param {string} path
 * @returns {string}
 */
function normalizeRepoPath(path) {
  return path.replaceAll("\\", "/").replace(/^\.\/+/, "");
}
