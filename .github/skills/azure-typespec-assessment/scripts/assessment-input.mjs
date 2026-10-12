import { spawnSync } from "node:child_process";
import path from "node:path";
import { isRecord } from "./cli.mjs";

/**
 * @typedef {{cwd?: string, allowFailure?: boolean}} RunOptions
 * @typedef {{owner: string, repository: string}} GitHubRepository
 * @typedef {GitHubRepository & {
 *   number: number,
 *   url: string,
 *   cloneUrl: string,
 *   baseRef: string,
 *   baseCommit: string,
 *   headCommit: string
 * }} PullRequestInput
 * @typedef {{
 *   repo?: string,
 *   pr?: string | number,
 *   base?: string,
 *   head?: string,
 *   sparse_root?: string[],
 *   sparseRoots?: string[],
 *   specification?: string,
 *   [key: string]: unknown
 * }} AssessmentInputOptions
 * @typedef {{getPullRequest?: (repo: string, value: string | number) => PullRequestInput}} AssessmentInputDependencies
 */

/**
 * @param {string} command
 * @param {string[]} args
 * @param {RunOptions} [options]
 * @returns {import("node:child_process").SpawnSyncReturns<string>}
 */
function run(command, args, options = {}) {
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

/**
 * @param {string} repo
 * @param {string[]} args
 * @param {RunOptions} [options]
 */
function git(repo, args, options = {}) {
  return run("git", ["-C", repo, ...args], options);
}

/**
 * @param {number} started
 * @returns {number}
 */
function elapsed(started) {
  return Math.round(performance.now() - started);
}

/**
 * @param {string | number | undefined} value
 * @param {string} remoteUrl
 * @returns {GitHubRepository & {number: number}}
 */
export function parsePullRequest(value, remoteUrl) {
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

/**
 * @param {string | undefined} remoteUrl
 * @returns {GitHubRepository | undefined}
 */
export function parseGitHubRepository(remoteUrl) {
  const match = /github\.com[/:]([^/]+)\/([^/]+)$/i.exec(remoteUrl ?? "");
  return match ? { owner: match[1], repository: match[2].replace(/\.git$/i, "") } : undefined;
}

/**
 * @param {string} repo
 * @param {string} ref
 * @returns {string | undefined}
 */
function resolveCommit(repo, ref) {
  const result = git(repo, ["rev-parse", "--verify", `${ref}^{commit}`], {
    allowFailure: true,
  });
  return result.status === 0 ? result.stdout.trim() : undefined;
}

/**
 * @param {string} repo
 * @param {string} remote
 * @param {string[]} refspecs
 * @param {string[]} [extra]
 */
function fetch(repo, remote, refspecs, extra = []) {
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

/**
 * @param {string} repo
 * @param {string} base
 * @param {string} head
 * @param {(depth: number) => void} deepen
 * @returns {string}
 */
function ensureMergeBase(repo, base, head, deepen) {
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

/**
 * @param {string} repo
 * @param {string} mergeBase
 * @param {string} head
 * @returns {string[]}
 */
function changedTypeSpecPaths(repo, mergeBase, head) {
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

/**
 * @param {string[]} files
 * @returns {string[]}
 */
export function deriveSparseRoots(files) {
  return [
    ...new Set(
      files.flatMap((file) => {
        const match = /^(specification\/[^/]+)/.exec(file);
        return match ? [match[1]] : [];
      }),
    ),
  ].sort();
}

/**
 * @param {string[]} roots
 * @returns {string}
 */
export function commonSpecificationRoot(roots) {
  if (!roots.length) return "specification";
  const parts = roots.map((root) => root.split("/"));
  const common = parts[0].filter((part, index) =>
    parts.every((candidate) => candidate[index] === part),
  );
  return common.join("/") || "specification";
}

/**
 * @param {string} repo
 * @param {string | number} value
 * @returns {PullRequestInput}
 */
function getPullRequest(repo, value) {
  const remoteUrl = git(repo, ["remote", "get-url", "origin"], {
    allowFailure: true,
  }).stdout.trim();
  const identity = parsePullRequest(value, remoteUrl);
  const response = run("gh", [
    "api",
    `repos/${identity.owner}/${identity.repository}/pulls/${identity.number}`,
  ]);
  const data = /** @type {unknown} */ (JSON.parse(response.stdout));
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

/**
 * @param {string} repo
 * @param {string} ref
 * @param {string} label
 * @returns {string}
 */
function ensureExplicitCommit(repo, ref, label) {
  const existing = resolveCommit(repo, ref);
  if (existing) return existing;
  const destination = `refs/azsdk-assessment/explicit/${label}`;
  fetch(repo, "origin", [`+${ref}:${destination}`], ["--depth=1"]);
  const fetched = resolveCommit(repo, destination);
  if (!fetched) throw new Error(`Fetched ref did not resolve to a commit: ${ref}`);
  return fetched;
}

/**
 * @param {AssessmentInputOptions} options
 * @param {AssessmentInputDependencies} [dependencies]
 */
export function resolveAssessmentInput(options, dependencies = {}) {
  const started = performance.now();
  const repo = path.resolve(options.repo ?? process.cwd());
  /** @type {Record<string, number>} */
  const timings = {
    metadataMs: 0,
    fetchMs: 0,
    scopeDiscoveryMs: 0,
  };
  const hasPr = options.pr !== undefined;
  const hasHead = options.head !== undefined;
  if (hasPr && (hasHead || options.base !== undefined)) {
    throw new Error("--pr cannot be combined with --base or --head.");
  }
  if (hasHead && options.base === undefined) {
    throw new Error("--head requires --base.");
  }

  /** @type {string | undefined} */
  let base = options.base;
  /** @type {string | undefined} */
  let head = options.head;
  /** @type {PullRequestInput | undefined} */
  let pullRequest;
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
    base = ensureExplicitCommit(repo, /** @type {string} */ (base), "base");
    head = ensureExplicitCommit(repo, /** @type {string} */ (head), "head");
    timings.fetchMs = elapsed(fetchStarted);
  }

  /** @type {string[] | undefined} */
  let sparseRoots = options.sparse_root ?? options.sparseRoots;
  let specification = options.specification;
  /** @type {string | undefined} */
  let mergeBaseCommit;
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
