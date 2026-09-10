/*
  Entry point for the dedicated "TypeSpec Suppressions Review" pull request
  comment, mirroring the namespace-approval post-results.js pattern.

  Run from the typespec-suppressions-comment.yaml workflow on:
    - workflow_run:completed of "TypeSpec Suppressions - Analyze Code"
    - pull_request_target: labeled / unlabeled (to refresh ✅/❌ on the
      Approved-TypeSpecSuppression label)

  It resolves PR context, reads the current labels for approval state, downloads
  the latest Analyze Code report artifact (by head_sha), and posts or updates a
  sticky comment. When no suppressions require review it resolves any existing
  comment and otherwise does nothing.
*/

import { PER_PAGE_MAX } from "../../../shared/src/github.js";
import { commentOrUpdate, parseExistingComments } from "../comment.js";
import { extractInputs } from "../context.js";
import { removeLabelIfPresent } from "./labels.js";
import {
  buildSuppressionsComment,
  SUPPRESSION_REVIEW_REQUIRED_LABEL,
  TYPESPEC_SUPPRESSIONS_COMMENT_IDENTIFIER,
  TYPESPEC_SUPPRESSIONS_SECTION_TITLE,
} from "./suppressions-comment.js";

const RESOLVED_COMMENT_BODY = `## ${TYPESPEC_SUPPRESSIONS_SECTION_TITLE}\n\n✅ No TypeSpec suppressions require review for the latest commit.`;

/**
 * Applies or removes the TypeSpecSuppressionReviewRequired prerequisite label so
 * it tracks requiresApproval, mirroring the package-name-review-required pattern
 * in package-name-approval/post-results.js. Only called once a definitive
 * requiresApproval result is available (see caller).
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments["github"]} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {number} issue_number
 * @param {string[]} labelNames
 * @param {boolean} requiresApproval
 */
async function syncReviewRequiredLabel(
  github,
  core,
  owner,
  repo,
  issue_number,
  labelNames,
  requiresApproval,
) {
  const hasLabel = labelNames.includes(SUPPRESSION_REVIEW_REQUIRED_LABEL);
  if (requiresApproval && !hasLabel) {
    core.info(
      `Applying ${SUPPRESSION_REVIEW_REQUIRED_LABEL} label on ${owner}/${repo}#${issue_number}.`,
    );
    await github.rest.issues.addLabels({
      owner,
      repo,
      issue_number,
      labels: [SUPPRESSION_REVIEW_REQUIRED_LABEL],
    });
  } else if (!requiresApproval && hasLabel) {
    core.info(
      `Removing ${SUPPRESSION_REVIEW_REQUIRED_LABEL} label on ${owner}/${repo}#${issue_number}.`,
    );
    await removeLabelIfPresent(
      github,
      owner,
      repo,
      issue_number,
      SUPPRESSION_REVIEW_REQUIRED_LABEL,
    );
  }
}

/**
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function postSuppressionsResults({ github, context, core }) {
  const { owner, repo, issue_number, head_sha } = await extractInputs(github, context, core);

  const { data: pr } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: issue_number,
  });
  /** @type {string[]} */
  const labelNames = pr.labels.map((/** @type {{ name?: string }} */ label) => label.name ?? "");

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
    // Analysis hasn't completed (or its report couldn't be read) — the
    // requiresApproval state is unknown, so leave the review-required label
    // and any existing comment untouched rather than guessing.
    core.info(
      `TypeSpec suppressions analysis result unavailable for ${owner}/${repo}#${issue_number}; leaving labels and comment untouched.`,
    );
    return;
  }

  const { body, requiresApproval } = result;

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
