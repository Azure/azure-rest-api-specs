# RecoveryServicesSiteRecovery

> see https://aka.ms/autorest

This is the AutoRest configuration file for RecoveryServicesSiteRecovery.

---

## Getting Started

To build the SDK for RecoveryServicesSiteRecovery, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Suppression

``` yaml
directive:
  - from: service.json
    suppress: OAV131 
    reason: Testing purpose.

  - from: service.json 
    suppress: R4010
    reason: Testing purpose

  - from: service.json
    suppress:
    - R4009
    reason: suppressing system data for 2021-02-10

  - from: service.json
    suppress:
      - R4010
    reason: suppressing default error response as ASR is an old service and implements error response in a different format.

  - from: service.json
    suppress:
      - R4011
    reason: service implements 204 for delete and DeleteOperationResponses error was falsely raised.

  - code: AvoidAdditionalProperties
    from: service.json
    reason: Getting flagged in new API versions while inheriting old models, these fields exist in ASR from before and are required.

suppressions:
  - from: service.json
    code: AvoidAdditionalProperties
    reason: Getting flagged in new API versions while inheriting old models, these fields exist in ASR from before and are required.
```

## Configuration

### Basic Information

These are the global settings for the RecoveryServicesSiteRecovery API.

``` yaml
openapi-type: arm
tag: package-2024-10
directive:
  - where:
      - $.paths
    suppress:
      - UniqueResourcePaths
```


### Tag: package-2024-10

These settings apply only when `--tag=package-2024-10` is specified on the command line.

```yaml $(tag) == 'package-2024-10'
input-file:
  - Microsoft.RecoveryServices/stable/2024-10-01/service.json
```

### Tag: package-2024-04

These settings apply only when `--tag=package-2024-04` is specified on the command line.

```yaml $(tag) == 'package-2024-04'
input-file:
  - Microsoft.RecoveryServices/stable/2024-04-01/service.json
```

### Tag: package-2024-02

These settings apply only when `--tag=package-2024-02` is specified on the command line.

```yaml $(tag) == 'package-2024-02'
input-file:
  - Microsoft.RecoveryServices/stable/2024-02-01/service.json
```
### Tag: package-2024-01

These settings apply only when `--tag=package-2024-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-01'
input-file:
  - Microsoft.RecoveryServices/stable/2024-01-01/service.json
```

### Tag: package-2023-08

These settings apply only when `--tag=package-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-2023-08'
input-file:
  - Microsoft.RecoveryServices/stable/2023-08-01/service.json
```

### Tag: package-2023-06

These settings apply only when `--tag=package-2023-06` is specified on the command line.

``` yaml $(tag) == 'package-2023-06'
input-file:
  - Microsoft.RecoveryServices/stable/2023-06-01/service.json
```

### Tag: package-2023-04

These settings apply only when `--tag=package-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-2023-04'
input-file:
  - Microsoft.RecoveryServices/stable/2023-04-01/service.json
```

### Tag: package-2023-02

These settings apply only when `--tag=package-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-2023-02'
input-file:
  - Microsoft.RecoveryServices/stable/2023-02-01/service.json
```

### Tag: package-2023-01

These settings apply only when `--tag=package-2023-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-01'
input-file:
  - Microsoft.RecoveryServices/stable/2023-01-01/service.json
```

### Tag: package-2022-10

These settings apply only when `--tag=package-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-2022-10'
input-file:
  - Microsoft.RecoveryServices/stable/2022-10-01/service.json
```

### Tag: package-2022-09

These settings apply only when `--tag=package-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-2022-09'
input-file:
  - Microsoft.RecoveryServices/stable/2022-09-10/service.json
```

### Tag: package-2022-08

These settings apply only when `--tag=package-2022-08` is specified on the command line.

``` yaml $(tag) == 'package-2022-08'
input-file:
  - Microsoft.RecoveryServices/stable/2022-08-01/service.json
```

### Tag: package-2022-05

These settings apply only when `--tag=package-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-2022-05'
input-file:
  - Microsoft.RecoveryServices/stable/2022-05-01/service.json
```

### Tag: package-2022-04

These settings apply only when `--tag=package-2022-04` is specified on the command line.

``` yaml $(tag) == 'package-2022-04'
input-file:
  - Microsoft.RecoveryServices/stable/2022-04-01/service.json
```

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-2022-03'
input-file:
  - Microsoft.RecoveryServices/stable/2022-03-01/service.json
```

### Tag: package-2022-02

These settings apply only when `--tag=package-2022-02` is specified on the command line.

``` yaml $(tag) == 'package-2022-02'
input-file:
  - Microsoft.RecoveryServices/stable/2022-02-01/service.json
```

### Tag: package-2022-01

These settings apply only when `--tag=package-2022-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-01'
input-file:
  - Microsoft.RecoveryServices/stable/2022-01-01/service.json
```

### Tag: package-2021-12

These settings apply only when `--tag=package-2021-12` is specified on the command line.

``` yaml $(tag) == 'package-2021-12'
input-file:
  - Microsoft.RecoveryServices/stable/2021-12-01/service.json
```

### Tag: package-2021-11

These settings apply only when `--tag=package-2021-11` is specified on the command line.

``` yaml $(tag) == 'package-2021-11'
input-file:
  - Microsoft.RecoveryServices/stable/2021-11-01/service.json
```

### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

``` yaml $(tag) == 'package-2021-10'
input-file:
  - Microsoft.RecoveryServices/stable/2021-10-01/service.json
```

### Tag: package-2021-08

These settings apply only when `--tag=package-2021-08` is specified on the command line.

``` yaml $(tag) == 'package-2021-08'
input-file:
  - Microsoft.RecoveryServices/stable/2021-08-01/service.json
```

### Tag: package-2021-07

These settings apply only when `--tag=package-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-2021-07'
input-file:
  - Microsoft.RecoveryServices/stable/2021-07-01/service.json
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-2021-06'
input-file:
  - Microsoft.RecoveryServices/stable/2021-06-01/service.json
```

### Tag: package-2021-04

These settings apply only when `--tag=package-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-2021-04'
input-file:
  - Microsoft.RecoveryServices/stable/2021-04-01/service.json
```

### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-2021-03'
input-file:
  - Microsoft.RecoveryServices/stable/2021-03-01/service.json
```

### Tag: package-2021-02

These settings apply only when `--tag=package-2021-02` is specified on the command line.

``` yaml $(tag) == 'package-2021-02'
input-file:
  - Microsoft.RecoveryServices/stable/2021-02-10/service.json
```

### Tag: package-2018-07

These settings apply only when `--tag=package-2018-07` is specified on the command line.

``` yaml $(tag) == 'package-2018-07'
input-file:
  - Microsoft.RecoveryServices/stable/2018-07-10/service.json
```

### Tag: package-2018-01

These settings apply only when `--tag=package-2018-01` is specified on the command line.

``` yaml $(tag) == 'package-2018-01'
input-file:
  - Microsoft.RecoveryServices/stable/2018-01-10/service.json
```

### Tag: package-2016-08

These settings apply only when `--tag=package-2016-08` is specified on the command line.

``` yaml $(tag) == 'package-2016-08'
input-file:
- Microsoft.RecoveryServices/stable/2016-08-10/service.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_recovery_services_site_recovery']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  payload-flattening-threshold: 0
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.RecoveryServices.SiteRecovery
  output-folder: $(csharp-sdks-folder)/recoveryservices-siterecovery/Microsoft.Azure.Management.RecoveryServices.SiteRecovery/src/Generated
  clear-output-folder: true
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
