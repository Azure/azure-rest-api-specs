---
applyTo: "specification/**/resource-manager/**/*.json"
---

# ARM-Specific OpenAPI (Swagger) Review Instructions
# ARM-Specific OpenAPI (Swagger) Review Instructions

This file contains **ARM control plane–specific** review rules that supplement the generic OpenAPI review instructions in `openapi-review.instructions.md`. All generic rules (versioning, naming, JSON conventions, enums, error handling, pagination, descriptions, x-ms extensions, etc.) are enforced by that file and are **not repeated here**. When reviewing ARM resource-manager swagger files, apply **both** instruction sets. If the Azure RPC contract conflicts with the generic guidelines, the ARM RPC rules below take precedence.

Flag every violation clearly with the file path, JSON path or line number, the specific rule ID, and a concrete suggestion for how to fix it. Respond in markdown format.

---

## 1. ARM Resource Path Structure

### 1.1 Tracked Resource Paths (RPC-Put-V1-01, RPC-Get-V1-11)

- All API paths for **tracked resources** (resources with `location` as a required property) **MUST** be scoped under a subscription and resource group:
  ```text
  /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.{Namespace}/{resourceType}/{resourceName}
  ```
- If a tracked resource path is missing the `subscriptions` or `resourceGroups` segments, flag it as an error and instruct the author to add them.

### 1.2 Proxy Resource Paths

- Proxy resources (no `location` property) **MAY** be scoped at subscription level, management group level, or as nested children — but verify the scope is intentional.
- Extension resources use the pattern: `/{scope}/providers/Microsoft.{Namespace}/{resourceType}/{resourceName}` where `{scope}` is a target resource ID.
- **Proxy resources MUST use `ProxyResource` as their base type, NOT `Resource`.** If a proxy or extension resource extends `Resource` instead of `ProxyResource`, flag it as an error.
- **Proxy resources MUST NOT have `tags`.** Tags are a property of tracked resources only. If tags appear on a proxy resource, flag it and instruct the author to remove them.

### 1.3 Resource Provider Namespace Consistency (RPC-Put-V1-06)

- The `Microsoft.{Namespace}` in every path **MUST** match the resource provider namespace declared in the specification.
- Flag any mismatch between path namespace and the `title` or `host` metadata.

### 1.4 Operations API (RPC-Operations-V1)

- Every resource provider **MUST** expose an operations API at:
  ```text
  /providers/Microsoft.{Namespace}/operations
  ```
- This GET operation **MUST** return an `OperationListResult` with `x-ms-pageable` and a `nextLinkName`.
- The operations list **MUST** use the common types `OperationListResult` and `Operation` definitions. Do not define custom Operation types.
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

### 2.1 PUT Response Must Be an ARM Resource (RPC-Put-V1-12)

- The `200` and `201` response models for a PUT operation **MUST** have `x-ms-azure-resource: true` set somewhere in their schema hierarchy (typically inherited from the common-types `Resource` base).
- If missing, flag it and instruct the author to ensure the response model extends a common-types resource base.

### 2.2 Tracked Resource Requirements

- A **tracked resource** (has `location` as required property) **MUST** implement all of:
  - **GET** — return the resource (RPC-Get-V1-01)
  - **PUT** — create or replace the resource (RPC-Put-V1-01)
  - **PATCH** — update the resource; at minimum must support updating `tags` (RPC-Patch-V1-03)
  - **DELETE** — remove the resource (RPC-Delete-V1-01)
  - **List by Resource Group** (RPC-Get-V1-11)
  - **List by Subscription** (RPC-Get-V1-11)
- If any of these operations are missing for a tracked resource, flag it as an ARM Error.

### 2.3 Nested Resources

- Nested resources **MUST** have a List operation under their parent.
- Nested resources **MUST NOT** be embedded inline in the parent resource's GET response body (see Azure Resource Graph guideline ARG001 below). Return a resource ID reference instead.

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

### 2.7 Every Resource Must Have a Point GET (Singleton Naming)

- Every resource type **MUST** have a corresponding singleton or point GET operation that retrieves a single instance by its resource path.
- If a List operation exists but no corresponding GET for a single instance, flag it as an ARM Error.
- **Singleton resources MUST be named "default"** (lowercase). Names like "Experimentation", "config", or any other non-"default" value for a singleton are not allowed unless explicitly approved.

### 2.8 Common Type Definitions Must Be Used

- **Do not define custom types for `Operation`, `OperationListResult`, `ErrorResponse`, `CloudError`, or `ErrorDetail`**. These **MUST** be referenced from the ARM common types (`common-types/resource-management/vX/types.json`).
- Private endpoint connection types (`PrivateEndpointConnection`, `PrivateLinkResource`, etc.) **MUST** also come from common types unless the service has a documented exception. If defining them locally, they must be in a dedicated file (e.g. `privateEndpointConnections.json`) and must exactly match the common types schema.
- Flag any custom re-definition of these types as an ARM Error.

---

## 3. PUT Operation Rules

### 3.1 PUT for Resource Creation

- Resources that are created by end users **MUST** expose a PUT operation.
- **Exception**: POST may be used to create **proxy resources only** when the business scenario requires the service to generate the resource name. Tracked resources **MUST** always use PUT.
- PUT **MUST** be idempotent — sending the same PUT request multiple times must produce the same result.

### 3.2 PUT Must Not Expose Secrets in Response

- The response of a PUT operation **MUST NOT** return secret values (e.g. passwords, keys, connection strings).
- If a secret is accepted on write (e.g. `administratorPassword`), the response **MUST** return `null` or omit the property entirely.
- Properties containing secrets **MUST** be annotated with "x-ms-secret": true.

---

## 4. PATCH Operation Rules

### 4.1 PATCH Body Must Not Have Required Properties (RPC-Patch-V1-10)

- PATCH request body parameters **MUST NOT** have any properties marked as `required`.
- PATCH request body properties **MUST NOT** have `default` values.
- PATCH request body properties **MUST NOT** have `x-ms-mutability` set to only `["create"]`.
- A PATCH operation updates only the fields the customer provides — forced defaults or required fields break this contract.
- **Recommendation**: Define a separate "Update" or "PatchBody" model containing only the patchable properties, rather than reusing the full resource model.

### 4.2 Tracked Resource PATCH Must Support Tags (RPC-Patch-V1-03)

- For tracked resources, the PATCH operation **MUST** support updating `tags` at minimum.
- Ideally, all mutable properties should be patchable for a better customer experience.

### 4.3 PATCH Must Not Expose Secrets in Response

- Same rule as PUT — the PATCH response **MUST NOT** return secret values.

### 4.4 PATCH Does NOT Need to Be Long-Running (CRITICAL)

- **PATCH operations are NOT required to be long-running.** Do NOT flag a PATCH operation as an error or warning solely because it is synchronous (i.e., it does not use `x-ms-long-running-operation: true`).
- A PATCH MAY be long-running if the service genuinely requires it (in which case it MUST return `200` for completion and `202 Accepted` for async acceptance), but this is NOT a requirement.
- **Never recommend or mandate that a PATCH be made long-running as a blanket rule.** Only flag if the PATCH returns `202` without the required `x-ms-long-running-operation` annotation.

### 4.5 No Query Parameters on PATCH Operations

- PATCH operations **MUST NOT** have query parameters other than `api-version`.
- If additional filtering is needed, use OData `$filter` — do not add individual query parameters.

---

## 5. DELETE Operation Rules

### 5.1 DELETE Response Codes (RPC-Delete-V1-01)

- Non-async DELETE operations **MUST** define responses for:
  - `200` — successful deletion (with body)
  - `204` — resource not found / already deleted (no body)
  - `default` — error response
- Do **not** return `404` for a resource that doesn't exist — return `204` instead.
- Async DELETE operations **MUST** also include `202` (Accepted) per RPC-Async-V1-09.

### 5.2 DELETE Must Not Have a Request Body

- DELETE operations **MUST NOT** accept a request body parameter.

### 5.3 No Query Parameters on DELETE Operations

- DELETE operations **MUST NOT** have query parameters other than `api-version`.

---

## 6. Long-Running Operations (ARM-Specific)

### 6.1 Async Response Validation (RPC-Async-V1)

- LRO PUT operations returning `201` **MUST** include a response schema (the resource body).
- LRO POST and DELETE operations returning `202` **MUST** include `Location` or `Azure-AsyncOperation` response headers.
- The `200`/`201` response of an LRO **MUST** have a schema definition — empty LRO responses are invalid.
- Always use unique identifiers (GUIDs) for operation results — never hash-based identifiers that could collide across sequential operations on the same resource.
- If an operation returns `202` it **MUST** be marked with "x-ms-long-running-operation": true. Flag any operation with a `202` response that lacks this annotation.

### 6.2 202 Response Must Not Contain the Resource Body

- A `202 Accepted` response **MUST NOT** contain a schema/body that is the full resource representation.
- The `202` response body, if present, should only be a status/operation-tracking envelope (e.g. an `OperationStatus` object), not the resource itself.
- Flag any `202` response whose schema is the same as (or directly references) the primary resource model.

### 6.3 Long-Running PATCH Requirements

- If a PATCH operation IS long-running, it **MUST** return `202 Accepted` (in addition to the final `200`) and be annotated with "x-ms-long-running-operation": true.
- Remember: being long-running for PATCH is **optional** (see rule 4.4). Only validate the above if the PATCH is declared as long-running.

### 6.4 Operation Results Placement

- The `/operationResults` API used to track async operations **MUST** be modeled as a root-level resource, not as a child of the resource being operated on.
- If modeled as a child, `404 Not Found` will be returned after a deletion completes, causing ARM to fail to track the async operation.

### 6.5 Location Header for Async Operations

- Services performing async operations **MUST** return a `Location` header in `202` responses to allow polling.
- Verify that the swagger `202` response definition includes the `Location` response header. If it is suppressed or missing, flag it and ask the author to confirm whether the service actually returns a `Location` header today.

---

## 7. Secret Handling & Sensitive Data

### 7.1 No Secrets in GET/PUT/PATCH Responses

- Secrets (passwords, keys, connection strings, tokens) **MUST NOT** be exposed in the response of GET, PUT, or PATCH operations.
- For properties that accept a secret on write:
  - Return `null` or omit the property in the GET/PUT/PATCH response.
  - If the secret needs to be retrievable, expose it via a **POST action** (e.g. `listKeys`) for granular RBAC control.
  - POST actions named `list*` (e.g. `listKeys`, `listConnectionStrings`) are automatically exposed to ARM deployment templates via the `list()` template function.

### 7.2 x-ms-secret Annotation

- Any property that contains a secret in **any** operation (PUT, PATCH, GET, or POST) **MUST** be annotated with "x-ms-secret": true in the swagger definition.

---

## 8. Property Design Best Practices

> **These rules apply specifically to properties defined inside the `properties` bag of a resource model.** Always examine all properties critically for better design opportunities.

### 8.1 Prefer Enums Over Booleans

- **YOU SHOULD** use extensible string enums instead of boolean types.
- Booleans do not version well — what starts as a two-state switch often needs additional states in the future, leading to breaking changes.
- When converting a boolean concept to an enum, use meaningful state names (e.g. "NetworkOperationStatus": ["InProgress", "Succeeded", "Failed"]) not just "True" / "False".

### 8.2 Use Enums for Finite Value Sets (ACTIVELY REVIEW)

- **Actively examine every `string` property** in the `properties` bag. If the property name or description suggests it takes values from a limited or well-known set (e.g. "status", "mode", "tier", "kind", "protocol", "algorithm", "action", "state", "type", "category", "level"), **flag it** and recommend modeling it as an extensible enum with `x-ms-enum`.
- If a string property's description lists its valid values (e.g. "Possible values are: Enabled, Disabled"), it **MUST** be declared as an enum, not a plain string.
- Use "x-ms-enum": { "name": "<EnumName>", "modelAsString": true } to keep the enum extensible and avoid breaking changes when new values are added.

### 8.3 Use Specific Types Instead of Generic Strings (ACTIVELY REVIEW)

- **Actively examine every `string` property** for opportunities to use a more precise type:
  - Properties that represent a date, time, or timestamp **MUST** use "type": "string", "format": "date-time" (ISO 8601). Do not use a plain unformatted string for timestamps.
  - Properties that represent a duration **MUST** use "type": "string", "format": "duration" (ISO 8601 duration).
  - Properties that represent a URL or URI **MUST** use "type": "string", "format": "uri".
  - Properties that represent a UUID/GUID **MUST** use "type": "string", "format": "uuid".
  - Properties that represent a Base64-encoded value **MUST** use "type": "string", "format": "byte".
  - Properties that represent a binary value **MUST** use "type": "string", "format": "binary".
  - Properties that represent a password or secret **MUST** use "type": "string", "format": "password" and "x-ms-secret": true.
- If a plain "type": "string" property clearly represents one of the above, flag it and suggest the correct format.

### 8.4 Use Objects Instead of Strings for Structured Values

- If a property value has a well-defined or structured format (e.g. a JSON blob encoded as a string, a connection string with multiple components), model it as an object, not a free-form string.
- Free-form strings prevent client-side validation and make SDK generation less useful.
- **No freeform `type: object` either** — if a property is typed as `type: object` with no additional schema properties defined (an "empty object" or "any"), flag it. Every object property **MUST** have its schema defined with explicit properties.

### 8.5 Visibility and Mutability

- Properties that can be set on creation but **not** subsequently updated **MUST** be annotated with `x-ms-mutability`: ["create", "read"] (or `@visibility("create", "read")` in TypeSpec).
- Properties that are only returned in responses **MUST** be annotated with "readOnly": true or `x-ms-mutability`: ["read"].
- Properties that are fully mutable (create + update + read) do **not** need an `x-ms-mutability` annotation.

### 8.6 Avoid Writable Circular Dependencies

- If resource A references resource B, and resource B's GET response includes a back-reference to resource A, mark **one** of the references as `readOnly`.
- Writable circular references prevent ARM from determining dependency ordering in deployment templates.

### 8.7 ProvisioningState Correctness

- `provisioningState` **MUST** include at minimum the terminal states: "Succeeded", "Failed", and "Canceled" (with a single 'l' — NOT "Cancelled").
- Non-terminal states like "Stopped" **MUST NOT** be included in `provisioningState`. Stopped/Running are operational states of the resource, not provisioning states.
- If `provisioningState` is missing required terminal states or includes invalid values, flag it.

### 8.8 Null and x-ms-nullable

- If a property can return `null` in a response, it **MUST** be annotated with "x-ms-nullable": true.
- Do not rely on the absence of "required" to imply nullability — be explicit.

---

## 9. Query Parameters & HTTP Verbs

### 9.1 Use OData Filters Instead of Individual Query Parameters

- For list/filter operations, prefer OData `$filter` over introducing individual custom query parameters.
- Do **not** add non-`api-version` query parameters to PUT, PATCH, or DELETE operations.
- If individual query parameters exist on a non-GET operation, flag it.

### 9.2 POST Action Definitions

- POST actions on resources **MUST** follow the ARM pattern: the action name appears as a path segment after the resource name (e.g. `.../resourceType/{resourceName}/actionName`).
- Do **not** use POST to replicate what should be a CRUD operation.
- **Not the right way to define a POST action**: using POST where the intent is to create a child resource that has a stable identity. Use PUT instead.

---

## 10. Inline Properties vs. Nested Resources (Design Choice)

### 10.1 When to Use Inline Properties

- The property set is an intrinsic part of the resource's state.
- The properties must be operated on together with other properties of the resource.
- The property set is small and not expected to grow significantly.

### 10.2 When to Use Nested Resources Instead

- The property set is complex enough to warrant its own lifecycle (separate CRUD operations).
- The properties have RBAC or routing requirements separate from the parent resource.
- The collection could grow large (arrays with unbounded or very large element counts **MUST** be modeled as nested resources, not inline arrays).
- Each element needs its own ARM resource ID.

### 10.3 Never Model Both

- A collection **MUST NOT** be modeled as **both** an inline array property **and** a nested resource type. This causes:
  - Customer confusion from duplicate representations
  - Inconsistencies if both representations are not kept in sync
  - Complications with Azure Resource Graph integration

### 10.4 Private Endpoint Connection Antipatterns

- Do not document **internal** private link contracts (e.g. private endpoint connections between internal services) as **external** ARM APIs.
- Private endpoint connection definitions **MUST** either come from ARM common types or be defined in a dedicated file (e.g. `privateEndpointConnections.json`). Do not define them inline in the main resource file.

---

## 11. Azure Resource Graph (ARG) Compatibility

### 11.1 No Embedded Child Resources in Parent GET (ARG001)

- **DO NOT** return child/nested resources inline in the parent resource's GET response.
- **DO NOT** include child resource count properties (e.g. `addressCount`) on the parent.
- Instead, return only a resource ID reference to the child, and require separate GET calls for child resources.
- **Rationale**: If a child resource changes, the parent resource notification may not fire, causing Azure Resource Graph to show stale data. It also creates information-leak risks if the user has access to the parent but not the child.

### 11.2 No Customer Data in Control Plane Properties (ARG002)

- **DO NOT** model customer data (user code, user content, PII) in the control plane resource properties.
- Control plane components (including ARG) cache resource properties and may store them in non-GDPR-compliant ways.
- If customer data must be associated with a resource, expose it via a **data plane API** or use a special query parameter (e.g. `$expandCustomerData=true`) that is not included in the default GET response.

### 11.3 Do Not Remove Properties Between API Versions (ARG003)

- **DO NOT** remove properties from a resource between API versions until the property's usage has been fully deprecated.
- Properties may be referenced in Azure Resource Graph queries and Azure Policy definitions. Removing them breaks customer queries.
- Instead, keep the property in the response and mark it as deprecated in the swagger description and documentation.
- All types and properties from previous API versions **MUST** be carried forward to new API versions.

---

## 12. API Version Practices (ARM-Specific)

### 12.1 Uniform Versioning Within a Service

- All resource types within a single Service under an RP namespace **MUST** version uniformly — they share the same `api-version` value.
- A change to any resource type in the service requires a new api-version for the entire service.

### 12.2 Incremental Version Progression

- Copy the entire API surface when creating a new version. New preview versions should include all existing GA functionality plus new changes.
- When promoting from preview to GA, the GA version **MUST** have a later date than the preview version.

---

## 13. POST Actions (ARM-Specific)

### 13.1 Use POST Actions Sparingly

- POST actions should only be used for:
  - Actions on a single resource instance (e.g. `restart`, `listKeys`)
  - Provider-level actions
- **DO NOT** use POST actions for what should be CRUD operations — if the actions resemble create/read/update/delete, model them as proper resource operations with PUT/PATCH/GET/DELETE instead.

### 13.2 POST to Create Resources (Exception)

- POST may be used to create **proxy resources only** when the service generates the resource name.
- This exception does **not** apply to tracked resources — they **MUST** always use PUT.
- Prefer allowing customers to specify their own resource names (via PUT) as this is more compatible with ARM templates and Policy.

---

## 14. List API Contract

### 14.1 List API Must Follow ARM Contract

- List operations **MUST** return a list wrapper object with a `value` array property and an optional `nextLink` property.
- The `value` array **MUST** contain the resource objects directly — do not wrap resources in additional envelopes.
- List operations **MUST** be marked with "x-ms-pageable" with "nextLinkName": "nextLink" (or `null` if the list is never paginated).
- The `nextLink` property format **MUST** be "format": "uri" — do not set it to `null` as a value; use `x-ms-pageable` with `nextLinkName: null` if pagination is not supported.
- If a list operation violates this contract (e.g. wraps in an extra object, uses a different field name, doesn't include `x-ms-pageable`), flag it as an ARM Error.

---

## 15. Suppression Rules

### 15.1 Suppressions Must Include a `where` Clause

- Any suppression of an ARM or linter rule **MUST** include a `where` clause specifying exactly which path(s), operation(s), or property/properties the suppression applies to.
- **Blanket suppressions** (those without a `where` clause targeting the entire file or all occurrences) are **NOT allowed**.
- If a suppression is missing a `where` clause, flag it and instruct the author to narrow the suppression to the specific violation location.

---

## ARM Review Checklist Summary

When reviewing ARM resource-manager swagger files, verify:

### Resource Structure & Paths
- ✅ Tracked resource paths include `/subscriptions/` and `/resourceGroups/` segments
- ✅ Resource type names are camelCase, plural, and specific (not generic)
- ✅ ARM `type/{instance}/type/{instance}` URL pattern followed
- ✅ Proxy resources use `ProxyResource` base type (not `Resource`)
- ✅ Proxy resources do NOT have `tags`
- ✅ Extension resources use the correct scope pattern
- ✅ Operations API endpoint exists for the resource provider, using common types definitions

### Resource Model
- ✅ Top-level ARM property names (`id`, `name`, `type`, `systemData`) NOT reused inside `properties` bag
- ✅ `zones`, `sku`, `kind`, `plan`, `identity`, `tags` are top-level properties (not inside `properties`)
- ✅ Non-ARM-envelope properties are inside the `properties` bag
- ✅ PUT request and 200 response schemas are identical
- ✅ PUT 200/201 response has `x-ms-azure-resource: true` in hierarchy
- ✅ Tracked resources have all required operations (GET, PUT, PATCH, DELETE, ListByRG, ListBySub)
- ✅ Every resource type has a point GET / singleton GET
- ✅ Singleton resources are named "default" (lowercase)
- ✅ `Operation`, `ErrorResponse`, `CloudError`, `PrivateEndpointConnection` use common types definitions
- ✅ `provisioningState` includes "Succeeded", "Failed", "Canceled" (single 'l') terminal states only

### PATCH Operations
- ✅ PATCH body has no required properties, no defaults, no create-only mutability
- ✅ PATCH for tracked resources supports at least tag updates
- ✅ **PATCH is NOT required to be long-running** — do NOT flag synchronous PATCH as a violation
- ✅ No non-`api-version` query parameters on PATCH

### DELETE Operations
- ✅ DELETE defines 200, 204, and default responses (plus 202 if async)
- ✅ No request body on DELETE
- ✅ No non-`api-version` query parameters on DELETE

### Security & Secrets
- ✅ No secrets in GET/PUT/PATCH responses; secrets annotated with "x-ms-secret: true"
- ✅ Secret retrieval exposed via `list*` POST action, not GET

### Long-Running Operations
- ✅ 202 responses do NOT contain the resource body
- ✅ Operations returning 202 are marked with "x-ms-long-running-operation: true"
- ✅ LRO 200/201 responses include schema definitions
- ✅ LRO POST/DELETE 202 responses include `Location` or `Azure-AsyncOperation` headers
- ✅ Operation results modeled as root-level resources (not children)
- ✅ Async operations return a `Location` header

### Property Design (Properties Bag Review)
- ✅ String properties actively reviewed — enums used for finite/limited value sets
- ✅ String properties actively reviewed — specific formats used (date-time, uri, uuid, duration, etc.)
- ✅ No freeform `type: object` with no schema; no plain untyped string for structured values
- ✅ Booleans reviewed — extensible enums preferred
- ✅ Nullable properties annotated with "x-ms-nullable: true"
- ✅ Immutable properties annotated with `x-ms-mutability`: ["create", "read"]
- ✅ Resource references use fully qualified ARM resource IDs
- ✅ No writable circular dependencies between resources

### List APIs
- ✅ List APIs return `{ value: [...], nextLink: "..." }` wrapper and are marked with `x-ms-pageable`

### ARG Compatibility
- ✅ No embedded child resources or child counts in parent GET response
- ✅ No customer data in control plane properties
- ✅ Properties not removed between API versions; all prior-version types carried forward

### Versioning & Suppressions
- ✅ Uniform API versioning across all resource types in the service
- ✅ API version parity across Azure clouds
- ✅ All suppressions include a `where` clause — no blanket suppressions
- ✅ POST actions used only for non-CRUD operations

Flag all violations clearly with JSON path references, the specific RPC rule ID where applicable, and a concrete fix suggestion.