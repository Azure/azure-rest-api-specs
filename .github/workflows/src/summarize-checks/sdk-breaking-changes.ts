import { table } from "@azure-tools/specs-shared/markdown";
import {
  getSdkLanguage,
  sdkLabels,
  SdkName,
  type SdkLabelInfo,
} from "@azure-tools/specs-shared/sdk-types";
import type { IssueComment } from "../comment.ts";

export function hasSdkBreakingChanges(labels: string[]): boolean {
  const sdkLabelInfos: SdkLabelInfo[] = Object.values(sdkLabels);

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
      return report ? `<a href="${prUrl}#issuecomment-${report.id}">View Results</a>` : undefined;
    };

    const analysis = reportLink("analysis");
    const mitigation = reportLink("mitigate");
    const nextAction =
      (mitigation
        ? "Review the mitigation report, apply any proposed customizations, then rerun SDK validation. "
        : analysis
          ? "Review the analysis and mitigation guidance. "
          : "Check the SDK validation results; analysis is not yet available for this commit. ") +
      `For accepted breaking changes, request <code>${repoLabels.breakingChangeApproved}</code> from an authorized reviewer.`;
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
    "<h3>SDK Breaking Change detection and mitigation</h3>",
    table([["Language", "Status", "Analysis", "Mitigation", "Next action"], ...rows]),
    "<p>Mitigation reports contain proposed changes; they do not mean those changes have been applied or validated.</p>",
    "",
  ].join("\n\n");
}
