import { dirname } from "node:path/posix";
import { PER_PAGE_MAX } from "../../shared/src/github.js";

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
 * Resolve a Swagger check exemption using the same ancestor-file semantics as
 * `@azure-tools/suppressions`.
 *
 * Conditional entries are deliberately ignored because this resolver runs in a privileged
 * workflow without the tool-specific context needed to evaluate them.
 *
 * @param {Object} params
 * @param {string[]} params.changedPaths
 * @param {string} params.checkName
 * @param {(path: string) => Promise<string | undefined>} params.loadSuppressionsFile
 * @returns {Promise<{skip: false} | {skip: true, reason: string}>}
 */
export async function resolveSwaggerCheckSuppression({
  changedPaths,
  checkName,
  loadSuppressionsFile,
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

  const suppressionTools = [SWAGGER_SUPPRESSION_TOOLS[checkName], SWAGGER_ALL_SUPPRESSION_TOOL];
  const { getSuppressionsFromYaml } =
    await import("../../../eng/tools/suppressions/src/suppressions.ts");
  /** @type {Map<string, Promise<string | undefined>>} */
  const contentCache = new Map();
  /** @type {Set<string>} */
  const reasons = new Set();

  for (const changedPath of specificationPaths) {
    /** @type {SwaggerSuppression | undefined} */
    let matchedSuppression;

    for (const suppressionsFile of getAncestorSuppressionsFiles(changedPath)) {
      let contentPromise = contentCache.get(suppressionsFile);
      if (!contentPromise) {
        contentPromise = loadSuppressionsFile(suppressionsFile);
        contentCache.set(suppressionsFile, contentPromise);
      }

      const content = await contentPromise;
      if (content === undefined) {
        continue;
      }

      for (const tool of suppressionTools) {
        const suppressions = /** @type {SwaggerSuppression[]} */ (
          getSuppressionsFromYaml(
            tool,
            changedPath,
            suppressionsFile,
            content,
            {},
            { evaluateIf: false },
          )
        );
        matchedSuppression = suppressions.find(
          (suppression) => !suppression.rules?.length && !suppression.subRules?.length,
        );

        if (matchedSuppression) {
          break;
        }
      }

      if (matchedSuppression) {
        break;
      }
    }

    if (!matchedSuppression) {
      return { skip: false };
    }

    reasons.add(matchedSuppression.reason);
  }

  return {
    skip: true,
    reason:
      reasons.size === 1 ? [...reasons][0] : `Matched ${reasons.size} Swagger check suppressions`,
  };
}

/**
 * Resolve a Swagger check exemption from `suppressions.yaml` files in the pull request base.
 *
 * Reading the reviewed base policy prevents an untrusted pull request from exempting itself.
 *
 * @param {Object} params
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} params.github
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {number} params.pullNumber
 * @param {string} params.checkName
 * @returns {Promise<{skip: false} | {skip: true, reason: string}>}
 */
export async function getSwaggerCheckSuppression({ github, owner, repo, pullNumber, checkName }) {
  /** @type {Promise<{baseOwner: string, baseRepo: string, baseSha: string}> | undefined} */
  let pullRequestBasePromise;
  const changedFiles = await github.paginate(github.rest.pulls.listFiles, {
    owner,
    repo,
    pull_number: pullNumber,
    per_page: PER_PAGE_MAX,
  });
  const changedPaths = changedFiles.flatMap((file) =>
    file.previous_filename ? [file.filename, file.previous_filename] : [file.filename],
  );

  return await resolveSwaggerCheckSuppression({
    changedPaths,
    checkName,
    loadSuppressionsFile: async (path) => {
      pullRequestBasePromise ??= getPullRequestBase(github, owner, repo, pullNumber);
      const { baseOwner, baseRepo, baseSha } = await pullRequestBasePromise;

      try {
        const { data } = await github.rest.repos.getContent({
          owner: baseOwner,
          repo: baseRepo,
          path,
          ref: baseSha,
        });

        if (Array.isArray(data) || data.type !== "file" || !("content" in data)) {
          throw new Error(`Expected '${path}' to be a file`);
        }

        return Buffer.from(data.content, "base64").toString("utf8");
      } catch (error) {
        if (error instanceof Error && "status" in error && error.status === 404) {
          return undefined;
        }
        throw error;
      }
    },
  });
}

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} github
 * @param {string} owner
 * @param {string} repo
 * @param {number} pullNumber
 * @returns {Promise<{baseOwner: string, baseRepo: string, baseSha: string}>}
 */
async function getPullRequestBase(github, owner, repo, pullNumber) {
  const { data: pullRequest } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: pullNumber,
  });
  const baseOwner = pullRequest.base.repo.owner.login;
  const baseRepo = pullRequest.base.repo.name;
  const baseSha = pullRequest.base.sha;

  if (!baseOwner || !baseRepo || !baseSha) {
    throw new Error(`Pull request ${pullNumber} has no accessible base repository`);
  }

  return { baseOwner, baseRepo, baseSha };
}

/**
 * @param {string} path
 * @returns {string}
 */
function normalizeRepoPath(path) {
  return path.replaceAll("\\", "/").replace(/^\.\/+/, "");
}

/**
 * @param {string} changedPath
 * @returns {string[]}
 */
function getAncestorSuppressionsFiles(changedPath) {
  const files = [];
  let directory = dirname(changedPath);

  while (directory === "specification" || directory.startsWith("specification/")) {
    files.push(`${directory}/suppressions.yaml`);
    if (directory === "specification") {
      break;
    }
    directory = dirname(directory);
  }

  return files;
}
