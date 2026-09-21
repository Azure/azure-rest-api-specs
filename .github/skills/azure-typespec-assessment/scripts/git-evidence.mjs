import fs from "node:fs";
import path from "node:path";
import { spawnSync } from "node:child_process";

function git(repo, args, options = {}) {
  const result = spawnSync("git", ["-C", repo, ...args], {
    encoding: "utf8",
    maxBuffer: 64 * 1024 * 1024,
    ...options,
  });
  if (result.status !== 0 && !options.allowFailure) {
    throw new Error(`git ${args.join(" ")} failed: ${result.stderr.trim()}`);
  }
  return result;
}

export function resolveComparison(repo, baseRef, headRef = "HEAD", mergeBase) {
  const mergeBaseCommit =
    mergeBase ?? git(repo, ["merge-base", headRef, baseRef]).stdout.trim();
  const headCommit = git(repo, ["rev-parse", headRef]).stdout.trim();
  const remoteUrl = git(repo, ["remote", "get-url", "origin"], {
    allowFailure: true,
  }).stdout.trim();
  return { baseRef, headRef, mergeBaseCommit, headCommit, remoteUrl };
}

function nameStatus(repo, args, origin) {
  const output = git(repo, args).stdout.trim();
  if (!output) return [];
  return output.split(/\r?\n/).flatMap((line) => {
    const fields = line.split("\t");
    const code = fields[0][0];
    const currentPath = fields.at(-1).replaceAll("\\", "/");
    const previousPath =
      fields.length > 2 ? fields[1].replaceAll("\\", "/") : undefined;
    const relevant = (file) =>
      file?.endsWith(".tsp") || path.basename(file ?? "") === "tspconfig.yaml";
    if ((code === "R" || code === "C") && previousPath) {
      const previousRelevant = relevant(previousPath);
      const currentRelevant = relevant(currentPath);
      if (!previousRelevant && !currentRelevant) return [];
      return [{
        path: currentPath,
        previousPath,
        status:
          code === "C" || (!previousRelevant && currentRelevant)
            ? "added"
            : previousRelevant && !currentRelevant
              ? "removed"
              : "modified",
        origin,
      }];
    }
    return relevant(currentPath)
      ? [{
          path: currentPath,
          status: code === "A" ? "added" : code === "D" ? "removed" : "modified",
          origin,
        }]
      : [];
  });
}

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
          ...nameStatus(
            repo,
            ["diff", "--find-renames", "--name-status", ...scoped],
            "unstaged",
          ),
        ]
      : []),
  ];
  const untracked = includeWorkingTree
    ? git(repo, [
        "ls-files",
        "--others",
        "--exclude-standard",
        ...scoped,
      ]).stdout
        .trim()
        .split(/\r?\n/)
        .filter(Boolean)
        .map((file) => ({
          path: file.replaceAll("\\", "/"),
          status: "added",
          origin: "untracked",
        }))
    : [];
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

export function readRevisionFile(repo, revision, file) {
  if (revision === "working") {
    const fullPath = path.join(repo, file);
    return fs.existsSync(fullPath) ? fs.readFileSync(fullPath, "utf8") : null;
  }
  const result = git(repo, ["show", `${revision}:${file}`], { allowFailure: true });
  return result.status === 0 ? result.stdout : null;
}

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

export function deriveServiceRoot(specification) {
  const normalized = specification.replaceAll("\\", "/").replace(/^\.?\//, "");
  if (normalized === "specification") return normalized;
  const match = /^(specification\/[^/]+)/.exec(normalized);
  if (!match) throw new Error(`Specification must be under specification/<service>: ${specification}`);
  return match[1];
}

export function normalizeSpecification(repo, specification) {
  const relative = path.relative(
    path.resolve(repo),
    path.resolve(repo, specification.replaceAll("\\", "/")),
  ).replaceAll("\\", "/");
  deriveServiceRoot(relative);
  return relative;
}

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
        return path.posix.normalize(portable).replace(/^(?:\.\/)+/, "").replace(/\/$/, "");
      }),
    ),
  ].sort();
  if (
    normalized.some(
      (root) =>
        root !== "specification" &&
        !/^specification\/[^/]+(?:\/.*)?$/.test(root),
    )
  ) {
    throw new Error("Sparse roots must be under specification/<service>.");
  }
  return normalized;
}

export function discoverProjects(repo, files, serviceRoot) {
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
  const actualRoots = git(destination, ["sparse-checkout", "list"]).stdout
    .trim()
    .split(/\r?\n/)
    .filter(Boolean)
    .map((item) => item.replaceAll("\\", "/"))
    .sort();
  if (JSON.stringify(actualRoots) !== JSON.stringify([...roots].sort())) {
    throw new Error(`Sparse checkout verification failed for ${destination}.`);
  }
  return actualRoots;
}

export function removeWorktree(repo, destination) {
  if (fs.existsSync(destination)) {
    git(repo, ["worktree", "remove", "--force", destination], { allowFailure: true });
  }
}
