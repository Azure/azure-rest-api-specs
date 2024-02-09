# ContainerRegistry

> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerRegistry.

---

## Getting Started

To build the SDK for ContainerRegistry, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the ContainerRegistry API.

``` yaml
openapi-type: arm
tag: package-2023-11-preview
```


### Tag: package-2023-11-preview-only

These settings apply only when `--tag=package-2023-11-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2023-11-preview-only'
input-file:
  - Microsoft.ContainerRegistry/preview/2023-11-01-preview/containerregistry.json
```

### Tag: package-2023-11-preview

These settings apply only when `--tag=package-2023-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-11-preview'
input-file:
  - Microsoft.ContainerRegistry/preview/2023-11-01-preview/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
```

### Tag: package-2023-08-preview-only

These settings apply only when `--tag=package-2023-08-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2023-08-preview-only'
input-file:
  - Microsoft.ContainerRegistry/preview/2023-08-01-preview/containerregistry.json
```

### Tag: package-2023-08-preview

These settings apply only when `--tag=package-2023-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-08-preview'
input-file:
  - Microsoft.ContainerRegistry/preview/2023-08-01-preview/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
```

### Tag: package-2023-07-only

These settings apply only when `--tag=package-2023-07-only` is specified on the command line.

``` yaml $(tag) == 'package-2023-07-only'
input-file:
  - Microsoft.ContainerRegistry/stable/2023-07-01/containerregistry.json
```

### Tag: package-2023-07

These settings apply only when `--tag=package-2023-07` is specified on the command line.

``` yaml $(tag) == 'package-2023-07'
input-file:
  - Microsoft.ContainerRegistry/stable/2023-07-01/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
```

### Tag: package-2023-06-preview-only

These settings apply only when `--tag=package-2023-06-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2023-06-preview-only'
input-file:
  - Microsoft.ContainerRegistry/preview/2023-06-01-preview/containerregistry.json
```

### Tag: package-2023-06-preview

These settings apply only when `--tag=package-2023-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-06-preview'
input-file:
  - Microsoft.ContainerRegistry/preview/2023-06-01-preview/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
```

### Tag: package-2023-01-preview-only

These settings apply only when `--tag=package-2023-01-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2023-01-preview-only'
input-file:
  - Microsoft.ContainerRegistry/preview/2023-01-01-preview/containerregistry.json
```

### Tag: package-2023-01-preview

These settings apply only when `--tag=package-2023-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-01-preview'
input-file:
  - Microsoft.ContainerRegistry/preview/2023-01-01-preview/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
```

### Tag: package-2022-12-only

These settings apply only when `--tag=package-2022-12-only` is specified on the command line.

``` yaml $(tag) == 'package-2022-12-only'
input-file:
  - Microsoft.ContainerRegistry/stable/2022-12-01/containerregistry.json
```

### Tag: package-2022-12

These settings apply only when `--tag=package-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-2022-12'
input-file:
  - Microsoft.ContainerRegistry/stable/2022-12-01/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
```

### Tag: package-2022-02-preview-only

These settings apply only when `--tag=package-2022-02-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2022-02-preview-only'
input-file:
  - Microsoft.ContainerRegistry/preview/2022-02-01-preview/containerregistry.json
```

### Tag: package-2022-02-preview

These settings apply only when `--tag=package-2022-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-02-preview'
input-file:
  - Microsoft.ContainerRegistry/preview/2022-02-01-preview/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
```

### Tag: package-2021-12-preview-only

These settings apply only when `--tag=package-2021-12-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2021-12-preview-only'
input-file:
  - Microsoft.ContainerRegistry/preview/2021-12-01-preview/containerregistry.json
```

### Tag: package-2021-12-preview

These settings apply only when `--tag=package-2021-12-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-12-preview'
input-file:
  - Microsoft.ContainerRegistry/preview/2021-12-01-preview/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
```

### Tag: package-2021-09-only

These settings apply only when `--tag=package-2021-09-only` is specified on the command line.

``` yaml $(tag) == 'package-2021-09-only'
input-file:
  - Microsoft.ContainerRegistry/stable/2021-09-01/containerregistry.json
```

### Tag: package-2021-09

These settings apply only when `--tag=package-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-2021-09'
input-file:
  - Microsoft.ContainerRegistry/stable/2021-09-01/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
```

### Tag: package-2021-08-preview-only

These settings apply only when `--tag=package-2021-08-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2021-08-preview-only'
input-file:
  - Microsoft.ContainerRegistry/preview/2021-08-01-preview/containerregistry.json
```

### Tag: package-2021-08-preview

These settings apply only when `--tag=package-2021-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-08-preview'
input-file:
  - Microsoft.ContainerRegistry/preview/2021-08-01-preview/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
```

### Tag: package-2021-06-preview-only

These settings apply only when `--tag=package-2021-06-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2021-06-preview-only'
input-file:
  - Microsoft.ContainerRegistry/preview/2021-06-01-preview/containerregistry.json
```

### Tag: package-2021-06-preview

These settings apply only when `--tag=package-2021-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-06-preview'
input-file:
  - Microsoft.ContainerRegistry/preview/2021-06-01-preview/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
```

### Tag: package-2020-11-preview-only

These settings apply only when `--tag=package-2020-11-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-11-preview-only'
input-file:
  - Microsoft.ContainerRegistry/preview/2020-11-01-preview/containerregistry.json
```

### Tag: package-2020-11-preview

These settings apply only when `--tag=package-2020-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-11-preview'
input-file:
  - Microsoft.ContainerRegistry/preview/2020-11-01-preview/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
```

### Tag: package-2019-12-preview-only

These settings apply only when `--tag=package-2019-12-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-12-preview-only'
input-file:
  - Microsoft.ContainerRegistry/preview/2019-12-01-preview/containerregistry.json
```

### Tag: package-2019-12-preview

These settings apply only when `--tag=package-2019-12-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-12-preview'
input-file:
  - Microsoft.ContainerRegistry/preview/2019-12-01-preview/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
  - Microsoft.ContainerRegistry/preview/2019-05-01-preview/containerregistry_scopemap.json
```

### Tag: package-2019-06-preview

These settings apply only when `--tag=package-2019-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-06-preview'
input-file:
- Microsoft.ContainerRegistry/stable/2019-05-01/containerregistry.json
- Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
- Microsoft.ContainerRegistry/preview/2019-05-01-preview/containerregistry_scopemap.json
```

### Tag: package-2019-06-preview-only

These settings apply only when `--tag=package-2019-06-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-06-preview-only'
input-file:
- Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
```

### Tag: package-2019-05-only

These settings apply only when `--tag=package-2019-05-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-05-only'
input-file:
- Microsoft.ContainerRegistry/stable/2019-05-01/containerregistry.json
```

### Tag: package-2019-05

These settings apply only when `--tag=package-2019-05` is specified on the command line.

``` yaml $(tag) == 'package-2019-05'
input-file:
- Microsoft.ContainerRegistry/stable/2019-05-01/containerregistry.json
- Microsoft.ContainerRegistry/stable/2019-04-01/containerregistry_build.json
```

### Tag: package-2019-05-preview-only

These settings apply only when `--tag=package-2019-05-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-05-preview-only'
input-file:
- Microsoft.ContainerRegistry/preview/2019-05-01-preview/containerregistry_scopemap.json
```

### Tag: package-2019-05-preview

These settings apply only when `--tag=package-2019-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-05-preview'
input-file:
- Microsoft.ContainerRegistry/stable/2017-10-01/containerregistry.json
- Microsoft.ContainerRegistry/preview/2019-05-01-preview/containerregistry_scopemap.json
```

### Tag: package-2019-04

These settings apply only when `--tag=package-2019-04` is specified on the command line.

``` yaml $(tag) == 'package-2019-04'
input-file:
- Microsoft.ContainerRegistry/stable/2017-10-01/containerregistry.json
- Microsoft.ContainerRegistry/stable/2019-04-01/containerregistry_build.json
```

### Tag: package-2019-04-only

These settings apply only when `--tag=package-2019-04-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-04-only'
input-file:
- Microsoft.ContainerRegistry/stable/2019-04-01/containerregistry_build.json
```

### Tag: package-2018-09-only

These settings apply only when `--tag=package-2018-09-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-09-only'
input-file:
- Microsoft.ContainerRegistry/stable/2018-09-01/containerregistry_build.json
```

### Tag: package-2018-09

These settings apply only when `--tag=package-2018-09` is specified on the command line.

``` yaml $(tag) == 'package-2018-09'
input-file:
- Microsoft.ContainerRegistry/stable/2017-10-01/containerregistry.json
- Microsoft.ContainerRegistry/stable/2018-09-01/containerregistry_build.json
```

### Tag: package-2018-02-preview-only

These settings apply only when `--tag=package-2018-02-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-02-preview-only'
input-file:
- Microsoft.ContainerRegistry/preview/2018-02-01-preview/containerregistry_build.json
```

### Tag: package-2018-02-preview

These settings apply only when `--tag=package-2018-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-02-preview'
input-file:
- Microsoft.ContainerRegistry/stable/2017-10-01/containerregistry.json
- Microsoft.ContainerRegistry/preview/2018-02-01-preview/containerregistry_build.json
```

### Tag: package-2017-10

These settings apply only when `--tag=package-2017-10` is specified on the command line.

``` yaml $(tag) == 'package-2017-10'
input-file:
- Microsoft.ContainerRegistry/stable/2017-10-01/containerregistry.json
```

### Tag: package-2017-06-preview

These settings apply only when `--tag=package-2017-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-06-preview'
input-file:
- Microsoft.ContainerRegistry/preview/2017-06-01-preview/containerregistry.json
```

### Tag: package-2017-03

These settings apply only when `--tag=package-2017-03` is specified on the command line.

``` yaml $(tag) == 'package-2017-03'
input-file:
- Microsoft.ContainerRegistry/stable/2017-03-01/containerregistry.json
```

### Tag: package-2016-06-preview

These settings apply only when `--tag=package-2016-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2016-06-preview'
input-file:
- Microsoft.ContainerRegistry/preview/2016-06-27-preview/containerregistry.json
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
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_container_registry']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # stop the simplifier from making Task conflict:
  skip-simplifier-on-namespace:
    - System.Threading.Tasks
  # last generated using AutoRest.1.0.0-Nightly20170212 with commit 3b0b26b4b6e3bc5e7cf3610b0866d310abb5b814
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.ContainerRegistry
  payload-flattening-threshold: 2
  output-folder: $(csharp-sdks-folder)/containerregistry/Microsoft.Azure.Management.ContainerRegistry/src/Generated
  clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

### Suppress rules to be fixed

``` yaml
suppressions:
  - code: TrackedResourcePatchOperation
    from: containerregistry.json
    reason: The following workitems will be implemented to improve the swagger for the next API verison. Workitems 24979281, 24778096, 24802955, 24802955. This is planned for 2023-11-01-preview
```
