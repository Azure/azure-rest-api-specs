import { Octokit } from "@octokit/rest";
import { execSync } from "node:child_process";
import { existsSync, readFileSync } from "node:fs";
import { join, posix } from "node:path";
import type {
  CommitProjectInfoResult,
  OctokitLike,
  PullRequestChangedFile,
  TypeSpecProjectInfo,
} from "./types.js";

/**
 * Identifies one TypeSpec project path and selected API version from a pull request.
 * Returns null when no specification files were modified, or when zero/multiple projects found.
 * @param params Object containing PR details, owner, repo, workspace, and Octokit instance
 * @param params.prNumber Pull request number
 * @param params.owner Repository owner
 * @param params.repo Repository name
 * @param params.workspace Absolute path to workspace root
 * @param params.octokit Octokit instance for GitHub API calls
 * @returns TypeSpec project info with path and API version, or null if no spec changes, no projects found, or multiple projects found
 * @throws Error if no API version detected in project
 */
export async function getTypeSpecProjectInfoFromPr(params: {
  prNumber: number;
  owner: string;
  repo: string;
  workspace: string;
  octokit: OctokitLike;
}): Promise<TypeSpecProjectInfo | null> {
  const { prNumber, owner, repo, workspace, octokit } = params;

  const allFiles = await getPrChangedFiles({
    octokit,
    owner,
    repo,
    prNumber,
  });

  const specFiles = allFiles.filter((f) => f.filename.startsWith("specification/"));
  if (specFiles.length === 0) {
    return null;
  }

  const tspProjectPaths = collectTypeSpecProjectPaths(specFiles, workspace);

  if (tspProjectPaths.length === 0) {
    console.log("Unable to locate TypeSpec project (tspconfig.yaml) for modified files.");
    return null;
  }
  if (tspProjectPaths.length > 1) {
    console.log(
      `Multiple TypeSpec projects found in PR: ${tspProjectPaths.join(", ")}. Create release plan manually using aka.ms/azsdk/releaseplan-dashboard.`,
    );
    return null;
  }

  const tspProjectPath = tspProjectPaths[0];
  const versionResult = detectApiVersions(
    specFiles.map((f) => f.filename),
    tspProjectPath,
    workspace,
  );

  if (versionResult.apiVersions.length === 0) {
    throw new Error("No API version found in modified files or TypeSpec project path/content.");
  }

  return {
    tspProjectPath,
    apiVersion: versionResult.apiVersions[0],
    isPreview: versionResult.isPreview,
  };
}

/**
 * Identifies TypeSpec project info from a commit SHA.
 * Attempts to resolve an associated PR first; if not found, inspects commit file changes directly.
 * @returns TypeSpec project info and optional associated PR number
 */
export async function getTypeSpecProjectInfoFromCommit(params: {
  commitSha: string;
  owner: string;
  repo: string;
  workspace: string;
  octokit: OctokitLike;
}): Promise<CommitProjectInfoResult> {
  const { commitSha, owner, repo, workspace, octokit } = params;

  const associatedPrNumber = await getAssociatedPrNumber({
    commitSha,
    owner,
    repo,
    octokit,
  });
  console.log(`Associated PR number for commit ${commitSha}: ${associatedPrNumber ?? "none"}`);
  if (associatedPrNumber) {
    const hasNewApiVersionLabel = await checkNewApiVersionLabel({
      octokit,
      owner,
      repo,
      prNumber: associatedPrNumber,
    });

    const projectInfo = await getTypeSpecProjectInfoFromPr({
      prNumber: associatedPrNumber,
      owner,
      repo,
      workspace,
      octokit,
    });
    return {
      projectInfo,
      prNumber: associatedPrNumber,
      hasNewApiVersionLabel,
    };
  }

  const allFiles = await getCommitChangedFiles({
    octokit,
    owner,
    repo,
    commitSha,
  });

  const specFiles = allFiles.filter((f) => f.filename.startsWith("specification/"));
  if (specFiles.length === 0) {
    return { projectInfo: null, hasNewApiVersionLabel: false };
  }

  const tspProjectPaths = collectTypeSpecProjectPaths(specFiles, workspace);
  if (tspProjectPaths.length === 0) {
    console.log("Unable to locate TypeSpec project (tspconfig.yaml) for modified files.");
    return { projectInfo: null, hasNewApiVersionLabel: false };
  }

  if (tspProjectPaths.length > 1) {
    console.log(
      `Multiple TypeSpec projects found in commit: ${tspProjectPaths.join(", ")}. Create release plan manually using aka.ms/azsdk/releaseplan-dashboard.`,
    );
    return { projectInfo: null, hasNewApiVersionLabel: false };
  }

  const tspProjectPath = tspProjectPaths[0];
  const versionResult = detectApiVersions(
    specFiles.map((f) => f.filename),
    tspProjectPath,
    workspace,
  );

  if (versionResult.apiVersions.length === 0) {
    throw new Error("No API version found in modified files or TypeSpec project path/content.");
  }

  return {
    projectInfo: {
      tspProjectPath,
      apiVersion: versionResult.apiVersions[0],
      isPreview: versionResult.isPreview,
    },
    hasNewApiVersionLabel: false,
  };
}

export async function checkNewApiVersionLabel(params: {
  octokit: OctokitLike;
  owner: string;
  repo: string;
  prNumber: number;
}): Promise<boolean> {
  const { octokit, owner, repo, prNumber } = params;

  const pullRequest = await octokit.rest.pulls.get({
    owner,
    repo,
    pull_number: prNumber,
  });

  return pullRequest.data.labels?.some((label) => label.name === "new-api-version") ?? false;
}

/**
 * Collects TypeSpec project paths from changed specification files.
 * Prioritizes files with tspconfig.yaml changes, falls back to directory traversal if none found.
 * @param specFiles Array of changed specification files
 * @param workspace Absolute path to workspace root
 * @returns Array of unique TypeSpec project paths
 */
export function collectTypeSpecProjectPaths(
  specFiles: PullRequestChangedFile[],
  workspace: string,
): string[] {
  const projectPaths = new Set<string>();

  const changedTspConfigs = specFiles.filter(
    (f) => f.filename.endsWith("/tspconfig.yaml") && f.status !== "removed",
  );

  if (changedTspConfigs.length > 0) {
    for (const file of changedTspConfigs) {
      projectPaths.add(posix.dirname(file.filename));
    }
  } else {
    for (const file of specFiles) {
      const tspProject = findTspConfigDir(file.filename, workspace);
      if (tspProject) {
        projectPaths.add(tspProject);
      }
    }
  }

  return [...projectPaths];
}

/**
 * Fetch all changed files for a pull request through GitHub API.
 * Uses pagination to retrieve all files (100 per page).
 * @param params Object containing Octokit instance, repository details, and PR number
 * @param params.octokit Octokit instance for GitHub API
 * @param params.owner Repository owner
 * @param params.repo Repository name
 * @param params.prNumber Pull request number
 * @returns Array of all changed files in the PR with filename and status
 */
export async function getPrChangedFiles(params: {
  octokit: OctokitLike;
  owner: string;
  repo: string;
  prNumber: number;
}): Promise<PullRequestChangedFile[]> {
  const { octokit, owner, repo, prNumber } = params;
  const allFiles: PullRequestChangedFile[] = [];

  for (let page = 1; ; page++) {
    const response = await octokit.rest.pulls.listFiles({
      owner,
      repo,
      pull_number: prNumber,
      per_page: 100,
      page,
    });

    const data = response.data;
    if (data.length === 0) {
      break;
    }

    for (const file of data) {
      if (file.filename) {
        allFiles.push({ filename: file.filename, status: file.status });
      }
    }

    if (data.length < 100) {
      break;
    }
  }

  return allFiles;
}

/**
 * Fetch changed files for a commit.
 */
export async function getCommitChangedFiles(params: {
  octokit: OctokitLike;
  owner: string;
  repo: string;
  commitSha: string;
}): Promise<PullRequestChangedFile[]> {
  const { octokit, owner, repo, commitSha } = params;
  if (!octokit.rest.repos?.getCommit) {
    throw new Error("Octokit repos.getCommit is not available.");
  }

  const response = await octokit.rest.repos.getCommit({
    owner,
    repo,
    ref: commitSha,
  });

  const files = response.data.files ?? [];
  return files
    .filter((file) => Boolean(file.filename))
    .map((file) => ({ filename: file.filename, status: file.status }));
}

/**
 * Resolve PR number associated with a commit SHA.
 */
export async function getAssociatedPrNumber(params: {
  octokit: OctokitLike;
  owner: string;
  repo: string;
  commitSha: string;
}): Promise<number | undefined> {
  const { octokit, owner, repo, commitSha } = params;
  if (!octokit.rest.repos?.listPullRequestsAssociatedWithCommit) {
    throw new Error("Octokit repos.listPullRequestsAssociatedWithCommit is not available.");
  }

  const response = await octokit.rest.repos.listPullRequestsAssociatedWithCommit({
    owner,
    repo,
    commit_sha: commitSha,
  });

  return response.data[0]?.number;
}

/**
 * Walk up from a file path to locate nearest TypeSpec project root with tspconfig.yaml.
 * Starting from the directory of the given file, searches parent directories until
 * a tspconfig.yaml is found or the specification root is reached.
 * @param relativeFilePath Relative path to a file within specification directory
 * @param workspace Absolute path to workspace root
 * @returns Relative path to TypeSpec project directory, or null if not found
 */
export function findTspConfigDir(relativeFilePath: string, workspace: string): string | null {
  let dir = posix.dirname(relativeFilePath);

  while (dir && dir !== "." && dir.startsWith("specification")) {
    const tspConfigAbsolute = join(workspace, dir, "tspconfig.yaml");
    if (existsSync(tspConfigAbsolute)) {
      return dir;
    }

    const parent = posix.dirname(dir);
    if (parent === dir) {
      break;
    }
    dir = parent;
  }

  return null;
}

/**
 * Detect API versions from changed file paths or from TypeSpec project content.
 * Searches in order: changed file paths, project directory tree, main.tsp content.
 * @param changedFiles Array of changed file paths
 * @param tspProjectPath Relative path to TypeSpec project
 * @param workspace Absolute path to workspace root
 * @returns Object containing sorted API versions (latest first) and preview flag
 */
export function detectApiVersions(
  changedFiles: string[],
  tspProjectPath: string,
  workspace: string,
): { apiVersions: string[]; isPreview: boolean } {
  const apiVersionPattern = /(\d{4}-\d{2}-\d{2}(?:-preview)?)/g;
  const versions = new Set<string>();
  let isPreview = false;

  for (const file of changedFiles) {
    const matches = file.match(apiVersionPattern);
    if (matches) {
      for (const version of matches) {
        versions.add(version);
        if (version.endsWith("-preview")) {
          isPreview = true;
        }
      }
    }
  }

  if (versions.size === 0) {
    for (const version of collectApiVersionsFromMainTsp(tspProjectPath, workspace)) {
      versions.add(version);
      if (version.endsWith("-preview")) {
        isPreview = true;
      }
    }
  }

  const apiVersions = [...versions].sort(compareApiVersionsDesc);
  return { apiVersions, isPreview };
}

/**
 * Collects API versions from main.tsp file content.
 * Searches the TypeSpec project's main.tsp file for version patterns.
 * @param tspProjectPath Relative path to TypeSpec project
 * @param workspace Absolute path to workspace root
 * @returns Array of API versions found in main.tsp content
 */
function collectApiVersionsFromMainTsp(tspProjectPath: string, workspace: string): string[] {
  const mainFile = join(workspace, tspProjectPath, "main.tsp");
  if (!existsSync(mainFile)) {
    return [];
  }

  const content = readFileSync(mainFile, "utf8");
  const matches = content.match(/(\d{4}-\d{2}-\d{2}(?:-preview)?)/g);
  if (!matches) {
    return [];
  }

  return [...new Set(matches)];
}

/**
 * Compare API versions in descending order (latest first).
 * Sorts by year, month, day, then prioritizes GA versions over preview for same date.
 * @param a First API version string (e.g., "2025-06-01" or "2025-06-01-preview")
 * @param b Second API version string
 * @returns Negative if a > b, positive if b > a, zero if equal
 */
export function compareApiVersionsDesc(a: string, b: string): number {
  const pa = parseApiVersion(a);
  const pb = parseApiVersion(b);

  if (pa.year !== pb.year) {
    return pb.year - pa.year;
  }
  if (pa.month !== pb.month) {
    return pb.month - pa.month;
  }
  if (pa.day !== pb.day) {
    return pb.day - pa.day;
  }
  if (pa.isPreview !== pb.isPreview) {
    return pa.isPreview ? 1 : -1;
  }

  return b.localeCompare(a);
}

/**
 * Parse API version string.
 * Extracts year, month, day, and preview flag from a version string like "2025-06-01" or "2025-06-01-preview".
 * @param version API version string in format YYYY-MM-DD or YYYY-MM-DD-preview
 * @returns Parsed version components (year, month, day, isPreview), or zeros if invalid format
 */
export function parseApiVersion(version: string): {
  year: number;
  month: number;
  day: number;
  isPreview: boolean;
} {
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

/**
 * Create an Octokit instance for GitHub API access.
 * Uses the explicit token first, then GITHUB_TOKEN/GH_TOKEN, then falls back to `gh auth token`.
 * @param token GitHub authentication token (optional)
 * @returns Octokit instance configured with the available credentials
 */
export function createOctokit(token: string | undefined): OctokitLike {
  const auth = token ?? getGitHubAuthToken();

  return new Octokit({
    auth,
  });
}

function getGitHubAuthToken(): string | undefined {
  const envToken = process.env.GITHUB_TOKEN || process.env.GH_TOKEN;
  if (envToken) {
    return envToken;
  }

  try {
    return execSync("gh auth token", { encoding: "utf8" }).trim() || undefined;
  } catch {
    return undefined;
  }
}
