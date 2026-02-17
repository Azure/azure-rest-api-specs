---
applyTo: "specification/**/resource-manager/**/*.json"
---

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

### 1.3 Resource Provider Namespace Consistency (RPC-Put-V1-06)

- The `Microsoft.{Namespace}` in every path **MUST** match the resource provider namespace declared in the specification.
- Flag any mismatch between path namespace and the `title` or `host` metadata.

### 1.4 Operations API (RPC-Operations-V1)

- Every resource provider **MUST** expose an operations API at:
  ```text
  /providers/Microsoft.{Namespace}/operations
  ```
- This GET operation **MUST** return an `OperationListResult` with `x-ms-pageable` and a `nextLinkName`.
- If the operations endpoint is missing from the spec, flag it as an ARM Error.

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

---

## 3. PUT Operation Rules

### 3.1 PUT for Resource Creation

- Resources that are created by end users **MUST** expose a PUT operation.
- **Exception**: POST may be used to create **proxy resources only** when the business scenario requires the service to generate the resource name. Tracked resources **MUST** always use PUT.
- PUT **MUST** be idempotent — sending the same PUT request multiple times must produce the same result.

### 3.2 PUT Must Not Expose Secrets in Response

- The response of a PUT operation **MUST NOT** return secret values (e.g. passwords, keys, connection strings).
- If a secret is accepted on write (e.g. `administratorPassword`), the response **MUST** return `null` or omit the property entirely.
- Properties containing secrets **MUST** be annotated with `"x-ms-secret": true`.

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

---

## 6. Long-Running Operations (ARM-Specific)

### 6.1 Async Response Validation (RPC-Async-V1)

- LRO PUT operations returning `201` **MUST** include a response schema (the resource body).
- LRO POST and DELETE operations returning `202` **MUST** include `Location` or `Azure-AsyncOperation` headers.
- The `200`/`201` response of an LRO **MUST** have a schema definition — empty LRO responses are invalid.
- Always use unique identifiers (GUIDs) for operation results — never hash-based identifiers that could collide across sequential operations on the same resource.

### 6.2 Operation Results Placement

- The `/operationResults` API used to track async operations **MUST** be modeled as a root-level resource, not as a child of the resource being operated on.
- If modeled as a child, `404 Not Found` will be returned after a deletion completes, causing ARM to fail to track the async operation.

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

---

## 8. Property Design Best Practices

### 8.1 Prefer Enums Over Booleans

- **YOU SHOULD** use extensible string enums instead of boolean types.
- Booleans do not version well — what starts as a two-state switch often needs additional states in the future, leading to breaking changes.
- When converting a boolean concept to an enum, use meaningful state names (e.g. `"NetworkOperationStatus": ["InProgress", "Succeeded", "Failed"]`) not just `"True"` / `"False"`.

### 8.2 Use Objects Instead of Strings for Structured Values

- If a property value has a well-defined or structured format, model it as an object, not a free-form string.
- Free-form strings prevent client-side validation and make SDK generation less useful.

### 8.3 Use Enums for Finite Value Sets

- If a string property has a finite set of values enforced by the service, declare it as an enum type with `x-ms-enum` to enable client-side validation and discoverability.

### 8.4 Visibility and Mutability

- Properties that can be set on creation but **not** subsequently updated **MUST** be annotated with `x-ms-mutability: ["create", "read"]` (or `@visibility("create", "read")` in TypeSpec).
- Properties that are only returned in responses **MUST** be annotated with `"readOnly": true` or `x-ms-mutability: ["read"]`.
- Properties that are fully mutable (create + update + read) do **not** need an `x-ms-mutability` annotation.

### 8.5 Avoid Writable Circular Dependencies

- If resource A references resource B, and resource B's GET response includes a back-reference to resource A, mark **one** of the references as `readOnly`.
- Writable circular references prevent ARM from determining dependency ordering in deployment templates.

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

---

## 11. API Version Practices (ARM-Specific)

### 11.1 Uniform Versioning Within a Service

- All resource types within a single Service under an RP namespace **MUST** version uniformly — they share the same `api-version` value.
- A change to any resource type in the service requires a new api-version for the entire service.

### 11.2 Incremental Version Progression

- Copy the entire API surface when creating a new version. New preview versions should include all existing GA functionality plus new changes.
- When promoting from preview to GA, the GA version **MUST** have a later date than the preview version.

---

## 12. POST Actions (ARM-Specific)

### 12.1 Use POST Actions Sparingly

- POST actions should only be used for:
  - Actions on a single resource instance (e.g. `restart`, `listKeys`)
  - Provider-level actions
- **DO NOT** use POST actions for what should be CRUD operations — if the actions resemble create/read/update/delete, model them as proper resource operations with PUT/PATCH/GET/DELETE instead.

### 12.2 POST to Create Resources (Exception)

- POST may be used to create **proxy resources only** when the service generates the resource name.
- This exception does **not** apply to tracked resources — they **MUST** always use PUT.
- Prefer allowing customers to specify their own resource names (via PUT) as this is more compatible with ARM templates and Policy.

---

## ARM Review Checklist Summary

When reviewing ARM resource-manager swagger files, verify:

- ✅ Tracked resource paths include `/subscriptions/` and `/resourceGroups/` segments
- ✅ Top-level resource body properties are from the allowed set only; custom properties are inside `properties`
- ✅ PUT request and 200 response schemas are identical
- ✅ PUT 200/201 response has `x-ms-azure-resource: true` in hierarchy
- ✅ Tracked resources have all required operations (GET, PUT, PATCH, DELETE, ListByRG, ListBySub)
- ✅ PATCH body has no required properties, no defaults, no create-only mutability
- ✅ PATCH for tracked resources supports at least tag updates
- ✅ DELETE defines 200, 204, and default responses (plus 202 if async)
- ✅ No secrets in GET/PUT/PATCH responses; secrets annotated with `x-ms-secret: true`
- ✅ Secret retrieval exposed via `list*` POST action, not GET
- ✅ Resource references use fully qualified ARM resource IDs
- ✅ No embedded child resources or child counts in parent GET response
- ✅ No customer data in control plane properties
- ✅ Properties not removed between API versions
- ✅ Booleans reviewed — extensible enums preferred
- ✅ Operations API endpoint exists for the resource provider
- ✅ LRO 200/201 responses include schema definitions
- ✅ Operation results modeled as root-level resources (not children)
- ✅ Uniform API versioning across all resource types in the service
- ✅ API version parity across Azure clouds
- ✅ No writable circular dependencies between resources
- ✅ POST actions used only for non-CRUD operations

Flag all violations clearly with JSON path references, the specific RPC rule ID where applicable, and a concrete fix suggestion.
