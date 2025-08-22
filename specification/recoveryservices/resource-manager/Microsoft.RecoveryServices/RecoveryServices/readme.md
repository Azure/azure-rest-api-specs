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
tag: package-2025-02-01
```

### Validations

Run validations when `--validate` is specified on command line

``` yaml $(validate)
azure-validator: true
model-validator: true
semantic-validator: true
message-format: json
```

### Tag: package-2025-02-01

These settings apply only when `--tag=package-2025-02-01` is specified on the command line.

```yaml $(tag) == 'package-2025-02-01'
input-file:
  - stable/2025-02-01/openapi.json
```

### Tag: package-2025-01-01

These settings apply only when `--tag=package-2025-01-01` is specified on the command line.

```yaml $(tag) == 'package-2025-01-01'
input-file:
  - stable/2025-01-01/registeredidentities.json
  - stable/2025-01-01/replicationusages.json
  - stable/2025-01-01/vaults.json
  - stable/2025-01-01/vaultusages.json
```

### Tag: package-2024-10

These settings apply only when `--tag=package-2024-10` is specified on the command line.

```yaml $(tag) == 'package-2024-10'
input-file:
  - stable/2024-10-01/registeredidentities.json
  - stable/2024-10-01/replicationusages.json
  - stable/2024-10-01/vaults.json
  - stable/2024-10-01/vaultusages.json
```

### Tag: package-preview-2024-09

These settings apply only when `--tag=package-preview-2024-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-09'
input-file:
  - preview/2024-09-30-preview/registeredidentities.json
  - preview/2024-09-30-preview/replicationusages.json
  - preview/2024-09-30-preview/vaults.json
  - preview/2024-09-30-preview/vaultusages.json
```

### Tag: package-preview-2024-04

These settings apply only when `--tag=package-preview-2024-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-04'
input-file:
  - preview/2024-04-30-preview/registeredidentities.json
  - preview/2024-04-30-preview/replicationusages.json
  - preview/2024-04-30-preview/vaults.json
  - preview/2024-04-30-preview/vaultusages.json
```

### Tag: package-2024-04

These settings apply only when `--tag=package-2024-04` is specified on the command line.

```yaml $(tag) == 'package-2024-04'
input-file:
  - stable/2024-04-01/registeredidentities.json
  - stable/2024-04-01/replicationusages.json
  - stable/2024-04-01/vaults.json
  - stable/2024-04-01/vaultusages.json
```

### Tag: package-2024-02

These settings apply only when `--tag=package-2024-02` is specified on the command line.

``` yaml $(tag) == 'package-2024-02'
input-file:
  - stable/2024-02-01/registeredidentities.json
  - stable/2024-02-01/replicationusages.json
  - stable/2024-02-01/vaults.json
  - stable/2024-02-01/vaultusages.json
```

### Tag: package-2024-01

These settings apply only when `--tag=package-2024-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-01'
input-file:
  - stable/2024-01-01/registeredidentities.json
  - stable/2024-01-01/replicationusages.json
  - stable/2024-01-01/vaults.json
  - stable/2024-01-01/vaultusages.json
```

### Tag: package-2023-08

These settings apply only when `--tag=package-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-2023-08'
input-file:
  - stable/2023-08-01/registeredidentities.json
  - stable/2023-08-01/replicationusages.json
  - stable/2023-08-01/vaults.json
  - stable/2023-08-01/vaultusages.json
```

### Tag: package-2023-06

These settings apply only when `--tag=package-2023-06` is specified on the command line.

``` yaml $(tag) == 'package-2023-06'
input-file:
  - stable/2023-06-01/registeredidentities.json
  - stable/2023-06-01/replicationusages.json
  - stable/2023-06-01/vaults.json
  - stable/2023-06-01/vaultusages.json
```

### Tag: package-2023-04

These settings apply only when `--tag=package-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-2023-04'
input-file:
  - stable/2023-04-01/registeredidentities.json
  - stable/2023-04-01/replicationusages.json
  - stable/2023-04-01/vaults.json
  - stable/2023-04-01/vaultusages.json
```

### Tag: package-2023-02

These settings apply only when `--tag=package-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-2023-02'
input-file:
  - stable/2023-02-01/registeredidentities.json
  - stable/2023-02-01/replicationusages.json
  - stable/2023-02-01/vaults.json
  - stable/2023-02-01/vaultusages.json
```

### Tag: package-2023-01

These settings apply only when `--tag=package-2023-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-01'
input-file:
  - stable/2023-01-01/registeredidentities.json
  - stable/2023-01-01/replicationusages.json
  - stable/2023-01-01/vaults.json
  - stable/2023-01-01/vaultusages.json
```

### Tag: package-2022-10

These settings apply only when `--tag=package-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-2022-10'
input-file:
  - stable/2022-10-01/registeredidentities.json
  - stable/2022-10-01/replicationusages.json
  - stable/2022-10-01/vaults.json
  - stable/2022-10-01/vaultusages.json
```

### Tag: package-preview-2022-09

These settings apply only when `--tag=package-preview-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-09'
input-file:
  - preview/2022-09-30-preview/registeredidentities.json
  - preview/2022-09-30-preview/replicationusages.json
  - preview/2022-09-30-preview/vaults.json
  - preview/2022-09-30-preview/vaultusages.json
```

### Tag: package-2022-09

These settings apply only when `--tag=package-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-2022-09'
input-file:
  - stable/2022-09-10/registeredidentities.json
  - stable/2022-09-10/replicationusages.json
  - stable/2022-09-10/vaults.json
  - stable/2022-09-10/vaultusages.json
```

### Tag: package-2022-08

These settings apply only when `--tag=package-2022-08` is specified on the command line.

``` yaml $(tag) == 'package-2022-08'
input-file:
  - stable/2022-08-01/registeredidentities.json
  - stable/2022-08-01/replicationusages.json
  - stable/2022-08-01/vaults.json
  - stable/2022-08-01/vaultusages.json
```

### Tag: package-2022-05

These settings apply only when `--tag=package-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-2022-05'
input-file:
  - stable/2022-05-01/registeredidentities.json
  - stable/2022-05-01/replicationusages.json
  - stable/2022-05-01/vaults.json
  - stable/2022-05-01/vaultusages.json
```

### Tag: package-2022-04

These settings apply only when `--tag=package-2022-04` is specified on the command line.

``` yaml $(tag) == 'package-2022-04'
input-file:
  - stable/2022-04-01/registeredidentities.json
  - stable/2022-04-01/replicationusages.json
  - stable/2022-04-01/vaults.json
  - stable/2022-04-01/vaultusages.json
```

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-2022-03'
input-file:
  - stable/2022-03-01/registeredidentities.json
  - stable/2022-03-01/replicationusages.json
  - stable/2022-03-01/vaults.json
  - stable/2022-03-01/vaultusages.json
```

### Tag: package-2022-02

These settings apply only when `--tag=package-2022-02` is specified on the command line.

``` yaml $(tag) == 'package-2022-02'
input-file:
  - stable/2022-02-01/registeredidentities.json
  - stable/2022-02-01/replicationusages.json
  - stable/2022-02-01/vaults.json
  - stable/2022-02-01/vaultusages.json
```

### Tag: package-preview-2022-01

These settings apply only when `--tag=package-preview-2022-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-01'
input-file:
  - preview/2022-01-31-preview/registeredidentities.json
  - preview/2022-01-31-preview/replicationusages.json
  - preview/2022-01-31-preview/vaults.json
  - preview/2022-01-31-preview/vaultusages.json
```

### Tag: package-2022-01

These settings apply only when `--tag=package-2022-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-01'
input-file:
  - stable/2022-01-01/registeredidentities.json
  - stable/2022-01-01/replicationusages.json
  - stable/2022-01-01/vaults.json
  - stable/2022-01-01/vaultusages.json
```

### Tag: package-2021-12

These settings apply only when `--tag=package-2021-12` is specified on the command line.

``` yaml $(tag) == 'package-2021-12'
input-file:
  - stable/2021-12-01/registeredidentities.json
  - stable/2021-12-01/replicationusages.json
  - stable/2021-12-01/vaults.json
  - stable/2021-12-01/vaultusages.json
```

### Tag: package-preview-2021-11

These settings apply only when `--tag=package-preview-2021-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-11'
input-file:
  - preview/2021-11-01-preview/registeredidentities.json
  - preview/2021-11-01-preview/replicationusages.json
  - preview/2021-11-01-preview/vaults.json
  - preview/2021-11-01-preview/vaultusages.json
```

### Tag: package-2021-08

These settings apply only when `--tag=package-2021-08` is specified on the command line.

``` yaml $(tag) == 'package-2021-08'
input-file:
  - stable/2021-08-01/registeredidentities.json
  - stable/2021-08-01/replicationusages.json
  - stable/2021-08-01/vaults.json
  - stable/2021-08-01/vaultusages.json
```

### Tag: package-2021-07

These settings apply only when `--tag=package-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-2021-07'
input-file:
  - stable/2021-07-01/registeredidentities.json
  - stable/2021-07-01/replicationusages.json
  - stable/2021-07-01/vaults.json
  - stable/2021-07-01/vaultusages.json
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-2021-06'
input-file:
  - stable/2021-06-01/registeredidentities.json
  - stable/2021-06-01/replicationusages.json
  - stable/2021-06-01/vaults.json
  - stable/2021-06-01/vaultusages.json
```

### Tag: package-2021-04

These settings apply only when `--tag=package-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-2021-04'
input-file:
  - stable/2021-04-01/registeredidentities.json
  - stable/2021-04-01/replicationusages.json
  - stable/2021-04-01/vaults.json
  - stable/2021-04-01/vaultusages.json
```

### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-2021-03'
input-file:
  - stable/2021-03-01/registeredidentities.json
  - stable/2021-03-01/replicationusages.json
  - stable/2021-03-01/vaults.json
  - stable/2021-03-01/vaultusages.json
```

### Tag: package-2021-02

These settings apply only when `--tag=package-2021-02` is specified on the command line.

``` yaml $(tag) == 'package-2021-02'
input-file:
  - stable/2021-02-10/registeredidentities.json
  - stable/2021-02-10/replicationusages.json
  - stable/2021-02-10/vaults.json
  - stable/2021-02-10/vaultusages.json
```

### Tag: package-2016-06

These settings apply only when `--tag=package-2016-06` is specified on the command line.

``` yaml $(tag) == 'package-2016-06'
input-file:
- stable/2016-06-01/registeredidentities.json
- stable/2016-06-01/replicationusages.json
- stable/2016-06-01/vaults.json
- stable/2016-06-01/vaultusages.json
```

### Tag: package-2020-02

These settings apply only when `--tag=package-2020-02` is specified on the command line.

``` yaml $(tag) == 'package-2020-02'
input-file:
- stable/2020-02-02/registeredidentities.json
- stable/2020-02-02/replicationusages.json
- stable/2020-02-02/vaults.json
- stable/2020-02-02/vaultusages.json
```

### Tag: package-2020-10

These settings apply only when `--tag=package-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-2020-10'
input-file:
- stable/2020-10-01/registeredidentities.json
- stable/2020-10-01/replicationusages.json
- stable/2020-10-01/vaults.json
- stable/2020-10-01/vaultusages.json
```

### Tag: package-2021-01

These settings apply only when `--tag=package-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-01'
input-file:
- stable/2021-01-01/registeredidentities.json
- stable/2021-01-01/replicationusages.json
- stable/2021-01-01/vaults.json
- stable/2021-01-01/vaultusages.json
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
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_recovery_services']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
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
