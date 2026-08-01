import { createAddDecoratorCodeFix } from "@typespec/compiler";
/**
 * Create a codefix that adds @approvedBreakingChange decorator to suppress a finding.
 *
 * Targets the origin declaration type when available (suppresses all uses of that declaration),
 * falling back to the head type (wire type where the change was detected).
 *
 * @param finding - The finding to create a codefix for
 * @returns A CodeFix, or undefined if no suitable target exists
 */
export function createApproveBreakingChangeCodeFix(finding) {
    const target = getCodefixTarget(finding);
    if (!target)
        return undefined;
    return createAddDecoratorCodeFix(target, "approvedBreakingChange", [
        `"Approved: ${escapeString(finding.diff.message)}"`,
        `#{ kind: "${escapeString(finding.diff.kind)}" }`,
    ]);
}
/**
 * Get the best target node for the codefix decorator insertion.
 * Prefers origin type (named declaration) over wire type.
 */
function getCodefixTarget(finding) {
    // Prefer origin — it's the named declaration that "owns" the change
    if (finding.diff.origin?.type) {
        return finding.diff.origin.type;
    }
    // Fallback to head type (where the change is visible in the current spec)
    if (finding.diff.headType) {
        return finding.diff.headType;
    }
    // For removals, the base type might be all we have
    return finding.diff.baseType;
}
function escapeString(s) {
    return s.replace(/\\/g, "\\\\").replace(/"/g, '\\"');
}
//# sourceMappingURL=codefixes.js.map