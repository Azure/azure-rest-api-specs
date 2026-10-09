# EdgeActions

> see https://aka.ms/autorest

This is the AutoRest configuration file for EdgeActions.

---

## Getting Started

To build the SDK for EdgeActions, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the EdgeActions API.

``` yaml
title: EdgeActionsManagementClient
description: Edge Actions Management Client
openapi-type: arm
tag: package-2026-10-01
```

### Tag: package-2026-10-01

These settings apply only when `--tag=package-2026-10-01` is specified on the command line.

This is the default stable tag. Its wire contract is identical to `package-2025-12-01-preview` apart
from the api-version string: the same operations, request and response models, response codes, and
long-running operation metadata. `2026-10-01` introduces no contract change, so an existing
`2025-12-01-preview` caller reaches GA by changing the api-version alone. The internal
`addAttachment` and `deleteAttachment` operations used exclusively by the AFD RP remain absent, as
they have been since `2025-12-01-preview`.

The stable examples use valid resource names and supported property values, consistent resource
identifiers, and the `2026-10-01` api-version. They declare the polling and `Retry-After` headers
the contract already defines.

The PATCH descriptions are explicitly versioned in TypeSpec: the revised descriptions apply
starting with `2026-10-01`, while both preview versions retain their original descriptions.
Normal compilation regenerates all versions without changing the preview contracts or documentation.

The stable descriptions define tags-only PATCH for Edge Actions and versions. Execution-filter
PATCH supports both properties and tags. For all three resources, omitted tags are preserved,
an empty tags object clears all tags, and supplied tags replace the entire tag collection.
Null tags are rejected. Version properties are not changed.
If `deploymentType` or `isDefaultVersion` is supplied in a version PATCH request,
it must match the existing value; use `swapDefault` to change the default version. Do not include
`sku` in Edge Action PATCH requests; any supplied `sku`, including null or the existing value,
is rejected. These documentation changes do not alter schemas, operations, response codes, or
long-running operation metadata.

Version PATCH tag persistence requires a corresponding resource-provider implementation fix:
the current implementation validates the supplied version properties but does not persist tags.
The description documents the intended contract, not delivery of that implementation fix.

Because the wire contract is unchanged, this tag carries the same suppressions as the preview tag it is
derived from.

```yaml $(tag) == 'package-2026-10-01'
input-file:
  - stable/2026-10-01/openapi.json
modelerfour:
  lenient-model-deduplication: true
  prenamer: true
suppressions:
  # Operations endpoint for Microsoft.Cdn already defined in central Cdn swagger, not duplicated here
  - code: OperationsAPIImplementation
    reason: Operations API implemented in central Cdn swagger (package-preview-2025-09) for provider Microsoft.Cdn.
  # LRO POST actions intentionally return 200 (final) and 202 (in-progress) matching 2024-07-22-preview baseline.
  - code: PostResponseCodes
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}/versions/{version}/swapDefault"].post
    reason: Preexisting LRO pattern (200,202) retained for backward compatibility with 2024-07-22-preview.
  # Delete operations return 200 for synchronous completion in addition to 202/204 for LRO pattern.
  - code: DeleteResponseCodes
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}/versions/{version}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}/executionFilters/{executionFilter}"].delete
    reason: >-
      EdgeActions RP currently implements synchronous delete (returns 200). Adding 200 to the spec
      enables SDK generation to accept 200 as a valid response. Transitioning to async delete (202)
      while maintaining backward compatibility with existing clients from 2024-07-22-preview.
```

### Tag: package-2025-12-01-preview

These settings apply only when `--tag=package-2025-12-01-preview` is specified on the command line.

This preview tag removes the internal `addAttachment` and `deleteAttachment` operations
that are used exclusively by the AFD RP.

```yaml $(tag) == 'package-2025-12-01-preview'
input-file:
  - preview/2025-12-01-preview/openapi.json
modelerfour:
  lenient-model-deduplication: true
  prenamer: true
suppressions:
  # Operations endpoint for Microsoft.Cdn already defined in central Cdn swagger, not duplicated here
  - code: OperationsAPIImplementation
    reason: Operations API implemented in central Cdn swagger (package-preview-2025-09) for provider Microsoft.Cdn.
  # LRO POST actions intentionally return 200 (final) and 202 (in-progress) matching 2024-07-22-preview baseline.
  - code: PostResponseCodes
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}/versions/{version}/swapDefault"].post
    reason: Preexisting LRO pattern (200,202) retained for backward compatibility with 2024-07-22-preview.
  # Delete operations return 200 for synchronous completion in addition to 202/204 for LRO pattern.
  - code: DeleteResponseCodes
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}/versions/{version}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}/executionFilters/{executionFilter}"].delete
    reason: >-
      EdgeActions RP currently implements synchronous delete (returns 200). Adding 200 to the spec
      enables SDK generation to accept 200 as a valid response. Transitioning to async delete (202)
      while maintaining backward compatibility with existing clients from 2024-07-22-preview.
```

### Tag: package-2025-09-01-preview

These settings apply only when `--tag=package-2025-09-01-preview` is specified on the command line.

This version includes the internal `addAttachment` and `deleteAttachment` operations.

```yaml $(tag) == 'package-2025-09-01-preview'
input-file:
  - preview/2025-09-01-preview/openapi.json
modelerfour:
  lenient-model-deduplication: true
  prenamer: true
suppressions:
  # Operations endpoint for Microsoft.Cdn already defined in central Cdn swagger, not duplicated here
  - code: OperationsAPIImplementation
    reason: Operations API implemented in central Cdn swagger (package-preview-2025-09) for provider Microsoft.Cdn.
  # LRO POST actions intentionally return 200 (final) and 202 (in-progress) matching 2024-07-22-preview baseline.
  - code: PostResponseCodes
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}/addAttachment"].post
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}/deleteAttachment"].post
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}/versions/{version}/swapDefault"].post
    reason: Preexisting LRO pattern (200,202) retained for backward compatibility with 2024-07-22-preview.
  # Delete operations return 200 for synchronous completion in addition to 202/204 for LRO pattern.
  - code: DeleteResponseCodes
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}/versions/{version}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}/executionFilters/{executionFilter}"].delete
    reason: >-
      EdgeActions RP currently implements synchronous delete (returns 200). Adding 200 to the spec
      enables SDK generation to accept 200 as a valid response. Transitioning to async delete (202)
      while maintaining backward compatibility with existing clients from 2024-07-22-preview.
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

C# SDK generation is configured via TypeSpec in `tspconfig.yaml`.
The generated SDK uses the `Azure.ResourceManager.EdgeActions` namespace as a separate package.
