// @ts-check

/**
 * Retrieves the PR number associated with a specific commit SHA
 * @param {Object} params
 * @param {String} params.head_sha - The head_sha
 * @param {typeof import("@actions/core")} params.core - GitHub Actions core for logging
 * @param {import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api} params.github - GitHub API client
 * @returns {Promise<{issueNumber: number}>} - The PR number or NaN if not found
 */
export async function getIssueNumber({ head_sha, core, github }) {
  let issueNumber = NaN;

  if (!head_sha) {
    throw new Error("head_sha is required when trying to search a PR.");
  }

  core.info(`Searching for PRs with commit SHA: ${head_sha}`);

  try {
    const searchResponse = await github.rest.search.issuesAndPullRequests({
      q: `sha:${head_sha} type:pr state:open`,
    });

    const totalCount = searchResponse.data.total_count;
    const itemsCount = searchResponse.data.items.length;

    core.info(`Search results: ${totalCount} total matches, ${itemsCount} items returned`);

    if (itemsCount > 0) {
      const firstItem = searchResponse.data.items[0];
      issueNumber = firstItem.number;
      core.info(`Found the first matched PR #${issueNumber}: ${firstItem.html_url}`);

      if (itemsCount > 1) {
        core.warning(
          `Multiple PRs found for commit ${head_sha}: ${searchResponse.data.items.map((item) => `#${item.html_url}`).join(", ")}`,
        );
      }
    } else {
      core.info(`No open PRs found for commit ${head_sha}`);
    }
  } catch (error) {
    core.error(`Error searching for PRs with commit ${head_sha}: ${error}`);
    throw error;
  }

  return { issueNumber };
}
