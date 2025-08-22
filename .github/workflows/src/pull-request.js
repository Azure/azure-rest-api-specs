// @ts-check

/**
 * Returns the pull request associated with a head_sha, head_repo, and base_repo.
 * If there are multiple PRs with the same head_sha to the base_repo, throws an error.
 * If there are no PRs with the head_sha to the base_repo, throws an error.
 *
 * @param {string} head_sha
 * @param {string} head_owner
 * @param {string} head_repo
 * @param {string} base_owner
 * @param {string} base_repo
 * @returns {Promise<number>}
 */

export async function getPullRequest(head_sha, head_owner, head_repo, base_owner, base_repo) {
  return 0;
}
