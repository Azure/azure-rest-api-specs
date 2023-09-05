# M365CustomerKey

> see https://aka.ms/autorest

This is the AutoRest Configuration file for M365CustomerKey

---
## Getting Started
To build the SDK for AzureBridge Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:
> `autorest`
To see additional help and options, run:
> `autorest --help`
---
## Configuration
### Basic Information
These are the global settings for the M365CustomerKey API.
``` yaml
title: M365CustomerKeyClient
description: M365CustomerKey Client
openapi-type: arm
tag: 2021-08-01-preview
```
### Tag: 2021-08-01-preview
These settings apply only when `--tag=2021-08-01-preview` is specified on the command line.
``` yaml $(tag) == '2021-08-01-preview'
input-file:
    - Microsoft.M365CustomerKey\preview\2021-08-01-preview/openapi.json
```