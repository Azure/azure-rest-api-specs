# Batch

> see https://aka.ms/autorest

This is the AutoRest configuration file for Batch.

---

## Getting Started

To build the SDK for Batch, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Batch API.

``` yaml
title: Azure.Batch
openapi-type: data-plane
input-file: Microsoft.Batch\2023-01-01.17.0\BatchService.json
```

## Code Generation

## Swagger to SDK

## C\#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  client-side-validation: false
  namespace: Azure.Data.Batch
  public-clients: false
  output-folder: E:\hpc\azure-sdk-for-net/sdk/batch/Azure.Batch/src/Generated
```
