
# TimeSeriesInsights

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Time Series Insights Data Plane API.

---

## Getting Started

To build the SDK for Azure Time Series Insights Data Plane API, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information

These are the global settings for Azure Time Series Insights Data Plane API.

``` yaml
openapi-type: data-plane
add-credentials: true
license-header: MICROSOFT_MIT
tag: package-2018-11-01-preview
```

### Tag: package-2018-11-01-preview

These settings apply only when `--tag=package-2018-11-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-11-01-preview'
input-file:
- Microsoft.TimeSeriesInsights/preview/2018-11-01-preview/timeseriesinsights.json
```

## Suppression

``` yaml
directive:
  - suppress: R2001
    reason: Adding flattening does not improve the code - array of properties is not supported by flattening.
```

``` yaml
directive:
  - suppress: R3017
    reason: GUIDs are required to enforce referential constraints and reduce number of updates.
```

---
# Code Generation

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  sync-methods: none
  azure-arm: false
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.TimeSeriesInsights
  output-folder: $(csharp-sdks-folder)/TimeSeriesInsights/DataPlane.TimeSeriesInsights/Generated
```