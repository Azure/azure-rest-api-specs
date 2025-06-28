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
  body
}) {
  try {
    // Get the authenticated user to know who we are
    const { data: user } = await github.rest.users.getAuthenticated();
    const authenticatedUsername = user.login;

    // Get all comments on the issue/PR
    const { data: comments } = await github.rest.issues.listComments({
      owner,
      repo,
      issue_number,
    });

    // Find the first comment by the authenticated user
    const existingComment = comments.find(comment =>
      comment.user.login === authenticatedUsername
    );

    if (existingComment) {
      // Update the existing comment
      await github.rest.issues.updateComment({
        owner,
        repo,
        comment_id: existingComment.id,
        body
      });
      core.info(`Updated existing comment #${existingComment.id} by ${authenticatedUsername}`);
    } else {
      // Create a new comment
      const { data: newComment } = await github.rest.issues.createComment({
        owner,
        repo,
        issue_number,
        body
      });
      core.info(`Created new comment #${newComment.id}`);
    }
  } catch (error) {
    core.setFailed(`Failed to comment or update: ${error.message}`);
  }
}