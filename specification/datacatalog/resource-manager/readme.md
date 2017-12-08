# Data Catalog

> see https://aka.ms/autorest

This is the AutoRest configuration file for Data Catalog.



---
## Getting Started
To build the SDK for Data Catalog, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration


### Basic Information
These are the global settings for the Data Catalog API.

``` yaml
title: DataCatalogRestClient
description: The Azure Data Catalog management API provides a RESTful set of web services that interact with Azure Data Catalog services.
openapi-type: arm
tag: package-2016-03-30
```

### Tag: package-2016-03-30

These settings apply only when `--tag=package-2016-03-30` is specified on the command line.

``` yaml $(tag) == 'package-2016-03-30'
input-file:
- Microsoft.DataCatalog/2016-03-30/datacatalog.json
```

---
# Code Generation

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.DataCatalog
  output-folder: $(csharp-sdks-folder)/DataCatalog/Management.DataCatalog/Generated
  clear-output-folder: true
```

# Validation

## Suppression

``` yaml
directive:
  - suppress: R3018  # EnumInsteadOfBoolean
    where: 
      - $.definitions.ADCCatalogProperties.properties.successfullyProvisioned
      - $.definitions.ADCCatalogProperties.properties.enableAutomaticUnitAdjustment
    from: datacatalog.json
    reason: Booleans are used to indicate binary states of the property, enum is not appropriate.
  - suppress: R3027  # TrackedResourceListByResourceGroup
    where: 
      - $.definitions.ADCCatalog
    from: datacatalog.json
    reason: Catalog is per tenant level resources.
  - suppress: R3028  # TrackedResourceListBySubscription
    where: 
      - $.definitions.ADCCatalog
    from: datacatalog.json
    reason: Catalog can only be listed by resource group.
```