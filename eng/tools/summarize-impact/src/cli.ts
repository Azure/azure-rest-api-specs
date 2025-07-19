#!/usr/bin/env node

import { evaluateImpact } from "./impact.js";
import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import { setOutput } from "@azure-tools/specs-shared/error-reporting";

import { resolve, join } from "path";
import fs from "fs";
import { parseArgs, ParseArgsConfig } from "node:util";
import { simpleGit } from "simple-git";
import { LabelContext, PRContext } from "./types.js";

export async function getRootFolder(inputPath: string): Promise<string> {
  try {
    const gitRoot = await simpleGit(inputPath).revparse("--show-toplevel");
    return resolve(gitRoot.trim());
  } catch (error) {
    console.error(
      `Error: Unable to determine the root folder of the git repository.`,
      `Please ensure you are running this command within a git repository OR providing a targeted directory that is within a git repo.`,
    );
    process.exit(1);
  }
}

export async function main() {
  const config: ParseArgsConfig = {
    options: {
      // the target branch checked out
      targetDirectory: {
        type: "string",
        multiple: false,
      },
      // the pr
      sourceDirectory: {
        type: "string",
        multiple: false,
        default: process.cwd(),
      },
      fileList: {
        type: "string",
        short: "f",
        multiple: false,
        default: undefined,
      },
      number: {
        type: "string",
        short: "n",
        multiple: false,
      },
      sourceBranch: {
        type: "string",
        multiple: false,
      },
      targetBranch: {
        type: "string",
        multiple: false,
      },
      sha: {
        type: "string",
        short: "s",
        multiple: false,
      },
      repo: {
        type: "string",
        short: "r",
        multiple: false,
      },
      owner: {
        type: "string",
        short: "o",
        multiple: false,
      },
      labels: {
        type: "string",
        short: "l",
        multiple: false,
      },
      isDraft: {
        type: "boolean",
        multiple: false,
      },
    },
    allowPositionals: true,
  };

  const { values: opts } = parseArgs(config);

  // todo: refactor these opts
  const sourceDirectory = opts.sourceDirectory as string;
  const targetDirectory = opts.targetDirectory as string;
  const sourceGitRoot = await getRootFolder(sourceDirectory);
  const targetGitRoot = await getRootFolder(targetDirectory);
  const fileList = await getChangedFilesStatuses({ cwd: sourceGitRoot });
  const sha = opts.sha as string;
  const sourceBranch = opts.sourceBranch as string;
  const targetBranch = opts.targetBranch as string;
  const repo = opts.repo as string;
  const owner = opts.owner as string;
  const prNumber = opts.number as string;
  const existingLabels = (opts.labels as string).split(",").map((l) => l.trim());
  const isDraft = opts.prStaisDrafttus as boolean;

  const labelContext: LabelContext = {
    present: new Set(existingLabels),
    toAdd: new Set(),
    toRemove: new Set(),
  };

  const prContext = new PRContext(sourceGitRoot, targetGitRoot, labelContext, {
    sha,
    sourceBranch,
    targetBranch,
    repo,
    prNumber,
    owner,
    fileList,
    isDraft,
  });

  let impact = await evaluateImpact(prContext, labelContext);

  console.log("Evaluated impact: ", JSON.stringify(impact));

  // Write to a temp file that can get picked up later.
  const summaryFile = join(process.cwd(), "summary.json");
  fs.writeFileSync(summaryFile, JSON.stringify(impact, null, 2));
  setOutput("summary", summaryFile);
}
