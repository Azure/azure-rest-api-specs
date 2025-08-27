// @ts-check

import { PER_PAGE_MAX } from "../../shared/src/github.js";
import { getIssueNumber } from "./issues.js";

/**
 * Returns the pull request associated with a head_sha, head_repo, and base_repo.
 * If there are multiple PRs with the same head_sha to the base_repo, throws an error.
 * If there are no PRs with the head_sha to the base_repo, throws an error.
 *
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {string} head_sha
 * @param {string} head_owner
 * @param {string} head_repo
 * @param {string} base_owner
 * @param {string} base_repo
 * @param {import('../../shared/src/logger.js').ILogger} [logger]
 * @returns {Promise<number>}
 */
export async function getPullRequest(
  github,
  head_sha,
  head_owner,
  head_repo,
  base_owner,
  base_repo,
  logger,
) {
  /** @type {Number} */
  let issue_number;

  /** @type {import("./context.js").PullRequest[]} */
  let pullRequests = [];

  try {
    // For fork PRs, we must call an API in the head repository to get the PR number in the base repository

    logger?.info(`listPullRequestsAssociatedWithCommit(${head_owner}, ${head_repo}, ${head_sha})`);
    pullRequests = (
      await github.paginate(github.rest.repos.listPullRequestsAssociatedWithCommit, {
        owner: head_owner,
        repo: head_repo,
        commit_sha: head_sha,
        per_page: PER_PAGE_MAX,
      })
    ).filter(
      // Only include PRs to the same repo as the triggering workflow.
      (pr) => pr.base.repo.owner.login === base_owner && pr.base.repo.name === base_repo,
    );
  } catch (error) {
    // Short message always
    logger?.info(`Error: ${error instanceof Error ? error.message : "unknown"}`);

    // Long message only in debug
    logger?.debug(`Error: ${error}`);
  }

  if (pullRequests.length === 0) {
    // There are three cases where the "commits" REST API called above can return
    // empty, even if there is an open PR from the commit:
    //
    // 1. If the head branch of a fork PR is the default branch of the fork repo, the
    //    API always returns empty. (#33315)
    // 2. If a PR was just merged, the API may return empty for a brief window (#33416).
    // 3. The API may fail occasionally for no known reason (#33417).
    //
    // In any case, the solution is to fall back to the (lower-rate-limit) search API.
    // The search API is confirmed to work in case #1, but has not been tested in #2 or #3.
    issue_number = (await getIssueNumber(github, head_sha, logger)).issueNumber;
  } else if (pullRequests.length === 1) {
    issue_number = pullRequests[0].number;
  } else {
    throw new Error(
      `Unexpected number of pull requests associated with commit '${head_sha}'. ` +
        `Expected: '1'. Actual: '${pullRequests.length}'. PRs:\n` +
        pullRequests.map((pr) => pr.html_url).join("\n"),
    );
  }
  if (!issue_number) {
    logger?.info(
      `Could not find PR for ${head_sha} in ${head_owner}:${head_repo} from either the "commits" or "search" REST APIs`,
    );
  }

  return issue_number;
}
