import { table } from "@azure-tools/specs-shared/markdown";
import { getSdkLanguage, SdkName } from "@azure-tools/specs-shared/sdk-types";
import type { IssueComment } from "../comment.ts";
import { sdkLabels } from "./labelling.ts";

export function hasSdkBreakingChanges(labels: string[]): boolean {
  const sdkLabelInfos = Object.values(sdkLabels);

  return sdkLabelInfos.some(
    ({ breakingChange, breakingChangeApproved }) =>
      breakingChange !== undefined &&
      labels.includes(breakingChange) &&
      (breakingChangeApproved === undefined || !labels.includes(breakingChangeApproved)),
  );
}

export function buildSdkBreakingChangesSummary(
  labels: string[],
  comments: IssueComment[],
  headSha: string,
  prUrl: string,
): string {
  const rows: string[][] = [];
  for (const [repo, repoLabels] of Object.entries(sdkLabels)) {
    if (
      !repoLabels.breakingChange ||
      !labels.includes(repoLabels.breakingChange) ||
      (repoLabels.breakingChangeApproved && labels.includes(repoLabels.breakingChangeApproved))
    ) {
      continue;
    }

    const language = getSdkLanguage(repo as SdkName);
    const reportLink = (stage: "analysis" | "mitigate"): string | undefined => {
      const command = `/azsdk sdk-breaking-${stage} ${language}`;
      const report = comments.findLast(
        (comment) =>
          comment.user?.login === "github-actions[bot]" &&
          comment.body?.startsWith(`${command}\n`) &&
          comment.body.includes(`<!-- ${command} -->`) &&
          comment.body.includes(`<!-- sdk-breaking-change-head-sha: ${headSha} -->`),
      );
      return report
        ? `<a href="${prUrl}#issuecomment-${report.id}">View ${stage} Results</a>`
        : undefined;
    };

    const analysis = reportLink("analysis");
    const mitigation = reportLink("mitigate");
    const nextAction =
      (mitigation
        ? "Review the mitigation report, apply any proposed customizations, then rerun SDK validation. "
        : analysis
          ? "Review the analysis and mitigation guidance. "
          : "Check the SDK validation results; analysis is not yet available for this commit. ") +
      `For accepted breaking changes, follow the [suppression process](https://github.com/Azure/azure-rest-api-specs/wiki/SDK-Breaking-Changes#how-to-suppress-the-sdk-breaking-changes) to suppress them.`;
    rows.push([
      language === "DotNet" ? ".NET" : language,
      "Breaking changes detected",
      analysis ?? "Not available for this commit",
      mitigation ?? "Not available for this commit",
      nextAction,
    ]);
  }
  if (rows.length === 0) {
    return "";
  }
  return [
    "",
    "<h3>SDK Breaking Change Detection and Mitigation</h3>",
    table([["Language", "Status", "Analysis", "Mitigation", "Next action"], ...rows]),
    "<p>💡 Mitigation reports contain proposed changes; they do not mean those changes have been applied or validated.</p>",
    "<p>💡 When suppressing breaking changes, ensure to use the original breaking changes.</p>",
    "",
  ].join("\n\n");
}
