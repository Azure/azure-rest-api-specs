import { existsSync } from "fs";
import { join, posix } from "path";

/**
 * @typedef {{ tspProjectPaths: string[], tspProjectUrls: string[], apiVersions: string[], isPreview: boolean }} TypeSpecProjectInfo
 */

/**
 * @typedef {{ filename: string, status?: string }} PullRequestChangedFile
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
  const specFiles = allFiles.filter((f) => f.filename.startsWith("specification/"));

  if (specFiles.length === 0) {
    core.info("No specification files changed in this PR.");
    return { tspProjectPaths: [], tspProjectUrls: [], apiVersions: [], isPreview: false };
  }

  core.info(`Found ${specFiles.length} changed specification file(s)`);

  // Collect TypeSpec project paths from changed files
  /** @type {Set<string>} */
  const tspProjectPathsSet = new Set();

  const changedTspConfigs = specFiles.filter(
    (f) => f.filename.endsWith("/tspconfig.yaml") && f.status !== "removed",
  );

  if (changedTspConfigs.length > 0) {
    // If PR directly changes tspconfig.yaml, trust those paths and skip filesystem probing.
    for (const file of changedTspConfigs) {
      const projectPath = posix.dirname(file.filename);
      tspProjectPathsSet.add(projectPath);
      core.info(`Found changed tspconfig.yaml at: ${projectPath} (status: ${file.status ?? "unknown"})`);
    }

    if (changedTspConfigs.length === 1) {
      core.info("Exactly one non-removed tspconfig.yaml changed; using it as authoritative TypeSpec project path.");
    }
  } else {
    // No changed tspconfig.yaml in PR: fall back to filesystem probing from changed files.
    for (const file of specFiles) {
      const projectPath = findTspConfigDir(file.filename, workspace);
      if (projectPath) {
        tspProjectPathsSet.add(projectPath);
      }
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

  // Convert relative paths to absolute TypeSpec project URLs (without tspconfig.yaml suffix)
  const tspProjectUrls = tspProjectPaths.map(
    (path) => `https://github.com/${owner}/${repo}/${path}`,
  );

  core.info(`TypeSpec project URLs: ${JSON.stringify(tspProjectUrls)}`);

  // Detect API versions and preview status
  const tspProjectPath = tspProjectPaths.length === 1 ? tspProjectPaths[0] : null;
  const specFilePaths = specFiles.map((f) => f.filename);
  const versionResult = await detectApiVersions(specFilePaths, tspProjectPath, workspace, core);

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
 * @returns {Promise<PullRequestChangedFile[]>}
 */
async function getPrChangedFiles(github, owner, repo, prNumber) {
  /** @type {PullRequestChangedFile[]} */
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
    allFiles.push(...files.map((f) => ({ filename: f.filename, status: f.status })));
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

  const sortedApiVersions = [...apiVersions].sort(compareApiVersionsDesc);
  if (sortedApiVersions.length > 1) {
    core.info(
      `Sorted API versions (latest first): ${JSON.stringify(sortedApiVersions)}. Latest: ${sortedApiVersions[0]}`,
    );
  }

  return { apiVersions: sortedApiVersions, isPreview };
}

/**
 * Compare API versions in descending order (latest first).
 * Version format: YYYY-MM-DD or YYYY-MM-DD-preview.
 * For the same date, GA is considered newer than preview.
 *
 * @param {string} a
 * @param {string} b
 * @returns {number}
 */
function compareApiVersionsDesc(a, b) {
  const pa = parseApiVersion(a);
  const pb = parseApiVersion(b);

  if (pa.year !== pb.year) return pb.year - pa.year;
  if (pa.month !== pb.month) return pb.month - pa.month;
  if (pa.day !== pb.day) return pb.day - pa.day;

  if (pa.isPreview !== pb.isPreview) {
    return pa.isPreview ? 1 : -1;
  }

  return b.localeCompare(a);
}

/**
 * @param {string} version
 * @returns {{ year: number, month: number, day: number, isPreview: boolean }}
 */
function parseApiVersion(version) {
  const match = /^(\d{4})-(\d{2})-(\d{2})(-preview)?$/.exec(version);
  if (!match) {
    return { year: 0, month: 0, day: 0, isPreview: false };
  }

  return {
    year: Number.parseInt(match[1], 10),
    month: Number.parseInt(match[2], 10),
    day: Number.parseInt(match[3], 10),
    isPreview: Boolean(match[4]),
  };
}
