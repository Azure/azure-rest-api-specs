# Bicep

> see https://aka.ms/autorest
This is the AutoRest configuration file.

## Getting Started

To build the SDKs, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings.

``` yaml
title: BicepClient
description: Bicep Client
openapi-type: arm
tag: package-2023-11
```

### Tag: package-2023-11

These settings apply only when `--tag=package-2023-11` is specified on the command line.

``` yaml $(tag) == 'package-2023-11'
input-file:
  - stable/2023-11-01/bicepClient.json
```

## Suppression

``` yaml
directive:
  - suppress: OperationsAPIImplementation
    from: bicepClient.json
    reason: Operations API is implemented as a separate service.
```