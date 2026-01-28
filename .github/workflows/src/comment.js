import { PER_PAGE_MAX } from "../../shared/src/github.js";

/**
 * @typedef {Object} IssueComment
 * @property {number} id
 * @property {string} [body]
 * @property {{ login: string } | null} [user]
 */

/**
 * Given a set of comments from an issue (or PR) for a specific user, grab the one that contains the specified comment group name.
 *
 * If the comment group name is not found, this function should return undefined.
 *
 * @param {IssueComment[]} comments - The list of comments to search through.
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
    for (const comment of comments) {
      // When we create or update this comment, we will always leave behind
      // <!-- commentGroupName --> in the body of the comment.
      // This allows us to identify the comment later on. We need to return the body
      // so we can know if we need to update it or not. If it's the same body content
      // we will no-op on the update.
      if (comment.body?.includes(commentGroupName)) {
        commentId = comment.id;
        commentBody = comment.body;
        break; // Return the first match, not the last
      }
    }
  }

  return [commentId, commentBody];
}

/**
 * Find all comments with the specified comment group name and return them sorted by ID (oldest first).
 *
 * @param {IssueComment[]} comments - The list of comments to search through.
 * @param {string} commentGroupName - The name of the comment group to search for.
 * @returns {IssueComment[]} Array of matching comments sorted by ID (oldest first).
 */
export function findAllMatchingComments(comments, commentGroupName) {
  /** @type {IssueComment[]} */
  const matchingComments = [];

  if (comments) {
    comments.forEach((comment) => {
      if (comment.body?.includes(commentGroupName)) {
        matchingComments.push(comment);
      }
    });
  }

  // Sort by ID to ensure deterministic order (oldest comment has lowest ID)
  return matchingComments.sort((a, b) => a.id - b.id);
}

/**
 * Creates a new issue comment or updates an existing one.
 *
 *
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner - The repository owner.
 * @param {string} repo - The repository name.
 * @param {number} issue_number - The issue or pull request number.
 * @param {string} body - The markdown content of the comment.
 * @param {string} commentIdentifier - The value that will be stored in an html comment so we can retrieve this comment later
 * @returns {Promise<void>} Resolves when the comment is created or updated.
 */
export async function commentOrUpdate(
  github,
  core,
  owner,
  repo,
  issue_number,
  body,
  commentIdentifier,
) {
  const computedBody = body + `\n<!-- ${commentIdentifier} -->`;

  /** @type {IssueComment[]} */
  const comments = await github.paginate(github.rest.issues.listComments, {
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

    // RACE CONDITION FIX: Check for duplicates after creating the comment
    // If two instances run simultaneously, both might create comments
    // In that case, we need to clean up the duplicate
    const afterComments = await github.paginate(github.rest.issues.listComments, {
      owner,
      repo,
      issue_number,
      per_page: PER_PAGE_MAX,
    });

    const allMatchingComments = findAllMatchingComments(afterComments, commentIdentifier);

    if (allMatchingComments.length > 1) {
      core.warning(
        `Race condition detected: Found ${allMatchingComments.length} comments with identifier '${commentIdentifier}'. ` +
          `Cleaning up duplicate comment ${newComment.id} and updating comment ${allMatchingComments[0].id}.`,
      );

      // Delete the comment we just created (it will be one of the newer ones)
      await github.rest.issues.deleteComment({
        owner,
        repo,
        comment_id: newComment.id,
      });
      core.info(`Deleted duplicate comment ${newComment.id} due to race condition.`);

      // Update the oldest existing comment instead
      await github.rest.issues.updateComment({
        owner,
        repo,
        comment_id: allMatchingComments[0].id,
        body: computedBody,
      });
      core.info(
        `Updated oldest existing comment ${allMatchingComments[0].id} after race condition cleanup.`,
      );
    }
  }
}
