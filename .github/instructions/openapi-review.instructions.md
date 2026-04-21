---
applyTo: "specification/**/*.json"
---

<!-- Upstream alignment: 2026-04-15
     This date is for maintainers of this file only -- it records when
     rules were last verified against upstream docs. No action is needed
     by spec authors or PR reviewers. The upstream documents always take
     precedence if there is a conflict.

     Rules derived from:
       - Azure REST API Guidelines (vNext)
         https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md
       - Azure Resource Provider Contract (RPC) v1.0 (for ARM-related rules)
         https://github.com/cloud-and-ai-microsoft/resource-provider-contract/tree/master/v1.0
     If an upstream document changes a rule, update this file to match.
     When in doubt, the upstream document takes precedence over this file. -->

# Copilot Review Instructions for OpenAPI v2 (Swagger) Specification Files

When performing a code review on OpenAPI v2 (Swagger) JSON definition files in this repository, validate the specification against the [Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md). This repository hosts all OpenAPI swagger definitions for Azure services. Each service team provides a swagger specification that **must** comply with the rules below.

Flag every violation clearly with the file path, the JSON path or line number, the specific rule being violated, and a concrete suggestion for how to fix it. Respond in markdown format.

---

## 1. File & Directory Structure

- Verify the file is placed in the correct directory path following the pattern:
  - ARM: `specification/<organization>/resource-manager/Microsoft.<Namespace>/<ServiceName>/{stable|preview}/<api-version>/<SpecName>.json`
  - Data plane: `specification/<organization>/data-plane/<ServiceName>/{stable|preview}/<api-version>/<SpecName>.json`
- Stable API versions **MUST** be in a `/stable/` directory; preview versions in `/preview/`.
- Example JSON files **MUST** reside in an `examples/` subdirectory relative to the spec.
- The file **MUST** be valid JSON (no trailing commas, no comments, proper encoding).
- JSON example files **MUST** use spaces for indentation, not tabs.

## 2. API Versioning

**Reference: [Azure Guidelines — API Versioning](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#api-versioning)**

- The `info.version` field **MUST** follow the `YYYY-MM-DD` format (e.g. `"2025-04-01"`), with an optional `-preview` suffix for preview versions.
  (Also enforced by: `VersionConvention` linter rule)
- The `info.version` value **MUST** match the API version folder name the file resides in. For example, a file in `preview/2025-11-01-preview/` must have `"info": { "version": "2025-11-01-preview" }` — not a different version like `"2025-04-15"`. A mismatch indicates a copy-paste error from a prior version.
- The API version suffix for pre-GA releases **MUST** be `-preview`. Suffixes like `-alpha`, `-beta`, `-privatepreview` are **not** permitted in the public spec repository.
- Every operation **MUST** have an `api-version` query parameter (typically via `$ref` to common-types `ApiVersionParameter`).
- **DO NOT** include a version number segment in operation URL paths (e.g. `/v1/` or `/v2/` in the path is forbidden).
- The GA version date **MUST** be later than any preceding preview version date.
- Preview features **MUST NOT** remain in preview for more than 1 year.
- Verify no breaking changes are introduced within the same API version. Breaking changes include:
  - Removing or renaming properties, operations, or parameters
  - Changing property types (e.g. `boolean` → `string`)
  - Removing or changing a property's `format` (e.g. removing `"format": "uuid"` from a string property is a breaking change for SDKs that relied on the format for type generation)
  - Removing enum values
  - Making an optional property required
  - Changing the URL path format
  - Changing required/optional status of parameters
  - Renaming a model definition without adding `x-ms-client-name` to preserve the SDK-facing name

## 3. Security Definitions

**Reference: [Azure Guidelines — HTTP Headers](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#http-query-parameters-and-header-values)**

- ARM specs **MUST** define `securityDefinitions` using OAuth2 implicit flow with Azure AD:
  ```json
  "securityDefinitions": {
    "azure_auth": {
      "type": "oauth2",
      "flow": "implicit",
      "authorizationUrl": "https://login.microsoftonline.com/common/oauth2/authorize",
      "scopes": { "user_impersonation": "impersonate your user account" }
    }
  }
  ```
- The `security` property **MUST** be applied at the top level or on every operation:
  ```json
  "security": [{ "azure_auth": ["user_impersonation"] }]
  ```
- Data plane specs **MUST** also have appropriate security definitions (OAuth2, API key, or both as applicable).
- **DO NOT** expose unsecured endpoints unless explicitly documented and justified.

## 4. URL Path & Naming Conventions

**Reference: [Azure Guidelines — URLs](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#uniform-resource-locators-urls)**

- URL path segments **MUST** use kebab-casing (preferred) or camelCasing. If a segment refers to a JSON field, use camelCase.
- Restrict service-defined path segment characters to `0-9 A-Z a-z - . _ ~` with `:` allowed only for action operations.
- Resource provider namespace in paths **MUST** use PascalCase (e.g. `Microsoft.Compute`).
- Resource type names in paths **MUST** use camelCase (e.g. `virtualMachines`).
- Path parameters **SHOULD** use full resource name, not abbreviations (e.g. `{virtualMachineName}` not `{vmName}`).
- Path parameter names **MUST** be descriptive of the resource they identify (e.g., `{syncSetName}` not `{childResourceName}`, `{configurationName}` not `{name}`).
- Resource name path parameters **SHOULD** include a `pattern` constraint with:
  - A maximum length limit (e.g., `{1,128}` or `{1,64}`) to prevent excessively long names.
  - Prevention of leading special characters (e.g., `^(?![.-])`) — resource names should not start with `.` or `-`.
  - Allowed character set (e.g., `[A-Za-z0-9_.-]`) that matches the service's actual validation.
  - Example: `"pattern": "^(?![.-])[A-Za-z0-9_.-]{1,128}$"`
- For action operations on a resource, the URL pattern **SHOULD** be: `/<resource-collection>/<resource-id>:<action>`.
- For action operations on a collection: `/<resource-collection>:<action>`.
- **DO NOT** use action URLs for standard CRUD operations that map naturally to GET/PUT/PATCH/DELETE.

## 5. HTTP Methods & Status Codes

**Reference: [Azure Guidelines — HTTP Return Codes](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#http-return-codes)**

- Verify each operation uses the correct HTTP method and defines the correct success response codes:

  | Method | Purpose                                      | Success Status Code |
  | ------ | -------------------------------------------- | ------------------- |
  | GET    | Read resource / list collection              | `200`               |
  | PUT    | Create or replace resource                   | `200`, `201`        |
  | PATCH  | Create or update resource (JSON Merge Patch) | `200`, `201`        |
  | POST   | Create (service-assigned ID)                 | `201`               |
  | POST   | Action                                       | `200`               |
  | DELETE | Remove resource                              | `204` (avoid `404`) |

- Long-running operations **MUST** return `202-Accepted` and include `x-ms-long-running-operation: true`.
- **DO** return the resource body on PUT, PATCH, POST, and GET operations with `200` or `201`.
- The `ProvisioningState` async pattern (returning 200/201 with a `provisioningState` field that transitions from `Creating`/`Updating` to `Succeeded`/`Failed`) **MUST NOT** be combined with `202` responses. If the operation returns `202`, it **MUST** use `Location` or `Azure-AsyncOperation` header-based polling -- not `ProvisioningState`. Mixing `202` with `ProvisioningState` is an incorrect async pattern. See [`.github/skills/azure-api-review/references/provisioning-state.md`](../skills/azure-api-review/references/provisioning-state.md) for complete provisioningState rules.
- DELETE operations **MUST** return `204-No Content` with no response body. Do not return `404` for missing resources on DELETE.
- POST action operations **MUST** return `200` with a response body (even if empty, to allow future extension).
- POST actions that intentionally return no content **SHOULD** use `204 No Content` instead of `200` with an empty body. An empty `200` response is ambiguous — `204` explicitly signals no content.
- POST action responses that return the full parent resource body should be reviewed carefully — this can inadvertently expose resource state to callers who only have permission to invoke the action, not read the resource.
- All operations **MUST** include a `"default"` error response.

## 6. JSON Property & Schema Rules

**Reference: [Azure Guidelines — JSON](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#json)**

### Naming

> **See also:** [`.github/skills/azure-api-review/references/naming-conventions.md`](../skills/azure-api-review/references/naming-conventions.md) for comprehensive naming and Azure terminology rules.

- All JSON property names **MUST** use camelCase. Do not upper-case acronyms (use `resourceId`, not `ResourceID` or `resourceID`).
- Property names **MUST** be treated as case-sensitive.
- Avoid abbreviations in property names unless they are industry-standard.
- Property names with a plural noun (e.g., `deploymentErrors`) **MUST** be arrays. If the property is a scalar (string, object), use a singular name. Plural names on non-array types confuse SDK consumers and tooling.
  (Also enforced by: `BodyTopLevelProperties`, `PropertyNaming` linter rules)

### Types & Formats

- Integer properties **MUST** specify `format` as `int32` or `int64`.
- Object definitions **MUST** have `"type": "object"`.
- Object definitions **MUST NOT** be free-form (i.e., `"type": "object"` with no `properties` defined and no `$ref`). Every object must have a defined schema. If the service truly needs to accept arbitrary key-value data, use `additionalProperties` with explicit justification.
- Array properties **MUST** have an `items` schema defined.
- Date/time properties **MUST** use `"format": "date-time"` (RFC 3339).
- UUID properties **MUST** use `"format": "uuid"` (RFC 4122).
- ARM resource ID properties **SHOULD** use `"format": "arm-id"` to enable ARM-aware tooling and SDK generation.
- URI/URL properties **MUST** use `"format": "uri"` to enable SDK validation and proper typing.
- Duration properties **SHOULD** use fixed time intervals with the unit in the property name (e.g. `backupTimeInMinutes`, `ttlSeconds`). Use ISO 8601 durations only when variable calendar intervals are needed.
- A property that specifies `format` **MUST** also specify the corresponding `type` (e.g., `"format": "int64"` requires `"type": "integer"`; `"format": "uuid"` requires `"type": "string"`). A `format` without a `type` may be ignored by tooling.
- Boolean properties deserve scrutiny — consider if an extensible enum would be more future-proof.
- Integer properties **SHOULD** specify `minimum` and/or `maximum` constraints when the valid range is known (e.g., percentage fields: `"minimum": 0, "maximum": 100`; port numbers: `"minimum": 1, "maximum": 65535`). This enables client-side validation and improves documentation.
- Enum values **MUST** be semantically distinct. Do not define overlapping or synonymous values (e.g., `InProgress` and `Running` in the same enum). Each value must represent a clearly different state.

### Field Mutability

> **Full rule definitions:** See [`.github/skills/azure-api-review/references/property-mutability.md`](../skills/azure-api-review/references/property-mutability.md) for OAPI027, OAPI020, OAPI029 with format-specific examples.

- Read-only properties **MUST** be marked `"readOnly": true` (e.g. `id`, `name`, `type`, `systemData`, computed properties).
- If a property is `readOnly`, it **MUST** always be `readOnly`. Do not make the same property conditionally read-only (OAPI020).
- If a property is immutable (`x-ms-mutability: ["create", "read"]`), it **MUST** always be immutable (OAPI029).
- Use `x-ms-mutability` to specify `["create", "read"]`, `["read"]`, or `["create", "update", "read"]` behavior.
- Write-only properties (`x-ms-mutability: ["create", "update"]` without `"read"`) are **NOT allowed** (OAPI027). The only exception is secret properties annotated with `x-ms-secret: true`.
- Required read-only properties **MUST NOT** be required in request bodies. Check that `"required"` arrays don't include read-only fields for request schemas.

### Schema Consistency

- **MUST** use the same JSON schema for PUT request/response, PATCH response, GET response, and POST request/response on a given URL path.
- PATCH request schema **SHOULD** have all the same fields as the resource schema but with no required fields (to support partial update).
- **DO NOT** return secret/sensitive fields in GET responses (e.g. `administratorPassword`). Secrets **MAY** only be returned via POST if absolutely necessary.
- Proactively check every `"type": "string"` property for secret indicators -- see [`.github/skills/azure-api-review/references/secret-detection.md`](../skills/azure-api-review/references/secret-detection.md) for the full **SEC-SECRET-DETECT** rule, detection signals, keyword list, and fix guidance.
- **DO NOT** include fields whose values are trivially computable from other fields.
- Properties with `default` values **MUST** use a static constant — the same default on every similar PUT request. Do not derive defaults from other properties in the resource. The `default` annotation in the swagger must specify the actual constant value.
- Properties **MUST NOT** use comma-separated value (CSV) strings to represent collections. Use a JSON array instead. CSV-encoded strings prevent Azure Policy from evaluating individual values (PLCY004).
- Properties **SHOULD NOT** accept values of different JSON types (e.g., both `"42"` and `42`). If backward-compatibility forces this, the service must preserve the user's data type in responses. Prefer rejecting incorrect types with `400 Bad Request` (OAPI025).

### Null Values

- **DO NOT** define response properties that can be `null`. Services should omit fields with null values rather than sending `null`.
- Accept `null` values only in PATCH request bodies with JSON Merge Patch semantics (to delete a field).

## 7. Enumerations

**Reference: [Azure Guidelines -- Enums & SDKs](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#enums--sdks-client-libraries)**

> **Full rule definitions:** See [`.github/skills/azure-api-review/references/enum-best-practices.md`](../skills/azure-api-review/references/enum-best-practices.md) for comprehensive enum and boolean-to-enum guidance.

- Every enum **MUST** have the `x-ms-enum` extension with a `name` property and `"modelAsString": true` (extensible enum).
- Enum `name` values **MUST** be unique across the entire specification.
- Enum values **MUST NOT** be empty strings; **SHOULD** use PascalCase.
- Enum values **MUST** be semantically distinct (no overlapping synonyms like `InProgress` and `Running`).
- Enum values replacing booleans **MUST** carry semantic meaning beyond `True`/`False`.
- `default` values for enum properties **MUST** be one of the defined enum values.
- **DO NOT** remove existing enum values -- this is a breaking change.
- Document that customers should expect new enum values may appear in the future.

## 8. Polymorphic Types

**Reference: [Azure Guidelines — Polymorphic types](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#polymorphic-types)**

- Polymorphic types **MUST** use a `discriminator` field. The recommended discriminator name is `kind`.
- The discriminator field **SHOULD** be an extensible enum (`modelAsString: true`).
- The discriminator field **SHOULD NOT** be changeable via PATCH/update operations.
- **SHOULD NOT** return polymorphic properties not defined for the requested api-version.
- **SHOULD NOT** have array properties containing polymorphic objects on updatable resources (JSON Merge Patch cannot handle this version-resiliently).
- Use `x-ms-discriminator-value` to specify the discriminator value on child schemas.

## 9. Collections & Pagination

**Reference: [Azure Guidelines — Collections](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#collections)**

- List operations **MUST** return an object (not a bare array) with a top-level array property.
- The array property **SHOULD** be named `value`.
- List operations **MUST** use `x-ms-pageable` with the `nextLinkName` property specified:
  ```json
  "x-ms-pageable": { "nextLinkName": "nextLink" }
  ```
- The response model **MUST** include a `nextLink` property of type `string` for pagination (or set `"nextLinkName": null` only if pagination is guaranteed never needed).
- **DO NOT** return `nextLink` with a value of `null` — omit the field entirely on the last page.
- Each item in the collection **MUST** include its `id` and `etag` (if ETags are supported).
- Pageable operations **MUST** define a `200` response.
- **SHOULD** support paging from the start if the collection could grow large. Adding paging later is a breaking change.
- Query parameters for filtering/sorting (`filter`, `orderby`, `skip`, `top`, `maxpagesize`, `select`, `expand`) **MUST NOT** be prefixed with `$`.
- Query parameter names **MUST** be camelCase and treated as case-sensitive.

## 10. Long-Running Operations (LRO)

**Reference: [Azure Guidelines — Long-Running Operations](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#long-running-operations--jobs)**

- If an operation can take more than 1 second at the 99th percentile, it **MUST** be implemented as an LRO.
- Mark LRO operations with `"x-ms-long-running-operation": true`.
- For POST LROs with a response schema, specify `"x-ms-long-running-operation-options"` with `"final-state-via": "location"` (or `"azure-async-operation"` only if the status monitor itself contains the result). For PUT, PATCH, and DELETE following standard ARM patterns, do **NOT** specify `final-state-via` -- the default SDK behavior is already correct. See [`.github/skills/azure-api-review/references/lro-final-state-via.md`](../skills/azure-api-review/references/lro-final-state-via.md) for the full decision table.
- LRO operations **MUST** return `202-Accepted` (for POST/DELETE) or `201-Created` / `200-OK` (for PUT) with an `Operation-Location` or `Azure-AsyncOperation` header.
- Status monitor responses **MUST** include `id`, `status` (one of `NotStarted`, `Running`, `Succeeded`, `Failed`, `Canceled`), and `error` (on failure).
- LRO responses **SHOULD** include a `retry-after` header when the operation is not complete.

## 11. Error Handling

**Reference: [Azure Guidelines — Handling Errors](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#handling-errors)**

- Every operation **MUST** have a `"default"` response for errors.
- The default error response **MUST** reference the standard `ErrorResponse` schema (preferably from common-types):
  ```json
  "default": {
    "description": "Error response describing why the operation failed.",
    "schema": { "$ref": "...common-types/.../types.json#/definitions/ErrorResponse" }
  }
  ```
- The default error `description` **MUST** be generic (e.g., "Error response describing why the operation failed.") — not specific to one error type (e.g., "Bad request" is wrong because the default error covers all error codes, not just 400).
- The error schema **MUST** follow this structure:
  ```json
  {
    "error": {
      "code": "string (required)",
      "message": "string (required)",
      "target": "string (optional)",
      "details": [ ...ErrorDetail array (optional) ],
      "innererror": { "code": "string", "innererror": { ... } }
    }
  }
  ```
- Use `x-ms-error-response: true` on non-default error responses (e.g. specific 4xx responses with different schemas).
- **YOU SHOULD NOT** document specific error status codes in the spec unless the response schema differs from the default error.

## 12. Common-Types Usage (ARM Specs)

> **Reference:** [Azure Resource Provider Contract (RPC)](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/tree/master/v1.0) -- ARM common-types are defined by the RPC contract.

- ARM specs **MUST** reference the appropriate `common-types` version (v3, v4, v5, or v6) for standard definitions:
  - Resource types: `Resource`, `TrackedResource`, `ProxyResource`, `ExtensionResource`
  - Error types: `ErrorResponse`, `ErrorDetail`
  - Standard parameters: `SubscriptionIdParameter`, `ResourceGroupNameParameter`, `ApiVersionParameter`
  - System metadata: `systemData`
- Use `$ref` to common-types instead of redefining standard ARM structures inline.
- Verify the `$ref` path is valid and points to the correct common-types version file.
- Definition names **MUST** be unique across all swagger files included in the same package tag. Duplicate definitions (e.g., `ErrorResponse` defined in both `foo.json` and `bar.json`) cause SDK generation conflicts. Use `$ref` to a single shared definition or common-types instead.
- All ARM resources **MUST** include `systemData` as a read-only property.

## 13. ARM Resource Model Requirements

> **See also:** [`.github/skills/azure-api-review/references/tracked-resource-lifecycle.md`](../skills/azure-api-review/references/tracked-resource-lifecycle.md) for the complete tracked resource CRUD requirements and operations API rules.
> **See also:** [`.github/skills/azure-api-review/references/naming-conventions.md`](../skills/azure-api-review/references/naming-conventions.md) for naming and terminology rules.

- Resource model name **MUST** match the singular form of the resource type (e.g. `VirtualMachine` for `virtualMachines`).
- Model definitions **MUST** use PascalCase.
- Top-level tracked resources **MUST** define all of: GET, PUT, PATCH (update), DELETE, List by Resource Group, List by Subscription.
- Nested resources **MUST** define a List operation.
- ARM resources **MUST** have top-level body properties limited to: `id`, `name`, `type`, `location`, `tags`, `plan`, `sku`, `etag`, `managedBy`, `identity`, `systemData`, `properties`, and `zones`.
- The `properties` object should contain service-specific fields — do not put custom fields at the resource top level.
- Properties inside the `properties` bag **MUST NOT** reuse ARM top-level property names (`id`, `name`, `type`, `location`, `tags`). These generic names create ambiguity about whether they refer to the resource itself or a sub-component. Use qualified names instead (e.g., `agentId`, `deploymentType`, `ruleName`).
- For proxy resources, do **not** recreate ARM `tags` functionality inside `properties`. The `tags` name is reserved for ARM tags (V1 and future V2). If tag-like metadata is needed on a proxy resource, use a different name (e.g., `labels`, `resourceTags`).
- Properties named generically (e.g., `id`, `type`) inside a `properties` bag **SHOULD** have their `format` constrained (e.g., `format: uuid` for GUID-style IDs) and their description **MUST** clarify what kind of identifier it is, how it's created (client vs. server-generated), and its uniqueness scope.
- The resource provider namespace in the path **MUST** match the namespace declared in the spec.

## 14. Operation IDs

- Every operation **MUST** have a unique `operationId`.
  (Also enforced by: `OperationIdRequired` linter rule R4004)
- ARM operation IDs **MUST** follow the `{ResourceType}_{Action}` pattern (e.g. `VirtualMachines_Get`, `VirtualMachines_CreateOrUpdate`, `VirtualMachines_List`).
  (Also enforced by: `OperationIdNounVerb` linter rule R1001)
- The Operations API response `display` object **MUST** use camelCase property names: `provider`, `resource`, `operation`, `description` — not PascalCase (`Provider`, `Resource`, `Operation`, `Description`). This applies to both the swagger schema and example files.
- Use standard verb suffixes: GET → `Get` / `List`, PUT → `CreateOrUpdate`, PATCH → `Update`, DELETE → `Delete`, POST → `<ActionName>`.
  (Also enforced by: `GetInOperationName` R1005, `PutInOperationName` R1006, `PatchInOperationName` R1007, `DeleteInOperationName` R1009, `ListInOperationName` R1003, `PostOperationIdContainsUrlVerb` R2066)
- The noun part in `operationId` **SHOULD NOT** repeat inside the verb part.
- There **MUST** be exactly one underscore in the `operationId`.
  (Also enforced by: `OneUnderscoreInOperationId` linter rule R2055)
- The noun part of the `operationId` **MUST NOT** conflict with model definition names in the spec. This causes naming collisions in generated SDK code.
  (Also enforced by: `OperationIdNounConflictingModelNames` linter rule R2063)

## 15. Parameters

- Required parameters **MUST** be marked with `"required": true`.
- Use `"in": "path"`, `"in": "query"`, `"in": "body"`, or `"in": "header"` correctly.
- Path parameters **MUST** correspond to a `{parameterName}` placeholder in the operation path.
- Common parameters (subscriptionId, resourceGroupName, api-version) **SHOULD** use `$ref` to common-types.
- Parameters defined in the `parameters` section **MUST** have `x-ms-parameter-location` set to `"method"` or `"client"`.
- Body parameters **MUST NOT** be anonymous — they must reference a named definition.
- Body parameters **MUST NOT** use `"type": "array"` as the top-level schema. ARM does not allow array-typed request bodies. Wrap the array in an object model (e.g., `{ "value": [...] }`).
- DELETE operations **MUST NOT** have a request body.
- Validate all query parameters and request headers; fail with `400-Bad Request` if invalid.
- The `name` property **MUST** be defined for all parameters.

## 16. x-ms Extensions

- `x-ms-examples`: **MUST** be present on every operation, referencing example JSON files in the `examples/` directory. Example files **MUST** validate against the specification.
- `x-ms-pageable`: **MUST** be used on all list/collection operations.
- `x-ms-long-running-operation`: **MUST** be `true` on all async operations.
- `x-ms-enum`: **MUST** be present on all enum types with `name` and `modelAsString`.
- `x-ms-client-flatten`: **DO NOT** add `x-ms-client-flatten` to new specs. It is discouraged and creates SDK issues. Existing usages may remain for backward compatibility.
- `x-ms-mutability`: **SHOULD** be specified on properties with create-only or read-only semantics.
- `x-ms-client-name`: If used, the value **MUST NOT** be empty.
- `x-ms-paths`: If used, entries **MUST** overload (be equivalent to) existing paths with different query parameters.

## 17. Descriptions & Documentation Quality

- Every operation, parameter, property, model definition, and enum value **MUST** have a non-empty `description`.
- Property descriptions **MUST NOT** simply repeat the property name (e.g. `"name": { "description": "name" }` is not acceptable).
- Operation descriptions **SHOULD** start with a verb and end with a period (e.g. `"Gets the specified virtual machine."`).
- PUT operation descriptions **MUST NOT** imply non-idempotent behavior. Avoid language like "Creates a new..." or "This will create a new version" — instead use "Creates or updates..." or "Creates or replaces..." to reflect PUT's idempotent, upsert semantics.
- Start descriptions with a capital letter.
- Specify units for quantifiable properties (e.g. "The timeout in seconds.", "The size in megabytes.").
- Property names for temporal or measurement values **SHOULD** encode the unit when the type alone does not make it clear (e.g., `startTimeInUTC`, `durationInMs`, `throughputMiBPerSec`, `backupTimeInMinutes`). This is especially important when not using `format: date-time` or ISO 8601 duration.
- Avoid: "Gets or sets...", "Gets...", "Sets..." in property descriptions — describe what the property represents.
- Use correct acronym capitalization in descriptions: "URL" not "Url", "ID" not "Id", "VM" not "Vm".

## 18. Conditional Requests & Optimistic Concurrency

**Reference: [Azure Guidelines — Conditional Requests](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#conditional-requests)**

- Operations **SHOULD** support `If-Match`, `If-None-Match`, `If-Modified-Since`, and `If-Unmodified-Since` request headers.
- Operations **SHOULD** return `ETag` and `last-modified` response headers.
- If ETag is supported, include it in the response schema and document its behavior.
- GET operations with `If-None-Match` should return `304-Not Modified` when the ETag matches.
- PUT/PATCH/DELETE with `If-Match` should return `412-Precondition Failed` on mismatch.

## 19. Repeatability (POST Idempotency)

**Reference: [Azure Guidelines — Repeatability of requests](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#repeatability-of-requests)**

- POST operations that create resources or perform non-idempotent actions **SHOULD** support the `Repeatability-Request-ID` and `Repeatability-First-Sent` request headers.
- The `Repeatability-Result` response header should be documented if repeatability is supported.

## 20. Distributed Tracing & Telemetry Headers

**Reference: [Azure Guidelines — Distributed Tracing](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#distributed-tracing--telemetry)**

- Operations **MUST** support the `x-ms-request-id` response header (a unique opaque value per request).
- Operations **SHOULD** support `x-ms-client-request-id` as an optional request header.
- **DO NOT** reject requests with unrecognized headers — middleware and API gateways may add them.

## 21. Data Plane Specific Rules

For data plane (non-ARM) swagger files, additionally verify:

- An `api-version` query parameter is present and required on all operations.
- The `host` and `basePath` are correctly defined for the data plane endpoint pattern.
- Security definitions are appropriate for the service (may use API keys, bearer tokens, or other schemes instead of ARM OAuth2).
- Data-plane LROs **MUST** use `Operation-Location` header for polling, **not** `Azure-AsyncOperation` (which is ARM-specific). 
- Action operations follow the `:<action>` URL suffix pattern where applicable.
- The spec includes `"produces": ["application/json"]` and `"consumes": ["application/json"]` (or appropriate media types).

## 22. Example File Validation (EX-*)

Example files referenced by `x-ms-examples` are a critical part of the spec — they serve as documentation, SDK test cases, and validation inputs. Validate every example file in the PR against the following rules.

### 22.0 Example Validation Process (EX-PROCESS)

For each example file changed or added in a PR, perform the following validation steps in order:

1. **Trace the example to its operation.** Follow the `x-ms-examples` reference in the spec to identify the parent operation (path + HTTP method + operationId). Every example file **MUST** be referenced by exactly one `x-ms-examples` entry. An orphaned example file (not referenced by any operation) **MUST** be flagged.

2. **Validate parameters against the operation definition.**
   - Every `required` path, query, and body parameter defined on the operation **MUST** be present in the example's `parameters` section.
   - Each parameter value **MUST** match the declared `type`, `format`, and `enum` constraints. For example, if the operation defines `api-version` as a string enum with value `2025-07-01`, the example **MUST** use that exact value.
   - Path parameter values in the `parameters` section **MUST** match the corresponding segments in the example URL (e.g., `"resourceGroupName": "myRG"` must appear as `/resourceGroups/myRG/` in the URL).

3. **Validate the request body against the operation's request schema.**
   - If the operation defines a `body` parameter with a schema, the example request body **MUST** include all `required` properties defined in that schema.
   - Property names and types **MUST** match the schema. Extra properties not defined in the schema **SHOULD** be flagged as potential errors.
   - For PUT operations, the example **SHOULD** include `location` and `tags` if the resource is a tracked (top-level) ARM resource.

4. **Validate the response body against the operation's response schema.**
   - For each response status code in the example (e.g., `200`, `201`, `202`), verify that the status code is defined on the operation.
   - The response body **MUST** include all `required` properties from the response schema.
   - Property names, types, and nesting **MUST** match the schema. A list operation returning `OperationListResult` must include `"value": [...]`, not just `{}`.

5. **Cross-reference URL segments with request and response bodies.**
   - Subscription ID, resource group name, resource name, and other path segments in the URL **MUST** be consistent across the request parameters, request body, and response body (including the `id` field in the response).
   - For example, if the URL contains `/virtualMachines/myVM`, the response `id` must contain the same value, and the response `name` must be `"myVM"`.

6. **Check example coverage for the operation.**
   - PUT and PATCH operations **SHOULD** have at least two examples: one with the minimum required properties and one with the full/maximum property set.
   - Operations with multiple possible request shapes (e.g., polymorphic discriminators, mutually exclusive property groups) **SHOULD** have separate examples for each variant.
   - LRO operations **SHOULD** have examples showing both the initial response (e.g., `202`) and the final response (e.g., `200`).

7. **Apply the individual EX-* rules below** (22.1 through 22.10) to catch specific violations.

### 22.1 Example Title Accuracy (EX-TITLE)

- The `"title"` field in each example **MUST** accurately describe the operation it demonstrates.
- A GET-single-resource example **MUST NOT** have a "List" title; a list example **MUST NOT** have a "Get" title.
- The title **SHOULD** match the operationId verb: GET → "Get..." or "List...", PUT → "Create or Update...", DELETE → "Delete...", PATCH → "Update...", POST → the action name.

### 22.2 Resource Identity Consistency (EX-RESOURCE-ID)

- Every ARM resource in an example response **MUST** have a valid, fully-qualified `id` field:
  - The `id` **MUST** be an absolute path starting with `/` (e.g., `/subscriptions/...`). Do not use relative paths like `providers/Microsoft.EventGrid/...`.
  - Contains `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.{Namespace}/...`.
  - Uses `/resourceGroups/` (plural, PascalCase 'G') — not `/resourceGroup/` or `/resourcegroup/`.
  - The RP namespace casing **MUST** match the canonical casing (e.g., `Microsoft.DocumentDB` not `Microsoft.DocumentDb`).
  - The resource segments in the `id` **MUST NOT** be truncated (e.g., ending at `/providers/Microsoft.ExtendedLocation/` without the resource type and name).
  <!-- cSpell:ignore hvirtual Nameub -->
  - Values **MUST NOT** contain stray/garbled characters (e.g., trailing single quotes `bastionhosttenant'`, corrupted names like `hvirtualHubNameub1` instead of `virtualHubName`).
- The `name` field **MUST** match the last segment of the resource `id`.
- The `type` field **MUST** be the ARM resource type **without** the `providers/` prefix (e.g., `Microsoft.EventGrid/extensionTopics` — not `providers/Microsoft.EventGrid/extensionTopics`).
- The `type` field **MUST** match the full ARM resource type derived from the `id` (e.g., for nested resources `/.../monitors/{name}/tagRules/{ruleName}`, the `type` must be `Dynatrace.Observability/monitors/tagRules`, not `Dynatrace.Observability/monitors`).
- For nested resource operations, the response **MUST NOT** use the parent resource's `id`/`name`/`type`.

### 22.3 Request-Response Parameter Consistency (EX-PARAM-CONSISTENCY)

- Response `id` fields **MUST** be consistent with the request parameters. For example, if the request has `"resourceGroupName": "rg1"`, the response `id` must contain `/resourceGroups/rg1/` — not `/resourceGroups/Default/` or any other value.
- Request query parameters and response body properties for the same concept **MUST** be consistent (e.g., if request sets `observationMetric` to `cpu`, the response should not show `duration`).

### 22.4 Pagination Examples (EX-PAGINATION)

- Pageable response examples **MUST NOT** set `nextLink` to `null`. On the last page, omit `nextLink` entirely.
- If `nextLink` is present, it **MUST** be a valid URL string (not `null`, not an empty string).
- The `nextLink` URL **MUST** be a well-formed URL that includes the `api-version=` query parameter with the correct value (e.g., `?api-version=2025-11-15-preview&...` — not `?2025-11-15-preview&...` with the `api-version=` key omitted).
- The `nextLink` URL **MUST** point to the same operation endpoint as the operation being demonstrated (e.g., a TagRules list `nextLink` must not point to a monitors collection URL).

### 22.5 LRO Example Headers (EX-LRO-HEADERS)

- LRO response examples (typically `202`) **MUST** include the appropriate polling headers (`Azure-AsyncOperation`, `Location`, or both) matching the operation's LRO configuration. See [`.github/skills/azure-api-review/references/lro-final-state-via.md`](../skills/azure-api-review/references/lro-final-state-via.md) for when `final-state-via` should be specified.
- Do not leave `202` response examples as empty objects (`"202": {}`) — include the polling headers.
- Header names in examples **MUST** use correct PascalCase: `Azure-AsyncOperation` (not `azure-AsyncOperation`), `Location` (not `location`), `Retry-After` (not `retry-after`).
- The `api-version` in LRO polling URLs **MUST** match the example's own `api-version`. Do not carry over stale versions from previous API versions (e.g., `api-version=2022-09-01` in a `2026-01-07-preview` example is wrong). Ensure the `-preview` suffix is included if the API version is a preview (e.g., `api-version=2025-02-01-preview` not `api-version=2025-02-01`).
- LRO polling URLs and `nextLink` URLs **MUST** use `https://management.azure.com/...` — not the legacy `https://management.windowsazure.com/...` endpoint.
- LRO polling URLs in examples **MUST NOT** use placeholder domains (e.g., `https://contoso.com/operationstatus`). They must use realistic `https://management.azure.com/subscriptions/{subId}/providers/{namespace}/locations/{location}/operationStatuses/{operationId}?api-version={version}` URLs.
- For LRO POST operations that return a result body (e.g., export actions), examples **SHOULD** include both the `202` (Accepted with polling headers) and `200` (final response with result body) to show the complete LRO lifecycle. Omitting the `200` final response leaves consumers guessing about the result shape.

### 22.6 Timestamp & Format Consistency (EX-FORMAT)

- Date/time values in examples **MUST** use ISO-8601/RFC3339 format (e.g., `2025-02-06T08:00:00Z`) — not locale-specific formats like `02/06/2025 08:00:00`.
- UUID values in examples **MUST** follow the 8-4-4-4-12 hex-digit format (e.g., `11111111-1111-1111-1111-111111111111`).
- Values in examples **MUST** match the schema's declared `format` (if `format: date-time`, use RFC3339; if `format: uuid`, use valid GUID).

### 22.7 Example Payload Correctness (EX-PAYLOAD)

- Example response bodies **MUST** validate against the operation's response schema. A list operation returning `OperationListResult` must include at least `"value": []`, not just `{}`.
- The `id` field in examples **MUST NOT** be an empty string (`"id": ""`). Empty resource IDs crash ModelValidation tooling and are never valid ARM resource identifiers.
- String values **MUST NOT** have malformed content (e.g., extra closing braces `"{value}}"`, duplicate prefixes like `"$filter=$filter=..."`, stray trailing quotes or garbled characters).
- The example response key **MUST** be `"headers"` (plural) — not `"header"` (singular).
- `type` casing in examples must match the RP/type exactly: `Microsoft.Security/securityConnectors` not `Microsoft.Security/securityconnectors`.
- ARM properties that are objects (`tags`, `systemData`, etc.) **MUST NOT** be set to `null` in examples. Either omit the property or provide a valid object. Setting known ARM object properties to `null` fails schema validation.
- DELETE 200/204 response examples **SHOULD** have empty bodies (`"200": {}`, `"204": {}`). Do not include unexpected content like `message` fields in DELETE response bodies.

### 22.8 Example Secret & Credential Placeholders (EX-SECRET-PLACEHOLDER)

- Example files **MUST NOT** contain actual or realistic-looking secrets, tokens, SSH keys, passwords, connection strings, or API keys.
- Use clearly identifiable string placeholders instead:
  - SSH keys: `"{ssh-rsa public key}"` or `"ssh-rsa AAAA...{example}"`
  - Passwords: `"********"` or `"{password}"`
  - Connection strings: `"{connection-string}"`
  - API keys/tokens: `"00000000-0000-0000-0000-000000000000"` or `"{api-key}"`
- Base64-encoded blobs that look like real secrets **MUST** be replaced with clearly fake placeholder values or truncated with `...{example}`.
- **Rationale:** Examples are published in documentation and SDK test fixtures. Realistic-looking secrets cause security scanner false positives and may lead customers to believe they need similar-looking values.

### 22.9 Example File Size (EX-SIZE)

- Example files **SHOULD** be kept to a reasonable size. Extremely large examples (>500 lines) make review difficult and add repo bloat.
- For "maximum set" examples, include a representative subset of fields rather than thousands of lines of repetitive data.

### 22.10 Descriptive Example Values (EX-DESCRIPTIVE-VALUES)

- Example values **MUST** be realistic and descriptive. Examples are published in Microsoft's public Azure documentation and embedded in SDK samples -- they are often the first thing a customer reads when learning how to use an API.
- **Resource names** in URLs and request/response bodies **MUST** use recognizable, human-readable names (e.g., `"myVmScaleSet"`, `"testVault"`, `"myResourceGroup"`) -- not random strings or repeated characters.
- **Property values** (instance IDs, SKU names, locations, tags, etc.) **MUST** reflect realistic usage that helps the reader understand the parameter's purpose (e.g., `"0"`, `"1"` for VMSS instance IDs; `"Standard_DS1_v2"` for a VM size; `"eastus"` for a location; `{"env": "production"}` for tags).
- **Specifically forbidden patterns:**
  - Repeated single characters: `"aaaaaaa"`, `"xxxxxxx"`, `"zzzzzzz"`, `"bbbbbbb"`
  - Bare generic filler: `"string"` as a value for a property where a meaningful example exists (acceptable only when the property has no well-known values and the schema provides no further guidance)
  - Excessively long meaningless names: resource names of 20+ characters composed of a single repeated character (e.g., `"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa"`)
  - Numeric-looking garbage: `"12345"` or `"11111"` for a property that represents a real-world concept (e.g., a resource name, a display name)
- **Acceptable generic values:**
  - Subscription IDs, tenant IDs, principal IDs, and other GUIDs: stylized placeholders like `"00000000-0000-0000-0000-000000000000"` or `"subid"` per existing convention
  - Operation IDs in LRO polling URLs: `"00000000-0000-0000-0000-000000000000"` is acceptable
  - Properties with no well-known values where the schema description is the primary guidance: a short descriptive string like `"my-value"` is acceptable
- **Fix:** Replace filler values with short, meaningful names that help the reader understand what the parameter represents. For example:
  - `"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa"` → `"myVmScaleSet"`
  - `"aaaaaaaaaaaaaaaaa"` (instance ID) → `"0"`
  - `"string"` (location) → `"eastus"`

---

## 23. Unused & Orphaned Definitions (SCHEMA-UNUSED-DEF)

- Every model definition in the `definitions` section **MUST** be referenced by at least one `$ref` in the same file or by another file in the same package tag.
- Definitions that are defined but never referenced (orphaned) add spec bloat, confuse SDK generators, and may trigger "unused definition" validation warnings.
- Common causes: copy-paste from a template, a PATCH model that was refactored but the old definition was not removed, or a definition intended for a future version that was accidentally included.
- **Fix:** Remove the orphaned definition if it is genuinely unused. If it was intended as the PATCH body, wire the PATCH operation to reference it.

---

## 24. JSON Schema Correctness

### 24.1 `$ref` Must Not Have Sibling Keywords (SCHEMA-REF-SIBLINGS)

- In OpenAPI 2.0 / JSON Schema draft-04, keywords alongside `$ref` (e.g., `type`, `description`, `readOnly`) are **ignored** by compliant tooling.
- If a `$ref` is used alongside sibling properties, flag it — the sibling properties will not take effect and may cause incorrect SDK/docs generation.
- **Fix:** Use `allOf` to combine the reference with additional constraints:
  ```json
  "allOf": [
    { "$ref": "...#/definitions/MyType" }
  ],
  "description": "Additional description",
  "readOnly": true
  ```

### 24.2 Consistent common-types Version (SCHEMA-COMMON-TYPES-VERSION)

- A single swagger file **SHOULD** reference a single version of common-types (e.g., all `$ref` paths use `v5`).
- Mixing common-types versions within the same file (e.g., `v3` for parameters and `v5` for resource types) can lead to subtle schema incompatibilities.
- If different common-types versions are used, flag it and recommend aligning to the newest version used in the file.
- Common-types version `v2` is outdated — prefer `v5` or `v6` for new specs.

### 24.3 Proactive Format Detection (SCHEMA-FORMAT-DETECT)

- If a string property's description mentions ISO-8601, datetime, or timestamp concepts but the schema lacks `"format": "date-time"`, flag it.
- If a string property's name or examples suggest GUID/UUID values (e.g., `tenantId`, `objectId`, `clientId`) but the schema lacks `"format": "uuid"`, flag it.
- If a string property contains what appears to be an ARM resource ID (from name or description), recommend using a `$ref` to a common resource ID type or adding appropriate `format`/`pattern` annotations.

### 24.4 `nextLink` Should Be Read-Only (SCHEMA-NEXTLINK-READONLY)

- The `nextLink` property in list result schemas **SHOULD** be marked `"readOnly": true` to indicate it is server-generated and response-only.

### 24.5 Semantic Type Correctness (SCHEMA-SEMANTIC-TYPE)

- Properties whose names or descriptions clearly indicate numeric values (e.g., `numberOfCores`, `ram`, `vCpu`, `diskSizeGB`, `memoryInMB`, `maxRetries`) **SHOULD** use `integer` or `number` types, not `string`.
- When a numeric property is modeled as `string` for backward-compatibility reasons, the description **MUST** document the expected format and units (e.g., "RAM in megabytes, as a numeric string").
- Properties whose names or descriptions suggest a known finite set of values **SHOULD** use `enum` with `x-ms-enum`. Reviewers **SHOULD** ask whether strings like `category`, `diskType`, `meterType` have a finite value set that warrants enum modeling.

---

## Review Checklist Summary

When reviewing, systematically check:

- ✅ Valid JSON, correct directory placement, and proper file organization
- ✅ API version follows `YYYY-MM-DD` format (only `-preview` suffix allowed); no version in URL path
- ✅ No breaking changes vs. previous version of the same API
- ✅ Security definitions present and applied to all operations
- ✅ All property names in camelCase, model names in PascalCase
- ✅ `readOnly`, `required`, and `x-ms-mutability` correctly applied; no write-only properties (OAPI027); no conditional read-only or immutable properties (OAPI020, OAPI029)
- ✅ Common-types referenced (not redefined) for ARM standard types; no duplicate definitions across files in same tag
- ✅ All CRUD operations and List operations present for ARM resources
- ✅ `x-ms-pageable` on list operations with correct `nextLinkName`
- ✅ `x-ms-long-running-operation` on async operations with polling config; no ProvisioningState + 202 mixing
- ✅ `x-ms-enum` with `modelAsString: true` on all enums
- ✅ `x-ms-examples` on every operation with valid example files
- ✅ `operationId` follows `{Resource}_{Verb}` pattern with exactly one underscore
- ✅ Path parameter names are descriptive (`{syncSetName}` not `{childResourceName}`)
- ✅ Default error response references standard `ErrorResponse` schema
- ✅ Every operation, parameter, property, and model has a clear description
- ✅ Integer types have `format` specified; objects have `"type": "object"`; integers have `minimum`/`maximum` when range is known
- ✅ Enum values are semantically distinct (no overlapping synonyms)
- ✅ No anonymous body parameter types; no request body on DELETE; no array-typed request bodies; no free-form objects
- ✅ Consistent resource schema across PUT/GET/PATCH responses
- ✅ No `null` values in response schemas; no secrets in GET responses
- ✅ No CSV-encoded strings representing collections — use JSON arrays (PLCY004)
- ✅ Default values are static constants, not derived from other properties (OAPI022)
- ✅ Plural property names are arrays; scalar properties use singular names
- ✅ Properties with `format` also specify `type`; ARM resource IDs use `format: arm-id`; URLs use `format: uri`
- ✅ Every string property inspected for secret indicators (SEC-SECRET-DETECT): flag if property name, description, or examples suggest a secret but `x-ms-secret: true` is missing
- ✅ Example files validated: titles match operations, resource IDs are valid and consistent, no `null` nextLink, LRO headers correct, timestamps in RFC3339, no malformed values, values are realistic and descriptive -- not filler like `aaaa` or `string` (EX-*)
- ✅ No `$ref` with sibling keywords (SCHEMA-REF-SIBLINGS)
- ✅ Single common-types version per file; no outdated v2 in new specs (SCHEMA-COMMON-TYPES-VERSION)
- ✅ String properties with datetime/UUID descriptions have matching `format` (SCHEMA-FORMAT-DETECT)
- ✅ `nextLink` properties marked `readOnly: true` (SCHEMA-NEXTLINK-READONLY)
- ✅ Numeric properties use integer/number types, not string (SCHEMA-SEMANTIC-TYPE)
- ✅ No unused/orphaned definitions in `definitions` section (SCHEMA-UNUSED-DEF)
- ✅ Example files use string placeholders for secrets, SSH keys, and credentials — no realistic-looking sensitive values (EX-SECRET-PLACEHOLDER)
- ✅ Resource name path parameters include `pattern` constraints with length limits and character restrictions
- ✅ PUT operation descriptions use idempotent language ("Creates or updates..." not "Creates a new...")
- ✅ Operations API display object uses camelCase property names (`provider`, `resource`, `operation`, `description`)

Flag all violations clearly with JSON path references, the specific rule, and a concrete fix suggestion.
