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

import { PER_PAGE_MAX } from "../../../shared/src/github.ts";
import { commentOrUpdate, parseExistingComments } from "../comment.ts";
import { extractInputs } from "../context.ts";
import {
  TYPESPEC_SUPPRESSIONS_APPROVED_LABEL,
  TYPESPEC_SUPPRESSIONS_REVIEW_REQUIRED_LABEL,
} from "../label.ts";
import { removeLabelIfPresent } from "../package-name-approval/labels.ts";
import {
  buildSuppressionsComment,
  TYPESPEC_SUPPRESSIONS_COMMENT_IDENTIFIER,
  TYPESPEC_SUPPRESSIONS_SECTION_TITLE,
} from "./suppressions-comment.ts";

const RESOLVED_COMMENT_BODY = `## ${TYPESPEC_SUPPRESSIONS_SECTION_TITLE}\n\n✅ No TypeSpec suppressions require review for the latest commit.`;

async function syncReviewRequiredLabel(
  github: import("@actions/github-script").AsyncFunctionArguments["github"],
  core: import("../github.ts").Core,
  owner: string,
  repo: string,
  issueNumber: number,
  labelNames: string[],
  requiresApproval: boolean,
) {
  const hasLabel = labelNames.includes(TYPESPEC_SUPPRESSIONS_REVIEW_REQUIRED_LABEL);
  if (requiresApproval && !hasLabel) {
    core.info(
      `Applying ${TYPESPEC_SUPPRESSIONS_REVIEW_REQUIRED_LABEL} label on ${owner}/${repo}#${issueNumber}.`,
    );
    await github.rest.issues.addLabels({
      owner,
      repo,
      issue_number: issueNumber,
      labels: [TYPESPEC_SUPPRESSIONS_REVIEW_REQUIRED_LABEL],
    });
  } else if (!requiresApproval && hasLabel) {
    core.info(
      `Removing ${TYPESPEC_SUPPRESSIONS_REVIEW_REQUIRED_LABEL} label on ${owner}/${repo}#${issueNumber}.`,
    );
    await removeLabelIfPresent(
      github,
      owner,
      repo,
      issueNumber,
      TYPESPEC_SUPPRESSIONS_REVIEW_REQUIRED_LABEL,
    );
  }
}

export default async function postSuppressionsResults({
  github,
  context,
  core,
}: import("@actions/github-script").AsyncFunctionArguments) {
  const { owner, repo, issue_number, head_sha } = await extractInputs(github, context, core);

  const { data: pr } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: issue_number,
  });

  const labelNames: string[] = pr.labels.map((label: { name?: string }) => label.name ?? "");
  const isNewAnalysis = context.eventName === "workflow_run";
  const effectiveLabelNames = isNewAnalysis
    ? labelNames.filter((label) => label !== TYPESPEC_SUPPRESSIONS_APPROVED_LABEL)
    : labelNames;

  const result = await buildSuppressionsComment(
    github,
    core,
    owner,
    repo,
    head_sha,
    issue_number,
    effectiveLabelNames,
  );

  if (!result) {
    core.info(
      `TypeSpec suppressions analysis result unavailable for ${owner}/${repo}#${issue_number}; leaving labels and comment untouched.`,
    );
    return;
  }

  const { body, requiresApproval } = result;

  if (isNewAnalysis && labelNames.includes(TYPESPEC_SUPPRESSIONS_APPROVED_LABEL)) {
    core.info(
      `Removing ${TYPESPEC_SUPPRESSIONS_APPROVED_LABEL} label for new analysis result on ${owner}/${repo}#${issue_number}.`,
    );
    await removeLabelIfPresent(
      github,
      owner,
      repo,
      issue_number,
      TYPESPEC_SUPPRESSIONS_APPROVED_LABEL,
    );
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
