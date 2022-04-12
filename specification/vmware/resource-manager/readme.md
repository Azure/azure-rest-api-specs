# VMware Solution

> see https://aka.ms/autorest

This is the AutoRest configuration file for VMware Solution.

## Getting Started
To build the SDK for VMware Solution, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the VMware Solution API.

``` yaml
openapi-type: arm
tag: package-2021-12-01
```

### Tag: package-2021-12-01

These settings apply only when `--tag=package-2021-12-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-12-01'
input-file:
- Microsoft.AVS/stable/2021-12-01/vmware.json
directive:
  - suppress: R3020
    from: Microsoft.AVS/stable/2021-12-01/vmware.json
    reason: Microsoft.AVS was chosen over Microsoft.AzureVMwareSolution
  - suppress: R3010
    from: Microsoft.AVS/stable/2021-12-01/vmware.json
    reason: list by immediate parent operations are defined
  - suppress: R3027
    from: Microsoft.AVS/stable/2021-12-01/vmware.json
    reasons: the PrivateClouds_List operation is by resource group
  - suppress: R3018
    from: Microsoft.AVS/stable/2021-12-01/vmware.json
    where: $.definitions.Operation.properties.isDataAction
    reason: standard property for Operation
  - suppress: R3018
    from: Microsoft.AVS/stable/2021-12-01/vmware.json
    where: $.definitions.MetricSpecification.properties.fillGapWithZero
    reason: standard property for MetricSpecification
  - suppress: R2001
    from: Microsoft.AVS/stable/2021-12-01/vmware.json
    where: $.definitions.Operation.properties.properties
    reason: x-ms-client-flatten not needed for Operation
  - suppress: R4009
    from: Microsoft.AVS/stable/2021-12-01/vmware.json
    reason: systemData is not in this API version
  - suppress: R3018
    from: Microsoft.AVS/stable/2021-12-01/vmware.json
    reason: standard property defined by Geneva Metrics
```

### Tag: package-2021-06-01

These settings apply only when `--tag=package-2021-06-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-06-01'
input-file:
- Microsoft.AVS/stable/2021-06-01/vmware.json
directive:
  - suppress: R3020
    from: Microsoft.AVS/stable/2021-06-01/vmware.json
    reason: Microsoft.AVS was chosen over Microsoft.AzureVMwareSolution
  - suppress: R3010
    from: Microsoft.AVS/stable/2021-06-01/vmware.json
    reason: list by immediate parent operations are defined
  - suppress: R3027
    from: Microsoft.AVS/stable/2021-06-01/vmware.json
    reasons: the PrivateClouds_List operation is by resource group
  - suppress: R3018
    from: Microsoft.AVS/stable/2021-06-01/vmware.json
    where: $.definitions.Operation.properties.isDataAction
    reason: standard property for Operation
  - suppress: R3018
    from: Microsoft.AVS/stable/2021-06-01/vmware.json
    where: $.definitions.MetricSpecification.properties.fillGapWithZero
    reason: standard property for MetricSpecification
  - suppress: R2001
    from: Microsoft.AVS/stable/2021-06-01/vmware.json
    where: $.definitions.Operation.properties.properties
    reason: x-ms-client-flatten not needed for Operation
  - suppress: R4009
    from: Microsoft.AVS/stable/2021-06-01/vmware.json
    reason: systemData is not in this API version
  - suppress: R3018
    from: Microsoft.AVS/stable/2021-06-01/vmware.json
    where: $.definitions.MetricDimension.properties.toBeExportedForShoebox
    reason: standard property defined by Geneva Metrics
```

### Tag: package-2021-01-01-preview

These settings apply only when `--tag=package-2021-01-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-01-01-preview'
input-file:
- Microsoft.AVS/preview/2021-01-01-preview/vmware.json
directive:
  - suppress: R3020
    from: Microsoft.AVS/preview/2021-01-01-preview/vmware.json
    reason: Microsoft.AVS was chosen over Microsoft.AzureVMwareSolution
  - suppress: R3010
    from: Microsoft.AVS/preview/2021-01-01-preview/vmware.json
    reason: list by immediate parent operations are defined
  - suppress: R3027
    from: Microsoft.AVS/preview/2021-01-01-preview/vmware.json
    reasons: the PrivateClouds_List operation is by resource group
  - suppress: R3018
    from: Microsoft.AVS/preview/2021-01-01-preview/vmware.json
    where: $.definitions.Operation.properties.isDataAction
    reason: standard property for Operation
  - suppress: R3018
    from: Microsoft.AVS/preview/2021-01-01-preview/vmware.json
    where: $.definitions.MetricSpecification.properties.fillGapWithZero
    reason: standard property for MetricSpecification
  - suppress: R2001
    from: Microsoft.AVS/preview/2021-01-01-preview/vmware.json
    where: $.definitions.Operation.properties.properties
    reason: x-ms-client-flatten not needed for Operation
  - suppress: R4009
    from: Microsoft.AVS/preview/2021-01-01-preview/vmware.json
    reason: systemData is not in this API version
  - suppress: R3018
    from: Microsoft.AVS/preview/2021-01-01-preview/vmware.json
    where: $.definitions.MetricDimension.properties.toBeExportedForShoebox
    reason: standard property defined by Geneva Metrics
```

### Tag: package-2020-07-17-preview

These settings apply only when `--tag=package-2020-07-17-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-07-17-preview'
input-file:
- Microsoft.AVS/preview/2020-07-17-preview/vmware.json
directive:
  - suppress: R3020
    from: Microsoft.AVS/preview/2020-07-17-preview/vmware.json
    reason: Microsoft.AVS was chosen over Microsoft.AzureVMwareSolution
  - suppress: R3010
    from: Microsoft.AVS/preview/2020-07-17-preview/vmware.json
    reason: list by immediate parent operations are defined
  - suppress: R3027
    from: Microsoft.AVS/preview/2020-07-17-preview/vmware.json
    reasons: the PrivateClouds_List operation is by resource group
  - suppress: R3018
    from: Microsoft.AVS/preview/2020-07-17-preview/vmware.json
    where: $.definitions.Operation.properties.isDataAction
    reason: standard property for Operation
  - suppress: R3018
    from: Microsoft.AVS/preview/2020-07-17-preview/vmware.json
    where: $.definitions.MetricSpecification.properties.fillGapWithZero
    reason: standard property for MetricSpecification
  - suppress: R2001
    from: Microsoft.AVS/preview/2020-07-17-preview/vmware.json
    where: $.definitions.Operation.properties.properties
    reason: x-ms-client-flatten not needed for Operation
  - suppress: R4009
    from: Microsoft.AVS/preview/2020-07-17-preview/vmware.json
    reason: systemData is not in this API version
  - suppress: R3018
    from: Microsoft.AVS/preview/2020-07-17-preview/vmware.json
    where: $.definitions.MetricDimension.properties.toBeExportedForShoebox
    reason: standard property defined by Geneva Metrics
```

### Tag: package-2020-03-20

These settings apply only when `--tag=package-2020-03-20` is specified on the command line.

``` yaml $(tag) == 'package-2020-03-20'
input-file:
- Microsoft.AVS/stable/2020-03-20/vmware.json
directive:
  - suppress: R3020
    from: Microsoft.AVS/stable/2020-03-20/vmware.json
    reason: Microsoft.AVS was chosen over Microsoft.AzureVMwareSolution
  - suppress: R3010
    from: Microsoft.AVS/stable/2020-03-20/vmware.json
    reason: list by immediate parent operations are defined
  - suppress: R3027
    from: Microsoft.AVS/stable/2020-03-20/vmware.json
    reasons: the PrivateClouds_List operation is by resource group
  - suppress: R3018
    from: Microsoft.AVS/stable/2020-03-20/vmware.json
    where: $.definitions.Operation.properties.isDataAction
    reason: standard property for Operation
  - suppress: R3018
    from: Microsoft.AVS/stable/2020-03-20/vmware.json
    where: $.definitions.MetricSpecification.properties.fillGapWithZero
    reason: standard property for MetricSpecification
  - suppress: R2001
    from: Microsoft.AVS/stable/2020-03-20/vmware.json
    where: $.definitions.Operation.properties.properties
    reason: x-ms-client-flatten not needed for Operation
  - suppress: R3018
    from: Microsoft.AVS/stable/2020-03-20/vmware.json
    where: $.definitions.MetricDimension.properties.toBeExportedForShoebox
    reason: standard property defined by Geneva Metrics
```

---
# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-powershell
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-java
  - repo: azure-resource-manager-schemas
```

## Suppression
```
directive:
  - suppress: SECRET_PROPERTY
    from:
      - Microsoft.AVS/stable/2021-12-01/vmware.json
      - Microsoft.AVS/stable/2021-06-01/vmware.json
      - Microsoft.AVS/preview/2021-01-01-preview/vmware.json
      - Microsoft.AVS/preview/2020-07-17-preview/vmware.json
      - Microsoft.AVS/stable/2020-03-20/vmware.json
    where:
      - $.definitions.AdminCredentials.properties.nsxtPassword
      - $.definitions.AdminCredentials.properties.vcenterPassword
    reason: Secrets are OK to return in a POST response.
```

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)



