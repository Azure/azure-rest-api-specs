import type { GitHubScriptArgs } from "../github.ts";
import { readFile } from "node:fs/promises";
import {
  details,
  escapeMarkdown,
  renderMarkdownDoc,
  section,
  table,
} from "@azure-tools/specs-shared/markdown";
import { type MitigationResult, MitigationResultSchema } from "./types.ts";
import { publishResultInComment } from "./publish-result-in-comment.ts";

export async function buildMitigationReport({
  github,
  context,
  core,
  mitigationResultPath,
  workflowSummaryUrl,
}: GitHubScriptArgs & {
  mitigationResultPath: string;
  workflowSummaryUrl: string;
}): Promise<{ report: string; result: MitigationResult }> {
  const result = MitigationResultSchema.parse(
    JSON.parse(await readFile(mitigationResultPath, "utf8")),
  );
  if (result.status !== "success") {
    const errorMessage = `SDK breaking change mitigation failed.\n\n${result.errorMessage ?? ""}\n\n[See mitigation workflow](${result.mitigationWorkflowUrl})`;
    core.warning(errorMessage); // Handle the failure case if needed
    return { report: `❌ ${errorMessage}`, result };
  }
  const { data: pull } = await github.rest.pulls.get({
    ...context.repo,
    pull_number: result.prNumber,
  });
  if (pull.head.sha !== result.headSha) {
    const staleMessage = `Mitigation result for ${result.headSha} is stale; current PR head is ${pull.head.sha}.`;
    core.warning(staleMessage);
    return { report: `⚠️ ${staleMessage}`, result };
  }
  const projectSections = result.projects.flatMap((project) => {
    const resolvedChanges: string[][] = project.breakingChanges
      .filter((change) => change.isResolved)
      .map((change) => [
        escapeMarkdown(change.id),
        escapeMarkdown(change.breakingChange),
        change.suggestedFix ? escapeMarkdown(change.suggestedFix) : "",
        change.typespecChangesSummary?.[0] ? escapeMarkdown(change.typespecChangesSummary[0]) : "",
      ]);
    const unresolvedChanges: string[][] = project.breakingChanges
      .filter((change) => !change.isResolved)
      .map((change) => [
        escapeMarkdown(change.id),
        escapeMarkdown(change.breakingChange),
        change.suggestedFix ? escapeMarkdown(change.suggestedFix) : "",
      ]);
    return [
      `**TypeSpec project:** ${project.typespecProject}`,
      "",
      `**SDK package:** ${project.sdkPackage}`,
      "",
      "**Resolved Breaking Changes:**",
      "",
      resolvedChanges.length > 0
        ? details(
            "View resolved breaking changes",
            table([
              ["ID", "Breaking change", "Resolution", "TypeSpec changes"],
              ...resolvedChanges,
            ]),
            true,
          )
        : "None",
      "",
      "**Unresolved Breaking Changes:**",
      "",
      unresolvedChanges.length > 0
        ? table([["ID", "Breaking change", "Suggested resolution"], ...unresolvedChanges])
        : "None",
      "",
    ];
  });

  const changedCode = result.customizationCode.trim();
  const sdkBreakingChangeMitigationSection = section(
    `SDK Breaking Change Mitigation for ${result.sdkLanguage}`,
    "",
  );
  return {
    report: [
      `${renderMarkdownDoc(sdkBreakingChangeMitigationSection, 2)}`,
      "",
      `**Mitigation upon commit:** \`${result.headSha}\``,
      "",
      ...projectSections,
      "**Customization Code:**",
      "",
      changedCode
        ? details("View customization Code", ["````diff", changedCode, "````"].join("\n"))
        : "No mitigation changes were produced.",
      `[View customization code in the workflow summary](${workflowSummaryUrl})`,
      "",
      "<p>💡 Apply the customization code to mitigate the breaking changes.</p>",
      "",
      "<p>💡 For accepted breaking changes, follow the <a href=\"https://github.com/Azure/azure-rest-api-specs/wiki/SDK-Breaking-Changes#how-to-suppress-the-sdk-breaking-changes\">suppression process</a> to suppress them.</p>",
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
}: GitHubScriptArgs & {
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
  core.setOutput("issue_number", buildResult.result.prNumber);
  core.setOutput("head_sha", buildResult.result.headSha);
  await publishResultInComment(
    { github, context, core },
    buildResult.result.prNumber,
    `/azsdk sdk-breaking-mitigate ${buildResult.result.sdkLanguage}`,
    buildResult.report,
    buildResult.result.headSha,
  );
}
