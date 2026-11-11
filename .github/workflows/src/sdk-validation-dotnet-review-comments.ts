import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import { commentOrUpdate } from "./comment.ts";
import type { GitHubScriptArgs } from "./github.ts";

export const SDK_REVIEW_SUMMARY_MARKER = "generated-dotnet-sdk-review-summary";
export const MAX_INLINE_SDK_REVIEW_COMMENTS = 25;
export const MAX_SUMMARY_FINDINGS = 100;
export const MAX_SUMMARY_BODY_LENGTH = 60_000;

const BOT_LOGIN = "github-actions[bot]";
const INLINE_MARKER_PATTERN = /<!-- generated-dotnet-sdk-review-inline:(\d+):(\d+) -->/;

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

type ReviewComment = {
  id: number;
  body?: string;
  line?: number | null;
  original_line?: number | null;
  path: string;
  user?: {
    login: string;
  } | null;
};

function truncate(value: string, maximumLength: number): string {
  if (value.length <= maximumLength) {
    return value;
  }
  return `${value.slice(0, maximumLength - 1)}…`;
}

function sanitizeMarkdownText(value: string, maximumLength = 1000): string {
  return truncate(
    value
      .replace(/\p{Cc}|[\u202A-\u202E\u2066-\u2069]/gu, "")
      .replace(/([\\`*_#[\]<>|])/g, "\\$1")
      .replace(/@(?=[A-Za-z0-9])/g, "@\u200B")
      .trim(),
    maximumLength,
  );
}

function inlineCode(value: string): string {
  return `\`${truncate(
    value
      .replace(/\p{Cc}/gu, " ")
      .replaceAll("`", "'")
      .trim(),
    500,
  )}\``;
}

function getInlineMarker(finding: PublishableRemediationFinding): string {
  return `<!-- generated-dotnet-sdk-review-inline:${finding.reviewIndex}:${finding.findingIndex} -->`;
}

function isInlineCandidate(finding: PublishableRemediationFinding): boolean {
  return (
    finding.remediation.confidence === "high" &&
    finding.remediation.sourceLocation !== undefined &&
    ["typespec", "client.tsp"].includes(finding.remediation.target)
  );
}

function buildInlineComment(finding: PublishableRemediationFinding): string {
  const generatedLocation = `${finding.generatedLocation.file}:${finding.generatedLocation.line}`;
  return [
    `**${sanitizeMarkdownText(finding.title, 300)}** (${sanitizeMarkdownText(finding.severity, 20)})`,
    "",
    sanitizeMarkdownText(finding.evidence),
    "",
    `Suggested change: ${sanitizeMarkdownText(finding.remediation.suggestion, 1500)}`,
    "",
    `Generated SDK: ${inlineCode(generatedLocation)}`,
    getInlineMarker(finding),
  ].join("\n");
}

function buildFindingSummary(
  finding: PublishableRemediationFinding,
  inlineKeys: Set<string>,
): string {
  const key = `${finding.reviewIndex}:${finding.findingIndex}`;
  const location = finding.remediation.sourceLocation;
  const lines = [
    `- **${sanitizeMarkdownText(finding.title, 300)}**`,
    `  - Classification: ${inlineKeys.has(key) ? "inline" : "summary"}; severity ${sanitizeMarkdownText(finding.severity, 20)}; target ${inlineCode(finding.remediation.target)}; confidence ${sanitizeMarkdownText(finding.remediation.confidence, 20)}`,
    `  - Suggested change: ${sanitizeMarkdownText(finding.remediation.suggestion, 1000)}`,
    `  - Generated SDK: ${inlineCode(`${finding.generatedLocation.file}:${finding.generatedLocation.line}`)}`,
  ];
  if (location) {
    lines.push(`  - TypeSpec: ${inlineCode(`${location.file}:${location.line}`)}`);
  }
  return lines.join("\n");
}

export function buildSdkReviewSummary(params: {
  findings: PublishableRemediationFinding[];
  headSha: string;
  inlineFindings: PublishableRemediationFinding[];
}): string {
  const { findings, headSha, inlineFindings } = params;
  if (findings.length === 0) {
    return [
      "## Generated .NET SDK review",
      "",
      `No high-confidence generated SDK defects were found for commit ${inlineCode(headSha)}.`,
    ].join("\n");
  }

  const inlineKeys = new Set(
    inlineFindings.map((finding) => `${finding.reviewIndex}:${finding.findingIndex}`),
  );
  const lines = [
    "## Generated .NET SDK review",
    "",
    `Reviewed commit ${inlineCode(headSha)}. Posted ${inlineFindings.length} exact changed-line comment${inlineFindings.length === 1 ? "" : "s"}. All findings are listed below.`,
    "",
  ];
  let displayedFindingCount = 0;
  for (const finding of findings.slice(0, MAX_SUMMARY_FINDINGS)) {
    const block = buildFindingSummary(finding, inlineKeys);
    if ([...lines, block].join("\n").length > MAX_SUMMARY_BODY_LENGTH - 250) {
      break;
    }
    lines.push(block);
    displayedFindingCount += 1;
  }
  if (displayedFindingCount < findings.length) {
    lines.push(
      "",
      `${findings.length - displayedFindingCount} additional findings were omitted from this comment. Check the workflow artifact for the complete validated result.`,
    );
  }
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

export async function syncSdkReviewInlineComments(
  { github, context, core }: GitHubScriptArgs,
  pullNumber: number,
  headSha: string,
  findings: PublishableRemediationFinding[],
): Promise<PublishableRemediationFinding[]> {
  const inlineFindings = findings
    .filter(isInlineCandidate)
    .slice(0, MAX_INLINE_SDK_REVIEW_COMMENTS);
  const existingComments = (await github.paginate(github.rest.pulls.listReviewComments, {
    owner: context.repo.owner,
    repo: context.repo.repo,
    pull_number: pullNumber,
    per_page: PER_PAGE_MAX,
  })) as ReviewComment[];
  const managedComments = existingComments.filter(
    (comment) =>
      comment.user?.login === BOT_LOGIN &&
      typeof comment.body === "string" &&
      INLINE_MARKER_PATTERN.test(comment.body),
  );
  const retainedCommentIds = new Set<number>();
  const deletedCommentIds = new Set<number>();

  for (const finding of inlineFindings) {
    const sourceLocation = finding.remediation.sourceLocation!;
    const marker = getInlineMarker(finding);
    const body = buildInlineComment(finding);
    const matches = managedComments.filter((comment) => comment.body?.includes(marker));
    const existing = matches.at(-1);
    for (const duplicate of matches.slice(0, -1)) {
      await github.rest.pulls.deleteReviewComment({
        owner: context.repo.owner,
        repo: context.repo.repo,
        comment_id: duplicate.id,
      });
      deletedCommentIds.add(duplicate.id);
    }

    const existingLine = existing?.line ?? existing?.original_line;
    if (existing && existing.path === sourceLocation.file && existingLine === sourceLocation.line) {
      retainedCommentIds.add(existing.id);
      if (existing.body !== body) {
        await github.rest.pulls.updateReviewComment({
          owner: context.repo.owner,
          repo: context.repo.repo,
          comment_id: existing.id,
          body,
        });
      }
      continue;
    }
    const { data } = await github.rest.pulls.createReviewComment({
      owner: context.repo.owner,
      repo: context.repo.repo,
      pull_number: pullNumber,
      commit_id: headSha,
      path: sourceLocation.file,
      line: sourceLocation.line,
      side: "RIGHT",
      body,
    });
    retainedCommentIds.add(data.id);
    if (existing) {
      await github.rest.pulls.deleteReviewComment({
        owner: context.repo.owner,
        repo: context.repo.repo,
        comment_id: existing.id,
      });
      deletedCommentIds.add(existing.id);
    }
  }

  for (const comment of managedComments) {
    if (!retainedCommentIds.has(comment.id) && !deletedCommentIds.has(comment.id)) {
      await github.rest.pulls.deleteReviewComment({
        owner: context.repo.owner,
        repo: context.repo.repo,
        comment_id: comment.id,
      });
    }
  }
  core.info(`Published ${inlineFindings.length} generated SDK review inline comments.`);
  return inlineFindings;
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
    BOT_LOGIN,
  );
}
