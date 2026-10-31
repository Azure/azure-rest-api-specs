import { execFileSync } from "node:child_process";
import fs from "node:fs";
import path from "node:path";

type ReviewInputEntry = {
  packageName: string;
  packageRootPath: string;
  changedFiles: string[];
  sdkBaseCommitSha: string;
  reviewInputPath: string;
};

type ReviewManifest = {
  prNumber: string;
  headSha: string;
  language: string;
  apiViewRequestData: ReviewInputEntry[];
};

type CanonicalSkill = {
  skillRevision: string;
  skillPath: string;
};

const SDK_REPOSITORY_URL =
  process.env.SDK_REVIEW_REPOSITORY_URL ?? "https://github.com/Azure/azure-sdk-for-net.git";
const MANIFEST_FILE_NAME = "spec-gen-sdk-artifact.json";
const SHA_PATTERN = /^[0-9a-f]{40}$/i;
const SAFE_PATH_PATTERN = /^(?![A-Za-z]:)(?!\/)(?!.*\\)(?!.*(?:^|\/)\.{1,2}(?:\/|$)).+$/;

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function containsControlCharacter(value: string): boolean {
  return [...value].some((character) => {
    const codePoint = character.codePointAt(0) ?? 0;
    return codePoint <= 0x1f || codePoint === 0x7f;
  });
}

/**
 * Runs Git without inheriting interactive input and returns trimmed stdout.
 *
 * @param workingDirectory Repository or directory in which Git should run.
 * @param args Git arguments excluding the executable name.
 */
function runGit(workingDirectory: string, args: string[]): string {
  return execFileSync("git", args, {
    cwd: workingDirectory,
    encoding: "utf8",
    stdio: ["ignore", "pipe", "pipe"],
  }).trim();
}

/**
 * Validates an artifact or repository path before it is resolved on disk.
 *
 * @throws When the value is absolute, contains traversal, backslashes, or
 * control characters.
 */
function requireSafeRelativePath(value: unknown, fieldName: string): string {
  if (
    typeof value !== "string" ||
    !SAFE_PATH_PATTERN.test(value) ||
    containsControlCharacter(value)
  ) {
    throw new Error(`Invalid ${fieldName} '${String(value)}'`);
  }
  return value;
}

/**
 * Resolves a validated relative path and verifies the result remains under the
 * trusted root.
 */
function resolveWithin(root: string, relativePath: string, fieldName: string): string {
  const resolvedRoot = path.resolve(root);
  const resolvedPath = path.resolve(resolvedRoot, ...relativePath.split("/"));
  if (resolvedPath !== resolvedRoot && !resolvedPath.startsWith(`${resolvedRoot}${path.sep}`)) {
    throw new Error(`${fieldName} '${relativePath}' resolves outside '${resolvedRoot}'`);
  }
  return resolvedPath;
}

function parseNullSeparatedPaths(value: string): string[] {
  return value
    .split("\0")
    .filter(Boolean)
    .map((filePath) => filePath.replaceAll("\\", "/"));
}

function parseReviewInputEntry(value: unknown, index: number): ReviewInputEntry {
  if (!isRecord(value)) {
    throw new Error(`SDK review input entry #${index + 1} must be an object`);
  }
  const packageName = value.packageName;
  const sdkBaseCommitSha = value.sdkBaseCommitSha;
  if (typeof packageName !== "string" || !packageName) {
    throw new Error(`SDK review input entry #${index + 1} has an invalid packageName`);
  }
  if (typeof sdkBaseCommitSha !== "string" || !SHA_PATTERN.test(sdkBaseCommitSha)) {
    throw new Error(`Invalid sdkBaseCommitSha for '${packageName}'`);
  }
  if (
    !Array.isArray(value.changedFiles) ||
    !value.changedFiles.every((filePath): filePath is string => typeof filePath === "string")
  ) {
    throw new Error(`Invalid changedFiles for '${packageName}'`);
  }

  return {
    packageName,
    sdkBaseCommitSha,
    packageRootPath: requireSafeRelativePath(value.packageRootPath, "packageRootPath"),
    reviewInputPath: requireSafeRelativePath(value.reviewInputPath, "reviewInputPath"),
    changedFiles: value.changedFiles.map((filePath) =>
      requireSafeRelativePath(filePath, "changedFiles"),
    ),
  };
}

/**
 * Parses the validated handoff manifest into the subset required to rebuild
 * SDK workspaces. The GitHub handoff already performs the full shared-schema
 * validation; this boundary validates every field used for filesystem access.
 */
function parseReviewManifest(value: unknown): ReviewManifest {
  if (
    !isRecord(value) ||
    typeof value.prNumber !== "string" ||
    typeof value.headSha !== "string" ||
    typeof value.language !== "string" ||
    !Array.isArray(value.apiViewRequestData) ||
    value.apiViewRequestData.length === 0
  ) {
    throw new Error("SDK review input manifest is missing required fields");
  }

  return {
    prNumber: value.prNumber,
    headSha: value.headSha,
    language: value.language,
    apiViewRequestData: value.apiViewRequestData.map(parseReviewInputEntry),
  };
}

/**
 * Creates a detached, shallow checkout for one exact SDK baseline commit.
 */
function cloneCommit(destination: string, commitSha: string): void {
  fs.mkdirSync(destination, { recursive: true });
  runGit(destination, ["init"]);
  runGit(destination, ["remote", "add", "origin", SDK_REPOSITORY_URL]);
  runGit(destination, ["fetch", "--depth=1", "origin", commitSha]);
  runGit(destination, ["checkout", "--detach", "FETCH_HEAD"]);
  runGit(destination, ["config", "core.fileMode", "false"]);
}

/**
 * Resolves the current canonical skill revision, sparsely checks out only the
 * skill directory, and returns the exact revision and SKILL.md path.
 */
function cloneCanonicalSkill(destination: string): CanonicalSkill {
  const mainReference = runGit(process.cwd(), ["ls-remote", SDK_REPOSITORY_URL, "refs/heads/main"]);
  const skillRevision = mainReference.split(/\s+/)[0];
  if (!SHA_PATTERN.test(skillRevision)) {
    throw new Error(`Unable to resolve canonical .NET skill revision from '${mainReference}'`);
  }

  fs.mkdirSync(destination, { recursive: true });
  runGit(destination, ["init"]);
  runGit(destination, ["remote", "add", "origin", SDK_REPOSITORY_URL]);
  runGit(destination, ["config", "core.sparseCheckout", "true"]);
  fs.writeFileSync(
    path.join(destination, ".git", "info", "sparse-checkout"),
    ".github/skills/code-review/\n",
    "utf8",
  );
  runGit(destination, ["fetch", "--depth=1", "origin", skillRevision]);
  runGit(destination, ["checkout", "--detach", "FETCH_HEAD"]);

  const skillPath = path.join(destination, ".github", "skills", "code-review", "SKILL.md");
  if (!fs.existsSync(skillPath)) {
    throw new Error(`Canonical .NET code-review skill is missing at ${skillRevision}`);
  }
  return { skillRevision, skillPath };
}

/**
 * Returns tracked and untracked package changes in normalized repository paths.
 */
function collectWorkspaceChanges(workspace: string, packageRoots: string[]): string[] {
  const pathArguments = ["--", ...packageRoots];
  const tracked = parseNullSeparatedPaths(
    execFileSync("git", ["diff", "--name-only", "-z", "HEAD", ...pathArguments], {
      cwd: workspace,
      encoding: "utf8",
    }),
  );
  const untracked = parseNullSeparatedPaths(
    execFileSync("git", ["ls-files", "--others", "--exclude-standard", "-z", ...pathArguments], {
      cwd: workspace,
      encoding: "utf8",
    }),
  );
  return [...new Set([...tracked, ...untracked])].sort();
}

const inputRoot = path.resolve(process.env.SDK_REVIEW_INPUT_ROOT ?? "");
const outputRoot = path.resolve(process.env.SDK_REVIEW_WORKSPACE_ROOT ?? "");
if (!process.env.SDK_REVIEW_INPUT_ROOT || !process.env.SDK_REVIEW_WORKSPACE_ROOT) {
  throw new Error("SDK_REVIEW_INPUT_ROOT and SDK_REVIEW_WORKSPACE_ROOT are required");
}

const manifestPath = path.join(inputRoot, MANIFEST_FILE_NAME);
const parsedManifest: unknown = JSON.parse(fs.readFileSync(manifestPath, "utf8"));
const manifest = parseReviewManifest(parsedManifest);

fs.rmSync(outputRoot, { recursive: true, force: true });
fs.mkdirSync(outputRoot, { recursive: true });

const entriesByBaseline = new Map<string, ReviewInputEntry[]>();
for (const entry of manifest.apiViewRequestData) {
  const entries = entriesByBaseline.get(entry.sdkBaseCommitSha) ?? [];
  entries.push(entry);
  entriesByBaseline.set(entry.sdkBaseCommitSha, entries);
}

const workspaces = [];
let groupIndex = 0;
for (const [baselineCommitSha, entries] of entriesByBaseline) {
  groupIndex += 1;
  const workspace = path.join(outputRoot, `baseline-${groupIndex}`);
  cloneCommit(workspace, baselineCommitSha);

  for (const entry of entries) {
    const sourceSnapshot = resolveWithin(inputRoot, entry.reviewInputPath, "reviewInputPath");
    if (!fs.statSync(sourceSnapshot).isDirectory()) {
      throw new Error(`Missing source snapshot '${entry.reviewInputPath}'`);
    }
    const packageRoot = resolveWithin(workspace, entry.packageRootPath, "packageRootPath");
    fs.rmSync(packageRoot, { recursive: true, force: true });
    fs.mkdirSync(path.dirname(packageRoot), { recursive: true });
    fs.cpSync(sourceSnapshot, packageRoot, { recursive: true, force: true });
  }

  const expectedChangedFiles = [...new Set(entries.flatMap((entry) => entry.changedFiles))].sort();
  const actualChangedFiles = collectWorkspaceChanges(
    workspace,
    entries.map((entry) => entry.packageRootPath),
  );
  if (JSON.stringify(actualChangedFiles) !== JSON.stringify(expectedChangedFiles)) {
    throw new Error(
      `Reconstructed diff for ${baselineCommitSha} does not match declared changedFiles.\nExpected: ${JSON.stringify(expectedChangedFiles)}\nActual: ${JSON.stringify(actualChangedFiles)}`,
    );
  }

  workspaces.push({
    baselineCommitSha,
    workspace,
    packages: entries.map((entry) => ({
      packageName: entry.packageName,
      packageRootPath: entry.packageRootPath,
      changedFiles: entry.changedFiles,
    })),
  });
}

const canonicalSkill = cloneCanonicalSkill(path.join(outputRoot, "canonical-skill"));
if (process.env.SDK_REVIEW_SKILL_INSTALL_ROOT) {
  const installedSkillRoot = path.resolve(process.env.SDK_REVIEW_SKILL_INSTALL_ROOT);
  fs.rmSync(installedSkillRoot, { recursive: true, force: true });
  fs.mkdirSync(path.dirname(installedSkillRoot), { recursive: true });
  fs.cpSync(path.dirname(canonicalSkill.skillPath), installedSkillRoot, {
    recursive: true,
    force: true,
  });
  canonicalSkill.skillPath = path.join(installedSkillRoot, "SKILL.md");
}

const context = {
  schemaVersion: 1,
  source: {
    specPrNumber: Number.parseInt(manifest.prNumber, 10),
    specHeadSha: manifest.headSha,
    language: manifest.language,
  },
  canonicalSkill,
  workspaces,
};
const contextPath = path.join(outputRoot, "sdk-review-context.json");
fs.writeFileSync(contextPath, `${JSON.stringify(context, undefined, 2)}\n`, "utf8");
console.log(`Prepared ${workspaces.length} SDK review workspace(s) at '${outputRoot}'`);
console.log(`Canonical skill revision: ${canonicalSkill.skillRevision}`);
