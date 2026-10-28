import {
  generateTypeSpecMetadata,
  type TypeSpecMetadata,
} from "@azure-tools/specs-shared/typespec-metadata";
import { Octokit } from "@octokit/rest";
import { execSync } from "node:child_process";
import { existsSync } from "node:fs";
import { join, posix } from "node:path";
import type {
  CommitProjectInfoResult,
  OctokitLike,
  PullRequestChangedFile,
  TypeSpecProjectInfo,
} from "./types.ts";

type TypeSpecMetadataCache = Map<string, Promise<TypeSpecMetadata>>;
type TypeSpecDirectoryResult = {
  sdkProjectPath: string | null;
  fallbackProjectPath: string | null;
};
type TypeSpecDirectoryCache = Map<string, TypeSpecDirectoryResult>;

function getCachedTypeSpecMetadata(
  projectPath: string,
  cache: TypeSpecMetadataCache,
): Promise<TypeSpecMetadata> {
  let metadata = cache.get(projectPath);
  if (!metadata) {
    metadata = generateTypeSpecMetadata(projectPath);
    cache.set(projectPath, metadata);
  }
  return metadata;
}

/** Label indicating that a spec PR introduces a new API version. */
export const NEW_API_VERSION_LABEL = "new-api-version";

/**
 * Label indicating that a spec PR only migrates/renames folders. Release plan
 * processing must be skipped entirely for PRs carrying this label.
 */
export const FOLDER_MIGRATION_LABEL = "FolderMigrationV2";

/** Label indicating that release plan automation should not process a spec PR. */
export const SKIP_RELEASE_PLAN_AUTOMATION_LABEL = "Skip-ReleasePlan-Automation";

async function getTypeSpecProjectInfoFromFiles(
  allFiles: PullRequestChangedFile[],
  workspace: string,
  isPrivatePreview = false,
): Promise<Pick<CommitProjectInfoResult, "projectInfo" | "multipleProjectPaths" | "projectError">> {
  const specFiles = allFiles.filter((f) => f.filename.startsWith("specification/"));
  if (specFiles.length === 0) {
    return { projectInfo: null };
  }

  const metadataCache: TypeSpecMetadataCache = new Map();
  const tspProjectPaths = await collectTypeSpecProjectPaths(specFiles, workspace, metadataCache);

  if (tspProjectPaths.length === 0) {
    console.log("Unable to locate TypeSpec project (tspconfig.yaml) for modified files.");
    return { projectInfo: null };
  }
  if (tspProjectPaths.length > 1) {
    console.log(
      `Multiple TypeSpec projects found: ${tspProjectPaths.join(", ")}. Create release plan manually using aka.ms/azsdk/releaseplan-dashboard.`,
    );
    return { projectInfo: null, multipleProjectPaths: tspProjectPaths };
  }

  const tspProjectRelPath = tspProjectPaths[0];
  const tspProjectAbsPath = join(workspace, tspProjectRelPath);

  try {
    return {
      projectInfo: await getTypeSpecProjectVersionFromMetadata(
        tspProjectAbsPath,
        tspProjectRelPath,
        metadataCache,
        isPrivatePreview,
      ),
    };
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    console.error(`Failed to determine API version for TypeSpec project at ${tspProjectRelPath}`);
    return {
      projectInfo: null,
      projectError: { tspProjectPath: tspProjectRelPath, message },
    };
  }
}

/**
 * Identifies TypeSpec project info from a commit SHA.
 * Attempts to resolve an associated PR first; if not found, inspects commit file changes directly.
 * Uses TypeSpec metadata emitter to determine API version and SDK type.
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
    const labels = await getPullRequestLabels({
      octokit,
      owner,
      repo,
      prNumber: associatedPrNumber,
    });

    if (
      labels.includes(FOLDER_MIGRATION_LABEL) ||
      labels.includes(SKIP_RELEASE_PLAN_AUTOMATION_LABEL)
    ) {
      console.log(
        `PR #${associatedPrNumber} has a release plan automation skip label. Skipping release plan processing.`,
      );
      return {
        projectInfo: null,
        changedFiles: [],
        prNumber: associatedPrNumber,
        hasNewApiVersionLabel: false,
        skipReleasePlanAutomation: true,
      };
    }

    const hasNewApiVersionLabel = labels.includes(NEW_API_VERSION_LABEL);

    const changedFiles = await getPrChangedFiles({
      prNumber: associatedPrNumber,
      owner,
      repo,
      octokit,
    });
    return {
      ...(await getTypeSpecProjectInfoFromFiles(
        changedFiles,
        workspace,
        repo === "azure-rest-api-specs-pr",
      )),
      changedFiles,
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

  return {
    ...(await getTypeSpecProjectInfoFromFiles(
      allFiles,
      workspace,
      repo === "azure-rest-api-specs-pr",
    )),
    changedFiles: allFiles,
    hasNewApiVersionLabel: false,
  };
}

/**
 * Fetches the label names applied to a pull request.
 * @returns Array of label names (empty when the PR has no labels)
 */
export async function getPullRequestLabels(params: {
  octokit: OctokitLike;
  owner: string;
  repo: string;
  prNumber: number;
}): Promise<string[]> {
  const { octokit, owner, repo, prNumber } = params;

  const pullRequest = await octokit.rest.pulls.get({
    owner,
    repo,
    pull_number: prNumber,
  });

  return pullRequest.data.labels?.map((label) => label.name) ?? [];
}

/**
 * Collects TypeSpec project paths from changed .tsp files and tspconfig.yaml files.
 * Resolves every changed directory so config changes cannot hide other changed projects.
 * @param specFiles Array of changed specification files
 * @param workspace Absolute path to workspace root
 * @returns Array of unique TypeSpec project paths
 */
export async function collectTypeSpecProjectPaths(
  specFiles: PullRequestChangedFile[],
  workspace: string,
  metadataCache: TypeSpecMetadataCache = new Map(),
): Promise<string[]> {
  const projectPaths = new Set<string>();
  const directoryCache: TypeSpecDirectoryCache = new Map();

  const directories = new Set(
    specFiles
      .filter(
        ({ filename }) =>
          filename.startsWith("specification/") &&
          (filename.endsWith(".tsp") || posix.basename(filename) === "tspconfig.yaml"),
      )
      .map((file) => posix.dirname(file.filename)),
  );
  // Descendants populate their ancestors' cache entries before those ancestors are considered.
  for (const directory of [...directories].sort((a, b) => b.length - a.length)) {
    const result = directoryCache.get(directory);
    const tspProject = result
      ? (result.sdkProjectPath ?? result.fallbackProjectPath)
      : await findTspConfigDir(
          posix.join(directory, "tspconfig.yaml"),
          workspace,
          metadataCache,
          directoryCache,
        );
    if (tspProject) {
      projectPaths.add(tspProject);
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
 * Resolve the PR merged at this commit, not another PR that merely contains it.
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

  return response.data.find(
    (pullRequest) =>
      pullRequest.merged_at &&
      pullRequest.merge_commit_sha?.toLowerCase() === commitSha.toLowerCase(),
  )?.number;
}

/**
 * Finds the nearest tspconfig.yaml with Java, JavaScript, .NET, Python, or Go metadata.
 * Searches up through the service folder directly below specification, falling back
 * to the first tspconfig.yaml when no SDK project is configured (e.g. private preview).
 * @param relativeFilePath Relative path to a file within specification directory
 * @param workspace Absolute path to workspace root
 * @returns Relative path to TypeSpec project directory, or null if not found
 */
export async function findTspConfigDir(
  relativeFilePath: string,
  workspace: string,
  metadataCache: TypeSpecMetadataCache = new Map(),
  directoryCache: TypeSpecDirectoryCache = new Map(),
): Promise<string | null> {
  let dir = posix.dirname(relativeFilePath);
  const visited: { directory: string; hasConfig: boolean }[] = [];
  let result: TypeSpecDirectoryResult = { sdkProjectPath: null, fallbackProjectPath: null };

  while (dir.startsWith("specification/")) {
    const cached = directoryCache.get(dir);
    if (cached) {
      result = cached;
      break;
    }

    const tspConfigAbsolute = join(workspace, dir, "tspconfig.yaml");
    const hasConfig = existsSync(tspConfigAbsolute);
    visited.push({ directory: dir, hasConfig });
    if (
      hasConfig &&
      (existsSync(join(workspace, dir, "main.tsp")) ||
        existsSync(join(workspace, dir, "client.tsp")))
    ) {
      const metadata = await getCachedTypeSpecMetadata(join(workspace, dir), metadataCache);
      if (
        ["java", "javascript", "typescript", "csharp", "python", "go"].some(
          (language) => (metadata.languages[language]?.length ?? 0) > 0,
        )
      ) {
        result = { sdkProjectPath: dir, fallbackProjectPath: dir };
        break;
      }
    } else if (hasConfig) {
      console.log(
        `Skipping metadata generation for partial TypeSpec config at ${dir}: no main.tsp or client.tsp found.`,
      );
    }

    const parent = posix.dirname(dir);
    if (parent === dir) {
      break;
    }
    dir = parent;
  }

  for (const { directory, hasConfig } of visited.reverse()) {
    result = {
      sdkProjectPath: result.sdkProjectPath,
      fallbackProjectPath: hasConfig ? directory : result.fallbackProjectPath,
    };
    directoryCache.set(directory, result);
  }

  return result.sdkProjectPath ?? result.fallbackProjectPath;
}

/**
 * Extracts the API version from TypeSpec metadata. Private previews can fall back
 * to any emitter's version without requiring SDK package metadata.
 */
export function resolveTypeSpecMetadata(
  metadata: TypeSpecMetadata,
  isPrivatePreview = false,
): {
  apiVersion: string;
} {
  const apiVersions = new Set<string>();
  let hasPackage = false;

  for (const [, langConfigs] of Object.entries(metadata.languages)) {
    if (!Array.isArray(langConfigs)) {
      continue;
    }

    for (const config of langConfigs) {
      const apiVersion = config.apiVersion;
      const packageName = config.packageName;
      hasPackage ||= Boolean(packageName);

      if (!apiVersion || !packageName) {
        console.warn(
          `Skipping language config with missing apiVersion or packageName: ${JSON.stringify(config)}`,
        );
        continue;
      }

      console.log(`language config: ${JSON.stringify(config)}`);
      apiVersions.add(apiVersion);
    }
  }

  if (isPrivatePreview && apiVersions.size === 0) {
    for (const configs of Object.values(metadata.languages)) {
      for (const config of configs) {
        if (config.apiVersion) {
          return { apiVersion: config.apiVersion };
        }
      }
    }
    throw new Error(
      "No API version found in TypeSpec metadata. Configure api-version in tspconfig.yaml emitter options.",
    );
  }

  if (apiVersions.size === 0 && !hasPackage) {
    throw new Error("No valid language configurations found in TypeSpec metadata");
  }

  return { apiVersion: Array.from(apiVersions)[0] ?? "" };
}

/**
 * Gets TypeSpec project version info using TypeSpec metadata emitter.
 * Runs the metadata emitter and derives preview status from the API version suffix.
 * @param tspProjectAbsPath Absolute path to TypeSpec project
 * @param tspProjectRelPath Relative path to TypeSpec project (for logging)
 * @returns TypeSpecProjectInfo with apiVersion and isPreview, or throws error
 */
export async function getTypeSpecProjectVersionFromMetadata(
  tspProjectAbsPath: string,
  tspProjectRelPath: string,
  metadataCache: TypeSpecMetadataCache = new Map(),
  isPrivatePreview = false,
): Promise<TypeSpecProjectInfo> {
  try {
    const metadata = await getCachedTypeSpecMetadata(tspProjectAbsPath, metadataCache);
    const { apiVersion } = resolveTypeSpecMetadata(metadata, isPrivatePreview);
    const isPreview = apiVersion.endsWith("-preview");

    console.log(
      `Found TypeSpec project at ${tspProjectRelPath} with API version ${apiVersion} (${isPreview ? "preview" : "stable"})`,
    );

    return {
      tspProjectPath: tspProjectRelPath,
      apiVersion,
      isPreview,
    };
  } catch (error) {
    const errorMsg = error instanceof Error ? error.message : String(error);
    console.error(
      `Failed to extract version from TypeSpec project at ${tspProjectRelPath}: ${errorMsg}`,
    );
    throw error;
  }
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
