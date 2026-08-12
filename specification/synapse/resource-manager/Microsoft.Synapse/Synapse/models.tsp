import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Synapse;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union AzureADOnlyAuthenticationName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  default: "default",
}

/**
 * property configuration state
 */
union StateValue {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Consistent: "Consistent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InConsistent: "InConsistent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
}

/**
 * Resource provisioning state
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeleteError: "DeleteError",
}

/**
 * Operation status
 */
union OperationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PointInTimeRestore: "PointInTimeRestore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Recovery: "Recovery",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Restore: "Restore",
}

/**
 * The storage account type used to store backups for this sql pool.
 */
union StorageAccountType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GRS: "GRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LRS: "LRS",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union GeoBackupPolicyName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union DataWarehouseUserActivityName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  current: "current",
}

/**
 * The replication state for the replication link.
 */
union ReplicationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PENDING: "PENDING",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SEEDING: "SEEDING",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CATCH_UP: "CATCH_UP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SUSPENDED: "SUSPENDED",
}

/**
 * Day of maintenance window.
 */
union DayOfWeek {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Sunday: "Sunday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Monday: "Monday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Tuesday: "Tuesday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Wednesday: "Wednesday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Thursday: "Thursday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Friday: "Friday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Saturday: "Saturday",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union TransparentDataEncryptionName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  current: "current",
}

/**
 * The operation state.
 */
union ManagementOperationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CancelInProgress: "CancelInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cancelled: "Cancelled",
}

/**
 * The column data type.
 */
union ColumnDataType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  image: "image",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  text: "text",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  uniqueidentifier: "uniqueidentifier",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  date: "date",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  time: "time",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  datetime2: "datetime2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  datetimeoffset: "datetimeoffset",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  tinyint: "tinyint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  smallint: "smallint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  int: "int",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  smalldatetime: "smalldatetime",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  real: "real",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  money: "money",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  datetime: "datetime",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  float: "float",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  sql_variant: "sql_variant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ntext: "ntext",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  bit: "bit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  decimal: "decimal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  numeric: "numeric",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  smallmoney: "smallmoney",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  bigint: "bigint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  hierarchyid: "hierarchyid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  geometry: "geometry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  geography: "geography",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  varbinary: "varbinary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  varchar: "varchar",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  binary: "binary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  char: "char",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  timestamp: "timestamp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  nvarchar: "nvarchar",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  nchar: "nchar",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  xml: "xml",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  sysname: "sysname",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ConnectionPolicyName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union VulnerabilityAssessmentName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  default: "default",
}

/**
 * The scan trigger type.
 */
union VulnerabilityAssessmentScanTriggerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OnDemand: "OnDemand",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Recurring: "Recurring",
}

/**
 * The scan status.
 */
union VulnerabilityAssessmentScanState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Passed: "Passed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FailedToRun: "FailedToRun",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union SqlPoolSecurityAlertPolicyName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union BlobAuditingPolicyName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union SqlServerSecurityAlertPolicyName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union EncryptionProtectorName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  current: "current",
}

/**
 * The encryption protector type like 'ServiceManaged', 'AzureKeyVault'.
 */
union ServerKeyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ServiceManaged: "ServiceManaged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureKeyVault: "AzureKeyVault",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union DedicatedSQLMinimalTlsSettingsName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  default: "default",
}

/**
 * Enable or Disable public network access to workspace
 */
union WorkspacePublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The type of the spark config properties file.
 */
union ConfigurationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  File: "File",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Artifact: "Artifact",
}

/**
 * The level of compute power that each node in the Big Data pool has.
 */
union NodeSize {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Small: "Small",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Medium: "Medium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Large: "Large",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  XLarge: "XLarge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  XXLarge: "XXLarge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  XXXLarge: "XXXLarge",
}

/**
 * The kind of nodes that the Big Data pool provides.
 */
union NodeSizeFamily {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MemoryOptimized: "MemoryOptimized",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HardwareAcceleratedFPGA: "HardwareAcceleratedFPGA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HardwareAcceleratedGPU: "HardwareAcceleratedGPU",
}

/**
 * The state of integration runtime auto update.
 */
union IntegrationRuntimeAutoUpdate {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  On: "On",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Off: "Off",
}

/**
 * The type of integration runtime.
 */
union IntegrationRuntimeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Managed: "Managed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SelfHosted: "SelfHosted",
}

/**
 * The type of SSIS object metadata.
 */
union SsisObjectMetadataType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Folder: "Folder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Project: "Project",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Package: "Package",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Environment: "Environment",
}

/**
 * Status of the integration runtime node.
 */
union SelfHostedIntegrationRuntimeNodeStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NeedRegistration: "NeedRegistration",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Online: "Online",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Limited: "Limited",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Offline: "Offline",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Upgrading: "Upgrading",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Initializing: "Initializing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InitializeFailed: "InitializeFailed",
}

/**
 * The result of the last integration runtime node update.
 */
union IntegrationRuntimeUpdateResult {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeed: "Succeed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Fail: "Fail",
}

/**
 * The state of integration runtime.
 */
union IntegrationRuntimeState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Initial: "Initial",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Started: "Started",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Starting: "Starting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stopping: "Stopping",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NeedRegistration: "NeedRegistration",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Online: "Online",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Limited: "Limited",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Offline: "Offline",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AccessDenied: "AccessDenied",
}

/**
 * The name of the authentication key to regenerate.
 */
union IntegrationRuntimeAuthKeyName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  authKey1: "authKey1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  authKey2: "authKey2",
}

/**
 * status of Start Integrationruntimes.
 */
union WorkspaceStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * Message providing the reason why the given name is invalid.
 */
union Reason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AlreadyExists: "AlreadyExists",
}

/**
 * SKU name.
 */
union SkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Compute optimized`: "Compute optimized",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Storage optimized`: "Storage optimized",
}

/**
 * SKU size.
 */
union SkuSize {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Extra small`: "Extra small",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Small: "Small",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Medium: "Medium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Large: "Large",
}

/**
 * The state of the resource.
 */
union State {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unavailable: "Unavailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stopping: "Stopping",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Starting: "Starting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
}

/**
 * The provisioned state of the resource.
 */
union ResourceProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * Language extension that can run within KQL query.
 */
union LanguageExtensionName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PYTHON: "PYTHON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  R: "R",
}

/**
 * Scale type.
 */
union AzureScaleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  automatic: "automatic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  manual: "manual",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  none: "none",
}

/**
 * The default principals modification kind
 */
union DefaultPrincipalsModificationKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Union: "Union",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Replace: "Replace",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * Kind of the database
 */
union Kind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ReadWrite: "ReadWrite",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ReadOnlyFollowing: "ReadOnlyFollowing",
}

/**
 * Kind of the endpoint for the data connection
 */
union DataConnectionKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EventHub: "EventHub",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EventGrid: "EventGrid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IotHub: "IotHub",
}

/**
 * Cluster principal role.
 */
union ClusterPrincipalRole {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AllDatabasesAdmin: "AllDatabasesAdmin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AllDatabasesViewer: "AllDatabasesViewer",
}

/**
 * Principal type.
 */
union PrincipalType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  App: "App",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Group: "Group",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
}

/**
 * Database principal role.
 */
union DatabasePrincipalRole {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Admin: "Admin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Ingestor: "Ingestor",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Monitor: "Monitor",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UnrestrictedViewer: "UnrestrictedViewer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Viewer: "Viewer",
}

/**
 * Compute type of the cluster which will execute data flow job.
 */
union DataFlowComputeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  General: "General",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MemoryOptimized: "MemoryOptimized",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ComputeOptimized: "ComputeOptimized",
}

/**
 * The pricing tier for the catalog database. The valid values could be found in https://azure.microsoft.com/en-us/pricing/details/sql-database/
 */
union IntegrationRuntimeSsisCatalogPricingTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Premium: "Premium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PremiumRS: "PremiumRS",
}

/**
 * License type for bringing your own license scenario.
 */
union IntegrationRuntimeLicenseType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BasePrice: "BasePrice",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LicenseIncluded: "LicenseIncluded",
}

/**
 * The type of this referenced entity.
 */
union IntegrationRuntimeEntityReferenceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IntegrationRuntimeReference: "IntegrationRuntimeReference",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LinkedServiceReference: "LinkedServiceReference",
}

/**
 * The edition for the SSIS Integration Runtime
 */
union IntegrationRuntimeEdition {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enterprise: "Enterprise",
}

/**
 * The managed integration runtime node status.
 */
union ManagedIntegrationRuntimeNodeStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Starting: "Starting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Recycling: "Recycling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unavailable: "Unavailable",
}

/**
 * It is used to set the encryption mode for node-node communication channel (when more than 2 self-hosted integration runtime nodes exist).
 */
union IntegrationRuntimeInternalChannelEncryptionMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSet: "NotSet",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SslEncrypted: "SslEncrypted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotEncrypted: "NotEncrypted",
}

/**
 * The principals modification kind of the database
 */
union PrincipalsModificationKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Union: "Union",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Replace: "Replace",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * The data format of the message. Optionally the data format can be added to each message.
 */
union EventHubDataFormat {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MULTIJSON: "MULTIJSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  JSON: "JSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CSV: "CSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TSV: "TSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SCSV: "SCSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SOHSV: "SOHSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PSV: "PSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TXT: "TXT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RAW: "RAW",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SINGLEJSON: "SINGLEJSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AVRO: "AVRO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TSVE: "TSVE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PARQUET: "PARQUET",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ORC: "ORC",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  APACHEAVRO: "APACHEAVRO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  W3CLOGFILE: "W3CLOGFILE",
}

/**
 * The compression type
 */
union Compression {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GZip: "GZip",
}

/**
 * The data format of the message. Optionally the data format can be added to each message.
 */
union IotHubDataFormat {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MULTIJSON: "MULTIJSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  JSON: "JSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CSV: "CSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TSV: "TSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SCSV: "SCSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SOHSV: "SOHSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PSV: "PSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TXT: "TXT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RAW: "RAW",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SINGLEJSON: "SINGLEJSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AVRO: "AVRO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TSVE: "TSVE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PARQUET: "PARQUET",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ORC: "ORC",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  APACHEAVRO: "APACHEAVRO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  W3CLOGFILE: "W3CLOGFILE",
}

/**
 * The data format of the message. Optionally the data format can be added to each message.
 */
union EventGridDataFormat {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MULTIJSON: "MULTIJSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  JSON: "JSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CSV: "CSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TSV: "TSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SCSV: "SCSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SOHSV: "SOHSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PSV: "PSV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TXT: "TXT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RAW: "RAW",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SINGLEJSON: "SINGLEJSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AVRO: "AVRO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TSVE: "TSVE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PARQUET: "PARQUET",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ORC: "ORC",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  APACHEAVRO: "APACHEAVRO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  W3CLOGFILE: "W3CLOGFILE",
}

/**
 * The name of blob storage event type to process.
 */
union BlobStorageEventType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.Storage.BlobCreated`: "Microsoft.Storage.BlobCreated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.Storage.BlobRenamed`: "Microsoft.Storage.BlobRenamed",
}

/**
 * The state of the geo backup policy.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum GeoBackupPolicyState {
  Disabled,
  Enabled,
}

/**
 * The type of restore point
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum RestorePointType {
  CONTINUOUS,
  DISCRETE,
}

/**
 * The role of the Sql pool in the replication link.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ReplicationRole {
  Primary,
  Secondary,
  NonReadableSecondary,
  Source,
  Copy,
}

/**
 * The status of the database transparent data encryption.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum TransparentDataEncryptionStatus {
  Enabled,
  Disabled,
}

/**
 * Specifies the state of the policy. If state is Enabled, storageEndpoint or isAzureMonitorTargetEnabled are required.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum BlobAuditingPolicyState {
  Enabled,
  Disabled,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum SensitivityLabelRank {
  None,
  Low,
  Medium,
  High,
  Critical,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum SensitivityLabelUpdateKind {
  set,
  remove,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum RecommendedSensitivityLabelUpdateKind {
  enable,
  disable,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum SensitivityLabelSource {
  current,
  recommended,
}

/**
 * Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific Sql pool.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum SecurityAlertPolicyState {
  New,
  Enabled,
  Disabled,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
union VulnerabilityAssessmentPolicyBaselineName {
  string,
  master: "master",
  default: "default",
}

/**
 * The state of the data masking policy.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DataMaskingState {
  Disabled,
  Enabled,
}

/**
 * The rule state. Used to delete a rule. To delete an existing rule, specify the schemaName, tableName, columnName, maskingFunction, and specify ruleState as disabled. However, if the rule doesn't already exist, the rule will be created with ruleState set to enabled, regardless of the provided value of ruleState.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DataMaskingRuleState {
  Disabled,
  Enabled,
}

/**
 * The masking function that is used for the data masking rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DataMaskingFunction {
  Default,
  CCN,
  Email,
  Number,
  SSN,
  Text,
}

/**
 * The type of managed identity for the workspace
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  None,
  SystemAssigned,
  `SystemAssigned,UserAssigned`,
}

/**
 * Desired state
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DesiredState {
  Enabled,
  Disabled,
}

/**
 * Actual state
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ActualState {
  Enabling,
  Enabled,
  Disabling,
  Disabled,
  Unknown,
}

/**
 * The type of resource, for instance Microsoft.Synapse/workspaces/kustoPools/databases.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum Type {
  `Microsoft.Synapse/workspaces/kustoPools/databases`,
  `Microsoft.Synapse/workspaces/kustoPools/attachedDatabaseConfigurations`,
}

/**
 * The function that is used to aggregate each query's metrics.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum QueryAggregationFunction {
  min,
  max,
  avg,
  sum,
}

/**
 * The execution type that is used to filter the query instances that are returned.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum QueryExecutionType {
  any,
  regular,
  irregular,
  aborted,
  exception,
}

/**
 * The type of metric to use for ordering the top metrics.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum QueryObservedMetricType {
  cpu,
  io,
  logio,
  duration,
  executionCount,
}

/**
 * The unit of measurement
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum QueryMetricUnit {
  percentage,
  KB,
  microseconds,
}

/**
 * An alternative option to ensure interactive authoring function when your self-hosted integration runtime is unable to establish a connection with Azure Relay.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
alias SelfContainedInteractiveAuthoringState = boolean;

/**
 * Properties of a active directory only authentication.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AzureADOnlyAuthenticationProperties {
  /**
   * Azure Active Directory only Authentication enabled.
   */
  azureADOnlyAuthentication: boolean;

  /**
   * property configuration state
   */
  @visibility(Lifecycle.Read)
  state?: StateValue;

  /**
   * property configuration date
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * A request about whether a workspace name is available
 */
model CheckNameAvailabilityRequest {
  /**
   * Workspace name
   */
  name?: string;

  /**
   * Type: workspace
   */
  type?: string;
}

/**
 * A response saying whether the workspace name is available
 */
model CheckNameAvailabilityResponse {
  /**
   * Validation message
   */
  message?: string;

  /**
   * Whether the workspace name is available
   */
  available?: boolean;

  /**
   * Reason the workspace name is or is not available
   */
  reason?: string;

  /**
   * Workspace name
   */
  name?: string;
}

/**
 * IP firewall rule properties
 */
model IpFirewallRuleProperties {
  /**
   * The end IP address of the firewall rule. Must be IPv4 format. Must be greater than or equal to startIpAddress
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  endIpAddress?: string;

  /**
   * Resource provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The start IP address of the firewall rule. Must be IPv4 format
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  startIpAddress?: string;
}

/**
 * Replace all IP firewall rules request
 */
model ReplaceAllIpFirewallRulesRequest {
  /**
   * IP firewall rule properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  ipFirewallRules?: Record<IpFirewallRuleProperties>;
}

/**
 * An existing operation for replacing the firewall rules
 */
model ReplaceAllFirewallRulesOperationResponse {
  /**
   * The operation ID
   */
  operationId?: string;
}

/**
 * Key properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model KeyProperties {
  /**
   * Used to activate the workspace after a customer managed key is provided.
   */
  isActiveCMK?: boolean;

  /**
   * The Key Vault Url of the workspace key.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  keyVaultUrl?: string;
}

/**
 * An operation that is available in this resource provider
 */
model AvailableRpOperation {
  /**
   * Display properties of the operation
   */
  display?: AvailableRpOperationDisplayInfo;

  /**
   * Whether this operation is a data action
   */
  isDataAction?: string;

  /**
   * Operation name
   */
  name?: string;

  /**
   * Operation properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  properties?: OperationMetaPropertyInfo;

  /**
   * Operation origin
   */
  origin?: string;
}

/**
 * Description of an available operation
 */
model AvailableRpOperationDisplayInfo {
  /**
   * Operation description
   */
  description?: string;

  /**
   * Resource type
   */
  resource?: string;

  /**
   * Resource provider name
   */
  provider?: string;

  /**
   * Operation name
   */
  operation?: string;
}

/**
 * What is this?
 */
model OperationMetaPropertyInfo {
  /**
   * Operation service specification
   */
  serviceSpecification?: OperationMetaServiceSpecification;
}

/**
 * What is this?
 */
model OperationMetaServiceSpecification {
  /**
   * Service metric specifications
   */
  metricSpecifications?: OperationMetaMetricSpecification[];

  /**
   * Service log specifications
   */
  logSpecifications?: OperationMetaLogSpecification[];
}

/**
 * What is this?
 */
model OperationMetaMetricSpecification {
  /**
   * The source MDM namespace
   */
  sourceMdmNamespace?: string;

  /**
   * Metric display name
   */
  displayName?: string;

  /**
   * Metric unique name
   */
  name?: string;

  /**
   * Metric aggregation type
   */
  aggregationType?: string;

  /**
   * Metric description
   */
  displayDescription?: string;

  /**
   * The source MDM account
   */
  sourceMdmAccount?: string;

  /**
   * Whether the regional MDM account is enabled
   */
  enableRegionalMdmAccount?: boolean;

  /**
   * Metric units
   */
  unit?: string;

  /**
   * Metric dimensions
   */
  dimensions?: OperationMetaMetricDimensionSpecification[];

  /**
   * Whether the metric supports instance-level aggregation
   */
  supportsInstanceLevelAggregation?: boolean;

  /**
   * Metric filter
   */
  metricFilterPattern?: string;
}

/**
 * What is this?
 */
model OperationMetaMetricDimensionSpecification {
  /**
   * Dimension display name
   */
  displayName?: string;

  /**
   * Dimension unique name
   */
  name?: string;

  /**
   * Whether this metric should be exported for Shoebox
   */
  toBeExportedForShoebox?: boolean;
}

/**
 * What is this?
 */
model OperationMetaLogSpecification {
  /**
   * Log display name
   */
  displayName?: string;

  /**
   * Time range the log covers
   */
  blobDuration?: string;

  /**
   * Log unique name
   */
  name?: string;
}

/**
 * An operation
 */
model OperationResource {
  /**
   * Operation ID
   */
  id?: string;

  /**
   * Operation name
   */
  name?: string;

  /**
   * Operation status
   */
  status?: OperationStatus;

  /**
   * Operation properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  properties?: Record<unknown>;

  /**
   * Errors from the operation
   */
  error?: ErrorDetail;

  /**
   * Operation start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Operation start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Completion percentage of the operation
   */
  percentComplete?: float32;
}

/**
 * Properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The private endpoint which the connection belongs to.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * Connection state of the private endpoint connection.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  /**
   * Provisioning state of the private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Private endpoint details
 */
model PrivateEndpoint {
  /**
   * Resource id of the private endpoint.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * Connection state details of the private endpoint
 */
model PrivateLinkServiceConnectionState {
  /**
   * The private link service connection status.
   */
  status?: string;

  /**
   * The private link service connection description.
   */
  description?: string;

  /**
   * The actions required for private link service connection.
   */
  @visibility(Lifecycle.Read)
  actionsRequired?: string;
}

/**
 * A list of private endpoint connections
 */
model PrivateEndpointConnectionList
  is Azure.Core.Page<PrivateEndpointConnection>;

/**
 * Properties of a private link resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
   * Required DNS zone names of the the private link resource.
   */
  @visibility(Lifecycle.Read)
  requiredZoneNames?: string[];
}

/**
 * PrivateLinkHub properties
 */
model PrivateLinkHubProperties {
  /**
   * PrivateLinkHub provisioning state
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  provisioningState?: string;

  /**
   * List of private endpoint connections
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnectionForPrivateLinkHubBasic[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model PrivateEndpointConnectionForPrivateLinkHubBasic {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  id?: string;

  /**
   * Properties of a private endpoint connection.
   */
  properties?: PrivateEndpointConnectionProperties;
}

/**
 * PrivateLinkHub patch details
 */
model PrivateLinkHubPatchInfo {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model PrivateEndpointConnectionForPrivateLinkHubResourceCollectionResponse
  is Azure.Core.Page<PrivateEndpointConnectionForPrivateLinkHub>;

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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.)
 */
@error
model LegacyErrorResponse {
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

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["message", "target"])
  details?: LegacyErrorResponse[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  additionalInfo?: ErrorAdditionalInfo[];
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
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @extension("x-ms-secret", true)
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
}

/**
 * A Sql pool operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SqlPoolOperation extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
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
model SqlPoolUsageListResult is Azure.Core.Page<SqlPoolUsage>;

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
  extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
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
  extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
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
  @extension("x-ms-secret", true)
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
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @extension("x-ms-secret", true)
  storageContainerSasKey?: string;

  /**
   * Specifies the identifier key of the storage account for vulnerability assessment scan results. If 'StorageContainerSasKey' isn't specified, storageAccountAccessKey is required.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @extension("x-ms-secret", true)
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
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
model ListSqlPoolSecurityAlertPolicies
  is Azure.Core.Page<SqlPoolSecurityAlertPolicy>;

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
  @extension("x-ms-secret", true)
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @extension("x-ms-secret", true)
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
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @extension("x-ms-secret", true)
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
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @extension("x-ms-secret", true)
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
  @extension("x-ms-secret", true)
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
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @extension("x-ms-secret", true)
  storageContainerSasKey?: string;

  /**
   * Specifies the identifier key of the storage account for vulnerability assessment scan results. If 'StorageContainerSasKey' isn't specified, storageAccountAccessKey is required.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @extension("x-ms-secret", true)
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
model ServerUsageListResult is Azure.Core.Page<ServerUsage>;

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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DedicatedSQLminimalTlsSettingsProperties {
  /**
   * The minimal tls version of the sql server.
   */
  minimalTlsVersion?: string;
}

/**
 * Workspace properties
 */
model WorkspaceProperties {
  /**
   * Workspace default data lake storage account details
   */
  defaultDataLakeStorage?: DataLakeStorageAccountDetails;

  /**
   * SQL administrator login password
   */
  @extension("x-ms-secret", true)
  sqlAdministratorLoginPassword?: string;

  /**
   * Workspace managed resource group. The resource group name uniquely identifies the resource group within the user subscriptionId. The resource group name must be no longer than 90 characters long, and must be alphanumeric characters (Char.IsLetterOrDigit()) and '-', '_', '(', ')' and'.'. Note that the name cannot end with '.'
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  managedResourceGroupName?: string;

  /**
   * Resource provisioning state
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Login for workspace SQL active directory administrator
   */
  sqlAdministratorLogin?: string;

  /**
   * Virtual Network profile
   */
  virtualNetworkProfile?: VirtualNetworkProfile;

  /**
   * Connectivity endpoints
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  connectivityEndpoints?: Record<string>;

  /**
   * Setting this to 'default' will ensure that all compute for this workspace is in a virtual network managed on behalf of the user.
   */
  managedVirtualNetwork?: string;

  /**
   * Private endpoint connections to the workspace
   */
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The encryption details of the workspace
   */
  encryption?: EncryptionDetails;

  /**
   * The workspace unique identifier
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  workspaceUID?: string;

  /**
   * Workspace level configs and feature flags
   */
  @visibility(Lifecycle.Read)
  extraProperties?: Record<unknown>;

  /**
   * Managed Virtual Network Settings
   */
  managedVirtualNetworkSettings?: ManagedVirtualNetworkSettings;

  /**
   * Git integration settings
   */
  workspaceRepositoryConfiguration?: WorkspaceRepositoryConfiguration;

  /**
   * Purview Configuration
   */
  purviewConfiguration?: PurviewConfiguration;

  /**
   * The ADLA resource ID.
   */
  @visibility(Lifecycle.Read)
  adlaResourceId?: string;

  /**
   * Enable or Disable public network access to workspace
   */
  publicNetworkAccess?: WorkspacePublicNetworkAccess;

  /**
   * Initial workspace AAD admin properties for a CSP subscription
   */
  cspWorkspaceAdminProperties?: CspWorkspaceAdminProperties;

  /**
   * Workspace settings
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  settings?: Record<Record<unknown>>;

  /**
   * Enable or Disable AzureADOnlyAuthentication on All Workspace subresource
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  azureADOnlyAuthentication?: boolean;

  /**
   * Is trustedServiceBypassEnabled for the workspace
   */
  trustedServiceBypassEnabled?: boolean;
}

/**
 * Details of the data lake storage account associated with the workspace
 */
model DataLakeStorageAccountDetails {
  /**
   * Account URL
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  accountUrl?: string;

  /**
   * Filesystem name
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  filesystem?: string;

  /**
   * ARM resource Id of this storage account
   */
  resourceId?: string;

  /**
   * Create managed private endpoint to this storage account or not
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  createManagedPrivateEndpoint?: boolean;
}

/**
 * Virtual Network Profile
 */
model VirtualNetworkProfile {
  /**
   * Subnet ID used for computes in workspace
   */
  computeSubnetId?: string;
}

/**
 * Details of the encryption associated with the workspace
 */
model EncryptionDetails {
  /**
   * Double Encryption enabled
   */
  @visibility(Lifecycle.Read)
  doubleEncryptionEnabled?: boolean;

  /**
   * Customer Managed Key Details
   */
  cmk?: CustomerManagedKeyDetails;
}

/**
 * Details of the customer managed key associated with the workspace
 */
model CustomerManagedKeyDetails {
  /**
   * The customer managed key status on the workspace
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The key object of the workspace
   */
  key?: WorkspaceKeyDetails;

  /**
   * Key encryption key
   */
  kekIdentity?: KekIdentityProperties;
}

/**
 * Details of the customer managed key associated with the workspace
 */
model WorkspaceKeyDetails {
  /**
   * Workspace Key sub-resource name
   */
  name?: string;

  /**
   * Workspace Key sub-resource key vault url
   */
  keyVaultUrl?: string;
}

/**
 * Key encryption key properties
 */
model KekIdentityProperties {
  /**
   * User assigned identity resource Id
   */
  userAssignedIdentity?: string;

  /**
   * Boolean specifying whether to use system assigned identity or not
   */
  useSystemAssignedIdentity?: unknown;
}

/**
 * Managed Virtual Network Settings
 */
model ManagedVirtualNetworkSettings {
  /**
   * Prevent Data Exfiltration
   */
  preventDataExfiltration?: boolean;

  /**
   * Linked Access Check On Target Resource
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  linkedAccessCheckOnTargetResource?: boolean;

  /**
   * Allowed Aad Tenant Ids For Linking
   */
  allowedAadTenantIdsForLinking?: string[];
}

/**
 * Git integration settings
 */
model WorkspaceRepositoryConfiguration {
  /**
   * Type of workspace repositoryID configuration. Example WorkspaceVSTSConfiguration, WorkspaceGitHubConfiguration
   */
  type?: string;

  /**
   * GitHub Enterprise host name. For example: `https://github.mydomain.com`
   */
  hostName?: string;

  /**
   * Account name
   */
  accountName?: string;

  /**
   * VSTS project name
   */
  projectName?: string;

  /**
   * Repository name
   */
  repositoryName?: string;

  /**
   * Collaboration branch
   */
  collaborationBranch?: string;

  /**
   * Root folder to use in the repository
   */
  rootFolder?: string;

  /**
   * The last commit ID
   */
  lastCommitId?: string;

  /**
   * The VSTS tenant ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  tenantId?: string;
}

/**
 * Purview Configuration
 */
model PurviewConfiguration {
  /**
   * Purview Resource ID
   */
  purviewResourceId?: string;
}

/**
 * Initial workspace AAD admin properties for a CSP subscription
 */
model CspWorkspaceAdminProperties {
  /**
   * AAD object ID of initial workspace admin
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  initialWorkspaceAdminObjectId?: string;
}

/**
 * The workspace managed identity
 */
model ManagedIdentity {
  /**
   * The principal ID of the workspace managed identity
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of the workspace managed identity
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;

  /**
   * The type of managed identity for the workspace
   */
  type?: ResourceIdentityType;

  /**
   * The user assigned managed identities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedManagedIdentity>;
}

/**
 * User Assigned Managed Identity
 */
model UserAssignedManagedIdentity {
  /**
   * The client ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  clientId?: string;

  /**
   * The principal ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;
}

/**
 * Workspace patch details
 */
model WorkspacePatchInfo {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The identity of the workspace
   */
  identity?: ManagedIdentity;

  /**
   * Workspace patch properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  properties?: WorkspacePatchProperties;
}

/**
 * Workspace patch properties
 */
model WorkspacePatchProperties {
  /**
   * SQL administrator login password
   */
  @extension("x-ms-secret", true)
  sqlAdministratorLoginPassword?: string;

  /**
   * Managed Virtual Network Settings
   */
  managedVirtualNetworkSettings?: ManagedVirtualNetworkSettings;

  /**
   * Git integration settings
   */
  workspaceRepositoryConfiguration?: WorkspaceRepositoryConfiguration;

  /**
   * Purview Configuration
   */
  purviewConfiguration?: PurviewConfiguration;

  /**
   * Resource provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The encryption details of the workspace
   */
  encryption?: EncryptionDetails;

  /**
   * Enable or Disable public network access to workspace
   */
  publicNetworkAccess?: WorkspacePublicNetworkAccess;
}

/**
 * Workspace active directory administrator properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AadAdminProperties {
  /**
   * Tenant ID of the workspace active directory administrator
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tenantId?: string;

  /**
   * Login of the workspace active directory administrator
   */
  login?: string;

  /**
   * Workspace active directory administrator type
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorType?: string;

  /**
   * Object ID of the workspace active directory administrator
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sid?: string;
}

/**
 * Sql Control Settings for workspace managed identity
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ManagedIdentitySqlControlSettingsModelProperties {
  /**
   * Grant sql control to managed identity
   */
  grantSqlControlToManagedIdentity?: ManagedIdentitySqlControlSettingsModelPropertiesGrantSqlControlToManagedIdentity;
}

/**
 * Grant sql control to managed identity
 */
model ManagedIdentitySqlControlSettingsModelPropertiesGrantSqlControlToManagedIdentity {
  /**
   * Desired state
   */
  desiredState?: DesiredState;

  /**
   * Actual state
   */
  @visibility(Lifecycle.Read)
  actualState?: ActualState;
}

/**
 * The properties of a restorable dropped Sql pool
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RestorableDroppedSqlPoolProperties {
  /**
   * The name of the database
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * The edition of the database
   */
  @visibility(Lifecycle.Read)
  edition?: string;

  /**
   * The max size in bytes of the database
   */
  @visibility(Lifecycle.Read)
  maxSizeBytes?: string;

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
   * The creation date of the database (ISO8601 format)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The deletion date of the database (ISO8601 format)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionDate?: utcDateTime;

  /**
   * The earliest restore date of the database (ISO8601 format)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;
}

/**
 * The response to a list restorable dropped Sql pools request
 */
model RestorableDroppedSqlPoolListResult {
  /**
   * A list of restorable dropped Sql pools
   */
  @pageItems
  value: RestorableDroppedSqlPool[];
}

/**
 * Properties of a Big Data pool powered by Apache Spark
 */
model BigDataPoolResourceProperties {
  /**
   * The state of the Big Data pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  provisioningState?: string;

  /**
   * Auto-scaling properties
   */
  autoScale?: AutoScaleProperties;

  /**
   * The time when the Big Data pool was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Auto-pausing properties
   */
  autoPause?: AutoPauseProperties;

  /**
   * Whether compute isolation is required or not.
   */
  isComputeIsolationEnabled?: boolean;

  /**
   * Whether autotune is required or not.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isAutotuneEnabled?: boolean;

  /**
   * Whether session level packages enabled.
   */
  sessionLevelPackagesEnabled?: boolean;

  /**
   * The cache size
   */
  cacheSize?: int32;

  /**
   * Dynamic Executor Allocation
   */
  dynamicExecutorAllocation?: DynamicExecutorAllocation;

  /**
   * The Spark events folder
   */
  sparkEventsFolder?: string;

  /**
   * The number of nodes in the Big Data pool.
   */
  nodeCount?: int32;

  /**
   * Library version requirements
   */
  libraryRequirements?: LibraryRequirements;

  /**
   * List of custom libraries/packages associated with the spark pool.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  customLibraries?: LibraryInfo[];

  /**
   * Spark configuration file to specify additional properties
   */
  sparkConfigProperties?: SparkConfigProperties;

  /**
   * The Apache Spark version.
   */
  sparkVersion?: string;

  /**
   * The default folder where Spark logs will be written.
   */
  defaultSparkLogFolder?: string;

  /**
   * The level of compute power that each node in the Big Data pool has.
   */
  nodeSize?: NodeSize;

  /**
   * The kind of nodes that the Big Data pool provides.
   */
  nodeSizeFamily?: NodeSizeFamily;

  /**
   * The time when the Big Data pool was updated successfully.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSucceededTimestamp?: utcDateTime;
}

/**
 * Auto-scaling properties of a Big Data pool powered by Apache Spark
 */
model AutoScaleProperties {
  /**
   * The minimum number of nodes the Big Data pool can support.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  minNodeCount?: int32;

  /**
   * Whether automatic scaling is enabled for the Big Data pool.
   */
  enabled?: boolean;

  /**
   * The maximum number of nodes the Big Data pool can support.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  maxNodeCount?: int32;
}

/**
 * Auto-pausing properties of a Big Data pool powered by Apache Spark
 */
model AutoPauseProperties {
  /**
   * Number of minutes of idle time before the Big Data pool is automatically paused.
   */
  delayInMinutes?: int32;

  /**
   * Whether auto-pausing is enabled for the Big Data pool.
   */
  enabled?: boolean;
}

/**
 * Dynamic Executor Allocation Properties
 */
model DynamicExecutorAllocation {
  /**
   * Indicates whether Dynamic Executor Allocation is enabled or not.
   */
  enabled?: boolean;

  /**
   * The minimum number of executors alloted
   */
  minExecutors?: int32;

  /**
   * The maximum number of executors alloted
   */
  maxExecutors?: int32;
}

/**
 * Library requirements for a Big Data pool powered by Apache Spark
 */
model LibraryRequirements {
  /**
   * The last update time of the library requirements file.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * The library requirements.
   */
  content?: string;

  /**
   * The filename of the library requirements file.
   */
  filename?: string;
}

/**
 * Library/package information of a Big Data pool powered by Apache Spark
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model LibraryInfo {
  /**
   * Name of the library.
   */
  name?: string;

  /**
   * Storage blob path of library.
   */
  path?: string;

  /**
   * Storage blob container name.
   */
  containerName?: string;

  /**
   * The last update time of the library.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  uploadedTimestamp?: utcDateTime;

  /**
   * Type of the library.
   */
  type?: string;

  /**
   * Provisioning status of the library/package.
   */
  @visibility(Lifecycle.Read)
  provisioningStatus?: string;

  /**
   * Creator Id of the library/package.
   */
  @visibility(Lifecycle.Read)
  creatorId?: string;
}

/**
 * SparkConfig Properties for a Big Data pool powered by Apache Spark
 */
model SparkConfigProperties {
  /**
   * The last update time of the spark config properties file.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * The spark config properties.
   */
  content?: string;

  /**
   * The filename of the spark config properties file.
   */
  filename?: string;

  /**
   * The type of the spark config properties file.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  configurationType?: ConfigurationType;
}

/**
 * Properties patch for a Big Data pool
 */
model BigDataPoolPatchInfo {
  /**
   * Updated tags for the Big Data pool
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Azure Synapse nested resource, which belongs to a workspace.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SubResource extends AzureEntityResource {}

/**
 * The resource model definition for an Azure Resource Manager resource with an etag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AzureEntityResource extends Resource {
  /**
   * Resource Etag.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * A list of Library resources.
 */
model LibraryListResponse is Azure.Core.Page<LibraryResource>;

/**
 * Update integration runtime request.
 */
model UpdateIntegrationRuntimeRequest {
  /**
   * Enables or disables the auto-update feature of the self-hosted integration runtime. See https://go.microsoft.com/fwlink/?linkid=854189.
   */
  autoUpdate?: IntegrationRuntimeAutoUpdate;

  /**
   * The time offset (in hours) in the day, e.g., PT03H is 3 hours. The integration runtime auto update will happen on that time.
   */
  updateDelayOffset?: string;
}

/**
 * Azure Synapse nested object which serves as a compute resource for activities.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@discriminator("type")
model IntegrationRuntime {
  ...Record<unknown>;

  /**
   * Type of integration runtime.
   */
  type: IntegrationRuntimeType;

  /**
   * Integration runtime description.
   */
  description?: string;
}

/**
 * The IP address of self-hosted integration runtime node.
 */
model IntegrationRuntimeNodeIpAddress {
  /**
   * The IP address of self-hosted integration runtime node.
   */
  @visibility(Lifecycle.Read)
  ipAddress?: string;
}

/**
 * The request payload of get SSIS object metadata.
 */
model GetSsisObjectMetadataRequest {
  /**
   * Metadata path.
   */
  metadataPath?: string;
}

/**
 * A list of SSIS object metadata.
 */
model SsisObjectMetadataListResponse {
  /**
   * List of SSIS object metadata.
   */
  value?: SsisObjectMetadata[];

  /**
   * The link to the next page of results, if any remaining results exist.
   */
  nextLink?: string;
}

/**
 * SSIS object metadata.
 */
@discriminator("type")
model SsisObjectMetadata {
  /**
   * Type of metadata.
   */
  type: SsisObjectMetadataType;

  /**
   * Metadata id.
   */
  id?: int64;

  /**
   * Metadata name.
   */
  name?: string;

  /**
   * Metadata description.
   */
  description?: string;
}

/**
 * Properties of Self-hosted integration runtime node.
 */
model SelfHostedIntegrationRuntimeNode {
  ...Record<unknown>;

  /**
   * Name of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  nodeName?: string;

  /**
   * Machine name of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  machineName?: string;

  /**
   * URI for the host machine of the integration runtime.
   */
  @visibility(Lifecycle.Read)
  hostServiceUri?: string;

  /**
   * Status of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  status?: SelfHostedIntegrationRuntimeNodeStatus;

  /**
   * The integration runtime capabilities dictionary
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  capabilities?: Record<string>;

  /**
   * Status of the integration runtime node version.
   */
  @visibility(Lifecycle.Read)
  versionStatus?: string;

  /**
   * Version of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The time at which the integration runtime node was registered in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  registerTime?: utcDateTime;

  /**
   * The most recent time at which the integration runtime was connected in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConnectTime?: utcDateTime;

  /**
   * The time at which the integration runtime will expire in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * The time the node last started up.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStartTime?: utcDateTime;

  /**
   * The integration runtime node last stop time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStopTime?: utcDateTime;

  /**
   * The result of the last integration runtime node update.
   */
  @visibility(Lifecycle.Read)
  lastUpdateResult?: IntegrationRuntimeUpdateResult;

  /**
   * The last time for the integration runtime node update start.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStartUpdateTime?: utcDateTime;

  /**
   * The last time for the integration runtime node update end.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastEndUpdateTime?: utcDateTime;

  /**
   * Indicates whether this node is the active dispatcher for integration runtime requests.
   */
  @visibility(Lifecycle.Read)
  isActiveDispatcher?: boolean;

  /**
   * Maximum concurrent jobs on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  concurrentJobsLimit?: int32;

  /**
   * The maximum concurrent jobs in this integration runtime.
   */
  @visibility(Lifecycle.Read)
  maxConcurrentJobs?: int32;
}

/**
 * Update integration runtime node request.
 */
model UpdateIntegrationRuntimeNodeRequest {
  /**
   * The number of concurrent jobs permitted to run on the integration runtime node. Values between 1 and maxConcurrentJobs(inclusive) are allowed.
   */
  @minValue(1)
  concurrentJobsLimit?: int32;
}

/**
 * A list of integration runtime resources.
 */
model IntegrationRuntimeListResponse
  is Azure.Core.Page<IntegrationRuntimeResource>;

/**
 * Connection information for encrypting the on-premises data source credentials.
 */
model IntegrationRuntimeConnectionInfo {
  ...Record<unknown>;

  /**
   * The token generated in service. Callers use this token to authenticate to integration runtime.
   */
  @visibility(Lifecycle.Read)
  @extension("x-ms-secret", true)
  serviceToken?: string;

  /**
   * The integration runtime SSL certificate thumbprint. Click-Once application uses it to do server validation.
   */
  @visibility(Lifecycle.Read)
  identityCertThumbprint?: string;

  /**
   * The on-premises integration runtime host URL.
   */
  @visibility(Lifecycle.Read)
  hostServiceUri?: string;

  /**
   * The integration runtime version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The public key for encrypting a credential when transferring the credential to the integration runtime.
   */
  @visibility(Lifecycle.Read)
  publicKey?: string;

  /**
   * Whether the identity certificate is expired.
   */
  @visibility(Lifecycle.Read)
  isIdentityCertExprired?: boolean;
}

/**
 * Integration runtime status response.
 */
model IntegrationRuntimeStatusResponse {
  /**
   * The integration runtime name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Integration runtime properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  properties: IntegrationRuntimeStatus;
}

/**
 * Integration runtime status.
 */
@discriminator("type")
model IntegrationRuntimeStatus {
  ...Record<unknown>;

  /**
   * Type of integration runtime.
   */
  type: IntegrationRuntimeType;

  /**
   * The workspace name which the integration runtime belong to.
   */
  @visibility(Lifecycle.Read)
  dataFactoryName?: string;

  /**
   * The state of integration runtime.
   */
  @visibility(Lifecycle.Read)
  state?: IntegrationRuntimeState;
}

/**
 * Parameters to regenerate the authentication key.
 */
model IntegrationRuntimeRegenerateKeyParameters {
  /**
   * The name of the authentication key to regenerate.
   */
  keyName?: IntegrationRuntimeAuthKeyName;
}

/**
 * The integration runtime authentication keys.
 */
model IntegrationRuntimeAuthKeys {
  /**
   * The primary integration runtime authentication key.
   */
  authKey1?: string;

  /**
   * The secondary integration runtime authentication key.
   */
  authKey2?: string;
}

/**
 * Get monitoring data response.
 */
model IntegrationRuntimeMonitoringData {
  /**
   * Integration runtime name.
   */
  name?: string;

  /**
   * Integration runtime node monitoring data.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  nodes?: IntegrationRuntimeNodeMonitoringData[];
}

/**
 * Monitoring data for integration runtime node.
 */
model IntegrationRuntimeNodeMonitoringData {
  ...Record<unknown>;

  /**
   * Name of the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  nodeName?: string;

  /**
   * Available memory (MB) on the integration runtime node.
   */
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
  sentBytes?: float32;

  /**
   * Received bytes on the integration runtime node.
   */
  @visibility(Lifecycle.Read)
  receivedBytes?: float32;
}

/**
 * The status of the operation.
 */
model SsisObjectMetadataStatusResponse {
  /**
   * The status of the operation.
   */
  status?: string;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * The operation properties.
   */
  properties?: string;

  /**
   * The operation error message.
   */
  error?: string;
}

/**
 * Azure-SSIS integration runtime outbound network dependency endpoints.
 */
model IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse {
  /**
   * The list of outbound network dependency endpoints.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  value?: IntegrationRuntimeOutboundNetworkDependenciesCategoryEndpoint[];
}

/**
 * Azure-SSIS integration runtime outbound network dependency endpoints for one category.
 */
model IntegrationRuntimeOutboundNetworkDependenciesCategoryEndpoint {
  /**
   * The category of outbound network dependency.
   */
  category?: string;

  /**
   * The endpoints for outbound network dependency.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  endpoints?: IntegrationRuntimeOutboundNetworkDependenciesEndpoint[];
}

/**
 * The endpoint for Azure-SSIS integration runtime outbound network dependency.
 */
model IntegrationRuntimeOutboundNetworkDependenciesEndpoint {
  /**
   * The domain name of endpoint.
   */
  domainName?: string;

  /**
   * The details of endpoint.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  endpointDetails?: IntegrationRuntimeOutboundNetworkDependenciesEndpointDetails[];
}

/**
 * The details of Azure-SSIS integration runtime outbound network dependency endpoint.
 */
model IntegrationRuntimeOutboundNetworkDependenciesEndpointDetails {
  /**
   * The port of endpoint.
   */
  port?: int32;
}

/**
 * Integration Runtime Operation Status Properties
 */
model IntegrationRuntimeOperationStatus {
  /**
   * status of Start Integrationruntimes.
   */
  status?: WorkspaceStatus;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * The operation properties.
   */
  properties?: Record<unknown>;

  /**
   * The operation error message.
   */
  error?: string;
}

/**
 * Integration Runtime Operation Status Properties
 */
model IntegrationRuntimeStopOperationStatus {
  /**
   * status of Start Integrationruntimes.
   */
  status?: WorkspaceStatus;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * The operation properties.
   */
  properties?: Record<unknown>;

  /**
   * The operation error message.
   */
  error?: string;
}

/**
 * Integration Runtime Operation Status Properties
 */
model IntegrationRuntimeEnableinteractivequery {
  /**
   * EnableInteractivequery status of  Integrationruntimes.
   */
  status?: WorkspaceStatus;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * The operation properties.
   */
  properties?: Record<unknown>;

  /**
   * The operation error message.
   */
  error?: string;
}

/**
 * SparkConfiguration Artifact information
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SparkConfigurationInfo {
  /**
   * Description about the SparkConfiguration.
   */
  description?: string;

  /**
   * SparkConfiguration configs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  configs: Record<string>;

  /**
   * Annotations for SparkConfiguration.
   */
  annotations?: string[];

  /**
   * additional Notes.
   */
  notes?: string;

  /**
   * The identity that created the resource.
   */
  createdBy?: string;

  /**
   * The timestamp of resource creation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * SparkConfiguration merge configs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  configMergeRule?: Record<string>;
}

/**
 * A list of SparkConfiguration resources.
 */
model SparkConfigurationListResponse
  is Azure.Core.Page<SparkConfigurationResource>;

/**
 * The list of the SKU descriptions
 */
model SkuDescriptionList {
  /**
   * SKU descriptions
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: SkuDescription[];
}

/**
 * The Kusto SKU description of given resource type
 */
model SkuDescription {
  /**
   * The resource type
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The name of the SKU
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The size of the SKU
   */
  @visibility(Lifecycle.Read)
  size?: string;

  /**
   * The set of locations that the SKU is available
   */
  @visibility(Lifecycle.Read)
  locations?: string[];

  /**
   * Locations and zones
   */
  @visibility(Lifecycle.Read)
  locationInfo?: SkuLocationInfoItem[];

  /**
   * The restrictions because of which SKU cannot be used
   */
  @visibility(Lifecycle.Read)
  restrictions?: Record<unknown>[];
}

/**
 * The locations and zones info for SKU.
 */
model SkuLocationInfoItem {
  /**
   * The available location of the SKU.
   */
  location: string;

  /**
   * The available zone of the SKU.
   */
  zones?: string[];
}

/**
 * The object sent for a kusto pool check name availability request.
 */
model KustoPoolCheckNameRequest {
  /**
   * Kusto Pool name.
   */
  name: string;

  /**
   * The type of resource, Microsoft.Synapse/workspaces/kustoPools.
   */
  type: "Microsoft.Synapse/workspaces/kustoPools";
}

/**
 * The result returned from a check name availability request.
 */
model CheckNameResult {
  /**
   * Specifies a Boolean value that indicates if the name is available.
   */
  nameAvailable?: boolean;

  /**
   * The name that was checked.
   */
  name?: string;

  /**
   * Message indicating an unavailable name due to a conflict, or a description of the naming rules that are violated.
   */
  message?: string;

  /**
   * Message providing the reason why the given name is invalid.
   */
  reason?: Reason;
}

/**
 * The list Kusto pools operation response.
 */
model KustoPoolListResult {
  /**
   * The list of Kusto pools.
   */
  @pageItems
  value?: KustoPool[];
}

/**
 * Azure SKU definition.
 */
model AzureSku {
  /**
   * SKU name.
   */
  name: SkuName;

  /**
   * The number of instances of the cluster.
   */
  capacity?: int32;

  /**
   * SKU size.
   */
  size: SkuSize;
}

/**
 * Class representing the Kusto pool properties.
 */
model KustoPoolProperties {
  /**
   * The state of the resource.
   */
  @visibility(Lifecycle.Read)
  state?: State;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The Kusto Pool URI.
   */
  @visibility(Lifecycle.Read)
  uri?: string;

  /**
   * The Kusto Pool data ingestion URI.
   */
  @visibility(Lifecycle.Read)
  dataIngestionUri?: string;

  /**
   * The reason for the Kusto Pool's current state.
   */
  @visibility(Lifecycle.Read)
  stateReason?: string;

  /**
   * Optimized auto scale definition.
   */
  optimizedAutoscale?: OptimizedAutoscale;

  /**
   * A boolean value that indicates if the streaming ingest is enabled.
   */
  enableStreamingIngest?: boolean;

  /**
   * A boolean value that indicates if the purge operations are enabled.
   */
  enablePurge?: boolean;

  /**
   * List of the Kusto Pool's language extensions.
   */
  @visibility(Lifecycle.Read)
  languageExtensions?: LanguageExtensionsList;

  /**
   * The workspace unique identifier.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  workspaceUID?: string;
}

/**
 * A class that contains the optimized auto scale definition.
 */
model OptimizedAutoscale {
  /**
   * The version of the template defined, for instance 1.
   */
  version: int32;

  /**
   * A boolean value that indicate if the optimized autoscale feature is enabled or not.
   */
  isEnabled: boolean;

  /**
   * Minimum allowed instances count.
   */
  minimum: int32;

  /**
   * Maximum allowed instances count.
   */
  maximum: int32;
}

/**
 * The list of language extension objects.
 */
model LanguageExtensionsList {
  /**
   * The list of language extensions.
   */
  @pageItems
  value?: LanguageExtension[];
}

/**
 * The language extension object.
 */
model LanguageExtension {
  /**
   * The language extension name.
   */
  languageExtensionName?: LanguageExtensionName;
}

/**
 * Class representing an update to a Kusto kusto pool.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model KustoPoolUpdate extends Resource {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The SKU of the kusto pool.
   */
  sku?: AzureSku;

  /**
   * The kusto pool properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  properties?: KustoPoolProperties;
}

/**
 * List of available SKUs for a Kusto Pool.
 */
model ListResourceSkusResult {
  /**
   * The collection of available SKUs for an existing resource.
   */
  @pageItems
  value?: AzureResourceSku[];
}

/**
 * Azure resource SKU definition.
 */
model AzureResourceSku {
  /**
   * Resource Namespace and Type.
   */
  resourceType?: string;

  /**
   * The SKU details.
   */
  sku?: AzureSku;

  /**
   * The number of instances of the cluster.
   */
  capacity?: AzureCapacity;
}

/**
 * Azure capacity definition.
 */
model AzureCapacity {
  /**
   * Scale type.
   */
  scaleType: AzureScaleType;

  /**
   * Minimum allowed capacity.
   */
  minimum: int32;

  /**
   * Maximum allowed capacity.
   */
  maximum: int32;

  /**
   * The default capacity that would be used.
   */
  default: int32;
}

/**
 * The result returned from a database check name availability request.
 */
model DatabaseCheckNameRequest {
  /**
   * Resource name.
   */
  name: string;

  /**
   * The type of resource, for instance Microsoft.Synapse/workspaces/kustoPools/databases.
   */
  type: Type;
}

/**
 * The list Kusto database principals operation response.
 */
model FollowerDatabaseListResult {
  /**
   * The list of follower database result.
   */
  @pageItems
  value?: FollowerDatabaseDefinition[];
}

/**
 * A class representing follower database request.
 */
model FollowerDatabaseDefinition {
  /**
   * Resource id of the cluster that follows a database owned by this cluster.
   */
  clusterResourceId: string;

  /**
   * Resource name of the attached database configuration in the follower cluster.
   */
  attachedDatabaseConfigurationName: string;

  /**
   * The database name owned by this cluster that was followed. * in case following all databases.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;
}

/**
 * The list attached database configurations operation response.
 */
model AttachedDatabaseConfigurationListResult {
  /**
   * The list of attached database configurations.
   */
  @pageItems
  value?: AttachedDatabaseConfiguration[];
}

/**
 * Class representing the an attached database configuration properties of kind specific.
 */
model AttachedDatabaseConfigurationProperties {
  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The name of the database which you would like to attach, use * if you want to follow all current and future databases.
   */
  databaseName: string;

  /**
   * The resource id of the kusto pool where the databases you would like to attach reside.
   */
  clusterResourceId: string;

  /**
   * The list of databases from the clusterResourceId which are currently attached to the kusto pool.
   */
  @visibility(Lifecycle.Read)
  attachedDatabaseNames?: string[];

  /**
   * The default principals modification kind
   */
  defaultPrincipalsModificationKind: DefaultPrincipalsModificationKind;

  /**
   * Table level sharing specifications
   */
  tableLevelSharingProperties?: TableLevelSharingProperties;
}

/**
 * Tables that will be included and excluded in the follower database
 */
model TableLevelSharingProperties {
  /**
   * List of tables to include in the follower database
   */
  tablesToInclude?: string[];

  /**
   * List of tables to exclude from the follower database
   */
  tablesToExclude?: string[];

  /**
   * List of external tables to include in the follower database
   */
  externalTablesToInclude?: string[];

  /**
   * List of external tables exclude from the follower database
   */
  externalTablesToExclude?: string[];

  /**
   * List of materialized views to include in the follower database
   */
  materializedViewsToInclude?: string[];

  /**
   * List of materialized views exclude from the follower database
   */
  materializedViewsToExclude?: string[];
}

/**
 * The list Kusto databases operation response.
 */
model DatabaseListResult {
  /**
   * The list of Kusto databases.
   */
  @pageItems
  value?: Database[];
}

/**
 * A data connection check name availability request.
 */
model DataConnectionCheckNameRequest {
  /**
   * Data Connection name.
   */
  name: string;

  /**
   * The type of resource, Microsoft.Synapse/workspaces/kustoPools/databases/dataConnections.
   */
  type: "Microsoft.Synapse/workspaces/kustoPools/databases/dataConnections";
}

/**
 * Class representing an data connection validation.
 */
model DataConnectionValidation {
  /**
   * The name of the data connection.
   */
  dataConnectionName?: string;

  /**
   * The data connection properties to validate.
   */
  properties?: DataConnection;
}

/**
 * The list Kusto data connection validation result.
 */
model DataConnectionValidationListResult {
  /**
   * The list of Kusto data connection validation errors.
   */
  value?: DataConnectionValidationResult[];
}

/**
 * The result returned from a data connection validation request.
 */
model DataConnectionValidationResult {
  /**
   * A message which indicates a problem in data connection validation.
   */
  errorMessage?: string;
}

/**
 * The list Kusto data connections operation response.
 */
model DataConnectionListResult {
  /**
   * The list of Kusto data connections.
   */
  @pageItems
  value?: DataConnection[];
}

/**
 * A principal assignment check name availability request.
 */
model ClusterPrincipalAssignmentCheckNameRequest {
  /**
   * Principal Assignment resource name.
   */
  name: string;

  /**
   * The type of resource, Microsoft.Synapse/workspaces/kustoPools/principalAssignments.
   */
  type: "Microsoft.Synapse/workspaces/kustoPools/principalAssignments";
}

/**
 * The list Kusto cluster principal assignments operation response.
 */
model ClusterPrincipalAssignmentListResult {
  /**
   * The list of Kusto cluster principal assignments.
   */
  @pageItems
  value?: ClusterPrincipalAssignment[];
}

/**
 * A class representing cluster principal property.
 */
model ClusterPrincipalProperties {
  /**
   * The principal ID assigned to the cluster principal. It can be a user email, application ID, or security group name.
   */
  principalId: string;

  /**
   * Cluster principal role.
   */
  role: ClusterPrincipalRole;

  /**
   * The tenant id of the principal
   */
  tenantId?: string;

  /**
   * Principal type.
   */
  principalType: PrincipalType;

  /**
   * The tenant name of the principal
   */
  @visibility(Lifecycle.Read)
  tenantName?: string;

  /**
   * The principal name
   */
  @visibility(Lifecycle.Read)
  principalName?: string;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The service principal object id in AAD (Azure active directory)
   */
  @visibility(Lifecycle.Read)
  aadObjectId?: string;
}

/**
 * A principal assignment check name availability request.
 */
model DatabasePrincipalAssignmentCheckNameRequest {
  /**
   * Principal Assignment resource name.
   */
  name: string;

  /**
   * The type of resource, Microsoft.Synapse/workspaces/kustoPools/databases/principalAssignments.
   */
  type: "Microsoft.Synapse/workspaces/kustoPools/databases/principalAssignments";
}

/**
 * The list Kusto database principal assignments operation response.
 */
model DatabasePrincipalAssignmentListResult {
  /**
   * The list of Kusto database principal assignments.
   */
  @pageItems
  value?: DatabasePrincipalAssignment[];
}

/**
 * A class representing database principal property.
 */
model DatabasePrincipalProperties {
  /**
   * The principal ID assigned to the database principal. It can be a user email, application ID, or security group name.
   */
  principalId: string;

  /**
   * Database principal role.
   */
  role: DatabasePrincipalRole;

  /**
   * The tenant id of the principal
   */
  tenantId?: string;

  /**
   * Principal type.
   */
  principalType: PrincipalType;

  /**
   * The tenant name of the principal
   */
  @visibility(Lifecycle.Read)
  tenantName?: string;

  /**
   * The principal name
   */
  @visibility(Lifecycle.Read)
  principalName?: string;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The service principal object id in AAD (Azure active directory)
   */
  @visibility(Lifecycle.Read)
  aadObjectId?: string;
}

/**
 * The list Kusto Private Link Resources operation response.
 */
model PrivateLinkResources {
  /**
   * The list of Kusto Private Link Resources.
   */
  @pageItems
  value?: KustoPoolPrivateLinkResources[];
}

/**
 * Class representing a Private Link Resources.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model KustoPoolPrivateLinkResources
  extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * The Private Link Resources.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  properties?: PrivateLinkResourcesProperties;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Private Link Resources Properties.
 */
model PrivateLinkResourcesProperties {
  /**
   * The Private link resources GroupId
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

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  value: TopQueries[];
}

/**
 * Dedicated SQL minimal tls settings patch info
 */
model DedicatedSQLminimalTlsSettingsPatchInfo {
  /**
   * minimal tls version
   */
  minimalTlsVersion?: string;
}

/**
 * Managed integration runtime, including managed elastic and managed dedicated integration runtimes.
 */
model ManagedIntegrationRuntime extends IntegrationRuntime {
  /**
   * Integration runtime state, only valid for managed dedicated integration runtime.
   */
  @visibility(Lifecycle.Read)
  state?: IntegrationRuntimeState;

  /**
   * Managed integration runtime properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  typeProperties: ManagedIntegrationRuntimeTypeProperties;

  /**
   * Managed integration runtime managed virtual network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  managedVirtualNetwork?: ManagedIntegrationRuntimeManagedVirtualNetworkReference;

  /**
   * Type of integration runtime.
   */
  type: "Managed";
}

/**
 * Managed integration runtime type properties.
 */
model ManagedIntegrationRuntimeTypeProperties {
  /**
   * The compute resource for managed integration runtime.
   */
  computeProperties?: IntegrationRuntimeComputeProperties;

  /**
   * SSIS properties for managed integration runtime.
   */
  ssisProperties?: IntegrationRuntimeSsisProperties;
}

/**
 * The compute resource properties for managed integration runtime.
 */
model IntegrationRuntimeComputeProperties {
  ...Record<unknown>;

  /**
   * The location for managed integration runtime. The supported regions could be found on https://docs.microsoft.com/en-us/azure/data-factory/data-factory-data-movement-activities
   */
  location?: string;

  /**
   * The node size requirement to managed integration runtime.
   */
  nodeSize?: string;

  /**
   * The required number of nodes for managed integration runtime.
   */
  @minValue(1)
  numberOfNodes?: int32;

  /**
   * Maximum parallel executions count per node for managed integration runtime.
   */
  @minValue(1)
  maxParallelExecutionsPerNode?: int32;

  /**
   * Data flow properties for managed integration runtime.
   */
  dataFlowProperties?: IntegrationRuntimeDataFlowProperties;

  /**
   * VNet properties for managed integration runtime.
   */
  vNetProperties?: IntegrationRuntimeVNetProperties;

  /**
   * CopyComputeScale properties for managed integration runtime.
   */
  copyComputeScaleProperties?: CopyComputeScaleProperties;

  /**
   * PipelineExternalComputeScale properties for managed integration runtime.
   */
  pipelineExternalComputeScaleProperties?: PipelineExternalComputeScaleProperties;
}

/**
 * Data flow properties for managed integration runtime.
 */
model IntegrationRuntimeDataFlowProperties {
  ...Record<unknown>;

  /**
   * Compute type of the cluster which will execute data flow job.
   */
  computeType?: DataFlowComputeType;

  /**
   * Core count of the cluster which will execute data flow job. Supported values are: 8, 16, 32, 48, 80, 144 and 272.
   */
  coreCount?: int32;

  /**
   * Time to live (in minutes) setting of the cluster which will execute data flow job.
   */
  timeToLive?: int32;

  /**
   * Cluster will not be recycled and it will be used in next data flow activity run until TTL (time to live) is reached if this is set as false. Default is true.
   */
  cleanup?: boolean;
}

/**
 * VNet properties for managed integration runtime.
 */
model IntegrationRuntimeVNetProperties {
  ...Record<unknown>;

  /**
   * The ID of the VNet that this integration runtime will join.
   */
  vNetId?: string;

  /**
   * The name of the subnet this integration runtime will join.
   */
  subnet?: string;

  /**
   * Resource IDs of the public IP addresses that this integration runtime will use.
   */
  publicIPs?: string[];

  /**
   * The ID of subnet, to which this Azure-SSIS integration runtime will be joined.
   */
  subnetId?: string;
}

/**
 * CopyComputeScale properties for managed integration runtime.
 */
model CopyComputeScaleProperties {
  /**
   * DIU number setting reserved for copy activity execution. Supported values are multiples of 4 in range 4-256.
   */
  @minValue(4)
  dataIntegrationUnit?: int32;

  /**
   * Time to live (in minutes) setting of integration runtime which will execute copy activity.
   */
  @minValue(5)
  timeToLive?: int32;
}

/**
 * PipelineExternalComputeScale properties for managed integration runtime.
 */
model PipelineExternalComputeScaleProperties {
  /**
   * Time to live (in minutes) setting of integration runtime which will execute pipeline and external activity.
   */
  @minValue(5)
  timeToLive?: int32;

  /**
   * Number of the pipeline nodes, which should be greater than 0 and less than 11.
   */
  @maxValue(10)
  @minValue(1)
  numberOfPipelineNodes?: int32;

  /**
   * Number of the the external nodes, which should be greater than 0 and less than 11.
   */
  @maxValue(10)
  @minValue(1)
  numberOfExternalNodes?: int32;
}

/**
 * SSIS properties for managed integration runtime.
 */
model IntegrationRuntimeSsisProperties {
  ...Record<unknown>;

  /**
   * Catalog information for managed dedicated integration runtime.
   */
  catalogInfo?: IntegrationRuntimeSsisCatalogInfo;

  /**
   * License type for bringing your own license scenario.
   */
  licenseType?: IntegrationRuntimeLicenseType;

  /**
   * Custom setup script properties for a managed dedicated integration runtime.
   */
  customSetupScriptProperties?: IntegrationRuntimeCustomSetupScriptProperties;

  /**
   * Data proxy properties for a managed dedicated integration runtime.
   */
  dataProxyProperties?: IntegrationRuntimeDataProxyProperties;

  /**
   * The edition for the SSIS Integration Runtime
   */
  edition?: IntegrationRuntimeEdition;

  /**
   * Custom setup without script properties for a SSIS integration runtime.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  expressCustomSetupProperties?: CustomSetupBase[];
}

/**
 * Catalog information for managed dedicated integration runtime.
 */
model IntegrationRuntimeSsisCatalogInfo {
  ...Record<unknown>;

  /**
   * The catalog database server URL.
   */
  catalogServerEndpoint?: string;

  /**
   * The administrator user name of catalog database.
   */
  @maxLength(128)
  @minLength(1)
  catalogAdminUserName?: string;

  /**
   * The password of the administrator user account of the catalog database.
   */
  catalogAdminPassword?: SecureString;

  /**
   * The pricing tier for the catalog database. The valid values could be found in https://azure.microsoft.com/en-us/pricing/details/sql-database/
   */
  catalogPricingTier?: IntegrationRuntimeSsisCatalogPricingTier;
}

/**
 * Azure Synapse secure string definition. The string value will be masked with asterisks '*' during Get or List API calls.
 */
model SecureString extends SecretBase {
  /**
   * Value of secure string.
   */
  value: string;

  /**
   * Type of the secret.
   */
  type: "SecureString";
}

/**
 * The base definition of a secret type.
 */
@discriminator("type")
model SecretBase {
  /**
   * Type of the secret.
   */
  type: string;
}

/**
 * Custom setup script properties for a managed dedicated integration runtime.
 */
model IntegrationRuntimeCustomSetupScriptProperties {
  /**
   * The URI of the Azure blob container that contains the custom setup script.
   */
  blobContainerUri?: string;

  /**
   * The SAS token of the Azure blob container.
   */
  sasToken?: SecureString;
}

/**
 * Data proxy properties for a managed dedicated integration runtime.
 */
model IntegrationRuntimeDataProxyProperties {
  /**
   * The self-hosted integration runtime reference.
   */
  connectVia?: EntityReference;

  /**
   * The staging linked service reference.
   */
  stagingLinkedService?: EntityReference;

  /**
   * The path to contain the staged data in the Blob storage.
   */
  path?: string;
}

/**
 * The entity reference.
 */
model EntityReference {
  /**
   * The type of this referenced entity.
   */
  type?: IntegrationRuntimeEntityReferenceType;

  /**
   * The name of this referenced entity.
   */
  referenceName?: string;
}

/**
 * The base definition of the custom setup.
 */
@discriminator("type")
model CustomSetupBase {
  /**
   * The type of custom setup.
   */
  type: string;
}

/**
 * Managed integration runtime managed virtual network reference.
 */
model ManagedIntegrationRuntimeManagedVirtualNetworkReference {
  /**
   * The reference name of the managed virtual network.
   */
  referenceName?: string;

  /**
   * The type of the managed virtual network.
   */
  type?: string;

  /**
   * The id of the managed virtual network.
   */
  id?: string;
}

/**
 * The custom setup of running cmdkey commands.
 */
model CmdkeySetup extends CustomSetupBase {
  /**
   * Cmdkey command custom setup type properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  typeProperties: CmdkeySetupTypeProperties;

  /**
   * The type of custom setup.
   */
  type: "CmdkeySetup";
}

/**
 * Cmdkey command custom setup type properties.
 */
model CmdkeySetupTypeProperties {
  /**
   * The server name of data source access.
   */
  targetName: Record<unknown>;

  /**
   * The user name of data source access.
   */
  userName: Record<unknown>;

  /**
   * The password of data source access.
   */
  password: SecretBase;
}

/**
 * The custom setup of setting environment variable.
 */
model EnvironmentVariableSetup extends CustomSetupBase {
  /**
   * Add environment variable type properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  typeProperties: EnvironmentVariableSetupTypeProperties;

  /**
   * The type of custom setup.
   */
  type: "EnvironmentVariableSetup";
}

/**
 * Environment variable custom setup type properties.
 */
model EnvironmentVariableSetupTypeProperties {
  /**
   * The name of the environment variable.
   */
  variableName: string;

  /**
   * The value of the environment variable.
   */
  variableValue: string;
}

/**
 * The custom setup of installing 3rd party components.
 */
model ComponentSetup extends CustomSetupBase {
  /**
   * Install 3rd party component type properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  typeProperties: LicensedComponentSetupTypeProperties;

  /**
   * The type of custom setup.
   */
  type: "ComponentSetup";
}

/**
 * Installation of licensed component setup type properties.
 */
model LicensedComponentSetupTypeProperties {
  /**
   * The name of the 3rd party component.
   */
  componentName: string;

  /**
   * The license key to activate the component.
   */
  licenseKey?: SecretBase;
}

/**
 * Self-hosted integration runtime.
 */
model SelfHostedIntegrationRuntime extends IntegrationRuntime {
  /**
   * When this property is not null, means this is a linked integration runtime. The property is used to access original integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  typeProperties?: SelfHostedIntegrationRuntimeTypeProperties;

  /**
   * Type of integration runtime.
   */
  type: "SelfHosted";
}

/**
 * The self-hosted integration runtime properties.
 */
model SelfHostedIntegrationRuntimeTypeProperties {
  /**
   * Linked integration runtime type from data factory
   */
  linkedInfo?: LinkedIntegrationRuntimeType;

  /**
   * An alternative option to ensure interactive authoring function when your self-hosted integration runtime is unable to establish a connection with Azure Relay.
   */
  selfContainedInteractiveAuthoringEnabled?: SelfContainedInteractiveAuthoringState;
}

/**
 * The base definition of a linked integration runtime.
 */
@discriminator("authorizationType")
model LinkedIntegrationRuntimeType {
  /**
   * The authorization type for integration runtime sharing.
   */
  authorizationType: string;
}

/**
 * The key authorization type integration runtime.
 */
model LinkedIntegrationRuntimeKeyAuthorization
  extends LinkedIntegrationRuntimeType {
  /**
   * The key used for authorization.
   */
  key: SecureString;

  /**
   * The authorization type for integration runtime sharing.
   */
  authorizationType: "Key";
}

/**
 * The role based access control (RBAC) authorization type integration runtime.
 */
model LinkedIntegrationRuntimeRbacAuthorization
  extends LinkedIntegrationRuntimeType {
  /**
   * The resource identifier of the integration runtime to be shared.
   */
  resourceId: string;

  /**
   * The authorization type for integration runtime sharing.
   */
  authorizationType: "RBAC";
}

/**
 * Managed integration runtime status.
 */
model ManagedIntegrationRuntimeStatus extends IntegrationRuntimeStatus {
  /**
   * Managed integration runtime status type properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  typeProperties: ManagedIntegrationRuntimeStatusTypeProperties;

  /**
   * Type of integration runtime.
   */
  type: "Managed";
}

/**
 * Managed integration runtime status type properties.
 */
model ManagedIntegrationRuntimeStatusTypeProperties {
  /**
   * The time at which the integration runtime was created, in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * The list of nodes for managed integration runtime.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  nodes?: ManagedIntegrationRuntimeNode[];

  /**
   * The errors that occurred on this integration runtime.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  otherErrors?: ManagedIntegrationRuntimeError[];

  /**
   * The last operation result that occurred on this integration runtime.
   */
  @visibility(Lifecycle.Read)
  lastOperation?: ManagedIntegrationRuntimeOperationResult;
}

/**
 * Properties of integration runtime node.
 */
model ManagedIntegrationRuntimeNode {
  ...Record<unknown>;

  /**
   * The managed integration runtime node id.
   */
  @visibility(Lifecycle.Read)
  nodeId?: string;

  /**
   * The managed integration runtime node status.
   */
  @visibility(Lifecycle.Read)
  status?: ManagedIntegrationRuntimeNodeStatus;

  /**
   * The errors that occurred on this integration runtime node.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  errors?: ManagedIntegrationRuntimeError[];
}

/**
 * Error definition for managed integration runtime.
 */
model ManagedIntegrationRuntimeError {
  ...Record<unknown>;

  /**
   * The time when the error occurred.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Managed integration runtime error parameters.
   */
  @visibility(Lifecycle.Read)
  parameters?: string[];

  /**
   * Error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Properties of managed integration runtime operation result.
 */
model ManagedIntegrationRuntimeOperationResult {
  ...Record<unknown>;

  /**
   * The operation type. Could be start or stop.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The start time of the operation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The operation result.
   */
  @visibility(Lifecycle.Read)
  result?: string;

  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * Managed integration runtime error parameters.
   */
  @visibility(Lifecycle.Read)
  parameters?: string[];

  /**
   * The activity id for the operation request.
   */
  @visibility(Lifecycle.Read)
  activityId?: string;
}

/**
 * Self-hosted integration runtime status.
 */
model SelfHostedIntegrationRuntimeStatus extends IntegrationRuntimeStatus {
  /**
   * Self-hosted integration runtime status type properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  typeProperties: SelfHostedIntegrationRuntimeStatusTypeProperties;

  /**
   * Type of integration runtime.
   */
  type: "SelfHosted";
}

/**
 * Self-hosted integration runtime status type properties.
 */
model SelfHostedIntegrationRuntimeStatusTypeProperties {
  /**
   * The time at which the integration runtime was created, in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * The task queue id of the integration runtime.
   */
  @visibility(Lifecycle.Read)
  taskQueueId?: string;

  /**
   * The node communication Channel encryption mode
   */
  @visibility(Lifecycle.Read)
  nodeCommunicationChannelEncryptionMode?: string;

  /**
   * It is used to set the encryption mode for node-node communication channel (when more than 2 self-hosted integration runtime nodes exist).
   */
  @visibility(Lifecycle.Read)
  internalChannelEncryption?: IntegrationRuntimeInternalChannelEncryptionMode;

  /**
   * Version of the integration runtime.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The list of nodes for this integration runtime.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  nodes?: SelfHostedIntegrationRuntimeNode[];

  /**
   * The date at which the integration runtime will be scheduled to update, in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledUpdateDate?: utcDateTime;

  /**
   * The time in the date scheduled by service to update the integration runtime, e.g., PT03H is 3 hours
   */
  @visibility(Lifecycle.Read)
  updateDelayOffset?: string;

  /**
   * The local time zone offset in hours.
   */
  @visibility(Lifecycle.Read)
  localTimeZoneOffset?: string;

  /**
   * Object with additional information about integration runtime capabilities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  capabilities?: Record<string>;

  /**
   * The URLs for the services used in integration runtime backend service.
   */
  @visibility(Lifecycle.Read)
  serviceUrls?: string[];

  /**
   * Whether Self-hosted integration runtime auto update has been turned on.
   */
  @visibility(Lifecycle.Read)
  autoUpdate?: IntegrationRuntimeAutoUpdate;

  /**
   * Status of the integration runtime version.
   */
  @visibility(Lifecycle.Read)
  versionStatus?: string;

  /**
   * The list of linked integration runtimes that are created to share with this integration runtime.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  links?: LinkedIntegrationRuntime[];

  /**
   * The version that the integration runtime is going to update to.
   */
  @visibility(Lifecycle.Read)
  pushedVersion?: string;

  /**
   * The latest version on download center.
   */
  @visibility(Lifecycle.Read)
  latestVersion?: string;

  /**
   * The estimated time when the self-hosted integration runtime will be updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  autoUpdateETA?: utcDateTime;

  /**
   * The service region of the integration runtime
   */
  serviceRegion?: string;

  /**
   * The newer versions on download center.
   */
  newerVersions?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  osType?: int32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  targetFramework?: int32;

  /**
   * An alternative option to ensure interactive authoring function when your self-hosted integration runtime is unable to establish a connection with Azure Relay.
   */
  @visibility(Lifecycle.Read)
  selfContainedInteractiveAuthoringEnabled?: SelfContainedInteractiveAuthoringState;
}

/**
 * The linked integration runtime information.
 */
model LinkedIntegrationRuntime {
  /**
   * The name of the linked integration runtime.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The subscription ID for which the linked integration runtime belong to.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The name of the workspace for which the linked integration runtime belong to.
   */
  @visibility(Lifecycle.Read)
  dataFactoryName?: string;

  /**
   * The location of the workspace for which the linked integration runtime belong to.
   */
  @visibility(Lifecycle.Read)
  dataFactoryLocation?: string;

  /**
   * The creating time of the linked integration runtime.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;
}

/**
 * Ssis folder.
 */
model SsisFolder extends SsisObjectMetadata {
  /**
   * Type of metadata.
   */
  type: "Folder";
}

/**
 * Ssis project.
 */
model SsisProject extends SsisObjectMetadata {
  /**
   * Folder id which contains project.
   */
  folderId?: int64;

  /**
   * Project version.
   */
  version?: int64;

  /**
   * Environment reference in project
   */
  environmentRefs?: SsisEnvironmentReference[];

  /**
   * Parameters in project
   */
  parameters?: SsisParameter[];

  /**
   * Type of metadata.
   */
  type: "Project";
}

/**
 * Ssis environment reference.
 */
model SsisEnvironmentReference {
  /**
   * Environment reference id.
   */
  id?: int64;

  /**
   * Environment folder name.
   */
  environmentFolderName?: string;

  /**
   * Environment name.
   */
  environmentName?: string;

  /**
   * Reference type
   */
  referenceType?: string;
}

/**
 * Ssis parameter.
 */
model SsisParameter {
  /**
   * Parameter id.
   */
  id?: int64;

  /**
   * Parameter name.
   */
  name?: string;

  /**
   * Parameter description.
   */
  description?: string;

  /**
   * Parameter type.
   */
  dataType?: string;

  /**
   * Whether parameter is required.
   */
  required?: boolean;

  /**
   * Whether parameter is sensitive.
   */
  sensitive?: boolean;

  /**
   * Design default value of parameter.
   */
  designDefaultValue?: string;

  /**
   * Default value of parameter.
   */
  defaultValue?: string;

  /**
   * Default sensitive value of parameter.
   */
  sensitiveDefaultValue?: string;

  /**
   * Parameter value type.
   */
  valueType?: string;

  /**
   * Parameter value set.
   */
  valueSet?: boolean;

  /**
   * Parameter reference variable.
   */
  variable?: string;
}

/**
 * Ssis Package.
 */
model SsisPackage extends SsisObjectMetadata {
  /**
   * Folder id which contains package.
   */
  folderId?: int64;

  /**
   * Project version which contains package.
   */
  projectVersion?: int64;

  /**
   * Project id which contains package.
   */
  projectId?: int64;

  /**
   * Parameters in package
   */
  parameters?: SsisParameter[];

  /**
   * Type of metadata.
   */
  type: "Package";
}

/**
 * Ssis environment.
 */
model SsisEnvironment extends SsisObjectMetadata {
  /**
   * Folder id which contains environment.
   */
  folderId?: int64;

  /**
   * Variable in environment
   */
  variables?: SsisVariable[];

  /**
   * Type of metadata.
   */
  type: "Environment";
}

/**
 * Ssis variable.
 */
model SsisVariable {
  /**
   * Variable id.
   */
  id?: int64;

  /**
   * Variable name.
   */
  name?: string;

  /**
   * Variable description.
   */
  description?: string;

  /**
   * Variable type.
   */
  dataType?: string;

  /**
   * Whether variable is sensitive.
   */
  sensitive?: boolean;

  /**
   * Variable value.
   */
  value?: string;

  /**
   * Variable sensitive value.
   */
  sensitiveValue?: string;
}

/**
 * Class representing a read write database.
 */
model ReadWriteDatabase extends Database {
  /**
   * The database properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  properties?: ReadWriteDatabaseProperties;

  /**
   * Kind of the database
   */
  kind: "ReadWrite";
}

/**
 * Class representing the Kusto database properties.
 */
model ReadWriteDatabaseProperties {
  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The time the data should be kept before it stops being accessible to queries in TimeSpan.
   */
  softDeletePeriod?: duration;

  /**
   * The time the data should be kept in cache for fast queries in TimeSpan.
   */
  hotCachePeriod?: duration;

  /**
   * The statistics of the database.
   */
  @visibility(Lifecycle.Read)
  statistics?: DatabaseStatistics;

  /**
   * Indicates whether the database is followed.
   */
  @visibility(Lifecycle.Read)
  isFollowed?: boolean;
}

/**
 * A class that contains database statistics information.
 */
model DatabaseStatistics {
  /**
   * The database size - the total size of compressed data and index in bytes.
   */
  size?: float32;
}

/**
 * Class representing a read only following database.
 */
model ReadOnlyFollowingDatabase extends Database {
  /**
   * The database properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  properties?: ReadOnlyFollowingDatabaseProperties;

  /**
   * Kind of the database
   */
  kind: "ReadOnlyFollowing";
}

/**
 * Class representing the Kusto database properties.
 */
model ReadOnlyFollowingDatabaseProperties {
  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The time the data should be kept before it stops being accessible to queries in TimeSpan.
   */
  @visibility(Lifecycle.Read)
  softDeletePeriod?: duration;

  /**
   * The time the data should be kept in cache for fast queries in TimeSpan.
   */
  hotCachePeriod?: duration;

  /**
   * The statistics of the database.
   */
  @visibility(Lifecycle.Read)
  statistics?: DatabaseStatistics;

  /**
   * The name of the leader cluster
   */
  @visibility(Lifecycle.Read)
  leaderClusterResourceId?: string;

  /**
   * The name of the attached database configuration cluster
   */
  @visibility(Lifecycle.Read)
  attachedDatabaseConfigurationName?: string;

  /**
   * The principals modification kind of the database
   */
  @visibility(Lifecycle.Read)
  principalsModificationKind?: PrincipalsModificationKind;
}

/**
 * Class representing an event hub data connection.
 */
model EventHubDataConnection extends DataConnection {
  /**
   * The Event Hub data connection properties to validate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  properties?: EventHubConnectionProperties;

  /**
   * Kind of the endpoint for the data connection
   */
  kind: "EventHub";
}

/**
 * Class representing the Kusto event hub connection properties.
 */
model EventHubConnectionProperties {
  /**
   * The resource ID of the event hub to be used to create a data connection.
   */
  eventHubResourceId: string;

  /**
   * The event hub consumer group.
   */
  consumerGroup: string;

  /**
   * The table where the data should be ingested. Optionally the table information can be added to each message.
   */
  tableName?: string;

  /**
   * The mapping rule to be used to ingest the data. Optionally the mapping information can be added to each message.
   */
  mappingRuleName?: string;

  /**
   * The data format of the message. Optionally the data format can be added to each message.
   */
  dataFormat?: EventHubDataFormat;

  /**
   * System properties of the event hub
   */
  eventSystemProperties?: string[];

  /**
   * The event hub messages compression type
   */
  compression?: Compression;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The resource ID of a managed identity (system or user assigned) to be used to authenticate with event hub.
   */
  managedIdentityResourceId?: string;
}

/**
 * Class representing an iot hub data connection.
 */
model IotHubDataConnection extends DataConnection {
  /**
   * The Iot Hub data connection properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  properties?: IotHubConnectionProperties;

  /**
   * Kind of the endpoint for the data connection
   */
  kind: "IotHub";
}

/**
 * Class representing the Kusto Iot hub connection properties.
 */
model IotHubConnectionProperties {
  /**
   * The resource ID of the Iot hub to be used to create a data connection.
   */
  iotHubResourceId: string;

  /**
   * The iot hub consumer group.
   */
  consumerGroup: string;

  /**
   * The table where the data should be ingested. Optionally the table information can be added to each message.
   */
  tableName?: string;

  /**
   * The mapping rule to be used to ingest the data. Optionally the mapping information can be added to each message.
   */
  mappingRuleName?: string;

  /**
   * The data format of the message. Optionally the data format can be added to each message.
   */
  dataFormat?: IotHubDataFormat;

  /**
   * System properties of the iot hub
   */
  eventSystemProperties?: string[];

  /**
   * The name of the share access policy
   */
  sharedAccessPolicyName: string;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

/**
 * Class representing an Event Grid data connection.
 */
model EventGridDataConnection extends DataConnection {
  /**
   * The properties of the Event Grid data connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  properties?: EventGridConnectionProperties;

  /**
   * Kind of the endpoint for the data connection
   */
  kind: "EventGrid";
}

/**
 * Class representing the Kusto event grid connection properties.
 */
model EventGridConnectionProperties {
  /**
   * The resource ID of the storage account where the data resides.
   */
  storageAccountResourceId: string;

  /**
   * The resource ID where the event grid is configured to send events.
   */
  eventHubResourceId: string;

  /**
   * The event hub consumer group.
   */
  consumerGroup: string;

  /**
   * The table where the data should be ingested. Optionally the table information can be added to each message.
   */
  tableName?: string;

  /**
   * The mapping rule to be used to ingest the data. Optionally the mapping information can be added to each message.
   */
  mappingRuleName?: string;

  /**
   * The data format of the message. Optionally the data format can be added to each message.
   */
  dataFormat?: EventGridDataFormat;

  /**
   * A Boolean value that, if set to true, indicates that ingestion should ignore the first record of every file
   */
  ignoreFirstRecord?: boolean;

  /**
   * The name of blob storage event type to process.
   */
  blobStorageEventType?: BlobStorageEventType;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}
