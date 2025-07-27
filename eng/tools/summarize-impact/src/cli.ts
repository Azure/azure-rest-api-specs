#!/usr/bin/env node

import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import { setOutput } from "@azure-tools/specs-shared/error-reporting";
import { evaluateImpact } from "./impact.js";

import { getRootFolder } from "@azure-tools/specs-shared/simple-git";
import { Octokit } from "@octokit/rest";
import fs from "fs";
import { parseArgs, ParseArgsConfig } from "node:util";
import { join, resolve } from "path";
import { LabelContext } from "./labelling-types.js";
import { PRContext } from "./PRContext.js";

export async function getRoot(inputPath: string): Promise<string> {
  try {
    const gitRoot = await getRootFolder(inputPath);
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
  const sourceGitRoot = await getRoot(sourceDirectory);
  const targetGitRoot = await getRoot(targetDirectory);
  const fileList = await getChangedFilesStatuses({ cwd: sourceGitRoot, paths: ["specification"] });
  const sha = opts.sha as string;
  const sourceBranch = opts.sourceBranch as string;
  const targetBranch = opts.targetBranch as string;
  const repo = opts.repo as string;
  const owner = opts.owner as string;
  const prNumber = opts.number as string;
  const isDraft = opts.isDraft as boolean;

  // create github client (use token if available, otherwise unauthenticated. we will throw if unhandled)
  const github = new Octokit({
    ...(process.env.GITHUB_TOKEN && { auth: process.env.GITHUB_TOKEN }),
  });

  const labels = (
    await github.paginate(github.rest.issues.listLabelsOnIssue, {
      owner,
      repo,
      issue_number: Number(prNumber),
      per_page: 100,
    })
  ).map((label: any) => label.name);

  const labelContext: LabelContext = {
    present: new Set(labels),
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

  // sets by default are not serializable, so we need to convert them to arrays
  // before we can write them to the output file.
  function setReplacer(_key: string, value: any) {
    if (value instanceof Set) {
      return [...value];
    }
    return value;
  }

  console.log("Evaluated impact: ", JSON.stringify(impact, setReplacer, 2));

  // Write to a temp file that can get picked up later.
  const summaryFile = join(process.cwd(), "summary.json");
  fs.writeFileSync(summaryFile, JSON.stringify(impact, setReplacer, 2));
  setOutput("summary", summaryFile);
}
