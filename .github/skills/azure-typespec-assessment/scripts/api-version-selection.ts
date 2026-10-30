import fs from "node:fs";
import path from "node:path";

type ApiVersionSet = {
  versioned: boolean;
  versions: string[];
};

const identifier = String.raw`[A-Za-z_]\w*`;
const qualifiedIdentifier = String.raw`${identifier}(?:\s*\.\s*${identifier})*`;

function stripComments(contents: string): string {
  return contents.replace(/\/\*[\s\S]*?\*\/|\/\/[^\r\n]*/g, (comment) =>
    comment.replace(/[^\r\n]/g, " "),
  );
}

function fileNamespace(contents: string): string | undefined {
  const match = new RegExp(String.raw`\bnamespace\s+(${qualifiedIdentifier})\s*;`).exec(contents);
  return match?.[1].replace(/\s+/g, "");
}

function tspFiles(root: string): string[] {
  const files: string[] = [];

  const visit = (directory: string) => {
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

export function extractApiVersions(contents: string[]): ApiVersionSet {
  const versions: Set<string> = new Set();
  const versionEnums = new Set<string>();

  for (const content of contents) {
    const source = stripComments(content);
    for (const match of source.matchAll(
      new RegExp(String.raw`@versioned\s*\(\s*(${qualifiedIdentifier})\s*\)`, "g"),
    )) {
      versionEnums.add(match[1].replace(/\s+/g, ""));
    }
  }

  for (const content of contents) {
    const source = stripComments(content);
    const namespace = fileNamespace(source);
    for (const match of source.matchAll(
      new RegExp(String.raw`\benum\s+(${identifier})\s*\{([\s\S]*?)\}`, "g"),
    )) {
      const enumName = match[1];
      const qualifiedName = namespace ? `${namespace}.${enumName}` : enumName;
      const referenced = [...versionEnums].some((reference) =>
        reference.includes(".") ? reference === qualifiedName : reference === enumName,
      );
      if (!referenced) continue;

      const members = match[2];
      for (const member of members.matchAll(
        /\b[A-Za-z_]\w*\s*:\s*"([^"]+)"|`([^`]+)`(?:\s*:\s*"([^"]+)")?(?=\s*(?:,|$))/g,
      )) {
        versions.add(member[1] ?? member[3] ?? member[2]);
      }
    }
  }
  return {
    versioned: versionEnums.size > 0,
    versions: [...versions].sort(compareApiVersions),
  };
}

export function compareApiVersions(left: string, right: string): number {
  return left.localeCompare(right, "en", { numeric: true, sensitivity: "base" });
}

function latest(versions: string[]): string | undefined {
  return [...versions].sort(compareApiVersions).at(-1);
}

function isPreview(version: string): boolean {
  return /preview/i.test(version);
}

export function selectApiVersionPair({
  base,
  current,
  baseCommit,
  headCommit,
}: {
  base: ApiVersionSet;
  current: ApiVersionSet;
  baseCommit?: string;
  headCommit?: string;
}) {
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

export function resolveProjectApiVersions({
  baseWorktree,
  currentWorktree,
  project,
  baseCommit,
  headCommit,
}: {
  baseWorktree: string;
  currentWorktree: string;
  project: string;
  baseCommit: string;
  headCommit: string;
}) {
  const discover = (worktree: string) => {
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
