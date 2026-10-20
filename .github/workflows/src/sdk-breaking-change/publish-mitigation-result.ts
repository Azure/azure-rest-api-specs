import type { GitHubScriptArgs } from "../github.ts";
import { readFile } from "node:fs/promises";
import {
  details,
  escapeMarkdown,
  renderMarkdownDoc,
  section,
  table,
} from "@azure-tools/specs-shared/markdown";
import { MarkdownHeadingId, type MitigationResult, MitigationResultSchema } from "./types.ts";
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
    const changes: string[][] = project.breakingChanges.map((change) => [
      change.isResolved ? "✔️" : "❌",
      `[${escapeMarkdown(change.id)}](${workflowSummaryUrl}#breaking-change-${escapeMarkdown(change.id)}-${MarkdownHeadingId.BreakingChange} "How to Suppress")`,
      escapeMarkdown(change.breakingChange),
      change.suggestedFix ? escapeMarkdown(change.suggestedFix) : "",
      change.typespecChangesSummary?.[0] ? escapeMarkdown(change.typespecChangesSummary[0]) : "",
    ]);
    return [
      `**TypeSpec project:** ${project.typespecProject}`,
      "",
      `**SDK package:** ${project.sdkPackage}`,
      "",
      "**Breaking Changes:**",
      "",
      changes.length > 0
        ? details(
            "View breaking changes",
            table([
              ["Resolvable", "ID", "Breaking change", "Resolution", "TypeSpec changes"],
              ...changes,
            ]),
            true,
          )
        : "None",
      "",
    ];
  });

  const changedCode = result.customizationCode.trim();
  const sdkBreakingChangeMitigationSection = section(
    `SDK Breaking Change Mitigation for ${result.sdkLanguage}`,
    "",
  );
  const nextStep = section(
    "Next Steps",
    `<p>💡 Apply Mitigation: Apply the customization code to mitigate the breaking changes.</p>\n\n<p>💡 Suppress Breaking Changes: For accepted breaking changes, click the breaking change ID link to view suppression instructions and follow the suppression process.</p>`,
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
      "",
      `[View customization code in the workflow summary](${workflowSummaryUrl})`,
      "",
      renderMarkdownDoc(nextStep, 2),
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
