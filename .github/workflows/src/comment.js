/**
 * @typedef {Object} CommentOrUpdateOptions
 * @property {import('@actions/github').GitHub} github - GitHub client instance from @actions/github.
 * @property {import('@actions/core').Core} core - Core toolkit instance from @actions/core.
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
 * @returns {Promise<string || undefined>} Resolves when the comment is created or updated.
 */
export async function parseExistingComments(comments, commentGroupName) {
    if (!comments) {
        return undefined;
    }

    return comments.find(comment => {
        // when we create or update this comment, we will always leave behind

        // <!-- commentGroupName --> in the body of the comment.
        // This allows us to identify the comment later on.
        return comment.body.includes(commentGroupName);
    })
}

/**
 * Creates a new issue comment or updates an existing one.
 *
 * @param {CommentOrUpdateOptions} options - Parameters for the comment operation.
 * @returns {Promise<void>} Resolves when the comment is created or updated.
 */
export async function commentOrUpdate({
  github,
  core,
  owner,
  repo,
  issue_number,
  body,
  commentGroupName
}) {
  try {
    // Get the authenticated user to know who we are
    const { data: user } = await github.rest.users.getAuthenticated();
    const authenticatedUsername = user.login;


    // Find the first comment by the authenticated user
    const existingComments = comments.filter(comment =>
      comment.user.login === authenticatedUsername
    );

    const commentId = parseExistingComments(existingComments, commentGroupName);

    if (commentId) {
      // Update the existing comment
      await github.rest.issues.updateComment({
        owner,
        repo,
        comment_id: commentId,
        body
      });
      core.info(`Updated existing comment #${existingComment.id} by ${authenticatedUsername}`);
    } else {
      // Create a new comment
      const { data: newComment } = await github.rest.issues.createComment({
        owner,
        repo,
        issue_number,
        body // body should have <!-- commentGroupName --> at the end so we can easily find it later
      });
      core.info(`Created new comment #${newComment.id}`);
    }
  } catch (error) {
    core.setFailed(`Failed to comment or update: ${error.message}`);
  }
}