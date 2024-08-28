# azurestackhci

> see https://aka.ms/autorest

This is the AutoRest configuration file for azurestackhci.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the azurestackhci.

```yaml
title: Microsoft.AzureStackHCI
description: Azure Stack HCI management service
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2024-05-01-preview
```

## Suppression

```yaml
directive:
  - suppress: R3020
    from:
      - stackhcivm.json
      - operations.json
    reason: Microsoft.AzureStackHCI is the correct name for our RP.
suppressions:
  - code: PathResourceProviderNamePascalCase
    reason: We had already gone to production with "HCI" in our namespace, so changing it to "Hci" now would be disruptive.
    from: 
      - stackhcivm.json
      - operations.json
  - code: DefinitionsPropertiesNamesCamelCase
    reason: There is a false positive reporting the two letter acronym ID should be lower camel case. The property is correctly capitalized according to guidance.
    from: 
      - stackhcivm.json
      - operations.json
  - code:  XmsPageableForListCalls
    reason: XmsPageable not needed for GET calls
    from:
      - stackhcivm.json
  - code: EvenSegmentedPathForPutOperation
    reason: resourceUri in virtualmachineinstances is the parent resource. It consists of an even number of segmented paths. 
    from: 
      - stackhcivm.json
```

### Tag: package-preview-2024-05

These settings apply only when `--tag=package-preview-2024-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05-01-preview'
input-file:
  - preview/2024-05-01-preview/stackhcivm.json
  - ../operations/preview/2024-05-01-preview/operations.json
```

### Tag: package-preview-2024-02

These settings apply only when `--tag=package-preview-2024-02-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-02-01'
input-file:
  - preview/2024-02-01-preview/stackhcivm.json
  - ../operations/preview/2024-02-01-preview/operations.json
```