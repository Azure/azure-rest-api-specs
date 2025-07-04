/**
 * @typedef {Object} CommentOrUpdateOptions
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @property {string} owner - The repository owner.
 * @property {string} repo - The repository name.
 * @property {number} issue_number - The issue or pull request number.
 * @property {string} body - The markdown content of the comment.
 */

/**
 * Given a set of comments from an issue (or PR) for a specific user, grab the one that contains the specified comment group name.
 *
 * If the comment group name is not found, this function should return undefined.
 *
 * @param {import("@octokit/openapi-types").components["schemas"]["issue-comment"][]} comments - The list of comments to search through.
 * @param {string} commentGroupName - The name of the comment group to search for in the comments. This is merely a "category" that
 *  will allow the comment to be identified and updated later in a context where there are MULTIPLE github comments being left by token.
 *  This is a bit more future proofed than merely assuming the first comment by the GITHUB_TOKEN user is the one we want to update.
 * @returns {[number | undefined, string | undefined]} Resolves when the comment is created or updated.
 */
export function parseExistingComments(comments, commentGroupName) {
  /** @type {number | undefined} */
  let commentId = undefined;
  /** @type {string | undefined} */
  let commentBody = undefined;

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
 *
 *
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @param {string} owner - The repository owner.
 * @param {string} repo - The repository name.
 * @param {number} issue_number - The issue or pull request number.
 * @param {string} body - The markdown content of the comment.
 * @param {string} commentIdentifier - The value that will be stored in an html comment so we can retrieve this comment later
 * @returns {Promise<void>} Resolves when the comment is created or updated.
 */
export async function commentOrUpdate(
  { github, context, core },
  owner,
  repo,
  issue_number,
  body,
  commentIdentifier,
) {
  try {
    // Get the authenticated user to know who we are
    const { data: user } = await github.rest.users.getAuthenticated();
    const authenticatedUsername = user.login;
    const computedBody = body + `\n<!-- ${commentIdentifier} -->`;

    /** @type {import("@octokit/openapi-types").components["schemas"]["issue-comment"][]} */
    const comments = await github.paginate(github.rest.issues.listComments, {
      owner,
      repo,
      issue_number,
    });

    // only examine the comments from user in our current GITHUB_TOKEN context
    const existingComments = comments.filter(
      (comment) => comment.user?.login === authenticatedUsername,
    );

    const [commentId, commentBody] = parseExistingComments(existingComments, commentIdentifier);

    if (commentId) {
      if (commentBody === computedBody) {
        core.info(`No update needed for comment ${commentId} by ${authenticatedUsername}`);
        return; // No-op if the body is the same
      }
      await github.rest.issues.updateComment({
        owner,
        repo,
        comment_id: commentId,
        body: computedBody,
      });
      core.info(`Updated existing comment ${commentId} by ${authenticatedUsername}`);
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
  } catch (error) {
    core.setFailed(`Failed to comment or update: ${error.message}`);
  }
}
