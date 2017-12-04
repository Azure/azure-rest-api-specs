# OperationalInsightsData

> see https://aka.ms/autorest

This is the AutoRest configuration file for OperationalInsightsData.

---

## Getting Started

To build the SDK for OperationalInsightsData, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information

These are the global settings for the OperationalInsightsData API.

``` yaml
title: OperationalInsightsDataClient
description: Operational Insights Data Client
add-credentials: true
openapi-type: data-plane
tag: v1
```

### Tag: v1

These settings apply only when `--tag=v1` is specified on the command line.

``` yaml $(tag) == 'v1'
input-file:
- Microsoft.OperationalInsights/v1/OperationalInsights.json
```

---

# Code Generation

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  namespace: Microsoft.Azure.OperationalInsights
  output-folder: $(csharp-sdks-folder)/OperationalInsights/DataPlane/OperationalInsights/Generated
  clear-output-folder: true
  payload-flattening-threshold: 3
directive:
  - reason: Don't expose the GET endpoint since it's behavior is more limited than POST
    remove-operation: Query_Get
  - reason: Rename Query_Post to Query so that we don't get an IQuery interface with 1 operation
    where-operation: Query_Post
    transform: $.operationId = "Query"
```