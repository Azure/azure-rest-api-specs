## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-datamigration-2018-07-15-preview
  - tag: schema-datamigration-2018-04-19
  - tag: schema-datamigration-2018-03-31-preview
  - tag: schema-datamigration-2018-03-15-preview
  - tag: schema-datamigration-2017-11-15-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-datamigration-2018-07-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-datamigration-2018-07-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
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

### Tag: schema-datamigration-2018-04-19 and azureresourceschema

``` yaml $(tag) == 'schema-datamigration-2018-04-19' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
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

### Tag: schema-datamigration-2018-03-31-preview and azureresourceschema

``` yaml $(tag) == 'schema-datamigration-2018-03-31-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
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

### Tag: schema-datamigration-2018-03-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-datamigration-2018-03-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
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

### Tag: schema-datamigration-2017-11-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-datamigration-2017-11-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
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
