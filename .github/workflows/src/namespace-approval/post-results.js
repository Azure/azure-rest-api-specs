import { unlink, writeFile } from "fs/promises";
import { join } from "path";
import { z } from "zod";
import { execFile } from "../../../shared/src/exec.js";
import { PER_PAGE_MAX } from "../../../shared/src/github.js";
import { commentOrUpdate, parseExistingComments } from "../comment.js";
import { extractInputs } from "../context.js";
import { loadApproversConfig } from "./approvers.js";
import { removeLabelIfPresent } from "./labels.js";

const FormatValidationResultSchema = z.object({
  valid: z.boolean(),
  namespace: z.string(),
  language: z.string(),
  matchedRule: z.string().optional(),
  error: z.string().optional(),
});

const NamespaceResultsSchema = z.object({
  namespacesFound: z.record(z.string(), z.string()),
  namespaces: z.record(z.string(), z.string()).optional().default({}),
  formatResults: z.array(FormatValidationResultSchema).optional().default([]),
  isMgmt: z.boolean(),
  isDataPlane: z.boolean(),
  prNumber: z.number().int().positive(),
  action: z.string().optional(),
});

/**
 * @param {import("@actions/github-script").AsyncFunctionArguments["github"]} github
 * @param {import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {number} runId
 * @returns {Promise<z.infer<typeof NamespaceResultsSchema> | null>}
 */
async function downloadNamespaceResults(github, core, owner, repo, runId) {
  const artifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
    owner,
    repo,
    run_id: runId,
    name: "package-name-results",
    per_page: PER_PAGE_MAX,
  });

  const artifact = artifacts.sort((left, right) => {
    const leftTime = new Date(left.updated_at ?? 0).getTime();
    const rightTime = new Date(right.updated_at ?? 0).getTime();
    return rightTime - leftTime;
  })[0];

  if (!artifact) {
    core.info(
      `No package-name-results artifact found for run ${runId} (PR likely has no tspconfig changes)`,
    );
    return null;
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
  const zipPath = join(runnerTemp, `package-name-results-${runId}.zip`);
  const zipBuffer = Buffer.from(new Uint8Array(/** @type {ArrayBuffer} */ (download.data)));
  await writeFile(zipPath, zipBuffer);

  try {
    const { stdout } = await execFile("unzip", ["-p", zipPath, "package-name-results.json"]);
    return /** @type {z.infer<typeof NamespaceResultsSchema>} */ (
      NamespaceResultsSchema.parse(JSON.parse(stdout))
    );
  } finally {
    await unlink(zipPath).catch(() => undefined);
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
      `No approvers configured for language "${language}" in .github/protected-labels.yml`,
    );
  }
  return approvers;
}

/**
 * Parse the package name review table from an existing bot comment.
 *
 * Extracts language, package name, and approval status from each row.
 * Table format: Language | Package Name | Namespace | Format | Status | Approvers
 *
 * @param {string} body - The full comment body.
 * @returns {Map<string, { namespace: string, status: string }>}
 */
export function parseCommentTable(body) {
  /** @type {Map<string, { namespace: string, status: string }>} */
  const results = new Map();
  // 6-column row: | language | `packageName` | `namespace` | format | status | approvers |
  const rowRegex = /\| (\w+)[^|]*\| `([^`]+)` \| [^|]+ \| [^|]+ \| ([^|]+) \|/g;
  let match;
  while ((match = rowRegex.exec(body)) !== null) {
    const lang = match[1];
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
 * @param {Record<string, string>} [params.namespaces] - Language namespaces (distinct from package names).
 * @param {z.infer<typeof FormatValidationResultSchema>[]} params.formatResults
 * @param {boolean} params.isMgmt
 * @param {string} params.baseRef
 * @param {string[]} [params.resetLanguages] - Languages whose approvals were reset on this push.
 * @param {Map<string, { namespace: string, status: string }>} [params.preservedApprovals] - Approval statuses preserved from the previous comment for unchanged package names.
 */
function buildCommentBody({
  approversConfig,
  namespacesFound,
  namespaces,
  formatResults,
  isMgmt,
  baseRef,
  resetLanguages,
  preservedApprovals,
}) {
  const planeType = isMgmt ? "Management Plane" : "Data Plane";
  let body = `## Package Name Review Required\n\n**Plane:** ${planeType}\n\n`;
  body += `| Language | Package Name | Namespace | Format | Status | Approvers |\n`;
  body += `|----------|--------------|-----------|--------|--------|----------|\n`;

  /** @type {Map<string, z.infer<typeof FormatValidationResultSchema>>} */
  const formatMap = new Map();
  for (const r of formatResults) {
    formatMap.set(r.language, r);
  }

  for (const [language, packageName] of Object.entries(namespacesFound)) {
    const ns = namespaces?.[language] ?? "—";
    const formatResult = formatMap.get(language);
    const formatStatus = !formatResult ? "—" : formatResult.valid ? "✅" : "⚠️ Invalid";
    const preserved = preservedApprovals?.get(language);
    const status = preserved?.status ?? "⏳ Pending";
    body += `| ${language} | \`${packageName}\` | \`${ns}\` | ${formatStatus} | ${status} | ${getApprovers(
      approversConfig,
      isMgmt,
      language,
    )
      .map((a) => `@${a}`)
      .join(", ")} |\n`;
  }

  const formatErrors = formatResults.filter((result) => !result.valid);
  if (formatErrors.length > 0) {
    body += `\n> **⚠️ Format issues detected:**\n`;
    for (const error of formatErrors) {
      body += `> - **${error.language}:** ${error.error}\n`;
    }
    body += `>\n> _Format validation does not block approval but should be reviewed._\n`;
  }

  body += `\n**How to approve:**\n`;
  body += `- Per language: apply \`package-name-<language>-approved\` label\n`;
  body += `- All at once: apply \`package-name-approved-all\` label (shortcut for mgmt plane)\n\n`;
  body += `Merge is blocked until all languages are approved.\n`;
  if (resetLanguages && resetLanguages.length > 0) {
    body += `\n> ⚠️ **Package name changed** -- approvals for ${resetLanguages.join(", ")} have been reset.\n`;
  }
  body += `\n_Approver list: [.github/protected-labels.yml](../blob/${baseRef}/.github/protected-labels.yml)_\n`;
  body += `_Process: [.github/workflows/src/namespace-approval/PACKAGE-NAME-REVIEW-PROCESS.md](../blob/${baseRef}/.github/workflows/src/namespace-approval/PACKAGE-NAME-REVIEW-PROCESS.md)_\n`;
  body += `_Package names extracted via tsp compile with typespec-metadata emitter_`;
  return body;
}

/**
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function postResults({ github, context, core }) {
  const { owner, repo, issue_number, run_id } = await extractInputs(github, context, core);
  const approversConfig = await loadApproversConfig();
  const results = await downloadNamespaceResults(github, core, owner, repo, run_id);

  if (!results) {
    core.info("No package name results to process, exiting gracefully");
    return;
  }

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
    // Fetch existing bot comment to compare package names per language
    const comments = await github.paginate(github.rest.issues.listComments, {
      owner,
      repo,
      issue_number,
      per_page: PER_PAGE_MAX,
    });
    const [, existingBody] = parseExistingComments(comments, "package-name-review-bot");
    /** @type {Map<string, { namespace: string, status: string }>} */
    const previousTable = existingBody ? parseCommentTable(existingBody) : new Map();

    for (const language of languages) {
      const prev = previousTable.get(language);
      const newNs = results.namespacesFound[language];

      if (prev && prev.namespace !== newNs) {
        // Package name genuinely changed from a previously-recorded value
        const approvedLabel = `package-name-${language}-approved`;
        if (existingLabels.includes(approvedLabel)) {
          core.info(
            `Package name changed for ${language}: "${prev.namespace}" → "${newNs}", resetting approval`,
          );
          await removeLabelIfPresent(github, owner, repo, issue_number, approvedLabel);
          existingLabels.splice(existingLabels.indexOf(approvedLabel), 1);
          resetLanguages.push(language);
        }
      } else if (prev && prev.status && !prev.status.includes("Pending")) {
        // Package name unchanged and previously approved: preserve status
        core.info(`Package name unchanged for ${language}: "${newNs}", preserving approval`);
        preservedApprovals.set(language, prev);
      }
      // No previous entry (!prev) means first detection — treat as new pending (no reset)
    }

    // Only remove global approval labels if any language was actually reset
    if (resetLanguages.length > 0) {
      for (const label of ["package-name-approved-all", "package-name-approved"]) {
        if (existingLabels.includes(label)) {
          await removeLabelIfPresent(github, owner, repo, issue_number, label);
          existingLabels.splice(existingLabels.indexOf(label), 1);
        }
      }
    }
  }

  if (languages.length === 0) {
    core.info("No package name changes detected");
    return;
  }

  const labelsToAdd = new Set(["package-name-review-required"]);
  if (results.isMgmt) {
    labelsToAdd.add("Mgmt");
  }
  if (results.isDataPlane) {
    labelsToAdd.add("data-plane");
  }
  for (const language of languages) {
    // Skip adding pending label if language is already approved
    const approvedLabel = `package-name-${language}-approved`;
    if (!existingLabels.includes(approvedLabel)) {
      labelsToAdd.add(`package-name-${language}-pending`);
    }
  }

  // Don't re-add package-name-review-required if everything is already approved
  const allApproved = languages.every((lang) =>
    existingLabels.includes(`package-name-${lang}-approved`),
  );
  if (allApproved && languages.length > 0) {
    labelsToAdd.delete("package-name-review-required");
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
    namespaces: results.namespaces,
    formatResults: results.formatResults,
    isMgmt: results.isMgmt,
    baseRef: pr.base.ref,
    resetLanguages,
    preservedApprovals,
  });

  await commentOrUpdate(github, core, owner, repo, issue_number, body, "package-name-review-bot");
}
