/*
  Rendering for the "TypeSpec suppressions requiring review" section of the
  "Summarize PR Impact" comment.

  This module owns everything related to surfacing TypeSpec suppressions in the
  PR comment: downloading the analyzer report artifact produced by the "TypeSpec
  Suppressions - Analyze Code" workflow and rendering it into an HTML details
  block. It is intentionally isolated from summarize-checks.js, which only needs
  the `getTypeSpecSuppressionsSection` entry point.

  Gating (the TypeSpecSuppressionReviewRequired label) is applied separately by
  summarize-impact; nothing in this module blocks merges.
*/

import { execFile } from "../../../shared/src/exec.js";
import { PER_PAGE_MAX } from "../../../shared/src/github.js";
import { byDate, invert } from "../../../shared/src/sort.js";

import fs from "fs/promises";
import os from "os";
import path from "path";

/**
 * @typedef {import("../github.js").WorkflowRuns[0]} WorkflowRunInfo
 */

/**
 * @typedef {Object} TypeSpecRuleMetadata
 * @property {string} [packageName]
 * @property {string} [localRuleName]
 * @property {string} [description]
 * @property {string} [documentationUrl]
 * @property {string[]} [guidelineCodes]
 */

/**
 * @typedef {Object} TypeSpecSourceLocation
 * @property {number} line
 * @property {number} column
 */

/**
 * @typedef {Object} TypeSpecSuppressionRecord
 * @property {string} specPath
 * @property {"inline" | "tspconfig"} sourceKind
 * @property {string} ruleName
 * @property {string} justification
 * @property {string} sourceFile
 * @property {string} anchorPath
 * @property {TypeSpecSourceLocation} location
 * @property {string} rawText
 * @property {TypeSpecRuleMetadata} [ruleMetadata]
 */

/**
 * @typedef {Object} TypeSpecSuppressionChange
 * @property {TypeSpecSuppressionRecord} before
 * @property {TypeSpecSuppressionRecord} after
 */

/**
 * @typedef {Object} TypeSpecCheckedSuppressions
 * @property {string[]} checkRules
 * @property {boolean} requiresApproval
 * @property {TypeSpecSuppressionRecord[]} [newSuppressions]
 * @property {TypeSpecSuppressionRecord[]} [removedSuppressions]
 * @property {TypeSpecSuppressionChange[]} [changedSuppressions]
 */

/**
 * @typedef {Object} TypeSpecSuppressionsReport
 * @property {boolean} [requiresApproval]
 * @property {TypeSpecSuppressionRecord[]} [newSuppressions]
 * @property {TypeSpecSuppressionChange[]} [changedSuppressions]
 * @property {TypeSpecCheckedSuppressions} [checkedSuppressions]
 */

const TYPESPEC_SUPPRESSIONS_WORKFLOW_NAME = "TypeSpec Suppressions - Analyze Code";
const TYPESPEC_SUPPRESSIONS_REPORT_ARTIFACT_NAME = "typespec-suppressions-report";
const TYPESPEC_SUPPRESSIONS_SECTION_TITLE =
  "TypeSpec suppressions requiring review (testing, non-blocking)";
const APPROVED_SUPPRESSION_LABEL = "Approved-TypeSpecSuppression";
// GitHub caps comment bodies at ~65k characters, so only render a handful of suppressions
// inline per table (new and changed) and link to the analysis log for the full list.
const MAX_SUPPRESSIONS_SHOWN = 5;

/**
 * Downloads a text artifact for a given workflow run.
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {number} runId
 * @param {string} artifactName
 * @returns {Promise<string>}
 */
export async function downloadArtifactText(github, core, owner, repo, runId, artifactName) {
  const artifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
    owner,
    repo,
    run_id: runId,
    name: artifactName,
    per_page: PER_PAGE_MAX,
  });

  const artifact = artifacts.sort(invert(byDate((item) => item.updated_at || "1970")))[0];
  if (!artifact) {
    throw new Error(`Unable to find ${artifactName} artifact for run ID: ${runId}.`);
  }

  const download = await github.rest.actions.downloadArtifact({
    owner,
    repo,
    artifact_id: artifact.id,
    archive_format: "zip",
  });

  core.info(`Successfully downloaded ${artifactName} artifact ID: ${artifact.id}`);

  const tmpZip = path.join(
    process.env.RUNNER_TEMP || os.tmpdir(),
    `${artifactName.replace(/[^A-Za-z0-9_.-]/g, "-")}-${runId}.zip`,
  );
  const arrayBuffer = /** @type {ArrayBuffer} */ (download.data);
  const zipBuffer = Buffer.from(new Uint8Array(arrayBuffer));
  await fs.writeFile(tmpZip, zipBuffer);

  try {
    const { stdout } = await execFile("unzip", ["-p", tmpZip]);
    return stdout;
  } finally {
    await fs.unlink(tmpZip);
  }
}

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {string} head_sha
 * @returns {Promise<WorkflowRunInfo | undefined>}
 */
async function getLatestTypeSpecSuppressionsWorkflowRun(github, core, owner, repo, head_sha) {
  const workflowRuns = await github.paginate(github.rest.actions.listWorkflowRunsForRepo, {
    owner,
    repo,
    event: "pull_request",
    head_sha,
    per_page: PER_PAGE_MAX,
  });

  const targetRuns = workflowRuns
    .filter(
      (workflowRun) =>
        workflowRun.name === TYPESPEC_SUPPRESSIONS_WORKFLOW_NAME ||
        workflowRun.name === `[TEST-IGNORE] ${TYPESPEC_SUPPRESSIONS_WORKFLOW_NAME}`,
    )
    .sort(invert(byDate((workflowRun) => workflowRun.updated_at)));

  const run = targetRuns[0];
  if (run) {
    core.info(`Using TypeSpec suppressions workflow run ${run.id}.`);
  }
  return run;
}

/**
 * @param {string} value
 * @returns {string}
 */
function escapeHtml(value) {
  return value
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;");
}

/**
 * @param {string} filePath
 * @returns {string}
 */
function getPathSegment(filePath) {
  return filePath.split("/").slice(-4).join("/");
}

/**
 * @param {string} owner
 * @param {string} repo
 * @param {string} sha
 * @param {string} filePath
 * @param {number} line
 * @returns {string}
 */
function getBlobLineLink(owner, repo, sha, filePath, line) {
  const normalizedPath = filePath.startsWith("/") ? filePath.slice(1) : filePath;
  return `https://github.com/${owner}/${repo}/blob/${sha}/${normalizedPath}#L${line}`;
}

/**
 * @param {number} count
 * @param {string} singular
 * @param {string} [plural]
 * @returns {string}
 */
function pluralize(count, singular, plural = `${singular}s`) {
  return `${count} ${count === 1 ? singular : plural}`;
}

/**
 * @param {TypeSpecSuppressionRecord} suppression
 * @returns {string}
 */
function renderRuleLabel(suppression) {
  const label = `<code>${escapeHtml(suppression.ruleName)}</code>`;
  const documentationUrl = suppression.ruleMetadata?.documentationUrl;
  return documentationUrl ? `<a href="${documentationUrl}">${label}</a>` : label;
}

/**
 * @param {string} owner
 * @param {string} repo
 * @param {string} head_sha
 * @param {TypeSpecSuppressionRecord} suppression
 * @returns {string}
 */
function renderSourceLink(owner, repo, head_sha, suppression) {
  const sourceLabel = `${getPathSegment(suppression.sourceFile)}#L${suppression.location.line}`;
  const sourceUrl = getBlobLineLink(
    owner,
    repo,
    head_sha,
    suppression.sourceFile,
    suppression.location.line,
  );
  return `<a href="${sourceUrl}">${escapeHtml(sourceLabel)}</a>`;
}

/**
 * @param {TypeSpecSuppressionRecord} suppression
 * @returns {string}
 */
function renderRuleCell(suppression) {
  const ruleMetadata = suppression.ruleMetadata;
  const description = ruleMetadata?.description
    ? `<br/>${escapeHtml(ruleMetadata.description)}`
    : "";
  const guidance = ruleMetadata?.guidelineCodes?.length
    ? `<br/>Azure guidance: ${ruleMetadata.guidelineCodes
        .map((code) => `<code>${escapeHtml(code)}</code>`)
        .join(", ")}`
    : "";
  return `<strong>${renderRuleLabel(suppression)}</strong>${description}${guidance}`;
}

/**
 * @param {string | undefined} justification
 * @returns {string}
 */
function renderJustificationValue(justification) {
  if (!justification || !justification.trim()) {
    return "<strong>NO JUSTIFICATION PROVIDED, THIS IS A REQUIRED SUPPRESSION COMPONENT</strong>";
  }
  return escapeHtml(justification);
}

/**
 * @param {string} owner
 * @param {string} repo
 * @param {string} head_sha
 * @param {TypeSpecSuppressionRecord} suppression
 * @param {string} statusCell
 * @returns {string}
 */
function renderNewSuppressionRow(owner, repo, head_sha, suppression, statusCell) {
  return (
    `<tr><td align="center">${statusCell}</td>` +
    `<td>${renderRuleCell(suppression)}</td>` +
    `<td>${renderSourceLink(owner, repo, head_sha, suppression)}</td>` +
    `<td>${renderJustificationValue(suppression.justification)}</td></tr>`
  );
}

/**
 * @param {string} owner
 * @param {string} repo
 * @param {string} head_sha
 * @param {TypeSpecSuppressionChange} change
 * @param {string} statusCell
 * @returns {string}
 */
function renderChangedSuppressionRow(owner, repo, head_sha, change, statusCell) {
  return (
    `<tr><td align="center">${statusCell}</td>` +
    `<td>${renderRuleCell(change.after)}</td>` +
    `<td>${renderSourceLink(owner, repo, head_sha, change.after)}</td>` +
    `<td>${renderJustificationValue(change.before.justification)}</td>` +
    `<td>${renderJustificationValue(change.after.justification)}</td></tr>`
  );
}

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {typeof import("@actions/core")} core
 * @param {string} owner
 * @param {string} repo
 * @param {string} head_sha
 * @param {import("./labelling.js").ImpactAssessment | undefined} impactAssessment
 * @param {string[]} [labelNames] - Current PR labels, used to reflect approval status.
 * @returns {Promise<string | undefined>}
 */
export async function getTypeSpecSuppressionsSection(
  github,
  core,
  owner,
  repo,
  head_sha,
  impactAssessment,
  labelNames = [],
) {
  // Reporting is driven by the Analyze Code report artifact, not the shared
  // swagger/README `suppressionReviewRequired` signal. The `impactAssessment`
  // parameter is retained for signature/backward compatibility but no longer
  // gates rendering. Gating (the TypeSpecSuppressionReviewRequired label) is
  // applied separately by summarize-impact and is currently disabled during the
  // initial rollout.
  //
  // Once gating is enabled (the force-off line in summarize-impact's
  // `processTypeSpecSuppression` is removed), this parameter should be used to
  // render the suppressions section only when
  // `impactAssessment.typeSpecSuppressionReviewRequired` is true, so the
  // "Approval required" messaging appears only while the gate is actually active
  // rather than on every PR that touches a checked suppression.
  void impactAssessment;

  const run = await getLatestTypeSpecSuppressionsWorkflowRun(github, core, owner, repo, head_sha);
  if (!run || run.status !== "completed") {
    return undefined;
  }

  let reportContent;
  try {
    reportContent = await downloadArtifactText(
      github,
      core,
      owner,
      repo,
      run.id,
      TYPESPEC_SUPPRESSIONS_REPORT_ARTIFACT_NAME,
    );
  } catch {
    return undefined;
  }

  /** @type {unknown} */
  const parsedReport = JSON.parse(reportContent);
  const report = /** @type {TypeSpecSuppressionsReport} */ (parsedReport);

  // In checked-only mode (a check-rules file was used), render only the checked
  // subset; otherwise fall back to the full diff (legacy behavior). An empty
  // ruleset yields an empty checked subset, so nothing is reported — the same as
  // a PR that added no suppressions.
  const reported = report.checkedSuppressions ?? report;
  if (!reported.requiresApproval) {
    return undefined;
  }

  const newSuppressions = reported.newSuppressions ?? [];
  const changedSuppressions = reported.changedSuppressions ?? [];

  const isApproved = labelNames.includes(APPROVED_SUPPRESSION_LABEL);
  const statusCell = isApproved ? "✅" : "❌";
  const approvalState = isApproved ? "✅ Approved" : "❌ Approval required";

  const totalCount = newSuppressions.length + changedSuppressions.length;

  const summaryParts = [approvalState, pluralize(totalCount, "suppression")];

  const sectionLines = [
    `<br/><br/><details><summary><strong>${TYPESPEC_SUPPRESSIONS_SECTION_TITLE}</strong> — ${summaryParts.join(
      " — ",
    )}</summary>`,
    "",
    "",
    "⚠️ This PR adds or updates the TypeSpec suppressions listed below. <strong>Suppressions are strongly discouraged</strong> — they bypass linter rules that protect API quality and consistency. Authors should avoid adding new suppressions and prefer fixing the underlying issue; reviewers should approve only when there is a clear, compelling justification and no reasonable alternative. Review each linked rule and source location, then apply <code>Approved-TypeSpecSuppression</code> only if every justification is acceptable. The <strong>Status</strong> column shows ✅ once the label is applied and ❌ while approval is pending.",
    "",
  ];

  const shownNew = newSuppressions.slice(0, MAX_SUPPRESSIONS_SHOWN);
  const shownChanged = changedSuppressions.slice(0, MAX_SUPPRESSIONS_SHOWN);
  const shownCount = shownNew.length + shownChanged.length;
  const hiddenCount = totalCount - shownCount;

  if (shownNew.length > 0) {
    sectionLines.push(
      `<strong>New suppressions (${newSuppressions.length})</strong>`,
      "",
      "<table>",
      "<thead><tr><th>Status</th><th>Rule</th><th>Source</th><th>Justification</th></tr></thead>",
      "<tbody>",
      ...shownNew.map((suppression) =>
        renderNewSuppressionRow(owner, repo, head_sha, suppression, statusCell),
      ),
      "</tbody>",
      "</table>",
      "",
    );
  }

  if (shownChanged.length > 0) {
    sectionLines.push(
      `<strong>Changed suppressions (${changedSuppressions.length})</strong>`,
      "",
      "<table>",
      "<thead><tr><th>Status</th><th>Rule</th><th>Source</th><th>Previous justification</th><th>New justification</th></tr></thead>",
      "<tbody>",
      ...shownChanged.map((change) =>
        renderChangedSuppressionRow(owner, repo, head_sha, change, statusCell),
      ),
      "</tbody>",
      "</table>",
      "",
    );
  }

  if (hiddenCount > 0) {
    const runUrl = run.html_url ?? `https://github.com/${owner}/${repo}/actions/runs/${run.id}`;
    sectionLines.push(
      `<em>Showing ${shownCount} of ${totalCount} suppressions. See the <a href="${runUrl}">full analysis log</a> for the complete list.</em>`,
      "",
    );
  }

  sectionLines.push(
    "",
    '💬 Have feedback on the TypeSpec suppression flow? <a href="https://aka.ms/azsdk/tspsuppressionfeedback">Let us know</a>.',
    "</details>",
  );
  return sectionLines.join("\n");
}
