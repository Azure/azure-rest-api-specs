import fs from "node:fs";
import path from "node:path";

/**
 * @typedef {{versioned: boolean, versions: string[]}} ApiVersionSet
 */

/**
 * @param {string} root
 * @returns {string[]}
 */
function tspFiles(root) {
  /** @type {string[]} */
  const files = [];
  /** @param {string} directory */
  const visit = (directory) => {
    for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
      if (entry.name === "node_modules") continue;
      const file = path.join(directory, entry.name);
      if (entry.isDirectory()) visit(file);
      else if (entry.name.endsWith(".tsp")) files.push(file);
    }
  };
  visit(root);
  return files.sort();
}

/**
 * @param {string[]} contents
 * @returns {ApiVersionSet}
 */
export function extractApiVersions(contents) {
  /** @type {Set<string>} */
  const versions = new Set();
  let versioned = false;
  for (const content of contents) {
    if (/@versioned\s*\(/.test(content)) versioned = true;
    for (const match of content.matchAll(/\benum\s+Versions\s*\{([\s\S]*?)\}/g)) {
      for (const member of match[1].matchAll(/\b[A-Za-z_]\w*\s*:\s*"([^"]+)"/g)) {
        versions.add(member[1]);
      }
    }
  }
  return { versioned, versions: [...versions].sort(compareApiVersions) };
}

/**
 * @param {string} left
 * @param {string} right
 * @returns {number}
 */
export function compareApiVersions(left, right) {
  return left.localeCompare(right, "en", { numeric: true, sensitivity: "base" });
}

/**
 * @param {string[]} versions
 * @returns {string | undefined}
 */
function latest(versions) {
  return [...versions].sort(compareApiVersions).at(-1);
}

/**
 * @param {string} version
 * @returns {boolean}
 */
function isPreview(version) {
  return /preview/i.test(version);
}

/**
 * @param {{
 *   base: ApiVersionSet,
 *   current: ApiVersionSet,
 *   baseCommit?: string,
 *   headCommit?: string
 * }} options
 */
export function selectApiVersionPair({ base, current, baseCommit, headCommit }) {
  if (!base.versioned && !current.versioned) {
    return {
      mode: "unversioned",
      baseline: {
        sourceRevision: "base",
        commit: baseCommit,
        apiVersion: undefined,
        reason: "unversioned",
      },
      target: {
        sourceRevision: "current",
        commit: headCommit,
        apiVersion: undefined,
        reason: "unversioned",
      },
      base: undefined,
      current: undefined,
      baseReason: "unversioned",
      currentReason: "unversioned",
      addedCurrentVersions: [],
      available: { base: base.versions, current: current.versions },
    };
  }
  if (!base.versioned && current.versioned) {
    if (!current.versions.length) {
      throw new Error("Unable to resolve API versions from the versioned TypeSpec project.");
    }
    const currentVersion = latest(current.versions);
    return {
      mode: "existing-api-version",
      versioningChange: "unversioned-to-versioned",
      baseline: {
        sourceRevision: "base",
        commit: baseCommit,
        apiVersion: undefined,
        reason: "unversioned",
      },
      target: {
        sourceRevision: "current",
        commit: headCommit,
        apiVersion: currentVersion,
        reason: "newest-added-version",
      },
      base: undefined,
      current: currentVersion,
      baseReason: "unversioned",
      currentReason: "new-version-added",
      addedCurrentVersions: current.versions,
      available: { base: base.versions, current: current.versions },
    };
  }
  if (base.versioned && !current.versioned) {
    if (!base.versions.length) {
      throw new Error("Unable to resolve API versions from the versioned TypeSpec project.");
    }
    const baseVersion = latest(base.versions);
    return {
      mode: "existing-api-version",
      versioningChange: "versioned-to-unversioned",
      baseline: {
        sourceRevision: "base",
        commit: baseCommit,
        apiVersion: baseVersion,
        reason: "affected-existing-version",
      },
      target: {
        sourceRevision: "current",
        commit: headCommit,
        apiVersion: undefined,
        reason: "unversioned",
      },
      base: baseVersion,
      current: undefined,
      baseReason: "affected-existing-version",
      currentReason: "unversioned",
      addedCurrentVersions: [],
      available: { base: base.versions, current: current.versions },
    };
  }
  if (!base.versions.length || !current.versions.length) {
    throw new Error("Unable to resolve API versions from the versioned TypeSpec project.");
  }

  const baseSet = new Set(base.versions);
  const addedCurrentVersions = current.versions.filter((version) => !baseSet.has(version));
  const currentVersion = latest(
    addedCurrentVersions.length ? addedCurrentVersions : current.versions,
  );
  if (!currentVersion) throw new Error("Unable to select the current API version.");
  const stableBaseVersions = base.versions.filter((version) => !isPreview(version));
  const useSameVersion = !addedCurrentVersions.length && baseSet.has(currentVersion);
  const baselineVersion = useSameVersion
    ? currentVersion
    : latest(stableBaseVersions.length ? stableBaseVersions : base.versions);
  const baselineReason = useSameVersion
    ? "affected-existing-version"
    : stableBaseVersions.length
      ? "previous-latest-stable"
      : "previous-latest-preview";
  const mode = addedCurrentVersions.length ? "new-api-version" : "existing-api-version";
  return {
    mode,
    baseline: {
      sourceRevision: mode === "new-api-version" ? "current" : "base",
      commit: mode === "new-api-version" ? headCommit : baseCommit,
      apiVersion: baselineVersion,
      reason: baselineReason,
    },
    target: {
      sourceRevision: "current",
      commit: headCommit,
      apiVersion: currentVersion,
      reason: mode === "new-api-version" ? "newest-added-version" : "affected-existing-version",
    },
    // Transitional aliases for readers that have not yet moved to comparison roles.
    base: baselineVersion,
    current: currentVersion,
    baseReason: baselineReason,
    currentReason: addedCurrentVersions.length ? "new-version-added" : "latest-version",
    addedCurrentVersions,
    available: { base: base.versions, current: current.versions },
  };
}

/**
 * @param {{
 *   baseWorktree: string,
 *   currentWorktree: string,
 *   project: string,
 *   baseCommit: string,
 *   headCommit: string
 * }} options
 */
export function resolveProjectApiVersions({
  baseWorktree,
  currentWorktree,
  project,
  baseCommit,
  headCommit,
}) {
  /** @param {string} worktree */
  const discover = (worktree) => {
    const root = path.join(worktree, project);
    return extractApiVersions(tspFiles(root).map((file) => fs.readFileSync(file, "utf8")));
  };
  return selectApiVersionPair({
    base: discover(baseWorktree),
    current: discover(currentWorktree),
    baseCommit,
    headCommit,
  });
}
