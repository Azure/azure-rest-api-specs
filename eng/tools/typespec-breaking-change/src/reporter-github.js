import { isOperationIdentity } from "./types.js";
export function formatGithubReport(result) {
    const errors = result.findings.filter((finding) => finding.severity === "error" && !finding.suppressed);
    const suppressed = result.findings.filter((finding) => finding.suppressed);
    const lines = [
        "## Breaking Change Analysis",
        "",
        `**${errors.length} breaking change${errors.length === 1 ? "" : "s"} detected** (${suppressed.length} suppressed)`,
    ];
    if (errors.length > 0) {
        lines.push("", "### Errors", "| Kind | Operation | Element | Phase | Version Pair |", "|------|-----------|---------|-------|--------------|", ...errors.map((finding) => `| ${escapeCell(finding.diff.kind)} | ${escapeCell(formatOperation(finding))} | ${escapeCell(finding.diff.identity.element)} | ${escapeCell(finding.phase)} | ${escapeCell(formatVersionPair(finding))} |`));
    }
    if (suppressed.length > 0) {
        lines.push("", "### Suppressed", "| Kind | Operation | Reason |", "|------|-----------|--------|", ...suppressed.map((finding) => `| ${escapeCell(finding.diff.kind)} | ${escapeCell(formatOperation(finding))} | ${escapeCell(finding.suppressionReason ?? "")} |`));
    }
    lines.push("", "<details>", "<summary>Timing</summary>", "", `Total: ${formatDuration(result.timing.totalMs)} | Compile: ${formatDuration(result.timing.compileBaseMs + result.timing.compileHeadMs)} | Diff: ${formatDuration(result.timing.versionMutatorsMs +
        result.timing.canonicalizeMs +
        result.timing.identityMatchingMs +
        result.timing.diffEngineMs)} | Classify: ${formatDuration(result.timing.classifyMs + result.timing.suppressMs)}`, "</details>");
    return lines.join("\n");
}
function formatOperation(finding) {
    if (!isOperationIdentity(finding.diff.identity)) {
        return "—";
    }
    return `${finding.diff.identity.operation.method} ${finding.diff.identity.operation.path}`;
}
function formatVersionPair(finding) {
    return `${finding.versionPair.baseVersion} → ${finding.versionPair.headVersion}`;
}
function formatDuration(ms) {
    return `${(ms / 1000).toFixed(1)}s`;
}
function escapeCell(value) {
    return value.replace(/\|/g, "\\|").replace(/\r?\n/g, "<br>");
}
//# sourceMappingURL=reporter-github.js.map