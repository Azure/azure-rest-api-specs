import { listHttpOperationsIn } from "@typespec/http";
/**
 * Normalize a path by replacing parameter names with {}.
 * "/subscriptions/{subscriptionId}/providers/{rpName}" → "/subscriptions/{}/providers/{}"
 */
export function normalizePath(path) {
    return path.replace(/\{[^}]+\}/g, "{}");
}
/**
 * Create an OperationIdentity from an HttpOperation.
 */
export function getOperationIdentity(httpOp) {
    return {
        method: httpOp.verb.toUpperCase(),
        path: normalizePath(httpOp.path),
        name: httpOp.operation.name,
    };
}
/**
 * Create a string key for map lookup from an OperationIdentity.
 */
export function identityKey(identity) {
    return `${identity.method} ${identity.path}`;
}
/**
 * Resolve all HTTP operations in a versioned namespace and build an identity-keyed map.
 *
 * @param program - The compiled program
 * @param namespace - The versioned namespace to scan for operations
 * @returns Map of resolved operations keyed by identity string
 */
export function resolveOperationIdentities(program, namespace) {
    const [httpOps, _diagnostics] = listHttpOperationsIn(program, namespace);
    const operations = new Map();
    for (const httpOp of httpOps) {
        const identity = getOperationIdentity(httpOp);
        const key = identityKey(identity);
        operations.set(key, {
            identity,
            httpOperation: httpOp,
            operation: httpOp.operation,
        });
    }
    return { operations };
}
//# sourceMappingURL=operation-identity.js.map