import { $ } from "@typespec/compiler/typekit";
import { HttpCanonicalizer, } from "@typespec/http-canonicalization";
import { listHttpOperationsIn } from "@typespec/http";
import { getOperationIdentity, identityKey } from "./operation-identity.js";
/**
 * Canonicalize all HTTP operations in a versioned namespace.
 *
 * Creates an HttpCanonicalizer, resolves all HTTP operations from the namespace,
 * canonicalizes each one, and returns them keyed by wire identity.
 */
export function canonicalizeOperations(program, namespace) {
    const tk = $(program);
    const canonicalizer = new HttpCanonicalizer(tk);
    const [httpOps, _diagnostics] = listHttpOperationsIn(program, namespace);
    const operations = new Map();
    for (const httpOp of httpOps) {
        const identity = getOperationIdentity(httpOp);
        const key = identityKey(identity);
        const canonical = canonicalizer.canonicalize(httpOp.operation);
        operations.set(key, { identity, canonical, httpOperation: httpOp });
    }
    return { operations, canonicalizer };
}
//# sourceMappingURL=canonicalize.js.map