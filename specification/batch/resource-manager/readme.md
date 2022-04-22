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
title: BatchManagementClient
description: Batch Client
openapi-type: arm
tag: package-2022-01
```

### Tag: package-2022-01

These settings apply only when `--tag=package-2022-01` is specified on the command line.

```yaml $(tag) == 'package-2022-01'
input-file:
  - Microsoft.Batch/stable/2022-01-01/BatchManagement.json
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

```yaml $(tag) == 'package-2021-06'
input-file:
  - Microsoft.Batch/stable/2021-06-01/BatchManagement.json
```

### Tag: package-2021-01

These settings apply only when `--tag=package-2021-01` is specified on the command line.

```yaml $(tag) == 'package-2021-01'
input-file:
  - Microsoft.Batch/stable/2021-01-01/BatchManagement.json
```

### Tag: package-2020-09

These settings apply only when `--tag=package-2020-09` is specified on the command line.

```yaml $(tag) == 'package-2020-09'
input-file:
  - Microsoft.Batch/stable/2020-09-01/BatchManagement.json
```

### Tag: package-2020-05

These settings apply only when `--tag=package-2020-05` is specified on the command line.

```yaml $(tag) == 'package-2020-05'
input-file:
  - Microsoft.Batch/stable/2020-05-01/BatchManagement.json
```

### Tag: package-2020-03

These settings apply only when `--tag=package-2020-03` is specified on the command line.

``` yaml $(tag) == 'package-2020-03'
input-file:
  - Microsoft.Batch/stable/2020-03-01/BatchManagement.json
```

### Tag: package-2019-08

These settings apply only when `--tag=package-2019-08` is specified on the command line.

``` yaml $(tag) == 'package-2019-08'
input-file:
  - Microsoft.Batch/stable/2019-08-01/BatchManagement.json
```

### Tag: package-2019-04

These settings apply only when `--tag=package-2019-04` is specified on the command line.

``` yaml $(tag) == 'package-2019-04'
input-file:
  - Microsoft.Batch/stable/2019-04-01/BatchManagement.json
```

### Tag: package-2018-12

These settings apply only when `--tag=package-2018-12` is specified on the command line.

``` yaml $(tag) == 'package-2018-12'
input-file:
  - Microsoft.Batch/stable/2018-12-01/BatchManagement.json
```

### Tag: package-2017-09

These settings apply only when `--tag=package-2017-09` is specified on the command line.

``` yaml $(tag) == 'package-2017-09'
input-file:
- Microsoft.Batch/stable/2017-09-01/BatchManagement.json
```

## Suppression

Note that this setting should be removed once [this GitHub bug](https://github.com/Azure/azure-openapi-validator/issues/68) is fixed.

``` yaml
directive:
  - suppress: R2001
    where: $.definitions.Operation.properties.properties
    reason: Breaking change.

  - suppress: R2017
    where:
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}"].put
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/certificates/{certificateName}"].put
    reason: Matching service response.

  - suppress: R2063
    reason: Bug in linter

  - suppress: R2066
    where:
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/certificates/{certificateName}/cancelDelete"].post.operationId
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/listKeys"].post.operationId
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/regenerateKeys"].post.operationId
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/syncAutoStorageKeys"].post.operationId
    reason: This is fine as long as the OperationIds are all unique (as they presently are), and fixing it would likely involve a breaking change.

  - suppress: R3018
    where:
     - $.definitions.ApplicationProperties.properties.allowUpdates
     - $.definitions.BatchAccountProperties.properties.dedicatedCoreQuotaPerVMFamilyEnforced
     - $.definitions.CheckNameAvailabilityResult.properties.nameAvailable
     - $.definitions.StartTask.properties.waitForSuccess
     - $.definitions.VMExtension.properties.autoUpgradeMinorVersion
     - $.definitions.WindowsConfiguration.properties.enableAutomaticUpdates
    reason: Breaking change.

  - suppress: R3018
    where:
     - $.definitions.Operation.properties.isDataAction
    reason: Boolean required for operations schema.

  - suppress: R4009
    where:
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}"].get
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}"].patch
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}"].put
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/applications/{applicationName}"].get
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/applications/{applicationName}"].patch
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/applications/{applicationName}"].put
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/applications/{applicationName}/versions/{versionName}"].get
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/applications/{applicationName}/versions/{versionName}"].put
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/certificates/{certificateName}"].get
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/certificates/{certificateName}"].patch
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/certificates/{certificateName}"].put
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/detectors/{detectorId}"].get
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/detectors/{detectorId}"].patch
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/detectors/{detectorId}"].put
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/pools/{poolName}"].get
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/pools/{poolName}"].put
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/pools/{poolName}"].patch
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}"].patch
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}"].get
     - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/privateLinkResources/{privateLinkResourceName}"].get
    reason: Service missing headers.

  - suppress: OBJECT_MISSING_REQUIRED_PROPERTY
    where: $.definitions.UserAccount
    reason: This field contains a secret (password) and is not returned on a get (but is required on a PUT/PATCH). Previous discussions with the modelling team had said that this was the correct way to model this type of field.
```

### Tag: package-2017-05

These settings apply only when `--tag=package-2017-05` is specified on the command line.

``` yaml $(tag) == 'package-2017-05'
input-file:
- Microsoft.Batch/stable/2017-05-01/BatchManagement.json
```

### Tag: package-2017-01

These settings apply only when `--tag=package-2017-01` is specified on the command line.

``` yaml $(tag) == 'package-2017-01'
input-file:
- Microsoft.Batch/stable/2017-01-01/BatchManagement.json
```

### Tag: package-2015-12

These settings apply only when `--tag=package-2015-12` is specified on the command line.

``` yaml $(tag) == 'package-2015-12'
input-file:
- Microsoft.Batch/stable/2015-12-01/BatchManagement.json
```

---

## Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_batch']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C\#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # last generated with AutoRest.1.0.0-Nightly20170129 from commit 19f63015ea5a8a0fc64b9d7e2cdfeac447d93eaf
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Batch
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/batch/Microsoft.Azure.Management.Batch/src/Generated
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
namespace: com.microsoft.azure.management.batch
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-batch
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2015-12
  - tag: package-2017-09
  - tag: package-2017-01
  - tag: package-2017-05
```

### Tag: package-2015-12 and java

These settings apply only when `--tag=package-2015-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.batch.v2015_12_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/batch/mgmt-v2015_12_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-09 and java

These settings apply only when `--tag=package-2017-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.batch.v2017_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/batch/mgmt-v2017_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-01 and java

These settings apply only when `--tag=package-2017-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.batch.v2017_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/batch/mgmt-v2017_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-05 and java

These settings apply only when `--tag=package-2017-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.batch.v2017_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/batch/mgmt-v2017_05_01
regenerate-manager: true
generate-interface: true
```

`
