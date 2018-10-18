# Azure Database Migration Service

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Database Migration Service.

The Data Migration RP comprises of APIs that enable a customer to manage the service instances that help migrate databases from a source to target.

---

## Getting Started
To build the SDK for Compute, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information
These are the global settings for the Database Migration Service API.

``` yaml
title: DataMigrationManagementClient
description: Data Migration Client
openapi-type: arm
tag: package-2018-07-15-preview
```

### Tag: package-2018-04-19

These settings apply only when `--tag=package-2018-04-19` is specified on the command line.

``` yaml $(tag) == 'package-2018-04-19'
input-file:
- Microsoft.DataMigration/stable/2018-04-19/datamigration.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/Common.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToSourceSqlServerTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToTargetSqlDbTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/GetUserTablesSqlTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/MigrateSqlServerSqlDbTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/Projects.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/Services.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/Tasks.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/TasksCommon.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/MigrationValidation.json
```

### Tag: package-2018-07-15-preview

These settings apply only when `--tag=package-2018-07-15-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-07-15-preview'
input-file:
- Microsoft.DataMigration/preview/2018-07-15-preview/datamigration.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/Commands.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/Common.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToSourceMySqlTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToSourceSqlServerTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetAzureDbForMySqlTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetSqlDbTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetSqlMITask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetSqlSqlDbSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/GetUserTablesSqlSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/GetUserTablesSqlTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSchemaSqlServerSqlDbTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSqlServerSqlDbSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSqlServerSqlDbTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSqlServerSqlMITask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrationValidation.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/GetTdeCertificatesSqlTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/Projects.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/Services.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/Tasks.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/TasksCommon.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ValidateSyncMigrationInputSqlServerTask.json
```

### Tag: package-2018-03-31-preview

These settings apply only when `--tag=package-2018-03-31-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-03-31-preview'
input-file:
- Microsoft.DataMigration/preview/2018-03-31-preview/datamigration.json
- Microsoft.DataMigration/preview/2018-03-31-preview/definitions/Common.json
- Microsoft.DataMigration/preview/2018-03-31-preview/definitions/ConnectToSourceSqlServerTask.json
- Microsoft.DataMigration/preview/2018-03-31-preview/definitions/ConnectToTargetSqlDbTask.json
- Microsoft.DataMigration/preview/2018-03-31-preview/definitions/ConnectToTargetSqlMITask.json
- Microsoft.DataMigration/preview/2018-03-31-preview/definitions/GetUserTablesSqlTask.json
- Microsoft.DataMigration/preview/2018-03-31-preview/definitions/MigrateSqlServerSqlDbTask.json
- Microsoft.DataMigration/preview/2018-03-31-preview/definitions/MigrateSqlServerSqlMITask.json
- Microsoft.DataMigration/preview/2018-03-31-preview/definitions/Projects.json
- Microsoft.DataMigration/preview/2018-03-31-preview/definitions/Services.json
- Microsoft.DataMigration/preview/2018-03-31-preview/definitions/Tasks.json
- Microsoft.DataMigration/preview/2018-03-31-preview/definitions/TasksCommon.json
- Microsoft.DataMigration/preview/2018-03-31-preview/definitions/MigrationValidation.json
- Microsoft.DataMigration/preview/2018-03-31-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
```

### Tag: package-2018-03-15-preview

These settings apply only when `--tag=package-2018-03-15-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-03-15-preview'
input-file:
- Microsoft.DataMigration/preview/2018-03-15-preview/datamigration.json
- Microsoft.DataMigration/preview/2018-03-15-preview/definitions/Common.json
- Microsoft.DataMigration/preview/2018-03-15-preview/definitions/ConnectToSourceSqlServerTask.json
- Microsoft.DataMigration/preview/2018-03-15-preview/definitions/ConnectToTargetSqlDbTask.json
- Microsoft.DataMigration/preview/2018-03-15-preview/definitions/ConnectToTargetSqlMITask.json
- Microsoft.DataMigration/preview/2018-03-15-preview/definitions/GetUserTablesSqlTask.json
- Microsoft.DataMigration/preview/2018-03-15-preview/definitions/MigrateSqlServerSqlDbTask.json
- Microsoft.DataMigration/preview/2018-03-15-preview/definitions/MigrateSqlServerSqlMITask.json
- Microsoft.DataMigration/preview/2018-03-15-preview/definitions/Projects.json
- Microsoft.DataMigration/preview/2018-03-15-preview/definitions/Services.json
- Microsoft.DataMigration/preview/2018-03-15-preview/definitions/Tasks.json
- Microsoft.DataMigration/preview/2018-03-15-preview/definitions/TasksCommon.json
- Microsoft.DataMigration/preview/2018-03-15-preview/definitions/MigrationValidation.json
- Microsoft.DataMigration/preview/2018-03-15-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
```

### Tag: package-2017-11-15-preview

These settings apply only when `--tag=package-2017-11-15-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-11-15-preview'
input-file:
- Microsoft.DataMigration/preview/2017-11-15-preview/datamigration.json
- Microsoft.DataMigration/preview/2017-11-15-preview/definitions/Common.json
- Microsoft.DataMigration/preview/2017-11-15-preview/definitions/ConnectToSourceSqlServerTask.json
- Microsoft.DataMigration/preview/2017-11-15-preview/definitions/ConnectToTargetSqlDbTask.json
- Microsoft.DataMigration/preview/2017-11-15-preview/definitions/GetUserTablesSqlTask.json
- Microsoft.DataMigration/preview/2017-11-15-preview/definitions/MigrateSqlServerSqlDbTask.json
- Microsoft.DataMigration/preview/2017-11-15-preview/definitions/Projects.json
- Microsoft.DataMigration/preview/2017-11-15-preview/definitions/Services.json
- Microsoft.DataMigration/preview/2017-11-15-preview/definitions/Tasks.json
- Microsoft.DataMigration/preview/2017-11-15-preview/definitions/TasksCommon.json
- Microsoft.DataMigration/preview/2017-11-15-preview/definitions/MigrationValidation.json
```

---

# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
```

## C#

These settings apply only when --csharp is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.DataMigration
  output-folder: $(csharp-sdks-folder)/DataMigration/Management.DataMigration/Generated
  clear-output-folder: true
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
  namespace: azure.mgmt.datamigration
  package-name: azure-mgmt-datamigration
  package-version: 0.1.0
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt-datamigration/azure/mgmt/datamigration
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-datamigration
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.datamigration
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-datamigration
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2017-11-15-preview
  - tag: package-2018-03-31-preview
```

### Tag: package-2017-11-15-preview and java

These settings apply only when `--tag=package-2017-11-15-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-11-15-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.azuredatabasemigrationservice.v2017_11_15_preview
  output-folder: $(azure-libraries-for-java-folder)/azuredatabasemigrationservice/resource-manager/v2017_11_15_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-03-31-preview and java

These settings apply only when `--tag=package-2018-03-31-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-03-31-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.azuredatabasemigrationservice.v2018_03_31_preview
  output-folder: $(azure-libraries-for-java-folder)/azuredatabasemigrationservice/resource-manager/v2018_03_31_preview
regenerate-manager: true
generate-interface: true
```


