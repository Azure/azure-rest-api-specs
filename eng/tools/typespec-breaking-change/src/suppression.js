import { findSuppressions, findUnversionedSuppressions, } from "./decorators.js";
import { isOperationIdentity } from "./types.js";
/**
 * Apply suppression metadata to classified findings.
 *
 * A suppression matches if:
 * 1. Its `kind` is undefined (wildcard) OR matches the finding's diff kind
 * 2. Its `version` is undefined (no scope) OR the finding's head version is >= the since version
 * 3. Path matching:
 *    - Direct suppression (target === finding type): no path needed, wildcard OK
 *    - Ancestor suppression (target !== finding type): path MUST be specified and match
 */
export function applySuppressions(findings, program) {
    return findings.map((finding) => {
        if (finding.severity !== "error") {
            return finding;
        }
        const targetType = finding.diff.headType ?? finding.diff.baseType;
        if (!targetType) {
            return finding;
        }
        // Collect all types where a direct (pathless) suppression is valid
        const directTargets = new Set();
        directTargets.add(targetType);
        const originType = finding.diff.origin?.type;
        if (originType)
            directTargets.add(originType);
        const allSuppressions = collectSuppressions(finding, program, targetType);
        const match = allSuppressions.find((suppression) => matchesKind(suppression, finding) &&
            matchesVersion(suppression, finding) &&
            matchesPathOrDirect(suppression, finding, directTargets));
        if (!match) {
            return finding;
        }
        return {
            ...finding,
            suppressed: true,
            suppressionReason: match.suppression.reason,
        };
    });
}
/**
 * Collect suppressions from the wire type, origin type, and operation type.
 */
function collectSuppressions(finding, program, targetType) {
    const finder = finding.phase === "same-version" ? findUnversionedSuppressions : findSuppressions;
    const suppressions = [...finder(program, targetType)];
    const originType = finding.diff.origin?.type;
    if (originType && originType !== targetType) {
        suppressions.push(...finder(program, originType));
    }
    const operationType = finding.diff.operationType;
    if (operationType && operationType !== targetType && operationType !== originType) {
        suppressions.push(...finder(program, operationType));
    }
    return suppressions;
}
function matchesKind(suppression, finding) {
    return (suppression.suppression.kind === undefined || suppression.suppression.kind === finding.diff.kind);
}
function matchesVersion(suppression, finding) {
    return (suppression.suppression.version === undefined ||
        finding.versionPair.headVersion >= suppression.suppression.version);
}
/**
 * Check if a suppression matches via direct placement or identity path.
 *
 * - Direct: suppression target IS the finding's type → matches without path
 * - Ancestor: suppression target is NOT the finding's type → requires path to match
 */
function matchesPathOrDirect(suppression, finding, directTargets) {
    const isDirect = directTargets.has(suppression.target);
    const suppressionPath = suppression.suppression.path;
    if (isDirect && !suppressionPath) {
        // Direct suppression without path — always matches (wildcard on target)
        return true;
    }
    if (!isDirect && !suppressionPath) {
        // Ancestor suppression without path — does NOT match
        return false;
    }
    // Path specified — match against the finding's full identity path
    return matchesPath(suppressionPath, finding);
}
/**
 * Compose the full identity path from an OperationDiffIdentity.
 *
 * Per design doc §3.1:
 * - Request elements: request.{element} (e.g., request.body.properties.tags, request.query.filter)
 * - Response elements: responses.{statusCode}.{element} (e.g., responses.200.body.properties.name)
 */
export function composeFullIdentityPath(identity) {
    if (identity.component === "request") {
        return `request.${identity.element}`;
    }
    const statusCode = identity.statusCode ?? "*";
    return `responses.${statusCode}.${identity.element}`;
}
/**
 * Match a suppression path against the finding's identity.
 *
 * The suppression path can be:
 * - Absolute from operation root: "responses.200.body.properties.legacy"
 * - Relative from anchor: "properties.legacy" (matches as a suffix)
 *
 * Per design §6.5: both relative and absolute paths are supported.
 * Relative paths match at dot boundaries.
 */
function matchesPath(suppressionPath, finding) {
    const identity = finding.diff.identity;
    if (!isOperationIdentity(identity))
        return false;
    const fullPath = composeFullIdentityPath(identity);
    // Exact match (absolute path from operation root)
    if (fullPath === suppressionPath)
        return true;
    // Suffix match at dot boundary (relative path from anchor)
    if (fullPath.endsWith(`.${suppressionPath}`))
        return true;
    return false;
}
//# sourceMappingURL=suppression.js.map