# AzureBridge Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for BootstrapRP.

---
## Getting Started
To build the SDK for AzureBridge Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the BootstrapRP API.

``` yaml
title: BootstrapRP
description: BootstrapRP Client
openapi-type: arm
openapi-subtype: providerHub
tag: package-2025-08-01-preview
```

### Tag: 2025-08-01-preview

These settings apply only when `--tag=package-2025-08-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2025-08-01-preview'
input-file:
    - Microsoft.BareMetal/preview/2025-08-01-preview/BootstrapRP.json
suppressions:
    - code: XmsPageableForListCalls
      where: $.paths["/providers/Microsoft.BareMetal/locations/{location}/utilization"].get
      reason: Partner wants to ensure return value of existing API doesn't change
    - code: GetCollectionOnlyHasValueAndNextLink
      where: $.paths["/providers/Microsoft.BareMetal/locations/{location}/utilization"].get.responses["200"].schema.properties
      reason: Partner wants to ensure return value of existing API doesn't change
```

### Tag: 2025-02-01-preview

These settings apply only when `--tag=package-2025-02-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2025-02-01-preview'
input-file:
    - Microsoft.BareMetal/preview/2025-02-01-preview/BootstrapRP.json
suppressions:
    - code: XmsPageableForListCalls
      where: $.paths["/providers/Microsoft.BareMetal/locations/{location}/utilization"].get
      reason: Partner wants to ensure return value of existing API doesn't change
    - code: GetCollectionOnlyHasValueAndNextLink
      where: $.paths["/providers/Microsoft.BareMetal/locations/{location}/utilization"].get.responses["200"].schema.properties
      reason: Partner wants to ensure return value of existing API doesn't change
```

### Tag: 2024-12-01-preview

These settings apply only when `--tag=package-2024-12-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-12-01-preview'
input-file:
    - Microsoft.BareMetal/preview/2024-12-01-preview/BootstrapRP.json
```

### Tag: 2024-06-01-preview

These settings apply only when `--tag=package-2024-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-06-01-preview'
input-file:
    - Microsoft.BareMetal/preview/2024-06-01-preview/BootstrapRP.json
```

### Tag: 2023-12-01

These settings apply only when `--tag=package-2023-12` is specified on the command line.

``` yaml $(tag) == 'package-2023-12'
input-file:
    - Microsoft.BareMetal/preview/2023-12-01/BootstrapRP.json
```