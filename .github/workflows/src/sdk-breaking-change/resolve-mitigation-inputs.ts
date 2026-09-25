import type { AsyncFunctionArguments } from "@actions/github-script";
import { readFile } from "node:fs/promises";
import { AnalysisResultSchema } from "./create-analysis-result.ts";
import { resolveSdkLanguageConfig } from "./resolve-analysis-inputs.ts";

export async function resolveMitigationTrigger({
  github,
  context,
  core,
  publishedResultsPath,
}: Pick<AsyncFunctionArguments, "github" | "context" | "core"> & {
  publishedResultsPath: string;
}): Promise<void> {
  const analysis = AnalysisResultSchema.parse(
    JSON.parse(await readFile(publishedResultsPath, "utf8")),
  );
  if (analysis.status !== "success") {
    core.notice("The SDK breaking-change analysis did not succeed.");
    core.setOutput("should-run", "false");
    return;
  }

  const languageConfig = resolveSdkLanguageConfig(analysis.sdkLanguage);
  const { data: pull } = await github.rest.pulls.get({
    ...context.repo,
    pull_number: analysis.prNumber,
  });
  if (pull.head.sha !== analysis.headSha) {
    throw new Error(
      `Pull request head ${pull.head.sha} does not match analyzed head ${analysis.headSha}.`,
    );
  }

  core.setOutput("should-run", "true");
  core.setOutput("pull-number", analysis.prNumber);
  core.setOutput("sdk-language", analysis.sdkLanguage);
  core.setOutput("sdk-repository", languageConfig.repository);
  core.setOutput("head-repository", pull.head.repo.full_name);
  core.setOutput("head-sha", pull.head.sha);
  core.setOutput("head-branch", pull.head.ref);
}
