<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-04-15
     Derived from:
       - Azure Resource Provider Contract (RPC) v1.0 — Resource API Reference, PUT Resource
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
- [TypeSpec Azure -- ARM Resource Operations](https://azure.github.io/typespec-azure/docs/howtos/arm/resource-operations)
- [TypeSpec Azure -- Common Types](https://azure.github.io/typespec-azure/docs/howtos/arm/add-common-types/)

[rpc-resource]: https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/resource-api-reference.md
[rpc-put]: https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/put-resource.md

---

## Required Operations for Tracked Resources

Every tracked resource **MUST** implement all of:

| Operation              | HTTP Method                                              | Purpose                                | Rule ID          |
| ---------------------- | -------------------------------------------------------- | -------------------------------------- | ---------------- |
| GET (point)            | `GET .../resourceType/{name}`                            | Return a single resource instance      | RPC-Get-V1-01    |
| PUT                    | `PUT .../resourceType/{name}`                            | Create or replace the resource         | RPC-Put-V1-22    |
| PATCH                  | `PATCH .../resourceType/{name}`                          | Update the resource (at minimum, tags) | RPC-Patch-V1-03  |
| DELETE                 | `DELETE .../resourceType/{name}`                         | Remove the resource                    | RPC-Delete-V1-03 |
| List by Resource Group | `GET .../resourceGroups/{rg}/providers/.../resourceType` | Collection GET under resource group    | RPC-Get-V1-05    |
| List by Subscription   | `GET .../subscriptions/{sub}/providers/.../resourceType` | Collection GET under subscription      | RPC-Get-V1-05    |

If **any** of these operations are missing for a tracked resource, flag it as an ARM Error.

## GET Rules

- Point GET **MUST** return only `200` and **MUST NOT** be an LRO (RPC-Get-V1-01, RPC-Get-V1-14).
- Point GET **MUST NOT** have query parameters other than `api-version` (RPC-Get-V1-08).
- Collection GET responses **MUST** only have `value` and `nextLink` as top-level properties (RPC-Get-V1-09).
- The model in the `value` array **MUST** be the same model as the point GET response (RPC-Get-V1-10).
- Collection GET **MUST** specify `x-ms-pageable` (RPC-Get-V1-13).
- The `nextLink` property **MUST** use URI format (`"format": "uri"` in JSON, `url` type in TypeSpec).

## Nested Resource Rules

- Nested resources **MUST** have a List operation under their parent.
- Nested resources **MUST NOT** be embedded inline in the parent
  resource's GET response body. Return a resource ID reference instead.
- Singleton nested resources **SHOULD** be named `default`. Both the collection GET and singleton GET must exist.

## Operations API

Every resource provider **MUST** expose an operations API at:

```text
GET /providers/Microsoft.{Namespace}/operations
```

Using the common-types `OperationListResult` and `Operation` definitions.

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
  delete is ArmResourceDeleteAsync<MyResource>;
  listByResourceGroup is ArmResourceListByParent<MyResource>;
  listBySubscription is ArmListBySubscription<MyResource>;
}

// Operations API (required for every ARM RP)
interface Operations extends Azure.ResourceManager.Operations {}
```

**Reference:** [TypeSpec ARM Resource Operations](https://azure.github.io/typespec-azure/docs/howtos/arm/resource-operations)
