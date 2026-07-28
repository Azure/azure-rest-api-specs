/**
 * Parameters for creating a PR comment about release plan creation.
 */
export interface PrCommentParams {
  /** Octokit instance for GitHub API calls */
  octokit: {
    rest: {
      issues?: {
        createComment: (params: {
          owner: string;
          repo: string;
          issue_number: number;
          body: string;
        }) => Promise<unknown>;
      };
    };
  };
  /** GitHub repository owner */
  owner: string;
  /** GitHub repository name */
  repo: string;
  /** Pull request number */
  prNumber: number;
  /** Release plan ID or work item ID */
  planId?: string | number;
  /** Release plan URL or link */
  planLink?: string;
  /** API version for the release */
  apiVersion: string;
  /** TypeSpec project path */
  tspProjectPath: string;
}

/**
 * Create a comment on a GitHub PR announcing the release plan creation.
 * @param params - Comment parameters including PR details and release plan info
 * @throws Error if GitHub API call fails
 * @example
 * await postReleasePlanComment({
 *   octokit,
 *   owner: "Azure",
 *   repo: "azure-rest-api-specs",
 *   prNumber: 42,
 *   planId: "123",
 *   planLink: "https://example.com/plan/123",
 *   apiVersion: "2025-06-01-preview",
 *   tspProjectPath: "specification/foo/Contoso.Service"
 * });
 */
export async function postReleasePlanComment(params: PrCommentParams): Promise<void> {
  const { octokit, owner, repo, prNumber, planId, planLink, apiVersion, tspProjectPath } = params;

  const body = buildReleaseplanCommentBody({
    planId,
    planLink,
    apiVersion,
    tspProjectPath,
  });

  try {
    if (!octokit.rest.issues?.createComment) {
      throw new Error("Octokit issues.createComment is not available.");
    }

    await octokit.rest.issues.createComment({
      owner,
      repo,
      issue_number: prNumber,
      body,
    });
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    throw new Error(`Failed to post release plan comment on PR #${prNumber}: ${message}`, {
      cause: error,
    });
  }
}

/**
 * Build a formatted markdown comment body for release plan creation announcement.
 */
export interface CommentBodyParams {
  /** Release plan ID or work item ID */
  planId?: string | number;
  /** Release plan URL or link */
  planLink?: string;
  /** API version for the release */
  apiVersion: string;
  /** TypeSpec project path */
  tspProjectPath: string;
}

/**
 * Build the markdown body for a release plan creation comment.
 * @param params - Parameters for the comment
 * @returns Formatted markdown comment body
 */
export function buildReleaseplanCommentBody(params: CommentBodyParams): string {
  const { planId, planLink, apiVersion, tspProjectPath } = params;

  let body = `### ✅ Release Plan Created\n\n`;
  body += `| Field | Value |\n|-------|-------|\n`;

  if (planLink) {
    body += `| **Release Plan** | [View Release Plan](${planLink}) |\n`;
  }

  if (planId) {
    body += `| **Release Plan ID** | ${planId} |\n`;
  }

  body += `| **API Version** | \`${apiVersion}\` |\n`;
  body += `| **TypeSpec Project** | \`${tspProjectPath}\` |\n`;

  return body;
}
