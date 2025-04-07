import { PER_PAGE_MAX } from "./github.js";

/**
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {{ 
 *   owner: string; 
 *   repo: string; 
 *   ref: string; 
 *   name?: string; 
 *   status?: "queued" | "in_progress" | "completed";
 * }} params
 * @returns {Promise<import("@octokit/plugin-rest-endpoint-methods").RestEndpointMethodTypes["checks"]["listForRef"]["response"]["data"]["check_runs"]>}
 */
export async function listChecksForRef(github, { owner, repo, ref, name, status}) { 
  const options = { 
    owner, 
    repo, 
    ref, 
    ...(name && { check_name: name }), 
    ...(status && { status }),
    per_page: PER_PAGE_MAX,
  };

  return await github.paginate(github.rest.checks.listForRef, options);
}
