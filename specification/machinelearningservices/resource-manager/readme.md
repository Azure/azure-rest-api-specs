# MachineLearningServices

> see https://aka.ms/autorest

This is the AutoRest configuration file for Machine Learning Services.

---

## Getting Started

To build the SDK for Azure Machine Learning, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Machine Learning Services API.

``` yaml
openapi-type: arm
tag: package-preview-2023-08
```


### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-08'
input-file:
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2023-08-01-preview/workspaceRP.json
suppressions:
  - code: LroPostReturn
    reason: LRO does not return 200 by design.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/resize"].post
  - code: TrackedResourcePatchOperation
    reason: server side don't support Patch yet track with https://msdata.visualstudio.com/Vienna/_workitems/edit/2702298.
    where:
      - $.definitions.PrivateEndpointConnection
```

### Tag: package-2023-10

These settings apply only when `--tag=package-2023-10` is specified on the command line.

```yaml $(tag) == 'package-2023-10'
input-file:
  - Microsoft.MachineLearningServices/stable/2023-10-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2023-10-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2023-10-01/registries.json
  - Microsoft.MachineLearningServices/stable/2023-10-01/workspaceFeatures.json
```

### Tag: package-preview-2023-06

These settings apply only when `--tag=package-preview-2023-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-06'
input-file:
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2023-06-01-preview/workspaceRP.json
```

### Tag: package-2023-04

These settings apply only when `--tag=package-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-2023-04'
input-file:
  - Microsoft.MachineLearningServices/stable/2023-04-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2023-04-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2023-04-01/registries.json
  - Microsoft.MachineLearningServices/stable/2023-04-01/workspaceFeatures.json
```

### Tag: package-preview-2023-04

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-04'
input-file:
  - Microsoft.MachineLearningServices/preview/2023-04-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2023-04-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2023-04-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2023-04-01-preview/workspaceFeatures.json
```

### Tag: package-preview-2023-02

These settings apply only when `--tag=package-preview-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-02'
input-file:
  - Microsoft.MachineLearningServices/preview/2023-02-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2023-02-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2023-02-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2023-02-01-preview/workspaceFeatures.json
```

### Tag: package-preview-2022-12

These settings apply only when `--tag=package-preview-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-12'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-12-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-12-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2022-12-01-preview/registries.json
  - Microsoft.MachineLearningServices/preview/2022-12-01-preview/workspaceFeatures.json
```

### Tag: package-preview-2022-10

These settings apply only when `--tag=package-preview-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-10'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-10-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-10-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2022-10-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2022-10-01-preview/registries.json
```

### Tag: package-2022-10

These settings apply only when `--tag=package-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-2022-10'
input-file:
  - Microsoft.MachineLearningServices/stable/2022-10-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2022-10-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2022-10-01/workspaceFeatures.json
```

### Tag: package-preview-2022-06

These settings apply only when `--tag=package-preview-2022-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-06'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-06-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-06-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2022-06-01-preview/workspaceFeatures.json
```

### Tag: package-2022-05-01

These settings apply only when `--tag=package-2022-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-05-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2022-05-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2022-05-01/mfe.json
  - Microsoft.MachineLearningServices/stable/2022-05-01/workspaceFeatures.json
```

### Tag: package-2022-02-01-preview

These settings apply only when `--tag=package-2022-02-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-02-01-preview'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-02-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-02-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2022-02-01-preview/workspaceFeatures.json
```

### Tag: package-2022-01-01-preview

These settings apply only when `--tag=package-2022-01-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-01-01-preview'
input-file:
  - Microsoft.MachineLearningServices/preview/2022-01-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2022-01-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2022-01-01-preview/workspaceSkus.json
```

### Tag: package-2021-07-01

These settings apply only when `--tag=package-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-2021-07-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2021-07-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2021-07-01/workspaceFeatures.json
  - Microsoft.MachineLearningServices/stable/2021-07-01/workspaceSkus.json
```

### Tag: package-2021-04-01

These settings apply only when `--tag=package-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-2021-04-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2021-04-01/machineLearningServices.json
```

### Tag: package-2021-01-01

These settings apply only when `--tag=package-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-01-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2021-01-01/machineLearningServices.json
```

### Tag: package-2021-03-01-preview

These settings apply only when `--tag=package-2021-03-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-03-01-preview'
input-file:
  - Microsoft.MachineLearningServices/preview/2021-03-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2021-03-01-preview/mfe.json
  - Microsoft.MachineLearningServices/preview/2021-03-01-preview/workspaceFeatures.json
  - Microsoft.MachineLearningServices/preview/2021-03-01-preview/workspaceSkus.json
```

### Tag: package-2020-08-01

These settings apply only when `--tag=package-2020-08` is specified on the command line.

``` yaml $(tag) == 'package-2020-08-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-08-01/machineLearningServices.json
```

### Tag: package-2020-06-01

These settings apply only when `--tag=package-2020-06` is specified on the command line.

``` yaml $(tag) == 'package-2020-06-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-06-01/machineLearningServices.json
```

### Tag: package-preview-2020-05

These settings apply only when `--tag=package-preview-2020-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-05'
input-file:
  - Microsoft.MachineLearningServices/preview/2020-05-15-preview/machineLearningServices.json
```

### Tag: package-2020-04-01

These settings apply only when `--tag=package-2020-04` is specified on the command line.

``` yaml $(tag) == 'package-2020-04-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-04-01/machineLearningServices.json
```

### Tag: package-2020-03-01

These settings apply only when `--tag=package-2020-03` is specified on the command line.

``` yaml $(tag) == 'package-2020-03-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-03-01/machineLearningServices.json
```

### Tag: package-2020-01-01

These settings apply only when `--tag=package-2020-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2020-01-01/machineLearningServices.json
```

### Tag: package-2019-11-01

These settings apply only when `--tag=package-2019-11` is specified on the command line.

``` yaml $(tag) == 'package-2019-11-01'
input-file:
  - Microsoft.MachineLearningServices/stable/2019-11-01/machineLearningServices.json
```

### Tag: package-2019-06-01

These settings apply only when `--tag=package-2019-06-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-06-01'
input-file:
- Microsoft.MachineLearningServices/stable/2019-06-01/machineLearningServices.json
```

### Tag: package-2019-05-01

These settings apply only when `--tag=package-2019-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-05-01'
input-file:
- Microsoft.MachineLearningServices/stable/2019-05-01/machineLearningServices.json
```

### Tag: package-2018-11-19

These settings apply only when `--tag=package-2018-11-19` is specified on the command line.

``` yaml $(tag) == 'package-2018-11-19'
input-file:
- Microsoft.MachineLearningServices/stable/2018-11-19/machineLearningServices.json
```

### Tag: package-2020-09-01-preview

These settings apply only when `--tag=package-2020-09-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-09-01-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2020-09-01-preview/jobs.json
- Microsoft.MachineLearningServices/preview/2020-09-01-preview/machineLearningServices.json
```

### Tag: package-2020-05-01-preview

These settings apply only when `--tag=package-2020-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-05-01-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2020-05-01-preview/machineLearningServices.json
```

### Tag: package-2020-04-01-preview

These settings apply only when `--tag=package-2020-04-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-04-01-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2020-04-01-preview/machineLearningServices.json
```

### Tag: package-2020-02-18-preview

These settings apply only when `--tag=package-2020-02-18-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-02-18-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2020-02-18-preview/machineLearningServices.json
```

### Tag: package-2018-03-preview

These settings apply only when `--tag=package-2018-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-03-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2018-03-01-preview/machineLearningServices.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.MachineLearningServices
  output-folder: $(csharp-sdks-folder)/machinelearningservices/Microsoft.Azure.Management.MachineLearningServices/src/Generated
  clear-output-folder: true
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
