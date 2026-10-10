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

```yaml
title: EdgeActionsManagementClient
description: Edge Actions Management Client
openapi-type: arm
tag: package-2026-10-01
```

### Tag: package-2026-10-01

These settings apply only when `--tag=package-2026-10-01` is specified on the command line.

This is the default stable tag.

Stable request models retain their existing API identities: `EdgeActionUpdate`
and `EdgeActionVersionUpdate` contain optional tags only, and
`EdgeActionExecutionFilterUpdate` contains optional tags and writable filter
properties. `VersionCode` is shared by code deployment and code retrieval and
contains required `content` only. Internal version-specific operation helpers
preserve the published operation IDs and preview contracts.

#### Stable long-running operation contract

The stable API distinguishes operation **status** from the operation's logical
**result**. `Azure-AsyncOperation` identifies status polling: a successful status
read returns HTTP `200` and `EdgeActionOperationStatus`, including `status`
and, for a failed operation, `error.code` and `error.message`. A failed operation
remains failed even if resource rollback restores a healthy resource.

`Location` identifies result polling for continuing PATCH, DELETE, and POST:
HTTP `202` without a body while pending, then the operation-specific completion
response below. It is not interchangeable with the status envelope or an
ordinary resource GET that always returns HTTP `200`.

| Operation                             | Initial success responses                                          | Logical completion result                                                                  | Generated `final-state-via` |
| ------------------------------------- | ------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | --------------------------- |
| Resource PUT (all three resources)    | `201` create or `200` replace, with the resource body; never `202` | The resource                                                                               | `azure-async-operation`     |
| Resource PATCH (all three resources)  | `200` completed resource or body-less `202`                        | `200` with the complete resource                                                           | `location`                  |
| Resource DELETE (all three resources) | Body-less `200`, `202`, or `204`                                   | Body-less `200` or `204`; resource absent                                                  | `location`                  |
| `deployVersionCode` POST              | `200` with version properties or body-less `202`                   | `200` with `EdgeActionVersionProperties`, not the full Version resource or status envelope | `location`                  |
| `swapDefault` POST                    | Body-less `202`                                                    | `204` without a body                                                                       | `location`                  |

Continuing PUT responses use a non-terminal resource `provisioningState` and
`Azure-AsyncOperation`; no `Location` is added to PUT. Continuing PATCH, DELETE,
and POST responses use both polling headers for their distinct contracts.
`Retry-After`, when supplied, is an integer from 10 through 600 seconds.
Synchronous completions need not return polling headers. Polling URLs are
absolute and retain the initiating `api-version`.

All operations in the table retain `x-ms-long-running-operation: true`. That
marker and `final-state-via` are OpenAPI operation extensions, not HTTP headers.
The existing generated literals are preserved, not a universal prescription for
all ARM services or SDK pollers. `swapDefault`'s initial `202`-only declaration
does not describe its result URL's terminal `204`. `getVersionCode` is a separate
synchronous POST returning only `content`, with no LRO metadata or polling headers.

The Execution Filter examples illustrate continuing PUT `201` and `200`, alongside
synchronous PUT completion. Edge Action and Version PUT examples retain their
valid synchronous `Succeeded` responses. Additional coverage illustrates
body-less `202` responses.
The illustrative `Location` URLs use an EdgeActions-owned, subscription-scoped
result route. The exact route remains provisional; these examples do not
establish a registered or implemented result endpoint.
This specification does not add a separately callable operation-status or
operation-result GET, or a new result envelope. The existing operation-status
model remains the polling-header status monitor, not a new resource API.
Clients follow the returned polling URLs rather than construct them from these
examples.

```yaml $(tag) == 'package-2026-10-01'
input-file:
  - stable/2026-10-01/openapi.json
modelerfour:
  lenient-model-deduplication: true
  prenamer: true
suppressions:
  # Operations endpoint for Microsoft.Cdn already defined in central Cdn swagger, not duplicated here
  - code: OperationsAPIImplementation
    reason: Operations API implemented in central Cdn swagger for provider Microsoft.Cdn.
```

### Tag: package-2025-12-01-preview

These settings apply only when `--tag=package-2025-12-01-preview` is specified on the command line.

This preview tag removes the internal `addAttachment` and `deleteAttachment` operations that are
used exclusively by the AFD RP.

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

```yaml $(swagger-to-sdk)
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
