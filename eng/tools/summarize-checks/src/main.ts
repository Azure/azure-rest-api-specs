#!/usr/bin/env node

import { Octokit } from "@octokit/rest";

export interface CheckInspectorOptions {
  owner: string;
  repo: string;
  prNumber: number;
  commitSha: string;
}

export async function getPrState(
  octokit: Octokit,
  opts: CheckInspectorOptions
): Promise<{ runs: any; status: any; labels: string[] }> {
  const { owner, repo, commitSha, prNumber } = opts;

  // fetch all check runs for this SHA
  const { data: runs } = await octokit.rest.checks.listForRef({
    owner,
    repo,
    ref: commitSha,
  });

  // fetch the combined status for this SHA
  const { data: status } = await octokit.rest.repos.getCombinedStatusForRef({
    owner,
    repo,
    ref: commitSha,
  });

  // fetch labels on the pull request
  let labels: string[] = [];
  try {
    const { data: labelsData } = await octokit.rest.issues.listLabelsOnIssue({
      owner,
      repo,
      issue_number: prNumber,
    });
    labels = labelsData.map((label: { name: string }) => label.name);
  } catch (e) {
    console.warn(`Failed to fetch PR labels: ${e}`);
  }

  // return both raw payloads and labels
  return { runs, status, labels };
}