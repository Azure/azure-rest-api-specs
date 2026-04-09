import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Sql;

/**
 * The differential backup interval in hours. This is how many interval hours between each differential backup will be supported. This is only applicable to live databases but not dropped databases.
 */
union DiffBackupIntervalInHours {
  int32,

  /**
   * 12
   */
  `12`: 12,

  /**
   * 24
   */
  `24`: 24,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ShortTermRetentionPolicyName {
  string,

  /**
   * default
   */
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DataSyncParticipantIdentityType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",

  /**
   * SystemAssignedUserAssigned
   */
  SystemAssignedUserAssigned: "SystemAssignedUserAssigned",
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
union AdvancedThreatProtectionName {
  string,

  /**
   * Default
   */
  Default: "Default",
}

/**
 * Current state the recommended action is in. Some commonly used states are: Active      -> recommended action is active and no action has been taken yet. Pending     -> recommended action is approved for and is awaiting execution. Executing   -> recommended action is being applied on the user database. Verifying   -> recommended action was applied and is being verified of its usefulness by the system. Success     -> recommended action was applied and improvement found during verification. Pending Revert  -> verification found little or no improvement so recommended action is queued for revert or user has manually reverted. Reverting   -> changes made while applying recommended action are being reverted on the user database. Reverted    -> successfully reverted the changes made by recommended action on user database. Ignored     -> user explicitly ignored/discarded the recommended action.
 */
union RecommendedActionCurrentState {
  string,

  /**
   * Active
   */
  Active: "Active",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Executing
   */
  Executing: "Executing",

  /**
   * Verifying
   */
  Verifying: "Verifying",

  /**
   * PendingRevert
   */
  PendingRevert: "PendingRevert",

  /**
   * RevertCancelled
   */
  RevertCancelled: "RevertCancelled",

  /**
   * Reverting
   */
  Reverting: "Reverting",

  /**
   * Reverted
   */
  Reverted: "Reverted",

  /**
   * Ignored
   */
  Ignored: "Ignored",

  /**
   * Expired
   */
  Expired: "Expired",

  /**
   * Monitoring
   */
  Monitoring: "Monitoring",

  /**
   * Resolved
   */
  Resolved: "Resolved",

  /**
   * Success
   */
  Success: "Success",

  /**
   * Error
   */
  Error: "Error",
}

/**
 * The column data type.
 */
union ColumnDataType {
  string,

  /**
   * image
   */
  image: "image",

  /**
   * text
   */
  text: "text",

  /**
   * uniqueidentifier
   */
  uniqueidentifier: "uniqueidentifier",

  /**
   * date
   */
  date: "date",

  /**
   * time
   */
  time: "time",

  /**
   * datetime2
   */
  datetime2: "datetime2",

  /**
   * datetimeoffset
   */
  datetimeoffset: "datetimeoffset",

  /**
   * tinyint
   */
  tinyint: "tinyint",

  /**
   * smallint
   */
  smallint: "smallint",

  /**
   * int
   */
  int: "int",

  /**
   * smalldatetime
   */
  smalldatetime: "smalldatetime",

  /**
   * real
   */
  real: "real",

  /**
   * money
   */
  money: "money",

  /**
   * datetime
   */
  datetime: "datetime",

  /**
   * float
   */
  float: "float",

  /**
   * sql_variant
   */
  sql_variant: "sql_variant",

  /**
   * ntext
   */
  ntext: "ntext",

  /**
   * bit
   */
  bit: "bit",

  /**
   * decimal
   */
  decimal: "decimal",

  /**
   * numeric
   */
  numeric: "numeric",

  /**
   * smallmoney
   */
  smallmoney: "smallmoney",

  /**
   * bigint
   */
  bigint: "bigint",

  /**
   * hierarchyid
   */
  hierarchyid: "hierarchyid",

  /**
   * geometry
   */
  geometry: "geometry",

  /**
   * geography
   */
  geography: "geography",

  /**
   * varbinary
   */
  varbinary: "varbinary",

  /**
   * varchar
   */
  varchar: "varchar",

  /**
   * binary
   */
  binary: "binary",

  /**
   * char
   */
  char: "char",

  /**
   * timestamp
   */
  timestamp: "timestamp",

  /**
   * nvarchar
   */
  nvarchar: "nvarchar",

  /**
   * nchar
   */
  nchar: "nchar",

  /**
   * xml
   */
  xml: "xml",

  /**
   * sysname
   */
  sysname: "sysname",
}

/**
 * The table temporal type.
 */
union TableTemporalType {
  string,

  /**
   * NonTemporalTable
   */
  NonTemporalTable: "NonTemporalTable",

  /**
   * HistoryTable
   */
  HistoryTable: "HistoryTable",

  /**
   * SystemVersionedTemporalTable
   */
  SystemVersionedTemporalTable: "SystemVersionedTemporalTable",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union EncryptionProtectorName {
  string,

  /**
   * current
   */
  current: "current",
}

/**
 * Operation mode of the operation: Import, Export, or PolybaseImport.
 */
union OperationMode {
  string,

  /**
   * PolybaseImport
   */
  PolybaseImport: "PolybaseImport",

  /**
   * Import
   */
  Import: "Import",

  /**
   * Export
   */
  Export: "Export",
}

/**
 * Storage key type: StorageAccessKey, SharedAccessKey or ManagedIdentity.
 */
union StorageKeyType {
  string,

  /**
   * SharedAccessKey
   */
  SharedAccessKey: "SharedAccessKey",

  /**
   * StorageAccessKey
   */
  StorageAccessKey: "StorageAccessKey",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",
}

/**
 * The operation state.
 */
union ManagementOperationState {
  string,

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * CancelInProgress
   */
  CancelInProgress: "CancelInProgress",

  /**
   * Cancelled
   */
  Cancelled: "Cancelled",
}

/**
 * The operation phase.
 */
union Phase {
  string,

  /**
   * LogTransitionInProgress
   */
  LogTransitionInProgress: "LogTransitionInProgress",

  /**
   * Copying
   */
  Copying: "Copying",

  /**
   * BuildingHyperscaleComponents
   */
  BuildingHyperscaleComponents: "BuildingHyperscaleComponents",

  /**
   * Catchup
   */
  Catchup: "Catchup",

  /**
   * WaitingForCutover
   */
  WaitingForCutover: "WaitingForCutover",

  /**
   * CutoverInProgress
   */
  CutoverInProgress: "CutoverInProgress",
}

/**
 * The identity type
 */
union DatabaseIdentityType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",
}

/**
 * Specifies the mode of database creation.
 *
 * Default: regular database creation.
 *
 * Copy: creates a database as a copy of an existing database. sourceDatabaseId must be specified as the resource ID of the source database.
 *
 * Secondary: creates a database as a secondary replica of an existing database. sourceDatabaseId must be specified as the resource ID of the existing primary database.
 *
 * PointInTimeRestore: Creates a database by restoring a point in time backup of an existing database. sourceDatabaseId must be specified as the resource ID of the existing database, and restorePointInTime must be specified.
 *
 * Recovery: Creates a database by restoring a geo-replicated backup. sourceDatabaseId must be specified as the recoverable database resource ID to restore.
 *
 * Restore: Creates a database by restoring a backup of a deleted database. sourceDatabaseId must be specified. If sourceDatabaseId is the database's original resource ID, then sourceDatabaseDeletionDate must be specified. Otherwise sourceDatabaseId must be the restorable dropped database resource ID and sourceDatabaseDeletionDate is ignored. restorePointInTime may also be specified to restore from an earlier point in time.
 *
 * RestoreLongTermRetentionBackup: Creates a database by restoring from a long term retention vault. recoveryServicesRecoveryPointResourceId must be specified as the recovery point resource ID.
 *
 * Copy, Secondary, and RestoreLongTermRetentionBackup are not supported for DataWarehouse edition.
 */
union CreateMode {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * Copy
   */
  Copy: "Copy",

  /**
   * Secondary
   */
  Secondary: "Secondary",

  /**
   * PointInTimeRestore
   */
  PointInTimeRestore: "PointInTimeRestore",

  /**
   * Restore
   */
  Restore: "Restore",

  /**
   * Recovery
   */
  Recovery: "Recovery",

  /**
   * RestoreExternalBackup
   */
  RestoreExternalBackup: "RestoreExternalBackup",

  /**
   * RestoreExternalBackupSecondary
   */
  RestoreExternalBackupSecondary: "RestoreExternalBackupSecondary",

  /**
   * RestoreLongTermRetentionBackup
   */
  RestoreLongTermRetentionBackup: "RestoreLongTermRetentionBackup",

  /**
   * OnlineSecondary
   */
  OnlineSecondary: "OnlineSecondary",
}

/**
 * The name of the sample schema to apply when creating this database.
 */
union SampleName {
  string,

  /**
   * AdventureWorksLT
   */
  AdventureWorksLT: "AdventureWorksLT",

  /**
   * WideWorldImportersStd
   */
  WideWorldImportersStd: "WideWorldImportersStd",

  /**
   * WideWorldImportersFull
   */
  WideWorldImportersFull: "WideWorldImportersFull",
}

/**
 * The status of the database.
 */
union DatabaseStatus {
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
   * RecoveryPending
   */
  RecoveryPending: "RecoveryPending",

  /**
   * Recovering
   */
  Recovering: "Recovering",

  /**
   * Suspect
   */
  Suspect: "Suspect",

  /**
   * Offline
   */
  Offline: "Offline",

  /**
   * Standby
   */
  Standby: "Standby",

  /**
   * Shutdown
   */
  Shutdown: "Shutdown",

  /**
   * EmergencyMode
   */
  EmergencyMode: "EmergencyMode",

  /**
   * AutoClosed
   */
  AutoClosed: "AutoClosed",

  /**
   * Copying
   */
  Copying: "Copying",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Inaccessible
   */
  Inaccessible: "Inaccessible",

  /**
   * OfflineSecondary
   */
  OfflineSecondary: "OfflineSecondary",

  /**
   * Pausing
   */
  Pausing: "Pausing",

  /**
   * Paused
   */
  Paused: "Paused",

  /**
   * Resuming
   */
  Resuming: "Resuming",

  /**
   * Scaling
   */
  Scaling: "Scaling",

  /**
   * OfflineChangingDwPerformanceTiers
   */
  OfflineChangingDwPerformanceTiers: "OfflineChangingDwPerformanceTiers",

  /**
   * OnlineChangingDwPerformanceTiers
   */
  OnlineChangingDwPerformanceTiers: "OnlineChangingDwPerformanceTiers",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Stopping
   */
  Stopping: "Stopping",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Starting
   */
  Starting: "Starting",
}

/**
 * Collation of the metadata catalog.
 */
union CatalogCollationType {
  string,

  /**
   * DATABASE_DEFAULT
   */
  DATABASE_DEFAULT: "DATABASE_DEFAULT",

  /**
   * SQL_Latin1_General_CP1_CI_AS
   */
  SQL_Latin1_General_CP1_CI_AS: "SQL_Latin1_General_CP1_CI_AS",
}

/**
 * The license type to apply for this database. `LicenseIncluded` if you need a license, or `BasePrice` if you have a license and are eligible for the Azure Hybrid Benefit.
 */
union DatabaseLicenseType {
  string,

  /**
   * LicenseIncluded
   */
  LicenseIncluded: "LicenseIncluded",

  /**
   * BasePrice
   */
  BasePrice: "BasePrice",
}

/**
 * The state of read-only routing. If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica in the same region. Not applicable to a Hyperscale database within an elastic pool.
 */
union DatabaseReadScale {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The secondary type of the database if it is a secondary.  Valid values are Geo, Named and Standby.
 */
union SecondaryType {
  string,

  /**
   * Geo
   */
  Geo: "Geo",

  /**
   * Named
   */
  Named: "Named",

  /**
   * Standby
   */
  Standby: "Standby",
}

/**
 * The storage account type used to store backups for this database.
 */
union BackupStorageRedundancy {
  string,

  /**
   * Geo
   */
  Geo: "Geo",

  /**
   * Local
   */
  Local: "Local",

  /**
   * Zone
   */
  Zone: "Zone",

  /**
   * GeoZone
   */
  GeoZone: "GeoZone",
}

/**
 * The database key type. Only supported value is 'AzureKeyVault'.
 */
union DatabaseKeyType {
  string,

  /**
   * AzureKeyVault
   */
  AzureKeyVault: "AzureKeyVault",
}

/**
 * Type of enclave requested on the database i.e. Default or VBS enclaves.
 */
union AlwaysEncryptedEnclaveType {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * VBS
   */
  VBS: "VBS",
}

/**
 * Specifies the behavior when monthly free limits are exhausted for the free database.
 *
 * AutoPause: The database will be auto paused upon exhaustion of free limits for remainder of the month.
 *
 * BillForUsage: The database will continue to be online upon exhaustion of free limits and any overage will be billed.
 */
union FreeLimitExhaustionBehavior {
  string,

  /**
   * AutoPause
   */
  AutoPause: "AutoPause",

  /**
   * BillOverUsage
   */
  BillOverUsage: "BillOverUsage",
}

/**
 * Specifies the availability zone the database is pinned to.
 */
union AvailabilityZoneType {
  string,

  /**
   * NoPreference
   */
  NoPreference: "NoPreference",

  /**
   * 1
   */
  `1`: "1",

  /**
   * 2
   */
  `2`: "2",

  /**
   * 3
   */
  `3`: "3",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ReplicaType {
  string,

  /**
   * Primary
   */
  Primary: "Primary",

  /**
   * ReadableSecondary
   */
  ReadableSecondary: "ReadableSecondary",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DatabaseSecurityAlertPolicyName {
  string,

  /**
   * default
   */
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union VulnerabilityAssessmentName {
  string,

  /**
   * default
   */
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union BaselineName {
  string,

  /**
   * default
   */
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SqlVulnerabilityAssessmentName {
  string,

  /**
   * default
   */
  default: "default",
}

/**
 * SQL Vulnerability Assessment baseline status
 */
union RuleStatus {
  string,

  /**
   * NonFinding
   */
  NonFinding: "NonFinding",

  /**
   * Finding
   */
  Finding: "Finding",

  /**
   * InternalError
   */
  InternalError: "InternalError",
}

/**
 * SQL Vulnerability Assessment rule severity.
 */
union RuleSeverity {
  string,

  /**
   * High
   */
  High: "High",

  /**
   * Medium
   */
  Medium: "Medium",

  /**
   * Low
   */
  Low: "Low",

  /**
   * Informational
   */
  Informational: "Informational",

  /**
   * Obsolete
   */
  Obsolete: "Obsolete",
}

/**
 * SQL Vulnerability Assessment rule type.
 */
union RuleType {
  string,

  /**
   * Binary
   */
  Binary: "Binary",

  /**
   * BaselineExpected
   */
  BaselineExpected: "BaselineExpected",

  /**
   * PositiveList
   */
  PositiveList: "PositiveList",

  /**
   * NegativeList
   */
  NegativeList: "NegativeList",
}

/**
 * The scan trigger type.
 */
union VulnerabilityAssessmentScanTriggerType {
  string,

  /**
   * OnDemand
   */
  OnDemand: "OnDemand",

  /**
   * Recurring
   */
  Recurring: "Recurring",
}

/**
 * The scan status.
 */
union VulnerabilityAssessmentScanState {
  string,

  /**
   * Passed
   */
  Passed: "Passed",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * FailedToRun
   */
  FailedToRun: "FailedToRun",

  /**
   * InProgress
   */
  InProgress: "InProgress",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DataMaskingPolicyName {
  string,

  /**
   * Default
   */
  Default: "Default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DataWarehouseUserActivityName {
  string,

  /**
   * current
   */
  current: "current",
}

/**
 * Replication mode of the link
 */
union ReplicationModeType {
  string,

  /**
   * Async
   */
  Async: "Async",

  /**
   * Sync
   */
  Sync: "Sync",
}

/**
 * SQL server side link role
 */
union LinkRole {
  string,

  /**
   * Primary
   */
  Primary: "Primary",

  /**
   * Secondary
   */
  Secondary: "Secondary",
}

/**
 * The link failover mode - can be Manual if intended to be used for two-way failover with a supported SQL Server, or None for one-way failover to Azure.
 */
union FailoverModeType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Manual
   */
  Manual: "Manual",
}

/**
 * Database seeding mode – can be Automatic (default), or Manual for supported scenarios.
 */
union SeedingModeType {
  string,

  /**
   * Automatic
   */
  Automatic: "Automatic",

  /**
   * Manual
   */
  Manual: "Manual",
}

/**
 * Link health state
 */
union ReplicaSynchronizationHealth {
  string,

  /**
   * NOT_HEALTHY
   */
  NOT_HEALTHY: "NOT_HEALTHY",

  /**
   * PARTIALLY_HEALTHY
   */
  PARTIALLY_HEALTHY: "PARTIALLY_HEALTHY",

  /**
   * HEALTHY
   */
  HEALTHY: "HEALTHY",
}

/**
 * Link connected state
 */
union ReplicaConnectedState {
  string,

  /**
   * DISCONNECTED
   */
  DISCONNECTED: "DISCONNECTED",

  /**
   * CONNECTED
   */
  CONNECTED: "CONNECTED",
}

/**
 * The failover type, can be ForcedAllowDataLoss or Planned.
 */
union FailoverType {
  string,

  /**
   * ForcedAllowDataLoss
   */
  ForcedAllowDataLoss: "ForcedAllowDataLoss",

  /**
   * Planned
   */
  Planned: "Planned",
}

/**
 * New role of managed instance in a distributed availability group, can be Primary or Secondary.
 */
union InstanceRole {
  string,

  /**
   * Primary
   */
  Primary: "Primary",

  /**
   * Secondary
   */
  Secondary: "Secondary",
}

/**
 * The type of the role change, can be Planned or Forced.
 */
union RoleChangeType {
  string,

  /**
   * Forced
   */
  Forced: "Forced",

  /**
   * Planned
   */
  Planned: "Planned",
}

/**
 * The state of the elastic pool.
 */
union ElasticPoolState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Ready
   */
  Ready: "Ready",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The license type to apply for this elastic pool.
 */
union ElasticPoolLicenseType {
  string,

  /**
   * LicenseIncluded
   */
  LicenseIncluded: "LicenseIncluded",

  /**
   * BasePrice
   */
  BasePrice: "BasePrice",
}

/**
 * The encryption protector type like 'ServiceManaged', 'AzureKeyVault'.
 */
union ServerKeyType {
  string,

  /**
   * ServiceManaged
   */
  ServiceManaged: "ServiceManaged",

  /**
   * AzureKeyVault
   */
  AzureKeyVault: "AzureKeyVault",
}

/**
 * Failover policy of the read-write endpoint for the failover group. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.
 */
union ReadWriteEndpointFailoverPolicy {
  string,

  /**
   * Manual
   */
  Manual: "Manual",

  /**
   * Automatic
   */
  Automatic: "Automatic",
}

/**
 * Failover policy of the read-only endpoint for the failover group.
 */
union ReadOnlyEndpointFailoverPolicy {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Local replication role of the failover group instance.
 */
union FailoverGroupReplicationRole {
  string,

  /**
   * Primary
   */
  Primary: "Primary",

  /**
   * Secondary
   */
  Secondary: "Secondary",
}

/**
 * Databases secondary type on partner server.
 */
union FailoverGroupDatabasesSecondaryType {
  string,

  /**
   * Geo
   */
  Geo: "Geo",

  /**
   * Standby
   */
  Standby: "Standby",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union GeoBackupPolicyName {
  string,

  /**
   * Default
   */
  Default: "Default",
}

/**
 * Type of the geo-secondary instance. Set 'Standby' if the instance is used as a DR option only.
 */
union SecondaryInstanceType {
  string,

  /**
   * Geo
   */
  Geo: "Geo",

  /**
   * Standby
   */
  Standby: "Standby",
}

/**
 * Local replication role of the failover group instance.
 */
union InstanceFailoverGroupReplicationRole {
  string,

  /**
   * Primary
   */
  Primary: "Primary",

  /**
   * Secondary
   */
  Secondary: "Secondary",
}

/**
 * Error type (e.g. None, User).
 */
union ErrorType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * User
   */
  User: "User",
}

/**
 * The license type. Possible values are 'LicenseIncluded' (price for SQL license is included) and 'BasePrice' (without SQL license price).
 */
union InstancePoolLicenseType {
  string,

  /**
   * LicenseIncluded
   */
  LicenseIncluded: "LicenseIncluded",

  /**
   * BasePrice
   */
  BasePrice: "BasePrice",
}

/**
 * The job agent identity type
 */
union JobAgentIdentityType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",

  /**
   * SystemAssignedUserAssigned
   */
  SystemAssignedUserAssigned: "SystemAssignedUserAssigned",
}

/**
 * The state of the job agent.
 */
union JobAgentState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Ready
   */
  Ready: "Ready",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The detailed state of the job execution.
 */
union JobExecutionLifecycle {
  string,

  /**
   * Created
   */
  Created: "Created",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * WaitingForChildJobExecutions
   */
  WaitingForChildJobExecutions: "WaitingForChildJobExecutions",

  /**
   * WaitingForRetry
   */
  WaitingForRetry: "WaitingForRetry",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * SucceededWithSkipped
   */
  SucceededWithSkipped: "SucceededWithSkipped",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * TimedOut
   */
  TimedOut: "TimedOut",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Skipped
   */
  Skipped: "Skipped",
}

/**
 * The ARM provisioning state of the job execution.
 */
union ProvisioningState {
  string,

  /**
   * Created
   */
  Created: "Created",

  /**
   * InProgress
   */
  InProgress: "InProgress",

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
 * The type of the target.
 */
union JobTargetType {
  string,

  /**
   * TargetGroup
   */
  TargetGroup: "TargetGroup",

  /**
   * SqlDatabase
   */
  SqlDatabase: "SqlDatabase",

  /**
   * SqlElasticPool
   */
  SqlElasticPool: "SqlElasticPool",

  /**
   * SqlShardMap
   */
  SqlShardMap: "SqlShardMap",

  /**
   * SqlServer
   */
  SqlServer: "SqlServer",
}

/**
 * Type of action being executed by the job step.
 */
union JobStepActionType {
  string,

  /**
   * TSql
   */
  TSql: "TSql",
}

/**
 * The source of the action to execute.
 */
union JobStepActionSource {
  string,

  /**
   * Inline
   */
  Inline: "Inline",
}

/**
 * The output destination type.
 */
union JobStepOutputType {
  string,

  /**
   * SqlDatabase
   */
  SqlDatabase: "SqlDatabase",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union LedgerDigestUploadsName {
  string,

  /**
   * current
   */
  current: "current",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union CapabilityGroup {
  string,

  /**
   * supportedEditions
   */
  supportedEditions: "supportedEditions",

  /**
   * supportedElasticPoolEditions
   */
  supportedElasticPoolEditions: "supportedElasticPoolEditions",

  /**
   * supportedManagedInstanceVersions
   */
  supportedManagedInstanceVersions: "supportedManagedInstanceVersions",

  /**
   * supportedInstancePoolEditions
   */
  supportedInstancePoolEditions: "supportedInstancePoolEditions",

  /**
   * supportedManagedInstanceEditions
   */
  supportedManagedInstanceEditions: "supportedManagedInstanceEditions",

  /**
   * supportedJobAgentVersions
   */
  supportedJobAgentVersions: "supportedJobAgentVersions",
}

/**
 * The units that the limit is expressed in.
 */
union MaxSizeUnit {
  string,

  /**
   * Megabytes
   */
  Megabytes: "Megabytes",

  /**
   * Gigabytes
   */
  Gigabytes: "Gigabytes",

  /**
   * Terabytes
   */
  Terabytes: "Terabytes",

  /**
   * Petabytes
   */
  Petabytes: "Petabytes",
}

/**
 * The units that the limit is expressed in.
 */
union LogSizeUnit {
  string,

  /**
   * Megabytes
   */
  Megabytes: "Megabytes",

  /**
   * Gigabytes
   */
  Gigabytes: "Gigabytes",

  /**
   * Terabytes
   */
  Terabytes: "Terabytes",

  /**
   * Petabytes
   */
  Petabytes: "Petabytes",

  /**
   * Percent
   */
  Percent: "Percent",
}

/**
 * Unit type used to measure performance level.
 */
union PerformanceLevelUnit {
  string,

  /**
   * DTU
   */
  DTU: "DTU",

  /**
   * VCores
   */
  VCores: "VCores",
}

/**
 * Unit of time that delay is expressed in
 */
union PauseDelayTimeUnit {
  string,

  /**
   * Minutes
   */
  Minutes: "Minutes",
}

/**
 * The storage account type for the database's backups.
 */
union StorageCapabilityStorageAccountType {
  string,

  /**
   * GRS
   */
  GRS: "GRS",

  /**
   * LRS
   */
  LRS: "LRS",

  /**
   * ZRS
   */
  ZRS: "ZRS",

  /**
   * GZRS
   */
  GZRS: "GZRS",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DatabaseState {
  string,

  /**
   * All
   */
  All: "All",

  /**
   * Live
   */
  Live: "Live",

  /**
   * Deleted
   */
  Deleted: "Deleted",
}

/**
 * The setting for whether or not time-based immutability is enabled for the LTR backup. When time-based immutability is enabled and locked, the backup cannot be deleted until BackupExpirationTime.
 */
union TimeBasedImmutability {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The time-based immutability mode. Only applicable if time-based immutability is enabled.
 */
union TimeBasedImmutabilityMode {
  string,

  /**
   * Locked
   */
  Locked: "Locked",

  /**
   * Unlocked
   */
  Unlocked: "Unlocked",
}

/**
 * The setting for whether LegalHold is enabled or disabled on the LTR backup. When LegalHold is enabled, the backup cannot be deleted until the LegalHold is removed.
 */
union SetLegalHoldImmutability {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The BackupStorageAccessTier for the LTR backup
 */
union BackupStorageAccessTier {
  string,

  /**
   * Hot
   */
  Hot: "Hot",

  /**
   * Archive
   */
  Archive: "Archive",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union LongTermRetentionPolicyName {
  string,

  /**
   * default
   */
  default: "default",
}

/**
 * Day of maintenance window.
 */
union DayOfWeek {
  string,

  /**
   * Sunday
   */
  Sunday: "Sunday",

  /**
   * Monday
   */
  Monday: "Monday",

  /**
   * Tuesday
   */
  Tuesday: "Tuesday",

  /**
   * Wednesday
   */
  Wednesday: "Wednesday",

  /**
   * Thursday
   */
  Thursday: "Thursday",

  /**
   * Friday
   */
  Friday: "Friday",

  /**
   * Saturday
   */
  Saturday: "Saturday",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ManagedShortTermRetentionPolicyName {
  string,

  /**
   * default
   */
  default: "default",
}

/**
 * Operation mode.
 */
union MoveOperationMode {
  string,

  /**
   * Move
   */
  Move: "Move",

  /**
   * Copy
   */
  Copy: "Copy",
}

/**
 * Interval type (length).
 */
union QueryTimeGrainType {
  string,

  /**
   * PT1H
   */
  PT1H: "PT1H",

  /**
   * P1D
   */
  P1D: "P1D",
}

/**
 * The unit of the metric.
 */
union QueryMetricUnitType {
  string,

  /**
   * percentage
   */
  percentage: "percentage",

  /**
   * KB
   */
  KB: "KB",

  /**
   * microseconds
   */
  microseconds: "microseconds",

  /**
   * count
   */
  count: "count",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union RestoreDetailsName {
  string,

  /**
   * Default
   */
  Default: "Default",
}

/**
 * Status of the database.
 */
union ManagedDatabaseStatus {
  string,

  /**
   * Online
   */
  Online: "Online",

  /**
   * Offline
   */
  Offline: "Offline",

  /**
   * Shutdown
   */
  Shutdown: "Shutdown",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Inaccessible
   */
  Inaccessible: "Inaccessible",

  /**
   * Restoring
   */
  Restoring: "Restoring",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Stopping
   */
  Stopping: "Stopping",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Starting
   */
  Starting: "Starting",

  /**
   * DbMoving
   */
  DbMoving: "DbMoving",

  /**
   * DbCopying
   */
  DbCopying: "DbCopying",
}

/**
 * Managed database create mode. PointInTimeRestore: Create a database by restoring a point in time backup of an existing database. SourceDatabaseName, SourceManagedInstanceName and PointInTime must be specified. RestoreExternalBackup: Create a database by restoring from external backup files. Collation, StorageContainerUri and StorageContainerSasToken must be specified. Recovery: Creates a database by restoring a geo-replicated backup. RecoverableDatabaseId must be specified as the recoverable database resource ID to restore. RestoreLongTermRetentionBackup: Create a database by restoring from a long term retention backup (longTermRetentionBackupResourceId required).
 */
union ManagedDatabaseCreateMode {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * RestoreExternalBackup
   */
  RestoreExternalBackup: "RestoreExternalBackup",

  /**
   * PointInTimeRestore
   */
  PointInTimeRestore: "PointInTimeRestore",

  /**
   * Recovery
   */
  Recovery: "Recovery",

  /**
   * RestoreLongTermRetentionBackup
   */
  RestoreLongTermRetentionBackup: "RestoreLongTermRetentionBackup",
}

/**
 * Root cause kind. Allowed values are “TransparentDataEncryption”, “DatabaseReplication”, and “Unknown”.
 */
union InaccessibilityReason {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * TransparentDataEncryption
   */
  TransparentDataEncryption: "TransparentDataEncryption",

  /**
   * DatabaseReplication
   */
  DatabaseReplication: "DatabaseReplication",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ManagedDatabaseSecurityAlertPolicyName {
  string,

  /**
   * default
   */
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ClientClassificationSource {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Native
   */
  Native: "Native",

  /**
   * Recommended
   */
  Recommended: "Recommended",

  /**
   * MIP
   */
  MIP: "MIP",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union TransparentDataEncryptionName {
  string,

  /**
   * current
   */
  current: "current",
}

/**
 * Type of the managed instance administrator.
 */
union ManagedInstanceAdministratorType {
  string,

  /**
   * ActiveDirectory
   */
  ActiveDirectory: "ActiveDirectory",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AdministratorName {
  string,

  /**
   * ActiveDirectory
   */
  ActiveDirectory: "ActiveDirectory",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AuthenticationName {
  string,

  /**
   * Default
   */
  Default: "Default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DtcName {
  string,

  /**
   * current
   */
  current: "current",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ManagedInstanceLongTermRetentionPolicyName {
  string,

  /**
   * default
   */
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union UpsertManagedServerOperationStepWithEstimatesAndDurationStatus {
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
   * SlowedDown
   */
  SlowedDown: "SlowedDown",

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

/**
 * The identity type. Set this to 'SystemAssigned' in order to automatically create and assign an Azure Active Directory principal for the resource.
 */
union IdentityType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",

  /**
   * SystemAssigned,UserAssigned
   */
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * Specifies the mode of database creation.
 *
 * Default: Regular instance creation.
 *
 * Restore: Creates an instance by restoring a set of backups to specific point in time. RestorePointInTime and SourceManagedInstanceId must be specified.
 */
union ManagedServerCreateMode {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * PointInTimeRestore
   */
  PointInTimeRestore: "PointInTimeRestore",
}

/**
 * The license type. Possible values are 'LicenseIncluded' (regular price inclusive of a new SQL license) and 'BasePrice' (discounted AHB price for bringing your own SQL licenses).
 */
union ManagedInstanceLicenseType {
  string,

  /**
   * LicenseIncluded
   */
  LicenseIncluded: "LicenseIncluded",

  /**
   * BasePrice
   */
  BasePrice: "BasePrice",
}

/**
 * Hybrid secondary usage. Possible values are 'Active' (default value) and 'Passive' (customer uses the secondary as Passive DR).
 */
union HybridSecondaryUsage {
  string,

  /**
   * Active
   */
  Active: "Active",

  /**
   * Passive
   */
  Passive: "Passive",
}

/**
 * Hybrid secondary usage detected. Possible values are 'Active' (customer does not meet the requirements to use the secondary as Passive DR) and 'Passive' (customer meets the requirements to use the secondary as Passive DR).
 */
union HybridSecondaryUsageDetected {
  string,

  /**
   * Active
   */
  Active: "Active",

  /**
   * Passive
   */
  Passive: "Passive",
}

/**
 * Connection type used for connecting to the instance.
 */
union ManagedInstanceProxyOverride {
  string,

  /**
   * Proxy
   */
  Proxy: "Proxy",

  /**
   * Redirect
   */
  Redirect: "Redirect",

  /**
   * Default
   */
  Default: "Default",
}

/**
 * Type of the sever administrator.
 */
union AdministratorType {
  string,

  /**
   * ActiveDirectory
   */
  ActiveDirectory: "ActiveDirectory",
}

/**
 * Principal Type of the sever administrator.
 */
union PrincipalType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Group
   */
  Group: "Group",

  /**
   * Application
   */
  Application: "Application",
}

/**
 * Service principal type.
 */
union ServicePrincipalType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",
}

/**
 * Status of external governance.
 */
union ExternalGovernanceStatus {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Pricing model of Managed Instance.
 */
union PricingModel {
  string,

  /**
   * Regular
   */
  Regular: "Regular",

  /**
   * Freemium
   */
  Freemium: "Freemium",
}

/**
 * The managed instance's authentication metadata lookup mode.
 */
union AuthMetadataLookupModes {
  string,

  /**
   * AzureAD
   */
  AzureAD: "AzureAD",

  /**
   * Paired
   */
  Paired: "Paired",

  /**
   * Windows
   */
  Windows: "Windows",
}

/**
 * Specifies the internal format of instance databases specific to the SQL engine version.
 */
union ManagedInstanceDatabaseFormat {
  string,

  /**
   * AlwaysUpToDate
   */
  AlwaysUpToDate: "AlwaysUpToDate",

  /**
   * SQLServer2022
   */
  SQLServer2022: "SQLServer2022",

  /**
   * SQLServer2025
   */
  SQLServer2025: "SQLServer2025",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AggregationFunctionType {
  string,

  /**
   * avg
   */
  avg: "avg",

  /**
   * min
   */
  min: "min",

  /**
   * max
   */
  max: "max",

  /**
   * stdev
   */
  stdev: "stdev",

  /**
   * sum
   */
  sum: "sum",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union MetricType {
  string,

  /**
   * cpu
   */
  cpu: "cpu",

  /**
   * io
   */
  io: "io",

  /**
   * logIo
   */
  logIo: "logIo",

  /**
   * duration
   */
  duration: "duration",

  /**
   * dtu
   */
  dtu: "dtu",
}

/**
 * Specifies the state of ledger digest upload.
 */
union ManagedLedgerDigestUploadsState {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ManagedLedgerDigestUploadsName {
  string,

  /**
   * current
   */
  current: "current",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ManagedServerSecurityAlertPolicyName {
  string,

  /**
   * Default
   */
  Default: "Default",
}

/**
 * The intended executor of the operation.
 */
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
 * The private link service connection status.
 */
union PrivateLinkServiceConnectionStateStatus {
  string,

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Rejected
   */
  Rejected: "Rejected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",
}

/**
 * The actions required for private link service connection.
 */
union PrivateLinkServiceConnectionStateActionsRequire {
  string,

  /**
   * None
   */
  None: "None",
}

/**
 * State of the private endpoint connection.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union PrivateEndpointProvisioningState {
  string,

  /**
   * Approving
   */
  Approving: "Approving",

  /**
   * Ready
   */
  Ready: "Ready",

  /**
   * Dropping
   */
  Dropping: "Dropping",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Rejecting
   */
  Rejecting: "Rejecting",
}

/**
 * Replication state (PENDING, SEEDING, CATCHUP, SUSPENDED).
 */
union ReplicationState {
  string,

  /**
   * PENDING
   */
  PENDING: "PENDING",

  /**
   * SEEDING
   */
  SEEDING: "SEEDING",

  /**
   * CATCH_UP
   */
  CATCH_UP: "CATCH_UP",

  /**
   * SUSPENDED
   */
  SUSPENDED: "SUSPENDED",
}

/**
 * Link type (GEO, NAMED, STANDBY). Update operation does not support NAMED.
 */
union ReplicationLinkType {
  string,

  /**
   * GEO
   */
  GEO: "GEO",

  /**
   * NAMED
   */
  NAMED: "NAMED",

  /**
   * STANDBY
   */
  STANDBY: "STANDBY",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ServerConfigurationOptionName {
  string,

  /**
   * allowPolybaseExport
   */
  allowPolybaseExport: "allowPolybaseExport",
}

/**
 * The server connection type.
 */
union ServerConnectionType {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * Redirect
   */
  Redirect: "Redirect",

  /**
   * Proxy
   */
  Proxy: "Proxy",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ConnectionPolicyName {
  string,

  /**
   * default
   */
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DevOpsAuditingSettingsName {
  string,

  /**
   * Default
   */
  Default: "Default",
}

/**
 * Minimal TLS version. Allowed values: 'None', 1.0', '1.1', '1.2', '1.3'
 */
union MinimalTlsVersion {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * 1.0
   */
  `1.0`: "1.0",

  /**
   * 1.1
   */
  `1.1`: "1.1",

  /**
   * 1.2
   */
  `1.2`: "1.2",

  /**
   * 1.3
   */
  `1.3`: "1.3",
}

/**
 * Whether or not public endpoint access is allowed for this server.  Value is optional but if passed in, must be 'Enabled' or 'Disabled' or 'SecuredByPerimeter'
 */
union ServerPublicNetworkAccessFlag {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * SecuredByPerimeter
   */
  SecuredByPerimeter: "SecuredByPerimeter",
}

/**
 * Whether or not existing server has a workspace created and if it allows connection from workspace
 */
union ServerWorkspaceFeature {
  string,

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",
}

/**
 * Whether or not to restrict outbound network access for this server.  Value is optional but if passed in, must be 'Enabled' or 'Disabled'
 */
union ServerNetworkAccessFlag {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Create mode for server, only valid values for this are Normal and Restore.
 */
union ServerCreateMode {
  string,

  /**
   * Normal
   */
  Normal: "Normal",

  /**
   * Restore
   */
  Restore: "Restore",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SecurityAlertPolicyName {
  string,

  /**
   * Default
   */
  Default: "Default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ServerTrustGroupPropertiesTrustScopesItem {
  string,

  /**
   * GlobalTransactions
   */
  GlobalTransactions: "GlobalTransactions",

  /**
   * ServiceBroker
   */
  ServiceBroker: "ServiceBroker",
}

/**
 * The state of Sql Agent.
 */
union SqlAgentConfigurationPropertiesState {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union StartStopScheduleName {
  string,

  /**
   * default
   */
  default: "default",
}

/**
 * State of the sync agent.
 */
union SyncAgentState {
  string,

  /**
   * Online
   */
  Online: "Online",

  /**
   * Offline
   */
  Offline: "Offline",

  /**
   * NeverConnected
   */
  NeverConnected: "NeverConnected",
}

/**
 * Type of the sync agent linked database.
 */
union SyncMemberDbType {
  string,

  /**
   * AzureSqlDatabase
   */
  AzureSqlDatabase: "AzureSqlDatabase",

  /**
   * SqlServerDatabase
   */
  SqlServerDatabase: "SqlServerDatabase",
}

/**
 * Conflict resolution policy of the sync group.
 */
union SyncConflictResolutionPolicy {
  string,

  /**
   * HubWin
   */
  HubWin: "HubWin",

  /**
   * MemberWin
   */
  MemberWin: "MemberWin",
}

/**
 * Sync state of the sync group.
 */
union SyncGroupState {
  string,

  /**
   * NotReady
   */
  NotReady: "NotReady",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Progressing
   */
  Progressing: "Progressing",

  /**
   * Good
   */
  Good: "Good",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SyncGroupsType {
  string,

  /**
   * All
   */
  All: "All",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Success
   */
  Success: "Success",
}

/**
 * Type of the sync group log.
 */
union SyncGroupLogType {
  string,

  /**
   * All
   */
  All: "All",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Success
   */
  Success: "Success",
}

/**
 * Sync direction of the sync member.
 */
union SyncDirection {
  string,

  /**
   * Bidirectional
   */
  Bidirectional: "Bidirectional",

  /**
   * OneWayMemberToHub
   */
  OneWayMemberToHub: "OneWayMemberToHub",

  /**
   * OneWayHubToMember
   */
  OneWayHubToMember: "OneWayHubToMember",
}

/**
 * The masking function that is used for the data masking rule.
 */
union DataMaskingFunction {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * CCN
   */
  CCN: "CCN",

  /**
   * Email
   */
  Email: "Email",

  /**
   * Number
   */
  Number: "Number",

  /**
   * SSN
   */
  SSN: "SSN",

  /**
   * Text
   */
  Text: "Text",
}

/**
 * Sync state of the sync member.
 */
union SyncMemberState {
  string,

  /**
   * SyncInProgress
   */
  SyncInProgress: "SyncInProgress",

  /**
   * SyncSucceeded
   */
  SyncSucceeded: "SyncSucceeded",

  /**
   * SyncFailed
   */
  SyncFailed: "SyncFailed",

  /**
   * DisabledTombstoneCleanup
   */
  DisabledTombstoneCleanup: "DisabledTombstoneCleanup",

  /**
   * DisabledBackupRestore
   */
  DisabledBackupRestore: "DisabledBackupRestore",

  /**
   * SyncSucceededWithWarnings
   */
  SyncSucceededWithWarnings: "SyncSucceededWithWarnings",

  /**
   * SyncCancelling
   */
  SyncCancelling: "SyncCancelling",

  /**
   * SyncCancelled
   */
  SyncCancelled: "SyncCancelled",

  /**
   * UnProvisioned
   */
  UnProvisioned: "UnProvisioned",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Provisioned
   */
  Provisioned: "Provisioned",

  /**
   * ProvisionFailed
   */
  ProvisionFailed: "ProvisionFailed",

  /**
   * DeProvisioning
   */
  DeProvisioning: "DeProvisioning",

  /**
   * DeProvisioned
   */
  DeProvisioned: "DeProvisioned",

  /**
   * DeProvisionFailed
   */
  DeProvisionFailed: "DeProvisionFailed",

  /**
   * Reprovisioning
   */
  Reprovisioning: "Reprovisioning",

  /**
   * ReprovisionFailed
   */
  ReprovisionFailed: "ReprovisionFailed",

  /**
   * UnReprovisioned
   */
  UnReprovisioned: "UnReprovisioned",
}

/**
 * Specifies the encryption scan state of the transparent data encryption.
 */
union TransparentDataEncryptionScanState {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Resume
   */
  Resume: "Resume",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Suspend
   */
  Suspend: "Suspend",

  /**
   * Aborted
   */
  Aborted: "Aborted",

  /**
   * Completed
   */
  Completed: "Completed",
}

/**
 * The status of the DNS refresh operation.
 */
union DNSRefreshOperationStatus {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * InProgress
   */
  InProgress: "InProgress",
}

/**
 * Virtual Network Rule State
 */
union VirtualNetworkRuleState {
  string,

  /**
   * Initializing
   */
  Initializing: "Initializing",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Ready
   */
  Ready: "Ready",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * The rule state. Used to delete a rule. To delete an existing rule, specify the schemaName, tableName, columnName, maskingFunction, and specify ruleState as disabled. However, if the rule doesn't already exist, the rule will be created with ruleState set to enabled, regardless of the provided value of ruleState.
 */
union DataMaskingRuleState {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum BlobAuditingPolicyState {
  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabled
   */
  Disabled,
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CheckNameAvailabilityResourceType {
  /**
   * Microsoft.Sql/servers
   */
  `Microsoft.Sql/servers`,
}

/**
 * Specifies the state of the Advanced Threat Protection, whether it is enabled or disabled or a state has not been applied yet on the specific database or server.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AdvancedThreatProtectionState {
  /**
   * New
   */
  New,

  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabled
   */
  Disabled,
}

/**
 * Gets the status of availability of this advisor to customers. Possible values are 'GA', 'PublicPreview', 'LimitedPublicPreview' and 'PrivatePreview'.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AdvisorStatus {
  /**
   * GA
   */
  GA,

  /**
   * PublicPreview
   */
  PublicPreview,

  /**
   * LimitedPublicPreview
   */
  LimitedPublicPreview,

  /**
   * PrivatePreview
   */
  PrivatePreview,
}

/**
 * Gets the auto-execute status (whether to let the system execute the recommendations) of this advisor. Possible values are 'Enabled' and 'Disabled'
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AutoExecuteStatus {
  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabled
   */
  Disabled,

  /**
   * Default
   */
  Default,
}

/**
 * Gets the resource from which current value of auto-execute status is inherited. Auto-execute status can be set on (and inherited from) different levels in the resource hierarchy. Possible values are 'Subscription', 'Server', 'ElasticPool', 'Database' and 'Default' (when status is not explicitly set on any level).
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AutoExecuteStatusInheritedFrom {
  /**
   * Default
   */
  Default,

  /**
   * Subscription
   */
  Subscription,

  /**
   * Server
   */
  Server,

  /**
   * ElasticPool
   */
  ElasticPool,

  /**
   * Database
   */
  Database,
}

/**
 * Gets if approval for applying this recommended action was given by user/system.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RecommendedActionInitiatedBy {
  /**
   * User
   */
  User,

  /**
   * System
   */
  System,
}

/**
 * Gets the method in which this recommended action can be manually implemented. e.g., TSql, AzurePowerShell.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ImplementationMethod {
  /**
   * TSql
   */
  TSql,

  /**
   * AzurePowerShell
   */
  AzurePowerShell,
}

/**
 * Gets whether the error could be ignored and recommended action could be retried. Possible values are: Yes/No
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum IsRetryable {
  /**
   * Yes
   */
  Yes,

  /**
   * No
   */
  No,
}

/**
 * Automatic tuning desired state.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AutomaticTuningMode {
  /**
   * Inherit
   */
  Inherit,

  /**
   * Custom
   */
  Custom,

  /**
   * Auto
   */
  Auto,

  /**
   * Unspecified
   */
  Unspecified,
}

/**
 * Automatic tuning option desired state.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AutomaticTuningOptionModeDesired {
  /**
   * Off
   */
  Off,

  /**
   * On
   */
  On,

  /**
   * Default
   */
  Default,
}

/**
 * Automatic tuning option actual state.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AutomaticTuningOptionModeActual {
  /**
   * Off
   */
  Off,

  /**
   * On
   */
  On,
}

/**
 * Reason description if desired and actual state are different.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AutomaticTuningDisabledReason {
  /**
   * Default
   */
  Default,

  /**
   * Disabled
   */
  Disabled,

  /**
   * AutoConfigured
   */
  AutoConfigured,

  /**
   * InheritedFromServer
   */
  InheritedFromServer,

  /**
   * QueryStoreOff
   */
  QueryStoreOff,

  /**
   * QueryStoreReadOnly
   */
  QueryStoreReadOnly,

  /**
   * NotSupported
   */
  NotSupported,
}

/**
 * Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific database.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SecurityAlertsPolicyState {
  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabled
   */
  Disabled,
}

/**
 * Specifies the state of the SQL Vulnerability Assessment, whether it is enabled or disabled or a state has not been applied yet on the specific database or server.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SqlVulnerabilityAssessmentState {
  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabled
   */
  Disabled,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum VulnerabilityAssessmentPolicyBaselineName {
  /**
   * master
   */
  master,

  /**
   * default
   */
  default,
}

/**
 * The state of the data masking policy.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DataMaskingState {
  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabled
   */
  Disabled,
}

/**
 * The state of the geo backup policy.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum GeoBackupPolicyState {
  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabled
   */
  Disabled,
}

/**
 * Schedule interval type
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum JobScheduleType {
  /**
   * Once
   */
  Once,

  /**
   * Recurring
   */
  Recurring,
}

/**
 * Whether the target is included or excluded from the group.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum JobTargetGroupMembershipType {
  /**
   * Include
   */
  Include,

  /**
   * Exclude
   */
  Exclude,
}

/**
 * Specifies the state of ledger digest upload.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum LedgerDigestUploadsState {
  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabled
   */
  Disabled,
}

/**
 * The status of the capability.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CapabilityStatus {
  /**
   * Visible
   */
  Visible,

  /**
   * Available
   */
  Available,

  /**
   * Default
   */
  Default,

  /**
   * Disabled
   */
  Disabled,
}

/**
 * Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific database.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SecurityAlertPolicyState {
  /**
   * New
   */
  New,

  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabled
   */
  Disabled,
}

/**
 * The type of the security event.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SecurityEventType {
  /**
   * Undefined
   */
  Undefined,

  /**
   * SqlInjectionVulnerability
   */
  SqlInjectionVulnerability,

  /**
   * SqlInjectionExploit
   */
  SqlInjectionExploit,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SensitivityLabelRank {
  /**
   * None
   */
  None,

  /**
   * Low
   */
  Low,

  /**
   * Medium
   */
  Medium,

  /**
   * High
   */
  High,

  /**
   * Critical
   */
  Critical,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SensitivityLabelUpdateKind {
  /**
   * set
   */
  set,

  /**
   * remove
   */
  remove,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RecommendedSensitivityLabelUpdateKind {
  /**
   * enable
   */
  enable,

  /**
   * disable
   */
  disable,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SensitivityLabelSource {
  /**
   * current
   */
  current,

  /**
   * recommended
   */
  recommended,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CurrentSensitivityLabelSource {
  /**
   * current
   */
  current,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RecommendedSensitivityLabelSource {
  /**
   * recommended
   */
  recommended,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum BlobAuditingPolicyName {
  /**
   * default
   */
  default,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum VulnerabilityAssessmentSystemDatabaseName {
  /**
   * master
   */
  master,
}

/**
 * Specifies the state of the transparent data encryption.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum TransparentDataEncryptionState {
  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabled
   */
  Disabled,
}

/**
 * Local replication role.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ReplicationRole {
  /**
   * Primary
   */
  Primary,

  /**
   * Secondary
   */
  Secondary,

  /**
   * NonReadableSecondary
   */
  NonReadableSecondary,

  /**
   * Source
   */
  Source,

  /**
   * Copy
   */
  Copy,
}

/**
 * The type of restore point
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RestorePointType {
  /**
   * CONTINUOUS
   */
  CONTINUOUS,

  /**
   * DISCRETE
   */
  DISCRETE,
}

/**
 * Automatic tuning desired state.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AutomaticTuningServerMode {
  /**
   * Custom
   */
  Custom,

  /**
   * Auto
   */
  Auto,

  /**
   * Unspecified
   */
  Unspecified,
}

/**
 * Reason description if desired and actual state are different.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AutomaticTuningServerReason {
  /**
   * Default
   */
  Default,

  /**
   * Disabled
   */
  Disabled,

  /**
   * AutoConfigured
   */
  AutoConfigured,
}

/**
 * The reason code explaining why the name is unavailable. Will be undefined if the name is available.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CheckNameAvailabilityReason {
  /**
   * Invalid
   */
  Invalid,

  /**
   * AlreadyExists
   */
  AlreadyExists,
}

/**
 * Properties of a short term retention policy
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupShortTermRetentionPolicyProperties {
  /**
   * The backup retention period in days. This is how many days Point-in-Time Restore will be supported.
   */
  retentionDays?: int32;

  /**
   * The differential backup interval in hours. This is how many interval hours between each differential backup will be supported. This is only applicable to live databases but not dropped databases.
   */
  diffBackupIntervalInHours?: DiffBackupIntervalInHours;
}

/**
 * Properties of a server blob auditing policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerBlobAuditingPolicyProperties {
  /**
   * Specifies the state of devops audit. If state is Enabled, devops logs will be sent to Azure Monitor.
   * In order to send the events to Azure Monitor, specify 'State' as 'Enabled', 'IsAzureMonitorTargetEnabled' as true and 'IsDevopsAuditEnabled' as true
   *
   * When using REST API to configure auditing, Diagnostic Settings with 'DevOpsOperationsAudit' diagnostic logs category on the master database should also be created.
   *
   * Diagnostic Settings URI format:
   * PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/master/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview
   *
   * For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
   * or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)
   *
   */
  isDevopsAuditEnabled?: boolean;

  /**
   * Specifies the number of days to keep in the audit logs in the storage account.
   */
  retentionDays?: int32;

  /**
   * Specifies the Actions-Groups and Actions to audit.
   *
   * The recommended set of action groups to use is the following combination - this will audit all the queries and stored procedures executed against the database, as well as successful and failed logins:
   *
   * BATCH_COMPLETED_GROUP,
   * SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP,
   * FAILED_DATABASE_AUTHENTICATION_GROUP.
   *
   * This above combination is also the set that is configured by default when enabling auditing from the Azure portal.
   *
   * The supported action groups to audit are (note: choose only specific groups that cover your auditing needs. Using unnecessary groups could lead to very large quantities of audit records):
   *
   * APPLICATION_ROLE_CHANGE_PASSWORD_GROUP
   * BACKUP_RESTORE_GROUP
   * DATABASE_LOGOUT_GROUP
   * DATABASE_OBJECT_CHANGE_GROUP
   * DATABASE_OBJECT_OWNERSHIP_CHANGE_GROUP
   * DATABASE_OBJECT_PERMISSION_CHANGE_GROUP
   * DATABASE_OPERATION_GROUP
   * DATABASE_PERMISSION_CHANGE_GROUP
   * DATABASE_PRINCIPAL_CHANGE_GROUP
   * DATABASE_PRINCIPAL_IMPERSONATION_GROUP
   * DATABASE_ROLE_MEMBER_CHANGE_GROUP
   * FAILED_DATABASE_AUTHENTICATION_GROUP
   * SCHEMA_OBJECT_ACCESS_GROUP
   * SCHEMA_OBJECT_CHANGE_GROUP
   * SCHEMA_OBJECT_OWNERSHIP_CHANGE_GROUP
   * SCHEMA_OBJECT_PERMISSION_CHANGE_GROUP
   * SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP
   * USER_CHANGE_PASSWORD_GROUP
   * BATCH_STARTED_GROUP
   * BATCH_COMPLETED_GROUP
   * DBCC_GROUP
   * DATABASE_OWNERSHIP_CHANGE_GROUP
   * DATABASE_CHANGE_GROUP
   * LEDGER_OPERATION_GROUP
   *
   * These are groups that cover all sql statements and stored procedures executed against the database, and should not be used in combination with other groups as this will result in duplicate audit logs.
   *
   * For more information, see [Database-Level Audit Action Groups](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-action-groups).
   *
   * For Database auditing policy, specific Actions can also be specified (note that Actions cannot be specified for Server auditing policy). The supported actions to audit are:
   * SELECT
   * UPDATE
   * INSERT
   * DELETE
   * EXECUTE
   * RECEIVE
   * REFERENCES
   *
   * The general form for defining an action to be audited is:
   * {action} ON {object} BY {principal}
   *
   * Note that <object> in the above format can refer to an object like a table, view, or stored procedure, or an entire database or schema. For the latter cases, the forms DATABASE::{db_name} and SCHEMA::{schema_name} are used, respectively.
   *
   * For example:
   * SELECT on dbo.myTable by public
   * SELECT on DATABASE::myDatabase by public
   * SELECT on SCHEMA::mySchema by public
   *
   * For more information, see [Database-Level Audit Actions](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-actions)
   */
  auditActionsAndGroups?: string[];

  /**
   * Specifies whether storageAccountAccessKey value is the storage's secondary key.
   */
  isStorageSecondaryKeyInUse?: boolean;

  /**
   * Specifies whether audit events are sent to Azure Monitor.
   * In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.
   *
   * When using REST API to configure auditing, Diagnostic Settings with 'SQLSecurityAuditEvents' diagnostic logs category on the database should be also created.
   * Note that for server level audit you should use the 'master' database as {databaseName}.
   *
   * Diagnostic Settings URI format:
   * PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview
   *
   * For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
   * or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)
   *
   */
  isAzureMonitorTargetEnabled?: boolean;

  /**
   * Specifies the amount of time in milliseconds that can elapse before audit actions are forced to be processed.
   * The default minimum value is 1000 (1 second). The maximum is 2,147,483,647.
   */
  queueDelayMs?: int32;

  /**
   * Specifies whether Managed Identity is used to access blob storage
   */
  isManagedIdentityInUse?: boolean;

  /**
   * Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
   */
  state: BlobAuditingPolicyState;

  /**
   * Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.
   */
  storageEndpoint?: string;

  /**
   * Specifies the identifier key of the auditing storage account.
   * If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
   * Prerequisites for using managed identity authentication:
   * 1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
   * 2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
   * For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  storageAccountAccessKey?: string;

  /**
   * Specifies the blob storage subscription Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageAccountSubscriptionId?: Azure.Core.uuid;
}

/**
 * Properties of a database blob auditing policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseBlobAuditingPolicyProperties {
  /**
   * Specifies the number of days to keep in the audit logs in the storage account.
   */
  retentionDays?: int32;

  /**
   * Specifies the Actions-Groups and Actions to audit.
   *
   * The recommended set of action groups to use is the following combination - this will audit all the queries and stored procedures executed against the database, as well as successful and failed logins:
   *
   * BATCH_COMPLETED_GROUP,
   * SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP,
   * FAILED_DATABASE_AUTHENTICATION_GROUP.
   *
   * This above combination is also the set that is configured by default when enabling auditing from the Azure portal.
   *
   * The supported action groups to audit are (note: choose only specific groups that cover your auditing needs. Using unnecessary groups could lead to very large quantities of audit records):
   *
   * APPLICATION_ROLE_CHANGE_PASSWORD_GROUP
   * BACKUP_RESTORE_GROUP
   * DATABASE_LOGOUT_GROUP
   * DATABASE_OBJECT_CHANGE_GROUP
   * DATABASE_OBJECT_OWNERSHIP_CHANGE_GROUP
   * DATABASE_OBJECT_PERMISSION_CHANGE_GROUP
   * DATABASE_OPERATION_GROUP
   * DATABASE_PERMISSION_CHANGE_GROUP
   * DATABASE_PRINCIPAL_CHANGE_GROUP
   * DATABASE_PRINCIPAL_IMPERSONATION_GROUP
   * DATABASE_ROLE_MEMBER_CHANGE_GROUP
   * FAILED_DATABASE_AUTHENTICATION_GROUP
   * SCHEMA_OBJECT_ACCESS_GROUP
   * SCHEMA_OBJECT_CHANGE_GROUP
   * SCHEMA_OBJECT_OWNERSHIP_CHANGE_GROUP
   * SCHEMA_OBJECT_PERMISSION_CHANGE_GROUP
   * SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP
   * USER_CHANGE_PASSWORD_GROUP
   * BATCH_STARTED_GROUP
   * BATCH_COMPLETED_GROUP
   * DBCC_GROUP
   * DATABASE_OWNERSHIP_CHANGE_GROUP
   * DATABASE_CHANGE_GROUP
   * LEDGER_OPERATION_GROUP
   *
   * These are groups that cover all sql statements and stored procedures executed against the database, and should not be used in combination with other groups as this will result in duplicate audit logs.
   *
   * For more information, see [Database-Level Audit Action Groups](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-action-groups).
   *
   * For Database auditing policy, specific Actions can also be specified (note that Actions cannot be specified for Server auditing policy). The supported actions to audit are:
   * SELECT
   * UPDATE
   * INSERT
   * DELETE
   * EXECUTE
   * RECEIVE
   * REFERENCES
   *
   * The general form for defining an action to be audited is:
   * {action} ON {object} BY {principal}
   *
   * Note that <object> in the above format can refer to an object like a table, view, or stored procedure, or an entire database or schema. For the latter cases, the forms DATABASE::{db_name} and SCHEMA::{schema_name} are used, respectively.
   *
   * For example:
   * SELECT on dbo.myTable by public
   * SELECT on DATABASE::myDatabase by public
   * SELECT on SCHEMA::mySchema by public
   *
   * For more information, see [Database-Level Audit Actions](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-actions)
   */
  auditActionsAndGroups?: string[];

  /**
   * Specifies whether storageAccountAccessKey value is the storage's secondary key.
   */
  isStorageSecondaryKeyInUse?: boolean;

  /**
   * Specifies whether audit events are sent to Azure Monitor.
   * In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.
   *
   * When using REST API to configure auditing, Diagnostic Settings with 'SQLSecurityAuditEvents' diagnostic logs category on the database should be also created.
   * Note that for server level audit you should use the 'master' database as {databaseName}.
   *
   * Diagnostic Settings URI format:
   * PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview
   *
   * For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
   * or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)
   *
   */
  isAzureMonitorTargetEnabled?: boolean;

  /**
   * Specifies the amount of time in milliseconds that can elapse before audit actions are forced to be processed.
   * The default minimum value is 1000 (1 second). The maximum is 2,147,483,647.
   */
  queueDelayMs?: int32;

  /**
   * Specifies whether Managed Identity is used to access blob storage
   */
  isManagedIdentityInUse?: boolean;

  /**
   * Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
   */
  state: BlobAuditingPolicyState;

  /**
   * Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.
   */
  storageEndpoint?: string;

  /**
   * Specifies the identifier key of the auditing storage account.
   * If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
   * Prerequisites for using managed identity authentication:
   * 1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
   * 2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
   * For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  storageAccountAccessKey?: string;

  /**
   * Specifies the blob storage subscription Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageAccountSubscriptionId?: Azure.Core.uuid;
}

/**
 * Properties of an extended database blob auditing policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExtendedDatabaseBlobAuditingPolicyProperties {
  /**
   * Specifies condition of where clause when creating an audit.
   */
  predicateExpression?: string;

  /**
   * Specifies the number of days to keep in the audit logs in the storage account.
   */
  retentionDays?: int32;

  /**
   * Specifies the Actions-Groups and Actions to audit.
   *
   * The recommended set of action groups to use is the following combination - this will audit all the queries and stored procedures executed against the database, as well as successful and failed logins:
   *
   * BATCH_COMPLETED_GROUP,
   * SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP,
   * FAILED_DATABASE_AUTHENTICATION_GROUP.
   *
   * This above combination is also the set that is configured by default when enabling auditing from the Azure portal.
   *
   * The supported action groups to audit are (note: choose only specific groups that cover your auditing needs. Using unnecessary groups could lead to very large quantities of audit records):
   *
   * APPLICATION_ROLE_CHANGE_PASSWORD_GROUP
   * BACKUP_RESTORE_GROUP
   * DATABASE_LOGOUT_GROUP
   * DATABASE_OBJECT_CHANGE_GROUP
   * DATABASE_OBJECT_OWNERSHIP_CHANGE_GROUP
   * DATABASE_OBJECT_PERMISSION_CHANGE_GROUP
   * DATABASE_OPERATION_GROUP
   * DATABASE_PERMISSION_CHANGE_GROUP
   * DATABASE_PRINCIPAL_CHANGE_GROUP
   * DATABASE_PRINCIPAL_IMPERSONATION_GROUP
   * DATABASE_ROLE_MEMBER_CHANGE_GROUP
   * FAILED_DATABASE_AUTHENTICATION_GROUP
   * SCHEMA_OBJECT_ACCESS_GROUP
   * SCHEMA_OBJECT_CHANGE_GROUP
   * SCHEMA_OBJECT_OWNERSHIP_CHANGE_GROUP
   * SCHEMA_OBJECT_PERMISSION_CHANGE_GROUP
   * SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP
   * USER_CHANGE_PASSWORD_GROUP
   * BATCH_STARTED_GROUP
   * BATCH_COMPLETED_GROUP
   * DBCC_GROUP
   * DATABASE_OWNERSHIP_CHANGE_GROUP
   * DATABASE_CHANGE_GROUP
   * LEDGER_OPERATION_GROUP
   *
   * These are groups that cover all sql statements and stored procedures executed against the database, and should not be used in combination with other groups as this will result in duplicate audit logs.
   *
   * For more information, see [Database-Level Audit Action Groups](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-action-groups).
   *
   * For Database auditing policy, specific Actions can also be specified (note that Actions cannot be specified for Server auditing policy). The supported actions to audit are:
   * SELECT
   * UPDATE
   * INSERT
   * DELETE
   * EXECUTE
   * RECEIVE
   * REFERENCES
   *
   * The general form for defining an action to be audited is:
   * {action} ON {object} BY {principal}
   *
   * Note that <object> in the above format can refer to an object like a table, view, or stored procedure, or an entire database or schema. For the latter cases, the forms DATABASE::{db_name} and SCHEMA::{schema_name} are used, respectively.
   *
   * For example:
   * SELECT on dbo.myTable by public
   * SELECT on DATABASE::myDatabase by public
   * SELECT on SCHEMA::mySchema by public
   *
   * For more information, see [Database-Level Audit Actions](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-actions)
   */
  auditActionsAndGroups?: string[];

  /**
   * Specifies whether storageAccountAccessKey value is the storage's secondary key.
   */
  isStorageSecondaryKeyInUse?: boolean;

  /**
   * Specifies whether audit events are sent to Azure Monitor.
   * In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.
   *
   * When using REST API to configure auditing, Diagnostic Settings with 'SQLSecurityAuditEvents' diagnostic logs category on the database should be also created.
   * Note that for server level audit you should use the 'master' database as {databaseName}.
   *
   * Diagnostic Settings URI format:
   * PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview
   *
   * For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
   * or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)
   *
   */
  isAzureMonitorTargetEnabled?: boolean;

  /**
   * Specifies the amount of time in milliseconds that can elapse before audit actions are forced to be processed.
   * The default minimum value is 1000 (1 second). The maximum is 2,147,483,647.
   */
  queueDelayMs?: int32;

  /**
   * Specifies whether Managed Identity is used to access blob storage
   */
  isManagedIdentityInUse?: boolean;

  /**
   * Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
   */
  state: BlobAuditingPolicyState;

  /**
   * Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.
   */
  storageEndpoint?: string;

  /**
   * Specifies the identifier key of the auditing storage account.
   * If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
   * Prerequisites for using managed identity authentication:
   * 1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
   * 2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
   * For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  storageAccountAccessKey?: string;

  /**
   * Specifies the blob storage subscription Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageAccountSubscriptionId?: Azure.Core.uuid;
}

/**
 * Properties of an extended server blob auditing policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExtendedServerBlobAuditingPolicyProperties {
  /**
   * Specifies the state of devops audit. If state is Enabled, devops logs will be sent to Azure Monitor.
   * In order to send the events to Azure Monitor, specify 'State' as 'Enabled', 'IsAzureMonitorTargetEnabled' as true and 'IsDevopsAuditEnabled' as true
   *
   * When using REST API to configure auditing, Diagnostic Settings with 'DevOpsOperationsAudit' diagnostic logs category on the master database should also be created.
   *
   * Diagnostic Settings URI format:
   * PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/master/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview
   *
   * For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
   * or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)
   *
   */
  isDevopsAuditEnabled?: boolean;

  /**
   * Specifies condition of where clause when creating an audit.
   */
  predicateExpression?: string;

  /**
   * Specifies the number of days to keep in the audit logs in the storage account.
   */
  retentionDays?: int32;

  /**
   * Specifies the Actions-Groups and Actions to audit.
   *
   * The recommended set of action groups to use is the following combination - this will audit all the queries and stored procedures executed against the database, as well as successful and failed logins:
   *
   * BATCH_COMPLETED_GROUP,
   * SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP,
   * FAILED_DATABASE_AUTHENTICATION_GROUP.
   *
   * This above combination is also the set that is configured by default when enabling auditing from the Azure portal.
   *
   * The supported action groups to audit are (note: choose only specific groups that cover your auditing needs. Using unnecessary groups could lead to very large quantities of audit records):
   *
   * APPLICATION_ROLE_CHANGE_PASSWORD_GROUP
   * BACKUP_RESTORE_GROUP
   * DATABASE_LOGOUT_GROUP
   * DATABASE_OBJECT_CHANGE_GROUP
   * DATABASE_OBJECT_OWNERSHIP_CHANGE_GROUP
   * DATABASE_OBJECT_PERMISSION_CHANGE_GROUP
   * DATABASE_OPERATION_GROUP
   * DATABASE_PERMISSION_CHANGE_GROUP
   * DATABASE_PRINCIPAL_CHANGE_GROUP
   * DATABASE_PRINCIPAL_IMPERSONATION_GROUP
   * DATABASE_ROLE_MEMBER_CHANGE_GROUP
   * FAILED_DATABASE_AUTHENTICATION_GROUP
   * SCHEMA_OBJECT_ACCESS_GROUP
   * SCHEMA_OBJECT_CHANGE_GROUP
   * SCHEMA_OBJECT_OWNERSHIP_CHANGE_GROUP
   * SCHEMA_OBJECT_PERMISSION_CHANGE_GROUP
   * SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP
   * USER_CHANGE_PASSWORD_GROUP
   * BATCH_STARTED_GROUP
   * BATCH_COMPLETED_GROUP
   * DBCC_GROUP
   * DATABASE_OWNERSHIP_CHANGE_GROUP
   * DATABASE_CHANGE_GROUP
   * LEDGER_OPERATION_GROUP
   *
   * These are groups that cover all sql statements and stored procedures executed against the database, and should not be used in combination with other groups as this will result in duplicate audit logs.
   *
   * For more information, see [Database-Level Audit Action Groups](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-action-groups).
   *
   * For Database auditing policy, specific Actions can also be specified (note that Actions cannot be specified for Server auditing policy). The supported actions to audit are:
   * SELECT
   * UPDATE
   * INSERT
   * DELETE
   * EXECUTE
   * RECEIVE
   * REFERENCES
   *
   * The general form for defining an action to be audited is:
   * {action} ON {object} BY {principal}
   *
   * Note that <object> in the above format can refer to an object like a table, view, or stored procedure, or an entire database or schema. For the latter cases, the forms DATABASE::{db_name} and SCHEMA::{schema_name} are used, respectively.
   *
   * For example:
   * SELECT on dbo.myTable by public
   * SELECT on DATABASE::myDatabase by public
   * SELECT on SCHEMA::mySchema by public
   *
   * For more information, see [Database-Level Audit Actions](https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions#database-level-audit-actions)
   */
  auditActionsAndGroups?: string[];

  /**
   * Specifies whether storageAccountAccessKey value is the storage's secondary key.
   */
  isStorageSecondaryKeyInUse?: boolean;

  /**
   * Specifies whether audit events are sent to Azure Monitor.
   * In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.
   *
   * When using REST API to configure auditing, Diagnostic Settings with 'SQLSecurityAuditEvents' diagnostic logs category on the database should be also created.
   * Note that for server level audit you should use the 'master' database as {databaseName}.
   *
   * Diagnostic Settings URI format:
   * PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview
   *
   * For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
   * or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)
   *
   */
  isAzureMonitorTargetEnabled?: boolean;

  /**
   * Specifies the amount of time in milliseconds that can elapse before audit actions are forced to be processed.
   * The default minimum value is 1000 (1 second). The maximum is 2,147,483,647.
   */
  queueDelayMs?: int32;

  /**
   * Specifies whether Managed Identity is used to access blob storage
   */
  isManagedIdentityInUse?: boolean;

  /**
   * Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
   */
  state: BlobAuditingPolicyState;

  /**
   * Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.
   */
  storageEndpoint?: string;

  /**
   * Specifies the identifier key of the auditing storage account.
   * If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
   * Prerequisites for using managed identity authentication:
   * 1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
   * 2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
   * For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
   */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageAccountAccessKey?: string;

  /**
   * Specifies the blob storage subscription Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageAccountSubscriptionId?: Azure.Core.uuid;
}

/**
 * Properties of an Advanced Threat Protection state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AdvancedThreatProtectionProperties {
  /**
   * Specifies the state of the Advanced Threat Protection, whether it is enabled or disabled or a state has not been applied yet on the specific database or server.
   */
  state: AdvancedThreatProtectionState;

  /**
   * Specifies the UTC creation time of the policy.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

/**
 * Properties for a Database, Server or Elastic Pool Advisor.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AdvisorProperties {
  /**
   * Gets the status of availability of this advisor to customers. Possible values are 'GA', 'PublicPreview', 'LimitedPublicPreview' and 'PrivatePreview'.
   */
  @visibility(Lifecycle.Read)
  advisorStatus?: AdvisorStatus;

  /**
   * Gets the auto-execute status (whether to let the system execute the recommendations) of this advisor. Possible values are 'Enabled' and 'Disabled'
   */
  autoExecuteStatus: AutoExecuteStatus;

  /**
   * Gets the resource from which current value of auto-execute status is inherited. Auto-execute status can be set on (and inherited from) different levels in the resource hierarchy. Possible values are 'Subscription', 'Server', 'ElasticPool', 'Database' and 'Default' (when status is not explicitly set on any level).
   */
  @visibility(Lifecycle.Read)
  autoExecuteStatusInheritedFrom?: AutoExecuteStatusInheritedFrom;

  /**
   * Gets that status of recommendations for this advisor and reason for not having any recommendations. Possible values include, but are not limited to, 'Ok' (Recommendations available),LowActivity (not enough workload to analyze), 'DbSeemsTuned' (Database is doing well), etc.
   */
  @visibility(Lifecycle.Read)
  recommendationsStatus?: string;

  /**
   * Gets the time when the current resource was analyzed for recommendations by this advisor.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastChecked?: utcDateTime;

  /**
   * Gets the recommended actions for this advisor.
   */
  @visibility(Lifecycle.Read)
  recommendedActions?: RecommendedAction[];
}

/**
 * Properties for a Database, Server or Elastic Pool Recommended Action.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecommendedActionProperties {
  /**
   * Gets the reason for recommending this action. e.g., DuplicateIndex
   */
  @visibility(Lifecycle.Read)
  recommendationReason?: string;

  /**
   * Gets the time since when this recommended action is valid.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validSince?: utcDateTime;

  /**
   * Gets time when this recommended action was last refreshed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRefresh?: utcDateTime;

  /**
   * Gets the info of the current state the recommended action is in.
   */
  state: RecommendedActionStateInfo;

  /**
   * Gets if this recommended action is actionable by user
   */
  @visibility(Lifecycle.Read)
  isExecutableAction?: boolean;

  /**
   * Gets if changes applied by this recommended action can be reverted by user
   */
  @visibility(Lifecycle.Read)
  isRevertableAction?: boolean;

  /**
   * Gets if this recommended action was suggested some time ago but user chose to ignore this and system added a new recommended action again.
   */
  @visibility(Lifecycle.Read)
  isArchivedAction?: boolean;

  /**
   * Gets the time when system started applying this recommended action on the user resource. e.g., index creation start time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  executeActionStartTime?: utcDateTime;

  /**
   * Gets the time taken for applying this recommended action on user resource. e.g., time taken for index creation
   */
  @visibility(Lifecycle.Read)
  executeActionDuration?: duration;

  /**
   * Gets the time when system started reverting changes of this recommended action on user resource. e.g., time when index drop is executed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  revertActionStartTime?: utcDateTime;

  /**
   * Gets the time taken for reverting changes of this recommended action on user resource. e.g., time taken for dropping the created index.
   */
  @visibility(Lifecycle.Read)
  revertActionDuration?: duration;

  /**
   * Gets if approval for applying this recommended action was given by user/system.
   */
  @visibility(Lifecycle.Read)
  executeActionInitiatedBy?: RecommendedActionInitiatedBy;

  /**
   * Gets the time when this recommended action was approved for execution.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  executeActionInitiatedTime?: utcDateTime;

  /**
   * Gets if approval for reverting this recommended action was given by user/system.
   */
  @visibility(Lifecycle.Read)
  revertActionInitiatedBy?: RecommendedActionInitiatedBy;

  /**
   * Gets the time when this recommended action was approved for revert.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  revertActionInitiatedTime?: utcDateTime;

  /**
   * Gets the impact of this recommended action. Possible values are 1 - Low impact, 2 - Medium Impact and 3 - High Impact
   */
  @visibility(Lifecycle.Read)
  score?: int32;

  /**
   * Gets the implementation details of this recommended action for user to apply it manually.
   */
  @visibility(Lifecycle.Read)
  implementationDetails?: RecommendedActionImplementationInfo;

  /**
   * Gets the error details if and why this recommended action is put to error state.
   */
  @visibility(Lifecycle.Read)
  errorDetails?: RecommendedActionErrorInfo;

  /**
   * Gets the estimated impact info for this recommended action e.g., Estimated CPU gain, Estimated Disk Space change
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  estimatedImpact?: RecommendedActionImpactRecord[];

  /**
   * Gets the observed/actual impact info for this recommended action e.g., Actual CPU gain, Actual Disk Space change
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  observedImpact?: RecommendedActionImpactRecord[];

  /**
   * Gets the time series info of metrics for this recommended action e.g., CPU consumption time series
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  timeSeries?: RecommendedActionMetricInfo[];

  /**
   * Gets the linked objects, if any.
   */
  @visibility(Lifecycle.Read)
  linkedObjects?: string[];

  /**
   * Gets additional details specific to this recommended action.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  details?: Record<string>;
}

/**
 * Contains information of current state for an Azure SQL Database, Server or Elastic Pool Recommended Action.
 */
model RecommendedActionStateInfo {
  /**
   * Current state the recommended action is in. Some commonly used states are: Active      -> recommended action is active and no action has been taken yet. Pending     -> recommended action is approved for and is awaiting execution. Executing   -> recommended action is being applied on the user database. Verifying   -> recommended action was applied and is being verified of its usefulness by the system. Success     -> recommended action was applied and improvement found during verification. Pending Revert  -> verification found little or no improvement so recommended action is queued for revert or user has manually reverted. Reverting   -> changes made while applying recommended action are being reverted on the user database. Reverted    -> successfully reverted the changes made by recommended action on user database. Ignored     -> user explicitly ignored/discarded the recommended action.
   */
  currentValue: RecommendedActionCurrentState;

  /**
   * Gets who initiated the execution of this recommended action. Possible Value are: User    -> When user explicity notified system to apply the recommended action. System  -> When auto-execute status of this advisor was set to 'Enabled', in which case the system applied it.
   */
  @visibility(Lifecycle.Read)
  actionInitiatedBy?: RecommendedActionInitiatedBy;

  /**
   * Gets the time when the state was last modified
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;
}

/**
 * Contains information for manual implementation for an Azure SQL Database, Server or Elastic Pool Recommended Action.
 */
model RecommendedActionImplementationInfo {
  /**
   * Gets the method in which this recommended action can be manually implemented. e.g., TSql, AzurePowerShell.
   */
  @visibility(Lifecycle.Read)
  method?: ImplementationMethod;

  /**
   * Gets the manual implementation script. e.g., T-SQL script that could be executed on the database.
   */
  @visibility(Lifecycle.Read)
  script?: string;
}

/**
 * Contains error information for an Azure SQL Database, Server or Elastic Pool Recommended Action.
 */
model RecommendedActionErrorInfo {
  /**
   * Gets the reason why the recommended action was put to error state. e.g., DatabaseHasQdsOff, IndexAlreadyExists
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * Gets whether the error could be ignored and recommended action could be retried. Possible values are: Yes/No
   */
  @visibility(Lifecycle.Read)
  isRetryable?: IsRetryable;
}

/**
 * Contains information of estimated or observed impact on various metrics for an Azure SQL Database, Server or Elastic Pool Recommended Action.
 */
model RecommendedActionImpactRecord {
  /**
   * Gets the name of the impact dimension. e.g., CPUChange, DiskSpaceChange, NumberOfQueriesAffected.
   */
  @visibility(Lifecycle.Read)
  dimensionName?: string;

  /**
   * Gets the name of the impact dimension. e.g., CPUChange, DiskSpaceChange, NumberOfQueriesAffected.
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * Gets the absolute value of this dimension if applicable. e.g., Number of Queries affected
   */
  @visibility(Lifecycle.Read)
  absoluteValue?: float64;

  /**
   * Gets the absolute change in the value of this dimension. e.g., Absolute Disk space change in Megabytes
   */
  @visibility(Lifecycle.Read)
  changeValueAbsolute?: float64;

  /**
   * Gets the relative change in the value of this dimension. e.g., Relative Disk space change in Percentage
   */
  @visibility(Lifecycle.Read)
  changeValueRelative?: float64;
}

/**
 * Contains time series of various impacted metrics for an Azure SQL Database, Server or Elastic Pool Recommended Action.
 */
model RecommendedActionMetricInfo {
  /**
   * Gets the name of the metric. e.g., CPU, Number of Queries.
   */
  @visibility(Lifecycle.Read)
  metricName?: string;

  /**
   * Gets the unit in which metric is measured. e.g., DTU, Frequency
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * Gets the duration of time interval for the value given by this MetricInfo. e.g., PT1H (1 hour)
   */
  @visibility(Lifecycle.Read)
  timeGrain?: string;

  /**
   * Gets the start time of time interval given by this MetricInfo.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the value of the metric in the time interval given by this MetricInfo.
   */
  @visibility(Lifecycle.Read)
  value?: float64;
}

/**
 * Database-level Automatic Tuning properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseAutomaticTuningProperties {
  /**
   * Automatic tuning desired state.
   */
  desiredState?: AutomaticTuningMode;

  /**
   * Automatic tuning actual state.
   */
  @visibility(Lifecycle.Read)
  actualState?: AutomaticTuningMode;

  /**
   * Automatic tuning options definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  options?: Record<AutomaticTuningOptions>;
}

/**
 * Automatic tuning properties for individual advisors.
 */
model AutomaticTuningOptions {
  /**
   * Automatic tuning option desired state.
   */
  desiredState?: AutomaticTuningOptionModeDesired;

  /**
   * Automatic tuning option actual state.
   */
  @visibility(Lifecycle.Read)
  actualState?: AutomaticTuningOptionModeActual;

  /**
   * Reason code if desired and actual state are different.
   */
  @visibility(Lifecycle.Read)
  reasonCode?: int32;

  /**
   * Reason description if desired and actual state are different.
   */
  @visibility(Lifecycle.Read)
  reasonDesc?: AutomaticTuningDisabledReason;
}

/**
 * Database column properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseColumnProperties {
  /**
   * The column data type.
   */
  columnType?: ColumnDataType;

  /**
   * The table temporal type.
   */
  temporalType?: TableTemporalType;

  /**
   * Whether or not the column belongs to a memory optimized table.
   */
  memoryOptimized?: boolean;

  /**
   * Whether or not the column is computed.
   */
  isComputed?: boolean;
}

/**
 * Contains the operation result properties for import/export operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ImportExportExtensionsOperationResultProperties {
  /**
   * Request Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  requestId?: Azure.Core.uuid;

  /**
   * Request type.
   */
  @visibility(Lifecycle.Read)
  requestType?: string;

  /**
   * Last modified time.
   */
  @visibility(Lifecycle.Read)
  lastModifiedTime?: string;

  /**
   * Server name.
   */
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * Database name.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Operation status.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * Queued time.
   */
  @visibility(Lifecycle.Read)
  queuedTime?: string;

  /**
   * Blob URI.
   */
  @visibility(Lifecycle.Read)
  blobUri?: string;

  /**
   * Gets the status of private endpoints associated with this request.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  privateEndpointConnections?: PrivateEndpointConnectionRequestStatus[];
}

/**
 * Contains the private endpoint connection requests status.
 */
model PrivateEndpointConnectionRequestStatus {
  /**
   * Resource id for which the private endpoint is created.
   */
  @visibility(Lifecycle.Read)
  privateLinkServiceId?: string;

  /**
   * The connection name for the private endpoint.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnectionName?: string;

  /**
   * Status of this private endpoint connection.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * An Import, Export, or PolybaseImport resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseExtensions extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: DatabaseExtensionsProperties;
}

/**
 * Contains the database information after a successful Import, Export, or PolybaseImport
 */
model DatabaseExtensionsProperties {
  /**
   * Operation mode of the operation: Import, Export, or PolybaseImport.
   */
  @visibility(Lifecycle.Create)
  operationMode: OperationMode;

  /**
   * Storage key type: StorageAccessKey, SharedAccessKey or ManagedIdentity.
   */
  @visibility(Lifecycle.Create)
  storageKeyType: StorageKeyType;

  /**
   * Storage key for the storage account. If StorageKeyType is ManagedIdentity, this field should specify the Managed Identity's resource ID.
   */
  @visibility(Lifecycle.Create)
  storageKey: string;

  /**
   * Storage Uri for the storage account.
   */
  @visibility(Lifecycle.Create)
  storageUri: string;

  /**
   * Administrator login name. If AuthenticationType is ManagedIdentity, this field should specify the Managed Identity's resource ID.
   */
  @visibility(Lifecycle.Create)
  administratorLogin?: string;

  /**
   * Administrator login password. If AuthenticationType is ManagedIdentity, this field should not be specified.
   */
  @visibility(Lifecycle.Create)
  @secret
  administratorLoginPassword?: string;

  /**
   * Authentication type used to access the SQL: Sql, ADPassword or ManagedIdentity.
   */
  @visibility(Lifecycle.Create)
  authenticationType?: string;

  /**
   * Database edition for the newly created database in the case of an import operation.
   */
  @visibility(Lifecycle.Create)
  databaseEdition?: string;

  /**
   * Database service level objective for the newly created database in the case of an import operation.
   */
  @visibility(Lifecycle.Create)
  serviceObjectiveName?: string;

  /**
   * Database max size in bytes for the newly created database in the case of an import operation.
   */
  @visibility(Lifecycle.Create)
  maxSizeBytes?: string;

  /**
   * Optional resource information to enable network isolation for request.
   */
  @visibility(Lifecycle.Create)
  networkIsolation?: NetworkIsolationSettings;
}

/**
 * Contains the ARM resources for which to create private endpoint connection.
 */
model NetworkIsolationSettings {
  /**
   * The resource id for the storage account used to store BACPAC file. If set, private endpoint connection will be created for the storage account. Must match storage account used for StorageUri parameter.
   */
  @visibility(Lifecycle.Create)
  storageAccountResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource id for the SQL server which is the target of this request. If set, private endpoint connection will be created for the SQL server. Must match server which is target of the operation.
   */
  @visibility(Lifecycle.Create)
  sqlServerResourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * A database operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseOperation extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: DatabaseOperationProperties;
}

/**
 * The properties of a database operation.
 */
model DatabaseOperationProperties {
  /**
   * The name of the database the operation is being performed on.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * The name of operation.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The friendly name of operation.
   */
  @visibility(Lifecycle.Read)
  operationFriendlyName?: string;

  /**
   * The percentage of the operation completed.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * The name of the server.
   */
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * The operation start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The operation state.
   */
  @visibility(Lifecycle.Read)
  state?: ManagementOperationState;

  /**
   * The operation error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * The operation error description.
   */
  @visibility(Lifecycle.Read)
  errorDescription?: string;

  /**
   * The operation error severity.
   */
  @visibility(Lifecycle.Read)
  errorSeverity?: int32;

  /**
   * Whether or not the error is a user error.
   */
  @visibility(Lifecycle.Read)
  isUserError?: boolean;

  /**
   * The estimated completion time of the operation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  estimatedCompletionTime?: utcDateTime;

  /**
   * The operation description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Whether the operation can be cancelled.
   */
  @visibility(Lifecycle.Read)
  isCancellable?: boolean;

  /**
   * The operation phase details.
   */
  @visibility(Lifecycle.Read)
  operationPhaseDetails?: PhaseDetails;
}

/**
 * The phase details properties of a database operation.
 */
model PhaseDetails {
  /**
   * The operation phase.
   */
  @visibility(Lifecycle.Read)
  phase?: Phase;

  /**
   * The operation phase information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  phaseInformation?: Record<string>;
}

/**
 * An ARM Resource SKU.
 */
model Sku {
  /**
   * The name of the SKU, typically, a letter + Number code, e.g. P3.
   */
  name: string;

  /**
   * The tier or edition of the particular SKU, e.g. Basic, Premium.
   */
  tier?: string;

  /**
   * Size of the particular SKU
   */
  size?: string;

  /**
   * If the service has different generations of hardware, for the same SKU, then that can be captured here.
   */
  family?: string;

  /**
   * Capacity of the particular SKU.
   */
  capacity?: int32;
}

/**
 * Azure Active Directory identity configuration for a resource.
 */
model DatabaseIdentity {
  /**
   * The identity type
   */
  type?: DatabaseIdentityType;

  /**
   * The Azure Active Directory tenant id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tenantId?: Azure.Core.uuid;

  /**
   * The resource ids of the user assigned identities to use
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<DatabaseUserIdentity>;
}

/**
 * Azure Active Directory identity configuration for a resource.
 */
model DatabaseUserIdentity {
  /**
   * The Azure Active Directory principal id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  principalId?: Azure.Core.uuid;

  /**
   * The Azure Active Directory client id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  clientId?: Azure.Core.uuid;
}

/**
 * The database's properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseProperties {
  /**
   * Specifies the mode of database creation.
   *
   * Default: regular database creation.
   *
   * Copy: creates a database as a copy of an existing database. sourceDatabaseId must be specified as the resource ID of the source database.
   *
   * Secondary: creates a database as a secondary replica of an existing database. sourceDatabaseId must be specified as the resource ID of the existing primary database.
   *
   * PointInTimeRestore: Creates a database by restoring a point in time backup of an existing database. sourceDatabaseId must be specified as the resource ID of the existing database, and restorePointInTime must be specified.
   *
   * Recovery: Creates a database by restoring a geo-replicated backup. sourceDatabaseId must be specified as the recoverable database resource ID to restore.
   *
   * Restore: Creates a database by restoring a backup of a deleted database. sourceDatabaseId must be specified. If sourceDatabaseId is the database's original resource ID, then sourceDatabaseDeletionDate must be specified. Otherwise sourceDatabaseId must be the restorable dropped database resource ID and sourceDatabaseDeletionDate is ignored. restorePointInTime may also be specified to restore from an earlier point in time.
   *
   * RestoreLongTermRetentionBackup: Creates a database by restoring from a long term retention vault. recoveryServicesRecoveryPointResourceId must be specified as the recovery point resource ID.
   *
   * Copy, Secondary, and RestoreLongTermRetentionBackup are not supported for DataWarehouse edition.
   */
  @visibility(Lifecycle.Create)
  createMode?: CreateMode;

  /**
   * The collation of the database.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  collation?: string;

  /**
   * The max size of the database expressed in bytes.
   */
  maxSizeBytes?: int64;

  /**
   * The name of the sample schema to apply when creating this database.
   */
  @visibility(Lifecycle.Create)
  sampleName?: SampleName;

  /**
   * The resource identifier of the elastic pool containing this database.
   */
  elasticPoolId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/elasticPools";
    }
  ]>;

  /**
   * The resource identifier of the source database associated with create operation of this database.
   */
  @visibility(Lifecycle.Create)
  sourceDatabaseId?: Azure.Core.armResourceIdentifier;

  /**
   * The status of the database.
   */
  @visibility(Lifecycle.Read)
  status?: DatabaseStatus;

  /**
   * The ID of the database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  databaseId?: Azure.Core.uuid;

  /**
   * The creation date of the database (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The current service level objective name of the database.
   */
  @visibility(Lifecycle.Read)
  currentServiceObjectiveName?: string;

  /**
   * The requested service level objective name of the database.
   */
  @visibility(Lifecycle.Read)
  requestedServiceObjectiveName?: string;

  /**
   * The default secondary region for this database.
   */
  @visibility(Lifecycle.Read)
  defaultSecondaryLocation?: string;

  /**
   * Failover Group resource identifier that this database belongs to.
   */
  @visibility(Lifecycle.Read)
  failoverGroupId?: string;

  /**
   * Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.
   */
  @visibility(Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restorePointInTime?: utcDateTime;

  /**
   * Specifies the time that the database was deleted.
   */
  @visibility(Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sourceDatabaseDeletionDate?: utcDateTime;

  /**
   * The resource identifier of the recovery point associated with create operation of this database.
   */
  @visibility(Lifecycle.Create)
  recoveryServicesRecoveryPointId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource identifier of the long term retention backup associated with create operation of this database.
   */
  @visibility(Lifecycle.Create)
  longTermRetentionBackupResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/locations/longTermRetentionBackups";
    }
  ]>;

  /**
   * The resource identifier of the recoverable database associated with create operation of this database.
   */
  @visibility(Lifecycle.Create)
  recoverableDatabaseId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource identifier of the restorable dropped database associated with create operation of this database.
   */
  @visibility(Lifecycle.Create)
  restorableDroppedDatabaseId?: Azure.Core.armResourceIdentifier;

  /**
   * Collation of the metadata catalog.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  catalogCollation?: CatalogCollationType;

  /**
   * Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones.
   */
  zoneRedundant?: boolean;

  /**
   * The license type to apply for this database. `LicenseIncluded` if you need a license, or `BasePrice` if you have a license and are eligible for the Azure Hybrid Benefit.
   */
  licenseType?: DatabaseLicenseType;

  /**
   * The max log size for this database.
   */
  @visibility(Lifecycle.Read)
  maxLogSizeBytes?: int64;

  /**
   * This records the earliest start date and time that restore is available for this database (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;

  /**
   * The state of read-only routing. If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica in the same region. Not applicable to a Hyperscale database within an elastic pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  readScale?: DatabaseReadScale;

  /**
   * The number of secondary replicas associated with the Business Critical, Premium, or Hyperscale edition database that are used to provide high availability. Not applicable to a Hyperscale database within an elastic pool.
   */
  highAvailabilityReplicaCount?: int32;

  /**
   * The secondary type of the database if it is a secondary.  Valid values are Geo, Named and Standby.
   */
  secondaryType?: SecondaryType;

  /**
   * The name and tier of the SKU.
   */
  @visibility(Lifecycle.Read)
  currentSku?: Sku;

  /**
   * Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled
   */
  autoPauseDelay?: int32;

  /**
   * The storage account type used to store backups for this database.
   */
  @visibility(Lifecycle.Read)
  currentBackupStorageRedundancy?: BackupStorageRedundancy;

  /**
   * The storage account type to be used to store backups for this database.
   */
  requestedBackupStorageRedundancy?: BackupStorageRedundancy;

  /**
   * Minimal capacity that database will always have allocated, if not paused
   */
  minCapacity?: float64;

  /**
   * The date when database was paused by user configuration or action(ISO8601 format). Null if the database is ready.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  pausedDate?: utcDateTime;

  /**
   * The date when database was resumed by user action or database login (ISO8601 format). Null if the database is paused.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resumedDate?: utcDateTime;

  /**
   * Maintenance configuration id assigned to the database. This configuration defines the period when the maintenance updates will occur.
   */
  maintenanceConfigurationId?: string;

  /**
   * Whether or not this database is a ledger database, which means all tables in the database are ledger tables. Note: the value of this property cannot be changed after the database has been created.
   */
  isLedgerOn?: boolean;

  /**
   * Infra encryption is enabled for this database.
   */
  @visibility(Lifecycle.Read)
  isInfraEncryptionEnabled?: boolean;

  /**
   * The Client id used for cross tenant per database CMK scenario
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  federatedClientId?: Azure.Core.uuid;

  /**
   * The resource ids of the user assigned identities to use
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keys?: Record<DatabaseKey>;

  /**
   * The azure key vault URI of the database if it's configured with per Database Customer Managed Keys.
   */
  encryptionProtector?: string;

  /**
   * Type of enclave requested on the database i.e. Default or VBS enclaves.
   */
  preferredEnclaveType?: AlwaysEncryptedEnclaveType;

  /**
   * Whether or not the database uses free monthly limits. Allowed on one database in a subscription.
   */
  useFreeLimit?: boolean;

  /**
   * Specifies the behavior when monthly free limits are exhausted for the free database.
   *
   * AutoPause: The database will be auto paused upon exhaustion of free limits for remainder of the month.
   *
   * BillForUsage: The database will continue to be online upon exhaustion of free limits and any overage will be billed.
   */
  freeLimitExhaustionBehavior?: FreeLimitExhaustionBehavior;

  /**
   * The resource identifier of the source associated with the create operation of this database.
   *
   * This property is only supported for DataWarehouse edition and allows to restore across subscriptions.
   *
   * When sourceResourceId is specified, sourceDatabaseId, recoverableDatabaseId, restorableDroppedDatabaseId and sourceDatabaseDeletionDate must not be specified and CreateMode must be PointInTimeRestore, Restore or Recover.
   *
   * When createMode is PointInTimeRestore, sourceResourceId must be the resource ID of the existing database or existing sql pool, and restorePointInTime must be specified.
   *
   * When createMode is Restore, sourceResourceId must be the resource ID of restorable dropped database or restorable dropped sql pool.
   *
   * When createMode is Recover, sourceResourceId must be the resource ID of recoverable database or recoverable sql pool.
   *
   * When source subscription belongs to a different tenant than target subscription, “x-ms-authorization-auxiliary” header must contain authentication token for the source tenant. For more details about “x-ms-authorization-auxiliary” header see https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/authenticate-multi-tenant
   */
  @visibility(Lifecycle.Create)
  sourceResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Whether or not customer controlled manual cutover needs to be done during Update Database operation to Hyperscale tier.
   *
   * This property is only applicable when scaling database from Business Critical/General Purpose/Premium/Standard tier to Hyperscale tier.
   *
   * When manualCutover is specified, the scaling operation will wait for user input to trigger cutover to Hyperscale database.
   *
   * To trigger cutover, please provide 'performCutover' parameter when the Scaling operation is in Waiting state.
   */
  manualCutover?: boolean;

  /**
   * To trigger customer controlled manual cutover during the wait state while Scaling operation is in progress.
   *
   * This property parameter is only applicable for scaling operations that are initiated along with 'manualCutover' parameter.
   *
   * This property is only applicable when scaling database from Business Critical/General Purpose/Premium/Standard tier to Hyperscale tier is already in progress.
   *
   * When performCutover is specified, the scaling operation will trigger cutover and perform role-change to Hyperscale database.
   */
  performCutover?: boolean;

  /**
   * Specifies the availability zone the database is pinned to.
   */
  availabilityZone?: AvailabilityZoneType;

  /**
   * The flag to enable or disable auto rotation of database encryption protector AKV key.
   */
  encryptionProtectorAutoRotation?: boolean;

  /**
   * Specifies the provisioning state for this resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Database level key used for encryption at rest.
 */
model DatabaseKey {
  /**
   * The database key type. Only supported value is 'AzureKeyVault'.
   */
  @visibility(Lifecycle.Read)
  type?: DatabaseKeyType;

  /**
   * Thumbprint of the database key.
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * The database key creation date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Subregion of the server key.
   */
  @visibility(Lifecycle.Read)
  subregion?: string;

  /**
   * The database key's version.
   */
  @visibility(Lifecycle.Read)
  keyVersion?: string;
}

/**
 * ARM tracked top level resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TrackedResource extends CommonTypes.Resource {
  /**
   * Resource location.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * A database update resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseUpdate {
  /**
   * The name and tier of the SKU.
   */
  sku?: Sku;

  /**
   * Database identity
   */
  identity?: DatabaseIdentity;

  /**
   * Resource properties.
   */
  properties?: DatabaseUpdateProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * A database update properties.
 */
model DatabaseUpdateProperties {
  /**
   * Specifies the mode of database creation.
   *
   * Default: regular database creation.
   *
   * Copy: creates a database as a copy of an existing database. sourceDatabaseId must be specified as the resource ID of the source database.
   *
   * Secondary: creates a database as a secondary replica of an existing database. sourceDatabaseId must be specified as the resource ID of the existing primary database.
   *
   * PointInTimeRestore: Creates a database by restoring a point in time backup of an existing database. sourceDatabaseId must be specified as the resource ID of the existing database, and restorePointInTime must be specified.
   *
   * Recovery: Creates a database by restoring a geo-replicated backup. sourceDatabaseId must be specified as the recoverable database resource ID to restore.
   *
   * Restore: Creates a database by restoring a backup of a deleted database. sourceDatabaseId must be specified. If sourceDatabaseId is the database's original resource ID, then sourceDatabaseDeletionDate must be specified. Otherwise sourceDatabaseId must be the restorable dropped database resource ID and sourceDatabaseDeletionDate is ignored. restorePointInTime may also be specified to restore from an earlier point in time.
   *
   * RestoreLongTermRetentionBackup: Creates a database by restoring from a long term retention vault. recoveryServicesRecoveryPointResourceId must be specified as the recovery point resource ID.
   *
   * Copy, Secondary, and RestoreLongTermRetentionBackup are not supported for DataWarehouse edition.
   */
  @visibility(Lifecycle.Create)
  createMode?: CreateMode;

  /**
   * The collation of the database.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  collation?: string;

  /**
   * The max size of the database expressed in bytes.
   */
  maxSizeBytes?: int64;

  /**
   * The name of the sample schema to apply when creating this database.
   */
  @visibility(Lifecycle.Create)
  sampleName?: SampleName;

  /**
   * The resource identifier of the elastic pool containing this database.
   */
  elasticPoolId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/elasticPools";
    }
  ]>;

  /**
   * The resource identifier of the source database associated with create operation of this database.
   */
  @visibility(Lifecycle.Create)
  sourceDatabaseId?: Azure.Core.armResourceIdentifier;

  /**
   * The status of the database.
   */
  @visibility(Lifecycle.Read)
  status?: DatabaseStatus;

  /**
   * The ID of the database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  databaseId?: Azure.Core.uuid;

  /**
   * The creation date of the database (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The current service level objective name of the database.
   */
  @visibility(Lifecycle.Read)
  currentServiceObjectiveName?: string;

  /**
   * The requested service level objective name of the database.
   */
  @visibility(Lifecycle.Read)
  requestedServiceObjectiveName?: string;

  /**
   * The default secondary region for this database.
   */
  @visibility(Lifecycle.Read)
  defaultSecondaryLocation?: string;

  /**
   * Failover Group resource identifier that this database belongs to.
   */
  @visibility(Lifecycle.Read)
  failoverGroupId?: string;

  /**
   * Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.
   */
  @visibility(Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restorePointInTime?: utcDateTime;

  /**
   * Specifies the time that the database was deleted.
   */
  @visibility(Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sourceDatabaseDeletionDate?: utcDateTime;

  /**
   * The resource identifier of the recovery point associated with create operation of this database.
   */
  @visibility(Lifecycle.Create)
  recoveryServicesRecoveryPointId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource identifier of the long term retention backup associated with create operation of this database.
   */
  @visibility(Lifecycle.Create)
  longTermRetentionBackupResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/locations/longTermRetentionBackups";
    }
  ]>;

  /**
   * The resource identifier of the recoverable database associated with create operation of this database.
   */
  @visibility(Lifecycle.Create)
  recoverableDatabaseId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource identifier of the restorable dropped database associated with create operation of this database.
   */
  @visibility(Lifecycle.Create)
  restorableDroppedDatabaseId?: Azure.Core.armResourceIdentifier;

  /**
   * Collation of the metadata catalog.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  catalogCollation?: CatalogCollationType;

  /**
   * Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones.
   */
  zoneRedundant?: boolean;

  /**
   * The license type to apply for this database. `LicenseIncluded` if you need a license, or `BasePrice` if you have a license and are eligible for the Azure Hybrid Benefit.
   */
  licenseType?: DatabaseLicenseType;

  /**
   * The max log size for this database.
   */
  @visibility(Lifecycle.Read)
  maxLogSizeBytes?: int64;

  /**
   * This records the earliest start date and time that restore is available for this database (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;

  /**
   * The state of read-only routing. If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica in the same region. Not applicable to a Hyperscale database within an elastic pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  readScale?: DatabaseReadScale;

  /**
   * The number of secondary replicas associated with the Business Critical, Premium, or Hyperscale edition database that are used to provide high availability. Not applicable to a Hyperscale database within an elastic pool.
   */
  highAvailabilityReplicaCount?: int32;

  /**
   * The secondary type of the database if it is a secondary.  Valid values are Geo, Named and Standby.
   */
  secondaryType?: SecondaryType;

  /**
   * The name and tier of the SKU.
   */
  @visibility(Lifecycle.Read)
  currentSku?: Sku;

  /**
   * Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled
   */
  autoPauseDelay?: int32;

  /**
   * The storage account type used to store backups for this database.
   */
  @visibility(Lifecycle.Read)
  currentBackupStorageRedundancy?: BackupStorageRedundancy;

  /**
   * The storage account type to be used to store backups for this database.
   */
  requestedBackupStorageRedundancy?: BackupStorageRedundancy;

  /**
   * Minimal capacity that database will always have allocated, if not paused
   */
  minCapacity?: float64;

  /**
   * The date when database was paused by user configuration or action(ISO8601 format). Null if the database is ready.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  pausedDate?: utcDateTime;

  /**
   * The date when database was resumed by user action or database login (ISO8601 format). Null if the database is paused.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resumedDate?: utcDateTime;

  /**
   * Maintenance configuration id assigned to the database. This configuration defines the period when the maintenance updates will occur.
   */
  maintenanceConfigurationId?: string;

  /**
   * Whether or not this database is a ledger database, which means all tables in the database are ledger tables. Note: the value of this property cannot be changed after the database has been created.
   */
  isLedgerOn?: boolean;

  /**
   * Infra encryption is enabled for this database.
   */
  @visibility(Lifecycle.Read)
  isInfraEncryptionEnabled?: boolean;

  /**
   * The Client id used for cross tenant per database CMK scenario
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  federatedClientId?: Azure.Core.uuid;

  /**
   * The resource ids of the user assigned identities to use
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keys?: Record<DatabaseKey>;

  /**
   * The azure key vault URI of the database if it's configured with per Database Customer Managed Keys.
   */
  encryptionProtector?: string;

  /**
   * Type of enclave requested on the database i.e. Default or VBS enclaves.
   */
  preferredEnclaveType?: AlwaysEncryptedEnclaveType;

  /**
   * Whether or not the database uses free monthly limits. Allowed on one database in a subscription.
   */
  useFreeLimit?: boolean;

  /**
   * Specifies the behavior when monthly free limits are exhausted for the free database.
   *
   * AutoPause: The database will be auto paused upon exhaustion of free limits for remainder of the month.
   *
   * BillForUsage: The database will continue to be online upon exhaustion of free limits and any overage will be billed.
   */
  freeLimitExhaustionBehavior?: FreeLimitExhaustionBehavior;

  /**
   * Whether or not customer controlled manual cutover needs to be done during Update Database operation to Hyperscale tier.
   *
   * This property is only applicable when scaling database from Business Critical/General Purpose/Premium/Standard tier to Hyperscale tier.
   *
   * When manualCutover is specified, the scaling operation will wait for user input to trigger cutover to Hyperscale database.
   *
   * To trigger cutover, please provide 'performCutover' parameter when the Scaling operation is in Waiting state.
   */
  manualCutover?: boolean;

  /**
   * To trigger customer controlled manual cutover during the wait state while Scaling operation is in progress.
   *
   * This property parameter is only applicable for scaling operations that are initiated along with 'manualCutover' parameter.
   *
   * This property is only applicable when scaling database from Business Critical/General Purpose/Premium/Standard tier to Hyperscale tier is already in progress.
   *
   * When performCutover is specified, the scaling operation will trigger cutover and perform role-change to Hyperscale database.
   */
  performCutover?: boolean;

  /**
   * The flag to enable or disable auto rotation of database encryption protector AKV key.
   */
  encryptionProtectorAutoRotation?: boolean;

  /**
   * Specifies the provisioning state for this resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Contains the information necessary to perform export database operation.
 */
model ExportDatabaseDefinition {
  /**
   * Storage key type: StorageAccessKey, SharedAccessKey, or ManagedIdentity.
   */
  @visibility(Lifecycle.Create)
  storageKeyType: StorageKeyType;

  /**
   * Storage key for the storage account. If StorageKeyType is ManagedIdentity, this field should specify the Managed Identity's resource ID.
   */
  @visibility(Lifecycle.Create)
  storageKey: string;

  /**
   * Storage Uri.
   */
  @visibility(Lifecycle.Create)
  storageUri: string;

  /**
   * Administrator login name. If AuthenticationType is ManagedIdentity, this field should specify the Managed Identity's resource ID.
   */
  @visibility(Lifecycle.Create)
  administratorLogin: string;

  /**
   * Administrator login password. If AuthenticationType is ManagedIdentity, this field should not be specified.
   */
  @visibility(Lifecycle.Create)
  @secret
  administratorLoginPassword?: string;

  /**
   * Type of credentials provided for access to the target SQL server: SQL, ADPassword or ManagedIdentity.
   */
  @visibility(Lifecycle.Create)
  authenticationType?: string;

  /**
   * Optional resource information to enable network isolation for request.
   */
  @visibility(Lifecycle.Create)
  networkIsolation?: NetworkIsolationSettings;
}

/**
 * An ImportExport operation result resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ImportExportOperationResult extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: ImportExportOperationResultProperties;
}

/**
 * Contains the operation result properties for import/export operation.
 */
model ImportExportOperationResultProperties {
  /**
   * Request Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  requestId?: Azure.Core.uuid;

  /**
   * Request type.
   */
  @visibility(Lifecycle.Read)
  requestType?: string;

  /**
   * Queued time.
   */
  @visibility(Lifecycle.Read)
  queuedTime?: string;

  /**
   * Last modified time.
   */
  @visibility(Lifecycle.Read)
  lastModifiedTime?: string;

  /**
   * Blob Uri.
   */
  @visibility(Lifecycle.Read)
  blobUri?: string;

  /**
   * Server name.
   */
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * Database name.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Operation status.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * Gets the status of private endpoints associated with this request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnectionRequestStatus[];
}

/**
 * Contains the information necessary to perform import operation for existing database.
 */
model ImportExistingDatabaseDefinition {
  /**
   * Storage key type: StorageAccessKey, SharedAccessKey, or ManagedIdentity.
   */
  @visibility(Lifecycle.Create)
  storageKeyType: StorageKeyType;

  /**
   * Storage key for the storage account. If StorageKeyType is ManagedIdentity, this field should specify the Managed Identity's resource ID.
   */
  @visibility(Lifecycle.Create)
  storageKey: string;

  /**
   * Storage Uri.
   */
  @visibility(Lifecycle.Create)
  storageUri: string;

  /**
   * Administrator login name. If AuthenticationType is ManagedIdentity, this field should specify the Managed Identity's resource ID.
   */
  @visibility(Lifecycle.Create)
  administratorLogin: string;

  /**
   * Administrator login password. If AuthenticationType is ManagedIdentity, this field should not be specified.
   */
  @visibility(Lifecycle.Create)
  @secret
  administratorLoginPassword?: string;

  /**
   * Type of credentials provided for access to the target SQL server: SQL, ADPassword or ManagedIdentity.
   */
  @visibility(Lifecycle.Create)
  authenticationType?: string;

  /**
   * Optional resource information to enable network isolation for request.
   */
  @visibility(Lifecycle.Create)
  networkIsolation?: NetworkIsolationSettings;
}

/**
 * Contains the information necessary to perform a resource move (rename).
 */
model ResourceMoveDefinition {
  /**
   * The target ID for the resource
   */
  id: string;
}

/**
 * Properties of a security alert policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityAlertsPolicyProperties {
  /**
   * Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific database.
   */
  state: SecurityAlertsPolicyState;

  /**
   * Specifies an array of alerts that are disabled. Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly, Data_Exfiltration, Unsafe_Action, Brute_Force
   */
  disabledAlerts?: string[];

  /**
   * Specifies an array of e-mail addresses to which the alert is sent.
   */
  emailAddresses?: string[];

  /**
   * Specifies that the alert is sent to the account administrators.
   */
  emailAccountAdmins?: boolean;

  /**
   * Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs.
   */
  storageEndpoint?: string;

  /**
   * Specifies the identifier key of the Threat Detection audit storage account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageAccountAccessKey?: string;

  /**
   * Specifies the number of days to keep in the Threat Detection audit logs.
   */
  retentionDays?: int32;

  /**
   * Specifies the UTC creation time of the policy.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

/**
 * Properties of a database Sql Vulnerability Assessment baseline set.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseSqlVulnerabilityAssessmentBaselineSetProperties {
  /**
   * The baseline set result
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  results: Record<string[][]>;
}

/**
 * A database sql vulnerability assessment rule baseline list input.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseSqlVulnerabilityAssessmentRuleBaselineListInput
  extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: DatabaseSqlVulnerabilityAssessmentRuleBaselineListInputProperties;
}

/**
 * Properties of a database Sql Vulnerability Assessment rule baseline.
 */
model DatabaseSqlVulnerabilityAssessmentRuleBaselineListInputProperties {
  /**
   * The latest scan flag
   */
  latestScan: boolean;

  /**
   * The rule baseline result list
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  results: Record<string[][]>;
}

/**
 * Properties of a database Sql Vulnerability Assessment rule baseline.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseSqlVulnerabilityAssessmentRuleBaselineProperties {
  /**
   * The rule baseline result
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  results: string[][];
}

/**
 * A database sql vulnerability assessment rule baseline input.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseSqlVulnerabilityAssessmentRuleBaselineInput
  extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: DatabaseSqlVulnerabilityAssessmentRuleBaselineInputProperties;
}

/**
 * Properties of a database Sql Vulnerability Assessment rule baseline.
 */
model DatabaseSqlVulnerabilityAssessmentRuleBaselineInputProperties {
  /**
   * The latest scan flag
   */
  latestScan: boolean;

  /**
   * The rule baseline result
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  results: string[][];
}

/**
 * SQL Vulnerability Assessment scan result properties for a single rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlVulnerabilityAssessmentScanResultProperties {
  /**
   * SQL Vulnerability Assessment rule Id.
   */
  @visibility(Lifecycle.Read)
  ruleId?: string;

  /**
   * SQL Vulnerability Assessment rule result status.
   */
  @visibility(Lifecycle.Read)
  status?: RuleStatus;

  /**
   * SQL Vulnerability Assessment error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * SQL Vulnerability Assessment is the query results trimmed.
   */
  @visibility(Lifecycle.Read)
  isTrimmed?: boolean;

  /**
   * SQL Vulnerability Assessment query results that was run.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  queryResults?: string[][];

  /**
   * SQL Vulnerability Assessment the remediation details.
   */
  @visibility(Lifecycle.Read)
  remediation?: Remediation;

  /**
   * SQL Vulnerability Assessment rule result adjusted with baseline.
   */
  @visibility(Lifecycle.Read)
  baselineAdjustedResult?: BaselineAdjustedResult;

  /**
   * SQL Vulnerability Assessment rule metadata.
   */
  @visibility(Lifecycle.Read)
  ruleMetadata?: VaRule;
}

/**
 * SQL Vulnerability Assessment remediation Details.
 */
model Remediation {
  /**
   * SQL Vulnerability Assessment remediation description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * SQL Vulnerability Assessment remediation script.
   */
  @visibility(Lifecycle.Read)
  scripts?: string[];

  /**
   * SQL Vulnerability Assessment is remediation automated.
   */
  @visibility(Lifecycle.Read)
  automated?: boolean;

  /**
   * SQL Vulnerability Assessment optional link to remediate in Azure Portal.
   */
  @visibility(Lifecycle.Read)
  portalLink?: string;
}

/**
 * SQL Vulnerability Assessment baseline adjusted results
 */
model BaselineAdjustedResult {
  /**
   * SQL Vulnerability Assessment baseline details
   */
  @visibility(Lifecycle.Read)
  baseline?: Baseline;

  /**
   * SQL Vulnerability Assessment baseline status
   */
  @visibility(Lifecycle.Read)
  status?: RuleStatus;

  /**
   * SQL Vulnerability Assessment results that are not in baseline
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  resultsNotInBaseline?: string[][];

  /**
   * SQL Vulnerability Assessment results that are in baseline.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  resultsOnlyInBaseline?: string[][];
}

/**
 * SQL Vulnerability Assessment baseline Details
 */
model Baseline {
  /**
   * SQL Vulnerability Assessment baseline expected results
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  expectedResults?: string[][];

  /**
   * SQL Vulnerability Assessment baseline update time (UTC)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedTime?: utcDateTime;
}

/**
 * SQL Vulnerability Assessment rule metadata details.
 */
model VaRule {
  /**
   * SQL Vulnerability Assessment rule Id.
   */
  @visibility(Lifecycle.Read)
  ruleId?: string;

  /**
   * SQL Vulnerability Assessment rule severity.
   */
  @visibility(Lifecycle.Read)
  severity?: RuleSeverity;

  /**
   * SQL Vulnerability Assessment rule category.
   */
  @visibility(Lifecycle.Read)
  category?: string;

  /**
   * SQL Vulnerability Assessment rule type.
   */
  @visibility(Lifecycle.Read)
  ruleType?: RuleType;

  /**
   * SQL Vulnerability Assessment rule title.
   */
  @visibility(Lifecycle.Read)
  title?: string;

  /**
   * SQL Vulnerability Assessment rule description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * SQL Vulnerability Assessment rule rationale.
   */
  @visibility(Lifecycle.Read)
  rationale?: string;

  /**
   * SQL Vulnerability Assessment rule query details.
   */
  @visibility(Lifecycle.Read)
  queryCheck?: QueryCheck;

  /**
   * SQL Vulnerability Assessment benchmark references.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  benchmarkReferences?: BenchmarkReference[];
}

/**
 * SQL Vulnerability Assessment query check object.
 */
model QueryCheck {
  /**
   * SQL Vulnerability Assessment rule query.
   */
  @visibility(Lifecycle.Read)
  query?: string;

  /**
   * SQL Vulnerability Assessment query expected result.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  expectedResult?: string[][];

  /**
   * SQL Vulnerability Assessment column names of query expected result.
   */
  @visibility(Lifecycle.Read)
  columnNames?: string[];
}

/**
 * SQL Vulnerability Assessment benchmark reference
 */
model BenchmarkReference {
  /**
   * SQL Vulnerability Assessment benchmark name
   */
  @visibility(Lifecycle.Read)
  benchmark?: string;

  /**
   * SQL Vulnerability Assessment benchmark reference.
   */
  @visibility(Lifecycle.Read)
  reference?: string;
}

/**
 * Properties of a vulnerability assessment scan record.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlVulnerabilityAssessmentScanRecordProperties {
  /**
   * The scan ID.
   */
  @visibility(Lifecycle.Read)
  scanId?: string;

  /**
   * The scan trigger type.
   */
  @visibility(Lifecycle.Read)
  triggerType?: VulnerabilityAssessmentScanTriggerType;

  /**
   * The scan status.
   */
  @visibility(Lifecycle.Read)
  state?: VulnerabilityAssessmentScanState;

  /**
   * The scan start time (UTC).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The scan end time (UTC).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The scan errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errors?: SqlVulnerabilityAssessmentScanError[];

  /**
   * The server name.
   */
  @visibility(Lifecycle.Read)
  server?: string;

  /**
   * The database name.
   */
  @visibility(Lifecycle.Read)
  database?: string;

  /**
   * The SQL version.
   */
  @visibility(Lifecycle.Read)
  sqlVersion?: string;

  /**
   * The number of failed rules with high severity.
   */
  @visibility(Lifecycle.Read)
  highSeverityFailedRulesCount?: int32;

  /**
   * The number of failed rules with medium severity.
   */
  @visibility(Lifecycle.Read)
  mediumSeverityFailedRulesCount?: int32;

  /**
   * The number of failed rules with low severity.
   */
  @visibility(Lifecycle.Read)
  lowSeverityFailedRulesCount?: int32;

  /**
   * The number of total passed rules.
   */
  @visibility(Lifecycle.Read)
  totalPassedRulesCount?: int32;

  /**
   * The number of total failed rules.
   */
  @visibility(Lifecycle.Read)
  totalFailedRulesCount?: int32;

  /**
   * The number of total rules assessed.
   */
  @visibility(Lifecycle.Read)
  totalRulesCount?: int32;

  /**
   * Baseline created for this database, and has one or more rules.
   */
  @visibility(Lifecycle.Read)
  isBaselineApplied?: boolean;

  /**
   * The last scan time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastScanTime?: utcDateTime;
}

/**
 * Properties of a vulnerability assessment scan error.
 */
model SqlVulnerabilityAssessmentScanError {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlVulnerabilityAssessmentPolicyProperties {
  /**
   * Specifies the state of the SQL Vulnerability Assessment, whether it is enabled or disabled or a state has not been applied yet on the specific database or server.
   */
  state?: SqlVulnerabilityAssessmentState;
}

/**
 * Database table properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseTableProperties {
  /**
   * The table temporal type.
   */
  temporalType?: TableTemporalType;

  /**
   * Whether or not the table is memory optimized.
   */
  memoryOptimized?: boolean;
}

/**
 * Usage metric of a database.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseUsage extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: DatabaseUsageProperties;
}

/**
 * Properties of a database usage.
 */
model DatabaseUsageProperties {
  /**
   * User-readable name of the metric.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Current value of the metric.
   */
  @visibility(Lifecycle.Read)
  currentValue?: float64;

  /**
   * Boundary value of the metric.
   */
  @visibility(Lifecycle.Read)
  limit?: float64;

  /**
   * Unit of the metric.
   */
  @visibility(Lifecycle.Read)
  unit?: string;
}

/**
 * Properties of a database Vulnerability Assessment rule baseline.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseVulnerabilityAssessmentRuleBaselineProperties {
  /**
   * The rule baseline result
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  baselineResults: DatabaseVulnerabilityAssessmentRuleBaselineItem[];
}

/**
 * Properties for an Azure SQL Database Vulnerability Assessment rule baseline's result.
 */
model DatabaseVulnerabilityAssessmentRuleBaselineItem {
  /**
   * The rule baseline result
   */
  result: string[];
}

/**
 * Properties of a database Vulnerability Assessment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseVulnerabilityAssessmentProperties {
  /**
   * A blob storage container path to hold the scan results (e.g. https://myStorage.blob.core.windows.net/VaScans/).  It is required if server level vulnerability assessment policy doesn't set
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageContainerPath?: string;

  /**
   * A shared access signature (SAS Key) that has write access to the blob container specified in 'storageContainerPath' parameter. If 'storageAccountAccessKey' isn't specified, StorageContainerSasKey is required. Applies only if the storage account is not behind a Vnet or a firewall
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageContainerSasKey?: string;

  /**
   * Specifies the identifier key of the storage account for vulnerability assessment scan results. If 'StorageContainerSasKey' isn't specified, storageAccountAccessKey is required. Applies only if the storage account is not behind a Vnet or a firewall
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageAccountAccessKey?: string;

  /**
   * The recurring scans settings
   */
  recurringScans?: VulnerabilityAssessmentRecurringScansProperties;
}

/**
 * Properties of a Vulnerability Assessment recurring scans.
 */
model VulnerabilityAssessmentRecurringScansProperties {
  /**
   * Recurring scans state.
   */
  isEnabled?: boolean;

  /**
   * Specifies that the schedule scan notification will be is sent to the subscription administrators.
   */
  emailSubscriptionAdmins?: boolean = true;

  /**
   * Specifies an array of e-mail addresses to which the scan notification is sent.
   */
  emails?: string[];
}

/**
 * Properties of a vulnerability assessment scan record.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VulnerabilityAssessmentScanRecordProperties {
  /**
   * The scan ID.
   */
  @visibility(Lifecycle.Read)
  scanId?: string;

  /**
   * The scan trigger type.
   */
  @visibility(Lifecycle.Read)
  triggerType?: VulnerabilityAssessmentScanTriggerType;

  /**
   * The scan status.
   */
  @visibility(Lifecycle.Read)
  state?: VulnerabilityAssessmentScanState;

  /**
   * The scan start time (UTC).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The scan end time (UTC).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The scan errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errors?: VulnerabilityAssessmentScanError[];

  /**
   * The scan results storage container path.
   */
  @visibility(Lifecycle.Read)
  storageContainerPath?: string;

  /**
   * The number of failed security checks.
   */
  @visibility(Lifecycle.Read)
  numberOfFailedSecurityChecks?: int32;
}

/**
 * Properties of a vulnerability assessment scan error.
 */
model VulnerabilityAssessmentScanError {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * A database Vulnerability Assessment scan export resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseVulnerabilityAssessmentScansExport
  extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: DatabaseVulnerabilityAssessmentScanExportProperties;
}

/**
 * Properties of the export operation's result.
 */
model DatabaseVulnerabilityAssessmentScanExportProperties {
  /**
   * Location of the exported report (e.g. https://myStorage.blob.core.windows.net/VaScans/scans/serverName/databaseName/scan_scanId.xlsx).
   */
  @visibility(Lifecycle.Read)
  exportedReportLocation?: string;
}

/**
 * The properties of a database data masking policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataMaskingPolicyProperties {
  /**
   * The state of the data masking policy.
   */
  dataMaskingState: DataMaskingState;

  /**
   * The list of the exempt principals. Specifies the semicolon-separated list of database users for which the data masking policy does not apply. The specified users receive data results without masking for all of the database queries.
   */
  exemptPrincipals?: string;

  /**
   * The list of the application principals. This is a legacy parameter and is no longer used.
   */
  @visibility(Lifecycle.Read)
  applicationPrincipals?: string;

  /**
   * The masking level. This is a legacy parameter and is no longer used.
   */
  @visibility(Lifecycle.Read)
  maskingLevel?: string;
}

/**
 * A database data masking rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataMaskingRule extends CommonTypes.ProxyResource {
  /**
   * The location of the data masking rule.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The kind of Data Masking Rule. Metadata, used for Azure portal.
   */
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * Resource properties.
   */
  properties?: DataMaskingRuleProperties;
}

/**
 * The properties of a database data masking rule.
 */
model DataMaskingRuleProperties {
  /**
   * The rule Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The rule state. Used to delete a rule. To delete an existing rule, specify the schemaName, tableName, columnName, maskingFunction, and specify ruleState as disabled. However, if the rule doesn't already exist, the rule will be created with ruleState set to enabled, regardless of the provided value of ruleState.
   */
  ruleState?: DataMaskingRuleState;

  /**
   * The schema name on which the data masking rule is applied.
   */
  schemaName: string;

  /**
   * The table name on which the data masking rule is applied.
   */
  tableName: string;

  /**
   * The column name on which the data masking rule is applied.
   */
  columnName: string;

  /**
   * The alias name. This is a legacy parameter and is no longer used.
   */
  aliasName?: string;

  /**
   * The masking function that is used for the data masking rule.
   */
  maskingFunction: DataMaskingFunction;

  /**
   * The numberFrom property of the masking rule. Required if maskingFunction is set to Number, otherwise this parameter will be ignored.
   */
  numberFrom?: string;

  /**
   * The numberTo property of the data masking rule. Required if maskingFunction is set to Number, otherwise this parameter will be ignored.
   */
  numberTo?: string;

  /**
   * If maskingFunction is set to Text, the number of characters to show unmasked in the beginning of the string. Otherwise, this parameter will be ignored.
   */
  prefixSize?: string;

  /**
   * If maskingFunction is set to Text, the number of characters to show unmasked at the end of the string. Otherwise, this parameter will be ignored.
   */
  suffixSize?: string;

  /**
   * If maskingFunction is set to Text, the character to use for masking the unexposed part of the string. Otherwise, this parameter will be ignored.
   */
  replacementString?: string;
}

/**
 * User activities of a data warehouse. This currently includes the count of running or suspended queries. For more information, please view the sys.dm_pdw_exec_requests dynamic management view (DMV).
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataWarehouseUserActivitiesProperties {
  /**
   * Count of running and suspended queries.
   */
  @visibility(Lifecycle.Read)
  activeQueriesCount?: int32;
}

/**
 * The properties of a deleted server.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DeletedServerProperties {
  /**
   * The version of the deleted server.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The deletion time of the deleted server.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionTime?: utcDateTime;

  /**
   * The original ID of the server before deletion.
   */
  @visibility(Lifecycle.Read)
  originalId?: string;

  /**
   * The fully qualified domain name of the server.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;
}

/**
 * The properties of a distributed availability group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DistributedAvailabilityGroupProperties {
  /**
   * Name of the distributed availability group
   */
  @visibility(Lifecycle.Read)
  distributedAvailabilityGroupName?: string;

  /**
   * ID of the distributed availability group
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  distributedAvailabilityGroupId?: Azure.Core.uuid;

  /**
   * Replication mode of the link
   */
  replicationMode?: ReplicationModeType;

  /**
   * SQL server side link role
   */
  @visibility(Lifecycle.Read)
  partnerLinkRole?: LinkRole;

  /**
   * SQL server side availability group name
   */
  partnerAvailabilityGroupName?: string;

  /**
   * SQL server side endpoint - IP or DNS resolvable name
   */
  partnerEndpoint?: string;

  /**
   * Managed instance side link role
   */
  instanceLinkRole?: LinkRole;

  /**
   * Managed instance side availability group name
   */
  instanceAvailabilityGroupName?: string;

  /**
   * The link failover mode - can be Manual if intended to be used for two-way failover with a supported SQL Server, or None for one-way failover to Azure.
   */
  failoverMode?: FailoverModeType;

  /**
   * Database seeding mode – can be Automatic (default), or Manual for supported scenarios.
   */
  seedingMode?: SeedingModeType;

  /**
   * Databases in the distributed availability group
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  databases?: DistributedAvailabilityGroupDatabase[];
}

/**
 * Database specific information
 */
model DistributedAvailabilityGroupDatabase {
  /**
   * The name of the database in link
   */
  databaseName?: string;

  /**
   * Managed instance replica id
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  instanceReplicaId?: Azure.Core.uuid;

  /**
   * SQL server replica id
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  partnerReplicaId?: Azure.Core.uuid;

  /**
   * Current link state
   */
  @visibility(Lifecycle.Read)
  replicaState?: string;

  /**
   * Seeding progress
   */
  @visibility(Lifecycle.Read)
  seedingProgress?: string;

  /**
   * Link health state
   */
  @visibility(Lifecycle.Read)
  synchronizationHealth?: ReplicaSynchronizationHealth;

  /**
   * Link connected state
   */
  @visibility(Lifecycle.Read)
  connectedState?: ReplicaConnectedState;

  /**
   * Last received LSN
   */
  @visibility(Lifecycle.Read)
  lastReceivedLsn?: string;

  /**
   * Last received LSN time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastReceivedTime?: utcDateTime;

  /**
   * Last sent LSN
   */
  @visibility(Lifecycle.Read)
  lastSentLsn?: string;

  /**
   * Last sent LSN time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSentTime?: utcDateTime;

  /**
   * Last commit LSN
   */
  @visibility(Lifecycle.Read)
  lastCommitLsn?: string;

  /**
   * Last commit LSN time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCommitTime?: utcDateTime;

  /**
   * Last hardened LSN
   */
  @visibility(Lifecycle.Read)
  lastHardenedLsn?: string;

  /**
   * Last hardened LSN time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHardenedTime?: utcDateTime;

  /**
   * Last backup LSN
   */
  @visibility(Lifecycle.Read)
  lastBackupLsn?: string;

  /**
   * Last backup LSN time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastBackupTime?: utcDateTime;

  /**
   * The most recent link connection error description
   */
  @visibility(Lifecycle.Read)
  mostRecentLinkError?: string;

  /**
   * SQL server certificate validity
   */
  @visibility(Lifecycle.Read)
  partnerAuthCertValidity?: CertificateInfo;

  /**
   * Replication lag when Managed Instance link side is primary
   */
  @visibility(Lifecycle.Read)
  instanceSendReplicationLagSeconds?: int32;

  /**
   * Redo lag when Managed Instance link side is primary
   */
  @visibility(Lifecycle.Read)
  instanceRedoReplicationLagSeconds?: int32;
}

/**
 * Certificate information
 */
model CertificateInfo {
  /**
   * The certificate name
   */
  @visibility(Lifecycle.Read)
  certificateName?: string;

  /**
   * The certificate expiry date
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDate?: utcDateTime;
}

/**
 * Distributed availability group failover.
 */
model DistributedAvailabilityGroupsFailoverRequest {
  /**
   * The failover type, can be ForcedAllowDataLoss or Planned.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  failoverType: FailoverType;
}

/**
 * Distributed availability group failover request.
 */
model DistributedAvailabilityGroupSetRole {
  /**
   * New role of managed instance in a distributed availability group, can be Primary or Secondary.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  instanceRole: InstanceRole;

  /**
   * The type of the role change, can be Planned or Forced.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  roleChangeType: RoleChangeType;
}

/**
 * A elastic pool operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ElasticPoolOperation extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: ElasticPoolOperationProperties;
}

/**
 * The properties of a elastic pool operation.
 */
model ElasticPoolOperationProperties {
  /**
   * The name of the elastic pool the operation is being performed on.
   */
  @visibility(Lifecycle.Read)
  elasticPoolName?: string;

  /**
   * The name of operation.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The friendly name of operation.
   */
  @visibility(Lifecycle.Read)
  operationFriendlyName?: string;

  /**
   * The percentage of the operation completed.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * The name of the server.
   */
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * The operation start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The operation state.
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * The operation error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * The operation error description.
   */
  @visibility(Lifecycle.Read)
  errorDescription?: string;

  /**
   * The operation error severity.
   */
  @visibility(Lifecycle.Read)
  errorSeverity?: int32;

  /**
   * Whether or not the error is a user error.
   */
  @visibility(Lifecycle.Read)
  isUserError?: boolean;

  /**
   * The estimated completion time of the operation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  estimatedCompletionTime?: utcDateTime;

  /**
   * The operation description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Whether the operation can be cancelled.
   */
  @visibility(Lifecycle.Read)
  isCancellable?: boolean;
}

/**
 * Properties of an elastic pool
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ElasticPoolProperties {
  /**
   * The state of the elastic pool.
   */
  @visibility(Lifecycle.Read)
  state?: ElasticPoolState;

  /**
   * The creation date of the elastic pool (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The storage limit for the database elastic pool in bytes.
   */
  maxSizeBytes?: int64;

  /**
   * Minimal capacity that serverless pool will not shrink below, if not paused
   */
  minCapacity?: float64;

  /**
   * The per database settings for the elastic pool.
   */
  perDatabaseSettings?: ElasticPoolPerDatabaseSettings;

  /**
   * Whether or not this elastic pool is zone redundant, which means the replicas of this elastic pool will be spread across multiple availability zones.
   */
  zoneRedundant?: boolean;

  /**
   * The license type to apply for this elastic pool.
   */
  licenseType?: ElasticPoolLicenseType;

  /**
   * Maintenance configuration id assigned to the elastic pool. This configuration defines the period when the maintenance updates will will occur.
   */
  maintenanceConfigurationId?: string;

  /**
   * The number of secondary replicas associated with the Business Critical, Premium, or Hyperscale edition elastic pool that are used to provide high availability. Applicable only to Hyperscale elastic pools.
   */
  highAvailabilityReplicaCount?: int32;

  /**
   * Time in minutes after which elastic pool is automatically paused. A value of -1 means that automatic pause is disabled
   */
  autoPauseDelay?: int32;

  /**
   * Type of enclave requested on the elastic pool.
   */
  preferredEnclaveType?: AlwaysEncryptedEnclaveType;

  /**
   * Specifies the availability zone the pool's primary replica is pinned to.
   */
  availabilityZone?: AvailabilityZoneType;

  /**
   * The name and tier of the current SKU.
   */
  @visibility(Lifecycle.Read)
  currentSku?: Sku;
}

/**
 * Per database settings of an elastic pool.
 */
model ElasticPoolPerDatabaseSettings {
  /**
   * The minimum capacity all databases are guaranteed.
   */
  minCapacity?: float64;

  /**
   * The maximum capacity any one database can consume.
   */
  maxCapacity?: float64;

  /**
   * Auto Pause Delay for per database within pool
   */
  autoPauseDelay?: int32;
}

/**
 * An elastic pool update.
 */
model ElasticPoolUpdate {
  /**
   * An ARM Resource SKU.
   */
  sku?: Sku;

  /**
   * Resource properties.
   */
  properties?: ElasticPoolUpdateProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Properties of an elastic pool
 */
model ElasticPoolUpdateProperties {
  /**
   * The storage limit for the database elastic pool in bytes.
   */
  maxSizeBytes?: int64;

  /**
   * Minimal capacity that serverless pool will not shrink below, if not paused
   */
  minCapacity?: float64;

  /**
   * The per database settings for the elastic pool.
   */
  perDatabaseSettings?: ElasticPoolPerDatabaseSettings;

  /**
   * Whether or not this elastic pool is zone redundant, which means the replicas of this elastic pool will be spread across multiple availability zones.
   */
  zoneRedundant?: boolean;

  /**
   * The license type to apply for this elastic pool.
   */
  licenseType?: ElasticPoolLicenseType;

  /**
   * Maintenance configuration id assigned to the elastic pool. This configuration defines the period when the maintenance updates will will occur.
   */
  maintenanceConfigurationId?: string;

  /**
   * The number of secondary replicas associated with the Business Critical, Premium, or Hyperscale edition elastic pool that are used to provide high availability. Applicable only to Hyperscale elastic pools.
   */
  highAvailabilityReplicaCount?: int32;

  /**
   * Time in minutes after which elastic pool is automatically paused. A value of -1 means that automatic pause is disabled
   */
  autoPauseDelay?: int32;

  /**
   * Type of enclave requested on the elastic pool.
   */
  preferredEnclaveType?: AlwaysEncryptedEnclaveType;

  /**
   * Specifies the availability zone the pool's primary replica is pinned to.
   */
  availabilityZone?: AvailabilityZoneType;

  /**
   * The name and tier of the current SKU.
   */
  @visibility(Lifecycle.Read)
  currentSku?: Sku;
}

/**
 * Properties for an encryption protector execution.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EncryptionProtectorProperties {
  /**
   * Subregion of the encryption protector.
   */
  @visibility(Lifecycle.Read)
  subregion?: string;

  /**
   * The name of the server key.
   */
  serverKeyName?: string;

  /**
   * The encryption protector type like 'ServiceManaged', 'AzureKeyVault'.
   */
  serverKeyType: ServerKeyType;

  /**
   * The URI of the server key.
   */
  @visibility(Lifecycle.Read)
  uri?: string;

  /**
   * Thumbprint of the server key.
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * Key auto rotation opt-in flag. Either true or false.
   */
  autoRotationEnabled?: boolean;

  /**
   * The version of the server key being used as encryption protector
   */
  @visibility(Lifecycle.Read)
  keyVersion?: string;
}

/**
 * The properties of an endpoint certificate.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EndpointCertificateProperties {
  /**
   * The certificate public blob
   */
  publicBlob?: string;
}

/**
 * Properties of a failover group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FailoverGroupProperties {
  /**
   * Read-write endpoint of the failover group instance.
   */
  readWriteEndpoint: FailoverGroupReadWriteEndpoint;

  /**
   * Read-only endpoint of the failover group instance.
   */
  readOnlyEndpoint?: FailoverGroupReadOnlyEndpoint;

  /**
   * Local replication role of the failover group instance.
   */
  @visibility(Lifecycle.Read)
  replicationRole?: FailoverGroupReplicationRole;

  /**
   * Replication state of the failover group instance.
   */
  @visibility(Lifecycle.Read)
  replicationState?: string;

  /**
   * List of partner server information for the failover group.
   */
  partnerServers: PartnerInfo[];

  /**
   * List of databases in the failover group.
   */
  databases?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/databases";
    }
  ]>[];

  /**
   * Databases secondary type on partner server.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secondaryType?: FailoverGroupDatabasesSecondaryType;
}

/**
 * Read-write endpoint of the failover group instance.
 */
model FailoverGroupReadWriteEndpoint {
  /**
   * Failover policy of the read-write endpoint for the failover group. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.
   */
  failoverPolicy: ReadWriteEndpointFailoverPolicy;

  /**
   * Grace period before failover with data loss is attempted for the read-write endpoint. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.
   */
  failoverWithDataLossGracePeriodMinutes?: int32;
}

/**
 * Read-only endpoint of the failover group instance.
 */
model FailoverGroupReadOnlyEndpoint {
  /**
   * Failover policy of the read-only endpoint for the failover group.
   */
  failoverPolicy?: ReadOnlyEndpointFailoverPolicy;

  /**
   * The target partner server where the read-only endpoint points to.
   */
  targetServer?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers";
    }
  ]>;
}

/**
 * Partner server information for the failover group.
 */
model PartnerInfo {
  /**
   * Resource identifier of the partner server.
   */
  id: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers";
    }
  ]>;

  /**
   * Geo location of the partner server.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Replication role of the partner server.
   */
  @visibility(Lifecycle.Read)
  replicationRole?: FailoverGroupReplicationRole;
}

/**
 * A failover group update request.
 */
model FailoverGroupUpdate {
  /**
   * Resource properties.
   */
  properties?: FailoverGroupUpdateProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Properties of a failover group update.
 */
model FailoverGroupUpdateProperties {
  /**
   * Read-write endpoint of the failover group instance.
   */
  readWriteEndpoint?: FailoverGroupReadWriteEndpoint;

  /**
   * Read-only endpoint of the failover group instance.
   */
  readOnlyEndpoint?: FailoverGroupReadOnlyEndpoint;

  /**
   * List of databases in the failover group.
   */
  databases?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/databases";
    }
  ]>[];

  /**
   * List of partner server information for the failover group.
   */
  partnerServers?: PartnerInfo[];

  /**
   * Databases secondary type on partner server.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secondaryType?: FailoverGroupDatabasesSecondaryType;
}

/**
 * The properties of a server firewall rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerFirewallRuleProperties {
  /**
   * The start IP address of the firewall rule. Must be IPv4 format. Use value '0.0.0.0' for all Azure-internal IP addresses.
   */
  startIpAddress?: string;

  /**
   * The end IP address of the firewall rule. Must be IPv4 format. Must be greater than or equal to startIpAddress. Use value '0.0.0.0' for all Azure-internal IP addresses.
   */
  endIpAddress?: string;
}

/**
 * ARM proxy resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource
model ProxyResourceWithWritableName extends ResourceWithWritableName {}

/**
 * ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource
model ResourceWithWritableName {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name.
   */
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * A list of server firewall rules.
 */
model FirewallRuleList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  values?: FirewallRule[];
}

/**
 * The properties of the geo backup policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GeoBackupPolicyProperties {
  /**
   * The state of the geo backup policy.
   */
  state: GeoBackupPolicyState;

  /**
   * The storage type of the geo backup policy.
   */
  @visibility(Lifecycle.Read)
  storageType?: string;
}

/**
 * Properties of a instance failover group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InstanceFailoverGroupProperties {
  /**
   * Type of the geo-secondary instance. Set 'Standby' if the instance is used as a DR option only.
   */
  secondaryType?: SecondaryInstanceType;

  /**
   * Read-write endpoint of the failover group instance.
   */
  readWriteEndpoint: InstanceFailoverGroupReadWriteEndpoint;

  /**
   * Read-only endpoint of the failover group instance.
   */
  readOnlyEndpoint?: InstanceFailoverGroupReadOnlyEndpoint;

  /**
   * Local replication role of the failover group instance.
   */
  @visibility(Lifecycle.Read)
  replicationRole?: InstanceFailoverGroupReplicationRole;

  /**
   * Replication state of the failover group instance.
   */
  @visibility(Lifecycle.Read)
  replicationState?: string;

  /**
   * Partner region information for the failover group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  partnerRegions: PartnerRegionInfo[];

  /**
   * List of managed instance pairs in the failover group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  managedInstancePairs: ManagedInstancePairInfo[];
}

/**
 * Read-write endpoint of the failover group instance.
 */
model InstanceFailoverGroupReadWriteEndpoint {
  /**
   * Failover policy of the read-write endpoint for the failover group. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.
   */
  failoverPolicy: ReadWriteEndpointFailoverPolicy;

  /**
   * Grace period before failover with data loss is attempted for the read-write endpoint. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.
   */
  failoverWithDataLossGracePeriodMinutes?: int32;
}

/**
 * Read-only endpoint of the failover group instance.
 */
model InstanceFailoverGroupReadOnlyEndpoint {
  /**
   * Failover policy of the read-only endpoint for the failover group.
   */
  failoverPolicy?: ReadOnlyEndpointFailoverPolicy;
}

/**
 * Partner region information for the failover group.
 */
model PartnerRegionInfo {
  /**
   * Geo location of the partner managed instances.
   */
  location?: string;

  /**
   * Replication role of the partner managed instances.
   */
  @visibility(Lifecycle.Read)
  replicationRole?: InstanceFailoverGroupReplicationRole;
}

/**
 * Pairs of Managed Instances in the failover group.
 */
model ManagedInstancePairInfo {
  /**
   * Id of Primary Managed Instance in pair.
   */
  primaryManagedInstanceId?: string;

  /**
   * Id of Partner Managed Instance in pair.
   */
  partnerManagedInstanceId?: string;
}

/**
 * The properties of a instance pool operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InstancePoolOperationProperties {
  /**
   * The name of the instance pool the operation is being performed on.
   */
  @visibility(Lifecycle.Read)
  instancePoolName?: string;

  /**
   * The name of operation.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The friendly name of operation.
   */
  @visibility(Lifecycle.Read)
  operationFriendlyName?: string;

  /**
   * The percentage of the operation completed.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * The operation start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The operation state.
   */
  @visibility(Lifecycle.Read)
  state?: ManagementOperationState;

  /**
   * The operation error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * The operation error description.
   */
  @visibility(Lifecycle.Read)
  errorDescription?: string;

  /**
   * The operation error severity.
   */
  @visibility(Lifecycle.Read)
  errorSeverity?: int32;

  /**
   * Error type (e.g. None, User).
   */
  @visibility(Lifecycle.Read)
  errorType?: ErrorType;

  /**
   * The estimated completion time of the operation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  estimatedCompletionTime?: utcDateTime;

  /**
   * The operation description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Whether the operation can be cancelled.
   */
  @visibility(Lifecycle.Read)
  isCancellable?: boolean;
}

/**
 * Properties of an instance pool.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InstancePoolProperties {
  /**
   * Resource ID of the subnet to place this instance pool in.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetId: string;

  /**
   * Count of vCores belonging to this instance pool.
   */
  vCores: int32;

  /**
   * The license type. Possible values are 'LicenseIncluded' (price for SQL license is included) and 'BasePrice' (without SQL license price).
   */
  licenseType: InstancePoolLicenseType;

  /**
   * The Dns Zone that the managed instance pool is in.
   */
  @visibility(Lifecycle.Read)
  dnsZone?: string;

  /**
   * Specifies maintenance configuration id to apply to this managed instance.
   */
  maintenanceConfigurationId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Maintenance/publicMaintenanceConfigurations";
    }
  ]>;
}

/**
 * An update to an Instance pool.
 */
model InstancePoolUpdate {
  /**
   * The name and tier of the SKU.
   */
  sku?: Sku;

  /**
   * Resource properties.
   */
  properties?: InstancePoolProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * The properties of an IPv6 server firewall rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IPv6ServerFirewallRuleProperties {
  /**
   * The start IP address of the firewall rule. Must be IPv6 format.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  startIPv6Address?: string;

  /**
   * The end IP address of the firewall rule. Must be IPv6 format. Must be greater than or equal to startIpv6Address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endIPv6Address?: string;
}

/**
 * Azure Active Directory identity configuration for a resource.
 */
model JobAgentIdentity {
  /**
   * The job agent identity tenant id
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenantId?: Azure.Core.uuid;

  /**
   * The job agent identity type
   */
  type: JobAgentIdentityType;

  /**
   * The resource ids of the user assigned identities to use
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<JobAgentUserAssignedIdentity>;
}

/**
 * Azure Active Directory identity configuration for a resource.
 */
model JobAgentUserAssignedIdentity {
  /**
   * The Azure Active Directory principal id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  principalId?: Azure.Core.uuid;

  /**
   * The Azure Active Directory client id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  clientId?: Azure.Core.uuid;
}

/**
 * Properties of a job agent.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JobAgentProperties {
  /**
   * Resource ID of the database to store job metadata in.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  databaseId: Azure.Core.armResourceIdentifier;

  /**
   * The state of the job agent.
   */
  @visibility(Lifecycle.Read)
  state?: JobAgentState;
}

/**
 * An update to an Azure SQL job agent.
 */
model JobAgentUpdate {
  /**
   * Managed identity assigned to job agent
   */
  identity?: JobAgentIdentity;

  /**
   * The name and tier of the SKU.
   */
  sku?: Sku;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Properties of a job credential.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JobCredentialProperties {
  /**
   * The credential user name.
   */
  username: string;

  /**
   * The credential password.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  password: string;
}

/**
 * Properties for an Azure SQL Database Elastic job execution.
 */
model JobExecutionProperties {
  /**
   * The job version number.
   */
  @visibility(Lifecycle.Read)
  jobVersion?: int32;

  /**
   * The job step name.
   */
  @visibility(Lifecycle.Read)
  stepName?: string;

  /**
   * The job step id.
   */
  @visibility(Lifecycle.Read)
  stepId?: int32;

  /**
   * The unique identifier of the job execution.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  jobExecutionId?: Azure.Core.uuid;

  /**
   * The detailed state of the job execution.
   */
  @visibility(Lifecycle.Read)
  lifecycle?: JobExecutionLifecycle;

  /**
   * The ARM provisioning state of the job execution.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The time that the job execution was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * The time that the job execution started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The time that the job execution completed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Number of times the job execution has been attempted.
   */
  currentAttempts?: int32;

  /**
   * Start time of the current attempt.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  currentAttemptStartTime?: utcDateTime;

  /**
   * The last status or error message.
   */
  @visibility(Lifecycle.Read)
  lastMessage?: string;

  /**
   * The target that this execution is executed on.
   */
  @visibility(Lifecycle.Read)
  target?: JobExecutionTarget;
}

/**
 * The target that a job execution is executed on.
 */
model JobExecutionTarget {
  /**
   * The type of the target.
   */
  @visibility(Lifecycle.Read)
  type?: JobTargetType;

  /**
   * The server name.
   */
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * The database name.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;
}

/**
 * Properties of job agent private endpoint.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JobPrivateEndpointProperties {
  /**
   * ARM resource id of the server the private endpoint will target.
   */
  targetServerAzureResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers";
    }
  ]>;

  /**
   * Private endpoint id of the private endpoint.
   */
  @visibility(Lifecycle.Read)
  privateEndpointId?: string;
}

/**
 * Properties of a job.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JobProperties {
  /**
   * User-defined description of the job.
   */
  description?: string = "";

  /**
   * The job version number.
   */
  @visibility(Lifecycle.Read)
  version?: int32;

  /**
   * Schedule properties of the job.
   */
  schedule?: JobSchedule;
}

/**
 * Scheduling properties of a job.
 */
model JobSchedule {
  /**
   * Schedule start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime = utcDateTime.fromISO("0001-01-01T05:30:00+05:30");

  /**
   * Schedule end time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime = utcDateTime.fromISO("9999-12-31T17:29:59+05:30");

  /**
   * Schedule interval type
   */
  type?: JobScheduleType = JobScheduleType.Once;

  /**
   * Whether or not the schedule is enabled.
   */
  enabled?: boolean;

  /**
   * Value of the schedule's recurring interval, if the ScheduleType is recurring. ISO8601 duration format.
   */
  interval?: string;
}

/**
 * Properties of a job step.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JobStepProperties {
  /**
   * The job step's index within the job. If not specified when creating the job step, it will be created as the last step. If not specified when updating the job step, the step id is not modified.
   */
  stepId?: int32;

  /**
   * The resource ID of the target group that the job step will be executed on.
   */
  targetGroup: string;

  /**
   * The resource ID of the job credential that will be used to connect to the targets.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  credential?: string;

  /**
   * The action payload of the job step.
   */
  action: JobStepAction;

  /**
   * Output destination properties of the job step.
   */
  output?: JobStepOutput;

  /**
   * Execution options for the job step.
   */
  executionOptions?: JobStepExecutionOptions;
}

/**
 * The action to be executed by a job step.
 */
model JobStepAction {
  /**
   * Type of action being executed by the job step.
   */
  type?: JobStepActionType = JobStepActionType.TSql;

  /**
   * The source of the action to execute.
   */
  source?: JobStepActionSource = JobStepActionSource.Inline;

  /**
   * The action value, for example the text of the T-SQL script to execute.
   */
  value: string;
}

/**
 * The output configuration of a job step.
 */
model JobStepOutput {
  /**
   * The output destination type.
   */
  type?: JobStepOutputType = JobStepOutputType.SqlDatabase;

  /**
   * The output destination subscription id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId?: Azure.Core.uuid;

  /**
   * The output destination resource group.
   */
  resourceGroupName?: string;

  /**
   * The output destination server name.
   */
  serverName: string;

  /**
   * The output destination database.
   */
  databaseName: string;

  /**
   * The output destination schema.
   */
  schemaName?: string = "dbo";

  /**
   * The output destination table.
   */
  tableName: string;

  /**
   * The resource ID of the credential to use to connect to the output destination.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  credential?: string;
}

/**
 * The execution options of a job step.
 */
model JobStepExecutionOptions {
  /**
   * Execution timeout for the job step.
   */
  timeoutSeconds?: int32 = 43200;

  /**
   * Maximum number of times the job step will be reattempted if the first attempt fails.
   */
  retryAttempts?: int32 = 10;

  /**
   * Initial delay between retries for job step execution.
   */
  initialRetryIntervalSeconds?: int32 = 1;

  /**
   * The maximum amount of time to wait between retries for job step execution.
   */
  maximumRetryIntervalSeconds?: int32 = 120;

  /**
   * The backoff multiplier for the time between retries.
   */
  retryIntervalBackoffMultiplier?: float32 = 2;
}

/**
 * Properties of job target group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JobTargetGroupProperties {
  /**
   * Members of the target group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  members: JobTarget[];
}

/**
 * A job target, for example a specific database or a container of databases that is evaluated during job execution.
 */
model JobTarget {
  /**
   * Whether the target is included or excluded from the group.
   */
  membershipType?: JobTargetGroupMembershipType = JobTargetGroupMembershipType.Include;

  /**
   * The target type.
   */
  type: JobTargetType;

  /**
   * The target server name.
   */
  serverName?: string;

  /**
   * The target database name.
   */
  databaseName?: string;

  /**
   * The target elastic pool name.
   */
  elasticPoolName?: string;

  /**
   * The target shard map.
   */
  shardMapName?: string;

  /**
   * The resource ID of the credential that is used during job execution to connect to the target and determine the list of databases inside the target.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  refreshCredential?: string;
}

/**
 * The properties of a database ledger digest upload settings.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LedgerDigestUploadsProperties {
  /**
   * The digest storage endpoint, which must be either an Azure blob storage endpoint or an URI for Azure Confidential Ledger.
   */
  digestStorageEndpoint?: string;

  /**
   * Specifies the state of ledger digest upload.
   */
  @visibility(Lifecycle.Read)
  state?: LedgerDigestUploadsState;
}

/**
 * The location capability.
 */
model LocationCapabilities {
  /**
   * The location name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The list of supported server versions.
   */
  @visibility(Lifecycle.Read)
  supportedServerVersions?: ServerVersionCapability[];

  /**
   * The list of supported managed instance versions.
   */
  @visibility(Lifecycle.Read)
  supportedManagedInstanceVersions?: ManagedInstanceVersionCapability[];

  /**
   * The list of supported job agent versions.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  supportedJobAgentVersions?: JobAgentVersionCapability[];

  /**
   * Whether or not the subscription is allowed to provision zone resilient resources.
   */
  @visibility(Lifecycle.Read)
  isZoneResilientProvisioningAllowed?: boolean;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The server capability
 */
model ServerVersionCapability {
  /**
   * The server version name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The list of supported database editions.
   */
  @visibility(Lifecycle.Read)
  supportedEditions?: EditionCapability[];

  /**
   * The list of supported elastic pool editions.
   */
  @visibility(Lifecycle.Read)
  supportedElasticPoolEditions?: ElasticPoolEditionCapability[];

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The edition capability.
 */
model EditionCapability {
  /**
   * The database edition name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The list of supported service objectives for the edition.
   */
  @visibility(Lifecycle.Read)
  supportedServiceLevelObjectives?: ServiceObjectiveCapability[];

  /**
   * Whether or not zone redundancy is supported for the edition.
   */
  @visibility(Lifecycle.Read)
  zoneRedundant?: boolean;

  /**
   * The read scale capability for the edition.
   */
  @visibility(Lifecycle.Read)
  readScale?: ReadScaleCapability;

  /**
   * The list of supported storage capabilities for this edition
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedStorageCapabilities?: StorageCapability[];

  /**
   * Whether or not zone pinning is supported for the edition.
   */
  @visibility(Lifecycle.Read)
  zonePinning?: boolean;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The service objectives capability.
 */
model ServiceObjectiveCapability {
  /**
   * The unique ID of the service objective.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  id?: Azure.Core.uuid;

  /**
   * The service objective name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The list of supported maximum database sizes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedMaxSizes?: MaxSizeRangeCapability[];

  /**
   * The performance level.
   */
  @visibility(Lifecycle.Read)
  performanceLevel?: PerformanceLevelCapability;

  /**
   * The sku.
   */
  @visibility(Lifecycle.Read)
  sku?: Sku;

  /**
   * List of supported license types.
   */
  @visibility(Lifecycle.Read)
  supportedLicenseTypes?: LicenseTypeCapability[];

  /**
   * The included (free) max size.
   */
  @visibility(Lifecycle.Read)
  includedMaxSize?: MaxSizeCapability;

  /**
   * Whether or not zone redundancy is supported for the service objective.
   */
  @visibility(Lifecycle.Read)
  zoneRedundant?: boolean;

  /**
   * Supported time range for auto pause delay
   */
  @visibility(Lifecycle.Read)
  supportedAutoPauseDelay?: AutoPauseDelayTimeRange;

  /**
   * List of supported min capacities
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedMinCapacities?: MinCapacityCapability[];

  /**
   * The compute model
   */
  @visibility(Lifecycle.Read)
  computeModel?: string;

  /**
   * List of supported maintenance configurations
   */
  @visibility(Lifecycle.Read)
  supportedMaintenanceConfigurations?: MaintenanceConfigurationCapability[];

  /**
   * Whether or not zone pinning is supported.
   */
  @visibility(Lifecycle.Read)
  zonePinning?: boolean;

  /**
   * List of supported availability zones
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedZones?: ZonePinningCapability[];

  /**
   * List of supported free limit exhaustion behaviors
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  supportedFreeLimitExhaustionBehaviors?: FreeLimitExhaustionBehaviorCapability[];

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The maximum size range capability.
 */
model MaxSizeRangeCapability {
  /**
   * Minimum value.
   */
  @visibility(Lifecycle.Read)
  minValue?: MaxSizeCapability;

  /**
   * Maximum value.
   */
  @visibility(Lifecycle.Read)
  maxValue?: MaxSizeCapability;

  /**
   * Scale/step size for discrete values between the minimum value and the maximum value.
   */
  @visibility(Lifecycle.Read)
  scaleSize?: MaxSizeCapability;

  /**
   * Size of transaction log.
   */
  @visibility(Lifecycle.Read)
  logSize?: LogSizeCapability;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The maximum size capability.
 */
model MaxSizeCapability {
  /**
   * The maximum size limit (see 'unit' for the units).
   */
  @visibility(Lifecycle.Read)
  limit?: int32;

  /**
   * The units that the limit is expressed in.
   */
  @visibility(Lifecycle.Read)
  unit?: MaxSizeUnit;
}

/**
 * The log size capability.
 */
model LogSizeCapability {
  /**
   * The log size limit (see 'unit' for the units).
   */
  @visibility(Lifecycle.Read)
  limit?: int32;

  /**
   * The units that the limit is expressed in.
   */
  @visibility(Lifecycle.Read)
  unit?: LogSizeUnit;
}

/**
 * The performance level capability.
 */
model PerformanceLevelCapability {
  /**
   * Performance level value.
   */
  @visibility(Lifecycle.Read)
  value?: float64;

  /**
   * Unit type used to measure performance level.
   */
  @visibility(Lifecycle.Read)
  unit?: PerformanceLevelUnit;
}

/**
 * The license type capability
 */
model LicenseTypeCapability {
  /**
   * License type identifier.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * Supported auto pause delay time range
 */
model AutoPauseDelayTimeRange {
  /**
   * Minimum value
   */
  @visibility(Lifecycle.Read)
  minValue?: int32;

  /**
   * Maximum value
   */
  @visibility(Lifecycle.Read)
  maxValue?: int32;

  /**
   * Step value for discrete values between the minimum value and the maximum value.
   */
  @visibility(Lifecycle.Read)
  stepSize?: int32;

  /**
   * Default value is no value is provided
   */
  @visibility(Lifecycle.Read)
  default?: int32;

  /**
   * Unit of time that delay is expressed in
   */
  @visibility(Lifecycle.Read)
  unit?: PauseDelayTimeUnit;

  /**
   * Value that is used to not pause (infinite delay before pause)
   */
  @visibility(Lifecycle.Read)
  doNotPauseValue?: int32;
}

/**
 * The min capacity capability
 */
model MinCapacityCapability {
  /**
   * Min capacity value
   */
  @visibility(Lifecycle.Read)
  value?: float64;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The maintenance configuration capability
 */
model MaintenanceConfigurationCapability {
  /**
   * Maintenance configuration name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Whether or not zone redundancy is supported for the maintenance configuration.
   */
  @visibility(Lifecycle.Read)
  zoneRedundant?: boolean;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The zone pinning capability
 */
model ZonePinningCapability {
  /**
   * Name of the availability zone
   */
  @visibility(Lifecycle.Read)
  availabilityZone?: string;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * Supported free limit exhaustion behavior options
 */
model FreeLimitExhaustionBehaviorCapability {
  /**
   * Free limit exhaustion behavior type
   */
  @visibility(Lifecycle.Read)
  exhaustionBehaviorType?: FreeLimitExhaustionBehavior;

  /**
   * Free limit exhaustion behavior status
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;
}

/**
 * The read scale capability.
 */
model ReadScaleCapability {
  /**
   * The maximum number of read scale replicas.
   */
  @visibility(Lifecycle.Read)
  maxNumberOfReplicas?: int32;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The storage account type capability.
 */
model StorageCapability {
  /**
   * The storage account type for the database's backups.
   */
  @visibility(Lifecycle.Read)
  storageAccountType?: StorageCapabilityStorageAccountType;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The elastic pool edition capability.
 */
model ElasticPoolEditionCapability {
  /**
   * The elastic pool edition name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The list of supported elastic pool DTU levels for the edition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedElasticPoolPerformanceLevels?: ElasticPoolPerformanceLevelCapability[];

  /**
   * Whether or not zone redundancy is supported for the edition.
   */
  @visibility(Lifecycle.Read)
  zoneRedundant?: boolean;

  /**
   * Whether or not zone pinning is supported for the edition.
   */
  @visibility(Lifecycle.Read)
  zonePinning?: boolean;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The Elastic Pool performance level capability.
 */
model ElasticPoolPerformanceLevelCapability {
  /**
   * The performance level for the pool.
   */
  @visibility(Lifecycle.Read)
  performanceLevel?: PerformanceLevelCapability;

  /**
   * The sku.
   */
  @visibility(Lifecycle.Read)
  sku?: Sku;

  /**
   * List of supported license types.
   */
  @visibility(Lifecycle.Read)
  supportedLicenseTypes?: LicenseTypeCapability[];

  /**
   * The maximum number of databases supported.
   */
  @visibility(Lifecycle.Read)
  maxDatabaseCount?: int32;

  /**
   * The included (free) max size for this performance level.
   */
  @visibility(Lifecycle.Read)
  includedMaxSize?: MaxSizeCapability;

  /**
   * The list of supported max sizes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedMaxSizes?: MaxSizeRangeCapability[];

  /**
   * The list of supported per database max sizes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedPerDatabaseMaxSizes?: MaxSizeRangeCapability[];

  /**
   * The list of supported per database max performance levels.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedPerDatabaseMaxPerformanceLevels?: ElasticPoolPerDatabaseMaxPerformanceLevelCapability[];

  /**
   * Whether or not zone redundancy is supported for the performance level.
   */
  @visibility(Lifecycle.Read)
  zoneRedundant?: boolean;

  /**
   * List of supported maintenance configurations
   */
  @visibility(Lifecycle.Read)
  supportedMaintenanceConfigurations?: MaintenanceConfigurationCapability[];

  /**
   * List of supported min capacities
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  supportedMinCapacities?: MinCapacityCapability[];

  /**
   * Supported time range for auto pause delay
   */
  @visibility(Lifecycle.Read)
  supportedAutoPauseDelay?: AutoPauseDelayTimeRange;

  /**
   * Supported time range for per database auto pause delay
   */
  @visibility(Lifecycle.Read)
  supportedPerDatabaseAutoPauseDelay?: PerDatabaseAutoPauseDelayTimeRange;

  /**
   * List of supported availability zones
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedZones?: ZonePinningCapability[];

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The max per-database performance level capability.
 */
model ElasticPoolPerDatabaseMaxPerformanceLevelCapability {
  /**
   * The maximum performance level per database.
   */
  @visibility(Lifecycle.Read)
  limit?: float64;

  /**
   * Unit type used to measure performance level.
   */
  @visibility(Lifecycle.Read)
  unit?: PerformanceLevelUnit;

  /**
   * The list of supported min database performance levels.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedPerDatabaseMinPerformanceLevels?: ElasticPoolPerDatabaseMinPerformanceLevelCapability[];

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The minimum per-database performance level capability.
 */
model ElasticPoolPerDatabaseMinPerformanceLevelCapability {
  /**
   * The minimum performance level per database.
   */
  @visibility(Lifecycle.Read)
  limit?: float64;

  /**
   * Unit type used to measure performance level.
   */
  @visibility(Lifecycle.Read)
  unit?: PerformanceLevelUnit;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * Supported auto pause delay time range
 */
model PerDatabaseAutoPauseDelayTimeRange {
  /**
   * Minimum value
   */
  @visibility(Lifecycle.Read)
  minValue?: int32;

  /**
   * Maximum value
   */
  @visibility(Lifecycle.Read)
  maxValue?: int32;

  /**
   * Step value for discrete values between the minimum value and the maximum value.
   */
  @visibility(Lifecycle.Read)
  stepSize?: int32;

  /**
   * Default value if no value is provided
   */
  @visibility(Lifecycle.Read)
  default?: int32;

  /**
   * Unit of time that delay is expressed in
   */
  @visibility(Lifecycle.Read)
  unit?: PauseDelayTimeUnit;

  /**
   * Value that is used to not pause (infinite delay before pause)
   */
  @visibility(Lifecycle.Read)
  doNotPauseValue?: int32;
}

/**
 * The managed instance capability
 */
model ManagedInstanceVersionCapability {
  /**
   * The server version name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The list of supported managed instance editions.
   */
  @visibility(Lifecycle.Read)
  supportedEditions?: ManagedInstanceEditionCapability[];

  /**
   * The list of supported instance pool editions.
   */
  @visibility(Lifecycle.Read)
  supportedInstancePoolEditions?: InstancePoolEditionCapability[];

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The managed server capability
 */
model ManagedInstanceEditionCapability {
  /**
   * The managed server version name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Whether or not this is a GPv2 variant of General Purpose edition.
   */
  @visibility(Lifecycle.Read)
  isGeneralPurposeV2?: boolean;

  /**
   * The supported families.
   */
  @visibility(Lifecycle.Read)
  supportedFamilies?: ManagedInstanceFamilyCapability[];

  /**
   * The list of supported storage capabilities for this edition
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedStorageCapabilities?: StorageCapability[];

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The managed server family capability.
 */
model ManagedInstanceFamilyCapability {
  /**
   * Family name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * SKU name.
   */
  @visibility(Lifecycle.Read)
  sku?: string;

  /**
   * Whether or not zone redundancy is supported for the family.
   */
  @visibility(Lifecycle.Read)
  zoneRedundant?: boolean;

  /**
   * List of supported license types.
   */
  @visibility(Lifecycle.Read)
  supportedLicenseTypes?: LicenseTypeCapability[];

  /**
   * List of supported virtual cores values.
   */
  @visibility(Lifecycle.Read)
  supportedVcoresValues?: ManagedInstanceVcoresCapability[];

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The managed instance virtual cores capability.
 */
model ManagedInstanceVcoresCapability {
  /**
   * The virtual cores identifier.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The virtual cores value.
   */
  @visibility(Lifecycle.Read)
  value?: int32;

  /**
   * Supported memory sizes in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedMemorySizesInGB?: MaxLimitRangeCapability;

  /**
   * Memory limit MB ranges.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedMemoryLimitsMB?: MaxLimitRangeCapability;

  /**
   * Included size.
   */
  @visibility(Lifecycle.Read)
  includedMaxSize?: MaxSizeCapability;

  /**
   * Storage size ranges.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedStorageSizes?: MaxSizeRangeCapability[];

  /**
   * Included storage IOps.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  includedStorageIOps?: int64;

  /**
   * Storage IOps ranges.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedStorageIOps?: MaxLimitRangeCapability;

  /**
   * Min IOps override factor per selected storage GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  iopsMinValueOverrideFactorPerSelectedStorageGB?: float64;

  /**
   * Included IOps override factor per selected storage GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  iopsIncludedValueOverrideFactorPerSelectedStorageGB?: float64;

  /**
   * Included storage throughput MBps.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  includedStorageThroughputMBps?: int64;

  /**
   * Storage throughput MBps ranges.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedStorageThroughputMBps?: MaxLimitRangeCapability;

  /**
   * Min throughput MBps override factor per selected storage GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  throughputMBpsMinValueOverrideFactorPerSelectedStorageGB?: float64;

  /**
   * Included throughput MBps override factor per selected storage GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  throughputMBpsIncludedValueOverrideFactorPerSelectedStorageGB?: float64;

  /**
   * True if this service objective is supported for managed instances in an instance pool.
   */
  @visibility(Lifecycle.Read)
  instancePoolSupported?: boolean;

  /**
   * True if this service objective is supported for standalone managed instances.
   */
  @visibility(Lifecycle.Read)
  standaloneSupported?: boolean;

  /**
   * List of supported maintenance configurations
   */
  @visibility(Lifecycle.Read)
  supportedMaintenanceConfigurations?: ManagedInstanceMaintenanceConfigurationCapability[];

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The maximum limit range capability.
 */
model MaxLimitRangeCapability {
  /**
   * Minimum value.
   */
  @visibility(Lifecycle.Read)
  minValue?: int64;

  /**
   * Maximum value.
   */
  @visibility(Lifecycle.Read)
  maxValue?: int64;

  /**
   * Scale/step size for discrete values between the minimum value and the maximum value.
   */
  @visibility(Lifecycle.Read)
  scaleSize?: int64;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The maintenance configuration capability
 */
model ManagedInstanceMaintenanceConfigurationCapability {
  /**
   * Maintenance configuration name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The instance pool capability
 */
model InstancePoolEditionCapability {
  /**
   * The instance pool version name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The supported families.
   */
  @visibility(Lifecycle.Read)
  supportedFamilies?: InstancePoolFamilyCapability[];

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The instance pool family capability.
 */
model InstancePoolFamilyCapability {
  /**
   * Family name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * List of supported license types.
   */
  @visibility(Lifecycle.Read)
  supportedLicenseTypes?: LicenseTypeCapability[];

  /**
   * List of supported virtual cores values.
   */
  @visibility(Lifecycle.Read)
  supportedVcoresValues?: InstancePoolVcoresCapability[];

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The managed instance virtual cores capability.
 */
model InstancePoolVcoresCapability {
  /**
   * The virtual cores identifier.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The virtual cores value.
   */
  @visibility(Lifecycle.Read)
  value?: int32;

  /**
   * Storage limit.
   */
  @visibility(Lifecycle.Read)
  storageLimit?: MaxSizeCapability;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The job agent version capability.
 */
model JobAgentVersionCapability {
  /**
   * The job agent version name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The list of supported editions.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  supportedEditions?: JobAgentEditionCapability[];

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The job agent edition capability.
 */
model JobAgentEditionCapability {
  /**
   * The job agent edition name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The list of supported service level objectives for the edition.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  supportedServiceLevelObjectives?: JobAgentServiceLevelObjectiveCapability[];

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * The job agent service level objective capability.
 */
model JobAgentServiceLevelObjectiveCapability {
  /**
   * The service objective name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The sku.
   */
  @visibility(Lifecycle.Read)
  sku?: Sku;

  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  reason?: string;
}

/**
 * Properties of a long term retention backup
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LongTermRetentionBackupProperties {
  /**
   * The server name that the backup database belong to.
   */
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * The create time of the server.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  serverCreateTime?: utcDateTime;

  /**
   * The name of the database the backup belong to
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * The delete time of the database
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  databaseDeletionTime?: utcDateTime;

  /**
   * The time the backup was taken
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupTime?: utcDateTime;

  /**
   * The time the long term retention backup will expire.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupExpirationTime?: utcDateTime;

  /**
   * The storage redundancy type of the backup
   */
  @visibility(Lifecycle.Read)
  backupStorageRedundancy?: BackupStorageRedundancy;

  /**
   * The storage redundancy type of the backup
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  requestedBackupStorageRedundancy?: BackupStorageRedundancy;

  /**
   * The setting whether the LTR backup is immutable
   */
  isBackupImmutable?: boolean;

  /**
   * The setting for whether or not time-based immutability is enabled for the LTR backup. When time-based immutability is enabled and locked, the backup cannot be deleted until BackupExpirationTime.
   */
  timeBasedImmutability?: TimeBasedImmutability;

  /**
   * The time-based immutability mode. Only applicable if time-based immutability is enabled.
   */
  timeBasedImmutabilityMode?: TimeBasedImmutabilityMode;

  /**
   * The setting for whether LegalHold is enabled or disabled on the LTR backup. When LegalHold is enabled, the backup cannot be deleted until the LegalHold is removed.
   */
  legalHoldImmutability?: SetLegalHoldImmutability;

  /**
   * The BackupStorageAccessTier for the LTR backup
   */
  @visibility(Lifecycle.Read)
  backupStorageAccessTier?: BackupStorageAccessTier;
}

/**
 * Contains the information necessary to change long term retention backup access tier and related operation mode.
 */
model ChangeLongTermRetentionBackupAccessTierParameters {
  /**
   * The long term retention backup storage access tier
   */
  backupStorageAccessTier: string;

  /**
   * The operation mode when updating ltr backup storage access tier
   */
  operationMode: string;
}

/**
 * Contains the information necessary to perform long term retention backup copy operation.
 */
model CopyLongTermRetentionBackupParameters {
  /**
   * Resource properties.
   */
  properties?: CopyLongTermRetentionBackupParametersProperties;
}

/**
 * Contains the properties to perform long term retention backup copy operation.
 */
model CopyLongTermRetentionBackupParametersProperties {
  /**
   * The subscription that owns the target server
   */
  @visibility(Lifecycle.Create)
  targetSubscriptionId?: string;

  /**
   * The resource group that owns the target server
   */
  @visibility(Lifecycle.Create)
  targetResourceGroup?: string;

  /**
   * The resource Id of the target server that owns the database
   */
  @visibility(Lifecycle.Create)
  targetServerResourceId?: string;

  /**
   * The fully qualified domain name of the target server
   */
  @visibility(Lifecycle.Create)
  targetServerFullyQualifiedDomainName?: string;

  /**
   * The name of the database owns the copied backup.
   */
  @visibility(Lifecycle.Create)
  targetDatabaseName?: string;

  /**
   * The storage redundancy type of the copied backup
   */
  @visibility(Lifecycle.Create)
  targetBackupStorageRedundancy?: BackupStorageRedundancy;
}

/**
 * A LongTermRetentionBackup operation result resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LongTermRetentionBackupOperationResult extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: LongTermRetentionOperationResultProperties;
}

/**
 * Contains the operation result properties for long term retention backup operation.
 */
model LongTermRetentionOperationResultProperties {
  /**
   * Request Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  requestId?: Azure.Core.uuid;

  /**
   * Operation type.
   */
  @visibility(Lifecycle.Read)
  operationType?: string;

  /**
   * Source backup resource id
   */
  @visibility(Lifecycle.Read)
  fromBackupResourceId?: string;

  /**
   * Target backup resource id
   */
  @visibility(Lifecycle.Read)
  toBackupResourceId?: string;

  /**
   * The storage redundancy type of the copied backup
   */
  @visibility(Lifecycle.Read)
  targetBackupStorageRedundancy?: BackupStorageRedundancy;

  /**
   * Operation status
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Progress message
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Contains the information necessary to perform long term retention backup update operation.
 */
model UpdateLongTermRetentionBackupParameters {
  /**
   * Resource properties.
   */
  properties?: UpdateLongTermRetentionBackupParametersProperties;
}

/**
 * Contains the properties to perform long term retention backup copy operation.
 */
model UpdateLongTermRetentionBackupParametersProperties {
  /**
   * The storage redundancy type of the copied backup
   */
  @visibility(Lifecycle.Create)
  requestedBackupStorageRedundancy?: BackupStorageRedundancy;
}

/**
 * Properties of a long term retention backup
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedInstanceLongTermRetentionBackupProperties {
  /**
   * The managed instance that the backup database belongs to.
   */
  @visibility(Lifecycle.Read)
  managedInstanceName?: string;

  /**
   * The create time of the instance.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  managedInstanceCreateTime?: utcDateTime;

  /**
   * The name of the database the backup belong to
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * The delete time of the database
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  databaseDeletionTime?: utcDateTime;

  /**
   * The time the backup was taken
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupTime?: utcDateTime;

  /**
   * The time the long term retention backup will expire.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupExpirationTime?: utcDateTime;

  /**
   * The storage redundancy type of the backup
   */
  @visibility(Lifecycle.Read)
  backupStorageRedundancy?: BackupStorageRedundancy;

  /**
   * The BackupStorageAccessTier for the LTR backup
   */
  @visibility(Lifecycle.Read)
  backupStorageAccessTier?: BackupStorageAccessTier;
}

/**
 * Properties of a long term retention policy
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LongTermRetentionPolicyProperties {
  /**
   * The setting for whether to enable time-based immutability for future backups. When set, future backups will have TimeBasedImmutability enabled.
   */
  timeBasedImmutability?: TimeBasedImmutability;

  /**
   * The setting for time-based immutability mode for future backup (Value can be either Locked or UnLocked. Only effective if TimeBasedImmutability is enabled). Caution: Immutability of LTR backup cannot be removed if TimeBasedImmutabilityMode is Locked.
   */
  timeBasedImmutabilityMode?: TimeBasedImmutabilityMode;

  /**
   * The weekly retention policy for an LTR backup in an ISO 8601 format.
   */
  weeklyRetention?: string;

  /**
   * The monthly retention policy for an LTR backup in an ISO 8601 format.
   */
  monthlyRetention?: string;

  /**
   * The yearly retention policy for an LTR backup in an ISO 8601 format.
   */
  yearlyRetention?: string;

  /**
   * The week of year to take the yearly backup in an ISO 8601 format.
   */
  weekOfYear?: int32;
}

/**
 * Maintenance window options properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MaintenanceWindowOptionsProperties {
  /**
   * Whether maintenance windows are enabled for the database.
   */
  isEnabled?: boolean;

  /**
   * Available maintenance cycles e.g. {Saturday, 0, 48*60}, {Wednesday, 0, 24*60}.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maintenanceWindowCycles?: MaintenanceWindowTimeRange[];

  /**
   * Minimum duration of maintenance window.
   */
  minDurationInMinutes?: int32;

  /**
   * Default duration for maintenance window.
   */
  defaultDurationInMinutes?: int32;

  /**
   * Minimum number of maintenance windows cycles to be set on the database.
   */
  minCycles?: int32;

  /**
   * Time granularity in minutes for maintenance windows.
   */
  timeGranularityInMinutes?: int32;

  /**
   * Whether we allow multiple maintenance windows per cycle.
   */
  allowMultipleMaintenanceWindowsPerCycle?: boolean;
}

/**
 * Maintenance window time range.
 */
model MaintenanceWindowTimeRange {
  /**
   * Day of maintenance window.
   */
  dayOfWeek?: DayOfWeek;

  /**
   * Start time minutes offset from 12am.
   */
  startTime?: string;

  /**
   * Duration of maintenance window in minutes.
   */
  duration?: string;
}

/**
 * Maintenance windows resource properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MaintenanceWindowsProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeRanges?: MaintenanceWindowTimeRange[];
}

/**
 * Properties of a short term retention policy
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedBackupShortTermRetentionPolicyProperties {
  /**
   * The backup retention period in days. This is how many days Point-in-Time Restore will be supported.
   */
  retentionDays?: int32;
}

/**
 * Contains the operation result properties for managed database move operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedDatabaseMoveOperationResultProperties {
  /**
   * The name of operation.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The friendly name of operation.
   */
  @visibility(Lifecycle.Read)
  operationFriendlyName?: string;

  /**
   * The operation start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The operation state.
   */
  @visibility(Lifecycle.Read)
  state?: ManagementOperationState;

  /**
   * Operation mode.
   */
  @visibility(Lifecycle.Read)
  operationMode?: MoveOperationMode;

  /**
   * Source Managed Instance name.
   */
  @visibility(Lifecycle.Read)
  sourceManagedInstanceName?: string;

  /**
   * Target Managed Instance name.
   */
  @visibility(Lifecycle.Read)
  targetManagedInstanceName?: string;

  /**
   * Source Managed Instance resource id.
   */
  @visibility(Lifecycle.Read)
  sourceManagedInstanceId?: string;

  /**
   * Target Managed instance resource id.
   */
  @visibility(Lifecycle.Read)
  targetManagedInstanceId?: string;

  /**
   * Source database name.
   */
  @visibility(Lifecycle.Read)
  sourceDatabaseName?: string;

  /**
   * Target database name.
   */
  @visibility(Lifecycle.Read)
  targetDatabaseName?: string;

  /**
   * Is move operation cancellable.
   */
  @visibility(Lifecycle.Read)
  isCancellable?: boolean;

  /**
   * The operation error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * The operation error description.
   */
  @visibility(Lifecycle.Read)
  errorDescription?: string;

  /**
   * The operation error severity.
   */
  @visibility(Lifecycle.Read)
  errorSeverity?: int32;

  /**
   * Whether or not the error is a user error.
   */
  @visibility(Lifecycle.Read)
  isUserError?: boolean;
}

/**
 * Properties of a database query.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model QueryProperties {
  /**
   * Query text.
   */
  queryText?: string;
}

/**
 * Execution statistics for one particular query
 */
model ManagedInstanceQueryStatistics is Azure.Core.Page<QueryStatistics>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model QueryStatistics extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: QueryStatisticsProperties;
}

/**
 * Properties of a query execution statistics.
 */
model QueryStatisticsProperties {
  /**
   * Database name of the database in which this query was executed.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Unique query id (unique within one database).
   */
  @visibility(Lifecycle.Read)
  queryId?: string;

  /**
   * The start time for the metric (ISO-8601 format).
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * The end time for the metric (ISO-8601 format).
   */
  @visibility(Lifecycle.Read)
  endTime?: string;

  /**
   * List of intervals with appropriate metric data
   */
  @identifiers(#[])
  intervals?: QueryMetricInterval[];
}

/**
 * Properties of a query metrics interval.
 */
model QueryMetricInterval {
  /**
   * The start time for the metric interval (ISO-8601 format).
   */
  @visibility(Lifecycle.Read)
  intervalStartTime?: string;

  /**
   * Interval type (length).
   */
  @visibility(Lifecycle.Read)
  intervalType?: QueryTimeGrainType;

  /**
   * Execution count of a query in this interval.
   */
  @visibility(Lifecycle.Read)
  executionCount?: int64;

  /**
   * List of metric objects for this interval
   */
  @identifiers(#[])
  metrics?: QueryMetricProperties[];
}

/**
 * Properties of a topquery metric in one interval.
 */
model QueryMetricProperties {
  /**
   * The name information for the metric.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The UI appropriate name for the metric.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The unit of the metric.
   */
  @visibility(Lifecycle.Read)
  unit?: QueryMetricUnitType;

  /**
   * The value of the metric.
   */
  @visibility(Lifecycle.Read)
  value?: float64;

  /**
   * Metric value when min() aggregate function is used over the interval.
   */
  @visibility(Lifecycle.Read)
  min?: float64;

  /**
   * Metric value when max() aggregate function is used over the interval.
   */
  @visibility(Lifecycle.Read)
  max?: float64;

  /**
   * Metric value when avg() aggregate function is used over the interval.
   */
  @visibility(Lifecycle.Read)
  avg?: float64;

  /**
   * Metric value when sum() aggregate function is used over the interval.
   */
  @visibility(Lifecycle.Read)
  sum?: float64;

  /**
   * Metric value when stdev aggregate function is used over the interval.
   */
  @visibility(Lifecycle.Read)
  stdev?: float64;
}

/**
 * The managed database's restore details properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedDatabaseRestoreDetailsProperties {
  /**
   * Restore type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Restore status.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The reason why restore is in Blocked state.
   */
  @visibility(Lifecycle.Read)
  blockReason?: string;

  /**
   * Last uploaded file name.
   */
  @visibility(Lifecycle.Read)
  lastUploadedFileName?: string;

  /**
   * Last uploaded file time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUploadedFileTime?: utcDateTime;

  /**
   * Last restored file name.
   */
  @visibility(Lifecycle.Read)
  lastRestoredFileName?: string;

  /**
   * Last restored file time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRestoredFileTime?: utcDateTime;

  /**
   * Percent completed.
   */
  @visibility(Lifecycle.Read)
  percentCompleted?: int32;

  /**
   * Current restored size MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  currentRestoredSizeMB?: int32;

  /**
   * Current restore plan size MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  currentRestorePlanSizeMB?: int32;

  /**
   * Current backup type.
   */
  @visibility(Lifecycle.Read)
  currentBackupType?: string;

  /**
   * Current restoring file name.
   */
  @visibility(Lifecycle.Read)
  currentRestoringFileName?: string;

  /**
   * Number of files detected.
   */
  @visibility(Lifecycle.Read)
  numberOfFilesDetected?: int32;

  /**
   * Number of files queued.
   */
  @visibility(Lifecycle.Read)
  numberOfFilesQueued?: int32;

  /**
   * Number of files skipped.
   */
  @visibility(Lifecycle.Read)
  numberOfFilesSkipped?: int32;

  /**
   * Number of files restoring.
   */
  @visibility(Lifecycle.Read)
  numberOfFilesRestoring?: int32;

  /**
   * Number of files restored.
   */
  @visibility(Lifecycle.Read)
  numberOfFilesRestored?: int32;

  /**
   * Number of files unrestorable.
   */
  @visibility(Lifecycle.Read)
  numberOfFilesUnrestorable?: int32;

  /**
   * Full backup sets.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  fullBackupSets?: ManagedDatabaseRestoreDetailsBackupSetProperties[];

  /**
   * Diff backup sets.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  diffBackupSets?: ManagedDatabaseRestoreDetailsBackupSetProperties[];

  /**
   * Log backup sets.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  logBackupSets?: ManagedDatabaseRestoreDetailsBackupSetProperties[];

  /**
   * Unrestorable files.
   */
  @visibility(Lifecycle.Read)
  unrestorableFiles?: ManagedDatabaseRestoreDetailsUnrestorableFileProperties[];
}

/**
 * The managed database's restore details backup set properties.
 */
model ManagedDatabaseRestoreDetailsBackupSetProperties {
  /**
   * Backup set status.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * First stripe name.
   */
  @visibility(Lifecycle.Read)
  firstStripeName?: string;

  /**
   * Number of stripes.
   */
  @visibility(Lifecycle.Read)
  numberOfStripes?: int32;

  /**
   * Backup size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  backupSizeMB?: int32;

  /**
   * Last restored file time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restoreStartedTimestampUtc?: utcDateTime;

  /**
   * Last restored file time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restoreFinishedTimestampUtc?: utcDateTime;
}

/**
 * The managed database's restore details unrestorable file properties.
 */
model ManagedDatabaseRestoreDetailsUnrestorableFileProperties {
  /**
   * File name.
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * The managed database's properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedDatabaseProperties {
  /**
   * Collation of the managed database.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  collation?: string;

  /**
   * Status of the database.
   */
  @visibility(Lifecycle.Read)
  status?: ManagedDatabaseStatus;

  /**
   * Creation date of the database.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Earliest restore point in time for point in time restore.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestorePoint?: utcDateTime;

  /**
   * Conditional. If createMode is PointInTimeRestore, this value is required. Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.
   */
  @visibility(Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restorePointInTime?: utcDateTime;

  /**
   * Geo paired region.
   */
  @visibility(Lifecycle.Read)
  defaultSecondaryLocation?: string;

  /**
   * Collation of the metadata catalog.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  catalogCollation?: CatalogCollationType;

  /**
   * Managed database create mode. PointInTimeRestore: Create a database by restoring a point in time backup of an existing database. SourceDatabaseName, SourceManagedInstanceName and PointInTime must be specified. RestoreExternalBackup: Create a database by restoring from external backup files. Collation, StorageContainerUri and StorageContainerSasToken must be specified. Recovery: Creates a database by restoring a geo-replicated backup. RecoverableDatabaseId must be specified as the recoverable database resource ID to restore. RestoreLongTermRetentionBackup: Create a database by restoring from a long term retention backup (longTermRetentionBackupResourceId required).
   */
  @visibility(Lifecycle.Create)
  createMode?: ManagedDatabaseCreateMode;

  /**
   * Conditional. If createMode is RestoreExternalBackup, this value is required. Specifies the uri of the storage container where backups for this restore are stored.
   */
  @visibility(Lifecycle.Create)
  storageContainerUri?: string;

  /**
   * The resource identifier of the source database associated with create operation of this database.
   */
  @visibility(Lifecycle.Create)
  sourceDatabaseId?: string;

  /**
   * The resource identifier of the cross-subscription source database associated with create operation of this database.
   */
  @visibility(Lifecycle.Create)
  crossSubscriptionSourceDatabaseId?: string;

  /**
   * The restorable dropped database resource id to restore when creating this database.
   */
  @visibility(Lifecycle.Create)
  restorableDroppedDatabaseId?: string;

  /**
   * The restorable cross-subscription dropped database resource id to restore when creating this database.
   */
  @visibility(Lifecycle.Create)
  crossSubscriptionRestorableDroppedDatabaseId?: string;

  /**
   * Conditional. If createMode is RestoreExternalBackup, this value is used. Specifies the identity used for storage container authentication. Can be 'SharedAccessSignature' or 'ManagedIdentity'; if not specified 'SharedAccessSignature' is assumed.
   */
  @visibility(Lifecycle.Create)
  storageContainerIdentity?: string;

  /**
   * Conditional. If createMode is RestoreExternalBackup and storageContainerIdentity is not ManagedIdentity, this value is required. Specifies the storage container sas token.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create)
  storageContainerSasToken?: string;

  /**
   * Instance Failover Group resource identifier that this managed database belongs to.
   */
  @visibility(Lifecycle.Read)
  failoverGroupId?: string;

  /**
   * The resource identifier of the recoverable database associated with create operation of this database.
   */
  @visibility(Lifecycle.Create)
  recoverableDatabaseId?: string;

  /**
   * The name of the Long Term Retention backup to be used for restore of this managed database.
   */
  @visibility(Lifecycle.Create)
  longTermRetentionBackupResourceId?: string;

  /**
   * Whether to auto complete restore of this managed database.
   */
  @visibility(Lifecycle.Create)
  autoCompleteRestore?: boolean;

  /**
   * Last backup file name for restore of this managed database.
   */
  @visibility(Lifecycle.Create)
  lastBackupName?: string;

  /**
   * Target managed instance id used in cross-subscription restore.
   */
  @visibility(Lifecycle.Create)
  crossSubscriptionTargetManagedInstanceId?: string;

  /**
   * Whether or not this database is a ledger database, which means all tables in the database are ledger tables. Note: the value of this property cannot be changed after the database has been created.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isLedgerOn?: boolean;

  /**
   * Additional observability and troubleshooting information for databases in ‘Inaccessible’ state.
   */
  @visibility(Lifecycle.Read)
  extendedAccessibilityInfo?: ManagedDatabaseExtendedAccessibilityInfo;
}

/**
 * Managed Database Extended Accessibility Information
 */
model ManagedDatabaseExtendedAccessibilityInfo {
  /**
   * SQL Server error code connected to the inaccessibility root cause.
   */
  @visibility(Lifecycle.Read)
  inaccessibilityReasonErrorCode: string;

  /**
   * Root cause explanation and mitigation action.
   */
  @visibility(Lifecycle.Read)
  inaccessibilityReasonDescription: string;

  /**
   * Root cause kind. Allowed values are “TransparentDataEncryption”, “DatabaseReplication”, and “Unknown”.
   */
  @visibility(Lifecycle.Read)
  inaccessibilityReasonKind: InaccessibilityReason;

  /**
   * For the root cause kind “TransparentDataEncryption”, the CMK URI.
   */
  @visibility(Lifecycle.Read)
  inaccessibilityReasonTdeKeyUri?: string;
}

/**
 * An managed database update.
 */
model ManagedDatabaseUpdate {
  /**
   * Resource properties.
   */
  properties?: ManagedDatabaseProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Contains the information necessary to perform a managed database move.
 */
model ManagedDatabaseMoveDefinition {
  /**
   * The destination managed database ID
   */
  destinationManagedDatabaseId: string;
}

/**
 * Contains the information necessary to perform a complete database restore operation.
 */
model CompleteDatabaseRestoreDefinition {
  /**
   * The last backup name to apply
   */
  lastBackupName: string;
}

/**
 * Contains the information necessary to start a managed database move.
 */
model ManagedDatabaseStartMoveDefinition {
  /**
   * The destination managed database ID
   */
  destinationManagedDatabaseId: string;

  /**
   * The move operation mode.
   */
  operationMode?: MoveOperationMode = MoveOperationMode.Move;
}

/**
 * Properties of a security alert policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityAlertPolicyProperties {
  /**
   * Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific database.
   */
  state: SecurityAlertPolicyState;

  /**
   * Specifies an array of alerts that are disabled. Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly, Data_Exfiltration, Unsafe_Action, Brute_Force
   */
  disabledAlerts?: string[];

  /**
   * Specifies an array of e-mail addresses to which the alert is sent.
   */
  emailAddresses?: string[];

  /**
   * Specifies that the alert is sent to the account administrators.
   */
  emailAccountAdmins?: boolean;

  /**
   * Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs.
   */
  storageEndpoint?: string;

  /**
   * Specifies the identifier key of the Threat Detection audit storage account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageAccountAccessKey?: string;

  /**
   * Specifies the number of days to keep in the Threat Detection audit logs.
   */
  retentionDays?: int32;

  /**
   * Specifies the UTC creation time of the policy.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

/**
 * A list of security events.
 */
model SecurityEventCollection is Azure.Core.Page<SecurityEvent>;

/**
 * A security event.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityEvent extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: SecurityEventProperties;
}

/**
 * The properties of a security event.
 */
model SecurityEventProperties {
  /**
   * The time when the security event occurred.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime?: utcDateTime;

  /**
   * The type of the security event.
   */
  @visibility(Lifecycle.Read)
  securityEventType?: SecurityEventType;

  /**
   * The subscription name
   */
  @visibility(Lifecycle.Read)
  subscription?: string;

  /**
   * The server name
   */
  @visibility(Lifecycle.Read)
  server?: string;

  /**
   * The database name
   */
  @visibility(Lifecycle.Read)
  database?: string;

  /**
   * The IP address of the client who executed the statement.
   */
  @visibility(Lifecycle.Read)
  clientIp?: string;

  /**
   * The application used to execute the statement.
   */
  @visibility(Lifecycle.Read)
  applicationName?: string;

  /**
   * The principal user who executed the statement
   */
  @visibility(Lifecycle.Read)
  principalName?: string;

  /**
   * The sql injection additional properties, populated only if the type of the security event is sql injection.
   */
  @visibility(Lifecycle.Read)
  securityEventSqlInjectionAdditionalProperties?: SecurityEventSqlInjectionAdditionalProperties;
}

/**
 * The properties of a security event sql injection additional properties.
 */
model SecurityEventSqlInjectionAdditionalProperties {
  /**
   * The threat ID.
   */
  @visibility(Lifecycle.Read)
  threatId?: string;

  /**
   * The statement
   */
  @visibility(Lifecycle.Read)
  statement?: string;

  /**
   * The statement highlight offset
   */
  @visibility(Lifecycle.Read)
  statementHighlightOffset?: int32;

  /**
   * The statement highlight length
   */
  @visibility(Lifecycle.Read)
  statementHighlightLength?: int32;

  /**
   * The sql error code
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * The sql error severity
   */
  @visibility(Lifecycle.Read)
  errorSeverity?: int32;

  /**
   * The sql error message
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

/**
 * Properties of a sensitivity label.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SensitivityLabelProperties {
  /**
   * The schema name.
   */
  @visibility(Lifecycle.Read)
  schemaName?: string;

  /**
   * The table name.
   */
  @visibility(Lifecycle.Read)
  tableName?: string;

  /**
   * The column name.
   */
  @visibility(Lifecycle.Read)
  columnName?: string;

  /**
   * The label name.
   */
  labelName?: string;

  /**
   * The label ID.
   */
  labelId?: string;

  /**
   * The information type.
   */
  informationType?: string;

  /**
   * The information type ID.
   */
  informationTypeId?: string;

  /**
   * Is sensitivity recommendation disabled. Applicable for recommended sensitivity label only. Specifies whether the sensitivity recommendation on this column is disabled (dismissed) or not.
   */
  @visibility(Lifecycle.Read)
  isDisabled?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rank?: SensitivityLabelRank;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientClassificationSource?: ClientClassificationSource;
}

/**
 * A list of sensitivity label update operations.
 */
model SensitivityLabelUpdateList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  operations?: SensitivityLabelUpdate[];
}

/**
 * A sensitivity label update operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SensitivityLabelUpdate extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: SensitivityLabelUpdateProperties;
}

/**
 * Properties of an operation executed on a sensitivity label.
 */
model SensitivityLabelUpdateProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `op`: SensitivityLabelUpdateKind;

  /**
   * Schema name of the column to update.
   */
  schema: string;

  /**
   * Table name of the column to update.
   */
  table: string;

  /**
   * Column name to update.
   */
  column: string;

  /**
   * The sensitivity label information to apply on a column.
   */
  sensitivityLabel?: SensitivityLabel;
}

/**
 * A list of recommended sensitivity label update operations.
 */
model RecommendedSensitivityLabelUpdateList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  operations?: RecommendedSensitivityLabelUpdate[];
}

/**
 * A recommended sensitivity label update operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecommendedSensitivityLabelUpdate extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: RecommendedSensitivityLabelUpdateProperties;
}

/**
 * Properties of an operation executed on a recommended sensitivity label.
 */
model RecommendedSensitivityLabelUpdateProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `op`: RecommendedSensitivityLabelUpdateKind;

  /**
   * Schema name of the column to update.
   */
  schema: string;

  /**
   * Table name of the column to update.
   */
  table: string;

  /**
   * Column name to update.
   */
  column: string;
}

/**
 * Properties of a transparent data encryption.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedTransparentDataEncryptionProperties {
  /**
   * Specifies the state of the transparent data encryption.
   */
  state: TransparentDataEncryptionState;
}

/**
 * The properties of a managed instance administrator.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedInstanceAdministratorProperties {
  /**
   * Type of the managed instance administrator.
   */
  administratorType: ManagedInstanceAdministratorType;

  /**
   * Login name of the managed instance administrator.
   */
  login: string;

  /**
   * SID (object ID) of the managed instance administrator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sid: Azure.Core.uuid;

  /**
   * Tenant ID of the managed instance administrator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenantId?: Azure.Core.uuid;
}

/**
 * Properties of a active directory only authentication for Managed Instance.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedInstanceAzureADOnlyAuthProperties {
  /**
   * Azure Active Directory only Authentication enabled.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureADOnlyAuthentication: boolean;
}

/**
 * The properties of managed instance DTC.
 */
model ManagedInstanceDtcProperties {
  /**
   * Active status of managed instance DTC.
   */
  dtcEnabled?: boolean;

  /**
   * Security settings of managed instance DTC.
   */
  securitySettings?: ManagedInstanceDtcSecuritySettings;

  /**
   * External dns suffix search list of managed instance DTC.
   */
  externalDnsSuffixSearchList?: string[];

  /**
   * Host name dns suffix of managed instance DTC.
   */
  @visibility(Lifecycle.Read)
  dtcHostNameDnsSuffix?: string;

  /**
   * Status of FQDN of managed instance DTC. Toggling this setting might trigger a restart of the managed instance.
   */
  fqdnEnabled?: boolean;

  /**
   * Provisioning state of managed instance DTC.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The Security Settings of managed instance DTC.
 */
model ManagedInstanceDtcSecuritySettings {
  /**
   * Transaction Manager communication settings of managed instance DTC.
   */
  transactionManagerCommunicationSettings?: ManagedInstanceDtcTransactionManagerCommunicationSettings;

  /**
   * Allow XA Transactions to managed instance DTC.
   */
  xaTransactionsEnabled?: boolean;

  /**
   * Allow SNA LU 6.2 Transactions to managed instance DTC.
   */
  snaLu6point2TransactionsEnabled?: boolean;

  /**
   * Default timeout for XA Transactions (in seconds).
   */
  xaTransactionsDefaultTimeout?: int32;

  /**
   * Maximum timeout for XA Transactions (in seconds).
   */
  xaTransactionsMaximumTimeout?: int32;
}

/**
 * The Transaction Manager Communication Settings of managed instance DTC.
 */
model ManagedInstanceDtcTransactionManagerCommunicationSettings {
  /**
   * Allow Inbound traffic to managed instance DTC.
   */
  allowInboundEnabled?: boolean;

  /**
   * Allow Outbound traffic of managed instance DTC.
   */
  allowOutboundEnabled?: boolean;

  /**
   * Authentication type of managed instance DTC.
   */
  authentication?: string;
}

/**
 * Properties for an encryption protector execution.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedInstanceEncryptionProtectorProperties {
  /**
   * The name of the managed instance key.
   */
  serverKeyName?: string;

  /**
   * The encryption protector type like 'ServiceManaged', 'AzureKeyVault'.
   */
  serverKeyType: ServerKeyType;

  /**
   * The URI of the server key.
   */
  @visibility(Lifecycle.Read)
  uri?: string;

  /**
   * Thumbprint of the server key.
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * Key auto rotation opt-in flag. Either true or false.
   */
  autoRotationEnabled?: boolean;
}

/**
 * Properties for a key execution.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedInstanceKeyProperties {
  /**
   * The key type like 'ServiceManaged', 'AzureKeyVault'.
   */
  @visibility(Lifecycle.Create)
  serverKeyType: ServerKeyType;

  /**
   * The URI of the key. If the ServerKeyType is AzureKeyVault, then the URI is required.
   */
  @visibility(Lifecycle.Create)
  uri?: string;

  /**
   * Thumbprint of the key.
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * The key creation date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Key auto rotation opt-in flag. Either true or false.
   */
  @visibility(Lifecycle.Read)
  autoRotationEnabled?: boolean;
}

/**
 * Properties of a long term retention policy
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedInstanceLongTermRetentionPolicyProperties {
  /**
   * The BackupStorageAccessTier for the LTR backups
   */
  backupStorageAccessTier?: BackupStorageAccessTier;

  /**
   * The weekly retention policy for an LTR backup in an ISO 8601 format.
   */
  weeklyRetention?: string;

  /**
   * The monthly retention policy for an LTR backup in an ISO 8601 format.
   */
  monthlyRetention?: string;

  /**
   * The yearly retention policy for an LTR backup in an ISO 8601 format.
   */
  yearlyRetention?: string;

  /**
   * The week of year to take the yearly backup in an ISO 8601 format.
   */
  weekOfYear?: int32;
}

/**
 * The properties of a managed instance operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedInstanceOperationProperties {
  /**
   * The name of the managed instance the operation is being performed on.
   */
  @visibility(Lifecycle.Read)
  managedInstanceName?: string;

  /**
   * The name of operation.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The friendly name of operation.
   */
  @visibility(Lifecycle.Read)
  operationFriendlyName?: string;

  /**
   * The percentage of the operation completed.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * The operation start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The operation state.
   */
  @visibility(Lifecycle.Read)
  state?: ManagementOperationState;

  /**
   * The operation error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * The operation error description.
   */
  @visibility(Lifecycle.Read)
  errorDescription?: string;

  /**
   * The operation error severity.
   */
  @visibility(Lifecycle.Read)
  errorSeverity?: int32;

  /**
   * Whether or not the error is a user error.
   */
  @visibility(Lifecycle.Read)
  isUserError?: boolean;

  /**
   * The estimated completion time of the operation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  estimatedCompletionTime?: utcDateTime;

  /**
   * The operation description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Whether the operation can be cancelled.
   */
  @visibility(Lifecycle.Read)
  isCancellable?: boolean;

  /**
   * The operation parameters.
   */
  @visibility(Lifecycle.Read)
  operationParameters?: ManagedInstanceOperationParametersPair;

  /**
   * The operation steps.
   */
  @visibility(Lifecycle.Read)
  operationSteps?: ManagedInstanceOperationSteps;
}

/**
 * The parameters of a managed instance operation.
 */
model ManagedInstanceOperationParametersPair {
  /**
   * The current parameters.
   */
  @visibility(Lifecycle.Read)
  currentParameters?: UpsertManagedServerOperationParameters;

  /**
   * The requested parameters.
   */
  @visibility(Lifecycle.Read)
  requestedParameters?: UpsertManagedServerOperationParameters;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UpsertManagedServerOperationParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  family?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tier?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vCores?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageSizeInGB?: int32;
}

/**
 * The steps of a managed instance operation.
 */
model ManagedInstanceOperationSteps {
  /**
   * The total number of operation steps.
   */
  @visibility(Lifecycle.Read)
  totalSteps?: string;

  /**
   * The number of current operation steps.
   */
  @visibility(Lifecycle.Read)
  currentStep?: int32;

  /**
   * The operation steps list.
   */
  @visibility(Lifecycle.Read)
  stepsList?: UpsertManagedServerOperationStepWithEstimatesAndDuration[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UpsertManagedServerOperationStepWithEstimatesAndDuration {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  stepStartTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  stepEndTime?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeElapsed?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  order?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  status?: UpsertManagedServerOperationStepWithEstimatesAndDurationStatus;
}

/**
 * Properties of a private endpoint connection.
 */
model ManagedInstancePrivateEndpointConnectionProperties {
  /**
   * Private endpoint which the connection belongs to.
   */
  privateEndpoint?: ManagedInstancePrivateEndpointProperty;

  /**
   * Connection State of the Private Endpoint Connection.
   */
  privateLinkServiceConnectionState?: ManagedInstancePrivateLinkServiceConnectionStateProperty;

  /**
   * State of the Private Endpoint Connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedInstancePrivateEndpointProperty {
  /**
   * Resource id of the private endpoint.
   */
  id?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedInstancePrivateLinkServiceConnectionStateProperty {
  /**
   * The private link service connection status.
   */
  status: string;

  /**
   * The private link service connection description.
   */
  description: string;

  /**
   * The private link service connection description.
   */
  @visibility(Lifecycle.Read)
  actionsRequired?: string;
}

/**
 * Properties of a private link resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedInstancePrivateLinkProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The private link resource required zone names.
   */
  @visibility(Lifecycle.Read)
  requiredZoneNames?: string[];
}

/**
 * Azure Active Directory identity configuration for a resource.
 */
model ResourceIdentity {
  /**
   * The resource ids of the user assigned identities to use
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserIdentity>;

  /**
   * The Azure Active Directory principal id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  principalId?: Azure.Core.uuid;

  /**
   * The identity type. Set this to 'SystemAssigned' in order to automatically create and assign an Azure Active Directory principal for the resource.
   */
  type?: IdentityType;

  /**
   * The Azure Active Directory tenant id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tenantId?: Azure.Core.uuid;
}

/**
 * Azure Active Directory identity configuration for a resource.
 */
model UserIdentity {
  /**
   * The Azure Active Directory principal id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  principalId?: Azure.Core.uuid;

  /**
   * The Azure Active Directory client id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  clientId?: Azure.Core.uuid;
}

/**
 * The properties of a managed instance.
 */
model ManagedInstanceProperties {
  /**
   * Provisioning state of managed instance.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Specifies the mode of database creation.
   *
   * Default: Regular instance creation.
   *
   * Restore: Creates an instance by restoring a set of backups to specific point in time. RestorePointInTime and SourceManagedInstanceId must be specified.
   */
  @visibility(Lifecycle.Create)
  managedInstanceCreateMode?: ManagedServerCreateMode;

  /**
   * The fully qualified domain name of the managed instance.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  /**
   * Whether or not this is a GPv2 variant of General Purpose edition.
   */
  isGeneralPurposeV2?: boolean;

  /**
   * Administrator username for the managed instance. Can only be specified when the managed instance is being created (and is required for creation).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorLogin?: string;

  /**
   * The administrator login password (required for managed instance creation).
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  administratorLoginPassword?: string;

  /**
   * Subnet resource ID for the managed instance.
   */
  subnetId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * The state of the managed instance.
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * The license type. Possible values are 'LicenseIncluded' (regular price inclusive of a new SQL license) and 'BasePrice' (discounted AHB price for bringing your own SQL licenses).
   */
  licenseType?: ManagedInstanceLicenseType;

  /**
   * Hybrid secondary usage. Possible values are 'Active' (default value) and 'Passive' (customer uses the secondary as Passive DR).
   */
  hybridSecondaryUsage?: HybridSecondaryUsage;

  /**
   * Hybrid secondary usage detected. Possible values are 'Active' (customer does not meet the requirements to use the secondary as Passive DR) and 'Passive' (customer meets the requirements to use the secondary as Passive DR).
   */
  @visibility(Lifecycle.Read)
  hybridSecondaryUsageDetected?: HybridSecondaryUsageDetected;

  /**
   * The number of vCores. Allowed values: 4, 6, 8, 10, 12, 16, 20, 24, 32, 40, 48, 56, 64, 80, 96, 128. Supported vCores depends on the selected hardware family and service tier.
   */
  vCores?: int32;

  /**
   * Storage size in GB. Minimum value: 32. Maximum value: 32768. Increments of 32 GB allowed only. Maximum value depends on the selected hardware family and number of vCores.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageSizeInGB?: int32;

  /**
   * Storage IOps. Minimum value: 300. Maximum value: 80000. Increments of 1 IOps allowed only. Maximum value depends on the selected hardware family and number of vCores.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageIOps?: int32;

  /**
   * Storage throughput MBps parameter is not supported in the instance create/update operation.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageThroughputMBps?: int32;

  /**
   * Memory size in GB. Minimum value: 28. Maximum value: 870. Minimum and maximum value depend on the number of vCores and service tier. Read more about resource limits: https://aka.ms/mi-resource-limits-api.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  memorySizeInGB?: int32;

  /**
   * Collation of the managed instance.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  collation?: string;

  /**
   * The Dns Zone that the managed instance is in.
   */
  @visibility(Lifecycle.Read)
  dnsZone?: string;

  /**
   * The resource id of another managed instance whose DNS zone this managed instance will share after creation.
   */
  @visibility(Lifecycle.Create)
  dnsZonePartner?: Azure.Core.armResourceIdentifier;

  /**
   * Whether or not the public data endpoint is enabled.
   */
  publicDataEndpointEnabled?: boolean;

  /**
   * The resource identifier of the source managed instance associated with create operation of this instance.
   */
  @visibility(Lifecycle.Create)
  sourceManagedInstanceId?: Azure.Core.armResourceIdentifier;

  /**
   * Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.
   */
  @visibility(Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restorePointInTime?: utcDateTime;

  /**
   * Connection type used for connecting to the instance.
   */
  proxyOverride?: ManagedInstanceProxyOverride;

  /**
   * Id of the timezone. Allowed values are timezones supported by Windows.
   * Windows keeps details on supported timezones, including the id, in registry under
   * KEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones.
   * You can get those registry values via SQL Server by querying SELECT name AS timezone_id FROM sys.time_zone_info.
   * List of Ids can also be obtained by executing [System.TimeZoneInfo]::GetSystemTimeZones() in PowerShell.
   * An example of valid timezone id is "Pacific Standard Time" or "W. Europe Standard Time".
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  timezoneId?: string;

  /**
   * The Id of the instance pool this managed server belongs to.
   */
  instancePoolId?: string;

  /**
   * Specifies maintenance configuration id to apply to this managed instance.
   */
  maintenanceConfigurationId?: string;

  /**
   * List of private endpoint connections on a managed instance.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: ManagedInstancePecProperty[];

  /**
   * Minimal TLS version. Allowed values: 'None', '1.0', '1.1', '1.2'
   */
  minimalTlsVersion?: string;

  /**
   * The storage account type used to store backups for this instance. The options are Local (LocallyRedundantStorage), Zone (ZoneRedundantStorage), Geo (GeoRedundantStorage) and GeoZone(GeoZoneRedundantStorage)
   */
  @visibility(Lifecycle.Read)
  currentBackupStorageRedundancy?: BackupStorageRedundancy;

  /**
   * The storage account type to be used to store backups for this instance. The options are Local (LocallyRedundantStorage), Zone (ZoneRedundantStorage), Geo (GeoRedundantStorage) and GeoZone(GeoZoneRedundantStorage)
   */
  requestedBackupStorageRedundancy?: BackupStorageRedundancy;

  /**
   * Whether or not the zone-redundancy is enabled.
   */
  zoneRedundant?: boolean;

  /**
   * The resource id of a user assigned identity to be used by default.
   */
  primaryUserAssignedIdentityId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  /**
   * A CMK URI of the key to use for encryption.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  keyId?: string;

  /**
   * The Azure Active Directory administrator can be utilized during instance creation and for instance updates, except for the azureADOnlyAuthentication property. To update the azureADOnlyAuthentication property, individual API must be used.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administrators?: ManagedInstanceExternalAdministrator;

  /**
   * The managed instance's service principal.
   */
  servicePrincipal?: ServicePrincipal;

  /**
   * Virtual cluster resource id for the Managed Instance.
   */
  @visibility(Lifecycle.Read)
  virtualClusterId?: string;

  /**
   * Status of external governance.
   */
  @visibility(Lifecycle.Read)
  externalGovernanceStatus?: ExternalGovernanceStatus;

  /**
   * Pricing model of Managed Instance.
   */
  pricingModel?: PricingModel;

  /**
   * Specifies the point in time (ISO8601 format) of the Managed Instance creation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * The managed instance's authentication metadata lookup mode.
   */
  authenticationMetadata?: AuthMetadataLookupModes;

  /**
   * Specifies the internal format of instance databases specific to the SQL engine version.
   */
  databaseFormat?: ManagedInstanceDatabaseFormat;

  /**
   * Specifies the logical availability zone Managed Instance is pinned to.
   */
  requestedLogicalAvailabilityZone?: AvailabilityZoneType;
}

/**
 * A private endpoint connection under a managed instance
 */
model ManagedInstancePecProperty {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Private endpoint connection properties
   */
  @visibility(Lifecycle.Read)
  properties?: ManagedInstancePrivateEndpointConnectionProperties;
}

/**
 * Properties of a active directory administrator.
 */
model ManagedInstanceExternalAdministrator {
  /**
   * Type of the sever administrator.
   */
  administratorType?: AdministratorType;

  /**
   * Principal Type of the sever administrator.
   */
  principalType?: PrincipalType;

  /**
   * Login name of the server administrator.
   */
  login?: string;

  /**
   * SID (object ID) of the server administrator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sid?: Azure.Core.uuid;

  /**
   * Tenant ID of the administrator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenantId?: Azure.Core.uuid;

  /**
   * Azure Active Directory only Authentication enabled.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureADOnlyAuthentication?: boolean;
}

/**
 * The managed instance's service principal configuration for a resource.
 */
model ServicePrincipal {
  /**
   * The Azure Active Directory application object id.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The Azure Active Directory application client id.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;

  /**
   * The Azure Active Directory tenant id.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Service principal type.
   */
  type?: ServicePrincipalType;
}

/**
 * An update request for an Azure SQL Database managed instance.
 */
model ManagedInstanceUpdate {
  /**
   * Managed instance sku
   */
  sku?: Sku;

  /**
   * Managed instance identity
   */
  identity?: ResourceIdentity;

  /**
   * Resource properties.
   */
  properties?: ManagedInstanceProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * A collection of endpoints that the managed instance service requires outbound network access to.
 */
model OutboundEnvironmentEndpointCollection
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

/**
 * An endpoint that the managed instance service requires outbound network access to.
 */
model OutboundEnvironmentEndpoint {
  /**
   * The type of service accessed by the managed instance service, e.g., Azure Storage, Azure Active Directory, etc.
   */
  @visibility(Lifecycle.Read)
  category?: string;

  /**
   * The endpoints that the managed instance service communicates with in order to function correctly.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  endpoints?: EndpointDependency[];
}

/**
 * A domain name that the managed instance service needs to communicate with, along with additional details.
 */
model EndpointDependency {
  /**
   * The domain name of the dependency.
   */
  @visibility(Lifecycle.Read)
  domainName?: string;

  /**
   * The IP Addresses and Ports used when connecting to DomainName.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  endpointDetails?: EndpointDetail[];
}

/**
 * A domain name that the managed instance service needs to communicate with, along with additional details.
 */
model EndpointDetail {
  /**
   * The port an endpoint is connected to.
   */
  @visibility(Lifecycle.Read)
  port?: int32;
}

/**
 * An RefreshExternalGovernanceStatus operation result resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RefreshExternalGovernanceStatusOperationResultMI
  extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: RefreshExternalGovernanceStatusOperationResultPropertiesMI;
}

/**
 * Contains the operation result properties for refresh external governance status operation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RefreshExternalGovernanceStatusOperationResultPropertiesMI {
  /**
   * Request Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  requestId?: Azure.Core.uuid;

  /**
   * Request type.
   */
  @visibility(Lifecycle.Read)
  requestType?: string;

  /**
   * Queued time.
   */
  @visibility(Lifecycle.Read)
  queuedTime?: string;

  /**
   * Managed instance name.
   */
  @visibility(Lifecycle.Read)
  managedInstanceName?: string;

  /**
   * Operation status.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

/**
 * A list of top resource consuming queries on managed instance
 */
model TopQueriesListResult is Azure.Core.Page<TopQueries>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TopQueries {
  /**
   * Requested number of top queries.
   */
  @visibility(Lifecycle.Read)
  numberOfQueries?: int32;

  /**
   * Aggregation function used to calculate query metrics.
   */
  @visibility(Lifecycle.Read)
  aggregationFunction?: string;

  /**
   * Metric used to rank queries.
   */
  @visibility(Lifecycle.Read)
  observationMetric?: string;

  /**
   * Interval type (length).
   */
  @visibility(Lifecycle.Read)
  intervalType?: QueryTimeGrainType;

  /**
   * The start time for the metric (ISO-8601 format).
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * The end time for the metric (ISO-8601 format).
   */
  @visibility(Lifecycle.Read)
  endTime?: string;

  /**
   * List of top resource consuming queries with appropriate metric data
   */
  @identifiers(#[])
  queries?: QueryStatisticsProperties[];
}

/**
 * Validate azure key vault encryption key.
 */
model ManagedInstanceValidateAzureKeyVaultEncryptionKeyRequest {
  /**
   * The URI of the key.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  tdeKeyUri: string;
}

/**
 * A TDE certificate that can be uploaded into a server.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TdeCertificate extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: TdeCertificateProperties;
}

/**
 * Properties of a TDE certificate.
 */
model TdeCertificateProperties {
  /**
   * The base64 encoded certificate private blob.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  privateBlob: string;

  /**
   * The certificate password.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  certPassword?: string;
}

/**
 * Properties of a managed instance vulnerability assessment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedInstanceVulnerabilityAssessmentProperties {
  /**
   * A blob storage container path to hold the scan results (e.g. https://myStorage.blob.core.windows.net/VaScans/).
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageContainerPath: string;

  /**
   * A shared access signature (SAS Key) that has write access to the blob container specified in 'storageContainerPath' parameter. If 'storageAccountAccessKey' isn't specified, StorageContainerSasKey is required. Applies only if the storage account is not behind a Vnet or a firewall
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageContainerSasKey?: string;

  /**
   * Specifies the identifier key of the storage account for vulnerability assessment scan results. If 'StorageContainerSasKey' isn't specified, storageAccountAccessKey is required. Applies only if the storage account is not behind a Vnet or a firewall
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageAccountAccessKey?: string;

  /**
   * The recurring scans settings
   */
  recurringScans?: VulnerabilityAssessmentRecurringScansProperties;
}

/**
 * The properties of a database ledger digest upload settings.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedLedgerDigestUploadsProperties {
  /**
   * The digest storage endpoint, which must be either an Azure blob storage endpoint or an URI for Azure Confidential Ledger.
   */
  digestStorageEndpoint?: string;

  /**
   * Specifies the state of ledger digest upload.
   */
  @visibility(Lifecycle.Read)
  state?: ManagedLedgerDigestUploadsState;
}

/**
 * Properties of a managed server DNS alias.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedServerDnsAliasProperties {
  /**
   * The fully qualified DNS record for managed server alias
   */
  @visibility(Lifecycle.Read)
  azureDnsRecord?: string;

  /**
   * The fully qualified public DNS record for managed server alias
   */
  @visibility(Lifecycle.Read)
  publicAzureDnsRecord?: string;
}

/**
 * A managed server dns alias creation request.
 */
model ManagedServerDnsAliasCreation {
  /**
   * Whether or not DNS record should be created for this alias.
   */
  createDnsRecord?: boolean = true;
}

/**
 * A managed server DNS alias acquisition request.
 */
model ManagedServerDnsAliasAcquisition {
  /**
   * The resource ID of the managed server DNS alias that will be acquired to point to this managed server instead.
   */
  oldManagedServerDnsAliasResourceId: string;
}

/**
 * The properties of an NSP config.
 */
model NetworkSecurityPerimeterConfigurationProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  networkSecurityPerimeter?: NSPConfigPerimeter;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceAssociation?: NSPConfigAssociation;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  profile?: NSPConfigProfile;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  provisioningIssues?: NSPProvisioningIssue[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NSPConfigPerimeter {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  id?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  perimeterGuid?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NSPConfigAssociation {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accessMode?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NSPConfigProfile {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accessRulesVersion?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  accessRules?: NSPConfigAccessRule[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NSPConfigAccessRule {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: NSPConfigAccessRuleProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NSPConfigAccessRuleProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  direction?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  addressPrefixes?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fullyQualifiedDomainNames?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptions?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  networkSecurityPerimeters?: NSPConfigNetworkSecurityPerimeterRule[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceTags?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NSPConfigNetworkSecurityPerimeterRule {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  id?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  perimeterGuid?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NSPProvisioningIssue {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: NSPProvisioningIssueProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NSPProvisioningIssueProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  issueType?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  severity?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  suggestedResourceIds?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  suggestedAccessRules?: string[];
}

/**
 * SQL REST API operation definition.
 */
model Operation {
  /**
   * The name of the operation being performed on this particular object.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The localized display information for this particular operation / action.
   */
  @visibility(Lifecycle.Read)
  display?: OperationDisplay;

  /**
   * The intended executor of the operation.
   */
  @visibility(Lifecycle.Read)
  origin?: OperationOrigin;

  /**
   * Additional descriptions for the operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  properties?: Record<unknown>;
}

/**
 * Display metadata associated with the operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name.
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly form of the resource type related to this action/operation.
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The localized friendly name for the operation.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The localized friendly description for the operation.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * The properties of an outbound firewall rule.
 */
model OutboundFirewallRuleProperties {
  /**
   * The state of the outbound rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * Private endpoint which the connection belongs to.
   */
  privateEndpoint?: PrivateEndpointProperty;

  /**
   * Group IDs.
   */
  @visibility(Lifecycle.Read)
  groupIds?: string[];

  /**
   * Connection state of the private endpoint connection.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionStateProperty;

  /**
   * State of the private endpoint connection.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateEndpointProperty {
  /**
   * Resource id of the private endpoint.
   */
  id?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkServiceConnectionStateProperty {
  /**
   * The private link service connection status.
   */
  status: PrivateLinkServiceConnectionStateStatus;

  /**
   * The private link service connection description.
   */
  description: string;

  /**
   * The actions required for private link service connection.
   */
  @visibility(Lifecycle.Read)
  actionsRequired?: PrivateLinkServiceConnectionStateActionsRequire;
}

/**
 * Properties of a private link resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The private link resource required zone names.
   */
  @visibility(Lifecycle.Read)
  requiredZoneNames?: string[];
}

/**
 * The recoverable database's properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecoverableDatabaseProperties {
  /**
   * The edition of the database.
   */
  @visibility(Lifecycle.Read)
  edition?: string;

  /**
   * The service level objective name of the database.
   */
  @visibility(Lifecycle.Read)
  serviceLevelObjective?: string;

  /**
   * The elastic pool name of the database
   */
  @visibility(Lifecycle.Read)
  elasticPoolName?: string;

  /**
   * The last available backup date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastAvailableBackupDate?: utcDateTime;

  /**
   * The resource ids of the user assigned identities to use
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keys?: Record<DatabaseKey>;
}

/**
 * The recoverable managed database's properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecoverableManagedDatabaseProperties {
  /**
   * The last available backup date.
   */
  @visibility(Lifecycle.Read)
  lastAvailableBackupDate?: string;
}

/**
 * Properties of a replication link.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReplicationLinkProperties {
  /**
   * Resource partner server.
   */
  @visibility(Lifecycle.Read)
  partnerServer?: string;

  /**
   * Resource partner database.
   */
  @visibility(Lifecycle.Read)
  partnerDatabase?: string;

  /**
   * Resource partner database Id.
   */
  @visibility(Lifecycle.Read)
  partnerDatabaseId?: string;

  /**
   * Resource partner location.
   */
  @visibility(Lifecycle.Read)
  partnerLocation?: string;

  /**
   * Local replication role.
   */
  @visibility(Lifecycle.Read)
  role?: ReplicationRole;

  /**
   * Partner replication role.
   */
  @visibility(Lifecycle.Read)
  partnerRole?: ReplicationRole;

  /**
   * Replication mode.
   */
  @visibility(Lifecycle.Read)
  replicationMode?: string;

  /**
   * Time at which the link was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Seeding completion percentage for the link.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * Replication state (PENDING, SEEDING, CATCHUP, SUSPENDED).
   */
  @visibility(Lifecycle.Read)
  replicationState?: ReplicationState;

  /**
   * Whether the user is currently allowed to terminate the link.
   */
  @visibility(Lifecycle.Read)
  isTerminationAllowed?: boolean;

  /**
   * Link type (GEO, NAMED, STANDBY). Update operation does not support NAMED.
   */
  linkType?: ReplicationLinkType;
}

/**
 * A replication link update request.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReplicationLinkUpdate extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: ReplicationLinkUpdateProperties;
}

/**
 * Properties of a replication link update.
 */
model ReplicationLinkUpdateProperties {
  /**
   * Link type (GEO, NAMED, STANDBY). Update operation does not support NAMED.
   */
  linkType?: ReplicationLinkType;
}

/**
 * The restorable dropped database's properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RestorableDroppedDatabaseProperties {
  /**
   * The name of the database.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * The max size of the database expressed in bytes.
   */
  @visibility(Lifecycle.Read)
  maxSizeBytes?: int64;

  /**
   * The creation date of the database (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The deletion date of the database (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  /**
   * The earliest restore date of the database (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;

  /**
   * The storage account type used to store backups for this database.
   */
  @visibility(Lifecycle.Read)
  backupStorageRedundancy?: BackupStorageRedundancy;

  /**
   * The resource ids of the user assigned identities to use
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keys?: Record<DatabaseKey>;
}

/**
 * The restorable dropped managed database's properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RestorableDroppedManagedDatabaseProperties {
  /**
   * The name of the database.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * The creation date of the database (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The deletion date of the database (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  /**
   * The earliest restore date of the database (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;
}

/**
 * Properties of a database restore point
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RestorePointProperties {
  /**
   * The type of restore point
   */
  @visibility(Lifecycle.Read)
  restorePointType?: RestorePointType;

  /**
   * The earliest time to which this database can be restored
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;

  /**
   * The time the backup was taken
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restorePointCreationDate?: utcDateTime;

  /**
   * The label of restore point for backup request by user
   */
  @visibility(Lifecycle.Read)
  restorePointLabel?: string;
}

/**
 * Contains the information necessary to perform a create database restore point operation.
 */
model CreateDatabaseRestorePointDefinition {
  /**
   * The restore point label to apply
   */
  restorePointLabel: string;
}

/**
 * Server-level Automatic Tuning properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutomaticTuningServerProperties {
  /**
   * Automatic tuning desired state.
   */
  desiredState?: AutomaticTuningServerMode;

  /**
   * Automatic tuning actual state.
   */
  @visibility(Lifecycle.Read)
  actualState?: AutomaticTuningServerMode;

  /**
   * Automatic tuning options definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  options?: Record<AutomaticTuningServerOptions>;
}

/**
 * Automatic tuning properties for individual advisors.
 */
model AutomaticTuningServerOptions {
  /**
   * Automatic tuning option desired state.
   */
  desiredState?: AutomaticTuningOptionModeDesired;

  /**
   * Automatic tuning option actual state.
   */
  @visibility(Lifecycle.Read)
  actualState?: AutomaticTuningOptionModeActual;

  /**
   * Reason code if desired and actual state are different.
   */
  @visibility(Lifecycle.Read)
  reasonCode?: int32;

  /**
   * Reason description if desired and actual state are different.
   */
  @visibility(Lifecycle.Read)
  reasonDesc?: AutomaticTuningServerReason;
}

/**
 * Properties of a active directory administrator.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AdministratorProperties {
  /**
   * Type of the sever administrator.
   */
  administratorType?: AdministratorType;

  /**
   * Login name of the server administrator.
   */
  login: string;

  /**
   * SID (object ID) of the server administrator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sid: Azure.Core.uuid;

  /**
   * Tenant ID of the administrator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenantId?: Azure.Core.uuid;

  /**
   * Azure Active Directory only Authentication enabled.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  azureADOnlyAuthentication?: boolean;
}

/**
 * Properties of a active directory only authentication.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureADOnlyAuthProperties {
  /**
   * Azure Active Directory only Authentication enabled.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureADOnlyAuthentication: boolean;
}

/**
 * The properties of server configuration option.
 */
model ServerConfigurationOptionProperties {
  /**
   * Value of the server configuration option.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  serverConfigurationOptionValue: int32;

  /**
   * Provisioning state of server configuration option.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The properties of a server connection policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerConnectionPolicyProperties {
  /**
   * The server connection type.
   */
  connectionType: ServerConnectionType;
}

/**
 * Properties of a server DevOps audit settings.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerDevOpsAuditSettingsProperties {
  /**
   * Specifies whether DevOps audit events are sent to Azure Monitor.
   * In order to send the events to Azure Monitor, specify 'State' as 'Enabled' and 'IsAzureMonitorTargetEnabled' as true.
   *
   * When using REST API to configure DevOps audit, Diagnostic Settings with 'DevOpsOperationsAudit' diagnostic logs category on the master database should be also created.
   *
   * Diagnostic Settings URI format:
   * PUT https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Sql/servers/{serverName}/databases/master/providers/microsoft.insights/diagnosticSettings/{settingsName}?api-version=2017-05-01-preview
   *
   * For more information, see [Diagnostic Settings REST API](https://go.microsoft.com/fwlink/?linkid=2033207)
   * or [Diagnostic Settings PowerShell](https://go.microsoft.com/fwlink/?linkid=2033043)
   *
   */
  isAzureMonitorTargetEnabled?: boolean;

  /**
   * Specifies whether Managed Identity is used to access blob storage
   */
  isManagedIdentityInUse?: boolean;

  /**
   * Specifies the state of the audit. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
   */
  state: BlobAuditingPolicyState;

  /**
   * Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled is required.
   */
  storageEndpoint?: string;

  /**
   * Specifies the identifier key of the auditing storage account.
   * If state is Enabled and storageEndpoint is specified, not specifying the storageAccountAccessKey will use SQL server system-assigned managed identity to access the storage.
   * Prerequisites for using managed identity authentication:
   * 1. Assign SQL Server a system-assigned managed identity in Azure Active Directory (AAD).
   * 2. Grant SQL Server identity access to the storage account by adding 'Storage Blob Data Contributor' RBAC role to the server identity.
   * For more information, see [Auditing to storage using Managed Identity authentication](https://go.microsoft.com/fwlink/?linkid=2114355)
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  storageAccountAccessKey?: string;

  /**
   * Specifies the blob storage subscription Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageAccountSubscriptionId?: Azure.Core.uuid;
}

/**
 * Properties of a server DNS alias.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerDnsAliasProperties {
  /**
   * The fully qualified DNS record for alias
   */
  @visibility(Lifecycle.Read)
  azureDnsRecord?: string;
}

/**
 * A server dns alias acquisition request.
 */
model ServerDnsAliasAcquisition {
  /**
   * The id of the server alias that will be acquired to point to this server instead.
   */
  oldServerDnsAliasId: string;
}

/**
 * Properties for a server key execution.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerKeyProperties {
  /**
   * Subregion of the server key.
   */
  @visibility(Lifecycle.Read)
  subregion?: string;

  /**
   * The server key type like 'ServiceManaged', 'AzureKeyVault'.
   */
  @visibility(Lifecycle.Create)
  serverKeyType: ServerKeyType;

  /**
   * The URI of the server key. If the ServerKeyType is AzureKeyVault, then the URI is required. The AKV URI is required to be in this format: 'https://YourVaultName.vault.azure.net/keys/YourKeyName/YourKeyVersion' or can be 'https://YourVaultName.vault.azure.net/keys/YourKeyName'
   */
  @visibility(Lifecycle.Create)
  uri?: string;

  /**
   * Thumbprint of the server key.
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * The server key creation date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Key auto rotation opt-in flag. Either true or false.
   */
  @visibility(Lifecycle.Read)
  autoRotationEnabled?: boolean;

  /**
   * The version of the server key.
   */
  @visibility(Lifecycle.Read)
  keyVersion?: string;
}

/**
 * A server operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerOperation extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: ServerOperationProperties;
}

/**
 * The properties of a server operation.
 */
model ServerOperationProperties {
  /**
   * The name of operation.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The friendly name of operation.
   */
  @visibility(Lifecycle.Read)
  operationFriendlyName?: string;

  /**
   * The percentage of the operation completed.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * The name of the server.
   */
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * The operation start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The operation state.
   */
  @visibility(Lifecycle.Read)
  state?: ManagementOperationState;

  /**
   * The operation error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * The operation error description.
   */
  @visibility(Lifecycle.Read)
  errorDescription?: string;

  /**
   * The operation error severity.
   */
  @visibility(Lifecycle.Read)
  errorSeverity?: int32;

  /**
   * Whether or not the error is a user error.
   */
  @visibility(Lifecycle.Read)
  isUserError?: boolean;

  /**
   * The estimated completion time of the operation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  estimatedCompletionTime?: utcDateTime;

  /**
   * The operation description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Whether the operation can be cancelled.
   */
  @visibility(Lifecycle.Read)
  isCancellable?: boolean;
}

/**
 * A request to check whether the specified name for a resource is available.
 */
model CheckNameAvailabilityRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: CheckNameAvailabilityResourceType;
}

/**
 * The result of a name availability check.
 */
model CheckNameAvailabilityResponse {
  /**
   * The name whose availability was checked.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * True if the name is available, otherwise false.
   */
  @visibility(Lifecycle.Read)
  available?: boolean;

  /**
   * The reason code explaining why the name is unavailable. Will be undefined if the name is available.
   */
  @visibility(Lifecycle.Read)
  reason?: CheckNameAvailabilityReason;

  /**
   * A message explaining why the name is unavailable. Will be undefined if the name is available.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * The properties of a server.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerProperties {
  /**
   * Administrator username for the server. Once created it cannot be changed.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorLogin?: string;

  /**
   * The administrator login password (required for server creation).
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  administratorLoginPassword?: string;

  /**
   * The version of the server.
   */
  version?: string;

  /**
   * The state of the server.
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * The fully qualified domain name of the server.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  /**
   * List of private endpoint connections on a server
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: ServerPrivateEndpointConnection[];

  /**
   * Minimal TLS version. Allowed values: 'None', 1.0', '1.1', '1.2', '1.3'
   */
  minimalTlsVersion?: MinimalTlsVersion;

  /**
   * Whether or not public endpoint access is allowed for this server.  Value is optional but if passed in, must be 'Enabled' or 'Disabled' or 'SecuredByPerimeter'
   */
  publicNetworkAccess?: ServerPublicNetworkAccessFlag;

  /**
   * Whether or not existing server has a workspace created and if it allows connection from workspace
   */
  @visibility(Lifecycle.Read)
  workspaceFeature?: ServerWorkspaceFeature;

  /**
   * The resource id of a user assigned identity to be used by default.
   */
  primaryUserAssignedIdentityId?: string;

  /**
   * The Client id used for cross tenant CMK scenario
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  federatedClientId?: Azure.Core.uuid;

  /**
   * A CMK URI of the key to use for encryption.
   */
  keyId?: string;

  /**
   * The Azure Active Directory administrator can be utilized during server creation and for server updates, except for the azureADOnlyAuthentication property. To update the azureADOnlyAuthentication property, individual API must be used.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administrators?: ServerExternalAdministrator;

  /**
   * Whether or not to restrict outbound network access for this server.  Value is optional but if passed in, must be 'Enabled' or 'Disabled'
   */
  restrictOutboundNetworkAccess?: ServerNetworkAccessFlag;

  /**
   * Whether or not to enable IPv6 support for this server.  Value is optional but if passed in, must be 'Enabled' or 'Disabled'
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isIPv6Enabled?: ServerNetworkAccessFlag;

  /**
   * Status of external governance.
   */
  @visibility(Lifecycle.Read)
  externalGovernanceStatus?: ExternalGovernanceStatus;

  /**
   * Number of days this server will stay soft-deleted.
   */
  retentionDays?: int32;

  /**
   * Create mode for server, only valid values for this are Normal and Restore.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  createMode?: ServerCreateMode;
}

/**
 * A private endpoint connection under a server
 */
model ServerPrivateEndpointConnection {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Private endpoint connection properties
   */
  @visibility(Lifecycle.Read)
  properties?: PrivateEndpointConnectionProperties;
}

/**
 * Properties of a active directory administrator.
 */
model ServerExternalAdministrator {
  /**
   * Type of the sever administrator.
   */
  administratorType?: AdministratorType;

  /**
   * Principal Type of the sever administrator.
   */
  principalType?: PrincipalType;

  /**
   * Login name of the server administrator.
   */
  login?: string;

  /**
   * SID (object ID) of the server administrator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sid?: Azure.Core.uuid;

  /**
   * Tenant ID of the administrator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenantId?: Azure.Core.uuid;

  /**
   * Azure Active Directory only Authentication enabled.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureADOnlyAuthentication?: boolean;
}

/**
 * An update request for an Azure SQL Database server.
 */
model ServerUpdate {
  /**
   * Server identity
   */
  identity?: ResourceIdentity;

  /**
   * Resource properties.
   */
  properties?: ServerProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Contains the information necessary to perform import operation for new database.
 */
model ImportNewDatabaseDefinition {
  /**
   * Name of the import database.
   */
  @visibility(Lifecycle.Create)
  databaseName?: string;

  /**
   * Edition of the import database.
   */
  @visibility(Lifecycle.Create)
  edition?: string;

  /**
   * Service level objective name of the import database.
   */
  @visibility(Lifecycle.Create)
  serviceObjectiveName?: string;

  /**
   * Max size in bytes for the import database.
   */
  @visibility(Lifecycle.Create)
  maxSizeBytes?: string;

  /**
   * Storage key type: StorageAccessKey, SharedAccessKey, or ManagedIdentity.
   */
  @visibility(Lifecycle.Create)
  storageKeyType: StorageKeyType;

  /**
   * Storage key for the storage account. If StorageKeyType is ManagedIdentity, this field should specify the Managed Identity's resource ID.
   */
  @visibility(Lifecycle.Create)
  storageKey: string;

  /**
   * Storage Uri.
   */
  @visibility(Lifecycle.Create)
  storageUri: string;

  /**
   * Administrator login name. If AuthenticationType is ManagedIdentity, this field should specify the Managed Identity's resource ID.
   */
  @visibility(Lifecycle.Create)
  administratorLogin: string;

  /**
   * Administrator login password. If AuthenticationType is ManagedIdentity, this field should not be specified.
   */
  @visibility(Lifecycle.Create)
  @secret
  administratorLoginPassword?: string;

  /**
   * Type of credentials provided for access to the target SQL server: SQL, ADPassword or ManagedIdentity.
   */
  @visibility(Lifecycle.Create)
  authenticationType?: string;

  /**
   * Optional resource information to enable network isolation for request.
   */
  @visibility(Lifecycle.Create)
  networkIsolation?: NetworkIsolationSettings;
}

/**
 * An RefreshExternalGovernanceStatus operation result resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RefreshExternalGovernanceStatusOperationResult
  extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: RefreshExternalGovernanceStatusOperationResultProperties;
}

/**
 * Contains the operation result properties for refresh external governance status operation.
 */
model RefreshExternalGovernanceStatusOperationResultProperties {
  /**
   * Request Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  requestId?: Azure.Core.uuid;

  /**
   * Request type.
   */
  @visibility(Lifecycle.Read)
  requestType?: string;

  /**
   * Queued time.
   */
  @visibility(Lifecycle.Read)
  queuedTime?: string;

  /**
   * Server name.
   */
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * Operation status.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

/**
 * The properties of a server trust certificate.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerTrustCertificateProperties {
  /**
   * The certificate public blob
   */
  publicBlob?: string;

  /**
   * The certificate thumbprint
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * The certificate name
   */
  @visibility(Lifecycle.Read)
  certificateName?: string;
}

/**
 * Properties of a server trust group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerTrustGroupProperties {
  /**
   * Group members information for the server trust group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  groupMembers: ServerInfo[];

  /**
   * Trust scope of the server trust group.
   */
  trustScopes: ServerTrustGroupPropertiesTrustScopesItem[];
}

/**
 * Server info for the server trust group.
 */
model ServerInfo {
  /**
   * Server Id.
   */
  serverId: string;
}

/**
 * Usage metric of a server.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerUsage extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: ServerUsageProperties;
}

/**
 * Properties of a server usage.
 */
model ServerUsageProperties {
  /**
   * User-readable name of the metric.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Current value of the metric.
   */
  @visibility(Lifecycle.Read)
  currentValue?: float64;

  /**
   * Boundary value of the metric.
   */
  @visibility(Lifecycle.Read)
  limit?: float64;

  /**
   * Unit of the metric.
   */
  @visibility(Lifecycle.Read)
  unit?: string;
}

/**
 * Properties of a server Vulnerability Assessment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerVulnerabilityAssessmentProperties {
  /**
   * A blob storage container path to hold the scan results (e.g. https://myStorage.blob.core.windows.net/VaScans/).
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageContainerPath: string;

  /**
   * A shared access signature (SAS Key) that has write access to the blob container specified in 'storageContainerPath' parameter. If 'storageAccountAccessKey' isn't specified, StorageContainerSasKey is required. Applies only if the storage account is not behind a Vnet or a firewall
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageContainerSasKey?: string;

  /**
   * Specifies the identifier key of the storage account for vulnerability assessment scan results. If 'StorageContainerSasKey' isn't specified, storageAccountAccessKey is required. Applies only if the storage account is not behind a Vnet or a firewall
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageAccountAccessKey?: string;

  /**
   * The recurring scans settings
   */
  recurringScans?: VulnerabilityAssessmentRecurringScansProperties;
}

/**
 * Sql agent configuration properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlAgentConfigurationProperties {
  /**
   * The state of Sql Agent.
   */
  state?: SqlAgentConfigurationPropertiesState;
}

/**
 * Properties of managed instance's Start/Stop schedule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StartStopManagedInstanceScheduleProperties {
  /**
   * The description of the schedule.
   */
  description?: string = "";

  /**
   * The time zone of the schedule.
   */
  timeZoneId?: string = "UTC";

  /**
   * Schedule list.
   */
  @identifiers(#[])
  scheduleList: ScheduleItem[];

  /**
   * Next action to be executed (Start or Stop)
   */
  @visibility(Lifecycle.Read)
  nextRunAction?: string;

  /**
   * Timestamp when the next action will be executed in the corresponding schedule time zone.
   */
  @visibility(Lifecycle.Read)
  nextExecutionTime?: string;
}

/**
 * Schedule info describing when the server should be started or stopped.
 */
model ScheduleItem {
  /**
   * Start day.
   */
  startDay: DayOfWeek;

  /**
   * Start time.
   */
  startTime: string;

  /**
   * Stop day.
   */
  stopDay: DayOfWeek;

  /**
   * Stop time.
   */
  stopTime: string;
}

/**
 * Properties of a subscription usage.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SubscriptionUsageProperties {
  /**
   * User-readable name of the metric.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Current value of the metric.
   */
  @visibility(Lifecycle.Read)
  currentValue?: float64;

  /**
   * Boundary value of the metric.
   */
  @visibility(Lifecycle.Read)
  limit?: float64;

  /**
   * Unit of the metric.
   */
  @visibility(Lifecycle.Read)
  unit?: string;
}

/**
 * Synapse link workspace resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SynapseLinkWorkspace extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: SynapseLinkWorkspaceProperties;
}

/**
 * Properties of a Synapse link workspaces
 */
model SynapseLinkWorkspaceProperties {
  /**
   * List of all synapselink workspaces
   */
  @identifiers(#[])
  workspaces?: SynapseLinkWorkspaceInfoProperties[];
}

/**
 * Properties of a Synapse link workspaces
 */
model SynapseLinkWorkspaceInfoProperties {
  /**
   * Synapse link workspace id.
   */
  workspaceId?: string;

  /**
   * Link connection name.
   */
  linkConnectionName?: string;
}

/**
 * Properties of an Azure SQL Database sync agent.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SyncAgentProperties {
  /**
   * Name of the sync agent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * ARM resource id of the sync database in the sync agent.
   */
  syncDatabaseId?: string;

  /**
   * Last alive time of the sync agent.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastAliveTime?: utcDateTime;

  /**
   * State of the sync agent.
   */
  @visibility(Lifecycle.Read)
  state?: SyncAgentState;

  /**
   * If the sync agent version is up to date.
   */
  @visibility(Lifecycle.Read)
  isUpToDate?: boolean;

  /**
   * Expiration time of the sync agent version.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * Version of the sync agent.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * Properties of an Azure SQL Database sync agent key.
 */
model SyncAgentKeyProperties {
  /**
   * Key of sync agent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  syncAgentKey?: string;
}

/**
 * An Azure SQL Database sync agent linked database.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SyncAgentLinkedDatabase extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: SyncAgentLinkedDatabaseProperties;
}

/**
 * Properties of an Azure SQL Database sync agent linked database.
 */
model SyncAgentLinkedDatabaseProperties {
  /**
   * Type of the sync agent linked database.
   */
  @visibility(Lifecycle.Read)
  databaseType?: SyncMemberDbType;

  /**
   * Id of the sync agent linked database.
   */
  @visibility(Lifecycle.Read)
  databaseId?: string;

  /**
   * Description of the sync agent linked database.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Server name of the sync agent linked database.
   */
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * Database name of the sync agent linked database.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * User name of the sync agent linked database.
   */
  @visibility(Lifecycle.Read)
  userName?: string;
}

/**
 * A list of sync database ID properties.
 */
model SyncDatabaseIdListResult is Azure.Core.Page<SyncDatabaseIdProperties>;

/**
 * Properties of the sync database id.
 */
model SyncDatabaseIdProperties {
  /**
   * ARM resource id of sync database.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * Properties of a sync group with support to MI.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SyncGroupProperties {
  /**
   * Sync interval of the sync group.
   */
  interval?: int32;

  /**
   * Last sync time of the sync group.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTime?: utcDateTime;

  /**
   * Conflict resolution policy of the sync group.
   */
  conflictResolutionPolicy?: SyncConflictResolutionPolicy;

  /**
   * ARM resource id of the sync database in the sync group.
   */
  syncDatabaseId?: string;

  /**
   * User name for the sync group hub database credential.
   */
  hubDatabaseUserName?: string;

  /**
   * Password for the sync group hub database credential.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  hubDatabasePassword?: string;

  /**
   * Sync state of the sync group.
   */
  @visibility(Lifecycle.Read)
  syncState?: SyncGroupState;

  /**
   * Sync schema of the sync group.
   */
  schema?: SyncGroupSchema;

  /**
   * If conflict logging is enabled.
   */
  enableConflictLogging?: boolean;

  /**
   * Conflict logging retention period.
   */
  conflictLoggingRetentionInDays?: int32;

  /**
   * If use private link connection is enabled.
   */
  usePrivateLinkConnection?: boolean;

  /**
   * Private endpoint name of the sync group if use private link connection is enabled.
   */
  @visibility(Lifecycle.Read)
  privateEndpointName?: string;
}

/**
 * Properties of sync group schema.
 */
model SyncGroupSchema {
  /**
   * List of tables in sync group schema.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tables?: SyncGroupSchemaTable[];

  /**
   * Name of master sync member where the schema is from.
   */
  masterSyncMemberName?: string;
}

/**
 * Properties of table in sync group schema.
 */
model SyncGroupSchemaTable {
  /**
   * List of columns in sync group schema.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  columns?: SyncGroupSchemaTableColumn[];

  /**
   * Quoted name of sync group schema table.
   */
  quotedName?: string;
}

/**
 * Properties of column in sync group table.
 */
model SyncGroupSchemaTableColumn {
  /**
   * Quoted name of sync group table column.
   */
  quotedName?: string;

  /**
   * Data size of the column.
   */
  dataSize?: string;

  /**
   * Data type of the column.
   */
  dataType?: string;
}

/**
 * A list of sync schema properties.
 */
model SyncFullSchemaPropertiesListResult
  is Azure.Core.Page<SyncFullSchemaProperties>;

/**
 * Properties of the database full schema.
 */
model SyncFullSchemaProperties {
  /**
   * List of tables in the database full schema.
   */
  @visibility(Lifecycle.Read)
  tables?: SyncFullSchemaTable[];

  /**
   * Last update time of the database schema.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateTime?: utcDateTime;
}

/**
 * Properties of the table in the database full schema.
 */
model SyncFullSchemaTable {
  /**
   * List of columns in the table of database full schema.
   */
  @visibility(Lifecycle.Read)
  columns?: SyncFullSchemaTableColumn[];

  /**
   * Error id of the table.
   */
  @visibility(Lifecycle.Read)
  errorId?: string;

  /**
   * If there is error in the table.
   */
  @visibility(Lifecycle.Read)
  hasError?: boolean;

  /**
   * Name of the table.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Quoted name of the table.
   */
  @visibility(Lifecycle.Read)
  quotedName?: string;
}

/**
 * Properties of the column in the table of database full schema.
 */
model SyncFullSchemaTableColumn {
  /**
   * Data size of the column.
   */
  @visibility(Lifecycle.Read)
  dataSize?: string;

  /**
   * Data type of the column.
   */
  @visibility(Lifecycle.Read)
  dataType?: string;

  /**
   * Error id of the column.
   */
  @visibility(Lifecycle.Read)
  errorId?: string;

  /**
   * If there is error in the table.
   */
  @visibility(Lifecycle.Read)
  hasError?: boolean;

  /**
   * If it is the primary key of the table.
   */
  @visibility(Lifecycle.Read)
  isPrimaryKey?: boolean;

  /**
   * Name of the column.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Quoted name of the column.
   */
  @visibility(Lifecycle.Read)
  quotedName?: string;
}

/**
 * A list of sync group log properties.
 */
model SyncGroupLogListResult is Azure.Core.Page<SyncGroupLogProperties>;

/**
 * Properties of an Azure SQL Database sync group log.
 */
model SyncGroupLogProperties {
  /**
   * Timestamp of the sync group log.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Type of the sync group log.
   */
  @visibility(Lifecycle.Read)
  type?: SyncGroupLogType;

  /**
   * Source of the sync group log.
   */
  @visibility(Lifecycle.Read)
  source?: string;

  /**
   * Details of the sync group log.
   */
  @visibility(Lifecycle.Read)
  details?: string;

  /**
   * TracingId of the sync group log.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tracingId?: Azure.Core.uuid;

  /**
   * OperationStatus of the sync group log.
   */
  @visibility(Lifecycle.Read)
  operationStatus?: string;
}

/**
 * Properties of a sync member with support to MI.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SyncMemberProperties {
  /**
   * Database type of the sync member.
   */
  databaseType?: SyncMemberDbType;

  /**
   * ARM resource id of the sync agent in the sync member.
   */
  syncAgentId?: string;

  /**
   * SQL Server database id of the sync member.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlServerDatabaseId?: Azure.Core.uuid;

  /**
   * ARM resource id of the sync member logical database, for sync members in Azure.
   */
  syncMemberAzureDatabaseResourceId?: string;

  /**
   * Whether to use private link connection.
   */
  usePrivateLinkConnection?: boolean;

  /**
   * Private endpoint name of the sync member if use private link connection is enabled, for sync members in Azure.
   */
  @visibility(Lifecycle.Read)
  privateEndpointName?: string;

  /**
   * Server name of the member database in the sync member
   */
  serverName?: string;

  /**
   * Database name of the member database in the sync member.
   */
  databaseName?: string;

  /**
   * User name of the member database in the sync member.
   */
  userName?: string;

  /**
   * Password of the member database in the sync member.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  password?: string;

  /**
   * Sync direction of the sync member.
   */
  syncDirection?: SyncDirection;

  /**
   * Sync state of the sync member.
   */
  @visibility(Lifecycle.Read)
  syncState?: SyncMemberState;
}

/**
 * The properties of a time zone.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TimeZoneProperties {
  /**
   * The time zone id
   */
  @visibility(Lifecycle.Read)
  timeZoneId?: string;

  /**
   * The time zone display name
   */
  @visibility(Lifecycle.Read)
  displayName?: string;
}

/**
 * Properties of a transparent data encryption scan.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TransparentDataEncryptionProperties {
  /**
   * Specifies the state of the transparent data encryption.
   */
  state: TransparentDataEncryptionState;

  /**
   * Specifies the encryption scan state of the transparent data encryption.
   */
  scanState?: TransparentDataEncryptionScanState;
}

/**
 * A list of usages.
 */
model UsageListResult is Azure.Core.Page<Usage>;

/**
 * ARM usage.
 */
model Usage {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read)
  name?: Name;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Usage unit.
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * Usage current value.
   */
  @visibility(Lifecycle.Read)
  currentValue?: int32;

  /**
   * Usage limit.
   */
  @visibility(Lifecycle.Read)
  limit?: int32;

  /**
   * Usage requested limit.
   */
  @visibility(Lifecycle.Read)
  requestedLimit?: int32;
}

/**
 * ARM Usage Name
 */
model Name {
  /**
   * Usage name value
   */
  value?: string;

  /**
   * Usage name localized value.
   */
  localizedValue?: string;
}

/**
 * The properties of a virtual cluster.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VirtualClusterProperties {
  /**
   * Subnet resource ID for the virtual cluster.
   */
  @visibility(Lifecycle.Read)
  subnetId?: string;

  /**
   * Virtual cluster version.
   */
  version?: string;

  /**
   * List of resources in this virtual cluster.
   */
  @visibility(Lifecycle.Read)
  childResources?: string[];
}

/**
 * An update request for virtual cluster.
 */
model VirtualClusterUpdate {
  /**
   * Resource properties.
   */
  properties?: VirtualClusterProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * A refresh DNS servers operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UpdateVirtualClusterDnsServersOperation
  extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: VirtualClusterDnsServersProperties;
}

/**
 * The properties of dns servers on virtual cluster.
 */
model VirtualClusterDnsServersProperties {
  /**
   * The status of the DNS refresh operation.
   */
  @visibility(Lifecycle.Read)
  status?: DNSRefreshOperationStatus;
}

/**
 * Properties of a virtual network rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VirtualNetworkRuleProperties {
  /**
   * The ARM resource id of the virtual network subnet.
   */
  virtualNetworkSubnetId: string;

  /**
   * Create firewall rule before the virtual network has vnet service endpoint enabled.
   */
  ignoreMissingVnetServiceEndpoint?: boolean;

  /**
   * Virtual Network Rule State
   */
  @visibility(Lifecycle.Read)
  state?: VirtualNetworkRuleState;
}

/**
 * Workload classifier definition. For more information look at sys.workload_management_workload_classifiers (DMV).
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkloadClassifierProperties {
  /**
   * The workload classifier member name.
   */
  memberName: string;

  /**
   * The workload classifier label.
   */
  label?: string;

  /**
   * The workload classifier context.
   */
  context?: string;

  /**
   * The workload classifier start time for classification.
   */
  startTime?: string;

  /**
   * The workload classifier end time for classification.
   */
  endTime?: string;

  /**
   * The workload classifier importance.
   */
  importance?: string;
}

/**
 * Workload group definition. For more information look at sys.workload_management_workload_groups (DMV).
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkloadGroupProperties {
  /**
   * The workload group minimum percentage resource.
   */
  minResourcePercent: int32;

  /**
   * The workload group cap percentage resource.
   */
  maxResourcePercent: int32;

  /**
   * The workload group request minimum grant percentage.
   */
  minResourcePercentPerRequest: float64;

  /**
   * The workload group request maximum grant percentage.
   */
  maxResourcePercentPerRequest?: float64;

  /**
   * The workload group importance level.
   */
  importance?: string;

  /**
   * The workload group query execution timeout.
   */
  queryExecutionTimeout?: int32;
}

/**
 * The properties that are supported in the $filter operation.
 */
model SecurityEventsFilterParameters {
  /**
   * Filter on the event time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime?: utcDateTime;

  /**
   * Whether to show server records or not.
   */
  showServerRecords?: boolean;
}

/**
 * A list of long term retention backups.
 */
model LongTermRetentionBackupListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: LongTermRetentionBackup[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * List of managed database move operations.
 */
model ManagedDatabaseMoveOperationListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ManagedDatabaseMoveOperationResult[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * List of managed database move operations.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedInstanceAzureADOnlyAuthListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ManagedInstanceAzureADOnlyAuthentication[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of distributed availability groups in instance.
 */
model DistributedAvailabilityGroupsListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: DistributedAvailabilityGroup[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of server trust certificates in instance.
 */
model ServerTrustCertificatesListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ServerTrustCertificate[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of active directory administrators.
 */
model AdministratorListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ServerAzureADAdministrator[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of the server's Advanced Threat Protection configurations.
 */
model LogicalServerAdvancedThreatProtectionListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ServerAdvancedThreatProtection[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of active directory only authentications.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureADOnlyAuthListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ServerAzureADOnlyAuthentication[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Import export operation extensions list.
 */
model ImportExportExtensionsOperationListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ImportExportExtensionsOperationResult[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of the database's security alert policies.
 */
model DatabaseSecurityAlertListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: DatabaseSecurityAlertPolicy[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of vulnerability assessment scan results.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SQLVulnerabilityAssessmentScanListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SqlVulnerabilityAssessmentScanResults[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of server DevOps audit settings.
 */
model ServerDevOpsAuditSettingsListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ServerDevOpsAuditingSettings[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of the server's security alert policies.
 */
model LogicalServerSecurityAlertPolicyListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ServerSecurityAlertPolicy[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Result of the request to list SQL operations.
 */
model OperationListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Operation[];

  /**
   * Link to retrieve next page of results.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}

/**
 * A Server ImportExport operation result resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerImportExportOperationResult extends CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: ServerImportExportOperationResultProperties;
}

/**
 * Contains the operation result properties for import/export operation.
 */
model ServerImportExportOperationResultProperties {
  /**
   * Request Id.
   */
  @visibility(Lifecycle.Read)
  requestId?: Azure.Core.uuid;

  /**
   * Request type.
   */
  @visibility(Lifecycle.Read)
  requestType?: string;

  /**
   * Queued time.
   */
  @visibility(Lifecycle.Read)
  queuedTime?: string;

  /**
   * Last modified time.
   */
  @visibility(Lifecycle.Read)
  lastModifiedTime?: string;

  /**
   * Blob Uri.
   */
  @visibility(Lifecycle.Read)
  blobUri?: string;

  /**
   * Server name.
   */
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * Database name.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Operation status.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * Gets the status of private endpoints associated with this request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnectionRequestStatus[];
}

/**
 * Azure Active Directory identity configuration for a resource.
 */
model DataSyncParticipantIdentity {
  /**
   * The Datasync identity type
   */
  type: DataSyncParticipantIdentityType;

  /**
   * The DataSync participant identity tenant id
   */
  tenantId?: Azure.Core.uuid;

  /**
   * The resource ids of the user assigned identities to use
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<DataSyncParticipantUserAssignedIdentity>;
}

/**
 * Azure Active Directory identity configuration for a resource.
 */
model DataSyncParticipantUserAssignedIdentity {
  /**
   * The Azure Active Directory principal id.
   */
  @visibility(Lifecycle.Read)
  principalId?: Azure.Core.uuid;

  /**
   * The Azure Active Directory client id.
   */
  @visibility(Lifecycle.Read)
  clientId?: Azure.Core.uuid;
}
