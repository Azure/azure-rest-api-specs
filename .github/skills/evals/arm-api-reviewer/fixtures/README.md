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

Each fixture is **self-contained** -- it includes all definitions, parameters,
security blocks, and error responses inline. This makes fixtures portable and
avoids cross-file dependencies.

Fixtures intentionally contain a single category of seeded violations (or none
for true negatives). This isolation ensures each eval stimulus tests exactly one
rule category without interference from other issues.

> **Note on credential scanners**: `example-realistic-secret.json` contains
> synthetic secrets (fake passwords, connection strings, and a Base64 string
> that decodes to a benign message). These are intentional test inputs for
> secret-detection evaluation. If CI credential scanners flag them, add the
> file to the scanner's allowlist.

## Fixture Catalog

### `arm-openapi/` -- ARM OpenAPI Specifications (15 files)

| File                              | Violations                    | Description                                                                                                                                                                                  |
| --------------------------------- | ----------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `clean-spec.json`                 | None (true negative)          | Fully compliant ARM spec with all CRUD operations, provisioningState, systemData, x-ms-enum, descriptions, x-ms-pageable, and x-ms-mutability. Use as a baseline for false-positive testing. |
| `clean-proxy-resource.json`       | None (true negative)          | Fully compliant proxy (extension) resource spec. Uses ProxyResource from common-types — no location, tags, or resource move. Tests false-positive resistance for tracked-resource rules.     |
| `cna-violations.json`             | CNA model issues              | Custom inline CheckNameAvailabilityRequest/Response instead of common-types `$ref`; name field has no pattern or maxLength constraint.                                                       |
| `delete-violations.json`          | DELETE response issues        | 404 on DELETE instead of 204; non-empty response body on 200 DELETE; missing 204 response code.                                                                                              |
| `enum-violations.json`            | Enum best-practice issues     | Missing x-ms-enum decorator; modelAsString false; non-PascalCase values; empty string enum value.                                                                                            |
| `inline-common-types.json`        | Inline common-types           | Defines ErrorResponse, ErrorDetail, SubscriptionIdParameter, ResourceGroupNameParameter, and ApiVersionParameter inline instead of using common-types $ref.                                  |
| `lro-violations.json`             | Long-running operation issues | Async PUT returning 202 instead of 200/201 with provisioningState; DELETE returning resource body.                                                                                           |
| `missing-crud-ops.json`           | Missing lifecycle operations  | PUT, GET, and PATCH exist but DELETE, ListByResourceGroup, ListBySubscription, and Operations API are missing.                                                                               |
| `missing-descriptions.json`       | Missing descriptions          | Operations, models, and properties lack description fields.                                                                                                                                  |
| `missing-provisioning-state.json` | Missing provisioningState     | LRO PUT resource with no provisioningState property.                                                                                                                                         |
| `naming-violations.json`          | Naming convention issues      | PascalCase (DisplayName), uppercase acronyms (IPAddress), underscores (HTTP_Endpoint, resource_group_id).                                                                                    |
| `patch-violations.json`           | PATCH body issues             | Required properties in PATCH body; default values; create-only mutability on PATCH fields.                                                                                                   |
| `put-response-mismatch.json`      | PUT response mismatch         | 200 and 201 responses use different schemas; request body differs from 201 response.                                                                                                         |
| `secret-property.json`            | Secret property issues        | connectionString, adminPassword, and primaryKey without x-ms-secret annotation.                                                                                                              |
| `typespec-generated-spec.json`    | None (true negative)          | Compliant ARM spec carrying the `x-typespec-generated` extension at the top level. Used by the TSP-REQUIRED-V1 eval to verify TypeSpec-generated swagger is not flagged.                     |

### `examples/` -- Example JSON Files (3 files)

| File                            | Violations           | Description                                                                                          |
| ------------------------------- | -------------------- | ---------------------------------------------------------------------------------------------------- |
| `example-clean.json`            | None (true negative) | Properly formed example with fully qualified ARM resource ID, no secrets, correct provisioningState. |
| `example-bad-resource-id.json`  | Empty resource ID    | Response body has an empty string for the `id` field.                                                |
| `example-realistic-secret.json` | Realistic secrets    | Contains realistic connection string, password, and Base64-encoded key values.                       |

### `readme/` -- Suppression Configuration (2 files)

| File                                  | Violations                 | Description                                                                                    |
| ------------------------------------- | -------------------------- | ---------------------------------------------------------------------------------------------- |
| `readme-new-suppression-no-reason.md` | Missing justification      | Suppressions for AvoidAdditionalProperties and PatchBodyParametersSchema with no reason field. |
| `readme-security-suppression.md`      | Vague security suppression | Suppressions for XmsSecretNotReadBack and SecretPropertyMustBeWriteOnly with vague reasons.    |

### `version-pairs/` -- Version Comparison Pairs (5 pairs, 10 files)

Each subdirectory contains a `stable-2024-01-01.json` (previous) and
`stable-2025-01-01.json` (new) for breaking-change detection testing.

| Pair                       | Violations                | Description                                                                                           |
| -------------------------- | ------------------------- | ----------------------------------------------------------------------------------------------------- |
| `removed-property/`        | Removed properties        | `category` and `priority` properties removed between versions.                                        |
| `type-change/`             | Property type change      | `maxRetries` changed from string to integer between versions.                                         |
| `enum-narrowing/`          | Enum value removal        | `status` enum narrowed from 5 values to 3 (Suspended, Archived dropped).                              |
| `new-vs-existing/`         | Mixed classification      | `bar` has no description in both versions (EXISTING); `baz` is newly added without description (NEW). |
| `added-required-property/` | Optional becomes required | `sku` property changes from optional to required in WidgetProperties between versions.                |

### `typespec/` -- TypeSpec Specification Files (3 files)

| File                             | Violations                    | Description                                                                                                                                                                                                                                           |
| -------------------------------- | ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `segment-casing-violations.tsp`  | @segment casing, naming, enum | @segment uses all-lowercase instead of camelCase (TSP-SEGMENT-CASE); PATCH named "patch" not "update" (TSP-PATCH-NAME); @operationId override; enum instead of union; plain string for ARM resource ID.                                               |
| `secret-and-type-violations.tsp` | Secrets, type constraints     | Missing @secret on connectionString/adminPassword/primaryKey (SEC-SECRET-DETECT); #suppress for secret-prop; string instead of utcDateTime; string for numeric diskSizeGB (TSP-NUMERIC-TYPE); plain string for ARM resource ID (TSP-ARM-RESOURCE-ID). |
| `anti-patterns.tsp`              | Common TypeSpec anti-patterns | Empty model `{}` instead of void for POST action; #suppress for no-empty-model; @flattenProperty on new API; default value flowing into PATCH; `\| null` on new property; underscore and ALL_CAPS enum values.                                        |
