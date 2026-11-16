# Reference Document Links

Prefer explanatory guidance and its embedded examples. Keep a standalone
official sample only when it clarifies a distinct pattern, such as extension
resource scopes; samples illustrate usage, not additional requirements.

## API Versioning

- [Evolving APIs](https://azure.github.io/typespec-azure/docs/howtos/versioning/06-evolving-apis/): Primary guidance for changing existing versioned APIs: add, remove, rename, or modify resources, operations, parameters, and properties.
- [Versioning overview](https://azure.github.io/typespec-azure/docs/howtos/versioning/01-about-versioning/): Understand Azure API versioning, version enum ordering, and active preview guidance.
- [Add preview after preview](https://azure.github.io/typespec-azure/docs/howtos/versioning/02-preview-after-preview/): Add a preview version when the latest existing version is also a preview.
- [Add stable after preview](https://azure.github.io/typespec-azure/docs/howtos/versioning/03-stable-after-preview/): Promote preview changes into a new stable version.
- [Add preview after stable](https://azure.github.io/typespec-azure/docs/howtos/versioning/04-preview-after-stable/): Add a preview version after the latest stable version.
- [Add stable after stable](https://azure.github.io/typespec-azure/docs/howtos/versioning/05-stable-after-stable/): Add a stable version after the latest stable version.

## Add ARM Resource Type

- [ARM resource types and modeling](https://azure.github.io/typespec-azure/docs/howtos/arm/resource-type/): Define tracked, proxy, tenant, extension, and child resources with the standard ARM resource templates.
- [Specific extension resource sample](https://azure.github.io/typespec-azure/docs/samples/resource-manager/resource-types/specific-extension/): Define an extension resource and its scoped operations with the `Extension.*` templates.
- [Private endpoints](https://azure.github.io/typespec-azure/docs/howtos/arm/private-endpoints/): Add private endpoint connection resources and their standard operations to an ARM resource provider.
- [Private links](https://azure.github.io/typespec-azure/docs/howtos/arm/private-links/): Add private link resources and their standard operations to an ARM resource provider.
- [Network security perimeter](https://azure.github.io/typespec-azure/docs/howtos/arm/network-security-perimeter/): Add network security perimeter configuration resources and operations to an ARM service.

## Add ARM Resource Operation

- [ARM resource operations](https://azure.github.io/typespec-azure/docs/howtos/arm/resource-operations/): Use standard lifecycle and action templates, including `ArmResourceListByParent` and `ArmListBySubscription` for ARM lists.
- [Azure.ResourceManager interface reference](https://azure.github.io/typespec-azure/docs/libraries/azure-resource-manager/reference/interfaces/): Look up exact signatures and parameters for ARM resource and extension operation templates.

## Resource Semantics

- [TypeSpec.Rest decorators](https://typespec.io/docs/libraries/rest/reference/decorators/): Identify resource models, parents, lifecycle roles, and actions with `@resource`, `@parentResource`, `@readsResource`, `@listsResource`, and related decorators.
- [Azure.ResourceManager decorators](https://azure.github.io/typespec-azure/docs/libraries/azure-resource-manager/reference/decorators/): Identify ARM lifecycle roles through `@armResourceRead`, `@armResourceCreateOrUpdate`, `@armResourceUpdate`, `@armResourceDelete`, and `@armResourceList`.

## Long-Running Operations (LRO)

- [ARM long-running operations](https://azure.github.io/typespec-azure/docs/howtos/arm/long-running-operations/): Define ARM LROs and customize Azure-AsyncOperation, Location, and Retry-After response headers.
- [Azure.Core long-running operations](https://azure.github.io/typespec-azure/docs/howtos/azure-core/long-running-operations/): Define polling and status-monitor patterns for Azure.Core asynchronous operations.

## ARM Paging

ARM list operations normally use the standard resource-operation templates
above. Assess the template, resource scope, and paged response; do not require
authors to repeat the low-level paging decorators supplied by templates.

- [Azure.ResourceManager data types](https://azure.github.io/typespec-azure/docs/libraries/azure-resource-manager/reference/data-types/): Use standard ARM paging parameters such as `ArmTopParameter` and `ArmSkipParameter`.

## Data-Plane Paging

- [TypeSpec pagination](https://typespec.io/docs/standard-library/pagination/): Model data-plane paging with low-level `@list`, `@pageItems`, `@nextLink`, `@continuationToken`, `@pageSize`, and `@offset` decorators.

## Models and Enums

- [ARM common types](https://azure.github.io/typespec-azure/docs/howtos/arm/add-common-types/): Author and version common ARM model definitions and expose them with `@@armCommonDefinition`.
- [Models](https://typespec.io/docs/language-basics/models/): Define model properties, optional values, defaults, spreads, inheritance, and composition.
- [Enums](https://typespec.io/docs/language-basics/enums/): Define named enum members and service-facing enum values.
- [Scalars](https://typespec.io/docs/language-basics/scalars/): Define reusable custom scalar types and constrained primitive values.

## Decorators

- [Decorators](https://typespec.io/docs/language-basics/decorators/): Apply decorators and augment decorators to TypeSpec declarations.
- [Built-in decorators](https://typespec.io/docs/standard-library/built-in-decorators/): Use standard decorators for documentation, visibility, and value constraints such as minimum and maximum length.
- [OpenAPI decorators](https://typespec.io/docs/libraries/openapi/reference/decorators/): Reference OpenAPI-specific decorators such as `@operationId`.
- [Change provider namespace](https://azure.github.io/typespec-azure/docs/howtos/arm/change-provider-namespace/): Set an ARM provider namespace that differs from the TypeSpec namespace with `@armProviderNamespace`.
- [Azure Portal default experiences](https://azure.github.io/typespec-azure/docs/howtos/azure-portal/default-experiences/): Understand the default Azure Portal experiences generated for ARM resource types and the available customization areas.
- [Content negotiation](https://azure.github.io/typespec-azure/docs/howtos/azure-core/content-negotiation/): Model Azure.Core content negotiation with shared routes and typed Accept headers.

## Warnings

- [Directives](https://typespec.io/docs/language-basics/directives/): Suppress specific compiler or linter warnings with `#suppress` and a justification.
- [Azure Core `no-openapi` rule](https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-openapi/): Understand the warning against OpenAPI-specific decorators in Azure TypeSpec and when suppression is appropriate.
