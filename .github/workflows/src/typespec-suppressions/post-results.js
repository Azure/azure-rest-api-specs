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
import {
  buildSuppressionsComment,
  TYPESPEC_SUPPRESSIONS_COMMENT_IDENTIFIER,
  TYPESPEC_SUPPRESSIONS_SECTION_TITLE,
} from "./suppressions-comment.js";

const RESOLVED_COMMENT_BODY = `## ${TYPESPEC_SUPPRESSIONS_SECTION_TITLE}\n\n✅ No TypeSpec suppressions require review for the latest commit.`;

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

  const body = await buildSuppressionsComment(github, core, owner, repo, head_sha, labelNames);

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
