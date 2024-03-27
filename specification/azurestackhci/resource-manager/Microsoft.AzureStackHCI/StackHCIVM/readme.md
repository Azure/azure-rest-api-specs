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
tag: package-preview-2024-02-01
```

## Suppression

```yaml
directive:
  - suppress: R3020
    from:
      - preview/2024-02-01-preview/openapi.json
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
```

### Tag: package-preview-2024-02

These settings apply only when `--tag=package-preview-2024-02-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-02-01'
input-file:
  - preview/2024-02-01-preview/openapi.json
```
