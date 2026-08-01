import { createTypeSpecLibrary, paramMessage } from "@typespec/compiler";
export const $lib = createTypeSpecLibrary({
    name: "@azure-tools/typespec-breaking-change",
    diagnostics: {
        "invalid-suppression-kind": {
            severity: "warning",
            messages: {
                default: "Invalid DiffKind specified in suppression decorator.",
            },
        },
        "breaking-change": {
            severity: "error",
            messages: {
                default: paramMessage `Breaking change detected: ${"message"}`,
            },
        },
    },
    state: {
        approvedBreakingChange: { description: "Approved breaking change suppressions" },
        approvedUnversionedChange: { description: "Approved unversioned change suppressions" },
    },
});
export const { reportDiagnostic, stateKeys: BreakingChangeStateKeys } = $lib;
//# sourceMappingURL=lib.js.map