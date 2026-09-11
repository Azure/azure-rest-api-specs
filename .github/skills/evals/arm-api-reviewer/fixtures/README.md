# ARM API Reviewer -- Test Fixtures

Self-contained test fixtures for evaluating ARM API review tools. Each fixture
is a valid OpenAPI 2.0 (Swagger) spec, TypeSpec (`.tsp`) file, example JSON,
or readme.md file that can be consumed by any tool that processes Azure REST API
specifications.

## Reuse

These fixtures are designed for reuse across multiple eval suites and tools:

- **Other review agents** -- data-plane API reviewers, TypeSpec reviewers, or
  custom linting agents can reference these fixtures to test shared rules
  (naming, descriptions, enums, secrets, examples).
- **CI validation tools** -- `openapi-diff`, `oav`, and custom lint rules can
  use these as known-good or known-bad inputs.
- **SDK generation testing** -- `clean-spec.json` is a complete, valid ARM spec
  suitable as a golden input for SDK code-gen smoke tests. Version-pair
  fixtures can test breaking-change detection tooling.

To reference a fixture from another eval suite, use a relative path in the
`environment.files` section of your eval YAML:

```yaml
environment:
  files:
    - src: "../../arm-api-reviewer/fixtures/arm-openapi/clean-spec.json"
      dest: "specification/example/resource-manager/Microsoft.Example/stable/2025-01-01/example.json"
```

## Design Principles

Fixtures are intentionally small, but not every file is self-contained. Some
OpenAPI fixtures reference repository common-types or companion examples.
Every eval that uses one of those fixtures must map all referenced dependencies
into its isolated workspace.

Most fixtures seed one related rule category. When a compact fixture omits
unrelated production boilerplate, its prompt must scope the review to the
target construct and its catalog entry must not claim the fixture is a
standalone validation input.

> **Note on credential scanners**: `example-realistic-secret.json` contains
> synthetic secrets (fake passwords, connection strings, and a Base64 string
> that decodes to a benign message). These are intentional test inputs for
> secret-detection evaluation. If CI credential scanners flag them, add the
> file to the scanner's allowlist.

## Fixture Catalog

### `arm-openapi/` -- ARM OpenAPI Specifications (21 files)

| File                              | Violations                    | Description                                                                                                                                                                                  |
| --------------------------------- | ----------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `clean-spec.json`                 | None (true negative)          | Fully compliant ARM spec with all CRUD operations, provisioningState, systemData, x-ms-enum, descriptions, x-ms-pageable, and x-ms-mutability. Use as a baseline for false-positive testing. |
| `clean-proxy-resource.json`       | None (true negative)          | Fully compliant proxy (extension) resource spec. Uses ProxyResource from common-types — no location, tags, or resource move. Tests false-positive resistance for tracked-resource rules.     |
| `collection-paging-parameters.json` | Prompt-scoped positive control | Collection GET with valid RPC-defined `$top` and `$skipToken`; the eval reviews only paging parameters and maps common-types separately. |
| `collection-custom-query-parameter.json` | Prompt-scoped custom parameter | Collection GET with a non-standard `region` query parameter; the eval scopes review to its Warning-level RPC-Uri-V1-09 behavior. |
| `cna-violations.json`             | CNA model issues              | Custom inline CheckNameAvailabilityRequest/Response instead of common-types `$ref`; name field has no pattern or maxLength constraint.                                                       |
| `delete-violations.json`          | DELETE response issues        | 404 on DELETE instead of 204; non-empty response body on 200 DELETE; missing 204 response code.                                                                                              |
| `denylist-pattern-new.json`       | Denylist pattern violations   | policyName path parameter, displayName, and description body properties use denylist `[^...]` patterns (OAPI-PATTERN-ALLOWLIST). All are new (no previous version) — Blocking severity. The category property uses a correct allowlist pattern as a positive control. |
| `enum-violations.json`            | Enum best-practice issues     | Missing x-ms-enum decorator; modelAsString false; non-PascalCase values; empty string enum value.                                                                                            |
| `ex-payload-enum-cases.json`      | Prompt-scoped EX-PAYLOAD cases | Shared schema for extensible, closed, discriminator, and request-path unknown enum examples; companion examples and common-types are mapped by the eval. |
| `inline-common-types.json`        | Inline common-types           | Defines ErrorResponse, ErrorDetail, SubscriptionIdParameter, ResourceGroupNameParameter, and ApiVersionParameter inline instead of using common-types $ref.                                  |
| `inline-systemdata.json`          | Prompt-scoped incomplete systemData | Resource defines an inline `systemData` shape missing canonical fields; the eval reviews only that shape and `systemData` placement. |
| `lro-violations.json`             | Long-running operation issues | Async PUT returning 202 instead of 200/201 with provisioningState; DELETE returning resource body.                                                                                           |
| `missing-crud-ops.json`           | Missing lifecycle operations  | PUT, GET, and PATCH exist but DELETE, ListByResourceGroup, ListBySubscription, and Operations API are missing.                                                                               |
| `missing-descriptions.json`       | Missing descriptions          | Operations, models, and properties lack description fields.                                                                                                                                  |
| `missing-provisioning-state.json` | Missing provisioningState     | LRO PUT resource with no provisioningState property.                                                                                                                                         |
| `naming-violations.json`          | Naming convention issues      | PascalCase (DisplayName), uppercase acronyms (IPAddress), underscores (HTTP_Endpoint, resource_group_id).                                                                                    |
| `patch-violations.json`           | PATCH body issues             | Required properties in PATCH body; default values; create-only mutability on PATCH fields.                                                                                                   |
| `put-response-mismatch.json`      | PUT response mismatch         | 200 and 201 responses use different schemas; request body differs from 201 response.                                                                                                         |
| `point-custom-query-parameter.json` | Prompt-scoped point GET parameter | Point GET with custom `expandDetails`; the eval scopes review to its Blocking RPC-Get-V1-08 behavior. |
| `secret-property.json`            | Secret property issues        | connectionString, adminPassword, and primaryKey without x-ms-secret annotation.                                                                                                              |
| `typespec-generated-spec.json`    | None (true negative)          | Compliant ARM spec carrying the `x-typespec-generated` extension at the top level. Used by the TSP-REQUIRED-V1 eval to verify TypeSpec-generated swagger is not flagged.                     |

### `examples/` -- Example JSON Files (13 files)

| File                            | Violations           | Description                                                                                          |
| ------------------------------- | -------------------- | ---------------------------------------------------------------------------------------------------- |
| `example-clean.json`            | None (true negative) | Properly formed example with fully qualified ARM resource ID, no secrets, correct provisioningState. |
| `example-clean-create-or-update.json`        | None (true negative)        | Complete PUT request and response for the clean golden specification.                                 |
| `example-clean-update.json`                  | None (true negative)        | Complete PATCH request and response for the clean golden specification.                               |
| `example-clean-delete.json`                  | None (true negative)        | DELETE example with an empty successful response.                                                     |
| `example-clean-list-by-resource-group.json`  | None (true negative)        | Empty collection response for resource-group list.                                                    |
| `example-clean-list-by-subscription.json`    | None (true negative)        | Empty collection response for subscription list.                                                      |
| `example-clean-operations-list.json`         | None (true negative)        | Empty Operations API collection response.                                                             |
| `example-bad-resource-id.json`  | Empty resource ID    | Response body has an empty string for the `id` field.                                                |
| `example-ex-payload-extensible-enum.json` | Extensible enum response | Undeclared ordinary response value; Warning because `modelAsString` is true. |
| `example-ex-payload-closed-enum.json` | Closed enum response | Undeclared ordinary response value; Blocking because `modelAsString` is false. |
| `example-ex-payload-discriminator.json` | Unknown discriminator | Undeclared required discriminator value; Blocking despite extensibility. |
| `example-ex-payload-path-param.json` | Unknown request path value | Undeclared enum value in a request path; Blocking despite extensibility. |
| `example-realistic-secret.json` | Realistic secrets    | Contains realistic connection string, password, and Base64-encoded key values.                       |

### `readme/` -- Suppression Configuration (2 files)

| File                                  | Violations                 | Description                                                                                    |
| ------------------------------------- | -------------------------- | ---------------------------------------------------------------------------------------------- |
| `readme-new-suppression-no-reason.md` | Missing justification      | Suppressions for AvoidAdditionalProperties and PatchBodyParametersSchema with no reason field. |
| `readme-security-suppression.md`      | Vague security suppression | Suppressions for XmsSecretNotReadBack and SecretPropertyMustBeWriteOnly with vague reasons.    |

### `version-pairs/` -- Version Comparison Pairs (6 pairs, 12 files)

Each subdirectory contains a `stable-2024-01-01.json` (previous) and
`stable-2025-01-01.json` (new) for breaking-change detection testing.

| Pair                       | Violations                | Description                                                                                           |
| -------------------------- | ------------------------- | ----------------------------------------------------------------------------------------------------- |
| `removed-property/`        | Removed properties        | `category` and `priority` properties removed between versions.                                        |
| `type-change/`             | Property type change      | `maxRetries` changed from string to integer between versions.                                         |
| `enum-narrowing/`          | Enum value removal        | `status` enum narrowed from 5 values to 3 (Suspended, Archived dropped).                              |
| `new-vs-existing/`         | Mixed classification      | `bar` has no description in both versions (EXISTING); `baz` is newly added without description (NEW). |
| `added-required-property/` | Optional becomes required | `sku` property changes from optional to required in WidgetProperties between versions.                |
| `denylist-pattern/`        | Denylist pattern severity | The `policyName` path parameter and `displayName` body property use denylist patterns in both versions (pre-existing — Warning). A new `description` body property adds a denylist pattern only in 2025-01-01 (new — Blocking). Tests severity differentiation for OAPI-PATTERN-ALLOWLIST. |

### `typespec/` -- TypeSpec Project Files (7 files)

| File                             | Violations                    | Description                                                                                                                                                                                                                                                                   |
| -------------------------------- | ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `segment-casing-violations.tsp`  | @segment casing, naming, enum | @segment uses all-lowercase instead of camelCase (TSP-SEGMENT-CASE); PATCH named "patch" not "update" (TSP-PATCH-NAME); @operationId override; enum instead of union; plain string for ARM resource ID.                                                                       |
| `secret-and-type-violations.tsp` | Secrets, type constraints     | Missing @secret on connectionString/adminPassword/primaryKey (SEC-SECRET-DETECT); #suppress for secret-prop; string instead of utcDateTime; string for numeric diskSizeGB (TSP-NUMERIC-TYPE); plain string for ARM resource ID (TSP-ARM-RESOURCE-ID).                         |
| `anti-patterns.tsp`              | Common TypeSpec anti-patterns | Empty model `{}` instead of void for POST action; #suppress for no-empty-model; @flattenProperty on new API; default value flowing into PATCH; `\| null` on new property; underscore and ALL_CAPS enum values.                                                                |
| `x-ms-identifiers-violations.tsp` | x-ms-identifiers / @extension | `@extension("x-ms-identifiers", ...)` on array properties (forbidden -- use `@identifiers` or `@key`); `#suppress` of `missing-x-ms-identifiers` with FIXME placeholder text (TSP-4.1); vague "matching another resource" suppression (TSP-ARRAY-IDENTIFIERS). Also contains positive controls: `@identifiers(#["..."])`, `@identifiers(#[])`, and `@key` on item type. |
| `denylist-pattern-violations.tsp` | Denylist @pattern violations  | Policy resource key `@pattern` and displayName body property `@pattern` use denylist `[^...]` syntax (OAPI-PATTERN-ALLOWLIST) — Blocking for new spec. Positive controls: category property with correct allowlist; slug property with negative lookahead alongside allowlist (both should NOT be flagged). |
| `unrelated-version-main.tsp`       | Emission-linkage mismatch | Declares only API version `2024-01-01`; paired with a new handwritten `2025-01-01` OpenAPI directory to test TSP-REQUIRED-V1. |
| `unrelated-version-tspconfig.yaml` | Emission-linkage mismatch | Emits only the `stable/2024-01-01` directory, proving the sibling TypeSpec project does not produce the new handwritten version. |
