# AppPlatform

> see https://aka.ms/autorest

This is the AutoRest configuration file for AppPlatform.

---

## Getting Started

To build the SDK for AppPlatform, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the AppPlatform API.

``` yaml
openapi-type: arm
tag: package-2023-12
```

### Suppression

``` yaml
directive:
  - suppress: EnumInsteadOfBoolean
    from: appplatform.json
    where: $.definitions.NameAvailability.properties.nameAvailable
    reason:  The boolean properties 'nameAvailable' is actually boolean value defined by Azure API spec
  - suppress: EnumInsteadOfBoolean
    from: appplatform.json
    where: $.definitions.Dimension.properties.toBeExportedForShoebox
    reason:  The boolean properties 'toBeExportedForShoebox' is defined by Geneva metrics
  - suppress: R3021
    from: appplatform.json
    reason:  The resource type name 'Spring' is a trademark so cannot be changed to be camel-case
  - suppress: PathResourceTypeNameCamelCase
    from: appplatform.json
    reason:  The resource type name 'Spring' is a trademark so cannot be changed to be camel-case
  - suppress: LroErrorContent
    from: appplatform.json
    reason:  Keeping it for legacy tooling. Will fix the error in next version
    #where:
    #  - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AppPlatform/Spring/{serviceName}/configServers/default"]
    #  - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AppPlatform/Spring/{serviceName}/monitoringSettings/default"]

suppressions:
  - code: LroPostReturn
    reason: start,stop,flushDNSsetting api do not have return body in async operation
```


### Tag: package-2023-12

These settings apply only when `--tag=package-2023-12` is specified on the command line.

```yaml $(tag) == 'package-2023-12'
input-file:
  - Microsoft.AppPlatform/stable/2023-12-01/appplatform.json
```

### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-11'
input-file:
  - Microsoft.AppPlatform/preview/2023-11-01-preview/appplatform.json
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-09'
input-file:
  - Microsoft.AppPlatform/preview/2023-09-01-preview/appplatform.json
```

### Tag: package-preview-2023-07

These settings apply only when `--tag=package-preview-2023-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-07'
input-file:
  - Microsoft.AppPlatform/preview/2023-07-01-preview/appplatform.json
```

### Tag: package-preview-2023-05

These settings apply only when `--tag=package-preview-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-05'
input-file:
  - Microsoft.AppPlatform/preview/2023-05-01-preview/appplatform.json
```

### Tag: package-preview-2023-03

These settings apply only when `--tag=package-preview-2023-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-03'
input-file:
  - Microsoft.AppPlatform/preview/2023-03-01-preview/appplatform.json
```

### Tag: package-preview-2023-01

These settings apply only when `--tag=package-preview-2023-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-01'
input-file:
  - Microsoft.AppPlatform/preview/2023-01-01-preview/appplatform.json
```

### Tag: package-2022-12

These settings apply only when `--tag=package-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-2022-12'
input-file:
  - Microsoft.AppPlatform/stable/2022-12-01/appplatform.json
```

### Tag: package-preview-2022-11

These settings apply only when `--tag=package-preview-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-11'
input-file:
  - Microsoft.AppPlatform/preview/2022-11-01-preview/appplatform.json
```

### Tag: package-preview-2022-09

These settings apply only when `--tag=package-preview-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-09'
input-file:
  - Microsoft.AppPlatform/preview/2022-09-01-preview/appplatform.json
```

### Tag: package-preview-2022-05

These settings apply only when `--tag=package-preview-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-05'
input-file:
  - Microsoft.AppPlatform/preview/2022-05-01-preview/appplatform.json
```

### Tag: package-2022-04

These settings apply only when `--tag=package-2022-04` is specified on the command line.

``` yaml $(tag) == 'package-2022-04'
input-file:
  - Microsoft.AppPlatform/stable/2022-04-01/appplatform.json
```

### Tag: package-preview-2022-03

These settings apply only when `--tag=package-preview-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-03'
input-file:
  - Microsoft.AppPlatform/preview/2022-03-01-preview/appplatform.json
```

### Tag: package-preview-2022-01

These settings apply only when `--tag=package-preview-2022-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-01'
input-file:
  - Microsoft.AppPlatform/preview/2022-01-01-preview/appplatform.json
```

### Tag: package-preview-2021-09

These settings apply only when `--tag=package-preview-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-09'
input-file:
  - Microsoft.AppPlatform/preview/2021-09-01-preview/appplatform.json
```

### Tag: package-preview-2021-06

These settings apply only when `--tag=package-preview-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-06'
input-file:
  - Microsoft.AppPlatform/preview/2021-06-01-preview/appplatform.json
```

### Tag: package-preview-2020-11

These settings apply only when `--tag=package-preview-2020-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-11'
input-file:
  - Microsoft.AppPlatform/preview/2020-11-01-preview/appplatform.json
```

### Tag: package-2020-07

These settings apply only when `--tag=package-2020-07` is specified on the command line.

``` yaml $(tag) == 'package-2020-07'
input-file:
  - Microsoft.AppPlatform/stable/2020-07-01/appplatform.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-powershell
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_appplatform']
  - repo: azure-resource-manager-schemas
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "sdk" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # last generated with AutoRest.0.17.3
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.AppPlatform
  output-folder: $(csharp-sdks-folder)/appplatform/Microsoft.Azure.Management.AppPlatform/src/Generated
  clear-output-folder: true
```
