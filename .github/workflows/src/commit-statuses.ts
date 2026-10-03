import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import type { GitHub, RestEndpointMethodTypes } from "./github.ts";

export type LatestCommitStatus =
  RestEndpointMethodTypes["repos"]["getCombinedStatusForRef"]["response"]["data"]["statuses"][number];

/** Reads the latest status for each context, rather than every historical update. */
export async function getLatestCommitStatuses(
  github: Pick<GitHub, "rest">,
  owner: string,
  repo: string,
  ref: string,
): Promise<LatestCommitStatus[]> {
  const statuses: LatestCommitStatus[] = [];
  // This endpoint returns a combined-status envelope that Octokit's list paginator does not unwrap.
  for (let page = 1; ; page++) {
    const { data } = await github.rest.repos.getCombinedStatusForRef({
      owner,
      repo,
      ref,
      per_page: PER_PAGE_MAX,
      page,
    });
    statuses.push(...data.statuses);
    if (statuses.length >= data.total_count) return statuses;
    if (data.statuses.length === 0) {
      throw new Error(`Incomplete commit statuses for ${owner}/${repo}@${ref}`);
    }
  }
}
