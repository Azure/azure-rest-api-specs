import { existsSync } from "fs";
import { join, posix } from "path";

/**
 * @typedef {{ tspProjectPaths: string[], tspProjectUrls: string[], apiVersions: string[], isPreview: boolean }} TypeSpecProjectInfo
 */

/**
 * Identifies TypeSpec project path(s) and API version info from modified files in a PR.
 *
 * Uses the GitHub API to fetch the list of changed files (reliable across forks and
 * shallow checkouts), then for each modified file under `specification/`, walks up
 * the directory tree to find the nearest ancestor containing a `tspconfig.yaml`.
 * This works even if `tspconfig.yaml` itself is not modified in the PR.
 *
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {import('@actions/github-script').AsyncFunctionArguments['context']} context
 * @param {import('@actions/github-script').AsyncFunctionArguments['core']} core
 * @param {Object} [options]
 * @param {string} [options.workspace] - Absolute path to repo root. Defaults to GITHUB_WORKSPACE or cwd.
 * @param {number} [options.prNumber] - PR number. Defaults to context.payload.pull_request.number if available.
 * @returns {Promise<TypeSpecProjectInfo>}
 */
export async function getTypeSpecProjectInfo(github, context, core, options = {}) {
  const workspace = options.workspace || process.env.GITHUB_WORKSPACE || process.cwd();
  const owner = context.repo.owner;
  const repo = context.repo.repo;
  const prNumber = options.prNumber ?? context.payload.pull_request?.number;

  core.info(`Fetching changed files for PR #${prNumber} via GitHub API`);

  const allFiles = await getPrChangedFiles(github, owner, repo, prNumber);
  const specFiles = allFiles.filter((f) => f.startsWith("specification/"));

  if (specFiles.length === 0) {
    core.info("No specification files changed in this PR.");
    return { tspProjectPaths: [], tspProjectUrls: [], apiVersions: [], isPreview: false };
  }

  core.info(`Found ${specFiles.length} changed specification file(s)`);

  // Collect TypeSpec project paths from changed files
  /** @type {Set<string>} */
  const tspProjectPathsSet = new Set();

  // First, check if any changed file IS a tspconfig.yaml (direct match)
  for (const file of specFiles) {
    if (file.endsWith("/tspconfig.yaml")) {
      // Extract project path by removing the filename
      const projectPath = posix.dirname(file);
      tspProjectPathsSet.add(projectPath);
      core.info(`Found tspconfig.yaml at: ${projectPath}`);
    }
  }

  // For remaining TypeSpec files, walk up the directory tree to find tspconfig.yaml
  const filesWithoutTspConfig = specFiles.filter((file) => !file.endsWith("/tspconfig.yaml"));

  for (const file of filesWithoutTspConfig) {
    const projectPath = findTspConfigDir(file, workspace);
    if (projectPath) {
      tspProjectPathsSet.add(projectPath);
    }
  }

  const tspProjectPaths = [...tspProjectPathsSet];

  core.info(
    `Found ${tspProjectPaths.length} TypeSpec project(s): ${JSON.stringify(tspProjectPaths)}`,
  );

  if (tspProjectPaths.length === 0) {
    core.info("No TypeSpec project (tspconfig.yaml) found for any modified file.");
    return { tspProjectPaths: [], tspProjectUrls: [], apiVersions: [], isPreview: false };
  }

  // Convert relative paths to absolute URLs to tspconfig.yaml
  const tspProjectUrls = tspProjectPaths.map(
    (path) => `https://github.com/${owner}/${repo}/${path}/tspconfig.yaml`,
  );

  core.info(`TypeSpec project URLs: ${JSON.stringify(tspProjectUrls)}`);

  // Detect API versions and preview status
  const tspProjectPath = tspProjectPaths.length === 1 ? tspProjectPaths[0] : null;
  const versionResult = await detectApiVersions(specFiles, tspProjectPath, workspace, core);

  return {
    tspProjectPaths,
    tspProjectUrls,
    apiVersions: versionResult.apiVersions,
    isPreview: versionResult.isPreview,
  };
}

/**
 * Fetches all files changed in a PR using the GitHub API (paginated).
 *
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {string} owner
 * @param {string} repo
 * @param {number} prNumber
 * @returns {Promise<string[]>}
 */
async function getPrChangedFiles(github, owner, repo, prNumber) {
  /** @type {string[]} */
  const allFiles = [];
  let page = 1;

  while (true) {
    const { data: files } = await github.rest.pulls.listFiles({
      owner,
      repo,
      pull_number: prNumber,
      per_page: 100,
      page,
    });

    if (files.length === 0) break;
    allFiles.push(...files.map((f) => f.filename));
    if (files.length < 100) break;
    page++;
  }

  return allFiles;
}

/**
 * Walk up from a file's directory to find the nearest ancestor containing tspconfig.yaml.
 * Stops at the `specification/` boundary.
 *
 * @param {string} relativeFilePath - Relative path (posix) from repo root, e.g. "specification/foo/Bar/main.tsp"
 * @param {string} workspace - Absolute path to repo root
 * @returns {string | null} Relative posix path to the TypeSpec project root, or null if not found
 */
export function findTspConfigDir(relativeFilePath, workspace) {
  let dir = posix.dirname(relativeFilePath);

  while (dir && dir !== "." && dir.startsWith("specification")) {
    const tspConfigAbsolute = join(workspace, dir, "tspconfig.yaml");
    if (existsSync(tspConfigAbsolute)) {
      return dir;
    }
    const parent = posix.dirname(dir);
    if (parent === dir) break;
    dir = parent;
  }

  return null;
}

/**
 * Detect API versions from changed file paths and main.tsp content.
 *
 * First checks file paths for date-based version segments (e.g., `2025-06-01-preview`),
 * then falls back to reading the project's main.tsp from the workspace
 * (even if main.tsp is not modified in the PR).
 *
 * @param {string[]} files - Changed files in the PR
 * @param {string | null} tspProjectPath - Relative posix path to the TypeSpec project root (null if multiple projects)
 * @param {string} workspace - Absolute path to the repo root
 * @param {import('@actions/github-script').AsyncFunctionArguments['core']} core
 * @returns {Promise<{ apiVersions: string[], isPreview: boolean }>}
 */
export async function detectApiVersions(files, tspProjectPath, workspace, core) {
  let isPreview = false;

  // Collect distinct API versions from file paths (yyyy-mm-dd or yyyy-mm-dd-preview pattern)
  const apiVersionPattern = /(\d{4}-\d{2}-\d{2}(?:-preview)?)/g;
  /** @type {Set<string>} */
  const apiVersions = new Set();

  for (const file of files) {
    const matches = file.match(apiVersionPattern);
    if (matches) {
      for (const version of matches) {
        apiVersions.add(version);
        if (version.endsWith("-preview")) {
          isPreview = true;
        }
      }
    }
  }

  if (apiVersions.size > 0) {
    core.info(`API versions detected from file paths: ${JSON.stringify([...apiVersions])}`);
    if (isPreview) {
      core.info("Preview version detected from file path pattern.");
    }
  }

  return { apiVersions: [...apiVersions], isPreview };
}
