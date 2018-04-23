# InfrastructureInsights Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for InfrastructureInsights Admin.

---
## Getting Started
To build the SDK for InfrastructureInsights Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the InfrastructureInsights API.

``` yaml
title: InfrastructureInsightsAdminClient
description: InfrastructureInsights Admin Client
openapi-type: arm
tag: package-2016-05-01
```

### Tag: package-2016-05-01

These settings apply only when `--tag=package-2016-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2016-05-01'
input-file:
    - Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/InfrastructureInsights.json
    - Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/Alert.json
    - Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/RegionHealth.json
    - Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/ResourceHealth.json
    - Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/ServiceHealth.json
```

---
# Code Generation

## Swagger to SDK

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.AzureStack.Management.InfrastructureInsights.Admin
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/Generated
  clear-output-folder: true
```
