import { RequestError } from "@octokit/request-error";
import { vi, type Mock } from "vitest";

export type Core = import("@actions/github-script").AsyncFunctionArguments["core"];

export type Context = import("@actions/github-script").AsyncFunctionArguments["context"];

export type GitHub = import("@actions/github-script").AsyncFunctionArguments["github"];

export function createMockGithub(): GitHub & ReturnType<typeof createMockGithubImpl> {
  return createMockGithubImpl() as GitHub & ReturnType<typeof createMockGithubImpl>;
}

/**
 * `github` mock as returned by {@link createMockGithub}, including vitest `Mock`
 * helpers (e.g. `.mockResolvedValue`) on the `rest.*` methods.
 */
export type MockGithub = ReturnType<typeof createMockGithub>;

// Partial mock of `github` parameter passed into github-script actions
function createMockGithubImpl() {
  return {
    hook: {
      after: vi.fn(),
      before: vi.fn(),
    },
    paginate: async <T, U>(
      func: (input: T) => Promise<{ data: Array<U> | Record<string, Array<U>> }>,
      params: T,
    ) => {
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
        createComment: vi.fn(),
        deleteComment: vi.fn(),
        listComments: vi.fn().mockResolvedValue({ data: [] }),
        listEvents: vi.fn().mockResolvedValue({ data: [] }),
        listLabelsOnIssue: vi.fn().mockResolvedValue({ data: [] }),
        removeLabel: vi.fn(),
        updateComment: vi.fn(),
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

export function createMockCore(): Core & ReturnType<typeof createMockCoreImpl> {
  return createMockCoreImpl() as Core & ReturnType<typeof createMockCoreImpl>;
}

// Partial mock of `core` parameter passed into to github-script actions
function createMockCoreImpl() {
  const summary = {} as { addRaw: Mock; write: Mock };
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

export function createMockRequestError(status: number): RequestError {
  return new RequestError(`mock RequestError with status '${status}'`, status, {
    // request properties "url" and "headers" must be defined to prevent errors
    request: { method: "GET", url: "test url", headers: {} },
  });
}

export function createMockContext(): Context & ReturnType<typeof createMockContextImpl> {
  return createMockContextImpl() as Context & ReturnType<typeof createMockContextImpl>;
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
