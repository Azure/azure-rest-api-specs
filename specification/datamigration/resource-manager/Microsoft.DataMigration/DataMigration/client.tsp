import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.DataMigration;

@@clientName(
  Microsoft.DataMigration,
  "DataMigrationManagementClient",
  "javascript,python"
);

@@clientName(
  ConnectToTargetSqlSqlDbSyncTaskProperties,
  "ConnectToTargetSQLDbSyncTaskProperties",
  "go"
);
@@clientName(
  ConnectToTargetSqlSqlDbSyncTaskInput,
  "ConnectToTargetSQLDbSyncTaskInput",
  "go"
);
@@clientName(
  DatabaseMigrationCosmosDbMongos.getForScope,
  "listForScope",
  "javascript"
);
@@clientName(
  DatabaseMigrationsMongoToCosmosDbvCoreMongo.getForScope,
  "listForScope",
  "javascript"
);

@@clientName(
  ConnectToTargetSqlSqlDbSyncTaskInput,
  "ConnectToTargetSqlDbSyncTaskInput",
  "python"
);
@@clientName(
  ConnectToTargetSqlSqlDbSyncTaskProperties,
  "ConnectToTargetSqlDbSyncTaskProperties",
  "python"
);

@@clientName(
  ConnectToTargetSqlSqlDbSyncTaskInput,
  "ConnectToTargetSqlDbSyncTaskInput",
  "java"
);
@@clientName(
  ConnectToTargetSqlSqlDbSyncTaskProperties,
  "ConnectToTargetSqlDbSyncTaskProperties",
  "java"
);
@@clientName(OracleOCIDriverInfo, "OracleOciDriverInfo", "java");
@@clientName(
  CheckOCIDriverTaskProperties,
  "CheckOciDriverTaskProperties",
  "java"
);
@@clientName(CheckOCIDriverTaskInput, "CheckOciDriverTaskInput", "java");
@@clientName(CheckOCIDriverTaskOutput, "CheckOciDriverTaskOutput", "java");
@@clientName(
  UploadOCIDriverTaskProperties,
  "UploadOciDriverTaskProperties",
  "java"
);
@@clientName(UploadOCIDriverTaskInput, "UploadOciDriverTaskInput", "java");
@@clientName(UploadOCIDriverTaskOutput, "UploadOciDriverTaskOutput", "java");
@@clientName(
  InstallOCIDriverTaskProperties,
  "InstallOciDriverTaskProperties",
  "java"
);
@@clientName(InstallOCIDriverTaskInput, "InstallOciDriverTaskInput", "java");
@@clientName(InstallOCIDriverTaskOutput, "InstallOciDriverTaskOutput", "java");

@@clientName(ConnectionInfo.userName, "username", "java");
@@clientName(FileShare.userName, "username", "java");
@@clientName(SqlConnectionInformation.userName, "username", "java");
@@clientName(MongoConnectionInformation.userName, "username", "java");
@@clientName(MongoDbConnectionInfo.enforceSSL, "enforceSsl", "java");
@@clientName(SqlBackupSetInfo.firstLSN, "firstLsn", "java");
@@clientName(SqlBackupSetInfo.lastLSN, "lastLsn", "java");
@@clientName(ResourceSkuCosts.meterID, "meterId", "java");
@@clientName(
  MigrateSyncCompleteCommandInput.commitTimeStamp,
  "commitTimestamp",
  "java"
);

// ===== C# customizations for MPG migration =====

// --- Suppress unwanted resources (removed in old autorest.md via directives) ---
// Files for DatabaseMigrationCosmosDbMongo, DatabaseMigrationsMongoToCosmosDb*, and MigrationService
// are deleted from Generated/ since they were excluded via autorest directives in the previous SDK.

// --- Resource/interface renames ---
@@clientName(Projects, "DataMigrationProjects", "csharp");
@@clientName(Project, "DataMigrationProject", "csharp");
@@clientName(ProjectFiles, "DataMigrationProjectFiles", "csharp");
@@clientName(ProjectFile, "DataMigrationProjectFile", "csharp");
@@clientName(ProjectTasks, "DataMigrationServiceTasks", "csharp");
@@clientName(ProjectTask, "DataMigrationProjectTask", "csharp");
@@clientName(ServiceTasks, "ServiceServiceTasks", "csharp");

// --- Operation name overrides ---
@@clientName(
  DataMigrationServices.checkChildrenNameAvailability,
  "CheckDataMigrationServiceNameAvailability",
  "csharp"
);
@@clientName(
  ServicesOperationGroup.checkNameAvailability,
  "CheckDataMigrationNameAvailability",
  "csharp"
);
@@clientName(UsagesOperationGroup.list, "GetUsages", "csharp");
@@clientName(
  ResourceSkusOperationGroup.listSkus,
  "GetSkusResourceSkus",
  "csharp"
);

// --- Type renames (from autorest.md rename-mapping) ---
@@clientName(AuthenticationKeys, "SqlMigrationAuthenticationKeys", "csharp");
@@clientName(AuthType, "SqlMigrationBlobAuthType", "csharp");
@@clientName(
  AvailableServiceSkuCapacity,
  "DataMigrationAvailableServiceSkuCapacity",
  "csharp"
);
@@clientName(
  AvailableServiceSkuSku,
  "DataMigrationAvailableServiceSkuDetails",
  "csharp"
);
@@clientName(AzureActiveDirectoryApp, "DataMigrationAadApp", "csharp");
@@clientName(AzureBlob, "SqlMigrationBlobDetails", "csharp");
@@clientName(ConnectionInfo, "ServerConnectionInfo", "csharp");
@@clientName(DatabaseFileType, "DataMigrationSqlDatabaseFileType", "csharp");
@@clientName(DatabaseInfo, "DataMigrationProjectDatabaseInfo", "csharp");
@@clientName(DatabaseState, "DataMigrationSqlDatabaseState", "csharp");
@@clientName(deleteNode, "DeletedIntegrationRuntimeNodeResult", "csharp");
@@clientName(ErrorInfo, "SqlMigrationErrorInfo", "csharp");
@@clientName(FileShare, "DataMigrationFileShareInfo", "csharp");
@@clientName(
  IntegrationRuntimeMonitoringData,
  "IntegrationRuntimeMonitoringResult",
  "csharp"
);
@@clientName(MigrationState, "DataMigrationState", "csharp");
@@clientName(MigrationStatus, "DataMigrationStatus", "csharp");
@@clientName(MigrationStatusDetails, "DataMigrationStatusDetails", "csharp");
@@clientName(
  NameAvailabilityRequest,
  "DataMigrationServiceNameAvailabilityContent",
  "csharp"
);
@@clientName(
  NameAvailabilityResponse,
  "DataMigrationServiceNameAvailabilityResult",
  "csharp"
);
@@clientName(
  NameCheckFailureReason,
  "DataMigrationServiceNameUnavailableReason",
  "csharp"
);
@@clientName(NodeMonitoringData, "IntegrationRuntimeMonitoringNode", "csharp");
@@clientName(ObjectType, "DataMigrationDatabaseObjectType", "csharp");
@@clientName(
  OrphanedUserInfo,
  "DataMigrationSqlServerOrphanedUserInfo",
  "csharp"
);
@@clientName(RegenAuthKeys, "SqlMigrationRegenAuthKeys", "csharp");
@@clientName(ResourceSku, "DataMigrationSku", "csharp");
@@clientName(ResourceSkuCapabilities, "DataMigrationSkuCapabilities", "csharp");
@@clientName(ResourceSkuCapacity, "DataMigrationSkuCapacity", "csharp");
@@clientName(ResourceSkuCosts, "DataMigrationSkuCosts", "csharp");
@@clientName(ResourceSkuRestrictions, "DataMigrationSkuRestrictions", "csharp");
@@clientName(
  ResourceSkuRestrictionsType,
  "DataMigrationSkuRestrictionsType",
  "csharp"
);
@@clientName(ServerProperties, "DataMigrationMySqlServerProperties", "csharp");
@@clientName(Severity, "MigrationValidationSeverity", "csharp");
@@clientName(SourceLocation, "DataMigrationBackupSourceLocation", "csharp");
@@clientName(TargetLocation, "DataMigrationBackupTargetLocation", "csharp");
@@clientName(UpdateActionType, "MigrationValidatioUpdateActionType", "csharp");
@@clientName(ValidationError, "MigrationValidationError", "csharp");
@@clientName(ValidationStatus, "MigrationValidationStatus", "csharp");
@@clientName(WaitStatistics, "MigrationValidationWaitStatistics", "csharp");

// --- Prepend DataMigration prefix renames ---
@@clientName(AuthenticationType, "DataMigrationAuthenticationType", "csharp");
@@clientName(AvailableServiceSku, "DataMigrationAvailableServiceSku", "csharp");
@@clientName(BackupConfiguration, "DataMigrationBackupConfiguration", "csharp");
@@clientName(BackupFileInfo, "DataMigrationBackupFileInfo", "csharp");
@@clientName(BackupFileStatus, "DataMigrationBackupFileStatus", "csharp");
@@clientName(BackupMode, "DataMigrationBackupMode", "csharp");
@@clientName(BackupSetInfo, "DataMigrationBackupSetInfo", "csharp");
@@clientName(BackupType, "DataMigrationBackupType", "csharp");
@@clientName(BlobShare, "DataMigrationBlobShare", "csharp");
@@clientName(CommandProperties, "DataMigrationCommandProperties", "csharp");
@@clientName(CommandState, "DataMigrationCommandState", "csharp");
@@clientName(CommandType, "DataMigrationCommandType", "csharp");
@@clientName(DatabaseBackupInfo, "DataMigrationDatabaseBackupInfo", "csharp");
@@clientName(DatabaseCompatLevel, "DataMigrationDatabaseCompatLevel", "csharp");
@@clientName(DatabaseFileInfo, "DataMigrationDatabaseFileInfo", "csharp");
@@clientName(DatabaseTable, "DataMigrationDatabaseTable", "csharp");
@@clientName(FileStorageInfo, "DataMigrationFileStorageInfo", "csharp");
@@clientName(LoginType, "DataMigrationLoginType", "csharp");
@@clientName(MiSqlConnectionInfo, "DataMigrationMISqlConnectionInfo", "csharp");
@@clientName(
  MongoDbCancelCommand,
  "DataMigrationMongoDBCancelCommand",
  "csharp"
);
@@clientName(MongoDbClusterInfo, "DataMigrationMongoDBClusterInfo", "csharp");
@@clientName(MongoDbClusterType, "DataMigrationMongoDBClusterType", "csharp");
@@clientName(
  MongoDbCollectionInfo,
  "DataMigrationMongoDBCollectionInfo",
  "csharp"
);
@@clientName(
  MongoDbCollectionProgress,
  "DataMigrationMongoDBCollectionProgress",
  "csharp"
);
@@clientName(
  MongoDbCollectionSettings,
  "DataMigrationMongoDBCollectionSettings",
  "csharp"
);
@@clientName(MongoDbCommandInput, "DataMigrationMongoDBCommandInput", "csharp");
@@clientName(
  MongoDbConnectionInfo,
  "DataMigrationMongoDBConnectionInfo",
  "csharp"
);
@@clientName(MongoDbDatabaseInfo, "DataMigrationMongoDBDatabaseInfo", "csharp");
@@clientName(
  MongoDbDatabaseProgress,
  "DataMigrationMongoDBDatabaseProgress",
  "csharp"
);
@@clientName(
  MongoDbDatabaseSettings,
  "DataMigrationMongoDBDatabaseSettings",
  "csharp"
);
@@clientName(MongoDbError, "DataMigrationMongoDBError", "csharp");
@@clientName(MongoDbErrorType, "DataMigrationMongoDBErrorType", "csharp");
@@clientName(
  MongoDbFinishCommand,
  "DataMigrationMongoDBFinishCommand",
  "csharp"
);
@@clientName(
  MongoDbFinishCommandInput,
  "DataMigrationMongoDBFinishCommandInput",
  "csharp"
);
@@clientName(
  MongoDbMigrationProgress,
  "DataMigrationMongoDBMigrationProgress",
  "csharp"
);
@@clientName(
  MongoDbMigrationSettings,
  "DataMigrationMongoDBMigrationSettings",
  "csharp"
);
@@clientName(
  MongoDbMigrationState,
  "DataMigrationMongoDBMigrationState",
  "csharp"
);
@@clientName(MongoDbObjectInfo, "DataMigrationMongoDBObjectInfo", "csharp");
@@clientName(MongoDbProgress, "DataMigrationMongoDBProgress", "csharp");
@@clientName(
  MongoDbProgressResultType,
  "DataMigrationMongoDBProgressResultType",
  "csharp"
);
@@clientName(MongoDbReplication, "DataMigrationMongoDBReplication", "csharp");
@@clientName(
  MongoDbRestartCommand,
  "DataMigrationMongoDBRestartCommand",
  "csharp"
);
@@clientName(
  MongoDbShardKeyField,
  "DataMigrationMongoDBShardKeyField",
  "csharp"
);
@@clientName(MongoDbShardKeyInfo, "DataMigrationMongoDBShardKeyInfo", "csharp");
@@clientName(
  MongoDbShardKeyOrder,
  "DataMigrationMongoDBShardKeyOrder",
  "csharp"
);
@@clientName(
  MongoDbShardKeySetting,
  "DataMigrationMongoDBShardKeySetting",
  "csharp"
);
@@clientName(
  MongoDbThrottlingSettings,
  "DataMigrationMongoDBThrottlingSettings",
  "csharp"
);
@@clientName(MySqlConnectionInfo, "DataMigrationMySqlConnectionInfo", "csharp");
@@clientName(
  MySqlTargetPlatformType,
  "DataMigrationMySqlTargetPlatformType",
  "csharp"
);
@@clientName(ODataError, "DataMigrationODataError", "csharp");
@@clientName(
  OfflineConfiguration,
  "DataMigrationOfflineConfiguration",
  "csharp"
);
@@clientName(
  OracleConnectionInfo,
  "DataMigrationOracleConnectionInfo",
  "csharp"
);
@@clientName(OracleOCIDriverInfo, "DataMigrationOracleOciDriverInfo", "csharp");
@@clientName(
  PostgreSqlConnectionInfo,
  "DataMigrationPostgreSqlConnectionInfo",
  "csharp"
);
@@clientName(
  ProjectFileProperties,
  "DataMigrationProjectFileProperties",
  "csharp"
);
@@clientName(
  ProjectProvisioningState,
  "DataMigrationProjectProvisioningState",
  "csharp"
);
@@clientName(
  ProjectSourcePlatform,
  "DataMigrationProjectSourcePlatform",
  "csharp"
);
@@clientName(
  ProjectTargetPlatform,
  "DataMigrationProjectTargetPlatform",
  "csharp"
);
@@clientName(
  ProjectTaskProperties,
  "DataMigrationProjectTaskProperties",
  "csharp"
);
@@clientName(ProvisioningState, "DataMigrationProvisioningState", "csharp");
@@clientName(Quota, "DataMigrationQuota", "csharp");
@@clientName(QuotaName, "DataMigrationQuotaName", "csharp");
@@clientName(ReportableException, "DataMigrationReportableException", "csharp");
@@clientName(ScenarioSource, "DataMigrationScenarioSource", "csharp");
@@clientName(ScenarioTarget, "DataMigrationScenarioTarget", "csharp");
@@clientName(
  ServiceProvisioningState,
  "DataMigrationServiceProvisioningState",
  "csharp"
);
@@clientName(ServiceScalability, "DataMigrationServiceScalability", "csharp");
@@clientName(ServiceSku, "DataMigrationServiceSku", "csharp");
@@clientName(SqlBackupFileInfo, "DataMigrationSqlBackupFileInfo", "csharp");
@@clientName(SqlBackupSetInfo, "DataMigrationSqlBackupSetInfo", "csharp");
@@clientName(SqlConnectionInfo, "DataMigrationSqlConnectionInfo", "csharp");
@@clientName(
  SqlConnectionInformation,
  "DataMigrationSqlConnectionInformation",
  "csharp"
);
@@clientName(
  SqlDbMigrationStatusDetails,
  "DataMigrationSqlDBMigrationStatusDetails",
  "csharp"
);
@@clientName(
  SqlDbOfflineConfiguration,
  "DataMigrationSqlDBOfflineConfiguration",
  "csharp"
);
@@clientName(SqlFileShare, "DataMigrationSqlFileShare", "csharp");
@@clientName(SqlSourcePlatform, "DataMigrationSqlSourcePlatform", "csharp");
@@clientName(SsisStoreType, "DataMigrationSsisStoreType", "csharp");
@@clientName(TaskState, "DataMigrationTaskState", "csharp");
@@clientName(TaskType, "DataMigrationTaskType", "csharp");

// --- Property renames ---
@@clientName(
  AzureActiveDirectoryApp.ignoreAzurePermissions,
  "DoesIgnoreAzurePermissions",
  "csharp"
);
@@clientName(
  ConnectToSourceSqlServerTaskInput.collectAgentJobs,
  "ShouldCollectAgentJobs",
  "csharp"
);
@@clientName(
  ConnectToSourceSqlServerTaskInput.collectDatabases,
  "ShouldCollectDatabases",
  "csharp"
);
@@clientName(
  ConnectToSourceSqlServerTaskInput.collectLogins,
  "ShouldCollectLogins",
  "csharp"
);
@@clientName(
  ConnectToSourceSqlServerTaskInput.collectTdeCertificateInfo,
  "ShouldCollectTdeCertificateInfo",
  "csharp"
);
@@clientName(
  ConnectToSourceSqlServerTaskInput.validateSsisCatalogOnly,
  "ShouldValidateSsisCatalogOnly",
  "csharp"
);
@@clientName(
  ConnectToTargetSqlDbTaskInput.queryObjectCounts,
  "ShouldQueryObjectCounts",
  "csharp"
);
@@clientName(
  ConnectToTargetSqlMITaskInput.collectAgentJobs,
  "ShouldCollectAgentJobs",
  "csharp"
);
@@clientName(
  ConnectToTargetSqlMITaskInput.collectLogins,
  "ShouldCollectLogins",
  "csharp"
);
@@clientName(
  ConnectToTargetSqlMITaskInput.validateSsisCatalogOnly,
  "ShouldValidateSsisCatalogOnly",
  "csharp"
);
@@clientName(CopyProgressDetails.copyStart, "CopyStartOn", "csharp");
@@clientName(DatabaseBackupInfo.backupFinishDate, "BackupFinishedOn", "csharp");
@@clientName(
  DataMigrationServiceProperties.deleteResourcesOnStop,
  "ShouldDeleteResourcesOnStop",
  "csharp"
);
@@clientName(ExecutionStatistics.cpuTimeMs, "CpuTimeInMilliseconds", "csharp");
@@clientName(
  ExecutionStatistics.elapsedTimeMs,
  "ElapsedTimeInMilliseconds",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlOfflineTaskInput.makeSourceServerReadOnly,
  "ShouldMakeSourceServerReadOnly",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlOfflineTaskOutputDatabaseLevel.lastStorageUpdate,
  "LastStorageUpdatedOn",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlOfflineTaskOutputMigrationLevel.lastStorageUpdate,
  "LastStorageUpdatedOn",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlOfflineTaskOutputTableLevel.lastStorageUpdate,
  "LastStorageUpdatedOn",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlSyncTaskOutputDatabaseLevel.initializationCompleted,
  "IsInitializationCompleted",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlSyncTaskOutputTableLevel.fullLoadEstFinishTime,
  "FullLoadEstFinishedOn",
  "csharp"
);
@@clientName(
  MigrateOracleAzureDbPostgreSqlSyncTaskOutputDatabaseLevel.initializationCompleted,
  "IsInitializationCompleted",
  "csharp"
);
@@clientName(
  MigrateOracleAzureDbPostgreSqlSyncTaskOutputTableLevel.fullLoadEstFinishTime,
  "FullLoadEstFinishedOn",
  "csharp"
);
@@clientName(
  MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputDatabaseLevel.initializationCompleted,
  "IsInitializationCompleted",
  "csharp"
);
@@clientName(
  MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputTableLevel.fullLoadEstFinishTime,
  "FullLoadEstFinishedOn",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbDatabaseInput.makeSourceDbReadOnly,
  "ShouldMakeSourceDBReadOnly",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbSyncTaskOutputDatabaseLevel.initializationCompleted,
  "IsInitializationCompleted",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbSyncTaskOutputTableLevel.fullLoadEstFinishTime,
  "FullLoadEstFinishedOn",
  "csharp"
);
@@clientName(
  MigrateSyncCompleteCommandInput.commitTimeStamp,
  "CompletedOn",
  "csharp"
);
@@clientName(
  MigrationValidationOptions.enableDataIntegrityValidation,
  "IsDataIntegrityValidationEnabled",
  "csharp"
);
@@clientName(
  MigrationValidationOptions.enableQueryAnalysisValidation,
  "IsQueryAnalysisValidationEnabled",
  "csharp"
);
@@clientName(
  MigrationValidationOptions.enableSchemaValidation,
  "IsSchemaValidationEnabled",
  "csharp"
);
@@clientName(
  MongoDbClusterInfo.supportsSharding,
  "IsShardingSupported",
  "csharp"
);
@@clientName(
  MongoDbCollectionInfo.supportsSharding,
  "IsShardingSupported",
  "csharp"
);
@@clientName(
  MongoDbConnectionInfo.encryptConnection,
  "ShouldEncryptConnection",
  "csharp"
);
@@clientName(MongoDbConnectionInfo.enforceSSL, "DoesEnforceSsl", "csharp");
@@clientName(
  MongoDbConnectionInfo.trustServerCertificate,
  "ShouldTrustServerCertificate",
  "csharp"
);
@@clientName(
  MongoDbDatabaseInfo.supportsSharding,
  "IsShardingSupported",
  "csharp"
);
@@clientName(
  MongoDbFinishCommandInput.immediate,
  "ShouldStopReplicationImmediately",
  "csharp"
);
@@clientName(
  MySqlConnectionInfo.encryptConnection,
  "ShouldEncryptConnection",
  "csharp"
);
@@clientName(
  NameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(OfflineConfiguration.offline, "IsOfflineMigration", "csharp");
@@clientName(
  PostgreSqlConnectionInfo.encryptConnection,
  "ShouldEncryptConnection",
  "csharp"
);
@@clientName(
  PostgreSqlConnectionInfo.trustServerCertificate,
  "ShouldTrustServerCertificate",
  "csharp"
);
@@clientName(ProjectFileProperties.lastModified, "LastModifiedOn", "csharp");
@@clientName(ScenarioSource.MySQLRDS, "MySqlRds", "csharp");
@@clientName(ScenarioSource.PostgreSQLRDS, "PostgreSqlRds", "csharp");
@@clientName(ScenarioSource.SQLRDS, "SqlRds", "csharp");
@@clientName(
  SqlConnectionInfo.encryptConnection,
  "ShouldEncryptConnection",
  "csharp"
);
@@clientName(
  SqlConnectionInfo.trustServerCertificate,
  "ShouldTrustServerCertificate",
  "csharp"
);
@@clientName(
  SqlConnectionInformation.encryptConnection,
  "ShouldEncryptConnection",
  "csharp"
);
@@clientName(
  SqlConnectionInformation.trustServerCertificate,
  "ShouldTrustServerCertificate",
  "csharp"
);
@@clientName(SqlDbOfflineConfiguration.offline, "IsOfflineMigration", "csharp");
@@clientName(WaitStatistics.waitTimeMs, "WaitTimeInMilliseconds", "csharp");

// --- Restore TrackedResourceData base type for GA backward compat ---
// The generator maps TrackedResourceWithOptionalLocation to ResourceData,
// but the GA SDK shipped these as TrackedResourceData.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(
  DataMigrationService,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(
  Project,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(
  SqlMigrationService,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

// --- Format overrides (arm-id, azureLocation) ---
@@alternateType(
  DataMigrationService.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(Project.location, Azure.Core.azureLocation, "csharp");
@@alternateType(
  SqlMigrationService.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  MiSqlConnectionInfo.managedInstanceResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// --- Property renames for GA compat (replacing SDK-side shims) ---
@@clientName(MongoDbClusterInfo.type, "ClusterType", "csharp");
@@clientName(MongoDbError.type, "ErrorType", "csharp");
@@clientName(ResourceSkuCosts.meterID, "MeterId", "csharp");
@@clientName(ResourceSkuRestrictions.type, "RestrictionsType", "csharp");
@@clientName(NameAvailabilityRequest.type, "ResourceType", "csharp");

// --- Naming convention fixes (AZC0030) ---
@@clientName(
  MongoMigrationCollection,
  "DataMigrationMongoMigrationCollectionInfo",
  "csharp"
);

// --- Properties model renames (from autorest.md directives) ---
@@clientName(
  DatabaseMigrationPropertiesSqlMi,
  "DatabaseMigrationSqlMIProperties",
  "csharp"
);
@@clientName(
  DatabaseMigrationPropertiesSqlVm,
  "DatabaseMigrationSqlVmProperties",
  "csharp"
);
@@clientName(
  DatabaseMigrationPropertiesSqlDb,
  "DatabaseMigrationSqlDBProperties",
  "csharp"
);

// --- Casing fixes for model factory consistency ---
// SqlDb -> SqlDB (from autorest.md acronym-mapping: Sqldb: SqlDB)
@@clientName(
  ConnectToTargetSqlDbTaskInput,
  "ConnectToTargetSqlDBTaskInput",
  "csharp"
);
@@clientName(
  ConnectToTargetSqlDbTaskOutput,
  "ConnectToTargetSqlDBTaskOutput",
  "csharp"
);
@@clientName(
  ConnectToTargetSqlDbTaskProperties,
  "ConnectToTargetSqlDBTaskProperties",
  "csharp"
);
@@clientName(
  ConnectToTargetSqlSqlDbSyncTaskInput,
  "ConnectToTargetSqlDBSyncTaskInput",
  "csharp"
);
@@clientName(
  ConnectToTargetSqlSqlDbSyncTaskProperties,
  "ConnectToTargetSqlDBSyncTaskProperties",
  "csharp"
);
@@clientName(
  MigrateSchemaSqlServerSqlDbDatabaseInput,
  "MigrateSchemaSqlServerSqlDBDatabaseInput",
  "csharp"
);
@@clientName(
  MigrateSchemaSqlServerSqlDbTaskInput,
  "MigrateSchemaSqlServerSqlDBTaskInput",
  "csharp"
);
@@clientName(
  MigrateSchemaSqlServerSqlDbTaskOutput,
  "MigrateSchemaSqlServerSqlDBTaskOutput",
  "csharp"
);
@@clientName(
  MigrateSchemaSqlServerSqlDbTaskOutputDatabaseLevel,
  "MigrateSchemaSqlServerSqlDBTaskOutputDatabaseLevel",
  "csharp"
);
@@clientName(
  MigrateSchemaSqlServerSqlDbTaskOutputError,
  "MigrateSchemaSqlServerSqlDBTaskOutputError",
  "csharp"
);
@@clientName(
  MigrateSchemaSqlServerSqlDbTaskOutputMigrationLevel,
  "MigrateSchemaSqlServerSqlDBTaskOutputMigrationLevel",
  "csharp"
);
@@clientName(
  MigrateSchemaSqlServerSqlDbTaskProperties,
  "MigrateSchemaSqlServerSqlDBTaskProperties",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbDatabaseInput,
  "MigrateSqlServerSqlDBDatabaseInput",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbSyncDatabaseInput,
  "MigrateSqlServerSqlDBSyncDatabaseInput",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbSyncTaskInput,
  "MigrateSqlServerSqlDBSyncTaskInput",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbSyncTaskOutput,
  "MigrateSqlServerSqlDBSyncTaskOutput",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbSyncTaskOutputDatabaseError,
  "MigrateSqlServerSqlDBSyncTaskOutputDatabaseError",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbSyncTaskOutputDatabaseLevel,
  "MigrateSqlServerSqlDBSyncTaskOutputDatabaseLevel",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbSyncTaskOutputError,
  "MigrateSqlServerSqlDBSyncTaskOutputError",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbSyncTaskOutputMigrationLevel,
  "MigrateSqlServerSqlDBSyncTaskOutputMigrationLevel",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbSyncTaskOutputTableLevel,
  "MigrateSqlServerSqlDBSyncTaskOutputTableLevel",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbSyncTaskProperties,
  "MigrateSqlServerSqlDBSyncTaskProperties",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbTaskInput,
  "MigrateSqlServerSqlDBTaskInput",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbTaskOutput,
  "MigrateSqlServerSqlDBTaskOutput",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbTaskOutputDatabaseLevel,
  "MigrateSqlServerSqlDBTaskOutputDatabaseLevel",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbTaskOutputDatabaseLevelValidationResult,
  "MigrateSqlServerSqlDBTaskOutputDatabaseLevelValidationResult",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbTaskOutputError,
  "MigrateSqlServerSqlDBTaskOutputError",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbTaskOutputMigrationLevel,
  "MigrateSqlServerSqlDBTaskOutputMigrationLevel",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbTaskOutputTableLevel,
  "MigrateSqlServerSqlDBTaskOutputTableLevel",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbTaskOutputValidationResult,
  "MigrateSqlServerSqlDBTaskOutputValidationResult",
  "csharp"
);
@@clientName(
  MigrateSqlServerSqlDbTaskProperties,
  "MigrateSqlServerSqlDBTaskProperties",
  "csharp"
);
@@clientName(
  ValidateMigrationInputSqlServerSqlDbSyncTaskProperties,
  "ValidateMigrationInputSqlServerSqlDBSyncTaskProperties",
  "csharp"
);
@@clientName(DatabaseMigrationSqlDb, "DatabaseMigrationSqlDB", "csharp");

// --- Acronym casing renames (AzureDb->AzureDB, MongoDb->MongoDB, SqlMi->SqlMI) ---
@@clientName(
  ConnectToMongoDbTaskProperties,
  "ConnectToMongoDBTaskProperties",
  "csharp"
);
@@clientName(
  ConnectToTargetAzureDbForMySqlTaskInput,
  "ConnectToTargetAzureDBForMySqlTaskInput",
  "csharp"
);
@@clientName(
  ConnectToTargetAzureDbForMySqlTaskOutput,
  "ConnectToTargetAzureDBForMySqlTaskOutput",
  "csharp"
);
@@clientName(
  ConnectToTargetAzureDbForMySqlTaskProperties,
  "ConnectToTargetAzureDBForMySqlTaskProperties",
  "csharp"
);
@@clientName(
  ConnectToTargetAzureDbForPostgreSqlSyncTaskInput,
  "ConnectToTargetAzureDBForPostgreSqlSyncTaskInput",
  "csharp"
);
@@clientName(
  ConnectToTargetAzureDbForPostgreSqlSyncTaskOutput,
  "ConnectToTargetAzureDBForPostgreSqlSyncTaskOutput",
  "csharp"
);
@@clientName(
  ConnectToTargetAzureDbForPostgreSqlSyncTaskProperties,
  "ConnectToTargetAzureDBForPostgreSqlSyncTaskProperties",
  "csharp"
);
@@clientName(
  ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskInput,
  "ConnectToTargetOracleAzureDBForPostgreSqlSyncTaskInput",
  "csharp"
);
@@clientName(
  ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskOutput,
  "ConnectToTargetOracleAzureDBForPostgreSqlSyncTaskOutput",
  "csharp"
);
@@clientName(
  ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskOutputDatabaseSchemaMapItem,
  "ConnectToTargetOracleAzureDBForPostgreSqlSyncTaskOutputDatabaseSchemaMapItem",
  "csharp"
);
@@clientName(
  ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskProperties,
  "ConnectToTargetOracleAzureDBForPostgreSqlSyncTaskProperties",
  "csharp"
);
@@clientName(DatabaseMigrationSqlMi, "DatabaseMigrationSqlMI", "csharp");
@@clientName(
  MigrateMongoDbTaskProperties,
  "MigrateMongoDBTaskProperties",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlOfflineDatabaseInput,
  "MigrateMySqlAzureDBForMySqlOfflineDatabaseInput",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlOfflineTaskInput,
  "MigrateMySqlAzureDBForMySqlOfflineTaskInput",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlOfflineTaskOutput,
  "MigrateMySqlAzureDBForMySqlOfflineTaskOutput",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlOfflineTaskOutputDatabaseLevel,
  "MigrateMySqlAzureDBForMySqlOfflineTaskOutputDatabaseLevel",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlOfflineTaskOutputError,
  "MigrateMySqlAzureDBForMySqlOfflineTaskOutputError",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlOfflineTaskOutputMigrationLevel,
  "MigrateMySqlAzureDBForMySqlOfflineTaskOutputMigrationLevel",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlOfflineTaskOutputTableLevel,
  "MigrateMySqlAzureDBForMySqlOfflineTaskOutputTableLevel",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlOfflineTaskProperties,
  "MigrateMySqlAzureDBForMySqlOfflineTaskProperties",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlSyncDatabaseInput,
  "MigrateMySqlAzureDBForMySqlSyncDatabaseInput",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlSyncTaskInput,
  "MigrateMySqlAzureDBForMySqlSyncTaskInput",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlSyncTaskOutput,
  "MigrateMySqlAzureDBForMySqlSyncTaskOutput",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlSyncTaskOutputDatabaseError,
  "MigrateMySqlAzureDBForMySqlSyncTaskOutputDatabaseError",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlSyncTaskOutputDatabaseLevel,
  "MigrateMySqlAzureDBForMySqlSyncTaskOutputDatabaseLevel",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlSyncTaskOutputError,
  "MigrateMySqlAzureDBForMySqlSyncTaskOutputError",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlSyncTaskOutputMigrationLevel,
  "MigrateMySqlAzureDBForMySqlSyncTaskOutputMigrationLevel",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlSyncTaskOutputTableLevel,
  "MigrateMySqlAzureDBForMySqlSyncTaskOutputTableLevel",
  "csharp"
);
@@clientName(
  MigrateMySqlAzureDbForMySqlSyncTaskProperties,
  "MigrateMySqlAzureDBForMySqlSyncTaskProperties",
  "csharp"
);
@@clientName(
  MigrateOracleAzureDbForPostgreSqlSyncTaskProperties,
  "MigrateOracleAzureDBForPostgreSqlSyncTaskProperties",
  "csharp"
);
@@clientName(
  MigrateOracleAzureDbPostgreSqlSyncDatabaseInput,
  "MigrateOracleAzureDBPostgreSqlSyncDatabaseInput",
  "csharp"
);
@@clientName(
  MigrateOracleAzureDbPostgreSqlSyncTaskInput,
  "MigrateOracleAzureDBPostgreSqlSyncTaskInput",
  "csharp"
);
@@clientName(
  MigrateOracleAzureDbPostgreSqlSyncTaskOutput,
  "MigrateOracleAzureDBPostgreSqlSyncTaskOutput",
  "csharp"
);
@@clientName(
  MigrateOracleAzureDbPostgreSqlSyncTaskOutputDatabaseError,
  "MigrateOracleAzureDBPostgreSqlSyncTaskOutputDatabaseError",
  "csharp"
);
@@clientName(
  MigrateOracleAzureDbPostgreSqlSyncTaskOutputDatabaseLevel,
  "MigrateOracleAzureDBPostgreSqlSyncTaskOutputDatabaseLevel",
  "csharp"
);
@@clientName(
  MigrateOracleAzureDbPostgreSqlSyncTaskOutputError,
  "MigrateOracleAzureDBPostgreSqlSyncTaskOutputError",
  "csharp"
);
@@clientName(
  MigrateOracleAzureDbPostgreSqlSyncTaskOutputMigrationLevel,
  "MigrateOracleAzureDBPostgreSqlSyncTaskOutputMigrationLevel",
  "csharp"
);
@@clientName(
  MigrateOracleAzureDbPostgreSqlSyncTaskOutputTableLevel,
  "MigrateOracleAzureDBPostgreSqlSyncTaskOutputTableLevel",
  "csharp"
);
@@clientName(
  MigratePostgreSqlAzureDbForPostgreSqlSyncDatabaseInput,
  "MigratePostgreSqlAzureDBForPostgreSqlSyncDatabaseInput",
  "csharp"
);
@@clientName(
  MigratePostgreSqlAzureDbForPostgreSqlSyncDatabaseTableInput,
  "MigratePostgreSqlAzureDBForPostgreSqlSyncDatabaseTableInput",
  "csharp"
);
@@clientName(
  MigratePostgreSqlAzureDbForPostgreSqlSyncTaskInput,
  "MigratePostgreSqlAzureDBForPostgreSqlSyncTaskInput",
  "csharp"
);
@@clientName(
  MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput,
  "MigratePostgreSqlAzureDBForPostgreSqlSyncTaskOutput",
  "csharp"
);
@@clientName(
  MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputDatabaseError,
  "MigratePostgreSqlAzureDBForPostgreSqlSyncTaskOutputDatabaseError",
  "csharp"
);
@@clientName(
  MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputDatabaseLevel,
  "MigratePostgreSqlAzureDBForPostgreSqlSyncTaskOutputDatabaseLevel",
  "csharp"
);
@@clientName(
  MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputError,
  "MigratePostgreSqlAzureDBForPostgreSqlSyncTaskOutputError",
  "csharp"
);
@@clientName(
  MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputMigrationLevel,
  "MigratePostgreSqlAzureDBForPostgreSqlSyncTaskOutputMigrationLevel",
  "csharp"
);
@@clientName(
  MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputTableLevel,
  "MigratePostgreSqlAzureDBForPostgreSqlSyncTaskOutputTableLevel",
  "csharp"
);
@@clientName(
  MigratePostgreSqlAzureDbForPostgreSqlSyncTaskProperties,
  "MigratePostgreSqlAzureDBForPostgreSqlSyncTaskProperties",
  "csharp"
);
@@clientName(
  ValidateMongoDbTaskProperties,
  "ValidateMongoDBTaskProperties",
  "csharp"
);
@@clientName(
  ValidateOracleAzureDbForPostgreSqlSyncTaskProperties,
  "ValidateOracleAzureDBForPostgreSqlSyncTaskProperties",
  "csharp"
);
@@clientName(
  ValidateOracleAzureDbPostgreSqlSyncTaskOutput,
  "ValidateOracleAzureDBPostgreSqlSyncTaskOutput",
  "csharp"
);

// --- OCI -> Oci casing (from autorest.md acronym mapping) ---
@@clientName(CheckOCIDriverTaskInput, "CheckOciDriverTaskInput", "csharp");
@@clientName(CheckOCIDriverTaskOutput, "CheckOciDriverTaskOutput", "csharp");
@@clientName(
  CheckOCIDriverTaskProperties,
  "CheckOciDriverTaskProperties",
  "csharp"
);
@@clientName(InstallOCIDriverTaskInput, "InstallOciDriverTaskInput", "csharp");
@@clientName(
  InstallOCIDriverTaskOutput,
  "InstallOciDriverTaskOutput",
  "csharp"
);
@@clientName(
  InstallOCIDriverTaskProperties,
  "InstallOciDriverTaskProperties",
  "csharp"
);
@@clientName(UploadOCIDriverTaskInput, "UploadOciDriverTaskInput", "csharp");
@@clientName(UploadOCIDriverTaskOutput, "UploadOciDriverTaskOutput", "csharp");
@@clientName(
  UploadOCIDriverTaskProperties,
  "UploadOciDriverTaskProperties",
  "csharp"
);

// --- Access overrides ---
@@access(BlobShare, Access.public, "csharp");

// --- DatabaseMigrationPropertiesSqlVm and SqlDb renames already above ---

// --- Enum value renames (SCREAMING_CASE -> PascalCase for GA compat) ---
@@clientName(DatabaseMigrationState.CANCELLED, "Cancelled", "csharp");
@@clientName(DatabaseMigrationState.COMPLETED, "Completed", "csharp");
@@clientName(DatabaseMigrationState.CUTOVER_START, "CutoverStart", "csharp");
@@clientName(DatabaseMigrationState.FAILED, "Failed", "csharp");
@@clientName(
  DatabaseMigrationState.FULL_BACKUP_UPLOAD_START,
  "FullBackupUploadStart",
  "csharp"
);
@@clientName(DatabaseMigrationState.INITIAL, "Initial", "csharp");
@@clientName(
  DatabaseMigrationState.LOG_SHIPPING_START,
  "LOGShippingStart",
  "csharp"
);
@@clientName(
  DatabaseMigrationState.POST_CUTOVER_COMPLETE,
  "PostCutoverComplete",
  "csharp"
);
@@clientName(DatabaseMigrationState.UNDEFINED, "Undefined", "csharp");
@@clientName(
  DatabaseMigrationState.UPLOAD_LOG_FILES_START,
  "UploadLOGFilesStart",
  "csharp"
);
@@clientName(MongoDbClusterType.CosmosDb, "CosmosDB", "csharp");
@@clientName(MongoDbClusterType.MongoDb, "MongoDB", "csharp");
@@clientName(
  MySqlTargetPlatformType.AzureDbForMySQL,
  "AzureDBForMySql",
  "csharp"
);
@@clientName(ProjectSourcePlatform.MongoDb, "MongoDB", "csharp");
@@clientName(ProjectSourcePlatform.MySQL, "MySql", "csharp");
@@clientName(ProjectSourcePlatform.SQL, "Sql", "csharp");
@@clientName(
  ProjectTargetPlatform.AzureDbForMySql,
  "AzureDBForMySql",
  "csharp"
);
@@clientName(
  ProjectTargetPlatform.AzureDbForPostgreSql,
  "AzureDBForPostgreSql",
  "csharp"
);
@@clientName(ProjectTargetPlatform.MongoDb, "MongoDB", "csharp");
@@clientName(ProjectTargetPlatform.SQLDB, "SqlDB", "csharp");
@@clientName(ProjectTargetPlatform.SQLMI, "SqlMI", "csharp");
@@clientName(
  ReplicateMigrationState.ACTION_REQUIRED,
  "ActionRequired",
  "csharp"
);
@@clientName(ReplicateMigrationState.COMPLETE, "Complete", "csharp");
@@clientName(ReplicateMigrationState.FAILED, "Failed", "csharp");
@@clientName(ReplicateMigrationState.PENDING, "Pending", "csharp");
@@clientName(ReplicateMigrationState.UNDEFINED, "Undefined", "csharp");
@@clientName(ReplicateMigrationState.VALIDATING, "Validating", "csharp");
@@clientName(ScenarioSource.MySQL, "MySql", "csharp");
@@clientName(ScenarioSource.PostgreSQL, "PostgreSql", "csharp");
@@clientName(ScenarioSource.SQL, "Sql", "csharp");
@@clientName(
  ScenarioTarget.AzureDBForPostgresSQL,
  "AzureDBForPostgresSql",
  "csharp"
);
@@clientName(ScenarioTarget.SQLDB, "SqlDB", "csharp");
@@clientName(ScenarioTarget.SQLDW, "SqlDW", "csharp");
@@clientName(ScenarioTarget.SQLMI, "SqlMI", "csharp");
@@clientName(ScenarioTarget.SQLServer, "SqlServer", "csharp");
@@clientName(
  SyncDatabaseMigrationReportingState.BACKUP_COMPLETED,
  "BackupCompleted",
  "csharp"
);
@@clientName(
  SyncDatabaseMigrationReportingState.BACKUP_IN_PROGRESS,
  "BackupINProgress",
  "csharp"
);
@@clientName(
  SyncDatabaseMigrationReportingState.CANCELLED,
  "Cancelled",
  "csharp"
);
@@clientName(
  SyncDatabaseMigrationReportingState.CANCELLING,
  "Cancelling",
  "csharp"
);
@@clientName(
  SyncDatabaseMigrationReportingState.COMPLETE,
  "Complete",
  "csharp"
);
@@clientName(
  SyncDatabaseMigrationReportingState.COMPLETING,
  "Completing",
  "csharp"
);
@@clientName(
  SyncDatabaseMigrationReportingState.CONFIGURING,
  "Configuring",
  "csharp"
);
@@clientName(SyncDatabaseMigrationReportingState.FAILED, "Failed", "csharp");
@@clientName(
  SyncDatabaseMigrationReportingState.INITIALIAZING,
  "Initialiazing",
  "csharp"
);
@@clientName(
  SyncDatabaseMigrationReportingState.READY_TO_COMPLETE,
  "ReadyTOComplete",
  "csharp"
);
@@clientName(
  SyncDatabaseMigrationReportingState.RESTORE_COMPLETED,
  "RestoreCompleted",
  "csharp"
);
@@clientName(
  SyncDatabaseMigrationReportingState.RESTORE_IN_PROGRESS,
  "RestoreINProgress",
  "csharp"
);
@@clientName(SyncDatabaseMigrationReportingState.RUNNING, "Running", "csharp");
@@clientName(
  SyncDatabaseMigrationReportingState.STARTING,
  "Starting",
  "csharp"
);
@@clientName(
  SyncDatabaseMigrationReportingState.UNDEFINED,
  "Undefined",
  "csharp"
);
@@clientName(
  SyncDatabaseMigrationReportingState.VALIDATING,
  "Validating",
  "csharp"
);
@@clientName(
  SyncDatabaseMigrationReportingState.VALIDATION_COMPLETE,
  "ValidationComplete",
  "csharp"
);
@@clientName(
  SyncDatabaseMigrationReportingState.VALIDATION_FAILED,
  "ValidationFailed",
  "csharp"
);
@@clientName(SyncTableMigrationState.BEFORE_LOAD, "BeforeLoad", "csharp");
@@clientName(SyncTableMigrationState.CANCELED, "Canceled", "csharp");
@@clientName(SyncTableMigrationState.COMPLETED, "Completed", "csharp");
@@clientName(SyncTableMigrationState.ERROR, "Error", "csharp");
@@clientName(SyncTableMigrationState.FAILED, "Failed", "csharp");
@@clientName(SyncTableMigrationState.FULL_LOAD, "FullLoad", "csharp");

// --- Regular enum casing fixes ---
@@clientName(
  ServerLevelPermissionsGroup.MigrationFromMySQLToAzureDBForMySQL,
  "MigrationFromMySqlToAzureDBForMySql",
  "csharp"
);
@@clientName(
  ServerLevelPermissionsGroup.MigrationFromSqlServerToAzureVM,
  "MigrationFromSqlServerToAzureVm",
  "csharp"
);

// --- Operation param name override ---
@@clientName(
  DatabaseMigrationSqlDbs.cancel::parameters.body,
  "input",
  "csharp"
);
@@clientName(DatabaseMigrationSqlDbs.retry::parameters.body, "input", "csharp");
@@clientName(
  DatabaseMigrationSqlMis.cancel::parameters.body,
  "input",
  "csharp"
);
@@clientName(
  DatabaseMigrationSqlMis.cutover::parameters.body,
  "input",
  "csharp"
);
@@clientName(
  DatabaseMigrationSqlVms.cancel::parameters.body,
  "input",
  "csharp"
);
@@clientName(
  DatabaseMigrationSqlVms.cutover::parameters.body,
  "input",
  "csharp"
);
@@clientName(MigrateMISyncCompleteCommandProperties.input, "Input", "csharp");
@@clientName(MigrateMISyncCompleteCommandProperties.output, "Output", "csharp");
