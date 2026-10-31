import { execFileSync } from "node:child_process";
import fs from "node:fs";
import path from "node:path";

const SDK_REPOSITORY_URL =
  process.env.SDK_REVIEW_REPOSITORY_URL ?? "https://github.com/Azure/azure-sdk-for-net.git";
const MANIFEST_FILE_NAME = "spec-gen-sdk-artifact.json";
const SHA_PATTERN = /^[0-9a-f]{40}$/i;
const SAFE_PATH_PATTERN =
  /^(?![A-Za-z]:)(?!\/)(?!.*\\)(?!.*(?:^|\/)\.{1,2}(?:\/|$))[^\u0000-\u001f\u007f]+$/;

function runGit(workingDirectory, args) {
  return execFileSync("git", args, {
    cwd: workingDirectory,
    encoding: "utf8",
    stdio: ["ignore", "pipe", "pipe"],
  }).trim();
}

function requireSafeRelativePath(value, fieldName) {
  if (typeof value !== "string" || !SAFE_PATH_PATTERN.test(value)) {
    throw new Error(`Invalid ${fieldName} '${value}'`);
  }
  return value;
}

function resolveWithin(root, relativePath, fieldName) {
  const resolvedRoot = path.resolve(root);
  const resolvedPath = path.resolve(resolvedRoot, ...relativePath.split("/"));
  if (resolvedPath !== resolvedRoot && !resolvedPath.startsWith(`${resolvedRoot}${path.sep}`)) {
    throw new Error(`${fieldName} '${relativePath}' resolves outside '${resolvedRoot}'`);
  }
  return resolvedPath;
}

function parseNullSeparatedPaths(value) {
  return value
    .split("\0")
    .filter(Boolean)
    .map((filePath) => filePath.replaceAll("\\", "/"));
}

function cloneCommit(destination, commitSha) {
  fs.mkdirSync(destination, { recursive: true });
  runGit(destination, ["init"]);
  runGit(destination, ["remote", "add", "origin", SDK_REPOSITORY_URL]);
  runGit(destination, ["fetch", "--depth=1", "origin", commitSha]);
  runGit(destination, ["checkout", "--detach", "FETCH_HEAD"]);
  runGit(destination, ["config", "core.fileMode", "false"]);
}

function cloneCanonicalSkill(destination) {
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

function collectWorkspaceChanges(workspace, packageRoots) {
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
const manifest = JSON.parse(fs.readFileSync(manifestPath, "utf8"));
if (!Array.isArray(manifest.apiViewRequestData) || manifest.apiViewRequestData.length === 0) {
  throw new Error("SDK review input manifest has no package entries");
}

fs.rmSync(outputRoot, { recursive: true, force: true });
fs.mkdirSync(outputRoot, { recursive: true });

const entriesByBaseline = new Map();
for (const entry of manifest.apiViewRequestData) {
  if (!SHA_PATTERN.test(entry.sdkBaseCommitSha ?? "")) {
    throw new Error(`Invalid sdkBaseCommitSha for '${entry.packageName}'`);
  }
  const packageRootPath = requireSafeRelativePath(entry.packageRootPath, "packageRootPath");
  const reviewInputPath = requireSafeRelativePath(entry.reviewInputPath, "reviewInputPath");
  if (!Array.isArray(entry.changedFiles)) {
    throw new Error(`Invalid changedFiles for '${entry.packageName}'`);
  }
  const normalizedEntry = {
    ...entry,
    packageRootPath,
    reviewInputPath,
    changedFiles: entry.changedFiles.map((filePath) =>
      requireSafeRelativePath(filePath, "changedFiles"),
    ),
  };
  const entries = entriesByBaseline.get(entry.sdkBaseCommitSha) ?? [];
  entries.push(normalizedEntry);
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
