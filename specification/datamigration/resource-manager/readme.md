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
tag: package-preview-2022-03
```

### Tag: package-preview-2022-03

These settings apply only when `--tag=package-preview-2022-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2022-03'
input-file:
  - Microsoft.DataMigration/preview/2022-03-30-preview/sqlmigration.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/datamigration.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/Commands.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/Common.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ConnectToSourceMySqlTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ConnectToSourceSqlServerTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ConnectToSourcePostgreSqlSyncTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ConnectToTargetAzureDbForMySqlTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ConnectToTargetSqlDbTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ConnectToTargetSqlMiSyncTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ConnectToTargetSqlMITask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ConnectToTargetSqlSqlDbSyncTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/GetUserTablesMySqlTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/Files.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/GetTdeCertificatesSqlTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/GetUserTablesSqlSyncTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/GetUserTablesSqlTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/MigrateSchemaSqlServerSqlDbTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/MigrateSqlServerSqlDbSyncTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/MigrateSqlServerSqlDbTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/MigrateSqlServerSqlMiSyncTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/MigrateSqlServerSqlMITask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/MigrateSsisTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/MigrationValidation.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/MongoDbTasks.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/OracleAzureDbPostgreSqlSyncTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/Projects.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ResourceSkus.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ServiceFeatureOCITask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/Services.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ServiceTasks.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/Tasks.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/TasksCommon.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
  - Microsoft.DataMigration/preview/2022-03-30-preview/definitions/ValidateSyncMigrationInputSqlServerTask.json
directive:
  - suppress: R4009
  - suppress: R4013
  - suppress: R4037
  - suppress: R4017
    from: Microsoft.DataMigration/preview/2022-03-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4017
    from: Microsoft.DataMigration/preview/2022-03-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4017
    from: Microsoft.DataMigration/preview/2022-03-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlDb
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Database.
  - suppress: R4016
    from: Microsoft.DataMigration/preview/2022-03-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4016
    from: Microsoft.DataMigration/preview/2022-03-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4016
    from: Microsoft.DataMigration/preview/2022-03-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlDb
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Database.
```

### Tag: package-preview-2022-01

These settings apply only when `--tag=package-preview-2022-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2022-01'
input-file:
  - Microsoft.DataMigration/preview/2022-01-30-preview/sqlmigration.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/datamigration.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/Commands.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/Common.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ConnectToSourceMySqlTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ConnectToSourceSqlServerTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ConnectToSourcePostgreSqlSyncTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ConnectToTargetAzureDbForMySqlTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ConnectToTargetSqlDbTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ConnectToTargetSqlMiSyncTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ConnectToTargetSqlMITask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ConnectToTargetSqlSqlDbSyncTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/GetUserTablesMySqlTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/Files.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/GetTdeCertificatesSqlTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/GetUserTablesSqlSyncTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/GetUserTablesSqlTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/MigrateSchemaSqlServerSqlDbTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/MigrateSqlServerSqlDbSyncTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/MigrateSqlServerSqlDbTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/MigrateSqlServerSqlMiSyncTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/MigrateSqlServerSqlMITask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/MigrateSsisTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/MigrationValidation.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/MongoDbTasks.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/OracleAzureDbPostgreSqlSyncTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/Projects.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ResourceSkus.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ServiceFeatureOCITask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/Services.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ServiceTasks.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/Tasks.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/TasksCommon.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
  - Microsoft.DataMigration/preview/2022-01-30-preview/definitions/ValidateSyncMigrationInputSqlServerTask.json
directive:
  - suppress: R4009
  - suppress: R4013
  - suppress: R4037
  - suppress: R4017
    from: Microsoft.DataMigration/preview/2022-01-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4017
    from: Microsoft.DataMigration/preview/2022-01-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4016
    from: Microsoft.DataMigration/preview/2022-01-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4016
    from: Microsoft.DataMigration/preview/2022-01-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
```
### Tag: package-preview-2021-10

These settings apply only when `--tag=package-preview-2021-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-10'
input-file:
  - Microsoft.DataMigration/preview/2021-10-30-preview/sqlmigration.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/datamigration.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/Commands.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/Common.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ConnectToSourceMySqlTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ConnectToSourceSqlServerTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ConnectToSourcePostgreSqlSyncTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ConnectToTargetAzureDbForMySqlTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ConnectToTargetSqlDbTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ConnectToTargetSqlMiSyncTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ConnectToTargetSqlMITask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ConnectToTargetSqlSqlDbSyncTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/GetUserTablesMySqlTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/Files.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/GetTdeCertificatesSqlTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/GetUserTablesSqlSyncTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/GetUserTablesSqlTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/MigrateSchemaSqlServerSqlDbTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/MigrateSqlServerSqlDbSyncTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/MigrateSqlServerSqlDbTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/MigrateSqlServerSqlMiSyncTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/MigrateSqlServerSqlMITask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/MigrateSsisTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/MigrationValidation.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/MongoDbTasks.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/OracleAzureDbPostgreSqlSyncTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/Projects.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ResourceSkus.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ServiceFeatureOCITask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/Services.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ServiceTasks.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/Tasks.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/TasksCommon.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
  - Microsoft.DataMigration/preview/2021-10-30-preview/definitions/ValidateSyncMigrationInputSqlServerTask.json
directive:
  - suppress: R4009
  - suppress: R4013
  - suppress: R4037
  - suppress: R4017
    from: Microsoft.DataMigration/preview/2021-10-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4017
    from: Microsoft.DataMigration/preview/2021-10-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4016
    from: Microsoft.DataMigration/preview/2021-10-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4016
    from: Microsoft.DataMigration/preview/2021-10-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
```
### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-2021-06'
input-file:
- Microsoft.DataMigration/stable/2021-06-30/datamigration.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/Commands.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/Common.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/ConnectToSourceMySqlTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/ConnectToSourceSqlServerTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/ConnectToSourcePostgreSqlSyncTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/ConnectToTargetAzureDbForMySqlTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/ConnectToTargetSqlDbTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/ConnectToTargetSqlMiSyncTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/ConnectToTargetSqlMITask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/ConnectToTargetSqlSqlDbSyncTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/GetUserTablesSqlSyncTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/GetUserTablesSqlTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/MigrateSchemaSqlServerSqlDbTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/MigrateSqlServerSqlDbSyncTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/MigrateSqlServerSqlDbTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/MigrateSqlServerSqlMiSyncTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/MigrateSqlServerSqlMITask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/MigrateSsisTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/MigrationValidation.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/MongoDbTasks.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/GetTdeCertificatesSqlTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/OracleAzureDbPostgreSqlSyncTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/Projects.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/ServiceFeatureOCITask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/Services.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/ServiceTasks.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/Tasks.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/TasksCommon.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/ValidateMigrationInputSqlServerSqlMITask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/ValidateSyncMigrationInputSqlServerTask.json
- Microsoft.DataMigration/stable/2021-06-30/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
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
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-java
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
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

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Suppression

``` yaml
directive:
  - suppress: SECRET_PROPERTY
    from:
      - Microsoft.DataMigration/preview/2021-10-30-preview/sqlmigration.json
      - Microsoft.DataMigration/preview/2022-01-30-preview/sqlmigration.json
      - Microsoft.DataMigration/preview/2022-03-30-preview/sqlmigration.json
    where:
      - $.definitions.RegenAuthKeys.properties.authKey1
      - $.definitions.RegenAuthKeys.properties.authKey2
      - $.definitions.AuthenticationKeys.properties.authKey1
      - $.definitions.AuthenticationKeys.properties.authKey2
    reason: Secrets are OK to return in a POST response.
```
