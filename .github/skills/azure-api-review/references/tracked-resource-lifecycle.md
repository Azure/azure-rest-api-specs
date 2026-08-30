<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-08-15
     Derived from:
       - Azure Resource Provider Contract (RPC) v1.0 — Resource API Reference, PUT Resource
       - Azure Resource Provider Contract (RPC) v1.0 — Pagination
       - Azure Resource Provider Contract (RPC) v1.0 — URI Format and Arguments
       - ARM Wiki: api_contracts/guidelines/rpc.md (RPC003, RPC006)
       - ARM Wiki: rp_onboarding/tracked_vs_proxy_resources.md
     The upstream documents always take precedence if there is a conflict. -->

# Tracked Resource Lifecycle -- Required Operations

ARM tracked resources (resources with `location` as a required
property) have a mandatory set of CRUD and list operations. Missing any
operation is a blocking ARM review error.

**Authoritative references:**

- [Azure Resource Provider Contract -- Resource API Reference][rpc-resource]
  (RPC-Put-V1-22, RPC-Get-V1-05, RPC-Patch-V1-03, RPC-Delete-V1-03)
- [Azure Resource Provider Contract -- PUT Resource][rpc-put]
- [Azure Resource Provider Contract -- Pagination][rpc-pagination]
- [Azure Resource Provider Contract -- Get Resource][rpc-get]
- [Azure Resource Provider Contract -- URI Format and Arguments][rpc-uri]
- [ARM Guidelines -- Query Parameter Pass-through][rpc031] (RPC031)
- [TypeSpec Azure -- ARM Resource Operations](https://azure.github.io/typespec-azure/docs/howtos/arm/resource-operations)
- [TypeSpec Azure -- Common Types](https://azure.github.io/typespec-azure/docs/howtos/arm/add-common-types/)

[rpc-resource]: https://eng.ms/docs/products/arm/api_contracts/resource-provider-contract/v10/resource-api-reference
[rpc-put]: https://eng.ms/docs/products/arm/api_contracts/resource-provider-contract/v10/put-resource
[rpc-pagination]: https://eng.ms/docs/products/arm/api_contracts/resource-provider-contract/v10/pagination
[rpc-get]: https://eng.ms/docs/products/arm/api_contracts/resource-provider-contract/v10/get-resource
[rpc-uri]: https://eng.ms/docs/products/arm/api_contracts/resource-provider-contract/v10/uri-format-and-arguments-for-crud-apis-on-resources
[rpc031]: https://eng.ms/docs/products/arm/api_contracts/guidelines/rpc

---

## Required Operations for Tracked Resources

Every tracked resource, whether top-level or nested, **MUST** implement:

| Operation   | HTTP Method                      | Purpose                                | Rule ID          |
| ----------- | -------------------------------- | -------------------------------------- | ---------------- |
| GET (point) | `GET .../resourceType/{name}`    | Return a single resource instance      | RPC-Get-V1-04    |
| PUT         | `PUT .../resourceType/{name}`    | Create or replace the resource         | RPC-Put-V1-22    |
| PATCH       | `PATCH .../resourceType/{name}`  | Update the resource (at minimum, tags) | RPC-Patch-V1-03  |
| DELETE      | `DELETE .../resourceType/{name}` | Remove the resource                    | RPC-Delete-V1-03 |

Collection scope depends on the resource hierarchy:

- A top-level tracked type **MUST** implement List by Resource Group and List by
  Subscription (RPC-Get-V1-05). RPC-Put-V1-01 requires tracked resources
  themselves to be resource-group scoped.
- A nested type **MUST** implement collection GET under its immediate parent
  (PLCY008 / RPC006). Do not require additional resource-group or subscription
  list operations for the nested type.

Flag any missing operation that applies to the tracked resource's scope.

## GET Rules

- Point GET **MUST** return only `200` and **MUST NOT** be an LRO (RPC-Get-V1-01, RPC-Get-V1-14).
- Point GET **MUST NOT** have query parameters other than `api-version` (RPC-Get-V1-08).
- Collection GET responses **MUST** only have `value` and `nextLink` as top-level properties (RPC-Get-V1-09).
- The model in the `value` array **MUST** be the same model as the point GET response (RPC-Get-V1-10).
- Collection GET **MUST** specify `x-ms-pageable` (RPC-Get-V1-13).
- When present, `nextLink` **MUST** use URI format (`"format": "uri"` in JSON, `url` type in TypeSpec) under the generic URL-format rule. RPC-Get-V1-06 requires continuation via `nextLink` when paging.

### Collection GET Query Parameters

Collection GET operations may use the following query parameters. **Do not flag
the presence of a correctly defined parameter:**

| Parameter     | Purpose                                                     |
| ------------- | ----------------------------------------------------------- |
| `api-version` | Required ARM API version                                    |
| `$filter`     | OData server-side filtering                                 |
| `$top`        | Optional client-supplied page size                          |
| `$skipToken`  | Opaque continuation token returned by the resource provider |

`$skipToken` **MUST** be opaque to clients and scoped to the tenant,
subscription, and collection that issued it. Replaying a token from another
scope must not expose that scope's data.

The allowance does not excuse a malformed definition. A finding about the
parameter's type, optionality, description, or `$skipToken` opacity and scope is
still valid; only the claim that the parameter itself is forbidden is a false
positive.

Other custom query parameters on collection GET operations are a **Warning**,
not Blocking. RPC-Uri-V1-09 says they **SHOULD NOT** be used, so the normative
strength policy caps the finding at Warning. Suggest an OData `$filter`
alternative when it can express the same operation.

ARM proxies non-reserved query parameters to the resource provider unchanged
(RPC031); do not claim that ARM cannot carry them. The
`QueryParametersInCollectionGet` linter is staging-only and currently has a
hard-coded allowlist that omits `$top` and `$skipToken`, so its output is not
evidence that these two RPC-defined paging parameters are invalid.

Point GET is unchanged: a query parameter other than `api-version` is a
**Blocking** RPC-Get-V1-08 violation.

## Nested Resource Rules

- Nested resources **MUST** have a List operation under their parent.
- Nested resources **MUST NOT** be embedded inline in the parent
  resource's GET response body. Return a resource ID reference instead.
- Singleton nested resources **SHOULD** be named `default`. Both the collection GET and singleton GET must exist.

## Singleton and Constrained Collection Resources

When a resource has a service-defined singleton name, use a predefined constant:
prefer `default`; `current` is also contract-valid. A static literal route such
as `/default` is allowed by the RPC. When the name is modeled as a path
parameter for SDK ergonomics, authoring guidance recommends a required one-value
enum with `x-ms-enum`.

The enum form enables SDK code generation to produce a typed parameter, but it
is not an ARM contract rule that invalidates literal routes.

**Correct (OpenAPI JSON):**

```json
{
  "name": "configName",
  "in": "path",
  "required": true,
  "type": "string",
  "enum": ["default"],
  "x-ms-enum": { "name": "ConfigName", "modelAsString": true }
}
```

**Contract-valid literal route (not SDK-preferred):**

```text
/providers/Microsoft.Example/resources/{name}/configs/default
```

The RPC permits this route. The `ReservedResourceNamesModelAsEnum` linter may
still recommend the enum form at warning level for SDK ergonomics.

**Correct (TypeSpec):**

```tsp
// TypeSpec singleton resources use the @singleton decorator which
// handles the enum representation automatically
@singleton
model MyConfig is ProxyResource<MyConfigProperties> {
  @key("configName")
  @segment("configs")
  name: string;
}
```

## `x-ms-azure-resource` Placement

`x-ms-azure-resource: true` **MUST** only be set on **top-level
resource envelope models** (models that define the ARM resource with
`id`, `name`, `type`). It **MUST NOT** be applied to nested or child
models within a resource definition. Applying it to non-resource models
causes SDK code generators to incorrectly treat those models as
independent ARM resources.

## Operations API

Every resource provider **MUST** expose an operations API at:

```text
GET /providers/Microsoft.{Namespace}/operations
```

The response **SHOULD** use the common-types `OperationListResult` and `Operation`
definitions. Inline definitions with the same shape are acceptable.

---

## Resource Move (RPC003)

All top-level tracked resource types **MUST** support resource move —
the ability to move a resource across resource groups or across
subscriptions within the same AAD tenant.

- Child resources move with the parent automatically; they do not need
  to be included in the move request.
- Move does not change the resource's physical location.
- If a resource type **cannot** support move, it must be explicitly
  blocked in the RP manifest (`linkedOperationRules` with mode
  `Blocked`).
- If a resource type supports move, the RP must handle the ARM move
  callback and update internal state (e.g., resource group references).

**Why:** Customers need to consolidate or reorganize resources across
resource groups and subscriptions. Blocking move without a documented
technical justification is a poor customer experience.

**Severity:** Required

---

## Format-Specific Templates

### OpenAPI JSON

Define each operation as a separate path entry in the swagger,
referencing the appropriate common-types for parameters and error
responses.

### TypeSpec

Use the ARM operation templates from `@azure-tools/typespec-azure-resource-manager`:

```tsp
@armResourceOperations
interface MyResources {
  get is ArmResourceRead<MyResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MyResource>;
  update is ArmResourcePatchAsync<MyResource, MyResourceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<MyResource>;
  listByResourceGroup is ArmResourceListByParent<MyResource>;
  listBySubscription is ArmListBySubscription<MyResource>;
}

// Operations API (required for every ARM RP)
interface Operations extends Azure.ResourceManager.Operations {}
```

**Reference:** [TypeSpec ARM Resource Operations](https://azure.github.io/typespec-azure/docs/howtos/arm/resource-operations)
