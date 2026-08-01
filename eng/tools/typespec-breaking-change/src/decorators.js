import { BreakingChangeStateKeys, reportDiagnostic } from "./lib.js";
const validDiffKinds = new Set([
    "ApiVersionRemoved",
    "ApiVersionAdded",
    "AuthSchemeRemoved",
    "AuthSchemeAdded",
    "OAuthScopeAdded",
    "OAuthScopeRemoved",
    "OperationRemoved",
    "OperationAdded",
    "OperationRouteChanged",
    "RequestPathParameterAdded",
    "RequestPathParameterRemoved",
    "RequestQueryParameterAdded",
    "RequestQueryParameterRemoved",
    "RequestHeaderAdded",
    "RequestHeaderRemoved",
    "RequestParameterRenamed",
    "RequestParameterMadeRequired",
    "RequestParameterMadeOptional",
    "RequestParameterDefaultChanged",
    "RequestParameterLocationChanged",
    "RequestPropertyAdded",
    "RequestPropertyRemoved",
    "RequestPropertyRenamed",
    "RequestPropertyTypeChanged",
    "RequestPropertyTypeNarrowed",
    "RequestPropertyTypeWidened",
    "RequestPropertyMadeRequired",
    "RequestPropertyMadeOptional",
    "RequestPropertyDefaultChanged",
    "RequestTypeChanged",
    "RequestTypeNarrowed",
    "RequestTypeWidened",
    "RequestTypeKindChanged",
    "RequestEncodingChanged",
    "RequestConstraintStrengthened",
    "RequestConstraintRelaxed",
    "RequestContentTypeAdded",
    "RequestContentTypeRemoved",
    "ResponsePropertyAdded",
    "ResponsePropertyRemoved",
    "ResponsePropertyRenamed",
    "ResponsePropertyTypeChanged",
    "ResponsePropertyTypeNarrowed",
    "ResponsePropertyTypeWidened",
    "ResponsePropertyMadeRequired",
    "ResponsePropertyMadeOptional",
    "ResponseTypeChanged",
    "ResponseTypeNarrowed",
    "ResponseTypeWidened",
    "ResponseTypeKindChanged",
    "ResponseEncodingChanged",
    "ResponseConstraintStrengthened",
    "ResponseConstraintRelaxed",
    "ResponseStatusCodeAdded",
    "ResponseStatusCodeRemoved",
    "ResponseContentTypeAdded",
    "ResponseContentTypeRemoved",
    "ResponseHeaderAdded",
    "ResponseHeaderRemoved",
    "ErrorResponseAdded",
    "ErrorResponseRemoved",
    "TypeKindChanged",
    "EnumerationMemberAdded",
    "EnumerationMemberRemoved",
    "EnumerationOpened",
    "EnumerationClosed",
    "DiscriminatorChanged",
    "DefaultValueAdded",
    "DefaultValueRemoved",
    "DefaultValueChanged",
]);
export function $approvedBreakingChange(context, target, reason, options) {
    const normalizedReason = getDecoratorStringValue(reason) ?? String(reason);
    const normalizedKind = options?.kind ? getDecoratorStringValue(options.kind) ?? options.kind : undefined;
    const normalizedSince = options?.since ? getDecoratorStringValue(options.since) ?? options.since : undefined;
    const normalizedPath = options?.path ? getDecoratorStringValue(options.path) ?? options.path : undefined;
    const resolvedKind = validateDiffKind(context, target, normalizedKind);
    if (normalizedKind !== undefined && resolvedKind === undefined) {
        return;
    }
    addSuppression(context.program, BreakingChangeStateKeys.approvedBreakingChange, target, resolvedKind, normalizedReason, normalizedSince, normalizedPath);
}
export function $approvedUnversionedChange(context, target, reason, options) {
    const normalizedReason = getDecoratorStringValue(reason) ?? String(reason);
    const normalizedKind = options?.kind ? getDecoratorStringValue(options.kind) ?? options.kind : undefined;
    const resolvedKind = validateDiffKind(context, target, normalizedKind);
    if (normalizedKind !== undefined && resolvedKind === undefined) {
        return;
    }
    addSuppression(context.program, BreakingChangeStateKeys.approvedUnversionedChange, target, resolvedKind, normalizedReason);
}
export function getSuppressions(program, type) {
    return program.stateMap(BreakingChangeStateKeys.approvedBreakingChange).get(type) ?? [];
}
export function getUnversionedSuppressions(program, type) {
    return program.stateMap(BreakingChangeStateKeys.approvedUnversionedChange).get(type) ?? [];
}
export function findSuppressions(program, type) {
    return findSuppressionsWith(program, type, getSuppressions);
}
export function findUnversionedSuppressions(program, type) {
    return findSuppressionsWith(program, type, getUnversionedSuppressions);
}
function validateDiffKind(context, target, kind) {
    if (kind === undefined) {
        return undefined;
    }
    if (validDiffKinds.has(kind)) {
        return kind;
    }
    reportDiagnostic(context.program, {
        code: "invalid-suppression-kind",
        target,
    });
    return undefined;
}
function addSuppression(program, stateKey, target, kind, reason, version, path) {
    const stateMap = program.stateMap(stateKey);
    const existing = stateMap.get(target) ?? [];
    const metadata = { kind, reason };
    if (version !== undefined)
        metadata.version = version;
    if (path !== undefined)
        metadata.path = path;
    stateMap.set(target, [...existing, metadata]);
}
function findSuppressionsWith(program, type, accessor) {
    const results = [];
    for (const target of walkSuppressionTargets(type)) {
        for (const suppression of accessor(program, target)) {
            results.push({ suppression, target });
        }
    }
    return results;
}
function* walkSuppressionTargets(type) {
    const visited = new Set();
    let current = type;
    while (current && !visited.has(current)) {
        visited.add(current);
        yield current;
        current = getParentSuppressionTarget(current);
    }
}
function getParentSuppressionTarget(type) {
    switch (type.kind) {
        case "ModelProperty":
            return type.model ?? (type.type.kind === "Model" ? type.type : undefined);
        case "Model":
        case "Interface":
            return type.namespace;
        case "Operation":
            return type.interface ?? type.namespace;
        case "Namespace":
            return type.namespace;
        default:
            return undefined;
    }
}
function getDecoratorStringValue(value) {
    if (typeof value === "string" || value === undefined) {
        return value;
    }
    if (typeof value === "object" && value !== null && "value" in value) {
        const stringValue = value.value;
        if (typeof stringValue === "string") {
            return stringValue;
        }
    }
    return undefined;
}
//# sourceMappingURL=decorators.js.map