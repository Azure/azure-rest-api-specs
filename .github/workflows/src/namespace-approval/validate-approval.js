import { readFileSync } from "fs";
import yaml from "js-yaml";

/**
 * @typedef {Object} ApproversConfig
 * @property {Record<string, string[]>} [data-plane]
 * @property {{ all?: string[] }} [management-plane]
 */

/**
 * @typedef {Object} ValidateContext
 * @property {import("@actions/github-script").AsyncFunctionArguments["github"]} github
 * @property {import("@actions/github-script").AsyncFunctionArguments["context"]} context
 * @property {import("@actions/github-script").AsyncFunctionArguments["core"]} core
 * @property {ApproversConfig} approversConfig
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
 * @param {ApproversConfig} approversConfig
 * @returns {string[]}
 */
function getAllApprovers(approversConfig) {
  const mgmtApprovers = approversConfig["management-plane"]?.all ?? [];
  return [
    ...new Set([...mgmtApprovers, ...Object.values(approversConfig["data-plane"] ?? {}).flat()]),
  ];
}

/**
 * Handle unlabeled event: re-apply pending labels if removed by unauthorized user.
 *
 * @param {ValidateContext} ctx
 */
async function handleUnlabeled({
  github,
  context,
  core,
  approversConfig,
  targetLabel,
  actor,
  prNumber,
}) {
  // Only guard namespace-related labels
  if (!targetLabel.endsWith("-namespace-pending") && targetLabel !== "namespace-review-required") {
    core.info(`${targetLabel} is not a namespace label, skipping`);
    return;
  }

  // Allow bots and authorized approvers to remove labels
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

  // Unauthorized removal — re-apply the label
  core.warning(`${actor} is not authorized to remove ${targetLabel}, re-applying`);

  await github.rest.issues.addLabels({
    owner: context.repo.owner,
    repo: context.repo.repo,
    issue_number: prNumber,
    labels: [targetLabel],
  });

  await github.rest.issues.createComment({
    owner: context.repo.owner,
    repo: context.repo.repo,
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
  context,
  core,
  approversConfig,
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
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: prNumber,
        name: targetLabel,
      });
      await github.rest.issues.createComment({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: prNumber,
        body: `⚠️ @${actor} is not authorized to use \`namespace-approved-all\`. This shortcut is available to authorized namespace approvers.\n\nLabel removed.`,
      });
      return;
    }

    langsToApprove = labels
      .filter((l) => l.endsWith("-namespace-pending"))
      .map((l) => l.replace("-namespace-pending", ""));
  } else {
    const match = targetLabel.match(/^(\w+)-namespace-approved$/);
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
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: prNumber,
        name: targetLabel,
      });
      await github.rest.issues.createComment({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: prNumber,
        body: `⚠️ @${actor} is not authorized to approve **${lang}** namespace. Authorized approvers: ${authorizedList.join(", ")}.\n\nLabel \`${targetLabel}\` has been removed.`,
      });
      return;
    }

    langsToApprove = [lang];
  }

  core.info(`Approving languages: ${langsToApprove.join(", ")} by ${actor}`);

  // Apply per-language approved labels and remove pending labels
  for (const lang of langsToApprove) {
    try {
      await github.rest.issues.removeLabel({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: prNumber,
        name: `${lang}-namespace-pending`,
      });
    } catch {
      // label may not exist
    }

    if (targetLabel === "namespace-approved-all") {
      const approvedLabel = `${lang}-namespace-approved`;
      try {
        await github.rest.issues.getLabel({
          owner: context.repo.owner,
          repo: context.repo.repo,
          name: approvedLabel,
        });
      } catch {
        await github.rest.issues.createLabel({
          owner: context.repo.owner,
          repo: context.repo.repo,
          name: approvedLabel,
          color: "22c55e",
        });
      }
      await github.rest.issues.addLabels({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: prNumber,
        labels: [approvedLabel],
      });
    }
  }

  // Update bot comment
  const { data: currentPR } = await github.rest.pulls.get({
    owner: context.repo.owner,
    repo: context.repo.repo,
    pull_number: prNumber,
  });
  /** @type {string[]} */
  const currentLabels = currentPR.labels.map((l) => l.name ?? "");
  const pendingLabels = currentLabels.filter((l) => l.endsWith("-namespace-pending"));

  const comments = await github.rest.issues.listComments({
    owner: context.repo.owner,
    repo: context.repo.repo,
    issue_number: prNumber,
  });
  const botComment = comments.data.find(
    (c) => c.user?.type === "Bot" && c.body?.includes("<!-- namespace-review-bot -->"),
  );

  if (botComment?.body) {
    let body = botComment.body;
    for (const lang of langsToApprove) {
      const rowRegex = new RegExp(`(\\| ${lang} \\|[^|]+\\|) ⏳ Pending (\\|)`, "i");
      body = body.replace(rowRegex, `$1 ✅ Approved by @${actor} $2`);
    }
    await github.rest.issues.updateComment({
      owner: context.repo.owner,
      repo: context.repo.repo,
      comment_id: botComment.id,
      body,
    });
  }

  if (pendingLabels.length === 0) {
    core.info("All namespaces approved!");
    try {
      await github.rest.issues.removeLabel({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: prNumber,
        name: "namespace-review-required",
      });
    } catch {
      // label may not exist
    }
    try {
      await github.rest.issues.getLabel({
        owner: context.repo.owner,
        repo: context.repo.repo,
        name: "namespace-approved",
      });
    } catch {
      await github.rest.issues.createLabel({
        owner: context.repo.owner,
        repo: context.repo.repo,
        name: "namespace-approved",
        color: "22c55e",
      });
    }
    await github.rest.issues.addLabels({
      owner: context.repo.owner,
      repo: context.repo.repo,
      issue_number: prNumber,
      labels: ["namespace-approved"],
    });
    await github.rest.issues.createComment({
      owner: context.repo.owner,
      repo: context.repo.repo,
      issue_number: prNumber,
      body: "## ✅ Namespace Approved\n\nAll required namespace approvals received. This PR is clear to merge from a namespace perspective.",
    });
  }
}

/**
 * Validate namespace label changes by authorized approvers.
 * Handles both labeled (approval) and unlabeled (guard against unauthorized removal).
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function validateApproval({ github, context, core }) {
  /** @type {ApproversConfig} */
  let approversConfig;
  try {
    const content = readFileSync(".github/namespace-approvers.yml", "utf8");
    approversConfig = /** @type {ApproversConfig} */ (yaml.load(content));
  } catch (e) {
    core.setFailed("Failed to load .github/namespace-approvers.yml: " + String(e));
    return;
  }

  const payload =
    /** @type {import("@octokit/webhooks-types").PullRequestLabeledEvent | import("@octokit/webhooks-types").PullRequestUnlabeledEvent} */ (
      context.payload
    );

  const prNumber = payload.pull_request.number;
  /** @type {string[]} */
  const labels = payload.pull_request.labels.map((l) => l.name);
  const targetLabel = payload.label.name;
  const actor = payload.sender.login;
  const isMgmt = labels.includes("Mgmt");

  // Handle unlabeled: guard against unauthorized removal of pending/required labels
  if (payload.action === "unlabeled") {
    return await handleUnlabeled({
      github,
      context,
      core,
      approversConfig,
      targetLabel,
      actor,
      prNumber,
      isMgmt,
    });
  }

  // Skip if no namespace review is required
  if (!labels.includes("namespace-review-required")) {
    core.info("No namespace review, skipping");
    return;
  }

  // Handle labeled: validate approval labels
  return await handleLabeled({
    github,
    context,
    core,
    approversConfig,
    targetLabel,
    actor,
    prNumber,
    isMgmt,
    labels,
  });
}
