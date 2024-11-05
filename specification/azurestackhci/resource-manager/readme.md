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

``` yaml
title: AzureStackHCIClient
description: Azure Stack HCI management service
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-01
```

## Suppression

``` yaml
directive:
  - suppress: R3020
    from:
      - arcSettings.json
      - clusters.json
      - extensions.json
      - galleryImages.json
      - logicalNetworks.json
      - marketplaceGalleryImages.json
      - networkInterfaces.json
      - operations.json
      - storageContainers.json
      - virtualHardDisks.json
      - virtualMachines.json
      - virtualMachineInstances.json
      - virtualNetworks.json
      - offers.json
      - publishers.json
      - skus.json
      - updates.json
      - updateRuns.json
      - updateSummaries.json
      - deploymentSettings.json
      - edgeDevices.json
      - securitySettings.json
      - hciCommon.json
    reason: Microsoft.AzureStackHCI is the correct name for our RP.
suppressions:
  - code: PathResourceProviderNamePascalCase
    reason: We had already gone to production with "HCI" in our namespace, so changing it to "Hci" now would be disruptive.
  - code: TopLevelResourcesListBySubscription
    reason: It is reporting issue for proxy extension resource which doesn't have use case to ListBySubscription as this resource will always tied to one parent resource only. Additionally, there is a 1:1 relationship between HybridCompute Machines and AzureStackHCI VirtualMachineInstances.
  - code: PropertiesTypeObjectNoDefinition
    reason: These are existing properties already supported as part of PUT extensions call. Same properties are being supported for extensions Patch now.  
    from: extensions.json
  - code: DefinitionsPropertiesNamesCamelCase
    reason: There is a false positive reporting the two letter acronym ID should be lower camel case. The property is correctly capitalized according to guidance. 
    from: logicalNetworks.json
  - code: ResourceNameRestriction
    reason: publisherName, publisherName etc didn't have a pattern initially, adding the constraint now will cause a breaking change.
  - code: DefinitionsPropertiesNamesCamelCase
    reason: We have a dependency on other team which is already using these values, changing it will break backward compatibility.
  - code: ProvisioningStateSpecifiedForLROPut
    reason: already working without the properties section, adding it will break polymorphism
    from:
      - edgeDevices.json
```

### Tag: package-preview-2024-02

These settings apply only when `--tag=package-preview-2024-02` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-02'
input-file:
  - Microsoft.AzureStackHCI/preview/2024-02-15-preview/arcSettings.json
  - Microsoft.AzureStackHCI/preview/2024-02-15-preview/clusters.json
  - Microsoft.AzureStackHCI/preview/2024-02-15-preview/deploymentSettings.json
  - Microsoft.AzureStackHCI/preview/2024-02-15-preview/edgeDevices.json
  - Microsoft.AzureStackHCI/preview/2024-02-15-preview/extensions.json
  - Microsoft.AzureStackHCI/preview/2024-02-15-preview/offers.json
  - Microsoft.AzureStackHCI/preview/2024-02-15-preview/operations.json
  - Microsoft.AzureStackHCI/preview/2024-02-15-preview/publishers.json
  - Microsoft.AzureStackHCI/preview/2024-02-15-preview/securitySettings.json
  - Microsoft.AzureStackHCI/preview/2024-02-15-preview/skus.json
  - Microsoft.AzureStackHCI/preview/2024-02-15-preview/updateRuns.json
  - Microsoft.AzureStackHCI/preview/2024-02-15-preview/updateSummaries.json
  - Microsoft.AzureStackHCI/preview/2024-02-15-preview/updates.json
  - Microsoft.AzureStackHCI/preview/2024-02-15-preview/hciCommon.json
```

### Tag: package-2024-01

These settings apply only when `--tag=package-2024-01` is specified on the command line.

```yaml $(tag) == 'package-2024-01'
input-file:
  - Microsoft.AzureStackHCI/stable/2024-01-01/arcSettings.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/clusters.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/deploymentSettings.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/edgeDevices.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/common.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/extensions.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/galleryImages.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/logicalNetworks.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/marketplaceGalleryImages.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/networkInterfaces.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/offers.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/operations.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/publishers.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/securitySettings.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/skus.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/storageContainers.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/updateRuns.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/updateSummaries.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/updates.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/virtualHardDisks.json
  - Microsoft.AzureStackHCI/stable/2024-01-01/virtualMachineInstances.json
```

### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-11'
input-file:
  - Microsoft.AzureStackHCI/preview/2023-11-01-preview/arcSettings.json
  - Microsoft.AzureStackHCI/preview/2023-11-01-preview/clusters.json
  - Microsoft.AzureStackHCI/preview/2023-11-01-preview/deploymentSettings.json
  - Microsoft.AzureStackHCI/preview/2023-11-01-preview/edgeDevices.json
  - Microsoft.AzureStackHCI/preview/2023-11-01-preview/extensions.json
  - Microsoft.AzureStackHCI/preview/2023-11-01-preview/offers.json
  - Microsoft.AzureStackHCI/preview/2023-11-01-preview/operations.json
  - Microsoft.AzureStackHCI/preview/2023-11-01-preview/publishers.json
  - Microsoft.AzureStackHCI/preview/2023-11-01-preview/securitySettings.json
  - Microsoft.AzureStackHCI/preview/2023-11-01-preview/skus.json
  - Microsoft.AzureStackHCI/preview/2023-11-01-preview/updateRuns.json
  - Microsoft.AzureStackHCI/preview/2023-11-01-preview/updateSummaries.json
  - Microsoft.AzureStackHCI/preview/2023-11-01-preview/updates.json
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-09'
input-file:
  - Microsoft.AzureStackHCI/preview/2023-09-01-preview/common.json
  - Microsoft.AzureStackHCI/preview/2023-09-01-preview/galleryImages.json
  - Microsoft.AzureStackHCI/preview/2023-09-01-preview/logicalNetworks.json
  - Microsoft.AzureStackHCI/preview/2023-09-01-preview/marketplaceGalleryImages.json
  - Microsoft.AzureStackHCI/preview/2023-09-01-preview/networkInterfaces.json
  - Microsoft.AzureStackHCI/preview/2023-09-01-preview/storageContainers.json
  - Microsoft.AzureStackHCI/preview/2023-09-01-preview/virtualHardDisks.json
  - Microsoft.AzureStackHCI/preview/2023-09-01-preview/virtualMachineInstances.json
```

### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-08'
input-file:
  - Microsoft.AzureStackHCI/preview/2023-08-01-preview/arcSettings.json
  - Microsoft.AzureStackHCI/preview/2023-08-01-preview/clusters.json
  - Microsoft.AzureStackHCI/preview/2023-08-01-preview/extensions.json
  - Microsoft.AzureStackHCI/preview/2023-08-01-preview/offers.json
  - Microsoft.AzureStackHCI/preview/2023-08-01-preview/operations.json
  - Microsoft.AzureStackHCI/preview/2023-08-01-preview/publishers.json
  - Microsoft.AzureStackHCI/preview/2023-08-01-preview/skus.json
  - Microsoft.AzureStackHCI/preview/2023-08-01-preview/updateRuns.json
  - Microsoft.AzureStackHCI/preview/2023-08-01-preview/updateSummaries.json
  - Microsoft.AzureStackHCI/preview/2023-08-01-preview/updates.json
  - Microsoft.AzureStackHCI/preview/2023-08-01-preview/deploymentSettings.json
  - Microsoft.AzureStackHCI/preview/2023-08-01-preview/edgeDevices.json
```

### Tag: package-2023-08

These settings apply only when `--tag=package-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-2023-08'
input-file:
  - Microsoft.AzureStackHCI/stable/2023-08-01/arcSettings.json
  - Microsoft.AzureStackHCI/stable/2023-08-01/clusters.json
  - Microsoft.AzureStackHCI/stable/2023-08-01/extensions.json
  - Microsoft.AzureStackHCI/stable/2023-08-01/offers.json
  - Microsoft.AzureStackHCI/stable/2023-08-01/operations.json
  - Microsoft.AzureStackHCI/stable/2023-08-01/publishers.json
  - Microsoft.AzureStackHCI/stable/2023-08-01/skus.json
  - Microsoft.AzureStackHCI/stable/2023-08-01/updateRuns.json
  - Microsoft.AzureStackHCI/stable/2023-08-01/updateSummaries.json
  - Microsoft.AzureStackHCI/stable/2023-08-01/updates.json
```

### Tag: package-preview-2023-07

These settings apply only when `--tag=package-preview-2023-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-07'
input-file:
  - Microsoft.AzureStackHCI/preview/2023-07-01-preview/galleryImages.json
  - Microsoft.AzureStackHCI/preview/2023-07-01-preview/marketplaceGalleryImages.json
  - Microsoft.AzureStackHCI/preview/2023-07-01-preview/networkInterfaces.json
  - Microsoft.AzureStackHCI/preview/2023-07-01-preview/storageContainers.json
  - Microsoft.AzureStackHCI/preview/2023-07-01-preview/virtualHardDisks.json
  - Microsoft.AzureStackHCI/preview/2023-07-01-preview/virtualMachineInstances.json
  - Microsoft.AzureStackHCI/preview/2023-07-01-preview/virtualNetworks.json
```

### Tag: package-2023-06

These settings apply only when `--tag=package-2023-06` is specified on the command line.

``` yaml $(tag) == 'package-2023-06'
input-file:
  - Microsoft.AzureStackHCI/stable/2023-06-01/arcSettings.json
  - Microsoft.AzureStackHCI/stable/2023-06-01/clusters.json
  - Microsoft.AzureStackHCI/stable/2023-06-01/extensions.json
  - Microsoft.AzureStackHCI/stable/2023-06-01/offers.json
  - Microsoft.AzureStackHCI/stable/2023-06-01/operations.json
  - Microsoft.AzureStackHCI/stable/2023-06-01/publishers.json
  - Microsoft.AzureStackHCI/stable/2023-06-01/skus.json
  - Microsoft.AzureStackHCI/stable/2023-06-01/updateRuns.json
  - Microsoft.AzureStackHCI/stable/2023-06-01/updateSummaries.json
  - Microsoft.AzureStackHCI/stable/2023-06-01/updates.json
```

### Tag: package-2023-03

These settings apply only when `--tag=package-2023-03` is specified on the command line.

``` yaml $(tag) == 'package-2023-03'
input-file:
  - Microsoft.AzureStackHCI/stable/2023-03-01/arcSettings.json
  - Microsoft.AzureStackHCI/stable/2023-03-01/clusters.json
  - Microsoft.AzureStackHCI/stable/2023-03-01/extensions.json
  - Microsoft.AzureStackHCI/stable/2023-03-01/offers.json
  - Microsoft.AzureStackHCI/stable/2023-03-01/operations.json
  - Microsoft.AzureStackHCI/stable/2023-03-01/publishers.json
  - Microsoft.AzureStackHCI/stable/2023-03-01/skus.json
  - Microsoft.AzureStackHCI/stable/2023-03-01/updateRuns.json
  - Microsoft.AzureStackHCI/stable/2023-03-01/updateSummaries.json
  - Microsoft.AzureStackHCI/stable/2023-03-01/updates.json
```

### Tag: package-2023-02

These settings apply only when `--tag=package-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-2023-02'
input-file:
  - Microsoft.AzureStackHCI/stable/2023-02-01/arcSettings.json
  - Microsoft.AzureStackHCI/stable/2023-02-01/clusters.json
  - Microsoft.AzureStackHCI/stable/2023-02-01/extensions.json
  - Microsoft.AzureStackHCI/stable/2023-02-01/offers.json
  - Microsoft.AzureStackHCI/stable/2023-02-01/operations.json
  - Microsoft.AzureStackHCI/stable/2023-02-01/publishers.json
  - Microsoft.AzureStackHCI/stable/2023-02-01/skus.json
  - Microsoft.AzureStackHCI/stable/2023-02-01/updateRuns.json
  - Microsoft.AzureStackHCI/stable/2023-02-01/updateSummaries.json
  - Microsoft.AzureStackHCI/stable/2023-02-01/updates.json
```

### Tag: package-preview-2022-12-15

These settings apply only when `--tag=package-preview-2022-12-15` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-12-15'
input-file:
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/arcSettings.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/clusters.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/common.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/extensions.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/galleryImages.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/marketplaceGalleryImages.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/networkInterfaces.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/offers.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/operations.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/publishers.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/skus.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/storageContainers.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/updateRuns.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/updateSummaries.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/updates.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/virtualHardDisks.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/virtualMachines.json
  - Microsoft.AzureStackHCI/preview/2022-12-15-preview/virtualNetworks.json
```

### Tag: package-2022-12

These settings apply only when `--tag=package-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-2022-12'
input-file:
  - Microsoft.AzureStackHCI/stable/2022-12-01/arcSettings.json
  - Microsoft.AzureStackHCI/stable/2022-12-01/clusters.json
  - Microsoft.AzureStackHCI/stable/2022-12-01/extensions.json
  - Microsoft.AzureStackHCI/stable/2022-12-01/offers.json
  - Microsoft.AzureStackHCI/stable/2022-12-01/operations.json
  - Microsoft.AzureStackHCI/stable/2022-12-01/publishers.json
  - Microsoft.AzureStackHCI/stable/2022-12-01/skus.json
  - Microsoft.AzureStackHCI/stable/2022-12-01/updateRuns.json
  - Microsoft.AzureStackHCI/stable/2022-12-01/updateSummaries.json
  - Microsoft.AzureStackHCI/stable/2022-12-01/updates.json
```

### Tag: package-preview-2022-10

These settings apply only when `--tag=package-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-2022-10'
input-file:
  - Microsoft.AzureStackHCI/stable/2022-10-01/arcSettings.json
  - Microsoft.AzureStackHCI/stable/2022-10-01/clusters.json
  - Microsoft.AzureStackHCI/stable/2022-10-01/extensions.json
  - Microsoft.AzureStackHCI/stable/2022-10-01/operations.json
  - Microsoft.AzureStackHCI/stable/2022-10-01/offers.json
  - Microsoft.AzureStackHCI/stable/2022-10-01/publishers.json
  - Microsoft.AzureStackHCI/stable/2022-10-01/skus.json
  - Microsoft.AzureStackHCI/stable/2022-10-01/updateRuns.json
  - Microsoft.AzureStackHCI/stable/2022-10-01/updateSummaries.json
  - Microsoft.AzureStackHCI/stable/2022-10-01/updates.json
```

### Tag: package-2022-09

These settings apply only when `--tag=package-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-2022-09'
input-file:
  - Microsoft.AzureStackHCI/stable/2022-09-01/arcSettings.json
  - Microsoft.AzureStackHCI/stable/2022-09-01/clusters.json
  - Microsoft.AzureStackHCI/stable/2022-09-01/extensions.json
  - Microsoft.AzureStackHCI/stable/2022-09-01/operations.json
```

### Tag: package-2022-05

These settings apply only when `--tag=package-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-2022-05'
input-file:
  - Microsoft.AzureStackHCI/stable/2022-05-01/arcSettings.json
  - Microsoft.AzureStackHCI/stable/2022-05-01/clusters.json
  - Microsoft.AzureStackHCI/stable/2022-05-01/extensions.json
  - Microsoft.AzureStackHCI/stable/2022-05-01/operations.json
```

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-2022-03'
input-file:
  - Microsoft.AzureStackHCI/stable/2022-03-01/arcSettings.json
  - Microsoft.AzureStackHCI/stable/2022-03-01/clusters.json
  - Microsoft.AzureStackHCI/stable/2022-03-01/extensions.json
  - Microsoft.AzureStackHCI/stable/2022-03-01/operations.json
```

### Tag: package-2022-01

These settings apply only when `--tag=package-2022-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-01'
input-file:
  - Microsoft.AzureStackHCI/stable/2022-01-01/arcSettings.json
  - Microsoft.AzureStackHCI/stable/2022-01-01/clusters.json
  - Microsoft.AzureStackHCI/stable/2022-01-01/extensions.json
  - Microsoft.AzureStackHCI/stable/2022-01-01/operations.json
```

### Tag: package-preview-2021-09

These settings apply only when `--tag=package-preview-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-09'
input-file:
  - Microsoft.AzureStackHCI/preview/2021-09-01-preview/arcSettings.json
  - Microsoft.AzureStackHCI/preview/2021-09-01-preview/clusters.json
  - Microsoft.AzureStackHCI/preview/2021-09-01-preview/extensions.json
  - Microsoft.AzureStackHCI/preview/2021-09-01-preview/galleryImages.json
  - Microsoft.AzureStackHCI/preview/2021-09-01-preview/marketplaceGalleryImages.json
  - Microsoft.AzureStackHCI/preview/2021-09-01-preview/networkInterfaces.json
  - Microsoft.AzureStackHCI/preview/2021-09-01-preview/operations.json
  - Microsoft.AzureStackHCI/preview/2021-09-01-preview/storageContainers.json
  - Microsoft.AzureStackHCI/preview/2021-09-01-preview/virtualHardDisks.json
  - Microsoft.AzureStackHCI/preview/2021-09-01-preview/virtualMachines.json
  - Microsoft.AzureStackHCI/preview/2021-09-01-preview/virtualNetworks.json
```

### Tag: package-2021-09

These settings apply only when `--tag=package-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-2021-09'
input-file:
  - Microsoft.AzureStackHCI/stable/2021-09-01/arcSettings.json
  - Microsoft.AzureStackHCI/stable/2021-09-01/clusters.json
  - Microsoft.AzureStackHCI/stable/2021-09-01/extensions.json
  - Microsoft.AzureStackHCI/stable/2021-09-01/operations.json
```

### Tag: package-preview-2021-07

These settings apply only when `--tag=package-preview-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-07'
input-file:
  - Microsoft.AzureStackHCI/preview/2021-07-01-preview/galleryImages.json
  - Microsoft.AzureStackHCI/preview/2021-07-01-preview/networkInterfaces.json
  - Microsoft.AzureStackHCI/preview/2021-07-01-preview/virtualHardDisks.json
  - Microsoft.AzureStackHCI/preview/2021-07-01-preview/virtualMachines.json
  - Microsoft.AzureStackHCI/preview/2021-07-01-preview/virtualNetworks.json
  - Microsoft.AzureStackHCI/preview/2021-07-01-preview/operations.json
```

### Tag: package-preview-2021-01

These settings apply only when `--tag=package-preview-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-01'
input-file:
  - Microsoft.AzureStackHCI/preview/2021-01-01-preview/arcSettings.json
  - Microsoft.AzureStackHCI/preview/2021-01-01-preview/clusters.json
  - Microsoft.AzureStackHCI/preview/2021-01-01-preview/extensions.json
  - Microsoft.AzureStackHCI/preview/2021-01-01-preview/operations.json
```

### Tag: package-2020-10-01

These settings apply only when `--tag=package-2020-10-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-10-01'
input-file:
  - Microsoft.AzureStackHCI/stable/2020-10-01/azurestackhci.json
```

### Tag: package-2020-03-01-preview

These settings apply only when `--tag=package-2020-03-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-03-01-preview'
input-file:
  - Microsoft.AzureStackHCI/preview/2020-03-01-preview/azurestackhci.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_azurestackhci']
  - repo: azure-resource-manager-schemas
    after_scripts:
      - node sdkauto_afterscript.js azurestackhci/resource-manager
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)
