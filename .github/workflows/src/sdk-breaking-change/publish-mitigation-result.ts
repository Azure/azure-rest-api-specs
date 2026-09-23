import type { AsyncFunctionArguments } from "@actions/github-script";
import { readFile } from "node:fs/promises";
import { publishResultInComment } from "./publish-result-in-comment.ts";

type MitigationResult = {
  prNumber: number;
  headSha: string;
  sdkLanguage: string;
  status: "success" | "failure";
  errorMessage?: string;
  customizationCode: string;
  projects: Array<{
    typespecProject: string;
    sdkPackage: string;
    breakingChanges: Array<{
      breakingChange: string;
      suggestedFix: string;
      isResolved: boolean;
      typespecChangesSummary?: string[];
    }>;
  }>;
};

function escapeTableCell(value: unknown, fallback = "-"): string {
  const text =
    typeof value === "string" || typeof value === "number" || typeof value === "boolean"
      ? String(value).trim()
      : "";
  return text
    ? text.replaceAll("\r", "").replaceAll("\n", "<br>").replaceAll("|", "\\|")
    : fallback;
}

export async function buildMitigationReport({
  github,
  context,
  core,
  mitigationResultPath,
  workflowSummaryUrl,
}: Pick<AsyncFunctionArguments, "github" | "context" | "core"> & {
  mitigationResultPath: string;
  workflowSummaryUrl: string;
}): Promise<{ report: string; result: MitigationResult }> {
  const result = JSON.parse(await readFile(mitigationResultPath, "utf8")) as MitigationResult;
  if (result.status !== "success") {
    const errorMessage =
      result.errorMessage ?? "The SDK breaking-change mitigation did not succeed.";
    core.warning(errorMessage); // Handle the failure case if needed
    return { report: errorMessage, result };
  }
  const { data: pull } = await github.rest.pulls.get({
    ...context.repo,
    pull_number: result.prNumber,
  });
  if (pull.head.sha !== result.headSha) {
    const staleMessage = `Analysis result for ${result.headSha} is stale; current PR head is ${pull.head.sha}.`;
    core.warning(staleMessage);
    return { report: staleMessage, result };
  }
  const projectSections = result.projects.flatMap((project) => {
    const resolvedChanges = project.breakingChanges
      .filter((change) => change.isResolved)
      .map(
        (change) =>
          `| ${escapeTableCell(change.breakingChange)} | ${escapeTableCell(change.suggestedFix)} | ${escapeTableCell(change.typespecChangesSummary?.[0])} |`,
      );
    const unresolvedChanges = project.breakingChanges
      .filter((change) => !change.isResolved)
      .map(
        (change) =>
          `| ${escapeTableCell(change.breakingChange)} | ${escapeTableCell(change.suggestedFix)} |`,
      );
    return [
      `**TypeSpec project:** ${project.typespecProject}`,
      "",
      `**SDK package:** ${project.sdkPackage}`,
      "",
      "**Resolved Breaking Changes:**",
      "",
      "| Breaking change | Resolution | TypeSpec changes |",
      "| --- | --- | --- |",
      ...(resolvedChanges.length
        ? resolvedChanges
        : ["| None | No SDK breaking changes were resolved. | - |"]),
      "",
      "**Unresolved Breaking Changes:**",
      "",
      "| Breaking change | Suggested resolution |",
      "| --- | --- |",
      ...(unresolvedChanges.length
        ? unresolvedChanges
        : ["| None | All SDK breaking changes were resolved. |"]),
      "",
    ];
  });

  const changedCode = result.customizationCode.trim();
  return {
    report: [
      "## SDK breaking-change mitigation result",
      "",
      `**Mitigation upon commit:** \`${result.headSha}\``,
      "",
      ...projectSections,
      "**Customization Code:**",
      "",
      changedCode
        ? ["````diff", changedCode, "````"].join("\n")
        : "No mitigation changes were produced.",
      `[View customization code in the workflow summary](${workflowSummaryUrl})`,
    ].join("\n"),
    result,
  };
}

export async function publishMitigationResult({
  github,
  context,
  core,
  mitigationResultPath,
  workflowSummaryUrl,
}: Pick<AsyncFunctionArguments, "github" | "context" | "core"> & {
  mitigationResultPath: string;
  workflowSummaryUrl: string;
}): Promise<void> {
  const buildResult = await buildMitigationReport({
    github,
    context,
    core,
    mitigationResultPath,
    workflowSummaryUrl,
  });
  await publishResultInComment(
    { github, context, core },
    buildResult.result.prNumber,
    `/azsdk sdk-breaking-mitigate ${buildResult.result.sdkLanguage}`,
    buildResult.report,
  );
}
