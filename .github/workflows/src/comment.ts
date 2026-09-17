import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import type { Core } from "./github.ts";

export type IssueComment = {
  id: number;
  body?: string;
  user?: {
    login: string;
  } | null;
};

/**
 * Given a set of comments from an issue (or PR) for a specific user, grab the one that contains the specified comment group name.
 *
 * If the comment group name is not found, this function should return undefined.
 * @param comments - The list of comments to search through.
 * @param commentGroupName - The name of the comment group to search for in the comments. This is merely a "category" that
 * will allow the comment to be identified and updated later in a context where there are MULTIPLE github comments being left by token.
 * This is a bit more future proofed than merely assuming the first comment by the GITHUB_TOKEN user is the one we want to update.
 * @returns Resolves when the comment is created or updated.
 */
export function parseExistingComments(
  comments: IssueComment[],
  commentGroupName: string,
): [number | undefined, string | undefined] {
  let commentId: number | undefined = undefined;

  let commentBody: string | undefined = undefined;

  if (comments) {
    comments.map((comment) => {
      // When we create or update this comment, we will always leave behind
      // <!-- commentGroupName --> in the body of the comment.
      // This allows us to identify the comment later on. We need to return the body
      // so we can know if we need to update it or not. If it's the same body content
      // we will no-op on the update.
      if (comment.body?.includes(commentGroupName)) {
        commentId = comment.id;
        commentBody = comment.body;
      }
    });
  }

  return [commentId, commentBody];
}

/**
 * Creates a new issue comment or updates an existing one.
 * @param owner - The repository owner.
 * @param repo - The repository name.
 * @param issue_number - The issue or pull request number.
 * @param body - The markdown content of the comment.
 * @param commentIdentifier - The value that will be stored in an html comment so we can retrieve this comment later
 * @returns Resolves when the comment is created or updated.
 */
export async function commentOrUpdate(
  github: import("./github.ts").WorkflowArguments["github"],
  core: Core,
  owner: string,
  repo: string,
  issue_number: number,
  body: string,
  commentIdentifier: string,
): Promise<void> {
  const computedBody = body + `\n<!-- ${commentIdentifier} -->`;

  const comments: IssueComment[] = await github.paginate(github.rest.issues.listComments, {
    owner,
    repo,
    issue_number,
    per_page: PER_PAGE_MAX,
  });

  const [commentId, commentBody] = parseExistingComments(comments, commentIdentifier);

  if (commentId) {
    if (commentBody === computedBody) {
      core.info(`No update needed for comment ${commentId}.`);
      return; // No-op if the body is the same
    }
    await github.rest.issues.updateComment({
      owner,
      repo,
      comment_id: commentId,
      body: computedBody,
    });
    core.info(`Updated existing comment ${commentId}.`);
  } else {
    // Create a new comment
    const { data: newComment } = await github.rest.issues.createComment({
      owner,
      repo,
      issue_number,
      body: computedBody,
    });
    core.info(`Created new comment #${newComment.id}`);
  }
}
