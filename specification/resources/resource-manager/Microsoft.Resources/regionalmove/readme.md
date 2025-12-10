# RegionalMove

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
title: RegionalMoveServiceClient
description: Regional Move Service Client
openapi-type: arm
tag: package-2026-01
```

### Tag: package-2026-01

These settings apply only when `--tag=package-2026-01` is specified on the command line.

``` yaml $(tag) == 'package-2026-01'
input-file:
  - preview/2026-01-01-preview/regionalMove.json
```

## Suppression

``` yaml
directive:
  - suppress: OperationsAPIImplementation
    from: regionalMove.json
    reason: Operations API is implemented as a separate service.
  - suppress: AvoidAdditionalProperties
    from: regionalMove.json
    where: $.definitions.RegionalMoveRequestedResource.properties.resourceOverrides
    reason: Regional Move Containers allow overriding resource properties during copy operations. These can be any arbitrary ARM resource properties. We pass them through as-is to the RP.
```