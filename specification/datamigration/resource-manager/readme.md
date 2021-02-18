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
- Microsoft.DataMigration/stable/2018-04-19/definitions/Commands.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/Common.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToSourceMySqlTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToSourcePostgreSqlSyncTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToSourceSqlServerTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToTargetAzureDbForMySqlTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToTargetSqlDbTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToTargetSqlMITask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToTargetSqlMiSyncTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToTargetSqlSqlDbSyncTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/GetTdeCertificatesSqlTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/GetUserTablesSqlSyncTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/GetUserTablesSqlTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/MigrateSqlServerSqlDbSyncTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/MigrateSqlServerSqlDbTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/MigrateSqlServerSqlMITask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/MigrateSqlServerSqlMiSyncTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/Projects.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/Services.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/Tasks.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/TasksCommon.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/MigrationValidation.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/ValidateMigrationInputSqlServerSqlMITask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
- Microsoft.DataMigration/stable/2018-04-19/definitions/ValidateSyncMigrationInputSqlServerTask.json
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
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToSourcePostgreSqlSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetAzureDbForMySqlTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetSqlDbTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetSqlMiSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetSqlMITask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetSqlSqlDbSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/GetUserTablesSqlSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/GetUserTablesSqlTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSchemaSqlServerSqlDbTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSqlServerSqlDbSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSqlServerSqlDbTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSqlServerSqlMiSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSqlServerSqlMITask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSsisTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrationValidation.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MongoDbTasks.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/GetTdeCertificatesSqlTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/OracleAzureDbPostgreSqlSyncTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/Projects.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ServiceFeatureOCITask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/Services.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ServiceTasks.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/Tasks.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/TasksCommon.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ValidateSyncMigrationInputSqlServerTask.json
- Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
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
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-java
  - repo: azure-resource-manager-schemas
    after_scripts:
      - node sdkauto_afterscript.js datamigration/resource-manager
```

## C#

These settings apply only when --csharp is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.DataMigration
  output-folder: $(csharp-sdks-folder)/datamigration/Microsoft.Azure.Management.DataMigration/src/Generated
  clear-output-folder: true
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)

## Multi-API/Profile support for AutoRest v3 generators 

AutoRest V3 generators require the use of `--tag=all-api-versions` to select api files.

This block is updated by an automatic script. Edits may be lost!

``` yaml $(tag) == 'all-api-versions' /* autogenerated */
# include the azure profile definitions from the standard location
require: $(this-folder)/../../../profiles/readme.md

# all the input files across all versions
input-file:
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/datamigration.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/Commands.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/Common.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToSourceMySqlTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToSourcePostgreSqlSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToSourceSqlServerTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToTargetAzureDbForMySqlTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToTargetSqlDbTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToTargetSqlMITask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToTargetSqlMiSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/ConnectToTargetSqlSqlDbSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/GetTdeCertificatesSqlTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/GetUserTablesSqlSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/GetUserTablesSqlTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/MigrateSqlServerSqlDbSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/MigrateSqlServerSqlDbTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/MigrateSqlServerSqlMITask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/MigrateSqlServerSqlMiSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/Projects.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/Services.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/Tasks.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/TasksCommon.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/MigrationValidation.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/ValidateMigrationInputSqlServerSqlMITask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/stable/2018-04-19/definitions/ValidateSyncMigrationInputSqlServerTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/datamigration.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/Commands.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/Common.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToSourceMySqlTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToSourceSqlServerTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToSourcePostgreSqlSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetAzureDbForMySqlTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetSqlDbTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetSqlMiSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetSqlMITask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetSqlSqlDbSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/GetUserTablesSqlSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/GetUserTablesSqlTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSchemaSqlServerSqlDbTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSqlServerSqlDbSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSqlServerSqlDbTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSqlServerSqlMiSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSqlServerSqlMITask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrateSsisTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MigrationValidation.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/MongoDbTasks.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/GetTdeCertificatesSqlTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/OracleAzureDbPostgreSqlSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/Projects.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ServiceFeatureOCITask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/Services.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ServiceTasks.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/Tasks.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/TasksCommon.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ValidateSyncMigrationInputSqlServerTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-07-15-preview/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-31-preview/datamigration.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-31-preview/definitions/Common.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-31-preview/definitions/ConnectToSourceSqlServerTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-31-preview/definitions/ConnectToTargetSqlDbTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-31-preview/definitions/ConnectToTargetSqlMITask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-31-preview/definitions/GetUserTablesSqlTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-31-preview/definitions/MigrateSqlServerSqlDbTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-31-preview/definitions/MigrateSqlServerSqlMITask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-31-preview/definitions/Projects.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-31-preview/definitions/Services.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-31-preview/definitions/Tasks.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-31-preview/definitions/TasksCommon.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-31-preview/definitions/MigrationValidation.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-31-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-15-preview/datamigration.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-15-preview/definitions/Common.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-15-preview/definitions/ConnectToSourceSqlServerTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-15-preview/definitions/ConnectToTargetSqlDbTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-15-preview/definitions/ConnectToTargetSqlMITask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-15-preview/definitions/GetUserTablesSqlTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-15-preview/definitions/MigrateSqlServerSqlDbTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-15-preview/definitions/MigrateSqlServerSqlMITask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-15-preview/definitions/Projects.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-15-preview/definitions/Services.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-15-preview/definitions/Tasks.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-15-preview/definitions/TasksCommon.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-15-preview/definitions/MigrationValidation.json
  - $(this-folder)/Microsoft.DataMigration/preview/2018-03-15-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2017-11-15-preview/datamigration.json
  - $(this-folder)/Microsoft.DataMigration/preview/2017-11-15-preview/definitions/Common.json
  - $(this-folder)/Microsoft.DataMigration/preview/2017-11-15-preview/definitions/ConnectToSourceSqlServerTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2017-11-15-preview/definitions/ConnectToTargetSqlDbTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2017-11-15-preview/definitions/GetUserTablesSqlTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2017-11-15-preview/definitions/MigrateSqlServerSqlDbTask.json
  - $(this-folder)/Microsoft.DataMigration/preview/2017-11-15-preview/definitions/Projects.json
  - $(this-folder)/Microsoft.DataMigration/preview/2017-11-15-preview/definitions/Services.json
  - $(this-folder)/Microsoft.DataMigration/preview/2017-11-15-preview/definitions/Tasks.json
  - $(this-folder)/Microsoft.DataMigration/preview/2017-11-15-preview/definitions/TasksCommon.json
  - $(this-folder)/Microsoft.DataMigration/preview/2017-11-15-preview/definitions/MigrationValidation.json

```

If there are files that should not be in the `all-api-versions` set, 
uncomment the  `exclude-file` section below and add the file paths.

``` yaml $(tag) == 'all-api-versions'
#exclude-file: 
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```

