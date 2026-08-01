/** Type guard: is this an operation-relative identity? */
export function isOperationIdentity(id) {
    return "operation" in id;
}
/** Type guard: is this a service-level identity? */
export function isServiceIdentity(id) {
    return !("operation" in id);
}
//# sourceMappingURL=types.js.map