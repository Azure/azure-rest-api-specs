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
tag: package-preview-2025-09-01-preview
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
  - code: XmsPageableForListCalls
    reason: XmsPageable not needed for GET calls
    from:
      - stackhcivm.json
  - code: EvenSegmentedPathForPutOperation
    reason: resourceUri in virtualmachineinstances is the parent resource. It consists of an even number of segmented paths.
    from:
      - stackhcivm.json
```

### Tag: package-preview-2025-09-01-preview
These settings apply only when `--tag=package-preview-2025-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-09-01-preview'
input-file:
  - preview/2025-09-01-preview/stackhcivm.json
```

### Tag: package-preview-2025-06-01-preview
These settings apply only when `--tag=package-preview-2025-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-06-01-preview'
input-file:
  - preview/2025-06-01-preview/stackhcivm.json
```

### Tag: package-preview-2025-04-01-preview

These settings apply only when `--tag=package-preview-2025-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-04-01-preview'
input-file:
  - preview/2025-04-01-preview/stackhcivm.json
```

### Tag: package-preview-2025-02-01-preview

These settings apply only when `--tag=package-preview-2025-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-02-01-preview'
input-file:
  - preview/2025-02-01-preview/stackhcivm.json
```

### Tag: package-preview-2024-10-01-preview

These settings apply only when `--tag=package-preview-2024-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-10-01-preview'
input-file:
  - preview/2024-10-01-preview/stackhcivm.json
```

### Tag: package-preview-2024-08

These settings apply only when `--tag=package-preview-2024-08` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-08'
input-file:
  - preview/2024-08-01-preview/stackhcivm.json
```

### Tag: package-preview-2024-05

These settings apply only when `--tag=package-preview-2024-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05-01-preview'
input-file:
  - preview/2024-05-01-preview/stackhcivm.json
```

### Tag: package-preview-2024-02

These settings apply only when `--tag=package-preview-2024-02-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-02-01'
input-file:
  - preview/2024-02-01-preview/stackhcivm.json
```

### Tag: package-2024-01

These settings apply only when `--tag=package-2024-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-01'
input-file:
  - stable/2024-01-01/common.json
  - stable/2024-01-01/galleryImages.json
  - stable/2024-01-01/logicalNetworks.json
  - stable/2024-01-01/marketplaceGalleryImages.json
  - stable/2024-01-01/networkInterfaces.json
  - stable/2024-01-01/operations.json
  - stable/2024-01-01/storageContainers.json
  - stable/2024-01-01/virtualHardDisks.json
  - stable/2024-01-01/virtualMachineInstances.json
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-09'
input-file:
  - preview/2023-09-01-preview/common.json
  - preview/2023-09-01-preview/galleryImages.json
  - preview/2023-09-01-preview/logicalNetworks.json
  - preview/2023-09-01-preview/marketplaceGalleryImages.json
  - preview/2023-09-01-preview/networkInterfaces.json
  - preview/2023-09-01-preview/storageContainers.json
  - preview/2023-09-01-preview/virtualHardDisks.json
  - preview/2023-09-01-preview/virtualMachineInstances.json
```

### Tag: package-preview-2023-07

These settings apply only when `--tag=package-preview-2023-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-07'
input-file:
  - preview/2023-07-01-preview/galleryImages.json
  - preview/2023-07-01-preview/marketplaceGalleryImages.json
  - preview/2023-07-01-preview/networkInterfaces.json
  - preview/2023-07-01-preview/storageContainers.json
  - preview/2023-07-01-preview/virtualHardDisks.json
  - preview/2023-07-01-preview/virtualMachineInstances.json
  - preview/2023-07-01-preview/virtualNetworks.json
```

### Tag: package-preview-2022-12-15

These settings apply only when `--tag=package-preview-2022-12-15` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-12-15'
input-file:
  - preview/2022-12-15-preview/common.json
  - preview/2022-12-15-preview/galleryImages.json
  - preview/2022-12-15-preview/marketplaceGalleryImages.json
  - preview/2022-12-15-preview/networkInterfaces.json
  - preview/2022-12-15-preview/operations.json
  - preview/2022-12-15-preview/storageContainers.json
  - preview/2022-12-15-preview/virtualHardDisks.json
  - preview/2022-12-15-preview/virtualMachines.json
  - preview/2022-12-15-preview/virtualNetworks.json
```

### Tag: package-preview-2021-09

These settings apply only when `--tag=package-preview-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-09'
input-file:
  - preview/2021-09-01-preview/galleryImages.json
  - preview/2021-09-01-preview/marketplaceGalleryImages.json
  - preview/2021-09-01-preview/networkInterfaces.json
  - preview/2021-09-01-preview/operations.json
  - preview/2021-09-01-preview/storageContainers.json
  - preview/2021-09-01-preview/virtualHardDisks.json
  - preview/2021-09-01-preview/virtualMachines.json
  - preview/2021-09-01-preview/virtualNetworks.json
```

### Tag: package-preview-2021-07

These settings apply only when `--tag=package-preview-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-07'
input-file:
  - preview/2021-07-01-preview/galleryImages.json
  - preview/2021-07-01-preview/networkInterfaces.json
  - preview/2021-07-01-preview/virtualHardDisks.json
  - preview/2021-07-01-preview/virtualMachines.json
  - preview/2021-07-01-preview/virtualNetworks.json
  - preview/2021-07-01-preview/operations.json
```
