import { detectChangedSpecConfigFromChangedFiles } from "@azure-tools/spec-gen-sdk-runner/spec-helpers";
import { isFullGitSha } from "@azure-tools/specs-shared/git";
import type { GitHubScriptArgs } from "../../src/github.ts";

interface PullRequestFile {
  filename: string;
  previous_filename?: string;
}

export async function resolveChangedTypeSpecConfigPathsFromPullRequest({
  github,
  context,
  core,
  pullNumber,
  expectedHeadSha,
  localSpecRepoPath,
}: GitHubScriptArgs & {
  pullNumber: number;
  expectedHeadSha: string;
  localSpecRepoPath: string;
}): Promise<string[]> {
  if (!Number.isSafeInteger(pullNumber) || pullNumber <= 0) {
    throw new Error(`Invalid pull request number: ${pullNumber}`);
  }
  const { data: pull } = await github.rest.pulls.get({
    ...context.repo,
    pull_number: pullNumber,
  });
  const headSha = pull.head.sha;
  if (!headSha || !isFullGitSha(headSha)) {
    throw new Error(`Invalid HEAD_SHA: ${headSha}`);
  }
  if (headSha !== expectedHeadSha) {
    throw new Error(`Pull request head changed from ${expectedHeadSha} to ${headSha}.`);
  }

  const files: PullRequestFile[] = await github.paginate(github.rest.pulls.listFiles, {
    ...context.repo,
    pull_number: pullNumber,
    per_page: 100,
  });
  const changedFiles = files.flatMap(({ filename, previous_filename }) =>
    [filename, previous_filename].filter((path): path is string => path !== undefined),
  );

  const configPaths = detectChangedSpecConfigFromChangedFiles(localSpecRepoPath, changedFiles);
  if (configPaths.length === 0) {
    throw new Error("No tspconfig.yaml could be resolved from the changed TypeSpec files.");
  }
  const sortedConfigPaths = configPaths
    .map((config) => config.typespecProject)
    .filter((path): path is string => path !== undefined)
    .map((path) => path.replaceAll("\\", "/"))
    .sort();
  core.setOutput("tsp-config-paths", JSON.stringify(sortedConfigPaths));
  return sortedConfigPaths;
}
