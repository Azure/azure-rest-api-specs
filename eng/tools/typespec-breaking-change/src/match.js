/**
 * Match operations between base and head by wire identity.
 * Identifies matched pairs, added operations, and removed operations.
 *
 * @param baseOps - Resolved operations from the base version
 * @param headOps - Resolved operations from the head version
 * @returns Matched, added, and removed operations
 */
export function matchOperations(baseOps, headOps) {
    const matched = [];
    const removed = [];
    const added = [];
    // Find matched and removed (in base, check if in head)
    for (const [key, baseOp] of baseOps.operations) {
        const headOp = headOps.operations.get(key);
        if (headOp) {
            matched.push({
                identity: baseOp.identity,
                base: baseOp,
                head: headOp,
            });
        }
        else {
            removed.push(baseOp);
        }
    }
    // Find added (in head but not in base)
    for (const [key, headOp] of headOps.operations) {
        if (!baseOps.operations.has(key)) {
            added.push(headOp);
        }
    }
    return { matched, removed, added };
}
//# sourceMappingURL=match.js.map