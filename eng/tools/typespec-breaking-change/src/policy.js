const PHASE_B_RULES = {
    ApiVersionRemoved: { severity: "error", rule: "service-level" },
    ApiVersionAdded: { severity: "ignore", rule: "service-level" },
    AuthSchemeRemoved: { severity: "error", rule: "service-level" },
    AuthSchemeAdded: { severity: "ignore", rule: "service-level" },
    OAuthScopeAdded: { severity: "ignore", rule: "service-level" },
    OAuthScopeRemoved: { severity: "error", rule: "service-level" },
    OperationRemoved: { severity: "error", rule: "operation-lifecycle" },
    OperationAdded: { severity: "ignore", rule: "operation-lifecycle" },
    OperationRouteChanged: { severity: "error", rule: "operation-lifecycle" },
    RequestPathParameterAdded: { severity: "error", rule: "request-narrowing" },
    RequestPathParameterRemoved: { severity: "error", rule: "request-narrowing" },
    RequestQueryParameterAdded: { severity: "ignore", rule: "request-widening" },
    RequestQueryParameterRemoved: { severity: "error", rule: "request-narrowing" },
    RequestHeaderAdded: { severity: "ignore", rule: "request-widening" },
    RequestHeaderRemoved: { severity: "error", rule: "request-narrowing" },
    RequestParameterRenamed: { severity: "error", rule: "request-narrowing" },
    RequestParameterMadeRequired: { severity: "error", rule: "request-narrowing" },
    RequestParameterMadeOptional: { severity: "ignore", rule: "request-widening" },
    RequestParameterDefaultChanged: { severity: "ignore", rule: "default-value-change" },
    RequestParameterLocationChanged: { severity: "error", rule: "request-narrowing" },
    RequestPropertyAdded: { severity: "error", rule: "request-narrowing" },
    RequestPropertyRemoved: { severity: "error", rule: "request-narrowing" },
    RequestPropertyRenamed: { severity: "error", rule: "request-narrowing" },
    RequestPropertyTypeChanged: { severity: "error", rule: "request-narrowing" },
    RequestPropertyTypeNarrowed: { severity: "error", rule: "request-narrowing" },
    RequestPropertyTypeWidened: { severity: "ignore", rule: "request-widening" },
    RequestPropertyMadeRequired: { severity: "error", rule: "request-narrowing" },
    RequestPropertyMadeOptional: { severity: "ignore", rule: "request-widening" },
    RequestPropertyDefaultChanged: { severity: "ignore", rule: "default-value-change" },
    RequestTypeChanged: { severity: "error", rule: "request-narrowing" },
    RequestTypeNarrowed: { severity: "error", rule: "request-narrowing" },
    RequestTypeWidened: { severity: "ignore", rule: "request-widening" },
    RequestTypeKindChanged: { severity: "error", rule: "type-kind-change" },
    RequestEncodingChanged: { severity: "error", rule: "encoding-change" },
    RequestConstraintStrengthened: { severity: "error", rule: "request-narrowing" },
    RequestConstraintRelaxed: { severity: "ignore", rule: "request-widening" },
    RequestContentTypeAdded: { severity: "ignore", rule: "request-widening" },
    RequestContentTypeRemoved: { severity: "error", rule: "request-narrowing" },
    ResponsePropertyAdded: { severity: "ignore", rule: "response-narrowing" },
    ResponsePropertyRemoved: { severity: "error", rule: "response-contract-weakened" },
    ResponsePropertyRenamed: { severity: "error", rule: "response-contract-weakened" },
    ResponsePropertyTypeChanged: { severity: "error", rule: "response-contract-weakened" },
    ResponsePropertyTypeNarrowed: { severity: "ignore", rule: "response-narrowing" },
    ResponsePropertyTypeWidened: { severity: "error", rule: "response-widening" },
    ResponsePropertyMadeRequired: { severity: "ignore", rule: "response-narrowing" },
    ResponsePropertyMadeOptional: { severity: "error", rule: "response-contract-weakened" },
    ResponseTypeChanged: { severity: "error", rule: "response-widening" },
    ResponseTypeNarrowed: { severity: "ignore", rule: "response-narrowing" },
    ResponseTypeWidened: { severity: "error", rule: "response-widening" },
    ResponseTypeKindChanged: { severity: "error", rule: "type-kind-change" },
    ResponseEncodingChanged: { severity: "error", rule: "encoding-change" },
    ResponseConstraintStrengthened: { severity: "ignore", rule: "response-narrowing" },
    ResponseConstraintRelaxed: { severity: "error", rule: "response-contract-weakened" },
    ResponseStatusCodeAdded: { severity: "ignore", rule: "response-narrowing" },
    ResponseStatusCodeRemoved: { severity: "error", rule: "response-contract-weakened" },
    ResponseContentTypeAdded: { severity: "ignore", rule: "response-narrowing" },
    ResponseContentTypeRemoved: { severity: "error", rule: "response-contract-weakened" },
    ResponseHeaderAdded: { severity: "ignore", rule: "response-narrowing" },
    ResponseHeaderRemoved: { severity: "error", rule: "response-contract-weakened" },
    ErrorResponseAdded: { severity: "ignore", rule: "response-narrowing" },
    ErrorResponseRemoved: { severity: "ignore", rule: "response-narrowing" },
    TypeKindChanged: { severity: "error", rule: "type-kind-change" },
    EnumerationMemberAdded: { severity: "ignore", rule: "service-level" },
    EnumerationMemberRemoved: { severity: "error", rule: "request-narrowing" },
    EnumerationOpened: { severity: "ignore", rule: "service-level" },
    EnumerationClosed: { severity: "error", rule: "request-narrowing" },
    DiscriminatorChanged: { severity: "error", rule: "type-kind-change" },
    DefaultValueAdded: { severity: "ignore", rule: "default-value-change" },
    DefaultValueRemoved: { severity: "ignore", rule: "default-value-change" },
    DefaultValueChanged: { severity: "ignore", rule: "default-value-change" },
    ResourcePropertyAdded: { severity: "error", rule: "resource-contract-change" },
    ResourcePropertyRemoved: { severity: "error", rule: "resource-contract-change" },
    ResourcePropertyRenamed: { severity: "error", rule: "resource-contract-change" },
    ResourcePropertyTypeChanged: { severity: "error", rule: "resource-contract-change" },
    ResourcePropertyTypeNarrowed: { severity: "error", rule: "resource-contract-change" },
    ResourcePropertyTypeWidened: { severity: "error", rule: "resource-contract-change" },
    ResourcePropertyMadeRequired: { severity: "error", rule: "resource-contract-change" },
    ResourcePropertyMadeOptional: { severity: "error", rule: "resource-contract-change" },
};
/**
 * Classify an array of diffs into findings based on phase and directional rules.
 */
export function classifyDiffs(diffs, phase, versionPair) {
    return diffs.map((diff) => classifyDiff(diff, phase, versionPair));
}
/**
 * Classify a single diff into a finding.
 */
function classifyDiff(diff, phase, versionPair) {
    if (phase === "same-version") {
        return classifyPhaseA(diff, versionPair);
    }
    return classifyPhaseB(diff, versionPair);
}
function classifyPhaseA(diff, versionPair) {
    return {
        diff,
        severity: "error",
        rule: "phase-a-any-change",
        phase: "same-version",
        suppressed: false,
        versionPair,
    };
}
function classifyPhaseB(diff, versionPair) {
    const classification = refineClassification(diff, PHASE_B_RULES[diff.kind]);
    return {
        diff,
        severity: classification.severity,
        rule: classification.rule,
        phase: "cross-version",
        suppressed: false,
        versionPair,
    };
}
/**
 * Refine a static classification using runtime type information from the diff.
 *
 * For example, RequestPropertyAdded is only breaking if the added property is
 * required. An optional property addition widens the request contract.
 * Same logic applies to request parameters (query, header) — adding optional
 * params is non-breaking.
 */
function refineClassification(diff, base) {
    const optionalAddKinds = [
        "RequestPropertyAdded",
        "RequestQueryParameterAdded",
        "RequestHeaderAdded",
    ];
    if (optionalAddKinds.includes(diff.kind) && isOptionalProperty(diff)) {
        return { severity: "ignore", rule: "request-widening" };
    }
    return base;
}
function isOptionalProperty(diff) {
    const type = diff.headType;
    if (type && type.kind === "ModelProperty") {
        return type.optional;
    }
    // Defensive: in practice this is unreachable — isOptionalProperty is only called
    // for *Added diff kinds, so headType should always be a ModelProperty.
    // Consider replacing with an assertion if this assumption is validated.
    return false;
}
//# sourceMappingURL=policy.js.map