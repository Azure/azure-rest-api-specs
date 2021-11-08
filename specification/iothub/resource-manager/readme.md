# IotHub

> see https://aka.ms/autorest

This is the AutoRest configuration file for IotHub.

---

## Getting Started

To build the SDK for IotHub, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the IotHub API.

``` yaml
openapi-type: arm
tag: package-preview-2021-07
```


### Tag: package-preview-2021-07

These settings apply only when `--tag=package-preview-2021-07-02` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-07-02'
input-file:
  - Microsoft.Devices/preview/2021-07-02-preview/iothub.json
```
### Tag: package-2021-07

These settings apply only when `--tag=package-2021-07-02` is specified on the command line.

```yaml $(tag) == 'package-2021-07-02'
input-file:
  - Microsoft.Devices/stable/2021-07-02/iothub.json
```
### Tag: package-2021-07

These settings apply only when `--tag=package-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-2021-07'
input-file:
  - Microsoft.Devices/stable/2021-07-01/iothub.json
```

### Tag: package-preview-2021-07

These settings apply only when `--tag=package-preview-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-07'
input-file:
  - Microsoft.Devices/preview/2021-07-01-preview/iothub.json
```

### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-2021-03'
input-file:
  - Microsoft.Devices/stable/2021-03-31/iothub.json
```

### Tag: package-preview-2021-03

These settings apply only when `--tag=package-preview-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-03'
input-file:
  - Microsoft.Devices/preview/2021-03-03-preview/iothub.json
```

### Tag: package-preview-2021-02

These settings apply only when `--tag=package-preview-2021-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-02'
input-file:
  - Microsoft.Devices/preview/2021-02-01-preview/iothub.json
```

### Tag: package-2020-08-31

These settings apply only when `--tag=package-2020-08-31` is specified on the command line.

``` yaml $(tag) == 'package-2020-08-31'
input-file:
  - Microsoft.Devices/stable/2020-08-31/iothub.json
```

### Tag: package-preview-2020-08-31

These settings apply only when `--tag=package-preview-2020-08-31` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-08-31'
input-file:
  - Microsoft.Devices/preview/2020-08-31-preview/iothub.json
```

### Tag: package-2020-08

These settings apply only when `--tag=package-2020-08` is specified on the command line.

``` yaml $(tag) == 'package-2020-08'
input-file:
  - Microsoft.Devices/stable/2020-08-01/iothub.json
```

### Tag: package-preview-2020-07

These settings apply only when `--tag=package-preview-2020-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-07'
input-file:
  - Microsoft.Devices/preview/2020-07-10-preview/iothub.json
```

### Tag: package-2020-06

These settings apply only when `--tag=package-2020-06` is specified on the command line.

``` yaml $(tag) == 'package-2020-06'
input-file:
  - Microsoft.Devices/stable/2020-06-15/iothub.json
```

### Tag: package-2020-04

These settings apply only when `--tag=package-2020-04` is specified on the command line.

``` yaml $(tag) == 'package-2020-04'
input-file:
  - Microsoft.Devices/stable/2020-04-01/iothub.json
```

### Tag: package-2020-03

These settings apply only when `--tag=package-2020-03` is specified on the command line.

``` yaml $(tag) == 'package-2020-03'
input-file:
  - Microsoft.Devices/stable/2020-03-01/iothub.json
```

### Tag: package-2019-11

These settings apply only when `--tag=package-2019-11` is specified on the command line.

``` yaml $(tag) == 'package-2019-11'
input-file:
  - Microsoft.Devices/stable/2019-11-04/iothub.json
```

### Tag: package-preview-2019-07

These settings apply only when `--tag=package-preview-2019-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2019-07'
input-file:
  - Microsoft.Devices/preview/2019-07-01-preview/iothub.json
```

### Tag: package-2019-03

These settings apply only when `--tag=package-2019-03` is specified on the command line.

``` yaml $(tag) == 'package-2019-03'
input-file:
  - Microsoft.Devices/stable/2019-03-22/iothub.json
```

### Tag: package-preview-2019-03

These settings apply only when `--tag=package-preview-2019-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2019-03'
input-file:
  - Microsoft.Devices/preview/2019-03-22-preview/iothub.json
```

### Tag: package-2018-12-preview

These settings apply only when `--tag=package-2018-12-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-12-preview'
input-file:
- Microsoft.Devices/preview/2018-12-01-preview/iothub.json
```

### Tag: package-2018-04

These settings apply only when `--tag=package-2018-04` is specified on the command line.

``` yaml $(tag) == 'package-2018-04'
input-file:
- Microsoft.Devices/stable/2018-04-01/iothub.json
```

### Tag: package-2018-01

These settings apply only when `--tag=package-2018-01` is specified on the command line.

``` yaml $(tag) == 'package-2018-01'
input-file:
- Microsoft.Devices/stable/2018-01-22/iothub.json
```

### Tag: package-2017-07

These settings apply only when `--tag=package-2017-07` is specified on the command line.

``` yaml $(tag) == 'package-2017-07'
input-file:
- Microsoft.Devices/stable/2017-07-01/iothub.json
```

### Tag: package-2017-01

These settings apply only when `--tag=package-2017-01` is specified on the command line.

``` yaml $(tag) == 'package-2017-01'
input-file:
- Microsoft.Devices/stable/2017-01-19/iothub.json
```

### Tag: package-2016-02

These settings apply only when `--tag=package-2016-02` is specified on the command line.

``` yaml $(tag) == 'package-2016-02'
input-file:
- Microsoft.Devices/stable/2016-02-03/iothub.json
```

### Tag: profile-hybrid-2020-09-01

These settings apply only when `--tag=profile-hybrid-2020-09-01` is specified on the command line.

``` yaml $(tag) == 'profile-hybrid-2020-09-01'
input-file:
- Microsoft.Devices/preview/2019-07-01-preview/iothub.json
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
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_iot_hub']
  - repo: azure-resource-manager-schemas
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.IotHub
  output-folder: $(csharp-sdks-folder)/iothub/Microsoft.Azure.Management.IotHub/src/Generated
  clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.go.md)
