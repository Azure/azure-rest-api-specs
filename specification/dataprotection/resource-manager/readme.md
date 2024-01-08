# DataProtection

> see https://aka.ms/autorest

This is the AutoRest configuration file for DataProtection.

---

## Getting Started

To build the SDK for DataProtection, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the DataProtection API.

``` yaml
title: Data Protection Client
description: Open API 2.0 Specs for Azure Data Protection service
openapi-type: arm
tag: package-2023-12
csharp-sdks-folder: ./Generated/CSharp
python-sdks-folder: ./Generated/Python
go-sdk-folder: ./Generated/Golang
license-header: MICROSOFT_MIT
suppressions:
  - code: ResourceNameRestriction
    reason: 'BackupInstance Resource is created by DPP Service, so regex wont add much value here.'
```

### Validations

Run validations when `--validate` is specified on command line

``` yaml $(validate)
azure-validator: true
model-validator: true
semantic-validator: true
message-format: json
```


### Tag: package-2023-12

These settings apply only when `--tag=package-2023-12` is specified on the command line.

```yaml $(tag) == 'package-2023-12'
input-file:
  - Microsoft.DataProtection/stable/2023-12-01/dataprotection.json
```
### Tag: package-2023-11

These settings apply only when `--tag=package-2023-11` is specified on the command line.

``` yaml $(tag) == 'package-2023-11'
input-file:
  - Microsoft.DataProtection/stable/2023-11-01/dataprotection.json
```

### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-08'
input-file:
  - Microsoft.DataProtection/preview/2023-08-01-preview/dataprotection.json
```

### Tag: package-preview-2023-06

These settings apply only when `--tag=package-preview-2023-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-06'
input-file:
  - Microsoft.DataProtection/preview/2023-06-01-preview/dataprotection.json
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-2023-05'
input-file:
- Microsoft.DataProtection/stable/2023-05-01/dataprotection.json
```

### Tag: package-preview-2023-04

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-04'
input-file:
  - Microsoft.DataProtection/preview/2023-04-01-preview/dataprotection.json
```

### Tag: package-2023-01

These settings apply only when `--tag=package-2023-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-01'
input-file:
- Microsoft.DataProtection/stable/2023-01-01/dataprotection.json
```

### Tag: package-2022-12

These settings apply only when `--tag=package-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-2022-12'
input-file:
- Microsoft.DataProtection/stable/2022-12-01/dataprotection.json
```

### Tag: package-preview-2022-11

These settings apply only when `--tag=package-preview-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-11'
input-file:
  - Microsoft.DataProtection/preview/2022-11-01-preview/dataprotection.json
```

### Tag: package-2022-10-preview

These settings apply only when `--tag=package-2022-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-10-preview'
input-file:
- Microsoft.DataProtection/preview/2022-10-01-preview/dataprotection.json
```

### Tag: package-preview-2022-09

These settings apply only when `--tag=package-preview-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-09'
input-file:
  - Microsoft.DataProtection/preview/2022-09-01-preview/dataprotection.json
```

### Tag: package-2022-05

These settings apply only when `--tag=package-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-2022-05'
input-file:
  - Microsoft.DataProtection/stable/2022-05-01/dataprotection.json
```

### Tag: package-2022-04

These settings apply only when `--tag=package-2022-04` is specified on the command line.

``` yaml $(tag) == 'package-2022-04'
input-file:
  - Microsoft.DataProtection/stable/2022-04-01/dataprotection.json
```

### Tag: package-preview-2022-03

These settings apply only when `--tag=package-preview-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-03'
input-file:
  - Microsoft.DataProtection/preview/2022-03-31-preview/dataprotection.json
```

### Tag: package-preview-2022-02

These settings apply only when `--tag=package-preview-2022-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-02'
input-file:
  - Microsoft.DataProtection/preview/2022-02-01-preview/dataprotection.json
```

### Tag: package-2022-01

These settings apply only when `--tag=package-2022-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-01'
input-file:
  - Microsoft.DataProtection/stable/2022-01-01/dataprotection.json
```

### Tag: package-2021-10-preview

These settings apply only when `--tag=package-2021-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-10-preview'
input-file:
- Microsoft.DataProtection/preview/2021-10-01-preview/dataprotection.json
```

### Tag: package-2021-07

These settings apply only when `--tag=package-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-2021-07'
input-file:
- Microsoft.DataProtection/stable/2021-07-01/dataprotection.json
```

### Tag: package-2021-01

These settings apply only when `--tag=package-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-01'
input-file:
- Microsoft.DataProtection/stable/2021-01-01/dataprotection.json
```

### Tag: package-2021-02-preview

These settings apply only when `--tag=package-2021-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-02-preview'
input-file:
- Microsoft.DataProtection/preview/2021-02-01-preview/dataprotection.json
```

### Tag: package-2021-06-preview

These settings apply only when `--tag=package-2021-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-06-preview'
input-file:
- Microsoft.DataProtection/preview/2021-06-01-preview/dataprotection.json
```

### Tag: package-2021-12-preview

These settings apply only when `--tag=package-2021-12-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-12-preview'
input-file:
- Microsoft.DataProtection/preview/2021-12-01-preview/dataprotection.json
```

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-2022-03'
input-file:
- Microsoft.DataProtection/stable/2022-03-01/dataprotection.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_data_protection']
  - repo: azure-powershell
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  payload-flattening-threshold: 1
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.DataProtection
  output-folder: $(csharp-sdks-folder)/dataprotection/Microsoft.Azure.Management.DataProtection/src/Generated
  clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Suppression

``` yaml
directive:
  - suppress: ParametersInPost
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/locations/{location}/fetchSecondaryRecoveryPoints"].post
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/locations/{location}/fetchCrossRegionRestoreJobs"].post
```
