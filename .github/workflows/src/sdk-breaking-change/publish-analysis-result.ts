import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { escapeMarkdown, table } from "@azure-tools/specs-shared/markdown";
import { AnalysisResultSchema, MarkdownHeadingId, type AnalysisResult } from "./types.ts";
import { publishResultInComment } from "./publish-result-in-comment.ts";
import type { GitHubScriptArgs } from "../github.ts";

export async function buildAnalysisReport(resultsPath: string): Promise<{
  command: string;
  report: string;
  result: AnalysisResult;
}> {
  const result = AnalysisResultSchema.parse(
    JSON.parse(await readFile(join(resultsPath, "sdk-breaking-change-analysis.json"), "utf8")),
  );
  const projectReports = result.projects.map((project) => {
    const tableRows: string[][] = project.breakingChanges.length
      ? project.breakingChanges.map((change) => [
          escapeMarkdown(change.id),
          escapeMarkdown(change.breakingChange),
          escapeMarkdown(change.category),
          escapeMarkdown(change.suggestedFix),
        ])
      : [["-", "No SDK breaking changes detected.", "-", "-"]];

    const projectReport = [
      `**Typespec Project:** ${project.typespecProject}`,
      "",
      `**SDK Package:** ${project.sdkPackage}`,
      "",
      table([["ID", "Breaking change", "Category", "Suggested fix"], ...tableRows]),
    ];
    const breakingChangeSummaryUrl = [
      result.analysisWorkflowUrl,
      "#",
      `${project.sdkPackage}-${MarkdownHeadingId.BreakingChange}`,
    ].join("");
    projectReport.push("", `[SDK breaking change analysis details](${breakingChangeSummaryUrl})`);
    return projectReport;
  });

  return {
    command: `/azsdk sdk-breaking-analysis ${result.sdkLanguage}`,
    report: [
      `## SDK Breaking changes for ${result.sdkLanguage}`,
      "",
      `**Analyzed commit:** \`${result.headSha}\``,
      "",
      ...projectReports.flatMap((projectReport) => [...projectReport, ""]),
    ].join("\n"),
    result,
  };
}

export async function publishAnalysisResult({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<void> {
  const resultsPath = process.env.RESULTS_PATH;
  if (!resultsPath) {
    throw new Error("RESULTS_PATH is required.");
  }

  const { command, report, result } = await buildAnalysisReport(resultsPath);
  core.setOutput("issue_number", result.prNumber);
  core.setOutput("head_sha", result.headSha);
  if (result.status !== "success") {
    const errorMessage = `SDK breaking-change analysis failed.\n\n${result.errorMessage ?? ""}\n\n[See analysis workflow](${result.analysisWorkflowUrl})`;
    core.warning(errorMessage);
    await publishResultInComment(
      { github, context, core },
      result.prNumber,
      command,
      `❌ ${errorMessage}`,
      result.headSha,
    );
    return;
  }
  const { data: pull } = await github.rest.pulls.get({
    ...context.repo,
    pull_number: result.prNumber,
  });
  if (pull.head.sha !== result.headSha) {
    const staleMessage = `Analysis result for ${result.headSha} is stale; current PR head is ${pull.head.sha}.`;
    core.warning(staleMessage);
    await publishResultInComment(
      { github, context, core },
      result.prNumber,
      command,
      `⚠️ ${staleMessage}`,
      result.headSha,
    );
    return;
  }

  await publishResultInComment(
    { github, context, core },
    result.prNumber,
    command,
    report,
    result.headSha,
  );
}
