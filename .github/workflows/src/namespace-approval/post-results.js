import { readFile, unlink, writeFile } from "fs/promises";
import { tmpdir } from "os";
import { join } from "path";
import yaml from "js-yaml";
import { z } from "zod";
import { execFile } from "../../../shared/src/exec.js";
import { PER_PAGE_MAX } from "../../../shared/src/github.js";
import { commentOrUpdate } from "../comment.js";
import { extractInputs } from "../context.js";

const FormatValidationResultSchema = z.object({
  valid: z.boolean(),
  namespace: z.string(),
  language: z.string(),
  matchedRule: z.string().optional(),
  error: z.string().optional(),
});

const NamespaceResultsSchema = z.object({
  namespacesFound: z.record(z.string(), z.string()),
  isMgmt: z.boolean(),
  isDataPlane: z.boolean(),
  formatResults: z.record(z.string(), FormatValidationResultSchema),
  prNumber: z.number().int().positive(),
  action: z.string().optional(),
});

/**
 * @typedef {Object} ApproversConfig
 * @property {Record<string, string[]>} [data-plane]
 * @property {{ all?: string[] }} [management-plane]
 */

/** @type {Record<string, string>} */
const LABEL_COLORS = {
  "namespace-review-required": "e11d48",
};

/**
 * @param {import("@actions/core")} core
 * @returns {Promise<ApproversConfig | null>}
 */
async function loadApproversConfig(core) {
  try {
    const content = await readFile(".github/namespace-approvers.yml", "utf8");
    return /** @type {ApproversConfig} */ (yaml.load(content));
  } catch (error) {
    core.setFailed("Failed to load .github/namespace-approvers.yml: " + String(error));
    return null;
  }
}

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
    name: "namespace-results",
    per_page: PER_PAGE_MAX,
  });

  const artifact = artifacts.sort((left, right) => {
    const leftTime = new Date(left.updated_at || 0).getTime();
    const rightTime = new Date(right.updated_at || 0).getTime();
    return rightTime - leftTime;
  })[0];

  if (!artifact) {
    core.info(`No namespace-results artifact found for run ${runId}`);
    return null;
  }

  const download = await github.rest.actions.downloadArtifact({
    owner,
    repo,
    artifact_id: artifact.id,
    archive_format: "zip",
  });

  const zipPath = join(process.env.RUNNER_TEMP || tmpdir(), `namespace-results-${runId}.zip`);
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
 * @param {string} label
 */
async function ensureLabel(github, owner, repo, label) {
  try {
    await github.rest.issues.getLabel({
      owner,
      repo,
      name: label,
    });
  } catch {
    await github.rest.issues.createLabel({
      owner,
      repo,
      name: label,
      color: LABEL_COLORS[label] ?? (label.includes("pending") ? "fbbf24" : "94a3b8"),
    });
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
 * @param {ApproversConfig} approversConfig
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

  return approversConfig["data-plane"]?.[language] ?? ["TBD"];
}

/**
 * @param {Object} params
 * @param {ApproversConfig} params.approversConfig
 * @param {Record<string, string>} params.namespacesFound
 * @param {Record<string, z.infer<typeof FormatValidationResultSchema>>} params.formatResults
 * @param {boolean} params.isMgmt
 * @param {string} params.baseRef
 * @param {boolean} params.wasSynchronized
 */
function buildCommentBody({
  approversConfig,
  namespacesFound,
  formatResults,
  isMgmt,
  baseRef,
  wasSynchronized,
}) {
  const planeType = isMgmt ? "Management Plane" : "Data Plane";
  let body = `## Namespace Review Required\n\n**Plane:** ${planeType}\n\n`;
  body += `| Language | Proposed Namespace | Format | Status | Approvers |\n`;
  body += `|----------|-------------------|--------|--------|----------|\n`;

  for (const [language, namespace] of Object.entries(namespacesFound)) {
    const formatResult = formatResults[language];
    const formatStatus = !formatResult ? "—" : formatResult.valid ? "✅" : "⚠️ Invalid";
    body += `| ${language} | \`${namespace}\` | ${formatStatus} | ⏳ Pending | ${getApprovers(approversConfig, isMgmt, language).join(", ")} |\n`;
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
  if (wasSynchronized) {
    body += `\n> ⚠️ **Namespace changed** — approvals for affected languages have been reset.\n`;
  }
  body += `\n_Approver list: [.github/namespace-approvers.yml](../blob/${baseRef}/.github/namespace-approvers.yml)_\n`;
  body += `_Process: [.github/workflows/src/namespace-approval/NAMESPACE-REVIEW-PROCESS.md](../blob/${baseRef}/.github/workflows/src/namespace-approval/NAMESPACE-REVIEW-PROCESS.md)_\n`;
  body += `_Namespaces extracted via [@azure-tools/typespec-metadata](https://www.npmjs.com/package/@azure-tools/typespec-metadata) emitter_`;
  return body;
}

/**
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function postResults({ github, context, core }) {
  const { owner, repo, issue_number, run_id } = await extractInputs(github, context, core);
  const approversConfig = await loadApproversConfig(core);
  if (!approversConfig) {
    return;
  }

  const results = run_id ? await downloadNamespaceResults(github, core, owner, repo, run_id) : null;
  if (!results) {
    return;
  }

  const { data: pr } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: issue_number,
  });
  /** @type {string[]} */
  const existingLabels = pr.labels.map((label) => label.name ?? "");
  const languages = Object.keys(results.namespacesFound);

  if (results.action === "synchronize") {
    for (const language of languages) {
      const approvedLabel = `${language}-namespace-approved`;
      if (existingLabels.includes(approvedLabel)) {
        core.info(`Namespace changed for ${language}, resetting approval`);
        await removeLabelIfPresent(github, owner, repo, issue_number, approvedLabel);
      }
    }

    for (const label of ["namespace-approved-all", "namespace-approved"]) {
      if (existingLabels.includes(label)) {
        await removeLabelIfPresent(github, owner, repo, issue_number, label);
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
    labelsToAdd.add(`${language}-namespace-pending`);
  }

  for (const label of labelsToAdd) {
    await ensureLabel(github, owner, repo, label);
  }

  await github.rest.issues.addLabels({
    owner,
    repo,
    issue_number,
    labels: [...labelsToAdd],
  });

  const body = buildCommentBody({
    approversConfig,
    namespacesFound: results.namespacesFound,
    formatResults: results.formatResults,
    isMgmt: results.isMgmt,
    baseRef: pr.base.ref,
    wasSynchronized: results.action === "synchronize",
  });

  await commentOrUpdate(github, core, owner, repo, issue_number, body, "namespace-review-bot");
}
