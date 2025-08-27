// @ts-check

/**
 * Retrieves the PR number associated with a specific commit SHA
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} github - GitHub API client
 * @param {string} head_sha - The head_sha
 * @param {import('../../shared/src/logger.js').ILogger} [logger]
 * @returns {Promise<{issueNumber: number}>} - The PR number or NaN if not found
 */
export async function getIssueNumber(github, head_sha, logger) {
  let issueNumber = NaN;

  if (!head_sha) {
    throw new Error("head_sha is required when trying to search a PR.");
  }

  logger?.info(`Searching for PRs with commit SHA: ${head_sha}`);

  try {
    const searchResponse = await github.rest.search.issuesAndPullRequests({
      q: `sha:${head_sha} type:pr state:open`,
    });

    const totalCount = searchResponse.data.total_count;
    const itemsCount = searchResponse.data.items.length;

    logger?.info(`Search results: ${totalCount} total matches, ${itemsCount} items returned`);

    if (itemsCount > 0) {
      const firstItem = searchResponse.data.items[0];
      issueNumber = firstItem.number;
      logger?.info(`Found the first matched PR #${issueNumber}: ${firstItem.html_url}`);

      if (itemsCount > 1) {
        logger?.warning(
          `Multiple PRs found for commit ${head_sha}: ${searchResponse.data.items.map((item) => `#${item.html_url}`).join(", ")}`,
        );
      }
    } else {
      logger?.info(`No open PRs found for commit ${head_sha}`);
    }
  } catch (error) {
    logger?.error(`Error searching for PRs with commit ${head_sha}: ${error}`);
    throw error;
  }

  return { issueNumber };
}
