import type { SuppressionChange, SuppressionRecord } from "./types.ts";

function escapeHtml(value: string): string {
  return value
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;");
}

function formatSource(suppression: SuppressionRecord): string {
  return `${suppression.sourceFile}#L${suppression.location.line}`;
}

function renderRuleCell(suppression: SuppressionRecord): string {
  const ruleMetadata = suppression.ruleMetadata;
  const label = `<code>${escapeHtml(suppression.ruleName)}</code>`;
  const rule = ruleMetadata?.documentationUrl
    ? `<a href="${escapeHtml(ruleMetadata.documentationUrl)}">${label}</a>`
    : label;
  const description = ruleMetadata?.description
    ? `<br/>${escapeHtml(ruleMetadata.description)}`
    : "";
  const guidance = ruleMetadata?.guidelineCodes?.length
    ? `<br/>Azure guidance: ${ruleMetadata.guidelineCodes
        .map((code) => `<code>${escapeHtml(code)}</code>`)
        .join(", ")}`
    : "";
  return `<strong>${rule}</strong>${description}${guidance}`;
}

function renderSourceCell(suppression: SuppressionRecord): string {
  return `<code>${escapeHtml(formatSource(suppression))}</code>`;
}

function renderJustificationCell(justification: string): string {
  if (!justification || !justification.trim()) {
    return "<strong>NO JUSTIFICATION PROVIDED, THIS IS A REQUIRED SUPPRESSION COMPONENT</strong>";
  }
  return escapeHtml(justification);
}

function renderSuppressionTable(suppressions: SuppressionRecord[]): string {
  const rows = suppressions
    .map(
      (suppression) =>
        `<tr><td>${renderRuleCell(suppression)}</td>` +
        `<td>${renderSourceCell(suppression)}</td>` +
        `<td>${renderJustificationCell(suppression.justification)}</td></tr>`,
    )
    .join("");
  return (
    "<table>" +
    "<thead><tr><th>Rule</th><th>Source</th><th>Justification</th></tr></thead>" +
    `<tbody>${rows}</tbody>` +
    "</table>"
  );
}

function renderChangedTable(changes: SuppressionChange[]): string {
  const rows = changes
    .map(
      (change) =>
        `<tr><td>${renderRuleCell(change.after)}</td>` +
        `<td>${renderSourceCell(change.after)}</td>` +
        `<td>${renderJustificationCell(change.before.justification)}</td>` +
        `<td>${renderJustificationCell(change.after.justification)}</td></tr>`,
    )
    .join("");
  return (
    "<table>" +
    "<thead><tr><th>Rule</th><th>Source</th><th>Previous justification</th>" +
    "<th>New justification</th></tr></thead>" +
    `<tbody>${rows}</tbody>` +
    "</table>"
  );
}

export function renderMarkdownSummary(params: {
  baseRevision: string;
  headRevision: string;
  specPaths: string[];
  newSuppressions: SuppressionRecord[];
  changedSuppressions: SuppressionChange[];
}): string {
  const { baseRevision, changedSuppressions, headRevision, newSuppressions, specPaths } = params;
  const lines = [
    "# TypeSpec Suppressions",
    "",
    `- Base revision: \`${baseRevision}\``,
    `- Head revision: \`${headRevision}\``,
    `- Spec folders analyzed: ${specPaths.length}`,
    "",
  ];

  if (specPaths.length > 0) {
    lines.push("## Spec folders", "", ...specPaths.map((specPath) => `- \`${specPath}\``), "");
  }

  if (newSuppressions.length === 0 && changedSuppressions.length === 0) {
    lines.push("## Result", "", "No new or changed TypeSpec suppressions were found.", "");
    return `${lines.join("\n")}\n`;
  }

  if (newSuppressions.length > 0) {
    lines.push(
      `## New suppressions requiring approval (${newSuppressions.length})`,
      "",
      renderSuppressionTable(newSuppressions),
      "",
    );
  }

  if (changedSuppressions.length > 0) {
    lines.push(
      `## Changed suppressions requiring approval (${changedSuppressions.length})`,
      "",
      renderChangedTable(changedSuppressions),
      "",
    );
  }

  return `${lines.join("\n")}\n`;
}
