<!-- Upstream alignment: 2026-04-15 -->

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

## Singleton and Constrained Collection Resources (RPC-ConstrainedCollections-V1-04)

When a resource has a **service-defined name** (e.g., `default`,
`current`, or a fixed set of names), the name **MUST** be represented
as an **enum path parameter** with `x-ms-enum` and
`modelAsString: true`. It **MUST NOT** be a static literal string
baked into the URI path segment.

This enables SDK code generation to produce a typed enum parameter and
allows future extensibility if additional names are added.

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

**Incorrect -- static literal in path:**

```text
/providers/Microsoft.Example/resources/{name}/configs/default
```

(Also enforced by: `ReservedResourceNamesModelAsEnum` linter rule --
warning level)

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

Using the common-types `OperationListResult` and `Operation` definitions.

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
