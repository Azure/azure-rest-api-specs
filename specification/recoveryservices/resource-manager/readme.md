# RecoveryServices

> see https://aka.ms/autorest

This is the AutoRest configuration file for RecoveryServices.

---

## Getting Started

To build the SDK for RecoveryServices, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the RecoveryServices API.

``` yaml
title: RecoveryServicesClient
description: Recovery Services Client
openapi-type: arm
tag: package-2021-08
```

### Validations

Run validations when `--validate` is specified on command line

``` yaml $(validate)
azure-validator: true
model-validator: true
semantic-validator: true
message-format: json
```


### Tag: package-2021-08

These settings apply only when `--tag=package-2021-08` is specified on the command line.

```yaml $(tag) == 'package-2021-08'
input-file:
  - Microsoft.RecoveryServices/stable/2021-08-01/registeredidentities.json
  - Microsoft.RecoveryServices/stable/2021-08-01/replicationusages.json
  - Microsoft.RecoveryServices/stable/2021-08-01/vaults.json
  - Microsoft.RecoveryServices/stable/2021-08-01/vaultusages.json
```
### Tag: package-2021-07

These settings apply only when `--tag=package-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-2021-07'
input-file:
  - Microsoft.RecoveryServices/stable/2021-07-01/registeredidentities.json
  - Microsoft.RecoveryServices/stable/2021-07-01/replicationusages.json
  - Microsoft.RecoveryServices/stable/2021-07-01/vaults.json
  - Microsoft.RecoveryServices/stable/2021-07-01/vaultusages.json
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-2021-06'
input-file:
  - Microsoft.RecoveryServices/stable/2021-06-01/registeredidentities.json
  - Microsoft.RecoveryServices/stable/2021-06-01/replicationusages.json
  - Microsoft.RecoveryServices/stable/2021-06-01/vaults.json
  - Microsoft.RecoveryServices/stable/2021-06-01/vaultusages.json
```

### Tag: package-2021-04

These settings apply only when `--tag=package-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-2021-04'
input-file:
  - Microsoft.RecoveryServices/stable/2021-04-01/registeredidentities.json
  - Microsoft.RecoveryServices/stable/2021-04-01/replicationusages.json
  - Microsoft.RecoveryServices/stable/2021-04-01/vaults.json
  - Microsoft.RecoveryServices/stable/2021-04-01/vaultusages.json
```

### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-2021-03'
input-file:
  - Microsoft.RecoveryServices/stable/2021-03-01/registeredidentities.json
  - Microsoft.RecoveryServices/stable/2021-03-01/replicationusages.json
  - Microsoft.RecoveryServices/stable/2021-03-01/vaults.json
  - Microsoft.RecoveryServices/stable/2021-03-01/vaultusages.json
```

### Tag: package-2021-02

These settings apply only when `--tag=package-2021-02` is specified on the command line.

``` yaml $(tag) == 'package-2021-02'
input-file:
  - Microsoft.RecoveryServices/stable/2021-02-10/registeredidentities.json
  - Microsoft.RecoveryServices/stable/2021-02-10/replicationusages.json
  - Microsoft.RecoveryServices/stable/2021-02-10/vaults.json
  - Microsoft.RecoveryServices/stable/2021-02-10/vaultusages.json
```

### Tag: package-2016-06

These settings apply only when `--tag=package-2016-06` is specified on the command line.

``` yaml $(tag) == 'package-2016-06'
input-file:
- Microsoft.RecoveryServices/stable/2016-06-01/registeredidentities.json
- Microsoft.RecoveryServices/stable/2016-06-01/replicationusages.json
- Microsoft.RecoveryServices/stable/2016-06-01/vaults.json
- Microsoft.RecoveryServices/stable/2016-06-01/vaultusages.json
```

### Tag: package-2020-02

These settings apply only when `--tag=package-2020-02` is specified on the command line.

``` yaml $(tag) == 'package-2020-02'
input-file:
- Microsoft.RecoveryServices/stable/2020-02-02/registeredidentities.json
- Microsoft.RecoveryServices/stable/2020-02-02/replicationusages.json
- Microsoft.RecoveryServices/stable/2020-02-02/vaults.json
- Microsoft.RecoveryServices/stable/2020-02-02/vaultusages.json
```

### Tag: package-2020-10

These settings apply only when `--tag=package-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-2020-10'
input-file:
- Microsoft.RecoveryServices/stable/2020-10-01/registeredidentities.json
- Microsoft.RecoveryServices/stable/2020-10-01/replicationusages.json
- Microsoft.RecoveryServices/stable/2020-10-01/vaults.json
- Microsoft.RecoveryServices/stable/2020-10-01/vaultusages.json
```

### Tag: package-2021-01

These settings apply only when `--tag=package-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-01'
input-file:
- Microsoft.RecoveryServices/stable/2021-01-01/registeredidentities.json
- Microsoft.RecoveryServices/stable/2021-01-01/replicationusages.json
- Microsoft.RecoveryServices/stable/2021-01-01/vaults.json
- Microsoft.RecoveryServices/stable/2021-01-01/vaultusages.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_recovery_services']
  - repo: azure-resource-manager-schemas
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 1
  namespace: Microsoft.Azure.Management.RecoveryServices
  output-folder: $(csharp-sdks-folder)/recoveryservices/Microsoft.Azure.Management.RecoveryServices/src/Generated
  clear-output-folder: true
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.recoveryservices
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-recoveryservices
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-10
```

### Tag: package-2020-10 and java

These settings apply only when `--tag=package-2020-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.recoveryservices.v2020_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/recoveryservices/mgmt-v2020_10_01
regenerate-manager: true
generate-interface: true
```
