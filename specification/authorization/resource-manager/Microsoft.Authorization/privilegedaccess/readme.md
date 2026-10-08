# PrivilegedAccess migration prototype

> see https://aka.ms/autorest

This AutoRest configuration is an isolated packaging prototype for the published
Microsoft.Authorization PrivilegedAccess `2026-06-01-preview` contract. The
shared Authorization configuration remains the active generation entry point
until service and SDK package owners approve a cutover.

## Configuration

### Basic Information

```yaml
openapi-type: arm
tag: package-2026-06-01-preview
modelerfour:
  lenient-model-deduplication: true
```

### Suppression

```yaml
directive:
  - suppress: AvoidAdditionalProperties
    from: authorization-PrivilegedAccess.json
    where:
      - $.definitions.ParentResource.properties.properties
      - $.definitions.ResourceProjection.properties.tags
    reason: |
      `ResourceProjection.tags` and `ParentResource.properties` are
      pass-through, open key/value bags with no service-side validation on
      their contents. `ResourceProjection.tags` mirrors the upstream Azure
      resource's tags verbatim — identical semantics to the standard Azure
      Resource Manager `TrackedResource.tags` open string map. The
      `ParentResource.properties` bag mirrors per-scope-tier metadata from the
      upstream Azure scope; its field set is determined by the sibling `type`
      discriminator (`resourceGroup`, `subscription`, and future scope tiers).
      Strong typing at the schema layer would defeat the purpose — user-defined
      tags are arbitrary, and new scope tiers (e.g., `managementGroup`,
      `tenant`) must be addable server-side without an API contract break or
      SDK regeneration.
  - suppress: LocationMustHaveXmsMutability
    from: authorization-PrivilegedAccess.json
    where: $.definitions.ResourceProjection.properties.location
    reason: |
      `ResourceProjection.location` is a response-only projection field on a
      server-side aggregation view, not the `location` of a tracked ARM
      resource. The `x-ms-mutability: ["read", "create"]` rule targets tracked
      resources whose location is set on create; the projection has no PUT
      path that accepts a location.
  - suppress: RequiredPropertiesMissingInResourceModel
    from: authorization-PrivilegedAccess.json
    where: $.definitions.PagedResourceProjection
    reason: |
      `PagedResourceProjection` is the paging envelope returned by the
      `privilegedResources` list operation, not an ARM resource. It spreads the
      standard `Azure.Core.Page<ResourceProjection>` shape (`value` + `nextLink`)
      and adds the optional `count` field ($count=true). The linter heuristic
      mis-classifies this envelope definition as a resource model. The actual ARM
      resource invariants (id/name/type/readonly) are enforced on the page's
      items (`ResourceProjection`), not on the envelope itself.
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: authorization-PrivilegedAccess.json
    where: $.paths['/providers/Microsoft.Authorization/privilegedResources'].get.responses['200'].schema.properties
    reason: |
      The optional `count` property is returned only when the caller requests
      `$count=true`. It reports the complete post-filter cardinality before
      pagination and is an intentional part of this API contract. Existing
      Azure Resource Manager APIs, including Microsoft.DataLakeAnalytics
      `Accounts_List`, use the same `$count` query and response `count` pattern.
  - suppress: RequiredPropertiesMissingInResourceModel
    from: authorization-PrivilegedAccess.json
    where: $.definitions.PagedRelatedResourceProjection
    reason: |
      `PagedRelatedResourceProjection` is the swagger-emit of
      `Azure.Core.Page<RelatedResourceProjection>` — the paging envelope returned
      by the `privilegedResources/{privilegedResourceId}/relatedResources` list
      operation, not an ARM resource. The envelope is unnamed in TypeSpec
      (inlined as the operation's return type) but the autorest emitter generates
      a named definition; the linter heuristic mis-classifies that generated name
      as a resource model. The actual ARM resource invariants
      (id/name/type/readonly) are enforced on the page's items
      (`RelatedResourceProjection`), not on the envelope itself — identical
      treatment to `PagedResourceProjection` above.
  - suppress: TenantLevelAPIsNotAllowed
    from: authorization-PrivilegedAccess.json
    where:
      - $.paths['/providers/Microsoft.Authorization/privilegedResourceFavorites']
      - $.paths['/providers/Microsoft.Authorization/privilegedResourceFavorites/{favoriteId}']
      - $.paths['/providers/Microsoft.Authorization/privilegedResources']
      - $.paths['/providers/Microsoft.Authorization/privilegedResources/{privilegedResourceId}/relatedResources']
    reason: |
      `privilegedResources` returns a caller-specific view aggregated across
      subscriptions, so subscription or resource-group scoping would prevent
      the operation from representing the caller's complete accessible set.
      `relatedResources` follows the same tenant-scoped parent collection.
      `privilegedResourceFavorites` stores private per-caller state; the caller
      identity partitions records, and favorites do not belong to an Azure
      subscription or resource group.

      Chris Stackhouse approved this tenant-level API design during ARM API
      Modeling Office Hours on May 21, 2026. These APIs do not use
      `allowUnauthorizedActions` and do not bypass standard Azure RBAC.
```

### Tag: package-2026-06-01-preview

```yaml $(tag) == 'package-2026-06-01-preview'
input-file:
  - preview/2026-06-01-preview/authorization-PrivilegedAccess.json
```

## Suppression

```yaml
directive:
  - from: swagger-document
    where: $.definitions
    transform: return $.replace(/(?:\.[-.a-zA-Z0-9]+)+$/, "");
```

## Code Generation

### Swagger to SDK

This section is informational only for the local prototype. Package identities
and generation pointers require SDK-owner approval before use.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-net
```
