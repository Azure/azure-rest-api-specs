import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataMigration;

/**
 * Migration Status
 */
union MongoMigrationStatus {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ResourceType {
  string,

  /**
   * SqlMi
   */
  SqlMi: "SqlMi",

  /**
   * SqlVm
   */
  SqlVm: "SqlVm",

  /**
   * SqlDb
   */
  SqlDb: "SqlDb",

  /**
   * MongoToCosmosDbMongo
   */
  MongoToCosmosDbMongo: "MongoToCosmosDbMongo",
}

/**
 * Provisioning State of migration. ProvisioningState as Succeeded implies that validations have been performed and migration has started.
 */
union ProvisioningState {
  string,

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union OperationOrigin {
  string,

  /**
   * user
   */
  user: "user",

  /**
   * system
   */
  system: "system",
}

/**
 * The scale type applicable to the SKU.
 */
union ResourceSkuCapacityScaleType {
  string,

  /**
   * Automatic
   */
  Automatic: "Automatic",

  /**
   * Manual
   */
  Manual: "Manual",

  /**
   * None
   */
  None: "None",
}

/**
 * The type of restrictions.
 */
union ResourceSkuRestrictionsType {
  string,

  /**
   * location
   */
  location: "location",
}

/**
 * The reason code for restriction.
 */
union ResourceSkuRestrictionsReasonCode {
  string,

  /**
   * QuotaId
   */
  QuotaId: "QuotaId",

  /**
   * NotAvailableForSubscription
   */
  NotAvailableForSubscription: "NotAvailableForSubscription",
}

/**
 * The resource's provisioning state
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ServiceProvisioningState {
  string,

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Deploying
   */
  Deploying: "Deploying",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Stopping
   */
  Stopping: "Stopping",

  /**
   * Starting
   */
  Starting: "Starting",

  /**
   * FailedToStart
   */
  FailedToStart: "FailedToStart",

  /**
   * FailedToStop
   */
  FailedToStop: "FailedToStop",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The scalability approach
 */
union ServiceScalability {
  string,

  /**
   * none
   */
  none: "none",

  /**
   * manual
   */
  manual: "manual",

  /**
   * automatic
   */
  automatic: "automatic",
}

/**
 * Task type.
 */
union TaskType {
  string,

  /**
   * Connect.MongoDb
   */
  `Connect.MongoDb`: "Connect.MongoDb",

  /**
   * ConnectToSource.SqlServer
   */
  `ConnectToSource.SqlServer`: "ConnectToSource.SqlServer",

  /**
   * ConnectToSource.SqlServer.Sync
   */
  `ConnectToSource.SqlServer.Sync`: "ConnectToSource.SqlServer.Sync",

  /**
   * ConnectToSource.PostgreSql.Sync
   */
  `ConnectToSource.PostgreSql.Sync`: "ConnectToSource.PostgreSql.Sync",

  /**
   * ConnectToSource.MySql
   */
  `ConnectToSource.MySql`: "ConnectToSource.MySql",

  /**
   * ConnectToSource.Oracle.Sync
   */
  `ConnectToSource.Oracle.Sync`: "ConnectToSource.Oracle.Sync",

  /**
   * ConnectToTarget.SqlDb
   */
  `ConnectToTarget.SqlDb`: "ConnectToTarget.SqlDb",

  /**
   * ConnectToTarget.SqlDb.Sync
   */
  `ConnectToTarget.SqlDb.Sync`: "ConnectToTarget.SqlDb.Sync",

  /**
   * ConnectToTarget.AzureDbForPostgreSql.Sync
   */
  `ConnectToTarget.AzureDbForPostgreSql.Sync`: "ConnectToTarget.AzureDbForPostgreSql.Sync",

  /**
   * ConnectToTarget.Oracle.AzureDbForPostgreSql.Sync
   */
  `ConnectToTarget.Oracle.AzureDbForPostgreSql.Sync`: "ConnectToTarget.Oracle.AzureDbForPostgreSql.Sync",

  /**
   * ConnectToTarget.AzureSqlDbMI
   */
  `ConnectToTarget.AzureSqlDbMI`: "ConnectToTarget.AzureSqlDbMI",

  /**
   * ConnectToTarget.AzureSqlDbMI.Sync.LRS
   */
  `ConnectToTarget.AzureSqlDbMI.Sync.LRS`: "ConnectToTarget.AzureSqlDbMI.Sync.LRS",

  /**
   * ConnectToTarget.AzureDbForMySql
   */
  `ConnectToTarget.AzureDbForMySql`: "ConnectToTarget.AzureDbForMySql",

  /**
   * GetUserTables.Sql
   */
  `GetUserTables.Sql`: "GetUserTables.Sql",

  /**
   * GetUserTables.AzureSqlDb.Sync
   */
  `GetUserTables.AzureSqlDb.Sync`: "GetUserTables.AzureSqlDb.Sync",

  /**
   * GetUserTablesOracle
   */
  GetUserTablesOracle: "GetUserTablesOracle",

  /**
   * GetUserTablesPostgreSql
   */
  GetUserTablesPostgreSql: "GetUserTablesPostgreSql",

  /**
   * GetUserTablesMySql
   */
  GetUserTablesMySql: "GetUserTablesMySql",

  /**
   * Migrate.MongoDb
   */
  `Migrate.MongoDb`: "Migrate.MongoDb",

  /**
   * Migrate.SqlServer.AzureSqlDbMI
   */
  `Migrate.SqlServer.AzureSqlDbMI`: "Migrate.SqlServer.AzureSqlDbMI",

  /**
   * Migrate.SqlServer.AzureSqlDbMI.Sync.LRS
   */
  `Migrate.SqlServer.AzureSqlDbMI.Sync.LRS`: "Migrate.SqlServer.AzureSqlDbMI.Sync.LRS",

  /**
   * Migrate.SqlServer.SqlDb
   */
  `Migrate.SqlServer.SqlDb`: "Migrate.SqlServer.SqlDb",

  /**
   * Migrate.SqlServer.AzureSqlDb.Sync
   */
  `Migrate.SqlServer.AzureSqlDb.Sync`: "Migrate.SqlServer.AzureSqlDb.Sync",

  /**
   * Migrate.MySql.AzureDbForMySql.Sync
   */
  `Migrate.MySql.AzureDbForMySql.Sync`: "Migrate.MySql.AzureDbForMySql.Sync",

  /**
   * Migrate.MySql.AzureDbForMySql
   */
  `Migrate.MySql.AzureDbForMySql`: "Migrate.MySql.AzureDbForMySql",

  /**
   * Migrate.PostgreSql.AzureDbForPostgreSql.SyncV2
   */
  `Migrate.PostgreSql.AzureDbForPostgreSql.SyncV2`: "Migrate.PostgreSql.AzureDbForPostgreSql.SyncV2",

  /**
   * Migrate.Oracle.AzureDbForPostgreSql.Sync
   */
  `Migrate.Oracle.AzureDbForPostgreSql.Sync`: "Migrate.Oracle.AzureDbForPostgreSql.Sync",

  /**
   * ValidateMigrationInput.SqlServer.SqlDb.Sync
   */
  `ValidateMigrationInput.SqlServer.SqlDb.Sync`: "ValidateMigrationInput.SqlServer.SqlDb.Sync",

  /**
   * ValidateMigrationInput.SqlServer.AzureSqlDbMI
   */
  `ValidateMigrationInput.SqlServer.AzureSqlDbMI`: "ValidateMigrationInput.SqlServer.AzureSqlDbMI",

  /**
   * ValidateMigrationInput.SqlServer.AzureSqlDbMI.Sync.LRS
   */
  `ValidateMigrationInput.SqlServer.AzureSqlDbMI.Sync.LRS`: "ValidateMigrationInput.SqlServer.AzureSqlDbMI.Sync.LRS",

  /**
   * Validate.MongoDb
   */
  `Validate.MongoDb`: "Validate.MongoDb",

  /**
   * Validate.Oracle.AzureDbPostgreSql.Sync
   */
  `Validate.Oracle.AzureDbPostgreSql.Sync`: "Validate.Oracle.AzureDbPostgreSql.Sync",

  /**
   * GetTDECertificates.Sql
   */
  `GetTDECertificates.Sql`: "GetTDECertificates.Sql",

  /**
   * Migrate.Ssis
   */
  `Migrate.Ssis`: "Migrate.Ssis",

  /**
   * Service.Check.OCI
   */
  `Service.Check.OCI`: "Service.Check.OCI",

  /**
   * Service.Upload.OCI
   */
  `Service.Upload.OCI`: "Service.Upload.OCI",

  /**
   * Service.Install.OCI
   */
  `Service.Install.OCI`: "Service.Install.OCI",

  /**
   * MigrateSchemaSqlServerSqlDb
   */
  MigrateSchemaSqlServerSqlDb: "MigrateSchemaSqlServerSqlDb",
}

/**
 * The state of the task. This is ignored if submitted.
 */
union TaskState {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Queued
   */
  Queued: "Queued",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * FailedInputValidation
   */
  FailedInputValidation: "FailedInputValidation",

  /**
   * Faulted
   */
  Faulted: "Faulted",
}

/**
 * Command type.
 */
union CommandType {
  string,

  /**
   * Migrate.Sync.Complete.Database
   */
  `Migrate.Sync.Complete.Database`: "Migrate.Sync.Complete.Database",

  /**
   * Migrate.SqlServer.AzureDbSqlMi.Complete
   */
  `Migrate.SqlServer.AzureDbSqlMi.Complete`: "Migrate.SqlServer.AzureDbSqlMi.Complete",

  /**
   * cancel
   */
  cancel: "cancel",

  /**
   * finish
   */
  finish: "finish",

  /**
   * restart
   */
  restart: "restart",
}

/**
 * The state of the command. This is ignored if submitted.
 */
union CommandState {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The reason why the name is not available, if nameAvailable is false
 */
union NameCheckFailureReason {
  string,

  /**
   * AlreadyExists
   */
  AlreadyExists: "AlreadyExists",

  /**
   * Invalid
   */
  Invalid: "Invalid",
}

/**
 * Source platform of the project
 */
union ProjectSourcePlatform {
  string,

  /**
   * SQL
   */
  SQL: "SQL",

  /**
   * MySQL
   */
  MySQL: "MySQL",

  /**
   * PostgreSql
   */
  PostgreSql: "PostgreSql",

  /**
   * MongoDb
   */
  MongoDb: "MongoDb",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * Target platform of the project
 */
union ProjectTargetPlatform {
  string,

  /**
   * SQLDB
   */
  SQLDB: "SQLDB",

  /**
   * SQLMI
   */
  SQLMI: "SQLMI",

  /**
   * AzureDbForMySql
   */
  AzureDbForMySql: "AzureDbForMySql",

  /**
   * AzureDbForPostgreSql
   */
  AzureDbForPostgreSql: "AzureDbForPostgreSql",

  /**
   * MongoDb
   */
  MongoDb: "MongoDb",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * The project's provisioning state
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ProjectProvisioningState {
  string,

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",
}

/**
 * An enumeration of possible authentication types when connecting
 */
union AuthenticationType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * WindowsAuthentication
   */
  WindowsAuthentication: "WindowsAuthentication",

  /**
   * SqlAuthentication
   */
  SqlAuthentication: "SqlAuthentication",

  /**
   * ActiveDirectoryIntegrated
   */
  ActiveDirectoryIntegrated: "ActiveDirectoryIntegrated",

  /**
   * ActiveDirectoryPassword
   */
  ActiveDirectoryPassword: "ActiveDirectoryPassword",
}

/**
 * An enumeration of source platform types
 */
union SqlSourcePlatform {
  string,

  /**
   * SqlOnPrem
   */
  SqlOnPrem: "SqlOnPrem",
}

/**
 * Enum of the different backup types.
 */
union BackupType {
  string,

  /**
   * Database
   */
  Database: "Database",

  /**
   * TransactionLog
   */
  TransactionLog: "TransactionLog",

  /**
   * File
   */
  File: "File",

  /**
   * DifferentialDatabase
   */
  DifferentialDatabase: "DifferentialDatabase",

  /**
   * DifferentialFile
   */
  DifferentialFile: "DifferentialFile",

  /**
   * Partial
   */
  Partial: "Partial",

  /**
   * DifferentialPartial
   */
  DifferentialPartial: "DifferentialPartial",
}

/**
 * An enumeration of Status of the log backup file.
 */
union BackupFileStatus {
  string,

  /**
   * Arrived
   */
  Arrived: "Arrived",

  /**
   * Queued
   */
  Queued: "Queued",

  /**
   * Uploading
   */
  Uploading: "Uploading",

  /**
   * Uploaded
   */
  Uploaded: "Uploaded",

  /**
   * Restoring
   */
  Restoring: "Restoring",

  /**
   * Restored
   */
  Restored: "Restored",

  /**
   * Cancelled
   */
  Cancelled: "Cancelled",
}

/**
 * An enumeration of possible target types when migrating from MySQL
 */
union MySqlTargetPlatformType {
  string,

  /**
   * SqlServer
   */
  SqlServer: "SqlServer",

  /**
   * AzureDbForMySQL
   */
  AzureDbForMySQL: "AzureDbForMySQL",
}

/**
 * An enumeration of SQL Server database file types
 */
union DatabaseFileType {
  string,

  /**
   * Rows
   */
  Rows: "Rows",

  /**
   * Log
   */
  Log: "Log",

  /**
   * Filestream
   */
  Filestream: "Filestream",

  /**
   * NotSupported
   */
  NotSupported: "NotSupported",

  /**
   * Fulltext
   */
  Fulltext: "Fulltext",
}

/**
 * An enumeration of SQL Server database compatibility levels
 */
union DatabaseCompatLevel {
  string,

  /**
   * CompatLevel80
   */
  CompatLevel80: "CompatLevel80",

  /**
   * CompatLevel90
   */
  CompatLevel90: "CompatLevel90",

  /**
   * CompatLevel100
   */
  CompatLevel100: "CompatLevel100",

  /**
   * CompatLevel110
   */
  CompatLevel110: "CompatLevel110",

  /**
   * CompatLevel120
   */
  CompatLevel120: "CompatLevel120",

  /**
   * CompatLevel130
   */
  CompatLevel130: "CompatLevel130",

  /**
   * CompatLevel140
   */
  CompatLevel140: "CompatLevel140",
}

/**
 * An enumeration of SQL Server Database states
 */
union DatabaseState {
  string,

  /**
   * Online
   */
  Online: "Online",

  /**
   * Restoring
   */
  Restoring: "Restoring",

  /**
   * Recovering
   */
  Recovering: "Recovering",

  /**
   * RecoveryPending
   */
  RecoveryPending: "RecoveryPending",

  /**
   * Suspect
   */
  Suspect: "Suspect",

  /**
   * Emergency
   */
  Emergency: "Emergency",

  /**
   * Offline
   */
  Offline: "Offline",

  /**
   * Copying
   */
  Copying: "Copying",

  /**
   * OfflineSecondary
   */
  OfflineSecondary: "OfflineSecondary",
}

/**
 * Enum mapping of SMO LoginType.
 */
union LoginType {
  string,

  /**
   * WindowsUser
   */
  WindowsUser: "WindowsUser",

  /**
   * WindowsGroup
   */
  WindowsGroup: "WindowsGroup",

  /**
   * SqlLogin
   */
  SqlLogin: "SqlLogin",

  /**
   * Certificate
   */
  Certificate: "Certificate",

  /**
   * AsymmetricKey
   */
  AsymmetricKey: "AsymmetricKey",

  /**
   * ExternalUser
   */
  ExternalUser: "ExternalUser",

  /**
   * ExternalGroup
   */
  ExternalGroup: "ExternalGroup",
}

/**
 * Option for how schema is extracted and applied to target
 */
union SchemaMigrationOption {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * ExtractFromSource
   */
  ExtractFromSource: "ExtractFromSource",

  /**
   * UseStorageFile
   */
  UseStorageFile: "UseStorageFile",
}

/**
 * Current state of migration
 */
union MigrationState {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Skipped
   */
  Skipped: "Skipped",

  /**
   * Stopped
   */
  Stopped: "Stopped",
}

/**
 * Current stage of schema migration
 */
union SchemaMigrationStage {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * ValidatingInputs
   */
  ValidatingInputs: "ValidatingInputs",

  /**
   * CollectingObjects
   */
  CollectingObjects: "CollectingObjects",

  /**
   * DownloadingScript
   */
  DownloadingScript: "DownloadingScript",

  /**
   * GeneratingScript
   */
  GeneratingScript: "GeneratingScript",

  /**
   * UploadingScript
   */
  UploadingScript: "UploadingScript",

  /**
   * DeployingSchema
   */
  DeployingSchema: "DeployingSchema",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * CompletedWithWarnings
   */
  CompletedWithWarnings: "CompletedWithWarnings",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Enum of the different state of database level online migration.
 */
union SyncDatabaseMigrationReportingState {
  string,

  /**
   * UNDEFINED
   */
  UNDEFINED: "UNDEFINED",

  /**
   * CONFIGURING
   */
  CONFIGURING: "CONFIGURING",

  /**
   * INITIALIAZING
   */
  INITIALIAZING: "INITIALIAZING",

  /**
   * STARTING
   */
  STARTING: "STARTING",

  /**
   * RUNNING
   */
  RUNNING: "RUNNING",

  /**
   * READY_TO_COMPLETE
   */
  READY_TO_COMPLETE: "READY_TO_COMPLETE",

  /**
   * COMPLETING
   */
  COMPLETING: "COMPLETING",

  /**
   * COMPLETE
   */
  COMPLETE: "COMPLETE",

  /**
   * CANCELLING
   */
  CANCELLING: "CANCELLING",

  /**
   * CANCELLED
   */
  CANCELLED: "CANCELLED",

  /**
   * FAILED
   */
  FAILED: "FAILED",

  /**
   * VALIDATING
   */
  VALIDATING: "VALIDATING",

  /**
   * VALIDATION_COMPLETE
   */
  VALIDATION_COMPLETE: "VALIDATION_COMPLETE",

  /**
   * VALIDATION_FAILED
   */
  VALIDATION_FAILED: "VALIDATION_FAILED",

  /**
   * RESTORE_IN_PROGRESS
   */
  RESTORE_IN_PROGRESS: "RESTORE_IN_PROGRESS",

  /**
   * RESTORE_COMPLETED
   */
  RESTORE_COMPLETED: "RESTORE_COMPLETED",

  /**
   * BACKUP_IN_PROGRESS
   */
  BACKUP_IN_PROGRESS: "BACKUP_IN_PROGRESS",

  /**
   * BACKUP_COMPLETED
   */
  BACKUP_COMPLETED: "BACKUP_COMPLETED",
}

/**
 * Enum of the different state of table level online migration.
 */
union SyncTableMigrationState {
  string,

  /**
   * BEFORE_LOAD
   */
  BEFORE_LOAD: "BEFORE_LOAD",

  /**
   * FULL_LOAD
   */
  FULL_LOAD: "FULL_LOAD",

  /**
   * COMPLETED
   */
  COMPLETED: "COMPLETED",

  /**
   * CANCELED
   */
  CANCELED: "CANCELED",

  /**
   * ERROR
   */
  ERROR: "ERROR",

  /**
   * FAILED
   */
  FAILED: "FAILED",
}

/**
 * An enumeration of source type
 */
union ScenarioSource {
  string,

  /**
   * Access
   */
  Access: "Access",

  /**
   * DB2
   */
  DB2: "DB2",

  /**
   * MySQL
   */
  MySQL: "MySQL",

  /**
   * Oracle
   */
  Oracle: "Oracle",

  /**
   * SQL
   */
  SQL: "SQL",

  /**
   * Sybase
   */
  Sybase: "Sybase",

  /**
   * PostgreSQL
   */
  PostgreSQL: "PostgreSQL",

  /**
   * MongoDB
   */
  MongoDB: "MongoDB",

  /**
   * SQLRDS
   */
  SQLRDS: "SQLRDS",

  /**
   * MySQLRDS
   */
  MySQLRDS: "MySQLRDS",

  /**
   * PostgreSQLRDS
   */
  PostgreSQLRDS: "PostgreSQLRDS",
}

/**
 * An enumeration of target type
 */
union ScenarioTarget {
  string,

  /**
   * SQLServer
   */
  SQLServer: "SQLServer",

  /**
   * SQLDB
   */
  SQLDB: "SQLDB",

  /**
   * SQLDW
   */
  SQLDW: "SQLDW",

  /**
   * SQLMI
   */
  SQLMI: "SQLMI",

  /**
   * AzureDBForMySql
   */
  AzureDBForMySql: "AzureDBForMySql",

  /**
   * AzureDBForPostgresSQL
   */
  AzureDBForPostgresSQL: "AzureDBForPostgresSQL",

  /**
   * MongoDB
   */
  MongoDB: "MongoDB",
}

/**
 * Wrapper for replicate reported migration states.
 */
union ReplicateMigrationState {
  string,

  /**
   * UNDEFINED
   */
  UNDEFINED: "UNDEFINED",

  /**
   * VALIDATING
   */
  VALIDATING: "VALIDATING",

  /**
   * PENDING
   */
  PENDING: "PENDING",

  /**
   * COMPLETE
   */
  COMPLETE: "COMPLETE",

  /**
   * ACTION_REQUIRED
   */
  ACTION_REQUIRED: "ACTION_REQUIRED",

  /**
   * FAILED
   */
  FAILED: "FAILED",
}

/**
 * Current status of migration
 */
union MigrationStatus {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * Connecting
   */
  Connecting: "Connecting",

  /**
   * SourceAndTargetSelected
   */
  SourceAndTargetSelected: "SourceAndTargetSelected",

  /**
   * SelectLogins
   */
  SelectLogins: "SelectLogins",

  /**
   * Configured
   */
  Configured: "Configured",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * CompletedWithWarnings
   */
  CompletedWithWarnings: "CompletedWithWarnings",
}

/**
 * Current status of the validation
 */
union ValidationStatus {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * Initialized
   */
  Initialized: "Initialized",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * CompletedWithIssues
   */
  CompletedWithIssues: "CompletedWithIssues",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Current stage of migration
 */
union DatabaseMigrationStage {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Initialize
   */
  Initialize: "Initialize",

  /**
   * Backup
   */
  Backup: "Backup",

  /**
   * FileCopy
   */
  FileCopy: "FileCopy",

  /**
   * Restore
   */
  Restore: "Restore",

  /**
   * Completed
   */
  Completed: "Completed",
}

/**
 * Severity of the validation error
 */
union Severity {
  string,

  /**
   * Message
   */
  Message: "Message",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Error
   */
  Error: "Error",
}

/**
 * An enumeration of type of objects
 */
union ObjectType {
  string,

  /**
   * StoredProcedures
   */
  StoredProcedures: "StoredProcedures",

  /**
   * Table
   */
  Table: "Table",

  /**
   * User
   */
  User: "User",

  /**
   * View
   */
  View: "View",

  /**
   * Function
   */
  Function: "Function",
}

/**
 * Type of the actual difference for the compared object, while performing schema comparison
 */
union UpdateActionType {
  string,

  /**
   * DeletedOnTarget
   */
  DeletedOnTarget: "DeletedOnTarget",

  /**
   * ChangedOnTarget
   */
  ChangedOnTarget: "ChangedOnTarget",

  /**
   * AddedOnTarget
   */
  AddedOnTarget: "AddedOnTarget",
}

/**
 * Database level migration state.
 */
union DatabaseMigrationState {
  string,

  /**
   * UNDEFINED
   */
  UNDEFINED: "UNDEFINED",

  /**
   * INITIAL
   */
  INITIAL: "INITIAL",

  /**
   * FULL_BACKUP_UPLOAD_START
   */
  FULL_BACKUP_UPLOAD_START: "FULL_BACKUP_UPLOAD_START",

  /**
   * LOG_SHIPPING_START
   */
  LOG_SHIPPING_START: "LOG_SHIPPING_START",

  /**
   * UPLOAD_LOG_FILES_START
   */
  UPLOAD_LOG_FILES_START: "UPLOAD_LOG_FILES_START",

  /**
   * CUTOVER_START
   */
  CUTOVER_START: "CUTOVER_START",

  /**
   * POST_CUTOVER_COMPLETE
   */
  POST_CUTOVER_COMPLETE: "POST_CUTOVER_COMPLETE",

  /**
   * COMPLETED
   */
  COMPLETED: "COMPLETED",

  /**
   * CANCELLED
   */
  CANCELLED: "CANCELLED",

  /**
   * FAILED
   */
  FAILED: "FAILED",
}

/**
 * An enumeration of backup modes
 */
union BackupMode {
  string,

  /**
   * CreateBackup
   */
  CreateBackup: "CreateBackup",

  /**
   * ExistingBackup
   */
  ExistingBackup: "ExistingBackup",
}

/**
 * Enum of the different stage of login migration.
 */
union LoginMigrationStage {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Initialize
   */
  Initialize: "Initialize",

  /**
   * LoginMigration
   */
  LoginMigration: "LoginMigration",

  /**
   * EstablishUserMapping
   */
  EstablishUserMapping: "EstablishUserMapping",

  /**
   * AssignRoleMembership
   */
  AssignRoleMembership: "AssignRoleMembership",

  /**
   * AssignRoleOwnership
   */
  AssignRoleOwnership: "AssignRoleOwnership",

  /**
   * EstablishServerPermissions
   */
  EstablishServerPermissions: "EstablishServerPermissions",

  /**
   * EstablishObjectPermissions
   */
  EstablishObjectPermissions: "EstablishObjectPermissions",

  /**
   * Completed
   */
  Completed: "Completed",
}

/**
 * An enumeration of supported source SSIS store type in DMS (classic)
 */
union SsisStoreType {
  string,

  /**
   * SsisCatalog
   */
  SsisCatalog: "SsisCatalog",
}

/**
 * The overwrite option for SSIS object migration, only ignore and overwrite are supported in DMS (classic) now and future may add Reuse option for container object
 */
union SsisMigrationOverwriteOption {
  string,

  /**
   * Ignore
   */
  Ignore: "Ignore",

  /**
   * Overwrite
   */
  Overwrite: "Overwrite",
}

/**
 * Current stage of SSIS migration
 */
union SsisMigrationStage {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Initialize
   */
  Initialize: "Initialize",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Completed
   */
  Completed: "Completed",
}

/**
 * The field ordering
 */
union MongoDbShardKeyOrder {
  string,

  /**
   * Forward
   */
  Forward: "Forward",

  /**
   * Reverse
   */
  Reverse: "Reverse",

  /**
   * Hashed
   */
  Hashed: "Hashed",
}

/**
 * The type of data source
 */
union MongoDbClusterType {
  string,

  /**
   * BlobContainer
   */
  BlobContainer: "BlobContainer",

  /**
   * CosmosDb
   */
  CosmosDb: "CosmosDb",

  /**
   * MongoDb
   */
  MongoDb: "MongoDb",
}

/**
 * The type of error or warning
 */
union MongoDbErrorType {
  string,

  /**
   * Error
   */
  Error: "Error",

  /**
   * ValidationError
   */
  ValidationError: "ValidationError",

  /**
   * Warning
   */
  Warning: "Warning",
}

/**
 * The type of progress object
 */
union MongoDbProgressResultType {
  string,

  /**
   * Migration
   */
  Migration: "Migration",

  /**
   * Database
   */
  Database: "Database",

  /**
   * Collection
   */
  Collection: "Collection",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union MongoDbMigrationState {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * ValidatingInput
   */
  ValidatingInput: "ValidatingInput",

  /**
   * Initializing
   */
  Initializing: "Initializing",

  /**
   * Restarting
   */
  Restarting: "Restarting",

  /**
   * Copying
   */
  Copying: "Copying",

  /**
   * InitialReplay
   */
  InitialReplay: "InitialReplay",

  /**
   * Replaying
   */
  Replaying: "Replaying",

  /**
   * Finalizing
   */
  Finalizing: "Finalizing",

  /**
   * Complete
   */
  Complete: "Complete",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Describes how changes will be replicated from the source to the target. The default is OneTime.
 */
union MongoDbReplication {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * OneTime
   */
  OneTime: "OneTime",

  /**
   * Continuous
   */
  Continuous: "Continuous",
}

/**
 * Result code of the data migration
 */
union DataMigrationResultCode {
  string,

  /**
   * Initial
   */
  Initial: "Initial",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * ObjectNotExistsInSource
   */
  ObjectNotExistsInSource: "ObjectNotExistsInSource",

  /**
   * ObjectNotExistsInTarget
   */
  ObjectNotExistsInTarget: "ObjectNotExistsInTarget",

  /**
   * TargetObjectIsInaccessible
   */
  TargetObjectIsInaccessible: "TargetObjectIsInaccessible",

  /**
   * FatalError
   */
  FatalError: "FatalError",
}

/**
 * Error type
 */
union ErrorType {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Error
   */
  Error: "Error",
}

/**
 * Authentication type used for accessing Azure Blob Storage.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AuthType {
  /**
   * Use an account key for authentication.
   */
  AccountKey,

  /**
   * Use a managed identity for authentication.
   */
  ManagedIdentity,
}

/**
 * Permission group for validations. These groups will run a set of permissions for validating user activity. Select the permission group for the activity that you are performing.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ServerLevelPermissionsGroup {
  /**
   * Default
   */
  Default,

  /**
   * MigrationFromSqlServerToAzureDB
   */
  MigrationFromSqlServerToAzureDB,

  /**
   * MigrationFromSqlServerToAzureMI
   */
  MigrationFromSqlServerToAzureMI,

  /**
   * MigrationFromMySQLToAzureDBForMySQL
   */
  MigrationFromMySQLToAzureDBForMySQL,

  /**
   * MigrationFromSqlServerToAzureVM
   */
  MigrationFromSqlServerToAzureVM,
}

/**
 * Database Migration Resource properties for CosmosDb for Mongo.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseMigrationPropertiesCosmosDbMongo
  extends DatabaseMigrationBaseProperties {
  /**
   * Source Mongo connection details.
   */
  sourceMongoConnection?: MongoConnectionInformation;

  /**
   * Target Cosmos DB Mongo connection details.
   */
  targetMongoConnection?: MongoConnectionInformation;

  /**
   * List of Mongo Collections to be migrated.
   */
  @identifiers(#[])
  collectionList?: MongoMigrationCollection[];

  kind: "MongoToCosmosDbMongo";
}

/**
 * Mongo Connection
 */
model MongoConnectionInformation {
  /**
   * Host of mongo connection.
   */
  host?: string;

  /**
   * Port of mongo connection.
   */
  port?: int32;

  /**
   * User name to connect to Mongo.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  userName?: string;

  /**
   * Password to connect to Mongo.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  password?: string;

  /**
   * Whether to UseSsl or UseTls to connect to Mongo. Default is true.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  useSsl?: boolean;

  /**
   * ConnectionString to connect to Mongo.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  connectionString?: string;
}

/**
 * Mongo source and target database and collection details.
 */
model MongoMigrationCollection {
  /**
   * Source database name.
   */
  sourceDatabase?: string;

  /**
   * Source collection name.
   */
  sourceCollection?: string;

  /**
   * Target database name.
   */
  targetDatabase?: string;

  /**
   * Target collection name.
   */
  targetCollection?: string;

  /**
   * Detailed migration status. Not included by default.
   */
  @visibility(Lifecycle.Read)
  migrationProgressDetails?: MongoMigrationProgressDetails;
}

/**
 * Detailed status of collection migration.
 */
model MongoMigrationProgressDetails {
  /**
   * Migration Status
   */
  @visibility(Lifecycle.Read)
  migrationStatus?: MongoMigrationStatus;

  /**
   * Migration Error
   */
  @visibility(Lifecycle.Read)
  migrationError?: string;

  /**
   * Source Document Count
   */
  @visibility(Lifecycle.Read)
  sourceDocumentCount?: int64;

  /**
   * Processed Document Count
   */
  @visibility(Lifecycle.Read)
  processedDocumentCount?: int64;

  /**
   * Migration duration
   */
  @visibility(Lifecycle.Read)
  durationInSeconds?: int32;
}

/**
 * Database Migration Base Resource properties.
 */
@discriminator("kind")
model DatabaseMigrationBaseProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind: ResourceType;

  /**
   * Resource Id of the target resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  scope?: string;

  /**
   * Provisioning State of migration. ProvisioningState as Succeeded implies that validations have been performed and migration has started.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Migration status.
   */
  @visibility(Lifecycle.Read)
  migrationStatus?: string;

  /**
   * Database migration start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Database migration end time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Resource Id of the Migration Service.
   */
  migrationService?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DataMigration/migrationServices";
    },
    {
      type: "Microsoft.DataMigration/sqlMigrationServices";
    }
  ]>;

  /**
   * ID for current migration operation.
   */
  migrationOperationId?: string;

  /**
   * Error details in case of migration failure.
   */
  @visibility(Lifecycle.Read)
  migrationFailureError?: ErrorInfo;

  /**
   * Error message for migration provisioning failure, if any.
   */
  provisioningError?: string;
}

/**
 * Error details
 */
model ErrorInfo {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Database Migration Resource properties for SQL database.
 */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseMigrationPropertiesSqlDb extends DatabaseMigrationProperties {
  /**
   * Detailed migration status. Not included by default.
   */
  @visibility(Lifecycle.Read)
  migrationStatusDetails?: SqlDbMigrationStatusDetails;

  /**
   * Target SQL DB connection details.
   */
  targetSqlConnection?: SqlConnectionInformation;

  /**
   * Offline configuration.
   */
  @visibility(Lifecycle.Read)
  offlineConfiguration?: SqlDbOfflineConfiguration;

  /**
   * List of tables to copy.
   */
  tableList?: string[];

  kind: "SqlDb";
}

/**
 * Detailed status of current Sql Db migration.
 */
model SqlDbMigrationStatusDetails {
  /**
   * Current State of Migration.
   */
  @visibility(Lifecycle.Read)
  migrationState?: string;

  /**
   * Sql Data Copy errors, if any.
   */
  @visibility(Lifecycle.Read)
  sqlDataCopyErrors?: string[];

  /**
   * Details on progress of ADF copy activities.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  listOfCopyProgressDetails?: CopyProgressDetails[];
}

/**
 * Details on progress of ADF copy activity
 */
model CopyProgressDetails {
  /**
   * Table Name
   */
  @visibility(Lifecycle.Read)
  tableName?: string;

  /**
   * Status of the Copy activity (InProgress, Succeeded, Failed, Canceled).
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Type of parallel copy (Dynamic range, Physical partition, none).
   */
  @visibility(Lifecycle.Read)
  parallelCopyType?: string;

  /**
   * The degree of parallelization.
   */
  @visibility(Lifecycle.Read)
  usedParallelCopies?: int32;

  /**
   * Bytes read
   */
  @visibility(Lifecycle.Read)
  dataRead?: int64;

  /**
   * Bytes written
   */
  @visibility(Lifecycle.Read)
  dataWritten?: int64;

  /**
   * Rows read
   */
  @visibility(Lifecycle.Read)
  rowsRead?: int64;

  /**
   * Rows Copied
   */
  @visibility(Lifecycle.Read)
  rowsCopied?: int64;

  /**
   * Copy Start
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  copyStart?: utcDateTime;

  /**
   * Copy throughput in KBps
   */
  @visibility(Lifecycle.Read)
  copyThroughput?: float64;

  /**
   * Copy Duration in seconds
   */
  @visibility(Lifecycle.Read)
  copyDuration?: int32;
}

/**
 * Source SQL Connection
 */
model SqlConnectionInformation {
  /**
   * Data source.
   */
  dataSource?: string;

  /**
   * Authentication type.
   */
  authentication?: string;

  /**
   * User name to connect to source SQL.
   */
  userName?: string;

  /**
   * Password to connect to source SQL.
   */
  @secret
  password?: string;

  /**
   * Whether to encrypt connection or not.
   */
  encryptConnection?: boolean;

  /**
   * Whether to trust server certificate or not.
   */
  trustServerCertificate?: boolean;
}

/**
 * Offline configuration
 */
model SqlDbOfflineConfiguration {
  /**
   * Offline migration
   */
  @visibility(Lifecycle.Read)
  offline?: boolean;
}

/**
 * Database Migration Resource properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("kind")
model DatabaseMigrationProperties extends DatabaseMigrationBaseProperties {
  /**
   * Source SQL Server connection details.
   */
  sourceSqlConnection?: SqlConnectionInformation;

  /**
   * Name of the source database.
   */
  sourceDatabaseName?: string;

  /**
   * Name of the source sql server.
   */
  @visibility(Lifecycle.Read)
  sourceServerName?: string;

  /**
   * Database collation to be used for the target database.
   */
  targetDatabaseCollation?: string;

  /**
   * Optional property - Resource Id for the source Sql server instance. Validations are performed on this property to ensure that it follows the correct format.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sqlServerInstanceId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalProxyResource {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  id?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  name?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Migration Operation Input
 */
model MigrationOperationInput {
  /**
   * ID tracking migration operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  migrationOperationId?: string;
}

/**
 * Database Migration Resource properties for SQL Managed Instance.
 */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseMigrationPropertiesSqlMi extends DatabaseMigrationProperties {
  /**
   * Detailed migration status. Not included by default.
   */
  @visibility(Lifecycle.Read)
  migrationStatusDetails?: MigrationStatusDetails;

  /**
   * Backup configuration info.
   */
  backupConfiguration?: BackupConfiguration;

  /**
   * Offline configuration.
   */
  offlineConfiguration?: OfflineConfiguration;

  kind: "SqlMi";
}

/**
 * Detailed status of current migration.
 */
model MigrationStatusDetails {
  /**
   * Current State of Migration.
   */
  @visibility(Lifecycle.Read)
  migrationState?: string;

  /**
   * Details of full backup set.
   */
  @visibility(Lifecycle.Read)
  fullBackupSetInfo?: SqlBackupSetInfo;

  /**
   * Last applied backup set information.
   */
  @visibility(Lifecycle.Read)
  lastRestoredBackupSetInfo?: SqlBackupSetInfo;

  /**
   * Backup sets that are currently active.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  activeBackupSets?: SqlBackupSetInfo[];

  /**
   * Files that are not valid backup files.
   */
  @visibility(Lifecycle.Read)
  invalidFiles?: string[];

  /**
   * Name of blob container.
   */
  @visibility(Lifecycle.Read)
  blobContainerName?: string;

  /**
   * Whether full backup has been applied to the target database or not.
   */
  @visibility(Lifecycle.Read)
  isFullBackupRestored?: boolean;

  /**
   * Restore blocking reason, if any
   */
  @visibility(Lifecycle.Read)
  restoreBlockingReason?: string;

  /**
   * Complete restore error message, if any
   */
  @visibility(Lifecycle.Read)
  completeRestoreErrorMessage?: string;

  /**
   * File upload blocking errors, if any.
   */
  @visibility(Lifecycle.Read)
  fileUploadBlockingErrors?: string[];

  /**
   * File name that is currently being restored.
   */
  @visibility(Lifecycle.Read)
  currentRestoringFilename?: string;

  /**
   * Last restored file name.
   */
  @visibility(Lifecycle.Read)
  lastRestoredFilename?: string;

  /**
   * Total pending log backups.
   */
  @visibility(Lifecycle.Read)
  pendingLogBackupsCount?: int32;
}

/**
 * Information of backup set
 */
model SqlBackupSetInfo {
  /**
   * Backup set id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @format("uuid")
  backupSetId?: string;

  /**
   * First LSN of the backup set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  firstLSN?: string;

  /**
   * Last LSN of the backup set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  lastLSN?: string;

  /**
   * Backup type.
   */
  @visibility(Lifecycle.Read)
  backupType?: string;

  /**
   * List of files in the backup set.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  listOfBackupFiles?: SqlBackupFileInfo[];

  /**
   * Backup start date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupStartDate?: utcDateTime;

  /**
   * Backup end time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupFinishDate?: utcDateTime;

  /**
   * Whether this backup set has been restored or not.
   */
  @visibility(Lifecycle.Read)
  isBackupRestored?: boolean;

  /**
   * Has Backup Checksums
   */
  @visibility(Lifecycle.Read)
  hasBackupChecksums?: boolean;

  /**
   * Media family count
   */
  @visibility(Lifecycle.Read)
  familyCount?: int32;

  /**
   * The reasons why the backup set is ignored
   */
  @visibility(Lifecycle.Read)
  ignoreReasons?: string[];
}

/**
 * Information of backup file
 */
model SqlBackupFileInfo {
  /**
   * File name.
   */
  @visibility(Lifecycle.Read)
  fileName?: string;

  /**
   * Status of the file. (Initial, Uploading, Uploaded, Restoring, Restored or Skipped)
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * File size in bytes
   */
  @visibility(Lifecycle.Read)
  totalSize?: int64;

  /**
   * Bytes read
   */
  @visibility(Lifecycle.Read)
  dataRead?: int64;

  /**
   * Bytes written
   */
  @visibility(Lifecycle.Read)
  dataWritten?: int64;

  /**
   * Copy throughput in KBps
   */
  @visibility(Lifecycle.Read)
  copyThroughput?: float64;

  /**
   * Copy Duration in seconds
   */
  @visibility(Lifecycle.Read)
  copyDuration?: int32;

  /**
   * Media family sequence number
   */
  @visibility(Lifecycle.Read)
  familySequenceNumber?: int32;
}

/**
 * Backup Configuration
 */
model BackupConfiguration {
  /**
   * Source location of backups.
   */
  sourceLocation?: SourceLocation;

  /**
   * Target location for copying backups.
   */
  targetLocation?: TargetLocation;
}

/**
 * Source Location details of backups.
 */
model SourceLocation {
  /**
   * Source File share.
   */
  fileShare?: SqlFileShare;

  /**
   * Source Azure Blob.
   */
  azureBlob?: AzureBlob;

  /**
   * Backup storage Type.
   */
  @visibility(Lifecycle.Read)
  fileStorageType?: string;
}

/**
 * File share
 */
model SqlFileShare {
  /**
   * Location as SMB share or local drive where backups are placed.
   */
  path?: string;

  /**
   * Username to access the file share location for backups.
   */
  username?: string;

  /**
   * Password for username to access file share location.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  password?: string;
}

/**
 * Azure Blob Details
 */
model AzureBlob {
  /**
   * Authentication type used for accessing Azure Blob Storage.
   */
  authType?: AuthType;

  /**
   * Identity details for authentication using a Managed Identity.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * Resource Id of the storage account where backups are stored.
   */
  storageAccountResourceId?: string;

  /**
   * Storage Account Key.
   */
  @secret
  accountKey?: string;

  /**
   * Blob container name where backups are stored.
   */
  blobContainerName?: string;
}

/**
 * Target Location details for optional copy of backups
 */
model TargetLocation {
  /**
   * Resource Id of the storage account copying backups.
   */
  storageAccountResourceId?: string;

  /**
   * Storage Account Key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accountKey?: string;
}

/**
 * Offline configuration
 */
model OfflineConfiguration {
  /**
   * Offline migration
   */
  offline?: boolean;

  /**
   * Last backup name for offline migration. This is optional for migrations from file share. If it is not provided, then the service will determine the last backup file name based on latest backup files present in file share.
   */
  lastBackupName?: string;
}

/**
 * Database Migration Resource properties for SQL Virtual Machine.
 */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseMigrationPropertiesSqlVm extends DatabaseMigrationProperties {
  /**
   * Detailed migration status. Not included by default.
   */
  @visibility(Lifecycle.Read)
  migrationStatusDetails?: MigrationStatusDetails;

  /**
   * Backup configuration info.
   */
  backupConfiguration?: BackupConfiguration;

  /**
   * Offline configuration.
   */
  offlineConfiguration?: OfflineConfiguration;

  kind: "SqlVm";
}

model OperationListResult is Azure.Core.Page<OperationsDefinition>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OperationsDefinition {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  display?: OperationsDisplayDefinition;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  origin?: OperationOrigin;

  /**
   * Dictionary of <AnyObject>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  properties?: Record<unknown>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OperationsDisplayDefinition {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provider?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  resource?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  operation?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * The Migration Service properties.
 */
model MigrationServiceProperties {
  /**
   * Provisioning state to track the async operation status.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Current state of the Integration runtime.
   */
  @visibility(Lifecycle.Read)
  integrationRuntimeState?: string;
}

/**
 * An update to a Migration Service.
 */
model MigrationServiceUpdate {
  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Database Migration Resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseMigrationBase
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Database Migration Base Resource properties.
   */
  properties?: DatabaseMigrationBaseProperties;
}

/**
 * The SQL Migration Service properties.
 */
model SqlMigrationServiceProperties {
  /**
   * Provisioning state to track the async operation status.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Current state of the Integration runtime.
   */
  @visibility(Lifecycle.Read)
  integrationRuntimeState?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalTrackedResource {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  id?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  name?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  type?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * An update to a SQL Migration Service.
 */
model SqlMigrationServiceUpdate {
  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * The response of a MigrationService list operation.
 */
model MigrationServiceListResult is Azure.Core.Page<MigrationService>;

/**
 * The response of a DatabaseMigrationBase list operation.
 */
model DatabaseMigrationBaseListResult is Azure.Core.Page<DatabaseMigrationBase>;

/**
 * The response of a DatabaseMigrationCosmosDbMongo list operation.
 */
model DatabaseMigrationCosmosDbMongoListResult
  is Azure.Core.Page<DatabaseMigrationCosmosDbMongo>;

/**
 * The response of a DatabaseMigration list operation.
 */
model DatabaseMigrationListResult is Azure.Core.Page<DatabaseMigration>;

/**
 * A list of SQL Migration Service.
 */
model SqlMigrationListResult is Azure.Core.Page<SqlMigrationService>;

@@visibility(OperationListResult.value, Lifecycle.Read);
@@visibility(MigrationServiceListResult.value, Lifecycle.Read);
@@visibility(DatabaseMigrationBaseListResult.value, Lifecycle.Read);
@@visibility(DatabaseMigrationCosmosDbMongoListResult.value, Lifecycle.Read);
@@visibility(DatabaseMigrationListResult.value, Lifecycle.Read);
@@visibility(SqlMigrationListResult.value, Lifecycle.Read);

/**
 * An authentication key.
 */
model AuthenticationKeys {
  /**
   * The first authentication key.
   */
  @secret
  @visibility(Lifecycle.Read, Lifecycle.Create)
  authKey1?: string;

  /**
   * The second authentication key.
   */
  @secret
  @visibility(Lifecycle.Read, Lifecycle.Create)
  authKey2?: string;
}

/**
 * An authentication key to regenerate.
 */
model RegenAuthKeys {
  /**
   * The name of authentication key to generate.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  keyName?: string;

  /**
   * The first authentication key.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @secret
  authKey1?: string;

  /**
   * The second authentication key.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @secret
  authKey2?: string;
}

/**
 * Details of node to be deleted.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model deleteNode {
  /**
   * The name of node to delete.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  nodeName?: string;

  /**
   * The name of integration runtime.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  integrationRuntimeName?: string;
}

/**
 * Database Migration Resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseMigration
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Database Migration Resource properties.
   */
  properties?: DatabaseMigrationProperties;
}

/**
 * Integration Runtime Monitoring Data.
 */
model IntegrationRuntimeMonitoringData {
  /**
   * The name of Integration Runtime.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Integration Runtime node monitoring data.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  nodes?: NodeMonitoringData[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NodeMonitoringData {
  /**
   *  Unmatched properties from the message are deserialized in this collection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  additionalProperties?: Record<unknown>;

  /**
   * Name of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  nodeName?: string;

  /**
   * Available memory (MB) on the integration runtime node.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  availableMemoryInMB?: int32;

  /**
   * CPU percentage on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  cpuUtilization?: int32;

  /**
   * Maximum concurrent jobs on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  concurrentJobsLimit?: int32;

  /**
   * The number of jobs currently running on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  concurrentJobsRunning?: int32;

  /**
   * The maximum concurrent jobs in this integration runtime.
   */
  @visibility(Lifecycle.Read)
  maxConcurrentJobs?: int32;

  /**
   * Sent bytes on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  sentBytes?: float64;

  /**
   * Received bytes on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  receivedBytes?: float64;
}

/**
 * The DMS (classic) List SKUs operation response.
 */
model ResourceSkusResult is Azure.Core.Page<ResourceSku>;

/**
 * Describes an available DMS (classic) SKU.
 */
model ResourceSku {
  /**
   * The type of resource the SKU applies to.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The name of SKU.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Specifies the tier of DMS (classic) in a scale set.
   */
  @visibility(Lifecycle.Read)
  tier?: string;

  /**
   * The Size of the SKU.
   */
  @visibility(Lifecycle.Read)
  size?: string;

  /**
   * The Family of this particular SKU.
   */
  @visibility(Lifecycle.Read)
  family?: string;

  /**
   * The Kind of resources that are supported in this SKU.
   */
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * Not used.
   */
  @visibility(Lifecycle.Read)
  capacity?: ResourceSkuCapacity;

  /**
   * The set of locations that the SKU is available.
   */
  @visibility(Lifecycle.Read)
  locations?: string[];

  /**
   * The api versions that support this SKU.
   */
  @visibility(Lifecycle.Read)
  apiVersions?: string[];

  /**
   * Metadata for retrieving price info.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  costs?: ResourceSkuCosts[];

  /**
   * A name value pair to describe the capability.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  capabilities?: ResourceSkuCapabilities[];

  /**
   * The restrictions because of which SKU cannot be used. This is empty if there are no restrictions.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  restrictions?: ResourceSkuRestrictions[];
}

/**
 * Describes scaling information of a SKU.
 */
model ResourceSkuCapacity {
  /**
   * The minimum capacity.
   */
  @visibility(Lifecycle.Read)
  minimum?: int64;

  /**
   * The maximum capacity.
   */
  @visibility(Lifecycle.Read)
  maximum?: int64;

  /**
   * The default capacity.
   */
  @visibility(Lifecycle.Read)
  default?: int64;

  /**
   * The scale type applicable to the SKU.
   */
  @visibility(Lifecycle.Read)
  scaleType?: ResourceSkuCapacityScaleType;
}

/**
 * Describes metadata for retrieving price info.
 */
model ResourceSkuCosts {
  /**
   * Used for querying price from commerce.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  meterID?: string;

  /**
   * The multiplier is needed to extend the base metered cost.
   */
  @visibility(Lifecycle.Read)
  quantity?: int64;

  /**
   * An invariant to show the extended unit.
   */
  @visibility(Lifecycle.Read)
  extendedUnit?: string;
}

/**
 * Describes The SKU capabilities object.
 */
model ResourceSkuCapabilities {
  /**
   * An invariant to describe the feature.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * An invariant if the feature is measured by quantity.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * Describes scaling information of a SKU.
 */
model ResourceSkuRestrictions {
  /**
   * The type of restrictions.
   */
  @visibility(Lifecycle.Read)
  type?: ResourceSkuRestrictionsType;

  /**
   * The value of restrictions. If the restriction type is set to location. This would be different locations where the SKU is restricted.
   */
  @visibility(Lifecycle.Read)
  values?: string[];

  /**
   * The reason code for restriction.
   */
  @visibility(Lifecycle.Read)
  reasonCode?: ResourceSkuRestrictionsReasonCode;
}

/**
 * Error information.
 */
@error
model ApiError {
  /**
   * Error information in OData format
   */
  error?: ODataError;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Error information in OData format.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ODataError {
  /**
   * The machine-readable description of the error, such as 'InvalidRequest' or 'InternalServerError'
   */
  code?: string;

  /**
   * The human-readable description of the error
   */
  message?: string;

  /**
   * Inner errors that caused this error
   */
  @identifiers(#[])
  details?: ODataError[];
}

/**
 * Properties of the Azure Database Migration Service (classic) instance
 */
model DataMigrationServiceProperties {
  /**
   * The resource's provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ServiceProvisioningState;

  /**
   * The public key of the service, used to encrypt secrets sent to the service
   */
  publicKey?: string;

  /**
   * The ID of the Microsoft.Network/virtualNetworks/subnets resource to which the service should be joined
   */
  virtualSubnetId?: string;

  /**
   * The ID of the Microsoft.Network/networkInterfaces resource which the service have
   */
  virtualNicId?: string;

  /**
   * The time delay before the service is auto-stopped when idle.
   */
  autoStopDelay?: string;

  /**
   * Whether service resources should be deleted when stopped. (Turned on by default)
   */
  deleteResourcesOnStop?: boolean;
}

/**
 * An Azure SKU instance
 */
model ServiceSku {
  /**
   * The unique name of the SKU, such as 'P3'
   */
  name?: string;

  /**
   * The tier of the SKU, such as 'Basic', 'General Purpose', or 'Business Critical'
   */
  tier?: string;

  /**
   * The SKU family, used when the service has multiple performance classes within a tier, such as 'A', 'D', etc. for virtual machines
   */
  family?: string;

  /**
   * The size of the SKU, used when the name alone does not denote a service size or when a SKU has multiple performance classes within a family, e.g. 'A1' for virtual machines
   */
  size?: string;

  /**
   * The capacity of the SKU, if it supports scaling
   */
  capacity?: int32;
}

/**
 * Service health status
 */
model DataMigrationServiceStatusResponse {
  /**
   * The DMS instance agent version
   */
  agentVersion?: string;

  /**
   * Agent Configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  agentConfiguration?: unknown;

  /**
   * The machine-readable status, such as 'Initializing', 'Offline', 'Online', 'Deploying', 'Deleting', 'Stopped', 'Stopping', 'Starting', 'FailedToStart', 'FailedToStop' or 'Failed'
   */
  status?: string;

  /**
   * The services virtual machine size, such as 'Standard_D2_v2'
   */
  vmSize?: string;

  /**
   * The list of supported task types
   */
  supportedTaskTypes?: string[];
}

/**
 * OData page of available SKUs
 */
model ServiceSkuList is Azure.Core.Page<AvailableServiceSku>;

/**
 * Describes the available service SKU.
 */
model AvailableServiceSku {
  /**
   * The resource type, including the provider namespace
   */
  resourceType?: string;

  /**
   * SKU name, tier, etc.
   */
  sku?: AvailableServiceSkuSku;

  /**
   * A description of the scaling capacities of the SKU
   */
  capacity?: AvailableServiceSkuCapacity;
}

/**
 * SKU name, tier, etc.
 */
model AvailableServiceSkuSku {
  /**
   * The name of the SKU
   */
  name?: string;

  /**
   * SKU family
   */
  family?: string;

  /**
   * SKU size
   */
  size?: string;

  /**
   * The tier of the SKU, such as "Basic", "General Purpose", or "Business Critical"
   */
  tier?: string;
}

/**
 * A description of the scaling capacities of the SKU
 */
model AvailableServiceSkuCapacity {
  /**
   * The minimum capacity, usually 0 or 1.
   */
  minimum?: int32;

  /**
   * The maximum capacity
   */
  maximum?: int32;

  /**
   * The default capacity
   */
  default?: int32;

  /**
   * The scalability approach
   */
  scaleType?: ServiceScalability;
}

/**
 * OData page of tasks
 */
model TaskList is Azure.Core.Page<ProjectTask>;

/**
 * Base class for all types of DMS (classic) task properties. If task is not supported by current client, this object is returned.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("taskType")
model ProjectTaskProperties {
  /**
   * Task type.
   */
  taskType: TaskType;

  /**
   * Array of errors. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: ODataError[];

  /**
   * The state of the task. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  state?: TaskState;

  /**
   * Array of command properties.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  commands?: CommandProperties[];

  /**
   * Key value pairs of client data to attach meta data information to task
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientData?: Record<string>;
}

/**
 * Base class for all types of DMS (classic) command properties. If command is not supported by current client, this object is returned.
 */
@discriminator("commandType")
model CommandProperties {
  /**
   * Command type.
   */
  commandType: CommandType;

  /**
   * Array of errors. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: ODataError[];

  /**
   * The state of the command. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  state?: CommandState;
}

/**
 * ARM resource.
 */
model LocalResource {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * A resource type and proposed name
 */
model NameAvailabilityRequest {
  /**
   * The proposed resource name
   */
  name?: string;

  /**
   * The resource type chain (e.g. virtualMachines/extensions)
   */
  type?: string;
}

/**
 * Indicates whether a proposed resource name is available
 */
model NameAvailabilityResponse {
  /**
   * If true, the name is valid and available. If false, 'reason' describes why not.
   */
  nameAvailable?: boolean;

  /**
   * The reason why the name is not available, if nameAvailable is false
   */
  reason?: NameCheckFailureReason;

  /**
   * The localized reason why the name is not available, if nameAvailable is false
   */
  message?: string;
}

/**
 * OData page of service objects
 */
model DataMigrationServiceList is Azure.Core.Page<DataMigrationService>;

/**
 * OData page of project resources
 */
model ProjectList is Azure.Core.Page<Project>;

/**
 * Project-specific properties
 */
model ProjectProperties {
  /**
   * Source platform for the project
   */
  sourcePlatform: ProjectSourcePlatform;

  /**
   * Field that defines the Azure active directory application info, used to connect to the target Azure resource
   */
  azureAuthenticationInfo?: AzureActiveDirectoryApp;

  /**
   * Target platform for the project
   */
  targetPlatform: ProjectTargetPlatform;

  /**
   * UTC Date and time when project was created
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Information for connecting to source
   */
  sourceConnectionInfo?: ConnectionInfo;

  /**
   * Information for connecting to target
   */
  targetConnectionInfo?: ConnectionInfo;

  /**
   * List of DatabaseInfo
   */
  @identifiers(#[])
  databasesInfo?: DatabaseInfo[];

  /**
   * The project's provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProjectProvisioningState;
}

/**
 * Azure Active Directory Application
 */
model AzureActiveDirectoryApp {
  /**
   * Application ID of the Azure Active Directory Application
   */
  applicationId?: string;

  /**
   * Key used to authenticate to the Azure Active Directory Application
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  appKey?: string;

  /**
   * Tenant id of the customer
   */
  tenantId?: string;

  /**
   * Ignore checking azure permissions on the AAD app
   */
  ignoreAzurePermissions?: boolean;
}

/**
 * Defines the connection properties of a server
 */
@discriminator("type")
model ConnectionInfo {
  /**
   * Type of connection info
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * User name
   */
  userName?: string;

  /**
   * Password credential.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  password?: string;
}

/**
 * Project Database Details
 */
model DatabaseInfo {
  /**
   * Name of the database
   */
  sourceDatabaseName: string;
}

/**
 * OData page of quota objects
 */
model QuotaList is Azure.Core.Page<Quota>;

/**
 * Describes a quota for or usage details about a resource
 */
model Quota {
  /**
   * The current value of the quota. If null or missing, the current value cannot be determined in the context of the request.
   */
  currentValue?: float64;

  /**
   * The resource ID of the quota object
   */
  id?: string;

  /**
   * The maximum value of the quota. If null or missing, the quota has no maximum, in which case it merely tracks usage.
   */
  limit?: float64;

  /**
   * The name of the quota
   */
  name?: QuotaName;

  /**
   * The unit for the quota, such as Count, Bytes, BytesPerSecond, etc.
   */
  unit?: string;
}

/**
 * The name of the quota
 */
model QuotaName {
  /**
   * The localized name of the quota
   */
  localizedValue?: string;

  /**
   * The unlocalized name (or ID) of the quota
   */
  value?: string;
}

/**
 * OData page of files
 */
model FileList is Azure.Core.Page<ProjectFile>;

/**
 * Base class for file properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProjectFileProperties {
  /**
   * Optional File extension. If submitted it should not have a leading period and must match the extension from filePath.
   */
  extension?: string;

  /**
   * Relative path of this file resource. This property can be set when creating or updating the file resource.
   */
  filePath?: string;

  /**
   * Modification DateTime.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * File content type. This property can be modified to reflect the file content type.
   */
  mediaType?: string;

  /**
   * File size.
   */
  @visibility(Lifecycle.Read)
  size?: int64;
}

/**
 * File storage information.
 */
model FileStorageInfo {
  /**
   * A URI that can be used to access the file content.
   */
  uri?: string;

  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  headers?: Record<string>;
}

/**
 * Properties for the command that completes sync migration for a database.
 */
model MigrateSyncCompleteCommandProperties extends CommandProperties {
  /**
   * Command input
   */
  input?: MigrateSyncCompleteCommandInput;

  /**
   * Command output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  output?: MigrateSyncCompleteCommandOutput;

  /**
   * Command id
   */
  commandId?: string;

  /**
   * Command type.
   */
  commandType: "Migrate.Sync.Complete.Database";
}

/**
 * Input for command that completes sync migration for a database.
 */
model MigrateSyncCompleteCommandInput {
  /**
   * Name of database
   */
  databaseName: string;

  /**
   * Time stamp to complete
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  commitTimeStamp?: utcDateTime;
}

/**
 * Output for command that completes sync migration for a database.
 */
model MigrateSyncCompleteCommandOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * List of errors that happened during the command execution
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: ReportableException[];
}

/**
 * Exception object for all custom exceptions
 */
model ReportableException {
  /**
   * Error message
   */
  message?: string;

  /**
   * Actionable steps for this exception
   */
  actionableMessage?: string;

  /**
   * The path to the file where exception occurred
   */
  filePath?: string;

  /**
   * The line number where exception occurred
   */
  lineNumber?: string;

  /**
   * Coded numerical value that is assigned to a specific exception
   */
  hResult?: int32;

  /**
   * Stack trace
   */
  stackTrace?: string;
}

/**
 * Properties for the command that completes online migration for an Azure SQL Database Managed Instance.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateMISyncCompleteCommandProperties extends CommandProperties {
  /**
   * Command input
   */
  input?: MigrateMISyncCompleteCommandInput;

  /**
   * Command output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  output?: MigrateMISyncCompleteCommandOutput;

  /**
   * Command type.
   */
  commandType: "Migrate.SqlServer.AzureDbSqlMi.Complete";
}

/**
 * Input for command that completes online migration for an Azure SQL Database Managed Instance.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateMISyncCompleteCommandInput {
  /**
   * Name of managed instance database
   */
  sourceDatabaseName: string;
}

/**
 * Output for command that completes online migration for an Azure SQL Database Managed Instance.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateMISyncCompleteCommandOutput {
  /**
   * List of errors that happened during the command execution
   */
  @identifiers(#[])
  errors?: ReportableException[];
}

/**
 * Describes a connection to a MongoDB data source
 */
model MongoDbConnectionInfo extends ConnectionInfo {
  /**
   * A MongoDB connection string or blob container URL. The user name and password can be specified here or in the userName and password properties
   */
  connectionString: string;

  /**
   * Data source
   */
  dataSource?: string;

  /**
   * Whether to encrypt the connection
   */
  encryptConnection?: boolean;

  /**
   * server brand version
   */
  serverBrandVersion?: string;

  /**
   * server version
   */
  serverVersion?: string;

  /**
   * name of the server
   */
  serverName?: string;

  /**
   * Whether to trust the server certificate
   */
  trustServerCertificate?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enforceSSL?: boolean;

  /**
   * port for server
   */
  port?: int32;

  /**
   * Additional connection settings
   */
  additionalSettings?: string;

  /**
   * Authentication type to use for connection
   */
  authentication?: AuthenticationType;

  /**
   * Type of connection info
   */
  type: "MongoDbConnectionInfo";
}

/**
 * Information for connecting to SQL database server
 */
model SqlConnectionInfo extends ConnectionInfo {
  /**
   * Data source in the format Protocol:MachineName\SQLServerInstanceName,PortNumber
   */
  dataSource: string;

  /**
   * name of the server
   */
  serverName?: string;

  /**
   * Port for Server
   */
  port?: int32;

  /**
   * server version
   */
  serverVersion?: string;

  /**
   * server brand version
   */
  serverBrandVersion?: string;

  /**
   * Represents the ID of an HTTP resource represented by an Azure resource provider.
   */
  resourceId?: string;

  /**
   * Authentication type to use for connection
   */
  authentication?: AuthenticationType;

  /**
   * Whether to encrypt the connection
   */
  encryptConnection?: boolean = true;

  /**
   * Additional connection settings
   */
  additionalSettings?: string;

  /**
   * Whether to trust the server certificate
   */
  trustServerCertificate?: boolean;

  /**
   * Server platform type for connection
   */
  platform?: SqlSourcePlatform;

  /**
   * Type of connection info
   */
  type: "SqlConnectionInfo";
}

/**
 * Information for connecting to MySQL server
 */
model MySqlConnectionInfo extends ConnectionInfo {
  /**
   * Name of the server
   */
  serverName: string;

  /**
   * Data source
   */
  dataSource?: string;

  /**
   * Port for Server
   */
  port: int32;

  /**
   * Whether to encrypt the connection
   */
  encryptConnection?: boolean = true;

  /**
   * Authentication type to use for connection
   */
  authentication?: AuthenticationType;

  /**
   * Additional connection settings
   */
  additionalSettings?: string;

  /**
   * Type of connection info
   */
  type: "MySqlConnectionInfo";
}

/**
 * Information for connecting to Oracle server
 */
model OracleConnectionInfo extends ConnectionInfo {
  /**
   * EZConnect or TNSName connection string.
   */
  dataSource: string;

  /**
   * name of the server
   */
  serverName?: string;

  /**
   * server version
   */
  serverVersion?: string;

  /**
   * port for server
   */
  port?: int32;

  /**
   * Authentication type to use for connection
   */
  authentication?: AuthenticationType;

  /**
   * Type of connection info
   */
  type: "OracleConnectionInfo";
}

/**
 * Information for connecting to PostgreSQL server
 */
model PostgreSqlConnectionInfo extends ConnectionInfo {
  /**
   * Name of the server
   */
  serverName: string;

  /**
   * Data source
   */
  dataSource?: string;

  /**
   * server version
   */
  serverVersion?: string;

  /**
   * Name of the database
   */
  databaseName?: string;

  /**
   * Port for Server
   */
  port: int32;

  /**
   * Whether to encrypt the connection
   */
  encryptConnection?: boolean = true;

  /**
   * Whether to trust the server certificate
   */
  trustServerCertificate?: boolean;

  /**
   * Additional connection settings
   */
  additionalSettings?: string;

  /**
   * server brand version
   */
  serverBrandVersion?: string;

  /**
   * Authentication type to use for connection
   */
  authentication?: AuthenticationType;

  /**
   * Type of connection info
   */
  type: "PostgreSqlConnectionInfo";
}

/**
 * Properties required to create a connection to Azure SQL database Managed instance
 */
model MiSqlConnectionInfo extends ConnectionInfo {
  /**
   * Resource id for Azure SQL database Managed instance
   */
  managedInstanceResourceId: string;

  /**
   * Type of connection info
   */
  type: "MiSqlConnectionInfo";
}

/**
 * Information of backup set
 */
model BackupSetInfo {
  /**
   * Id for the set of backup files
   */
  backupSetId?: string;

  /**
   * First log sequence number of the backup file
   */
  firstLsn?: string;

  /**
   * Last log sequence number of the backup file
   */
  lastLsn?: string;

  /**
   * Last modified time of the backup file in share location
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Enum of the different backup types
   */
  backupType?: BackupType;

  /**
   * List of files in the backup set
   */
  @identifiers(#[])
  listOfBackupFiles?: BackupFileInfo[];

  /**
   * Name of the database to which the backup set belongs
   */
  databaseName?: string;

  /**
   * Date and time that the backup operation began
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupStartDate?: utcDateTime;

  /**
   * Date and time that the backup operation finished
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupFinishedDate?: utcDateTime;

  /**
   * Whether the backup set is restored or not
   */
  isBackupRestored?: boolean;
}

/**
 * Information of the backup file
 */
model BackupFileInfo {
  /**
   * Location of the backup file in shared folder
   */
  fileLocation?: string;

  /**
   * Sequence number of the backup file in the backup set
   */
  familySequenceNumber?: int32;

  /**
   * Status of the backup file during migration
   */
  status?: BackupFileStatus;
}

/**
 * Information of orphaned users on the SQL server database.
 */
model OrphanedUserInfo {
  /**
   * Name of the orphaned user
   */
  name?: string;

  /**
   * Parent database of the user
   */
  databaseName?: string;
}

/**
 * Input for the task that validates MySQL database connection
 */
model ConnectToSourceMySqlTaskInput {
  /**
   * Information for connecting to MySQL source
   */
  sourceConnectionInfo: MySqlConnectionInfo;

  /**
   * Target Platform for the migration
   */
  targetPlatform?: MySqlTargetPlatformType;

  /**
   * Permission group for validations
   */
  checkPermissionsGroup?: ServerLevelPermissionsGroup;

  /**
   * Flag for whether or not the migration is offline
   */
  isOfflineMigration?: boolean = false;
}

/**
 * Input for the task that validates connection to SQL Server and also validates source server requirements
 */
model ConnectToSourceSqlServerTaskInput {
  /**
   * Connection information for Source SQL Server
   */
  sourceConnectionInfo: SqlConnectionInfo;

  /**
   * Permission group for validations
   */
  checkPermissionsGroup?: ServerLevelPermissionsGroup;

  /**
   * Flag for whether to collect databases from source server.
   */
  collectDatabases?: boolean = true;

  /**
   * Flag for whether to collect logins from source server.
   */
  collectLogins?: boolean = false;

  /**
   * Flag for whether to collect agent jobs from source server.
   */
  collectAgentJobs?: boolean = false;

  /**
   * Flag for whether to collect TDE Certificate names from source server.
   */
  collectTdeCertificateInfo?: boolean = false;

  /**
   * Flag for whether to validate SSIS catalog is reachable on the source server.
   */
  validateSsisCatalogOnly?: boolean = false;

  /**
   * encrypted key for secure fields
   */
  encryptedKeyForSecureFields?: string;
}

/**
 * Output for the task that validates connection to SQL Server and also validates source server requirements
 */
@discriminator("resultType")
model ConnectToSourceSqlServerTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Type of result - database level or task level
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resultType: string;
}

/**
 * Task level output for the task that validates connection to SQL Server and also validates source server requirements
 */
model ConnectToSourceSqlServerTaskOutputTaskLevel
  extends ConnectToSourceSqlServerTaskOutput {
  /**
   * Source databases as a map from database name to database id
   */
  @visibility(Lifecycle.Read)
  databases?: string;

  /**
   * Source logins as a map from login name to login id.
   */
  @visibility(Lifecycle.Read)
  logins?: string;

  /**
   * Source agent jobs as a map from agent job name to id.
   */
  @visibility(Lifecycle.Read)
  agentJobs?: string;

  /**
   * Mapping from database name to TDE certificate name, if applicable
   */
  @visibility(Lifecycle.Read)
  databaseTdeCertificateMapping?: string;

  /**
   * Source server version
   */
  @visibility(Lifecycle.Read)
  sourceServerVersion?: string;

  /**
   * Source server brand version
   */
  @visibility(Lifecycle.Read)
  sourceServerBrandVersion?: string;

  /**
   * Validation errors
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];

  /**
   * Type of result - database level or task level
   */
  resultType: "TaskLevelOutput";
}

/**
 * Database level output for the task that validates connection to SQL Server and also validates source server requirements
 */
model ConnectToSourceSqlServerTaskOutputDatabaseLevel
  extends ConnectToSourceSqlServerTaskOutput {
  /**
   * Database name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Size of the file in megabytes
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  sizeMB?: float64;

  /**
   * The list of database files
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  databaseFiles?: DatabaseFileInfo[];

  /**
   * SQL Server compatibility level of database
   */
  @visibility(Lifecycle.Read)
  compatibilityLevel?: DatabaseCompatLevel;

  /**
   * State of the database
   */
  @visibility(Lifecycle.Read)
  databaseState?: DatabaseState;

  /**
   * Type of result - database level or task level
   */
  resultType: "DatabaseLevelOutput";
}

/**
 * Database file specific information
 */
model DatabaseFileInfo {
  /**
   * Name of the database
   */
  databaseName?: string;

  /**
   * Unique identifier for database file
   */
  id?: string;

  /**
   * Logical name of the file
   */
  logicalName?: string;

  /**
   * Operating-system full path of the file
   */
  physicalFullName?: string;

  /**
   * Suggested full path of the file for restoring
   */
  restoreFullName?: string;

  /**
   * Database file type
   */
  fileType?: DatabaseFileType;

  /**
   * Size of the file in megabytes
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sizeMB?: float64;
}

/**
 * Login level output for the task that validates connection to SQL Server and also validates source server requirements
 */
model ConnectToSourceSqlServerTaskOutputLoginLevel
  extends ConnectToSourceSqlServerTaskOutput {
  /**
   * Login name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of login.
   */
  @visibility(Lifecycle.Read)
  loginType?: LoginType;

  /**
   * The default database for the login.
   */
  @visibility(Lifecycle.Read)
  defaultDatabase?: string;

  /**
   * The state of the login.
   */
  @visibility(Lifecycle.Read)
  isEnabled?: boolean;

  /**
   * Information about eligibility of login for migration.
   */
  @visibility(Lifecycle.Read)
  migrationEligibility?: MigrationEligibilityInfo;

  /**
   * Type of result - database level or task level
   */
  resultType: "LoginLevelOutput";
}

/**
 * Information about migration eligibility of a server object
 */
model MigrationEligibilityInfo {
  /**
   * Whether object is eligible for migration or not.
   */
  @visibility(Lifecycle.Read)
  isEligibleForMigration?: boolean;

  /**
   * Information about eligibility failure for the server object.
   */
  @visibility(Lifecycle.Read)
  validationMessages?: string[];
}

/**
 * Agent Job level output for the task that validates connection to SQL Server and also validates source server requirements
 */
model ConnectToSourceSqlServerTaskOutputAgentJobLevel
  extends ConnectToSourceSqlServerTaskOutput {
  /**
   * Agent Job name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Agent Job.
   */
  @visibility(Lifecycle.Read)
  jobCategory?: string;

  /**
   * The state of the original Agent Job.
   */
  @visibility(Lifecycle.Read)
  isEnabled?: boolean;

  /**
   * The owner of the Agent Job
   */
  @visibility(Lifecycle.Read)
  jobOwner?: string;

  /**
   * UTC Date and time when the Agent Job was last executed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastExecutedOn?: utcDateTime;

  /**
   * Validation errors
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];

  /**
   * Information about eligibility of agent job for migration.
   */
  @visibility(Lifecycle.Read)
  migrationEligibility?: MigrationEligibilityInfo;

  /**
   * Type of result - database level or task level
   */
  resultType: "AgentJobLevelOutput";
}

/**
 * Input for the task that validates connection to PostgreSQL and source server requirements
 */
model ConnectToSourcePostgreSqlSyncTaskInput {
  /**
   * Connection information for source PostgreSQL server
   */
  sourceConnectionInfo: PostgreSqlConnectionInfo;
}

/**
 * Output for the task that validates connection to PostgreSQL and source server requirements
 */
model ConnectToSourcePostgreSqlSyncTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Version of the source server
   */
  @visibility(Lifecycle.Read)
  sourceServerVersion?: string;

  /**
   * List of databases on source server
   */
  @visibility(Lifecycle.Read)
  databases?: string[];

  /**
   * Source server brand version
   */
  @visibility(Lifecycle.Read)
  sourceServerBrandVersion?: string;

  /**
   * Validation errors associated with the task
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Input for the task that validates connection to Azure Database for MySQL and target server requirements
 */
model ConnectToTargetAzureDbForMySqlTaskInput {
  /**
   * Connection information for source MySQL server
   */
  sourceConnectionInfo: MySqlConnectionInfo;

  /**
   * Connection information for target Azure Database for MySQL server
   */
  targetConnectionInfo: MySqlConnectionInfo;

  /**
   * Flag for whether or not the migration is offline
   */
  isOfflineMigration?: boolean = false;
}

/**
 * Output for the task that validates connection to Azure Database for MySQL and target server requirements
 */
model ConnectToTargetAzureDbForMySqlTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Version of the target server
   */
  @visibility(Lifecycle.Read)
  serverVersion?: string;

  /**
   * List of databases on target server
   */
  @visibility(Lifecycle.Read)
  databases?: string[];

  /**
   * Target server brand version
   */
  @visibility(Lifecycle.Read)
  targetServerBrandVersion?: string;

  /**
   * Validation errors associated with the task
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Input for the task that validates connection to SQL DB and target server requirements
 */
model ConnectToTargetSqlDbTaskInput {
  /**
   * Connection information for target SQL DB
   */
  targetConnectionInfo: SqlConnectionInfo;

  /**
   * Boolean flag indicating whether to query object counts for each database on the target server
   */
  queryObjectCounts?: boolean;
}

/**
 * Output for the task that validates connection to SQL DB and target server requirements
 */
model ConnectToTargetSqlDbTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Source databases as a map from database name to database id
   */
  @visibility(Lifecycle.Read)
  databases?: string;

  /**
   * Version of the target server
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility(Lifecycle.Read)
  targetServerBrandVersion?: string;
}

/**
 * Input for the task that validates connection to Azure SQL Database Managed Instance online scenario.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectToTargetSqlMISyncTaskInput {
  /**
   * Connection information for Azure SQL Database Managed Instance
   */
  targetConnectionInfo: MiSqlConnectionInfo;

  /**
   * Azure Active Directory Application the DMS (classic) instance will use to connect to the target instance of Azure SQL Database Managed Instance and the Azure Storage Account
   */
  azureApp: AzureActiveDirectoryApp;
}

/**
 * Output for the task that validates connection to Azure SQL Database Managed Instance.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectToTargetSqlMISyncTaskOutput {
  /**
   * Target server version
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility(Lifecycle.Read)
  targetServerBrandVersion?: string;

  /**
   * Validation errors
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Input for the task that validates connection to Azure SQL Database Managed Instance.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectToTargetSqlMITaskInput {
  /**
   * Connection information for target SQL Server
   */
  targetConnectionInfo: SqlConnectionInfo;

  /**
   * Flag for whether to collect logins from target SQL MI server.
   */
  collectLogins?: boolean = true;

  /**
   * Flag for whether to collect agent jobs from target SQL MI server.
   */
  collectAgentJobs?: boolean = true;

  /**
   * Flag for whether to validate SSIS catalog is reachable on the target SQL MI server.
   */
  validateSsisCatalogOnly?: boolean = false;
}

/**
 * Output for the task that validates connection to Azure SQL Database Managed Instance.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectToTargetSqlMITaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Target server version
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility(Lifecycle.Read)
  targetServerBrandVersion?: string;

  /**
   * List of logins on the target server.
   */
  @visibility(Lifecycle.Read)
  logins?: string[];

  /**
   * List of agent jobs on the target server.
   */
  @visibility(Lifecycle.Read)
  agentJobs?: string[];

  /**
   * Validation errors
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Input for the task that validates connection to Azure SQL DB and target server requirements
 */
model ConnectToTargetSqlSqlDbSyncTaskInput {
  /**
   * Connection information for source SQL Server
   */
  sourceConnectionInfo: SqlConnectionInfo;

  /**
   * Connection information for target SQL DB
   */
  targetConnectionInfo: SqlConnectionInfo;
}

/**
 * Input for the task that validates connection to Azure Database for PostgreSQL and target server requirements
 */
model ConnectToTargetAzureDbForPostgreSqlSyncTaskInput {
  /**
   * Connection information for source PostgreSQL server
   */
  sourceConnectionInfo: PostgreSqlConnectionInfo;

  /**
   * Connection information for target Azure Database for PostgreSQL server
   */
  targetConnectionInfo: PostgreSqlConnectionInfo;
}

/**
 * Output for the task that validates connection to Azure Database for PostgreSQL and target server requirements
 */
model ConnectToTargetAzureDbForPostgreSqlSyncTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Version of the target server
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * List of databases on target server
   */
  @visibility(Lifecycle.Read)
  databases?: string[];

  /**
   * Target server brand version
   */
  @visibility(Lifecycle.Read)
  targetServerBrandVersion?: string;

  /**
   * Validation errors associated with the task
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Input for the task that collects user tables for the given list of databases
 */
model GetUserTablesMySqlTaskInput {
  /**
   * Connection information for SQL Server
   */
  connectionInfo: MySqlConnectionInfo;

  /**
   * List of database names to collect tables for
   */
  selectedDatabases: string[];
}

/**
 * Output of the task that collects user tables for the given list of databases
 */
model GetUserTablesMySqlTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Mapping from database name to list of tables
   */
  @visibility(Lifecycle.Read)
  databasesToTables?: string;

  /**
   * Validation errors
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Table properties
 */
model DatabaseTable {
  /**
   * Indicates whether table is empty or not
   */
  @visibility(Lifecycle.Read)
  hasRows?: boolean;

  /**
   * Schema-qualified name of the table
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * Input for the task that gets TDE certificates in Base64 encoded format.
 */
model GetTdeCertificatesSqlTaskInput {
  /**
   * Connection information for SQL Server
   */
  connectionInfo: SqlConnectionInfo;

  /**
   * Backup file share information for file share to be used for temporarily storing files.
   */
  backupFileShare: FileShare;

  /**
   * List containing certificate names and corresponding password to use for encrypting the exported certificate.
   */
  @identifiers(#[])
  selectedCertificates: SelectedCertificateInput[];
}

/**
 * File share information with Path, Username, and Password.
 */
model FileShare {
  /**
   * User name credential to connect to the share location
   */
  userName?: string;

  /**
   * Password credential used to connect to the share location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  password?: string;

  /**
   * The folder path for this share.
   */
  path: string;
}

/**
 * Info for certificate to be exported for TDE enabled databases.
 */
model SelectedCertificateInput {
  /**
   * Name of certificate to be exported.
   */
  certificateName: string;

  /**
   * Password to use for encrypting the exported certificate.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  password: string;
}

/**
 * Output of the task that gets TDE certificates in Base64 encoded format.
 */
model GetTdeCertificatesSqlTaskOutput {
  /**
   * Mapping from certificate name to base 64 encoded format.
   */
  @visibility(Lifecycle.Read)
  base64EncodedCertificates?: string;

  /**
   * Validation errors
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Input for the task that collects user tables for the given list of databases
 */
model GetUserTablesSqlSyncTaskInput {
  /**
   * Connection information for SQL Server
   */
  sourceConnectionInfo: SqlConnectionInfo;

  /**
   * Connection information for SQL DB
   */
  targetConnectionInfo: SqlConnectionInfo;

  /**
   * List of source database names to collect tables for
   */
  selectedSourceDatabases: string[];

  /**
   * List of target database names to collect tables for
   */
  selectedTargetDatabases: string[];
}

/**
 * Output of the task that collects user tables for the given list of databases
 */
model GetUserTablesSqlSyncTaskOutput {
  /**
   * Mapping from database name to list of source tables
   */
  @visibility(Lifecycle.Read)
  databasesToSourceTables?: string;

  /**
   * Mapping from database name to list of target tables
   */
  @visibility(Lifecycle.Read)
  databasesToTargetTables?: string;

  /**
   * Mapping from database name to list of validation errors
   */
  @visibility(Lifecycle.Read)
  tableValidationErrors?: string;

  /**
   * Validation errors
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Input for the task that collects user tables for the given list of databases
 */
model GetUserTablesSqlTaskInput {
  /**
   * Connection information for SQL Server
   */
  connectionInfo: SqlConnectionInfo;

  /**
   * List of database names to collect tables for
   */
  selectedDatabases: string[];

  /**
   * encrypted key for secure fields
   */
  encryptedKeyForSecureFields?: string;
}

/**
 * Output of the task that collects user tables for the given list of databases
 */
model GetUserTablesSqlTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Mapping from database name to list of tables
   */
  @visibility(Lifecycle.Read)
  databasesToTables?: string;

  /**
   * Validation errors
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Properties for task that migrates Schema for SQL Server databases to Azure SQL databases
 */
model MigrateSchemaSqlServerSqlDbTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: MigrateSchemaSqlServerSqlDbTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: MigrateSchemaSqlServerSqlDbTaskOutput[];

  /**
   * DateTime in UTC when the task was created
   */
  createdOn?: string;

  /**
   * Task id
   */
  taskId?: string;

  /**
   * whether the task can be cloned or not
   */
  isCloneable?: boolean;

  /**
   * Task type.
   */
  taskType: "MigrateSchemaSqlServerSqlDb";
}

/**
 * Input for task that migrates Schema for SQL Server databases to Azure SQL databases
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSchemaSqlServerSqlDbTaskInput extends SqlMigrationTaskInput {
  /**
   * Databases to migrate
   */
  @identifiers(#[])
  selectedDatabases: MigrateSchemaSqlServerSqlDbDatabaseInput[];

  /**
   * encrypted key for secure fields
   */
  encryptedKeyForSecureFields?: string;

  /**
   * Migration start time
   */
  startedOn?: string;
}

/**
 * Database input for migrate schema Sql Server to Azure SQL Server scenario
 */
model MigrateSchemaSqlServerSqlDbDatabaseInput {
  /**
   * Name of source database
   */
  name?: string;

  /**
   * Id of the source database
   */
  id?: string;

  /**
   * Name of target database
   */
  targetDatabaseName?: string;

  /**
   * Database schema migration settings
   */
  schemaSetting?: SchemaMigrationSetting;
}

/**
 * Settings for migrating schema from source to target
 */
model SchemaMigrationSetting {
  /**
   * Option on how to migrate the schema
   */
  schemaOption?: SchemaMigrationOption;

  /**
   * Resource Identifier of a file resource containing the uploaded schema file
   */
  fileId?: string;

  /**
   * Name of the file resource containing the uploaded schema file
   */
  fileName?: string;
}

/**
 * Base class for migration task input
 */
model SqlMigrationTaskInput {
  /**
   * Information for connecting to source
   */
  sourceConnectionInfo: SqlConnectionInfo;

  /**
   * Information for connecting to target
   */
  targetConnectionInfo: SqlConnectionInfo;
}

/**
 * Output for the task that migrates Schema for SQL Server databases to Azure SQL databases
 */
@discriminator("resultType")
model MigrateSchemaSqlServerSqlDbTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Result type
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resultType: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSchemaSqlServerSqlDbTaskOutputMigrationLevel
  extends MigrateSchemaSqlServerSqlDbTaskOutput {
  /**
   * Overall state of the schema migration
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Source server version
   */
  @visibility(Lifecycle.Read)
  sourceServerVersion?: string;

  /**
   * Source server brand version
   */
  @visibility(Lifecycle.Read)
  sourceServerBrandVersion?: string;

  /**
   * Target server version
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility(Lifecycle.Read)
  targetServerBrandVersion?: string;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSchemaSqlServerSqlDbTaskOutputDatabaseLevel
  extends MigrateSchemaSqlServerSqlDbTaskOutput {
  /**
   * The name of the database
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * State of the schema migration for this database
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Schema migration stage for this database
   */
  @visibility(Lifecycle.Read)
  stage?: SchemaMigrationStage;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Prefix string to use for querying errors for this database
   */
  @visibility(Lifecycle.Read)
  databaseErrorResultPrefix?: string;

  /**
   * Prefix string to use for querying schema errors for this database
   */
  @visibility(Lifecycle.Read)
  schemaErrorResultPrefix?: string;

  /**
   * Number of successful operations for this database
   */
  @visibility(Lifecycle.Read)
  numberOfSuccessfulOperations?: int64;

  /**
   * Number of failed operations for this database
   */
  @visibility(Lifecycle.Read)
  numberOfFailedOperations?: int64;

  /**
   * Identifier for the file resource containing the schema of this database
   */
  @visibility(Lifecycle.Read)
  fileId?: string;

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSchemaSqlServerSqlDbTaskOutputError
  extends MigrateSchemaSqlServerSqlDbTaskOutput {
  /**
   * Schema command which failed
   */
  @visibility(Lifecycle.Read)
  commandText?: string;

  /**
   * Reason of failure
   */
  @visibility(Lifecycle.Read)
  errorText?: string;

  /**
   * Result type
   */
  resultType: "SchemaErrorOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSchemaSqlTaskOutputError
  extends MigrateSchemaSqlServerSqlDbTaskOutput {
  /**
   * Migration error
   */
  @visibility(Lifecycle.Read)
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

/**
 * Input for the task that migrates MySQL databases to Azure Database for MySQL for online migrations
 */
model MigrateMySqlAzureDbForMySqlSyncTaskInput {
  /**
   * Connection information for source MySQL
   */
  sourceConnectionInfo: MySqlConnectionInfo;

  /**
   * Connection information for target Azure Database for MySQL
   */
  targetConnectionInfo: MySqlConnectionInfo;

  /**
   * Databases to migrate
   */
  @identifiers(#[])
  selectedDatabases: MigrateMySqlAzureDbForMySqlSyncDatabaseInput[];
}

/**
 * Database specific information for MySQL to Azure Database for MySQL migration task inputs
 */
model MigrateMySqlAzureDbForMySqlSyncDatabaseInput {
  /**
   * Name of the database
   */
  name?: string;

  /**
   * Name of target database. Note: Target database will be truncated before starting migration.
   */
  targetDatabaseName?: string;

  /**
   * Migration settings which tune the migration behavior
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  migrationSetting?: Record<string>;

  /**
   * Source settings to tune source endpoint migration behavior
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceSetting?: Record<string>;

  /**
   * Target settings to tune target endpoint migration behavior
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetSetting?: Record<string>;

  /**
   * Mapping of source to target tables
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableMap?: Record<string>;
}

/**
 * Output for the task that migrates MySQL databases to Azure Database for MySQL for online migrations
 */
@discriminator("resultType")
model MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Result type
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resultType: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateMySqlAzureDbForMySqlSyncTaskOutputMigrationLevel
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Source server version
   */
  @visibility(Lifecycle.Read)
  sourceServerVersion?: string;

  /**
   * Source server name
   */
  @visibility(Lifecycle.Read)
  sourceServer?: string;

  /**
   * Target server version
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * Target server name
   */
  @visibility(Lifecycle.Read)
  targetServer?: string;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateMySqlAzureDbForMySqlSyncTaskOutputDatabaseLevel
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  /**
   * Name of the database
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Migration state that this database is in
   */
  @visibility(Lifecycle.Read)
  migrationState?: SyncDatabaseMigrationReportingState;

  /**
   * Number of incoming changes
   */
  @visibility(Lifecycle.Read)
  incomingChanges?: int64;

  /**
   * Number of applied changes
   */
  @visibility(Lifecycle.Read)
  appliedChanges?: int64;

  /**
   * Number of cdc inserts
   */
  @visibility(Lifecycle.Read)
  cdcInsertCounter?: int64;

  /**
   * Number of cdc deletes
   */
  @visibility(Lifecycle.Read)
  cdcDeleteCounter?: int64;

  /**
   * Number of cdc updates
   */
  @visibility(Lifecycle.Read)
  cdcUpdateCounter?: int64;

  /**
   * Number of tables completed in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadCompletedTables?: int64;

  /**
   * Number of tables loading in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadLoadingTables?: int64;

  /**
   * Number of tables queued in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadQueuedTables?: int64;

  /**
   * Number of tables errored in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadErroredTables?: int64;

  /**
   * Indicates if initial load (full load) has been completed
   */
  @visibility(Lifecycle.Read)
  initializationCompleted?: boolean;

  /**
   * CDC apply latency
   */
  @visibility(Lifecycle.Read)
  latency?: int64;

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateMySqlAzureDbForMySqlSyncTaskOutputTableLevel
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  /**
   * Name of the table
   */
  @visibility(Lifecycle.Read)
  tableName?: string;

  /**
   * Name of the database
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Number of applied inserts
   */
  @visibility(Lifecycle.Read)
  cdcInsertCounter?: string;

  /**
   * Number of applied updates
   */
  @visibility(Lifecycle.Read)
  cdcUpdateCounter?: string;

  /**
   * Number of applied deletes
   */
  @visibility(Lifecycle.Read)
  cdcDeleteCounter?: string;

  /**
   * Estimate to finish full load
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEstFinishTime?: utcDateTime;

  /**
   * Full load start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadStartedOn?: utcDateTime;

  /**
   * Full load end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEndedOn?: utcDateTime;

  /**
   * Number of rows applied in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadTotalRows?: int64;

  /**
   * Current state of the table migration
   */
  @visibility(Lifecycle.Read)
  state?: SyncTableMigrationState;

  /**
   * Total number of applied changes
   */
  @visibility(Lifecycle.Read)
  totalChangesApplied?: int64;

  /**
   * Number of data errors occurred
   */
  @visibility(Lifecycle.Read)
  dataErrorsCounter?: int64;

  /**
   * Last modified time on target
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Result type
   */
  resultType: "TableLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateMySqlAzureDbForMySqlSyncTaskOutputError
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  /**
   * Migration error
   */
  @visibility(Lifecycle.Read)
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateMySqlAzureDbForMySqlSyncTaskOutputDatabaseError
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  /**
   * Error message
   */
  errorMessage?: string;

  /**
   * List of error events.
   */
  @identifiers(#[])
  events?: SyncMigrationDatabaseErrorEvent[];

  /**
   * Result type
   */
  resultType: "DatabaseLevelErrorOutput";
}

/**
 * Database migration errors for online migration
 */
model SyncMigrationDatabaseErrorEvent {
  /**
   * String value of timestamp.
   */
  @visibility(Lifecycle.Read)
  timestampString?: string;

  /**
   * Event type.
   */
  @visibility(Lifecycle.Read)
  eventTypeString?: string;

  /**
   * Event text.
   */
  @visibility(Lifecycle.Read)
  eventText?: string;
}

/**
 * Input for the task that migrates PostgreSQL databases to Azure Database for PostgreSQL for online migrations
 */
model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskInput {
  /**
   * Databases to migrate
   */
  @identifiers(#[])
  selectedDatabases: MigratePostgreSqlAzureDbForPostgreSqlSyncDatabaseInput[];

  /**
   * Connection information for target Azure Database for PostgreSQL
   */
  targetConnectionInfo: PostgreSqlConnectionInfo;

  /**
   * Connection information for source PostgreSQL
   */
  sourceConnectionInfo: PostgreSqlConnectionInfo;

  /**
   * encrypted key for secure fields
   */
  encryptedKeyForSecureFields?: string;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;
}

/**
 * Database specific information for PostgreSQL to Azure Database for PostgreSQL migration task inputs
 */
model MigratePostgreSqlAzureDbForPostgreSqlSyncDatabaseInput {
  /**
   * Name of the database
   */
  name?: string;

  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of target database. Note: Target database will be truncated before starting migration.
   */
  targetDatabaseName?: string;

  /**
   * Migration settings which tune the migration behavior
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  migrationSetting?: Record<unknown>;

  /**
   * Source settings to tune source endpoint migration behavior
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceSetting?: Record<string>;

  /**
   * Target settings to tune target endpoint migration behavior
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetSetting?: Record<string>;

  /**
   * Tables selected for migration
   */
  @identifiers(#[])
  selectedTables?: MigratePostgreSqlAzureDbForPostgreSqlSyncDatabaseTableInput[];
}

/**
 * Selected tables for the migration
 */
model MigratePostgreSqlAzureDbForPostgreSqlSyncDatabaseTableInput {
  /**
   * Name of the table to migrate
   */
  name?: string;
}

/**
 * Output for the task that migrates PostgreSQL databases to Azure Database for PostgreSQL for online migrations
 */
@discriminator("resultType")
model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Result type
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resultType: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputMigrationLevel
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Source server version
   */
  @visibility(Lifecycle.Read)
  sourceServerVersion?: string;

  /**
   * Source server name
   */
  @visibility(Lifecycle.Read)
  sourceServer?: string;

  /**
   * Target server version
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * Target server name
   */
  @visibility(Lifecycle.Read)
  targetServer?: string;

  /**
   * Source server type.
   */
  @visibility(Lifecycle.Read)
  sourceServerType?: ScenarioSource;

  /**
   * Target server type.
   */
  @visibility(Lifecycle.Read)
  targetServerType?: ScenarioTarget;

  /**
   * Migration status
   */
  @visibility(Lifecycle.Read)
  state?: ReplicateMigrationState;

  /**
   * Number of databases to include
   */
  databaseCount?: float32;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputDatabaseLevel
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  /**
   * Name of the database
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Migration state that this database is in
   */
  @visibility(Lifecycle.Read)
  migrationState?: SyncDatabaseMigrationReportingState;

  /**
   * Number of incoming changes
   */
  @visibility(Lifecycle.Read)
  incomingChanges?: int64;

  /**
   * Number of applied changes
   */
  @visibility(Lifecycle.Read)
  appliedChanges?: int64;

  /**
   * Number of cdc inserts
   */
  @visibility(Lifecycle.Read)
  cdcInsertCounter?: int64;

  /**
   * Number of cdc deletes
   */
  @visibility(Lifecycle.Read)
  cdcDeleteCounter?: int64;

  /**
   * Number of cdc updates
   */
  @visibility(Lifecycle.Read)
  cdcUpdateCounter?: int64;

  /**
   * Number of tables completed in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadCompletedTables?: int64;

  /**
   * Number of tables loading in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadLoadingTables?: int64;

  /**
   * Number of tables queued in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadQueuedTables?: int64;

  /**
   * Number of tables errored in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadErroredTables?: int64;

  /**
   * Indicates if initial load (full load) has been completed
   */
  @visibility(Lifecycle.Read)
  initializationCompleted?: boolean;

  /**
   * CDC apply latency
   */
  @visibility(Lifecycle.Read)
  latency?: int64;

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputTableLevel
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  /**
   * Name of the table
   */
  @visibility(Lifecycle.Read)
  tableName?: string;

  /**
   * Name of the database
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Number of applied inserts
   */
  @visibility(Lifecycle.Read)
  cdcInsertCounter?: int64;

  /**
   * Number of applied updates
   */
  @visibility(Lifecycle.Read)
  cdcUpdateCounter?: int64;

  /**
   * Number of applied deletes
   */
  @visibility(Lifecycle.Read)
  cdcDeleteCounter?: int64;

  /**
   * Estimate to finish full load
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEstFinishTime?: utcDateTime;

  /**
   * Full load start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadStartedOn?: utcDateTime;

  /**
   * Full load end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEndedOn?: utcDateTime;

  /**
   * Number of rows applied in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadTotalRows?: int64;

  /**
   * Current state of the table migration
   */
  @visibility(Lifecycle.Read)
  state?: SyncTableMigrationState;

  /**
   * Total number of applied changes
   */
  @visibility(Lifecycle.Read)
  totalChangesApplied?: int64;

  /**
   * Number of data errors occurred
   */
  @visibility(Lifecycle.Read)
  dataErrorsCounter?: int64;

  /**
   * Last modified time on target
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Result type
   */
  resultType: "TableLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputError
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  /**
   * Migration error
   */
  @visibility(Lifecycle.Read)
  error?: ReportableException;

  /**
   * List of error events
   */
  @identifiers(#[])
  events?: SyncMigrationDatabaseErrorEvent[];

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputDatabaseError
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  /**
   * Error message
   */
  errorMessage?: string;

  /**
   * List of error events.
   */
  @identifiers(#[])
  events?: SyncMigrationDatabaseErrorEvent[];

  /**
   * Result type
   */
  resultType: "DatabaseLevelErrorOutput";
}

/**
 * Input for the task that migrates on-prem SQL Server databases to Azure SQL Database for online migrations
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlDbSyncTaskInput extends SqlMigrationTaskInput {
  /**
   * Databases to migrate
   */
  @identifiers(#[])
  selectedDatabases: MigrateSqlServerSqlDbSyncDatabaseInput[];

  /**
   * Validation options
   */
  validationOptions?: MigrationValidationOptions;
}

/**
 * Database specific information for SQL to Azure SQL DB sync migration task inputs
 */
model MigrateSqlServerSqlDbSyncDatabaseInput {
  /**
   * Unique identifier for database
   */
  id?: string;

  /**
   * Name of database
   */
  name?: string;

  /**
   * Target database name
   */
  targetDatabaseName?: string;

  /**
   * Schema name to be migrated
   */
  schemaName?: string;

  /**
   * Mapping of source to target tables
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableMap?: Record<string>;

  /**
   * Migration settings which tune the migration behavior
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  migrationSetting?: Record<string>;

  /**
   * Source settings to tune source endpoint migration behavior
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceSetting?: Record<string>;

  /**
   * Target settings to tune target endpoint migration behavior
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetSetting?: Record<string>;
}

/**
 * Types of validations to run after the migration
 */
model MigrationValidationOptions {
  /**
   * Allows to compare the schema information between source and target.
   */
  enableSchemaValidation?: boolean;

  /**
   * Allows to perform a checksum based data integrity validation between source and target for the selected database / tables .
   */
  enableDataIntegrityValidation?: boolean;

  /**
   * Allows to perform a quick and intelligent query analysis by retrieving queries from the source database and executes them in the target. The result will have execution statistics for executions in source and target databases for the extracted queries.
   */
  enableQueryAnalysisValidation?: boolean;
}

/**
 * Output for the task that migrates on-prem SQL Server databases to Azure SQL Database for online migrations
 */
@discriminator("resultType")
model MigrateSqlServerSqlDbSyncTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Result type
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resultType: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlDbSyncTaskOutputMigrationLevel
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Source server version
   */
  @visibility(Lifecycle.Read)
  sourceServerVersion?: string;

  /**
   * Source server name
   */
  @visibility(Lifecycle.Read)
  sourceServer?: string;

  /**
   * Target server version
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * Target server name
   */
  @visibility(Lifecycle.Read)
  targetServer?: string;

  /**
   * Count of databases
   */
  @visibility(Lifecycle.Read)
  databaseCount?: int32;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlDbSyncTaskOutputDatabaseLevel
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  /**
   * Name of the database
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Migration state that this database is in
   */
  @visibility(Lifecycle.Read)
  migrationState?: SyncDatabaseMigrationReportingState;

  /**
   * Number of incoming changes
   */
  @visibility(Lifecycle.Read)
  incomingChanges?: int64;

  /**
   * Number of applied changes
   */
  @visibility(Lifecycle.Read)
  appliedChanges?: int64;

  /**
   * Number of cdc inserts
   */
  @visibility(Lifecycle.Read)
  cdcInsertCounter?: int64;

  /**
   * Number of cdc deletes
   */
  @visibility(Lifecycle.Read)
  cdcDeleteCounter?: int64;

  /**
   * Number of cdc updates
   */
  @visibility(Lifecycle.Read)
  cdcUpdateCounter?: int64;

  /**
   * Number of tables completed in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadCompletedTables?: int64;

  /**
   * Number of tables loading in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadLoadingTables?: int64;

  /**
   * Number of tables queued in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadQueuedTables?: int64;

  /**
   * Number of tables errored in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadErroredTables?: int64;

  /**
   * Indicates if initial load (full load) has been completed
   */
  @visibility(Lifecycle.Read)
  initializationCompleted?: boolean;

  /**
   * CDC apply latency
   */
  @visibility(Lifecycle.Read)
  latency?: int64;

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlDbSyncTaskOutputTableLevel
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  /**
   * Name of the table
   */
  @visibility(Lifecycle.Read)
  tableName?: string;

  /**
   * Name of the database
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Number of applied inserts
   */
  @visibility(Lifecycle.Read)
  cdcInsertCounter?: int64;

  /**
   * Number of applied updates
   */
  @visibility(Lifecycle.Read)
  cdcUpdateCounter?: int64;

  /**
   * Number of applied deletes
   */
  @visibility(Lifecycle.Read)
  cdcDeleteCounter?: int64;

  /**
   * Estimate to finish full load
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEstFinishTime?: utcDateTime;

  /**
   * Full load start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadStartedOn?: utcDateTime;

  /**
   * Full load end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEndedOn?: utcDateTime;

  /**
   * Number of rows applied in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadTotalRows?: int64;

  /**
   * Current state of the table migration
   */
  @visibility(Lifecycle.Read)
  state?: SyncTableMigrationState;

  /**
   * Total number of applied changes
   */
  @visibility(Lifecycle.Read)
  totalChangesApplied?: int64;

  /**
   * Number of data errors occurred
   */
  @visibility(Lifecycle.Read)
  dataErrorsCounter?: int64;

  /**
   * Last modified time on target
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Result type
   */
  resultType: "TableLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlDbSyncTaskOutputError
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  /**
   * Migration error
   */
  @visibility(Lifecycle.Read)
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlDbSyncTaskOutputDatabaseError
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  /**
   * Error message
   */
  errorMessage?: string;

  /**
   * List of error events.
   */
  @identifiers(#[])
  events?: SyncMigrationDatabaseErrorEvent[];

  /**
   * Result type
   */
  resultType: "DatabaseLevelErrorOutput";
}

/**
 * Input for the task that migrates on-prem SQL Server databases to Azure SQL Database
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlDbTaskInput extends SqlMigrationTaskInput {
  /**
   * Databases to migrate
   */
  @identifiers(#[])
  selectedDatabases: MigrateSqlServerSqlDbDatabaseInput[];

  /**
   * Options for enabling various post migration validations. Available options,
   *  1.) Data Integrity Check: Performs a checksum based comparison on source and target tables after the migration to ensure the correctness of the data.
   *  2.) Schema Validation: Performs a thorough schema comparison between the source and target tables and provides a list of differences between the source and target database, 3.) Query Analysis: Executes a set of queries picked up automatically either from the Query Plan Cache or Query Store and execute them and compares the execution time between the source and target database.
   */
  validationOptions?: MigrationValidationOptions;

  /**
   * Date and time relative to UTC when the migration was started on
   */
  startedOn?: string;

  /**
   * encrypted key for secure fields
   */
  encryptedKeyForSecureFields?: string;
}

/**
 * Database specific information for SQL to Azure SQL DB migration task inputs
 */
model MigrateSqlServerSqlDbDatabaseInput {
  /**
   * Name of the database
   */
  name?: string;

  /**
   * Name of target database. Note: Target database will be truncated before starting migration.
   */
  targetDatabaseName?: string;

  /**
   * Whether to set database read only before migration
   */
  makeSourceDbReadOnly?: boolean;

  /**
   * Mapping of source to target tables
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableMap?: Record<string>;

  /**
   * Settings selected for DB schema migration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schemaSetting?: unknown;

  /**
   * id of the database
   */
  id?: string;
}

/**
 * Output for the task that migrates on-prem SQL Server databases to Azure SQL Database
 */
@discriminator("resultType")
model MigrateSqlServerSqlDbTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Result type
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resultType: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlDbTaskOutputMigrationLevel
  extends MigrateSqlServerSqlDbTaskOutput {
  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Duration of task execution in seconds.
   */
  @visibility(Lifecycle.Read)
  durationInSeconds?: int64;

  /**
   * Current status of migration
   */
  @visibility(Lifecycle.Read)
  status?: MigrationStatus;

  /**
   * Migration status message
   */
  @visibility(Lifecycle.Read)
  statusMessage?: string;

  /**
   * Migration progress message
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Selected databases as a map from database name to database id
   */
  @visibility(Lifecycle.Read)
  databases?: string;

  /**
   * Summary of database results in the migration
   */
  @visibility(Lifecycle.Read)
  databaseSummary?: string;

  /**
   * Migration Validation Results
   */
  migrationValidationResult?: MigrationValidationResult;

  /**
   * Migration Report Result, provides unique url for downloading your migration report.
   */
  migrationReportResult?: MigrationReportResult;

  /**
   * Source server version
   */
  @visibility(Lifecycle.Read)
  sourceServerVersion?: string;

  /**
   * Source server brand version
   */
  @visibility(Lifecycle.Read)
  sourceServerBrandVersion?: string;

  /**
   * Target server version
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility(Lifecycle.Read)
  targetServerBrandVersion?: string;

  /**
   * Migration exceptions and warnings.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

/**
 * Migration Validation Result
 */
model MigrationValidationResult {
  /**
   * Migration validation result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Migration Identifier
   */
  @visibility(Lifecycle.Read)
  migrationId?: string;

  /**
   * Validation summary results for each database
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  summaryResults?: Record<MigrationValidationDatabaseSummaryResult>;

  /**
   * Current status of validation at the migration level. Status from the database validation result status will be aggregated here.
   */
  @visibility(Lifecycle.Read)
  status?: ValidationStatus;
}

/**
 * Migration Validation Database level summary result
 */
model MigrationValidationDatabaseSummaryResult {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Migration Identifier
   */
  @visibility(Lifecycle.Read)
  migrationId?: string;

  /**
   * Name of the source database
   */
  @visibility(Lifecycle.Read)
  sourceDatabaseName?: string;

  /**
   * Name of the target database
   */
  @visibility(Lifecycle.Read)
  targetDatabaseName?: string;

  /**
   * Validation start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Validation end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current status of validation at the database level
   */
  @visibility(Lifecycle.Read)
  status?: ValidationStatus;
}

/**
 * Migration validation report result, contains the url for downloading the generated report.
 */
model MigrationReportResult {
  /**
   * Migration validation result identifier
   */
  id?: string;

  /**
   * The url of the report.
   */
  reportUrl?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlDbTaskOutputDatabaseLevel
  extends MigrateSqlServerSqlDbTaskOutput {
  /**
   * Name of the item
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current state of migration
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Migration stage that this database is in
   */
  @visibility(Lifecycle.Read)
  stage?: DatabaseMigrationStage;

  /**
   * Status message
   */
  @visibility(Lifecycle.Read)
  statusMessage?: string;

  /**
   * Migration progress message
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Number of objects
   */
  @visibility(Lifecycle.Read)
  numberOfObjects?: int64;

  /**
   * Number of successfully completed objects
   */
  @visibility(Lifecycle.Read)
  numberOfObjectsCompleted?: int64;

  /**
   * Number of database/object errors.
   */
  @visibility(Lifecycle.Read)
  errorCount?: int64;

  /**
   * Wildcard string prefix to use for querying all errors of the item
   */
  @visibility(Lifecycle.Read)
  errorPrefix?: string;

  /**
   * Wildcard string prefix to use for querying all sub-tem results of the item
   */
  @visibility(Lifecycle.Read)
  resultPrefix?: string;

  /**
   * Migration exceptions and warnings.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Summary of object results in the migration
   */
  @visibility(Lifecycle.Read)
  objectSummary?: string;

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlDbTaskOutputTableLevel
  extends MigrateSqlServerSqlDbTaskOutput {
  /**
   * Name of the item
   */
  @visibility(Lifecycle.Read)
  objectName?: string;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current state of migration
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Status message
   */
  @visibility(Lifecycle.Read)
  statusMessage?: string;

  /**
   * Number of items
   */
  @visibility(Lifecycle.Read)
  itemsCount?: int64;

  /**
   * Number of successfully completed items
   */
  @visibility(Lifecycle.Read)
  itemsCompletedCount?: int64;

  /**
   * Wildcard string prefix to use for querying all errors of the item
   */
  @visibility(Lifecycle.Read)
  errorPrefix?: string;

  /**
   * Wildcard string prefix to use for querying all sub-tem results of the item
   */
  @visibility(Lifecycle.Read)
  resultPrefix?: string;

  /**
   * Result type
   */
  resultType: "TableLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlDbTaskOutputError
  extends MigrateSqlServerSqlDbTaskOutput {
  /**
   * Migration error
   */
  @visibility(Lifecycle.Read)
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

/**
 * Summary of database results in the migration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseSummaryResult extends DataItemMigrationSummaryResult {
  /**
   * Size of the database in megabytes
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  sizeMB?: float64;
}

/**
 * Basic summary of a data item migration
 */
model DataItemMigrationSummaryResult {
  /**
   * Name of the item
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current state of migration
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Status message
   */
  @visibility(Lifecycle.Read)
  statusMessage?: string;

  /**
   * Number of items
   */
  @visibility(Lifecycle.Read)
  itemsCount?: int64;

  /**
   * Number of successfully completed items
   */
  @visibility(Lifecycle.Read)
  itemsCompletedCount?: int64;

  /**
   * Wildcard string prefix to use for querying all errors of the item
   */
  @visibility(Lifecycle.Read)
  errorPrefix?: string;

  /**
   * Wildcard string prefix to use for querying all sub-tem results of the item
   */
  @visibility(Lifecycle.Read)
  resultPrefix?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlDbTaskOutputValidationResult
  extends MigrateSqlServerSqlDbTaskOutput {
  ...MigrationValidationResult;

  /**
   * Result type
   */
  resultType: "MigrationValidationOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlDbTaskOutputDatabaseLevelValidationResult
  extends MigrateSqlServerSqlDbTaskOutput {
  ...MigrationValidationDatabaseLevelResult;

  /**
   * Result type
   */
  resultType: "MigrationDatabaseLevelValidationOutput";
}

/**
 * Database level validation results
 */
model MigrationValidationDatabaseLevelResult {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Migration Identifier
   */
  @visibility(Lifecycle.Read)
  migrationId?: string;

  /**
   * Name of the source database
   */
  @visibility(Lifecycle.Read)
  sourceDatabaseName?: string;

  /**
   * Name of the target database
   */
  @visibility(Lifecycle.Read)
  targetDatabaseName?: string;

  /**
   * Validation start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Validation end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Provides data integrity validation result between the source and target tables that are migrated.
   */
  @visibility(Lifecycle.Read)
  dataIntegrityValidationResult?: DataIntegrityValidationResult;

  /**
   * Provides schema comparison result between source and target database
   */
  @visibility(Lifecycle.Read)
  schemaValidationResult?: SchemaComparisonValidationResult;

  /**
   * Results of some of the query execution result between source and target database
   */
  @visibility(Lifecycle.Read)
  queryAnalysisValidationResult?: QueryAnalysisValidationResult;

  /**
   * Current status of validation at the database level
   */
  @visibility(Lifecycle.Read)
  status?: ValidationStatus;
}

/**
 * Results for checksum based Data Integrity validation results
 */
model DataIntegrityValidationResult {
  /**
   * List of failed table names of source and target pair
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  failedObjects?: Record<string>;

  /**
   * List of errors that happened while performing data integrity validation
   */
  validationErrors?: ValidationError;
}

/**
 * Description about the errors happen while performing migration validation
 */
model ValidationError {
  /**
   * Error Text
   */
  text?: string;

  /**
   * Severity of the error
   */
  severity?: Severity;
}

/**
 * Results for schema comparison between the source and target
 */
model SchemaComparisonValidationResult {
  /**
   * List of schema differences between the source and target databases
   */
  schemaDifferences?: SchemaComparisonValidationResultType;

  /**
   * List of errors that happened while performing schema compare validation
   */
  validationErrors?: ValidationError;

  /**
   * Count of source database objects
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceDatabaseObjectCount?: Record<int64>;

  /**
   * Count of target database objects
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetDatabaseObjectCount?: Record<int64>;
}

/**
 * Description about the errors happen while performing migration validation
 */
model SchemaComparisonValidationResultType {
  /**
   * Name of the object that has the difference
   */
  objectName?: string;

  /**
   * Type of the object that has the difference. e.g (Table/View/StoredProcedure)
   */
  objectType?: ObjectType;

  /**
   * Update action type with respect to target
   */
  updateAction?: UpdateActionType;
}

/**
 * Results for query analysis comparison between the source and target
 */
model QueryAnalysisValidationResult {
  /**
   * List of queries executed and it's execution results in source and target
   */
  queryResults?: QueryExecutionResult;

  /**
   * Errors that are part of the execution
   */
  validationErrors?: ValidationError;
}

/**
 * Describes query analysis results for execution in source and target
 */
model QueryExecutionResult {
  /**
   * Query text retrieved from the source server
   */
  queryText?: string;

  /**
   * Total no. of statements in the batch
   */
  statementsInBatch?: int64;

  /**
   * Query analysis result from the source
   */
  sourceResult?: ExecutionStatistics;

  /**
   * Query analysis result from the target
   */
  targetResult?: ExecutionStatistics;
}

/**
 * Description about the errors happen while performing migration validation
 */
model ExecutionStatistics {
  /**
   * No. of query executions
   */
  executionCount?: int64;

  /**
   * CPU Time in millisecond(s) for the query execution
   */
  cpuTimeMs?: float32;

  /**
   * Time taken in millisecond(s) for executing the query
   */
  elapsedTimeMs?: float32;

  /**
   * Dictionary of sql query execution wait types and the respective statistics
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  waitStats?: Record<WaitStatistics>;

  /**
   * Indicates whether the query resulted in an error
   */
  hasErrors?: boolean;

  /**
   * List of sql Errors
   */
  sqlErrors?: string[];
}

/**
 * Wait statistics gathered during query batch execution
 */
model WaitStatistics {
  /**
   * Type of the Wait
   */
  waitType?: string;

  /**
   * Total wait time in millisecond(s)
   */
  waitTimeMs?: float32;

  /**
   * Total no. of waits
   */
  waitCount?: int64;
}

/**
 * Input for task that migrates SQL Server databases to Azure SQL Database Managed Instance online scenario.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlMISyncTaskInput extends SqlServerSqlMISyncTaskInput {
  /**
   * Number of database migrations to start in parallel
   */
  numberOfParallelDatabaseMigrations?: float32;
}

/**
 * Input for task that migrates SQL Server databases to Azure SQL Database Managed Instance online scenario.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlServerSqlMISyncTaskInput {
  /**
   * Databases to migrate
   */
  @identifiers(#[])
  selectedDatabases: MigrateSqlServerSqlMIDatabaseInput[];

  /**
   * Backup file share information for all selected databases.
   */
  backupFileShare?: FileShare;

  /**
   * Fully qualified resourceId of storage
   */
  storageResourceId: string;

  /**
   * Connection information for source SQL Server
   */
  sourceConnectionInfo: SqlConnectionInfo;

  /**
   * Connection information for Azure SQL Database Managed Instance
   */
  targetConnectionInfo: MiSqlConnectionInfo;

  /**
   * Azure Active Directory Application the DMS (classic) instance will use to connect to the target instance of Azure SQL Database Managed Instance and the Azure Storage Account
   */
  azureApp: AzureActiveDirectoryApp;
}

/**
 * Database specific information for SQL to Azure SQL DB Managed Instance migration task inputs
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlMIDatabaseInput {
  /**
   * Name of the database
   */
  name: string;

  /**
   * Name of the database at destination
   */
  restoreDatabaseName: string;

  /**
   * Backup file share information for backing up this database.
   */
  backupFileShare?: FileShare;

  /**
   * The list of backup files to be used in case of existing backups.
   */
  backupFilePaths?: string[];

  /**
   * id of the database
   */
  id?: string;
}

/**
 * Output for task that migrates SQL Server databases to Azure SQL Database Managed Instance using Log Replay Service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("resultType")
model MigrateSqlServerSqlMISyncTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Result type
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resultType: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlMISyncTaskOutputMigrationLevel
  extends MigrateSqlServerSqlMISyncTaskOutput {
  /**
   * Count of databases
   */
  @visibility(Lifecycle.Read)
  databaseCount?: int32;

  /**
   * Current state of migration
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Source server name
   */
  @visibility(Lifecycle.Read)
  sourceServerName?: string;

  /**
   * Source server version
   */
  @visibility(Lifecycle.Read)
  sourceServerVersion?: string;

  /**
   * Source server brand version
   */
  @visibility(Lifecycle.Read)
  sourceServerBrandVersion?: string;

  /**
   * Target server name
   */
  @visibility(Lifecycle.Read)
  targetServerName?: string;

  /**
   * Target server version
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility(Lifecycle.Read)
  targetServerBrandVersion?: string;

  /**
   * Number of database level errors
   */
  @visibility(Lifecycle.Read)
  databaseErrorCount?: int32;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlMISyncTaskOutputDatabaseLevel
  extends MigrateSqlServerSqlMISyncTaskOutput {
  /**
   * Name of the database
   */
  @visibility(Lifecycle.Read)
  sourceDatabaseName?: string;

  /**
   * Current state of database
   */
  @visibility(Lifecycle.Read)
  migrationState?: DatabaseMigrationState;

  /**
   * Database migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Database migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Details of full backup set
   */
  @visibility(Lifecycle.Read)
  fullBackupSetInfo?: BackupSetInfo;

  /**
   * Last applied backup set information
   */
  @visibility(Lifecycle.Read)
  lastRestoredBackupSetInfo?: BackupSetInfo;

  /**
   * Backup sets that are currently active (Either being uploaded or getting restored)
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  activeBackupSets?: BackupSetInfo[];

  /**
   * Name of container created in the Azure Storage account where backups are copied to
   */
  @visibility(Lifecycle.Read)
  containerName?: string;

  /**
   * prefix string to use for querying errors for this database
   */
  @visibility(Lifecycle.Read)
  errorPrefix?: string;

  /**
   * Whether full backup has been applied to the target database or not
   */
  @visibility(Lifecycle.Read)
  isFullBackupRestored?: boolean;

  /**
   * Migration exceptions and warnings
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlMISyncTaskOutputError
  extends MigrateSqlServerSqlMISyncTaskOutput {
  /**
   * Migration error
   */
  @visibility(Lifecycle.Read)
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

/**
 * Input for task that migrates SQL Server databases to Azure SQL Database Managed Instance.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlMITaskInput extends SqlMigrationTaskInput {
  /**
   * Databases to migrate
   */
  @identifiers(#[])
  selectedDatabases: MigrateSqlServerSqlMIDatabaseInput[];

  /**
   * Date and time relative to UTC when the migration was started on
   */
  startedOn?: string;

  /**
   * Logins to migrate.
   */
  selectedLogins?: string[];

  /**
   * Agent Jobs to migrate.
   */
  selectedAgentJobs?: string[];

  /**
   * Backup file share information for all selected databases.
   */
  backupFileShare?: FileShare;

  /**
   * SAS URI of Azure Storage Account Container to be used for storing backup files.
   */
  backupBlobShare: BlobShare;

  /**
   * Backup Mode to specify whether to use existing backup or create new backup. If using existing backups, backup file paths are required to be provided in selectedDatabases.
   */
  backupMode?: BackupMode;

  /**
   * Azure Active Directory domain name in the format of 'contoso.com' for federated Azure AD or 'contoso.onmicrosoft.com' for managed domain, required if and only if Windows logins are selected
   */
  aadDomainName?: string;

  /**
   * encrypted key for secure fields
   */
  encryptedKeyForSecureFields?: string;
}

/**
 * Blob container storage information.
 */
model BlobShare {
  /**
   * SAS URI of Azure Storage Account Container.
   */
  sasUri?: string;
}

/**
 * Output for task that migrates SQL Server databases to Azure SQL Database Managed Instance.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("resultType")
model MigrateSqlServerSqlMITaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Result type
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resultType: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlMITaskOutputMigrationLevel
  extends MigrateSqlServerSqlMITaskOutput {
  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current status of migration
   */
  @visibility(Lifecycle.Read)
  status?: MigrationStatus;

  /**
   * Current state of migration
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Selected agent jobs as a map from name to id
   */
  @visibility(Lifecycle.Read)
  agentJobs?: string;

  /**
   * Selected logins as a map from name to id
   */
  @visibility(Lifecycle.Read)
  logins?: string;

  /**
   * Migration progress message
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Map of server role migration results.
   */
  @visibility(Lifecycle.Read)
  serverRoleResults?: string;

  /**
   * List of orphaned users.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  orphanedUsersInfo?: OrphanedUserInfo[];

  /**
   * Selected databases as a map from database name to database id
   */
  @visibility(Lifecycle.Read)
  databases?: string;

  /**
   * Source server version
   */
  @visibility(Lifecycle.Read)
  sourceServerVersion?: string;

  /**
   * Source server brand version
   */
  @visibility(Lifecycle.Read)
  sourceServerBrandVersion?: string;

  /**
   * Target server version
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility(Lifecycle.Read)
  targetServerBrandVersion?: string;

  /**
   * Migration exceptions and warnings.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlMITaskOutputDatabaseLevel
  extends MigrateSqlServerSqlMITaskOutput {
  /**
   * Name of the database
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Size of the database in megabytes
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  sizeMB?: float64;

  /**
   * Current state of migration
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Current stage of migration
   */
  @visibility(Lifecycle.Read)
  stage?: DatabaseMigrationStage;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Migration progress message
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Migration exceptions and warnings
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlMITaskOutputAgentJobLevel
  extends MigrateSqlServerSqlMITaskOutput {
  /**
   * Agent Job name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The state of the original Agent Job.
   */
  @visibility(Lifecycle.Read)
  isEnabled?: boolean;

  /**
   * Current state of migration
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Migration progress message
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Migration errors and warnings per job
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Result type
   */
  resultType: "AgentJobLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlMITaskOutputLoginLevel
  extends MigrateSqlServerSqlMITaskOutput {
  /**
   * Login name.
   */
  @visibility(Lifecycle.Read)
  loginName?: string;

  /**
   * Current state of login
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Current stage of login
   */
  @visibility(Lifecycle.Read)
  stage?: LoginMigrationStage;

  /**
   * Login migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Login migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Login migration progress message
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Login migration errors and warnings per login
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Result type
   */
  resultType: "LoginLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlMITaskOutputError
  extends MigrateSqlServerSqlMITaskOutput {
  /**
   * Migration error
   */
  @visibility(Lifecycle.Read)
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

/**
 * Input for task that migrates SSIS packages from SQL Server to Azure SQL Database Managed Instance.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSsisTaskInput extends SqlMigrationTaskInput {
  /**
   * SSIS package migration information.
   */
  ssisMigrationInfo: SsisMigrationInfo;
}

/**
 * SSIS migration info with SSIS store type, overwrite policy.
 */
model SsisMigrationInfo {
  /**
   * The SSIS store type of source, only SSIS catalog is supported now in DMS (classic)
   */
  ssisStoreType?: SsisStoreType;

  /**
   * The overwrite option for the SSIS project migration
   */
  projectOverwriteOption?: SsisMigrationOverwriteOption;

  /**
   * The overwrite option for the SSIS environment migration
   */
  environmentOverwriteOption?: SsisMigrationOverwriteOption;
}

/**
 * Output for task that migrates SSIS packages from SQL Server to Azure SQL Database Managed Instance.
 */
@discriminator("resultType")
model MigrateSsisTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Result type
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resultType: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSsisTaskOutputMigrationLevel extends MigrateSsisTaskOutput {
  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current status of migration
   */
  @visibility(Lifecycle.Read)
  status?: MigrationStatus;

  /**
   * Migration progress message
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Source server version
   */
  @visibility(Lifecycle.Read)
  sourceServerVersion?: string;

  /**
   * Source server brand version
   */
  @visibility(Lifecycle.Read)
  sourceServerBrandVersion?: string;

  /**
   * Target server version
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility(Lifecycle.Read)
  targetServerBrandVersion?: string;

  /**
   * Migration exceptions and warnings.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Stage of SSIS migration.
   */
  @visibility(Lifecycle.Read)
  stage?: SsisMigrationStage;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSsisTaskOutputProjectLevel extends MigrateSsisTaskOutput {
  /**
   * Name of the folder
   */
  @visibility(Lifecycle.Read)
  folderName?: string;

  /**
   * Name of the project
   */
  @visibility(Lifecycle.Read)
  projectName?: string;

  /**
   * Current state of migration
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Stage of SSIS migration.
   */
  @visibility(Lifecycle.Read)
  stage?: SsisMigrationStage;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Migration progress message
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Migration exceptions and warnings
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Result type
   */
  resultType: "SsisProjectLevelOutput";
}

/**
 * Properties for the command that cancels a migration in whole or in part
 */
model MongoDbCancelCommand extends CommandProperties {
  /**
   * Command input
   */
  input?: MongoDbCommandInput;

  /**
   * Command type.
   */
  commandType: "cancel";
}

/**
 * Describes the input to the 'cancel' and 'restart' MongoDB migration commands
 */
model MongoDbCommandInput {
  /**
   * The qualified name of a database or collection to act upon, or null to act upon the entire migration
   */
  objectName?: string;
}

/**
 * Describes a MongoDB data source
 */
model MongoDbClusterInfo {
  /**
   * A list of non-system databases in the cluster
   */
  @identifiers(#[])
  databases: MongoDbDatabaseInfo[];

  /**
   * Whether the cluster supports sharded collections
   */
  supportsSharding: boolean;

  /**
   * The type of data source
   */
  type: MongoDbClusterType;

  /**
   * The version of the data source in the form x.y.z (e.g. 3.6.7). Not used if Type is BlobContainer.
   */
  version: string;
}

/**
 * Describes a database within a MongoDB data source
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDbDatabaseInfo extends MongoDbObjectInfo {
  /**
   * A list of supported collections in a MongoDB database
   */
  @identifiers(#[])
  collections: MongoDbCollectionInfo[];

  /**
   * Whether the database has sharding enabled. Note that the migration task will enable sharding on the target if necessary.
   */
  supportsSharding: boolean;
}

/**
 * Describes a supported collection within a MongoDB database
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDbCollectionInfo extends MongoDbObjectInfo {
  /**
   * The name of the database containing the collection
   */
  databaseName: string;

  /**
   * Whether the collection is a capped collection (i.e. whether it has a fixed size and acts like a circular buffer)
   */
  isCapped: boolean;

  /**
   * Whether the collection is system collection
   */
  isSystemCollection: boolean;

  /**
   * Whether the collection is a view of another collection
   */
  isView: boolean;

  /**
   * The shard key on the collection, or null if the collection is not sharded
   */
  shardKey?: MongoDbShardKeyInfo;

  /**
   * Whether the database has sharding enabled. Note that the migration task will enable sharding on the target if necessary.
   */
  supportsSharding: boolean;

  /**
   * The name of the collection that this is a view of, if IsView is true
   */
  viewOf?: string;
}

/**
 * Describes a MongoDB shard key
 */
model MongoDbShardKeyInfo {
  /**
   * The fields within the shard key
   */
  @identifiers(#[])
  fields: MongoDbShardKeyField[];

  /**
   * Whether the shard key is unique
   */
  isUnique: boolean;
}

/**
 * Describes a field reference within a MongoDB shard key
 */
model MongoDbShardKeyField {
  /**
   * The name of the field
   */
  name: string;

  /**
   * The field ordering
   */
  order: MongoDbShardKeyOrder;
}

/**
 * Describes a database or collection within a MongoDB data source
 */
model MongoDbObjectInfo {
  /**
   * The average document size, or -1 if the average size is unknown
   */
  averageDocumentSize: int64;

  /**
   * The estimated total data size, in bytes, or -1 if the size is unknown.
   */
  dataSize: int64;

  /**
   * The estimated total number of documents, or -1 if the document count is unknown
   */
  documentCount: int64;

  /**
   * The unqualified name of the database or collection
   */
  name: string;

  /**
   * The qualified name of the database or collection. For a collection, this is the database-qualified name.
   */
  qualifiedName: string;
}

/**
 * Describes the progress of a collection
 */
model MongoDbCollectionProgress extends MongoDbProgress {
  /**
   * The type of progress object
   */
  resultType: "Collection";
}

/**
 * Base class for MongoDB migration outputs
 */
@discriminator("resultType")
model MongoDbProgress {
  /**
   * The number of document bytes copied during the Copying stage
   */
  bytesCopied: int64;

  /**
   * The number of documents copied during the Copying stage
   */
  documentsCopied: int64;

  /**
   * The elapsed time in the format [ddd.]hh:mm:ss[.fffffff] (i.e. TimeSpan format)
   */
  elapsedTime: string;

  /**
   * The errors and warnings that have occurred for the current object. The keys are the error codes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errors: Record<MongoDbError>;

  /**
   * The number of oplog events awaiting replay
   */
  eventsPending: int64;

  /**
   * The number of oplog events replayed so far
   */
  eventsReplayed: int64;

  /**
   * The timestamp of the last oplog event received, or null if no oplog event has been received yet
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastEventTime?: utcDateTime;

  /**
   * The timestamp of the last oplog event replayed, or null if no oplog event has been replayed yet
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastReplayTime?: utcDateTime;

  /**
   * The name of the progress object. For a collection, this is the unqualified collection name. For a database, this is the database name. For the overall migration, this is null.
   */
  name?: string;

  /**
   * The qualified name of the progress object. For a collection, this is the database-qualified name. For a database, this is the database name. For the overall migration, this is null.
   */
  qualifiedName?: string;

  /**
   * The type of progress object
   */
  resultType: MongoDbProgressResultType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  state: MongoDbMigrationState;

  /**
   * The total number of document bytes on the source at the beginning of the Copying stage, or -1 if the total size was unknown
   */
  totalBytes: int64;

  /**
   * The total number of documents on the source at the beginning of the Copying stage, or -1 if the total count was unknown
   */
  totalDocuments: int64;
}

/**
 * Describes an error or warning that occurred during a MongoDB migration
 */
model MongoDbError {
  /**
   * The non-localized, machine-readable code that describes the error or warning
   */
  code?: string;

  /**
   * The number of times the error or warning has occurred
   */
  count?: int32;

  /**
   * The localized, human-readable message that describes the error or warning
   */
  message?: string;

  /**
   * The type of error or warning
   */
  type?: MongoDbErrorType;
}

/**
 * Describes how an individual MongoDB collection should be migrated
 */
model MongoDbCollectionSettings {
  /**
   * Whether the migrator is allowed to drop the target collection in the course of performing a migration. The default is true.
   */
  canDelete?: boolean;

  /**
   * Describes a MongoDB shard key
   */
  shardKey?: MongoDbShardKeySetting;

  /**
   * The RUs that should be configured on a CosmosDB target, or null to use the default. This has no effect on non-CosmosDB targets.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetRUs?: int32;
}

/**
 * Describes a MongoDB shard key
 */
model MongoDbShardKeySetting {
  /**
   * The fields within the shard key
   */
  @identifiers(#[])
  fields: MongoDbShardKeyField[];

  /**
   * Whether the shard key is unique
   */
  isUnique?: boolean;
}

/**
 * Describes the progress of a database
 */
model MongoDbDatabaseProgress extends MongoDbProgress {
  /**
   * The progress of the collections in the database. The keys are the unqualified names of the collections
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  collections?: Record<MongoDbCollectionProgress>;

  /**
   * The type of progress object
   */
  resultType: "Database";
}

/**
 * Describes how an individual MongoDB database should be migrated
 */
model MongoDbDatabaseSettings {
  /**
   * The collections on the source database to migrate to the target. The keys are the unqualified names of the collections.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  collections: Record<MongoDbCollectionSettings>;

  /**
   * The RUs that should be configured on a CosmosDB target, or null to use the default, or 0 if throughput should not be provisioned for the database. This has no effect on non-CosmosDB targets.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetRUs?: int32;
}

/**
 * Properties for the command that finishes a migration in whole or in part
 */
model MongoDbFinishCommand extends CommandProperties {
  /**
   * Command input
   */
  input?: MongoDbFinishCommandInput;

  /**
   * Command type.
   */
  commandType: "finish";
}

/**
 * Describes the input to the 'finish' MongoDB migration command
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDbFinishCommandInput extends MongoDbCommandInput {
  /**
   * If true, replication for the affected objects will be stopped immediately. If false, the migrator will finish replaying queued events before finishing the replication.
   */
  immediate: boolean;
}

/**
 * Describes how a MongoDB data migration should be performed
 */
model MongoDbMigrationSettings {
  /**
   * The RU limit on a CosmosDB target that collections will be temporarily increased to (if lower) during the initial copy of a migration, from 10,000 to 1,000,000, or 0 to use the default boost (which is generally the maximum), or null to not boost the RUs. This setting has no effect on non-CosmosDB targets.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  boostRUs?: int32;

  /**
   * The databases on the source cluster to migrate to the target. The keys are the names of the databases.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  databases: Record<MongoDbDatabaseSettings>;

  /**
   * Describes how changes will be replicated from the source to the target. The default is OneTime.
   */
  replication?: MongoDbReplication;

  /**
   * Settings used to connect to the source cluster
   */
  source: MongoDbConnectionInfo;

  /**
   * Settings used to connect to the target cluster
   */
  target: MongoDbConnectionInfo;

  /**
   * Settings used to limit the resource usage of the migration
   */
  throttling?: MongoDbThrottlingSettings;
}

/**
 * Specifies resource limits for the migration
 */
model MongoDbThrottlingSettings {
  /**
   * The percentage of CPU time that the migrator will try to avoid using, from 0 to 100
   */
  minFreeCpu?: int32;

  /**
   * The number of megabytes of RAM that the migrator will try to avoid using
   */
  minFreeMemoryMb?: int32;

  /**
   * The maximum number of work items (e.g. collection copies) that will be processed in parallel
   */
  maxParallelism?: int32;
}

/**
 * Describes the progress of the overall migration
 */
model MongoDbMigrationProgress extends MongoDbProgress {
  /**
   * The progress of the databases in the migration. The keys are the names of the databases
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  databases?: Record<MongoDbDatabaseProgress>;

  /**
   * The type of progress object
   */
  resultType: "Migration";
}

/**
 * Properties for the command that restarts a migration in whole or in part
 */
model MongoDbRestartCommand extends CommandProperties {
  /**
   * Command input
   */
  input?: MongoDbCommandInput;

  /**
   * Command type.
   */
  commandType: "restart";
}

/**
 * Input for the task that validates Oracle database connection
 */
model ConnectToSourceOracleSyncTaskInput {
  /**
   * Information for connecting to Oracle source
   */
  sourceConnectionInfo: OracleConnectionInfo;
}

/**
 * Output for the task that validates Oracle database connection
 */
model ConnectToSourceOracleSyncTaskOutput {
  /**
   * Version of the source server
   */
  @visibility(Lifecycle.Read)
  sourceServerVersion?: string;

  /**
   * List of schemas on source server
   */
  @visibility(Lifecycle.Read)
  databases?: string[];

  /**
   * Source server brand version
   */
  @visibility(Lifecycle.Read)
  sourceServerBrandVersion?: string;

  /**
   * Validation errors associated with the task
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Input for the task that validates connection to Azure Database for PostgreSQL and target server requirements for Oracle source.
 */
model ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskInput {
  /**
   * Connection information for target Azure Database for PostgreSQL server
   */
  targetConnectionInfo: PostgreSqlConnectionInfo;
}

/**
 * Output for the task that validates connection to Azure Database for PostgreSQL and target server requirements for Oracle source.
 */
model ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskOutput {
  /**
   * Version of the target server
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * List of databases on target server
   */
  @visibility(Lifecycle.Read)
  databases?: string[];

  /**
   * Target server brand version
   */
  @visibility(Lifecycle.Read)
  targetServerBrandVersion?: string;

  /**
   * Validation errors associated with the task
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];

  /**
   * Mapping of schemas per database
   */
  @identifiers(#[])
  databaseSchemaMap?: ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskOutputDatabaseSchemaMapItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskOutputDatabaseSchemaMapItem {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  database?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schemas?: string[];
}

/**
 * Input for the task that gets the list of tables contained within a provided list of Oracle schemas.
 */
model GetUserTablesOracleTaskInput {
  /**
   * Information for connecting to Oracle source
   */
  connectionInfo: OracleConnectionInfo;

  /**
   * List of Oracle schemas for which to collect tables
   */
  selectedSchemas: string[];
}

/**
 * Output for the task that gets the list of tables contained within a provided list of Oracle schemas.
 */
model GetUserTablesOracleTaskOutput {
  /**
   * The schema this result is for
   */
  @visibility(Lifecycle.Read)
  schemaName?: string;

  /**
   * List of valid tables found for this schema
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  tables?: DatabaseTable[];

  /**
   * Validation errors associated with the task
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Input for the task that gets the list of tables for a provided list of PostgreSQL databases.
 */
model GetUserTablesPostgreSqlTaskInput {
  /**
   * Information for connecting to PostgreSQL source
   */
  connectionInfo: PostgreSqlConnectionInfo;

  /**
   * List of PostgreSQL databases for which to collect tables
   */
  selectedDatabases: string[];
}

/**
 * Output for the task that gets the list of tables for a provided list of PostgreSQL databases.
 */
model GetUserTablesPostgreSqlTaskOutput {
  /**
   * The database this result is for
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * List of valid tables found for this database
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  tables?: DatabaseTable[];

  /**
   * Validation errors associated with the task
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Output for task that validates migration input for Oracle to Azure Database for PostgreSQL for online migrations
 */
model ValidateOracleAzureDbPostgreSqlSyncTaskOutput {
  /**
   * Errors associated with a selected database object
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Input for the task that migrates Oracle databases to Azure Database for PostgreSQL for online migrations
 */
model MigrateOracleAzureDbPostgreSqlSyncTaskInput {
  /**
   * Databases to migrate
   */
  @identifiers(#[])
  selectedDatabases: MigrateOracleAzureDbPostgreSqlSyncDatabaseInput[];

  /**
   * Connection information for target Azure Database for PostgreSQL
   */
  targetConnectionInfo: PostgreSqlConnectionInfo;

  /**
   * Connection information for source Oracle
   */
  sourceConnectionInfo: OracleConnectionInfo;
}

/**
 * Database specific information for Oracle to Azure Database for PostgreSQL migration task inputs
 */
model MigrateOracleAzureDbPostgreSqlSyncDatabaseInput {
  /**
   * How to handle object name casing: either Preserve or ToLower
   */
  caseManipulation?: string;

  /**
   * Name of the migration pipeline
   */
  name?: string;

  /**
   * Name of the source schema
   */
  schemaName?: string;

  /**
   * Mapping of source to target tables
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableMap?: Record<string>;

  /**
   * Name of target database. Note: Target database will be truncated before starting migration.
   */
  targetDatabaseName?: string;

  /**
   * Migration settings which tune the migration behavior
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  migrationSetting?: Record<string>;

  /**
   * Source settings to tune source endpoint migration behavior
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceSetting?: Record<string>;

  /**
   * Target settings to tune target endpoint migration behavior
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetSetting?: Record<string>;
}

/**
 * Output for the task that migrates Oracle databases to Azure Database for PostgreSQL for online migrations
 */
@discriminator("resultType")
model MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Result type
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resultType: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateOracleAzureDbPostgreSqlSyncTaskOutputMigrationLevel
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Source server version
   */
  @visibility(Lifecycle.Read)
  sourceServerVersion?: string;

  /**
   * Source server name
   */
  @visibility(Lifecycle.Read)
  sourceServer?: string;

  /**
   * Target server version
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * Target server name
   */
  @visibility(Lifecycle.Read)
  targetServer?: string;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateOracleAzureDbPostgreSqlSyncTaskOutputDatabaseLevel
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  /**
   * Name of the database
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Migration state that this database is in
   */
  @visibility(Lifecycle.Read)
  migrationState?: SyncDatabaseMigrationReportingState;

  /**
   * Number of incoming changes
   */
  @visibility(Lifecycle.Read)
  incomingChanges?: int64;

  /**
   * Number of applied changes
   */
  @visibility(Lifecycle.Read)
  appliedChanges?: int64;

  /**
   * Number of cdc inserts
   */
  @visibility(Lifecycle.Read)
  cdcInsertCounter?: int64;

  /**
   * Number of cdc deletes
   */
  @visibility(Lifecycle.Read)
  cdcDeleteCounter?: int64;

  /**
   * Number of cdc updates
   */
  @visibility(Lifecycle.Read)
  cdcUpdateCounter?: int64;

  /**
   * Number of tables completed in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadCompletedTables?: int64;

  /**
   * Number of tables loading in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadLoadingTables?: int64;

  /**
   * Number of tables queued in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadQueuedTables?: int64;

  /**
   * Number of tables errored in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadErroredTables?: int64;

  /**
   * Indicates if initial load (full load) has been completed
   */
  @visibility(Lifecycle.Read)
  initializationCompleted?: boolean;

  /**
   * CDC apply latency
   */
  @visibility(Lifecycle.Read)
  latency?: int64;

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateOracleAzureDbPostgreSqlSyncTaskOutputTableLevel
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  /**
   * Name of the table
   */
  @visibility(Lifecycle.Read)
  tableName?: string;

  /**
   * Name of the database
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Number of applied inserts
   */
  @visibility(Lifecycle.Read)
  cdcInsertCounter?: int64;

  /**
   * Number of applied updates
   */
  @visibility(Lifecycle.Read)
  cdcUpdateCounter?: int64;

  /**
   * Number of applied deletes
   */
  @visibility(Lifecycle.Read)
  cdcDeleteCounter?: int64;

  /**
   * Estimate to finish full load
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEstFinishTime?: utcDateTime;

  /**
   * Full load start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadStartedOn?: utcDateTime;

  /**
   * Full load end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEndedOn?: utcDateTime;

  /**
   * Number of rows applied in full load
   */
  @visibility(Lifecycle.Read)
  fullLoadTotalRows?: int64;

  /**
   * Current state of the table migration
   */
  @visibility(Lifecycle.Read)
  state?: SyncTableMigrationState;

  /**
   * Total number of applied changes
   */
  @visibility(Lifecycle.Read)
  totalChangesApplied?: int64;

  /**
   * Number of data errors occurred
   */
  @visibility(Lifecycle.Read)
  dataErrorsCounter?: int64;

  /**
   * Last modified time on target
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Result type
   */
  resultType: "TableLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateOracleAzureDbPostgreSqlSyncTaskOutputError
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  /**
   * Migration error
   */
  @visibility(Lifecycle.Read)
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateOracleAzureDbPostgreSqlSyncTaskOutputDatabaseError
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  /**
   * Error message
   */
  errorMessage?: string;

  /**
   * List of error events.
   */
  @identifiers(#[])
  events?: SyncMigrationDatabaseErrorEvent[];

  /**
   * Result type
   */
  resultType: "DatabaseLevelErrorOutput";
}

/**
 * Information about an Oracle OCI driver.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OracleOCIDriverInfo {
  /**
   * The name of the driver package
   */
  @visibility(Lifecycle.Read)
  driverName?: string;

  /**
   * The size in bytes of the driver package
   */
  @visibility(Lifecycle.Read)
  driverSize?: string;

  /**
   * The MD5 Base64 encoded checksum for the driver package.
   */
  @visibility(Lifecycle.Read)
  archiveChecksum?: string;

  /**
   * The checksum for the driver package provided by Oracle.
   */
  @visibility(Lifecycle.Read)
  oracleChecksum?: string;

  /**
   * Version listed in the OCI assembly 'oci.dll'
   */
  @visibility(Lifecycle.Read)
  assemblyVersion?: string;

  /**
   * List of Oracle database versions supported by this driver. Only major minor of the version is listed.
   */
  @visibility(Lifecycle.Read)
  supportedOracleVersions?: string[];
}

/**
 * Input for the service task to check for OCI drivers.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CheckOCIDriverTaskInput {
  /**
   * Version of the source server to check against.  Optional.
   */
  serverVersion?: string;
}

/**
 * Output for the service task to check for OCI drivers.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CheckOCIDriverTaskOutput {
  /**
   * Information about the installed driver if found and valid.
   */
  installedDriver?: OracleOCIDriverInfo;

  /**
   * Validation errors
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Input for the service task to upload an OCI driver.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UploadOCIDriverTaskInput {
  /**
   * File share information for the OCI driver archive.
   */
  driverShare?: FileShare;
}

/**
 * Output for the service task to upload an OCI driver.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UploadOCIDriverTaskOutput {
  /**
   * The name of the driver package that was validated and uploaded.
   */
  @visibility(Lifecycle.Read)
  driverPackageName?: string;

  /**
   * Validation errors
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Input for the service task to install an OCI driver.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InstallOCIDriverTaskInput {
  /**
   * Name of the uploaded driver package to install.
   */
  driverPackageName?: string;
}

/**
 * Output for the service task to install an OCI driver.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InstallOCIDriverTaskOutput {
  /**
   * Validation errors
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Description of an action supported by the Azure Database Migration Service (classic)
 */
model ServiceOperation {
  /**
   * The fully qualified action name, e.g. Microsoft.DataMigration/services/read
   */
  name?: string;

  /**
   * Localized display text
   */
  display?: ServiceOperationDisplay;
}

/**
 * Localized display text
 */
model ServiceOperationDisplay {
  /**
   * The localized resource provider name
   */
  provider?: string;

  /**
   * The localized resource type name
   */
  resource?: string;

  /**
   * The localized operation name
   */
  operation?: string;

  /**
   * The localized operation description
   */
  description?: string;
}

/**
 * OData page of action (operation) objects
 */
model ServiceOperationList is Azure.Core.Page<ServiceOperation>;

/**
 * Properties for the task that checks for OCI drivers.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CheckOCIDriverTaskProperties extends ProjectTaskProperties {
  /**
   * Input for the service task to check for OCI drivers.
   */
  input?: CheckOCIDriverTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: CheckOCIDriverTaskOutput[];

  /**
   * Task type.
   */
  taskType: "Service.Check.OCI";
}

/**
 * Properties for the task that uploads an OCI driver.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UploadOCIDriverTaskProperties extends ProjectTaskProperties {
  /**
   * Input for the service task to upload an OCI driver.
   */
  input?: UploadOCIDriverTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: UploadOCIDriverTaskOutput[];

  /**
   * Task type.
   */
  taskType: "Service.Upload.OCI";
}

/**
 * Properties for the task that installs an OCI driver.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InstallOCIDriverTaskProperties extends ProjectTaskProperties {
  /**
   * Input for the service task to install an OCI driver.
   */
  input?: InstallOCIDriverTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: InstallOCIDriverTaskOutput[];

  /**
   * Task type.
   */
  taskType: "Service.Install.OCI";
}

/**
 * Properties for the task that validates the connection to and provides information about a MongoDB server
 */
model ConnectToMongoDbTaskProperties extends ProjectTaskProperties {
  /**
   * Describes a connection to a MongoDB data source
   */
  input?: MongoDbConnectionInfo;

  /**
   * An array containing a single MongoDbClusterInfo object
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: MongoDbClusterInfo[];

  /**
   * Task type.
   */
  taskType: "Connect.MongoDb";
}

/**
 * Properties for the task that validates connection to SQL Server and also validates source server requirements
 */
model ConnectToSourceSqlServerTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ConnectToSourceSqlServerTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ConnectToSourceSqlServerTaskOutput[];

  /**
   * Task id
   */
  taskId?: string;

  /**
   * Task type.
   */
  taskType: "ConnectToSource.SqlServer";
}

/**
 * Properties for the task that validates connection to SQL Server and source server requirements for online migration
 */
model ConnectToSourceSqlServerSyncTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ConnectToSourceSqlServerTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ConnectToSourceSqlServerTaskOutput[];

  /**
   * Task type.
   */
  taskType: "ConnectToSource.SqlServer.Sync";
}

/**
 * Properties for the task that validates connection to PostgreSQL server and source server requirements for online migration
 */
model ConnectToSourcePostgreSqlSyncTaskProperties
  extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ConnectToSourcePostgreSqlSyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ConnectToSourcePostgreSqlSyncTaskOutput[];

  /**
   * Task type.
   */
  taskType: "ConnectToSource.PostgreSql.Sync";
}

/**
 * Properties for the task that validates MySQL database connection
 */
model ConnectToSourceMySqlTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ConnectToSourceMySqlTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ConnectToSourceNonSqlTaskOutput[];

  /**
   * Task type.
   */
  taskType: "ConnectToSource.MySql";
}

/**
 * Output for connect to MySQL type source
 */
model ConnectToSourceNonSqlTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Server brand version
   */
  @visibility(Lifecycle.Read)
  sourceServerBrandVersion?: string;

  /**
   * Server properties
   */
  @visibility(Lifecycle.Read)
  serverProperties?: ServerProperties;

  /**
   * List of databases on the server
   */
  @visibility(Lifecycle.Read)
  databases?: string[];

  /**
   * Validation errors associated with the task
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Server properties for MySQL type source
 */
model ServerProperties {
  /**
   * Name of the server platform
   */
  @visibility(Lifecycle.Read)
  serverPlatform?: string;

  /**
   * Name of the server
   */
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * Version of the database server
   */
  @visibility(Lifecycle.Read)
  serverVersion?: string;

  /**
   * Edition of the database server
   */
  @visibility(Lifecycle.Read)
  serverEdition?: string;

  /**
   * Version of the operating system
   */
  @visibility(Lifecycle.Read)
  serverOperatingSystemVersion?: string;

  /**
   * Number of databases in the server
   */
  @visibility(Lifecycle.Read)
  serverDatabaseCount?: int32;
}

/**
 * Properties for the task that validates Oracle database connection
 */
model ConnectToSourceOracleSyncTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ConnectToSourceOracleSyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ConnectToSourceOracleSyncTaskOutput[];

  /**
   * Task type.
   */
  taskType: "ConnectToSource.Oracle.Sync";
}

/**
 * Properties for the task that validates connection to SQL DB and target server requirements
 */
model ConnectToTargetSqlDbTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ConnectToTargetSqlDbTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ConnectToTargetSqlDbTaskOutput[];

  /**
   * DateTime in UTC when the task was created
   */
  createdOn?: string;

  /**
   * Task type.
   */
  taskType: "ConnectToTarget.SqlDb";
}

/**
 * Properties for the task that validates connection to SQL DB and target server requirements for online migration
 */
model ConnectToTargetSqlSqlDbSyncTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ConnectToTargetSqlSqlDbSyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ConnectToTargetSqlDbTaskOutput[];

  /**
   * Task type.
   */
  taskType: "ConnectToTarget.SqlDb.Sync";
}

/**
 * Properties for the task that validates connection to Azure Database For PostgreSQL server and target server requirements for online migration
 */
model ConnectToTargetAzureDbForPostgreSqlSyncTaskProperties
  extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ConnectToTargetAzureDbForPostgreSqlSyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ConnectToTargetAzureDbForPostgreSqlSyncTaskOutput[];

  /**
   * Task type.
   */
  taskType: "ConnectToTarget.AzureDbForPostgreSql.Sync";
}

/**
 * Properties for the task that validates connection to Azure Database For PostgreSQL server and target server requirements for online migration for Oracle source.
 */
model ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskProperties
  extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskOutput[];

  /**
   * Task type.
   */
  taskType: "ConnectToTarget.Oracle.AzureDbForPostgreSql.Sync";
}

/**
 * Properties for the task that collects user tables for the given list of databases
 */
model GetUserTablesSqlTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: GetUserTablesSqlTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: GetUserTablesSqlTaskOutput[];

  /**
   * Task id
   */
  taskId?: string;

  /**
   * Task type.
   */
  taskType: "GetUserTables.Sql";
}

/**
 * Properties for the task that collects user tables for the given list of databases
 */
model GetUserTablesSqlSyncTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: GetUserTablesSqlSyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: GetUserTablesSqlSyncTaskOutput[];

  /**
   * Task type.
   */
  taskType: "GetUserTables.AzureSqlDb.Sync";
}

/**
 * Properties for the task that collects user tables for the given list of Oracle schemas
 */
model GetUserTablesOracleTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: GetUserTablesOracleTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: GetUserTablesOracleTaskOutput[];

  /**
   * Task type.
   */
  taskType: "GetUserTablesOracle";
}

/**
 * Properties for the task that collects user tables for the given list of databases
 */
model GetUserTablesPostgreSqlTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: GetUserTablesPostgreSqlTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: GetUserTablesPostgreSqlTaskOutput[];

  /**
   * Task type.
   */
  taskType: "GetUserTablesPostgreSql";
}

/**
 * Properties for the task that collects user tables for the given list of databases
 */
model GetUserTablesMySqlTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: GetUserTablesMySqlTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: GetUserTablesMySqlTaskOutput[];

  /**
   * Task type.
   */
  taskType: "GetUserTablesMySql";
}

/**
 * Properties for the task that validates connection to Azure SQL Database Managed Instance
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectToTargetSqlMITaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ConnectToTargetSqlMITaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ConnectToTargetSqlMITaskOutput[];

  /**
   * Task type.
   */
  taskType: "ConnectToTarget.AzureSqlDbMI";
}

/**
 * Properties for the task that validates connection to Azure SQL Database Managed Instance
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectToTargetSqlMISyncTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ConnectToTargetSqlMISyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ConnectToTargetSqlMISyncTaskOutput[];

  /**
   * Task type.
   */
  taskType: "ConnectToTarget.AzureSqlDbMI.Sync.LRS";
}

/**
 * Properties for the task that validates connection to Azure Database for MySQL and target server requirements
 */
model ConnectToTargetAzureDbForMySqlTaskProperties
  extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ConnectToTargetAzureDbForMySqlTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ConnectToTargetAzureDbForMySqlTaskOutput[];

  /**
   * Task type.
   */
  taskType: "ConnectToTarget.AzureDbForMySql";
}

/**
 * Properties for the task that migrates data between MongoDB data sources
 */
model MigrateMongoDbTaskProperties extends ProjectTaskProperties {
  /**
   * Describes how a MongoDB data migration should be performed
   */
  input?: MongoDbMigrationSettings;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: MongoDbProgress[];

  /**
   * Task type.
   */
  taskType: "Migrate.MongoDb";
}

/**
 * Properties for task that migrates SQL Server databases to Azure SQL Database Managed Instance
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlMITaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: MigrateSqlServerSqlMITaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: MigrateSqlServerSqlMITaskOutput[];

  /**
   * task id
   */
  taskId?: string;

  /**
   * DateTime in UTC when the task was created
   */
  createdOn?: string;

  /**
   * parent task id
   */
  parentTaskId?: string;

  /**
   * whether the task can be cloned or not
   */
  isCloneable?: boolean;

  /**
   * Task type.
   */
  taskType: "Migrate.SqlServer.AzureSqlDbMI";
}

/**
 * Properties for task that migrates SQL Server databases to Azure SQL Database Managed Instance sync scenario
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateSqlServerSqlMISyncTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: MigrateSqlServerSqlMISyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: MigrateSqlServerSqlMISyncTaskOutput[];

  /**
   * DateTime in UTC when the task was created
   */
  createdOn?: string;

  /**
   * Task type.
   */
  taskType: "Migrate.SqlServer.AzureSqlDbMI.Sync.LRS";
}

/**
 * Properties for the task that migrates on-prem SQL Server databases to Azure SQL Database
 */
model MigrateSqlServerSqlDbTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: MigrateSqlServerSqlDbTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: MigrateSqlServerSqlDbTaskOutput[];

  /**
   * task id
   */
  taskId?: string;

  /**
   * whether the task can be cloned or not
   */
  isCloneable?: boolean;

  /**
   * DateTime in UTC when the task was created
   */
  createdOn?: string;

  /**
   * Task type.
   */
  taskType: "Migrate.SqlServer.SqlDb";
}

/**
 * Properties for the task that migrates on-prem SQL Server databases to Azure SQL Database for online migrations
 */
model MigrateSqlServerSqlDbSyncTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: MigrateSqlServerSqlDbSyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: MigrateSqlServerSqlDbSyncTaskOutput[];

  /**
   * Task type.
   */
  taskType: "Migrate.SqlServer.AzureSqlDb.Sync";
}

/**
 * Properties for the task that migrates MySQL databases to Azure Database for MySQL for online migrations
 */
model MigrateMySqlAzureDbForMySqlSyncTaskProperties
  extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: MigrateMySqlAzureDbForMySqlSyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: MigrateMySqlAzureDbForMySqlSyncTaskOutput[];

  /**
   * Task type.
   */
  taskType: "Migrate.MySql.AzureDbForMySql.Sync";
}

/**
 * Properties for the task that migrates MySQL databases to Azure Database for MySQL for offline migrations
 */
model MigrateMySqlAzureDbForMySqlOfflineTaskProperties
  extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: MigrateMySqlAzureDbForMySqlOfflineTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: MigrateMySqlAzureDbForMySqlOfflineTaskOutput[];

  /**
   * whether the task can be cloned or not
   */
  isCloneable?: boolean;

  /**
   * Task id
   */
  taskId?: string;

  /**
   * Task type.
   */
  taskType: "Migrate.MySql.AzureDbForMySql";
}

/**
 * Input for the task that migrates MySQL databases to Azure Database for MySQL for offline migrations
 */
model MigrateMySqlAzureDbForMySqlOfflineTaskInput {
  /**
   * Connection information for source MySQL
   */
  sourceConnectionInfo: MySqlConnectionInfo;

  /**
   * Connection information for target Azure Database for MySQL
   */
  targetConnectionInfo: MySqlConnectionInfo;

  /**
   * Databases to migrate
   */
  @identifiers(#[])
  selectedDatabases: MigrateMySqlAzureDbForMySqlOfflineDatabaseInput[];

  /**
   * Setting to set the source server read only
   */
  makeSourceServerReadOnly?: boolean;

  /**
   * Parameter to specify when the migration started
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Optional parameters for fine tuning the data transfer rate during migration
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  optionalAgentSettings?: Record<string>;

  /**
   * encrypted key for secure fields
   */
  encryptedKeyForSecureFields?: string;
}

/**
 * Database specific information for offline MySQL to Azure Database for MySQL migration task inputs
 */
model MigrateMySqlAzureDbForMySqlOfflineDatabaseInput {
  /**
   * Name of the database
   */
  name?: string;

  /**
   * Name of target database. Note: Target database will be truncated before starting migration.
   */
  targetDatabaseName?: string;

  /**
   * Mapping of source to target tables
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableMap?: Record<string>;
}

/**
 * Output for the task that migrates MySQL databases to Azure Database for MySQL for offline migrations
 */
@discriminator("resultType")
model MigrateMySqlAzureDbForMySqlOfflineTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Result type
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resultType: string;
}

/**
 * Properties for the task that migrates PostgreSQL databases to Azure Database for PostgreSQL for online migrations
 */
model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskProperties
  extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: MigratePostgreSqlAzureDbForPostgreSqlSyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput[];

  /**
   * task id
   */
  taskId?: string;

  /**
   * DateTime in UTC when the task was created
   */
  createdOn?: string;

  /**
   * whether the task can be cloned or not
   */
  isCloneable?: boolean;

  /**
   * Task type.
   */
  taskType: "Migrate.PostgreSql.AzureDbForPostgreSql.SyncV2";
}

/**
 * Properties for the task that migrates Oracle to Azure Database for PostgreSQL for online migrations
 */
model MigrateOracleAzureDbForPostgreSqlSyncTaskProperties
  extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: MigrateOracleAzureDbPostgreSqlSyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: MigrateOracleAzureDbPostgreSqlSyncTaskOutput[];

  /**
   * Task type.
   */
  taskType: "Migrate.Oracle.AzureDbForPostgreSql.Sync";
}

/**
 * Properties for task that validates migration input for SQL to Azure SQL DB sync migrations
 */
model ValidateMigrationInputSqlServerSqlDbSyncTaskProperties
  extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ValidateSyncMigrationInputSqlServerTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ValidateSyncMigrationInputSqlServerTaskOutput[];

  /**
   * Task type.
   */
  taskType: "ValidateMigrationInput.SqlServer.SqlDb.Sync";
}

/**
 * Input for task that validates migration input for SQL sync migrations
 */
model ValidateSyncMigrationInputSqlServerTaskInput {
  /**
   * Information for connecting to source SQL server
   */
  sourceConnectionInfo: SqlConnectionInfo;

  /**
   * Information for connecting to target
   */
  targetConnectionInfo: SqlConnectionInfo;

  /**
   * Databases to migrate
   */
  @identifiers(#[])
  selectedDatabases: MigrateSqlServerSqlDbSyncDatabaseInput[];
}

/**
 * Output for task that validates migration input for SQL sync migrations
 */
model ValidateSyncMigrationInputSqlServerTaskOutput {
  /**
   * Database identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of database
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Errors associated with a selected database object
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Properties for task that validates migration input for SQL to Azure SQL Database Managed Instance
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ValidateMigrationInputSqlServerSqlMITaskProperties
  extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ValidateMigrationInputSqlServerSqlMITaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ValidateMigrationInputSqlServerSqlMITaskOutput[];

  /**
   * Task type.
   */
  taskType: "ValidateMigrationInput.SqlServer.AzureSqlDbMI";
}

/**
 * Input for task that validates migration input for SQL to Azure SQL Managed Instance
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ValidateMigrationInputSqlServerSqlMITaskInput {
  /**
   * Information for connecting to source
   */
  sourceConnectionInfo: SqlConnectionInfo;

  /**
   * Information for connecting to target
   */
  targetConnectionInfo: SqlConnectionInfo;

  /**
   * Databases to migrate
   */
  @identifiers(#[])
  selectedDatabases: MigrateSqlServerSqlMIDatabaseInput[];

  /**
   * Logins to migrate
   */
  selectedLogins?: string[];

  /**
   * Backup file share information for all selected databases.
   */
  backupFileShare?: FileShare;

  /**
   * SAS URI of Azure Storage Account Container to be used for storing backup files.
   */
  backupBlobShare: BlobShare;

  /**
   * Backup Mode to specify whether to use existing backup or create new backup.
   */
  backupMode?: BackupMode;
}

/**
 * Output for task that validates migration input for SQL to Azure SQL Managed Instance migrations
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ValidateMigrationInputSqlServerSqlMITaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of database
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Errors associated with the RestoreDatabaseName
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  restoreDatabaseNameErrors?: ReportableException[];

  /**
   * Errors associated with the BackupFolder path
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  backupFolderErrors?: ReportableException[];

  /**
   * Errors associated with backup share user name and password credentials
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  backupShareCredentialsErrors?: ReportableException[];

  /**
   * Errors associated with the storage account provided.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  backupStorageAccountErrors?: ReportableException[];

  /**
   * Errors associated with existing backup files.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  existingBackupErrors?: ReportableException[];

  /**
   * Information about backup files when existing backup mode is used.
   */
  databaseBackupInfo?: DatabaseBackupInfo;
}

/**
 * Information about backup files when existing backup mode is used.
 */
model DatabaseBackupInfo {
  /**
   * Database name.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Backup Type.
   */
  @visibility(Lifecycle.Read)
  backupType?: BackupType;

  /**
   * The list of backup files for the current database.
   */
  @visibility(Lifecycle.Read)
  backupFiles?: string[];

  /**
   * Position of current database backup in the file.
   */
  @visibility(Lifecycle.Read)
  position?: int32;

  /**
   * Database was damaged when backed up, but the backup operation was requested to continue despite errors.
   */
  @visibility(Lifecycle.Read)
  isDamaged?: boolean;

  /**
   * Whether the backup set is compressed
   */
  @visibility(Lifecycle.Read)
  isCompressed?: boolean;

  /**
   * Number of files in the backup set.
   */
  @visibility(Lifecycle.Read)
  familyCount?: int32;

  /**
   * Date and time when the backup operation finished.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupFinishDate?: utcDateTime;
}

/**
 * Properties for task that validates migration input for SQL to Azure SQL Database Managed Instance sync scenario
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ValidateMigrationInputSqlServerSqlMISyncTaskProperties
  extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ValidateMigrationInputSqlServerSqlMISyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ValidateMigrationInputSqlServerSqlMISyncTaskOutput[];

  /**
   * Task type.
   */
  taskType: "ValidateMigrationInput.SqlServer.AzureSqlDbMI.Sync.LRS";
}

/**
 * Input for task that migrates SQL Server databases to Azure SQL Database Managed Instance online scenario.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ValidateMigrationInputSqlServerSqlMISyncTaskInput
  extends SqlServerSqlMISyncTaskInput {}

/**
 * Output for task that validates migration input for Azure SQL Database Managed Instance online migration
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ValidateMigrationInputSqlServerSqlMISyncTaskOutput {
  /**
   * Database identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of database
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Errors associated with a selected database object
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationErrors?: ReportableException[];
}

/**
 * Properties for the task that validates a migration between MongoDB data sources
 */
model ValidateMongoDbTaskProperties extends ProjectTaskProperties {
  /**
   * Describes how a MongoDB data migration should be performed
   */
  input?: MongoDbMigrationSettings;

  /**
   * An array containing a single MongoDbMigrationProgress object
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: MongoDbMigrationProgress[];

  /**
   * Task type.
   */
  taskType: "Validate.MongoDb";
}

/**
 * Properties for the task that validates a migration for Oracle to Azure Database for PostgreSQL for online migrations
 */
model ValidateOracleAzureDbForPostgreSqlSyncTaskProperties
  extends ProjectTaskProperties {
  /**
   * Input for the task that migrates Oracle databases to Azure Database for PostgreSQL for online migrations
   */
  input?: MigrateOracleAzureDbPostgreSqlSyncTaskInput;

  /**
   * An array containing a single validation error response object
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: ValidateOracleAzureDbPostgreSqlSyncTaskOutput[];

  /**
   * Task type.
   */
  taskType: "Validate.Oracle.AzureDbPostgreSql.Sync";
}

/**
 * Properties for the task that gets TDE certificates in Base64 encoded format.
 */
model GetTdeCertificatesSqlTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: GetTdeCertificatesSqlTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: GetTdeCertificatesSqlTaskOutput[];

  /**
   * Task type.
   */
  taskType: "GetTDECertificates.Sql";
}

/**
 * Properties for task that migrates SSIS packages from SQL Server databases to Azure SQL Database Managed Instance.
 */
model MigrateSsisTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: MigrateSsisTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  output?: MigrateSsisTaskOutput[];

  /**
   * Task type.
   */
  taskType: "Migrate.Ssis";
}

/**
 * Information about a single database
 */
model Database {
  /**
   * Unique identifier for the database
   */
  id?: string;

  /**
   * Name of the database
   */
  name?: string;

  /**
   * SQL Server compatibility level of database
   */
  compatibilityLevel?: DatabaseCompatLevel;

  /**
   * Collation name of the database
   */
  collation?: string;

  /**
   * Name of the server
   */
  serverName?: string;

  /**
   * Fully qualified name
   */
  fqdn?: string;

  /**
   * Install id of the database
   */
  installId?: string;

  /**
   * Version of the server
   */
  serverVersion?: string;

  /**
   * Edition of the server
   */
  serverEdition?: string;

  /**
   * Product level of the server (RTM, SP, CTP).
   */
  serverLevel?: string;

  /**
   * Default path of the data files
   */
  serverDefaultDataPath?: string;

  /**
   * Default path of the log files
   */
  serverDefaultLogPath?: string;

  /**
   * Default path of the backup folder
   */
  serverDefaultBackupPath?: string;

  /**
   * Number of cores on the server
   */
  serverCoreCount?: int32;

  /**
   * Number of cores on the server that have VISIBLE ONLINE status
   */
  serverVisibleOnlineCoreCount?: int32;

  /**
   * State of the database
   */
  databaseState?: DatabaseState;

  /**
   * The unique Server Id
   */
  serverId?: string;
}

/**
 * A representation of the name of an object in a database
 */
model DatabaseObjectName {
  /**
   * The unescaped name of the database containing the object
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * The unescaped name of the object
   */
  @visibility(Lifecycle.Read)
  objectName?: string;

  /**
   * The unescaped name of the schema containing the object
   */
  @visibility(Lifecycle.Read)
  schemaName?: string;

  /**
   * Type of the object in the database
   */
  objectType?: ObjectType;
}

/**
 * Common metadata for migration projects
 */
model DataMigrationProjectMetadata {
  /**
   * Source server name
   */
  @visibility(Lifecycle.Read)
  sourceServerName?: string;

  /**
   * Source server port number
   */
  @visibility(Lifecycle.Read)
  sourceServerPort?: string;

  /**
   * Source username
   */
  @visibility(Lifecycle.Read)
  sourceUsername?: string;

  /**
   * Target server name
   */
  @visibility(Lifecycle.Read)
  targetServerName?: string;

  /**
   * Target username
   */
  @visibility(Lifecycle.Read)
  targetUsername?: string;

  /**
   * Target database name
   */
  @visibility(Lifecycle.Read)
  targetDbName?: string;

  /**
   * Whether target connection is Windows authentication
   */
  @visibility(Lifecycle.Read)
  targetUsingWinAuth?: boolean;

  /**
   * List of tables selected for migration
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  selectedMigrationTables?: MigrationTableMetadata[];
}

/**
 * Metadata for tables selected in migration project
 */
model MigrationTableMetadata {
  /**
   * Source table name
   */
  @visibility(Lifecycle.Read)
  sourceTableName?: string;

  /**
   * Target table name
   */
  @visibility(Lifecycle.Read)
  targetTableName?: string;
}

/**
 * Input for the task that reads configuration from project artifacts
 */
model GetProjectDetailsNonSqlTaskInput {
  /**
   * Name of the migration project
   */
  projectName: string;

  /**
   * A URL that points to the location to access project artifacts
   */
  projectLocation: string;
}

/**
 * Base class for non sql migration task input
 */
model NonSqlMigrationTaskInput {
  /**
   * Information for connecting to target
   */
  targetConnectionInfo: SqlConnectionInfo;

  /**
   * Target database name
   */
  targetDatabaseName: string;

  /**
   * Name of the migration project
   */
  projectName: string;

  /**
   * A URL that points to the drop location to access project artifacts
   */
  projectLocation: string;

  /**
   * Metadata of the tables selected for migration
   */
  @identifiers(#[])
  selectedTables: NonSqlDataMigrationTable[];
}

/**
 * Defines metadata for table to be migrated
 */
model NonSqlDataMigrationTable {
  /**
   * Source table name
   */
  sourceName?: string;
}

/**
 * Base class for non sql migration task output
 */
model NonSqlMigrationTaskOutput {
  /**
   * Result identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current state of migration
   */
  @visibility(Lifecycle.Read)
  status?: MigrationStatus;

  /**
   * Results of the migration. The key contains the table name and the value the table result object
   */
  @visibility(Lifecycle.Read)
  dataMigrationTableResults?: string;

  /**
   * Message about the progress of the migration
   */
  @visibility(Lifecycle.Read)
  progressMessage?: string;

  /**
   * Name of source server
   */
  @visibility(Lifecycle.Read)
  sourceServerName?: string;

  /**
   * Name of target server
   */
  @visibility(Lifecycle.Read)
  targetServerName?: string;
}

/**
 * Object used to report the data migration results of a table
 */
model NonSqlDataMigrationTableResult {
  /**
   * Result code of the data migration
   */
  @visibility(Lifecycle.Read)
  resultCode?: DataMigrationResultCode;

  /**
   * Name of the source table
   */
  @visibility(Lifecycle.Read)
  sourceName?: string;

  /**
   * Name of the target table
   */
  @visibility(Lifecycle.Read)
  targetName?: string;

  /**
   * Number of rows in the source table
   */
  @visibility(Lifecycle.Read)
  sourceRowCount?: int64;

  /**
   * Number of rows in the target table
   */
  @visibility(Lifecycle.Read)
  targetRowCount?: int64;

  /**
   * Time taken to migrate the data
   */
  @visibility(Lifecycle.Read)
  elapsedTimeInMiliseconds?: float64;

  /**
   * List of errors, if any, during migration
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: DataMigrationError[];
}

/**
 * Migration Task errors
 */
model DataMigrationError {
  /**
   * Error description
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Error type
   */
  type?: ErrorType;
}

/**
 * Database specific information for SQL to SQL migration task inputs
 */
model MigrateSqlServerSqlServerDatabaseInput {
  /**
   * Name of the database
   */
  name?: string;

  /**
   * Name of the database at destination
   */
  restoreDatabaseName?: string;

  /**
   * The backup and restore folder
   */
  backupAndRestoreFolder?: string;

  /**
   * The list of database files
   */
  @identifiers(#[])
  databaseFiles?: DatabaseFileInput[];
}

/**
 * Database file specific information for input
 */
model DatabaseFileInput {
  /**
   * Unique identifier for database file
   */
  id?: string;

  /**
   * Logical name of the file
   */
  logicalName?: string;

  /**
   * Operating-system full path of the file
   */
  physicalFullName?: string;

  /**
   * Suggested full path of the file for restoring
   */
  restoreFullName?: string;

  /**
   * Database file type
   */
  fileType?: DatabaseFileType;
}

/**
 * Server role migration result
 */
model StartMigrationScenarioServerRoleResult {
  /**
   * Name of server role.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Current state of migration
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Migration exceptions and warnings.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  exceptionsAndWarnings?: ReportableException[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateMySqlAzureDbForMySqlOfflineTaskOutputMigrationLevel
  extends MigrateMySqlAzureDbForMySqlOfflineTaskOutput {
  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Duration of task execution in seconds.
   */
  @visibility(Lifecycle.Read)
  durationInSeconds?: int64;

  /**
   * Current status of migration
   */
  @visibility(Lifecycle.Read)
  status?: MigrationStatus;

  /**
   * Migration status message
   */
  @visibility(Lifecycle.Read)
  statusMessage?: string;

  /**
   * Migration progress message
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Selected databases as a map from database name to database id
   */
  databases?: string;

  /**
   * Summary of database results in the migration
   */
  @visibility(Lifecycle.Read)
  databaseSummary?: string;

  /**
   * Migration Report Result, provides unique url for downloading your migration report.
   */
  migrationReportResult?: MigrationReportResult;

  /**
   * Source server version
   */
  @visibility(Lifecycle.Read)
  sourceServerVersion?: string;

  /**
   * Source server brand version
   */
  @visibility(Lifecycle.Read)
  sourceServerBrandVersion?: string;

  /**
   * Target server version
   */
  @visibility(Lifecycle.Read)
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility(Lifecycle.Read)
  targetServerBrandVersion?: string;

  /**
   * Migration exceptions and warnings.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Last time the storage was updated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStorageUpdate?: utcDateTime;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateMySqlAzureDbForMySqlOfflineTaskOutputDatabaseLevel
  extends MigrateMySqlAzureDbForMySqlOfflineTaskOutput {
  /**
   * Name of the database
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current state of migration
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Migration stage that this database is in
   */
  @visibility(Lifecycle.Read)
  stage?: DatabaseMigrationStage;

  /**
   * Status message
   */
  @visibility(Lifecycle.Read)
  statusMessage?: string;

  /**
   * Migration progress message
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Number of objects
   */
  @visibility(Lifecycle.Read)
  numberOfObjects?: int64;

  /**
   * Number of successfully completed objects
   */
  @visibility(Lifecycle.Read)
  numberOfObjectsCompleted?: int64;

  /**
   * Number of database/object errors.
   */
  @visibility(Lifecycle.Read)
  errorCount?: int64;

  /**
   * Wildcard string prefix to use for querying all errors of the item
   */
  @visibility(Lifecycle.Read)
  errorPrefix?: string;

  /**
   * Wildcard string prefix to use for querying all sub-tem results of the item
   */
  @visibility(Lifecycle.Read)
  resultPrefix?: string;

  /**
   * Migration exceptions and warnings.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Last time the storage was updated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStorageUpdate?: utcDateTime;

  /**
   * Summary of object results in the migration
   */
  @visibility(Lifecycle.Read)
  objectSummary?: string;

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateMySqlAzureDbForMySqlOfflineTaskOutputTableLevel
  extends MigrateMySqlAzureDbForMySqlOfflineTaskOutput {
  /**
   * Name of the item
   */
  @visibility(Lifecycle.Read)
  objectName?: string;

  /**
   * Migration start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current state of migration
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Status message
   */
  @visibility(Lifecycle.Read)
  statusMessage?: string;

  /**
   * Number of items
   */
  @visibility(Lifecycle.Read)
  itemsCount?: int64;

  /**
   * Number of successfully completed items
   */
  @visibility(Lifecycle.Read)
  itemsCompletedCount?: int64;

  /**
   * Wildcard string prefix to use for querying all errors of the item
   */
  @visibility(Lifecycle.Read)
  errorPrefix?: string;

  /**
   * Wildcard string prefix to use for querying all sub-tem results of the item
   */
  @visibility(Lifecycle.Read)
  resultPrefix?: string;

  /**
   * Last time the storage was updated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStorageUpdate?: utcDateTime;

  /**
   * Result type
   */
  resultType: "TableLevelOutput";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateMySqlAzureDbForMySqlOfflineTaskOutputError
  extends MigrateMySqlAzureDbForMySqlOfflineTaskOutput {
  /**
   * Migration error
   */
  @visibility(Lifecycle.Read)
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}
