import { canonicalizeOperations, } from "./canonicalize.js";
import { diffOperations } from "./diff-operations.js";
import { getSourceLocation } from "@typespec/compiler";
import { isOperationIdentity } from "./types.js";
/**
 * Compute all API diffs between base and head versioned views.
 *
 * Orchestration:
 * 1. Canonicalize both sides using HttpCanonicalizer
 * 2. Match operations by identity (method + normalized path)
 * 3. For unmatched: emit OperationAdded/OperationRemoved
 * 4. For matched: delegate to diffOperations for structural comparison
 */
export function computeDiffs(base, head) {
    const baseCanonicalization = canonicalizeOperations(base.program, base.versionedNamespace);
    const headCanonicalization = canonicalizeOperations(head.program, head.versionedNamespace);
    const diffs = [];
    const baseOps = baseCanonicalization.operations;
    const headOps = headCanonicalization.operations;
    for (const [key, baseOp] of baseOps) {
        if (!headOps.has(key)) {
            diffs.push(makeOperationDiff("OperationRemoved", baseOp.identity, `Operation ${baseOp.identity.method} ${baseOp.identity.path} was removed.`, getOperationSourceLocation(baseOp.httpOperation.operation)));
        }
    }
    for (const [key, headOp] of headOps) {
        if (!baseOps.has(key)) {
            diffs.push(makeOperationDiff("OperationAdded", headOp.identity, `Operation ${headOp.identity.method} ${headOp.identity.path} was added.`, getOperationSourceLocation(headOp.httpOperation.operation)));
        }
    }
    for (const [key, baseOp] of baseOps) {
        const headOp = headOps.get(key);
        if (headOp) {
            const opDiffs = diffOperations(baseOp.canonical, headOp.canonical, baseOp.identity);
            // Attach operation source location and operation Type to all diffs
            const headOperation = headOp.httpOperation.operation;
            const opLoc = getOperationSourceLocation(headOperation);
            for (const diff of opDiffs) {
                if (!diff.operationSourceLocation && opLoc) {
                    diff.operationSourceLocation = opLoc;
                }
                if (!diff.operationType && headOperation) {
                    diff.operationType = headOperation;
                }
            }
            diffs.push(...opDiffs);
        }
    }
    return {
        diffs: deduplicateDiffs(diffs),
        baseCanonicalization,
        headCanonicalization,
    };
}
/**
 * Get the source location of a TypeSpec operation, preferring user code.
 */
function getOperationSourceLocation(operation) {
    if (!operation)
        return undefined;
    return getSourceLocation(operation, { locateId: true }) ?? getSourceLocation(operation) ?? undefined;
}
/**
 * Helper to create an operation-level diff (added/removed).
 */
function makeOperationDiff(kind, identity, message, operationSourceLocation) {
    const diffIdentity = {
        operation: identity,
        component: "request",
        element: "",
    };
    return {
        kind,
        identity: diffIdentity,
        message,
        operationSourceLocation,
    };
}
/**
 * Deduplicate diffs that share the same origin declaration and DiffKind.
 *
 * When a model type is used in multiple operations, the same structural change
 * produces duplicate diffs. This groups them by {origin.declarationPath, kind}
 * and collapses each group to a single diff, annotating it with all affected operations.
 *
 * Diffs without an origin (operation-specific) pass through unchanged.
 */
export function deduplicateDiffs(diffs) {
    const withOrigin = [];
    const withoutOrigin = [];
    for (const diff of diffs) {
        if (diff.origin) {
            withOrigin.push(diff);
        }
        else {
            withoutOrigin.push(diff);
        }
    }
    if (withOrigin.length === 0) {
        return diffs;
    }
    // Group by {declarationPath, kind}
    const groups = new Map();
    for (const diff of withOrigin) {
        const key = `${diff.origin.declarationPath}::${diff.kind}`;
        const group = groups.get(key);
        if (group) {
            group.push(diff);
        }
        else {
            groups.set(key, [diff]);
        }
    }
    const deduplicated = [];
    for (const [, group] of groups) {
        const representative = group[0];
        if (group.length === 1) {
            deduplicated.push(representative);
            continue;
        }
        // Collect all affected operations
        const affectedOperations = [];
        for (const diff of group) {
            if (isOperationIdentity(diff.identity)) {
                const op = diff.identity.operation;
                if (!affectedOperations.some((a) => a.method === op.method && a.path === op.path)) {
                    affectedOperations.push(op);
                }
            }
        }
        deduplicated.push({
            ...representative,
            details: {
                ...representative.details,
                affectedOperations,
                deduplicatedCount: group.length,
            },
        });
    }
    return [...deduplicated, ...withoutOrigin];
}
//# sourceMappingURL=diff-engine.js.map