# edgeoperator - LogCollections

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.EdgeOperator LogCollections.

SDK language emitters are not configured, matching the sibling SystemConfiguration
project. Default compilation generates only the OpenAPI specification.

## Getting Started

Compile the TypeSpec project with `tsp compile .`. The `main.tsp` entry point imports
`client.tsp` so compilation and SDK generation include language-scoped naming customizations.

This API exposes the public Azure Resource Manager routes, not the internal RPaaS
`ResourceReadBegin` callbacks. Requests must use the Operator subscription.

- `POST /subscriptions/{subscriptionId}/providers/Microsoft.EdgeOperator/collectLogs`
- `POST /subscriptions/{subscriptionId}/providers/Microsoft.EdgeOperator/collectLogsIndirect`
- `GET /subscriptions/{subscriptionId}/providers/Microsoft.EdgeOperator/logCollections/{jobId}`
- `GET /subscriptions/{subscriptionId}/providers/Microsoft.EdgeOperator/logCollections?fromDate={fromDate}`

Both POST actions return an empty `202` response with `Azure-AsyncOperation`,
`Location`, and `Retry-After` headers supplied through RPaaS. Poll the
`Azure-AsyncOperation` URL unchanged,
including its query string, until completion. On success, the operation status's
`properties.resourceId` identifies the job resource to retrieve. History requires
an ISO 8601 `fromDate` query parameter. Its pageable response contains `value` and
an optional `nextLink`. Generated SDKs can expose this operation as a pageable sequence.
The action specifications also declare bodyless `204` completion; initial submission
still returns `202`, and polling the status-monitor URL still returns a status document.
The collection request's `toDate` must be later than `fromDate`.

## Configuration

### Basic Information

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-06-01-preview
```

### Tag: package-2026-06-01-preview

```yaml $(tag) == 'package-2026-06-01-preview'
title: Microsoft.EdgeOperator - Azure Local Disconnected Operations log collection
input-file:
  - preview/2026-06-01-preview/logCollections.json
```

### Suppressions

Use Swagger basenames in `from`: AutoRest matches suppressions against internal
source URIs with percent-encoded directory separators before decoding them for diagnostics.

```yaml
suppressions:
  - code: AllProxyResourcesShouldHaveDelete
    from: logCollections.json
    where: $.definitions.LogCollection
    reason: Log collection jobs are service-created history records and cannot be deleted by callers.
directive:
  - suppress: OperationsAPIImplementation
    from: logCollections.json
    reason: The shared Microsoft.EdgeOperator Operations API is published by the sibling SystemReadiness project.
```
