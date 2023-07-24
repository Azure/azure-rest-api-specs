# AzureBridge Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for IBM PowerVm.

---
## Getting Started
To build the SDK for AzureBridge Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the IBM PowerVM API.

``` yaml
title: IBMPowerClient
description: IBMPower Client
openapi-type: arm
openapi-subtype: providerHub
tag: package-2023-05
```

### Tag: 2023-05-01

These settings apply only when `--tag=package-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-2023-05'
input-file:
    - Microsoft.IbmPower/preview/2023-05-01-preview/IbmPower.json
```