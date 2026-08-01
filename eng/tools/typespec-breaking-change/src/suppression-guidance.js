import { isOperationIdentity } from "./types.js";
/**
 * Generate suppression guidance for a finding.
 * Tells the user what decorator to use and where to place it.
 */
export function formatSuppressionGuidance(finding) {
    const kind = finding.diff.kind;
    const decoratorName = finding.phase === "same-version" ? "@approvedUnversionedChange" : "@approvedBreakingChange";
    const decorator = `${decoratorName}("your reason here", #{ kind: "${kind}" })`;
    const placement = getPlacementDescription(finding);
    const file = getTargetFile(finding);
    const example = buildExample(finding, decorator);
    return { decorator, placement, file, example };
}
/**
 * Get a one-line suppression hint suitable for console/annotation output.
 */
export function formatSuppressionHint(finding) {
    const decoratorName = finding.phase === "same-version" ? "@approvedUnversionedChange" : "@approvedBreakingChange";
    return `${decoratorName}("your reason here", #{ kind: "${finding.diff.kind}" })`;
}
/**
 * Describe where the suppression decorator should be placed.
 */
function getPlacementDescription(finding) {
    // If we have an origin, the decorator goes on the origin type
    if (finding.diff.origin) {
        return `On the declaration: ${finding.diff.origin.declarationPath}`;
    }
    // For operation-level changes, place on the operation
    if (isOperationIdentity(finding.diff.identity)) {
        const op = finding.diff.identity.operation;
        return `On the operation: ${op.method} ${op.path} (or on the affected model/property)`;
    }
    // Service-level changes
    return `On the service namespace or affected declaration`;
}
/**
 * Get the target file for placement (from origin or finding location).
 */
function getTargetFile(finding) {
    if (finding.diff.origin?.sourceLocation) {
        return finding.diff.origin.sourceLocation.file.path;
    }
    const loc = finding.diff.headSourceLocation ?? finding.diff.baseSourceLocation;
    return loc?.file.path;
}
/**
 * Build a code example showing the decorator in context.
 */
function buildExample(finding, decorator) {
    if (finding.diff.origin) {
        const path = finding.diff.origin.declarationPath;
        const parts = path.split(".");
        const name = parts[parts.length - 1];
        // Check if this is a property-level diff (element contains a property path)
        const element = finding.diff.identity.element;
        const isPropertyLevel = element.includes("properties.") ||
            element.includes("query.") ||
            element.includes("headers.") ||
            element.includes("path.");
        if (isPropertyLevel && parts.length > 1) {
            const parentName = parts[parts.length - 2];
            return [
                `model ${parentName} {`,
                `  ${decorator}`,
                `  ${name}: ...;`,
                `}`,
            ].join("\n");
        }
        // Type-level origin
        return [
            `${decorator}`,
            `model ${name} { ... }`,
        ].join("\n");
    }
    // Operation-level
    if (isOperationIdentity(finding.diff.identity)) {
        const opName = finding.diff.identity.operation.name ?? "myOperation";
        return [
            `${decorator}`,
            `op ${opName}(...): ...;`,
        ].join("\n");
    }
    // Fallback
    return decorator;
}
//# sourceMappingURL=suppression-guidance.js.map