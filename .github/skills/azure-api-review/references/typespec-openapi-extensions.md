<!-- Upstream alignment: 2026-09-10
     Sources:
       - Azure Core no-openapi-client-extensions rule
         https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-openapi-client-extensions/
       - Azure Core no-openapi rule
         https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-openapi/
       - TypeSpec OpenAPI decorator reference
         https://typespec.io/docs/libraries/openapi/reference/decorators/
       - TypeSpec Azure ARM long-running operation guidance
         https://azure.github.io/typespec-azure/docs/howtos/arm/long-running-operations/
-->

# TypeSpec and Raw OpenAPI Extensions

This reference governs review findings and suggested fixes when a TypeSpec
project adds, removes, or replaces raw OpenAPI decorators. It also governs
reviews of generated OpenAPI diffs when the owning source is TypeSpec.

## TSP-NO-RAW-CLIENT-EXTENSIONS

Azure TypeSpec must express API, ARM, and SDK behavior in the semantic TypeSpec
model. A raw `@OpenAPI.extension(...)` or `@extension(...)` that emits
client-altering `x-ms-*` metadata only into OpenAPI is not an acceptable way to
model that behavior. Other emitters do not see the extension, and its value is
not type-checked or kept in sync with the source model.

The upstream `@azure-tools/typespec-azure-core/no-openapi-client-extensions`
rule explicitly says **do not suppress**. Reviewers therefore MUST NOT suggest
adding or restoring a raw client-altering extension, and MUST NOT suggest a
`#suppress` for that rule, including as a way to preserve generated Swagger for
an already-published API version.

Use the TypeSpec-native construct instead. High-frequency mappings include:

| OpenAPI metadata                                                        | TypeSpec source of truth                                                                                                                                                                                                                                                                                                       |
| ----------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `x-ms-parameter-grouping`                                               | Group parameters in a model and spread the model into the operation.                                                                                                                                                                                                                                                           |
| `x-ms-client-name`                                                      | `@clientName` from `@azure-tools/typespec-client-generator-core`.                                                                                                                                                                                                                                                              |
| `x-ms-client-flatten`                                                   | `@flattenProperty` when compatibility requires it; do not add flattening to a new API.                                                                                                                                                                                                                                         |
| `x-ms-pageable`                                                         | `@list` or an Azure.Core/Azure.ResourceManager paging operation template.                                                                                                                                                                                                                                                      |
| `x-ms-long-running-operation` and `x-ms-long-running-operation-options` | For ARM, use an async Azure.ResourceManager template and customize `LroHeaders` with the matching `FinalResult`; see [ARM LRO guidance](lro-final-state-via.md). For Azure.Core or custom status monitors, use the native polling and final-operation constructs; see [data-plane LRO guidance](data-plane-lro-and-paging.md). |
| `x-ms-secret`                                                           | `@secret`.                                                                                                                                                                                                                                                                                                                     |
| `x-ms-azure-resource`                                                   | Azure.ResourceManager resource templates.                                                                                                                                                                                                                                                                                      |
| `x-ms-arm-id-details`                                                   | `armResourceIdentifier`.                                                                                                                                                                                                                                                                                                       |
| `x-ms-identifiers`                                                      | `@key` on the item identity property or `@identifiers` on the array property.                                                                                                                                                                                                                                                  |

When an extension is genuinely emitter-only, does not alter client, service,
wire, or ARM behavior, and has no TypeSpec-native representation, a raw custom
extension may be considered only with a concrete explanation of why no native
construct applies. Do not generalize that narrow case to the client-altering
extensions covered by `no-openapi-client-extensions`. If applicability is
unclear, ask the TypeSpec library owners or open an upstream issue; do not
recommend a suppression speculatively.

## Reviewing Generated OpenAPI Diffs

Do not treat every generated `x-ms-*` metadata diff as a published REST API
schema change. First identify the TypeSpec source and classify the metadata:

1. **Legacy emitter-only client metadata.** Removing a raw decorator whose only
   generated effect is obsolete client metadata is not, by itself, an ARM
   published-version immutability violation. Examples include removing
   `x-ms-parameter-grouping` while preserving the same wire parameters and
   removing `x-ms-client-request-id: true` while preserving the
   `x-ms-client-request-id` header. Do not file a finding that asks the author
   to restore the decorator or its suppression. Verify that paths, HTTP
   methods, wire names, locations, requiredness, types, request/response bodies,
   status codes, and ARM semantics are unchanged. SDK compatibility concerns,
   if demonstrated by an SDK breaking-change check, must be addressed through
   semantic TypeSpec modeling or client customization rather than raw OpenAPI
   metadata.
2. **Semantics-bearing metadata.** Metadata for paging, LROs, secrets, ARM
   resources, discriminators, and similar behavior must still be emitted from
   the corresponding native TypeSpec construct. If generated OpenAPI loses
   required semantics because the TypeSpec model is wrong, file the finding
   against the semantic defect and recommend the native construct. Never
   recommend `@OpenAPI.extension` as the fix.
3. **Native replacement changes generated metadata.** A mechanical metadata
   difference caused by replacing a raw decorator with its native construct is
   not automatically a REST breaking change. Compare the semantic TypeSpec
   model and wire contract. For example, review a change to
   `x-ms-pageable.nextLinkName` by checking the operation's `@list`/paging
   template and response continuation property, not by asking the author to
   hard-code the old `x-ms-pageable` object.

The published-version rule still applies when the cleanup changes the actual
REST or ARM contract. This reference prevents a format-specific compatibility
rule from forcing source patterns that current TypeSpec guidance prohibits; it
does not waive genuine wire or platform behavior changes.

## Reviewer Checklist

- Determine whether TypeSpec owns the generated OpenAPI file.
- Inspect the TypeSpec source change before classifying an `x-ms-*` diff.
- Separate wire/ARM semantics from emitter-only client metadata.
- For semantics-bearing metadata, verify the native TypeSpec construct and its
  generated output.
- Never propose a raw client-altering extension or suppress
  `no-openapi-client-extensions`.
- Require concrete downstream evidence before raising an SDK compatibility
  concern about legacy metadata cleanup.
