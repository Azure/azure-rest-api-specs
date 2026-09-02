# Reference Document Links

## Add ARM Resource Type

- [ARM resource types and modeling](https://azure.github.io/typespec-azure/docs/howtos/arm/resource-type/): Define tracked, proxy, tenant, extension, and child resources with the standard ARM resource templates.
- [Specific extension resource sample](https://azure.github.io/typespec-azure/docs/samples/resource-manager/resource-types/specific-extension/): Define an extension resource and its scoped operations with the `Extension.*` templates.
- [Agent base type](https://azure.github.io/typespec-azure/docs/howtos/arm/agent-base-type/): Model ARM agent resources and their conversation and response child resources with the standard base types.
- [Private endpoints](https://azure.github.io/typespec-azure/docs/howtos/arm/private-endpoints/): Add private endpoint connection resources and their standard operations to an ARM resource provider.
- [Private links](https://azure.github.io/typespec-azure/docs/howtos/arm/private-links/): Add private link resources and their standard operations to an ARM resource provider.
- [Network security perimeter](https://azure.github.io/typespec-azure/docs/howtos/arm/network-security-perimeter/): Add network security perimeter configuration resources and operations to an ARM service.

## Add ARM Resource Operation

- [ARM resource operations](https://azure.github.io/typespec-azure/docs/howtos/arm/resource-operations/): Use standard ARM templates for read, create or replace, update, delete, existence check, list, custom action, and provider action operations.
- [Azure.ResourceManager interface reference](https://azure.github.io/typespec-azure/docs/libraries/azure-resource-manager/reference/interfaces/): Look up exact signatures and parameters for ARM resource and extension operation templates.
- [Azure.Core operation interfaces](https://azure.github.io/typespec-azure/docs/getstarted/azure-core/step05/): Add data-plane resource interfaces with standard Azure.Core create, read, update, delete, list, and polling operation templates.
- [Azure.Core interface reference](https://azure.github.io/typespec-azure/docs/libraries/azure-core/reference/interfaces/): Use Azure.Core resource operation templates for data-plane create, read, update, delete, and list operations.

## API Versioning

- [Versioning overview](https://azure.github.io/typespec-azure/docs/howtos/versioning/01-about-versioning/): Understand Azure API versioning, version enum ordering, and active preview guidance.
- [Add preview after preview](https://azure.github.io/typespec-azure/docs/howtos/versioning/02-preview-after-preview/): Add a preview version when the latest existing version is also a preview.
- [Add stable after preview](https://azure.github.io/typespec-azure/docs/howtos/versioning/03-stable-after-preview/): Promote preview changes into a new stable version.
- [Add preview after stable](https://azure.github.io/typespec-azure/docs/howtos/versioning/04-preview-after-stable/): Add a preview version after the latest stable version.
- [Add stable after stable](https://azure.github.io/typespec-azure/docs/howtos/versioning/05-stable-after-stable/): Add a stable version after the latest stable version.
- [Evolving APIs](https://azure.github.io/typespec-azure/docs/howtos/versioning/06-evolving-apis/): Add, remove, rename, or modify resources, operations, parameters, and properties across API versions.

## Long-Running Operations (LRO)

- [ARM long-running operations](https://azure.github.io/typespec-azure/docs/howtos/arm/long-running-operations/): Define ARM LROs and customize Azure-AsyncOperation, Location, and Retry-After response headers.
- [Azure.Core long-running operations](https://azure.github.io/typespec-azure/docs/howtos/azure-core/long-running-operations/): Define polling and status-monitor patterns for Azure.Core asynchronous operations.

## Paging

- [TypeSpec pagination](https://typespec.io/docs/standard-library/pagination/): Model client-driven and server-driven paging with TypeSpec's standard pagination decorators.
- [Azure.ResourceManager data types](https://azure.github.io/typespec-azure/docs/libraries/azure-resource-manager/reference/data-types/): Use standard ARM paging parameters such as `ArmTopParameter` and `ArmSkipParameter`.
- [Azure.Core interface reference](https://azure.github.io/typespec-azure/docs/libraries/azure-core/reference/interfaces/): Define data-plane list operations and paged response shapes with Azure.Core resource templates.

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
