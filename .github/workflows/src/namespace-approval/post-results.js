import { unlink, writeFile } from "fs/promises";
import { join } from "path";
import { z } from "zod";
import { execFile } from "../../../shared/src/exec.js";
import { PER_PAGE_MAX } from "../../../shared/src/github.js";
import { commentOrUpdate, parseExistingComments } from "../comment.js";
import { extractInputs } from "../context.js";
import { loadApproversConfig } from "./approvers.js";

const FormatValidationResultSchema = z.object({
  valid: z.boolean(),
  namespace: z.string(),
  language: z.string(),
  matchedRule: z.string().optional(),
  error: z.string().optional(),
});

const NamespaceResultsSchema = z.object({
  namespacesFound: z.record(z.string(), z.string()),
  artifactNames: z.record(z.string(), z.string()).optional().default({}),
  isMgmt: z.boolean(),
  isDataPlane: z.boolean(),
  formatResults: z.record(z.string(), FormatValidationResultSchema),
  prNumber: z.number().int().positive(),
  action: z.string().optional(),
});

/**
 * @param {import("@actions/github-script").AsyncFunctionArguments["github"]} github
 * @param {import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {number} runId
 * @returns {Promise<z.infer<typeof NamespaceResultsSchema>>}
 */
async function downloadNamespaceResults(github, core, owner, repo, runId) {
  const artifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
    owner,
    repo,
    run_id: runId,
    name: "namespace-results",
    per_page: PER_PAGE_MAX,
  });

  const artifact = artifacts.sort((left, right) => {
    const leftTime = new Date(left.updated_at ?? 0).getTime();
    const rightTime = new Date(right.updated_at ?? 0).getTime();
    return rightTime - leftTime;
  })[0];

  if (!artifact) {
    throw new Error(`No namespace-results artifact found for run ${runId}`);
  }

  const download = await github.rest.actions.downloadArtifact({
    owner,
    repo,
    artifact_id: artifact.id,
    archive_format: "zip",
  });

  const runnerTemp = process.env.RUNNER_TEMP;
  if (!runnerTemp) {
    throw new Error("RUNNER_TEMP environment variable is required");
  }
  const zipPath = join(runnerTemp, `namespace-results-${runId}.zip`);
  const zipBuffer = Buffer.from(new Uint8Array(/** @type {ArrayBuffer} */ (download.data)));
  await writeFile(zipPath, zipBuffer);

  try {
    const { stdout } = await execFile("unzip", ["-p", zipPath, "namespace-results.json"]);
    return /** @type {z.infer<typeof NamespaceResultsSchema>} */ (
      NamespaceResultsSchema.parse(JSON.parse(stdout))
    );
  } finally {
    await unlink(zipPath).catch(() => undefined);
  }
}

/**
 * @param {import("@actions/github-script").AsyncFunctionArguments["github"]} github
 * @param {string} owner
 * @param {string} repo
 * @param {number} issueNumber
 * @param {string} label
 */
async function removeLabelIfPresent(github, owner, repo, issueNumber, label) {
  try {
    await github.rest.issues.removeLabel({
      owner,
      repo,
      issue_number: issueNumber,
      name: label,
    });
  } catch (error) {
    if (error instanceof Error && "status" in error && error.status === 404) {
      return;
    }
    throw error;
  }
}

/**
 * @param {import("./approvers.js").ApproversConfig} approversConfig
 * @param {boolean} isMgmt
 * @param {string} language
 * @returns {string[]}
 */
function getApprovers(approversConfig, isMgmt, language) {
  if (isMgmt) {
    const mgmtApprovers = approversConfig["management-plane"]?.all;
    if (mgmtApprovers) {
      return mgmtApprovers;
    }
  }

  const approvers = approversConfig["data-plane"]?.[language];
  if (!approvers) {
    throw new Error(
      `No approvers configured for language "${language}" in .github/namespace-approvers.yml`,
    );
  }
  return approvers;
}

/**
 * Parse the namespace review table from an existing bot comment.
 *
 * Extracts language, namespace, and approval status from each row.
 *
 * @param {string} body - The full comment body.
 * @returns {Map<string, { namespace: string, status: string }>}
 */
export function parseCommentTable(body) {
  /** @type {Map<string, { namespace: string, status: string }>} */
  const results = new Map();
  // Table row: | language (possibly with suffix) | `namespace` | format | status | approvers |
  // Captures the base language name (word chars before optional space/underscore/paren suffix)
  const rowRegex = /\| (\w+)[^|]*\| `([^`]+)` \| [^|]+ \| ([^|]+) \|/g;
  let match;
  while ((match = rowRegex.exec(body)) !== null) {
    const lang = match[1];
    // Keep only the first match per language (primary namespace, not artifact)
    if (!results.has(lang)) {
      results.set(lang, {
        namespace: match[2],
        status: match[3].trim(),
      });
    }
  }
  return results;
}

/**
 * @param {Object} params
 * @param {import("./approvers.js").ApproversConfig} params.approversConfig
 * @param {Record<string, string>} params.namespacesFound
 * @param {Record<string, string>} [params.artifactNames] - Secondary artifact names per language (e.g. Java Maven artifact).
 * @param {Record<string, z.infer<typeof FormatValidationResultSchema>>} params.formatResults
 * @param {boolean} params.isMgmt
 * @param {string} params.baseRef
 * @param {string[]} [params.resetLanguages] - Languages whose approvals were reset on this push.
 * @param {Map<string, { namespace: string, status: string }>} [params.preservedApprovals] - Approval statuses preserved from the previous comment for unchanged namespaces.
 */
function buildCommentBody({
  approversConfig,
  namespacesFound,
  artifactNames,
  formatResults,
  isMgmt,
  baseRef,
  resetLanguages,
  preservedApprovals,
}) {
  const planeType = isMgmt ? "Management Plane" : "Data Plane";
  let body = `## Namespace Review Required\n\n**Plane:** ${planeType}\n\n`;
  body += `| Language | Proposed Namespace | Format | Status | Approvers |\n`;
  body += `|----------|-------------------|--------|--------|----------|\n`;

  for (const [language, namespace] of Object.entries(namespacesFound)) {
    const formatResult = formatResults[language];
    const formatStatus = !formatResult ? "—" : formatResult.valid ? "✅" : "⚠️ Invalid";
    const preserved = preservedApprovals?.get(language);
    const status = preserved?.status ?? "⏳ Pending";
    const hasArtifact = artifactNames && language in artifactNames;
    const label = hasArtifact ? `${language} _(package)_` : language;
    body += `| ${label} | \`${namespace}\` | ${formatStatus} | ${status} | ${getApprovers(approversConfig, isMgmt, language).join(", ")} |\n`;

    // Show artifact row for languages that have one (e.g. Java Maven artifact)
    if (hasArtifact) {
      const artifactNs = artifactNames[language];
      const artifactFormat = formatResults[`${language}-artifact`];
      const artifactFormatStatus = !artifactFormat
        ? "—"
        : artifactFormat.valid
          ? "✅"
          : "⚠️ Invalid";
      body += `| ${language} _(artifact)_ | \`${artifactNs}\` | ${artifactFormatStatus} | ${status} | ${getApprovers(approversConfig, isMgmt, language).join(", ")} |\n`;
    }
  }

  const formatErrors = Object.values(formatResults).filter((result) => !result.valid);
  if (formatErrors.length > 0) {
    body += `\n> **⚠️ Format issues detected:**\n`;
    for (const error of formatErrors) {
      body += `> - **${error.language}:** ${error.error}\n`;
    }
    body += `>\n> _Format validation does not block approval but should be reviewed._\n`;
  }

  body += `\n**How to approve:**\n`;
  body += `- Per language: apply \`<language>-namespace-approved\` label\n`;
  body += `- All at once: apply \`namespace-approved-all\` label (shortcut for mgmt plane)\n\n`;
  body += `Merge is blocked until all languages are approved.\n`;
  if (resetLanguages && resetLanguages.length > 0) {
    body += `\n> ⚠️ **Namespace changed** — approvals for ${resetLanguages.join(", ")} have been reset.\n`;
  }
  body += `\n_Approver list: [.github/namespace-approvers.yml](../blob/${baseRef}/.github/namespace-approvers.yml)_\n`;
  body += `_Process: [.github/workflows/src/namespace-approval/NAMESPACE-REVIEW-PROCESS.md](../blob/${baseRef}/.github/workflows/src/namespace-approval/NAMESPACE-REVIEW-PROCESS.md)_\n`;
  body += `_Namespaces extracted from tspconfig.yaml emitter options_`;
  return body;
}

/**
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function postResults({ github, context, core }) {
  const { owner, repo, issue_number, run_id } = await extractInputs(github, context, core);
  const approversConfig = await loadApproversConfig();
  const results = await downloadNamespaceResults(github, core, owner, repo, run_id);

  const { data: pr } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: issue_number,
  });
  /** @type {string[]} */
  const existingLabels = pr.labels.map(
    (/** @type {{ name?: string }} */ label) => label.name ?? "",
  );
  const languages = Object.keys(results.namespacesFound);

  /** @type {string[]} */
  let resetLanguages = [];
  /** @type {Map<string, { namespace: string, status: string }>} */
  let preservedApprovals = new Map();

  if (results.action === "synchronize") {
    // Fetch existing bot comment to compare namespaces per language
    const comments = await github.paginate(github.rest.issues.listComments, {
      owner,
      repo,
      issue_number,
      per_page: PER_PAGE_MAX,
    });
    const [, existingBody] = parseExistingComments(comments, "namespace-review-bot");
    /** @type {Map<string, { namespace: string, status: string }>} */
    const previousTable = existingBody ? parseCommentTable(existingBody) : new Map();

    for (const language of languages) {
      const prev = previousTable.get(language);
      const newNs = results.namespacesFound[language];

      if (!prev || prev.namespace !== newNs) {
        // Namespace changed or new language: reset approval
        const approvedLabel = `${language}-namespace-approved`;
        if (existingLabels.includes(approvedLabel)) {
          core.info(
            `Namespace changed for ${language}: "${prev?.namespace ?? "(new)"}" → "${newNs}", resetting approval`,
          );
          await removeLabelIfPresent(github, owner, repo, issue_number, approvedLabel);
          existingLabels.splice(existingLabels.indexOf(approvedLabel), 1);
        }
        resetLanguages.push(language);
      } else if (prev.status && !prev.status.includes("Pending")) {
        // Namespace unchanged and previously approved: preserve status
        core.info(`Namespace unchanged for ${language}: "${newNs}", preserving approval`);
        preservedApprovals.set(language, prev);
      }
    }

    // Only remove global approval labels if any language was actually reset
    if (resetLanguages.length > 0) {
      for (const label of ["namespace-approved-all", "namespace-approved"]) {
        if (existingLabels.includes(label)) {
          await removeLabelIfPresent(github, owner, repo, issue_number, label);
          existingLabels.splice(existingLabels.indexOf(label), 1);
        }
      }
    }
  }

  if (languages.length === 0) {
    core.info("No namespace changes detected");
    return;
  }

  const labelsToAdd = new Set(["namespace-review-required"]);
  if (results.isMgmt) {
    labelsToAdd.add("Mgmt");
  }
  if (results.isDataPlane) {
    labelsToAdd.add("data-plane");
  }
  for (const language of languages) {
    // Skip adding pending label if language is already approved
    const approvedLabel = `${language}-namespace-approved`;
    if (!existingLabels.includes(approvedLabel)) {
      labelsToAdd.add(`${language}-namespace-pending`);
    }
  }

  // Don't re-add namespace-review-required if everything is already approved
  const allApproved = languages.every((lang) =>
    existingLabels.includes(`${lang}-namespace-approved`),
  );
  if (allApproved && languages.length > 0) {
    labelsToAdd.delete("namespace-review-required");
  }

  for (const label of labelsToAdd) {
    if (!existingLabels.includes(label)) {
      await github.rest.issues.addLabels({
        owner,
        repo,
        issue_number,
        labels: [label],
      });
    }
  }

  const body = buildCommentBody({
    approversConfig,
    namespacesFound: results.namespacesFound,
    artifactNames: results.artifactNames,
    formatResults: results.formatResults,
    isMgmt: results.isMgmt,
    baseRef: pr.base.ref,
    resetLanguages,
    preservedApprovals,
  });

  await commentOrUpdate(github, core, owner, repo, issue_number, body, "namespace-review-bot");
}
