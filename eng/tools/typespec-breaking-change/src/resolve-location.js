import { getSourceLocation } from "@typespec/compiler";
/**
 * Resolve the source location for a finding, using a cascading fallback chain
 * that guarantees a location is always returned when possible.
 *
 * Fallback chain (in priority order):
 * 1. Origin source location (most specific — points to named type/property declaration)
 * 2. Direct source location on the diff (headSourceLocation or baseSourceLocation)
 * 3. Parent model source location (when property type is Intrinsic or has no location)
 * 4. Operation declaration source location (always available for operation-relative diffs)
 *
 * This function should never return undefined for operation-relative diffs.
 */
export function resolveFindingLocation(finding) {
    const diff = finding.diff;
    // 1. Origin source location (property/type declaration in user code)
    if (diff.origin?.sourceLocation && isValidSourceLocation(diff.origin.sourceLocation)) {
        return diff.origin.sourceLocation;
    }
    // 2. Direct source location on the diff
    const directLoc = diff.headSourceLocation ?? diff.baseSourceLocation;
    if (directLoc && isValidSourceLocation(directLoc)) {
        return directLoc;
    }
    // 3. Parent model fallback — when type exists but has no useful location
    const type = diff.headType ?? diff.baseType;
    if (type) {
        const modelLoc = resolveTypeLocationWithModelFallback(type);
        if (modelLoc && isValidSourceLocation(modelLoc)) {
            return modelLoc;
        }
    }
    // 4. Operation declaration source location (final fallback)
    if (diff.operationSourceLocation && isValidSourceLocation(diff.operationSourceLocation)) {
        return diff.operationSourceLocation;
    }
    return undefined;
}
/**
 * Try to get a source location for a type, falling back to its parent model.
 *
 * Handles cases where:
 * - Type is Intrinsic (boolean, int32, etc.) with no user-code location
 * - Property is on an anonymous model
 * - Type has a synthetic/unknown location
 */
function resolveTypeLocationWithModelFallback(type) {
    // Try direct location on the type
    const typeLoc = safeGetSourceLocation(type);
    if (typeLoc && isValidSourceLocation(typeLoc)) {
        return typeLoc;
    }
    // For ModelProperty: try the parent model
    if (type.kind === "ModelProperty") {
        const prop = type;
        // Follow sourceProperty chain first
        let current = prop;
        while (current.sourceProperty) {
            current = current.sourceProperty;
        }
        const chainLoc = safeGetSourceLocation(current);
        if (chainLoc && isValidSourceLocation(chainLoc)) {
            return chainLoc;
        }
        // Fall back to parent model
        if (current.model) {
            const modelLoc = safeGetSourceLocation(current.model);
            if (modelLoc && isValidSourceLocation(modelLoc)) {
                return modelLoc;
            }
        }
    }
    // For EnumMember: try parent enum
    if (type.kind === "EnumMember" && type.enum) {
        const enumLoc = safeGetSourceLocation(type.enum);
        if (enumLoc && isValidSourceLocation(enumLoc)) {
            return enumLoc;
        }
    }
    // For UnionVariant: try parent union
    if (type.kind === "UnionVariant" && type.union) {
        const unionLoc = safeGetSourceLocation(type.union);
        if (unionLoc && isValidSourceLocation(unionLoc)) {
            return unionLoc;
        }
    }
    return undefined;
}
/**
 * Check if a source location is valid and points to real code.
 * Rejects empty/synthetic locations and <unknown> markers.
 */
function isValidSourceLocation(loc) {
    if (!loc || !loc.file)
        return false;
    if (!loc.file.path || loc.file.path === "<unknown location>")
        return false;
    return true;
}
/**
 * Safely get source location from a type.
 */
function safeGetSourceLocation(type) {
    try {
        return getSourceLocation(type, { locateId: true }) ?? getSourceLocation(type) ?? undefined;
    }
    catch {
        return undefined;
    }
}
//# sourceMappingURL=resolve-location.js.map