import { spawnSync } from "node:child_process";
import fs from "node:fs";
import path from "node:path";

/**
 * @typedef {{allowFailure?: boolean}} GitOptions
 * @typedef {{
 *   path: string,
 *   previousPath?: string,
 *   status: "added" | "removed" | "modified",
 *   origin: string
 * }} ChangeOrigin
 * @typedef {ChangeOrigin & {origins: string[]}} ChangeEntry
 */

/**
 * @param {string} repo
 * @param {string[]} args
 * @param {GitOptions} [options]
 * @returns {import("node:child_process").SpawnSyncReturns<string>}
 */
function git(repo, args, options = {}) {
  const { allowFailure = false } = options;
  const result = spawnSync("git", ["-C", repo, ...args], {
    encoding: "utf8",
    maxBuffer: 64 * 1024 * 1024,
  });
  if (result.status !== 0 && !allowFailure) {
    throw new Error(`git ${args.join(" ")} failed: ${result.stderr.trim()}`);
  }
  return result;
}

/**
 * @param {string} repo
 * @param {string} baseRef
 * @param {string} [headRef]
 * @param {string} [mergeBase]
 */
export function resolveComparison(repo, baseRef, headRef = "HEAD", mergeBase) {
  const mergeBaseCommit = mergeBase ?? git(repo, ["merge-base", headRef, baseRef]).stdout.trim();
  const headCommit = git(repo, ["rev-parse", headRef]).stdout.trim();
  const remoteUrl = git(repo, ["remote", "get-url", "origin"], {
    allowFailure: true,
  }).stdout.trim();
  return { baseRef, headRef, mergeBaseCommit, headCommit, remoteUrl };
}

/**
 * @param {string} repo
 * @param {string[]} args
 * @param {string} origin
 * @returns {ChangeOrigin[]}
 */
function nameStatus(repo, args, origin) {
  const output = git(repo, args).stdout.trim();
  if (!output) return [];
  return output.split(/\r?\n/).flatMap((line) => {
    const fields = line.split("\t");
    const code = fields[0]?.[0];
    const rawCurrentPath = fields.at(-1);
    if (!code || !rawCurrentPath) return [];
    const currentPath = rawCurrentPath.replaceAll("\\", "/");
    const previousPath = fields.length > 2 ? fields[1].replaceAll("\\", "/") : undefined;
    /** @param {string | undefined} file */
    const relevant = (file) =>
      file?.endsWith(".tsp") || path.basename(file ?? "") === "tspconfig.yaml";
    if ((code === "R" || code === "C") && previousPath) {
      const previousRelevant = relevant(previousPath);
      const currentRelevant = relevant(currentPath);
      if (!previousRelevant && !currentRelevant) return [];
      return [
        {
          path: currentPath,
          previousPath,
          status:
            code === "C" || (!previousRelevant && currentRelevant)
              ? "added"
              : previousRelevant && !currentRelevant
                ? "removed"
                : "modified",
          origin,
        },
      ];
    }
    return relevant(currentPath)
      ? [
          {
            path: currentPath,
            status: code === "A" ? "added" : code === "D" ? "removed" : "modified",
            origin,
          },
        ]
      : [];
  });
}

/**
 * @param {string} repo
 * @param {string} mergeBase
 * @param {string | string[] | undefined} scope
 * @param {{headRef?: string, includeWorkingTree?: boolean}} [options]
 * @returns {ChangeEntry[]}
 */
export function collectChanges(
  repo,
  mergeBase,
  scope,
  { headRef = "HEAD", includeWorkingTree = true } = {},
) {
  const scopes = Array.isArray(scope) ? scope : scope ? [scope] : [];
  const scoped = scopes.length ? ["--", ...scopes] : [];
  const entries = [
    ...nameStatus(
      repo,
      ["diff", "--find-renames", "--name-status", mergeBase, headRef, ...scoped],
      "committed",
    ),
    ...(includeWorkingTree
      ? [
          ...nameStatus(
            repo,
            ["diff", "--find-renames", "--cached", "--name-status", ...scoped],
            "staged",
          ),
          ...nameStatus(repo, ["diff", "--find-renames", "--name-status", ...scoped], "unstaged"),
        ]
      : []),
  ];
  /** @type {ChangeOrigin[]} */
  const untracked = includeWorkingTree
    ? git(repo, ["ls-files", "--others", "--exclude-standard", ...scoped])
        .stdout.trim()
        .split(/\r?\n/)
        .filter(Boolean)
        .map((file) => ({
          path: file.replaceAll("\\", "/"),
          status: "added",
          origin: "untracked",
        }))
    : [];
  /** @type {Map<string, ChangeEntry>} */
  const merged = new Map();
  for (const entry of [...entries, ...untracked]) {
    const current = merged.get(entry.path) ?? { ...entry, origins: [] };
    current.status = entry.status;
    if (entry.previousPath) current.previousPath = entry.previousPath;
    if (!current.origins.includes(entry.origin)) current.origins.push(entry.origin);
    merged.set(entry.path, current);
  }
  return [...merged.values()].sort((left, right) => left.path.localeCompare(right.path));
}

/**
 * @param {string} repo
 * @param {string} revision
 * @param {string} file
 * @returns {string | null}
 */
export function readRevisionFile(repo, revision, file) {
  if (revision === "working") {
    const fullPath = path.join(repo, file);
    return fs.existsSync(fullPath) ? fs.readFileSync(fullPath, "utf8") : null;
  }
  const result = git(repo, ["show", `${revision}:${file}`], { allowFailure: true });
  return result.status === 0 ? result.stdout : null;
}

/**
 * @param {string} repo
 * @param {string} mergeBase
 * @param {string} file
 * @param {string | undefined} target
 * @returns {string}
 */
export function unifiedDiff(repo, mergeBase, file, target) {
  return git(repo, [
    "diff",
    "--no-ext-diff",
    "--unified=3",
    mergeBase,
    ...(target ? [target] : []),
    "--",
    file,
  ]).stdout;
}

/**
 * @param {string} specification
 * @returns {string}
 */
export function deriveServiceRoot(specification) {
  const normalized = specification.replaceAll("\\", "/").replace(/^\.?\//, "");
  if (normalized === "specification") return normalized;
  const match = /^(specification\/[^/]+)/.exec(normalized);
  if (!match)
    throw new Error(`Specification must be under specification/<service>: ${specification}`);
  return match[1];
}

/**
 * @param {string} repo
 * @param {string} specification
 * @returns {string}
 */
export function normalizeSpecification(repo, specification) {
  const relative = path
    .relative(path.resolve(repo), path.resolve(repo, specification.replaceAll("\\", "/")))
    .replaceAll("\\", "/");
  deriveServiceRoot(relative);
  return relative;
}

/**
 * @param {string[] | undefined} sparseRoots
 * @param {string} specification
 * @returns {string[]}
 */
export function normalizeSparseRoots(sparseRoots, specification) {
  const roots = sparseRoots?.length ? sparseRoots : [deriveServiceRoot(specification)];
  const normalized = [
    ...new Set(
      roots.map((root) => {
        const portable = root.replaceAll("\\", "/");
        if (
          path.posix.isAbsolute(portable) ||
          /^[A-Za-z]:\//.test(portable) ||
          portable.split("/").includes("..")
        ) {
          throw new Error("Sparse roots must be under specification/<service>.");
        }
        return path.posix
          .normalize(portable)
          .replace(/^(?:\.\/)+/, "")
          .replace(/\/$/, "");
      }),
    ),
  ].sort();
  if (
    normalized.some(
      (root) => root !== "specification" && !/^specification\/[^/]+(?:\/.*)?$/.test(root),
    )
  ) {
    throw new Error("Sparse roots must be under specification/<service>.");
  }
  return normalized;
}

/**
 * @param {string} repo
 * @param {{path: string}[]} files
 * @param {string} serviceRoot
 * @returns {string[]}
 */
export function discoverProjects(repo, files, serviceRoot) {
  /** @type {Set<string>} */
  const projects = new Set();
  let hasSharedChange = false;
  for (const file of files) {
    let directory = path.dirname(path.join(repo, file.path));
    const boundary = path.join(repo, serviceRoot);
    let matched = false;
    while (directory.startsWith(boundary)) {
      if (fs.existsSync(path.join(directory, "tspconfig.yaml"))) {
        projects.add(path.relative(repo, directory).replaceAll("\\", "/"));
        matched = true;
        break;
      }
      if (directory === boundary) break;
      directory = path.dirname(directory);
    }
    if (!matched) hasSharedChange = true;
  }
  if (hasSharedChange) {
    /** @param {string} directory */
    const visit = (directory) => {
      if (!fs.existsSync(directory)) return;
      for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
        if (!entry.isDirectory()) continue;
        const child = path.join(directory, entry.name);
        if (fs.existsSync(path.join(child, "tspconfig.yaml"))) {
          projects.add(path.relative(repo, child).replaceAll("\\", "/"));
        } else {
          visit(child);
        }
      }
    };
    visit(path.join(repo, serviceRoot));
  }
  return [...projects].sort();
}

/**
 * @param {string} repo
 * @param {string} commit
 * @param {string | string[]} sparseRoots
 * @param {string} destination
 * @returns {string[]}
 */
export function createSparseWorktree(repo, commit, sparseRoots, destination) {
  if (fs.existsSync(destination)) {
    throw new Error(`Worktree destination already exists: ${destination}`);
  }
  const roots = Array.isArray(sparseRoots) ? sparseRoots : [sparseRoots];
  fs.mkdirSync(path.dirname(destination), { recursive: true });
  git(repo, ["worktree", "add", "--detach", "--no-checkout", destination, commit]);
  git(destination, ["sparse-checkout", "init", "--cone"]);
  git(destination, ["sparse-checkout", "set", ...roots]);
  git(destination, ["checkout", "--detach", commit]);
  const actualRoots = git(destination, ["sparse-checkout", "list"])
    .stdout.trim()
    .split(/\r?\n/)
    .filter(Boolean)
    .map((item) => item.replaceAll("\\", "/"))
    .sort();
  if (JSON.stringify(actualRoots) !== JSON.stringify([...roots].sort())) {
    throw new Error(`Sparse checkout verification failed for ${destination}.`);
  }
  return actualRoots;
}

/**
 * @param {string} repo
 * @param {string} destination
 */
export function removeWorktree(repo, destination) {
  if (fs.existsSync(destination)) {
    git(repo, ["worktree", "remove", "--force", destination], { allowFailure: true });
  }
}
