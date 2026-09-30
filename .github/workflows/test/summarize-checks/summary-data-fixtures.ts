import type {
  CheckContext,
  SummaryQueryResponse,
} from "../../src/summarize-checks/summary-data.ts";

export function page<T>(nodes: T[], hasNextPage = false, endCursor: string | null = null) {
  return { nodes, pageInfo: { hasNextPage, endCursor } };
}

export function summaryResponse({
  labels = [],
  comments = [],
  contexts = [],
  headSha = "sha",
  targetBranch = "main",
}: {
  labels?: { name: string }[];
  comments?: { databaseId: number | null; body: string }[];
  contexts?: CheckContext[];
  headSha?: string;
  targetBranch?: string;
} = {}) {
  return {
    repository: {
      pullRequest: {
        headRefOid: headSha,
        baseRefName: targetBranch,
        labels: page(labels),
        comments: page(comments),
      },
      object: { __typename: "Commit", statusCheckRollup: { contexts: page(contexts) } },
    },
  } satisfies SummaryQueryResponse;
}

export function checkRun(
  overrides: Partial<Extract<CheckContext, { __typename: "CheckRun" }>> = {},
): Extract<CheckContext, { __typename: "CheckRun" }> {
  return {
    __typename: "CheckRun",
    name: "TypeSpec Validation",
    status: "COMPLETED",
    conclusion: "SUCCESS",
    startedAt: "2026-09-30T00:00:00Z",
    completedAt: "2026-09-30T00:01:00Z",
    checkSuite: { workflowRun: { databaseId: 91001 } },
    ...overrides,
  };
}

export function statusContext(
  overrides: Partial<Extract<CheckContext, { __typename: "StatusContext" }>> = {},
): Extract<CheckContext, { __typename: "StatusContext" }> {
  return {
    __typename: "StatusContext",
    context: "SDK Validation Status",
    state: "PENDING",
    description: "Waiting",
    targetUrl: null,
    createdAt: "2026-09-30T00:00:00Z",
    ...overrides,
  };
}
