# ContainerServices

> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerServices (ACS/AKS/OpenShift).

The ContainerServices RPv2 consists of two similar services: ContainerServices and ManagedClusters.
Each service has its own swagger spec.

The two specs are united by running `autorest` in this directory, which will use this readme.md
file for configuration options. It will generate a single *azure-mgmt-containerservices* client
library.

---

# Getting Started

To build the SDK for ContainerServices, [install Autorest](https://aka.ms/autorest/install). Then
in this folder, run this command:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the ContainerServices API.

```yaml
openapi-type: arm
tag: package-2018-08-preview
```

### Tag: package-2018-08-preview

These settings apply only when `--tag=package-2018-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-08-preview'
input-file:
- Microsoft.ContainerService/preview/2018-09-30-preview/openShiftManagedClusters.json
- Microsoft.ContainerService/stable/2017-07-01/containerService.json
- Microsoft.ContainerService/preview/2018-08-01-preview/managedClusters.json
- Microsoft.ContainerService/stable/2017-09-30/location.json
```

### Tag: package-2018-09-30-preview

These settings apply only when `--tag=package-2018-09-30-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-09-30-preview'
input-file:
- Microsoft.ContainerService/preview/2018-09-30-preview/openShiftManagedClusters.json
- Microsoft.ContainerService/stable/2017-07-01/containerService.json
- Microsoft.ContainerService/stable/2018-03-31/managedClusters.json
- Microsoft.ContainerService/stable/2017-09-30/location.json
```

### Tag: package-2018-03

These settings apply only when `--tag=package-2018-03` is specified on the command line.

``` yaml $(tag) == 'package-2018-03'
input-file:
- Microsoft.ContainerService/stable/2017-07-01/containerService.json
- Microsoft.ContainerService/stable/2018-03-31/managedClusters.json
- Microsoft.ContainerService/stable/2017-09-30/location.json
```

### Tag: package-2017-09

These settings apply only when `--tag=package-2017-09` is specified on the command line.

``` yaml $(tag) == 'package-2017-09'
input-file:
- Microsoft.ContainerService/stable/2017-07-01/containerService.json
- Microsoft.ContainerService/stable/2017-08-31/managedClusters.json
- Microsoft.ContainerService/stable/2017-09-30/location.json
```

### Tag: package-2017-08

These settings apply only when `--tag=package-2017-08` is specified on the command line.

``` yaml $(tag) == 'package-2017-08'
input-file:
- Microsoft.ContainerService/stable/2017-07-01/containerService.json
- Microsoft.ContainerService/stable/2017-08-31/managedClusters.json
```

### Tag: package-2017-07

These settings apply only when `--tag=package-2017-07` is specified on the command line.

``` yaml $(tag) == 'package-2017-07'
input-file:
- Microsoft.ContainerService/stable/2017-07-01/containerService.json
```

### Tag: package-2018-08-preview-only

These settings apply only when `--tag=package-2018-08-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-08-preview-only'
input-file:
- Microsoft.ContainerService/preview/2018-08-01-preview/managedClusters.json
```

### Tag: package-2018-09-preview-only

These settings apply only when `--tag=package-2018-09-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-09-preview-only'
input-file:
- Microsoft.ContainerService/preview/2018-09-30-preview/openShiftManagedClusters.json
```

### Tag: package-2018-03-only

These settings apply only when `--tag=package-2018-03-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-03-only'
input-file:
- Microsoft.ContainerService/stable/2018-03-31/managedClusters.json
```

### Tag: package-2017-07-only-extended

These settings apply only when `--tag=package-2017-07-only-extended` is specified on the command line.

This tag is special, since it brings together two API version that belongs
to the same operation group, since Python does not know how to handle
multi-api operation group for now.

``` yaml $(tag) == 'package-2017-07-only-extended'
input-file:
- Microsoft.ContainerService/stable/2017-07-01/containerService.json
- Microsoft.ContainerService/stable/2017-09-30/location.json
```

### Tag: package-2017-08-only

These settings apply only when `--tag=package-2017-08-only` is specified on the command line.

``` yaml $(tag) == 'package-2017-08-only'
input-file:
- Microsoft.ContainerService/stable/2017-08-31/managedClusters.json
```

### Tag: package-2017-09-only

These settings apply only when `--tag=package-2017-09-only` is specified on the command line.

``` yaml $(tag) == 'package-2017-09-only'
input-file:
- Microsoft.ContainerService/stable/2017-09-30/location.json
```

### Tag: package-2017-01-only

These settings apply only when `--tag=package-2017-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2017-01-only'
input-file:
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2016-09-only

These settings apply only when `--tag=package-2016-09-only` is specified on the command line.

``` yaml $(tag) == 'package-2016-09-only'
input-file:
- Microsoft.ContainerService/stable/2016-09-30/containerService.json
```

### Tag: package-2016-03-only

These settings apply only when `--tag=package-2016-03-only` is specified on the command line.

``` yaml $(tag) == 'package-2016-03-only'
input-file:
- Microsoft.ContainerService/stable/2016-03-30/containerService.json
```

---

# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
    after_scripts:
      - python ./scripts/multiapi_init_gen.py azure-mgmt-containerservice
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_container_service']
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.ContainerService
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/ContainerService/Management.ContainerService/Generated
  clear-output-folder: true
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.containerservice
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-containerservice
title: ContainerServiceManagementClient
description: "Container Service Client"
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2017-09-only
  - tag: package-2017-08-only
  - tag: package-2017-07
```

### Tag: package-2017-09-only and java

These settings apply only when `--tag=package-2017-09-only` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-09-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2017_09_30
  output-folder: $(azure-libraries-for-java-folder)/containerservice/resource-manager/v2017_09_30
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-08-only and java

These settings apply only when `--tag=package-2017-08-only` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-08-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2017_08_31
  output-folder: $(azure-libraries-for-java-folder)/containerservice/resource-manager/v2017_08_31
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-07 and java

These settings apply only when `--tag=package-2017-07` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2017_07_01
  output-folder: $(azure-libraries-for-java-folder)/containerservice/resource-manager/v2017_07_01
regenerate-manager: true
generate-interface: true
```

## Suppression

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: managedClusters.json
    reason: Name change of "enableRBAC" property would break compatibility
  - suppress: TrackedResourcePatchOperation
    from: containerService.json
    reason: ACS service is deprecated so a PATCH endpoint won't be implemented
```
