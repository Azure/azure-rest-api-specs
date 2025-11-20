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
tag: package-preview-2025-09
```
### Tag: package-preview-2025-09

These settings apply only when `--tag=package-preview-2025-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-09'
input-file:
  - ./preview/2025-09-01-preview/sqlmigration.json
  - ./preview/2025-09-01-preview/datamigration.json
  - ./preview/2025-09-01-preview/definitions/Commands.json
  - ./preview/2025-09-01-preview/definitions/Common.json
  - ./preview/2025-09-01-preview/definitions/ConnectToSourceMySqlTask.json
  - ./preview/2025-09-01-preview/definitions/ConnectToSourceSqlServerTask.json
  - ./preview/2025-09-01-preview/definitions/ConnectToSourcePostgreSqlSyncTask.json
  - ./preview/2025-09-01-preview/definitions/ConnectToTargetAzureDbForMySqlTask.json
  - ./preview/2025-09-01-preview/definitions/ConnectToTargetSqlDbTask.json
  - ./preview/2025-09-01-preview/definitions/ConnectToTargetSqlMiSyncTask.json
  - ./preview/2025-09-01-preview/definitions/ConnectToTargetSqlMITask.json
  - ./preview/2025-09-01-preview/definitions/ConnectToTargetSqlSqlDbSyncTask.json
  - ./preview/2025-09-01-preview/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
  - ./preview/2025-09-01-preview/definitions/GetUserTablesMySqlTask.json
  - ./preview/2025-09-01-preview/definitions/Files.json
  - ./preview/2025-09-01-preview/definitions/GetTdeCertificatesSqlTask.json
  - ./preview/2025-09-01-preview/definitions/GetUserTablesSqlSyncTask.json
  - ./preview/2025-09-01-preview/definitions/GetUserTablesSqlTask.json
  - ./preview/2025-09-01-preview/definitions/MigrateSchemaSqlServerSqlDbTask.json
  - ./preview/2025-09-01-preview/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
  - ./preview/2025-09-01-preview/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
  - ./preview/2025-09-01-preview/definitions/MigrateSqlServerSqlDbSyncTask.json
  - ./preview/2025-09-01-preview/definitions/MigrateSqlServerSqlDbTask.json
  - ./preview/2025-09-01-preview/definitions/MigrateSqlServerSqlMiSyncTask.json
  - ./preview/2025-09-01-preview/definitions/MigrateSqlServerSqlMITask.json
  - ./preview/2025-09-01-preview/definitions/MigrateSsisTask.json
  - ./preview/2025-09-01-preview/definitions/MigrationValidation.json
  - ./preview/2025-09-01-preview/definitions/MongoDbTasks.json
  - ./preview/2025-09-01-preview/definitions/OracleAzureDbPostgreSqlSyncTask.json
  - ./preview/2025-09-01-preview/definitions/Projects.json
  - ./preview/2025-09-01-preview/definitions/ResourceSkus.json
  - ./preview/2025-09-01-preview/definitions/ServiceFeatureOCITask.json
  - ./preview/2025-09-01-preview/definitions/Services.json
  - ./preview/2025-09-01-preview/definitions/ServiceTasks.json
  - ./preview/2025-09-01-preview/definitions/Tasks.json
  - ./preview/2025-09-01-preview/definitions/TasksCommon.json
  - ./preview/2025-09-01-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
  - ./preview/2025-09-01-preview/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
  - ./preview/2025-09-01-preview/definitions/ValidateSyncMigrationInputSqlServerTask.json
modelerfour:
  lenient-model-deduplication: true # !!temporary!! to solve the duplicate schema issue of ProxyResource, TrackedResource and Resource in common-types v2 and v3 introduced in this PR
directive:
  - suppress: R4009
  - suppress: R4013
  - suppress: R4037
  - suppress: R4017
    from: ./preview/2025-09-01-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4017
    from: ./preview/2025-09-01-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4017
    from: ./preview/2025-09-01-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlDb
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Database.
  - suppress: R4016
    from: ./preview/2025-09-01-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4016
    from: ./preview/2025-09-01-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4016
    from: ./preview/2025-09-01-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlDb
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Database.
  - suppress: PostResponseCodes
    code: PostResponseCodes
    from: sqlmigration.json
    reason: Service requires returning a schema for POST long-running operations for client SDK generation.
  - suppress: LroLocationHeader
    code: LroLocationHeader
    from: sqlmigration.json
    reason: Location header not applicable for these long-running operations due to service design.
  - suppress: DefaultErrorResponseSchema
    code: DefaultErrorResponseSchema
    from: sqlmigration.json
    reason: Service uses a custom error schema for backward compatibility with existing clients.
  - suppress: DeleteResponseCodes
    code: DeleteResponseCodes
    from: sqlmigration.json
    reason: Service-specific delete response codes are required for compatibility with legacy workflows.
  - suppress: DeleteResponseBodyEmpty
    code: DeleteResponseBodyEmpty
    from: sqlmigration.json
    reason: Minimal payload is returned for delete confirmation per current backend behavior.
```

### Tag: package-2025-06

These settings apply only when `--tag=package-2025-06` is specified on the command line.

```yaml $(tag) == 'package-2025-06'
input-file:
  - ./stable/2025-06-30/sqlmigration.json
  - ./stable/2025-06-30/datamigration.json
  - ./stable/2025-06-30/definitions/Commands.json
  - ./stable/2025-06-30/definitions/Common.json
  - ./stable/2025-06-30/definitions/ConnectToSourceMySqlTask.json
  - ./stable/2025-06-30/definitions/ConnectToSourceSqlServerTask.json
  - ./stable/2025-06-30/definitions/ConnectToSourcePostgreSqlSyncTask.json
  - ./stable/2025-06-30/definitions/ConnectToTargetAzureDbForMySqlTask.json
  - ./stable/2025-06-30/definitions/ConnectToTargetSqlDbTask.json
  - ./stable/2025-06-30/definitions/ConnectToTargetSqlMiSyncTask.json
  - ./stable/2025-06-30/definitions/ConnectToTargetSqlMITask.json
  - ./stable/2025-06-30/definitions/ConnectToTargetSqlSqlDbSyncTask.json
  - ./stable/2025-06-30/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
  - ./stable/2025-06-30/definitions/GetUserTablesMySqlTask.json
  - ./stable/2025-06-30/definitions/Files.json
  - ./stable/2025-06-30/definitions/GetTdeCertificatesSqlTask.json
  - ./stable/2025-06-30/definitions/GetUserTablesSqlSyncTask.json
  - ./stable/2025-06-30/definitions/GetUserTablesSqlTask.json
  - ./stable/2025-06-30/definitions/MigrateSchemaSqlServerSqlDbTask.json
  - ./stable/2025-06-30/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
  - ./stable/2025-06-30/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
  - ./stable/2025-06-30/definitions/MigrateSqlServerSqlDbSyncTask.json
  - ./stable/2025-06-30/definitions/MigrateSqlServerSqlDbTask.json
  - ./stable/2025-06-30/definitions/MigrateSqlServerSqlMiSyncTask.json
  - ./stable/2025-06-30/definitions/MigrateSqlServerSqlMITask.json
  - ./stable/2025-06-30/definitions/MigrateSsisTask.json
  - ./stable/2025-06-30/definitions/MigrationValidation.json
  - ./stable/2025-06-30/definitions/MongoDbTasks.json
  - ./stable/2025-06-30/definitions/OracleAzureDbPostgreSqlSyncTask.json
  - ./stable/2025-06-30/definitions/Projects.json
  - ./stable/2025-06-30/definitions/ResourceSkus.json
  - ./stable/2025-06-30/definitions/ServiceFeatureOCITask.json
  - ./stable/2025-06-30/definitions/Services.json
  - ./stable/2025-06-30/definitions/ServiceTasks.json
  - ./stable/2025-06-30/definitions/Tasks.json
  - ./stable/2025-06-30/definitions/TasksCommon.json
  - ./stable/2025-06-30/definitions/ValidateMigrationInputSqlServerSqlMITask.json
  - ./stable/2025-06-30/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
  - ./stable/2025-06-30/definitions/ValidateSyncMigrationInputSqlServerTask.json
modelerfour:
  lenient-model-deduplication: true # !!temporary!! to solve the duplicate schema issue of ProxyResource, TrackedResource and Resource in common-types v2 and v3 introduced in this PR
directive:
  - suppress: R4009
  - suppress: R4013
  - suppress: R4037
  - suppress: R4017
    from: ./stable/2025-06-30/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4017
    from: ./stable/2025-06-30/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4017
    from: ./stable/2025-06-30/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlDb
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Database.
  - suppress: R4016
    from: ./stable/2025-06-30/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4016
    from: ./stable/2025-06-30/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4016
    from: ./stable/2025-06-30/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlDb
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Database.
  - suppress: PostResponseCodes
    code: PostResponseCodes
    from: sqlmigration.json
    reason: Service requires returning a schema for POST long-running operations for client SDK generation.
  - suppress: LroLocationHeader
    code: LroLocationHeader
    from: sqlmigration.json
    reason: Location header not applicable for these long-running operations due to service design.
  - suppress: DefaultErrorResponseSchema
    code: DefaultErrorResponseSchema
    from: sqlmigration.json
    reason: Service uses a custom error schema for backward compatibility with existing clients.
  - suppress: DeleteResponseCodes
    code: DeleteResponseCodes
    from: sqlmigration.json
    reason: Service-specific delete response codes are required for compatibility with legacy workflows.
  - suppress: DeleteResponseBodyEmpty
    code: DeleteResponseBodyEmpty
    from: sqlmigration.json
    reason: Minimal payload is returned for delete confirmation per current backend behavior.
```

### Tag: package-preview-2025-03

These settings apply only when `--tag=package-preview-2025-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-03'
input-file:
  - ./preview/2025-03-15-preview/sqlmigration.json
  - ./preview/2025-03-15-preview/datamigration.json
  - ./preview/2025-03-15-preview/definitions/Commands.json
  - ./preview/2025-03-15-preview/definitions/Common.json
  - ./preview/2025-03-15-preview/definitions/ConnectToSourceMySqlTask.json
  - ./preview/2025-03-15-preview/definitions/ConnectToSourceSqlServerTask.json
  - ./preview/2025-03-15-preview/definitions/ConnectToSourcePostgreSqlSyncTask.json
  - ./preview/2025-03-15-preview/definitions/ConnectToTargetAzureDbForMySqlTask.json
  - ./preview/2025-03-15-preview/definitions/ConnectToTargetSqlDbTask.json
  - ./preview/2025-03-15-preview/definitions/ConnectToTargetSqlMiSyncTask.json
  - ./preview/2025-03-15-preview/definitions/ConnectToTargetSqlMITask.json
  - ./preview/2025-03-15-preview/definitions/ConnectToTargetSqlSqlDbSyncTask.json
  - ./preview/2025-03-15-preview/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
  - ./preview/2025-03-15-preview/definitions/GetUserTablesMySqlTask.json
  - ./preview/2025-03-15-preview/definitions/Files.json
  - ./preview/2025-03-15-preview/definitions/GetTdeCertificatesSqlTask.json
  - ./preview/2025-03-15-preview/definitions/GetUserTablesSqlSyncTask.json
  - ./preview/2025-03-15-preview/definitions/GetUserTablesSqlTask.json
  - ./preview/2025-03-15-preview/definitions/MigrateSchemaSqlServerSqlDbTask.json
  - ./preview/2025-03-15-preview/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
  - ./preview/2025-03-15-preview/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
  - ./preview/2025-03-15-preview/definitions/MigrateSqlServerSqlDbSyncTask.json
  - ./preview/2025-03-15-preview/definitions/MigrateSqlServerSqlDbTask.json
  - ./preview/2025-03-15-preview/definitions/MigrateSqlServerSqlMiSyncTask.json
  - ./preview/2025-03-15-preview/definitions/MigrateSqlServerSqlMITask.json
  - ./preview/2025-03-15-preview/definitions/MigrateSsisTask.json
  - ./preview/2025-03-15-preview/definitions/MigrationValidation.json
  - ./preview/2025-03-15-preview/definitions/MongoDbTasks.json
  - ./preview/2025-03-15-preview/definitions/OracleAzureDbPostgreSqlSyncTask.json
  - ./preview/2025-03-15-preview/definitions/Projects.json
  - ./preview/2025-03-15-preview/definitions/ResourceSkus.json
  - ./preview/2025-03-15-preview/definitions/ServiceFeatureOCITask.json
  - ./preview/2025-03-15-preview/definitions/Services.json
  - ./preview/2025-03-15-preview/definitions/ServiceTasks.json
  - ./preview/2025-03-15-preview/definitions/Tasks.json
  - ./preview/2025-03-15-preview/definitions/TasksCommon.json
  - ./preview/2025-03-15-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
  - ./preview/2025-03-15-preview/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
  - ./preview/2025-03-15-preview/definitions/ValidateSyncMigrationInputSqlServerTask.json
modelerfour:
  lenient-model-deduplication: true # !!temporary!! to solve the duplicate schema issue of ProxyResource, TrackedResource and Resource in common-types v2 and v3 introduced in this PR
directive:
  - suppress: R4009
  - suppress: R4013
  - suppress: R4037
  - suppress: R4017
    from: ./preview/2025-03-15-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4017
    from: ./preview/2025-03-15-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4017
    from: ./preview/2025-03-15-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlDb
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Database.
  - suppress: R4016
    from: ./preview/2025-03-15-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4016
    from: ./preview/2025-03-15-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4016
    from: ./preview/2025-03-15-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlDb
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Database.
```

### Tag: package-preview-2023-07

These settings apply only when `--tag=package-preview-2023-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-07'
input-file:
  - ./preview/2023-07-15-preview/sqlmigration.json
  - ./preview/2023-07-15-preview/datamigration.json
  - ./preview/2023-07-15-preview/definitions/Commands.json
  - ./preview/2023-07-15-preview/definitions/Common.json
  - ./preview/2023-07-15-preview/definitions/ConnectToSourceMySqlTask.json
  - ./preview/2023-07-15-preview/definitions/ConnectToSourceSqlServerTask.json
  - ./preview/2023-07-15-preview/definitions/ConnectToSourcePostgreSqlSyncTask.json
  - ./preview/2023-07-15-preview/definitions/ConnectToTargetAzureDbForMySqlTask.json
  - ./preview/2023-07-15-preview/definitions/ConnectToTargetSqlDbTask.json
  - ./preview/2023-07-15-preview/definitions/ConnectToTargetSqlMiSyncTask.json
  - ./preview/2023-07-15-preview/definitions/ConnectToTargetSqlMITask.json
  - ./preview/2023-07-15-preview/definitions/ConnectToTargetSqlSqlDbSyncTask.json
  - ./preview/2023-07-15-preview/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
  - ./preview/2023-07-15-preview/definitions/GetUserTablesMySqlTask.json
  - ./preview/2023-07-15-preview/definitions/Files.json
  - ./preview/2023-07-15-preview/definitions/GetTdeCertificatesSqlTask.json
  - ./preview/2023-07-15-preview/definitions/GetUserTablesSqlSyncTask.json
  - ./preview/2023-07-15-preview/definitions/GetUserTablesSqlTask.json
  - ./preview/2023-07-15-preview/definitions/MigrateSchemaSqlServerSqlDbTask.json
  - ./preview/2023-07-15-preview/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
  - ./preview/2023-07-15-preview/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
  - ./preview/2023-07-15-preview/definitions/MigrateSqlServerSqlDbSyncTask.json
  - ./preview/2023-07-15-preview/definitions/MigrateSqlServerSqlDbTask.json
  - ./preview/2023-07-15-preview/definitions/MigrateSqlServerSqlMiSyncTask.json
  - ./preview/2023-07-15-preview/definitions/MigrateSqlServerSqlMITask.json
  - ./preview/2023-07-15-preview/definitions/MigrateSsisTask.json
  - ./preview/2023-07-15-preview/definitions/MigrationValidation.json
  - ./preview/2023-07-15-preview/definitions/MongoDbTasks.json
  - ./preview/2023-07-15-preview/definitions/OracleAzureDbPostgreSqlSyncTask.json
  - ./preview/2023-07-15-preview/definitions/Projects.json
  - ./preview/2023-07-15-preview/definitions/ResourceSkus.json
  - ./preview/2023-07-15-preview/definitions/ServiceFeatureOCITask.json
  - ./preview/2023-07-15-preview/definitions/Services.json
  - ./preview/2023-07-15-preview/definitions/ServiceTasks.json
  - ./preview/2023-07-15-preview/definitions/Tasks.json
  - ./preview/2023-07-15-preview/definitions/TasksCommon.json
  - ./preview/2023-07-15-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
  - ./preview/2023-07-15-preview/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
  - ./preview/2023-07-15-preview/definitions/ValidateSyncMigrationInputSqlServerTask.json
modelerfour:
  lenient-model-deduplication: true # !!temporary!! to solve the duplicate schema issue of ProxyResource, TrackedResource and Resource in common-types v2 and v3 introduced in this PR
directive:
  - suppress: R4009
  - suppress: R4013
  - suppress: R4037
  - suppress: R4017
    from: ./preview/2023-07-15-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4017
    from: ./preview/2023-07-15-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4017
    from: ./preview/2023-07-15-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlDb
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Database.
  - suppress: R4016
    from: ./preview/2023-07-15-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4016
    from: ./preview/2023-07-15-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4016
    from: ./preview/2023-07-15-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlDb
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Database.
```

### Tag: package-preview-2022-03

These settings apply only when `--tag=package-preview-2022-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2022-03'
input-file:
  - ./preview/2022-03-30-preview/sqlmigration.json
  - ./preview/2022-03-30-preview/datamigration.json
  - ./preview/2022-03-30-preview/definitions/Commands.json
  - ./preview/2022-03-30-preview/definitions/Common.json
  - ./preview/2022-03-30-preview/definitions/ConnectToSourceMySqlTask.json
  - ./preview/2022-03-30-preview/definitions/ConnectToSourceSqlServerTask.json
  - ./preview/2022-03-30-preview/definitions/ConnectToSourcePostgreSqlSyncTask.json
  - ./preview/2022-03-30-preview/definitions/ConnectToTargetAzureDbForMySqlTask.json
  - ./preview/2022-03-30-preview/definitions/ConnectToTargetSqlDbTask.json
  - ./preview/2022-03-30-preview/definitions/ConnectToTargetSqlMiSyncTask.json
  - ./preview/2022-03-30-preview/definitions/ConnectToTargetSqlMITask.json
  - ./preview/2022-03-30-preview/definitions/ConnectToTargetSqlSqlDbSyncTask.json
  - ./preview/2022-03-30-preview/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
  - ./preview/2022-03-30-preview/definitions/GetUserTablesMySqlTask.json
  - ./preview/2022-03-30-preview/definitions/Files.json
  - ./preview/2022-03-30-preview/definitions/GetTdeCertificatesSqlTask.json
  - ./preview/2022-03-30-preview/definitions/GetUserTablesSqlSyncTask.json
  - ./preview/2022-03-30-preview/definitions/GetUserTablesSqlTask.json
  - ./preview/2022-03-30-preview/definitions/MigrateSchemaSqlServerSqlDbTask.json
  - ./preview/2022-03-30-preview/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
  - ./preview/2022-03-30-preview/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
  - ./preview/2022-03-30-preview/definitions/MigrateSqlServerSqlDbSyncTask.json
  - ./preview/2022-03-30-preview/definitions/MigrateSqlServerSqlDbTask.json
  - ./preview/2022-03-30-preview/definitions/MigrateSqlServerSqlMiSyncTask.json
  - ./preview/2022-03-30-preview/definitions/MigrateSqlServerSqlMITask.json
  - ./preview/2022-03-30-preview/definitions/MigrateSsisTask.json
  - ./preview/2022-03-30-preview/definitions/MigrationValidation.json
  - ./preview/2022-03-30-preview/definitions/MongoDbTasks.json
  - ./preview/2022-03-30-preview/definitions/OracleAzureDbPostgreSqlSyncTask.json
  - ./preview/2022-03-30-preview/definitions/Projects.json
  - ./preview/2022-03-30-preview/definitions/ResourceSkus.json
  - ./preview/2022-03-30-preview/definitions/ServiceFeatureOCITask.json
  - ./preview/2022-03-30-preview/definitions/Services.json
  - ./preview/2022-03-30-preview/definitions/ServiceTasks.json
  - ./preview/2022-03-30-preview/definitions/Tasks.json
  - ./preview/2022-03-30-preview/definitions/TasksCommon.json
  - ./preview/2022-03-30-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
  - ./preview/2022-03-30-preview/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
  - ./preview/2022-03-30-preview/definitions/ValidateSyncMigrationInputSqlServerTask.json
directive:
  - suppress: R4009
  - suppress: R4013
  - suppress: R4037
  - suppress: R4017
    from: ./preview/2022-03-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4017
    from: ./preview/2022-03-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4017
    from: ./preview/2022-03-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlDb
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Database.
  - suppress: R4016
    from: ./preview/2022-03-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4016
    from: ./preview/2022-03-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4016
    from: ./preview/2022-03-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlDb
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Database.
```

### Tag: package-preview-2022-01

These settings apply only when `--tag=package-preview-2022-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2022-01'
input-file:
  - ./preview/2022-01-30-preview/sqlmigration.json
  - ./preview/2022-01-30-preview/datamigration.json
  - ./preview/2022-01-30-preview/definitions/Commands.json
  - ./preview/2022-01-30-preview/definitions/Common.json
  - ./preview/2022-01-30-preview/definitions/ConnectToSourceMySqlTask.json
  - ./preview/2022-01-30-preview/definitions/ConnectToSourceSqlServerTask.json
  - ./preview/2022-01-30-preview/definitions/ConnectToSourcePostgreSqlSyncTask.json
  - ./preview/2022-01-30-preview/definitions/ConnectToTargetAzureDbForMySqlTask.json
  - ./preview/2022-01-30-preview/definitions/ConnectToTargetSqlDbTask.json
  - ./preview/2022-01-30-preview/definitions/ConnectToTargetSqlMiSyncTask.json
  - ./preview/2022-01-30-preview/definitions/ConnectToTargetSqlMITask.json
  - ./preview/2022-01-30-preview/definitions/ConnectToTargetSqlSqlDbSyncTask.json
  - ./preview/2022-01-30-preview/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
  - ./preview/2022-01-30-preview/definitions/GetUserTablesMySqlTask.json
  - ./preview/2022-01-30-preview/definitions/Files.json
  - ./preview/2022-01-30-preview/definitions/GetTdeCertificatesSqlTask.json
  - ./preview/2022-01-30-preview/definitions/GetUserTablesSqlSyncTask.json
  - ./preview/2022-01-30-preview/definitions/GetUserTablesSqlTask.json
  - ./preview/2022-01-30-preview/definitions/MigrateSchemaSqlServerSqlDbTask.json
  - ./preview/2022-01-30-preview/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
  - ./preview/2022-01-30-preview/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
  - ./preview/2022-01-30-preview/definitions/MigrateSqlServerSqlDbSyncTask.json
  - ./preview/2022-01-30-preview/definitions/MigrateSqlServerSqlDbTask.json
  - ./preview/2022-01-30-preview/definitions/MigrateSqlServerSqlMiSyncTask.json
  - ./preview/2022-01-30-preview/definitions/MigrateSqlServerSqlMITask.json
  - ./preview/2022-01-30-preview/definitions/MigrateSsisTask.json
  - ./preview/2022-01-30-preview/definitions/MigrationValidation.json
  - ./preview/2022-01-30-preview/definitions/MongoDbTasks.json
  - ./preview/2022-01-30-preview/definitions/OracleAzureDbPostgreSqlSyncTask.json
  - ./preview/2022-01-30-preview/definitions/Projects.json
  - ./preview/2022-01-30-preview/definitions/ResourceSkus.json
  - ./preview/2022-01-30-preview/definitions/ServiceFeatureOCITask.json
  - ./preview/2022-01-30-preview/definitions/Services.json
  - ./preview/2022-01-30-preview/definitions/ServiceTasks.json
  - ./preview/2022-01-30-preview/definitions/Tasks.json
  - ./preview/2022-01-30-preview/definitions/TasksCommon.json
  - ./preview/2022-01-30-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
  - ./preview/2022-01-30-preview/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
  - ./preview/2022-01-30-preview/definitions/ValidateSyncMigrationInputSqlServerTask.json
directive:
  - suppress: R4009
  - suppress: R4013
  - suppress: R4037
  - suppress: R4017
    from: ./preview/2022-01-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4017
    from: ./preview/2022-01-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4016
    from: ./preview/2022-01-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4016
    from: ./preview/2022-01-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
```
### Tag: package-preview-2021-10

These settings apply only when `--tag=package-preview-2021-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-10'
input-file:
  - ./preview/2021-10-30-preview/sqlmigration.json
  - ./preview/2021-10-30-preview/datamigration.json
  - ./preview/2021-10-30-preview/definitions/Commands.json
  - ./preview/2021-10-30-preview/definitions/Common.json
  - ./preview/2021-10-30-preview/definitions/ConnectToSourceMySqlTask.json
  - ./preview/2021-10-30-preview/definitions/ConnectToSourceSqlServerTask.json
  - ./preview/2021-10-30-preview/definitions/ConnectToSourcePostgreSqlSyncTask.json
  - ./preview/2021-10-30-preview/definitions/ConnectToTargetAzureDbForMySqlTask.json
  - ./preview/2021-10-30-preview/definitions/ConnectToTargetSqlDbTask.json
  - ./preview/2021-10-30-preview/definitions/ConnectToTargetSqlMiSyncTask.json
  - ./preview/2021-10-30-preview/definitions/ConnectToTargetSqlMITask.json
  - ./preview/2021-10-30-preview/definitions/ConnectToTargetSqlSqlDbSyncTask.json
  - ./preview/2021-10-30-preview/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
  - ./preview/2021-10-30-preview/definitions/GetUserTablesMySqlTask.json
  - ./preview/2021-10-30-preview/definitions/Files.json
  - ./preview/2021-10-30-preview/definitions/GetTdeCertificatesSqlTask.json
  - ./preview/2021-10-30-preview/definitions/GetUserTablesSqlSyncTask.json
  - ./preview/2021-10-30-preview/definitions/GetUserTablesSqlTask.json
  - ./preview/2021-10-30-preview/definitions/MigrateSchemaSqlServerSqlDbTask.json
  - ./preview/2021-10-30-preview/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
  - ./preview/2021-10-30-preview/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
  - ./preview/2021-10-30-preview/definitions/MigrateSqlServerSqlDbSyncTask.json
  - ./preview/2021-10-30-preview/definitions/MigrateSqlServerSqlDbTask.json
  - ./preview/2021-10-30-preview/definitions/MigrateSqlServerSqlMiSyncTask.json
  - ./preview/2021-10-30-preview/definitions/MigrateSqlServerSqlMITask.json
  - ./preview/2021-10-30-preview/definitions/MigrateSsisTask.json
  - ./preview/2021-10-30-preview/definitions/MigrationValidation.json
  - ./preview/2021-10-30-preview/definitions/MongoDbTasks.json
  - ./preview/2021-10-30-preview/definitions/OracleAzureDbPostgreSqlSyncTask.json
  - ./preview/2021-10-30-preview/definitions/Projects.json
  - ./preview/2021-10-30-preview/definitions/ResourceSkus.json
  - ./preview/2021-10-30-preview/definitions/ServiceFeatureOCITask.json
  - ./preview/2021-10-30-preview/definitions/Services.json
  - ./preview/2021-10-30-preview/definitions/ServiceTasks.json
  - ./preview/2021-10-30-preview/definitions/Tasks.json
  - ./preview/2021-10-30-preview/definitions/TasksCommon.json
  - ./preview/2021-10-30-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
  - ./preview/2021-10-30-preview/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
  - ./preview/2021-10-30-preview/definitions/ValidateSyncMigrationInputSqlServerTask.json
directive:
  - suppress: R4009
  - suppress: R4013
  - suppress: R4037
  - suppress: R4017
    from: ./preview/2021-10-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4017
    from: ./preview/2021-10-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by subscription. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
  - suppress: R4016
    from: ./preview/2021-10-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlMi
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Managed Instance.
  - suppress: R4016
    from: ./preview/2021-10-30-preview/sqlmigration.json
    where: $.definitions.DatabaseMigrationSqlVm
    reason: DatabaseMigration does not support list by resource group. DatabaseMigration is an extension resource type. To get the DatabaseMigration, we should have a subscription as well as a resource group and a migration target SQL Virtual Machine.
```
### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-2021-06'
input-file:
- ./stable/2021-06-30/datamigration.json
- ./stable/2021-06-30/definitions/Commands.json
- ./stable/2021-06-30/definitions/Common.json
- ./stable/2021-06-30/definitions/ConnectToSourceMySqlTask.json
- ./stable/2021-06-30/definitions/ConnectToSourceSqlServerTask.json
- ./stable/2021-06-30/definitions/ConnectToSourcePostgreSqlSyncTask.json
- ./stable/2021-06-30/definitions/ConnectToTargetAzureDbForMySqlTask.json
- ./stable/2021-06-30/definitions/ConnectToTargetSqlDbTask.json
- ./stable/2021-06-30/definitions/ConnectToTargetSqlMiSyncTask.json
- ./stable/2021-06-30/definitions/ConnectToTargetSqlMITask.json
- ./stable/2021-06-30/definitions/ConnectToTargetSqlSqlDbSyncTask.json
- ./stable/2021-06-30/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
- ./stable/2021-06-30/definitions/GetUserTablesSqlSyncTask.json
- ./stable/2021-06-30/definitions/GetUserTablesSqlTask.json
- ./stable/2021-06-30/definitions/MigrateSchemaSqlServerSqlDbTask.json
- ./stable/2021-06-30/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
- ./stable/2021-06-30/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
- ./stable/2021-06-30/definitions/MigrateSqlServerSqlDbSyncTask.json
- ./stable/2021-06-30/definitions/MigrateSqlServerSqlDbTask.json
- ./stable/2021-06-30/definitions/MigrateSqlServerSqlMiSyncTask.json
- ./stable/2021-06-30/definitions/MigrateSqlServerSqlMITask.json
- ./stable/2021-06-30/definitions/MigrateSsisTask.json
- ./stable/2021-06-30/definitions/MigrationValidation.json
- ./stable/2021-06-30/definitions/MongoDbTasks.json
- ./stable/2021-06-30/definitions/GetTdeCertificatesSqlTask.json
- ./stable/2021-06-30/definitions/OracleAzureDbPostgreSqlSyncTask.json
- ./stable/2021-06-30/definitions/Projects.json
- ./stable/2021-06-30/definitions/ServiceFeatureOCITask.json
- ./stable/2021-06-30/definitions/Services.json
- ./stable/2021-06-30/definitions/ServiceTasks.json
- ./stable/2021-06-30/definitions/Tasks.json
- ./stable/2021-06-30/definitions/TasksCommon.json
- ./stable/2021-06-30/definitions/ValidateMigrationInputSqlServerSqlMITask.json
- ./stable/2021-06-30/definitions/ValidateSyncMigrationInputSqlServerTask.json
- ./stable/2021-06-30/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
```

### Tag: package-2018-04-19

These settings apply only when `--tag=package-2018-04-19` is specified on the command line.

``` yaml $(tag) == 'package-2018-04-19'
input-file:
- ./stable/2018-04-19/datamigration.json
- ./stable/2018-04-19/definitions/Commands.json
- ./stable/2018-04-19/definitions/Common.json
- ./stable/2018-04-19/definitions/ConnectToSourceMySqlTask.json
- ./stable/2018-04-19/definitions/ConnectToSourcePostgreSqlSyncTask.json
- ./stable/2018-04-19/definitions/ConnectToSourceSqlServerTask.json
- ./stable/2018-04-19/definitions/ConnectToTargetAzureDbForMySqlTask.json
- ./stable/2018-04-19/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
- ./stable/2018-04-19/definitions/ConnectToTargetSqlDbTask.json
- ./stable/2018-04-19/definitions/ConnectToTargetSqlMITask.json
- ./stable/2018-04-19/definitions/ConnectToTargetSqlMiSyncTask.json
- ./stable/2018-04-19/definitions/ConnectToTargetSqlSqlDbSyncTask.json
- ./stable/2018-04-19/definitions/GetTdeCertificatesSqlTask.json
- ./stable/2018-04-19/definitions/GetUserTablesSqlSyncTask.json
- ./stable/2018-04-19/definitions/GetUserTablesSqlTask.json
- ./stable/2018-04-19/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
- ./stable/2018-04-19/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
- ./stable/2018-04-19/definitions/MigrateSqlServerSqlDbSyncTask.json
- ./stable/2018-04-19/definitions/MigrateSqlServerSqlDbTask.json
- ./stable/2018-04-19/definitions/MigrateSqlServerSqlMITask.json
- ./stable/2018-04-19/definitions/MigrateSqlServerSqlMiSyncTask.json
- ./stable/2018-04-19/definitions/Projects.json
- ./stable/2018-04-19/definitions/Services.json
- ./stable/2018-04-19/definitions/Tasks.json
- ./stable/2018-04-19/definitions/TasksCommon.json
- ./stable/2018-04-19/definitions/MigrationValidation.json
- ./stable/2018-04-19/definitions/ValidateMigrationInputSqlServerSqlMITask.json
- ./stable/2018-04-19/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
- ./stable/2018-04-19/definitions/ValidateSyncMigrationInputSqlServerTask.json
```

### Tag: package-2018-07-15-preview

These settings apply only when `--tag=package-2018-07-15-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-07-15-preview'
input-file:
- ./preview/2018-07-15-preview/datamigration.json
- ./preview/2018-07-15-preview/definitions/Commands.json
- ./preview/2018-07-15-preview/definitions/Common.json
- ./preview/2018-07-15-preview/definitions/ConnectToSourceMySqlTask.json
- ./preview/2018-07-15-preview/definitions/ConnectToSourceSqlServerTask.json
- ./preview/2018-07-15-preview/definitions/ConnectToSourcePostgreSqlSyncTask.json
- ./preview/2018-07-15-preview/definitions/ConnectToTargetAzureDbForMySqlTask.json
- ./preview/2018-07-15-preview/definitions/ConnectToTargetSqlDbTask.json
- ./preview/2018-07-15-preview/definitions/ConnectToTargetSqlMiSyncTask.json
- ./preview/2018-07-15-preview/definitions/ConnectToTargetSqlMITask.json
- ./preview/2018-07-15-preview/definitions/ConnectToTargetSqlSqlDbSyncTask.json
- ./preview/2018-07-15-preview/definitions/ConnectToTargetAzureDbForPostgreSqlSyncTask.json
- ./preview/2018-07-15-preview/definitions/GetUserTablesSqlSyncTask.json
- ./preview/2018-07-15-preview/definitions/GetUserTablesSqlTask.json
- ./preview/2018-07-15-preview/definitions/MigrateSchemaSqlServerSqlDbTask.json
- ./preview/2018-07-15-preview/definitions/MigrateMySqlAzureDbForMySqlSyncTask.json
- ./preview/2018-07-15-preview/definitions/MigratePostgreSqlAzureDbForPostgreSqlSyncTask.json
- ./preview/2018-07-15-preview/definitions/MigrateSqlServerSqlDbSyncTask.json
- ./preview/2018-07-15-preview/definitions/MigrateSqlServerSqlDbTask.json
- ./preview/2018-07-15-preview/definitions/MigrateSqlServerSqlMiSyncTask.json
- ./preview/2018-07-15-preview/definitions/MigrateSqlServerSqlMITask.json
- ./preview/2018-07-15-preview/definitions/MigrateSsisTask.json
- ./preview/2018-07-15-preview/definitions/MigrationValidation.json
- ./preview/2018-07-15-preview/definitions/MongoDbTasks.json
- ./preview/2018-07-15-preview/definitions/GetTdeCertificatesSqlTask.json
- ./preview/2018-07-15-preview/definitions/OracleAzureDbPostgreSqlSyncTask.json
- ./preview/2018-07-15-preview/definitions/Projects.json
- ./preview/2018-07-15-preview/definitions/ServiceFeatureOCITask.json
- ./preview/2018-07-15-preview/definitions/Services.json
- ./preview/2018-07-15-preview/definitions/ServiceTasks.json
- ./preview/2018-07-15-preview/definitions/Tasks.json
- ./preview/2018-07-15-preview/definitions/TasksCommon.json
- ./preview/2018-07-15-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
- ./preview/2018-07-15-preview/definitions/ValidateSyncMigrationInputSqlServerTask.json
- ./preview/2018-07-15-preview/definitions/ValidateMigrationInputSqlServerSqlMiSyncTask.json
```

### Tag: package-2018-03-31-preview

These settings apply only when `--tag=package-2018-03-31-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-03-31-preview'
input-file:
- ./preview/2018-03-31-preview/datamigration.json
- ./preview/2018-03-31-preview/definitions/Common.json
- ./preview/2018-03-31-preview/definitions/ConnectToSourceSqlServerTask.json
- ./preview/2018-03-31-preview/definitions/ConnectToTargetSqlDbTask.json
- ./preview/2018-03-31-preview/definitions/ConnectToTargetSqlMITask.json
- ./preview/2018-03-31-preview/definitions/GetUserTablesSqlTask.json
- ./preview/2018-03-31-preview/definitions/MigrateSqlServerSqlDbTask.json
- ./preview/2018-03-31-preview/definitions/MigrateSqlServerSqlMITask.json
- ./preview/2018-03-31-preview/definitions/Projects.json
- ./preview/2018-03-31-preview/definitions/Services.json
- ./preview/2018-03-31-preview/definitions/Tasks.json
- ./preview/2018-03-31-preview/definitions/TasksCommon.json
- ./preview/2018-03-31-preview/definitions/MigrationValidation.json
- ./preview/2018-03-31-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
```

### Tag: package-2018-03-15-preview

These settings apply only when `--tag=package-2018-03-15-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-03-15-preview'
input-file:
- ./preview/2018-03-15-preview/datamigration.json
- ./preview/2018-03-15-preview/definitions/Common.json
- ./preview/2018-03-15-preview/definitions/ConnectToSourceSqlServerTask.json
- ./preview/2018-03-15-preview/definitions/ConnectToTargetSqlDbTask.json
- ./preview/2018-03-15-preview/definitions/ConnectToTargetSqlMITask.json
- ./preview/2018-03-15-preview/definitions/GetUserTablesSqlTask.json
- ./preview/2018-03-15-preview/definitions/MigrateSqlServerSqlDbTask.json
- ./preview/2018-03-15-preview/definitions/MigrateSqlServerSqlMITask.json
- ./preview/2018-03-15-preview/definitions/Projects.json
- ./preview/2018-03-15-preview/definitions/Services.json
- ./preview/2018-03-15-preview/definitions/Tasks.json
- ./preview/2018-03-15-preview/definitions/TasksCommon.json
- ./preview/2018-03-15-preview/definitions/MigrationValidation.json
- ./preview/2018-03-15-preview/definitions/ValidateMigrationInputSqlServerSqlMITask.json
```

### Tag: package-2017-11-15-preview

These settings apply only when `--tag=package-2017-11-15-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-11-15-preview'
input-file:
- ./preview/2017-11-15-preview/datamigration.json
- ./preview/2017-11-15-preview/definitions/Common.json
- ./preview/2017-11-15-preview/definitions/ConnectToSourceSqlServerTask.json
- ./preview/2017-11-15-preview/definitions/ConnectToTargetSqlDbTask.json
- ./preview/2017-11-15-preview/definitions/GetUserTablesSqlTask.json
- ./preview/2017-11-15-preview/definitions/MigrateSqlServerSqlDbTask.json
- ./preview/2017-11-15-preview/definitions/Projects.json
- ./preview/2017-11-15-preview/definitions/Services.json
- ./preview/2017-11-15-preview/definitions/Tasks.json
- ./preview/2017-11-15-preview/definitions/TasksCommon.json
- ./preview/2017-11-15-preview/definitions/MigrationValidation.json
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
  - repo: azure-powershell
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
      - ./preview/2021-10-30-preview/sqlmigration.json
      - ./preview/2022-01-30-preview/sqlmigration.json
      - ./preview/2022-03-30-preview/sqlmigration.json
      - ./preview/2023-07-15-preview/sqlmigration.json
      - ./preview/2025-03-15-preview/sqlmigration.json
    where:
      - $.definitions.RegenAuthKeys.properties.authKey1
      - $.definitions.RegenAuthKeys.properties.authKey2
      - $.definitions.AuthenticationKeys.properties.authKey1
      - $.definitions.AuthenticationKeys.properties.authKey2
    reason: Secrets are OK to return in a POST response.
```