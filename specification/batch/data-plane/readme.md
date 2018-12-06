# Batch

> see https://aka.ms/autorest

This is the AutoRest configuration file for Batch.



---
## Getting Started
To build the SDK for Batch, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the Batch API.

``` yaml
openapi-type: data-plane
tag: package-2018-08.7.0
```

### Tag: package-2018-08.7.0

These settings apply only when `--tag=package-2018-08.7.0` is specified on the command line.

``` yaml $(tag) == 'package-2018-08.7.0'
input-file:
- Microsoft.Batch/stable/2018-08-01.7.0/BatchService.json
```

### Tag: package-2018-03.6.1

These settings apply only when `--tag=package-2018-03.6.1` is specified on the command line.

``` yaml $(tag) == 'package-2018-03.6.1'
input-file:
- Microsoft.Batch/stable/2018-03-01.6.1/BatchService.json
```

### Tag: package-2017-09.6.0

These settings apply only when `--tag=package-2017-09.6.0` is specified on the command line.

``` yaml $(tag) == 'package-2017-09.6.0'
input-file:
- Microsoft.Batch/stable/2017-09-01.6.0/BatchService.json
```

### Tag: package-2017-06.5.1

These settings apply only when `--tag=package-2017-06.5.1` is specified on the command line.

``` yaml $(tag) == 'package-2017-06.5.1'
input-file:
- Microsoft.Batch/stable/2017-06-01.5.1/BatchService.json
```

## Suppression

Note that this setting should be removed once [this GitHub bug](https://github.com/Azure/azure-openapi-validator/issues/68) is fixed.
``` yaml
directive:
  - suppress: R2063
    from: BatchService.json
    reason: Bug in linter
```

Note that this setting should be removed once [this GitHub bug](https://github.com/Azure/azure-openapi-validator/issues/69) is fixed.
``` yaml
directive:
  - suppress: R2064
    from: BatchService.json
    reason: This is a data plane swagger specification, LRO's do not apply
```

``` yaml
directive:
  - suppress: R3016
    from: BatchService.json
    where: $..["odata.nextLink"]
    reason: The casing of this property is not incorrect.
```

``` yaml
directive:
  - suppress: R3016
    from: BatchService.json
    where: $..["publicFQDN"]
    reason: The suggested casing of this property is worse than the casing that we're using
```

``` yaml
directive:
  - suppress: R3016
    from: BatchService.json
    where: $.definitions.JobScheduleStatistics.properties.kernelCPUTime
    reason: The suggested casing of this property is worse than the casing that we're using
```

``` yaml
directive:
  - suppress: R3016
    from: BatchService.json
    where: $.definitions.TaskStatistics.properties.userCPUTime
    reason: The suggested casing of this property is worse than the casing that we're using
```

``` yaml
directive:
  - suppress: R3016
    from: BatchService.json
    where: $.definitions.TaskStatistics.properties.kernelCPUTime
    reason: The suggested casing of this property is worse than the casing that we're using
```

``` yaml
directive:
  - suppress: R3016
    from: BatchService.json
    where: $.definitions.JobScheduleStatistics.properties.userCPUTime
    reason: The suggested casing of this property is worse than the casing that we're using
```

``` yaml
directive:
  - suppress: R3016
    from: BatchService.json
    where: $.definitions.JobStatistics.properties.kernelCPUTime
    reason: The suggested casing of this property is worse than the casing that we're using
```

``` yaml
directive:
  - suppress: R3016
    from: BatchService.json
    where: $.definitions.JobStatistics.properties.userCPUTime
    reason: The suggested casing of this property is worse than the casing that we're using
```

``` yaml
directive:
  - suppress: R3016
    from: BatchService.json
    where: $.definitions.ResourceStatistics.properties.avgCPUPercentage
    reason: The suggested casing of this property is worse than the casing that we're using
```

``` yaml
directive:
  - suppress: R3016
    from: BatchService.json
    where: $.definitions.PoolEndpointConfiguration.properties.inboundNATPools
    reason: The suggested casing of this property is worse than the casing that we're using
```

``` yaml
directive:
  - suppress: R3016
    from: BatchService.json
    where: $.definitions.VirtualMachineConfiguration.properties.nodeAgentSKUId
    reason: The suggested casing of this property is worse than the casing that we're using
```

### Tag: package-2017-05.5.0

These settings apply only when `--tag=package-2017-05.5.0` is specified on the command line.

``` yaml $(tag) == 'package-2017-05.5.0'
input-file:
- Microsoft.Batch/stable/2017-05-01.5.0/BatchService.json
```


### Tag: package-2017-01.4.0

These settings apply only when `--tag=package-2017-01.4.0` is specified on the command line.

``` yaml $(tag) == 'package-2017-01.4.0'
input-file:
- Microsoft.Batch/stable/2017-01-01.4.0/BatchService.json
```

### Tag: package-2016-07.3.1

These settings apply only when `--tag=package-2016-07.3.1` is specified on the command line.

``` yaml $(tag) == 'package-2016-07.3.1'
input-file:
- Microsoft.Batch/stable/2016-07-01.3.1/BatchService.json
```

### Tag: package-2016-02.3.0

These settings apply only when `--tag=package-2016-02.3.0` is specified on the command line.

``` yaml $(tag) == 'package-2016-02.3.0'
input-file:
- Microsoft.Batch/stable/2016-02-01.3.0/BatchService.json
```

### Tag: package-2015-12.2.2

These settings apply only when `--tag=package-2015-12.2.2` is specified on the command line.

``` yaml $(tag) == 'package-2015-12.2.2'
input-file:
- Microsoft.Batch/stable/2015-12-01.2.2/BatchService.json
```


---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 1
  namespace: Microsoft.Azure.Batch.Protocol
  output-folder: $(csharp-sdks-folder)/Batch/DataPlane/Azure.Batch/GeneratedProtocol
  clear-output-folder: true
  client-side-validation: false
```

## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.batch
  package-name: azure-batch
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-batch/azure/batch
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-batch
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-batch-sdk-for-java clone>`.

``` yaml $(java)
nodejs:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: com.microsoft.azure.batch.protocol
  output-folder: $(node-sdks-folder)/src/main/java
  payload-flattening-threshold: 1
  generate-license-txt: true
  clear-output-folder: true
```

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  fluent: true
  namespace: com.microsoft.azure.batch
  license-header: MICROSOFT_MIT_NO_CODEGEN
  payload-flattening-threshold: 1
  output-folder: $(azure-libraries-for-java-folder)/azure-batch
```
