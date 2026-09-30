import { PER_PAGE_MAX } from "../../../shared/src/github.ts";
import type { IssueComment } from "../comment.ts";
import type { GitHub } from "../github.ts";

interface Connection<T> {
  nodes: (T | null)[];
  pageInfo: { hasNextPage: boolean; endCursor: string | null };
}

export type CheckContext =
  | {
      __typename: "CheckRun";
      name: string;
      status: string;
      conclusion: string | null;
      startedAt: string | null;
      completedAt: string | null;
      checkSuite: { workflowRun: { databaseId: number | null } | null } | null;
    }
  | {
      __typename: "StatusContext";
      context: string;
      state: string;
      description: string | null;
      targetUrl: string | null;
      createdAt: string;
    };

export interface SummaryQueryResponse {
  repository: {
    pullRequest: {
      headRefOid: string;
      baseRefName: string;
      labels?: Connection<{ name: string }> | null;
      comments?: Connection<{ databaseId: number | null; body: string }> | null;
    } | null;
    object: {
      __typename: string;
      statusCheckRollup?: { contexts: Connection<CheckContext> } | null;
    } | null;
  } | null;
}

export interface SummaryCheckRun {
  name: string;
  status: string;
  conclusion: string | null;
  started_at: string | null;
  completed_at: string | null;
  workflowRunId?: number;
}

export interface SummaryCommitStatus {
  context: string;
  state: string;
  description: string | null;
  target_url: string | null;
  updated_at: string;
}

export interface SummaryData {
  headSha: string;
  targetBranch: string;
  labels: string[];
  comments: IssueComment[];
  checkRuns: SummaryCheckRun[];
  statuses: SummaryCommitStatus[];
}

export const summaryQuery = `
  query CheckSummary(
    $owner: String!, $repo: String!, $number: Int!, $sha: GitObjectID!, $pageSize: Int!,
    $labelsCursor: String, $commentsCursor: String, $checksCursor: String,
    $includeLabels: Boolean!, $includeComments: Boolean!, $includeChecks: Boolean!
  ) {
    repository(owner: $owner, name: $repo) {
      pullRequest(number: $number) {
        headRefOid
        baseRefName
        labels(first: $pageSize, after: $labelsCursor) @include(if: $includeLabels) {
          nodes { name }
          pageInfo { hasNextPage endCursor }
        }
        comments(first: $pageSize, after: $commentsCursor) @include(if: $includeComments) {
          nodes { databaseId body }
          pageInfo { hasNextPage endCursor }
        }
      }
      object(oid: $sha) {
        __typename
        ... on Commit {
          statusCheckRollup @include(if: $includeChecks) {
            contexts(first: $pageSize, after: $checksCursor) {
              nodes {
                __typename
                ... on CheckRun {
                  name status conclusion startedAt completedAt
                  checkSuite { workflowRun { databaseId } }
                }
                ... on StatusContext {
                  context state description targetUrl createdAt
                }
              }
              pageInfo { hasNextPage endCursor }
            }
          }
        }
      }
    }
  }
`;

/** Batches independent summary reads and paginates only connections with remaining results. */
export async function getSummaryData(
  github: GitHub,
  owner: string,
  repo: string,
  number: number,
  sha: string,
): Promise<SummaryData> {
  const labels: { name: string }[] = [];
  const comments: { databaseId: number | null; body: string }[] = [];
  const contexts: CheckContext[] = [];
  let labelsCursor: string | null | undefined = null;
  let commentsCursor: string | null | undefined = null;
  let checksCursor: string | null | undefined = null;
  let refreshedHead = false;
  let targetBranch: string | undefined;

  do {
    const response: SummaryQueryResponse = await github.graphql<SummaryQueryResponse>(
      summaryQuery,
      {
        owner,
        repo,
        number,
        sha,
        pageSize: PER_PAGE_MAX,
        labelsCursor,
        commentsCursor,
        checksCursor,
        includeLabels: labelsCursor !== undefined,
        includeComments: commentsCursor !== undefined,
        includeChecks: checksCursor !== undefined,
      },
    );
    const repository: SummaryQueryResponse["repository"] = response.repository;
    if (!repository?.pullRequest?.headRefOid || !repository.pullRequest.baseRefName) {
      throw new Error(`Unable to load check summary for ${owner}/${repo}#${number} at ${sha}`);
    }
    if (repository.pullRequest.headRefOid !== sha) {
      if (refreshedHead) {
        throw new Error("PR head changed while reading the check summary; retry the workflow");
      }
      // A queued event can refer to an obsolete head. Restart all connections for the current PR.
      sha = repository.pullRequest.headRefOid;
      refreshedHead = true;
      labels.length = comments.length = contexts.length = 0;
      labelsCursor = commentsCursor = checksCursor = null;
      continue;
    }
    if (repository.object?.__typename !== "Commit") {
      throw new Error(`Unable to load check summary for ${owner}/${repo}#${number} at ${sha}`);
    }
    targetBranch = repository.pullRequest.baseRefName;
    if (labelsCursor !== undefined) {
      labelsCursor = appendPage(labels, repository.pullRequest.labels, labelsCursor);
    }
    if (commentsCursor !== undefined) {
      commentsCursor = appendPage(comments, repository.pullRequest.comments, commentsCursor);
    }
    if (checksCursor !== undefined) {
      const rollup = repository.object.statusCheckRollup;
      // A commit without checks or statuses has a null rollup.
      checksCursor =
        rollup === null ? undefined : appendPage(contexts, rollup?.contexts, checksCursor);
    }
  } while (
    labelsCursor !== undefined ||
    commentsCursor !== undefined ||
    checksCursor !== undefined
  );

  if (!targetBranch) throw new Error("Check summary has no target branch");

  const checkRuns: SummaryCheckRun[] = [];
  const statuses: SummaryCommitStatus[] = [];
  for (const context of contexts) {
    if (context.__typename === "CheckRun") {
      checkRuns.push({
        name: context.name,
        status: context.status.toLowerCase(),
        conclusion: context.conclusion?.toLowerCase() ?? null,
        started_at: context.startedAt,
        completed_at: context.completedAt,
        workflowRunId: context.checkSuite?.workflowRun?.databaseId ?? undefined,
      });
    } else {
      statuses.push({
        context: context.context,
        state: context.state.toLowerCase(),
        description: context.description,
        target_url: context.targetUrl,
        updated_at: context.createdAt,
      });
    }
  }
  return {
    headSha: sha,
    targetBranch,
    labels: labels.map((label) => label.name),
    comments: comments.map((comment) => {
      if (comment.databaseId === null) throw new Error("PR comment has no REST database ID");
      return { id: comment.databaseId, body: comment.body };
    }),
    checkRuns,
    statuses,
  };
}

function appendPage<T>(
  items: T[],
  connection: Connection<T> | null | undefined,
  previousCursor: string | null,
): string | undefined {
  if (!connection) throw new Error("Missing check-summary connection");
  for (const node of connection.nodes) {
    if (node === null) throw new Error("Incomplete check-summary connection");
    items.push(node);
  }
  const { hasNextPage, endCursor } = connection.pageInfo;
  if (!hasNextPage) return undefined;
  if (!endCursor || endCursor === previousCursor || connection.nodes.length === 0) {
    throw new Error("Check-summary pagination did not advance");
  }
  return endCursor;
}
