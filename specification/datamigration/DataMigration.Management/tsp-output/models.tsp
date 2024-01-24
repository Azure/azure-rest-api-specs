import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataMigration;

interface Operations extends Azure.ResourceManager.Operations {}

enum ResourceType {
  SqlMi,
  SqlVm,
  SqlDb,
}

enum OperationOrigin {
  user,
  system,
}

/**
 * The scale type applicable to the SKU.
 */
enum ResourceSkuCapacityScaleType {
  Automatic,
  Manual,
  None,
}

/**
 * The type of restrictions.
 */
enum ResourceSkuRestrictionsType {
  location,
}

/**
 * The reason code for restriction.
 */
enum ResourceSkuRestrictionsReasonCode {
  QuotaId,
  NotAvailableForSubscription,
}

/**
 * The resource's provisioning state
 */
enum ServiceProvisioningState {
  Accepted,
  Deleting,
  Deploying,
  Stopped,
  Stopping,
  Starting,
  FailedToStart,
  FailedToStop,
  Succeeded,
  Failed,
}

/**
 * The scalability approach
 */
enum ServiceScalability {
  none,
  manual,
  automatic,
}

/**
 * Task type.
 */
enum TaskType {
  `Connect.MongoDb`,
  `ConnectToSource.SqlServer`,
  `ConnectToSource.SqlServer.Sync`,
  `ConnectToSource.PostgreSql.Sync`,
  `ConnectToSource.MySql`,
  `ConnectToSource.Oracle.Sync`,
  `ConnectToTarget.SqlDb`,
  `ConnectToTarget.SqlDb.Sync`,
  `ConnectToTarget.AzureDbForPostgreSql.Sync`,
  `ConnectToTarget.Oracle.AzureDbForPostgreSql.Sync`,
  `ConnectToTarget.AzureSqlDbMI`,
  `ConnectToTarget.AzureSqlDbMI.Sync.LRS`,
  `ConnectToTarget.AzureDbForMySql`,
  `GetUserTables.Sql`,
  `GetUserTables.AzureSqlDb.Sync`,
  GetUserTablesOracle,
  GetUserTablesPostgreSql,
  GetUserTablesMySql,
  `Migrate.MongoDb`,
  `Migrate.SqlServer.AzureSqlDbMI`,
  `Migrate.SqlServer.AzureSqlDbMI.Sync.LRS`,
  `Migrate.SqlServer.SqlDb`,
  `Migrate.SqlServer.AzureSqlDb.Sync`,
  `Migrate.MySql.AzureDbForMySql.Sync`,
  `Migrate.MySql.AzureDbForMySql`,
  `Migrate.PostgreSql.AzureDbForPostgreSql.SyncV2`,
  `Migrate.Oracle.AzureDbForPostgreSql.Sync`,
  `ValidateMigrationInput.SqlServer.SqlDb.Sync`,
  `ValidateMigrationInput.SqlServer.AzureSqlDbMI`,
  `ValidateMigrationInput.SqlServer.AzureSqlDbMI.Sync.LRS`,
  `Validate.MongoDb`,
  `Validate.Oracle.AzureDbPostgreSql.Sync`,
  `GetTDECertificates.Sql`,
  `Migrate.Ssis`,
  `Service.Check.OCI`,
  `Service.Upload.OCI`,
  `Service.Install.OCI`,
  MigrateSchemaSqlServerSqlDb,
}

/**
 * The state of the task. This is ignored if submitted.
 */
enum TaskState {
  Unknown,
  Queued,
  Running,
  Canceled,
  Succeeded,
  Failed,
  FailedInputValidation,
  Faulted,
}

/**
 * Command type.
 */
enum CommandType {
  `Migrate.Sync.Complete.Database`,
  `Migrate.SqlServer.AzureDbSqlMi.Complete`,
  cancel,
  finish,
  restart,
}

/**
 * The state of the command. This is ignored if submitted.
 */
enum CommandState {
  Unknown,
  Accepted,
  Running,
  Succeeded,
  Failed,
}

/**
 * The reason why the name is not available, if nameAvailable is false
 */
enum NameCheckFailureReason {
  AlreadyExists,
  Invalid,
}

/**
 * Source platform of the project
 */
enum ProjectSourcePlatform {
  SQL,
  MySQL,
  PostgreSql,
  MongoDb,
  Unknown,
}

/**
 * Target platform of the project
 */
enum ProjectTargetPlatform {
  SQLDB,
  SQLMI,
  AzureDbForMySql,
  AzureDbForPostgreSql,
  MongoDb,
  Unknown,
}

/**
 * The project's provisioning state
 */
enum ProjectProvisioningState {
  Deleting,
  Succeeded,
}

/**
 * An enumeration of possible authentication types when connecting
 */
enum AuthenticationType {
  None,
  WindowsAuthentication,
  SqlAuthentication,
  ActiveDirectoryIntegrated,
  ActiveDirectoryPassword,
}

/**
 * An enumeration of source platform types
 */
enum SqlSourcePlatform {
  SqlOnPrem,
}

/**
 * Enum of the different backup types.
 */
enum BackupType {
  Database,
  TransactionLog,
  File,
  DifferentialDatabase,
  DifferentialFile,
  Partial,
  DifferentialPartial,
}

/**
 * An enumeration of Status of the log backup file.
 */
enum BackupFileStatus {
  Arrived,
  Queued,
  Uploading,
  Uploaded,
  Restoring,
  Restored,
  Cancelled,
}

/**
 * An enumeration of possible target types when migrating from MySQL
 */
enum MySqlTargetPlatformType {
  SqlServer,
  AzureDbForMySQL,
}

/**
 * An enumeration of SQL Server database file types
 */
enum DatabaseFileType {
  Rows,
  Log,
  Filestream,
  NotSupported,
  Fulltext,
}

/**
 * An enumeration of SQL Server database compatibility levels
 */
enum DatabaseCompatLevel {
  CompatLevel80,
  CompatLevel90,
  CompatLevel100,
  CompatLevel110,
  CompatLevel120,
  CompatLevel130,
  CompatLevel140,
}

/**
 * An enumeration of SQL Server Database states
 */
enum DatabaseState {
  Online,
  Restoring,
  Recovering,
  RecoveryPending,
  Suspect,
  Emergency,
  Offline,
  Copying,
  OfflineSecondary,
}

/**
 * Enum mapping of SMO LoginType.
 */
enum LoginType {
  WindowsUser,
  WindowsGroup,
  SqlLogin,
  Certificate,
  AsymmetricKey,
  ExternalUser,
  ExternalGroup,
}

/**
 * Option for how schema is extracted and applied to target
 */
enum SchemaMigrationOption {
  None,
  ExtractFromSource,
  UseStorageFile,
}

/**
 * Current state of migration
 */
enum MigrationState {
  None,
  InProgress,
  Failed,
  Warning,
  Completed,
  Skipped,
  Stopped,
}

/**
 * Current stage of schema migration
 */
enum SchemaMigrationStage {
  NotStarted,
  ValidatingInputs,
  CollectingObjects,
  DownloadingScript,
  GeneratingScript,
  UploadingScript,
  DeployingSchema,
  Completed,
  CompletedWithWarnings,
  Failed,
}

/**
 * Enum of the different state of database level online migration.
 */
enum SyncDatabaseMigrationReportingState {
  UNDEFINED,
  CONFIGURING,
  INITIALIAZING,
  STARTING,
  RUNNING,
  READY_TO_COMPLETE,
  COMPLETING,
  COMPLETE,
  CANCELLING,
  CANCELLED,
  FAILED,
  VALIDATING,
  VALIDATION_COMPLETE,
  VALIDATION_FAILED,
  RESTORE_IN_PROGRESS,
  RESTORE_COMPLETED,
  BACKUP_IN_PROGRESS,
  BACKUP_COMPLETED,
}

/**
 * Enum of the different state of table level online migration.
 */
enum SyncTableMigrationState {
  BEFORE_LOAD,
  FULL_LOAD,
  COMPLETED,
  CANCELED,
  ERROR,
  FAILED,
}

/**
 * An enumeration of source type
 */
enum ScenarioSource {
  Access,
  DB2,
  MySQL,
  Oracle,
  SQL,
  Sybase,
  PostgreSQL,
  MongoDB,
  SQLRDS,
  MySQLRDS,
  PostgreSQLRDS,
}

/**
 * An enumeration of target type
 */
enum ScenarioTarget {
  SQLServer,
  SQLDB,
  SQLDW,
  SQLMI,
  AzureDBForMySql,
  AzureDBForPostgresSQL,
  MongoDB,
}

/**
 * Wrapper for replicate reported migration states.
 */
enum ReplicateMigrationState {
  UNDEFINED,
  VALIDATING,
  PENDING,
  COMPLETE,
  ACTION_REQUIRED,
  FAILED,
}

/**
 * Current status of migration
 */
enum MigrationStatus {
  Default,
  Connecting,
  SourceAndTargetSelected,
  SelectLogins,
  Configured,
  Running,
  Error,
  Stopped,
  Completed,
  CompletedWithWarnings,
}

/**
 * Current status of the validation
 */
enum ValidationStatus {
  Default,
  NotStarted,
  Initialized,
  InProgress,
  Completed,
  CompletedWithIssues,
  Stopped,
  Failed,
}

/**
 * Current stage of migration
 */
enum DatabaseMigrationStage {
  None,
  Initialize,
  Backup,
  FileCopy,
  Restore,
  Completed,
}

/**
 * Severity of the validation error
 */
enum Severity {
  Message,
  Warning,
  Error,
}

/**
 * An enumeration of type of objects
 */
enum ObjectType {
  StoredProcedures,
  Table,
  User,
  View,
  Function,
}

/**
 * Type of the actual difference for the compared object, while performing schema comparison
 */
enum UpdateActionType {
  DeletedOnTarget,
  ChangedOnTarget,
  AddedOnTarget,
}

/**
 * Database level migration state.
 */
enum DatabaseMigrationState {
  UNDEFINED,
  INITIAL,
  FULL_BACKUP_UPLOAD_START,
  LOG_SHIPPING_START,
  UPLOAD_LOG_FILES_START,
  CUTOVER_START,
  POST_CUTOVER_COMPLETE,
  COMPLETED,
  CANCELLED,
  FAILED,
}

/**
 * An enumeration of backup modes
 */
enum BackupMode {
  CreateBackup,
  ExistingBackup,
}

/**
 * Enum of the different stage of login migration.
 */
enum LoginMigrationStage {
  None,
  Initialize,
  LoginMigration,
  EstablishUserMapping,
  AssignRoleMembership,
  AssignRoleOwnership,
  EstablishServerPermissions,
  EstablishObjectPermissions,
  Completed,
}

/**
 * An enumeration of supported source SSIS store type in DMS
 */
enum SsisStoreType {
  SsisCatalog,
}

/**
 * The overwrite option for SSIS object migration, only ignore and overwrite are supported in DMS now and future may add Reuse option for container object
 */
enum SsisMigrationOverwriteOption {
  Ignore,
  Overwrite,
}

/**
 * Current stage of SSIS migration
 */
enum SsisMigrationStage {
  None,
  Initialize,
  InProgress,
  Completed,
}

/**
 * The field ordering
 */
enum MongoDbShardKeyOrder {
  Forward,
  Reverse,
  Hashed,
}

/**
 * The type of data source
 */
enum MongoDbClusterType {
  BlobContainer,
  CosmosDb,
  MongoDb,
}

/**
 * The type of error or warning
 */
enum MongoDbErrorType {
  Error,
  ValidationError,
  Warning,
}

/**
 * The type of progress object
 */
enum MongoDbProgressResultType {
  Migration,
  Database,
  Collection,
}

enum MongoDbMigrationState {
  NotStarted,
  ValidatingInput,
  Initializing,
  Restarting,
  Copying,
  InitialReplay,
  Replaying,
  Finalizing,
  Complete,
  Canceled,
  Failed,
}

/**
 * Describes how changes will be replicated from the source to the target. The default is OneTime.
 */
enum MongoDbReplication {
  Disabled,
  OneTime,
  Continuous,
}

/**
 * Result code of the data migration
 */
enum DataMigrationResultCode {
  Initial,
  Completed,
  ObjectNotExistsInSource,
  ObjectNotExistsInTarget,
  TargetObjectIsInaccessible,
  FatalError,
}

/**
 * Error type
 */
enum ErrorType {
  Default,
  Warning,
  Error,
}

/**
 * Permission group for validations. These groups will run a set of permissions for validating user activity. Select the permission group for the activity that you are performing.
 */
@fixed
enum ServerLevelPermissionsGroup {
  Default,
  MigrationFromSqlServerToAzureDB,
  MigrationFromSqlServerToAzureMI,
  MigrationFromMySQLToAzureDBForMySQL,
  MigrationFromSqlServerToAzureVM,
}

/**
 * Database Migration Resource properties for SQL database.
 */
model DatabaseMigrationSqlDBProperties extends DatabaseMigrationProperties {
  /**
   * Detailed migration status. Not included by default.
   */
  @visibility("read")
  migrationStatusDetails?: SqlDbMigrationStatusDetails;

  /**
   * Target SQL DB connection details.
   */
  targetSqlConnection?: SqlConnectionInformation;

  /**
   * Offline configuration.
   */
  @visibility("read")
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
  @visibility("read")
  migrationState?: string;

  /**
   * Sql Data Copy errors, if any.
   */
  @visibility("read")
  sqlDataCopyErrors?: string[];

  /**
   * Details on progress of ADF copy activities.
   */
  @visibility("read")
  listOfCopyProgressDetails?: CopyProgressDetails[];
}

/**
 * Details on progress of ADF copy activity
 */
model CopyProgressDetails {
  /**
   * Table Name
   */
  @visibility("read")
  tableName?: string;

  /**
   * Status of the Copy activity (InProgress, Succeeded, Failed, Canceled).
   */
  @visibility("read")
  status?: string;

  /**
   * Type of parallel copy (Dynamic range, Physical partition, none).
   */
  @visibility("read")
  parallelCopyType?: string;

  /**
   * The degree of parallelization.
   */
  @visibility("read")
  usedParallelCopies?: int32;

  /**
   * Bytes read
   */
  @visibility("read")
  dataRead?: int64;

  /**
   * Bytes written
   */
  @visibility("read")
  dataWritten?: int64;

  /**
   * Rows read
   */
  @visibility("read")
  rowsRead?: int64;

  /**
   * Rows Copied
   */
  @visibility("read")
  rowsCopied?: int64;

  /**
   * Copy Start
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  copyStart?: utcDateTime;

  /**
   * Copy throughput in KBps
   */
  @visibility("read")
  copyThroughput?: float64;

  /**
   * Copy Duration in seconds
   */
  @visibility("read")
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
  @visibility("read")
  offline?: boolean;
}

/**
 * Database Migration Resource properties.
 */
@discriminator("kind")
model DatabaseMigrationProperties {
  /**
   * Resource Id of the target resource (SQL VM or SQL Managed Instance).
   */
  @visibility("read", "create")
  scope?: string;

  /**
   * Provisioning State of migration. ProvisioningState as Succeeded implies that validations have been performed and migration has started.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Migration status.
   */
  @visibility("read")
  migrationStatus?: string;

  /**
   * Database migration start time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Database migration end time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

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
  @visibility("read")
  sourceServerName?: string;

  /**
   * Resource Id of the Migration Service.
   */
  migrationService?: string;

  /**
   * ID tracking current migration operation.
   */
  migrationOperationId?: string;

  /**
   * Error details in case of migration failure.
   */
  @visibility("read")
  migrationFailureError?: ErrorInfo;

  /**
   * Database collation to be used for the target database.
   */
  targetDatabaseCollation?: string;

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
  @visibility("read")
  code?: string;

  /**
   * Error message.
   */
  @visibility("read")
  message?: string;
}

/**
 * Migration Operation Input
 */
model MigrationOperationInput {
  /**
   * ID tracking migration operation.
   */
  migrationOperationId?: string;
}

/**
 * Database Migration Resource properties for SQL Managed Instance.
 */
model DatabaseMigrationSqlMIProperties extends DatabaseMigrationProperties {
  /**
   * Detailed migration status. Not included by default.
   */
  @visibility("read")
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
  @visibility("read")
  migrationState?: string;

  /**
   * Details of full backup set.
   */
  @visibility("read")
  fullBackupSetInfo?: SqlBackupSetInfo;

  /**
   * Last applied backup set information.
   */
  @visibility("read")
  lastRestoredBackupSetInfo?: SqlBackupSetInfo;

  /**
   * Backup sets that are currently active.
   */
  @visibility("read")
  activeBackupSets?: SqlBackupSetInfo[];

  /**
   * Files that are not valid backup files.
   */
  @visibility("read")
  invalidFiles?: string[];

  /**
   * Name of blob container.
   */
  @visibility("read")
  blobContainerName?: string;

  /**
   * Whether full backup has been applied to the target database or not.
   */
  @visibility("read")
  isFullBackupRestored?: boolean;

  /**
   * Restore blocking reason, if any
   */
  @visibility("read")
  restoreBlockingReason?: string;

  /**
   * Complete restore error message, if any
   */
  @visibility("read")
  completeRestoreErrorMessage?: string;

  /**
   * File upload blocking errors, if any.
   */
  @visibility("read")
  fileUploadBlockingErrors?: string[];

  /**
   * File name that is currently being restored.
   */
  @visibility("read")
  currentRestoringFilename?: string;

  /**
   * Last restored file name.
   */
  @visibility("read")
  lastRestoredFilename?: string;

  /**
   * Total pending log backups.
   */
  @visibility("read")
  pendingLogBackupsCount?: int32;
}

/**
 * Information of backup set
 */
model SqlBackupSetInfo {
  /**
   * Backup set id.
   */
  @visibility("read")
  backupSetId?: string;

  /**
   * First LSN of the backup set.
   */
  @visibility("read")
  firstLSN?: string;

  /**
   * Last LSN of the backup set.
   */
  @visibility("read")
  lastLSN?: string;

  /**
   * Backup type.
   */
  @visibility("read")
  backupType?: string;

  /**
   * List of files in the backup set.
   */
  @visibility("read")
  listOfBackupFiles?: SqlBackupFileInfo[];

  /**
   * Backup start date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupStartDate?: utcDateTime;

  /**
   * Backup end time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupFinishDate?: utcDateTime;

  /**
   * Whether this backup set has been restored or not.
   */
  @visibility("read")
  isBackupRestored?: boolean;

  /**
   * Has Backup Checksums
   */
  @visibility("read")
  hasBackupChecksums?: boolean;

  /**
   * Media family count
   */
  @visibility("read")
  familyCount?: int32;

  /**
   * The reasons why the backup set is ignored
   */
  @visibility("read")
  ignoreReasons?: string[];
}

/**
 * Information of backup file
 */
model SqlBackupFileInfo {
  /**
   * File name.
   */
  @visibility("read")
  fileName?: string;

  /**
   * Status of the file. (Initial, Uploading, Uploaded, Restoring, Restored or Skipped)
   */
  @visibility("read")
  status?: string;

  /**
   * File size in bytes
   */
  @visibility("read")
  totalSize?: int64;

  /**
   * Bytes read
   */
  @visibility("read")
  dataRead?: int64;

  /**
   * Bytes written
   */
  @visibility("read")
  dataWritten?: int64;

  /**
   * Copy throughput in KBps
   */
  @visibility("read")
  copyThroughput?: float64;

  /**
   * Copy Duration in seconds
   */
  @visibility("read")
  copyDuration?: int32;

  /**
   * Media family sequence number
   */
  @visibility("read")
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
  @visibility("read")
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
  @visibility("create", "update")
  @secret
  password?: string;
}

/**
 * Azure Blob Details
 */
model AzureBlob {
  /**
   * Resource Id of the storage account where backups are stored.
   */
  storageAccountResourceId?: string;

  /**
   * Storage Account Key.
   */
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
model DatabaseMigrationSqlVmProperties extends DatabaseMigrationProperties {
  /**
   * Detailed migration status. Not included by default.
   */
  @visibility("read")
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

model OperationsDefinition {
  @visibility("read")
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  @visibility("read")
  display?: OperationsDisplayDefinition;

  @visibility("read")
  origin?: OperationOrigin;

  /**
   * Dictionary of <AnyObject>
   */
  @visibility("read")
  properties?: Record<Record<unknown>>;
}

model OperationsDisplayDefinition {
  @visibility("read")
  provider?: string;

  @visibility("read")
  resource?: string;

  @visibility("read")
  operation?: string;

  @visibility("read")
  description?: string;
}

/**
 * The SQL Migration Service properties.
 */
model SqlMigrationServiceProperties {
  /**
   * Provisioning state to track the async operation status.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Current state of the Integration runtime.
   */
  @visibility("read")
  integrationRuntimeState?: string;
}

/**
 * An update to a SQL Migration Service.
 */
model SqlMigrationServiceUpdate {
  /**
   * Dictionary of <string>
   */
  tags?: Record<string>;
}

/**
 * An authentication key.
 */
model AuthenticationKeys {
  /**
   * The first authentication key.
   */
  @visibility("read", "create")
  authKey1?: string;

  /**
   * The second authentication key.
   */
  @visibility("read", "create")
  authKey2?: string;
}

/**
 * An authentication key to regenerate.
 */
model RegenAuthKeys {
  /**
   * The name of authentication key to generate.
   */
  @visibility("read", "create")
  keyName?: string;

  /**
   * The first authentication key.
   */
  @visibility("read", "create")
  authKey1?: string;

  /**
   * The second authentication key.
   */
  @visibility("read", "create")
  authKey2?: string;
}

/**
 * Details of node to be deleted.
 */
model DeleteNode {
  /**
   * The name of node to delete.
   */
  @visibility("read", "create")
  nodeName?: string;

  /**
   * The name of integration runtime.
   */
  @visibility("read", "create")
  integrationRuntimeName?: string;
}

/**
 * A list of Database Migrations.
 */
model DatabaseMigrationListResult is Azure.Core.Page<DatabaseMigration>;

/**
 * Database Migration Resource.
 */
model DatabaseMigration extends ProxyResource {
  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;

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
  @visibility("read")
  name?: string;

  /**
   * Integration Runtime node monitoring data.
   */
  @visibility("read")
  nodes?: NodeMonitoringData[];
}

model NodeMonitoringData {
  /**
   *  Unmatched properties from the message are deserialized in this collection.
   */
  @visibility("read")
  additionalProperties?: Record<Record<unknown>>;

  /**
   * Name of the integration runtime node.
   */
  @visibility("read")
  nodeName?: string;

  /**
   * Available memory (MB) on the integration runtime node.
   */
  @visibility("read")
  availableMemoryInMB?: int32;

  /**
   * CPU percentage on the integration runtime node.
   */
  @visibility("read")
  cpuUtilization?: int32;

  /**
   * Maximum concurrent jobs on the integration runtime node.
   */
  @visibility("read")
  concurrentJobsLimit?: int32;

  /**
   * The number of jobs currently running on the integration runtime node.
   */
  @visibility("read")
  concurrentJobsRunning?: int32;

  /**
   * The maximum concurrent jobs in this integration runtime.
   */
  @visibility("read")
  maxConcurrentJobs?: int32;

  /**
   * Sent bytes on the integration runtime node.
   */
  @visibility("read")
  sentBytes?: float64;

  /**
   * Received bytes on the integration runtime node.
   */
  @visibility("read")
  receivedBytes?: float64;
}

/**
 * The DMS List SKUs operation response.
 */
model ResourceSkusResult is Azure.Core.Page<ResourceSku>;

/**
 * Describes an available DMS SKU.
 */
model ResourceSku {
  /**
   * The type of resource the SKU applies to.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The name of SKU.
   */
  @visibility("read")
  name?: string;

  /**
   * Specifies the tier of DMS in a scale set.
   */
  @visibility("read")
  tier?: string;

  /**
   * The Size of the SKU.
   */
  @visibility("read")
  size?: string;

  /**
   * The Family of this particular SKU.
   */
  @visibility("read")
  family?: string;

  /**
   * The Kind of resources that are supported in this SKU.
   */
  @visibility("read")
  kind?: string;

  /**
   * Not used.
   */
  @visibility("read")
  capacity?: ResourceSkuCapacity;

  /**
   * The set of locations that the SKU is available.
   */
  @visibility("read")
  locations?: string[];

  /**
   * The api versions that support this SKU.
   */
  @visibility("read")
  apiVersions?: string[];

  /**
   * Metadata for retrieving price info.
   */
  @visibility("read")
  costs?: ResourceSkuCosts[];

  /**
   * A name value pair to describe the capability.
   */
  @visibility("read")
  capabilities?: ResourceSkuCapabilities[];

  /**
   * The restrictions because of which SKU cannot be used. This is empty if there are no restrictions.
   */
  @visibility("read")
  restrictions?: ResourceSkuRestrictions[];
}

/**
 * Describes scaling information of a SKU.
 */
model ResourceSkuCapacity {
  /**
   * The minimum capacity.
   */
  @visibility("read")
  minimum?: int64;

  /**
   * The maximum capacity.
   */
  @visibility("read")
  maximum?: int64;

  /**
   * The default capacity.
   */
  @visibility("read")
  default?: int64;

  /**
   * The scale type applicable to the SKU.
   */
  @visibility("read")
  scaleType?: ResourceSkuCapacityScaleType;
}

/**
 * Describes metadata for retrieving price info.
 */
model ResourceSkuCosts {
  /**
   * Used for querying price from commerce.
   */
  @visibility("read")
  meterID?: string;

  /**
   * The multiplier is needed to extend the base metered cost.
   */
  @visibility("read")
  quantity?: int64;

  /**
   * An invariant to show the extended unit.
   */
  @visibility("read")
  extendedUnit?: string;
}

/**
 * Describes The SKU capabilities object.
 */
model ResourceSkuCapabilities {
  /**
   * An invariant to describe the feature.
   */
  @visibility("read")
  name?: string;

  /**
   * An invariant if the feature is measured by quantity.
   */
  @visibility("read")
  value?: string;
}

/**
 * Describes scaling information of a SKU.
 */
model ResourceSkuRestrictions {
  /**
   * The type of restrictions.
   */
  @visibility("read")
  type?: ResourceSkuRestrictionsType;

  /**
   * The value of restrictions. If the restriction type is set to location. This would be different locations where the SKU is restricted.
   */
  @visibility("read")
  values?: string[];

  /**
   * The reason code for restriction.
   */
  @visibility("read")
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
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Error information in OData format.
 */
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
  details?: ODataError[];
}

/**
 * Properties of the Database Migration Service instance
 */
model DataMigrationServiceProperties {
  /**
   * The resource's provisioning state
   */
  @visibility("read")
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
  agentConfiguration?: Record<unknown>;

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
 * Base class for all types of DMS task properties. If task is not supported by current client, this object is returned.
 */
@discriminator("taskType")
model ProjectTaskProperties {
  /**
   * Array of errors. This is ignored if submitted.
   */
  @visibility("read")
  errors?: ODataError[];

  /**
   * The state of the task. This is ignored if submitted.
   */
  @visibility("read")
  state?: TaskState;

  /**
   * Array of command properties.
   */
  @visibility("read")
  commands?: CommandProperties[];

  /**
   * Key value pairs of client data to attach meta data information to task
   */
  clientData?: Record<string>;
}

/**
 * Base class for all types of DMS command properties. If command is not supported by current client, this object is returned.
 */
@discriminator("commandType")
model CommandProperties {
  /**
   * Array of errors. This is ignored if submitted.
   */
  @visibility("read")
  errors?: ODataError[];

  /**
   * The state of the command. This is ignored if submitted.
   */
  @visibility("read")
  state?: CommandState;
}

/**
 * ARM resource.
 */
model Resource {
  /**
   * Resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type.
   */
  @visibility("read")
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
  @visibility("read")
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
  databasesInfo?: DatabaseInfo[];

  /**
   * The project's provisioning state
   */
  @visibility("read")
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
   * User name
   */
  userName?: string;

  /**
   * Password credential.
   */
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
 * Base class for file properties.
 */
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
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * File content type. This property can be modified to reflect the file content type.
   */
  mediaType?: string;

  /**
   * File size.
   */
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
  id?: string;

  /**
   * List of errors that happened during the command execution
   */
  @visibility("read")
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
model MigrateMISyncCompleteCommandProperties extends CommandProperties {
  /**
   * Command input
   */
  input?: MigrateMISyncCompleteCommandInput;

  /**
   * Command output. This is ignored if submitted.
   */
  @visibility("read")
  output?: MigrateMISyncCompleteCommandOutput;

  /**
   * Command type.
   */
  commandType: "Migrate.SqlServer.AzureDbSqlMi.Complete";
}

/**
 * Input for command that completes online migration for an Azure SQL Database Managed Instance.
 */
model MigrateMISyncCompleteCommandInput {
  /**
   * Name of managed instance database
   */
  sourceDatabaseName: string;
}

/**
 * Output for command that completes online migration for an Azure SQL Database Managed Instance.
 */
model MigrateMISyncCompleteCommandOutput {
  /**
   * List of errors that happened during the command execution
   */
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
  isOfflineMigration?: boolean;
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
  collectLogins?: boolean;

  /**
   * Flag for whether to collect agent jobs from source server.
   */
  collectAgentJobs?: boolean;

  /**
   * Flag for whether to collect TDE Certificate names from source server.
   */
  collectTdeCertificateInfo?: boolean;

  /**
   * Flag for whether to validate SSIS catalog is reachable on the source server.
   */
  validateSsisCatalogOnly?: boolean;

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
  @visibility("read")
  id?: string;
}

/**
 * Task level output for the task that validates connection to SQL Server and also validates source server requirements
 */
model ConnectToSourceSqlServerTaskOutputTaskLevel
  extends ConnectToSourceSqlServerTaskOutput {
  /**
   * Source databases as a map from database name to database id
   */
  @visibility("read")
  databases?: string;

  /**
   * Source logins as a map from login name to login id.
   */
  @visibility("read")
  logins?: string;

  /**
   * Source agent jobs as a map from agent job name to id.
   */
  @visibility("read")
  agentJobs?: string;

  /**
   * Mapping from database name to TDE certificate name, if applicable
   */
  @visibility("read")
  databaseTdeCertificateMapping?: string;

  /**
   * Source server version
   */
  @visibility("read")
  sourceServerVersion?: string;

  /**
   * Source server brand version
   */
  @visibility("read")
  sourceServerBrandVersion?: string;

  /**
   * Validation errors
   */
  @visibility("read")
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
  @visibility("read")
  name?: string;

  /**
   * Size of the file in megabytes
   */
  @visibility("read")
  sizeMB?: float64;

  /**
   * The list of database files
   */
  @visibility("read")
  databaseFiles?: DatabaseFileInfo[];

  /**
   * SQL Server compatibility level of database
   */
  @visibility("read")
  compatibilityLevel?: DatabaseCompatLevel;

  /**
   * State of the database
   */
  @visibility("read")
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
  @visibility("read")
  name?: string;

  /**
   * The type of login.
   */
  @visibility("read")
  loginType?: LoginType;

  /**
   * The default database for the login.
   */
  @visibility("read")
  defaultDatabase?: string;

  /**
   * The state of the login.
   */
  @visibility("read")
  isEnabled?: boolean;

  /**
   * Information about eligibility of login for migration.
   */
  @visibility("read")
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
  @visibility("read")
  isEligibleForMigration?: boolean;

  /**
   * Information about eligibility failure for the server object.
   */
  @visibility("read")
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
  @visibility("read")
  name?: string;

  /**
   * The type of Agent Job.
   */
  @visibility("read")
  jobCategory?: string;

  /**
   * The state of the original Agent Job.
   */
  @visibility("read")
  isEnabled?: boolean;

  /**
   * The owner of the Agent Job
   */
  @visibility("read")
  jobOwner?: string;

  /**
   * UTC Date and time when the Agent Job was last executed.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastExecutedOn?: utcDateTime;

  /**
   * Validation errors
   */
  @visibility("read")
  validationErrors?: ReportableException[];

  /**
   * Information about eligibility of agent job for migration.
   */
  @visibility("read")
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
  @visibility("read")
  id?: string;

  /**
   * Version of the source server
   */
  @visibility("read")
  sourceServerVersion?: string;

  /**
   * List of databases on source server
   */
  @visibility("read")
  databases?: string[];

  /**
   * Source server brand version
   */
  @visibility("read")
  sourceServerBrandVersion?: string;

  /**
   * Validation errors associated with the task
   */
  @visibility("read")
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
  isOfflineMigration?: boolean;
}

/**
 * Output for the task that validates connection to Azure Database for MySQL and target server requirements
 */
model ConnectToTargetAzureDbForMySqlTaskOutput {
  /**
   * Result identifier
   */
  @visibility("read")
  id?: string;

  /**
   * Version of the target server
   */
  @visibility("read")
  serverVersion?: string;

  /**
   * List of databases on target server
   */
  @visibility("read")
  databases?: string[];

  /**
   * Target server brand version
   */
  @visibility("read")
  targetServerBrandVersion?: string;

  /**
   * Validation errors associated with the task
   */
  @visibility("read")
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
  @visibility("read")
  id?: string;

  /**
   * Source databases as a map from database name to database id
   */
  @visibility("read")
  databases?: string;

  /**
   * Version of the target server
   */
  @visibility("read")
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility("read")
  targetServerBrandVersion?: string;
}

/**
 * Input for the task that validates connection to Azure SQL Database Managed Instance online scenario.
 */
model ConnectToTargetSqlMISyncTaskInput {
  /**
   * Connection information for Azure SQL Database Managed Instance
   */
  targetConnectionInfo: MiSqlConnectionInfo;

  /**
   * Azure Active Directory Application the DMS instance will use to connect to the target instance of Azure SQL Database Managed Instance and the Azure Storage Account
   */
  azureApp: AzureActiveDirectoryApp;
}

/**
 * Output for the task that validates connection to Azure SQL Database Managed Instance.
 */
model ConnectToTargetSqlMISyncTaskOutput {
  /**
   * Target server version
   */
  @visibility("read")
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility("read")
  targetServerBrandVersion?: string;

  /**
   * Validation errors
   */
  @visibility("read")
  validationErrors?: ReportableException[];
}

/**
 * Input for the task that validates connection to Azure SQL Database Managed Instance.
 */
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
  validateSsisCatalogOnly?: boolean;
}

/**
 * Output for the task that validates connection to Azure SQL Database Managed Instance.
 */
model ConnectToTargetSqlMITaskOutput {
  /**
   * Result identifier
   */
  @visibility("read")
  id?: string;

  /**
   * Target server version
   */
  @visibility("read")
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility("read")
  targetServerBrandVersion?: string;

  /**
   * List of logins on the target server.
   */
  @visibility("read")
  logins?: string[];

  /**
   * List of agent jobs on the target server.
   */
  @visibility("read")
  agentJobs?: string[];

  /**
   * Validation errors
   */
  @visibility("read")
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
  @visibility("read")
  id?: string;

  /**
   * Version of the target server
   */
  @visibility("read")
  targetServerVersion?: string;

  /**
   * List of databases on target server
   */
  @visibility("read")
  databases?: string[];

  /**
   * Target server brand version
   */
  @visibility("read")
  targetServerBrandVersion?: string;

  /**
   * Validation errors associated with the task
   */
  @visibility("read")
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
  @visibility("read")
  id?: string;

  /**
   * Mapping from database name to list of tables
   */
  @visibility("read")
  databasesToTables?: string;

  /**
   * Validation errors
   */
  @visibility("read")
  validationErrors?: ReportableException[];
}

/**
 * Table properties
 */
model DatabaseTable {
  /**
   * Indicates whether table is empty or not
   */
  @visibility("read")
  hasRows?: boolean;

  /**
   * Schema-qualified name of the table
   */
  @visibility("read")
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
  password: string;
}

/**
 * Output of the task that gets TDE certificates in Base64 encoded format.
 */
model GetTdeCertificatesSqlTaskOutput {
  /**
   * Mapping from certificate name to base 64 encoded format.
   */
  @visibility("read")
  base64EncodedCertificates?: string;

  /**
   * Validation errors
   */
  @visibility("read")
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
  @visibility("read")
  databasesToSourceTables?: string;

  /**
   * Mapping from database name to list of target tables
   */
  @visibility("read")
  databasesToTargetTables?: string;

  /**
   * Mapping from database name to list of validation errors
   */
  @visibility("read")
  tableValidationErrors?: string;

  /**
   * Validation errors
   */
  @visibility("read")
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
  @visibility("read")
  id?: string;

  /**
   * Mapping from database name to list of tables
   */
  @visibility("read")
  databasesToTables?: string;

  /**
   * Validation errors
   */
  @visibility("read")
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
  @visibility("read")
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
model MigrateSchemaSqlServerSqlDbTaskInput extends SqlMigrationTaskInput {
  /**
   * Databases to migrate
   */
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
  @visibility("read")
  id?: string;
}

model MigrateSchemaSqlServerSqlDbTaskOutputMigrationLevel
  extends MigrateSchemaSqlServerSqlDbTaskOutput {
  /**
   * Overall state of the schema migration
   */
  @visibility("read")
  state?: MigrationState;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Source server version
   */
  @visibility("read")
  sourceServerVersion?: string;

  /**
   * Source server brand version
   */
  @visibility("read")
  sourceServerBrandVersion?: string;

  /**
   * Target server version
   */
  @visibility("read")
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility("read")
  targetServerBrandVersion?: string;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

model MigrateSchemaSqlServerSqlDbTaskOutputDatabaseLevel
  extends MigrateSchemaSqlServerSqlDbTaskOutput {
  /**
   * The name of the database
   */
  @visibility("read")
  databaseName?: string;

  /**
   * State of the schema migration for this database
   */
  @visibility("read")
  state?: MigrationState;

  /**
   * Schema migration stage for this database
   */
  @visibility("read")
  stage?: SchemaMigrationStage;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Prefix string to use for querying errors for this database
   */
  @visibility("read")
  databaseErrorResultPrefix?: string;

  /**
   * Prefix string to use for querying schema errors for this database
   */
  @visibility("read")
  schemaErrorResultPrefix?: string;

  /**
   * Number of successful operations for this database
   */
  @visibility("read")
  numberOfSuccessfulOperations?: int64;

  /**
   * Number of failed operations for this database
   */
  @visibility("read")
  numberOfFailedOperations?: int64;

  /**
   * Identifier for the file resource containing the schema of this database
   */
  @visibility("read")
  fileId?: string;

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

model MigrateSchemaSqlServerSqlDbTaskOutputError
  extends MigrateSchemaSqlServerSqlDbTaskOutput {
  /**
   * Schema command which failed
   */
  @visibility("read")
  commandText?: string;

  /**
   * Reason of failure
   */
  @visibility("read")
  errorText?: string;

  /**
   * Result type
   */
  resultType: "SchemaErrorOutput";
}

model MigrateSchemaSqlTaskOutputError
  extends MigrateSchemaSqlServerSqlDbTaskOutput {
  /**
   * Migration error
   */
  @visibility("read")
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
  migrationSetting?: Record<string>;

  /**
   * Source settings to tune source endpoint migration behavior
   */
  sourceSetting?: Record<string>;

  /**
   * Target settings to tune target endpoint migration behavior
   */
  targetSetting?: Record<string>;

  /**
   * Mapping of source to target tables
   */
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
  @visibility("read")
  id?: string;
}

model MigrateMySqlAzureDbForMySqlSyncTaskOutputMigrationLevel
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Source server version
   */
  @visibility("read")
  sourceServerVersion?: string;

  /**
   * Source server name
   */
  @visibility("read")
  sourceServer?: string;

  /**
   * Target server version
   */
  @visibility("read")
  targetServerVersion?: string;

  /**
   * Target server name
   */
  @visibility("read")
  targetServer?: string;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

model MigrateMySqlAzureDbForMySqlSyncTaskOutputDatabaseLevel
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  /**
   * Name of the database
   */
  @visibility("read")
  databaseName?: string;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Migration state that this database is in
   */
  @visibility("read")
  migrationState?: SyncDatabaseMigrationReportingState;

  /**
   * Number of incoming changes
   */
  @visibility("read")
  incomingChanges?: int64;

  /**
   * Number of applied changes
   */
  @visibility("read")
  appliedChanges?: int64;

  /**
   * Number of cdc inserts
   */
  @visibility("read")
  cdcInsertCounter?: int64;

  /**
   * Number of cdc deletes
   */
  @visibility("read")
  cdcDeleteCounter?: int64;

  /**
   * Number of cdc updates
   */
  @visibility("read")
  cdcUpdateCounter?: int64;

  /**
   * Number of tables completed in full load
   */
  @visibility("read")
  fullLoadCompletedTables?: int64;

  /**
   * Number of tables loading in full load
   */
  @visibility("read")
  fullLoadLoadingTables?: int64;

  /**
   * Number of tables queued in full load
   */
  @visibility("read")
  fullLoadQueuedTables?: int64;

  /**
   * Number of tables errored in full load
   */
  @visibility("read")
  fullLoadErroredTables?: int64;

  /**
   * Indicates if initial load (full load) has been completed
   */
  @visibility("read")
  initializationCompleted?: boolean;

  /**
   * CDC apply latency
   */
  @visibility("read")
  latency?: int64;

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

model MigrateMySqlAzureDbForMySqlSyncTaskOutputTableLevel
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  /**
   * Name of the table
   */
  @visibility("read")
  tableName?: string;

  /**
   * Name of the database
   */
  @visibility("read")
  databaseName?: string;

  /**
   * Number of applied inserts
   */
  @visibility("read")
  cdcInsertCounter?: string;

  /**
   * Number of applied updates
   */
  @visibility("read")
  cdcUpdateCounter?: string;

  /**
   * Number of applied deletes
   */
  @visibility("read")
  cdcDeleteCounter?: string;

  /**
   * Estimate to finish full load
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEstFinishTime?: utcDateTime;

  /**
   * Full load start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadStartedOn?: utcDateTime;

  /**
   * Full load end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEndedOn?: utcDateTime;

  /**
   * Number of rows applied in full load
   */
  @visibility("read")
  fullLoadTotalRows?: int64;

  /**
   * Current state of the table migration
   */
  @visibility("read")
  state?: SyncTableMigrationState;

  /**
   * Total number of applied changes
   */
  @visibility("read")
  totalChangesApplied?: int64;

  /**
   * Number of data errors occurred
   */
  @visibility("read")
  dataErrorsCounter?: int64;

  /**
   * Last modified time on target
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Result type
   */
  resultType: "TableLevelOutput";
}

model MigrateMySqlAzureDbForMySqlSyncTaskOutputError
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  /**
   * Migration error
   */
  @visibility("read")
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

model MigrateMySqlAzureDbForMySqlSyncTaskOutputDatabaseError
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  /**
   * Error message
   */
  errorMessage?: string;

  /**
   * List of error events.
   */
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
  @visibility("read")
  timestampString?: string;

  /**
   * Event type.
   */
  @visibility("read")
  eventTypeString?: string;

  /**
   * Event text.
   */
  @visibility("read")
  eventText?: string;
}

/**
 * Input for the task that migrates PostgreSQL databases to Azure Database for PostgreSQL for online migrations
 */
model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskInput {
  /**
   * Databases to migrate
   */
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
  @visibility("read")
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
  @visibility("read")
  id?: string;

  /**
   * Name of target database. Note: Target database will be truncated before starting migration.
   */
  targetDatabaseName?: string;

  /**
   * Migration settings which tune the migration behavior
   */
  migrationSetting?: Record<unknown>;

  /**
   * Source settings to tune source endpoint migration behavior
   */
  sourceSetting?: Record<string>;

  /**
   * Target settings to tune target endpoint migration behavior
   */
  targetSetting?: Record<string>;

  /**
   * Tables selected for migration
   */
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
  @visibility("read")
  id?: string;
}

model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputMigrationLevel
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Source server version
   */
  @visibility("read")
  sourceServerVersion?: string;

  /**
   * Source server name
   */
  @visibility("read")
  sourceServer?: string;

  /**
   * Target server version
   */
  @visibility("read")
  targetServerVersion?: string;

  /**
   * Target server name
   */
  @visibility("read")
  targetServer?: string;

  /**
   * Source server type.
   */
  @visibility("read")
  sourceServerType?: ScenarioSource;

  /**
   * Target server type.
   */
  @visibility("read")
  targetServerType?: ScenarioTarget;

  /**
   * Migration status
   */
  @visibility("read")
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

model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputDatabaseLevel
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  /**
   * Name of the database
   */
  @visibility("read")
  databaseName?: string;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Migration state that this database is in
   */
  @visibility("read")
  migrationState?: SyncDatabaseMigrationReportingState;

  /**
   * Number of incoming changes
   */
  @visibility("read")
  incomingChanges?: int64;

  /**
   * Number of applied changes
   */
  @visibility("read")
  appliedChanges?: int64;

  /**
   * Number of cdc inserts
   */
  @visibility("read")
  cdcInsertCounter?: int64;

  /**
   * Number of cdc deletes
   */
  @visibility("read")
  cdcDeleteCounter?: int64;

  /**
   * Number of cdc updates
   */
  @visibility("read")
  cdcUpdateCounter?: int64;

  /**
   * Number of tables completed in full load
   */
  @visibility("read")
  fullLoadCompletedTables?: int64;

  /**
   * Number of tables loading in full load
   */
  @visibility("read")
  fullLoadLoadingTables?: int64;

  /**
   * Number of tables queued in full load
   */
  @visibility("read")
  fullLoadQueuedTables?: int64;

  /**
   * Number of tables errored in full load
   */
  @visibility("read")
  fullLoadErroredTables?: int64;

  /**
   * Indicates if initial load (full load) has been completed
   */
  @visibility("read")
  initializationCompleted?: boolean;

  /**
   * CDC apply latency
   */
  @visibility("read")
  latency?: int64;

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputTableLevel
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  /**
   * Name of the table
   */
  @visibility("read")
  tableName?: string;

  /**
   * Name of the database
   */
  @visibility("read")
  databaseName?: string;

  /**
   * Number of applied inserts
   */
  @visibility("read")
  cdcInsertCounter?: int64;

  /**
   * Number of applied updates
   */
  @visibility("read")
  cdcUpdateCounter?: int64;

  /**
   * Number of applied deletes
   */
  @visibility("read")
  cdcDeleteCounter?: int64;

  /**
   * Estimate to finish full load
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEstFinishTime?: utcDateTime;

  /**
   * Full load start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadStartedOn?: utcDateTime;

  /**
   * Full load end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEndedOn?: utcDateTime;

  /**
   * Number of rows applied in full load
   */
  @visibility("read")
  fullLoadTotalRows?: int64;

  /**
   * Current state of the table migration
   */
  @visibility("read")
  state?: SyncTableMigrationState;

  /**
   * Total number of applied changes
   */
  @visibility("read")
  totalChangesApplied?: int64;

  /**
   * Number of data errors occurred
   */
  @visibility("read")
  dataErrorsCounter?: int64;

  /**
   * Last modified time on target
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Result type
   */
  resultType: "TableLevelOutput";
}

model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputError
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  /**
   * Migration error
   */
  @visibility("read")
  error?: ReportableException;

  /**
   * List of error events
   */
  events?: SyncMigrationDatabaseErrorEvent[];

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputDatabaseError
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  /**
   * Error message
   */
  errorMessage?: string;

  /**
   * List of error events.
   */
  events?: SyncMigrationDatabaseErrorEvent[];

  /**
   * Result type
   */
  resultType: "DatabaseLevelErrorOutput";
}

/**
 * Input for the task that migrates on-prem SQL Server databases to Azure SQL Database for online migrations
 */
model MigrateSqlServerSqlDbSyncTaskInput extends SqlMigrationTaskInput {
  /**
   * Databases to migrate
   */
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
  tableMap?: Record<string>;

  /**
   * Migration settings which tune the migration behavior
   */
  migrationSetting?: Record<string>;

  /**
   * Source settings to tune source endpoint migration behavior
   */
  sourceSetting?: Record<string>;

  /**
   * Target settings to tune target endpoint migration behavior
   */
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
  @visibility("read")
  id?: string;
}

model MigrateSqlServerSqlDbSyncTaskOutputMigrationLevel
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Source server version
   */
  @visibility("read")
  sourceServerVersion?: string;

  /**
   * Source server name
   */
  @visibility("read")
  sourceServer?: string;

  /**
   * Target server version
   */
  @visibility("read")
  targetServerVersion?: string;

  /**
   * Target server name
   */
  @visibility("read")
  targetServer?: string;

  /**
   * Count of databases
   */
  @visibility("read")
  databaseCount?: int32;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

model MigrateSqlServerSqlDbSyncTaskOutputDatabaseLevel
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  /**
   * Name of the database
   */
  @visibility("read")
  databaseName?: string;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Migration state that this database is in
   */
  @visibility("read")
  migrationState?: SyncDatabaseMigrationReportingState;

  /**
   * Number of incoming changes
   */
  @visibility("read")
  incomingChanges?: int64;

  /**
   * Number of applied changes
   */
  @visibility("read")
  appliedChanges?: int64;

  /**
   * Number of cdc inserts
   */
  @visibility("read")
  cdcInsertCounter?: int64;

  /**
   * Number of cdc deletes
   */
  @visibility("read")
  cdcDeleteCounter?: int64;

  /**
   * Number of cdc updates
   */
  @visibility("read")
  cdcUpdateCounter?: int64;

  /**
   * Number of tables completed in full load
   */
  @visibility("read")
  fullLoadCompletedTables?: int64;

  /**
   * Number of tables loading in full load
   */
  @visibility("read")
  fullLoadLoadingTables?: int64;

  /**
   * Number of tables queued in full load
   */
  @visibility("read")
  fullLoadQueuedTables?: int64;

  /**
   * Number of tables errored in full load
   */
  @visibility("read")
  fullLoadErroredTables?: int64;

  /**
   * Indicates if initial load (full load) has been completed
   */
  @visibility("read")
  initializationCompleted?: boolean;

  /**
   * CDC apply latency
   */
  @visibility("read")
  latency?: int64;

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

model MigrateSqlServerSqlDbSyncTaskOutputTableLevel
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  /**
   * Name of the table
   */
  @visibility("read")
  tableName?: string;

  /**
   * Name of the database
   */
  @visibility("read")
  databaseName?: string;

  /**
   * Number of applied inserts
   */
  @visibility("read")
  cdcInsertCounter?: int64;

  /**
   * Number of applied updates
   */
  @visibility("read")
  cdcUpdateCounter?: int64;

  /**
   * Number of applied deletes
   */
  @visibility("read")
  cdcDeleteCounter?: int64;

  /**
   * Estimate to finish full load
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEstFinishTime?: utcDateTime;

  /**
   * Full load start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadStartedOn?: utcDateTime;

  /**
   * Full load end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEndedOn?: utcDateTime;

  /**
   * Number of rows applied in full load
   */
  @visibility("read")
  fullLoadTotalRows?: int64;

  /**
   * Current state of the table migration
   */
  @visibility("read")
  state?: SyncTableMigrationState;

  /**
   * Total number of applied changes
   */
  @visibility("read")
  totalChangesApplied?: int64;

  /**
   * Number of data errors occurred
   */
  @visibility("read")
  dataErrorsCounter?: int64;

  /**
   * Last modified time on target
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Result type
   */
  resultType: "TableLevelOutput";
}

model MigrateSqlServerSqlDbSyncTaskOutputError
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  /**
   * Migration error
   */
  @visibility("read")
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

model MigrateSqlServerSqlDbSyncTaskOutputDatabaseError
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  /**
   * Error message
   */
  errorMessage?: string;

  /**
   * List of error events.
   */
  events?: SyncMigrationDatabaseErrorEvent[];

  /**
   * Result type
   */
  resultType: "DatabaseLevelErrorOutput";
}

/**
 * Input for the task that migrates on-prem SQL Server databases to Azure SQL Database
 */
model MigrateSqlServerSqlDbTaskInput extends SqlMigrationTaskInput {
  /**
   * Databases to migrate
   */
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
  tableMap?: Record<string>;

  /**
   * Settings selected for DB schema migration.
   */
  schemaSetting?: Record<unknown>;

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
  @visibility("read")
  id?: string;
}

model MigrateSqlServerSqlDbTaskOutputMigrationLevel
  extends MigrateSqlServerSqlDbTaskOutput {
  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Duration of task execution in seconds.
   */
  @visibility("read")
  durationInSeconds?: int64;

  /**
   * Current status of migration
   */
  @visibility("read")
  status?: MigrationStatus;

  /**
   * Migration status message
   */
  @visibility("read")
  statusMessage?: string;

  /**
   * Migration progress message
   */
  @visibility("read")
  message?: string;

  /**
   * Selected databases as a map from database name to database id
   */
  @visibility("read")
  databases?: string;

  /**
   * Summary of database results in the migration
   */
  @visibility("read")
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
  @visibility("read")
  sourceServerVersion?: string;

  /**
   * Source server brand version
   */
  @visibility("read")
  sourceServerBrandVersion?: string;

  /**
   * Target server version
   */
  @visibility("read")
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility("read")
  targetServerBrandVersion?: string;

  /**
   * Migration exceptions and warnings.
   */
  @visibility("read")
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
  @visibility("read")
  id?: string;

  /**
   * Migration Identifier
   */
  @visibility("read")
  migrationId?: string;

  /**
   * Validation summary results for each database
   */
  summaryResults?: Record<MigrationValidationDatabaseSummaryResult>;

  /**
   * Current status of validation at the migration level. Status from the database validation result status will be aggregated here.
   */
  @visibility("read")
  status?: ValidationStatus;
}

/**
 * Migration Validation Database level summary result
 */
model MigrationValidationDatabaseSummaryResult {
  /**
   * Result identifier
   */
  @visibility("read")
  id?: string;

  /**
   * Migration Identifier
   */
  @visibility("read")
  migrationId?: string;

  /**
   * Name of the source database
   */
  @visibility("read")
  sourceDatabaseName?: string;

  /**
   * Name of the target database
   */
  @visibility("read")
  targetDatabaseName?: string;

  /**
   * Validation start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Validation end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current status of validation at the database level
   */
  @visibility("read")
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

model MigrateSqlServerSqlDbTaskOutputDatabaseLevel
  extends MigrateSqlServerSqlDbTaskOutput {
  /**
   * Name of the item
   */
  @visibility("read")
  databaseName?: string;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current state of migration
   */
  @visibility("read")
  state?: MigrationState;

  /**
   * Migration stage that this database is in
   */
  @visibility("read")
  stage?: DatabaseMigrationStage;

  /**
   * Status message
   */
  @visibility("read")
  statusMessage?: string;

  /**
   * Migration progress message
   */
  @visibility("read")
  message?: string;

  /**
   * Number of objects
   */
  @visibility("read")
  numberOfObjects?: int64;

  /**
   * Number of successfully completed objects
   */
  @visibility("read")
  numberOfObjectsCompleted?: int64;

  /**
   * Number of database/object errors.
   */
  @visibility("read")
  errorCount?: int64;

  /**
   * Wildcard string prefix to use for querying all errors of the item
   */
  @visibility("read")
  errorPrefix?: string;

  /**
   * Wildcard string prefix to use for querying all sub-tem results of the item
   */
  @visibility("read")
  resultPrefix?: string;

  /**
   * Migration exceptions and warnings.
   */
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Summary of object results in the migration
   */
  @visibility("read")
  objectSummary?: string;

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

model MigrateSqlServerSqlDbTaskOutputTableLevel
  extends MigrateSqlServerSqlDbTaskOutput {
  /**
   * Name of the item
   */
  @visibility("read")
  objectName?: string;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current state of migration
   */
  @visibility("read")
  state?: MigrationState;

  /**
   * Status message
   */
  @visibility("read")
  statusMessage?: string;

  /**
   * Number of items
   */
  @visibility("read")
  itemsCount?: int64;

  /**
   * Number of successfully completed items
   */
  @visibility("read")
  itemsCompletedCount?: int64;

  /**
   * Wildcard string prefix to use for querying all errors of the item
   */
  @visibility("read")
  errorPrefix?: string;

  /**
   * Wildcard string prefix to use for querying all sub-tem results of the item
   */
  @visibility("read")
  resultPrefix?: string;

  /**
   * Result type
   */
  resultType: "TableLevelOutput";
}

model MigrateSqlServerSqlDbTaskOutputError
  extends MigrateSqlServerSqlDbTaskOutput {
  /**
   * Migration error
   */
  @visibility("read")
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

/**
 * Summary of database results in the migration
 */
model DatabaseSummaryResult extends DataItemMigrationSummaryResult {
  /**
   * Size of the database in megabytes
   */
  @visibility("read")
  sizeMB?: float64;
}

/**
 * Basic summary of a data item migration
 */
model DataItemMigrationSummaryResult {
  /**
   * Name of the item
   */
  @visibility("read")
  name?: string;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current state of migration
   */
  @visibility("read")
  state?: MigrationState;

  /**
   * Status message
   */
  @visibility("read")
  statusMessage?: string;

  /**
   * Number of items
   */
  @visibility("read")
  itemsCount?: int64;

  /**
   * Number of successfully completed items
   */
  @visibility("read")
  itemsCompletedCount?: int64;

  /**
   * Wildcard string prefix to use for querying all errors of the item
   */
  @visibility("read")
  errorPrefix?: string;

  /**
   * Wildcard string prefix to use for querying all sub-tem results of the item
   */
  @visibility("read")
  resultPrefix?: string;
}

model MigrateSqlServerSqlDbTaskOutputValidationResult
  extends MigrateSqlServerSqlDbTaskOutput {
  ...MigrationValidationResult;

  /**
   * Result type
   */
  resultType: "MigrationValidationOutput";
}

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
  @visibility("read")
  id?: string;

  /**
   * Migration Identifier
   */
  @visibility("read")
  migrationId?: string;

  /**
   * Name of the source database
   */
  @visibility("read")
  sourceDatabaseName?: string;

  /**
   * Name of the target database
   */
  @visibility("read")
  targetDatabaseName?: string;

  /**
   * Validation start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Validation end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Provides data integrity validation result between the source and target tables that are migrated.
   */
  @visibility("read")
  dataIntegrityValidationResult?: DataIntegrityValidationResult;

  /**
   * Provides schema comparison result between source and target database
   */
  @visibility("read")
  schemaValidationResult?: SchemaComparisonValidationResult;

  /**
   * Results of some of the query execution result between source and target database
   */
  @visibility("read")
  queryAnalysisValidationResult?: QueryAnalysisValidationResult;

  /**
   * Current status of validation at the database level
   */
  @visibility("read")
  status?: ValidationStatus;
}

/**
 * Results for checksum based Data Integrity validation results
 */
model DataIntegrityValidationResult {
  /**
   * List of failed table names of source and target pair
   */
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
  sourceDatabaseObjectCount?: Record<int64>;

  /**
   * Count of target database objects
   */
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
model MigrateSqlServerSqlMISyncTaskInput extends SqlServerSqlMISyncTaskInput {
  /**
   * Number of database migrations to start in parallel
   */
  numberOfParallelDatabaseMigrations?: float32;
}

/**
 * Input for task that migrates SQL Server databases to Azure SQL Database Managed Instance online scenario.
 */
model SqlServerSqlMISyncTaskInput {
  /**
   * Databases to migrate
   */
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
   * Azure Active Directory Application the DMS instance will use to connect to the target instance of Azure SQL Database Managed Instance and the Azure Storage Account
   */
  azureApp: AzureActiveDirectoryApp;
}

/**
 * Database specific information for SQL to Azure SQL DB Managed Instance migration task inputs
 */
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
@discriminator("resultType")
model MigrateSqlServerSqlMISyncTaskOutput {
  /**
   * Result identifier
   */
  @visibility("read")
  id?: string;
}

model MigrateSqlServerSqlMISyncTaskOutputMigrationLevel
  extends MigrateSqlServerSqlMISyncTaskOutput {
  /**
   * Count of databases
   */
  @visibility("read")
  databaseCount?: int32;

  /**
   * Current state of migration
   */
  @visibility("read")
  state?: MigrationState;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Source server name
   */
  @visibility("read")
  sourceServerName?: string;

  /**
   * Source server version
   */
  @visibility("read")
  sourceServerVersion?: string;

  /**
   * Source server brand version
   */
  @visibility("read")
  sourceServerBrandVersion?: string;

  /**
   * Target server name
   */
  @visibility("read")
  targetServerName?: string;

  /**
   * Target server version
   */
  @visibility("read")
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility("read")
  targetServerBrandVersion?: string;

  /**
   * Number of database level errors
   */
  @visibility("read")
  databaseErrorCount?: int32;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

model MigrateSqlServerSqlMISyncTaskOutputDatabaseLevel
  extends MigrateSqlServerSqlMISyncTaskOutput {
  /**
   * Name of the database
   */
  @visibility("read")
  sourceDatabaseName?: string;

  /**
   * Current state of database
   */
  @visibility("read")
  migrationState?: DatabaseMigrationState;

  /**
   * Database migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Database migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Details of full backup set
   */
  @visibility("read")
  fullBackupSetInfo?: BackupSetInfo;

  /**
   * Last applied backup set information
   */
  @visibility("read")
  lastRestoredBackupSetInfo?: BackupSetInfo;

  /**
   * Backup sets that are currently active (Either being uploaded or getting restored)
   */
  @visibility("read")
  activeBackupSets?: BackupSetInfo[];

  /**
   * Name of container created in the Azure Storage account where backups are copied to
   */
  @visibility("read")
  containerName?: string;

  /**
   * prefix string to use for querying errors for this database
   */
  @visibility("read")
  errorPrefix?: string;

  /**
   * Whether full backup has been applied to the target database or not
   */
  @visibility("read")
  isFullBackupRestored?: boolean;

  /**
   * Migration exceptions and warnings
   */
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

model MigrateSqlServerSqlMISyncTaskOutputError
  extends MigrateSqlServerSqlMISyncTaskOutput {
  /**
   * Migration error
   */
  @visibility("read")
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

/**
 * Input for task that migrates SQL Server databases to Azure SQL Database Managed Instance.
 */
model MigrateSqlServerSqlMITaskInput extends SqlMigrationTaskInput {
  /**
   * Databases to migrate
   */
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
@discriminator("resultType")
model MigrateSqlServerSqlMITaskOutput {
  /**
   * Result identifier
   */
  @visibility("read")
  id?: string;
}

model MigrateSqlServerSqlMITaskOutputMigrationLevel
  extends MigrateSqlServerSqlMITaskOutput {
  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current status of migration
   */
  @visibility("read")
  status?: MigrationStatus;

  /**
   * Current state of migration
   */
  @visibility("read")
  state?: MigrationState;

  /**
   * Selected agent jobs as a map from name to id
   */
  @visibility("read")
  agentJobs?: string;

  /**
   * Selected logins as a map from name to id
   */
  @visibility("read")
  logins?: string;

  /**
   * Migration progress message
   */
  @visibility("read")
  message?: string;

  /**
   * Map of server role migration results.
   */
  @visibility("read")
  serverRoleResults?: string;

  /**
   * List of orphaned users.
   */
  @visibility("read")
  orphanedUsersInfo?: OrphanedUserInfo[];

  /**
   * Selected databases as a map from database name to database id
   */
  @visibility("read")
  databases?: string;

  /**
   * Source server version
   */
  @visibility("read")
  sourceServerVersion?: string;

  /**
   * Source server brand version
   */
  @visibility("read")
  sourceServerBrandVersion?: string;

  /**
   * Target server version
   */
  @visibility("read")
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility("read")
  targetServerBrandVersion?: string;

  /**
   * Migration exceptions and warnings.
   */
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

model MigrateSqlServerSqlMITaskOutputDatabaseLevel
  extends MigrateSqlServerSqlMITaskOutput {
  /**
   * Name of the database
   */
  @visibility("read")
  databaseName?: string;

  /**
   * Size of the database in megabytes
   */
  @visibility("read")
  sizeMB?: float64;

  /**
   * Current state of migration
   */
  @visibility("read")
  state?: MigrationState;

  /**
   * Current stage of migration
   */
  @visibility("read")
  stage?: DatabaseMigrationStage;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Migration progress message
   */
  @visibility("read")
  message?: string;

  /**
   * Migration exceptions and warnings
   */
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

model MigrateSqlServerSqlMITaskOutputAgentJobLevel
  extends MigrateSqlServerSqlMITaskOutput {
  /**
   * Agent Job name.
   */
  @visibility("read")
  name?: string;

  /**
   * The state of the original Agent Job.
   */
  @visibility("read")
  isEnabled?: boolean;

  /**
   * Current state of migration
   */
  @visibility("read")
  state?: MigrationState;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Migration progress message
   */
  @visibility("read")
  message?: string;

  /**
   * Migration errors and warnings per job
   */
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Result type
   */
  resultType: "AgentJobLevelOutput";
}

model MigrateSqlServerSqlMITaskOutputLoginLevel
  extends MigrateSqlServerSqlMITaskOutput {
  /**
   * Login name.
   */
  @visibility("read")
  loginName?: string;

  /**
   * Current state of login
   */
  @visibility("read")
  state?: MigrationState;

  /**
   * Current stage of login
   */
  @visibility("read")
  stage?: LoginMigrationStage;

  /**
   * Login migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Login migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Login migration progress message
   */
  @visibility("read")
  message?: string;

  /**
   * Login migration errors and warnings per login
   */
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Result type
   */
  resultType: "LoginLevelOutput";
}

model MigrateSqlServerSqlMITaskOutputError
  extends MigrateSqlServerSqlMITaskOutput {
  /**
   * Migration error
   */
  @visibility("read")
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

/**
 * Input for task that migrates SSIS packages from SQL Server to Azure SQL Database Managed Instance.
 */
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
   * The SSIS store type of source, only SSIS catalog is supported now in DMS
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
  @visibility("read")
  id?: string;
}

model MigrateSsisTaskOutputMigrationLevel extends MigrateSsisTaskOutput {
  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current status of migration
   */
  @visibility("read")
  status?: MigrationStatus;

  /**
   * Migration progress message
   */
  @visibility("read")
  message?: string;

  /**
   * Source server version
   */
  @visibility("read")
  sourceServerVersion?: string;

  /**
   * Source server brand version
   */
  @visibility("read")
  sourceServerBrandVersion?: string;

  /**
   * Target server version
   */
  @visibility("read")
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility("read")
  targetServerBrandVersion?: string;

  /**
   * Migration exceptions and warnings.
   */
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Stage of SSIS migration.
   */
  @visibility("read")
  stage?: SsisMigrationStage;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

model MigrateSsisTaskOutputProjectLevel extends MigrateSsisTaskOutput {
  /**
   * Name of the folder
   */
  @visibility("read")
  folderName?: string;

  /**
   * Name of the project
   */
  @visibility("read")
  projectName?: string;

  /**
   * Current state of migration
   */
  @visibility("read")
  state?: MigrationState;

  /**
   * Stage of SSIS migration.
   */
  @visibility("read")
  stage?: SsisMigrationStage;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Migration progress message
   */
  @visibility("read")
  message?: string;

  /**
   * Migration exceptions and warnings
   */
  @visibility("read")
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
model MongoDbDatabaseInfo extends MongoDbObjectInfo {
  /**
   * A list of supported collections in a MongoDB database
   */
  collections: MongoDbCollectionInfo[];

  /**
   * Whether the database has sharding enabled. Note that the migration task will enable sharding on the target if necessary.
   */
  supportsSharding: boolean;
}

/**
 * Describes a supported collection within a MongoDB database
 */
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
  targetRUs?: int32;
}

/**
 * Describes a MongoDB shard key
 */
model MongoDbShardKeySetting {
  /**
   * The fields within the shard key
   */
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
  collections: Record<MongoDbCollectionSettings>;

  /**
   * The RUs that should be configured on a CosmosDB target, or null to use the default, or 0 if throughput should not be provisioned for the database. This has no effect on non-CosmosDB targets.
   */
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
  boostRUs?: int32;

  /**
   * The databases on the source cluster to migrate to the target. The keys are the names of the databases.
   */
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
  @visibility("read")
  sourceServerVersion?: string;

  /**
   * List of schemas on source server
   */
  @visibility("read")
  databases?: string[];

  /**
   * Source server brand version
   */
  @visibility("read")
  sourceServerBrandVersion?: string;

  /**
   * Validation errors associated with the task
   */
  @visibility("read")
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
  @visibility("read")
  targetServerVersion?: string;

  /**
   * List of databases on target server
   */
  @visibility("read")
  databases?: string[];

  /**
   * Target server brand version
   */
  @visibility("read")
  targetServerBrandVersion?: string;

  /**
   * Validation errors associated with the task
   */
  @visibility("read")
  validationErrors?: ReportableException[];

  /**
   * Mapping of schemas per database
   */
  databaseSchemaMap?: ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskOutputDatabaseSchemaMapItem[];
}

model ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskOutputDatabaseSchemaMapItem {
  database?: string;
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
  @visibility("read")
  schemaName?: string;

  /**
   * List of valid tables found for this schema
   */
  @visibility("read")
  tables?: DatabaseTable[];

  /**
   * Validation errors associated with the task
   */
  @visibility("read")
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
  @visibility("read")
  databaseName?: string;

  /**
   * List of valid tables found for this database
   */
  @visibility("read")
  tables?: DatabaseTable[];

  /**
   * Validation errors associated with the task
   */
  @visibility("read")
  validationErrors?: ReportableException[];
}

/**
 * Output for task that validates migration input for Oracle to Azure Database for PostgreSQL for online migrations
 */
model ValidateOracleAzureDbPostgreSqlSyncTaskOutput {
  /**
   * Errors associated with a selected database object
   */
  @visibility("read")
  validationErrors?: ReportableException[];
}

/**
 * Input for the task that migrates Oracle databases to Azure Database for PostgreSQL for online migrations
 */
model MigrateOracleAzureDbPostgreSqlSyncTaskInput {
  /**
   * Databases to migrate
   */
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
  tableMap?: Record<string>;

  /**
   * Name of target database. Note: Target database will be truncated before starting migration.
   */
  targetDatabaseName?: string;

  /**
   * Migration settings which tune the migration behavior
   */
  migrationSetting?: Record<string>;

  /**
   * Source settings to tune source endpoint migration behavior
   */
  sourceSetting?: Record<string>;

  /**
   * Target settings to tune target endpoint migration behavior
   */
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
  @visibility("read")
  id?: string;
}

model MigrateOracleAzureDbPostgreSqlSyncTaskOutputMigrationLevel
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Source server version
   */
  @visibility("read")
  sourceServerVersion?: string;

  /**
   * Source server name
   */
  @visibility("read")
  sourceServer?: string;

  /**
   * Target server version
   */
  @visibility("read")
  targetServerVersion?: string;

  /**
   * Target server name
   */
  @visibility("read")
  targetServer?: string;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

model MigrateOracleAzureDbPostgreSqlSyncTaskOutputDatabaseLevel
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  /**
   * Name of the database
   */
  @visibility("read")
  databaseName?: string;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Migration state that this database is in
   */
  @visibility("read")
  migrationState?: SyncDatabaseMigrationReportingState;

  /**
   * Number of incoming changes
   */
  @visibility("read")
  incomingChanges?: int64;

  /**
   * Number of applied changes
   */
  @visibility("read")
  appliedChanges?: int64;

  /**
   * Number of cdc inserts
   */
  @visibility("read")
  cdcInsertCounter?: int64;

  /**
   * Number of cdc deletes
   */
  @visibility("read")
  cdcDeleteCounter?: int64;

  /**
   * Number of cdc updates
   */
  @visibility("read")
  cdcUpdateCounter?: int64;

  /**
   * Number of tables completed in full load
   */
  @visibility("read")
  fullLoadCompletedTables?: int64;

  /**
   * Number of tables loading in full load
   */
  @visibility("read")
  fullLoadLoadingTables?: int64;

  /**
   * Number of tables queued in full load
   */
  @visibility("read")
  fullLoadQueuedTables?: int64;

  /**
   * Number of tables errored in full load
   */
  @visibility("read")
  fullLoadErroredTables?: int64;

  /**
   * Indicates if initial load (full load) has been completed
   */
  @visibility("read")
  initializationCompleted?: boolean;

  /**
   * CDC apply latency
   */
  @visibility("read")
  latency?: int64;

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

model MigrateOracleAzureDbPostgreSqlSyncTaskOutputTableLevel
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  /**
   * Name of the table
   */
  @visibility("read")
  tableName?: string;

  /**
   * Name of the database
   */
  @visibility("read")
  databaseName?: string;

  /**
   * Number of applied inserts
   */
  @visibility("read")
  cdcInsertCounter?: int64;

  /**
   * Number of applied updates
   */
  @visibility("read")
  cdcUpdateCounter?: int64;

  /**
   * Number of applied deletes
   */
  @visibility("read")
  cdcDeleteCounter?: int64;

  /**
   * Estimate to finish full load
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEstFinishTime?: utcDateTime;

  /**
   * Full load start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadStartedOn?: utcDateTime;

  /**
   * Full load end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEndedOn?: utcDateTime;

  /**
   * Number of rows applied in full load
   */
  @visibility("read")
  fullLoadTotalRows?: int64;

  /**
   * Current state of the table migration
   */
  @visibility("read")
  state?: SyncTableMigrationState;

  /**
   * Total number of applied changes
   */
  @visibility("read")
  totalChangesApplied?: int64;

  /**
   * Number of data errors occurred
   */
  @visibility("read")
  dataErrorsCounter?: int64;

  /**
   * Last modified time on target
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Result type
   */
  resultType: "TableLevelOutput";
}

model MigrateOracleAzureDbPostgreSqlSyncTaskOutputError
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  /**
   * Migration error
   */
  @visibility("read")
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}

model MigrateOracleAzureDbPostgreSqlSyncTaskOutputDatabaseError
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  /**
   * Error message
   */
  errorMessage?: string;

  /**
   * List of error events.
   */
  events?: SyncMigrationDatabaseErrorEvent[];

  /**
   * Result type
   */
  resultType: "DatabaseLevelErrorOutput";
}

/**
 * Information about an Oracle OCI driver.
 */
model OracleOCIDriverInfo {
  /**
   * The name of the driver package
   */
  @visibility("read")
  driverName?: string;

  /**
   * The size in bytes of the driver package
   */
  @visibility("read")
  driverSize?: string;

  /**
   * The MD5 Base64 encoded checksum for the driver package.
   */
  @visibility("read")
  archiveChecksum?: string;

  /**
   * The checksum for the driver package provided by Oracle.
   */
  @visibility("read")
  oracleChecksum?: string;

  /**
   * Version listed in the OCI assembly 'oci.dll'
   */
  @visibility("read")
  assemblyVersion?: string;

  /**
   * List of Oracle database versions supported by this driver. Only major minor of the version is listed.
   */
  @visibility("read")
  supportedOracleVersions?: string[];
}

/**
 * Input for the service task to check for OCI drivers.
 */
model CheckOCIDriverTaskInput {
  /**
   * Version of the source server to check against.  Optional.
   */
  serverVersion?: string;
}

/**
 * Output for the service task to check for OCI drivers.
 */
model CheckOCIDriverTaskOutput {
  /**
   * Information about the installed driver if found and valid.
   */
  installedDriver?: OracleOCIDriverInfo;

  /**
   * Validation errors
   */
  @visibility("read")
  validationErrors?: ReportableException[];
}

/**
 * Input for the service task to upload an OCI driver.
 */
model UploadOCIDriverTaskInput {
  /**
   * File share information for the OCI driver archive.
   */
  driverShare?: FileShare;
}

/**
 * Output for the service task to upload an OCI driver.
 */
model UploadOCIDriverTaskOutput {
  /**
   * The name of the driver package that was validated and uploaded.
   */
  @visibility("read")
  driverPackageName?: string;

  /**
   * Validation errors
   */
  @visibility("read")
  validationErrors?: ReportableException[];
}

/**
 * Input for the service task to install an OCI driver.
 */
model InstallOCIDriverTaskInput {
  /**
   * Name of the uploaded driver package to install.
   */
  driverPackageName?: string;
}

/**
 * Output for the service task to install an OCI driver.
 */
model InstallOCIDriverTaskOutput {
  /**
   * Validation errors
   */
  @visibility("read")
  validationErrors?: ReportableException[];
}

/**
 * Description of an action supported by the Database Migration Service
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
model ServiceOperationList {
  /**
   * List of actions
   */
  value?: ServiceOperation[];

  /**
   * URL to load the next page of actions
   */
  nextLink?: string;
}

/**
 * Properties for the task that checks for OCI drivers.
 */
model CheckOCIDriverTaskProperties extends ProjectTaskProperties {
  /**
   * Input for the service task to check for OCI drivers.
   */
  input?: CheckOCIDriverTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility("read")
  output?: CheckOCIDriverTaskOutput[];

  /**
   * Task type.
   */
  taskType: "Service.Check.OCI";
}

/**
 * Properties for the task that uploads an OCI driver.
 */
model UploadOCIDriverTaskProperties extends ProjectTaskProperties {
  /**
   * Input for the service task to upload an OCI driver.
   */
  input?: UploadOCIDriverTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility("read")
  output?: UploadOCIDriverTaskOutput[];

  /**
   * Task type.
   */
  taskType: "Service.Upload.OCI";
}

/**
 * Properties for the task that installs an OCI driver.
 */
model InstallOCIDriverTaskProperties extends ProjectTaskProperties {
  /**
   * Input for the service task to install an OCI driver.
   */
  input?: InstallOCIDriverTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
  id?: string;

  /**
   * Server brand version
   */
  @visibility("read")
  sourceServerBrandVersion?: string;

  /**
   * Server properties
   */
  @visibility("read")
  serverProperties?: ServerProperties;

  /**
   * List of databases on the server
   */
  @visibility("read")
  databases?: string[];

  /**
   * Validation errors associated with the task
   */
  @visibility("read")
  validationErrors?: ReportableException[];
}

/**
 * Server properties for MySQL type source
 */
model ServerProperties {
  /**
   * Name of the server platform
   */
  @visibility("read")
  serverPlatform?: string;

  /**
   * Name of the server
   */
  @visibility("read")
  serverName?: string;

  /**
   * Version of the database server
   */
  @visibility("read")
  serverVersion?: string;

  /**
   * Edition of the database server
   */
  @visibility("read")
  serverEdition?: string;

  /**
   * Version of the operating system
   */
  @visibility("read")
  serverOperatingSystemVersion?: string;

  /**
   * Number of databases in the server
   */
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
  output?: GetUserTablesMySqlTaskOutput[];

  /**
   * Task type.
   */
  taskType: "GetUserTablesMySql";
}

/**
 * Properties for the task that validates connection to Azure SQL Database Managed Instance
 */
model ConnectToTargetSqlMITaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ConnectToTargetSqlMITaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility("read")
  output?: ConnectToTargetSqlMITaskOutput[];

  /**
   * Task type.
   */
  taskType: "ConnectToTarget.AzureSqlDbMI";
}

/**
 * Properties for the task that validates connection to Azure SQL Database Managed Instance
 */
model ConnectToTargetSqlMISyncTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ConnectToTargetSqlMISyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility("read")
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
  @visibility("read")
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

  @visibility("read")
  output?: MongoDbProgress[];

  /**
   * Task type.
   */
  taskType: "Migrate.MongoDb";
}

/**
 * Properties for task that migrates SQL Server databases to Azure SQL Database Managed Instance
 */
model MigrateSqlServerSqlMITaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: MigrateSqlServerSqlMITaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility("read")
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
model MigrateSqlServerSqlMISyncTaskProperties extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: MigrateSqlServerSqlMISyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
  id?: string;
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  selectedDatabases: MigrateSqlServerSqlDbSyncDatabaseInput[];
}

/**
 * Output for task that validates migration input for SQL sync migrations
 */
model ValidateSyncMigrationInputSqlServerTaskOutput {
  /**
   * Database identifier
   */
  @visibility("read")
  id?: string;

  /**
   * Name of database
   */
  @visibility("read")
  name?: string;

  /**
   * Errors associated with a selected database object
   */
  @visibility("read")
  validationErrors?: ReportableException[];
}

/**
 * Properties for task that validates migration input for SQL to Azure SQL Database Managed Instance
 */
model ValidateMigrationInputSqlServerSqlMITaskProperties
  extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ValidateMigrationInputSqlServerSqlMITaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility("read")
  output?: ValidateMigrationInputSqlServerSqlMITaskOutput[];

  /**
   * Task type.
   */
  taskType: "ValidateMigrationInput.SqlServer.AzureSqlDbMI";
}

/**
 * Input for task that validates migration input for SQL to Azure SQL Managed Instance
 */
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
model ValidateMigrationInputSqlServerSqlMITaskOutput {
  /**
   * Result identifier
   */
  @visibility("read")
  id?: string;

  /**
   * Name of database
   */
  @visibility("read")
  name?: string;

  /**
   * Errors associated with the RestoreDatabaseName
   */
  @visibility("read")
  restoreDatabaseNameErrors?: ReportableException[];

  /**
   * Errors associated with the BackupFolder path
   */
  @visibility("read")
  backupFolderErrors?: ReportableException[];

  /**
   * Errors associated with backup share user name and password credentials
   */
  @visibility("read")
  backupShareCredentialsErrors?: ReportableException[];

  /**
   * Errors associated with the storage account provided.
   */
  @visibility("read")
  backupStorageAccountErrors?: ReportableException[];

  /**
   * Errors associated with existing backup files.
   */
  @visibility("read")
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
  @visibility("read")
  databaseName?: string;

  /**
   * Backup Type.
   */
  @visibility("read")
  backupType?: BackupType;

  /**
   * The list of backup files for the current database.
   */
  @visibility("read")
  backupFiles?: string[];

  /**
   * Position of current database backup in the file.
   */
  @visibility("read")
  position?: int32;

  /**
   * Database was damaged when backed up, but the backup operation was requested to continue despite errors.
   */
  @visibility("read")
  isDamaged?: boolean;

  /**
   * Whether the backup set is compressed
   */
  @visibility("read")
  isCompressed?: boolean;

  /**
   * Number of files in the backup set.
   */
  @visibility("read")
  familyCount?: int32;

  /**
   * Date and time when the backup operation finished.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupFinishDate?: utcDateTime;
}

/**
 * Properties for task that validates migration input for SQL to Azure SQL Database Managed Instance sync scenario
 */
model ValidateMigrationInputSqlServerSqlMISyncTaskProperties
  extends ProjectTaskProperties {
  /**
   * Task input
   */
  input?: ValidateMigrationInputSqlServerSqlMISyncTaskInput;

  /**
   * Task output. This is ignored if submitted.
   */
  @visibility("read")
  output?: ValidateMigrationInputSqlServerSqlMISyncTaskOutput[];

  /**
   * Task type.
   */
  taskType: "ValidateMigrationInput.SqlServer.AzureSqlDbMI.Sync.LRS";
}

/**
 * Input for task that migrates SQL Server databases to Azure SQL Database Managed Instance online scenario.
 */
model ValidateMigrationInputSqlServerSqlMISyncTaskInput
  extends SqlServerSqlMISyncTaskInput {}

/**
 * Output for task that validates migration input for Azure SQL Database Managed Instance online migration
 */
model ValidateMigrationInputSqlServerSqlMISyncTaskOutput {
  /**
   * Database identifier
   */
  @visibility("read")
  id?: string;

  /**
   * Name of database
   */
  @visibility("read")
  name?: string;

  /**
   * Errors associated with a selected database object
   */
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
  databaseName?: string;

  /**
   * The unescaped name of the object
   */
  @visibility("read")
  objectName?: string;

  /**
   * The unescaped name of the schema containing the object
   */
  @visibility("read")
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
  @visibility("read")
  sourceServerName?: string;

  /**
   * Source server port number
   */
  @visibility("read")
  sourceServerPort?: string;

  /**
   * Source username
   */
  @visibility("read")
  sourceUsername?: string;

  /**
   * Target server name
   */
  @visibility("read")
  targetServerName?: string;

  /**
   * Target username
   */
  @visibility("read")
  targetUsername?: string;

  /**
   * Target database name
   */
  @visibility("read")
  targetDbName?: string;

  /**
   * Whether target connection is Windows authentication
   */
  @visibility("read")
  targetUsingWinAuth?: boolean;

  /**
   * List of tables selected for migration
   */
  @visibility("read")
  selectedMigrationTables?: MigrationTableMetadata[];
}

/**
 * Metadata for tables selected in migration project
 */
model MigrationTableMetadata {
  /**
   * Source table name
   */
  @visibility("read")
  sourceTableName?: string;

  /**
   * Target table name
   */
  @visibility("read")
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
  @visibility("read")
  id?: string;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current state of migration
   */
  @visibility("read")
  status?: MigrationStatus;

  /**
   * Results of the migration. The key contains the table name and the value the table result object
   */
  @visibility("read")
  dataMigrationTableResults?: string;

  /**
   * Message about the progress of the migration
   */
  @visibility("read")
  progressMessage?: string;

  /**
   * Name of source server
   */
  @visibility("read")
  sourceServerName?: string;

  /**
   * Name of target server
   */
  @visibility("read")
  targetServerName?: string;
}

/**
 * Object used to report the data migration results of a table
 */
model NonSqlDataMigrationTableResult {
  /**
   * Result code of the data migration
   */
  @visibility("read")
  resultCode?: DataMigrationResultCode;

  /**
   * Name of the source table
   */
  @visibility("read")
  sourceName?: string;

  /**
   * Name of the target table
   */
  @visibility("read")
  targetName?: string;

  /**
   * Number of rows in the source table
   */
  @visibility("read")
  sourceRowCount?: int64;

  /**
   * Number of rows in the target table
   */
  @visibility("read")
  targetRowCount?: int64;

  /**
   * Time taken to migrate the data
   */
  @visibility("read")
  elapsedTimeInMiliseconds?: float64;

  /**
   * List of errors, if any, during migration
   */
  @visibility("read")
  errors?: DataMigrationError[];
}

/**
 * Migration Task errors
 */
model DataMigrationError {
  /**
   * Error description
   */
  @visibility("read")
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
  @visibility("read")
  name?: string;

  /**
   * Current state of migration
   */
  @visibility("read")
  state?: MigrationState;

  /**
   * Migration exceptions and warnings.
   */
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];
}

model MigrateMySqlAzureDbForMySqlOfflineTaskOutputMigrationLevel
  extends MigrateMySqlAzureDbForMySqlOfflineTaskOutput {
  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Duration of task execution in seconds.
   */
  @visibility("read")
  durationInSeconds?: int64;

  /**
   * Current status of migration
   */
  @visibility("read")
  status?: MigrationStatus;

  /**
   * Migration status message
   */
  @visibility("read")
  statusMessage?: string;

  /**
   * Migration progress message
   */
  @visibility("read")
  message?: string;

  /**
   * Selected databases as a map from database name to database id
   */
  databases?: string;

  /**
   * Summary of database results in the migration
   */
  @visibility("read")
  databaseSummary?: string;

  /**
   * Migration Report Result, provides unique url for downloading your migration report.
   */
  migrationReportResult?: MigrationReportResult;

  /**
   * Source server version
   */
  @visibility("read")
  sourceServerVersion?: string;

  /**
   * Source server brand version
   */
  @visibility("read")
  sourceServerBrandVersion?: string;

  /**
   * Target server version
   */
  @visibility("read")
  targetServerVersion?: string;

  /**
   * Target server brand version
   */
  @visibility("read")
  targetServerBrandVersion?: string;

  /**
   * Migration exceptions and warnings.
   */
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Last time the storage was updated
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStorageUpdate?: utcDateTime;

  /**
   * Result type
   */
  resultType: "MigrationLevelOutput";
}

model MigrateMySqlAzureDbForMySqlOfflineTaskOutputDatabaseLevel
  extends MigrateMySqlAzureDbForMySqlOfflineTaskOutput {
  /**
   * Name of the database
   */
  @visibility("read")
  databaseName?: string;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current state of migration
   */
  @visibility("read")
  state?: MigrationState;

  /**
   * Migration stage that this database is in
   */
  @visibility("read")
  stage?: DatabaseMigrationStage;

  /**
   * Status message
   */
  @visibility("read")
  statusMessage?: string;

  /**
   * Migration progress message
   */
  @visibility("read")
  message?: string;

  /**
   * Number of objects
   */
  @visibility("read")
  numberOfObjects?: int64;

  /**
   * Number of successfully completed objects
   */
  @visibility("read")
  numberOfObjectsCompleted?: int64;

  /**
   * Number of database/object errors.
   */
  @visibility("read")
  errorCount?: int64;

  /**
   * Wildcard string prefix to use for querying all errors of the item
   */
  @visibility("read")
  errorPrefix?: string;

  /**
   * Wildcard string prefix to use for querying all sub-tem results of the item
   */
  @visibility("read")
  resultPrefix?: string;

  /**
   * Migration exceptions and warnings.
   */
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  /**
   * Last time the storage was updated
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStorageUpdate?: utcDateTime;

  /**
   * Summary of object results in the migration
   */
  @visibility("read")
  objectSummary?: string;

  /**
   * Result type
   */
  resultType: "DatabaseLevelOutput";
}

model MigrateMySqlAzureDbForMySqlOfflineTaskOutputTableLevel
  extends MigrateMySqlAzureDbForMySqlOfflineTaskOutput {
  /**
   * Name of the item
   */
  @visibility("read")
  objectName?: string;

  /**
   * Migration start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * Migration end time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Current state of migration
   */
  @visibility("read")
  state?: MigrationState;

  /**
   * Status message
   */
  @visibility("read")
  statusMessage?: string;

  /**
   * Number of items
   */
  @visibility("read")
  itemsCount?: int64;

  /**
   * Number of successfully completed items
   */
  @visibility("read")
  itemsCompletedCount?: int64;

  /**
   * Wildcard string prefix to use for querying all errors of the item
   */
  @visibility("read")
  errorPrefix?: string;

  /**
   * Wildcard string prefix to use for querying all sub-tem results of the item
   */
  @visibility("read")
  resultPrefix?: string;

  /**
   * Last time the storage was updated
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStorageUpdate?: utcDateTime;

  /**
   * Result type
   */
  resultType: "TableLevelOutput";
}

model MigrateMySqlAzureDbForMySqlOfflineTaskOutputError
  extends MigrateMySqlAzureDbForMySqlOfflineTaskOutput {
  /**
   * Migration error
   */
  @visibility("read")
  error?: ReportableException;

  /**
   * Result type
   */
  resultType: "ErrorOutput";
}
