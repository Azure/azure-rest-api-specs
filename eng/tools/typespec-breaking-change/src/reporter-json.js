import { isOperationIdentity } from "./types.js";
import { formatSuppressionGuidance } from "./suppression-guidance.js";
import { resolveFindingLocation } from "./resolve-location.js";
export function formatJsonReport(result, options) {
    const errors = result.findings.filter((f) => f.severity === "error" && !f.suppressed);
    const report = {
        specPaths: options?.specPaths ?? [],
        baseRevision: options?.baseRevision,
        headRevision: options?.headRevision,
        requiresAction: errors.length > 0,
        counts: {
            errors: errors.length,
            suppressed: result.findings.filter((f) => f.suppressed).length,
            ignored: result.findings.filter((f) => f.severity === "ignore" && !f.suppressed).length,
            totalFindings: result.findings.length,
            servicesAnalyzed: result.summary.servicesAnalyzed,
            comparisonsPerformed: result.summary.comparisonsPerformed,
        },
        noComparisonReason: result.summary.noComparisonReason,
        findings: result.findings.map(mapFinding),
        timing: result.timing,
    };
    return JSON.stringify(report, null, 2);
}
function mapFinding(finding) {
    const location = resolveFindingLocation(finding);
    const baseFinding = {
        kind: finding.diff.kind,
        severity: finding.severity,
        rule: finding.rule,
        phase: finding.phase,
        suppressed: finding.suppressed,
        suppressionReason: finding.suppressionReason,
        message: finding.diff.message,
        element: finding.diff.identity.element,
        versionPair: {
            baseVersion: finding.versionPair.baseVersion,
            headVersion: finding.versionPair.headVersion,
        },
        location: location
            ? {
                file: location.file.path,
                line: getLineNumber(location),
            }
            : undefined,
    };
    if (isOperationIdentity(finding.diff.identity)) {
        baseFinding.operation = {
            method: finding.diff.identity.operation.method,
            path: finding.diff.identity.operation.path,
        };
        baseFinding.component = finding.diff.identity.component;
        baseFinding.statusCode = finding.diff.identity.statusCode;
    }
    // Include suppression guidance for unsuppressed errors
    if (finding.severity === "error" && !finding.suppressed) {
        const guidance = formatSuppressionGuidance(finding);
        baseFinding.suppression = {
            decorator: guidance.decorator,
            placement: guidance.placement,
            file: guidance.file,
            example: guidance.example,
        };
    }
    return baseFinding;
}
function getLineNumber(location) {
    const text = location.file.text.substring(0, location.pos);
    return text.split("\n").length;
}
//# sourceMappingURL=reporter-json.js.map