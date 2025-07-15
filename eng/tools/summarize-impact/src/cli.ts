#!/usr/bin/env node

import { evaluateImpact } from "./runner.js";
import { getChangedFiles } from "@azure-tools/specs-shared/changed-files";

import { resolve } from "path";
import { parseArgs, ParseArgsConfig } from "node:util";
import fs from "node:fs/promises";
import { simpleGit } from "simple-git";
import { extractInputs } from "@azure-tools/specs-shared/context";

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
      targetDirectory: {
        type: "string",
        short: "d",
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
        multiple: false
      },
      sourceBranch: {
        type: "string",
        short: "sb",
        multiple: false,
      },
      targetBranch: {
        type: "string",
        short: "tb",
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
      }
    },
    allowPositionals: true,
  };

  const { values: opts, positionals } = parseArgs(config);
  console.log(positionals);
  // this option has a default value of process.cwd(), so we can assume it is always defined
  // just need to resolve that here to make ts aware of it
  const targetDirectory = opts.targetDirectory as string;

  const resolvedGitRoot = await getRootFolder(targetDirectory);

  let fileList: string[] | undefined = undefined;
  if (opts.fileList !== undefined) {
    const fileListPath = resolve(opts.fileList as string);
    try {
      const fileContent = await fs.readFile(fileListPath, { encoding: "utf-8" });
      fileList = fileContent
        .split("\n")
        .map((line) => line.trim())
        .filter((line) => line.length > 0);
      console.log(`Loaded ${fileList.length} files from ${opts.fileList}`);
    } catch (error) {
      console.error(
        `Error reading file list from ${opts.fileList}: ${error instanceof Error ? error.message : String(error)}`,
      );
      console.error("User provided file list that is not found.");
      console.error(
        "Please ensure the file exists and is readable, or do not provide the option 'fileList'",
      );
      process.exit(1);
    }
  }
  else {
    if (!fileList){
      await getChangedFiles({ cwd: resolvedGitRoot });
    }
  }

  const sha = opts.sha as string;
  const sourceBranch = opts.sourceBranch as string;
  const targetBranch = opts.targetBranch as string;
  const repo = opts.repo as string;
  const prNumber = opts.number as string;

  const context: any = {
    sha,
    sourceBranch,
    targetBranch,
    repo,
    prNumber
  };

  evaluateImpact(context, resolvedGitRoot, fileList,);
}
