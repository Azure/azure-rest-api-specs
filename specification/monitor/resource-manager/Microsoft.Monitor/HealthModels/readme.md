# AzureMonitorHealthModelsClient

> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureMonitorHealthModelsClient.

---

## Getting Started

To build the SDK for AzureMonitorHealthModelsClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the AzureMonitorHealthModelsClient API.

``` yaml !$(python) || !$(track2)
title: AzureMonitorHealthModelsClient
```

``` yaml
description: Azure Monitor HealthModels Management Client
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-05-03-preview
```

### Tag: package-2025-05-03-preview

These settings apply only when `--tag=package-2025-05-03-preview` is specified on the command line

``` yaml $(tag) == 'package-2025-05-03-preview'
input-file:
- preview/2025-05-03-preview/healthmodels.json
```

## Suppression

``` yaml
suppressions:
  - code: OperationsAPIImplementation
    reason: Operations API is defined in a separate swagger spec for Microsoft.Monitor namespace (https://github.com/Azure/azure-rest-api-specs/blob/master/specification/monitor/resource-manager/Microsoft.Monitor/Operations)
    from: healthmodels.json
```
