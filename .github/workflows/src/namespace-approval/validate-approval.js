import { extractInputs } from "../context.js";
import { loadApproversConfig } from "./approvers.js";
import { removeLabelIfPresent } from "./labels.js";

/**
 * @typedef {Object} ValidateContext
 * @property {import("@actions/github-script").AsyncFunctionArguments["github"]} github
 * @property {import("@actions/github-script").AsyncFunctionArguments["context"]} context
 * @property {import("@actions/github-script").AsyncFunctionArguments["core"]} core
 * @property {import("./approvers.js").ApproversConfig} approversConfig
 * @property {string} owner
 * @property {string} repo
 * @property {string} targetLabel
 * @property {string} actor
 * @property {number} prNumber
 * @property {boolean} isMgmt
 */

/** @type {string[]} */
const ALLOWED_BOT_LOGINS = ["github-actions[bot]", "azure-sdk"];

/**
 * Get all authorized approvers as a flat list.
 *
 * @param {import("./approvers.js").ApproversConfig} approversConfig
 * @returns {string[]}
 */
function getAllApprovers(approversConfig) {
  const mgmtApprovers = approversConfig["management-plane"]?.all ?? [];
  /** @type {string[][]} */
  const dpValues = Object.values(approversConfig["data-plane"] ?? {});
  return [...new Set([...mgmtApprovers, ...dpValues.flat()])];
}

/**
 * Handle unlabeled event: re-apply pending labels if removed by unauthorized user.
 *
 * @param {ValidateContext} ctx
 */
async function handleUnlabeled({
  github,
  core,
  approversConfig,
  owner,
  repo,
  targetLabel,
  actor,
  prNumber,
}) {
  const isNamespacePending =
    targetLabel.startsWith("namespace-") && targetLabel.endsWith("-pending");
  if (!isNamespacePending && targetLabel !== "namespace-review-required") {
    core.info(`${targetLabel} is not a namespace label, skipping`);
    return;
  }

  if (ALLOWED_BOT_LOGINS.includes(actor)) {
    core.info(`${actor} is a trusted bot, allowing label removal`);
    return;
  }

  /** @type {string[]} */
  const allApprovers = getAllApprovers(approversConfig);
  if (allApprovers.includes(actor)) {
    core.info(`${actor} is an authorized approver, allowing label removal`);
    return;
  }

  core.warning(`${actor} is not authorized to remove ${targetLabel}, re-applying`);

  await github.rest.issues.addLabels({
    owner,
    repo,
    issue_number: prNumber,
    labels: [targetLabel],
  });

  await github.rest.issues.createComment({
    owner,
    repo,
    issue_number: prNumber,
    body: `⚠️ @${actor} is not authorized to remove \`${targetLabel}\`. Only authorized namespace approvers can remove namespace labels.\n\nLabel has been re-applied.`,
  });
}

/**
 * Handle labeled event: validate approval labels from authorized approvers.
 *
 * @param {ValidateContext & { labels: string[] }} ctx
 */
async function handleLabeled({
  github,
  core,
  approversConfig,
  owner,
  repo,
  targetLabel,
  actor,
  prNumber,
  isMgmt,
  labels,
}) {
  /** @type {string[]} */
  let langsToApprove;

  if (targetLabel === "namespace-approved-all") {
    /** @type {string[]} */
    const allApprovers = getAllApprovers(approversConfig);

    if (!allApprovers.includes(actor)) {
      await github.rest.issues.removeLabel({
        owner,
        repo,
        issue_number: prNumber,
        name: targetLabel,
      });
      await github.rest.issues.createComment({
        owner,
        repo,
        issue_number: prNumber,
        body: `⚠️ @${actor} is not authorized to use \`namespace-approved-all\`. This shortcut is available to authorized namespace approvers.\n\nLabel removed.`,
      });
      return;
    }

    langsToApprove = labels
      .filter((label) => label.startsWith("namespace-") && label.endsWith("-pending"))
      .map((label) => label.replace("namespace-", "").replace("-pending", ""));
  } else {
    const match = targetLabel.match(/^namespace-(\w+)-approved$/);
    if (!match) {
      core.info(`${targetLabel} is not a namespace approval label`);
      return;
    }

    const lang = match[1];
    /** @type {string[]} */
    let authorizedList;
    if (isMgmt && approversConfig["management-plane"]?.all) {
      authorizedList = approversConfig["management-plane"].all;
    } else {
      authorizedList = approversConfig["data-plane"]?.[lang] ?? [];
    }

    if (!authorizedList.includes(actor)) {
      await github.rest.issues.removeLabel({
        owner,
        repo,
        issue_number: prNumber,
        name: targetLabel,
      });
      await github.rest.issues.createComment({
        owner,
        repo,
        issue_number: prNumber,
        body: `⚠️ @${actor} is not authorized to approve **${lang}** namespace. Authorized approvers: ${authorizedList.join(", ")}.\n\nLabel \`${targetLabel}\` has been removed.`,
      });
      return;
    }

    langsToApprove = [lang];
  }

  core.info(`Approving languages: ${langsToApprove.join(", ")} by ${actor}`);

  for (const lang of langsToApprove) {
    // Add approved label before removing pending to avoid status check timing gap (#4)
    if (targetLabel === "namespace-approved-all") {
      const approvedLabel = `namespace-${lang}-approved`;
      await github.rest.issues.addLabels({
        owner,
        repo,
        issue_number: prNumber,
        labels: [approvedLabel],
      });
    }

    await removeLabelIfPresent(github, owner, repo, prNumber, `namespace-${lang}-pending`);
  }

  const { data: currentPR } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: prNumber,
  });
  /** @type {string[]} */
  const currentLabels = currentPR.labels.map(
    (/** @type {{ name?: string }} */ label) => label.name ?? "",
  );
  const pendingLabels = currentLabels.filter(
    (/** @type {string} */ label) => label.startsWith("namespace-") && label.endsWith("-pending"),
  );

  const comments = await github.paginate(github.rest.issues.listComments, {
    owner,
    repo,
    issue_number: prNumber,
  });
  const botComment = comments.find(
    (/** @type {{ user?: { type?: string } | null, body?: string }} */ comment) =>
      comment.user?.type === "Bot" &&
      (comment.body?.includes("<!-- namespace-review-bot -->") ?? false),
  );

  if (botComment?.body) {
    let body = botComment.body;
    for (const lang of langsToApprove) {
      const rowRegex = new RegExp(`(\\| ${lang}[^|]*\\|[^|]+\\|[^|]+\\|) ⏳ Pending (\\|)`, "gi");
      body = body.replace(rowRegex, `$1 ✅ Approved by @${actor} $2`);
    }
    await github.rest.issues.updateComment({
      owner,
      repo,
      comment_id: botComment.id,
      body,
    });
  }

  if (pendingLabels.length === 0) {
    core.info("All namespaces approved!");
    await removeLabelIfPresent(github, owner, repo, prNumber, "namespace-review-required");
    await github.rest.issues.addLabels({
      owner,
      repo,
      issue_number: prNumber,
      labels: ["namespace-approved"],
    });

    // Only post the approval comment if one doesn't already exist (avoids duplicates
    // when multiple per-language labels are applied in quick succession)
    const approvalCommentExists = comments.some(
      (/** @type {{ user?: { type?: string } | null, body?: string }} */ comment) =>
        comment.user?.type === "Bot" &&
        (comment.body?.includes("## ✅ Namespace Approved") ?? false),
    );
    if (!approvalCommentExists) {
      await github.rest.issues.createComment({
        owner,
        repo,
        issue_number: prNumber,
        body: "## ✅ Namespace Approved\n\nAll required namespace approvals received. This PR is clear to merge from a namespace perspective.",
      });
    }
  }
}

/**
 * Validate namespace label changes by authorized approvers.
 * Handles both labeled (approval) and unlabeled (guard against unauthorized removal).
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function validateApproval({ github, context, core }) {
  const approversConfig = await loadApproversConfig();

  const { owner, repo, issue_number } = await extractInputs(github, context, core);

  const payload =
    /** @type {import("@octokit/webhooks-types").PullRequestLabeledEvent | import("@octokit/webhooks-types").PullRequestUnlabeledEvent} */ (
      context.payload
    );

  /** @type {string[]} */
  const labels = payload.pull_request.labels.map(
    (/** @type {{ name: string }} */ label) => label.name,
  );
  const targetLabel = payload.label.name;
  const actor = payload.sender.login;
  const isMgmt = labels.includes("Mgmt");

  if (payload.action === "unlabeled") {
    return await handleUnlabeled({
      github,
      context,
      core,
      approversConfig,
      owner,
      repo,
      targetLabel,
      actor,
      prNumber: issue_number,
      isMgmt,
    });
  }

  if (!labels.includes("namespace-review-required")) {
    core.info("No namespace review, skipping");
    return;
  }

  return await handleLabeled({
    github,
    context,
    core,
    approversConfig,
    owner,
    repo,
    targetLabel,
    actor,
    prNumber: issue_number,
    isMgmt,
    labels,
  });
}
