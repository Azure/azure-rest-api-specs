import { RequestError } from "@octokit/request-error";
import { vi } from "vitest";

// Partial mock of `github` parameter passed into github-script actions
export function createMockGithub() {
  return {
    paginate: async (func, params) => {
      // Assume all test data fits in single page
      const data = (await func(params)).data;

      // Simulate normalization performed by real impl
      return Array.isArray(data) ? data : data[Object.keys(data)[0]];
    },
    rest: {
      actions: {
        listJobsForWorkflowRun: vi.fn().mockResolvedValue({ data: [] }),
        listWorkflowRunArtifacts: vi
          .fn()
          .mockResolvedValue({ data: { artifacts: [] } }),
        listWorkflowRunsForRepo: vi
          .fn()
          .mockResolvedValue({ data: { workflow_runs: [] } }),
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
        listPullRequestsAssociatedWithCommit: vi.fn().mockResolvedValue({
          data: [],
        }),
      },
      search: {
        issuesAndPullRequests: vi.fn(),
      },
    },
  };
}

// Partial mock of `core` parameter passed into to github-script actions
export function createMockCore() {
  return {
    debug: vi.fn(console.debug),
    info: vi.fn(console.log),
    notice: vi.fn(console.log),
    error: vi.fn(console.error),
    warning: vi.fn(console.warn),
    isDebug: vi.fn().mockReturnValue(true),
    setOutput: vi.fn((name, value) =>
      console.log(`setOutput('${name}', '${value}')`),
    ),
    setFailed: vi.fn((msg) => console.log(`setFailed('${msg}')`)),
  };
}

export function createMockRequestError(status) {
  return new RequestError(`mock RequestError with status '${status}'`, status, {
    // request properties "url" and "headers" must be defined to prevent errors
    request: { url: "test url", headers: {} },
  });
}

// Partial mock of `context` parameter passed into github-script actions
export function createMockContext() {
  return {
    payload: {},
    repo: {
      owner: "owner",
      repo: "repo",
    },
  };
}
