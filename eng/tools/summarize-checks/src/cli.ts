#!/usr/bin/env node
import { parseArgs, ParseArgsConfig } from "node:util";
import { Octokit } from "@octokit/rest";
import { CheckInspectorOptions, getPrState } from "./main.js";

export function initOctokit(): Octokit {
  const token = process.env.GITHUB_TOKEN;
  if (!token) {
    // todo: do we want to TRY to continue unauthenticated or simply crash out here?
    console.warn("Warning: GITHUB_TOKEN is not set. Continuing unauthenticated — you may hit rate limits or see failures.");
    return new Octokit();
  } else {
    return new Octokit({ auth: token });
  }
}

export async function main() {
  const config: ParseArgsConfig = {
    options: {
      repo: {
        type: "string",
        short: "r",
        multiple: false
      },
      sha: {
        type: "string",
        short: "s",
        multiple: false,
      },
      pr: {
        type: "string",
        short: "p",
        multiple: false,
      },
      owner: {
        type: "string",
        short: "o",
        multiple: false,
        default: "Azure"
      },
    },
    allowPositionals: true,
  };

  const { values: opts } = parseArgs(config);
  const repo = opts.repo as string;
  const sha = opts.sha as string;
  const pr = opts.pr as string;
  const owner = opts.owner as string;

  if (!repo || !sha || !pr || !owner) {
    console.error("Missing required options: --repo, --owner, --sha, --pr");
    process.exit(1);
  }

  const kit = initOctokit();

  let options: CheckInspectorOptions = {
    owner,
    repo,
    prNumber: parseInt(pr, 10),
    commitSha: sha,
  };

  const prState = await getPrState(kit, options);

  console.log("Check runs:", JSON.stringify(prState.runs));
  console.log("Combined status:", JSON.stringify(prState.status));
  console.log("Labels on PR:", JSON.stringify(prState.labels));

  console.log(`Hello from summarize-checks CLI! You passed in a target repository: ${repo}, commit SHA: ${sha}, and pull request number: ${pr}.`);
  process.exit()
}
