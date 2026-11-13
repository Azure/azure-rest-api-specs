import * as core from "@actions/core";
import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import { defaultLogger } from "@azure-tools/specs-shared/logger";
import { evaluateImpact, getRPaaSFolderList } from "./impact.ts";

import { getRootFolder } from "@azure-tools/specs-shared/simple-git";
import { writeFile } from "node:fs/promises";
import { parseArgs, type ParseArgsConfig } from "node:util";
import { resolve } from "node:path";
import { simpleGit } from "simple-git";
import { PRContext } from "./PRContext.ts";

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
      // Accepted for existing workflow invocations; PR metadata is not part of change impact.
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
        default: false,
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
  // The target checkout is the PR merge base, not necessarily the source's first parent.
  const baseCommitish = await simpleGit(targetGitRoot).revparse("HEAD");
  const fileList = await getChangedFilesStatuses({
    cwd: sourceGitRoot,
    baseCommitish,
    // Analyze moves as deletion/addition so both the old and new service are represented.
    gitOptions: ["--no-renames"],
    logger: defaultLogger,
    paths: ["specification"],
  });

  // Get the list of RPaaS folders from the target branch's arm-leases directory (read from disk)
  const mainSpecFolders = getRPaaSFolderList(targetGitRoot);

  const prContext = new PRContext(sourceGitRoot, targetGitRoot, { fileList });
  const impact = await evaluateImpact(prContext, mainSpecFolders);

  console.log("Evaluated impact: ", JSON.stringify(impact, null, 2));

  // Write to a temp file that can get picked up later.
  // Intentionally doesn't use GITHUB_STEP_SUMMARY, since it's not a markdown summary for GH UI
  const summaryFile = resolve("summary.json");
  await writeFile(summaryFile, JSON.stringify(impact, null, 2));
  core.setOutput("summary", summaryFile);
}
