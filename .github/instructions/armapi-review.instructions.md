---
applyTo: "specification/**/resource-manager/**/*.json"
---

# ARM-Specific OpenAPI (Swagger) Review Instructions

This file contains **ARM control plane–specific** review rules that supplement the generic OpenAPI review instructions in `openapi-review.instructions.md`. All generic rules (versioning, naming, JSON conventions, enums, error handling, pagination, descriptions, x-ms extensions, etc.) are enforced by that file and are **not repeated here**. When reviewing ARM resource-manager swagger files, apply **both** instruction sets. If the Azure RPC contract conflicts with the generic guidelines, the ARM RPC rules below take precedence.

**Authoritative source for ARM control-plane rules:** [Azure Resource Provider Contract (RPC)](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/tree/master/v1.0). The RPC defines the contract between ARM and resource providers for PUT, PATCH, DELETE, GET, POST, and async operations. All rules in this file are derived from or aligned with the RPC. When in doubt, consult the RPC contract directly.

Flag every violation clearly with the file path, JSON path or line number, the specific rule ID, and a concrete suggestion for how to fix it. Respond in markdown format.

---

## 1. ARM Resource Path Structure

**Reference: [RPC — Resource API Reference](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/resource-api-reference.md)**

### 1.1 Tracked Resource Paths (RPC-Put-V1-01, RPC-Get-V1-11)

- All API paths for **tracked resources** (resources with `location` as a required property) **MUST** be scoped under a subscription and resource group:
  ```text
  /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.{Namespace}/{resourceType}/{resourceName}
  ```
- If a tracked resource path is missing the `subscriptions` or `resourceGroups` segments, flag it as an error and instruct the author to add them.
- Tracked resources **MUST NOT** be nested beyond the third level of nesting (RPC-Put-V1-19). ARM only guarantees consistent routing, RBAC, and behavior for tracked resources up to three levels deep.
- All API paths for PUT operations **MUST** have an even number of segments (alternating resource type and resource name) (RPC-Put-V1-02).

### 1.2 Proxy Resource Paths

- Proxy resources (no `location` property) **MAY** be scoped at subscription level, management group level, or as nested children — but verify the scope is intentional.
- Extension resources use the pattern: `/{scope}/providers/Microsoft.{Namespace}/{resourceType}/{resourceName}` where `{scope}` is a target resource ID.
- **Proxy resources MUST use `ProxyResource` as their base type, NOT `Resource`.** If a proxy or extension resource extends `Resource` instead of `ProxyResource`, flag it as an error.
- **Proxy resources MUST NOT have `tags`.** Tags are a property of tracked resources only. If tags appear on a proxy resource, flag it and instruct the author to remove them.

### 1.3 Resource Provider Namespace Consistency (RPC-Put-V1-06)

- The `Microsoft.{Namespace}` in every path **MUST** match the resource provider namespace declared in the specification.
- Flag any mismatch between path namespace and the `title` or `host` metadata.
- The RP namespace **SHOULD NOT** repeat the resource type name (e.g., `Microsoft.CloudPartnerProgramMembership` with resource type `membership` is redundant — prefer `Microsoft.CloudPartnerProgram` with resource type `memberships`).

### 1.4 Operations API (RPC-Operations-V1)

- Every resource provider **MUST** expose an operations API at:
  ```text
  /providers/Microsoft.{Namespace}/operations
  ```
- This GET operation **MUST** return an `OperationListResult` with `x-ms-pageable` and a `nextLinkName`.
- The operations list **MUST** use the common-types `OperationListResult` and `Operation` definitions. Do not define custom Operation types.
- If the operations endpoint is missing from the spec, flag it as an ARM Error.

### 1.5 ARM URL Pattern Compliance

- Every resource URL **MUST** follow the `type/{instance}/type/{instance}` pattern required by ARM and RBAC.
- Paths that skip the instance segment (e.g. `.../type/type/{instance}`) are invalid and will break RBAC role assignment scoping.

### 1.6 Resource Type Naming

- Resource type names in URL paths **MUST** be:
  - **camelCase** (e.g. `openShiftClusters`, not `OpenShiftClusters` or `openshiftclusters`).
  - **Plural** (e.g. `virtualMachines`, not `virtualMachine`) and must match the corresponding collection GET API path segment.
  - **Specific** — avoid generic names like `resourceName` or `childResourceName`. Use a meaningful, domain-specific name.
- Flag any resource type name that is PascalCase, singular-only (when a collection GET exists), or overly generic.

---

## 2. ARM Resource Model Rules

**Reference: [RPC — Resource API Reference](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/resource-api-reference.md)**

### 2.1 PUT Response Must Be an ARM Resource (RPC-Put-V1-12)

- The `200` and `201` response models for a PUT operation **MUST** have `x-ms-azure-resource: true` set somewhere in their schema hierarchy (typically inherited from the common-types `Resource` base).
- If missing, flag it and instruct the author to ensure the response model extends a common-types resource base.

### 2.2 Tracked Resource Requirements

- A **tracked resource** (has `location` as required property) **MUST** implement all of:
  - **GET** — return the resource; must only return `200` and must not be an LRO (RPC-Get-V1-01, RPC-Get-V1-14)
  - **PUT** — create or replace the resource (RPC-Put-V1-22)
  - **PATCH** — update the resource; at minimum must support updating `tags` (RPC-Patch-V1-03)
  - **DELETE** — remove the resource (RPC-Delete-V1-03)
  - **List by Resource Group** — collection GET under resource group (RPC-Get-V1-05)
  - **List by Subscription** — collection GET under subscription (RPC-Get-V1-05)
- If any of these operations are missing for a tracked resource, flag it as an ARM Error.
- Point GET operations **MUST NOT** have query parameters other than `api-version` (RPC-Get-V1-08).
- Collection GET responses **MUST** only have `value` and `nextLink` as top-level properties (RPC-Get-V1-09).
- The model in the `value` array of a collection GET **MUST** be the same model as the point GET response (RPC-Get-V1-10).
- Collection GET operations **MUST** specify `x-ms-pageable` (RPC-Get-V1-13).
- The `nextLink` property **MUST** use `"format": "uri"` in its schema definition.
- The `value` array **MUST** contain the resource objects directly — do not wrap resources in additional envelopes.

### 2.3 Nested Resources

- Nested resources **MUST** have a List operation under their parent.
- Nested resources **MUST NOT** be embedded inline in the parent resource's GET response body (see Azure Resource Graph guideline ARG001 below). Return a resource ID reference instead.
- For singleton nested resources (only one instance exists), the resource name **SHOULD** be `default`. The collection GET (`/parent/{parentName}/children`) and singleton GET (`/parent/{parentName}/children/default`) must both exist.

### 2.4 Resource References Between Resources

- When a resource needs to reference another resource, use a **single property containing the fully qualified ARM resource ID** of the referenced resource.
- This enables [linked access checks](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview) and is required for RBAC integration.
- Do not use separate properties for subscription, resource group, and resource name when a single resource ID suffices.

### 2.5 Top-Level ARM Properties Must Not Be Reused Inside the Properties Bag

- The ARM envelope properties `id`, `name`, `type`, and `systemData` are defined at the **top level** of a resource model and **MUST NOT** be redeclared inside the `properties` bag.
- If any of these names appear as properties inside the `properties` object, flag it as an ARM Error and instruct the author to rename the inner property to something domain-specific.
- **Example violation**: A resource whose `properties` object contains a field called `name` or `type`. These shadow the top-level ARM properties and cause confusion for clients and tooling.

### 2.6 Certain Properties Must Be Top-Level, Not Inside the Properties Bag

- The following properties **MUST** be defined at the top level of a resource model (alongside `id`, `name`, `type`, etc.), **not** inside the `properties` bag:
  - `zones` (Availability Zones)
  - `sku`
  - `kind`
  - `plan`
  - `identity`
  - `tags` (for tracked resources)
- If any of these appear inside `properties`, flag it as an ARM Error and instruct the author to move them to the top level.
- Conversely, properties that are **not** in this top-level set (e.g. `classification`, domain-specific configuration) **MUST** be inside the `properties` bag and not at the resource root.

### 2.7 Every Resource Must Have a Point GET

- Every resource type **MUST** have a corresponding point GET operation that retrieves a single instance by its resource path.
- If a List operation exists but no corresponding GET for a single instance, flag it as an ARM Error.
- **Singleton resources MUST be named "default"** (lowercase). Names like "Experimentation", "config", or any other non-"default" value for a singleton are not allowed unless explicitly approved.

### 2.8 Common Type Definitions Must Be Used

- **Do not define custom types for `Operation`, `OperationListResult`, `ErrorResponse`, `CloudError`, or `ErrorDetail`**. These **MUST** be referenced from the ARM common types (`common-types/resource-management/vX/types.json`).
- Private endpoint connection types (`PrivateEndpointConnection`, `PrivateLinkResource`, etc.) **MUST** also come from common types unless the service has a documented exception. If defining them locally, they must be in a dedicated file (e.g. `privateEndpointConnections.json`) and must exactly match the common-types schema.
- Flag any custom re-definition of these types as an ARM Error.

---

## 3. PUT Operation Rules

**Reference: [RPC — PUT Resource](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/put-resource.md)**

### 3.1 PUT for Resource Creation

- Resources that are created by end users **MUST** expose a PUT operation (RPC-Put-V1-22).
- **Exception**: POST may be used to create **proxy resources only** when the business scenario requires the service to generate the resource name. Tracked resources **MUST** always use PUT.
- PUT **MUST** be idempotent — sending the same PUT request multiple times must produce the same result (RPC-Put-V1-20).
- A re-PUT (PUT to an existing resource with the same body) **MUST NOT** fail. ARM expects PUT to be idempotent and usable for both create and update.
- PUT **MUST** return `201` for new resource creation and `200` for replacement of an existing resource (RPC-Put-V1-11). These status codes apply to both synchronous and asynchronous PUT operations.
- PUT **MUST NOT** return `202` for async operations. The required async model for PUT is `201`/`200` with a `provisioningState` property. The `202` model for PUT is deprecated and no longer supported for new resource types.
- PUT **MUST NOT** implicitly create other tracked resources — only the resource identified in the URL may be created (RPC-Put-V1-16). Implicit creation of other tracked resources means those resources won't be hydrated in ARM.
- PUT **SHOULD NOT** implicitly create nested or other proxy resources (RPC-Put-V1-17).
- The API path for PUT **MUST** have an even number of segments (alternating type/name) (RPC-Put-V1-02).
- The PUT request and response body **MUST** use the same model (RPC-Put-V1-25). The response of PUT **MUST** match the response of GET and PATCH for the same resource (RPC-Put-V1-12).

### 3.2 PUT Must Not Expose Secrets in Response

- The response of a PUT operation **MUST NOT** return secret values (e.g. passwords, keys, connection strings).
- If a secret is accepted on write (e.g. `administratorPassword`), the response **MUST** return `null` or omit the property entirely.
- Properties containing secrets **MUST** be annotated with `"x-ms-secret": true`.

---

## 4. PATCH Operation Rules

**Reference: [RPC — PATCH Resource](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/patch-resource.md)**

### 4.1 PATCH Body Must Not Have Required Properties (RPC-Patch-V1-10)

- PATCH request body parameters **MUST NOT** have any properties marked as `required`.
- PATCH request body properties **MUST NOT** have `default` values.
- PATCH request body properties **MUST NOT** have `x-ms-mutability` set to only `["create"]`.
- A PATCH operation updates only the fields the customer provides — forced defaults or required fields break this contract.
- PATCH **MUST NOT** update `id`, `name`, `type`, `location`, or `properties.provisioningState` — these are readOnly or immutable (RPC-Patch-V1-02).
- PATCH **MUST** follow JSON Merge Patch semantics ([RFC 7396](https://tools.ietf.org/html/rfc7396)) for fields inside the `properties` envelope (RPC-Patch-V1-05).
- **Recommendation**: Define a separate "Update" or "PatchBody" model containing only the patchable properties, rather than reusing the full resource model.

### 4.2 PATCH Response Codes (RPC-Patch-V1-06)

- Synchronous PATCH **MUST** return `200` (OK).
- Asynchronous PATCH **MUST** return `202` (Accepted). Additionally, `200` **MUST** also be specified in the swagger for async PATCH operations so SDKs can discover the final response schema.
- If the resource or resource group does not exist, PATCH **MUST** return `404` (NotFound) (RPC-Patch-V1-07).

### 4.3 Tracked Resource PATCH Must Support Tags (RPC-Patch-V1-03)

- For tracked resources, the PATCH operation **MUST** support updating `tags` at minimum.
- Ideally, all mutable properties should be patchable for a better customer experience.

### 4.4 PATCH Must Not Expose Secrets in Response

- Same rule as PUT — the PATCH response **MUST NOT** return secret values.

### 4.5 PATCH Must Have a Request Body (RPC-Patch-V1-12)

- Every PATCH request **MUST** have a request body containing at least one property.

### 4.6 PATCH Does NOT Need to Be Long-Running (CRITICAL)

- **PATCH operations are NOT required to be long-running.** Do NOT flag a PATCH operation as an error or warning solely because it is synchronous (i.e., it does not use `x-ms-long-running-operation: true`).
- A PATCH MAY be long-running if the service genuinely requires it (in which case it MUST return `200` for completion and `202 Accepted` for async acceptance), but this is NOT a requirement.
- **Never recommend or mandate that a PATCH be made long-running as a blanket rule.** Only flag if the PATCH returns `202` without the required `x-ms-long-running-operation` annotation.

### 4.7 No Query Parameters on PATCH Operations

- PATCH operations **MUST NOT** have query parameters other than `api-version`.
- If additional filtering is needed, use OData `$filter` — do not add individual query parameters.

---

## 5. DELETE Operation Rules

**Reference: [RPC — DELETE Resource](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/delete-resource.md)**

### 5.1 DELETE Response Codes (RPC-Delete-V1-01)

- Synchronous DELETE operations **MUST** define responses for:
  - `200` — successful deletion
  - `204` — resource does not exist / already deleted (no body)
  - `default` — error response
- Asynchronous DELETE operations **MUST** define responses for:
  - `202` — accepted for async processing
  - `204` — resource does not exist / already deleted (no body)
  - `default` — error response
- Do **not** return `404` for a resource that doesn't exist — return `204` instead.
- DELETE response body **MUST** be empty (RPC-Delete-V1-04).
- All tracked resources **MUST** support DELETE (RPC-Delete-V1-03). All proxy resources **SHOULD** support DELETE (RPC-Delete-V1-05).

### 5.2 DELETE Must Not Have a Request Body

- DELETE operations **MUST NOT** accept a request body parameter.

### 5.3 No Query Parameters on DELETE Operations

- DELETE operations **MUST NOT** have query parameters other than `api-version`.

---

## 6. Long-Running Operations (ARM-Specific)

**Reference: [RPC — Asynchronous Operations](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/async-api-reference.md)**

### 6.1 Async PUT Model (RPC-Async-V1-01)

- Async PUT **MUST** return `201` (create) or `200` (replace) with a `provisioningState` property set to a non-terminal value. PUT **MUST NOT** return `202` — the `202` model for PUT is deprecated and no longer supported for new resource types.
- The PUT response body **MUST** contain the resource with properties reflecting the in-progress operation (i.e., the state the resource will be in once the async operation completes).
- Starting January 2025, new RP namespace implementations **MUST** include the `Azure-AsyncOperation` header in the `201`/`200` response pointing to an operation status resource. Brownfield implementations are **strongly recommended** to add this header.
- If the resource is already in a **non-terminal `provisioningState`** (i.e., a previous async operation is still in progress), the service **MUST** return `409 Conflict`. A new PUT cannot be accepted while a prior operation is still running.
- Subsequent GET operations on the resource during provisioning **MUST** return `200` (OK) with a non-terminal `provisioningState` until the operation completes.
- After the operation completes, `provisioningState` **MUST** transition to a terminal state (`Succeeded`, `Failed`, or `Canceled`).

### 6.2 Async PATCH Model (RPC-Async-V1-08)

- Async PATCH **MUST** return `202` (Accepted) with both a `Location` header and an `Azure-AsyncOperation` header. The `200` status code **MUST** also be defined in the swagger so SDKs can discover the final response schema (RPC-Patch-V1-06).
- If the resource has a `provisioningState` property, it **MUST** transition to a non-terminal state (e.g., `"Updating"`) while the operation is in progress.
- The `Location` URL **MUST** return `202` (with no body) while the operation is in progress. When the operation completes, it **MUST** return the exact same response that would have been returned had the PATCH been synchronous (i.e., `200` with the updated resource body).

### 6.3 Async DELETE Model (RPC-Async-V1-09)

- Async DELETE **MUST** return `202` (Accepted) with both a `Location` header and an `Azure-AsyncOperation` header.
- If the resource has a `provisioningState` property, it **MUST** transition to a non-terminal state (e.g., `"Deleting"`).
- The `Location` URL **MUST** return `202` (with no body) while the operation is in progress. When the operation completes, it **MUST** return `200` (OK) or `204` (NoContent) and the resource **MUST** no longer exist.

### 6.4 Async POST Action Model (RPC-Async-V1-11)

- Async POST **MUST** return `202` (Accepted) with both a `Location` header and an `Azure-AsyncOperation` header.
- The `Location` URL **MUST** return `202` (with no body) while the operation is in progress. When the operation completes, it **MUST** return `200` (OK) with a response body, or `204` (NoContent) if no body is needed (e.g., restarting a VM).
- POST actions do **NOT** affect the resource's `provisioningState` property. Only PUT, PATCH, and DELETE operations update `provisioningState`.

### 6.5 `provisioningState` Requirements (RPC-Async-V1-02, RPC-Async-V1-03, RPC-Async-V1-16)

- A resource that supports at least one asynchronous verb (PUT or PATCH) **MUST** contain a `provisioningState` property in its model.
- `provisioningState` **MUST** include the terminal states: `Succeeded`, `Failed`, and `Canceled` (with a single 'l' — NOT "Cancelled"). If no `provisioningState` is returned, ARM assumes `Succeeded`.
- `provisioningState` **MUST** be marked `readOnly` in the swagger.
- `provisioningState` represents the status of the **latest long-running PUT, PATCH, or DELETE** operation — it does **NOT** represent the overall health or functional state of the resource. POST actions do **not** affect `provisioningState`.
- RP-defined non-terminal states are allowed (e.g., `"Creating"`, `"Updating"`, `"Deleting"`, `"PreparingVMDisk"`, `"MountingDrives"`, `"Accepted"`). Any state other than the three terminal states is considered non-terminal.
- `provisioningState` transitions are constrained: it can only move from **non-terminal → non-terminal** or **non-terminal → terminal**. It **MUST NOT** transition directly from one terminal state to another without an intervening non-terminal state (which would be set by a new operation).
- If a user includes `provisioningState` in a PUT request body (e.g., after a GET), the RP **MUST** treat it as a readOnly property. If the provided value matches the current value on the service, ignore it. If it does not match, the RP **MUST** reject the request with `400 Bad Request`.

### 6.6 `202` Response and Polling Headers (RPC-Async-V1-07, RPC-Async-V1-06, RPC-Async-V1-14)

- A `202` response **MUST NOT** include a response body.
- A `202` response **MUST** include a `Location` header with an absolute URI pointing to a monitoring URL. The URI host **MUST** match the host in the `referer` header.
- Starting January 2025, new RP namespaces **MUST** also include the `Azure-AsyncOperation` header (RPC-Async-V1-06). Brownfield implementations are **strongly recommended** to add it.
- The `Location` and `Azure-AsyncOperation` URIs **MUST** have an even number of segments with alternating resource type and resource name pattern.
- The `Location` and `Azure-AsyncOperation` URIs **MUST NOT** be exposed via any other header, API, or command — ARM only signs these two headers.
- Include `Retry-After` header (integer, seconds) when supported. Minimum 10 seconds, maximum 10 minutes. Default client polling interval is 60 seconds if `Retry-After` is not provided.
- A `202` response with no declared headers in the swagger (empty `"202": { "description": "Accepted" }`) makes the LRO contract ambiguous for ARM and SDKs — flag it.
- All asynchronous operations **MUST** have `x-ms-long-running-operation` set to `true` in the swagger (RPC-Async-V1-15).

### 6.7 Polling Behavior

- **`Location` header polling**: The polling URL returns `202` (with no body) while the operation is in progress and returns the **exact same response** as the synchronous completion when the operation finishes. For DELETE, the final response is `200` or `204`. For PATCH, the final response is `200` with the updated resource body. For POST, the final response is `200` or `204`.
- **`Azure-AsyncOperation` header polling**: The polling URL always returns `200` with a status object in the response body containing `status`, `error` (if failed/canceled), and optional `id`, `name`, `startTime`, `endTime`, `percentComplete`, `properties`. A `4xx`/`5xx` on the polling URL indicates a failure reading the *status*, not a failure of the underlying operation.
- The `Azure-AsyncOperation` status object **MUST** include `status` (Required) with terminal values `Succeeded`, `Failed`, or `Canceled`. If `status` is `Failed` or `Canceled`, `error.code` and `error.message` are **Required**.

### 6.8 Operation Results Placement

- For **new service onboardings**, operation statuses **MUST** be at subscription scope (e.g., `/subscriptions/{subscriptionId}/providers/{namespace}/locations/{location}/operationStatuses/{operationId}`). Subscription-level operation statuses provide better security through RBAC.
- If `operationResults`/`operationStatuses` are exposed under resource scope, long-running DELETE operations will cause them to become inaccessible after the parent resource is deleted, returning `404 Not Found`.
- The RP **MUST** ensure the operation result API is called in the same tenant and subscription that the operation originated in. The operation ID **MUST NOT** be the same as the correlation ID or request ID.
- Operation status `properties` **MUST NOT** contain sensitive information — operation status resources may be accessible through polling endpoints with different RBAC restrictions than the original operation.

### 6.9 Long-Running Operations Exceeding One Day

- For operations that may take longer than one day, RPs **SHOULD** expose a proxy resource for retrieving the latest operation status via a GET (e.g., `GET .../scenarioTests/{name}/testExecutionResults/latest`). This allows clients to retrieve status even if the original `Location` or `Azure-AsyncOperation` URI is lost (e.g., portal tab closed).

---

## 7. Secret Handling & Sensitive Data

### 7.1 No Secrets in GET/PUT/PATCH Responses

- Secrets (passwords, keys, connection strings, tokens) **MUST NOT** be exposed in the response of GET, PUT, or PATCH operations.
- For properties that accept a secret on write:
  - Return `null` or omit the property in the GET/PUT/PATCH response.
  - If the secret needs to be retrievable, expose it via a **POST action** (e.g. `listKeys`) for granular RBAC control.
  - POST actions named `list*` (e.g. `listKeys`, `listConnectionStrings`) are automatically exposed to ARM deployment templates via the `list()` template function.

### 7.2 x-ms-secret Annotation

- Any property that contains a secret in **any** operation (PUT, PATCH, GET, or POST) **MUST** be annotated with `"x-ms-secret": true` in the swagger definition.

### 7.3 Proactive Secret Detection (SEC-SECRET-DETECT)

- Reviewers **MUST** proactively inspect every `"type": "string"` property to determine whether it could contain a secret, credential, or sensitive token — even when `"x-ms-secret": true` is not present.
- Infer secret usage from **any** of the following signals:
  1. **Property name** contains or matches (case-insensitive): `key`, `token`, `secret`, `password`, `credential`, `connectionString`, `accessKey`, `sharedKey`, `masterKey`, `apiKey`, `sas`, `signature`, `cert`, `certificate`, `privateKey`, `passphrase`, `accountKey`, `ingestionKey`, `instrumentationKey`, `encryptionKey`, `symmetricKey`, `primaryKey`, `secondaryKey`, `clientSecret`.
  2. **Description** mentions concepts such as: authentication, authorization, signing, bearer, opaque credential, API token, SaaS token, ingestion key, shared access signature, or connection string.
  3. **Example values** in `x-ms-examples` or inline `example`/`default` contain patterns resembling tokens, base64-encoded blobs, or long random strings.
  4. **Suppress directives** referencing `secret-prop` or similar secret-related lint rules that are being silenced rather than addressed.
- If **any** of these signals are present and the property lacks `"x-ms-secret": true`, flag it as a **blocking security issue**:
  - **Rule ID:** `SEC-SECRET-DETECT`
  - **Severity:** Blocking
  - **Fix (OpenAPI JSON):** Add `"x-ms-secret": true` to the property definition.
  - **Fix (TypeSpec):** Add the `@secret` decorator to the property and remove any `#suppress` directive for `secret-prop`.
- When flagging, explain which signal(s) triggered the detection (name match, description content, example pattern, or suppression).

---

## 8. Property Design Best Practices

> **These rules apply specifically to properties defined inside the `properties` bag of a resource model.** Always examine all properties critically for better design opportunities.

### 8.1 Prefer Enums Over Booleans

- **YOU SHOULD** use extensible string enums instead of boolean types.
- Booleans do not version well — what starts as a two-state switch often needs additional states in the future, leading to breaking changes.
- When converting a boolean concept to an enum, use meaningful state names (e.g. `"NetworkOperationStatus": ["InProgress", "Succeeded", "Failed"]`) not just `"True"` / `"False"`.

### 8.2 Use Objects Instead of Strings for Structured Values

- If a property value has a well-defined or structured format (e.g. a JSON blob encoded as a string, a connection string with multiple components), model it as an object, not a free-form string.
- Free-form strings prevent client-side validation and make SDK generation less useful.
- **No freeform `type: object` either** — if a property is typed as `type: object` with no additional schema properties defined (an "empty object" or "any"), flag it. Every object property **MUST** have its schema defined with explicit properties.

### 8.3 Use Enums for Finite Value Sets (ACTIVELY REVIEW)

- **Actively examine every `string` property** in the `properties` bag. If the property name or description suggests it takes values from a limited or well-known set (e.g. "status", "mode", "tier", "kind", "protocol", "algorithm", "action", "state", "type", "category", "level"), **flag it** and recommend modeling it as an extensible enum with `x-ms-enum`.
- If a string property's description lists its valid values (e.g. "Possible values are: Enabled, Disabled"), it **MUST** be declared as an enum, not a plain string.
- Use `"x-ms-enum": { "name": "<EnumName>", "modelAsString": true }` to keep the enum extensible and avoid breaking changes when new values are added.

### 8.4 Use Specific Types Instead of Generic Strings (ACTIVELY REVIEW)

- **Actively examine every `string` property** for opportunities to use a more precise type:
  - Properties that represent a date, time, or timestamp **MUST** use `"type": "string", "format": "date-time"` (ISO 8601). Do not use a plain unformatted string for timestamps.
  - Properties that represent a duration **MUST** use `"type": "string", "format": "duration"` (ISO 8601 duration).
  - Properties that represent a URL or URI **MUST** use `"type": "string", "format": "uri"`.
  - Properties that represent a UUID/GUID **MUST** use `"type": "string", "format": "uuid"`.
  - Properties that represent a Base64-encoded value **MUST** use `"type": "string", "format": "byte"`.
  - Properties that represent a binary value **MUST** use `"type": "string", "format": "binary"`.
  - Properties that represent a password or secret **MUST** use `"type": "string", "format": "password"` and `"x-ms-secret": true`.
- If a plain `"type": "string"` property clearly represents one of the above, flag it and suggest the correct format.

### 8.5 `additionalProperties` Restriction

- `additionalProperties` (open-ended key-value maps) **MUST NOT** be used for service-owned properties whose structure is known at design time.
- `additionalProperties` is only acceptable for **user-defined pass-through data** (e.g., tags, custom metadata) that the service does not validate or interpret.
- If the set of keys is known or bounded, model them as explicit named properties instead.
- If the data is a collection, model it as an array of typed objects rather than a map.

### 8.6 Visibility and Mutability

- Properties that can be set on creation but **not** subsequently updated **MUST** be annotated with `x-ms-mutability: ["create", "read"]` (or `@visibility("create", "read")` in TypeSpec).
- Properties that are only returned in responses **MUST** be annotated with `"readOnly": true` or `x-ms-mutability: ["read"]`.
- Properties that are fully mutable (create + update + read) do **not** need an `x-ms-mutability` annotation.

### 8.7 Avoid Writable Circular Dependencies

- If resource A references resource B, and resource B's GET response includes a back-reference to resource A, mark **one** of the references as `readOnly`.
- Writable circular references prevent ARM from determining dependency ordering in deployment templates.

### 8.8 Deprecated Properties

- Properties that are deprecated **SHOULD** use the OpenAPI `"deprecated": true` keyword in addition to documenting "Deprecated" in the description.
- Using only a description mention of deprecation may be missed by tooling; the `deprecated` keyword enables SDK generators and linters to produce proper deprecation warnings.

### 8.9 `provisioningState` Correctness

- `provisioningState` **MUST** include at minimum the terminal states: `Succeeded`, `Failed`, and `Canceled` (with a single 'l' — NOT "Cancelled").
- Non-terminal operational states like `Stopped` or `Running` **MUST NOT** be included in `provisioningState`. These represent the runtime state of the resource, not the state of a provisioning operation. Use a separate property (e.g. `status` or `powerState`) for operational state.
- If `provisioningState` is missing required terminal states or includes invalid values, flag it.

### 8.10 `x-ms-nullable`

- If a property can legitimately return `null` in a response, it **MUST** be annotated with `"x-ms-nullable": true`.
- Do not rely on the absence of `"required"` to imply nullability — be explicit.

---

## 9. Inline Properties vs. Nested Resources (Design Choice)

### 9.1 When to Use Inline Properties

- The property set is an intrinsic part of the resource's state.
- The properties must be operated on together with other properties of the resource.
- The property set is small and not expected to grow significantly.

### 9.2 When to Use Nested Resources Instead

- The property set is complex enough to warrant its own lifecycle (separate CRUD operations).
- The properties have RBAC or routing requirements separate from the parent resource.
- The collection could grow large (arrays with unbounded or very large element counts **MUST** be modeled as nested resources, not inline arrays).
- Each element needs its own ARM resource ID.

### 9.3 Never Model Both

- A collection **MUST NOT** be modeled as **both** an inline array property **and** a nested resource type. This causes:
  - Customer confusion from duplicate representations
  - Inconsistencies if both representations are not kept in sync
  - Complications with Azure Resource Graph integration

### 9.4 Private Endpoint Connection Antipatterns

- Do not document **internal** private link contracts (e.g. private endpoint connections between internal services) as **external** ARM APIs.
- Private endpoint connection definitions **MUST** either come from ARM common types or be defined in a dedicated file (e.g. `privateEndpointConnections.json`). Do not define them inline in the main resource file.

---

## 10. Azure Resource Graph (ARG) Compatibility

### 10.1 No Embedded Child Resources in Parent GET (ARG001)

- **DO NOT** return child/nested resources inline in the parent resource's GET response.
- **DO NOT** include child resource count properties (e.g. `addressCount`) on the parent.
- Instead, return only a resource ID reference to the child, and require separate GET calls for child resources.
- **Rationale**: If a child resource changes, the parent resource notification may not fire, causing Azure Resource Graph to show stale data. It also creates information-leak risks if the user has access to the parent but not the child.

### 10.2 No Customer Data in Control Plane Properties (ARG002)

- **DO NOT** model customer data (user code, user content, PII) in the control plane resource properties.
- Control plane components (including ARG) cache resource properties and may store them in non-GDPR-compliant ways.
- If customer data must be associated with a resource, expose it via a **data plane API** or use a special query parameter (e.g. `$expandCustomerData=true`) that is not included in the default GET response.

### 10.3 Do Not Remove Properties Between API Versions (ARG003)

- **DO NOT** remove properties from a resource between API versions until the property's usage has been fully deprecated.
- Properties may be referenced in Azure Resource Graph queries and Azure Policy definitions. Removing them breaks customer queries.
- Instead, keep the property in the response and mark it as deprecated in the swagger description and documentation.
- All types and properties from previous API versions **MUST** be carried forward to new API versions.

---

## 10A. `readme.md` Suppression Scoping & Tag Coverage

### 10A.0 Suppression Rigor for GA vs. Preview (RPC-SUPPRESS-GA)

- Suppressions carried forward from **preview** API versions are **not automatically acceptable** in **GA (stable)** versions.
- For GA releases, reviewers **MUST** challenge each suppression: can the underlying violation now be fixed? Preview was the time let it slide; GA is the deadline to fix.
- `PathForResourceAction` suppressions in GA versions are **blocking** because they can prevent proper RBAC action registration.
- `LroLocationHeader` suppressions in GA versions are **blocking** because they indicate incorrect async patterns.
- Suppression reasons that say "back-compat with preview" are not sufficient for GA \u2014 provide a concrete technical justification for each suppression.

### 10A.1 Suppression Must Be Under Correct Tag (RPC-SUPPRESS-SCOPE)

- Suppressions in `readme.md` are scoped to the tag block they appear in. A suppression under `package-2025-03-01` does **not** apply to `package-2025-07-01`.
- When a PR adds a new swagger file to a **new** package tag, verify any carried-over suppressions are duplicated/moved to the new tag's `suppressions` list — or they will not take effect and CI will fail.
- Suppressions **MUST** include specific `from` and `where` clauses to target the exact file and JSON path of the violation. Blanket suppressions that suppress an entire file without specifying the path are not allowed — they mask other violations that may be introduced later.

### 10A.2 Operations API Must Be in Package Tag (RPC-Operations-V1-TAG)

- For ARM RPs, the `operations.json` (or equivalent operations API spec) **MUST** be included in every published package tag's input-file list.
- If a new tag only includes the service resource swagger but omits the operations API, flag it — the resulting SDK will be missing the operations endpoint.

---

## 11. API Version Practices (ARM-Specific)

**Reference: [RPC — API Versioning](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/resource-api-reference.md)**

### 11.1 Uniform Versioning Within a Service

- All resource types within a single Service under an RP namespace **MUST** version uniformly — they share the same `api-version` value.
- A change to any resource type in the service requires a new api-version for the entire service.
- A single package tag in `readme.md` **MUST NOT** mix swagger files from different API versions. For example, including both `stable/2024-10-01/foo.json` and `preview/2025-06-01-preview/bar.json` in the same tag violates uniform versioning.

### 11.2 Incremental Version Progression

- Copy the entire API surface when creating a new version. New preview versions should include all existing GA functionality plus new changes.
- When promoting from preview to GA, the GA version **MUST** have a later date than the preview version.
- The `default` API version tag in `readme.md` **MUST** point to the latest **stable** version. Do not change the default tag from a stable version to a preview version — the default tag is what SDK consumers get by default and must be a GA release.

---

## 12. POST Actions (ARM-Specific)

**Reference: [RPC — Resource Actions](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/resource-api-reference.md)**

### 12.1 Use POST Actions Sparingly

- POST actions should only be used for:
  - Actions on a single resource instance (e.g. `restart`, `listKeys`)
  - Provider-level actions
- POST action **MUST** have an action name in the URL path (RPC-POST-V1-01). POST **MUST NOT** be applied to a resource type — only to a specific resource instance or the provider (RPC-POST-V1-07).
- All parameters for a POST action **MUST** be in the request body, not in the URI (RPC-POST-V1-05). This ensures proper authorization checks.
- Synchronous POST **MUST** return `200` (OK) with response schema, or `204` (No Content) if no response body is needed (RPC-POST-V1-02).
- Asynchronous POST **MUST** return `202` (Accepted) and **SHOULD** additionally specify `200` with a response schema if the final response has content (RPC-POST-V1-03).
- POST action path segments and operation names **SHOULD** use verb phrases (e.g., `validateBackupParameters`, `beginRestore`) rather than noun phrases (e.g., `prebackup`, `prerestore`).
- Prefix the action name with `list` to enable ARM template deployment to call the POST action via the `list()` template function (RPC-POST-V1-10).
- **DO NOT** use POST actions for what should be CRUD operations — if the actions resemble create/read/update/delete, model them as proper resource operations with PUT/PATCH/GET/DELETE instead.

### 12.2 POST to Create Resources (Exception)

- POST may be used to create **proxy resources only** when the service generates the resource name.
- This exception does **not** apply to tracked resources — they **MUST** always use PUT.
- Prefer allowing customers to specify their own resource names (via PUT) as this is more compatible with ARM templates and Policy.

### 12.3 Version or Catalog Listings as Proxy Resources (RPC-LIST-VERSIONS)

- When a service needs to expose a list of available versions, SKUs, offerings, or other catalog-like data, model them as **proxy resource GET collections** — not as custom action endpoints or ad-hoc GET operations.
- The pattern is: `GET .../providers/Microsoft.{Namespace}/locations/{location}/{catalogResourceType}` returning a paginated list of proxy resources.
- Each item in the list **MUST** be modeled as a proper ARM proxy resource (with `id`, `name`, `type`, and `properties`).
- **DO NOT** model version/catalog listings as non-resource GET endpoints that return bare arrays or non-ARM-shaped responses — these cannot be tracked by ARM, are not compatible with RBAC, and the AKS-style `orchestrators` pattern is discouraged for new services.

---

## 13. List API Contract

### 13.1 List API Must Follow ARM Contract

- List operations **MUST** return a list wrapper object with a `value` array property and an optional `nextLink` property.
- The `value` array **MUST** contain the resource objects directly — do not wrap resources in additional envelopes.
- List operations **MUST** be marked with `"x-ms-pageable"` with `"nextLinkName": "nextLink"` (or `null` if the list is never paginated).
- The `nextLink` property **MUST** use `"format": "uri"` in its schema definition — do not set it to `null` as a value; use `x-ms-pageable` with `nextLinkName: null` if pagination is not supported.
- If a list operation violates this contract (e.g. wraps in an extra object, uses a different field name, doesn't include `x-ms-pageable`), flag it as an ARM Error.

---

## ARM Review Checklist Summary

When reviewing ARM resource-manager swagger files, verify:

### Resource Structure & Paths
- ✅ Tracked resource paths include `/subscriptions/` and `/resourceGroups/` segments; even-segmented paths (RPC-Put-V1-01, RPC-Put-V1-02)
- ✅ Tracked resources not nested beyond third level (RPC-Put-V1-19)
- ✅ Resource type names are camelCase, plural, and specific (not generic)
- ✅ ARM `type/{instance}/type/{instance}` URL pattern followed
- ✅ Proxy resources use `ProxyResource` base type (not `Resource`); proxy resources do NOT have `tags`
- ✅ Extension resources use the correct scope pattern
- ✅ Operations API endpoint exists using common-types `OperationListResult` and `Operation` definitions (RPC-Operations-V1)

### Resource Model
- ✅ Top-level ARM property names (`id`, `name`, `type`, `systemData`) NOT reused inside `properties` bag (RPC-Put-V1-09)
- ✅ `zones`, `sku`, `kind`, `plan`, `identity`, `tags` are top-level properties (not inside `properties`)
- ✅ Non-ARM-envelope properties are inside the `properties` bag
- ✅ `Operation`, `ErrorResponse`, `CloudError`, `PrivateEndpointConnection` use common-types definitions
- ✅ Every resource type has a point GET; singleton resources named "default"
- ✅ PUT request and response schemas are identical; PUT response matches GET and PATCH (RPC-Put-V1-12, RPC-Put-V1-25)
- ✅ PUT returns `201` (create) or `200` (replace) — never `202` for async PUT (RPC-Put-V1-11)
- ✅ PUT does not implicitly create other tracked resources (RPC-Put-V1-16)
- ✅ Tracked resources have all required operations (GET, PUT, PATCH, DELETE, ListByRG, ListBySub)
- ✅ GET operations return only `200` and are not LROs (RPC-Get-V1-01, RPC-Get-V1-14)
- ✅ Point GET has no query params other than `api-version` (RPC-Get-V1-08)
- ✅ Collection GET has only `value` and `nextLink` at top level with `x-ms-pageable`; `nextLink` has `format: uri` (RPC-Get-V1-09, RPC-Get-V1-13)
- ✅ `provisioningState` includes `Succeeded`, `Failed`, `Canceled` (single 'l') terminal states; no operational states like `Stopped` (RPC-Async-V1-02, RPC-Async-V1-03)

### PATCH Operations
- ✅ PATCH body has no required properties, no defaults, no create-only mutability (RPC-Patch-V1-10)
- ✅ PATCH does not update `id`, `name`, `type`, `location`, or `provisioningState` (RPC-Patch-V1-02)
- ✅ PATCH follows JSON Merge Patch (RFC 7396) semantics (RPC-Patch-V1-05)
- ✅ PATCH for tracked resources supports at least tag updates (RPC-Patch-V1-03)
- ✅ **PATCH is NOT required to be long-running** — do NOT flag synchronous PATCH as a violation
- ✅ No non-`api-version` query parameters on PATCH

### DELETE Operations
- ✅ Sync DELETE defines `200` + `204`; async DELETE defines `202` + `204`; DELETE body is empty (RPC-Delete-V1-01, RPC-Delete-V1-04)
- ✅ No request body on DELETE
- ✅ No non-`api-version` query parameters on DELETE

### Security & Secrets
- ✅ No secrets in GET/PUT/PATCH responses; secrets annotated with `x-ms-secret: true`
- ✅ Secret retrieval exposed via `list*` POST action, not GET
- ✅ Proactive secret detection (SEC-SECRET-DETECT) applied to all string properties

### Long-Running Operations
- ✅ Resources with async PUT/PATCH have `provisioningState` (readOnly) with terminal states Succeeded/Failed/Canceled (RPC-Async-V1-02, RPC-Async-V1-03)
- ✅ Async PUT returns `201`/`200` + provisioningState — never `202`; returns `409` if resource already in non-terminal state (RPC-Async-V1-01)
- ✅ Async PATCH/DELETE/POST return `202` with both `Location` and `Azure-AsyncOperation` headers; `202` body is empty (RPC-Async-V1-08/09/11/14)
- ✅ Greenfield RPs (since Jan 2025) include `Azure-AsyncOperation` header on all async responses including PUT `201` (RPC-Async-V1-06)
- ✅ Polling URIs have even segments, are absolute, and are not exposed via other means
- ✅ `Location` polling returns 202 in-progress → sync response on completion; `Azure-AsyncOperation` always returns 200 with status object
- ✅ POST actions do NOT affect provisioningState; provisioningState transitions only non-terminal → non-terminal or non-terminal → terminal
- ✅ Operation statuses at subscription scope for new services; no sensitive data in operation status properties

### Property Design (Properties Bag Review)
- ✅ String properties actively reviewed — enums used for finite/limited value sets
- ✅ String properties actively reviewed — specific formats used (`date-time`, `uri`, `uuid`, `duration`, etc.)
- ✅ No freeform `type: object` with no schema; no plain untyped string for structured values
- ✅ Booleans reviewed — extensible enums preferred
- ✅ Nullable properties annotated with `"x-ms-nullable": true`
- ✅ Immutable properties annotated with `x-ms-mutability: ["create", "read"]`
- ✅ Resource references use fully qualified ARM resource IDs
- ✅ No writable circular dependencies between resources
- ✅ `additionalProperties` only used for user-defined pass-through data, not service-owned properties (RPC-Put-V1-23)
- ✅ Deprecated properties use `"deprecated": true` keyword, not just description text

### List APIs
- ✅ List APIs return `{ value: [...], nextLink }` wrapper; `nextLink` has `format: uri`; marked with `x-ms-pageable`

### POST Actions
- ✅ POST actions have action name in URL, params in body, correct response codes (RPC-POST-V1-01, RPC-POST-V1-05)
- ✅ POST actions used only for non-CRUD operations
- ✅ Version/catalog listings modeled as proxy resource collections, not ad-hoc endpoints (RPC-LIST-VERSIONS)

### ARG Compatibility
- ✅ No embedded child resources or child counts in parent GET response (ARG001)
- ✅ No customer data in control plane properties (ARG002)
- ✅ Properties not removed between API versions; all prior-version types carried forward (ARG003)

### Nested & Inline Resources
- ✅ Singleton nested resources use `default` pattern with both collection and singleton GET
- ✅ Private endpoint connections use common-types or dedicated file
- ✅ Collections not modeled as both inline array and nested resource

### Versioning & Suppressions
- ✅ Uniform API versioning across all resource types in the service; no mixed versions in a single package tag
- ✅ Suppressions in `readme.md` are under the correct package tag with specific `from`/`where` clauses (RPC-SUPPRESS-SCOPE)
- ✅ Suppressions for GA versions justified individually — preview back-compat is not sufficient (RPC-SUPPRESS-GA)
- ✅ Every package tag includes the operations API spec (RPC-Operations-V1-TAG)

Flag all violations clearly with JSON path references, the specific RPC rule ID where applicable, and a concrete fix suggestion.
