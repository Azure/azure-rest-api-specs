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

@doc("The scale type applicable to the SKU.")
enum ResourceSkuCapacityScaleType {
  Automatic,
  Manual,
  None,
}

@doc("The type of restrictions.")
enum ResourceSkuRestrictionsType {
  location,
}

@doc("The reason code for restriction.")
enum ResourceSkuRestrictionsReasonCode {
  QuotaId,
  NotAvailableForSubscription,
}

@doc("The resource's provisioning state")
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

@doc("The scalability approach")
enum ServiceScalability {
  none,
  manual,
  automatic,
}

@doc("Task type.")
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

@doc("The state of the task. This is ignored if submitted.")
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

@doc("Command type.")
enum CommandType {
  `Migrate.Sync.Complete.Database`,
  `Migrate.SqlServer.AzureDbSqlMi.Complete`,
  cancel,
  finish,
  restart,
}

@doc("The state of the command. This is ignored if submitted.")
enum CommandState {
  Unknown,
  Accepted,
  Running,
  Succeeded,
  Failed,
}

@doc("The reason why the name is not available, if nameAvailable is false")
enum NameCheckFailureReason {
  AlreadyExists,
  Invalid,
}

@doc("Source platform of the project")
enum ProjectSourcePlatform {
  SQL,
  MySQL,
  PostgreSql,
  MongoDb,
  Unknown,
}

@doc("Target platform of the project")
enum ProjectTargetPlatform {
  SQLDB,
  SQLMI,
  AzureDbForMySql,
  AzureDbForPostgreSql,
  MongoDb,
  Unknown,
}

@doc("The project's provisioning state")
enum ProjectProvisioningState {
  Deleting,
  Succeeded,
}

@doc("An enumeration of possible authentication types when connecting")
enum AuthenticationType {
  None,
  WindowsAuthentication,
  SqlAuthentication,
  ActiveDirectoryIntegrated,
  ActiveDirectoryPassword,
}

@doc("An enumeration of source platform types")
enum SqlSourcePlatform {
  SqlOnPrem,
}

@doc("Enum of the different backup types.")
enum BackupType {
  Database,
  TransactionLog,
  File,
  DifferentialDatabase,
  DifferentialFile,
  Partial,
  DifferentialPartial,
}

@doc("An enumeration of Status of the log backup file.")
enum BackupFileStatus {
  Arrived,
  Queued,
  Uploading,
  Uploaded,
  Restoring,
  Restored,
  Cancelled,
}

@doc("An enumeration of possible target types when migrating from MySQL")
enum MySqlTargetPlatformType {
  SqlServer,
  AzureDbForMySQL,
}

@doc("An enumeration of SQL Server database file types")
enum DatabaseFileType {
  Rows,
  Log,
  Filestream,
  NotSupported,
  Fulltext,
}

@doc("An enumeration of SQL Server database compatibility levels")
enum DatabaseCompatLevel {
  CompatLevel80,
  CompatLevel90,
  CompatLevel100,
  CompatLevel110,
  CompatLevel120,
  CompatLevel130,
  CompatLevel140,
}

@doc("An enumeration of SQL Server Database states")
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

@doc("Enum mapping of SMO LoginType.")
enum LoginType {
  WindowsUser,
  WindowsGroup,
  SqlLogin,
  Certificate,
  AsymmetricKey,
  ExternalUser,
  ExternalGroup,
}

@doc("Option for how schema is extracted and applied to target")
enum SchemaMigrationOption {
  None,
  ExtractFromSource,
  UseStorageFile,
}

@doc("Current state of migration")
enum MigrationState {
  None,
  InProgress,
  Failed,
  Warning,
  Completed,
  Skipped,
  Stopped,
}

@doc("Current stage of schema migration")
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

@doc("Enum of the different state of database level online migration.")
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

@doc("Enum of the different state of table level online migration.")
enum SyncTableMigrationState {
  BEFORE_LOAD,
  FULL_LOAD,
  COMPLETED,
  CANCELED,
  ERROR,
  FAILED,
}

@doc("An enumeration of source type")
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

@doc("An enumeration of target type")
enum ScenarioTarget {
  SQLServer,
  SQLDB,
  SQLDW,
  SQLMI,
  AzureDBForMySql,
  AzureDBForPostgresSQL,
  MongoDB,
}

@doc("Wrapper for replicate reported migration states.")
enum ReplicateMigrationState {
  UNDEFINED,
  VALIDATING,
  PENDING,
  COMPLETE,
  ACTION_REQUIRED,
  FAILED,
}

@doc("Current status of migration")
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

@doc("Current status of the validation")
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

@doc("Current stage of migration")
enum DatabaseMigrationStage {
  None,
  Initialize,
  Backup,
  FileCopy,
  Restore,
  Completed,
}

@doc("Severity of the validation error")
enum Severity {
  Message,
  Warning,
  Error,
}

@doc("An enumeration of type of objects")
enum ObjectType {
  StoredProcedures,
  Table,
  User,
  View,
  Function,
}

@doc("Type of the actual difference for the compared object, while performing schema comparison")
enum UpdateActionType {
  DeletedOnTarget,
  ChangedOnTarget,
  AddedOnTarget,
}

@doc("Database level migration state.")
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

@doc("An enumeration of backup modes")
enum BackupMode {
  CreateBackup,
  ExistingBackup,
}

@doc("Enum of the different stage of login migration.")
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

@doc("An enumeration of supported source SSIS store type in DMS")
enum SsisStoreType {
  SsisCatalog,
}

@doc("The overwrite option for SSIS object migration, only ignore and overwrite are supported in DMS now and future may add Reuse option for container object")
enum SsisMigrationOverwriteOption {
  Ignore,
  Overwrite,
}

@doc("Current stage of SSIS migration")
enum SsisMigrationStage {
  None,
  Initialize,
  InProgress,
  Completed,
}

@doc("The field ordering")
enum MongoDbShardKeyOrder {
  Forward,
  Reverse,
  Hashed,
}

@doc("The type of data source")
enum MongoDbClusterType {
  BlobContainer,
  CosmosDb,
  MongoDb,
}

@doc("The type of error or warning")
enum MongoDbErrorType {
  Error,
  ValidationError,
  Warning,
}

@doc("The type of progress object")
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

@doc("Describes how changes will be replicated from the source to the target. The default is OneTime.")
enum MongoDbReplication {
  Disabled,
  OneTime,
  Continuous,
}

@doc("Result code of the data migration")
enum DataMigrationResultCode {
  Initial,
  Completed,
  ObjectNotExistsInSource,
  ObjectNotExistsInTarget,
  TargetObjectIsInaccessible,
  FatalError,
}

@doc("Error type")
enum ErrorType {
  Default,
  Warning,
  Error,
}

@doc("Permission group for validations. These groups will run a set of permissions for validating user activity. Select the permission group for the activity that you are performing.")
@fixed
enum ServerLevelPermissionsGroup {
  Default,
  MigrationFromSqlServerToAzureDB,
  MigrationFromSqlServerToAzureMI,
  MigrationFromMySQLToAzureDBForMySQL,
  MigrationFromSqlServerToAzureVM,
}

@doc("Database Migration Resource properties for SQL database.")
model DatabaseMigrationSqlDBProperties extends DatabaseMigrationProperties {
  @doc("Detailed migration status. Not included by default.")
  @visibility("read")
  migrationStatusDetails?: SqlDbMigrationStatusDetails;

  @doc("Target SQL DB connection details.")
  targetSqlConnection?: SqlConnectionInformation;

  @doc("Offline configuration.")
  @visibility("read")
  offlineConfiguration?: SqlDbOfflineConfiguration;

  @doc("List of tables to copy.")
  tableList?: string[];

  kind: "SqlDb";
}

@doc("Detailed status of current Sql Db migration.")
model SqlDbMigrationStatusDetails {
  @doc("Current State of Migration.")
  @visibility("read")
  migrationState?: string;

  @doc("Sql Data Copy errors, if any.")
  @visibility("read")
  sqlDataCopyErrors?: string[];

  @doc("Details on progress of ADF copy activities.")
  @visibility("read")
  listOfCopyProgressDetails?: CopyProgressDetails[];
}

@doc("Details on progress of ADF copy activity")
model CopyProgressDetails {
  @doc("Table Name")
  @visibility("read")
  tableName?: string;

  @doc("Status of the Copy activity (InProgress, Succeeded, Failed, Canceled).")
  @visibility("read")
  status?: string;

  @doc("Type of parallel copy (Dynamic range, Physical partition, none).")
  @visibility("read")
  parallelCopyType?: string;

  @doc("The degree of parallelization.")
  @visibility("read")
  usedParallelCopies?: int32;

  @doc("Bytes read")
  @visibility("read")
  dataRead?: int32;

  @doc("Bytes written")
  @visibility("read")
  dataWritten?: int32;

  @doc("Rows read")
  @visibility("read")
  rowsRead?: int32;

  @doc("Rows Copied")
  @visibility("read")
  rowsCopied?: int32;

  @doc("Copy Start")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  copyStart?: utcDateTime;

  @doc("Copy throughput in KBps")
  @visibility("read")
  copyThroughput?: float32;

  @doc("Copy Duration in seconds")
  @visibility("read")
  copyDuration?: int32;
}

@doc("Source SQL Connection")
model SqlConnectionInformation {
  @doc("Data source.")
  dataSource?: string;

  @doc("Authentication type.")
  authentication?: string;

  @doc("User name to connect to source SQL.")
  userName?: string;

  @doc("Password to connect to source SQL.")
  @secret
  password?: string;

  @doc("Whether to encrypt connection or not.")
  encryptConnection?: boolean;

  @doc("Whether to trust server certificate or not.")
  trustServerCertificate?: boolean;
}

@doc("Offline configuration")
model SqlDbOfflineConfiguration {
  @doc("Offline migration")
  @visibility("read")
  offline?: boolean;
}

@doc("Database Migration Resource properties.")
@discriminator("kind")
model DatabaseMigrationProperties {
  @doc("Resource Id of the target resource (SQL VM or SQL Managed Instance).")
  @visibility("read", "create")
  scope?: string;

  @doc("Provisioning State of migration. ProvisioningState as Succeeded implies that validations have been performed and migration has started.")
  @visibility("read")
  provisioningState?: string;

  @doc("Migration status.")
  @visibility("read")
  migrationStatus?: string;

  @doc("Database migration start time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Database migration end time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Source SQL Server connection details.")
  sourceSqlConnection?: SqlConnectionInformation;

  @doc("Name of the source database.")
  sourceDatabaseName?: string;

  @doc("Name of the source sql server.")
  @visibility("read")
  sourceServerName?: string;

  @doc("Resource Id of the Migration Service.")
  migrationService?: string;

  @doc("ID tracking current migration operation.")
  migrationOperationId?: string;

  @doc("Error details in case of migration failure.")
  @visibility("read")
  migrationFailureError?: ErrorInfo;

  @doc("Database collation to be used for the target database.")
  targetDatabaseCollation?: string;

  @doc("Error message for migration provisioning failure, if any.")
  provisioningError?: string;
}

@doc("Error details")
model ErrorInfo {
  @doc("Error code.")
  @visibility("read")
  code?: string;

  @doc("Error message.")
  @visibility("read")
  message?: string;
}

@doc("Migration Operation Input")
model MigrationOperationInput {
  @doc("ID tracking migration operation.")
  migrationOperationId?: string;
}

@doc("Database Migration Resource properties for SQL Managed Instance.")
model DatabaseMigrationSqlMIProperties extends DatabaseMigrationProperties {
  @doc("Detailed migration status. Not included by default.")
  @visibility("read")
  migrationStatusDetails?: MigrationStatusDetails;

  @doc("Backup configuration info.")
  backupConfiguration?: BackupConfiguration;

  @doc("Offline configuration.")
  offlineConfiguration?: OfflineConfiguration;

  kind: "SqlMi";
}

@doc("Detailed status of current migration.")
model MigrationStatusDetails {
  @doc("Current State of Migration.")
  @visibility("read")
  migrationState?: string;

  @doc("Details of full backup set.")
  @visibility("read")
  fullBackupSetInfo?: SqlBackupSetInfo;

  @doc("Last applied backup set information.")
  @visibility("read")
  lastRestoredBackupSetInfo?: SqlBackupSetInfo;

  @doc("Backup sets that are currently active.")
  @visibility("read")
  activeBackupSets?: SqlBackupSetInfo[];

  @doc("Files that are not valid backup files.")
  @visibility("read")
  invalidFiles?: string[];

  @doc("Name of blob container.")
  @visibility("read")
  blobContainerName?: string;

  @doc("Whether full backup has been applied to the target database or not.")
  @visibility("read")
  isFullBackupRestored?: boolean;

  @doc("Restore blocking reason, if any")
  @visibility("read")
  restoreBlockingReason?: string;

  @doc("Complete restore error message, if any")
  @visibility("read")
  completeRestoreErrorMessage?: string;

  @doc("File upload blocking errors, if any.")
  @visibility("read")
  fileUploadBlockingErrors?: string[];

  @doc("File name that is currently being restored.")
  @visibility("read")
  currentRestoringFilename?: string;

  @doc("Last restored file name.")
  @visibility("read")
  lastRestoredFilename?: string;

  @doc("Total pending log backups.")
  @visibility("read")
  pendingLogBackupsCount?: int32;
}

@doc("Information of backup set")
model SqlBackupSetInfo {
  @doc("Backup set id.")
  @visibility("read")
  backupSetId?: string;

  @doc("First LSN of the backup set.")
  @visibility("read")
  firstLSN?: string;

  @doc("Last LSN of the backup set.")
  @visibility("read")
  lastLSN?: string;

  @doc("Backup type.")
  @visibility("read")
  backupType?: string;

  @doc("List of files in the backup set.")
  @visibility("read")
  listOfBackupFiles?: SqlBackupFileInfo[];

  @doc("Backup start date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupStartDate?: utcDateTime;

  @doc("Backup end time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupFinishDate?: utcDateTime;

  @doc("Whether this backup set has been restored or not.")
  @visibility("read")
  isBackupRestored?: boolean;

  @doc("Has Backup Checksums")
  @visibility("read")
  hasBackupChecksums?: boolean;

  @doc("Media family count")
  @visibility("read")
  familyCount?: int32;

  @doc("The reasons why the backup set is ignored")
  @visibility("read")
  ignoreReasons?: string[];
}

@doc("Information of backup file")
model SqlBackupFileInfo {
  @doc("File name.")
  @visibility("read")
  fileName?: string;

  @doc("Status of the file. (Initial, Uploading, Uploaded, Restoring, Restored or Skipped)")
  @visibility("read")
  status?: string;

  @doc("File size in bytes")
  @visibility("read")
  totalSize?: int32;

  @doc("Bytes read")
  @visibility("read")
  dataRead?: int32;

  @doc("Bytes written")
  @visibility("read")
  dataWritten?: int32;

  @doc("Copy throughput in KBps")
  @visibility("read")
  copyThroughput?: float32;

  @doc("Copy Duration in seconds")
  @visibility("read")
  copyDuration?: int32;

  @doc("Media family sequence number")
  @visibility("read")
  familySequenceNumber?: int32;
}

@doc("Backup Configuration")
model BackupConfiguration {
  @doc("Source location of backups.")
  sourceLocation?: SourceLocation;

  @doc("Target location for copying backups.")
  targetLocation?: TargetLocation;
}

@doc("Source Location details of backups.")
model SourceLocation {
  @doc("Source File share.")
  fileShare?: SqlFileShare;

  @doc("Source Azure Blob.")
  azureBlob?: AzureBlob;

  @doc("Backup storage Type.")
  @visibility("read")
  fileStorageType?: string;
}

@doc("File share")
model SqlFileShare {
  @doc("Location as SMB share or local drive where backups are placed.")
  path?: string;

  @doc("Username to access the file share location for backups.")
  username?: string;

  @doc("Password for username to access file share location.")
  @visibility("create", "update")
  @secret
  password?: string;
}

@doc("Azure Blob Details")
model AzureBlob {
  @doc("Resource Id of the storage account where backups are stored.")
  storageAccountResourceId?: string;

  @doc("Storage Account Key.")
  accountKey?: string;

  @doc("Blob container name where backups are stored.")
  blobContainerName?: string;
}

@doc("Target Location details for optional copy of backups")
model TargetLocation {
  @doc("Resource Id of the storage account copying backups.")
  storageAccountResourceId?: string;

  @doc("Storage Account Key.")
  accountKey?: string;
}

@doc("Offline configuration")
model OfflineConfiguration {
  @doc("Offline migration")
  offline?: boolean;

  @doc("Last backup name for offline migration. This is optional for migrations from file share. If it is not provided, then the service will determine the last backup file name based on latest backup files present in file share.")
  lastBackupName?: string;
}

@doc("Database Migration Resource properties for SQL Virtual Machine.")
model DatabaseMigrationSqlVmProperties extends DatabaseMigrationProperties {
  @doc("Detailed migration status. Not included by default.")
  @visibility("read")
  migrationStatusDetails?: MigrationStatusDetails;

  @doc("Backup configuration info.")
  backupConfiguration?: BackupConfiguration;

  @doc("Offline configuration.")
  offlineConfiguration?: OfflineConfiguration;

  kind: "SqlVm";
}

model OperationsDefinition {
  @visibility("read")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @visibility("read")
  display?: OperationsDisplayDefinition;

  @visibility("read")
  origin?: OperationOrigin;

  @doc("Dictionary of <AnyObject>")
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

@doc("The SQL Migration Service properties.")
model SqlMigrationServiceProperties {
  @doc("Provisioning state to track the async operation status.")
  @visibility("read")
  provisioningState?: string;

  @doc("Current state of the Integration runtime.")
  @visibility("read")
  integrationRuntimeState?: string;
}

@doc("An update to a SQL Migration Service.")
model SqlMigrationServiceUpdate {
  @doc("Dictionary of <string>")
  tags?: Record<string>;
}

@doc("An authentication key.")
model AuthenticationKeys {
  @doc("The first authentication key.")
  @visibility("read", "create")
  authKey1?: string;

  @doc("The second authentication key.")
  @visibility("read", "create")
  authKey2?: string;
}

@doc("An authentication key to regenerate.")
model RegenAuthKeys {
  @doc("The name of authentication key to generate.")
  @visibility("read", "create")
  keyName?: string;

  @doc("The first authentication key.")
  @visibility("read", "create")
  authKey1?: string;

  @doc("The second authentication key.")
  @visibility("read", "create")
  authKey2?: string;
}

@doc("Details of node to be deleted.")
model DeleteNode {
  @doc("The name of node to delete.")
  @visibility("read", "create")
  nodeName?: string;

  @doc("The name of integration runtime.")
  @visibility("read", "create")
  integrationRuntimeName?: string;
}

@doc("A list of Database Migrations.")
model DatabaseMigrationListResult is Azure.Core.Page<DatabaseMigration>;

@doc("Database Migration Resource.")
model DatabaseMigration extends ProxyResource {
  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Database Migration Resource properties.")
  properties?: DatabaseMigrationProperties;
}

@doc("Integration Runtime Monitoring Data.")
model IntegrationRuntimeMonitoringData {
  @doc("The name of Integration Runtime.")
  @visibility("read")
  name?: string;

  @doc("Integration Runtime node monitoring data.")
  @visibility("read")
  nodes?: NodeMonitoringData[];
}

model NodeMonitoringData {
  @doc(" Unmatched properties from the message are deserialized in this collection.")
  @visibility("read")
  additionalProperties?: Record<Record<unknown>>;

  @doc("Name of the integration runtime node.")
  @visibility("read")
  nodeName?: string;

  @doc("Available memory (MB) on the integration runtime node.")
  @visibility("read")
  availableMemoryInMB?: int32;

  @doc("CPU percentage on the integration runtime node.")
  @visibility("read")
  cpuUtilization?: int32;

  @doc("Maximum concurrent jobs on the integration runtime node.")
  @visibility("read")
  concurrentJobsLimit?: int32;

  @doc("The number of jobs currently running on the integration runtime node.")
  @visibility("read")
  concurrentJobsRunning?: int32;

  @doc("The maximum concurrent jobs in this integration runtime.")
  @visibility("read")
  maxConcurrentJobs?: int32;

  @doc("Sent bytes on the integration runtime node.")
  @visibility("read")
  sentBytes?: float32;

  @doc("Received bytes on the integration runtime node.")
  @visibility("read")
  receivedBytes?: float32;
}

@doc("The DMS List SKUs operation response.")
model ResourceSkusResult is Azure.Core.Page<ResourceSku>;

@doc("Describes scaling information of a SKU.")
model ResourceSkuCapacity {
  @doc("The minimum capacity.")
  @visibility("read")
  minimum?: int32;

  @doc("The maximum capacity.")
  @visibility("read")
  maximum?: int32;

  @doc("The default capacity.")
  @visibility("read")
  default?: int32;

  @doc("The scale type applicable to the SKU.")
  @visibility("read")
  scaleType?: ResourceSkuCapacityScaleType;
}

@doc("Describes metadata for retrieving price info.")
model ResourceSkuCosts {
  @doc("Used for querying price from commerce.")
  @visibility("read")
  meterID?: string;

  @doc("The multiplier is needed to extend the base metered cost.")
  @visibility("read")
  quantity?: int32;

  @doc("An invariant to show the extended unit.")
  @visibility("read")
  extendedUnit?: string;
}

@doc("Describes The SKU capabilities object.")
model ResourceSkuCapabilities {
  @doc("An invariant to describe the feature.")
  @visibility("read")
  name?: string;

  @doc("An invariant if the feature is measured by quantity.")
  @visibility("read")
  value?: string;
}

@doc("Describes scaling information of a SKU.")
model ResourceSkuRestrictions {
  @doc("The type of restrictions.")
  @visibility("read")
  type?: ResourceSkuRestrictionsType;

  @doc("The value of restrictions. If the restriction type is set to location. This would be different locations where the SKU is restricted.")
  @visibility("read")
  values?: string[];

  @doc("The reason code for restriction.")
  @visibility("read")
  reasonCode?: ResourceSkuRestrictionsReasonCode;
}

@doc("Error information.")
@error
model ApiError {
  @doc("Error information in OData format")
  error?: ODataError;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Error information in OData format.")
model ODataError {
  @doc("The machine-readable description of the error, such as 'InvalidRequest' or 'InternalServerError'")
  code?: string;

  @doc("The human-readable description of the error")
  message?: string;

  @doc("Inner errors that caused this error")
  details?: ODataError[];
}

@doc("Properties of the Database Migration Service instance")
model DataMigrationServiceProperties {
  @doc("The resource's provisioning state")
  @visibility("read")
  provisioningState?: ServiceProvisioningState;

  @doc("The public key of the service, used to encrypt secrets sent to the service")
  publicKey?: string;

  @doc("The ID of the Microsoft.Network/virtualNetworks/subnets resource to which the service should be joined")
  virtualSubnetId?: string;

  @doc("The ID of the Microsoft.Network/networkInterfaces resource which the service have")
  virtualNicId?: string;

  @doc("The time delay before the service is auto-stopped when idle.")
  autoStopDelay?: string;

  @doc("Whether service resources should be deleted when stopped. (Turned on by default)")
  deleteResourcesOnStop?: boolean;
}

@doc("An Azure SKU instance")
model ServiceSku {
  @doc("The unique name of the SKU, such as 'P3'")
  name?: string;

  @doc("The tier of the SKU, such as 'Basic', 'General Purpose', or 'Business Critical'")
  tier?: string;

  @doc("The SKU family, used when the service has multiple performance classes within a tier, such as 'A', 'D', etc. for virtual machines")
  family?: string;

  @doc("The size of the SKU, used when the name alone does not denote a service size or when a SKU has multiple performance classes within a family, e.g. 'A1' for virtual machines")
  size?: string;

  @doc("The capacity of the SKU, if it supports scaling")
  capacity?: int32;
}

@doc("Service health status")
model DataMigrationServiceStatusResponse {
  @doc("The DMS instance agent version")
  agentVersion?: string;

  @doc("Agent Configuration")
  agentConfiguration?: Record<unknown>;

  @doc("The machine-readable status, such as 'Initializing', 'Offline', 'Online', 'Deploying', 'Deleting', 'Stopped', 'Stopping', 'Starting', 'FailedToStart', 'FailedToStop' or 'Failed'")
  status?: string;

  @doc("The services virtual machine size, such as 'Standard_D2_v2'")
  vmSize?: string;

  @doc("The list of supported task types")
  supportedTaskTypes?: string[];
}

@doc("OData page of available SKUs")
model ServiceSkuList is Azure.Core.Page<AvailableServiceSku>;

@doc("Describes the available service SKU.")
model AvailableServiceSku {
  @doc("The resource type, including the provider namespace")
  resourceType?: string;

  @doc("SKU name, tier, etc.")
  sku?: AvailableServiceSkuSku;

  @doc("A description of the scaling capacities of the SKU")
  capacity?: AvailableServiceSkuCapacity;
}

@doc("SKU name, tier, etc.")
model AvailableServiceSkuSku {
  @doc("The name of the SKU")
  name?: string;

  @doc("SKU family")
  family?: string;

  @doc("SKU size")
  size?: string;

  @doc("The tier of the SKU, such as \"Basic\", \"General Purpose\", or \"Business Critical\"")
  tier?: string;
}

@doc("A description of the scaling capacities of the SKU")
model AvailableServiceSkuCapacity {
  @doc("The minimum capacity, usually 0 or 1.")
  minimum?: int32;

  @doc("The maximum capacity")
  maximum?: int32;

  @doc("The default capacity")
  default?: int32;

  @doc("The scalability approach")
  scaleType?: ServiceScalability;
}

@doc("Base class for all types of DMS task properties. If task is not supported by current client, this object is returned.")
@discriminator("taskType")
model ProjectTaskProperties {
  @doc("Array of errors. This is ignored if submitted.")
  @visibility("read")
  errors?: ODataError[];

  @doc("The state of the task. This is ignored if submitted.")
  @visibility("read")
  state?: TaskState;

  @doc("Array of command properties.")
  @visibility("read")
  commands?: CommandProperties[];

  @doc("Key value pairs of client data to attach meta data information to task")
  clientData?: Record<string>;
}

@doc("Base class for all types of DMS command properties. If command is not supported by current client, this object is returned.")
@discriminator("commandType")
model CommandProperties {
  @doc("Array of errors. This is ignored if submitted.")
  @visibility("read")
  errors?: ODataError[];

  @doc("The state of the command. This is ignored if submitted.")
  @visibility("read")
  state?: CommandState;
}

@doc("ARM resource.")
model Resource {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;

  @doc("Resource name.")
  @visibility("read")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;
}

@doc("A resource type and proposed name")
model NameAvailabilityRequest {
  @doc("The proposed resource name")
  name?: string;

  @doc("The resource type chain (e.g. virtualMachines/extensions)")
  type?: string;
}

@doc("Indicates whether a proposed resource name is available")
model NameAvailabilityResponse {
  @doc("If true, the name is valid and available. If false, 'reason' describes why not.")
  nameAvailable?: boolean;

  @doc("The reason why the name is not available, if nameAvailable is false")
  reason?: NameCheckFailureReason;

  @doc("The localized reason why the name is not available, if nameAvailable is false")
  message?: string;
}

@doc("Project-specific properties")
model ProjectProperties {
  @doc("Source platform for the project")
  sourcePlatform: ProjectSourcePlatform;

  @doc("Field that defines the Azure active directory application info, used to connect to the target Azure resource")
  azureAuthenticationInfo?: AzureActiveDirectoryApp;

  @doc("Target platform for the project")
  targetPlatform: ProjectTargetPlatform;

  @doc("UTC Date and time when project was created")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Information for connecting to source")
  sourceConnectionInfo?: ConnectionInfo;

  @doc("Information for connecting to target")
  targetConnectionInfo?: ConnectionInfo;

  @doc("List of DatabaseInfo")
  databasesInfo?: DatabaseInfo[];

  @doc("The project's provisioning state")
  @visibility("read")
  provisioningState?: ProjectProvisioningState;
}

@doc("Azure Active Directory Application")
model AzureActiveDirectoryApp {
  @doc("Application ID of the Azure Active Directory Application")
  applicationId?: string;

  @doc("Key used to authenticate to the Azure Active Directory Application")
  appKey?: string;

  @doc("Tenant id of the customer")
  tenantId?: string;

  @doc("Ignore checking azure permissions on the AAD app")
  ignoreAzurePermissions?: boolean;
}

@doc("Defines the connection properties of a server")
@discriminator("type")
model ConnectionInfo {
  @doc("User name")
  userName?: string;

  @doc("Password credential.")
  password?: string;
}

@doc("Project Database Details")
model DatabaseInfo {
  @doc("Name of the database")
  sourceDatabaseName: string;
}

@doc("OData page of quota objects")
model QuotaList is Azure.Core.Page<Quota>;

@doc("Describes a quota for or usage details about a resource")
model Quota {
  @doc("The current value of the quota. If null or missing, the current value cannot be determined in the context of the request.")
  currentValue?: float32;

  @doc("The resource ID of the quota object")
  id?: string;

  @doc("The maximum value of the quota. If null or missing, the quota has no maximum, in which case it merely tracks usage.")
  limit?: float32;

  @doc("The name of the quota")
  name?: QuotaName;

  @doc("The unit for the quota, such as Count, Bytes, BytesPerSecond, etc.")
  unit?: string;
}

@doc("The name of the quota")
model QuotaName {
  @doc("The localized name of the quota")
  localizedValue?: string;

  @doc("The unlocalized name (or ID) of the quota")
  value?: string;
}

@doc("Base class for file properties.")
model ProjectFileProperties {
  @doc("Optional File extension. If submitted it should not have a leading period and must match the extension from filePath.")
  extension?: string;

  @doc("Relative path of this file resource. This property can be set when creating or updating the file resource.")
  filePath?: string;

  @doc("Modification DateTime.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  @doc("File content type. This property can be modified to reflect the file content type.")
  mediaType?: string;

  @doc("File size.")
  @visibility("read")
  size?: int32;
}

@doc("File storage information.")
model FileStorageInfo {
  @doc("A URI that can be used to access the file content.")
  uri?: string;

  @doc("Dictionary of <string>")
  headers?: Record<string>;
}

@doc("Properties for the command that completes sync migration for a database.")
model MigrateSyncCompleteCommandProperties extends CommandProperties {
  @doc("Command input")
  input?: MigrateSyncCompleteCommandInput;

  @doc("Command output. This is ignored if submitted.")
  @visibility("read")
  output?: MigrateSyncCompleteCommandOutput;

  @doc("Command id")
  commandId?: string;

  @doc("Command type.")
  commandType: "Migrate.Sync.Complete.Database";
}

@doc("Input for command that completes sync migration for a database.")
model MigrateSyncCompleteCommandInput {
  @doc("Name of database")
  databaseName: string;

  @doc("Time stamp to complete")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  commitTimeStamp?: utcDateTime;
}

@doc("Output for command that completes sync migration for a database.")
model MigrateSyncCompleteCommandOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;

  @doc("List of errors that happened during the command execution")
  @visibility("read")
  errors?: ReportableException[];
}

@doc("Exception object for all custom exceptions")
model ReportableException {
  @doc("Error message")
  message?: string;

  @doc("Actionable steps for this exception")
  actionableMessage?: string;

  @doc("The path to the file where exception occurred")
  filePath?: string;

  @doc("The line number where exception occurred")
  lineNumber?: string;

  @doc("Coded numerical value that is assigned to a specific exception")
  hResult?: int32;

  @doc("Stack trace")
  stackTrace?: string;
}

@doc("Properties for the command that completes online migration for an Azure SQL Database Managed Instance.")
model MigrateMISyncCompleteCommandProperties extends CommandProperties {
  @doc("Command input")
  input?: MigrateMISyncCompleteCommandInput;

  @doc("Command output. This is ignored if submitted.")
  @visibility("read")
  output?: MigrateMISyncCompleteCommandOutput;

  @doc("Command type.")
  commandType: "Migrate.SqlServer.AzureDbSqlMi.Complete";
}

@doc("Input for command that completes online migration for an Azure SQL Database Managed Instance.")
model MigrateMISyncCompleteCommandInput {
  @doc("Name of managed instance database")
  sourceDatabaseName: string;
}

@doc("Output for command that completes online migration for an Azure SQL Database Managed Instance.")
model MigrateMISyncCompleteCommandOutput {
  @doc("List of errors that happened during the command execution")
  errors?: ReportableException[];
}

@doc("Describes a connection to a MongoDB data source")
model MongoDbConnectionInfo extends ConnectionInfo {
  @doc("A MongoDB connection string or blob container URL. The user name and password can be specified here or in the userName and password properties")
  connectionString: string;

  @doc("Data source ")
  dataSource?: string;

  @doc("Whether to encrypt the connection")
  encryptConnection?: boolean;

  @doc("server brand version")
  serverBrandVersion?: string;

  @doc("server version")
  serverVersion?: string;

  @doc("name of the server")
  serverName?: string;

  @doc("Whether to trust the server certificate")
  trustServerCertificate?: boolean;

  enforceSSL?: boolean;

  @doc("port for server")
  port?: int32;

  @doc("Additional connection settings")
  additionalSettings?: string;

  @doc("Authentication type to use for connection")
  authentication?: AuthenticationType;

  @doc("Type of connection info")
  type: "MongoDbConnectionInfo";
}

@doc("Information for connecting to SQL database server")
model SqlConnectionInfo extends ConnectionInfo {
  @doc("Data source in the format Protocol:MachineName\\SQLServerInstanceName,PortNumber")
  dataSource: string;

  @doc("name of the server")
  serverName?: string;

  @doc("Port for Server")
  port?: int32;

  @doc("server version")
  serverVersion?: string;

  @doc("server brand version")
  serverBrandVersion?: string;

  @doc("Represents the ID of an HTTP resource represented by an Azure resource provider.")
  resourceId?: string;

  @doc("Authentication type to use for connection")
  authentication?: AuthenticationType;

  @doc("Whether to encrypt the connection")
  encryptConnection?: boolean;

  @doc("Additional connection settings")
  additionalSettings?: string;

  @doc("Whether to trust the server certificate")
  trustServerCertificate?: boolean;

  @doc("Server platform type for connection")
  platform?: SqlSourcePlatform;

  @doc("Type of connection info")
  type: "SqlConnectionInfo";
}

@doc("Information for connecting to MySQL server")
model MySqlConnectionInfo extends ConnectionInfo {
  @doc("Name of the server")
  serverName: string;

  @doc("Data source ")
  dataSource?: string;

  @doc("Port for Server")
  port: int32;

  @doc("Whether to encrypt the connection")
  encryptConnection?: boolean;

  @doc("Authentication type to use for connection")
  authentication?: AuthenticationType;

  @doc("Additional connection settings")
  additionalSettings?: string;

  @doc("Type of connection info")
  type: "MySqlConnectionInfo";
}

@doc("Information for connecting to Oracle server")
model OracleConnectionInfo extends ConnectionInfo {
  @doc("EZConnect or TNSName connection string.")
  dataSource: string;

  @doc("name of the server")
  serverName?: string;

  @doc("server version")
  serverVersion?: string;

  @doc("port for server")
  port?: int32;

  @doc("Authentication type to use for connection")
  authentication?: AuthenticationType;

  @doc("Type of connection info")
  type: "OracleConnectionInfo";
}

@doc("Information for connecting to PostgreSQL server")
model PostgreSqlConnectionInfo extends ConnectionInfo {
  @doc("Name of the server")
  serverName: string;

  @doc("Data source ")
  dataSource?: string;

  @doc("server version")
  serverVersion?: string;

  @doc("Name of the database")
  databaseName?: string;

  @doc("Port for Server")
  port: int32;

  @doc("Whether to encrypt the connection")
  encryptConnection?: boolean;

  @doc("Whether to trust the server certificate")
  trustServerCertificate?: boolean;

  @doc("Additional connection settings")
  additionalSettings?: string;

  @doc("server brand version")
  serverBrandVersion?: string;

  @doc("Authentication type to use for connection")
  authentication?: AuthenticationType;

  @doc("Type of connection info")
  type: "PostgreSqlConnectionInfo";
}

@doc("Properties required to create a connection to Azure SQL database Managed instance")
model MiSqlConnectionInfo extends ConnectionInfo {
  @doc("Resource id for Azure SQL database Managed instance")
  managedInstanceResourceId: string;

  @doc("Type of connection info")
  type: "MiSqlConnectionInfo";
}

@doc("Information of backup set")
model BackupSetInfo {
  @doc("Id for the set of backup files")
  backupSetId?: string;

  @doc("First log sequence number of the backup file")
  firstLsn?: string;

  @doc("Last log sequence number of the backup file")
  lastLsn?: string;

  @doc("Last modified time of the backup file in share location")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Enum of the different backup types")
  backupType?: BackupType;

  @doc("List of files in the backup set")
  listOfBackupFiles?: BackupFileInfo[];

  @doc("Name of the database to which the backup set belongs")
  databaseName?: string;

  @doc("Date and time that the backup operation began")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupStartDate?: utcDateTime;

  @doc("Date and time that the backup operation finished")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupFinishedDate?: utcDateTime;

  @doc("Whether the backup set is restored or not")
  isBackupRestored?: boolean;
}

@doc("Information of the backup file")
model BackupFileInfo {
  @doc("Location of the backup file in shared folder")
  fileLocation?: string;

  @doc("Sequence number of the backup file in the backup set")
  familySequenceNumber?: int32;

  @doc("Status of the backup file during migration")
  status?: BackupFileStatus;
}

@doc("Information of orphaned users on the SQL server database.")
model OrphanedUserInfo {
  @doc("Name of the orphaned user")
  name?: string;

  @doc("Parent database of the user")
  databaseName?: string;
}

@doc("Input for the task that validates MySQL database connection")
model ConnectToSourceMySqlTaskInput {
  @doc("Information for connecting to MySQL source")
  sourceConnectionInfo: MySqlConnectionInfo;

  @doc("Target Platform for the migration")
  targetPlatform?: MySqlTargetPlatformType;

  @doc("Permission group for validations")
  checkPermissionsGroup?: ServerLevelPermissionsGroup;

  @doc("Flag for whether or not the migration is offline")
  isOfflineMigration?: boolean;
}

@doc("Input for the task that validates connection to SQL Server and also validates source server requirements")
model ConnectToSourceSqlServerTaskInput {
  @doc("Connection information for Source SQL Server")
  sourceConnectionInfo: SqlConnectionInfo;

  @doc("Permission group for validations")
  checkPermissionsGroup?: ServerLevelPermissionsGroup;

  @doc("Flag for whether to collect databases from source server.")
  collectDatabases?: boolean;

  @doc("Flag for whether to collect logins from source server.")
  collectLogins?: boolean;

  @doc("Flag for whether to collect agent jobs from source server.")
  collectAgentJobs?: boolean;

  @doc("Flag for whether to collect TDE Certificate names from source server.")
  collectTdeCertificateInfo?: boolean;

  @doc("Flag for whether to validate SSIS catalog is reachable on the source server.")
  validateSsisCatalogOnly?: boolean;

  @doc("encrypted key for secure fields")
  encryptedKeyForSecureFields?: string;
}

@doc("Output for the task that validates connection to SQL Server and also validates source server requirements")
@discriminator("resultType")
model ConnectToSourceSqlServerTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;
}

@doc("Task level output for the task that validates connection to SQL Server and also validates source server requirements")
model ConnectToSourceSqlServerTaskOutputTaskLevel
  extends ConnectToSourceSqlServerTaskOutput {
  @doc("Source databases as a map from database name to database id")
  @visibility("read")
  databases?: string;

  @doc("Source logins as a map from login name to login id.")
  @visibility("read")
  logins?: string;

  @doc("Source agent jobs as a map from agent job name to id.")
  @visibility("read")
  agentJobs?: string;

  @doc("Mapping from database name to TDE certificate name, if applicable")
  @visibility("read")
  databaseTdeCertificateMapping?: string;

  @doc("Source server version")
  @visibility("read")
  sourceServerVersion?: string;

  @doc("Source server brand version")
  @visibility("read")
  sourceServerBrandVersion?: string;

  @doc("Validation errors")
  @visibility("read")
  validationErrors?: ReportableException[];

  @doc("Type of result - database level or task level")
  resultType: "TaskLevelOutput";
}

@doc("Database level output for the task that validates connection to SQL Server and also validates source server requirements")
model ConnectToSourceSqlServerTaskOutputDatabaseLevel
  extends ConnectToSourceSqlServerTaskOutput {
  @doc("Database name")
  @visibility("read")
  name?: string;

  @doc("Size of the file in megabytes")
  @visibility("read")
  sizeMB?: float32;

  @doc("The list of database files")
  @visibility("read")
  databaseFiles?: DatabaseFileInfo[];

  @doc("SQL Server compatibility level of database")
  @visibility("read")
  compatibilityLevel?: DatabaseCompatLevel;

  @doc("State of the database")
  @visibility("read")
  databaseState?: DatabaseState;

  @doc("Type of result - database level or task level")
  resultType: "DatabaseLevelOutput";
}

@doc("Database file specific information")
model DatabaseFileInfo {
  @doc("Name of the database")
  databaseName?: string;

  @doc("Unique identifier for database file")
  id?: string;

  @doc("Logical name of the file")
  logicalName?: string;

  @doc("Operating-system full path of the file")
  physicalFullName?: string;

  @doc("Suggested full path of the file for restoring")
  restoreFullName?: string;

  @doc("Database file type")
  fileType?: DatabaseFileType;

  @doc("Size of the file in megabytes")
  sizeMB?: float32;
}

@doc("Login level output for the task that validates connection to SQL Server and also validates source server requirements")
model ConnectToSourceSqlServerTaskOutputLoginLevel
  extends ConnectToSourceSqlServerTaskOutput {
  @doc("Login name.")
  @visibility("read")
  name?: string;

  @doc("The type of login.")
  @visibility("read")
  loginType?: LoginType;

  @doc("The default database for the login.")
  @visibility("read")
  defaultDatabase?: string;

  @doc("The state of the login.")
  @visibility("read")
  isEnabled?: boolean;

  @doc("Information about eligibility of login for migration.")
  @visibility("read")
  migrationEligibility?: MigrationEligibilityInfo;

  @doc("Type of result - database level or task level")
  resultType: "LoginLevelOutput";
}

@doc("Information about migration eligibility of a server object")
model MigrationEligibilityInfo {
  @doc("Whether object is eligible for migration or not.")
  @visibility("read")
  isEligibleForMigration?: boolean;

  @doc("Information about eligibility failure for the server object.")
  @visibility("read")
  validationMessages?: string[];
}

@doc("Agent Job level output for the task that validates connection to SQL Server and also validates source server requirements")
model ConnectToSourceSqlServerTaskOutputAgentJobLevel
  extends ConnectToSourceSqlServerTaskOutput {
  @doc("Agent Job name")
  @visibility("read")
  name?: string;

  @doc("The type of Agent Job.")
  @visibility("read")
  jobCategory?: string;

  @doc("The state of the original Agent Job.")
  @visibility("read")
  isEnabled?: boolean;

  @doc("The owner of the Agent Job")
  @visibility("read")
  jobOwner?: string;

  @doc("UTC Date and time when the Agent Job was last executed.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastExecutedOn?: utcDateTime;

  @doc("Validation errors")
  @visibility("read")
  validationErrors?: ReportableException[];

  @doc("Information about eligibility of agent job for migration.")
  @visibility("read")
  migrationEligibility?: MigrationEligibilityInfo;

  @doc("Type of result - database level or task level")
  resultType: "AgentJobLevelOutput";
}

@doc("Input for the task that validates connection to PostgreSQL and source server requirements")
model ConnectToSourcePostgreSqlSyncTaskInput {
  @doc("Connection information for source PostgreSQL server")
  sourceConnectionInfo: PostgreSqlConnectionInfo;
}

@doc("Output for the task that validates connection to PostgreSQL and source server requirements")
model ConnectToSourcePostgreSqlSyncTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;

  @doc("Version of the source server")
  @visibility("read")
  sourceServerVersion?: string;

  @doc("List of databases on source server")
  @visibility("read")
  databases?: string[];

  @doc("Source server brand version")
  @visibility("read")
  sourceServerBrandVersion?: string;

  @doc("Validation errors associated with the task")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Input for the task that validates connection to Azure Database for MySQL and target server requirements")
model ConnectToTargetAzureDbForMySqlTaskInput {
  @doc("Connection information for source MySQL server")
  sourceConnectionInfo: MySqlConnectionInfo;

  @doc("Connection information for target Azure Database for MySQL server")
  targetConnectionInfo: MySqlConnectionInfo;

  @doc("Flag for whether or not the migration is offline")
  isOfflineMigration?: boolean;
}

@doc("Output for the task that validates connection to Azure Database for MySQL and target server requirements")
model ConnectToTargetAzureDbForMySqlTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;

  @doc("Version of the target server")
  @visibility("read")
  serverVersion?: string;

  @doc("List of databases on target server")
  @visibility("read")
  databases?: string[];

  @doc("Target server brand version")
  @visibility("read")
  targetServerBrandVersion?: string;

  @doc("Validation errors associated with the task")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Input for the task that validates connection to SQL DB and target server requirements")
model ConnectToTargetSqlDbTaskInput {
  @doc("Connection information for target SQL DB")
  targetConnectionInfo: SqlConnectionInfo;

  @doc("Boolean flag indicating whether to query object counts for each database on the target server")
  queryObjectCounts?: boolean;
}

@doc("Output for the task that validates connection to SQL DB and target server requirements")
model ConnectToTargetSqlDbTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;

  @doc("Source databases as a map from database name to database id")
  @visibility("read")
  databases?: string;

  @doc("Version of the target server")
  @visibility("read")
  targetServerVersion?: string;

  @doc("Target server brand version")
  @visibility("read")
  targetServerBrandVersion?: string;
}

@doc("Input for the task that validates connection to Azure SQL Database Managed Instance online scenario.")
model ConnectToTargetSqlMISyncTaskInput {
  @doc("Connection information for Azure SQL Database Managed Instance")
  targetConnectionInfo: MiSqlConnectionInfo;

  @doc("Azure Active Directory Application the DMS instance will use to connect to the target instance of Azure SQL Database Managed Instance and the Azure Storage Account")
  azureApp: AzureActiveDirectoryApp;
}

@doc("Output for the task that validates connection to Azure SQL Database Managed Instance.")
model ConnectToTargetSqlMISyncTaskOutput {
  @doc("Target server version")
  @visibility("read")
  targetServerVersion?: string;

  @doc("Target server brand version")
  @visibility("read")
  targetServerBrandVersion?: string;

  @doc("Validation errors")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Input for the task that validates connection to Azure SQL Database Managed Instance.")
model ConnectToTargetSqlMITaskInput {
  @doc("Connection information for target SQL Server")
  targetConnectionInfo: SqlConnectionInfo;

  @doc("Flag for whether to collect logins from target SQL MI server.")
  collectLogins?: boolean;

  @doc("Flag for whether to collect agent jobs from target SQL MI server.")
  collectAgentJobs?: boolean;

  @doc("Flag for whether to validate SSIS catalog is reachable on the target SQL MI server.")
  validateSsisCatalogOnly?: boolean;
}

@doc("Output for the task that validates connection to Azure SQL Database Managed Instance.")
model ConnectToTargetSqlMITaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;

  @doc("Target server version")
  @visibility("read")
  targetServerVersion?: string;

  @doc("Target server brand version")
  @visibility("read")
  targetServerBrandVersion?: string;

  @doc("List of logins on the target server.")
  @visibility("read")
  logins?: string[];

  @doc("List of agent jobs on the target server.")
  @visibility("read")
  agentJobs?: string[];

  @doc("Validation errors")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Input for the task that validates connection to Azure SQL DB and target server requirements")
model ConnectToTargetSqlSqlDbSyncTaskInput {
  @doc("Connection information for source SQL Server")
  sourceConnectionInfo: SqlConnectionInfo;

  @doc("Connection information for target SQL DB")
  targetConnectionInfo: SqlConnectionInfo;
}

@doc("Input for the task that validates connection to Azure Database for PostgreSQL and target server requirements")
model ConnectToTargetAzureDbForPostgreSqlSyncTaskInput {
  @doc("Connection information for source PostgreSQL server")
  sourceConnectionInfo: PostgreSqlConnectionInfo;

  @doc("Connection information for target Azure Database for PostgreSQL server")
  targetConnectionInfo: PostgreSqlConnectionInfo;
}

@doc("Output for the task that validates connection to Azure Database for PostgreSQL and target server requirements")
model ConnectToTargetAzureDbForPostgreSqlSyncTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;

  @doc("Version of the target server")
  @visibility("read")
  targetServerVersion?: string;

  @doc("List of databases on target server")
  @visibility("read")
  databases?: string[];

  @doc("Target server brand version")
  @visibility("read")
  targetServerBrandVersion?: string;

  @doc("Validation errors associated with the task")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Input for the task that collects user tables for the given list of databases")
model GetUserTablesMySqlTaskInput {
  @doc("Connection information for SQL Server")
  connectionInfo: MySqlConnectionInfo;

  @doc("List of database names to collect tables for")
  selectedDatabases: string[];
}

@doc("Output of the task that collects user tables for the given list of databases")
model GetUserTablesMySqlTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;

  @doc("Mapping from database name to list of tables")
  @visibility("read")
  databasesToTables?: string;

  @doc("Validation errors")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Table properties")
model DatabaseTable {
  @doc("Indicates whether table is empty or not")
  @visibility("read")
  hasRows?: boolean;

  @doc("Schema-qualified name of the table")
  @visibility("read")
  name?: string;
}

@doc("Input for the task that gets TDE certificates in Base64 encoded format.")
model GetTdeCertificatesSqlTaskInput {
  @doc("Connection information for SQL Server")
  connectionInfo: SqlConnectionInfo;

  @doc("Backup file share information for file share to be used for temporarily storing files.")
  backupFileShare: FileShare;

  @doc("List containing certificate names and corresponding password to use for encrypting the exported certificate.")
  selectedCertificates: SelectedCertificateInput[];
}

@doc("File share information with Path, Username, and Password.")
model FileShare {
  @doc("User name credential to connect to the share location")
  userName?: string;

  @doc("Password credential used to connect to the share location.")
  password?: string;

  @doc("The folder path for this share.")
  path: string;
}

@doc("Info for certificate to be exported for TDE enabled databases.")
model SelectedCertificateInput {
  @doc("Name of certificate to be exported.")
  certificateName: string;

  @doc("Password to use for encrypting the exported certificate.")
  password: string;
}

@doc("Output of the task that gets TDE certificates in Base64 encoded format.")
model GetTdeCertificatesSqlTaskOutput {
  @doc("Mapping from certificate name to base 64 encoded format.")
  @visibility("read")
  base64EncodedCertificates?: string;

  @doc("Validation errors")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Input for the task that collects user tables for the given list of databases")
model GetUserTablesSqlSyncTaskInput {
  @doc("Connection information for SQL Server")
  sourceConnectionInfo: SqlConnectionInfo;

  @doc("Connection information for SQL DB")
  targetConnectionInfo: SqlConnectionInfo;

  @doc("List of source database names to collect tables for")
  selectedSourceDatabases: string[];

  @doc("List of target database names to collect tables for")
  selectedTargetDatabases: string[];
}

@doc("Output of the task that collects user tables for the given list of databases")
model GetUserTablesSqlSyncTaskOutput {
  @doc("Mapping from database name to list of source tables")
  @visibility("read")
  databasesToSourceTables?: string;

  @doc("Mapping from database name to list of target tables")
  @visibility("read")
  databasesToTargetTables?: string;

  @doc("Mapping from database name to list of validation errors")
  @visibility("read")
  tableValidationErrors?: string;

  @doc("Validation errors")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Input for the task that collects user tables for the given list of databases")
model GetUserTablesSqlTaskInput {
  @doc("Connection information for SQL Server")
  connectionInfo: SqlConnectionInfo;

  @doc("List of database names to collect tables for")
  selectedDatabases: string[];

  @doc("encrypted key for secure fields")
  encryptedKeyForSecureFields?: string;
}

@doc("Output of the task that collects user tables for the given list of databases")
model GetUserTablesSqlTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;

  @doc("Mapping from database name to list of tables")
  @visibility("read")
  databasesToTables?: string;

  @doc("Validation errors")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Properties for task that migrates Schema for SQL Server databases to Azure SQL databases")
model MigrateSchemaSqlServerSqlDbTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: MigrateSchemaSqlServerSqlDbTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: MigrateSchemaSqlServerSqlDbTaskOutput[];

  @doc("DateTime in UTC when the task was created")
  createdOn?: string;

  @doc("Task id ")
  taskId?: string;

  @doc("whether the task can be cloned or not")
  isCloneable?: boolean;

  @doc("Task type.")
  taskType: "MigrateSchemaSqlServerSqlDb";
}

@doc("Input for task that migrates Schema for SQL Server databases to Azure SQL databases")
model MigrateSchemaSqlServerSqlDbTaskInput extends SqlMigrationTaskInput {
  @doc("Databases to migrate")
  selectedDatabases: MigrateSchemaSqlServerSqlDbDatabaseInput[];

  @doc("encrypted key for secure fields")
  encryptedKeyForSecureFields?: string;

  @doc("Migration start time")
  startedOn?: string;
}

@doc("Database input for migrate schema Sql Server to Azure SQL Server scenario")
model MigrateSchemaSqlServerSqlDbDatabaseInput {
  @doc("Name of source database")
  name?: string;

  @doc("Id of the source database")
  id?: string;

  @doc("Name of target database")
  targetDatabaseName?: string;

  @doc("Database schema migration settings")
  schemaSetting?: SchemaMigrationSetting;
}

@doc("Settings for migrating schema from source to target")
model SchemaMigrationSetting {
  @doc("Option on how to migrate the schema")
  schemaOption?: SchemaMigrationOption;

  @doc("Resource Identifier of a file resource containing the uploaded schema file")
  fileId?: string;

  @doc("Name of the file resource containing the uploaded schema file")
  fileName?: string;
}

@doc("Base class for migration task input")
model SqlMigrationTaskInput {
  @doc("Information for connecting to source")
  sourceConnectionInfo: SqlConnectionInfo;

  @doc("Information for connecting to target")
  targetConnectionInfo: SqlConnectionInfo;
}

@doc("Output for the task that migrates Schema for SQL Server databases to Azure SQL databases")
@discriminator("resultType")
model MigrateSchemaSqlServerSqlDbTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;
}

model MigrateSchemaSqlServerSqlDbTaskOutputMigrationLevel
  extends MigrateSchemaSqlServerSqlDbTaskOutput {
  @doc("Overall state of the schema migration")
  @visibility("read")
  state?: MigrationState;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Source server version")
  @visibility("read")
  sourceServerVersion?: string;

  @doc("Source server brand version")
  @visibility("read")
  sourceServerBrandVersion?: string;

  @doc("Target server version")
  @visibility("read")
  targetServerVersion?: string;

  @doc("Target server brand version")
  @visibility("read")
  targetServerBrandVersion?: string;

  @doc("Result type")
  resultType: "MigrationLevelOutput";
}

model MigrateSchemaSqlServerSqlDbTaskOutputDatabaseLevel
  extends MigrateSchemaSqlServerSqlDbTaskOutput {
  @doc("The name of the database")
  @visibility("read")
  databaseName?: string;

  @doc("State of the schema migration for this database")
  @visibility("read")
  state?: MigrationState;

  @doc("Schema migration stage for this database")
  @visibility("read")
  stage?: SchemaMigrationStage;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Prefix string to use for querying errors for this database")
  @visibility("read")
  databaseErrorResultPrefix?: string;

  @doc("Prefix string to use for querying schema errors for this database")
  @visibility("read")
  schemaErrorResultPrefix?: string;

  @doc("Number of successful operations for this database")
  @visibility("read")
  numberOfSuccessfulOperations?: int32;

  @doc("Number of failed operations for this database")
  @visibility("read")
  numberOfFailedOperations?: int32;

  @doc("Identifier for the file resource containing the schema of this database")
  @visibility("read")
  fileId?: string;

  @doc("Result type")
  resultType: "DatabaseLevelOutput";
}

model MigrateSchemaSqlServerSqlDbTaskOutputError
  extends MigrateSchemaSqlServerSqlDbTaskOutput {
  @doc("Schema command which failed")
  @visibility("read")
  commandText?: string;

  @doc("Reason of failure")
  @visibility("read")
  errorText?: string;

  @doc("Result type")
  resultType: "SchemaErrorOutput";
}

model MigrateSchemaSqlTaskOutputError
  extends MigrateSchemaSqlServerSqlDbTaskOutput {
  @doc("Migration error")
  @visibility("read")
  error?: ReportableException;

  @doc("Result type")
  resultType: "ErrorOutput";
}

@doc("Input for the task that migrates MySQL databases to Azure Database for MySQL for online migrations")
model MigrateMySqlAzureDbForMySqlSyncTaskInput {
  @doc("Connection information for source MySQL")
  sourceConnectionInfo: MySqlConnectionInfo;

  @doc("Connection information for target Azure Database for MySQL")
  targetConnectionInfo: MySqlConnectionInfo;

  @doc("Databases to migrate")
  selectedDatabases: MigrateMySqlAzureDbForMySqlSyncDatabaseInput[];
}

@doc("Database specific information for MySQL to Azure Database for MySQL migration task inputs")
model MigrateMySqlAzureDbForMySqlSyncDatabaseInput {
  @doc("Name of the database")
  name?: string;

  @doc("Name of target database. Note: Target database will be truncated before starting migration.")
  targetDatabaseName?: string;

  @doc("Migration settings which tune the migration behavior")
  migrationSetting?: Record<string>;

  @doc("Source settings to tune source endpoint migration behavior")
  sourceSetting?: Record<string>;

  @doc("Target settings to tune target endpoint migration behavior")
  targetSetting?: Record<string>;

  @doc("Mapping of source to target tables")
  tableMap?: Record<string>;
}

@doc("Output for the task that migrates MySQL databases to Azure Database for MySQL for online migrations")
@discriminator("resultType")
model MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;
}

model MigrateMySqlAzureDbForMySqlSyncTaskOutputMigrationLevel
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Source server version")
  @visibility("read")
  sourceServerVersion?: string;

  @doc("Source server name")
  @visibility("read")
  sourceServer?: string;

  @doc("Target server version")
  @visibility("read")
  targetServerVersion?: string;

  @doc("Target server name")
  @visibility("read")
  targetServer?: string;

  @doc("Result type")
  resultType: "MigrationLevelOutput";
}

model MigrateMySqlAzureDbForMySqlSyncTaskOutputDatabaseLevel
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  @doc("Name of the database")
  @visibility("read")
  databaseName?: string;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Migration state that this database is in")
  @visibility("read")
  migrationState?: SyncDatabaseMigrationReportingState;

  @doc("Number of incoming changes")
  @visibility("read")
  incomingChanges?: int32;

  @doc("Number of applied changes")
  @visibility("read")
  appliedChanges?: int32;

  @doc("Number of cdc inserts")
  @visibility("read")
  cdcInsertCounter?: int32;

  @doc("Number of cdc deletes")
  @visibility("read")
  cdcDeleteCounter?: int32;

  @doc("Number of cdc updates")
  @visibility("read")
  cdcUpdateCounter?: int32;

  @doc("Number of tables completed in full load")
  @visibility("read")
  fullLoadCompletedTables?: int32;

  @doc("Number of tables loading in full load")
  @visibility("read")
  fullLoadLoadingTables?: int32;

  @doc("Number of tables queued in full load")
  @visibility("read")
  fullLoadQueuedTables?: int32;

  @doc("Number of tables errored in full load")
  @visibility("read")
  fullLoadErroredTables?: int32;

  @doc("Indicates if initial load (full load) has been completed")
  @visibility("read")
  initializationCompleted?: boolean;

  @doc("CDC apply latency")
  @visibility("read")
  latency?: int32;

  @doc("Result type")
  resultType: "DatabaseLevelOutput";
}

model MigrateMySqlAzureDbForMySqlSyncTaskOutputTableLevel
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  @doc("Name of the table")
  @visibility("read")
  tableName?: string;

  @doc("Name of the database")
  @visibility("read")
  databaseName?: string;

  @doc("Number of applied inserts")
  @visibility("read")
  cdcInsertCounter?: string;

  @doc("Number of applied updates")
  @visibility("read")
  cdcUpdateCounter?: string;

  @doc("Number of applied deletes")
  @visibility("read")
  cdcDeleteCounter?: string;

  @doc("Estimate to finish full load")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEstFinishTime?: utcDateTime;

  @doc("Full load start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadStartedOn?: utcDateTime;

  @doc("Full load end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEndedOn?: utcDateTime;

  @doc("Number of rows applied in full load")
  @visibility("read")
  fullLoadTotalRows?: int32;

  @doc("Current state of the table migration")
  @visibility("read")
  state?: SyncTableMigrationState;

  @doc("Total number of applied changes")
  @visibility("read")
  totalChangesApplied?: int32;

  @doc("Number of data errors occurred")
  @visibility("read")
  dataErrorsCounter?: int32;

  @doc("Last modified time on target")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Result type")
  resultType: "TableLevelOutput";
}

model MigrateMySqlAzureDbForMySqlSyncTaskOutputError
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  @doc("Migration error")
  @visibility("read")
  error?: ReportableException;

  @doc("Result type")
  resultType: "ErrorOutput";
}

model MigrateMySqlAzureDbForMySqlSyncTaskOutputDatabaseError
  extends MigrateMySqlAzureDbForMySqlSyncTaskOutput {
  @doc("Error message")
  errorMessage?: string;

  @doc("List of error events.")
  events?: SyncMigrationDatabaseErrorEvent[];

  @doc("Result type")
  resultType: "DatabaseLevelErrorOutput";
}

@doc("Database migration errors for online migration")
model SyncMigrationDatabaseErrorEvent {
  @doc("String value of timestamp.")
  @visibility("read")
  timestampString?: string;

  @doc("Event type.")
  @visibility("read")
  eventTypeString?: string;

  @doc("Event text.")
  @visibility("read")
  eventText?: string;
}

@doc("Input for the task that migrates PostgreSQL databases to Azure Database for PostgreSQL for online migrations")
model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskInput {
  @doc("Databases to migrate")
  selectedDatabases: MigratePostgreSqlAzureDbForPostgreSqlSyncDatabaseInput[];

  @doc("Connection information for target Azure Database for PostgreSQL")
  targetConnectionInfo: PostgreSqlConnectionInfo;

  @doc("Connection information for source PostgreSQL")
  sourceConnectionInfo: PostgreSqlConnectionInfo;

  @doc("encrypted key for secure fields")
  encryptedKeyForSecureFields?: string;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;
}

@doc("Database specific information for PostgreSQL to Azure Database for PostgreSQL migration task inputs")
model MigratePostgreSqlAzureDbForPostgreSqlSyncDatabaseInput {
  @doc("Name of the database")
  name?: string;

  @doc("Result identifier")
  @visibility("read")
  id?: string;

  @doc("Name of target database. Note: Target database will be truncated before starting migration.")
  targetDatabaseName?: string;

  @doc("Migration settings which tune the migration behavior")
  migrationSetting?: Record<unknown>;

  @doc("Source settings to tune source endpoint migration behavior")
  sourceSetting?: Record<string>;

  @doc("Target settings to tune target endpoint migration behavior")
  targetSetting?: Record<string>;

  @doc("Tables selected for migration")
  selectedTables?: MigratePostgreSqlAzureDbForPostgreSqlSyncDatabaseTableInput[];
}

@doc("Selected tables for the migration")
model MigratePostgreSqlAzureDbForPostgreSqlSyncDatabaseTableInput {
  @doc("Name of the table to migrate")
  name?: string;
}

@doc("Output for the task that migrates PostgreSQL databases to Azure Database for PostgreSQL for online migrations")
@discriminator("resultType")
model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;
}

model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputMigrationLevel
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Source server version")
  @visibility("read")
  sourceServerVersion?: string;

  @doc("Source server name")
  @visibility("read")
  sourceServer?: string;

  @doc("Target server version")
  @visibility("read")
  targetServerVersion?: string;

  @doc("Target server name")
  @visibility("read")
  targetServer?: string;

  @doc("Source server type.")
  @visibility("read")
  sourceServerType?: ScenarioSource;

  @doc("Target server type.")
  @visibility("read")
  targetServerType?: ScenarioTarget;

  @doc("Migration status")
  @visibility("read")
  state?: ReplicateMigrationState;

  @doc("Number of databases to include")
  databaseCount?: float32;

  @doc("Result type")
  resultType: "MigrationLevelOutput";
}

model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputDatabaseLevel
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  @doc("Name of the database")
  @visibility("read")
  databaseName?: string;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Migration state that this database is in")
  @visibility("read")
  migrationState?: SyncDatabaseMigrationReportingState;

  @doc("Number of incoming changes")
  @visibility("read")
  incomingChanges?: int32;

  @doc("Number of applied changes")
  @visibility("read")
  appliedChanges?: int32;

  @doc("Number of cdc inserts")
  @visibility("read")
  cdcInsertCounter?: int32;

  @doc("Number of cdc deletes")
  @visibility("read")
  cdcDeleteCounter?: int32;

  @doc("Number of cdc updates")
  @visibility("read")
  cdcUpdateCounter?: int32;

  @doc("Number of tables completed in full load")
  @visibility("read")
  fullLoadCompletedTables?: int32;

  @doc("Number of tables loading in full load")
  @visibility("read")
  fullLoadLoadingTables?: int32;

  @doc("Number of tables queued in full load")
  @visibility("read")
  fullLoadQueuedTables?: int32;

  @doc("Number of tables errored in full load")
  @visibility("read")
  fullLoadErroredTables?: int32;

  @doc("Indicates if initial load (full load) has been completed")
  @visibility("read")
  initializationCompleted?: boolean;

  @doc("CDC apply latency")
  @visibility("read")
  latency?: int32;

  @doc("Result type")
  resultType: "DatabaseLevelOutput";
}

model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputTableLevel
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  @doc("Name of the table")
  @visibility("read")
  tableName?: string;

  @doc("Name of the database")
  @visibility("read")
  databaseName?: string;

  @doc("Number of applied inserts")
  @visibility("read")
  cdcInsertCounter?: int32;

  @doc("Number of applied updates")
  @visibility("read")
  cdcUpdateCounter?: int32;

  @doc("Number of applied deletes")
  @visibility("read")
  cdcDeleteCounter?: int32;

  @doc("Estimate to finish full load")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEstFinishTime?: utcDateTime;

  @doc("Full load start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadStartedOn?: utcDateTime;

  @doc("Full load end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEndedOn?: utcDateTime;

  @doc("Number of rows applied in full load")
  @visibility("read")
  fullLoadTotalRows?: int32;

  @doc("Current state of the table migration")
  @visibility("read")
  state?: SyncTableMigrationState;

  @doc("Total number of applied changes")
  @visibility("read")
  totalChangesApplied?: int32;

  @doc("Number of data errors occurred")
  @visibility("read")
  dataErrorsCounter?: int32;

  @doc("Last modified time on target")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Result type")
  resultType: "TableLevelOutput";
}

model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputError
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  @doc("Migration error")
  @visibility("read")
  error?: ReportableException;

  @doc("List of error events")
  events?: SyncMigrationDatabaseErrorEvent[];

  @doc("Result type")
  resultType: "ErrorOutput";
}

model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutputDatabaseError
  extends MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput {
  @doc("Error message")
  errorMessage?: string;

  @doc("List of error events.")
  events?: SyncMigrationDatabaseErrorEvent[];

  @doc("Result type")
  resultType: "DatabaseLevelErrorOutput";
}

@doc("Input for the task that migrates on-prem SQL Server databases to Azure SQL Database for online migrations")
model MigrateSqlServerSqlDbSyncTaskInput extends SqlMigrationTaskInput {
  @doc("Databases to migrate")
  selectedDatabases: MigrateSqlServerSqlDbSyncDatabaseInput[];

  @doc("Validation options")
  validationOptions?: MigrationValidationOptions;
}

@doc("Database specific information for SQL to Azure SQL DB sync migration task inputs")
model MigrateSqlServerSqlDbSyncDatabaseInput {
  @doc("Unique identifier for database")
  id?: string;

  @doc("Name of database")
  name?: string;

  @doc("Target database name")
  targetDatabaseName?: string;

  @doc("Schema name to be migrated")
  schemaName?: string;

  @doc("Mapping of source to target tables")
  tableMap?: Record<string>;

  @doc("Migration settings which tune the migration behavior")
  migrationSetting?: Record<string>;

  @doc("Source settings to tune source endpoint migration behavior")
  sourceSetting?: Record<string>;

  @doc("Target settings to tune target endpoint migration behavior")
  targetSetting?: Record<string>;
}

@doc("Types of validations to run after the migration")
model MigrationValidationOptions {
  @doc("Allows to compare the schema information between source and target.")
  enableSchemaValidation?: boolean;

  @doc("Allows to perform a checksum based data integrity validation between source and target for the selected database / tables .")
  enableDataIntegrityValidation?: boolean;

  @doc("Allows to perform a quick and intelligent query analysis by retrieving queries from the source database and executes them in the target. The result will have execution statistics for executions in source and target databases for the extracted queries.")
  enableQueryAnalysisValidation?: boolean;
}

@doc("Output for the task that migrates on-prem SQL Server databases to Azure SQL Database for online migrations")
@discriminator("resultType")
model MigrateSqlServerSqlDbSyncTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;
}

model MigrateSqlServerSqlDbSyncTaskOutputMigrationLevel
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Source server version")
  @visibility("read")
  sourceServerVersion?: string;

  @doc("Source server name")
  @visibility("read")
  sourceServer?: string;

  @doc("Target server version")
  @visibility("read")
  targetServerVersion?: string;

  @doc("Target server name")
  @visibility("read")
  targetServer?: string;

  @doc("Count of databases")
  @visibility("read")
  databaseCount?: int32;

  @doc("Result type")
  resultType: "MigrationLevelOutput";
}

model MigrateSqlServerSqlDbSyncTaskOutputDatabaseLevel
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  @doc("Name of the database")
  @visibility("read")
  databaseName?: string;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Migration state that this database is in")
  @visibility("read")
  migrationState?: SyncDatabaseMigrationReportingState;

  @doc("Number of incoming changes")
  @visibility("read")
  incomingChanges?: int32;

  @doc("Number of applied changes")
  @visibility("read")
  appliedChanges?: int32;

  @doc("Number of cdc inserts")
  @visibility("read")
  cdcInsertCounter?: int32;

  @doc("Number of cdc deletes")
  @visibility("read")
  cdcDeleteCounter?: int32;

  @doc("Number of cdc updates")
  @visibility("read")
  cdcUpdateCounter?: int32;

  @doc("Number of tables completed in full load")
  @visibility("read")
  fullLoadCompletedTables?: int32;

  @doc("Number of tables loading in full load")
  @visibility("read")
  fullLoadLoadingTables?: int32;

  @doc("Number of tables queued in full load")
  @visibility("read")
  fullLoadQueuedTables?: int32;

  @doc("Number of tables errored in full load")
  @visibility("read")
  fullLoadErroredTables?: int32;

  @doc("Indicates if initial load (full load) has been completed")
  @visibility("read")
  initializationCompleted?: boolean;

  @doc("CDC apply latency")
  @visibility("read")
  latency?: int32;

  @doc("Result type")
  resultType: "DatabaseLevelOutput";
}

model MigrateSqlServerSqlDbSyncTaskOutputTableLevel
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  @doc("Name of the table")
  @visibility("read")
  tableName?: string;

  @doc("Name of the database")
  @visibility("read")
  databaseName?: string;

  @doc("Number of applied inserts")
  @visibility("read")
  cdcInsertCounter?: int32;

  @doc("Number of applied updates")
  @visibility("read")
  cdcUpdateCounter?: int32;

  @doc("Number of applied deletes")
  @visibility("read")
  cdcDeleteCounter?: int32;

  @doc("Estimate to finish full load")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEstFinishTime?: utcDateTime;

  @doc("Full load start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadStartedOn?: utcDateTime;

  @doc("Full load end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEndedOn?: utcDateTime;

  @doc("Number of rows applied in full load")
  @visibility("read")
  fullLoadTotalRows?: int32;

  @doc("Current state of the table migration")
  @visibility("read")
  state?: SyncTableMigrationState;

  @doc("Total number of applied changes")
  @visibility("read")
  totalChangesApplied?: int32;

  @doc("Number of data errors occurred")
  @visibility("read")
  dataErrorsCounter?: int32;

  @doc("Last modified time on target")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Result type")
  resultType: "TableLevelOutput";
}

model MigrateSqlServerSqlDbSyncTaskOutputError
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  @doc("Migration error")
  @visibility("read")
  error?: ReportableException;

  @doc("Result type")
  resultType: "ErrorOutput";
}

model MigrateSqlServerSqlDbSyncTaskOutputDatabaseError
  extends MigrateSqlServerSqlDbSyncTaskOutput {
  @doc("Error message")
  errorMessage?: string;

  @doc("List of error events.")
  events?: SyncMigrationDatabaseErrorEvent[];

  @doc("Result type")
  resultType: "DatabaseLevelErrorOutput";
}

@doc("Input for the task that migrates on-prem SQL Server databases to Azure SQL Database")
model MigrateSqlServerSqlDbTaskInput extends SqlMigrationTaskInput {
  @doc("Databases to migrate")
  selectedDatabases: MigrateSqlServerSqlDbDatabaseInput[];

  @doc("""
Options for enabling various post migration validations. Available options, 
 1.) Data Integrity Check: Performs a checksum based comparison on source and target tables after the migration to ensure the correctness of the data. 
 2.) Schema Validation: Performs a thorough schema comparison between the source and target tables and provides a list of differences between the source and target database, 3.) Query Analysis: Executes a set of queries picked up automatically either from the Query Plan Cache or Query Store and execute them and compares the execution time between the source and target database.
""")
  validationOptions?: MigrationValidationOptions;

  @doc("Date and time relative to UTC when the migration was started on")
  startedOn?: string;

  @doc("encrypted key for secure fields")
  encryptedKeyForSecureFields?: string;
}

@doc("Database specific information for SQL to Azure SQL DB migration task inputs")
model MigrateSqlServerSqlDbDatabaseInput {
  @doc("Name of the database")
  name?: string;

  @doc("Name of target database. Note: Target database will be truncated before starting migration.")
  targetDatabaseName?: string;

  @doc("Whether to set database read only before migration")
  makeSourceDbReadOnly?: boolean;

  @doc("Mapping of source to target tables")
  tableMap?: Record<string>;

  @doc("Settings selected for DB schema migration.")
  schemaSetting?: Record<unknown>;

  @doc("id of the database")
  id?: string;
}

@doc("Output for the task that migrates on-prem SQL Server databases to Azure SQL Database")
@discriminator("resultType")
model MigrateSqlServerSqlDbTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;
}

model MigrateSqlServerSqlDbTaskOutputMigrationLevel
  extends MigrateSqlServerSqlDbTaskOutput {
  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Duration of task execution in seconds.")
  @visibility("read")
  durationInSeconds?: int32;

  @doc("Current status of migration")
  @visibility("read")
  status?: MigrationStatus;

  @doc("Migration status message")
  @visibility("read")
  statusMessage?: string;

  @doc("Migration progress message")
  @visibility("read")
  message?: string;

  @doc("Selected databases as a map from database name to database id")
  @visibility("read")
  databases?: string;

  @doc("Summary of database results in the migration")
  @visibility("read")
  databaseSummary?: string;

  @doc("Migration Validation Results")
  migrationValidationResult?: MigrationValidationResult;

  @doc("Migration Report Result, provides unique url for downloading your migration report.")
  migrationReportResult?: MigrationReportResult;

  @doc("Source server version")
  @visibility("read")
  sourceServerVersion?: string;

  @doc("Source server brand version")
  @visibility("read")
  sourceServerBrandVersion?: string;

  @doc("Target server version")
  @visibility("read")
  targetServerVersion?: string;

  @doc("Target server brand version")
  @visibility("read")
  targetServerBrandVersion?: string;

  @doc("Migration exceptions and warnings.")
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  @doc("Result type")
  resultType: "MigrationLevelOutput";
}

@doc("Migration Validation Result")
model MigrationValidationResult {
  @doc("Migration validation result identifier")
  @visibility("read")
  id?: string;

  @doc("Migration Identifier")
  @visibility("read")
  migrationId?: string;

  @doc("Validation summary results for each database")
  summaryResults?: Record<MigrationValidationDatabaseSummaryResult>;

  @doc("Current status of validation at the migration level. Status from the database validation result status will be aggregated here.")
  @visibility("read")
  status?: ValidationStatus;
}

@doc("Migration Validation Database level summary result")
model MigrationValidationDatabaseSummaryResult {
  @doc("Result identifier")
  @visibility("read")
  id?: string;

  @doc("Migration Identifier")
  @visibility("read")
  migrationId?: string;

  @doc("Name of the source database")
  @visibility("read")
  sourceDatabaseName?: string;

  @doc("Name of the target database")
  @visibility("read")
  targetDatabaseName?: string;

  @doc("Validation start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Validation end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Current status of validation at the database level")
  @visibility("read")
  status?: ValidationStatus;
}

@doc("Migration validation report result, contains the url for downloading the generated report.")
model MigrationReportResult {
  @doc("Migration validation result identifier")
  id?: string;

  @doc("The url of the report.")
  reportUrl?: string;
}

model MigrateSqlServerSqlDbTaskOutputDatabaseLevel
  extends MigrateSqlServerSqlDbTaskOutput {
  @doc("Name of the item")
  @visibility("read")
  databaseName?: string;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Current state of migration")
  @visibility("read")
  state?: MigrationState;

  @doc("Migration stage that this database is in")
  @visibility("read")
  stage?: DatabaseMigrationStage;

  @doc("Status message")
  @visibility("read")
  statusMessage?: string;

  @doc("Migration progress message")
  @visibility("read")
  message?: string;

  @doc("Number of objects")
  @visibility("read")
  numberOfObjects?: int32;

  @doc("Number of successfully completed objects")
  @visibility("read")
  numberOfObjectsCompleted?: int32;

  @doc("Number of database/object errors.")
  @visibility("read")
  errorCount?: int32;

  @doc("Wildcard string prefix to use for querying all errors of the item")
  @visibility("read")
  errorPrefix?: string;

  @doc("Wildcard string prefix to use for querying all sub-tem results of the item")
  @visibility("read")
  resultPrefix?: string;

  @doc("Migration exceptions and warnings.")
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  @doc("Summary of object results in the migration")
  @visibility("read")
  objectSummary?: string;

  @doc("Result type")
  resultType: "DatabaseLevelOutput";
}

model MigrateSqlServerSqlDbTaskOutputTableLevel
  extends MigrateSqlServerSqlDbTaskOutput {
  @doc("Name of the item")
  @visibility("read")
  objectName?: string;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Current state of migration")
  @visibility("read")
  state?: MigrationState;

  @doc("Status message")
  @visibility("read")
  statusMessage?: string;

  @doc("Number of items")
  @visibility("read")
  itemsCount?: int32;

  @doc("Number of successfully completed items")
  @visibility("read")
  itemsCompletedCount?: int32;

  @doc("Wildcard string prefix to use for querying all errors of the item")
  @visibility("read")
  errorPrefix?: string;

  @doc("Wildcard string prefix to use for querying all sub-tem results of the item")
  @visibility("read")
  resultPrefix?: string;

  @doc("Result type")
  resultType: "TableLevelOutput";
}

model MigrateSqlServerSqlDbTaskOutputError
  extends MigrateSqlServerSqlDbTaskOutput {
  @doc("Migration error")
  @visibility("read")
  error?: ReportableException;

  @doc("Result type")
  resultType: "ErrorOutput";
}

@doc("Summary of database results in the migration")
model DatabaseSummaryResult extends DataItemMigrationSummaryResult {
  @doc("Size of the database in megabytes")
  @visibility("read")
  sizeMB?: float32;
}

@doc("Basic summary of a data item migration")
model DataItemMigrationSummaryResult {
  @doc("Name of the item")
  @visibility("read")
  name?: string;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Current state of migration")
  @visibility("read")
  state?: MigrationState;

  @doc("Status message")
  @visibility("read")
  statusMessage?: string;

  @doc("Number of items")
  @visibility("read")
  itemsCount?: int32;

  @doc("Number of successfully completed items")
  @visibility("read")
  itemsCompletedCount?: int32;

  @doc("Wildcard string prefix to use for querying all errors of the item")
  @visibility("read")
  errorPrefix?: string;

  @doc("Wildcard string prefix to use for querying all sub-tem results of the item")
  @visibility("read")
  resultPrefix?: string;
}

model MigrateSqlServerSqlDbTaskOutputValidationResult
  extends MigrateSqlServerSqlDbTaskOutput {
  ...MigrationValidationResult;

  @doc("Result type")
  resultType: "MigrationValidationOutput";
}

model MigrateSqlServerSqlDbTaskOutputDatabaseLevelValidationResult
  extends MigrateSqlServerSqlDbTaskOutput {
  ...MigrationValidationDatabaseLevelResult;

  @doc("Result type")
  resultType: "MigrationDatabaseLevelValidationOutput";
}

@doc("Database level validation results")
model MigrationValidationDatabaseLevelResult {
  @doc("Result identifier")
  @visibility("read")
  id?: string;

  @doc("Migration Identifier")
  @visibility("read")
  migrationId?: string;

  @doc("Name of the source database")
  @visibility("read")
  sourceDatabaseName?: string;

  @doc("Name of the target database")
  @visibility("read")
  targetDatabaseName?: string;

  @doc("Validation start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Validation end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Provides data integrity validation result between the source and target tables that are migrated.")
  @visibility("read")
  dataIntegrityValidationResult?: DataIntegrityValidationResult;

  @doc("Provides schema comparison result between source and target database")
  @visibility("read")
  schemaValidationResult?: SchemaComparisonValidationResult;

  @doc("Results of some of the query execution result between source and target database")
  @visibility("read")
  queryAnalysisValidationResult?: QueryAnalysisValidationResult;

  @doc("Current status of validation at the database level")
  @visibility("read")
  status?: ValidationStatus;
}

@doc("Results for checksum based Data Integrity validation results")
model DataIntegrityValidationResult {
  @doc("List of failed table names of source and target pair")
  failedObjects?: Record<string>;

  @doc("List of errors that happened while performing data integrity validation")
  validationErrors?: ValidationError;
}

@doc("Description about the errors happen while performing migration validation")
model ValidationError {
  @doc("Error Text")
  text?: string;

  @doc("Severity of the error")
  severity?: Severity;
}

@doc("Results for schema comparison between the source and target")
model SchemaComparisonValidationResult {
  @doc("List of schema differences between the source and target databases")
  schemaDifferences?: SchemaComparisonValidationResultType;

  @doc("List of errors that happened while performing schema compare validation")
  validationErrors?: ValidationError;

  @doc("Count of source database objects")
  sourceDatabaseObjectCount?: Record<int32>;

  @doc("Count of target database objects")
  targetDatabaseObjectCount?: Record<int32>;
}

@doc("Description about the errors happen while performing migration validation")
model SchemaComparisonValidationResultType {
  @doc("Name of the object that has the difference")
  objectName?: string;

  @doc("Type of the object that has the difference. e.g (Table/View/StoredProcedure)")
  objectType?: ObjectType;

  @doc("Update action type with respect to target")
  updateAction?: UpdateActionType;
}

@doc("Results for query analysis comparison between the source and target")
model QueryAnalysisValidationResult {
  @doc("List of queries executed and it's execution results in source and target")
  queryResults?: QueryExecutionResult;

  @doc("Errors that are part of the execution")
  validationErrors?: ValidationError;
}

@doc("Describes query analysis results for execution in source and target")
model QueryExecutionResult {
  @doc("Query text retrieved from the source server")
  queryText?: string;

  @doc("Total no. of statements in the batch")
  statementsInBatch?: int32;

  @doc("Query analysis result from the source")
  sourceResult?: ExecutionStatistics;

  @doc("Query analysis result from the target")
  targetResult?: ExecutionStatistics;
}

@doc("Description about the errors happen while performing migration validation")
model ExecutionStatistics {
  @doc("No. of query executions")
  executionCount?: int32;

  @doc("CPU Time in millisecond(s) for the query execution")
  cpuTimeMs?: float32;

  @doc("Time taken in millisecond(s) for executing the query")
  elapsedTimeMs?: float32;

  @doc("Dictionary of sql query execution wait types and the respective statistics")
  waitStats?: Record<WaitStatistics>;

  @doc("Indicates whether the query resulted in an error")
  hasErrors?: boolean;

  @doc("List of sql Errors")
  sqlErrors?: string[];
}

@doc("Wait statistics gathered during query batch execution")
model WaitStatistics {
  @doc("Type of the Wait")
  waitType?: string;

  @doc("Total wait time in millisecond(s) ")
  waitTimeMs?: float32;

  @doc("Total no. of waits")
  waitCount?: int32;
}

@doc("Input for task that migrates SQL Server databases to Azure SQL Database Managed Instance online scenario.")
model MigrateSqlServerSqlMISyncTaskInput extends SqlServerSqlMISyncTaskInput {
  @doc("Number of database migrations to start in parallel")
  numberOfParallelDatabaseMigrations?: float32;
}

@doc("Input for task that migrates SQL Server databases to Azure SQL Database Managed Instance online scenario.")
model SqlServerSqlMISyncTaskInput {
  @doc("Databases to migrate")
  selectedDatabases: MigrateSqlServerSqlMIDatabaseInput[];

  @doc("Backup file share information for all selected databases.")
  backupFileShare?: FileShare;

  @doc("Fully qualified resourceId of storage")
  storageResourceId: string;

  @doc("Connection information for source SQL Server")
  sourceConnectionInfo: SqlConnectionInfo;

  @doc("Connection information for Azure SQL Database Managed Instance")
  targetConnectionInfo: MiSqlConnectionInfo;

  @doc("Azure Active Directory Application the DMS instance will use to connect to the target instance of Azure SQL Database Managed Instance and the Azure Storage Account")
  azureApp: AzureActiveDirectoryApp;
}

@doc("Database specific information for SQL to Azure SQL DB Managed Instance migration task inputs")
model MigrateSqlServerSqlMIDatabaseInput {
  @doc("Name of the database")
  name: string;

  @doc("Name of the database at destination")
  restoreDatabaseName: string;

  @doc("Backup file share information for backing up this database.")
  backupFileShare?: FileShare;

  @doc("The list of backup files to be used in case of existing backups.")
  backupFilePaths?: string[];

  @doc("id of the database")
  id?: string;
}

@doc("Output for task that migrates SQL Server databases to Azure SQL Database Managed Instance using Log Replay Service.")
@discriminator("resultType")
model MigrateSqlServerSqlMISyncTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;
}

model MigrateSqlServerSqlMISyncTaskOutputMigrationLevel
  extends MigrateSqlServerSqlMISyncTaskOutput {
  @doc("Count of databases")
  @visibility("read")
  databaseCount?: int32;

  @doc("Current state of migration")
  @visibility("read")
  state?: MigrationState;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Source server name")
  @visibility("read")
  sourceServerName?: string;

  @doc("Source server version")
  @visibility("read")
  sourceServerVersion?: string;

  @doc("Source server brand version")
  @visibility("read")
  sourceServerBrandVersion?: string;

  @doc("Target server name")
  @visibility("read")
  targetServerName?: string;

  @doc("Target server version")
  @visibility("read")
  targetServerVersion?: string;

  @doc("Target server brand version")
  @visibility("read")
  targetServerBrandVersion?: string;

  @doc("Number of database level errors")
  @visibility("read")
  databaseErrorCount?: int32;

  @doc("Result type")
  resultType: "MigrationLevelOutput";
}

model MigrateSqlServerSqlMISyncTaskOutputDatabaseLevel
  extends MigrateSqlServerSqlMISyncTaskOutput {
  @doc("Name of the database")
  @visibility("read")
  sourceDatabaseName?: string;

  @doc("Current state of database")
  @visibility("read")
  migrationState?: DatabaseMigrationState;

  @doc("Database migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Database migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Details of full backup set")
  @visibility("read")
  fullBackupSetInfo?: BackupSetInfo;

  @doc("Last applied backup set information")
  @visibility("read")
  lastRestoredBackupSetInfo?: BackupSetInfo;

  @doc("Backup sets that are currently active (Either being uploaded or getting restored)")
  @visibility("read")
  activeBackupSets?: BackupSetInfo[];

  @doc("Name of container created in the Azure Storage account where backups are copied to")
  @visibility("read")
  containerName?: string;

  @doc("prefix string to use for querying errors for this database")
  @visibility("read")
  errorPrefix?: string;

  @doc("Whether full backup has been applied to the target database or not")
  @visibility("read")
  isFullBackupRestored?: boolean;

  @doc("Migration exceptions and warnings")
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  @doc("Result type")
  resultType: "DatabaseLevelOutput";
}

model MigrateSqlServerSqlMISyncTaskOutputError
  extends MigrateSqlServerSqlMISyncTaskOutput {
  @doc("Migration error")
  @visibility("read")
  error?: ReportableException;

  @doc("Result type")
  resultType: "ErrorOutput";
}

@doc("Input for task that migrates SQL Server databases to Azure SQL Database Managed Instance.")
model MigrateSqlServerSqlMITaskInput extends SqlMigrationTaskInput {
  @doc("Databases to migrate")
  selectedDatabases: MigrateSqlServerSqlMIDatabaseInput[];

  @doc("Date and time relative to UTC when the migration was started on")
  startedOn?: string;

  @doc("Logins to migrate.")
  selectedLogins?: string[];

  @doc("Agent Jobs to migrate.")
  selectedAgentJobs?: string[];

  @doc("Backup file share information for all selected databases.")
  backupFileShare?: FileShare;

  @doc("SAS URI of Azure Storage Account Container to be used for storing backup files.")
  backupBlobShare: BlobShare;

  @doc("Backup Mode to specify whether to use existing backup or create new backup. If using existing backups, backup file paths are required to be provided in selectedDatabases.")
  backupMode?: BackupMode;

  @doc("Azure Active Directory domain name in the format of 'contoso.com' for federated Azure AD or 'contoso.onmicrosoft.com' for managed domain, required if and only if Windows logins are selected")
  aadDomainName?: string;

  @doc("encrypted key for secure fields")
  encryptedKeyForSecureFields?: string;
}

@doc("Blob container storage information.")
model BlobShare {
  @doc("SAS URI of Azure Storage Account Container.")
  sasUri?: string;
}

@doc("Output for task that migrates SQL Server databases to Azure SQL Database Managed Instance.")
@discriminator("resultType")
model MigrateSqlServerSqlMITaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;
}

model MigrateSqlServerSqlMITaskOutputMigrationLevel
  extends MigrateSqlServerSqlMITaskOutput {
  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Current status of migration")
  @visibility("read")
  status?: MigrationStatus;

  @doc("Current state of migration")
  @visibility("read")
  state?: MigrationState;

  @doc("Selected agent jobs as a map from name to id")
  @visibility("read")
  agentJobs?: string;

  @doc("Selected logins as a map from name to id")
  @visibility("read")
  logins?: string;

  @doc("Migration progress message")
  @visibility("read")
  message?: string;

  @doc("Map of server role migration results.")
  @visibility("read")
  serverRoleResults?: string;

  @doc("List of orphaned users.")
  @visibility("read")
  orphanedUsersInfo?: OrphanedUserInfo[];

  @doc("Selected databases as a map from database name to database id")
  @visibility("read")
  databases?: string;

  @doc("Source server version")
  @visibility("read")
  sourceServerVersion?: string;

  @doc("Source server brand version")
  @visibility("read")
  sourceServerBrandVersion?: string;

  @doc("Target server version")
  @visibility("read")
  targetServerVersion?: string;

  @doc("Target server brand version")
  @visibility("read")
  targetServerBrandVersion?: string;

  @doc("Migration exceptions and warnings.")
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  @doc("Result type")
  resultType: "MigrationLevelOutput";
}

model MigrateSqlServerSqlMITaskOutputDatabaseLevel
  extends MigrateSqlServerSqlMITaskOutput {
  @doc("Name of the database")
  @visibility("read")
  databaseName?: string;

  @doc("Size of the database in megabytes")
  @visibility("read")
  sizeMB?: float32;

  @doc("Current state of migration")
  @visibility("read")
  state?: MigrationState;

  @doc("Current stage of migration")
  @visibility("read")
  stage?: DatabaseMigrationStage;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Migration progress message")
  @visibility("read")
  message?: string;

  @doc("Migration exceptions and warnings")
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  @doc("Result type")
  resultType: "DatabaseLevelOutput";
}

model MigrateSqlServerSqlMITaskOutputAgentJobLevel
  extends MigrateSqlServerSqlMITaskOutput {
  @doc("Agent Job name.")
  @visibility("read")
  name?: string;

  @doc("The state of the original Agent Job.")
  @visibility("read")
  isEnabled?: boolean;

  @doc("Current state of migration")
  @visibility("read")
  state?: MigrationState;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Migration progress message")
  @visibility("read")
  message?: string;

  @doc("Migration errors and warnings per job")
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  @doc("Result type")
  resultType: "AgentJobLevelOutput";
}

model MigrateSqlServerSqlMITaskOutputLoginLevel
  extends MigrateSqlServerSqlMITaskOutput {
  @doc("Login name.")
  @visibility("read")
  loginName?: string;

  @doc("Current state of login")
  @visibility("read")
  state?: MigrationState;

  @doc("Current stage of login")
  @visibility("read")
  stage?: LoginMigrationStage;

  @doc("Login migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Login migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Login migration progress message")
  @visibility("read")
  message?: string;

  @doc("Login migration errors and warnings per login")
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  @doc("Result type")
  resultType: "LoginLevelOutput";
}

model MigrateSqlServerSqlMITaskOutputError
  extends MigrateSqlServerSqlMITaskOutput {
  @doc("Migration error")
  @visibility("read")
  error?: ReportableException;

  @doc("Result type")
  resultType: "ErrorOutput";
}

@doc("Input for task that migrates SSIS packages from SQL Server to Azure SQL Database Managed Instance.")
model MigrateSsisTaskInput extends SqlMigrationTaskInput {
  @doc("SSIS package migration information.")
  ssisMigrationInfo: SsisMigrationInfo;
}

@doc("SSIS migration info with SSIS store type, overwrite policy.")
model SsisMigrationInfo {
  @doc("The SSIS store type of source, only SSIS catalog is supported now in DMS")
  ssisStoreType?: SsisStoreType;

  @doc("The overwrite option for the SSIS project migration")
  projectOverwriteOption?: SsisMigrationOverwriteOption;

  @doc("The overwrite option for the SSIS environment migration")
  environmentOverwriteOption?: SsisMigrationOverwriteOption;
}

@doc("Output for task that migrates SSIS packages from SQL Server to Azure SQL Database Managed Instance.")
@discriminator("resultType")
model MigrateSsisTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;
}

model MigrateSsisTaskOutputMigrationLevel extends MigrateSsisTaskOutput {
  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Current status of migration")
  @visibility("read")
  status?: MigrationStatus;

  @doc("Migration progress message")
  @visibility("read")
  message?: string;

  @doc("Source server version")
  @visibility("read")
  sourceServerVersion?: string;

  @doc("Source server brand version")
  @visibility("read")
  sourceServerBrandVersion?: string;

  @doc("Target server version")
  @visibility("read")
  targetServerVersion?: string;

  @doc("Target server brand version")
  @visibility("read")
  targetServerBrandVersion?: string;

  @doc("Migration exceptions and warnings.")
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  @doc("Stage of SSIS migration.")
  @visibility("read")
  stage?: SsisMigrationStage;

  @doc("Result type")
  resultType: "MigrationLevelOutput";
}

model MigrateSsisTaskOutputProjectLevel extends MigrateSsisTaskOutput {
  @doc("Name of the folder")
  @visibility("read")
  folderName?: string;

  @doc("Name of the project")
  @visibility("read")
  projectName?: string;

  @doc("Current state of migration")
  @visibility("read")
  state?: MigrationState;

  @doc("Stage of SSIS migration.")
  @visibility("read")
  stage?: SsisMigrationStage;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Migration progress message")
  @visibility("read")
  message?: string;

  @doc("Migration exceptions and warnings")
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  @doc("Result type")
  resultType: "SsisProjectLevelOutput";
}

@doc("Properties for the command that cancels a migration in whole or in part")
model MongoDbCancelCommand extends CommandProperties {
  @doc("Command input")
  input?: MongoDbCommandInput;

  @doc("Command type.")
  commandType: "cancel";
}

@doc("Describes the input to the 'cancel' and 'restart' MongoDB migration commands")
model MongoDbCommandInput {
  @doc("The qualified name of a database or collection to act upon, or null to act upon the entire migration")
  objectName?: string;
}

@doc("Describes a MongoDB data source")
model MongoDbClusterInfo {
  @doc("A list of non-system databases in the cluster")
  databases: MongoDbDatabaseInfo[];

  @doc("Whether the cluster supports sharded collections")
  supportsSharding: boolean;

  @doc("The type of data source")
  type: MongoDbClusterType;

  @doc("The version of the data source in the form x.y.z (e.g. 3.6.7). Not used if Type is BlobContainer.")
  version: string;
}

@doc("Describes a database within a MongoDB data source")
model MongoDbDatabaseInfo extends MongoDbObjectInfo {
  @doc("A list of supported collections in a MongoDB database")
  collections: MongoDbCollectionInfo[];

  @doc("Whether the database has sharding enabled. Note that the migration task will enable sharding on the target if necessary.")
  supportsSharding: boolean;
}

@doc("Describes a supported collection within a MongoDB database")
model MongoDbCollectionInfo extends MongoDbObjectInfo {
  @doc("The name of the database containing the collection")
  databaseName: string;

  @doc("Whether the collection is a capped collection (i.e. whether it has a fixed size and acts like a circular buffer)")
  isCapped: boolean;

  @doc("Whether the collection is system collection")
  isSystemCollection: boolean;

  @doc("Whether the collection is a view of another collection")
  isView: boolean;

  @doc("The shard key on the collection, or null if the collection is not sharded")
  shardKey?: MongoDbShardKeyInfo;

  @doc("Whether the database has sharding enabled. Note that the migration task will enable sharding on the target if necessary.")
  supportsSharding: boolean;

  @doc("The name of the collection that this is a view of, if IsView is true")
  viewOf?: string;
}

@doc("Describes a MongoDB shard key")
model MongoDbShardKeyInfo {
  @doc("The fields within the shard key")
  fields: MongoDbShardKeyField[];

  @doc("Whether the shard key is unique")
  isUnique: boolean;
}

@doc("Describes a field reference within a MongoDB shard key")
model MongoDbShardKeyField {
  @doc("The name of the field")
  name: string;

  @doc("The field ordering")
  order: MongoDbShardKeyOrder;
}

@doc("Describes a database or collection within a MongoDB data source")
model MongoDbObjectInfo {
  @doc("The average document size, or -1 if the average size is unknown")
  averageDocumentSize: int32;

  @doc("The estimated total data size, in bytes, or -1 if the size is unknown.")
  dataSize: int32;

  @doc("The estimated total number of documents, or -1 if the document count is unknown")
  documentCount: int32;

  @doc("The unqualified name of the database or collection")
  name: string;

  @doc("The qualified name of the database or collection. For a collection, this is the database-qualified name.")
  qualifiedName: string;
}

@doc("Describes the progress of a collection")
model MongoDbCollectionProgress extends MongoDbProgress {
  @doc("The type of progress object")
  resultType: "Collection";
}

@doc("Base class for MongoDB migration outputs")
@discriminator("resultType")
model MongoDbProgress {
  @doc("The number of document bytes copied during the Copying stage")
  bytesCopied: int32;

  @doc("The number of documents copied during the Copying stage")
  documentsCopied: int32;

  @doc("The elapsed time in the format [ddd.]hh:mm:ss[.fffffff] (i.e. TimeSpan format)")
  elapsedTime: string;

  @doc("The errors and warnings that have occurred for the current object. The keys are the error codes.")
  errors: Record<MongoDbError>;

  @doc("The number of oplog events awaiting replay")
  eventsPending: int32;

  @doc("The number of oplog events replayed so far")
  eventsReplayed: int32;

  @doc("The timestamp of the last oplog event received, or null if no oplog event has been received yet")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastEventTime?: utcDateTime;

  @doc("The timestamp of the last oplog event replayed, or null if no oplog event has been replayed yet")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastReplayTime?: utcDateTime;

  @doc("The name of the progress object. For a collection, this is the unqualified collection name. For a database, this is the database name. For the overall migration, this is null.")
  name?: string;

  @doc("The qualified name of the progress object. For a collection, this is the database-qualified name. For a database, this is the database name. For the overall migration, this is null.")
  qualifiedName?: string;

  state: MongoDbMigrationState;

  @doc("The total number of document bytes on the source at the beginning of the Copying stage, or -1 if the total size was unknown")
  totalBytes: int32;

  @doc("The total number of documents on the source at the beginning of the Copying stage, or -1 if the total count was unknown")
  totalDocuments: int32;
}

@doc("Describes an error or warning that occurred during a MongoDB migration")
model MongoDbError {
  @doc("The non-localized, machine-readable code that describes the error or warning")
  code?: string;

  @doc("The number of times the error or warning has occurred")
  count?: int32;

  @doc("The localized, human-readable message that describes the error or warning")
  message?: string;

  @doc("The type of error or warning")
  type?: MongoDbErrorType;
}

@doc("Describes how an individual MongoDB collection should be migrated")
model MongoDbCollectionSettings {
  @doc("Whether the migrator is allowed to drop the target collection in the course of performing a migration. The default is true.")
  canDelete?: boolean;

  @doc("Describes a MongoDB shard key")
  shardKey?: MongoDbShardKeySetting;

  @doc("The RUs that should be configured on a CosmosDB target, or null to use the default. This has no effect on non-CosmosDB targets.")
  targetRUs?: int32;
}

@doc("Describes a MongoDB shard key")
model MongoDbShardKeySetting {
  @doc("The fields within the shard key")
  fields: MongoDbShardKeyField[];

  @doc("Whether the shard key is unique")
  isUnique?: boolean;
}

@doc("Describes the progress of a database")
model MongoDbDatabaseProgress extends MongoDbProgress {
  @doc("The progress of the collections in the database. The keys are the unqualified names of the collections")
  collections?: Record<MongoDbCollectionProgress>;

  @doc("The type of progress object")
  resultType: "Database";
}

@doc("Describes how an individual MongoDB database should be migrated")
model MongoDbDatabaseSettings {
  @doc("The collections on the source database to migrate to the target. The keys are the unqualified names of the collections.")
  collections: Record<MongoDbCollectionSettings>;

  @doc("The RUs that should be configured on a CosmosDB target, or null to use the default, or 0 if throughput should not be provisioned for the database. This has no effect on non-CosmosDB targets.")
  targetRUs?: int32;
}

@doc("Properties for the command that finishes a migration in whole or in part")
model MongoDbFinishCommand extends CommandProperties {
  @doc("Command input")
  input?: MongoDbFinishCommandInput;

  @doc("Command type.")
  commandType: "finish";
}

@doc("Describes the input to the 'finish' MongoDB migration command")
model MongoDbFinishCommandInput extends MongoDbCommandInput {
  @doc("If true, replication for the affected objects will be stopped immediately. If false, the migrator will finish replaying queued events before finishing the replication.")
  immediate: boolean;
}

@doc("Describes how a MongoDB data migration should be performed")
model MongoDbMigrationSettings {
  @doc("The RU limit on a CosmosDB target that collections will be temporarily increased to (if lower) during the initial copy of a migration, from 10,000 to 1,000,000, or 0 to use the default boost (which is generally the maximum), or null to not boost the RUs. This setting has no effect on non-CosmosDB targets.")
  boostRUs?: int32;

  @doc("The databases on the source cluster to migrate to the target. The keys are the names of the databases.")
  databases: Record<MongoDbDatabaseSettings>;

  @doc("Describes how changes will be replicated from the source to the target. The default is OneTime.")
  replication?: MongoDbReplication;

  @doc("Settings used to connect to the source cluster")
  source: MongoDbConnectionInfo;

  @doc("Settings used to connect to the target cluster")
  target: MongoDbConnectionInfo;

  @doc("Settings used to limit the resource usage of the migration")
  throttling?: MongoDbThrottlingSettings;
}

@doc("Specifies resource limits for the migration")
model MongoDbThrottlingSettings {
  @doc("The percentage of CPU time that the migrator will try to avoid using, from 0 to 100")
  minFreeCpu?: int32;

  @doc("The number of megabytes of RAM that the migrator will try to avoid using")
  minFreeMemoryMb?: int32;

  @doc("The maximum number of work items (e.g. collection copies) that will be processed in parallel")
  maxParallelism?: int32;
}

@doc("Describes the progress of the overall migration")
model MongoDbMigrationProgress extends MongoDbProgress {
  @doc("The progress of the databases in the migration. The keys are the names of the databases")
  databases?: Record<MongoDbDatabaseProgress>;

  @doc("The type of progress object")
  resultType: "Migration";
}

@doc("Properties for the command that restarts a migration in whole or in part")
model MongoDbRestartCommand extends CommandProperties {
  @doc("Command input")
  input?: MongoDbCommandInput;

  @doc("Command type.")
  commandType: "restart";
}

@doc("Input for the task that validates Oracle database connection")
model ConnectToSourceOracleSyncTaskInput {
  @doc("Information for connecting to Oracle source")
  sourceConnectionInfo: OracleConnectionInfo;
}

@doc("Output for the task that validates Oracle database connection")
model ConnectToSourceOracleSyncTaskOutput {
  @doc("Version of the source server")
  @visibility("read")
  sourceServerVersion?: string;

  @doc("List of schemas on source server")
  @visibility("read")
  databases?: string[];

  @doc("Source server brand version")
  @visibility("read")
  sourceServerBrandVersion?: string;

  @doc("Validation errors associated with the task")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Input for the task that validates connection to Azure Database for PostgreSQL and target server requirements for Oracle source.")
model ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskInput {
  @doc("Connection information for target Azure Database for PostgreSQL server")
  targetConnectionInfo: PostgreSqlConnectionInfo;
}

@doc("Output for the task that validates connection to Azure Database for PostgreSQL and target server requirements for Oracle source.")
model ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskOutput {
  @doc("Version of the target server")
  @visibility("read")
  targetServerVersion?: string;

  @doc("List of databases on target server")
  @visibility("read")
  databases?: string[];

  @doc("Target server brand version")
  @visibility("read")
  targetServerBrandVersion?: string;

  @doc("Validation errors associated with the task")
  @visibility("read")
  validationErrors?: ReportableException[];

  @doc("Mapping of schemas per database")
  databaseSchemaMap?: ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskOutputDatabaseSchemaMapItem[];
}

model ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskOutputDatabaseSchemaMapItem {
  database?: string;
  schemas?: string[];
}

@doc("Input for the task that gets the list of tables contained within a provided list of Oracle schemas.")
model GetUserTablesOracleTaskInput {
  @doc("Information for connecting to Oracle source")
  connectionInfo: OracleConnectionInfo;

  @doc("List of Oracle schemas for which to collect tables")
  selectedSchemas: string[];
}

@doc("Output for the task that gets the list of tables contained within a provided list of Oracle schemas.")
model GetUserTablesOracleTaskOutput {
  @doc("The schema this result is for")
  @visibility("read")
  schemaName?: string;

  @doc("List of valid tables found for this schema")
  @visibility("read")
  tables?: DatabaseTable[];

  @doc("Validation errors associated with the task")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Input for the task that gets the list of tables for a provided list of PostgreSQL databases.")
model GetUserTablesPostgreSqlTaskInput {
  @doc("Information for connecting to PostgreSQL source")
  connectionInfo: PostgreSqlConnectionInfo;

  @doc("List of PostgreSQL databases for which to collect tables")
  selectedDatabases: string[];
}

@doc("Output for the task that gets the list of tables for a provided list of PostgreSQL databases.")
model GetUserTablesPostgreSqlTaskOutput {
  @doc("The database this result is for")
  @visibility("read")
  databaseName?: string;

  @doc("List of valid tables found for this database")
  @visibility("read")
  tables?: DatabaseTable[];

  @doc("Validation errors associated with the task")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Output for task that validates migration input for Oracle to Azure Database for PostgreSQL for online migrations")
model ValidateOracleAzureDbPostgreSqlSyncTaskOutput {
  @doc("Errors associated with a selected database object")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Input for the task that migrates Oracle databases to Azure Database for PostgreSQL for online migrations")
model MigrateOracleAzureDbPostgreSqlSyncTaskInput {
  @doc("Databases to migrate")
  selectedDatabases: MigrateOracleAzureDbPostgreSqlSyncDatabaseInput[];

  @doc("Connection information for target Azure Database for PostgreSQL")
  targetConnectionInfo: PostgreSqlConnectionInfo;

  @doc("Connection information for source Oracle")
  sourceConnectionInfo: OracleConnectionInfo;
}

@doc("Database specific information for Oracle to Azure Database for PostgreSQL migration task inputs")
model MigrateOracleAzureDbPostgreSqlSyncDatabaseInput {
  @doc("How to handle object name casing: either Preserve or ToLower")
  caseManipulation?: string;

  @doc("Name of the migration pipeline")
  name?: string;

  @doc("Name of the source schema")
  schemaName?: string;

  @doc("Mapping of source to target tables")
  tableMap?: Record<string>;

  @doc("Name of target database. Note: Target database will be truncated before starting migration.")
  targetDatabaseName?: string;

  @doc("Migration settings which tune the migration behavior")
  migrationSetting?: Record<string>;

  @doc("Source settings to tune source endpoint migration behavior")
  sourceSetting?: Record<string>;

  @doc("Target settings to tune target endpoint migration behavior")
  targetSetting?: Record<string>;
}

@doc("Output for the task that migrates Oracle databases to Azure Database for PostgreSQL for online migrations")
@discriminator("resultType")
model MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;
}

model MigrateOracleAzureDbPostgreSqlSyncTaskOutputMigrationLevel
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Source server version")
  @visibility("read")
  sourceServerVersion?: string;

  @doc("Source server name")
  @visibility("read")
  sourceServer?: string;

  @doc("Target server version")
  @visibility("read")
  targetServerVersion?: string;

  @doc("Target server name")
  @visibility("read")
  targetServer?: string;

  @doc("Result type")
  resultType: "MigrationLevelOutput";
}

model MigrateOracleAzureDbPostgreSqlSyncTaskOutputDatabaseLevel
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  @doc("Name of the database")
  @visibility("read")
  databaseName?: string;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Migration state that this database is in")
  @visibility("read")
  migrationState?: SyncDatabaseMigrationReportingState;

  @doc("Number of incoming changes")
  @visibility("read")
  incomingChanges?: int32;

  @doc("Number of applied changes")
  @visibility("read")
  appliedChanges?: int32;

  @doc("Number of cdc inserts")
  @visibility("read")
  cdcInsertCounter?: int32;

  @doc("Number of cdc deletes")
  @visibility("read")
  cdcDeleteCounter?: int32;

  @doc("Number of cdc updates")
  @visibility("read")
  cdcUpdateCounter?: int32;

  @doc("Number of tables completed in full load")
  @visibility("read")
  fullLoadCompletedTables?: int32;

  @doc("Number of tables loading in full load")
  @visibility("read")
  fullLoadLoadingTables?: int32;

  @doc("Number of tables queued in full load")
  @visibility("read")
  fullLoadQueuedTables?: int32;

  @doc("Number of tables errored in full load")
  @visibility("read")
  fullLoadErroredTables?: int32;

  @doc("Indicates if initial load (full load) has been completed")
  @visibility("read")
  initializationCompleted?: boolean;

  @doc("CDC apply latency")
  @visibility("read")
  latency?: int32;

  @doc("Result type")
  resultType: "DatabaseLevelOutput";
}

model MigrateOracleAzureDbPostgreSqlSyncTaskOutputTableLevel
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  @doc("Name of the table")
  @visibility("read")
  tableName?: string;

  @doc("Name of the database")
  @visibility("read")
  databaseName?: string;

  @doc("Number of applied inserts")
  @visibility("read")
  cdcInsertCounter?: int32;

  @doc("Number of applied updates")
  @visibility("read")
  cdcUpdateCounter?: int32;

  @doc("Number of applied deletes")
  @visibility("read")
  cdcDeleteCounter?: int32;

  @doc("Estimate to finish full load")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEstFinishTime?: utcDateTime;

  @doc("Full load start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadStartedOn?: utcDateTime;

  @doc("Full load end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fullLoadEndedOn?: utcDateTime;

  @doc("Number of rows applied in full load")
  @visibility("read")
  fullLoadTotalRows?: int32;

  @doc("Current state of the table migration")
  @visibility("read")
  state?: SyncTableMigrationState;

  @doc("Total number of applied changes")
  @visibility("read")
  totalChangesApplied?: int32;

  @doc("Number of data errors occurred")
  @visibility("read")
  dataErrorsCounter?: int32;

  @doc("Last modified time on target")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Result type")
  resultType: "TableLevelOutput";
}

model MigrateOracleAzureDbPostgreSqlSyncTaskOutputError
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  @doc("Migration error")
  @visibility("read")
  error?: ReportableException;

  @doc("Result type")
  resultType: "ErrorOutput";
}

model MigrateOracleAzureDbPostgreSqlSyncTaskOutputDatabaseError
  extends MigrateOracleAzureDbPostgreSqlSyncTaskOutput {
  @doc("Error message")
  errorMessage?: string;

  @doc("List of error events.")
  events?: SyncMigrationDatabaseErrorEvent[];

  @doc("Result type")
  resultType: "DatabaseLevelErrorOutput";
}

@doc("Information about an Oracle OCI driver.")
model OracleOCIDriverInfo {
  @doc("The name of the driver package")
  @visibility("read")
  driverName?: string;

  @doc("The size in bytes of the driver package")
  @visibility("read")
  driverSize?: string;

  @doc("The MD5 Base64 encoded checksum for the driver package.")
  @visibility("read")
  archiveChecksum?: string;

  @doc("The checksum for the driver package provided by Oracle.")
  @visibility("read")
  oracleChecksum?: string;

  @doc("Version listed in the OCI assembly 'oci.dll'")
  @visibility("read")
  assemblyVersion?: string;

  @doc("List of Oracle database versions supported by this driver. Only major minor of the version is listed.")
  @visibility("read")
  supportedOracleVersions?: string[];
}

@doc("Input for the service task to check for OCI drivers.")
model CheckOCIDriverTaskInput {
  @doc("Version of the source server to check against.  Optional.")
  serverVersion?: string;
}

@doc("Output for the service task to check for OCI drivers.")
model CheckOCIDriverTaskOutput {
  @doc("Information about the installed driver if found and valid.")
  installedDriver?: OracleOCIDriverInfo;

  @doc("Validation errors")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Input for the service task to upload an OCI driver.")
model UploadOCIDriverTaskInput {
  @doc("File share information for the OCI driver archive.")
  driverShare?: FileShare;
}

@doc("Output for the service task to upload an OCI driver.")
model UploadOCIDriverTaskOutput {
  @doc("The name of the driver package that was validated and uploaded.")
  @visibility("read")
  driverPackageName?: string;

  @doc("Validation errors")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Input for the service task to install an OCI driver.")
model InstallOCIDriverTaskInput {
  @doc("Name of the uploaded driver package to install.")
  driverPackageName?: string;
}

@doc("Output for the service task to install an OCI driver.")
model InstallOCIDriverTaskOutput {
  @doc("Validation errors")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Description of an action supported by the Database Migration Service")
model ServiceOperation {
  @doc("The fully qualified action name, e.g. Microsoft.DataMigration/services/read")
  name?: string;

  @doc("Localized display text")
  display?: ServiceOperationDisplay;
}

@doc("Localized display text")
model ServiceOperationDisplay {
  @doc("The localized resource provider name")
  provider?: string;

  @doc("The localized resource type name")
  resource?: string;

  @doc("The localized operation name")
  operation?: string;

  @doc("The localized operation description")
  description?: string;
}

@doc("OData page of action (operation) objects")
model ServiceOperationList {
  @doc("List of actions")
  value?: ServiceOperation[];

  @doc("URL to load the next page of actions")
  nextLink?: string;
}

@doc("Properties for the task that checks for OCI drivers.")
model CheckOCIDriverTaskProperties extends ProjectTaskProperties {
  @doc("Input for the service task to check for OCI drivers.")
  input?: CheckOCIDriverTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: CheckOCIDriverTaskOutput[];

  @doc("Task type.")
  taskType: "Service.Check.OCI";
}

@doc("Properties for the task that uploads an OCI driver.")
model UploadOCIDriverTaskProperties extends ProjectTaskProperties {
  @doc("Input for the service task to upload an OCI driver.")
  input?: UploadOCIDriverTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: UploadOCIDriverTaskOutput[];

  @doc("Task type.")
  taskType: "Service.Upload.OCI";
}

@doc("Properties for the task that installs an OCI driver.")
model InstallOCIDriverTaskProperties extends ProjectTaskProperties {
  @doc("Input for the service task to install an OCI driver.")
  input?: InstallOCIDriverTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: InstallOCIDriverTaskOutput[];

  @doc("Task type.")
  taskType: "Service.Install.OCI";
}

@doc("Properties for the task that validates the connection to and provides information about a MongoDB server")
model ConnectToMongoDbTaskProperties extends ProjectTaskProperties {
  @doc("Describes a connection to a MongoDB data source")
  input?: MongoDbConnectionInfo;

  @doc("An array containing a single MongoDbClusterInfo object")
  @visibility("read")
  output?: MongoDbClusterInfo[];

  @doc("Task type.")
  taskType: "Connect.MongoDb";
}

@doc("Properties for the task that validates connection to SQL Server and also validates source server requirements")
model ConnectToSourceSqlServerTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: ConnectToSourceSqlServerTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ConnectToSourceSqlServerTaskOutput[];

  @doc("Task id ")
  taskId?: string;

  @doc("Task type.")
  taskType: "ConnectToSource.SqlServer";
}

@doc("Properties for the task that validates connection to SQL Server and source server requirements for online migration")
model ConnectToSourceSqlServerSyncTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: ConnectToSourceSqlServerTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ConnectToSourceSqlServerTaskOutput[];

  @doc("Task type.")
  taskType: "ConnectToSource.SqlServer.Sync";
}

@doc("Properties for the task that validates connection to PostgreSQL server and source server requirements for online migration")
model ConnectToSourcePostgreSqlSyncTaskProperties
  extends ProjectTaskProperties {
  @doc("Task input")
  input?: ConnectToSourcePostgreSqlSyncTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ConnectToSourcePostgreSqlSyncTaskOutput[];

  @doc("Task type.")
  taskType: "ConnectToSource.PostgreSql.Sync";
}

@doc("Properties for the task that validates MySQL database connection")
model ConnectToSourceMySqlTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: ConnectToSourceMySqlTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ConnectToSourceNonSqlTaskOutput[];

  @doc("Task type.")
  taskType: "ConnectToSource.MySql";
}

@doc("Output for connect to MySQL type source")
model ConnectToSourceNonSqlTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;

  @doc("Server brand version")
  @visibility("read")
  sourceServerBrandVersion?: string;

  @doc("Server properties")
  @visibility("read")
  serverProperties?: ServerProperties;

  @doc("List of databases on the server")
  @visibility("read")
  databases?: string[];

  @doc("Validation errors associated with the task")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Server properties for MySQL type source")
model ServerProperties {
  @doc("Name of the server platform")
  @visibility("read")
  serverPlatform?: string;

  @doc("Name of the server")
  @visibility("read")
  serverName?: string;

  @doc("Version of the database server")
  @visibility("read")
  serverVersion?: string;

  @doc("Edition of the database server")
  @visibility("read")
  serverEdition?: string;

  @doc("Version of the operating system")
  @visibility("read")
  serverOperatingSystemVersion?: string;

  @doc("Number of databases in the server")
  @visibility("read")
  serverDatabaseCount?: int32;
}

@doc("Properties for the task that validates Oracle database connection")
model ConnectToSourceOracleSyncTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: ConnectToSourceOracleSyncTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ConnectToSourceOracleSyncTaskOutput[];

  @doc("Task type.")
  taskType: "ConnectToSource.Oracle.Sync";
}

@doc("Properties for the task that validates connection to SQL DB and target server requirements")
model ConnectToTargetSqlDbTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: ConnectToTargetSqlDbTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ConnectToTargetSqlDbTaskOutput[];

  @doc("DateTime in UTC when the task was created")
  createdOn?: string;

  @doc("Task type.")
  taskType: "ConnectToTarget.SqlDb";
}

@doc("Properties for the task that validates connection to SQL DB and target server requirements for online migration")
model ConnectToTargetSqlSqlDbSyncTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: ConnectToTargetSqlSqlDbSyncTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ConnectToTargetSqlDbTaskOutput[];

  @doc("Task type.")
  taskType: "ConnectToTarget.SqlDb.Sync";
}

@doc("Properties for the task that validates connection to Azure Database For PostgreSQL server and target server requirements for online migration")
model ConnectToTargetAzureDbForPostgreSqlSyncTaskProperties
  extends ProjectTaskProperties {
  @doc("Task input")
  input?: ConnectToTargetAzureDbForPostgreSqlSyncTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ConnectToTargetAzureDbForPostgreSqlSyncTaskOutput[];

  @doc("Task type.")
  taskType: "ConnectToTarget.AzureDbForPostgreSql.Sync";
}

@doc("Properties for the task that validates connection to Azure Database For PostgreSQL server and target server requirements for online migration for Oracle source.")
model ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskProperties
  extends ProjectTaskProperties {
  @doc("Task input")
  input?: ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ConnectToTargetOracleAzureDbForPostgreSqlSyncTaskOutput[];

  @doc("Task type.")
  taskType: "ConnectToTarget.Oracle.AzureDbForPostgreSql.Sync";
}

@doc("Properties for the task that collects user tables for the given list of databases")
model GetUserTablesSqlTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: GetUserTablesSqlTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: GetUserTablesSqlTaskOutput[];

  @doc("Task id ")
  taskId?: string;

  @doc("Task type.")
  taskType: "GetUserTables.Sql";
}

@doc("Properties for the task that collects user tables for the given list of databases")
model GetUserTablesSqlSyncTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: GetUserTablesSqlSyncTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: GetUserTablesSqlSyncTaskOutput[];

  @doc("Task type.")
  taskType: "GetUserTables.AzureSqlDb.Sync";
}

@doc("Properties for the task that collects user tables for the given list of Oracle schemas")
model GetUserTablesOracleTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: GetUserTablesOracleTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: GetUserTablesOracleTaskOutput[];

  @doc("Task type.")
  taskType: "GetUserTablesOracle";
}

@doc("Properties for the task that collects user tables for the given list of databases")
model GetUserTablesPostgreSqlTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: GetUserTablesPostgreSqlTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: GetUserTablesPostgreSqlTaskOutput[];

  @doc("Task type.")
  taskType: "GetUserTablesPostgreSql";
}

@doc("Properties for the task that collects user tables for the given list of databases")
model GetUserTablesMySqlTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: GetUserTablesMySqlTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: GetUserTablesMySqlTaskOutput[];

  @doc("Task type.")
  taskType: "GetUserTablesMySql";
}

@doc("Properties for the task that validates connection to Azure SQL Database Managed Instance")
model ConnectToTargetSqlMITaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: ConnectToTargetSqlMITaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ConnectToTargetSqlMITaskOutput[];

  @doc("Task type.")
  taskType: "ConnectToTarget.AzureSqlDbMI";
}

@doc("Properties for the task that validates connection to Azure SQL Database Managed Instance")
model ConnectToTargetSqlMISyncTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: ConnectToTargetSqlMISyncTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ConnectToTargetSqlMISyncTaskOutput[];

  @doc("Task type.")
  taskType: "ConnectToTarget.AzureSqlDbMI.Sync.LRS";
}

@doc("Properties for the task that validates connection to Azure Database for MySQL and target server requirements")
model ConnectToTargetAzureDbForMySqlTaskProperties
  extends ProjectTaskProperties {
  @doc("Task input")
  input?: ConnectToTargetAzureDbForMySqlTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ConnectToTargetAzureDbForMySqlTaskOutput[];

  @doc("Task type.")
  taskType: "ConnectToTarget.AzureDbForMySql";
}

@doc("Properties for the task that migrates data between MongoDB data sources")
model MigrateMongoDbTaskProperties extends ProjectTaskProperties {
  @doc("Describes how a MongoDB data migration should be performed")
  input?: MongoDbMigrationSettings;

  @visibility("read")
  output?: MongoDbProgress[];

  @doc("Task type.")
  taskType: "Migrate.MongoDb";
}

@doc("Properties for task that migrates SQL Server databases to Azure SQL Database Managed Instance")
model MigrateSqlServerSqlMITaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: MigrateSqlServerSqlMITaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: MigrateSqlServerSqlMITaskOutput[];

  @doc("task id")
  taskId?: string;

  @doc("DateTime in UTC when the task was created")
  createdOn?: string;

  @doc("parent task id")
  parentTaskId?: string;

  @doc("whether the task can be cloned or not")
  isCloneable?: boolean;

  @doc("Task type.")
  taskType: "Migrate.SqlServer.AzureSqlDbMI";
}

@doc("Properties for task that migrates SQL Server databases to Azure SQL Database Managed Instance sync scenario")
model MigrateSqlServerSqlMISyncTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: MigrateSqlServerSqlMISyncTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: MigrateSqlServerSqlMISyncTaskOutput[];

  @doc("DateTime in UTC when the task was created")
  createdOn?: string;

  @doc("Task type.")
  taskType: "Migrate.SqlServer.AzureSqlDbMI.Sync.LRS";
}

@doc("Properties for the task that migrates on-prem SQL Server databases to Azure SQL Database")
model MigrateSqlServerSqlDbTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: MigrateSqlServerSqlDbTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: MigrateSqlServerSqlDbTaskOutput[];

  @doc("task id")
  taskId?: string;

  @doc("whether the task can be cloned or not")
  isCloneable?: boolean;

  @doc("DateTime in UTC when the task was created")
  createdOn?: string;

  @doc("Task type.")
  taskType: "Migrate.SqlServer.SqlDb";
}

@doc("Properties for the task that migrates on-prem SQL Server databases to Azure SQL Database for online migrations")
model MigrateSqlServerSqlDbSyncTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: MigrateSqlServerSqlDbSyncTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: MigrateSqlServerSqlDbSyncTaskOutput[];

  @doc("Task type.")
  taskType: "Migrate.SqlServer.AzureSqlDb.Sync";
}

@doc("Properties for the task that migrates MySQL databases to Azure Database for MySQL for online migrations")
model MigrateMySqlAzureDbForMySqlSyncTaskProperties
  extends ProjectTaskProperties {
  @doc("Task input")
  input?: MigrateMySqlAzureDbForMySqlSyncTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: MigrateMySqlAzureDbForMySqlSyncTaskOutput[];

  @doc("Task type.")
  taskType: "Migrate.MySql.AzureDbForMySql.Sync";
}

@doc("Properties for the task that migrates MySQL databases to Azure Database for MySQL for offline migrations")
model MigrateMySqlAzureDbForMySqlOfflineTaskProperties
  extends ProjectTaskProperties {
  @doc("Task input")
  input?: MigrateMySqlAzureDbForMySqlOfflineTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: MigrateMySqlAzureDbForMySqlOfflineTaskOutput[];

  @doc("whether the task can be cloned or not")
  isCloneable?: boolean;

  @doc("Task id ")
  taskId?: string;

  @doc("Task type.")
  taskType: "Migrate.MySql.AzureDbForMySql";
}

@doc("Input for the task that migrates MySQL databases to Azure Database for MySQL for offline migrations")
model MigrateMySqlAzureDbForMySqlOfflineTaskInput {
  @doc("Connection information for source MySQL")
  sourceConnectionInfo: MySqlConnectionInfo;

  @doc("Connection information for target Azure Database for MySQL")
  targetConnectionInfo: MySqlConnectionInfo;

  @doc("Databases to migrate")
  selectedDatabases: MigrateMySqlAzureDbForMySqlOfflineDatabaseInput[];

  @doc("Setting to set the source server read only")
  makeSourceServerReadOnly?: boolean;

  @doc("Parameter to specify when the migration started")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Optional parameters for fine tuning the data transfer rate during migration")
  optionalAgentSettings?: Record<string>;

  @doc("encrypted key for secure fields")
  encryptedKeyForSecureFields?: string;
}

@doc("Database specific information for offline MySQL to Azure Database for MySQL migration task inputs")
model MigrateMySqlAzureDbForMySqlOfflineDatabaseInput {
  @doc("Name of the database")
  name?: string;

  @doc("Name of target database. Note: Target database will be truncated before starting migration.")
  targetDatabaseName?: string;

  @doc("Mapping of source to target tables")
  tableMap?: Record<string>;
}

@doc("Output for the task that migrates MySQL databases to Azure Database for MySQL for offline migrations")
@discriminator("resultType")
model MigrateMySqlAzureDbForMySqlOfflineTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;
}

@doc("Properties for the task that migrates PostgreSQL databases to Azure Database for PostgreSQL for online migrations")
model MigratePostgreSqlAzureDbForPostgreSqlSyncTaskProperties
  extends ProjectTaskProperties {
  @doc("Task input")
  input?: MigratePostgreSqlAzureDbForPostgreSqlSyncTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: MigratePostgreSqlAzureDbForPostgreSqlSyncTaskOutput[];

  @doc("task id")
  taskId?: string;

  @doc("DateTime in UTC when the task was created")
  createdOn?: string;

  @doc("whether the task can be cloned or not")
  isCloneable?: boolean;

  @doc("Task type.")
  taskType: "Migrate.PostgreSql.AzureDbForPostgreSql.SyncV2";
}

@doc("Properties for the task that migrates Oracle to Azure Database for PostgreSQL for online migrations")
model MigrateOracleAzureDbForPostgreSqlSyncTaskProperties
  extends ProjectTaskProperties {
  @doc("Task input")
  input?: MigrateOracleAzureDbPostgreSqlSyncTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: MigrateOracleAzureDbPostgreSqlSyncTaskOutput[];

  @doc("Task type.")
  taskType: "Migrate.Oracle.AzureDbForPostgreSql.Sync";
}

@doc("Properties for task that validates migration input for SQL to Azure SQL DB sync migrations")
model ValidateMigrationInputSqlServerSqlDbSyncTaskProperties
  extends ProjectTaskProperties {
  @doc("Task input")
  input?: ValidateSyncMigrationInputSqlServerTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ValidateSyncMigrationInputSqlServerTaskOutput[];

  @doc("Task type.")
  taskType: "ValidateMigrationInput.SqlServer.SqlDb.Sync";
}

@doc("Input for task that validates migration input for SQL sync migrations")
model ValidateSyncMigrationInputSqlServerTaskInput {
  @doc("Information for connecting to source SQL server")
  sourceConnectionInfo: SqlConnectionInfo;

  @doc("Information for connecting to target")
  targetConnectionInfo: SqlConnectionInfo;

  @doc("Databases to migrate")
  selectedDatabases: MigrateSqlServerSqlDbSyncDatabaseInput[];
}

@doc("Output for task that validates migration input for SQL sync migrations")
model ValidateSyncMigrationInputSqlServerTaskOutput {
  @doc("Database identifier")
  @visibility("read")
  id?: string;

  @doc("Name of database")
  @visibility("read")
  name?: string;

  @doc("Errors associated with a selected database object")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Properties for task that validates migration input for SQL to Azure SQL Database Managed Instance")
model ValidateMigrationInputSqlServerSqlMITaskProperties
  extends ProjectTaskProperties {
  @doc("Task input")
  input?: ValidateMigrationInputSqlServerSqlMITaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ValidateMigrationInputSqlServerSqlMITaskOutput[];

  @doc("Task type.")
  taskType: "ValidateMigrationInput.SqlServer.AzureSqlDbMI";
}

@doc("Input for task that validates migration input for SQL to Azure SQL Managed Instance")
model ValidateMigrationInputSqlServerSqlMITaskInput {
  @doc("Information for connecting to source")
  sourceConnectionInfo: SqlConnectionInfo;

  @doc("Information for connecting to target")
  targetConnectionInfo: SqlConnectionInfo;

  @doc("Databases to migrate")
  selectedDatabases: MigrateSqlServerSqlMIDatabaseInput[];

  @doc("Logins to migrate")
  selectedLogins?: string[];

  @doc("Backup file share information for all selected databases.")
  backupFileShare?: FileShare;

  @doc("SAS URI of Azure Storage Account Container to be used for storing backup files.")
  backupBlobShare: BlobShare;

  @doc("Backup Mode to specify whether to use existing backup or create new backup.")
  backupMode?: BackupMode;
}

@doc("Output for task that validates migration input for SQL to Azure SQL Managed Instance migrations")
model ValidateMigrationInputSqlServerSqlMITaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;

  @doc("Name of database")
  @visibility("read")
  name?: string;

  @doc("Errors associated with the RestoreDatabaseName")
  @visibility("read")
  restoreDatabaseNameErrors?: ReportableException[];

  @doc("Errors associated with the BackupFolder path")
  @visibility("read")
  backupFolderErrors?: ReportableException[];

  @doc("Errors associated with backup share user name and password credentials")
  @visibility("read")
  backupShareCredentialsErrors?: ReportableException[];

  @doc("Errors associated with the storage account provided.")
  @visibility("read")
  backupStorageAccountErrors?: ReportableException[];

  @doc("Errors associated with existing backup files.")
  @visibility("read")
  existingBackupErrors?: ReportableException[];

  @doc("Information about backup files when existing backup mode is used.")
  databaseBackupInfo?: DatabaseBackupInfo;
}

@doc("Information about backup files when existing backup mode is used.")
model DatabaseBackupInfo {
  @doc("Database name.")
  @visibility("read")
  databaseName?: string;

  @doc("Backup Type.")
  @visibility("read")
  backupType?: BackupType;

  @doc("The list of backup files for the current database.")
  @visibility("read")
  backupFiles?: string[];

  @doc("Position of current database backup in the file.")
  @visibility("read")
  position?: int32;

  @doc("Database was damaged when backed up, but the backup operation was requested to continue despite errors.")
  @visibility("read")
  isDamaged?: boolean;

  @doc("Whether the backup set is compressed")
  @visibility("read")
  isCompressed?: boolean;

  @doc("Number of files in the backup set.")
  @visibility("read")
  familyCount?: int32;

  @doc("Date and time when the backup operation finished.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupFinishDate?: utcDateTime;
}

@doc("Properties for task that validates migration input for SQL to Azure SQL Database Managed Instance sync scenario")
model ValidateMigrationInputSqlServerSqlMISyncTaskProperties
  extends ProjectTaskProperties {
  @doc("Task input")
  input?: ValidateMigrationInputSqlServerSqlMISyncTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: ValidateMigrationInputSqlServerSqlMISyncTaskOutput[];

  @doc("Task type.")
  taskType: "ValidateMigrationInput.SqlServer.AzureSqlDbMI.Sync.LRS";
}

@doc("Input for task that migrates SQL Server databases to Azure SQL Database Managed Instance online scenario.")
model ValidateMigrationInputSqlServerSqlMISyncTaskInput
  extends SqlServerSqlMISyncTaskInput {}

@doc("Output for task that validates migration input for Azure SQL Database Managed Instance online migration")
model ValidateMigrationInputSqlServerSqlMISyncTaskOutput {
  @doc("Database identifier")
  @visibility("read")
  id?: string;

  @doc("Name of database")
  @visibility("read")
  name?: string;

  @doc("Errors associated with a selected database object")
  @visibility("read")
  validationErrors?: ReportableException[];
}

@doc("Properties for the task that validates a migration between MongoDB data sources")
model ValidateMongoDbTaskProperties extends ProjectTaskProperties {
  @doc("Describes how a MongoDB data migration should be performed")
  input?: MongoDbMigrationSettings;

  @doc("An array containing a single MongoDbMigrationProgress object")
  @visibility("read")
  output?: MongoDbMigrationProgress[];

  @doc("Task type.")
  taskType: "Validate.MongoDb";
}

@doc("Properties for the task that validates a migration for Oracle to Azure Database for PostgreSQL for online migrations")
model ValidateOracleAzureDbForPostgreSqlSyncTaskProperties
  extends ProjectTaskProperties {
  @doc("Input for the task that migrates Oracle databases to Azure Database for PostgreSQL for online migrations")
  input?: MigrateOracleAzureDbPostgreSqlSyncTaskInput;

  @doc("An array containing a single validation error response object")
  @visibility("read")
  output?: ValidateOracleAzureDbPostgreSqlSyncTaskOutput[];

  @doc("Task type.")
  taskType: "Validate.Oracle.AzureDbPostgreSql.Sync";
}

@doc("Properties for the task that gets TDE certificates in Base64 encoded format.")
model GetTdeCertificatesSqlTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: GetTdeCertificatesSqlTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: GetTdeCertificatesSqlTaskOutput[];

  @doc("Task type.")
  taskType: "GetTDECertificates.Sql";
}

@doc("Properties for task that migrates SSIS packages from SQL Server databases to Azure SQL Database Managed Instance.")
model MigrateSsisTaskProperties extends ProjectTaskProperties {
  @doc("Task input")
  input?: MigrateSsisTaskInput;

  @doc("Task output. This is ignored if submitted.")
  @visibility("read")
  output?: MigrateSsisTaskOutput[];

  @doc("Task type.")
  taskType: "Migrate.Ssis";
}

@doc("Information about a single database")
model Database {
  @doc("Unique identifier for the database")
  id?: string;

  @doc("Name of the database")
  name?: string;

  @doc("SQL Server compatibility level of database")
  compatibilityLevel?: DatabaseCompatLevel;

  @doc("Collation name of the database")
  collation?: string;

  @doc("Name of the server")
  serverName?: string;

  @doc("Fully qualified name")
  fqdn?: string;

  @doc("Install id of the database")
  installId?: string;

  @doc("Version of the server")
  serverVersion?: string;

  @doc("Edition of the server")
  serverEdition?: string;

  @doc("Product level of the server (RTM, SP, CTP).")
  serverLevel?: string;

  @doc("Default path of the data files")
  serverDefaultDataPath?: string;

  @doc("Default path of the log files")
  serverDefaultLogPath?: string;

  @doc("Default path of the backup folder")
  serverDefaultBackupPath?: string;

  @doc("Number of cores on the server")
  serverCoreCount?: int32;

  @doc("Number of cores on the server that have VISIBLE ONLINE status")
  serverVisibleOnlineCoreCount?: int32;

  @doc("State of the database")
  databaseState?: DatabaseState;

  @doc("The unique Server Id")
  serverId?: string;
}

@doc("A representation of the name of an object in a database")
model DatabaseObjectName {
  @doc("The unescaped name of the database containing the object")
  @visibility("read")
  databaseName?: string;

  @doc("The unescaped name of the object")
  @visibility("read")
  objectName?: string;

  @doc("The unescaped name of the schema containing the object")
  @visibility("read")
  schemaName?: string;

  @doc("Type of the object in the database")
  objectType?: ObjectType;
}

@doc("Common metadata for migration projects")
model DataMigrationProjectMetadata {
  @doc("Source server name")
  @visibility("read")
  sourceServerName?: string;

  @doc("Source server port number")
  @visibility("read")
  sourceServerPort?: string;

  @doc("Source username")
  @visibility("read")
  sourceUsername?: string;

  @doc("Target server name")
  @visibility("read")
  targetServerName?: string;

  @doc("Target username")
  @visibility("read")
  targetUsername?: string;

  @doc("Target database name")
  @visibility("read")
  targetDbName?: string;

  @doc("Whether target connection is Windows authentication")
  @visibility("read")
  targetUsingWinAuth?: boolean;

  @doc("List of tables selected for migration")
  @visibility("read")
  selectedMigrationTables?: MigrationTableMetadata[];
}

@doc("Metadata for tables selected in migration project")
model MigrationTableMetadata {
  @doc("Source table name")
  @visibility("read")
  sourceTableName?: string;

  @doc("Target table name")
  @visibility("read")
  targetTableName?: string;
}

@doc("Input for the task that reads configuration from project artifacts")
model GetProjectDetailsNonSqlTaskInput {
  @doc("Name of the migration project")
  projectName: string;

  @doc("A URL that points to the location to access project artifacts")
  projectLocation: string;
}

@doc("Base class for non sql migration task input")
model NonSqlMigrationTaskInput {
  @doc("Information for connecting to target")
  targetConnectionInfo: SqlConnectionInfo;

  @doc("Target database name")
  targetDatabaseName: string;

  @doc("Name of the migration project")
  projectName: string;

  @doc("A URL that points to the drop location to access project artifacts")
  projectLocation: string;

  @doc("Metadata of the tables selected for migration")
  selectedTables: NonSqlDataMigrationTable[];
}

@doc("Defines metadata for table to be migrated")
model NonSqlDataMigrationTable {
  @doc("Source table name")
  sourceName?: string;
}

@doc("Base class for non sql migration task output")
model NonSqlMigrationTaskOutput {
  @doc("Result identifier")
  @visibility("read")
  id?: string;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Current state of migration")
  @visibility("read")
  status?: MigrationStatus;

  @doc("Results of the migration. The key contains the table name and the value the table result object")
  @visibility("read")
  dataMigrationTableResults?: string;

  @doc("Message about the progress of the migration")
  @visibility("read")
  progressMessage?: string;

  @doc("Name of source server")
  @visibility("read")
  sourceServerName?: string;

  @doc("Name of target server")
  @visibility("read")
  targetServerName?: string;
}

@doc("Object used to report the data migration results of a table")
model NonSqlDataMigrationTableResult {
  @doc("Result code of the data migration")
  @visibility("read")
  resultCode?: DataMigrationResultCode;

  @doc("Name of the source table")
  @visibility("read")
  sourceName?: string;

  @doc("Name of the target table")
  @visibility("read")
  targetName?: string;

  @doc("Number of rows in the source table")
  @visibility("read")
  sourceRowCount?: int32;

  @doc("Number of rows in the target table")
  @visibility("read")
  targetRowCount?: int32;

  @doc("Time taken to migrate the data")
  @visibility("read")
  elapsedTimeInMiliseconds?: float32;

  @doc("List of errors, if any, during migration")
  @visibility("read")
  errors?: DataMigrationError[];
}

@doc("Migration Task errors")
model DataMigrationError {
  @doc("Error description")
  @visibility("read")
  message?: string;

  @doc("Error type")
  type?: ErrorType;
}

@doc("Database specific information for SQL to SQL migration task inputs")
model MigrateSqlServerSqlServerDatabaseInput {
  @doc("Name of the database")
  name?: string;

  @doc("Name of the database at destination")
  restoreDatabaseName?: string;

  @doc("The backup and restore folder")
  backupAndRestoreFolder?: string;

  @doc("The list of database files")
  databaseFiles?: DatabaseFileInput[];
}

@doc("Database file specific information for input")
model DatabaseFileInput {
  @doc("Unique identifier for database file")
  id?: string;

  @doc("Logical name of the file")
  logicalName?: string;

  @doc("Operating-system full path of the file")
  physicalFullName?: string;

  @doc("Suggested full path of the file for restoring")
  restoreFullName?: string;

  @doc("Database file type")
  fileType?: DatabaseFileType;
}

@doc("Server role migration result")
model StartMigrationScenarioServerRoleResult {
  @doc("Name of server role.")
  @visibility("read")
  name?: string;

  @doc("Current state of migration")
  @visibility("read")
  state?: MigrationState;

  @doc("Migration exceptions and warnings.")
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];
}

model MigrateMySqlAzureDbForMySqlOfflineTaskOutputMigrationLevel
  extends MigrateMySqlAzureDbForMySqlOfflineTaskOutput {
  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Duration of task execution in seconds.")
  @visibility("read")
  durationInSeconds?: int32;

  @doc("Current status of migration")
  @visibility("read")
  status?: MigrationStatus;

  @doc("Migration status message")
  @visibility("read")
  statusMessage?: string;

  @doc("Migration progress message")
  @visibility("read")
  message?: string;

  @doc("Selected databases as a map from database name to database id")
  databases?: string;

  @doc("Summary of database results in the migration")
  @visibility("read")
  databaseSummary?: string;

  @doc("Migration Report Result, provides unique url for downloading your migration report.")
  migrationReportResult?: MigrationReportResult;

  @doc("Source server version")
  @visibility("read")
  sourceServerVersion?: string;

  @doc("Source server brand version")
  @visibility("read")
  sourceServerBrandVersion?: string;

  @doc("Target server version")
  @visibility("read")
  targetServerVersion?: string;

  @doc("Target server brand version")
  @visibility("read")
  targetServerBrandVersion?: string;

  @doc("Migration exceptions and warnings.")
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  @doc("Last time the storage was updated")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStorageUpdate?: utcDateTime;

  @doc("Result type")
  resultType: "MigrationLevelOutput";
}

model MigrateMySqlAzureDbForMySqlOfflineTaskOutputDatabaseLevel
  extends MigrateMySqlAzureDbForMySqlOfflineTaskOutput {
  @doc("Name of the database")
  @visibility("read")
  databaseName?: string;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Current state of migration")
  @visibility("read")
  state?: MigrationState;

  @doc("Migration stage that this database is in")
  @visibility("read")
  stage?: DatabaseMigrationStage;

  @doc("Status message")
  @visibility("read")
  statusMessage?: string;

  @doc("Migration progress message")
  @visibility("read")
  message?: string;

  @doc("Number of objects")
  @visibility("read")
  numberOfObjects?: int32;

  @doc("Number of successfully completed objects")
  @visibility("read")
  numberOfObjectsCompleted?: int32;

  @doc("Number of database/object errors.")
  @visibility("read")
  errorCount?: int32;

  @doc("Wildcard string prefix to use for querying all errors of the item")
  @visibility("read")
  errorPrefix?: string;

  @doc("Wildcard string prefix to use for querying all sub-tem results of the item")
  @visibility("read")
  resultPrefix?: string;

  @doc("Migration exceptions and warnings.")
  @visibility("read")
  exceptionsAndWarnings?: ReportableException[];

  @doc("Last time the storage was updated")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStorageUpdate?: utcDateTime;

  @doc("Summary of object results in the migration")
  @visibility("read")
  objectSummary?: string;

  @doc("Result type")
  resultType: "DatabaseLevelOutput";
}

model MigrateMySqlAzureDbForMySqlOfflineTaskOutputTableLevel
  extends MigrateMySqlAzureDbForMySqlOfflineTaskOutput {
  @doc("Name of the item")
  @visibility("read")
  objectName?: string;

  @doc("Migration start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  @doc("Migration end time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  @doc("Current state of migration")
  @visibility("read")
  state?: MigrationState;

  @doc("Status message")
  @visibility("read")
  statusMessage?: string;

  @doc("Number of items")
  @visibility("read")
  itemsCount?: int32;

  @doc("Number of successfully completed items")
  @visibility("read")
  itemsCompletedCount?: int32;

  @doc("Wildcard string prefix to use for querying all errors of the item")
  @visibility("read")
  errorPrefix?: string;

  @doc("Wildcard string prefix to use for querying all sub-tem results of the item")
  @visibility("read")
  resultPrefix?: string;

  @doc("Last time the storage was updated")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStorageUpdate?: utcDateTime;

  @doc("Result type")
  resultType: "TableLevelOutput";
}

model MigrateMySqlAzureDbForMySqlOfflineTaskOutputError
  extends MigrateMySqlAzureDbForMySqlOfflineTaskOutput {
  @doc("Migration error")
  @visibility("read")
  error?: ReportableException;

  @doc("Result type")
  resultType: "ErrorOutput";
}
