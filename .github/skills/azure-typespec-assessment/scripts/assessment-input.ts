import { spawnSync } from "node:child_process";
import fs from "node:fs";
import path from "node:path";
import { isRecord } from "./cli.ts";
import { normalizeSparseRoots, normalizeSpecification } from "./git-evidence.ts";

type AssessmentInputDependencies = {
  getPullRequest?: (repo: string, value: string | number) => PullRequestInput;
};
type AssessmentInputOptions = {
  repo?: string;
  repo_path?: string;
  pr?: string | number;
  base?: string;
  head?: string;
  sparse_root?: string[];
  sparseRoots?: string[];
  specification?: string;
  [key: string]: unknown;
};
type PullRequestInput = GitHubRepository & {
  number: number;
  url: string;
  cloneUrl: string;
  baseRef: string;
  baseCommit: string;
  headCommit: string;
};
type GitHubRepository = {
  owner: string;
  repository: string;
};
type RunOptions = {
  cwd?: string;
  allowFailure?: boolean;
};

function run(
  command: string,
  args: string[],
  options: RunOptions = {},
): import("node:child_process").SpawnSyncReturns<string> {
  const result = spawnSync(command, args, {
    cwd: options.cwd,
    encoding: "utf8",
    maxBuffer: 64 * 1024 * 1024,
  });
  if (result.status !== 0 && !options.allowFailure) {
    throw new Error(`${command} ${args.join(" ")} failed: ${result.stderr.trim()}`);
  }
  return result;
}

function git(repo: string, args: string[], options: RunOptions = {}) {
  return run("git", ["-C", repo, ...args], options);
}

function elapsed(started: number): number {
  return Math.round(performance.now() - started);
}

export function parsePullRequest(
  value: string | number | undefined,
  remoteUrl: string,
): GitHubRepository & {
  number: number;
} {
  const input = String(value ?? "").trim();
  let match = /^https:\/\/github\.com\/([^/]+)\/([^/]+)\/pull\/(\d+)(?:\/.*)?$/i.exec(input);
  if (match) {
    return { owner: match[1], repository: match[2], number: Number(match[3]) };
  }
  match = /^([^/\s]+)\/([^#\s]+)#(\d+)$/.exec(input);
  if (match) {
    return { owner: match[1], repository: match[2], number: Number(match[3]) };
  }
  if (/^\d+$/.test(input)) {
    const repository = parseGitHubRepository(remoteUrl);
    if (!repository) {
      throw new Error(`Cannot resolve PR ${input}: origin is not a GitHub repository.`);
    }
    return { ...repository, number: Number(input) };
  }
  throw new Error(
    `Invalid --pr value: ${value}. Use a GitHub PR URL, owner/repo#number, or number.`,
  );
}

export function parseGitHubRepository(remoteUrl: string | undefined): GitHubRepository | undefined {
  const match = /github\.com[/:]([^/]+)\/([^/]+)$/i.exec(remoteUrl ?? "");
  return match ? { owner: match[1], repository: match[2].replace(/\.git$/i, "") } : undefined;
}

export function validateAssessmentInput<T extends AssessmentInputOptions>(
  options: T,
): T & { repo: string } {
  const hasPr = options.pr !== undefined;
  const hasHead = options.head !== undefined;
  const resolvedInvocation = isRecord(options.invocation);
  if (!resolvedInvocation && hasPr && (hasHead || options.base !== undefined)) {
    throw new Error("--pr cannot be combined with --base or --head.");
  }
  if (hasHead && options.base === undefined) {
    throw new Error("--head requires --base.");
  }
  for (const [name, value] of [
    ["repo-path", options.repo_path],
    ["repo", options.repo],
    ["base", options.base],
    ["head", options.head],
  ]) {
    if (value !== undefined && !value.trim()) {
      throw new Error(`--${name} requires a nonempty value.`);
    }
  }
  if (
    options.repo_path !== undefined &&
    options.repo !== undefined &&
    path.resolve(options.repo_path) !== path.resolve(options.repo)
  ) {
    throw new Error(
      "--repo-path and --repo refer to different directories. Use only --repo-path <local-directory>.",
    );
  }
  if (
    options.model_input_budget_bytes !== undefined &&
    (!Number.isInteger(Number(options.model_input_budget_bytes)) ||
      Number(options.model_input_budget_bytes) <= 0)
  ) {
    throw new Error("--model-input-budget-bytes requires a positive integer.");
  }

  const supplied = options.repo_path ?? options.repo;
  const directory = path.resolve(supplied ?? process.cwd());
  const label =
    supplied === undefined
      ? "current directory"
      : `${options.repo_path !== undefined ? "--repo-path" : "--repo"} ${JSON.stringify(supplied)}`;
  const guidance =
    'Use --repo-path "<local-checkout-directory>" (--repo is a legacy alias), or omit it inside a Git worktree. ' +
    "Pass GitHub PR URLs with --pr; owner/repo is not cloned automatically.";
  if (!fs.existsSync(directory)) {
    throw new Error(`Invalid ${label}: local directory does not exist: ${directory}. ${guidance}`);
  }
  if (!fs.statSync(directory).isDirectory()) {
    throw new Error(`Invalid ${label}: not a directory: ${directory}. ${guidance}`);
  }
  const worktree = git(directory, ["rev-parse", "--show-cdup", "--show-toplevel"], {
    allowFailure: true,
  });
  if (worktree.status !== 0) {
    const detail = worktree.error?.message ?? worktree.stderr.trim();
    throw new Error(
      `Invalid ${label}: not a Git worktree: ${directory}. ${guidance}${detail ? `\n${detail}` : ""}`,
    );
  }
  const [relativeRoot, absoluteRoot] = worktree.stdout.split(/\r?\n/);
  // Preserve the caller's Windows short-path spelling when it identifies the same root.
  const candidateRoot = path.resolve(directory, relativeRoot);
  const repo =
    fs.realpathSync.native(candidateRoot) === fs.realpathSync.native(absoluteRoot)
      ? candidateRoot
      : path.resolve(absoluteRoot);
  if (!hasPr && !hasHead && !options.specification) {
    throw new Error("--specification is required when no TypeSpec scope can be derived.");
  }
  const specification =
    options.specification === undefined
      ? "specification"
      : normalizeSpecification(repo, options.specification);
  normalizeSparseRoots(options.sparse_root ?? options.sparseRoots, specification);
  if (hasPr && !resolvedInvocation) {
    const remoteUrl = /^\d+$/.test(String(options.pr).trim())
      ? git(repo, ["remote", "get-url", "origin"], { allowFailure: true }).stdout.trim()
      : "";
    parsePullRequest(options.pr, remoteUrl);
  }
  return {
    ...options,
    repo,
    ...(options.repo_path !== undefined ? { repo_path: repo } : {}),
  };
}

function resolveCommit(repo: string, ref: string): string | undefined {
  const result = git(repo, ["rev-parse", "--verify", `${ref}^{commit}`], {
    allowFailure: true,
  });
  return result.status === 0 ? result.stdout.trim() : undefined;
}

function fetch(repo: string, remote: string, refspecs: string[], extra: string[] = []) {
  git(repo, [
    "fetch",
    "--filter=blob:none",
    "--no-tags",
    "--no-write-fetch-head",
    ...extra,
    remote,
    ...refspecs,
  ]);
}

function ensureMergeBase(
  repo: string,
  base: string,
  head: string,
  deepen: (depth: number) => void,
): string {
  for (const depth of [0, 64, 256, 1024]) {
    const result = git(repo, ["merge-base", head, base], {
      allowFailure: true,
    });
    if (result.status === 0) return result.stdout.trim();
    if (depth === 0) continue;
    deepen(depth);
  }
  const result = git(repo, ["merge-base", head, base], {
    allowFailure: true,
  });
  if (result.status !== 0) {
    throw new Error(`Unable to resolve a merge base between ${base} and ${head}.`);
  }
  return result.stdout.trim();
}

function changedTypeSpecPaths(repo: string, mergeBase: string, head: string): string[] {
  const output = git(repo, [
    "diff",
    "--name-status",
    "--find-renames",
    mergeBase,
    head,
    "--",
    "specification",
  ]).stdout.trim();
  return output
    .split(/\r?\n/)
    .filter(Boolean)
    .flatMap((line) => {
      const [status, ...files] = line.split("\t");
      return status.startsWith("R") || status.startsWith("C")
        ? files.slice(0, 2)
        : files.slice(0, 1);
    })
    .map((file) => file.replaceAll("\\", "/"))
    .filter((file) => file.endsWith(".tsp") || path.posix.basename(file) === "tspconfig.yaml");
}

export function deriveSparseRoots(files: string[]): string[] {
  return [
    ...new Set(
      files.flatMap((file) => {
        const match = /^(specification\/[^/]+)/.exec(file);
        return match ? [match[1]] : [];
      }),
    ),
  ].sort();
}

export function commonSpecificationRoot(roots: string[]): string {
  if (!roots.length) return "specification";
  const parts = roots.map((root) => root.split("/"));
  const common = parts[0].filter((part, index) =>
    parts.every((candidate) => candidate[index] === part),
  );
  return common.join("/") || "specification";
}

function getPullRequest(repo: string, value: string | number): PullRequestInput {
  const remoteUrl = git(repo, ["remote", "get-url", "origin"], {
    allowFailure: true,
  }).stdout.trim();
  const identity = parsePullRequest(value, remoteUrl);
  const response = run("gh", [
    "api",
    `repos/${identity.owner}/${identity.repository}/pulls/${identity.number}`,
  ]);
  const data = JSON.parse(response.stdout) as unknown;
  if (
    !isRecord(data) ||
    typeof data.html_url !== "string" ||
    !isRecord(data.base) ||
    !isRecord(data.base.repo) ||
    typeof data.base.repo.clone_url !== "string" ||
    typeof data.base.ref !== "string" ||
    typeof data.base.sha !== "string" ||
    !isRecord(data.head) ||
    typeof data.head.sha !== "string"
  ) {
    throw new Error(`GitHub returned incomplete metadata for PR ${identity.number}.`);
  }
  return {
    ...identity,
    url: data.html_url,
    cloneUrl: data.base?.repo?.clone_url,
    baseRef: data.base?.ref,
    baseCommit: data.base?.sha,
    headCommit: data.head?.sha,
  };
}

function ensureExplicitCommit(repo: string, ref: string, label: string): string {
  const existing = resolveCommit(repo, ref);
  if (existing) return existing;
  const destination = `refs/azsdk-assessment/explicit/${label}`;
  fetch(repo, "origin", [`+${ref}:${destination}`], ["--depth=1"]);
  const fetched = resolveCommit(repo, destination);
  if (!fetched) throw new Error(`Fetched ref did not resolve to a commit: ${ref}`);
  return fetched;
}

export function resolveAssessmentInput(
  options: AssessmentInputOptions,
  dependencies: AssessmentInputDependencies = {},
) {
  const started = performance.now();
  const { repo } = validateAssessmentInput(options);

  const timings: Record<string, number> = {
    metadataMs: 0,
    fetchMs: 0,
    scopeDiscoveryMs: 0,
  };
  const hasPr = options.pr !== undefined;
  const hasHead = options.head !== undefined;

  let base: string | undefined = options.base;

  let head: string | undefined = options.head;

  let pullRequest: PullRequestInput | undefined;
  if (hasPr) {
    const pr = options.pr;
    if (pr === undefined) throw new Error("--pr requires a value.");
    const metadataStarted = performance.now();
    pullRequest = (dependencies.getPullRequest ?? getPullRequest)(repo, pr);
    timings.metadataMs = elapsed(metadataStarted);
    if (!pullRequest.baseCommit || !pullRequest.headCommit || !pullRequest.cloneUrl) {
      throw new Error(`PR metadata is incomplete for ${options.pr}.`);
    }
    base = pullRequest.baseCommit;
    head = pullRequest.headCommit;
    const fetchStarted = performance.now();
    const refRoot = `refs/azsdk-assessment/pr-${pullRequest.number}`;
    const refspecs = [];
    if (!resolveCommit(repo, base)) {
      refspecs.push(`+${base}:${refRoot}/base`);
    }
    if (!resolveCommit(repo, head)) {
      refspecs.push(`+refs/pull/${pullRequest.number}/head:${refRoot}/head`);
    }
    if (refspecs.length) {
      fetch(repo, pullRequest.cloneUrl, refspecs, ["--depth=1"]);
    }
    timings.fetchMs += elapsed(fetchStarted);
    if (!resolveCommit(repo, base) || !resolveCommit(repo, head)) {
      throw new Error(`Required commits for ${pullRequest.url} are unavailable.`);
    }
  } else if (hasHead) {
    const fetchStarted = performance.now();
    base = ensureExplicitCommit(repo, base as string, "base");
    head = ensureExplicitCommit(repo, head as string, "head");
    timings.fetchMs = elapsed(fetchStarted);
  }

  let sparseRoots: string[] | undefined = options.sparse_root ?? options.sparseRoots;
  let specification = options.specification;

  let mergeBaseCommit: string | undefined;
  if (head) {
    if (!base) throw new Error("--head requires --base.");
    const remote = pullRequest?.cloneUrl ?? "origin";
    const refspecs = pullRequest
      ? [
          `+${base}:refs/azsdk-assessment/pr-${pullRequest.number}/base`,
          `+${head}:refs/azsdk-assessment/pr-${pullRequest.number}/head`,
        ]
      : [base, head];
    mergeBaseCommit = ensureMergeBase(repo, base, head, (depth) => {
      const deepenStarted = performance.now();
      fetch(repo, remote, refspecs, [`--deepen=${depth}`]);
      timings.fetchMs += elapsed(deepenStarted);
    });
    const scopeStarted = performance.now();
    const changedFiles = changedTypeSpecPaths(repo, mergeBaseCommit, head);
    if (!sparseRoots?.length) sparseRoots = deriveSparseRoots(changedFiles);
    if (!specification) specification = commonSpecificationRoot(sparseRoots);
    timings.scopeDiscoveryMs = elapsed(scopeStarted);
  }

  timings.setupExcludingFetchMs = elapsed(started) - timings.fetchMs;
  return {
    ...options,
    repo,
    base: base ?? "origin/main",
    ...(head ? { head } : {}),
    specification,
    ...(sparseRoots?.length ? { sparseRoots } : {}),
    mergeBaseCommit,
    includeWorkingTree: !head,
    ...(pullRequest ? { pullRequest } : {}),
    invocation: {
      mode: hasPr ? "pull-request" : hasHead ? "commits" : "local",
      ...(pullRequest ? { pullRequest } : {}),
      timings,
    },
  };
}
