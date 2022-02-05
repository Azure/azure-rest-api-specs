# Deployment Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for Deployment Admin.

---
## Getting Started
To build the SDK for Deployment Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the Deployment Resource Provider API.

``` yaml
title: DeploymentAdminClient
description: Deployment Admin Client
openapi-type: arm
tag: package-2019-01-01
```

``` yaml
input-file: 
  - $(this-folder)/Microsoft.Deployment.Admin/preview/2019-01-01/Deployment.json
  - $(this-folder)/Microsoft.Deployment.Admin/preview/2019-01-01/ActionPlan.json
  - $(this-folder)/Microsoft.Deployment.Admin/preview/2019-01-01/ActionPlanOperation.json
  - $(this-folder)/Microsoft.Deployment.Admin/preview/2019-01-01/FileContainer.json
  - $(this-folder)/Microsoft.Deployment.Admin/preview/2019-01-01/ProductDeployment.json
  - $(this-folder)/Microsoft.Deployment.Admin/preview/2019-01-01/ProductPackage.json
  - $(this-folder)/Microsoft.Deployment.Admin/preview/2019-01-01/ProductSecret.json
```

---
# Code Generation

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.AzureStack.Management.Deployment.Admin
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/Generated
  clear-output-folder: true
```
