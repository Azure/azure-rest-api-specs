import { isOperationIdentity } from "./types.js";
import { formatSuppressionHint } from "./suppression-guidance.js";
/**
 * Render a Markdown summary suitable for PR comments.
 * Follows the typespec-suppressions pattern: concise summary + expandable details.
 */
export function renderMarkdownSummary(result, options) {
    const errors = result.findings.filter((f) => f.severity === "error" && !f.suppressed);
    const suppressed = result.findings.filter((f) => f.suppressed);
    const ignored = result.findings.filter((f) => f.severity === "ignore" && !f.suppressed);
    const lines = [];
    // Header
    lines.push("## Breaking Change Analysis");
    lines.push("");
    // Status badge
    if (result.summary.noComparisonReason) {
        lines.push(`ℹ️ **No comparisons performed**: ${result.summary.noComparisonReason}`);
        lines.push("");
        return lines.join("\n");
    }
    if (errors.length === 0) {
        if (suppressed.length > 0) {
            lines.push(`⚠️ **${suppressed.length} approved breaking change${suppressed.length === 1 ? "" : "s"}** — review required`);
        }
        else {
            lines.push("✅ **No breaking changes detected**");
        }
    }
    else {
        lines.push(`❌ **${errors.length} breaking change${errors.length === 1 ? "" : "s"} detected**`);
    }
    // Summary line
    const parts = [];
    if (errors.length > 0)
        parts.push(`${errors.length} error${errors.length === 1 ? "" : "s"}`);
    if (suppressed.length > 0)
        parts.push(`${suppressed.length} suppressed`);
    if (ignored.length > 0)
        parts.push(`${ignored.length} ignored`);
    parts.push(`${result.summary.comparisonsPerformed} version pair${result.summary.comparisonsPerformed === 1 ? "" : "s"} compared`);
    lines.push("");
    lines.push(parts.join(" · "));
    // Context
    if (options?.baseRevision || options?.headRevision) {
        lines.push("");
        lines.push(`Comparing \`${options.baseRevision ?? "N/A"}\` → \`${options.headRevision ?? "HEAD"}\``);
    }
    // Errors table
    if (errors.length > 0) {
        lines.push("");
        lines.push("### Breaking Changes");
        lines.push("");
        lines.push("| Kind | Operation | Element | Versions |");
        lines.push("|------|-----------|---------|----------|");
        for (const finding of errors) {
            lines.push(`| ${esc(finding.diff.kind)} | ${esc(fmtOp(finding))} | \`${esc(finding.diff.identity.element)}\` | ${esc(fmtVer(finding))} |`);
        }
        // Suppression guidance
        lines.push("");
        lines.push("<details>");
        lines.push("<summary>How to suppress these findings</summary>");
        lines.push("");
        lines.push("If a breaking change is intentional and approved, add the following decorator");
        lines.push("to the affected type or property in your TypeSpec source:");
        lines.push("");
        lines.push("```typespec");
        // Show unique decorator hints
        const seenHints = new Set();
        for (const finding of errors) {
            const hint = formatSuppressionHint(finding);
            if (!seenHints.has(hint)) {
                seenHints.add(hint);
                lines.push(hint);
            }
        }
        lines.push("```");
        lines.push("");
        lines.push("</details>");
    }
    // Suppressed — these are new approved breaking changes that reviewers should see
    if (suppressed.length > 0) {
        lines.push("");
        lines.push("### Approved Breaking Changes");
        lines.push("");
        lines.push("The following breaking changes have been suppressed with `@approvedBreakingChange` decorators.");
        lines.push("Reviewers should verify these changes are intentional and properly justified.");
        lines.push("");
        lines.push("| Kind | Operation | Element | Reason |");
        lines.push("|------|-----------|---------|--------|");
        for (const finding of suppressed) {
            lines.push(`| ${esc(finding.diff.kind)} | ${esc(fmtOp(finding))} | \`${esc(finding.diff.identity.element)}\` | ${esc(finding.suppressionReason ?? "—")} |`);
        }
    }
    // Timing (collapsed)
    if (options?.showTiming) {
        lines.push("");
        lines.push("<details>");
        lines.push("<summary>Performance</summary>");
        lines.push("");
        lines.push(`Total: ${fmtMs(result.timing.totalMs)} · Version mutators: ${fmtMs(result.timing.versionMutatorsMs)} · Diff engine: ${fmtMs(result.timing.diffEngineMs)} · Classify: ${fmtMs(result.timing.classifyMs)}`);
        lines.push("");
        lines.push("</details>");
    }
    lines.push("");
    return lines.join("\n");
}
function fmtOp(finding) {
    if (!isOperationIdentity(finding.diff.identity))
        return "—";
    return `${finding.diff.identity.operation.method} ${finding.diff.identity.operation.path}`;
}
function fmtVer(finding) {
    return `${finding.versionPair.baseVersion} → ${finding.versionPair.headVersion}`;
}
function fmtMs(ms) {
    return ms >= 1000 ? `${(ms / 1000).toFixed(1)}s` : `${ms}ms`;
}
function esc(value) {
    return value.replace(/\|/g, "\\|").replace(/\r?\n/g, " ");
}
//# sourceMappingURL=reporter-markdown.js.map