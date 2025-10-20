# mobilenetwork

> see https://aka.ms/autorest

This is the AutoRest configuration file for mobilenetwork.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the mobilenetwork.

``` yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-04
```

### Tag: package-2024-04

These settings apply only when `--tag=package-2024-04` is specified on the command line.

```yaml $(tag) == 'package-2024-04'
input-file:
  - stable/2024-04-01/attachedDataNetwork.json
  - stable/2024-04-01/common.json
  - stable/2024-04-01/dataNetwork.json
  - stable/2024-04-01/diagnosticsPackage.json
  - stable/2024-04-01/mobileNetwork.json
  - stable/2024-04-01/operation.json
  - stable/2024-04-01/packetCapture.json
  - stable/2024-04-01/packetCoreControlPlane.json
  - stable/2024-04-01/packetCoreDataPlane.json
  - stable/2024-04-01/service.json
  - stable/2024-04-01/sim.json
  - stable/2024-04-01/simGroup.json
  - stable/2024-04-01/simPolicy.json
  - stable/2024-04-01/site.json
  - stable/2024-04-01/slice.json
  - stable/2024-04-01/ts29571.json
  - stable/2024-04-01/ueInfo.json
```

### Tag: package-2024-02

These settings apply only when `--tag=package-2024-02` is specified on the command line.

``` yaml $(tag) == 'package-2024-02'
input-file:
  - stable/2024-02-01/attachedDataNetwork.json
  - stable/2024-02-01/common.json
  - stable/2024-02-01/dataNetwork.json
  - stable/2024-02-01/diagnosticsPackage.json
  - stable/2024-02-01/mobileNetwork.json
  - stable/2024-02-01/operation.json
  - stable/2024-02-01/packetCapture.json
  - stable/2024-02-01/packetCoreControlPlane.json
  - stable/2024-02-01/packetCoreDataPlane.json
  - stable/2024-02-01/service.json
  - stable/2024-02-01/sim.json
  - stable/2024-02-01/simGroup.json
  - stable/2024-02-01/simPolicy.json
  - stable/2024-02-01/site.json
  - stable/2024-02-01/slice.json
  - stable/2024-02-01/ts29571.json
  - stable/2024-02-01/ueInfo.json
```

### Tag: package-2023-09

These settings apply only when `--tag=package-2023-09` is specified on the command line.

``` yaml $(tag) == 'package-2023-09'
input-file:
  - stable/2023-09-01/attachedDataNetwork.json
  - stable/2023-09-01/common.json
  - stable/2023-09-01/dataNetwork.json
  - stable/2023-09-01/diagnosticsPackage.json
  - stable/2023-09-01/mobileNetwork.json
  - stable/2023-09-01/operation.json
  - stable/2023-09-01/packetCapture.json
  - stable/2023-09-01/packetCoreControlPlane.json
  - stable/2023-09-01/packetCoreDataPlane.json
  - stable/2023-09-01/service.json
  - stable/2023-09-01/sim.json
  - stable/2023-09-01/simGroup.json
  - stable/2023-09-01/simPolicy.json
  - stable/2023-09-01/site.json
  - stable/2023-09-01/slice.json
  - stable/2023-09-01/ts29571.json
```
### Tag: package-2023-06

These settings apply only when `--tag=package-2023-06` is specified on the command line.

``` yaml $(tag) == 'package-2023-06'
input-file:
  - stable/2023-06-01/attachedDataNetwork.json
  - stable/2023-06-01/common.json
  - stable/2023-06-01/dataNetwork.json
  - stable/2023-06-01/diagnosticsPackage.json
  - stable/2023-06-01/mobileNetwork.json
  - stable/2023-06-01/operation.json
  - stable/2023-06-01/packetCapture.json
  - stable/2023-06-01/packetCoreControlPlane.json
  - stable/2023-06-01/packetCoreDataPlane.json
  - stable/2023-06-01/service.json
  - stable/2023-06-01/sim.json
  - stable/2023-06-01/simGroup.json
  - stable/2023-06-01/simPolicy.json
  - stable/2023-06-01/site.json
  - stable/2023-06-01/slice.json
  - stable/2023-06-01/ts29571.json
```

### Tag: package-2022-11-01

These settings apply only when `--tag=package-2022-11-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-11-01'
input-file:
  - stable/2022-11-01/attachedDataNetwork.json
  - stable/2022-11-01/common.json
  - stable/2022-11-01/dataNetwork.json
  - stable/2022-11-01/mobileNetwork.json
  - stable/2022-11-01/operation.json
  - stable/2022-11-01/packetCoreControlPlane.json
  - stable/2022-11-01/packetCoreDataPlane.json
  - stable/2022-11-01/service.json
  - stable/2022-11-01/sim.json
  - stable/2022-11-01/simGroup.json
  - stable/2022-11-01/simPolicy.json
  - stable/2022-11-01/site.json
  - stable/2022-11-01/slice.json
  - stable/2022-11-01/ts29571.json
```

### Tag: package-2022-04-01-preview

These settings apply only when `--tag=package-2022-04-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-04-01-preview'
input-file:
  - preview/2022-04-01-preview/attachedDataNetwork.json
  - preview/2022-04-01-preview/common.json
  - preview/2022-04-01-preview/dataNetwork.json
  - preview/2022-04-01-preview/mobileNetwork.json
  - preview/2022-04-01-preview/operation.json
  - preview/2022-04-01-preview/packetCoreControlPlane.json
  - preview/2022-04-01-preview/packetCoreDataPlane.json
  - preview/2022-04-01-preview/service.json
  - preview/2022-04-01-preview/simPolicy.json
  - preview/2022-04-01-preview/slice.json
  - preview/2022-04-01-preview/ts29571.json
```

### Tag: package-2022-03-01-preview

These settings apply only when `--tag=package-2022-03-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-03-01-preview'
input-file:
  - preview/2022-03-01-preview/attachedDataNetwork.json
  - preview/2022-03-01-preview/common.json
  - preview/2022-03-01-preview/dataNetwork.json
  - preview/2022-03-01-preview/mobileNetwork.json
  - preview/2022-03-01-preview/operation.json
  - preview/2022-03-01-preview/packetCoreControlPlane.json
  - preview/2022-03-01-preview/packetCoreDataPlane.json
  - preview/2022-03-01-preview/service.json
  - preview/2022-03-01-preview/simPolicy.json
  - preview/2022-03-01-preview/slice.json
  - preview/2022-03-01-preview/ts29571.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_mobilenetwork']
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
