import { createApproveBreakingChangeCodeFix } from "./codefixes.js";
import { $lib } from "./lib.js";
/**
 * Emit breaking change findings as TypeSpec diagnostics on the program.
 *
 * Each unsuppressed error-severity finding becomes a diagnostic with:
 * - Source location pointing to the origin or head declaration
 * - A codefix to add @approvedBreakingChange decorator
 *
 * This integrates with the TypeSpec IDE experience (VS Code, etc.) so users
 * see breaking changes inline and can apply the suppression codefix.
 */
export function emitFindingDiagnostics(program, result) {
    const diagnostics = [];
    for (const finding of result.findings) {
        if (finding.suppressed)
            continue;
        if (finding.severity !== "error")
            continue;
        const target = getDiagnosticTarget(finding);
        if (!target)
            continue;
        const codefix = createApproveBreakingChangeCodeFix(finding);
        const codefixes = codefix ? [codefix] : [];
        const diagnostic = $lib.createDiagnostic({
            code: "breaking-change",
            target: target,
            format: { message: finding.diff.message },
            codefixes,
        });
        diagnostics.push(diagnostic);
    }
    return diagnostics;
}
/**
 * Determine the best diagnostic target for a finding.
 * Prefers origin (named declaration) for better source location,
 * falls back to head/base type.
 */
function getDiagnosticTarget(finding) {
    if (finding.diff.origin?.type) {
        return finding.diff.origin.type;
    }
    if (finding.diff.headType) {
        return finding.diff.headType;
    }
    if (finding.diff.baseType) {
        return finding.diff.baseType;
    }
    return undefined;
}
//# sourceMappingURL=diagnostics.js.map