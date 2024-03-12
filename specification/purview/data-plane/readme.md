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
tag: package-preview-2024-03
```


### Tag: package-preview-2024-03

These settings apply only when `--tag=package-preview-2024-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-03'
input-file:
  - Azure.Analytics.Purview.DataMap/preview/2024-03-01-preview/purviewdatamap.json
```
### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-10'
input-file:
  - Azure.Analytics.Purview.DataMap/preview/2023-10-01-preview/purviewdatamap.json
```

### Tag: package-2023-09

These settings apply only when `--tag=package-2023-09` is specified on the command line.

``` yaml $(tag) == 'package-2023-09'
input-file:
  - Azure.Analytics.Purview.DataMap/stable/2023-09-01/purviewdatamap.json
```

### Tag: package-preview-2023-02

These settings apply only when `--tag=package-preview-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-02'
input-file:
  - Azure.Analytics.Purview.Catalog/preview/2023-02-01-preview/purviewcatalog.json
```

### Tag: package-2022-11-01-preview

These settings apply only when `--tag=package-2022-11-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-11-01-preview'
input-file:
  - Azure.Analytics.Purview.DevopsPolicies/preview/2022-11-01-preview/purviewDevopsPolicy.json
```

### Tag: package-preview-2022-08

These settings apply only when `--tag=package-preview-2022-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-08'
input-file:
  - Azure.Analytics.Purview.Catalog/preview/2022-08-01-preview/purviewcatalog.json
```

### Tag: package-2022-12-01-preview

These settings apply only when `--tag=package-2022-12-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-12-01-preview'
input-file:
  - Azure.Analytics.Purview.SelfServicePolicies/preview/2022-12-01-preview/purviewSelfServicePolicy.json
```

### Tag: package-preview-2022-03

These settings apply only when `--tag=package-preview-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-03'
input-file:
  - Azure.Analytics.Purview.Catalog/preview/2022-03-01-preview/purviewcatalog.json
```

### Tag: package-2021-05-01-preview

These settings apply only when `--tag=package-2021-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-05-01-preview'
input-file:
  - Azure.Analytics.Purview.Catalog/preview/2021-05-01-preview/purviewcatalog.json
```

These are the global settings for the Purview Scanning API.

``` yaml
openapi-type: data-plane
tag: package-2018-12-01-preview
title: PurviewScanningClient
```

### Tag: package-2023-09

These settings apply only when `--tag=package-2023-09` is specified on the command line.

``` yaml $(tag) == 'package-2023-09-01'
input-file:
  - Azure.Analytics.Purview.Scanning/stable/2023-09-01/scanningService.json
```

### Tag: package-2022-07-01-preview

These settings apply only when `--tag=package-2022-07-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-07-01-preview'
input-file:
  - Azure.Analytics.Purview.Scanning/preview/2022-07-01-preview/scanningService.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-2022-02-01-preview

These settings apply only when `--tag=package-2022-02-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-02-01-preview'
input-file:
  - Azure.Analytics.Purview.Scanning/preview/2022-02-01-preview/scanningService.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-2021-10-01-preview

These settings apply only when `--tag=package-2021-10-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-10-01-preview'
input-file:
  - Azure.Analytics.Purview.Scanning/preview/2021-10-01-preview/scanningService.json
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-2018-12-01-preview

These settings apply only when `--tag=package-2018-12-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-12-01-preview'
input-file:
  - Azure.Analytics.Purview.Scanning/preview/2018-12-01-preview/scanningService.json
modelerfour:
  lenient-model-deduplication: true
```

These are the global settings for the Purview Workflow API.

``` yaml
openapi-type: data-plane
tag: package-2022-05-01-preview
```

### Tag: package-2022-05-01-preview

These settings apply only when `--tag=package-2022-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-05-01-preview'
input-file:
- Azure.Analytics.Purview.Workflow/preview/2022-05-01-preview/purviewWorkflow.json
```

### Tag: package-2023-10-01-preview

These settings apply only when `--tag=package-2023-10-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-10-01-preview'
input-file:
- Azure.Analytics.Purview.Workflow/preview/2023-10-01-preview/purviewWorkflow.json
```

These are the global settings for the Purview Metadata Policy API.

``` yaml
openapi-type: data-plane
tag: package-2021-07-01-preview
title: PurviewMetadataPolicyClient
```

### Tag: package-2021-07-01-preview

These settings apply only when `--tag=package-2021-07-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-07-01-preview'
input-file:
  - Azure.Analytics.Purview.MetadataPolicies/preview/2021-07-01-preview/purviewMetadataPolicy.json
modelerfour:
  lenient-model-deduplication: true
```

``` yaml
openapi-type: data-plane
tag: package-2021-09-01-preview
title: PurviewShareClient
```

### Tag: package-2021-09-01-preview

These settings apply only when `--tag=package-2021-09-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-09-01-preview'
input-file:
  - Azure.Analytics.Purview.Share/preview/2021-09-01-preview/share.json
```

``` yaml
openapi-type: data-plane
tag: package-2023-02-15-preview
title: PurviewShareClient
```

### Tag: package-2023-02-15-preview

These settings apply only when `--tag=package-2023-02-15-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-02-15-preview'
input-file:
  - Azure.Analytics.Purview.Share/preview/2023-02-15-preview/share.json
```

``` yaml
openapi-type: data-plane
tag: package-2023-05-30-preview
title: PurviewShareClient
```

### Tag: package-2023-05-30-preview

These settings apply only when `--tag=package-2023-05-30-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-05-30-preview'
input-file:
  - Azure.Analytics.Purview.Share/preview/2023-05-30-preview/share.json
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
  - suppress: AvoidAnonymousParameter
    from: purviewdatamap.json
    reason: This rule is irrelevant for data-plane TypeSpec specs.
  - suppress: AvoidAnonymousTypes
    from: purviewdatamap.json
    reason: This rule is irrelevant for data-plane TypeSpec specs.
  - suppress: IntegerTypeMustHaveFormat
    from: purviewdatamap.json
    reason: This rule is irrelevant for SDKs generated directly by TypeSpec.
```

``` yaml
directive:
  - suppress: R3013
where:
  - $.paths[\"/atlas/v2/glossary/terms/{termGuid}/assignedEntities\"].delete.parameters[1]
  - $.paths[\"/atlas/v2/types/typedefs\"].delete.parameters[0]
from: purviewcatalog.json
reason: This property is the discriminator for polymorph, but it can not be in request body.
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

``` yaml
directive:
  - suppress: R3006
where:
  - $.definitions.WorkflowDefinition.properties
from: purviewWorkflow.json
reason: Currently systemData is not allowed.
```

``` yaml
directive:
  - suppress: R2020
where:
  - $.definitions.WorkflowDefinition.properties
from: purviewWorkflow.json
reason: Workflow definition is not a resource.
```

``` yaml
directive:
  - suppress: R3023
where:
  - $.definitions.WorkflowDefinition.properties
from: purviewWorkflow.json
reason: No operations endpoint as not ARM resource provider.
```

``` yaml
directive:
  - suppress: R2062
where:
  - $.definitions.WorkflowDefinition.properties
from: purviewWorkflow.json
reason: Workflow is not ARM resource.
```

``` yaml
directive:
  - suppress: R4011
where:
  - $.definitions.WorkflowDefinition.properties
from: purviewWorkflow.json
reason: The delete workflow definition operation have the required responses.
```

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
```
