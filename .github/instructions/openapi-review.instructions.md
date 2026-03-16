---
applyTo: "specification/**/*.json"
---

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

## 2. API Versioning

**Reference: [Azure Guidelines — API Versioning](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#api-versioning)**

- The `info.version` field **MUST** follow the `YYYY-MM-DD` format (e.g. `"2025-04-01"`), with an optional `-preview` suffix for preview versions.
- Every operation **MUST** have an `api-version` query parameter (typically via `$ref` to common-types `ApiVersionParameter`).
- **DO NOT** include a version number segment in operation URL paths (e.g. `/v1/` or `/v2/` in the path is forbidden).
- The GA version date **MUST** be later than any preceding preview version date.
- Preview features **MUST NOT** remain in preview for more than 1 year.
- Verify no breaking changes are introduced within the same API version. Breaking changes include:
  - Removing or renaming properties, operations, or parameters
  - Changing property types (e.g. `boolean` → `string`)
  - Removing enum values
  - Making an optional property required
  - Changing the URL path format
  - Changing required/optional status of parameters

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
- DELETE operations **MUST** return `204-No Content` with no response body. Do not return `404` for missing resources on DELETE.
- POST action operations **MUST** return `200` with a response body (even if empty, to allow future extension).
- All operations **MUST** include a `"default"` error response.

## 6. JSON Property & Schema Rules

**Reference: [Azure Guidelines — JSON](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#json)**

### Naming

- All JSON property names **MUST** use camelCase. Do not upper-case acronyms (use `resourceId`, not `ResourceID` or `resourceID`).
- Property names **MUST** be treated as case-sensitive.
- Avoid abbreviations in property names unless they are industry-standard.

### Types & Formats

- Integer properties **MUST** specify `format` as `int32` or `int64`.
- Object definitions **MUST** have `"type": "object"`.
- Array properties **MUST** have an `items` schema defined.
- Date/time properties **MUST** use `"format": "date-time"` (RFC 3339).
- UUID properties **MUST** use `"format": "uuid"` (RFC 4122).
- Duration properties **SHOULD** use fixed time intervals with the unit in the property name (e.g. `backupTimeInMinutes`, `ttlSeconds`). Use ISO 8601 durations only when variable calendar intervals are needed.
- Boolean properties deserve scrutiny — consider if an extensible enum would be more future-proof.

### Field Mutability

- Read-only properties **MUST** be marked `"readOnly": true` (e.g. `id`, `name`, `type`, `systemData`, computed properties).
- Use `x-ms-mutability` to specify `["create", "read"]`, `["read"]`, or `["create", "update", "read"]` behavior.
- Required read-only properties **MUST NOT** be required in request bodies. Check that `"required"` arrays don't include read-only fields for request schemas.

### Schema Consistency

- **MUST** use the same JSON schema for PUT request/response, PATCH response, GET response, and POST request/response on a given URL path.
- PATCH request schema **SHOULD** have all the same fields as the resource schema but with no required fields (to support partial update).
- **DO NOT** return secret/sensitive fields in GET responses (e.g. `administratorPassword`). Secrets **MAY** only be returned via POST if absolutely necessary.
- **DO NOT** include fields whose values are trivially computable from other fields.

### Null Values

- **DO NOT** define response properties that can be `null`. Services should omit fields with null values rather than sending `null`.
- Accept `null` values only in PATCH request bodies with JSON Merge Patch semantics (to delete a field).

## 7. Enumerations

**Reference: [Azure Guidelines — Enums & SDKs](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#enums--sdks-client-libraries)**

- Every enum **MUST** have the `x-ms-enum` extension with a `name` property:
  ```json
  "x-ms-enum": {
    "name": "MyEnumName",
    "modelAsString": true
  }
  ```
- **YOU SHOULD** set `"modelAsString": true` (extensible enum) unless the set of values will provably never change. This allows new values to be added without breaking clients.
- Enum `name` values **MUST** be unique across the entire specification.
- Enum values **MUST NOT** be empty strings.
- Enum values **SHOULD** use PascalCase.
- `default` values for enum properties **MUST** be one of the defined enum values.
- **DO NOT** remove existing enum values — this is a breaking change.
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
- Specify the polling strategy with `x-ms-long-running-operation-options` (e.g. `"final-state-via": "azure-async-operation"` or `"location"`).
- LRO operations **MUST** return `202-Accepted` (for POST/DELETE) or `201-Created` / `200-OK` (for PUT) with an `Operation-Location` or `Azure-AsyncOperation` header.
- **DO NOT** implement PATCH as an LRO. Use an LRO POST action pattern instead.
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

- ARM specs **MUST** reference the appropriate `common-types` version (v3, v4, v5, or v6) for standard definitions:
  - Resource types: `Resource`, `TrackedResource`, `ProxyResource`, `ExtensionResource`
  - Error types: `ErrorResponse`, `ErrorDetail`
  - Standard parameters: `SubscriptionIdParameter`, `ResourceGroupNameParameter`, `ApiVersionParameter`
  - System metadata: `systemData`
- Use `$ref` to common-types instead of redefining standard ARM structures inline.
- Verify the `$ref` path is valid and points to the correct common-types version file.
- All ARM resources **MUST** include `systemData` as a read-only property.

## 13. ARM Resource Model Requirements

- Resource model name **MUST** match the singular form of the resource type (e.g. `VirtualMachine` for `virtualMachines`).
- Model definitions **MUST** use PascalCase.
- Top-level tracked resources **MUST** define all of: GET, PUT, PATCH (update), DELETE, List by Resource Group, List by Subscription.
- Nested resources **MUST** define a List operation.
- ARM resources **MUST** have top-level body properties limited to: `id`, `name`, `type`, `location`, `tags`, `plan`, `sku`, `etag`, `managedBy`, `identity`, `systemData`, `properties`, and `zones`.
- The `properties` object should contain service-specific fields — do not put custom fields at the resource top level.
- The resource provider namespace in the path **MUST** match the namespace declared in the spec.

## 14. Operation IDs

- Every operation **MUST** have a unique `operationId`.
- ARM operation IDs **MUST** follow the `{ResourceType}_{Action}` pattern (e.g. `VirtualMachines_Get`, `VirtualMachines_CreateOrUpdate`, `VirtualMachines_List`).
- Use standard verb suffixes: GET → `Get` / `List`, PUT → `CreateOrUpdate`, PATCH → `Update`, DELETE → `Delete`, POST → `<ActionName>`.
- The noun part in `operationId` **SHOULD NOT** repeat inside the verb part.
- There **MUST** be exactly one underscore in the `operationId`.

## 15. Parameters

- Required parameters **MUST** be marked with `"required": true`.
- Use `"in": "path"`, `"in": "query"`, `"in": "body"`, or `"in": "header"` correctly.
- Path parameters **MUST** correspond to a `{parameterName}` placeholder in the operation path.
- Common parameters (subscriptionId, resourceGroupName, api-version) **SHOULD** use `$ref` to common-types.
- Parameters defined in the `parameters` section **MUST** have `x-ms-parameter-location` set to `"method"` or `"client"`.
- Body parameters **MUST NOT** be anonymous — they must reference a named definition.
- DELETE operations **MUST NOT** have a request body.
- Validate all query parameters and request headers; fail with `400-Bad Request` if invalid.
- The `name` property **MUST** be defined for all parameters.

## 16. x-ms Extensions

- `x-ms-examples`: **MUST** be present on every operation, referencing example JSON files in the `examples/` directory. Example files **MUST** validate against the specification.
- `x-ms-pageable`: **MUST** be used on all list/collection operations.
- `x-ms-long-running-operation`: **MUST** be `true` on all async operations.
- `x-ms-enum`: **MUST** be present on all enum types with `name` and `modelAsString`.
- `x-ms-mutability`: **SHOULD** be specified on properties with create-only or read-only semantics.
- `x-ms-client-name`: If used, the value **MUST NOT** be empty.
- `x-ms-paths`: If used, entries **MUST** overload (be equivalent to) existing paths with different query parameters.

## 17. Descriptions & Documentation Quality

- Every operation, parameter, property, model definition, and enum value **MUST** have a non-empty `description`.
- Property descriptions **MUST NOT** simply repeat the property name (e.g. `"name": { "description": "name" }` is not acceptable).
- Operation descriptions **SHOULD** start with a verb and end with a period (e.g. `"Gets the specified virtual machine."`).
- Start descriptions with a capital letter.
- Specify units for quantifiable properties (e.g. "The timeout in seconds.", "The size in megabytes.").
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
- Action operations follow the `:<action>` URL suffix pattern where applicable.
- The spec includes `"produces": ["application/json"]` and `"consumes": ["application/json"]` (or appropriate media types).

## Review Checklist Summary

When reviewing, systematically check:

- ✅ Valid JSON, correct directory placement, and proper file organization
- ✅ API version follows `YYYY-MM-DD` format, no version in URL path
- ✅ No breaking changes vs. previous version of the same API
- ✅ Security definitions present and applied to all operations
- ✅ All property names in camelCase, model names in PascalCase
- ✅ `readOnly`, `required`, and `x-ms-mutability` correctly applied
- ✅ Common-types referenced (not redefined) for ARM standard types
- ✅ All CRUD operations and List operations present for ARM resources
- ✅ `x-ms-pageable` on list operations with correct `nextLinkName`
- ✅ `x-ms-long-running-operation` on async operations with polling config
- ✅ `x-ms-enum` with `modelAsString: true` on all enums
- ✅ `x-ms-examples` on every operation with valid example files
- ✅ `operationId` follows `{Resource}_{Verb}` pattern with exactly one underscore
- ✅ Default error response references standard `ErrorResponse` schema
- ✅ Every operation, parameter, property, and model has a clear description
- ✅ Integer types have `format` specified; objects have `"type": "object"`
- ✅ No anonymous body parameter types; no request body on DELETE
- ✅ Consistent resource schema across PUT/GET/PATCH responses
- ✅ No `null` values in response schemas; no secrets in GET responses

Flag all violations clearly with JSON path references, the specific rule, and a concrete fix suggestion.
