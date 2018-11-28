# DataLakeStorage

> see https://aka.ms/autorest

This is the AutoRest configuration file for DataLakeStorage.



---
## Getting Started
To build the SDK for DataLakeStorage, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the DataLakeStorage API.

``` yaml
openapi-type: data-plane
tag: package-2018-06-preview
use-internal-constructors: true
add-credentials: true
```


### Tag: package-2018-06-preview

These settings apply only when `--tag=package-2018-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-preview'
input-file:
- preview/2018-06-17/DataLakeStorage.json
```

---
# Code Generation


## Swagger to SDK

Swagger to SDK has been intentionally disabled for this spec.

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Storage.DataLake
  output-folder: $(csharp-sdks-folder)/Storage/DataLake/Generated
  clear-output-folder: true
```


## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.media
  package-name: azure-datalake-storage
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2018-06-preview
```

### Tag: package-2018-06-preview and python

These settings apply only when `--tag=package-2018-06-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-preview' && $(python)
python:
  namespace: azure.datalake.storage.v2018_06_17_preview
  output-folder: $(python-sdks-folder)/azure-datalake-storage/azure/datalake/storage/v2018_06_17_preview
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  namespace: com.microsoft.azure.storage.datalake
  license-header: MICROSOFT_MIT_NO_CODEGEN
  output-folder: $(azure-libraries-for-java-folder)/azure-storage-datalake
```
