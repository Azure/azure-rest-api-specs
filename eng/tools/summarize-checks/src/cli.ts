#!/usr/bin/env node

      // - name: Summarize Checks
      //   run: |
      //     npx summarize-checks \
      //       --owner ${{ github.repository_owner }} \
      //       --repo  ${{ github.event.repository.name }} \
      //       --pr    ${{ github.event.workflow_run.pull_requests[0].number }} \
      //       --sha   ${{ github.event.workflow_run.head_sha }}


import { parseArgs, ParseArgsConfig } from "node:util";

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
        short: "p",
        multiple: false,
        default: "Azure"
      },
    },
    allowPositionals: true,
  };

  const { values: opts } = parseArgs(config);
  // this option has a default value of process.cwd(), so we can assume it is always defined
  // just need to resolve that here to make ts aware of it

  const repo = opts.repo as string;
  const sha = opts.sha as string;
  const pr = opts.pr as string;
  const owner = opts.owner as string;

  if (!repo || !sha || !pr || !owner) {
    console.error("Missing required options: --repo, --sha, --pr");
    process.exit(1);
  }

  console.log(`Hello from summarize-checks CLI! You passed in a target repository: ${repo}, commit SHA: ${sha}, and pull request number: ${pr}.`);
  process.exit()
}
