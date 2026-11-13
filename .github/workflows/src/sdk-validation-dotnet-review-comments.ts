import { escapeMarkdown, inlineCode, link } from "../../shared/src/markdown.ts";
import { commentOrUpdate } from "./comment.ts";
import type { GitHubScriptArgs } from "./github.ts";

export const SDK_REVIEW_SUMMARY_MARKER = "generated-dotnet-sdk-review-summary";
export const MAX_SUMMARY_FINDINGS = 100;
export const MAX_SUMMARY_BODY_LENGTH = 60_000;

type SourceLocation = {
  file: string;
  line: number;
};

export type PublishableRemediationFinding = {
  reviewIndex: number;
  findingIndex: number;
  severity: string;
  generatedLocation: {
    file: string;
    line: number;
  };
  title: string;
  evidence: string;
  remediation: {
    target: string;
    suggestion: string;
    confidence: string;
    sourceLocation?: SourceLocation;
  };
};

function truncate(value: string, maximumLength: number): string {
  if (value.length <= maximumLength) {
    return value;
  }
  return `${value.slice(0, maximumLength - 1)}…`;
}

function sanitizeMarkdownText(value: string, maximumLength = 1000): string {
  return truncate(
    escapeMarkdown(value.replace(/\p{Cc}|[\u202A-\u202E\u2066-\u2069]/gu, "").trim()),
    maximumLength,
  );
}

function buildFindingSummary(
  finding: PublishableRemediationFinding,
  headSha: string,
  repositoryUrl: string,
): string {
  const location = finding.remediation.sourceLocation;
  const lines = [
    `- **${sanitizeMarkdownText(finding.title, 300)}**`,
    `  - Severity: ${sanitizeMarkdownText(finding.severity, 20)}; target ${inlineCode(finding.remediation.target)}; confidence ${sanitizeMarkdownText(finding.remediation.confidence, 20)}`,
    `  - Evidence: ${sanitizeMarkdownText(finding.evidence, 1500)}`,
    `  - Suggested change: ${sanitizeMarkdownText(finding.remediation.suggestion, 1000)}`,
    `  - Generated SDK: ${inlineCode(`${finding.generatedLocation.file}:${finding.generatedLocation.line}`)}`,
  ];
  if (location) {
    const encodedPath = location.file.split("/").map(encodeURIComponent).join("/");
    const sourceUrl = `${repositoryUrl}/blob/${headSha}/${encodedPath}#L${location.line}`;
    lines.push(`  - TypeSpec: ${link(inlineCode(`${location.file}:${location.line}`), sourceUrl)}`);
  }
  return lines.join("\n");
}

export function buildSdkReviewSummary(params: {
  findings: PublishableRemediationFinding[];
  headSha: string;
  repositoryUrl: string;
  workflowRunUrl: string;
}): string {
  const { findings, headSha, repositoryUrl, workflowRunUrl } = params;
  if (findings.length === 0) {
    return [
      "## Generated .NET SDK review",
      "",
      `No high-confidence generated SDK defects were found for commit ${inlineCode(headSha)}.`,
      "",
      link("View validated workflow results", workflowRunUrl),
    ].join("\n");
  }

  const lines = [
    "## Generated .NET SDK review",
    "",
    `Reviewed commit ${inlineCode(headSha)}. All validated findings are listed below.`,
    "",
  ];
  let displayedFindingCount = 0;
  for (const finding of findings.slice(0, MAX_SUMMARY_FINDINGS)) {
    const block = buildFindingSummary(finding, headSha, repositoryUrl);
    if ([...lines, block].join("\n").length > MAX_SUMMARY_BODY_LENGTH - 250) {
      break;
    }
    lines.push(block);
    displayedFindingCount += 1;
  }
  if (displayedFindingCount < findings.length) {
    lines.push(
      "",
      `${findings.length - displayedFindingCount} additional findings were omitted from this comment.`,
    );
  }
  lines.push("", link("View complete validated workflow results", workflowRunUrl));
  return lines.join("\n");
}

export function buildSdkReviewFailureSummary(headSha: string, workflowRunUrl: string): string {
  return [
    "## Generated .NET SDK review",
    "",
    `The review did not finish for commit ${inlineCode(headSha)}, so no new findings were published.`,
    "",
    `Rerun the SDK validation workflow for the current PR head. [Review workflow run](${workflowRunUrl})`,
  ].join("\n");
}

export async function publishSdkReviewSummary(
  { github, context, core }: GitHubScriptArgs,
  pullNumber: number,
  body: string,
): Promise<void> {
  await commentOrUpdate(
    github,
    core,
    context.repo.owner,
    context.repo.repo,
    pullNumber,
    body,
    SDK_REVIEW_SUMMARY_MARKER,
    "github-actions[bot]",
  );
}
