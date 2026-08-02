import { isOperationIdentity } from "./types.js";
import { formatSuppressionHint } from "./suppression-guidance.js";
import { resolveFindingLocation } from "./resolve-location.js";
const SUMMARY_SEPARATOR = "─────────────────────────────";
export function formatConsoleReport(result, options = {}) {
    const visibleFindings = result.findings.filter((finding) => shouldIncludeFinding(finding, options));
    const summaryLines = [SUMMARY_SEPARATOR, formatSummary(result)];
    if (result.summary.noComparisonReason) {
        summaryLines.push(`Note: ${result.summary.noComparisonReason}`);
    }
    if (options.showTiming ?? true) {
        summaryLines.push(formatTiming(result));
    }
    if (visibleFindings.length === 0) {
        return summaryLines.join("\n");
    }
    return `${visibleFindings.map(formatFinding).join("\n\n")}\n\n${summaryLines.join("\n")}`;
}
function shouldIncludeFinding(finding, options) {
    if (finding.suppressed) {
        return options.showSuppressed ?? false;
    }
    if (finding.severity === "ignore") {
        return options.showIgnored ?? false;
    }
    return true;
}
function formatFinding(finding) {
    const lines = [`${getSeverityLabel(finding)}  ${finding.diff.kind}`, `  ${finding.diff.message}`];
    if (isOperationIdentity(finding.diff.identity)) {
        lines.push(`  Operation: ${finding.diff.identity.operation.method} ${finding.diff.identity.operation.path}`);
    }
    lines.push(`  Element: ${finding.diff.identity.element}`);
    lines.push(`  Phase: ${formatVersionPair(finding)}`);
    lines.push(`  Location: ${formatLocation(resolveFindingLocation(finding))}`);
    if (finding.suppressed && finding.suppressionReason) {
        lines.push(`  Reason: ${finding.suppressionReason}`);
    }
    else if (finding.severity === "error") {
        lines.push(`  Suppress: ${formatSuppressionHint(finding)}`);
    }
    return lines.join("\n");
}
function getSeverityLabel(finding) {
    if (finding.suppressed) {
        return "SUPPRESSED";
    }
    return finding.severity === "error" ? "ERROR" : "IGNORED";
}
function formatSummary(result) {
    const errors = countErrors(result.findings);
    const suppressed = countSuppressed(result.findings);
    const ignored = countIgnored(result.findings);
    if (errors === 0) {
        return formatNoFindingsSummary(result);
    }
    const phaseSuffix = result.summary.phase ? ` (${result.summary.phase})` : "";
    return `Results: ${errors} errors, ${suppressed} suppressed, ${ignored} ignored${phaseSuffix}`;
}
function formatTiming(result) {
    const compileMs = result.timing.compileBaseMs + result.timing.compileHeadMs;
    const diffMs = result.timing.versionMutatorsMs +
        result.timing.canonicalizeMs +
        result.timing.identityMatchingMs +
        result.timing.diffEngineMs;
    const classifyMs = result.timing.classifyMs + result.timing.suppressMs;
    return `Timing: ${formatDuration(result.timing.totalMs)} total (compile: ${formatDuration(compileMs)}, diff: ${formatDuration(diffMs)}, classify: ${formatDuration(classifyMs)})`;
}
function formatVersionPair(finding) {
    const { phase, baseVersion, headVersion } = finding.versionPair;
    return `${phase} (${baseVersion} → ${headVersion})`;
}
function countErrors(findings) {
    return findings.filter((finding) => finding.severity === "error" && !finding.suppressed).length;
}
function countSuppressed(findings) {
    return findings.filter((finding) => finding.suppressed).length;
}
function countIgnored(findings) {
    return findings.filter((finding) => finding.severity === "ignore" && !finding.suppressed).length;
}
function getLineNumber(location) {
    const text = location.file.text.substring(0, location.pos);
    return text.split("\n").length;
}
function formatLocation(location) {
    if (!location)
        return "unknown";
    const line = getLineNumber(location);
    return `${location.file.path}:${line}`;
}
function formatDuration(ms) {
    return `${(ms / 1000).toFixed(1)}s`;
}
function formatNoFindingsSummary(result) {
    const pairCount = result.summary.comparisonsPerformed;
    const pairLabel = `${pairCount} version pair${pairCount === 1 ? "" : "s"} compared`;
    switch (result.summary.phase) {
        case "same-version":
            return `✅ No unversioned changes found (${pairLabel})`;
        case "cross-version":
            return `✅ No cross-version breaking changes found (${pairLabel})`;
        default:
            return `✅ No breaking changes found (${pairLabel})`;
    }
}
//# sourceMappingURL=reporter-console.js.map