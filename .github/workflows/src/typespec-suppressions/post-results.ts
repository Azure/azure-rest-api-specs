import type { GitHubScriptArgs } from "@azure-tools/github-core/github";
/*
  Entry point for the dedicated "TypeSpec Suppressions Review" pull request
  comment, mirroring the namespace-approval post-results.js pattern.

  Run from the typespec-suppressions-comment.yaml workflow on:
    - workflow_run:completed of "TypeSpec Suppressions - Analyze Code"
    - pull_request_target: labeled / unlabeled (to refresh ✅/❌ on the
      typespec-suppressions-approved label)

  It resolves PR context, reads the current labels for approval state, downloads
  the latest Analyze Code report artifact (by head_sha), and posts or updates a
  sticky comment. When no suppressions require review it resolves any existing
  comment and otherwise does nothing.
*/

import { TypeSpecSuppressionLabel } from "@azure-tools/specs-shared/labels";
import { PER_PAGE_MAX } from "../../../shared/src/github.ts";
import { commentOrUpdate, parseExistingComments } from "@azure-tools/github-core/comment";
import { extractInputs } from "@azure-tools/github-core/context";
import { removeLabelIfPresent } from "../package-name-approval/labels.ts";
import {
  buildSuppressionsComment,
  renderSuppressionsCommentBody,
  shouldInvalidateSuppressionApproval,
  TYPESPEC_SUPPRESSIONS_COMMENT_IDENTIFIER,
  TYPESPEC_SUPPRESSIONS_SECTION_TITLE,
} from "./suppressions-comment.ts";

const RESOLVED_COMMENT_BODY = `## ${TYPESPEC_SUPPRESSIONS_SECTION_TITLE}\n\n✅ No TypeSpec suppressions require review for the latest commit.`;

async function syncReviewRequiredLabel(
  github: GitHubScriptArgs["github"],
  core: GitHubScriptArgs["core"],
  owner: string,
  repo: string,
  issueNumber: number,
  labelNames: string[],
  requiresApproval: boolean,
) {
  const hasLabel = labelNames.includes(TypeSpecSuppressionLabel.ReviewRequired);
  if (requiresApproval && !hasLabel) {
    core.info(
      `Applying ${TypeSpecSuppressionLabel.ReviewRequired} label on ${owner}/${repo}#${issueNumber}.`,
    );
    await github.rest.issues.addLabels({
      owner,
      repo,
      issue_number: issueNumber,
      labels: [TypeSpecSuppressionLabel.ReviewRequired],
    });
  } else if (!requiresApproval && hasLabel) {
    core.info(
      `Removing ${TypeSpecSuppressionLabel.ReviewRequired} label on ${owner}/${repo}#${issueNumber}.`,
    );
    await removeLabelIfPresent(
      github,
      owner,
      repo,
      issueNumber,
      TypeSpecSuppressionLabel.ReviewRequired,
    );
  }
}

export default async function postSuppressionsResults({ github, context, core }: GitHubScriptArgs) {
  const { owner, repo, issue_number, head_sha } = await extractInputs(github, context, core);

  const { data: pr } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: issue_number,
  });

  const labelNames: string[] = pr.labels.map((label: { name?: string }) => label.name ?? "");
  const isNewAnalysis = context.eventName === "workflow_run";

  const result = await buildSuppressionsComment(
    github,
    core,
    owner,
    repo,
    head_sha,
    issue_number,
    labelNames,
  );

  if (!result) {
    core.info(
      `TypeSpec suppressions analysis result unavailable for ${owner}/${repo}#${issue_number}; leaving labels and comment untouched.`,
    );
    return;
  }

  let { body } = result;
  const { requiresApproval } = result;

  if (isNewAnalysis && labelNames.includes(TypeSpecSuppressionLabel.Approved)) {
    const invalidateApproval = await shouldInvalidateSuppressionApproval(
      github,
      core,
      owner,
      repo,
      issue_number,
      result.run,
      result.report,
    );
    if (invalidateApproval) {
      core.info(
        `Removing ${TypeSpecSuppressionLabel.Approved} label because the approval-relevant analysis changed on ${owner}/${repo}#${issue_number}.`,
      );
      await removeLabelIfPresent(
        github,
        owner,
        repo,
        issue_number,
        TypeSpecSuppressionLabel.Approved,
      );
      body = renderSuppressionsCommentBody(result.report, {
        owner,
        repo,
        pullNumber: issue_number,
        isApproved: false,
        runUrl: result.runUrl,
      });
    } else {
      core.info(
        `Preserving ${TypeSpecSuppressionLabel.Approved} because the approval-relevant analysis did not change on ${owner}/${repo}#${issue_number}.`,
      );
    }
  }

  await syncReviewRequiredLabel(
    github,
    core,
    owner,
    repo,
    issue_number,
    labelNames,
    requiresApproval,
  );

  if (body) {
    core.info(`Posting TypeSpec suppressions review comment on ${owner}/${repo}#${issue_number}.`);
    await commentOrUpdate(
      github,
      core,
      owner,
      repo,
      issue_number,
      body,
      TYPESPEC_SUPPRESSIONS_COMMENT_IDENTIFIER,
    );
    return;
  }

  // No suppressions require review. Only touch the PR if a prior comment exists,
  // updating it to a resolved note; otherwise do nothing (mirrors namespace,
  // which only comments when relevant).
  const comments = await github.paginate(github.rest.issues.listComments, {
    owner,
    repo,
    issue_number,
    per_page: PER_PAGE_MAX,
  });
  const [existingCommentId] = parseExistingComments(
    comments,
    TYPESPEC_SUPPRESSIONS_COMMENT_IDENTIFIER,
  );
  if (existingCommentId !== undefined) {
    core.info(
      `No suppressions require review; resolving existing comment on ${owner}/${repo}#${issue_number}.`,
    );
    await commentOrUpdate(
      github,
      core,
      owner,
      repo,
      issue_number,
      RESOLVED_COMMENT_BODY,
      TYPESPEC_SUPPRESSIONS_COMMENT_IDENTIFIER,
    );
    return;
  }

  core.info(
    `No TypeSpec suppressions require review and no existing comment on ${owner}/${repo}#${issue_number}; nothing to do.`,
  );
}
