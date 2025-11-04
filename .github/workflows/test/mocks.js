import { RequestError } from "@octokit/request-error";
import { vi } from "vitest";

/**
 * @typedef {import('@actions/github-script').AsyncFunctionArguments["github"]} GitHub
 * @typedef {import('@actions/github-script').AsyncFunctionArguments["context"]} Context
 * @typedef {import('@actions/github-script').AsyncFunctionArguments["core"]} Core
 */

/**
 * @returns {GitHub & ReturnType<typeof createMockGithubImpl>}
 */
export function createMockGithub() {
  return /** @type {GitHub & ReturnType<typeof createMockGithubImpl>} */ (createMockGithubImpl());
}

// Partial mock of `github` parameter passed into github-script actions
function createMockGithubImpl() {
  return {
    hook: {
      after: vi.fn(),
      before: vi.fn(),
    },
    paginate: async (/** @type {(arg0: any) => any} */ func, /** @type {any} */ params) => {
      // Assume all test data fits in single page
      const data = (await func(params)).data;

      // Simulate normalization performed by real impl
      return Array.isArray(data) ? data : data[Object.keys(data)[0]];
    },
    rest: {
      actions: {
        downloadArtifact: vi.fn().mockResolvedValue({ data: new ArrayBuffer(0) }),
        listJobsForWorkflowRun: vi.fn().mockResolvedValue({ data: [] }),
        listWorkflowRunArtifacts: vi.fn().mockResolvedValue({ data: { artifacts: [] } }),
        listWorkflowRunsForRepo: vi.fn().mockResolvedValue({ data: { workflow_runs: [] } }),
      },
      checks: {
        listForRef: vi.fn().mockResolvedValue({ data: { check_runs: [] } }),
      },
      issues: {
        addLabels: vi.fn(),
        listLabelsOnIssue: vi.fn().mockResolvedValue({ data: [] }),
        removeLabel: vi.fn(),
      },
      pulls: {
        get: vi.fn(),
      },
      repos: {
        createCommitStatus: vi.fn(),
        listCommitStatusesForRef: vi.fn().mockResolvedValue({ data: [] }),
        listPullRequestsAssociatedWithCommit: vi.fn().mockResolvedValue({
          data: [],
        }),
      },
      search: {
        issuesAndPullRequests: vi.fn(),
      },
    },
    request: {
      endpoint: vi.fn(),
    },
  };
}

/**
 * @returns {Core & ReturnType<typeof createMockCoreImpl>}
 */
export function createMockCore() {
  return /** @type {Core & ReturnType<typeof createMockCoreImpl>} */ (createMockCoreImpl());
}

// Partial mock of `core` parameter passed into to github-script actions
function createMockCoreImpl() {
  const summary = {};
  summary.addRaw = vi.fn().mockReturnValue(summary);
  summary.write = vi.fn().mockResolvedValue(undefined);

  return {
    debug: vi.fn(console.debug),
    info: vi.fn(console.log),
    notice: vi.fn(console.log),
    error: vi.fn(console.error),
    warning: vi.fn(console.warn),
    isDebug: vi.fn().mockReturnValue(true),
    setOutput: vi.fn((name, value) => console.log(`setOutput('${name}', '${value}')`)),
    setFailed: vi.fn((msg) => console.log(`setFailed('${msg}')`)),
    summary,
  };
}

/**
 * @param {number} status
 * @returns {RequestError}
 */
export function createMockRequestError(status) {
  return new RequestError(`mock RequestError with status '${status}'`, status, {
    // request properties "url" and "headers" must be defined to prevent errors
    request: { method: "GET", url: "test url", headers: {} },
  });
}

/**
 * @returns {Context & ReturnType<createMockContextImpl>}
 */
export function createMockContext() {
  return /** @type {Context & ReturnType<createMockContextImpl>} */ (createMockContextImpl());
}

// Partial mock of `context` parameter passed into github-script actions
function createMockContextImpl() {
  return {
    payload: {},
    repo: {
      owner: "owner",
      repo: "repo",
    },
  };
}

export function createMockLogger() {
  return {
    debug: vi.fn(),
    error: vi.fn(),
    info: vi.fn(),
    isDebug: vi.fn().mockReturnValue(false),
    warning: vi.fn(),
  };
}
