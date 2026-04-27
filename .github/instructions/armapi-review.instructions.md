---
applyTo: "specification/**/resource-manager/**/*.json"
---

<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-04-15
     All rules derived from or aligned with:
       - Azure Resource Provider Contract (RPC) v1.0
         https://github.com/cloud-and-ai-microsoft/resource-provider-contract/tree/master/v1.0
       - Azure REST API Guidelines (vNext)
         https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md
       - ARM API Best Practices
         https://eng.ms/docs/products/arm/api_contracts/guidelines/api_best_practices_and_design_choices
     If an upstream document changes a rule, update this file to match.
     When in doubt, the upstream document takes precedence over this file. -->

# ARM-Specific OpenAPI (Swagger) Review Instructions

This file contains **ARM control plane–specific** review rules that supplement the generic OpenAPI review instructions in `openapi-review.instructions.md`. All generic rules (versioning, naming, JSON conventions, enums, error handling, pagination, descriptions, x-ms extensions, etc.) are enforced by that file and are **not repeated here**. When reviewing ARM resource-manager swagger files, apply **both** instruction sets. If the Azure RPC contract conflicts with the generic guidelines, the ARM RPC rules below take precedence.

**Authoritative source for ARM control-plane rules:** [Azure Resource Provider Contract (RPC)](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/tree/master/v1.0). The RPC defines the contract between ARM and resource providers for PUT, PATCH, DELETE, GET, POST, and async operations. All rules in this file are derived from or aligned with the RPC. When in doubt, consult the RPC contract directly.

**Supplementary references:**
- [ARM API Best Practices & Design Choices](https://eng.ms/docs/products/arm/api_contracts/guidelines/api_best_practices_and_design_choices)
- [Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)

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
- **Extension resources MUST always be proxy.** An extension resource (one whose path uses the `/{scope}/providers/...` pattern) **MUST NOT** have `location` as a required property. If a resource model for an extension resource path includes a required `location` property, it is incorrectly modeled as a tracked resource — flag it as an ARM Error and instruct the author to remove `location` (RPC-Uri-V1-12).
  (Also enforced by: `TrackedExtensionResourcesAreNotAllowed` linter rule)
- **No duplicate paths when using `{scope}` parameter (RPC-Uri-V1-10).** If an API uses the `{scope}` path parameter to support multiple scopes (tenant, management group, subscription, resource group), the spec **MUST NOT** also include explicitly-scoped paths for the same resource type (e.g., both `/{scope}/providers/Microsoft.Bakery/breads` and `/subscriptions/{subscriptionId}/providers/Microsoft.Bakery/breads`). Either use `{scope}` or use explicit scope paths, but not both.
  (Also enforced by: `NoDuplicatePathsForScopeParameter` linter rule)

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
- The operations API endpoint **MUST** be scoped at the tenant level only (`/providers/Microsoft.{Namespace}/operations`). Operations **MUST NOT** vary per subscription — do not define the operations API under `/subscriptions/{subscriptionId}/...` (RPC-Operations-V1-02).
  (Also enforced by: `OperationsApiTenantLevelOnly` linter rule)
- When adding new API versions, the operations list **MUST** include ALL operations across all API versions. Do not remove existing operations from the operations list — only add new ones.

### 1.5 ARM URL Pattern Compliance

- Every resource URL **MUST** follow the `type/{instance}/type/{instance}` pattern required by ARM and RBAC.
- Paths that skip the instance segment (e.g. `.../type/type/{instance}`) are invalid and will break RBAC role assignment scoping.

### 1.6 Resource Type Naming

> **See also:** [`.github/skills/azure-api-review/references/naming-conventions.md`](../skills/azure-api-review/references/naming-conventions.md) for comprehensive resource type naming rules, RP namespace naming, and casing conventions.

- Resource type names in URL paths **MUST** be **camelCase**, **plural**, and **specific** (not generic names like `resourceName`).
- Resource type names **MUST NOT** collide with well-known Azure concepts (e.g., `subscriptions`, `resourceGroups`).
- Resource type names **MUST NOT** repeat the resource provider namespace.
- Resource provider namespace names **MUST NOT** be code names, product abbreviations, or temporary names.

### 1.7 Client-Facing Text Must Not Use Internal Terminology

> **See also:** [`.github/skills/azure-api-review/references/naming-conventions.md`](../skills/azure-api-review/references/naming-conventions.md) for comprehensive Azure terminology and naming rules.

- Property names, descriptions, and enum values **MUST NOT** use "ARM" as a standalone term. Use "Azure" or "Azure Resource Manager" instead.
- Descriptions **MUST NOT** use "AAD". Use "Microsoft Entra ID" instead.
- Descriptions **MUST** expand acronyms on first use (e.g., "Locally Redundant Storage (LRS)").

---

## 2. ARM Resource Model Rules

**Reference: [RPC — Resource API Reference](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/resource-api-reference.md)**

### 2.1 PUT Response Must Be an ARM Resource (RPC-Put-V1-12)

- The `200` and `201` response models for a PUT operation **MUST** have `x-ms-azure-resource: true` set somewhere in their schema hierarchy (typically inherited from the common-types `Resource` base).
- If missing, flag it and instruct the author to ensure the response model extends a common-types resource base.
- `x-ms-azure-resource: true` **MUST** only be set on top-level resource envelope models. It **MUST NOT** be applied to nested or child models within a resource definition. See [`.github/skills/azure-api-review/references/tracked-resource-lifecycle.md`](../skills/azure-api-review/references/tracked-resource-lifecycle.md) for details.

### 2.2 Tracked Resource Requirements

> **Full rule definition:** See [`.github/skills/azure-api-review/references/tracked-resource-lifecycle.md`](../skills/azure-api-review/references/tracked-resource-lifecycle.md) for the complete tracked resource CRUD requirements, required operations matrix with rule IDs, and collection GET contract.

- A **tracked resource** (has `location` as required property) **MUST** implement GET, PUT, PATCH, DELETE, List by Resource Group, and List by Subscription. If any are missing, flag it as an ARM Error.
- Point GET operations **MUST NOT** have query parameters other than `api-version` (RPC-Get-V1-08).
- Collection GET responses **MUST** only have `value` and `nextLink` as top-level properties; `nextLink` **MUST** use `"format": "uri"` (RPC-Get-V1-09, RPC-Get-V1-13).
- Collection GET operations **MUST NOT** have query parameters other than `api-version` and OData `$filter` (RPC-Get-V1-15). Custom query parameters on collection GETs are not supported by ARM.
  (Also enforced by: `QueryParametersInCollectionGet` linter rule — staging only)
- The model in the `value` array of a collection GET **MUST** be the same model as the point GET response (RPC-Get-V1-10).

### 2.3 Nested Resources

- Nested resources **MUST** have a List operation under their parent.
- Nested resources **MUST NOT** be embedded inline in the parent resource's GET response body (see Azure Resource Graph guideline ARG001 below). Return a resource ID reference instead.
- For singleton nested resources (only one instance exists), the resource name **SHOULD** be `default`. The collection GET (`/parent/{parentName}/children`) and singleton GET (`/parent/{parentName}/children/default`) must both exist.
- All child (nested) resource types — including singletons — **MUST** support both a collection GET under the parent and a point GET for a single instance (PLCY008). Without both operations, Azure Policy compliance data cannot be populated for the child resource type.

### 2.4 Resource References Between Resources

- When a resource needs to reference another resource, use a **single property containing the fully qualified ARM resource ID** of the referenced resource.
- This enables [linked access checks](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview) and is required for RBAC integration.
- Do not use separate properties for subscription, resource group, and resource name when a single resource ID suffices.

### 2.5 Top-Level ARM Properties Must Not Be Reused Inside the Properties Bag

- The ARM envelope properties `id`, `name`, `type`, and `systemData` are defined at the **top level** of a resource model and **MUST NOT** be redeclared inside the `properties` bag.
- If any of these names appear as properties inside the `properties` object, flag it as an ARM Error and instruct the author to rename the inner property to something domain-specific.
- **Example violation**: A resource whose `properties` object contains a field called `name` or `type`. These shadow the top-level ARM properties and cause confusion for clients and tooling.
- Additionally, `managedBy` is a reserved ARM envelope property and **MUST NOT** be used as a property name inside the `properties` bag.
- Timestamp properties like `creationTime` or `createdDate` **MUST NOT** be added inside the `properties` bag if they duplicate the ARM envelope `systemData.createdAt` field. Use the top-level `systemData` instead of reinventing these timestamps.

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

#### 2.6.1 Standard SKU Schema

- The `sku` top-level property **MUST** follow the standard ARM SKU schema with these sub-properties:
  - `name` (string, required) — the SKU identifier (e.g., `"Standard_LRS"`)
  - `tier` (string, recommended) — the SKU tier (e.g., `"Standard"`, `"Premium"`)
  - `size` (string, optional) — the SKU size
  - `family` (string, optional) — the SKU family
  - `capacity` (integer, optional) — scale unit count
- The SKU definition **SHOULD** reference the common-types SKU model where available.
- The internal SKU link API (used by ARM to discover regional SKU availability) **MUST NOT** be exposed in the public swagger specification.

### 2.7 Every Resource Must Have a Point GET

- Every resource type **MUST** have a corresponding point GET operation that retrieves a single instance by its resource path.
- If a List operation exists but no corresponding GET for a single instance, flag it as an ARM Error.
- **Singleton resources MUST be named "default"** (lowercase). Names like "Experimentation", "config", or any other non-"default" value for a singleton are not allowed unless explicitly approved.
- Singleton and constrained-collection resource names **MUST** be represented as an **enum path parameter** with `x-ms-enum` and `modelAsString: true` -- not as a static literal in the URI path. See [`.github/skills/azure-api-review/references/tracked-resource-lifecycle.md`](../skills/azure-api-review/references/tracked-resource-lifecycle.md) for the correct pattern (RPC-ConstrainedCollections-V1-04).
  (Also enforced by: `ReservedResourceNamesModelAsEnum` linter rule -- warning level)

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
  (Also enforced by: `PutResponseCodes` linter rule)
- PUT **MUST NOT** return `202` for async operations. The required async model for PUT is `201`/`200` with a `provisioningState` property. The `202` model for PUT is deprecated and no longer supported for new resource types.
- PUT **MUST NOT** implicitly create other tracked resources — only the resource identified in the URL may be created (RPC-Put-V1-16). Implicit creation of other tracked resources means those resources won't be hydrated in ARM.
- PUT **SHOULD NOT** implicitly create nested or other proxy resources (RPC-Put-V1-17).
- The API path for PUT **MUST** have an even number of segments (alternating type/name) (RPC-Put-V1-02).
- The PUT request and response body **MUST** use the same model (RPC-Put-V1-25). The response of PUT **MUST** match the response of GET and PATCH for the same resource (RPC-Put-V1-12).
- The PUT `200` and `201` response schemas **MUST** be identical — both must represent the same resource model. A PUT that returns a different schema for `201` (creation) vs `200` (replacement) is incorrect (RPC-Put-V1-29).
  (Also enforced by: `ConsistentResponseSchemaForPut` linter rule — staging only)

### 3.2 PUT Must Not Exhibit PATCH Semantics (WHATIF-004)

- Omitting a property from a PUT request body **MUST NOT** preserve the current value of that property. PUT is a full resource replacement, not a partial update.
- If existing API versions exhibit PATCH-like behavior on PUT (preserving omitted properties), this **MUST** be corrected in new API versions.
- **Why:** ARM Template What-If compares the PUT request body (from the template) with the GET response (current state). If PUT silently preserves omitted properties, What-If reports false differences because the template omits properties that the service secretly retains.

### 3.3 PUT Must Not Expose Secrets in Response

- The response of a PUT operation **MUST NOT** return secret values (e.g. passwords, keys, connection strings).
- If a secret is accepted on write (e.g. `administratorPassword`), the response **MUST** return `null` or omit the property entirely.
- Properties containing secrets **MUST** be annotated with `"x-ms-secret": true`.

---

## 4. PATCH Operation Rules

**Reference: [RPC — PATCH Resource](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/patch-resource.md)**

### 4.1 PATCH Body Must Not Have Required Properties (RPC-Patch-V1-10)

> **Reference:** [RPC -- PATCH Resource](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/patch-resource.md) for complete PATCH contract details.

- PATCH request body parameters **MUST NOT** have any properties marked as `required`, **MUST NOT** have `default` values, and **MUST NOT** have `x-ms-mutability` set to only `["create"]`.
  (Also enforced by: `PatchBodyParametersSchema` linter rule)
- PATCH **MUST NOT** update `id`, `name`, `type`, `location`, or `properties.provisioningState` (RPC-Patch-V1-02).
- PATCH **MUST** follow JSON Merge Patch semantics ([RFC 7396](https://tools.ietf.org/html/rfc7396)) (RPC-Patch-V1-05).

### 4.2 PATCH Response Codes (RPC-Patch-V1-06)

- Synchronous PATCH **MUST** return `200`; async PATCH **MUST** return `202` (plus `200` in swagger for SDK discovery). PATCH **MUST** return `404` if resource does not exist (RPC-Patch-V1-07).

### 4.3 Tracked Resource PATCH Must Support Tags (RPC-Patch-V1-03)

- For tracked resources, the PATCH operation **MUST** support updating `tags` at minimum.
- Ideally, all mutable properties should be patchable for a better customer experience.
- PATCH on `tags` follows **replace-all** semantics: sending `{ "tags": { "tag3": "v3" } }` to a resource with `tag1` and `tag2` replaces the entire tag set — the result has only `tag3`. Tags are not merged additively (RPC007).

### 4.3a PATCH Body Must Mirror Resource Model Layout (RPC-Patch-V1-01)

- The properties in the PATCH request body **MUST** be present in the corresponding resource model (PUT/GET response) and **MUST** follow the same nesting layout. For example, if `propertyA` is inside `properties` in the resource model, it must also appear inside `properties` in the PATCH body — not at the top level.
  (Also enforced by: `ConsistentPatchProperties` linter rule)

### 4.3b PATCH Should Support Updating Envelope Properties (RPC-Patch-V1-09, RPC-Patch-V1-11)

- If the resource model defines the `sku` top-level property and the service allows SKU changes after creation, the PATCH body **SHOULD** include `sku`. If SKU is immutable, it must be annotated with `x-ms-mutability: ["create", "read"]` (RPC-Patch-V1-09).
  (Also enforced by: `PatchSkuProperty` linter rule — warning level)
- If the resource model defines the `identity` top-level property and the service allows identity updates, the PATCH body **SHOULD** include `identity`. If identity is immutable, it must be annotated with `x-ms-mutability: ["create", "read"]` (RPC-Patch-V1-11).
  (Also enforced by: `PatchIdentityProperty` linter rule)

### 4.4 PATCH Must Not Expose Secrets in Response

- Same rule as PUT -- PATCH response **MUST NOT** return secret values (see Section 7).

### 4.5 PATCH Request Body and Query Parameters (RPC-Patch-V1-12)

- PATCH **MUST** have a request body. PATCH **MUST NOT** have query parameters other than `api-version`.

### 4.6 PATCH Does NOT Need to Be Long-Running (CRITICAL)

- **PATCH operations are NOT required to be long-running.** Do NOT flag a PATCH operation as an error or warning solely because it is synchronous (i.e., it does not use `x-ms-long-running-operation: true`).
- A PATCH MAY be long-running if the service genuinely requires it (in which case it MUST return `200` for completion and `202 Accepted` for async acceptance), but this is NOT a requirement.
- **Never recommend or mandate that a PATCH be made long-running as a blanket rule.** Only flag if the PATCH returns `202` without the required `x-ms-long-running-operation` annotation.

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
  (Also enforced by: `DeleteResponseCodes` linter rule)
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

> **Full rule definition:** See [`.github/skills/azure-api-review/references/provisioning-state.md`](../skills/azure-api-review/references/provisioning-state.md) for complete provisioningState requirements including terminal states, transition rules, invalid values, and format-specific guidance.

- A resource with async PUT or PATCH **MUST** have a `provisioningState` property (readOnly) with terminal states `Succeeded`, `Failed`, and `Canceled` (single 'l'). It represents only the latest LRO status, not resource health. POST actions do **not** affect it.
  (Also enforced by: `ProvisioningStateMustBeReadOnly` linter rule — but only checks readOnly, not terminal state completeness)
- If a user includes `provisioningState` in a PUT request body, the RP **MUST** ignore it if the value matches, or reject with `400 Bad Request` if it does not.

### 6.6 `202` Response and Polling Headers (RPC-Async-V1-07, RPC-Async-V1-06, RPC-Async-V1-14)

- A `202` response **MUST NOT** include a response body.
- A `202` response **MUST** include a `Location` header with an absolute URI pointing to a monitoring URL. The URI host **MUST** match the host in the `referer` header.
- Starting January 2025, new RP namespaces **MUST** also include the `Azure-AsyncOperation` header (RPC-Async-V1-06). Brownfield implementations are **strongly recommended** to add it.
- The `Location` and `Azure-AsyncOperation` URIs **MUST** have an even number of segments with alternating resource type and resource name pattern.
- The `Location` and `Azure-AsyncOperation` URIs **MUST NOT** be exposed via any other header, API, or command — ARM only signs these two headers.
- Include `Retry-After` header (integer, seconds) when supported. Minimum 10 seconds, maximum 10 minutes. Default client polling interval is 60 seconds if `Retry-After` is not provided.
- A `202` response with no declared headers in the swagger (empty `"202": { "description": "Accepted" }`) makes the LRO contract ambiguous for ARM and SDKs — flag it.
- All asynchronous operations **MUST** have `x-ms-long-running-operation` set to `true` in the swagger (RPC-Async-V1-15).

### 6.7 Polling Behavior and `final-state-via`

> **Full rule definition:** See [`.github/skills/azure-api-review/references/lro-final-state-via.md`](../skills/azure-api-review/references/lro-final-state-via.md) for the complete `final-state-via` decision table and anti-patterns.

- **`Location` header polling**: The polling URL returns `202` (with no body) while the operation is in progress and returns the **exact same response** as the synchronous completion when the operation finishes. For DELETE, the final response is `200` or `204`. For PATCH, the final response is `200` with the updated resource body. For POST, the final response is `200` or `204`.
- **`Azure-AsyncOperation` header polling**: The polling URL always returns `200` with a status object in the response body containing `status`, `error` (if failed/canceled), and optional `id`, `name`, `startTime`, `endTime`, `percentComplete`, `properties`. A `4xx`/`5xx` on the polling URL indicates a failure reading the *status*, not a failure of the underlying operation.
- The `Azure-AsyncOperation` status object **MUST** include `status` (Required) with terminal values `Succeeded`, `Failed`, or `Canceled`. If `status` is `Failed` or `Canceled`, `error.code` and `error.message` are **Required**.
- For PUT, PATCH, and DELETE following standard ARM patterns, do **NOT** specify `x-ms-long-running-operation-options` / `final-state-via` -- the default SDK behavior is correct. Only specify `"final-state-via": "location"` for POST LROs with a response schema.

### 6.8 Operation Results Placement

- For **new service onboardings**, operation statuses **MUST** be at subscription scope (e.g., `/subscriptions/{subscriptionId}/providers/{namespace}/locations/{location}/operationStatuses/{operationId}`). Subscription-level operation statuses provide better security through RBAC.
- If `operationResults`/`operationStatuses` are exposed under resource scope, long-running DELETE operations will cause them to become inaccessible after the parent resource is deleted, returning `404 Not Found`.
- The RP **MUST** ensure the operation result API is called in the same tenant and subscription that the operation originated in. The operation ID **MUST NOT** be the same as the correlation ID or request ID.
- Operation IDs **MUST** be globally unique for each operation instance. **DO NOT** derive operation IDs from a hash of resource properties — sequential operations on the same resource initiated close together can produce identical hashes, causing clients and ARM's template deployment engine to mix up operations. Generate a new GUID for each operation (RPC-BestPractice-08).
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
- Without this annotation, ARM Template What-If treats the property as a normal value and reports a **false create** when the template includes the secret but the GET response omits it (WHATIF-003).

### 7.3 Proactive Secret Detection (SEC-SECRET-DETECT)

> **Full rule definition:** See [`.github/skills/azure-api-review/references/secret-detection.md`](../skills/azure-api-review/references/secret-detection.md) for the complete detection signals, keyword list, and format-specific fix guidance.

- Reviewers **MUST** proactively inspect every `"type": "string"` property for secret indicators. Flag as **blocking** (`SEC-SECRET-DETECT`) if indicators suggest a secret but the annotation is missing. **Fix:** Add `"x-ms-secret": true` (OpenAPI) or `@secret` (TypeSpec).

---

## 8. Property Design Best Practices

> **These rules apply specifically to properties defined inside the `properties` bag of a resource model.** Always examine all properties critically for better design opportunities.

### 8.1 Prefer Enums Over Booleans

> **Full rule definition:** See [`.github/skills/azure-api-review/references/enum-best-practices.md`](../skills/azure-api-review/references/enum-best-practices.md) for comprehensive enum guidelines and boolean-to-enum conversion patterns.

- **YOU SHOULD** use extensible string enums instead of boolean types. Booleans do not version well. Boolean property names **SHOULD** indicate a state (`backupsEnabled`), not bare nouns (`backups`).

### 8.2 Use Objects Instead of Strings for Structured Values

- If a property value has a well-defined or structured format (e.g. a JSON blob encoded as a string, a connection string with multiple components), model it as an object, not a free-form string.
- Free-form strings prevent client-side validation and make SDK generation less useful.
- **No freeform `type: object` either** — if a property is typed as `type: object` with no additional schema properties defined (an "empty object" or "any"), flag it. Every object property **MUST** have its schema defined with explicit properties.
- **Avoid excessive nesting depth** — properties **SHOULD NOT** be nested more than 3 levels deep inside the `properties` bag. Deep nesting hinders SDK usability and makes the schema hard to navigate. Flatten where possible.
  (Also enforced by: `AvoidNestedProperties` linter rule R2001)

### 8.3 Use Enums for Finite Value Sets (ACTIVELY REVIEW)

> **Full rule definition:** See [`.github/skills/azure-api-review/references/enum-best-practices.md`](../skills/azure-api-review/references/enum-best-practices.md) for the complete enum review checklist.

- **Actively examine every `string` property** for enum candidates (e.g., "status", "mode", "tier"). If a property's description lists valid values, it **MUST** be an enum with `"x-ms-enum": { "name": "<EnumName>", "modelAsString": true }`.


### 8.3a Array Property Names Must Be Plural

- Properties that are arrays **MUST** have plural names (e.g., `scopes`, `rules`, `addresses`) -- not singular (e.g., `scope`, `rule`, `address`). Singular names suggest a single value, not a collection.
### 8.4 Use Specific Types Instead of Generic Strings (ACTIVELY REVIEW)

> **See also:** [`.github/skills/azure-api-review/references/naming-conventions.md`](../skills/azure-api-review/references/naming-conventions.md) for common property names (e.g., `createdAt`, `lastModifiedAt`, `deletedAt`) and resource identifier naming rules (use `Id` suffix, not `Uri` or `Name`).

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

> **Full rule definition:** See [`.github/skills/azure-api-review/references/property-mutability.md`](../skills/azure-api-review/references/property-mutability.md) for OAPI027, OAPI020, OAPI029 with format-specific examples and mutability guidelines.

- Create-only properties **MUST** use `x-ms-mutability: ["create", "read"]`. Response-only properties **MUST** use `"readOnly": true` or `x-ms-mutability: ["read"]`. Fully mutable properties do not need annotation.
- Every server-computed property **MUST** be annotated `readOnly` (WHATIF-001). Without this annotation, ARM Template What-If interprets the property as client-owned and reports a **false delete** when the template omits it.

> **Full What-If noise taxonomy:** See [`.github/skills/azure-api-review/references/what-if-preflight-compliance.md`](../skills/azure-api-review/references/what-if-preflight-compliance.md) for WHATIF-001 through WHATIF-005.

### 8.7 Avoid Writable Circular Dependencies

- If resource A references resource B, and resource B's GET response includes a back-reference to resource A, mark **one** of the references as `readOnly`.
- Writable circular references prevent ARM from determining dependency ordering in deployment templates.

### 8.8 Deprecated Properties

- Properties that are deprecated **SHOULD** use the OpenAPI `"deprecated": true` keyword in addition to documenting "Deprecated" in the description.
- Using only a description mention of deprecation may be missed by tooling; the `deprecated` keyword enables SDK generators and linters to produce proper deprecation warnings.

### 8.9 `provisioningState` Correctness

> See Section 6.5 above and [`.github/skills/azure-api-review/references/provisioning-state.md`](../skills/azure-api-review/references/provisioning-state.md) for complete provisioningState requirements.

- `provisioningState` **MUST** include terminal states `Succeeded`, `Failed`, `Canceled` (single 'l'). Operational states (`Stopped`, `Running`) and values like `Deleted`, `NotSpecified` are invalid -- use a separate property for runtime state.

### 8.10 `x-ms-nullable`

- If a property can legitimately return `null` in a response, it **MUST** be annotated with `"x-ms-nullable": true`.
- Do not rely on the absence of `"required"` to imply nullability — be explicit.

### 8.11 Write-Only Properties Are Forbidden (OAPI027)

> **Full rule definition:** See [`.github/skills/azure-api-review/references/property-mutability.md`](../skills/azure-api-review/references/property-mutability.md) for OAPI027, OAPI020, and OAPI029 with format-specific examples.

- Properties **MUST NOT** be write-only (no `"read"` in mutability). Exception: secrets with `"x-ms-secret": true`.

### 8.12 No Conditional Read-Only or Conditional Immutable Properties (OAPI020, OAPI029)

> **Full rule definition:** See [`.github/skills/azure-api-review/references/property-mutability.md`](../skills/azure-api-review/references/property-mutability.md) for OAPI020 and OAPI029 with format-specific examples.

- `readOnly` and immutable properties **MUST** always retain that status. Use separate properties for conditionally mutable cases.

### 8.13 Avoid CSV-Encoded Values in Properties (PLCY004)

> Rules PLCY004 and OAPI025 are defined in `openapi-review.instructions.md` and [`.github/skills/azure-api-review/references/policy-compatibility.md`](../skills/azure-api-review/references/policy-compatibility.md). They apply to all specs including ARM. Do not use CSV strings for collections (use JSON arrays) and do not accept mixed data types for the same property.

### 8.15 Default Values Must Be Static and Declared (OAPI022, WHATIF-002)

- Properties with `default` values **MUST** use the same default value on every similar PUT request. Do not derive the default value from other properties in the resource or from external state.
- The `default` annotation in the swagger **MUST** specify the actual default value so that clients, documentation, and policy can discover it.
- Every **optional** property where the service applies a default value when the property is omitted from PUT **MUST** declare that default value in the swagger spec. Without the annotation, ARM Template What-If reports a false delete for the property (the template omits it, but GET returns the service-applied default).

### 8.16 Service Must Preserve Array Ordering (OAPI024)

> **Full rule definition:** See [`.github/skills/azure-api-review/references/field-ownership.md`](../skills/azure-api-review/references/field-ownership.md) for OAPI024, OAPI025, and OAPI026 with examples.

- The order of items in array properties from a PUT or PATCH request **MUST** be preserved in responses. Reordering breaks ARM Template What-If and Change Analysis.

### 8.17 Service Must Preserve Property Value Casing (OAPI026)

> **Full rule definition:** See [`.github/skills/azure-api-review/references/field-ownership.md`](../skills/azure-api-review/references/field-ownership.md) for OAPI026 with normalization examples.

- String property values from PUT/PATCH requests **MUST** match in responses. Do not normalize casing, location formats, or IP address representations.

### 8.18 Service Must Reject Unknown Properties (OAPI018)

> **See also:** [`.github/skills/azure-api-review/references/what-if-preflight-compliance.md`](../skills/azure-api-review/references/what-if-preflight-compliance.md) WHATIF-005 for the What-If implications of this rule.

- If a PUT or PATCH payload contains properties that the RP does not recognize, the service **MUST** reject the request with `400 Bad Request` and an appropriate ARM error response body.
- Do not silently discard unknown properties — the user must be informed that their payload is incorrect. Silent discarding causes the GET response to differ from the PUT request, leading to What-If noise and customer confusion.

### 8.19 PUT/PATCH Must Tolerate Read-Only Properties (OAPI021)

- PUT and PATCH operations **MUST NOT** fail when the request body includes read-only properties with their current values.
- Automation tools (CLI, Terraform, Bicep) commonly GET a resource, modify a few properties, and PUT the entire payload back. If the service rejects the request because it contains read-only properties (e.g., `provisioningState`, `id`), these tools break.
- **Fix:** Ignore read-only properties in the request body silently, or if the value differs from the current value, reject with a descriptive `400 Bad Request` error.

### 8.20 Immutable Property Tolerance and Enforcement (OAPI030, OAPI031)

> **Full rule definition:** See [`.github/skills/azure-api-review/references/property-mutability.md`](../skills/azure-api-review/references/property-mutability.md) for OAPI030 and OAPI031.

- If a PUT or PATCH request includes an immutable property with the **same value** it already has, the service **MUST NOT** fail the request (OAPI030). This allows tools to round-trip payloads without stripping immutable fields.
- If a PUT or PATCH request attempts to **change** an immutable property, the service **MUST** reject with `400 Bad Request` and an error message identifying the property (OAPI031). Do not silently ignore the change.

### 8.21 Fields Must Have Clear Ownership — Server or Client (OAPI034)

> **Full rule definition:** See [`.github/skills/azure-api-review/references/property-mutability.md`](../skills/azure-api-review/references/property-mutability.md) for OAPI034. See [`.github/skills/azure-api-review/references/field-ownership.md`](../skills/azure-api-review/references/field-ownership.md) for value preservation rules OAPI024, OAPI025, and OAPI026.

- Every property **MUST** have a clear owner: either the **server** (read-only, computed) or the **client** (set by user, preserved by server).
- A property **MUST NOT** be writable by the client yet silently overwritten or auto-updated by the server. This anti-pattern causes the GET response to diverge from the last PUT, generating noise in What-If, Terraform drift detection, and Change Analysis.
- **Fix:** Use separate properties for client-specified and server-computed values (e.g., `requestedVersion` + `currentVersion` instead of a single `version` that the server auto-bumps).

---

## 9. Inline Properties vs. Nested Resources (Design Choice)

### 9.1 When to Use Inline Properties

- The property set is an intrinsic part of the resource's state.
- The properties must be operated on together with other properties of the resource.
- The property set is small and not expected to grow significantly.
- The elements of the collection have ordering requirements that require the entire array to be operated on atomically (e.g., reordering elements, removing one element and adjusting the order of the rest in a single operation).

### 9.2 When to Use Nested Resources Instead

- The property set is complex enough to warrant its own lifecycle (separate CRUD operations).
- The properties have RBAC or routing requirements separate from the parent resource.
- The collection could grow large (arrays with unbounded or very large element counts **MUST** be modeled as nested resources, not inline arrays). **Warning**: Large inline arrays can cause the resource representation to exceed ARM's maximum payload size limits.
- Each element needs its own ARM resource ID.

### 9.3 Never Model Both

- A collection **MUST NOT** be modeled as **both** an inline array property **and** a nested resource type. This causes:
  - Customer confusion from duplicate representations
  - Inconsistencies if both representations are not kept in sync
  - Complications with Azure Resource Graph integration

### 9.4 Private Endpoint Connection Requirements

- Do not document **internal** private link contracts (e.g. private endpoint connections between internal services) as **external** ARM APIs.
- Private endpoint connection definitions **MUST** either come from ARM common types or be defined in a dedicated file (e.g. `privateEndpointConnections.json`). Do not define them inline in the main resource file.
- Resources with private endpoint support **MUST** define three nested resource types:
  - `privateEndpointConnectionProxies` (async PUT/DELETE)
  - `privateEndpointConnections` (async PUT/DELETE)
  - `privateLinkResources` (GET only)
- The parent resource **MUST** include a `publicNetworkAccess` property (enum: `Enabled` / `Disabled`) and a `privateEndpointConnections` array property in its model.
- Private endpoint connection types **MUST** come from ARM common types (`common-types/resource-management/vX/privatelinks.json`).

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

> **Full rule definition:** See [`.github/skills/azure-api-review/references/suppression-review-criteria.md`](../skills/azure-api-review/references/suppression-review-criteria.md) for the complete suppression approval/rejection decision framework, including when to approve, when to push back, and when to escalate to peer review.

> **Full rule definition:** See [`.github/skills/azure-api-review/references/suppression-review-criteria.md`](../skills/azure-api-review/references/suppression-review-criteria.md) for the complete suppression approval/rejection decision framework, GA vs. preview rigor (RPC-SUPPRESS-GA), scoping rules (RPC-SUPPRESS-SCOPE), and when suppressions are never valid.

Apply the decision framework from the reference file when evaluating suppressions. Key points: suppressions from preview are not automatically acceptable in GA; suppressions must have specific `from`/`where` clauses (not blanket); warnings should not be suppressed; lack of time is never valid.

### 10A.3 Operations API Must Be in Package Tag (RPC-Operations-V1-TAG)

- For ARM RPs, the `operations.json` (or equivalent operations API spec) **MUST** be included in every published package tag's input-file list.
- If a new tag only includes the service resource swagger but omits the operations API, flag it — the resulting SDK will be missing the operations endpoint.

### 10A.4 `suppressions.yaml` Format (2024+)

- Starting in 2024, suppressions can also be specified in a YAML file at `specification/<service>/suppressions.yaml` (in addition to `readme.md` directives). Entries use `tool`/`path`/`reason` format.
- The `path` field **MUST** use narrow, version-scoped globs (e.g., `stable/2025-01-01/**`) -- not broad patterns like `data-plane/**`.
- Apply the same approval criteria from `suppression-review-criteria.md` for `suppressions.yaml` entries.

---

## 11. API Version Practices (ARM-Specific)

**Reference: [RPC — API Versioning](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/resource-api-reference.md)**

### 11.1 Uniform Versioning Within a Service

- An RP has one namespace shared by the one or more Services that make up the RP. It is **strongly recommended** that an RP consist of a single Service (RPC-BestPractice-14).
- All resource types within a single Service under an RP namespace **MUST** version uniformly — they share the same `api-version` value. This version becomes the Service's version when it is ultimately deployed in **all** supported regions.
- A change to any resource type in the service (adding a new request/response property or a new operation) requires a new api-version for the entire service.
- A single package tag in `readme.md` **MUST NOT** mix swagger files from different API versions. For example, including both `stable/2024-10-01/foo.json` and `preview/2025-06-01-preview/bar.json` in the same tag violates uniform versioning.

### 11.2 Incremental Version Progression

- Copy the entire API surface when creating a new version. New preview versions should include all existing GA functionality plus new changes.
- When promoting from preview to GA, the GA version **MUST** have a later date than the preview version.
- The `default` API version tag in `readme.md` **MUST** point to the latest **stable** version. Do not change the default tag from a stable version to a preview version — the default tag is what SDK consumers get by default and must be a GA release.

### 11.3 API Version Parity Across Clouds (RPC-BestPractice-15)

- For each API version, the service **SHOULD** expose the same functionality across every cloud where it is available (e.g., Public, Mooncake, Fairfax). An API version in one cloud should not correspond to different functionality than the same API version in another cloud.
- If a resource type is available in multiple clouds, the latest stable (non-preview) API version **SHOULD** be available in each cloud.

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

### 12.3 POST to Retrieve Data (Exception)

- POST may be used to retrieve data (instead of GET) **only** when:
  - **Retrieving a secret value** -- use a `list*` prefixed POST action for ARM template compatibility.
  - **The P99 latency of the equivalent GET would exceed 2 seconds** -- model it as an async POST. Verify that the data cannot be cached at creation time.
- In all other cases, steer authors toward **OData filters on the corresponding resource collection GET** rather than POST.
- POST actions used for data retrieval **MUST NOT** have `$filter`, `$top`, or other query parameters -- all parameters belong in the request body (RPC-POST-V1-05).
  (Also enforced by: `ParametersInPost` linter rule)
- **POST pagination**: SDKs do not natively support POST-based pagination. If a POST returns paginated results, the client must re-POST with the same filter body and the `nextLink` for each page. This must be documented. Prefer GET with OData filters to avoid this limitation.

### 12.4 Version or Catalog Listings as Proxy Resources (RPC-LIST-VERSIONS)

- When a service needs to expose a list of available versions, SKUs, offerings, or other catalog-like data, model them as **proxy resource GET collections** — not as custom action endpoints or ad-hoc GET operations.
- The pattern is: `GET .../providers/Microsoft.{Namespace}/locations/{location}/{catalogResourceType}` returning a paginated list of proxy resources.
- Each item in the list **MUST** be modeled as a proper ARM proxy resource (with `id`, `name`, `type`, and `properties`).
- **DO NOT** model version/catalog listings as non-resource GET endpoints that return bare arrays or non-ARM-shaped responses — these cannot be tracked by ARM, are not compatible with RBAC, and the AKS-style `orchestrators` pattern is discouraged for new services.

---

## 12A. Tenant-Level APIs (RPC-Uri-V1-11)

When a PR introduces APIs at the tenant or provider level (outside subscription scope), apply extra scrutiny:

- **Evaluate scope**: Can the requirements be met by modeling the API at subscription or resource group scope instead? Tenant-level APIs should be the exception, not the default.
- **Check for unauthorized actions**: If the service intends to bypass standard RBAC by adding `allowUnauthorizedActions` in the ARM manifest, this has security implications and requires approval from the PAS team (Security RBAC).
- The linter rule `TenantLevelAPIsNotAllowed` fires on such PRs. The suppression requires:
  - (A) ARM API review office hours sign-off, **AND**
  - (B) Either acknowledgment that no unauthorized actions are involved, or PAS team approval for the unauthorized actions.
  (Also enforced by: `TenantLevelAPIsNotAllowed` linter rule)

---

## 13. List API Contract

### 13.1 List API Must Follow ARM Contract

- List operations **MUST** return a list wrapper object with a `value` array property and an optional `nextLink` property.
- The `value` array **MUST** contain the resource objects directly — do not wrap resources in additional envelopes.
- List operations **MUST** be marked with `"x-ms-pageable"` with `"nextLinkName": "nextLink"` (or `null` if the list is never paginated).
- The `nextLink` property **MUST** use `"format": "uri"` in its schema definition — do not set it to `null` as a value; use `x-ms-pageable` with `nextLinkName: null` if pagination is not supported.
- If a list operation violates this contract (e.g. wraps in an extra object, uses a different field name, doesn't include `x-ms-pageable`), flag it as an ARM Error.

---

## 14. Azure Policy Compatibility

> **Full rule definition:** See [`.github/skills/azure-api-review/references/policy-compatibility.md`](../skills/azure-api-review/references/policy-compatibility.md) for all rules PLCY001–PLCY009 with examples and fix guidance.

When reviewing ARM resources, verify that properties are designed for Policy auditability (PLCY001), minimize read-only post-creation properties (PLCY003), avoid free-form objects (PLCY005), accept compliance-relevant properties in PUT (PLCY006), provide collection GETs at subscription and resource group level (PLCY007/PLCY008), and do not rely on POST actions for configurations that need Policy enforcement (PLCY009). See the reference file for details on each rule.

---

## 15. ARM Template Deployment Compatibility

> **Full rule definition:** See [`.github/skills/azure-api-review/references/template-deployment.md`](../skills/azure-api-review/references/template-deployment.md) for rules TD001–TD003. See [`.github/skills/azure-api-review/references/what-if-preflight-compliance.md`](../skills/azure-api-review/references/what-if-preflight-compliance.md) for WHATIF-001–005 and PREFLIGHT-001–005.

When reviewing ARM resources, verify: resources are created via PUT for template engine compatibility (TD001), PUT is idempotent for re-deployments (TD002), the RP supports the Preflight API (TD003), preflight returns `200 OK` even for validation errors (PREFLIGHT-001/002), preflight accepts Template Language Expressions without validation (PREFLIGHT-003), preflight does not perform existence checks (PREFLIGHT-004), and the spec supports ARM static validations -- resource name constraints, immutable `location`/`plan`/`identity`, zone support (PREFLIGHT-005). See the reference files for full details.

---

## 16. Resource Move Requirements (RPC003)

- All **top-level tracked resource types** **MUST** support resource move — the ability to move a resource across resource groups or across subscriptions within the same AAD tenant.
- Child resources move with the parent automatically.
- Move does not change the resource's physical location or region.
- If a resource type **cannot** support move, it must be explicitly blocked with documented technical justification. Blocking move without justification is a poor customer experience.
- Resource types that support move **MUST** handle the ARM move callback and update internal state (e.g., resource group references in stored data).

---

## 17. Availability Zones

> **Full rule definition:** See [`.github/skills/azure-api-review/references/availability-zones.md`](../skills/azure-api-review/references/availability-zones.md) for the full zones property contract including placement, immutability, zone semantics, discoverability, and format-specific code examples.

When reviewing resources that support availability zones, verify: `zones` is a top-level `array` of `string` (not inside `properties`), it is annotated as immutable (`x-ms-mutability: ["create", "read"]`), and zone information is discoverable via the provider metadata API. See the reference file for zone semantics (zonal vs. zone-redundant), empty array behavior, and nested resource rules.

---

## 18. Extended Locations

### 18.1 Extended Location Property

- Resources that support extended locations (e.g., Edge Zones) **MUST** use the `extendedLocation` top-level property (not inside `properties`).
- The property is an object with two required fields:
  - `type` — the extended location type (currently only `"EdgeZone"` is supported)
  - `name` — the extended location name (max 128 characters; forbidden characters: `<>%&:\?/` and control characters)

### 18.2 Extended Location Immutability

- `extendedLocation` **MUST NOT** be added to an existing resource after creation.
- `extendedLocation` **MUST NOT** be removed from a resource after creation.
- Once set, `extendedLocation` **MUST** be included on all subsequent PUT requests to the resource.

---

## 19. ETag and Concurrency Control

### 19.1 Supported Concurrency Headers

- ARM supports the `If-Match` header for write and delete concurrency control.
- `If-None-Match` and wildcard values (`*`) are **NOT** supported.
- Read concurrency (conditional GET) is not supported.

### 19.2 ETag in Responses

- Every successful CRUD operation **SHOULD** return an `ETag` header in the response.
- Clients may use the returned ETag in subsequent `If-Match` headers for optimistic concurrency.

### 19.3 If-Match Behavior

| Header Value         | Behavior                                                     |
| -------------------- | ------------------------------------------------------------ |
| Absent / empty       | Allow the operation (no concurrency check)                   |
| `If-Match: "xyz"`    | Check resource exists and ETag matches; `412` if mismatch    |

---

## 20. systemData Requirements

### 20.1 systemData Property

- `systemData` is a **required top-level property** on all tracked resources for new API versions. It contains `createdBy`, `createdByType`, `createdAt`, `lastModifiedBy`, `lastModifiedByType`, `lastModifiedAt`.
- All `systemData` properties **MUST** be `readOnly`.
- `systemData` **MUST** be referenced from ARM common types (`common-types/resource-management/vX/types.json`). Do not define a custom `systemData` model.
- `systemData` **MUST NOT** be placed inside the `properties` bag — it is a top-level ARM envelope property.
- `*ByType` values (`User`, `Application`, `ManagedIdentity`, `Key`) **MUST** be stored as strings (not enums) to support future identity types without breaking changes.

### 20.2 systemData Lifecycle Rules

- **DO NOT** add `systemData` to an existing (current) API version — this is a breaking change. Add it with a new API version only.
- **DO NOT** update `systemData` when child resources change — only update for changes to the resource itself.
- **DO NOT** update `systemData` on synchronously rejected requests (e.g., `400 Bad Request`).
- For long-running operations, `systemData` **MUST** reflect the values from when the operation was **triggered**, not when it completed. Keep trigger-time values even if the async operation fails or is canceled.
- Internal admin operations **MUST NOT** update `systemData` unless user-modifiable control-plane properties change.

---

## 21. Check Name Availability

### 21.1 API Pattern

- Resource providers **SHOULD** implement a check name availability API:
  - **Global uniqueness:** `POST /subscriptions/{id}/providers/{namespace}/checkNameAvailability`
  - **Local uniqueness:** `POST /subscriptions/{id}/providers/{namespace}/locations/{location}/checkNameAvailability`
- Check name availability **does NOT reserve** names. Concurrent operations can create a resource with the same name between the check and the PUT.

### 21.2 Request and Response Contract (CNA-002)

- The request body **MUST** include:
  - `name` (string) — the proposed resource name
  - `type` (string) — the fully qualified resource type (e.g., `Microsoft.Storage/storageAccounts`)
- The response body **MUST** include:
  - `nameAvailable` (boolean) — whether the name is available
  - `reason` (enum: `AlreadyExists` | `Invalid`) — why the name is unavailable
  - `message` (string) — a human-readable explanation
- Do not use checkNameAvailability as a gate — implement retry logic in resource creation.

---

## 22. managedBy Property

### 22.1 Purpose and Format

- `managedBy` is a **top-level** ARM envelope property containing a fully qualified ARM resource ID or a regional shorthand. It indicates that another resource manages this resource's lifecycle.
- `managedByExtended` is an array variant for multiple managing resources.
- Both `managedBy` and `managedByExtended` are **immutable** — once set during creation, they cannot be changed.

### 22.2 Impact on Platform Behavior

- Resources with `managedBy` set are **skipped during complete-mode deployment deletions** (ARM does not delete managed resources).
- During resource group or bulk deletion, the managing resource is deleted first, then the managed resource.
- `managedBy` **MUST NOT** be used as a property name inside the `properties` bag — it is reserved for the ARM envelope.

---

## 23. API Deprecation Policy

### 23.1 GA API Retirement

- GA APIs require a minimum of **36 months notice** before retirement.
- The deprecation notice period begins when customers are formally notified (not when the decision is made internally).

### 23.2 Preview API Lifecycle

- Preview APIs **MUST NOT** remain in preview for more than **12 months** — they must be promoted to GA or retired.
- Preview API retirement requires a minimum of **90 days notice** to customers.

### 23.3 Deprecation in Swagger

- Deprecated API versions, operations, or properties **MUST** be marked with the OpenAPI `"deprecated": true` keyword.
- Update REST API documentation, SDK packages, CLI, and PowerShell with deprecation messages and migration guidance.
- **Impact on Azure Policy:** Removing properties or API versions breaks existing Azure Policy alias references. Always coordinate with the Azure Policy team before deprecation.

---

## 24. Async Operation Signing and Validation

### 24.1 Protected Async Operation Polling

- Resource types that expose async operations **SHOULD** enable `ProtectedAsyncOperationPolling` in the RP manifest. This ensures ARM validates the caller's identity on polling URIs, preventing low-privileged users from accessing operation results they did not initiate.

### 24.2 Reserved Query Parameters

- The query parameters `t`, `c`, `s`, and `h` are **reserved** by ARM for async operation URI signing. RPs **MUST NOT** use these parameter names in their `Location` or `Azure-AsyncOperation` polling URIs.

### 24.3 Polling URI Length

- Polling URIs (with ARM signing parameters) can reach 3–4 KB in length. RPs and SDKs **MUST** support URIs up to at least **4 KB**. Do not add unnecessary data to polling URIs that increases their length.

---

## 25. Usages API Contract

### 25.1 Endpoints

- **Resource-level usage:** `GET {resource-identifier}/usages?api-version={version}`
- **Location-level usage:** `GET /subscriptions/{id}/providers/{namespace}/locations/{location}/usages?api-version={version}`

### 25.2 Response Structure

- Response **MUST** be a paged JSON object with a `value` array. Each item **MUST** include:
  - `unit` (required): `Count`, `Bytes`, `Seconds`, `Percent`, `CountPerSecond`, or `BytesPerSecond`
  - `limit` (required): Maximum permitted value (`-1` if no limit)
  - `currentValue` (required): Current usage value
  - `id` (required): Fully qualified ARM resource ID
  - `name` (required): `LocalizableString` with `value` and `localizedValue`

### 25.3 Filter Syntax

- The `$filter` query parameter supports only `name eq <value>` clauses separated by `or`. No other filter syntax is supported.

---

## 26. Schema Evolution Between API Versions

### 26.0 Published API Versions Are Immutable

- Once an API version is published (merged to `main` in either the public or private spec repo), its schema is **immutable**. No changes -- not even adding an optional property -- are allowed to that version.
- Any modification to a published API version requires creating a **new api-version** (with a later date). This applies to both GA and preview versions.
- If a PR modifies a swagger file under a version folder that was already merged to `main`, verify that the PR also introduces a new api-version folder. If it only modifies the existing version, flag it.

### 26.1 Allowed Schema Changes

Between API versions, the following changes are **allowed**:

- Adding **optional** properties.
- Removing **optional** properties (but see ARG003 — carry forward properties until usage is fully deprecated).
- Renaming properties (keep both old and new names for backward compatibility during a transition period).

### 26.2 Forbidden Schema Changes

The following changes are **forbidden**:

- **Changing the type** of an existing property (e.g., `string` → `object`). If the type must change, introduce a **new property name** and deprecate the old one.
- Adding a **required** property to an existing model (breaks clients sending the old schema).
- Removing a **required** property from an existing model.
- Changing a property from **optional to required** or vice versa.

### 26.3 DELETE Must Never Fail for API Version Mismatch

- The DELETE operation **MUST NOT** fail because a resource was created with a different API version than the one used for deletion. A user must be able to delete any resource regardless of which API version created it.

---

## ARM Review Checklist Summary

When reviewing ARM resource-manager swagger files, verify:

### Resource Structure & Paths
- ✅ Tracked resource paths include `/subscriptions/` and `/resourceGroups/` segments; even-segmented paths (RPC-Put-V1-01, RPC-Put-V1-02)
- ✅ Tracked resources not nested beyond third level (RPC-Put-V1-19)
- ✅ Resource type names are camelCase, plural, and specific (not generic)
- ✅ ARM `type/{instance}/type/{instance}` URL pattern followed
- ✅ Proxy resources use `ProxyResource` base type (not `Resource`); proxy resources do NOT have `tags`
- ✅ Extension resources use the correct scope pattern; extension resources are always proxy (never tracked) (RPC-Uri-V1-12)
- ✅ No duplicate paths when using `{scope}` parameter — no explicitly-scoped duplicates (RPC-Uri-V1-10)
- ✅ Operations API endpoint exists using common-types `OperationListResult` and `Operation` definitions (RPC-Operations-V1)
- ✅ Operations API is tenant-scoped only — not per-subscription (RPC-Operations-V1-02)
- ✅ Operations API includes ALL operations across all API versions; no operations removed when versioning

### Resource Model
- ✅ Top-level ARM property names (`id`, `name`, `type`, `systemData`) NOT reused inside `properties` bag (RPC-Put-V1-09)
- ✅ `zones`, `sku`, `kind`, `plan`, `identity`, `tags` are top-level properties (not inside `properties`)
- ✅ `sku` follows standard schema (`name`, `tier`, `size`, `family`, `capacity`); internal SKU link API not in public swagger
- ✅ Non-ARM-envelope properties are inside the `properties` bag
- ✅ `Operation`, `ErrorResponse`, `CloudError`, `PrivateEndpointConnection` use common-types definitions
- ✅ Every resource type has a point GET; singleton resources named "default" using enum path parameters (RPC-ConstrainedCollections-V1-04)
- ✅ `x-ms-azure-resource: true` only on top-level resource models, not nested models
- ✅ PUT request and response schemas are identical; PUT response matches GET and PATCH (RPC-Put-V1-12, RPC-Put-V1-25)
- ✅ PUT 200 and 201 response schemas are identical (RPC-Put-V1-29)
- ✅ PUT returns `201` (create) or `200` (replace) — never `202` for async PUT (RPC-Put-V1-11)
- ✅ PUT does not implicitly create other tracked resources (RPC-Put-V1-16)
- ✅ Tracked resources have all required operations (GET, PUT, PATCH, DELETE, ListByRG, ListBySub)
- ✅ GET operations return only `200` and are not LROs (RPC-Get-V1-01, RPC-Get-V1-14)
- ✅ Point GET has no query params other than `api-version` (RPC-Get-V1-08)
- ✅ Collection GET has only `value` and `nextLink` at top level with `x-ms-pageable`; `nextLink` has `format: uri` (RPC-Get-V1-09, RPC-Get-V1-13)
- ✅ Collection GET has no query parameters other than `api-version` and OData `$filter` (RPC-Get-V1-15)
- ✅ `provisioningState` includes `Succeeded`, `Failed`, `Canceled` (single 'l') terminal states; no operational states like `Stopped` (RPC-Async-V1-02, RPC-Async-V1-03)

### PATCH Operations
- ✅ PATCH body has no required properties, no defaults, no create-only mutability (RPC-Patch-V1-10)
- ✅ PATCH does not update `id`, `name`, `type`, `location`, or `provisioningState` (RPC-Patch-V1-02)
- ✅ PATCH follows JSON Merge Patch (RFC 7396) semantics (RPC-Patch-V1-05)
- ✅ PATCH for tracked resources supports at least tag updates (RPC-Patch-V1-03)
- ✅ PATCH body properties match resource model layout (RPC-Patch-V1-01)
- ✅ PATCH includes `sku` and `identity` if resource supports updating them; otherwise marked immutable (RPC-Patch-V1-09, RPC-Patch-V1-11)
- ✅ **PATCH is NOT required to be long-running** — do NOT flag synchronous PATCH as a violation
- ✅ No non-`api-version` query parameters on PATCH

### DELETE Operations
- ✅ Sync DELETE defines `200` + `204`; async DELETE defines `202` + `204`; DELETE body is empty (RPC-Delete-V1-01, RPC-Delete-V1-04)
- ✅ No request body on DELETE
- ✅ No non-`api-version` query parameters on DELETE

### Security & Secrets
- ✅ No secrets in GET/PUT/PATCH responses; secrets annotated with `x-ms-secret: true`
- ✅ Missing `x-ms-secret` causes What-If false creates — annotation required on all secret properties (WHATIF-003)
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
- ✅ Operation IDs are globally unique GUIDs — not derived from hashes of resource properties (RPC-BestPractice-08)
- ✅ `final-state-via` NOT specified on PUT/PATCH/DELETE following standard ARM patterns; only on POST LROs with response schema

### Property Design (Properties Bag Review)
- ✅ All server-computed properties marked `readOnly` — missing annotation causes What-If false deletes (WHATIF-001)
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
- ✅ No write-only properties (`x-ms-mutability: ["create", "update"]` without `"read"`) except for secrets (OAPI027)
- ✅ No conditional read-only or conditional immutable properties — consistency required (OAPI020, OAPI029)
- ✅ No CSV-encoded strings representing collections — use JSON arrays (PLCY004)
- ✅ Properties do not accept multiple data types; data types preserved in responses (OAPI025)
- ✅ Default values are static constants, not derived from other properties (OAPI022)
- ✅ PUT/PATCH tolerates read-only properties with unchanged values (OAPI021)
- ✅ Immutable properties: unchanged values accepted, changed values rejected with 400 (OAPI030, OAPI031)
- ✅ Fields have clear ownership — server-owned (readOnly) or client-owned (preserved exactly); no server auto-updates of client fields (OAPI034)
- ✅ Array ordering preserved in PUT/PATCH responses (OAPI024)
- ✅ Property value casing and formatting preserved — no normalization (OAPI026)

### List APIs
- ✅ List APIs return `{ value: [...], nextLink }` wrapper; `nextLink` has `format: uri`; marked with `x-ms-pageable`

### POST Actions
- ✅ POST actions have action name in URL, params in body, correct response codes (RPC-POST-V1-01, RPC-POST-V1-05)
- ✅ POST actions used only for non-CRUD operations
- ✅ POST for data retrieval only when retrieving secrets or P99 latency > 2s; prefer OData filters on GET
- ✅ Version/catalog listings modeled as proxy resource collections, not ad-hoc endpoints (RPC-LIST-VERSIONS)

### Tenant-Level APIs
- ✅ Tenant-level APIs evaluated for whether subscription/RG scope would suffice (RPC-Uri-V1-11)
- ✅ Unauthorized actions require PAS team approval

### ARG Compatibility
- ✅ No embedded child resources or child counts in parent GET response (ARG001)
- ✅ No customer data in control plane properties (ARG002)
- ✅ Properties not removed between API versions; all prior-version types carried forward (ARG003)

### Nested & Inline Resources
- ✅ Nested resources (including singletons) have both collection GET and point GET (PLCY008)
- ✅ Private endpoint connections: three nested types defined; `publicNetworkAccess` property on parent; common-types used
- ✅ Collections not modeled as both inline array and nested resource
- ✅ Inline arrays not used for unbounded/very large collections; large arrays risk exceeding ARM payload size limits

### Azure Policy Compatibility
- ✅ Properties designed for Policy auditability — composite values broken into individual fields (PLCY001)
- ✅ Minimal read-only properties that only appear post-creation; prefer values settable on PUT (PLCY003)
- ✅ No free-form `type: object` with dynamic keys for service-owned properties (PLCY005)
- ✅ PUT accepts all compliance-relevant properties; not implemented as partial update (PLCY006)
- ✅ Collection GETs at subscription + RG level for tracked resources (PLCY007)
- ✅ Policy-enforced configurations modeled in PUT/GET, not as POST actions (PLCY009)

### Template Deployment & What-If Compatibility
- ✅ Resources created via PUT (not POST) for template engine compatibility (TD001)
- ✅ PUT is idempotent; re-PUT with same body does not fail (TD002)
- ✅ PUT is a full replacement — omitting a property does not preserve current value; no PATCH semantics on PUT (WHATIF-004)
- ✅ Preflight API supported; returns `200 OK` even for validation errors; errors include `code`, `message`, `target` (TD003, PREFLIGHT-001/002)
- ✅ Preflight accepts Template Language Expressions (TLEs) without validation (PREFLIGHT-003)
- ✅ Preflight does not perform existence checks on referenced resource IDs (PREFLIGHT-004)
- ✅ Spec supports ARM static validations: resource name constraints, immutable `location`/`plan`/`identity`, zone support declared (PREFLIGHT-005)
- ✅ Every optional property with a service-applied default declares `"default"` in the spec (WHATIF-002)

### Resource Move & Lifecycle
- ✅ Top-level tracked resources support resource move across RG/subscription (RPC003)
- ✅ `managedBy` / `managedByExtended` are immutable top-level properties; not inside `properties` bag
- ✅ `systemData` is readOnly, added only with new API versions; `*ByType` stored as string not enum
- ✅ `systemData` referenced from common-types; no custom systemData model defined
- ✅ `systemData` not updated for child resource changes, rejected requests, or internal admin operations

### Availability Zones & Extended Locations
- ✅ `zones` property is top-level `array` of `string`; annotated `x-ms-mutability: ["create", "read"]`; immutable after creation
- ✅ `extendedLocation` property is top-level, immutable after creation; must be included on all subsequent PUTs

### API Versioning & Deprecation
- ✅ Uniform API versioning across all resource types in the service; no mixed versions in a single package tag
- ✅ API version parity across clouds — same functionality per API version in Public, Mooncake, Fairfax (RPC-BestPractice-15)
- ✅ GA APIs: 36 months notice before retirement; Preview: 12 months max lifespan, 90 days notice
- ✅ Deprecated versions/operations/properties marked with `"deprecated": true`; Azure Policy team consulted

### Schema Evolution
- ✅ Published API versions are immutable — no changes (even optional properties) without a new api-version
- ✅ No type changes on existing properties between API versions (introduce new property name + deprecate old)
- ✅ No required properties added to or removed from existing models between API versions
- ✅ DELETE never fails due to API version mismatch with creation version

### Long-Running Operation Security
- ✅ Polling URIs do not use reserved query params `t`, `c`, `s`, `h`
- ✅ Polling URIs supported up to 4 KB length

### Versioning & Suppressions
- ✅ Suppressions in `readme.md` are under the correct package tag with specific `from`/`where` clauses (RPC-SUPPRESS-SCOPE)
- ✅ Suppressions for GA versions justified individually — preview back-compat is not sufficient (RPC-SUPPRESS-GA)
- ✅ Suppressions evaluated per decision framework: approve only for false alarms or pre-existing violations; push to fix for new resources
- ✅ `suppressions.yaml` entries use narrow, version-scoped globs and clear justifications (same criteria as readme.md)
- ✅ Every package tag includes the operations API spec (RPC-Operations-V1-TAG)

### Naming
- ✅ Timestamp properties use common names (`createdAt`, `lastModifiedAt`, `deletedAt`) — not `createTime`, `creationTime`, etc.
- ✅ Resource ID reference properties use `Id` suffix — not `Uri`, `Url`, or `Name` suffix

Flag all violations clearly with JSON path references, the specific RPC rule ID where applicable, and a concrete fix suggestion.
