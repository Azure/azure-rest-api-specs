import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DBforPostgreSQL;

/**
 * The principal type used to represent the type of Active Directory Administrator.
 */
union PrincipalType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Group: "Group",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ServicePrincipal: "ServicePrincipal",
}

/**
 * HA mode supported for a server.
 */
union HaMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SameZone: "SameZone",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ZoneRedundant: "ZoneRedundant",
}

/**
 * Status of feature
 */
union SupportedFeatureStatusEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Gets a value indicating whether fast provisioning is supported. "Enabled" means fast provisioning is supported. "Disabled" stands for fast provisioning is not supported. Will be deprecated in future, please look to Supported Features for "FastProvisioning".
 */
union FastProvisioningSupportedEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Determines if geo-backup is supported in this region. "Enabled" means geo-backup is supported. "Disabled" stands for geo-back is not supported. Will be deprecated in future, please look to Supported Features for "GeoBackup".
 */
union GeoBackupSupportedEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * A value indicating whether Zone Redundant HA is supported in this region. "Enabled" means zone redundant HA is supported. "Disabled" stands for zone redundant HA is not supported. Will be deprecated in future, please look to Supported Features for "ZoneRedundantHa".
 */
union ZoneRedundantHaSupportedEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * A value indicating whether Zone Redundant HA and Geo-backup is supported in this region. "Enabled" means zone redundant HA and geo-backup is supported. "Disabled" stands for zone redundant HA and geo-backup is not supported. Will be deprecated in future, please look to Supported Features for "ZoneRedundantHaAndGeoBackup".
 */
union ZoneRedundantHaAndGeoBackupSupportedEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * A value indicating whether storage auto-grow is supported in this region. "Enabled" means storage auto-grow is supported. "Disabled" stands for storage auto-grow is not supported. Will be deprecated in future, please look to Supported Features for "StorageAutoGrowth".
 */
union StorageAutoGrowthSupportedEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * A value indicating whether online resize is supported in this region for the given subscription. "Enabled" means storage online resize is supported. "Disabled" means storage online resize is not supported. Will be deprecated in future, please look to Supported Features for "OnlineResize".
 */
union OnlineResizeSupportedEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * A value indicating whether this region is restricted. "Enabled" means region is restricted. "Disabled" stands for region is not restricted. Will be deprecated in future, please look to Supported Features for "Restricted".
 */
union RestrictedEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Data type of the configuration.
 */
union ConfigurationDataType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Boolean: "Boolean",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Numeric: "Numeric",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Integer: "Integer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enumeration: "Enumeration",
}

/**
 * the types of identities associated with this resource
 */
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * The version of a server.
 */
union ServerVersion {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `17`: "17",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `16`: "16",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `15`: "15",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `14`: "14",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `13`: "13",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `12`: "12",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `11`: "11",
}

/**
 * A state of a server that is visible to user.
 */
union ServerState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Ready: "Ready",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Dropping: "Dropping",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Starting: "Starting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stopping: "Stopping",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
}

/**
 * Flag to enable / disable Storage Auto grow for flexible server.
 */
union StorageAutoGrow {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Name of storage tier for IOPS.
 */
union AzureManagedDiskPerformanceTiers {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  P1: "P1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  P2: "P2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  P3: "P3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  P4: "P4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  P6: "P6",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  P10: "P10",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  P15: "P15",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  P20: "P20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  P30: "P30",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  P40: "P40",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  P50: "P50",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  P60: "P60",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  P70: "P70",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  P80: "P80",
}

/**
 * Storage type for the server. Allowed values are Premium_LRS, PremiumV2_LRS, and UltraSSD_LRS. Default is Premium_LRS if not specified
 */
union StorageType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Premium_LRS: "Premium_LRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PremiumV2_LRS: "PremiumV2_LRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UltraSSD_LRS: "UltraSSD_LRS",
}

/**
 * If Enabled, Azure Active Directory authentication is enabled.
 */
union ActiveDirectoryAuthEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * If Enabled, Password authentication is enabled.
 */
union PasswordAuthEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Data encryption type to depict if it is System Managed vs Azure Key vault.
 */
union ArmServerKeyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemManaged: "SystemManaged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureKeyVault: "AzureKeyVault",
}

/**
 * Primary encryption key status for Data encryption enabled server.
 */
union KeyStatusEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Valid: "Valid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Invalid: "Invalid",
}

/**
 * A value indicating whether Geo-Redundant backup is enabled on the server.
 */
union GeoRedundantBackupEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * public network access is enabled or not
 */
union ServerPublicNetworkAccessState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The HA mode for the server.
 */
union HighAvailabilityMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ZoneRedundant: "ZoneRedundant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SameZone: "SameZone",
}

/**
 * A state of a HA server that is visible to user.
 */
union ServerHAState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotEnabled: "NotEnabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CreatingStandby: "CreatingStandby",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ReplicatingData: "ReplicatingData",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FailingOver: "FailingOver",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Healthy: "Healthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RemovingStandby: "RemovingStandby",
}

/**
 * Used to indicate role of the server in replication set.
 */
union ReplicationRole {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Primary: "Primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AsyncReplica: "AsyncReplica",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GeoAsyncReplica: "GeoAsyncReplica",
}

/**
 * Gets the replication state of a replica server. This property is returned only for replicas api call. Supported values are Active, Catchup, Provisioning, Updating, Broken, Reconfiguring
 */
union ReplicationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Catchup: "Catchup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Broken: "Broken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Reconfiguring: "Reconfiguring",
}

/**
 * Sets the promote mode for a replica server. This is a write only property.
 */
union ReadReplicaPromoteMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  standalone: "standalone",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  switchover: "switchover",
}

/**
 * Sets the promote options for a replica server. This is a write only property.
 */
union ReplicationPromoteOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  planned: "planned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  forced: "forced",
}

/**
 * The mode to create a new PostgreSQL server.
 */
union CreateMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Create: "Create",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Update: "Update",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PointInTimeRestore: "PointInTimeRestore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GeoRestore: "GeoRestore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Replica: "Replica",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ReviveDropped: "ReviveDropped",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union PrivateEndpointConnectionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * The mode to update a new PostgreSQL server.
 */
union CreateModeForUpdate {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Update: "Update",
}

/**
 * Service-set extensible enum indicating the status of operation
 */
union ExecutionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cancelled: "Cancelled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
}

/**
 * Migration state.
 */
union MigrationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WaitingForUserAction: "WaitingForUserAction",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ValidationFailed: "ValidationFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CleaningUp: "CleaningUp",
}

/**
 * Migration sub state.
 */
union MigrationSubState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PerformingPreRequisiteSteps: "PerformingPreRequisiteSteps",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WaitingForLogicalReplicationSetupRequestOnSourceDB: "WaitingForLogicalReplicationSetupRequestOnSourceDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WaitingForDBsToMigrateSpecification: "WaitingForDBsToMigrateSpecification",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WaitingForTargetDBOverwriteConfirmation: "WaitingForTargetDBOverwriteConfirmation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WaitingForDataMigrationScheduling: "WaitingForDataMigrationScheduling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WaitingForDataMigrationWindow: "WaitingForDataMigrationWindow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MigratingData: "MigratingData",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WaitingForCutoverTrigger: "WaitingForCutoverTrigger",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CompletingMigration: "CompletingMigration",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CancelingRequestedDBMigrations: "CancelingRequestedDBMigrations",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ValidationInProgress: "ValidationInProgress",
}

/**
 * Migration db state of an individual database
 */
union MigrationDbState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WaitingForCutoverTrigger: "WaitingForCutoverTrigger",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceling: "Canceling",
}

/**
 * Validation status for migration
 */
union ValidationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warning: "Warning",
}

/**
 * There are two types of migration modes Online and Offline
 */
union MigrationMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Offline: "Offline",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Online: "Online",
}

/**
 * Supported types of migration request include Validate, Migrate and ValidateAndMigrate
 */
union MigrationOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Validate: "Validate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Migrate: "Migrate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ValidateAndMigrate: "ValidateAndMigrate",
}

/**
 * Migration source server type : OnPremises, AWS, GCP, AzureVM, PostgreSQLSingleServer, AWS_RDS, AWS_AURORA, AWS_EC2, GCP_CloudSQL, GCP_AlloyDB, GCP_Compute, EDB, EDB_Oracle_Server, EDB_PostgreSQL, PostgreSQLFlexibleServer, PostgreSQLCosmosDB, Huawei_RDS, Huawei_Compute, Heroku_PostgreSQL, Crunchy_PostgreSQL, ApsaraDB_RDS, Digital_Ocean_Droplets, Digital_Ocean_PostgreSQL, or Supabase_PostgreSQL
 */
union SourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OnPremises: "OnPremises",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AWS: "AWS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GCP: "GCP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureVM: "AzureVM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PostgreSQLSingleServer: "PostgreSQLSingleServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AWS_RDS: "AWS_RDS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AWS_AURORA: "AWS_AURORA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AWS_EC2: "AWS_EC2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GCP_CloudSQL: "GCP_CloudSQL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GCP_AlloyDB: "GCP_AlloyDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GCP_Compute: "GCP_Compute",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EDB: "EDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EDB_Oracle_Server: "EDB_Oracle_Server",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EDB_PostgreSQL: "EDB_PostgreSQL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PostgreSQLFlexibleServer: "PostgreSQLFlexibleServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PostgreSQLCosmosDB: "PostgreSQLCosmosDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Huawei_RDS: "Huawei_RDS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Huawei_Compute: "Huawei_Compute",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Heroku_PostgreSQL: "Heroku_PostgreSQL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Crunchy_PostgreSQL: "Crunchy_PostgreSQL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ApsaraDB_RDS: "ApsaraDB_RDS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Digital_Ocean_Droplets: "Digital_Ocean_Droplets",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Digital_Ocean_PostgreSQL: "Digital_Ocean_PostgreSQL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Supabase_PostgreSQL: "Supabase_PostgreSQL",
}

/**
 * Supported SSL modes for migration. VerifyFull is the recommended SSL mode for Single server migration. Prefer, Require are recommended SSL modes for other source types
 */
union SslMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Prefer: "Prefer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Require: "Require",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  VerifyCA: "VerifyCA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  VerifyFull: "VerifyFull",
}

/**
 * Indicates whether to setup LogicalReplicationOnSourceDb, if needed
 */
union LogicalReplicationOnSourceDbEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  False: "False",
}

/**
 * Indicates whether the databases on the target server can be overwritten, if already present. If set to False, the migration workflow will wait for a confirmation, if it detects that the database already exists.
 */
union OverwriteDbsInTargetEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  False: "False",
}

/**
 * To migrate roles and permissions we need to send this flag as True
 */
union MigrateRolesEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  False: "False",
}

/**
 * Indicates whether the data migration should start right away
 */
union StartDataMigrationEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  False: "False",
}

/**
 * To trigger cutover for entire migration we need to send this flag as True
 */
union TriggerCutoverEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  False: "False",
}

/**
 * To trigger cancel for entire migration we need to send this flag as True
 */
union CancelEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  False: "False",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union MigrationListFilter {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  All: "All",
}

/**
 * Migration name availability reason.
 */
union MigrationNameAvailabilityReason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AlreadyExists: "AlreadyExists",
}

/**
 * The intended executor of the operation.
 */
union OperationOrigin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  system: "system",
}

/**
 * Failover mode.
 */
union FailoverMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PlannedFailover: "PlannedFailover",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ForcedFailover: "ForcedFailover",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PlannedSwitchover: "PlannedSwitchover",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ForcedSwitchover: "ForcedSwitchover",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ThreatProtectionName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union TuningOptionEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  index: "index",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union RecommendationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CreateIndex: "CreateIndex",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DropIndex: "DropIndex",
}

/**
 * Type for this recommendation.
 */
union RecommendationTypeEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CreateIndex: "CreateIndex",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DropIndex: "DropIndex",
}

/**
 * The endpoint type for the virtual endpoint.
 */
union VirtualEndpointType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ReadWrite: "ReadWrite",
}

/**
 * Migration details level.
 */
union MigrationDetailsLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Summary: "Summary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Full: "Full",
}

/**
 * The status of the capability.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum CapabilityStatus {
  Visible,
  Available,
  Default,
  Disabled,
}

/**
 * Specifies the state of the Threat Protection, whether it is enabled or disabled or a state has not been applied yet on the specific server.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ThreatProtectionState {
  Enabled,
  Disabled,
}

/**
 * Represents an Active Directory administrator.
 */
model ActiveDirectoryAdministratorAdd {
  /**
   * Properties of the active directory administrator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: AdministratorPropertiesForAdd;
}

/**
 * The properties of an Active Directory administrator.
 */
model AdministratorPropertiesForAdd {
  /**
   * The principal type used to represent the type of Active Directory Administrator.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  principalType?: PrincipalType;

  /**
   * Active Directory administrator principal name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  principalName?: string;

  /**
   * The tenantId of the Active Directory administrator.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  tenantId?: string;
}

/**
 * The properties of an Active Directory administrator.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AdministratorProperties {
  /**
   * The principal type used to represent the type of Active Directory Administrator.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  principalType?: PrincipalType;

  /**
   * Active Directory administrator principal name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  principalName?: string;

  /**
   * The objectId of the Active Directory administrator.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  objectId?: string;

  /**
   * The tenantId of the Active Directory administrator.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tenantId?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

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

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * The properties of a server backup.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ServerBackupProperties {
  /**
   * Backup type.
   */
  backupType?: Origin;

  /**
   * Backup completed time (ISO8601 format).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completedTime?: utcDateTime;

  /**
   * Backup source
   */
  source?: string;
}

/**
 * Capability for the PostgreSQL server
 */
model CapabilitiesListResult is Azure.Core.Page<FlexibleServerCapability>;

/**
 * Capability for the PostgreSQL server
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model FlexibleServerCapability extends CapabilityBase {
  /**
   * Name of flexible servers capability
   */
  name?: string;

  /**
   * List of supported flexible server editions
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  supportedServerEditions?: FlexibleServerEditionCapability[];

  /**
   * The list of server versions supported for this capability.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  supportedServerVersions?: ServerVersionCapability[];

  /**
   * The supported features.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  supportedFeatures?: SupportedFeature[];

  /**
   * Gets a value indicating whether fast provisioning is supported. "Enabled" means fast provisioning is supported. "Disabled" stands for fast provisioning is not supported. Will be deprecated in future, please look to Supported Features for "FastProvisioning".
   */
  @visibility(Lifecycle.Read)
  fastProvisioningSupported?: FastProvisioningSupportedEnum;

  /**
   * List of supported server editions for fast provisioning
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["supportedSku"])
  supportedFastProvisioningEditions?: FastProvisioningEditionCapability[];

  /**
   * Determines if geo-backup is supported in this region. "Enabled" means geo-backup is supported. "Disabled" stands for geo-back is not supported. Will be deprecated in future, please look to Supported Features for "GeoBackup".
   */
  @visibility(Lifecycle.Read)
  geoBackupSupported?: GeoBackupSupportedEnum;

  /**
   * A value indicating whether Zone Redundant HA is supported in this region. "Enabled" means zone redundant HA is supported. "Disabled" stands for zone redundant HA is not supported. Will be deprecated in future, please look to Supported Features for "ZoneRedundantHa".
   */
  @visibility(Lifecycle.Read)
  zoneRedundantHaSupported?: ZoneRedundantHaSupportedEnum;

  /**
   * A value indicating whether Zone Redundant HA and Geo-backup is supported in this region. "Enabled" means zone redundant HA and geo-backup is supported. "Disabled" stands for zone redundant HA and geo-backup is not supported. Will be deprecated in future, please look to Supported Features for "ZoneRedundantHaAndGeoBackup".
   */
  @visibility(Lifecycle.Read)
  zoneRedundantHaAndGeoBackupSupported?: ZoneRedundantHaAndGeoBackupSupportedEnum;

  /**
   * A value indicating whether storage auto-grow is supported in this region. "Enabled" means storage auto-grow is supported. "Disabled" stands for storage auto-grow is not supported. Will be deprecated in future, please look to Supported Features for "StorageAutoGrowth".
   */
  @visibility(Lifecycle.Read)
  storageAutoGrowthSupported?: StorageAutoGrowthSupportedEnum;

  /**
   * A value indicating whether online resize is supported in this region for the given subscription. "Enabled" means storage online resize is supported. "Disabled" means storage online resize is not supported. Will be deprecated in future, please look to Supported Features for "OnlineResize".
   */
  @visibility(Lifecycle.Read)
  onlineResizeSupported?: OnlineResizeSupportedEnum;

  /**
   * A value indicating whether this region is restricted. "Enabled" means region is restricted. "Disabled" stands for region is not restricted. Will be deprecated in future, please look to Supported Features for "Restricted".
   */
  @visibility(Lifecycle.Read)
  restricted?: RestrictedEnum;
}

/**
 * Flexible server edition capabilities.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model FlexibleServerEditionCapability extends CapabilityBase {
  /**
   * Server edition name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Default sku name for the server edition
   */
  @visibility(Lifecycle.Read)
  defaultSkuName?: string;

  /**
   * The list of editions supported by this server edition.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  supportedStorageEditions?: StorageEditionCapability[];

  /**
   * List of supported server SKUs.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  supportedServerSkus?: ServerSkuCapability[];
}

/**
 * Storage edition capability
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model StorageEditionCapability extends CapabilityBase {
  /**
   * Storage edition name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Default storage size in MB for storage edition
   */
  @visibility(Lifecycle.Read)
  defaultStorageSizeMb?: int64;

  /**
   * Flexible server supported storage range in MB
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["storageSizeMb"])
  supportedStorageMb?: StorageMbCapability[];
}

/**
 * storage size in MB capability
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model StorageMbCapability extends CapabilityBase {
  /**
   * Supported IOPS
   */
  @visibility(Lifecycle.Read)
  supportedIops?: int32;

  /**
   * Maximum IOPS supported by this #Vcores or PremiumV2_LRS Storage Size
   */
  @visibility(Lifecycle.Read)
  supportedMaximumIops?: int32;

  /**
   * Storage size in MB
   */
  @visibility(Lifecycle.Read)
  storageSizeMb?: int64;

  /**
   * Maximum value of Storage size in MB
   */
  @visibility(Lifecycle.Read)
  maximumStorageSizeMb?: int64;

  /**
   * Values of throughput in MB/s
   */
  @visibility(Lifecycle.Read)
  supportedThroughput?: int32;

  /**
   * Maximum values of throughput in MB/s
   */
  @visibility(Lifecycle.Read)
  supportedMaximumThroughput?: int32;

  /**
   * Default tier for IOPS
   */
  @visibility(Lifecycle.Read)
  defaultIopsTier?: string;

  /**
   * List of available options to upgrade the storage performance
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  supportedIopsTiers?: StorageTierCapability[];
}

/**
 * Represents capability of a storage tier
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model StorageTierCapability extends CapabilityBase {
  /**
   * Name to represent Storage tier capability
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Supported IOPS for this storage tier
   */
  @visibility(Lifecycle.Read)
  iops?: int32;
}

/**
 * Base object for representing capability
 */
model CapabilityBase {
  /**
   * The status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * The reason for the capability not being available.
   */
  @visibility(Lifecycle.Read)
  reason?: string;
}

/**
 * Sku capability
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ServerSkuCapability extends CapabilityBase {
  /**
   * Sku name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Supported vCores
   */
  @visibility(Lifecycle.Read)
  vCores?: int32;

  /**
   * Supported IOPS
   */
  @visibility(Lifecycle.Read)
  supportedIops?: int32;

  /**
   * Supported memory per vCore in MB
   */
  @visibility(Lifecycle.Read)
  supportedMemoryPerVcoreMb?: int64;

  /**
   * List of supported Availability Zones. E.g. "1", "2", "3"
   */
  @visibility(Lifecycle.Read)
  supportedZones?: string[];

  /**
   * Supported high availability mode
   */
  @visibility(Lifecycle.Read)
  supportedHaMode?: HaMode[];

  /**
   * The supported features.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  supportedFeatures?: SupportedFeature[];

  /**
   * The value of security profile indicating if its confidential vm
   */
  @visibility(Lifecycle.Read)
  securityProfile?: string;
}

/**
 * The supported features.
 */
model SupportedFeature {
  /**
   * Name of feature
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Status of feature
   */
  @visibility(Lifecycle.Read)
  status?: SupportedFeatureStatusEnum;
}

/**
 * Server version capabilities.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ServerVersionCapability extends CapabilityBase {
  /**
   * Server version
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Supported servers versions to upgrade
   */
  @visibility(Lifecycle.Read)
  supportedVersionsToUpgrade?: string[];

  /**
   * The supported features.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  supportedFeatures?: SupportedFeature[];
}

/**
 * Represents capability of a fast provisioning edition
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model FastProvisioningEditionCapability extends CapabilityBase {
  /**
   * Fast provisioning supported tier name
   */
  @visibility(Lifecycle.Read)
  supportedTier?: string;

  /**
   * Fast provisioning supported sku name
   */
  @visibility(Lifecycle.Read)
  supportedSku?: string;

  /**
   * Fast provisioning supported storage in Gb
   */
  @visibility(Lifecycle.Read)
  supportedStorageGb?: int32;

  /**
   * Fast provisioning supported version
   */
  @visibility(Lifecycle.Read)
  supportedServerVersions?: string;

  /**
   * Count of servers in cache matching the spec
   */
  @visibility(Lifecycle.Read)
  serverCount?: int32;
}

/**
 * The check availability request body.
 */
model CheckNameAvailabilityRequest {
  /**
   * The name of the resource for which availability needs to be checked.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;
}

/**
 * Represents a resource name availability.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NameAvailability extends CheckNameAvailabilityResponse {
  /**
   * name of the PostgreSQL server.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * type of the server
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The check availability result.
 */
model CheckNameAvailabilityResponse {
  /**
   * Indicates if the resource name is available.
   */
  nameAvailable?: boolean;

  /**
   * The reason why the given name is not available.
   */
  reason?: CheckNameAvailabilityReason;

  /**
   * Detailed reason why the given name is available.
   */
  message?: string;
}

/**
 * The properties of a configuration.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ConfigurationProperties {
  /**
   * Value of the configuration. Required to update the configuration.
   */
  value?: string;

  /**
   * Description of the configuration.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Default value of the configuration.
   */
  @visibility(Lifecycle.Read)
  defaultValue?: string;

  /**
   * Data type of the configuration.
   */
  @visibility(Lifecycle.Read)
  dataType?: ConfigurationDataType;

  /**
   * Allowed values of the configuration.
   */
  @visibility(Lifecycle.Read)
  allowedValues?: string;

  /**
   * Source of the configuration. Required to update the configuration.
   */
  source?: string;

  /**
   * Configuration dynamic or static.
   */
  @visibility(Lifecycle.Read)
  isDynamicConfig?: boolean;

  /**
   * Configuration read-only or not.
   */
  @visibility(Lifecycle.Read)
  isReadOnly?: boolean;

  /**
   * Configuration is pending restart or not.
   */
  @visibility(Lifecycle.Read)
  isConfigPendingRestart?: boolean;

  /**
   * Configuration unit.
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * Configuration documentation link.
   */
  @visibility(Lifecycle.Read)
  documentationLink?: string;
}

/**
 * Represents a Configuration.
 */
model ConfigurationForUpdate {
  /**
   * The properties of a configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ConfigurationProperties;
}

/**
 * The properties of a database.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DatabaseProperties {
  /**
   * The charset of the database.
   */
  @pattern("^[a-zA-Z]+\\w*$")
  charset?: string;

  /**
   * The collation of the database.
   */
  @pattern("^[a-zA-Z\\-]+([. ]|\\w)*$")
  collation?: string;
}

/**
 * The properties of a server firewall rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model FirewallRuleProperties {
  /**
   * The start IP address of the server firewall rule. Must be IPv4 format.
   */
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  startIpAddress: string;

  /**
   * The end IP address of the server firewall rule. Must be IPv4 format.
   */
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  endIpAddress: string;
}

/**
 * Sku information related properties of a server.
 */
model Sku {
  /**
   * The name of the sku, typically, tier + family + cores, e.g. Standard_D4s_v3.
   */
  name: string;

  /**
   * The tier of the particular SKU, e.g. Burstable.
   */
  tier: SkuTier;
}

/**
 * Describes a single user-assigned identity associated with the application.
 */
model UserIdentity {
  /**
   * the object identifier of the Service Principal which this identity represents.
   */
  principalId?: string;

  /**
   * the client identifier of the Service Principal which this identity represents.
   */
  clientId?: string;
}

/**
 * The properties of a server.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ServerProperties {
  /**
   * The administrator's login name of a server. Can only be specified when the server is being created (and is required for creation).
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
   * PostgreSQL Server version.
   */
  version?: ServerVersion;

  /**
   * The minor version of the server.
   */
  @visibility(Lifecycle.Read)
  minorVersion?: string;

  /**
   * A state of a server that is visible to user.
   */
  @visibility(Lifecycle.Read)
  state?: ServerState;

  /**
   * The fully qualified domain name of a server.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  /**
   * Storage properties of a server.
   */
  storage?: Storage;

  /**
   * AuthConfig properties of a server.
   */
  authConfig?: AuthConfig;

  /**
   * Data encryption properties of a server.
   */
  dataEncryption?: DataEncryption;

  /**
   * Backup properties of a server.
   */
  backup?: Backup;

  /**
   * Network properties of a server. This Network property is required to be passed only in case you want the server to be Private access server.
   */
  network?: Network;

  /**
   * High availability properties of a server.
   */
  highAvailability?: HighAvailability;

  /**
   * Maintenance window properties of a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  maintenanceWindow?: MaintenanceWindow;

  /**
   * The source server resource ID to restore from. It's required when 'createMode' is 'PointInTimeRestore' or 'GeoRestore' or 'Replica' or 'ReviveDropped'. This property is returned only for Replica server
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceServerResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DBforPostgreSQL/flexibleServers";
    }
  ]>;

  /**
   * Restore point creation time (ISO8601 format), specifying the time to restore from. It's required when 'createMode' is 'PointInTimeRestore' or 'GeoRestore' or 'ReviveDropped'.
   */
  @visibility(Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  pointInTimeUTC?: utcDateTime;

  /**
   * availability zone information of the server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  availabilityZone?: string = "";

  /**
   * Replication role of the server
   */
  replicationRole?: ReplicationRole;

  /**
   * Replicas allowed for a server.
   */
  @visibility(Lifecycle.Read)
  replicaCapacity?: int32;

  /**
   * Replica properties of a server. These Replica properties are required to be passed only in case you want to Promote a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  replica?: Replica;

  /**
   * The mode to create a new PostgreSQL server.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  createMode?: CreateMode;

  /**
   * List of private endpoint connections associated with the specified resource.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Cluster properties of a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  cluster?: Cluster;
}

/**
 * Storage properties of a server
 */
model Storage {
  /**
   * Max storage allowed for a server.
   */
  storageSizeGB?: int32;

  /**
   * Flag to enable / disable Storage Auto grow for flexible server.
   */
  autoGrow?: StorageAutoGrow;

  /**
   * Name of storage tier for IOPS.
   */
  tier?: AzureManagedDiskPerformanceTiers;

  /**
   * Storage tier IOPS quantity. This property is required to be set for storage Type PremiumV2_LRS and UltraSSD_LRS.
   */
  iops?: int32;

  /**
   * Storage throughput for the server. This is required to be set for storage Type PremiumV2_LRS and UltraSSD_LRS.
   */
  throughput?: int32;

  /**
   * Storage type for the server. Allowed values are Premium_LRS, PremiumV2_LRS, and UltraSSD_LRS. Default is Premium_LRS if not specified
   */
  type?: StorageType;
}

/**
 * Authentication configuration properties of a server
 */
model AuthConfig {
  /**
   * If Enabled, Azure Active Directory authentication is enabled.
   */
  activeDirectoryAuth?: ActiveDirectoryAuthEnum;

  /**
   * If Enabled, Password authentication is enabled.
   */
  passwordAuth?: PasswordAuthEnum = PasswordAuthEnum.Enabled;

  /**
   * Tenant id of the server.
   */
  tenantId?: string = "";
}

/**
 * Data encryption properties of a server
 */
model DataEncryption {
  /**
   * URI for the key in keyvault for data encryption of the primary server.
   */
  primaryKeyURI?: string;

  /**
   * Resource Id for the User assigned identity to be used for data encryption of the primary server.
   */
  primaryUserAssignedIdentityId?: string;

  /**
   * URI for the key in keyvault for data encryption for geo-backup of server.
   */
  geoBackupKeyURI?: string;

  /**
   * Resource Id for the User assigned identity to be used for data encryption for geo-backup of server.
   */
  geoBackupUserAssignedIdentityId?: string;

  /**
   * Data encryption type to depict if it is System Managed vs Azure Key vault.
   */
  type?: ArmServerKeyType;

  /**
   * Primary encryption key status for Data encryption enabled server.
   */
  @visibility(Lifecycle.Read)
  primaryEncryptionKeyStatus?: KeyStatusEnum;

  /**
   * Geo-backup encryption key status for Data encryption enabled server.
   */
  @visibility(Lifecycle.Read)
  geoBackupEncryptionKeyStatus?: KeyStatusEnum;
}

/**
 * Backup properties of a server
 */
model Backup {
  /**
   * Backup retention days for the server.
   */
  backupRetentionDays?: int32 = 7;

  /**
   * A value indicating whether Geo-Redundant backup is enabled on the server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  geoRedundantBackup?: GeoRedundantBackupEnum = GeoRedundantBackupEnum.Disabled;

  /**
   * The earliest restore point time (ISO8601 format) for server.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;
}

/**
 * Network properties of a server.
 */
model Network {
  /**
   * public network access is enabled or not
   */
  publicNetworkAccess?: ServerPublicNetworkAccessState;

  /**
   * Delegated subnet arm resource id. This is required to be passed during create, in case we want the server to be VNET injected, i.e. Private access server. During update, pass this only if we want to update the value for Private DNS zone.
   */
  delegatedSubnetResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Private dns zone arm resource id. This is required to be passed during create, in case we want the server to be VNET injected, i.e. Private access server. During update, pass this only if we want to update the value for Private DNS zone.
   */
  privateDnsZoneArmResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateDnsZones";
    }
  ]>;
}

/**
 * High availability properties of a server
 */
model HighAvailability {
  /**
   * The HA mode for the server.
   */
  mode?: HighAvailabilityMode = HighAvailabilityMode.Disabled;

  /**
   * A state of a HA server that is visible to user.
   */
  @visibility(Lifecycle.Read)
  state?: ServerHAState;

  /**
   * availability zone information of the standby.
   */
  standbyAvailabilityZone?: string = "";
}

/**
 * Maintenance window properties of a server.
 */
model MaintenanceWindow {
  /**
   * indicates whether custom window is enabled or disabled
   */
  customWindow?: string = "Disabled";

  /**
   * start hour for maintenance window
   */
  startHour?: int32;

  /**
   * start minute for maintenance window
   */
  startMinute?: int32;

  /**
   * day of week for maintenance window
   */
  dayOfWeek?: int32;
}

/**
 * Replica properties of a server
 */
model Replica {
  /**
   * Used to indicate role of the server in replication set.
   */
  role?: ReplicationRole;

  /**
   * Replicas allowed for a server.
   */
  @visibility(Lifecycle.Read)
  capacity?: int32;

  /**
   * Gets the replication state of a replica server. This property is returned only for replicas api call. Supported values are Active, Catchup, Provisioning, Updating, Broken, Reconfiguring
   */
  @visibility(Lifecycle.Read)
  replicationState?: ReplicationState;

  /**
   * Sets the promote mode for a replica server. This is a write only property.
   */
  @visibility(Lifecycle.Update)
  promoteMode?: ReadReplicaPromoteMode;

  /**
   * Sets the promote options for a replica server. This is a write only property.
   */
  @visibility(Lifecycle.Update)
  promoteOption?: ReplicationPromoteOption;
}

/**
 * Properties of the private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The group ids for the private endpoint resource.
   */
  @visibility(Lifecycle.Read)
  groupIds?: string[];

  /**
   * The private endpoint resource.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The private endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for private endpoint.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * Cluster properties of a server.
 */
model Cluster {
  /**
   * The node count for the cluster.
   */
  clusterSize?: int32;
}

/**
 * Represents a server to be updated.
 */
model ServerForUpdate {
  /**
   * The SKU (pricing tier) of the server.
   */
  sku?: Sku;

  /**
   * Describes the identity of the application.
   */
  identity?: UserAssignedIdentity;

  /**
   * Properties of the server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ServerPropertiesForUpdate;

  /**
   * Application-specific metadata in the form of key-value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ServerPropertiesForUpdate {
  /**
   * The administrator's login name of a server. Can only be specified when the server is trying to switch to password authentication and does not have default administrator login.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  administratorLogin?: string;

  /**
   * The password of the administrator login.
   */
  @visibility(Lifecycle.Update)
  @secret
  administratorLoginPassword?: string;

  /**
   * PostgreSQL Server version. Version 16 is currently not supported for MVU.
   */
  version?: ServerVersion;

  /**
   * Storage properties of a server.
   */
  storage?: Storage;

  /**
   * Backup properties of a server.
   */
  backup?: Backup;

  /**
   * High availability properties of a server.
   */
  highAvailability?: HighAvailability;

  /**
   * Maintenance window properties of a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  maintenanceWindow?: MaintenanceWindow;

  /**
   * AuthConfig properties of a server.
   */
  authConfig?: AuthConfig;

  /**
   * Data encryption properties of a server.
   */
  dataEncryption?: DataEncryption;

  /**
   * The mode to update a new PostgreSQL server.
   */
  @visibility(Lifecycle.Update)
  createMode?: CreateModeForUpdate;

  /**
   * Replication role of the server
   */
  replicationRole?: ReplicationRole;

  /**
   * Replica properties of a server. These Replica properties are required to be passed only in case you want to Promote a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  replica?: Replica;

  /**
   * Network properties of a server. These are required to be passed only in case if server is a private access server.
   */
  network?: Network;

  /**
   * Cluster properties of a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  cluster?: Cluster;
}

/**
 * A request that is made for pre-backup.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LtrPreBackupRequest extends BackupRequestBase {}

/**
 * BackupRequestBase is the base for all backup request.
 */
model BackupRequestBase {
  /**
   * Backup Settings
   */
  backupSettings: BackupSettings;
}

/**
 * The settings for the long term backup.
 */
model BackupSettings {
  /**
   * Backup Name for the current backup
   */
  backupName: string;
}

/**
 * Response for the LTR pre-backup API call
 */
model LtrPreBackupResponse {
  /**
   * Additional Properties for the pre backup response
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: LtrPreBackupResponseProperties;
}

/**
 * Response for the pre-backup request.
 */
model LtrPreBackupResponseProperties {
  /**
   * Number of storage containers the plugin will use during backup. More than one containers may be used for size limitations, parallelism, or redundancy etc.
   */
  numberOfContainers: int32;
}

/**
 * The request that is made for a long term retention backup.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LtrBackupRequest extends BackupRequestBase {
  /**
   * Backup store detail for target server
   */
  targetDetails: BackupStoreDetails;
}

/**
 * Details about the target where the backup content will be stored.
 */
model BackupStoreDetails {
  /**
   * List of SAS uri of storage containers where backup data is to be streamed/copied.
   */
  sasUriList: string[];
}

/**
 * Response for the LTR backup API call
 */
model LtrBackupResponse {
  /**
   * Long Term Retention Backup Operation Resource Properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: LtrBackupOperationResponseProperties;
}

/**
 * Response for the backup request.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model LtrBackupOperationResponseProperties {
  /**
   * Size of datasource in bytes
   */
  datasourceSizeInBytes?: int64;

  /**
   * Data transferred in bytes
   */
  dataTransferredInBytes?: int64;

  /**
   * Name of Backup operation
   */
  backupName?: string;

  /**
   * Metadata to be stored in RP. Store everything that will be required to perform a successful restore using this Recovery point. e.g. Versions, DataFormat etc
   */
  backupMetadata?: string;

  /**
   * Service-set extensible enum indicating the status of operation
   */
  status: ExecutionStatus;

  /**
   * Start time of the operation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  /**
   * End time of the operation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * PercentageCompleted
   */
  @maxValue(100)
  percentComplete?: float64;

  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

/**
 * A list of long term retention backup operations for server.
 */
model LtrServerBackupOperationList is Azure.Core.Page<LtrServerBackupOperation>;

/**
 * Migration resource properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model MigrationResourceProperties {
  /**
   * ID for migration, a GUID.
   */
  @visibility(Lifecycle.Read)
  migrationId?: string;

  /**
   * Current status of migration
   */
  @visibility(Lifecycle.Read)
  currentStatus?: MigrationStatus;

  /**
   * ResourceId of the private endpoint migration instance
   */
  migrationInstanceResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * There are two types of migration modes Online and Offline
   */
  migrationMode?: MigrationMode;

  /**
   * This indicates the supported Migration option for the migration
   */
  migrationOption?: MigrationOption;

  /**
   * migration source server type : OnPremises, AWS, GCP, AzureVM, PostgreSQLSingleServer, AWS_RDS, AWS_AURORA, AWS_EC2, GCP_CloudSQL, GCP_AlloyDB, GCP_Compute, EDB, EDB_Oracle_Server, EDB_PostgreSQL, PostgreSQLFlexibleServer, PostgreSQLCosmosDB, Huawei_RDS, Huawei_Compute, Heroku_PostgreSQL, Crunchy_PostgreSQL, ApsaraDB_RDS, Digital_Ocean_Droplets, Digital_Ocean_PostgreSQL, or Supabase_PostgreSQL
   */
  sourceType?: SourceType;

  /**
   * SSL modes for migration. Default SSL mode for PostgreSQLSingleServer is VerifyFull and Prefer for other source types
   */
  sslMode?: SslMode;

  /**
   * Metadata of the source database server
   */
  @visibility(Lifecycle.Read)
  sourceDbServerMetadata?: DbServerMetadata;

  /**
   * Metadata of the target database server
   */
  @visibility(Lifecycle.Read)
  targetDbServerMetadata?: DbServerMetadata;

  @doc("ResourceId of the source database server in case the sourceType is PostgreSQLSingleServer. For other source types this should be ipaddress:port@username or hostname:port@username")
  sourceDbServerResourceId?: string;

  /**
   * Source server fully qualified domain name (FQDN) or IP address. It is a optional value, if customer provide it, migration service will always use it for connection
   */
  sourceDbServerFullyQualifiedDomainName?: string;

  /**
   * ResourceId of the source database server
   */
  @visibility(Lifecycle.Read)
  targetDbServerResourceId?: string;

  /**
   * Target server fully qualified domain name (FQDN) or IP address. It is a optional value, if customer provide it, migration service will always use it for connection
   */
  targetDbServerFullyQualifiedDomainName?: string;

  /**
   * Migration secret parameters
   */
  secretParameters?: MigrationSecretParameters;

  /**
   * Number of databases to migrate
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  dbsToMigrate?: string[];

  /**
   * Indicates whether to setup LogicalReplicationOnSourceDb, if needed
   */
  setupLogicalReplicationOnSourceDbIfNeeded?: LogicalReplicationOnSourceDbEnum;

  /**
   * Indicates whether the databases on the target server can be overwritten, if already present. If set to False, the migration workflow will wait for a confirmation, if it detects that the database already exists.
   */
  overwriteDbsInTarget?: OverwriteDbsInTargetEnum;

  /**
   * Start time in UTC for migration window
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  migrationWindowStartTimeInUtc?: utcDateTime;

  /**
   * End time in UTC for migration window
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  migrationWindowEndTimeInUtc?: utcDateTime;

  /**
   * To migrate roles and permissions we need to send this flag as True
   */
  migrateRoles?: MigrateRolesEnum;

  /**
   * Indicates whether the data migration should start right away
   */
  startDataMigration?: StartDataMigrationEnum;

  /**
   * To trigger cutover for entire migration we need to send this flag as True
   */
  triggerCutover?: TriggerCutoverEnum;

  /**
   * When you want to trigger cutover for specific databases send triggerCutover flag as True and database names in this array
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  dbsToTriggerCutoverOn?: string[];

  /**
   * To trigger cancel for entire migration we need to send this flag as True
   */
  cancel?: CancelEnum;

  /**
   * When you want to trigger cancel for specific databases send cancel flag as True and database names in this array
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  dbsToCancelMigrationOn?: string[];
}

/**
 * Migration status.
 */
model MigrationStatus {
  /**
   * State of migration
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Error message, if any, for the migration state
   */
  @visibility(Lifecycle.Read)
  error?: string;

  /**
   * Current Migration sub state details.
   */
  @visibility(Lifecycle.Read)
  currentSubStateDetails?: MigrationSubStateDetails;
}

/**
 * Migration sub state details.
 */
model MigrationSubStateDetails {
  /**
   * Migration sub state.
   */
  @visibility(Lifecycle.Read)
  currentSubState?: MigrationSubState;

  /**
   * Dictionary of <DbMigrationStatus>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  dbDetails?: Record<DbMigrationStatus>;

  /**
   * Details for the validation for migration
   */
  validationDetails?: ValidationDetails;
}

/**
 * Migration status of an individual database
 */
model DbMigrationStatus {
  /**
   * Name of the database
   */
  databaseName?: string;

  /**
   * Migration db state of an individual database
   */
  migrationState?: MigrationDbState;

  /**
   * Migration operation of an individual database
   */
  migrationOperation?: string;

  /**
   * Start date-time of a migration state
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * End date-time of a migration state
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Number of tables queued for the migration of a DB
   */
  fullLoadQueuedTables?: int32;

  /**
   * Number of tables errored out during the migration of a DB
   */
  fullLoadErroredTables?: int32;

  /**
   * Number of tables loading during the migration of a DB
   */
  fullLoadLoadingTables?: int32;

  /**
   * Number of tables loaded during the migration of a DB
   */
  fullLoadCompletedTables?: int32;

  /**
   * CDC update counter
   */
  cdcUpdateCounter?: int32;

  /**
   * CDC delete counter
   */
  cdcDeleteCounter?: int32;

  /**
   * CDC insert counter
   */
  cdcInsertCounter?: int32;

  /**
   * CDC applied changes counter
   */
  appliedChanges?: int32;

  /**
   * CDC incoming changes counter
   */
  incomingChanges?: int32;

  /**
   * Lag in seconds between source and target during online phase
   */
  latency?: int32;

  /**
   * Error message, if any, for the migration state
   */
  message?: string;
}

/**
 * Details for the validation for migration
 */
model ValidationDetails {
  /**
   * Validation status for migration
   */
  status?: ValidationState;

  /**
   * Validation Start date-time in UTC
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validationStartTimeInUtc?: utcDateTime;

  /**
   * Validation End date-time in UTC
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validationEndTimeInUtc?: utcDateTime;

  /**
   * Details of server level validations
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  serverLevelValidationDetails?: ValidationSummaryItem[];

  /**
   * Details of server level validations
   */
  @OpenAPI.extension("x-ms-identifiers", #["databaseName"])
  dbLevelValidationDetails?: DbLevelValidationStatus[];
}

/**
 * Validation summary object
 */
model ValidationSummaryItem {
  /**
   * Validation type
   */
  type?: string;

  /**
   * Validation status for migration
   */
  state?: ValidationState;

  /**
   * Validation messages
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  messages?: ValidationMessage[];
}

/**
 * Validation message object
 */
model ValidationMessage {
  /**
   * Severity of validation message
   */
  state?: ValidationState;

  /**
   * Validation message string
   */
  message?: string;
}

/**
 * Validation status summary for an individual database
 */
model DbLevelValidationStatus {
  /**
   * Name of the database
   */
  databaseName?: string;

  /**
   * Start date-time of a database level validation
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * End date-time of a database level validation
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Summary of database level validations
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  summary?: ValidationSummaryItem[];
}

/**
 * Database server metadata.
 */
model DbServerMetadata {
  /**
   * Location of database server
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Version for database engine
   */
  version?: string;

  /**
   * Storage size in MB for database server
   */
  storageMb?: int32;

  /**
   * SKU for the database server. This object is empty for PG single server
   */
  sku?: ServerSku;
}

/**
 * Sku information related properties of a server.
 */
model ServerSku {
  /**
   * The name of the sku, typically, tier + family + cores, e.g. Standard_D4s_v3.
   */
  name?: string;

  /**
   * The tier of the particular SKU, e.g. Burstable.
   */
  tier?: SkuTier;
}

/**
 * Migration secret parameters.
 */
model MigrationSecretParameters {
  /**
   * Admin credentials for source and target servers
   */
  adminCredentials: AdminCredentials;

  /**
   * Gets or sets the username for the source server. This user need not be an admin.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  sourceServerUsername?: string;

  /**
   * Gets or sets the username for the target server. This user need not be an admin.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  targetServerUsername?: string;
}

/**
 * Server admin credentials.
 */
model AdminCredentials {
  /**
   * Password for source server.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  sourceServerPassword: string;

  /**
   * Password for target server.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  targetServerPassword: string;
}

/**
 * Represents a migration resource for patch.
 */
model MigrationResourceForPatch {
  /**
   * Migration resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: MigrationResourcePropertiesForPatch;

  /**
   * Application-specific metadata in the form of key-value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Migration resource properties for patch.
 */
model MigrationResourcePropertiesForPatch {
  /**
   * ResourceId of the source database server
   */
  sourceDbServerResourceId?: string;

  /**
   * Source server fully qualified domain name (FQDN) or IP address. It is a optional value, if customer provide it, migration service will always use it for connection
   */
  sourceDbServerFullyQualifiedDomainName?: string;

  /**
   * Target server fully qualified domain name (FQDN) or IP address. It is a optional value, if customer provide it, migration service will always use it for connection
   */
  targetDbServerFullyQualifiedDomainName?: string;

  /**
   * Migration secret parameters
   */
  secretParameters?: MigrationSecretParameters;

  /**
   * Number of databases to migrate
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  dbsToMigrate?: string[];

  /**
   * Indicates whether to setup LogicalReplicationOnSourceDb, if needed
   */
  setupLogicalReplicationOnSourceDbIfNeeded?: LogicalReplicationOnSourceDbEnum;

  /**
   * Indicates whether the databases on the target server can be overwritten, if already present. If set to False, the migration workflow will wait for a confirmation, if it detects that the database already exists.
   */
  overwriteDbsInTarget?: OverwriteDbsInTargetEnum;

  /**
   * Start time in UTC for migration window
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  migrationWindowStartTimeInUtc?: utcDateTime;

  /**
   * To migrate roles and permissions we need to send this flag as True
   */
  migrateRoles?: MigrateRolesEnum;

  /**
   * Indicates whether the data migration should start right away
   */
  startDataMigration?: StartDataMigrationEnum;

  /**
   * To trigger cutover for entire migration we need to send this flag as True
   */
  triggerCutover?: TriggerCutoverEnum;

  /**
   * When you want to trigger cutover for specific databases send triggerCutover flag as True and database names in this array
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  dbsToTriggerCutoverOn?: string[];

  /**
   * To trigger cancel for entire migration we need to send this flag as True
   */
  cancel?: CancelEnum;

  /**
   * When you want to trigger cancel for specific databases send cancel flag as True and database names in this array
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  dbsToCancelMigrationOn?: string[];

  /**
   * There are two types of migration modes Online and Offline
   */
  migrationMode?: MigrationMode;
}

/**
 * Represents a migration name's availability.
 */
model MigrationNameAvailabilityResource {
  /**
   * The resource name to verify.
   */
  name: string;

  /**
   * The type of the resource.
   */
  type: string;

  /**
   * Indicates whether the resource name is available.
   */
  @visibility(Lifecycle.Read)
  nameAvailable?: boolean;

  /**
   * Migration name availability reason
   */
  @visibility(Lifecycle.Read)
  reason?: MigrationNameAvailabilityReason;

  /**
   * Migration name availability message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

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
   * The private link resource private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * Capability for the PostgreSQL server
 */
model QuotaUsagesListResult is Azure.Core.Page<QuotaUsage>;

/**
 * Quota usage for flexible servers
 */
model QuotaUsage {
  /**
   * Name of quota usage for flexible servers
   */
  name?: NameProperty;

  /**
   * Quota limit
   */
  limit?: int64;

  /**
   * Quota unit
   */
  unit?: string = "Count";

  /**
   * Current Quota usage value
   */
  currentValue?: int64;

  /**
   * Fully qualified ARM resource Id
   */
  id?: string;
}

/**
 * Name property for quota usage
 */
model NameProperty {
  /**
   * Name value
   */
  value?: string;

  /**
   * Localized name
   */
  localizedValue?: string;
}

/**
 * Represents a logFile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LogFile extends ProxyResource {
  /**
   * The properties of a logFile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: LogFileProperties;
}

/**
 * The properties of a logFile.
 */
model LogFileProperties {
  /**
   * Creation timestamp of the log file.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Last modified timestamp of the log file.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * The size in kb of the logFile.
   */
  sizeInKb?: int64;

  /**
   * Type of the log file.
   */
  type?: string;

  /**
   * The url to download the log file from.
   */
  url?: string;
}

/**
 * Represents server restart parameters.
 */
model RestartParameter {
  /**
   * Indicates whether to restart the server with failover.
   */
  restartWithFailover?: boolean;

  /**
   * Failover mode.
   */
  failoverMode?: FailoverMode;
}

/**
 * Properties of server Threat Protection state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ServerThreatProtectionProperties {
  /**
   * Specifies the state of the Threat Protection, whether it is enabled or disabled or a state has not been applied yet on the specific server.
   */
  state: ThreatProtectionState;

  /**
   * Specifies the UTC creation time of the policy.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

/**
 * Index recommendation properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model IndexRecommendationResource extends ProxyResource {
  /**
   * Properties of IndexRecommendationResource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: IndexRecommendationResourceProperties;
}

/**
 * Index recommendation properties.
 */
model IndexRecommendationResourceProperties {
  /**
   * Creation time of this recommendation in UTC date-time string format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  initialRecommendedTime?: utcDateTime;

  /**
   * The last refresh of this recommendation in UTC date-time string format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRecommendedTime?: utcDateTime;

  /**
   * The number of times this recommendation has encountered.
   */
  timesRecommended?: int32;

  /**
   * The ImprovedQueryIds. The list will only be populated for CREATE INDEX recommendations.
   */
  improvedQueryIds?: int64[];

  /**
   * Reason for this recommendation.
   */
  recommendationReason?: string;

  /**
   * Type for this recommendation.
   */
  recommendationType?: RecommendationTypeEnum;

  /**
   * Stores implementation details for the recommended action.
   */
  implementationDetails?: IndexRecommendationResourcePropertiesImplementationDetails;

  /**
   * Stores workload information for the recommended action.
   */
  analyzedWorkload?: IndexRecommendationResourcePropertiesAnalyzedWorkload;

  /**
   * The estimated impact of this recommended action
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["dimensionName"])
  estimatedImpact?: ImpactRecord[];

  /**
   * Stores recommendation details for the recommended action.
   */
  details?: IndexRecommendationDetails;
}

/**
 * Stores implementation details for the recommended action.
 */
model IndexRecommendationResourcePropertiesImplementationDetails {
  /**
   * Method of implementation for recommended action
   */
  method?: string;

  /**
   * Implementation script for the recommended action
   */
  script?: string;
}

/**
 * Stores workload information for the recommended action.
 */
model IndexRecommendationResourcePropertiesAnalyzedWorkload {
  /**
   * Workload start time in UTC date-time string format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Workload end time in UTC date-time string format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Workload query examined count. For DROP INDEX will be 0.
   */
  queryCount?: int32;
}

/**
 * Stores property that features impact on some metric if this recommended action is applied.
 */
model ImpactRecord {
  /**
   * Dimension name
   */
  dimensionName?: string;

  /**
   * Dimension unit
   */
  unit?: string;

  /**
   * Optional property that can be used to store the QueryId if the metric is for a specific query.
   */
  queryId?: int64;

  /**
   * Absolute value
   */
  absoluteValue?: float64;
}

/**
 * Recommendation details for the recommended action.
 */
model IndexRecommendationDetails {
  /**
   * Database name.
   */
  databaseName?: string;

  /**
   * Schema name.
   */
  schema?: string;

  /**
   * Table name.
   */
  table?: string;

  /**
   * Index type.
   */
  indexType?: string;

  /**
   * Index name.
   */
  indexName?: string;

  /**
   * Index columns. These will be semi-column separated.
   */
  indexColumns?: string;
}

/**
 * Represents a virtual endpoint for a server.
 */
model VirtualEndpointResourceForPatch {
  /**
   * Properties of the virtual endpoint resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualEndpointResourceProperties;
}

/**
 * The properties of a virtual endpoint.
 */
model VirtualEndpointResourceProperties {
  /**
   * The endpoint type for the virtual endpoint.
   */
  endpointType?: VirtualEndpointType;

  /**
   * List of members for a virtual endpoint
   */
  members?: string[];

  /**
   * List of virtual endpoints for a server
   */
  @visibility(Lifecycle.Read)
  virtualEndpoints?: string[];
}

/**
 * Virtual network subnet usage parameter
 */
model VirtualNetworkSubnetUsageParameter {
  /**
   * Virtual network resource id.
   */
  virtualNetworkArmResourceId?: string;
}

/**
 * Virtual network subnet usage data.
 */
model VirtualNetworkSubnetUsageResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["subnetName"])
  delegatedSubnetsUsage?: DelegatedSubnetUsage[];

  /**
   * location of the delegated subnet usage
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * subscriptionId of the delegated subnet usage
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;
}

/**
 * Delegated subnet usage data.
 */
model DelegatedSubnetUsage {
  /**
   * Name of the delegated subnet for which IP addresses are in use
   */
  @visibility(Lifecycle.Read)
  subnetName?: string;

  /**
   * Number of IP addresses used by the delegated subnet
   */
  @visibility(Lifecycle.Read)
  usage?: int64;
}
