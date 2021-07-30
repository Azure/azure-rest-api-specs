# Purview

> see https://aka.ms/autorest

This is the AutoRest configuration file for Purview.



---
## Getting Started
To build the SDK for Purview, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the Azure Purview Catalog API.

``` yaml
openapi-type: data-plane
tag: package-2021-05-01-preview
```


### Tag: package-2021-05-01-preview

These settings apply only when `--tag=package-2021-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-05-01-preview'
input-file:
- Azure.Analytics.Purview.Catalog/preview/2021-05-01-preview/purviewcatalog.json
```

These are the global settings for the Purview API.

``` yaml
openapi-type: data-plane
tag: package-2018-12-01-preview
title: PurviewScanningClient
```


### Tag: package-2018-12-01-preview

These settings apply only when `--tag=package-2018-12-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-12-01-preview'
input-file:
- Azure.Analytics.Purview.Scanning/preview/2018-12-01-preview/scanningService.json
modelerfour:
  lenient-model-deduplication: true
```

---
# Code Generation

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Purview.CatalogClient
  add-credentials: true
  output-folder: $(csharp-sdks-folder)/purview/Microsoft.Azure.Analytics.Purview.Catalog/src/Generated
  clear-output-folder: true
```

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Purview.CatalogClient
  add-credentials: true
  output-folder: $(azure-libraries-for-java-folder)/purview/Microsoft.Azure.Analytics.Purview.Catalog/src/Generated
  clear-output-folder: true
output-folder: $(csharp-sdks-folder)/Purview/ScanningClient/Generated
add-credentials: true
sync-methods: all
license-header: MICROSOFT_MIT_NO_VERSION
namespace: Azure.Analytics.Purview.Scanning
clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Suppression

``` yaml
directive:
  - suppress: R3013
where:
  - $.paths[\"/atlas/v2/glossary/terms/{termGuid}/assignedEntities\"].delete.parameters[1]
  - $.paths[\"/atlas/v2/types/typedefs\"].delete.parameters[0]
from: purviewcatalog.json
reason:  This property is the discriminator for polymorph, but it can not be in request body.
```

``` yaml
directive:
  - suppress: R2026
from: purviewcatalog.json
reason: Should be compatible with Atlas swagger.
```

``` yaml
directive:
  - suppress: D5001
where:
  - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/xxx.get
reason: It doesn't support file annotation in example file.
```

