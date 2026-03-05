# AzureComputeBulkActionsClient

> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureComputeBulkActionsClient.

---

## Getting Started

To build the SDK for AzureComputeBulkActionsClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the AzureComputeBulkActionsClient API.

``` yaml !$(python) || !$(track2)
title: ComputeBulkActionsResourceProviderClient
```

``` yaml
description: The Compute Bulk Actions Resource Provider Client
openapi-type: arm
tag: package-2026-03-01-preview

suppressions:
  - code: OperationsAPIImplementation
    reason: The operations API is defined in a separate file.
    from: Bulkactions.json
```

### Tag: package-2026-03-01-preview

These settings apply only when `--tag=package-2026-03-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2026-03-01-preview'
input-file:
- preview/2026-03-01-preview/Bulkactions.json
```
