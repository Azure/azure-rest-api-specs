import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace SqlPools;

/**
 * Specifies the mode of sql pool creation.
 *
 * Default: regular sql pool creation.
 *
 * PointInTimeRestore: Creates a sql pool by restoring a point in time backup of an existing sql pool. sourceDatabaseId must be specified as the resource ID of the existing sql pool, and restorePointInTime must be specified.
 *
 * Recovery: Creates a sql pool by a geo-replicated backup. sourceDatabaseId  must be specified as the recoverableDatabaseId to restore.
 *
 * Restore: Creates a sql pool by restoring a backup of a deleted sql  pool. SourceDatabaseId should be the sql pool's original resource ID. SourceDatabaseId and sourceDatabaseDeletionDate must be specified.
 */
union CreateMode {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * PointInTimeRestore
   */
  PointInTimeRestore: "PointInTimeRestore",

  /**
   * Recovery
   */
  Recovery: "Recovery",

  /**
   * Restore
   */
  Restore: "Restore",
}

/**
 * The storage account type used to store backups for this sql pool.
 */
union StorageAccountType {
  string,

  /**
   * GRS
   */
  GRS: "GRS",

  /**
   * LRS
   */
  LRS: "LRS",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union GeoBackupPolicyName {
  string,

  /**
   * Default
   */
  Default: "Default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union DataWarehouseUserActivityName {
  string,

  /**
   * current
   */
  current: "current",
}

/**
 * The replication state for the replication link.
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union TransparentDataEncryptionName {
  string,

  /**
   * current
   */
  current: "current",
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ConnectionPolicyName {
  string,

  /**
   * default
   */
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union VulnerabilityAssessmentName {
  string,

  /**
   * default
   */
  default: "default",
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union SecurityAlertPolicyName {
  string,

  /**
   * default
   */
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union BlobAuditingPolicyName {
  string,

  /**
   * default
   */
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union SecurityAlertPolicyNameAutoGenerated {
  string,

  /**
   * Default
   */
  Default: "Default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union EncryptionProtectorName {
  string,

  /**
   * current
   */
  current: "current",
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union DedicatedSQLMinimalTlsSettingsName {
  string,

  /**
   * default
   */
  default: "default",
}

/**
 * The state of the geo backup policy.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum GeoBackupPolicyState {
  /**
   * Disabled
   */
  Disabled,

  /**
   * Enabled
   */
  Enabled,
}

/**
 * The type of restore point
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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
 * The role of the Sql pool in the replication link.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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
 * The status of the database transparent data encryption.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum TransparentDataEncryptionStatus {
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
 * Specifies the state of the policy. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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

/**
 * Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific Sql pool.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The published path parameter is a closed enum (modelAsString: false); opening it would change the contract."
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
union VulnerabilityAssessmentPolicyBaselineName {
  /**
   * master
   */
  master: "master",

  /**
   * default
   */
  default: "default",
}

/**
 * The state of the data masking policy.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DataMaskingState {
  /**
   * Disabled
   */
  Disabled,

  /**
   * Enabled
   */
  Enabled,
}

/**
 * The rule state. Used to delete a rule. To delete an existing rule, specify the schemaName, tableName, columnName, maskingFunction, and specify ruleState as disabled. However, if the rule doesn't already exist, the rule will be created with ruleState set to enabled, regardless of the provided value of ruleState.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DataMaskingRuleState {
  /**
   * Disabled
   */
  Disabled,

  /**
   * Enabled
   */
  Enabled,
}

/**
 * The masking function that is used for the data masking rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DataMaskingFunction {
  /**
   * Default
   */
  Default,

  /**
   * CCN
   */
  CCN,

  /**
   * Email
   */
  Email,

  /**
   * Number
   */
  Number,

  /**
   * SSN
   */
  SSN,

  /**
   * Text
   */
  Text,
}

/**
 * The function that is used to aggregate each query's metrics.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum QueryAggregationFunction {
  /**
   * min
   */
  min,

  /**
   * max
   */
  max,

  /**
   * avg
   */
  avg,

  /**
   * sum
   */
  sum,
}

/**
 * The execution type that is used to filter the query instances that are returned.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum QueryExecutionType {
  /**
   * any
   */
  any,

  /**
   * regular
   */
  regular,

  /**
   * irregular
   */
  irregular,

  /**
   * aborted
   */
  aborted,

  /**
   * exception
   */
  exception,
}

/**
 * The type of metric to use for ordering the top metrics.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum QueryObservedMetricType {
  /**
   * cpu
   */
  cpu,

  /**
   * io
   */
  io,

  /**
   * logio
   */
  logio,

  /**
   * duration
   */
  duration,

  /**
   * executionCount
   */
  executionCount,
}

/**
 * The unit of measurement
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum QueryMetricUnit {
  /**
   * percentage
   */
  percentage,

  /**
   * KB
   */
  KB,

  /**
   * microseconds
   */
  microseconds,
}

/**
 * SQL pool SKU
 */
model Sku {
  /**
   * The service tier
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tier?: string;

  /**
   * The SKU name
   */
  name?: string;

  /**
   * If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  capacity?: int32;
}

/**
 * Properties of a SQL Analytics pool
 */
model SqlPoolResourceProperties {
  /**
   * Maximum size in bytes
   */
  maxSizeBytes?: int64;

  /**
   * Collation mode
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  collation?: string = "";

  /**
   * Source database to create from
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  sourceDatabaseId?: string;

  /**
   * Backup database to restore from
   */
  recoverableDatabaseId?: string;

  /**
   * Resource state
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  provisioningState?: string;

  /**
   * Resource status
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Snapshot time to restore
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restorePointInTime?: utcDateTime;

  /**
   * Specifies the mode of sql pool creation.
   *
   * Default: regular sql pool creation.
   *
   * PointInTimeRestore: Creates a sql pool by restoring a point in time backup of an existing sql pool. sourceDatabaseId must be specified as the resource ID of the existing sql pool, and restorePointInTime must be specified.
   *
   * Recovery: Creates a sql pool by a geo-replicated backup. sourceDatabaseId  must be specified as the recoverableDatabaseId to restore.
   *
   * Restore: Creates a sql pool by restoring a backup of a deleted sql  pool. SourceDatabaseId should be the sql pool's original resource ID. SourceDatabaseId and sourceDatabaseDeletionDate must be specified.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  createMode?: CreateMode;

  /**
   * Date the SQL pool was created
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The storage account type used to store backups for this sql pool.
   */
  storageAccountType?: StorageAccountType = StorageAccountType.GRS;

  /**
   * Specifies the time that the sql pool was deleted
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sourceDatabaseDeletionDate?: utcDateTime;
}

/**
 * A SQL Analytics pool patch info
 */
model SqlPoolPatchInfo {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  location?: string;

  /**
   * SQL pool SKU
   */
  sku?: Sku;

  /**
   * SQL pool properties
   */
  properties?: SqlPoolResourceProperties;
}

/**
 * The response to a list geo backup policies request.
 */
model GeoBackupPolicyListResult {
  /**
   * The list of geo backup policies.
   */
  @pageItems
  value?: GeoBackupPolicy[];
}

/**
 * The properties of the geo backup policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
 * User activities of a data warehouse. This currently includes the count of running or suspended queries. For more information, please view the sys.dm_pdw_exec_requests dynamic management view (DMV).
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DataWarehouseUserActivitiesProperties {
  /**
   * Count of running and suspended queries.
   */
  @visibility(Lifecycle.Read)
  activeQueriesCount?: int32;
}

/**
 * Properties of a database restore point
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
 * Contains the information necessary to perform a create Sql pool restore point operation.
 */
model CreateSqlPoolRestorePointDefinition {
  /**
   * The restore point label to apply
   */
  restorePointLabel: string;
}

/**
 * Represents the properties of a Sql pool replication link.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ReplicationLinkProperties {
  /**
   * Legacy value indicating whether termination is allowed.  Currently always returns true.
   */
  @visibility(Lifecycle.Read)
  isTerminationAllowed?: boolean;

  /**
   * Replication mode of this replication link.
   */
  @visibility(Lifecycle.Read)
  replicationMode?: string;

  /**
   * The name of the workspace hosting the partner Sql pool.
   */
  @visibility(Lifecycle.Read)
  partnerServer?: string;

  /**
   * The name of the partner Sql pool.
   */
  @visibility(Lifecycle.Read)
  partnerDatabase?: string;

  /**
   * The Azure Region of the partner Sql pool.
   */
  @visibility(Lifecycle.Read)
  partnerLocation?: string;

  /**
   * The role of the Sql pool in the replication link.
   */
  @visibility(Lifecycle.Read)
  role?: ReplicationRole;

  /**
   * The role of the partner Sql pool in the replication link.
   */
  @visibility(Lifecycle.Read)
  partnerRole?: ReplicationRole;

  /**
   * The start time for the replication link.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The percentage of seeding complete for the replication link.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * The replication state for the replication link.
   */
  @visibility(Lifecycle.Read)
  replicationState?: ReplicationState;
}

/**
 * Maintenance windows resource properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model MaintenanceWindowsProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#[])
  timeRanges?: MaintenanceWindowTimeRange[];
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
 * Maintenance window options properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model MaintenanceWindowOptionsProperties {
  /**
   * Whether maintenance windows are enabled for the database.
   */
  isEnabled?: boolean;

  /**
   * Available maintenance cycles e.g. {Saturday, 0, 48*60}, {Wednesday, 0, 24*60}.
   */
  @identifiers(#[])
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
 * Represents the properties of a database transparent data encryption.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model TransparentDataEncryptionProperties {
  /**
   * The status of the database transparent data encryption.
   */
  status?: TransparentDataEncryptionStatus;
}

/**
 * Properties of a Sql pool blob auditing policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SqlPoolBlobAuditingPolicyProperties {
  /**
   * Specifies the state of the policy. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
   */
  state: BlobAuditingPolicyState;

  /**
   * Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). If state is Enabled, storageEndpoint is required.
   */
  storageEndpoint?: string;

  /**
   * Specifies the identifier key of the auditing storage account. If state is Enabled and storageEndpoint is specified, storageAccountAccessKey is required.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Not marked x-ms-secret in the published API; adding @secret changes the contract (x-ms-secret, format password). Flagged for review."
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageAccountAccessKey?: string;

  /**
   * Specifies the number of days to keep in the audit logs in the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
   * Specifies the blob storage subscription Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @format("uuid")
  storageAccountSubscriptionId?: string;

  /**
   * Specifies whether storageAccountAccessKey value is the storage's secondary key.
   */
  isStorageSecondaryKeyInUse?: boolean;

  /**
   * Specifies whether audit events are sent to Azure Monitor.
   * In order to send the events to Azure Monitor, specify 'state' as 'Enabled' and 'isAzureMonitorTargetEnabled' as true.
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
  isAzureMonitorTargetEnabled?: boolean = false;
}

/**
 * A Sql pool operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SqlPoolOperation extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: SqlPoolOperationProperties;
}

/**
 * The properties of a Sql pool operation.
 */
model SqlPoolOperationProperties {
  /**
   * The name of the Sql pool the operation is being performed on.
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
}

/**
 * The response to a list Sql pool usages request.
 */
model SqlPoolUsageListResult {
  /**
   * The list of usages for the Sql pool.
   */
  @pageItems
  @identifiers(#[])
  value: SqlPoolUsage[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * The Sql pool usages.
 */
model SqlPoolUsage {
  /**
   * The name of the usage metric.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  resourceName?: string;

  /**
   * The usage metric display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The current value of the usage metric.
   */
  @visibility(Lifecycle.Read)
  currentValue?: float64;

  /**
   * The current limit of the usage metric.
   */
  @visibility(Lifecycle.Read)
  limit?: float64;

  /**
   * The units of the usage metric.
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * The next reset time for the usage metric (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextResetTime?: utcDateTime;
}

/**
 * Properties of a sensitivity label.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  rank?: SensitivityLabelRank;
}

/**
 * A list of sensitivity label update operations.
 */
model SensitivityLabelUpdateList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  operations?: SensitivityLabelUpdate[];
}

/**
 * A sensitivity label update operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SensitivityLabelUpdate
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: SensitivityLabelUpdateProperties;
}

/**
 * Properties of an operation executed on a sensitivity label.
 */
model SensitivityLabelUpdateProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  operations?: RecommendedSensitivityLabelUpdate[];
}

/**
 * A recommended sensitivity label update operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RecommendedSensitivityLabelUpdate
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: RecommendedSensitivityLabelUpdateProperties;
}

/**
 * Properties of an operation executed on a recommended sensitivity label.
 */
model RecommendedSensitivityLabelUpdateProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
 * Sql pool column properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SqlPoolColumnProperties {
  /**
   * The column data type.
   */
  columnType?: ColumnDataType;

  /**
   * Indicates whether column value is computed or not
   */
  @visibility(Lifecycle.Read)
  isComputed?: boolean;
}

/**
 * Properties of a Sql pool connection policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SqlPoolConnectionPolicyProperties {
  /**
   * The state of security access.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "False positive: an access-state string, not a credential."
  securityEnabledAccess?: string;

  /**
   * The fully qualified host name of the auditing proxy.
   */
  proxyDnsName?: string;

  /**
   * The port number of the auditing proxy.
   */
  proxyPort?: string;

  /**
   * The visibility of the auditing proxy.
   */
  visibility?: string;

  /**
   * Whether server default is enabled or disabled.
   */
  useServerDefault?: string;

  /**
   * The state of proxy redirection.
   */
  redirectionState?: string;

  /**
   * The connection policy state.
   */
  state?: string;
}

/**
 * Properties of a Sql pool Vulnerability Assessment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SqlPoolVulnerabilityAssessmentProperties {
  /**
   * A blob storage container path to hold the scan results (e.g. https://myStorage.blob.core.windows.net/VaScans/).  It is required if server level vulnerability assessment policy doesn't set
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  storageContainerPath?: string;

  /**
   * A shared access signature (SAS Key) that has write access to the blob container specified in 'storageContainerPath' parameter. If 'storageAccountAccessKey' isn't specified, StorageContainerSasKey is required.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Not marked x-ms-secret in the published API; adding @secret changes the contract (x-ms-secret, format password). Flagged for review."
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageContainerSasKey?: string;

  /**
   * Specifies the identifier key of the storage account for vulnerability assessment scan results. If 'StorageContainerSasKey' isn't specified, storageAccountAccessKey is required.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Not marked x-ms-secret in the published API; adding @secret changes the contract (x-ms-secret, format password). Flagged for review."
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
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  @visibility(Lifecycle.Read)
  @identifiers(#[])
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
 * A Sql pool Vulnerability Assessment scan export resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SqlPoolVulnerabilityAssessmentScansExport
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
  properties?: SqlPoolVulnerabilityAssessmentScanExportProperties;
}

/**
 * Properties of the export operation's result.
 */
model SqlPoolVulnerabilityAssessmentScanExportProperties {
  /**
   * Location of the exported report (e.g. https://myStorage.blob.core.windows.net/VaScans/scans/serverName/databaseName/scan_scanId.xlsx).
   */
  @visibility(Lifecycle.Read)
  exportedReportLocation?: string;
}

/**
 * A list of SQL pool security alert policies.
 */
model ListSqlPoolSecurityAlertPolicies {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SqlPoolSecurityAlertPolicy[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Properties of a security alert policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SecurityAlertPolicyProperties {
  /**
   * Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific Sql pool.
   */
  state: SecurityAlertPolicyState;

  /**
   * Specifies an array of alerts that are disabled. Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly, Data_Exfiltration, Unsafe_Action
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  disabledAlerts?: string[];

  /**
   * Specifies an array of e-mail addresses to which the alert is sent.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Not marked x-ms-secret in the published API; adding @secret changes the contract (x-ms-secret, format password). Flagged for review."
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
 * Properties of a Sql pool vulnerability assessment rule baseline.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SqlPoolVulnerabilityAssessmentRuleBaselineProperties {
  /**
   * The rule baseline result
   */
  @identifiers(#[])
  baselineResults: SqlPoolVulnerabilityAssessmentRuleBaselineItem[];
}

/**
 * Properties for an Sql pool vulnerability assessment rule baseline's result.
 */
model SqlPoolVulnerabilityAssessmentRuleBaselineItem {
  /**
   * The rule baseline result
   */
  result: string[];
}

/**
 * Properties of an extended Sql pool blob auditing policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ExtendedSqlPoolBlobAuditingPolicyProperties {
  /**
   * Specifies condition of where clause when creating an audit.
   */
  predicateExpression?: string;

  /**
   * Specifies the state of the policy. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Not marked x-ms-secret in the published API; adding @secret changes the contract (x-ms-secret, format password). Flagged for review."
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageAccountAccessKey?: string;

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
   * Specifies the blob storage subscription Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  storageAccountSubscriptionId?: string;

  /**
   * Specifies whether storageAccountAccessKey value is the storage's secondary key.
   */
  isStorageSecondaryKeyInUse?: boolean;

  /**
   * Specifies whether audit events are sent to Azure Monitor.
   * In order to send the events to Azure Monitor, specify 'state' as 'Enabled' and 'isAzureMonitorTargetEnabled' as true.
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
}

/**
 * The properties of a database data masking policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
 * The properties of a Sql pool data masking rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DataMaskingRuleProperties {
  /**
   * The rule Id.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Published property: the rule properties include a read-only id."
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The alias name. This is a legacy parameter and is no longer used.
   */
  aliasName?: string;

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
 * The response to a list data masking rules request.
 */
model DataMaskingRuleListResult {
  /**
   * The list of Sql pool data masking rules.
   */
  @pageItems
  value?: DataMaskingRule[];
}

/**
 * Workload group definition. For more information look at sys.workload_management_workload_groups (DMV).
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
 * Workload classifier definition. For more information look at sys.workload_management_workload_classifiers (DMV).
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
 * Properties of a server blob auditing policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ServerBlobAuditingPolicyProperties {
  /**
   * Specifies the state of the policy. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Not marked x-ms-secret in the published API; adding @secret changes the contract (x-ms-secret, format password). Flagged for review."
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageAccountAccessKey?: string;

  /**
   * Specifies the number of days to keep in the audit logs in the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  auditActionsAndGroups?: string[];

  /**
   * Specifies the blob storage subscription Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @format("uuid")
  storageAccountSubscriptionId?: string;

  /**
   * Specifies whether storageAccountAccessKey value is the storage's secondary key.
   */
  isStorageSecondaryKeyInUse?: boolean;

  /**
   * Specifies whether audit events are sent to Azure Monitor.
   * In order to send the events to Azure Monitor, specify 'state' as 'Enabled' and 'isAzureMonitorTargetEnabled' as true.
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
}

/**
 * Properties of an extended server blob auditing policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ExtendedServerBlobAuditingPolicyProperties {
  /**
   * Specifies condition of where clause when creating an audit.
   */
  predicateExpression?: string;

  /**
   * Specifies the state of the policy. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Not marked x-ms-secret in the published API; adding @secret changes the contract (x-ms-secret, format password). Flagged for review."
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageAccountAccessKey?: string;

  /**
   * Specifies the number of days to keep in the audit logs in the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
   * Specifies the blob storage subscription Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @format("uuid")
  storageAccountSubscriptionId?: string;

  /**
   * Specifies whether storageAccountAccessKey value is the storage's secondary key.
   */
  isStorageSecondaryKeyInUse?: boolean;

  /**
   * Specifies whether audit events are sent to Azure Monitor.
   * In order to send the events to Azure Monitor, specify 'state' as 'Enabled' and 'isAzureMonitorTargetEnabled' as true.
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
}

/**
 * Properties of a security alert policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ServerSecurityAlertPolicyProperties {
  /**
   * Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific server
   */
  state: SecurityAlertPolicyState;

  /**
   * Specifies an array of alerts that are disabled. Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly, Data_Exfiltration, Unsafe_Action
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  disabledAlerts?: string[];

  /**
   * Specifies an array of e-mail addresses to which the alert is sent.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  emailAddresses?: string[];

  /**
   * Specifies that the alert is sent to the account administrators.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  emailAccountAdmins?: boolean;

  /**
   * Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageEndpoint?: string;

  /**
   * Specifies the identifier key of the Threat Detection audit storage account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Not marked x-ms-secret in the published API; adding @secret changes the contract (x-ms-secret, format password). Flagged for review."
  storageAccountAccessKey?: string;

  /**
   * Specifies the number of days to keep in the Threat Detection audit logs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  retentionDays?: int32;

  /**
   * Specifies the UTC creation time of the policy.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

/**
 * Properties of a server Vulnerability Assessment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ServerVulnerabilityAssessmentProperties {
  /**
   * A blob storage container path to hold the scan results (e.g. https://myStorage.blob.core.windows.net/VaScans/).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageContainerPath: string;

  /**
   * A shared access signature (SAS Key) that has read and write access to the blob container specified in 'storageContainerPath' parameter. If 'storageAccountAccessKey' isn't specified, StorageContainerSasKey is required.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Not marked x-ms-secret in the published API; adding @secret changes the contract (x-ms-secret, format password). Flagged for review."
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageContainerSasKey?: string;

  /**
   * Specifies the identifier key of the storage account for vulnerability assessment scan results. If 'StorageContainerSasKey' isn't specified, storageAccountAccessKey is required.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Not marked x-ms-secret in the published API; adding @secret changes the contract (x-ms-secret, format password). Flagged for review."
  @visibility(Lifecycle.Create, Lifecycle.Update)
  storageAccountAccessKey?: string;

  /**
   * The recurring scans settings
   */
  recurringScans?: VulnerabilityAssessmentRecurringScansProperties;
}

/**
 * Properties for an encryption protector execution.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
}

/**
 * Represents the response to a list server metrics request.
 */
model ServerUsageListResult {
  /**
   * The list of server metrics for the server.
   */
  @pageItems
  @identifiers(#[])
  value: ServerUsage[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Represents server metrics.
 */
model ServerUsage {
  /**
   * Name of the server usage metric.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  resourceName?: string;

  /**
   * The metric display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The current value of the metric.
   */
  @visibility(Lifecycle.Read)
  currentValue?: float64;

  /**
   * The current limit of the metric.
   */
  @visibility(Lifecycle.Read)
  limit?: float64;

  /**
   * The units of the metric.
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * The next reset time for the metric (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextResetTime?: utcDateTime;
}

/**
 * The properties of a recoverable sql pool
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RecoverableSqlPoolProperties {
  /**
   * The edition of the database
   */
  @visibility(Lifecycle.Read)
  edition?: string;

  /**
   * The service level objective name of the database
   */
  @visibility(Lifecycle.Read)
  serviceLevelObjective?: string;

  /**
   * The elastic pool name of the database
   */
  @visibility(Lifecycle.Read)
  elasticPoolName?: string;

  /**
   * The last available backup date of the database (ISO8601 format)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastAvailableBackupDate?: utcDateTime;
}

/**
 * Properties of a dedicated sql minimal tls settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Published definition name; renaming would change the OpenAPI definition and SDK type name."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DedicatedSQLminimalTlsSettingsProperties {
  /**
   * The minimal tls version of the sql server.
   */
  minimalTlsVersion?: string;
}

/**
 * A database query.
 */
model TopQueries {
  /**
   * The function that is used to aggregate each query's metrics.
   */
  @visibility(Lifecycle.Read)
  aggregationFunction?: QueryAggregationFunction;

  /**
   * The execution type that is used to filter the query instances that are returned.
   */
  @visibility(Lifecycle.Read)
  executionType?: QueryExecutionType;

  /**
   * The duration of the interval (ISO8601 duration format).
   */
  @visibility(Lifecycle.Read)
  intervalType?: string;

  /**
   * The number of requested queries.
   */
  @visibility(Lifecycle.Read)
  numberOfTopQueries?: int32;

  /**
   * The start time for queries that are returned (ISO8601 format)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  observationStartTime?: utcDateTime;

  /**
   * The end time for queries that are returned (ISO8601 format)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  observationEndTime?: utcDateTime;

  /**
   * The type of metric to use for ordering the top metrics.
   */
  @visibility(Lifecycle.Read)
  observedMetric?: QueryObservedMetricType;

  /**
   * The list of queries.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  queries?: QueryStatistic[];
}

/**
 * A database query.
 */
model QueryStatistic {
  /**
   * The id of the query
   */
  @visibility(Lifecycle.Read)
  queryId?: string;

  /**
   * The list of query intervals.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  intervals?: QueryInterval[];
}

/**
 * A database query.
 */
model QueryInterval {
  /**
   * The start time of the measurement interval (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  intervalStartTime?: utcDateTime;

  /**
   * The number of times the query was executed during this interval.
   */
  @visibility(Lifecycle.Read)
  executionCount?: int32;

  /**
   * The list of query metrics during this interval.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  metrics?: QueryMetric[];
}

/**
 * A database query.
 */
model QueryMetric {
  /**
   * The name of the metric
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The name of the metric for display in user interface
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The unit of measurement
   */
  @visibility(Lifecycle.Read)
  unit?: QueryMetricUnit;

  /**
   * The measured value
   */
  @visibility(Lifecycle.Read)
  value?: float64;
}

/**
 * Represents the response to a get top queries request.
 */
model TopQueriesListResult {
  /**
   * The list of top queries.
   */
  @identifiers(#[])
  value: TopQueries[];
}

/**
 * Dedicated SQL minimal tls settings patch info
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Published definition name; renaming would change the OpenAPI definition and SDK type name."
model DedicatedSQLminimalTlsSettingsPatchInfo {
  /**
   * minimal tls version
   */
  minimalTlsVersion?: string;
}

/**
 * The name of the data masking policy (always Default).
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Closed single-value enum preserves the original x-ms-enum name"
enum DataMaskingPolicyName {
  /**
   * Default
   */
  Default,
}

namespace SqlPoolLevel {
  /**
   * The name of the SQL pool blob auditing policy (always default).
   * Declared in a sub-namespace so it keeps the original x-ms-enum name, which the workspace-level open union also uses.
   */
  #suppress "@azure-tools/typespec-azure-core/no-enum" "Closed single-value enum preserves the original x-ms-enum name"
  enum BlobAuditingPolicyName {
    /**
     * default
     */
    default,
  }
}

/**
 * The writable source of a sensitivity label (current).
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Closed single-value enum preserves the original x-ms-enum name"
enum WritableSensitivityLabelSource {
  /**
   * current
   */
  current,
}

/**
 * The source of a recommended sensitivity label (recommended).
 */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The published path parameter is a closed enum (modelAsString: false); opening it would change the contract."
union RecommendedSensitivityLabelSource {
  /**
   * recommended
   */
  recommended: "recommended",
}

/**
 * List of SQL pools
 */
model SqlPoolInfoListResult {
  /**
   * List of SQL pools
   */
  @pageItems
  value?: SqlPool[];

  /**
   * Link to the next page of results
   */
  @nextLink
  nextLink?: string;
}

/**
 * A list of sql pool extended auditing settings.
 */
model ExtendedSqlPoolBlobAuditingPolicyListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ExtendedSqlPoolBlobAuditingPolicy[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of Sql pool auditing settings.
 */
model SqlPoolBlobAuditingPolicyListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SqlPoolBlobAuditingPolicy[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Represents the response to a List Sql pool replication link request.
 */
model ReplicationLinkListResult {
  /**
   * The list of Sql pool replication links housed in the Sql pool.
   */
  @pageItems
  value?: ReplicationLink[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of long term retention backups.
 */
model RestorePointListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: RestorePoint[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of Sql pool schemas.
 */
model SqlPoolSchemaListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SqlPoolSchema[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of Sql pool columns.
 */
model SqlPoolColumnListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SqlPoolColumn[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of Sql pool tables.
 */
model SqlPoolTableListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SqlPoolTable[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of transparent data encryption configurations.
 */
model TransparentDataEncryptionListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: TransparentDataEncryption[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of vulnerability assessment scan records.
 */
model VulnerabilityAssessmentScanRecordListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: VulnerabilityAssessmentScanRecord[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of the Sql pool's vulnerability assessments.
 */
model SqlPoolVulnerabilityAssessmentListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SqlPoolVulnerabilityAssessment[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of workload classifiers for a workload group.
 */
model WorkloadClassifierListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: WorkloadClassifier[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of workload groups.
 */
model WorkloadGroupListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: WorkloadGroup[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of server auditing settings.
 */
model ServerBlobAuditingPolicyListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ServerBlobAuditingPolicy[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of the server's dedicated sql minimal tls settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Published definition name; renaming would change the OpenAPI definition and SDK type name."
model DedicatedSQLminimalTlsSettingsListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: DedicatedSQLminimalTlsSettings[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of server encryption protectors.
 */
model EncryptionProtectorListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: EncryptionProtector[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of server extended auditing settings.
 */
model ExtendedServerBlobAuditingPolicyListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ExtendedServerBlobAuditingPolicy[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * The response to a list recoverable sql pools request
 */
model RecoverableSqlPoolListResult {
  /**
   * A list of recoverable sql pool
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: RecoverableSqlPool[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of the workspace managed sql server's security alert policies.
 */
model ServerSecurityAlertPolicyListResult {
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
 * A list of the server's vulnerability assessments.
 */
model ServerVulnerabilityAssessmentListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ServerVulnerabilityAssessment[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * The response to a list Sql pool operations request
 */
model SqlPoolBlobAuditingPolicySqlPoolOperationListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SqlPoolOperation[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A list of sensitivity labels.
 */
model SensitivityLabelListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SensitivityLabel[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}
