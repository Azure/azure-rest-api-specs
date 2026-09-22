import type { AsyncFunctionArguments } from "@actions/github-script";
import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { AnalysisResultSchema, type AnalysisResult } from "./create-analysis-result.ts";
import { publishResultInComment } from "./publish-result-in-comment.ts";

function escapeTableCell(value: unknown, fallback = "-"): string {
  const text = String(value ?? "").trim();
  return text
    ? text.replaceAll("\r", "").replaceAll("|", "\\|").replaceAll("\n", "<br>")
    : fallback;
}

export async function buildAnalysisReport(resultsPath: string): Promise<{
  command: string;
  report: string;
  result: AnalysisResult;
}> {
  const result = AnalysisResultSchema.parse(
    JSON.parse(await readFile(join(resultsPath, "sdk-breaking-change-analysis.json"), "utf8")),
  );
  const projectReports = result.projects.map((project) => {
    const tableRows = project.breakingChanges.length
      ? project.breakingChanges.map(
          (change) =>
            `| ☐ | ${escapeTableCell(change.breakingChange)} | ${escapeTableCell(change.category)} | ${escapeTableCell(change.suggestedFix)} |`,
        )
      : ["| ☐ | No SDK breaking changes detected. | - | - |"];

    const projectReport = [
      `**Typespec Project:** ${project.typespecProject}`,
      "",
      `**SDK Package:** ${project.sdkPackage}`,
      "",
      "|  | Breaking change | Category | Suggested fix |",
      "| --- | --- | --- | --- |",
      ...tableRows,
    ];
    projectReport.push("", `[SDK breaking change analysis details](${result.analysisWorkflowUrl})`);
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
}: Pick<AsyncFunctionArguments, "github" | "context" | "core">): Promise<void> {
  const resultsPath = process.env.RESULTS_PATH;
  if (!resultsPath) {
    throw new Error("RESULTS_PATH is required.");
  }

  const { command, report, result } = await buildAnalysisReport(resultsPath);
  if (result.status !== "success") {
    const errorMessage = result.errorMessage ?? "The SDK breaking-change analysis did not succeed.";
    core.warning(errorMessage);
    await publishResultInComment({ github, context, core }, result.prNumber, command, errorMessage);
    return;
  }
  const { data: pull } = await github.rest.pulls.get({
    ...context.repo,
    pull_number: result.prNumber,
  });
  if (pull.head.sha !== result.headSha) {
    const staleMessage = `Analysis result for ${result.headSha} is stale; current PR head is ${pull.head.sha}.`;
    core.warning(staleMessage);
    await publishResultInComment({ github, context, core }, result.prNumber, command, staleMessage);
    return;
  }

  await publishResultInComment({ github, context, core }, result.prNumber, command, report);
}
