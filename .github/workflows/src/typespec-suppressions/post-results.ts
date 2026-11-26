import type { GitHubScriptArgs, WebhookEvent } from "../github.ts";
/*
  Entry point for the dedicated "TypeSpec Suppressions Review" pull request
  comment, mirroring the namespace-approval post-results.js pattern.

  Run from the typespec-suppressions-status.yaml workflow on:
    - workflow_run:completed of "TypeSpec Suppressions - Analyze Code"
    - pull_request_target: labeled / unlabeled (to refresh ✅/❌ on the
      typespec-suppressions-approved label)

  It resolves PR context, reads the current labels for approval state, downloads
  the latest Analyze Code report artifact (by head_sha), and posts or updates a
  sticky comment. When no suppressions require review it resolves any existing
  comment and otherwise does nothing.
*/

import { PER_PAGE_MAX } from "../../../shared/src/github.ts";
import { extractInputs } from "../context.ts";
import {
  TYPESPEC_SUPPRESSIONS_APPROVED_LABEL,
  TYPESPEC_SUPPRESSIONS_REVIEW_REQUIRED_LABEL,
} from "../label.ts";
import { removeLabelIfPresent } from "../package-name-approval/labels.ts";
import {
  buildSuppressionsComment,
  getSuppressionApprovalFingerprint,
  renderSuppressionsCommentBody,
  TYPESPEC_SUPPRESSIONS_COMMENT_IDENTIFIER,
  TYPESPEC_SUPPRESSIONS_SECTION_TITLE,
} from "./suppressions-comment.ts";

const RESOLVED_COMMENT_BODY = `## ${TYPESPEC_SUPPRESSIONS_SECTION_TITLE}\n\n✅ No TypeSpec suppressions require review for the latest commit.`;
const REAPPROVAL_MESSAGE = `The approved suppression content changed or could not be verified. An authorized reviewer must review the current report and reapply \`${TYPESPEC_SUPPRESSIONS_APPROVED_LABEL}\`.`;
const APPROVAL_METADATA = /<!-- TypeSpecSuppressionsApproval:v1:([a-f0-9]{64}):(\d+) -->/;

async function syncReviewRequiredLabel(
  github: GitHubScriptArgs["github"],
  core: GitHubScriptArgs["core"],
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

export default async function postSuppressionsResults({ github, context, core }: GitHubScriptArgs) {
  const { owner, repo, issue_number, head_sha } = await extractInputs(github, context, core);

  const { data: pr } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: issue_number,
  });

  if (pr.state !== "open" || pr.head.sha !== head_sha) {
    core.info("Skipping TypeSpec suppressions update for a closed PR or superseded head.");
    return;
  }

  const labelNames = pr.labels.map((label) => label.name);
  let isApproved = labelNames.includes(TYPESPEC_SUPPRESSIONS_APPROVED_LABEL);
  const comments = await github.paginate(github.rest.issues.listComments, {
    owner,
    repo,
    issue_number,
    per_page: PER_PAGE_MAX,
  });
  const existingComment = comments.findLast(
    (comment) =>
      comment.user?.login === "github-actions[bot]" &&
      comment.user.type === "Bot" &&
      comment.body?.includes(`<!-- ${TYPESPEC_SUPPRESSIONS_COMMENT_IDENTIFIER} -->`),
  );
  const metadata = existingComment?.body?.match(APPROVAL_METADATA);
  let approvedFingerprint = isApproved ? metadata?.[1] : undefined;
  let approvalEventId = isApproved ? metadata?.[2] : undefined;

  const result = await buildSuppressionsComment(
    github,
    core,
    owner,
    repo,
    head_sha,
    issue_number,
    labelNames,
  );

  const fingerprint = result && getSuppressionApprovalFingerprint(result.report);
  const approvalPayload = context.payload as WebhookEvent<"pull-request", "labeled">;
  const isApprovalEvent =
    context.eventName === "pull_request_target" &&
    approvalPayload.action === "labeled" &&
    approvalPayload.label?.name === TYPESPEC_SUPPRESSIONS_APPROVED_LABEL;

  if (isApproved && isApprovalEvent && result) {
    const events = await github.paginate(github.rest.issues.listEvents, {
      owner,
      repo,
      issue_number,
      per_page: PER_PAGE_MAX,
    });
    const latestLabelEvent = events.findLast(
      (event) =>
        (event.event === "labeled" || event.event === "unlabeled") &&
        "label" in event &&
        event.label?.name === TYPESPEC_SUPPRESSIONS_APPROVED_LABEL,
    );
    // Protected-label authorization remains enforced by the Automation App. Bind only
    // an analysis that completed before this label application; never approve a later rerun.
    if (
      latestLabelEvent?.event === "labeled" &&
      latestLabelEvent.actor?.login === approvalPayload.sender?.login &&
      String(latestLabelEvent.id) !== approvalEventId &&
      Date.parse(result.run.updated_at) <= Date.parse(latestLabelEvent.created_at)
    ) {
      approvedFingerprint = fingerprint;
      approvalEventId = String(latestLabelEvent.id);
    }
  }

  let needsReapproval = false;
  if (isApproved) {
    if (!fingerprint || approvedFingerprint !== fingerprint) {
      core.warning(REAPPROVAL_MESSAGE);
      await removeLabelIfPresent(
        github,
        owner,
        repo,
        issue_number,
        TYPESPEC_SUPPRESSIONS_APPROVED_LABEL,
      );
      isApproved = false;
      approvedFingerprint = undefined;
      approvalEventId = undefined;
      needsReapproval = true;
    } else {
      core.info("Preserving TypeSpec suppression approval: approved content is unchanged.");
    }
  }

  if (!result && !needsReapproval) {
    core.warning(
      "TypeSpec suppressions analysis unavailable; leaving the review comment untouched.",
    );
    return;
  }

  if (result) {
    await syncReviewRequiredLabel(
      github,
      core,
      owner,
      repo,
      issue_number,
      labelNames,
      result.requiresApproval,
    );
  }

  let body = result
    ? renderSuppressionsCommentBody(result.report, {
        owner,
        repo,
        pullNumber: issue_number,
        isApproved,
        runUrl: result.runUrl,
      })
    : `## ${TYPESPEC_SUPPRESSIONS_SECTION_TITLE}\n\n❌ Analysis unavailable.`;
  if (!body && !existingComment && !needsReapproval) {
    return;
  }
  body ??= RESOLVED_COMMENT_BODY;
  if (needsReapproval) {
    body += `\n\n${REAPPROVAL_MESSAGE}`;
  }
  if (isApproved && approvedFingerprint && approvalEventId) {
    body += `\n<!-- TypeSpecSuppressionsApproval:v1:${approvedFingerprint}:${approvalEventId} -->`;
  }
  body += `\n<!-- ${TYPESPEC_SUPPRESSIONS_COMMENT_IDENTIFIER} -->`;

  if (existingComment) {
    if (existingComment.body !== body) {
      await github.rest.issues.updateComment({
        owner,
        repo,
        comment_id: existingComment.id,
        body,
      });
      core.info(`Updated TypeSpec suppressions review comment ${existingComment.id}.`);
    }
  } else {
    await github.rest.issues.createComment({ owner, repo, issue_number, body });
    core.info("Created TypeSpec suppressions review comment.");
  }
}
