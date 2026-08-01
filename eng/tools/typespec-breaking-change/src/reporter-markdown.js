import { formatSuppressionHint } from "./suppression-guidance.js";
import { resolveFindingLocation } from "./resolve-location.js";
/** Default URL for the violations reference docs in the typespec-azure repo. */
const DEFAULT_VIOLATIONS_REF_URL = "https://github.com/Azure/typespec-azure/blob/main/packages/typespec-breaking-change/docs/violations-reference.md";
/**
 * Render a Markdown summary suitable for PR comments.
 */
export function renderMarkdownSummary(result, options) {
    const errors = result.findings.filter((f) => f.severity === "error" && !f.suppressed);
    const suppressed = result.findings.filter((f) => f.suppressed);
    const lines = [];
    // Header
    lines.push("## Breaking Change Analysis");
    lines.push("");
    // Spec path context
    if (options?.specPaths && options.specPaths.length > 0) {
        for (const sp of options.specPaths) {
            lines.push(`**Spec:** \`${sp}\``);
        }
        lines.push("");
    }
    // No comparison reason
    if (result.summary.noComparisonReason) {
        lines.push(`ℹ️ ${result.summary.noComparisonReason}`);
        lines.push("");
        return lines.join("\n");
    }
    // Status badge
    if (errors.length === 0 && suppressed.length === 0) {
        lines.push("✅ **No breaking changes detected**");
    }
    else if (errors.length === 0) {
        lines.push(`⚠️ **${suppressed.length} new suppressed breaking change${suppressed.length === 1 ? "" : "s"}** — review required`);
    }
    else {
        lines.push(`❌ **${errors.length} unsuppressed breaking change${errors.length === 1 ? "" : "s"} detected**`);
    }
    // Summary stats
    const parts = [];
    if (errors.length > 0)
        parts.push(`${errors.length} unsuppressed`);
    if (suppressed.length > 0)
        parts.push(`${suppressed.length} suppressed`);
    parts.push(`${result.summary.comparisonsPerformed} version pair${result.summary.comparisonsPerformed === 1 ? "" : "s"} compared`);
    lines.push("");
    lines.push(parts.join(" · "));
    // Deduplicate findings — same kind + element + version pair across operations
    const dedupedErrors = deduplicateFindings(errors);
    const dedupedSuppressed = deduplicateFindings(suppressed);
    // Unsuppressed breaking changes
    if (dedupedErrors.length > 0) {
        lines.push("");
        lines.push("### Unsuppressed Breaking Changes");
        lines.push("");
        lines.push("| Kind | Identity | Versions | Suppression |");
        lines.push("|------|----------|----------|-------------|");
        for (const finding of dedupedErrors) {
            const kind = fmtKindLink(finding.diff.kind, options);
            const identity = fmtIdentityLink(finding, options);
            const versions = esc(fmtVer(finding));
            const hint = esc(formatSuppressionHint(finding));
            lines.push(`| ${kind} | ${identity} | ${versions} | \`${hint}\` |`);
        }
    }
    // New suppressed breaking changes
    if (dedupedSuppressed.length > 0) {
        lines.push("");
        lines.push("### New Suppressed Breaking Changes");
        lines.push("");
        lines.push("The following breaking changes have `@approvedBreakingChange` decorators.");
        lines.push("Reviewers should verify these changes are intentional and properly justified.");
        lines.push("");
        lines.push("| Kind | Identity | Reason |");
        lines.push("|------|----------|--------|");
        for (const finding of dedupedSuppressed) {
            const kind = fmtKindLink(finding.diff.kind, options);
            const identity = fmtIdentityLink(finding, options);
            const reason = esc(finding.suppressionReason ?? "—");
            lines.push(`| ${kind} | ${identity} | ${reason} |`);
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
/**
 * Deduplicate findings that share the same kind, element path, and version pair
 * but differ only in operation (e.g., PUT vs PATCH for the same model property).
 * Keeps the first finding (which has the best source location).
 */
function deduplicateFindings(findings) {
    const seen = new Set();
    const result = [];
    for (const f of findings) {
        const key = `${f.diff.kind}|${f.diff.identity.element}|${f.versionPair.baseVersion}|${f.versionPair.headVersion}`;
        if (!seen.has(key)) {
            seen.add(key);
            result.push(f);
        }
    }
    return result;
}
/** Format a DiffKind as a link to the violations reference docs. */
function fmtKindLink(kind, options) {
    const baseUrl = options?.violationsReferenceUrl ?? DEFAULT_VIOLATIONS_REF_URL;
    // Link to the Phase B summary table which lists all kinds
    return `[\`${esc(kind)}\`](${baseUrl}#phase-b-summary-table)`;
}
/** Format the identity as a link to the source file, or plain text if no link available. */
function fmtIdentityLink(finding, options) {
    const element = finding.diff.identity.element;
    const location = resolveFindingLocation(finding);
    const url = buildSourceUrl(location, options);
    if (url) {
        return `[\`${esc(element)}\`](${url})`;
    }
    return `\`${esc(element)}\``;
}
/** Build a GitHub source URL from a SourceLocation. */
function buildSourceUrl(location, options) {
    if (!location?.file?.path)
        return undefined;
    if (!options?.githubRepository)
        return undefined;
    const server = options.githubServerUrl ?? "https://github.com";
    const sha = options.githubSha ?? "HEAD";
    let filePath = location.file.path;
    // Make path relative to workspace
    if (options.workspacePath) {
        const prefix = options.workspacePath.endsWith("/")
            ? options.workspacePath
            : options.workspacePath + "/";
        if (filePath.startsWith(prefix)) {
            filePath = filePath.substring(prefix.length);
        }
    }
    // Skip non-workspace files (node_modules, intrinsics, etc.)
    if (filePath.includes("node_modules/") || filePath.startsWith("/")) {
        return undefined;
    }
    const line = getLineNumber(location);
    const lineAnchor = line > 0 ? `#L${line}` : "";
    return `${server}/${options.githubRepository}/blob/${sha}/${filePath}${lineAnchor}`;
}
function getLineNumber(location) {
    if (!location.file?.text || location.pos === undefined)
        return 0;
    const text = location.file.text.substring(0, location.pos);
    return text.split("\n").length;
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