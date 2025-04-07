import { PER_PAGE_MAX } from "./github.js";

/**
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {{ 
 *   owner: string; 
 *   repo: string; 
 *   head_sha?: string; 
 *   status?: "completed" | "in_progress" | "queued";
 *   event?: string;
 * }} params
 * @returns {Promise<import("@octokit/plugin-rest-endpoint-methods").RestEndpointMethodTypes["actions"]["listWorkflowRunsForRepo"]["response"]["data"]["workflow_runs"]>}
 */
export async function listWorkflowRunsForRepo(github, { owner, repo, head_sha, status, event}) {
  return await github.paginate(github.rest.actions.listWorkflowRunsForRepo, {
    owner,
    repo,
    ...(head_sha && { head_sha }),
    ...(status && { status }),
    ...(event && { event }),
    per_page: PER_PAGE_MAX,
  });
}
