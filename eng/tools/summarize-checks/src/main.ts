#!/usr/bin/env node

import { Octokit } from "@octokit/rest";

export async function getPrState(): Promise<void> {
  // This function is a placeholder for the actual implementation.
  // It should contain the logic to retrieve the pull request state and labels using octokit and the current pr context.

  console.log("Retrieving pull request state...");
  // Simulate some asynchronous operation
  return new Promise((resolve) => setTimeout(resolve, 1000));
}


interface CheckInspectorOptions {
  owner: string;
  repo: string;
  prNumber: number;
  commitSha: string;
}

interface CheckSummary {
  total: number;
  successes: number;
  failures: number;
  neutral: number;
  // …whatever else you need
}

export async function inspectChecks(
  octokit: Octokit,
  opts: CheckInspectorOptions
): Promise<CheckSummary> {

  const { owner, repo, commitSha } = opts;

  const { data: runs } = await octokit.rest.checks.listForRef({
    owner, repo, ref: commitSha,
  });

  const { data: status } = await octokit.rest.repos.getCombinedStatusForRef({
    owner, repo, ref: commitSha,
  });

  const summary: CheckSummary = {
    total: runs.check_runs.length + status.statuses.length,
    successes: runs.check_runs.filter((r: typeof runs.check_runs[number]) => r.conclusion === "success").length
             + status.statuses.filter((s: typeof status.statuses[number]) => s.state === "success").length,
    failures: runs.check_runs.filter((r: typeof runs.check_runs[number]) => r.conclusion === "failure").length
            + status.statuses.filter((s: typeof status.statuses[number]) => s.state === "failure").length,
    neutral: runs.check_runs.filter((r: typeof runs.check_runs[number]) => r.conclusion === "neutral").length
           + status.statuses.filter((s: typeof status.statuses[number]) => s.state === "neutral").length,
  };

  return summary;
}