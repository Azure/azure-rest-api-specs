# RecoveryServices.Backup

> see https://aka.ms/autorest

This is the AutoRest configuration file for RecoveryServicesBackup.



---
## Getting Started
To build the SDK for RecoveryServicesBackup, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the RecoveryServicesBackup API.

``` yaml
title: Recovery Services Backup Client
description: Open API 2.0 Specs for Azure RecoveryServices Backup service
openapi-type: arm
tag: package-2021-02
csharp-sdks-folder: ./Generated/CSharp
python-sdks-folder: ./Generated/Python
go-sdk-folder: ./Generated/Golang

license-header: MICROSOFT_MIT
```

### Validations
Run validations when `--validate` is specified on command line

``` yaml $(validate)
azure-validator: true
model-validator: true
semantic-validator: true
message-format: json
```
### Tag: package-2021-02-preview

These settings apply only when `--tag=package-2021-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-02-preview'
input-file:
- Microsoft.RecoveryServices/preview/2021-02-01-preview/bms.json
- Microsoft.RecoveryServices/stable/2018-12-20/bms.json
```

### Tag: package-2021-02

These settings apply only when `--tag=package-2021-02` is specified on the command line.

``` yaml $(tag) == 'package-2021-02'
input-file:
- Microsoft.RecoveryServices/stable/2021-02-01/bms.json
- Microsoft.RecoveryServices/stable/2018-12-20/bms.json
```

### Tag: package-2021-01

These settings apply only when `--tag=package-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-01'
input-file:
- Microsoft.RecoveryServices/stable/2021-01-01/bms.json
- Microsoft.RecoveryServices/stable/2018-12-20/bms.json
- Microsoft.RecoveryServices/stable/2017-07-01/bms.json
- Microsoft.RecoveryServices/stable/2016-08-10/operations.json
```

### Tag: package-2020-12

These settings apply only when `--tag=package-2020-12` is specified on the command line.

``` yaml $(tag) == 'package-2020-12'
input-file:
- Microsoft.RecoveryServices/stable/2020-12-01/bms.json
- Microsoft.RecoveryServices/stable/2018-12-20/bms.json
- Microsoft.RecoveryServices/stable/2017-07-01/bms.json
- Microsoft.RecoveryServices/stable/2016-08-10/operations.json
```

### Tag: package-2020-10

These settings apply only when `--tag=package-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-2020-10'
input-file:
- Microsoft.RecoveryServices/stable/2020-10-01/bms.json
- Microsoft.RecoveryServices/stable/2018-12-20/bms.json
- Microsoft.RecoveryServices/stable/2017-07-01/bms.json
- Microsoft.RecoveryServices/stable/2016-08-10/operations.json
```

### Tag: package-2020-07

These settings apply only when `--tag=package-2020-07` is specified on the command line.

``` yaml $(tag) == 'package-2020-07'
input-file:
- Microsoft.RecoveryServices/stable/2020-07-01/bms.json
- Microsoft.RecoveryServices/stable/2018-12-20/bms.json
- Microsoft.RecoveryServices/stable/2017-07-01/bms.json
- Microsoft.RecoveryServices/stable/2016-08-10/operations.json
```

### Tag: package-2020-02

These settings apply only when `--tag=package-2020-02` is specified on the command line.

``` yaml $(tag) == 'package-2020-02'
input-file:
- Microsoft.RecoveryServices/stable/2020-02-02/bms.json
- Microsoft.RecoveryServices/stable/2019-06-15/bms.json
- Microsoft.RecoveryServices/stable/2017-07-01/bms.json
- Microsoft.RecoveryServices/stable/2016-12-01/bms.json
- Microsoft.RecoveryServices/stable/2016-08-10/operations.json
```


### Tag: package-2019-06

These settings apply only when `--tag=package-2019-06` is specified on the command line.

``` yaml $(tag) == 'package-2019-06'
input-file:
- Microsoft.RecoveryServices/stable/2019-06-15/bms.json
- Microsoft.RecoveryServices/stable/2017-07-01/bms.json
- Microsoft.RecoveryServices/stable/2016-12-01/bms.json
- Microsoft.RecoveryServices/stable/2016-08-10/operations.json
```

### Tag: package-2019-05

These settings apply only when `--tag=package-2019-05` is specified on the command line.

``` yaml $(tag) == 'package-2019-05'
input-file:
- Microsoft.RecoveryServices/stable/2019-05-13/bms.json
- Microsoft.RecoveryServices/stable/2017-07-01/bms.json
- Microsoft.RecoveryServices/stable/2016-12-01/bms.json
- Microsoft.RecoveryServices/stable/2016-08-10/operations.json
```

### Tag: package-2017-07

These settings apply only when `--tag=package-2017-07` is specified on the command line.

``` yaml $(tag) == 'package-2017-07'
input-file:
- Microsoft.RecoveryServices/stable/2017-07-01/bms.json
- Microsoft.RecoveryServices/stable/2016-12-01/bms.json
- Microsoft.RecoveryServices/stable/2016-08-10/operations.json
```

### Tag: package-2016-06

These settings apply only when `--tag=package-2016-06` is specified on the command line.

``` yaml $(tag) == 'package-2016-06'
input-file:
- Microsoft.RecoveryServices/stable/2016-06-01/recoveryservicesbackup.json
- Microsoft.RecoveryServices/stable/2016-06-01/registeredIdentities.json
```

### Tag: package-2016-08

These settings apply only when `--tag=package-2016-08` is specified on the command line.

``` yaml $(tag) == 'package-2016-08'
input-file:
- Microsoft.RecoveryServices/stable/2016-08-10/operations.json
```

### Tag: package-2016-12

These settings apply only when `--tag=package-2016-12` is specified on the command line.

``` yaml $(tag) == 'package-2016-12'
input-file:
- Microsoft.RecoveryServices/stable/2016-12-01/bms.json
```

### Tag: package-2017-07-only

These settings apply only when `--tag=package-2017-07` is specified on the command line.

``` yaml $(tag) == 'package-2017-07-only'
input-file:
- Microsoft.RecoveryServices/stable/2017-07-01/bms.json
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_recovery_services_backup']
  - repo: azure-resource-manager-schemas
    after_scripts:
      - node sdkauto_afterscript.js recoveryservicesbackup/resource-manager
```


## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  azure-arm: true
  payload-flattening-threshold: 1
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.RecoveryServices.Backup
  output-folder: $(csharp-sdks-folder)/recoveryservices-backup/Microsoft.Azure.Management.RecoveryServices.Backup/src/Generated
  clear-output-folder: true
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)