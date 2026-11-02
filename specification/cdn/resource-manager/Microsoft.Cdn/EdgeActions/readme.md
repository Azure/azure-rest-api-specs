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

### Tag: package-2027-01-01-preview

Select this preview explicitly with `--tag=package-2027-01-01-preview`.
The default remains the published stable API. See [the changelog](changelog.md)
for the breaking changes and downstream SDK implications.

The preview's PUT request properties allow both creation and replacement.
Execution-filter `versionId`, `executionFilterIdentifierHeaderName`, and
`executionFilterIdentifierHeaderValue` are writable through the entire
`properties` path, not only on the leaf definitions. This removes the conflicting
create-only parent mutability that caused update-oriented CLI generation to omit
those fields from GET/modify/PUT workflows. Execution-filter PATCH exposes the
same three fields as optional inputs; Edge Action and Version PATCH expose only
optional tags. Retaining a field in a GET or PATCH model alone does not make it
available to a generated PUT serializer.

`deploymentStatus` and `versionExecutionState` are required response-only Version
properties. `isDefaultVersion` is absent; use `swapDefault` to select the default.
`VersionCode` contains only required `content`, and `getVersionCode` is a
synchronous POST with no body or Content-Type input. `deployVersionCode` retains
the merged full `EdgeActionVersion` result, including resource metadata and nested
properties, rather than reverting to the closed PR's properties-only result.

`Azure-AsyncOperation` polls the resource-group-scoped `EdgeActionOperations_Get`
endpoint. Its `EdgeActionOperationStatus` uses `id` and `name`, replacing the old
flat monitor's `resourceId` and `operationId`, and reports failure in an HTTP 200
status response with a structured error. `Location` polls the separate,
subscription-scoped `EdgeActionOperationResults_Get` endpoint. A pending result
returns bodyless 202 and repeats Location; completion returns the originating
operation's synchronous result or bodyless 204. Its heterogeneous 200 result has
an unconstrained JSON object schema and is not the status envelope. Preview
examples use these same routes and retain the initiating api-version. Retry-After is 10 through 600
seconds. PUT declares status polling on both 200 and 201; PATCH, DELETE, deploy,
and swap declare status and result headers on 202.

These are preview service requirements, not evidence that the resource provider
already implements the new states, routes, status fields, or tags-only PATCH.
Existing API versions and their generated contracts remain unchanged.

```yaml $(tag) == 'package-2027-01-01-preview'
input-file:
  - preview/2027-01-01-preview/openapi.json
modelerfour:
  lenient-model-deduplication: true
  prenamer: true
suppressions:
  - code: OperationsAPIImplementation
    reason: Operations API implemented in central Cdn swagger, not duplicated in EdgeActions.
  - code: GetResponseCodes
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Cdn/edgeActionOperationResults/{operationId}"].get
    reason: This Location polling endpoint returns pending 202, a content-bearing final 200, or a bodyless final 204.
  - code: AvoidAdditionalProperties
    where:
      - $.definitions.EdgeActionOperationResultPayload
      - $.definitions.EdgeActionOperationStatus.properties.properties
    reason: Operation results and optional success snapshots have heterogeneous response fields; they are not writable resource configuration.
  - code: RequiredPropertiesMissingInResourceModel
    where:
      - $.definitions.EdgeActionOperationStatus
      - $.definitions.EdgeActionOperationResultPayload
    reason: Polling records and heterogeneous operation results are not fixed ARM resource envelopes.
  - code: BodyTopLevelProperties
    where:
      - $.definitions.EdgeActionOperationStatus
    reason: The Azure-AsyncOperation record exposes standard top-level status, error, and timestamps, not an ARM resource properties envelope.
  - code: PatchSkuProperty
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}"].patch.parameters[4]
    reason: The preview intentionally supports tags-only PATCH; SKU is not a PATCH input.
  - code: PostResponseCodes
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}/versions/{version}/swapDefault"].post
    reason: The final response has no content, so 204 is returned.
  - code: DeleteResponseCodes
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}/versions/{version}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActions/{edgeActionName}/executionFilters/{executionFilter}"].delete
    reason: Preserve synchronous 200, asynchronous 202, and idempotent 204 delete responses.
```

### Tag: package-2026-10-01

These settings apply only when `--tag=package-2026-10-01` is specified on the command line.

This is the default stable tag. `deployVersionCode` returns the full `EdgeActionVersion`
resource, matching version GET, rather than only `EdgeActionVersionProperties`. Its result
contains resource metadata and a nested `properties` object. Asynchronous PUT operations declare
`Azure-AsyncOperation` with optional `Retry-After` on both 200 and 201 responses. PUT returns
201 for creation and 200 for replacement; a 200 response does not by itself mean provisioning
is complete. Asynchronous PATCH, DELETE, and version action operations declare both
`Azure-AsyncOperation` and `Location`, with optional `Retry-After`, on their 202 responses.
The deploy result correction can change generated SDK result types and caller property access;
it requires compatibility review for consumers of `2026-10-01`.

Use `Azure-AsyncOperation` to poll operation status. PUT operations retain
`final-state-via: azure-async-operation` and the resource as their logical result.
The status monitor is `EdgeActionOperation`, reusing the existing flat
`EdgeActionOperationProperties` response with top-level `status` and `error`;
it is not the library-default `ArmOperationStatus` or a proxy-resource envelope.
For operations with combined headers, `Location` identifies the final result.
The 202 examples use `edgeActionOperations` URLs for operation status and `operationresults`
URLs for the final result. Completion endpoints return an empty 202 response while the operation
is running and the operation's final response only after completion.

Both preview versions retain their existing contracts. The internal
`addAttachment` and `deleteAttachment` operations used exclusively by the AFD RP remain absent, as
they have been since `2025-12-01-preview`.

The stable examples use valid resource names and supported property values, consistent resource
identifiers, and the `2026-10-01` api-version. They declare the polling and `Retry-After` headers
the contract already defines.

The PATCH descriptions are explicitly versioned in TypeSpec: the revised descriptions apply
starting with `2026-10-01`, while both preview versions retain their original descriptions.
Normal compilation regenerates all versions without changing the preview contracts or documentation.

#### Successful polling responses

These are responses to GET requests following the polling headers, not response
bodies for the initiating 202. The `EdgeActionOperation` TypeSpec model includes
a typed success example for tooling that consumes model examples.

For `deployVersionCode`, GET the `Azure-AsyncOperation` URL from
`examples/2026-10-01/EdgeActionVersions_DeployVersionCode.json`. A successful
operation returns the flat status body:

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "resourceId": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/testrg/providers/Microsoft.Cdn/edgeActionOperations/00000000-0000-0000-0000-000000000000",
  "operationId": "00000000-0000-0000-0000-000000000000",
  "status": "Succeeded",
  "operationType": "update",
  "startTime": "2026-10-01T12:00:00Z",
  "endTime": "2026-10-01T12:00:10Z"
}
```

After status reaches `Succeeded`, GET the `Location` URL. For `deployVersionCode`,
the successful result is the full version resource, matching the 200 response
body in the same source example:

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/testrg/providers/Microsoft.Cdn/edgeActions/edgeAction1/versions/version2",
  "name": "version2",
  "type": "Microsoft.Cdn/edgeActions/versions",
  "location": "global",
  "properties": {
    "provisioningState": "Succeeded",
    "deploymentType": "zip",
    "validationStatus": "Succeeded",
    "isDefaultVersion": "True",
    "lastPackageUpdateTime": "2024-05-25T16:19:23Z"
  }
}
```

For no-content operations such as `swapDefault` and DELETE, the successful
`Location` response has no body:

```http
HTTP/1.1 204 No Content
```

The status-monitor body is never substituted for the final result. These
examples describe the polling contract; they do not introduce new GET operations
or change the initiating operations' response codes.

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

This tag retains the existing suppressions listed below.

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
