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
 * Type of Microsoft Entra principal to which the server administrator is associated.
 */
union PrincipalType {
  string,

  /**
   * The principal type is not known or not specified.
   */
  Unknown: "Unknown",

  /**
   * A Microsoft Entra user.
   */
  User: "User",

  /**
   * A Microsoft Entra group.
   */
  Group: "Group",

  /**
   * A Microsoft Entra service principal, typically representing an application or service identity
   */
  ServicePrincipal: "ServicePrincipal",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ThreatProtectionName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
}

/**
 * Type of backup.
 */
union BackupType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Full: "Full",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Customer On-Demand`: "Customer On-Demand",
}

/**
 * Modes of high availability supported for this compute.
 */
union HighAvailabilityMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ZoneRedundant: "ZoneRedundant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SameZone: "SameZone",
}

/**
 * Modes of high availability supported for this compute.
 */
union PostgreSqlFlexibleServerHighAvailabilityMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ZoneRedundant: "ZoneRedundant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SameZone: "SameZone",
}

/**
 * Status of the feature. Indicates if the feature is enabled or not.
 */
union FeatureStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates if fast provisioning is supported. 'Enabled' means fast provisioning is supported. 'Disabled' stands for fast provisioning is not supported. Will be deprecated in the future. Look to Supported Features for 'FastProvisioning'.
 */
union FastProvisioningSupport {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates if geographically redundant backups are supported in this location. 'Enabled' means geographically redundant backups are supported. 'Disabled' stands for geographically redundant backup is not supported. Will be deprecated in the future. Look to Supported Features for 'GeoBackup'.
 */
union GeographicallyRedundantBackupSupport {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates if high availability with zone redundancy is supported in this location. 'Enabled' means high availability with zone redundancy is supported. 'Disabled' stands for high availability with zone redundancy is not supported. Will be deprecated in the future. Look to Supported Features for  'ZoneRedundantHa'.
 */
union ZoneRedundantHighAvailabilitySupport {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates if high availability with zone redundancy is supported in conjunction with geographically redundant backups in this location. 'Enabled' means high availability with zone redundancy is supported in conjunction with geographically redundant backups is supported. 'Disabled' stands for high availability with zone redundancy is supported in conjunction with geographically redundant backups is not supported. Will be deprecated in the future. Look to Supported Features for 'ZoneRedundantHaAndGeoBackup'.
 */
union ZoneRedundantHighAvailabilityAndGeographicallyRedundantBackupSupport {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates if storage autogrow is supported in this location. 'Enabled' means storage autogrow is supported. 'Disabled' stands for storage autogrow is not supported. Will be deprecated in the future. Look to Supported Features for 'StorageAutoGrowth'.
 */
union StorageAutoGrowthSupport {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates if resizing the storage, without interrupting the operation of the database engine, is supported in this location for the given subscription. 'Enabled' means resizing the storage without interrupting the operation of the database engine is supported. 'Disabled' means resizing the storage without interrupting the operation of the database engine is not supported. Will be deprecated in the future. Look to Supported Features for 'OnlineResize'.
 */
union OnlineStorageResizeSupport {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates if this location is restricted. 'Enabled' means location is restricted. 'Disabled' stands for location is not restricted. Will be deprecated in the future. Look to Supported Features for 'Restricted'.
 */
union LocationRestricted {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Data type of the configuration (also known as server parameter).
 */
union ConfigurationDataType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Boolean: "Boolean",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Numeric: "Numeric",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Integer: "Integer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enumeration: "Enumeration",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  String: "String",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Set: "Set",
}

/**
 * Service-set extensible enum indicating the status of operation
 */
union ExecutionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cancelled: "Cancelled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
}

/**
 * State of migration.
 */
union MigrationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WaitingForUserAction: "WaitingForUserAction",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ValidationFailed: "ValidationFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CleaningUp: "CleaningUp",
}

/**
 * Substate of migration.
 */
union MigrationSubstate {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PerformingPreRequisiteSteps: "PerformingPreRequisiteSteps",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WaitingForLogicalReplicationSetupRequestOnSourceDB: "WaitingForLogicalReplicationSetupRequestOnSourceDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WaitingForDBsToMigrateSpecification: "WaitingForDBsToMigrateSpecification",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WaitingForTargetDBOverwriteConfirmation: "WaitingForTargetDBOverwriteConfirmation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WaitingForDataMigrationScheduling: "WaitingForDataMigrationScheduling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WaitingForDataMigrationWindow: "WaitingForDataMigrationWindow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MigratingData: "MigratingData",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WaitingForCutoverTrigger: "WaitingForCutoverTrigger",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CompletingMigration: "CompletingMigration",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CancelingRequestedDBMigrations: "CancelingRequestedDBMigrations",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ValidationInProgress: "ValidationInProgress",
}

/**
 * Migration state of a database.
 */
union MigrationDatabaseState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WaitingForCutoverTrigger: "WaitingForCutoverTrigger",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceling: "Canceling",
}

/**
 * Validation status for migration.
 */
union ValidationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Warning: "Warning",
}

/**
 * Mode used to perform the migration: Online or Offline.
 */
union MigrationMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Offline: "Offline",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Online: "Online",
}

/**
 * Supported option for a migration
 */
union MigrationOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Validate: "Validate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Migrate: "Migrate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ValidateAndMigrate: "ValidateAndMigrate",
}

/**
 * Source server type used for the migration: ApsaraDB_RDS, AWS, AWS_AURORA, AWS_EC2, AWS_RDS, AzureVM, Crunchy_PostgreSQL, Digital_Ocean_Droplets, Digital_Ocean_PostgreSQL, EDB, EDB_Oracle_Server, EDB_PostgreSQL, GCP, GCP_AlloyDB, GCP_CloudSQL, GCP_Compute, Heroku_PostgreSQL, Huawei_Compute, Huawei_RDS, OnPremises, PostgreSQLCosmosDB, PostgreSQLFlexibleServer, PostgreSQLSingleServer, or Supabase_PostgreSQL
 */
union SourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OnPremises: "OnPremises",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AWS: "AWS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GCP: "GCP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureVM: "AzureVM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PostgreSQLSingleServer: "PostgreSQLSingleServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AWS_RDS: "AWS_RDS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AWS_AURORA: "AWS_AURORA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AWS_EC2: "AWS_EC2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GCP_CloudSQL: "GCP_CloudSQL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GCP_AlloyDB: "GCP_AlloyDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GCP_Compute: "GCP_Compute",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  EDB: "EDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  EDB_Oracle_Server: "EDB_Oracle_Server",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  EDB_PostgreSQL: "EDB_PostgreSQL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PostgreSQLFlexibleServer: "PostgreSQLFlexibleServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PostgreSQLCosmosDB: "PostgreSQLCosmosDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Huawei_RDS: "Huawei_RDS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Huawei_Compute: "Huawei_Compute",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Heroku_PostgreSQL: "Heroku_PostgreSQL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Crunchy_PostgreSQL: "Crunchy_PostgreSQL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ApsaraDB_RDS: "ApsaraDB_RDS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Digital_Ocean_Droplets: "Digital_Ocean_Droplets",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Digital_Ocean_PostgreSQL: "Digital_Ocean_PostgreSQL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Supabase_PostgreSQL: "Supabase_PostgreSQL",
}

/**
 * SSL mode used by a migration. Default SSL mode for 'PostgreSQLSingleServer' is 'VerifyFull'. Default SSL mode for other source types is 'Prefer'.
 */
union SslMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Prefer: "Prefer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Require: "Require",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VerifyCA: "VerifyCA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VerifyFull: "VerifyFull",
}

/**
 * Tier of the compute assigned to a server.
 */
union SkuTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Burstable: "Burstable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GeneralPurpose: "GeneralPurpose",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MemoryOptimized: "MemoryOptimized",
}

/**
 * Indicates whether to setup logical replication on source server, if needed.
 */
union LogicalReplicationOnSourceServer {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * Indicates if databases on the target server can be overwritten when already present. If set to 'False', when the migration workflow detects that the database already exists on the target server, it will wait for a confirmation.
 */
union OverwriteDatabasesOnTargetServer {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * Indicates if roles and permissions must be migrated.
 */
union MigrateRolesAndPermissions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * Indicates if data migration must start right away.
 */
union StartDataMigration {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * Indicates if cutover must be triggered for the entire migration.
 */
union TriggerCutover {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * Indicates if cancel must be triggered for the entire migration.
 */
union Cancel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union MigrationListFilter {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  All: "All",
}

/**
 * Migration name availability reason.
 */
union MigrationNameAvailabilityReason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AlreadyExists: "AlreadyExists",
}

/**
 * The reason why the given name is not available.
 */
union CheckNameAvailabilityReason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AlreadyExists: "AlreadyExists",
}

/**
 * Intended executor of the operation.
 */
union OperationOrigin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  system: "system",
}

/**
 * Types of identities associated with a server.
 */
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * Major version of PostgreSQL database engine.
 */
union PostgresMajorVersion {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `18`: "18",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `17`: "17",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `16`: "16",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `15`: "15",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `14`: "14",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `13`: "13",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `12`: "12",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `11`: "11",
}

/**
 * Possible states of a server.
 */
union ServerState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ready: "Ready",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Dropping: "Dropping",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Starting: "Starting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stopping: "Stopping",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Restarting: "Restarting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Inaccessible: "Inaccessible",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
}

/**
 * Flag to enable or disable the automatic growth of storage size of a server when available space is nearing zero and conditions allow for automatically growing storage size.
 */
union StorageAutoGrow {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Storage tier of a server.
 */
union AzureManagedDiskPerformanceTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P1: "P1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P2: "P2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P3: "P3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P4: "P4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P6: "P6",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P10: "P10",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P15: "P15",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P20: "P20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P30: "P30",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P40: "P40",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P50: "P50",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P60: "P60",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P70: "P70",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P80: "P80",
}

/**
 * Type of storage assigned to a server. Allowed values are Premium_LRS, PremiumV2_LRS, or UltraSSD_LRS. If not specified, it defaults to Premium_LRS.
 */
union StorageType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Premium_LRS: "Premium_LRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PremiumV2_LRS: "PremiumV2_LRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UltraSSD_LRS: "UltraSSD_LRS",
}

/**
 * Indicates if the server supports Microsoft Entra authentication.
 */
union MicrosoftEntraAuth {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates if the server supports password based authentication.
 */
union PasswordBasedAuth {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Data encryption type used by a server.
 */
union DataEncryptionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemManaged: "SystemManaged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureKeyVault: "AzureKeyVault",
}

/**
 * Status of key used by a server configured with data encryption based on customer managed key, to encrypt the primary storage associated to the server.
 */
union EncryptionKeyStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Valid: "Valid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
}

/**
 * Indicates if the server is configured to create geographically redundant backups.
 */
union GeographicallyRedundantBackup {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates if public network access is enabled or not.
 */
union ServerPublicNetworkAccessState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Possible states of the standby server created when high availability is set to SameZone or ZoneRedundant.
 */
union HighAvailabilityState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotEnabled: "NotEnabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CreatingStandby: "CreatingStandby",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReplicatingData: "ReplicatingData",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FailingOver: "FailingOver",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Healthy: "Healthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RemovingStandby: "RemovingStandby",
}

/**
 * Role of the server in a replication set.
 */
union ReplicationRole {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Primary: "Primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AsyncReplica: "AsyncReplica",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GeoAsyncReplica: "GeoAsyncReplica",
}

/**
 * Indicates the replication state of a read replica. This property is returned only when the target server is a read replica. Possible  values are Active, Broken, Catchup, Provisioning, Reconfiguring, and Updating
 */
union ReplicationState {
  string,

  /**
   * The read replica server is fully synchronized and actively replicating data from the primary server.
   */
  Active: "Active",

  /**
   * The read replica server is behind the primary server and is currently catching up with pending changes.
   */
  Catchup: "Catchup",

  /**
   * The read replica server is being created and is in process of getting initialized.
   */
  Provisioning: "Provisioning",

  /**
   * The read replica server is undergoing some changes it can be changing compute size of promoting it to primary server.
   */
  Updating: "Updating",

  /**
   * Replication has failed or been interrupted.
   */
  Broken: "Broken",

  /**
   * The read replica server is being reconfigured, possibly due to changes in source or settings.
   */
  Reconfiguring: "Reconfiguring",
}

/**
 * Type of operation to apply on the read replica. This property is write only. Standalone means that the read replica will be promoted to a standalone server, and will become a completely independent entity from the replication set. Switchover means that the read replica will roles with the primary server.
 */
union ReadReplicaPromoteMode {
  string,

  /**
   * Read replica will become an independent server.
   */
  Standalone: "Standalone",

  /**
   * Read replica will swap roles with primary server.
   */
  Switchover: "Switchover",
}

/**
 * Data synchronization option to use when processing the operation specified in the promoteMode property. This property is write only.
 */
union ReadReplicaPromoteOption {
  string,

  /**
   * The operation will wait for data in the read replica to be fully synchronized with its source server, before it initiates the operation.
   */
  Planned: "Planned",

  /**
   * The operation will not wait for data in the read replica to be synchronized with its source server, before it initiates the operation.
   */
  Forced: "Forced",
}

/**
 * Creation mode of a new server.
 */
union CreateMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Create: "Create",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Update: "Update",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PointInTimeRestore: "PointInTimeRestore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GeoRestore: "GeoRestore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Replica: "Replica",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReviveDropped: "ReviveDropped",
}

/**
 * Update mode of an existing server.
 */
union CreateModeForPatch {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Update: "Update",
}

/**
 * Failover mode.
 */
union FailoverMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PlannedFailover: "PlannedFailover",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ForcedFailover: "ForcedFailover",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PlannedSwitchover: "PlannedSwitchover",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ForcedSwitchover: "ForcedSwitchover",
}

/**
 * The name of the tuning option.
 */
union TuningOptionParameterEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  index: "index",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  table: "table",
}

/**
 * Type for this recommendation.
 */
union RecommendationTypeEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CreateIndex: "CreateIndex",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DropIndex: "DropIndex",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReIndex: "ReIndex",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AnalyzeTable: "AnalyzeTable",
}

/**
 * Recommendations list filter. Retrieves recommendations based on type.
 */
union RecommendationTypeParameterEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CreateIndex: "CreateIndex",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DropIndex: "DropIndex",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReIndex: "ReIndex",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AnalyzeTable: "AnalyzeTable",
}

/**
 * Type of endpoint for the virtual endpoints.
 */
union VirtualEndpointType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReadWrite: "ReadWrite",
}

/**
 * Level of details of a migration.
 */
union MigrationDetailsLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Summary: "Summary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Full: "Full",
}

/**
 * Specifies the state of the advanced threat protection, whether it is enabled, disabled, or a state has not been applied yet on the server.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ThreatProtectionState {
  Enabled,
  Disabled,
}

/**
 * The status of the capability.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CapabilityStatus {
  Visible,
  Available,
  Default,
  Disabled,
}

/**
 * Server administrator associated to a Microsoft Entra principal.
 */
model AdministratorMicrosoftEntraAdd {
  /**
   * Properties of the server administrator associated to a Microsoft Entra principal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: AdministratorMicrosoftEntraPropertiesForAdd;
}

/**
 * Properties of a server administrator associated to a Microsoft Entra principal.
 */
model AdministratorMicrosoftEntraPropertiesForAdd {
  /**
   * Type of Microsoft Entra principal to which the server administrator is associated.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  principalType?: PrincipalType;

  /**
   * Name of the Microsoft Entra principal.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  principalName?: string;

  /**
   * Identifier of the tenant in which the Microsoft Entra principal exists.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  tenantId?: string;
}

/**
 * Properties of a server administrator associated to a Microsoft Entra principal.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AdministratorMicrosoftEntraProperties {
  /**
   * Type of Microsoft Entra principal to which the server administrator is associated.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  principalType?: PrincipalType;

  /**
   * Name of the Microsoft Entra principal.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  principalName?: string;

  /**
   * Object identifier of the Microsoft Entra principal.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  objectId?: string;

  /**
   * Identifier of the tenant in which the Microsoft Entra principal exists.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tenantId?: string;
}

/**
 * List of server administrators associated to Microsoft Entra principals.
 */
model AdministratorMicrosoftEntraList
  is Azure.Core.Page<AdministratorMicrosoftEntra>;

/**
 * List of advanced threat protection settings for a server.
 */
model AdvancedThreatProtectionSettingsList
  is Azure.Core.Page<AdvancedThreatProtectionSettingsModel>;

/**
 * Properties of advanced threat protection state for a server.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AdvancedThreatProtectionSettingsProperties {
  /**
   * Specifies the state of the advanced threat protection, whether it is enabled, disabled, or a state has not been applied yet on the server.
   */
  state: ThreatProtectionState;

  /**
   * Specifies the creation time (UTC) of the policy.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

/**
 * Properties of a backup.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupAutomaticAndOnDemandProperties {
  /**
   * Type of backup.
   */
  backupType?: BackupType;

  /**
   * Time(ISO8601 format) at which the backup was completed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completedTime?: utcDateTime;

  /**
   * Source of the backup.
   */
  source?: string;
}

/**
 * List of backups.
 */
model BackupAutomaticAndOnDemandList
  is Azure.Core.Page<BackupAutomaticAndOnDemand>;

/**
 * List of capabilities for the Azure Database for PostgreSQL flexible server.
 */
model CapabilityList is Azure.Core.Page<Capability>;

/**
 * Capability for the Azure Database for PostgreSQL flexible server.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Capability extends CapabilityBase {
  /**
   * Name of flexible servers capabilities.
   */
  name?: string;

  /**
   * List of supported compute tiers.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedServerEditions?: ServerEditionCapability[];

  /**
   * List of supported major versions of PostgreSQL database engine.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedServerVersions?: ServerVersionCapability[];

  /**
   * Features supported.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedFeatures?: SupportedFeature[];

  /**
   * Indicates if fast provisioning is supported. 'Enabled' means fast provisioning is supported. 'Disabled' stands for fast provisioning is not supported. Will be deprecated in the future. Look to Supported Features for 'FastProvisioning'.
   */
  @visibility(Lifecycle.Read)
  fastProvisioningSupported?: FastProvisioningSupport;

  /**
   * List of compute tiers supporting fast provisioning.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["supportedSku"])
  supportedFastProvisioningEditions?: FastProvisioningEditionCapability[];

  /**
   * Indicates if geographically redundant backups are supported in this location. 'Enabled' means geographically redundant backups are supported. 'Disabled' stands for geographically redundant backup is not supported. Will be deprecated in the future. Look to Supported Features for 'GeoBackup'.
   */
  @visibility(Lifecycle.Read)
  geoBackupSupported?: GeographicallyRedundantBackupSupport;

  /**
   * Indicates if high availability with zone redundancy is supported in this location. 'Enabled' means high availability with zone redundancy is supported. 'Disabled' stands for high availability with zone redundancy is not supported. Will be deprecated in the future. Look to Supported Features for  'ZoneRedundantHa'.
   */
  @visibility(Lifecycle.Read)
  zoneRedundantHaSupported?: ZoneRedundantHighAvailabilitySupport;

  /**
   * Indicates if high availability with zone redundancy is supported in conjunction with geographically redundant backups in this location. 'Enabled' means high availability with zone redundancy is supported in conjunction with geographically redundant backups is supported. 'Disabled' stands for high availability with zone redundancy is supported in conjunction with geographically redundant backups is not supported. Will be deprecated in the future. Look to Supported Features for 'ZoneRedundantHaAndGeoBackup'.
   */
  @visibility(Lifecycle.Read)
  zoneRedundantHaAndGeoBackupSupported?: ZoneRedundantHighAvailabilityAndGeographicallyRedundantBackupSupport;

  /**
   * Indicates if storage autogrow is supported in this location. 'Enabled' means storage autogrow is supported. 'Disabled' stands for storage autogrow is not supported. Will be deprecated in the future. Look to Supported Features for 'StorageAutoGrowth'.
   */
  @visibility(Lifecycle.Read)
  storageAutoGrowthSupported?: StorageAutoGrowthSupport;

  /**
   * Indicates if resizing the storage, without interrupting the operation of the database engine, is supported in this location for the given subscription. 'Enabled' means resizing the storage without interrupting the operation of the database engine is supported. 'Disabled' means resizing the storage without interrupting the operation of the database engine is not supported. Will be deprecated in the future. Look to Supported Features for 'OnlineResize'.
   */
  @visibility(Lifecycle.Read)
  onlineResizeSupported?: OnlineStorageResizeSupport;

  /**
   * Indicates if this location is restricted. 'Enabled' means location is restricted. 'Disabled' stands for location is not restricted. Will be deprecated in the future. Look to Supported Features for 'Restricted'.
   */
  @visibility(Lifecycle.Read)
  restricted?: LocationRestricted;
}

/**
 * Capabilities in terms of compute tier.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerEditionCapability extends CapabilityBase {
  /**
   * Name of compute tier.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Default compute name (SKU) for this computer tier.
   */
  @visibility(Lifecycle.Read)
  defaultSkuName?: string;

  /**
   * List of storage editions supported by this compute tier and compute name.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedStorageEditions?: StorageEditionCapability[];

  /**
   * List of supported compute names (SKUs).
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedServerSkus?: ServerSkuCapability[];
}

/**
 * Capabilities in terms of storage tier.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageEditionCapability extends CapabilityBase {
  /**
   * Name of storage tier.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Default storage size (in MB) for this storage tier.
   */
  @visibility(Lifecycle.Read)
  defaultStorageSizeMb?: int64;

  /**
   * Configurations of storage supported for this storage tier.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["storageSizeMb"])
  supportedStorageMb?: StorageMbCapability[];
}

/**
 * Storage size (in MB) capability.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageMbCapability extends CapabilityBase {
  /**
   * Minimum IOPS supported by the storage size.
   */
  @visibility(Lifecycle.Read)
  supportedIops?: int32;

  /**
   * Maximum IOPS supported by the storage size.
   */
  @visibility(Lifecycle.Read)
  supportedMaximumIops?: int32;

  /**
   * Minimum supported size (in MB) of storage.
   */
  @visibility(Lifecycle.Read)
  storageSizeMb?: int64;

  /**
   * Maximum supported size (in MB) of storage.
   */
  @visibility(Lifecycle.Read)
  maximumStorageSizeMb?: int64;

  /**
   * Minimum supported throughput (in MB/s) of storage.
   */
  @visibility(Lifecycle.Read)
  supportedThroughput?: int32;

  /**
   * Maximum supported throughput (in MB/s) of storage.
   */
  @visibility(Lifecycle.Read)
  supportedMaximumThroughput?: int32;

  /**
   * Default IOPS for this tier and storage size.
   */
  @visibility(Lifecycle.Read)
  defaultIopsTier?: string;

  /**
   * List of all supported storage tiers for this tier and storage size.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedIopsTiers?: StorageTierCapability[];
}

/**
 * Capability of a storage tier.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageTierCapability extends CapabilityBase {
  /**
   * Name of the storage tier.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Supported IOPS for the storage tier.
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
 * Capabilities in terms of compute.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerSkuCapability extends CapabilityBase {
  /**
   * Name of the compute (SKU).
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * vCores available for this compute.
   */
  @visibility(Lifecycle.Read)
  vCores?: int32;

  /**
   * Maximum IOPS supported by this compute.
   */
  @visibility(Lifecycle.Read)
  supportedIops?: int32;

  /**
   * Supported memory (in MB) per virtual core assigned to this compute.
   */
  @visibility(Lifecycle.Read)
  supportedMemoryPerVcoreMb?: int64;

  /**
   * List of supported availability zones. E.g. '1', '2', '3'
   */
  @visibility(Lifecycle.Read)
  supportedZones?: string[];

  /**
   * Modes of high availability supported for this compute.
   */
  @visibility(Lifecycle.Read)
  supportedHaMode?: HighAvailabilityMode[];

  /**
   * Features supported.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedFeatures?: SupportedFeature[];

  /**
   * Security profile of the compute. Indicates if it's a Confidential Compute virtual machine.
   */
  @visibility(Lifecycle.Read)
  securityProfile?: string;
}

/**
 * Features supported.
 */
model SupportedFeature {
  /**
   * Name of the feature.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Status of the feature. Indicates if the feature is enabled or not.
   */
  @visibility(Lifecycle.Read)
  status?: FeatureStatus;
}

/**
 * Capabilities in terms of major versions of PostgreSQL database engine.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerVersionCapability extends CapabilityBase {
  /**
   * Major version of PostgreSQL database engine.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Major versions of PostgreSQL database engine to which this version can be automatically upgraded.
   */
  @visibility(Lifecycle.Read)
  supportedVersionsToUpgrade?: string[];

  /**
   * Features supported.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedFeatures?: SupportedFeature[];
}

/**
 * Capability of a fast provisioning compute tier.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FastProvisioningEditionCapability extends CapabilityBase {
  /**
   * Compute tier supporting fast provisioning.
   */
  @visibility(Lifecycle.Read)
  supportedTier?: string;

  /**
   * Compute name (SKU) supporting fast provisioning.
   */
  @visibility(Lifecycle.Read)
  supportedSku?: string;

  /**
   * Storage size (in GB) supporting fast provisioning.
   */
  @visibility(Lifecycle.Read)
  supportedStorageGb?: int32;

  /**
   * Major version of PostgreSQL database engine supporting fast provisioning.
   */
  @visibility(Lifecycle.Read)
  supportedServerVersions?: string;

  /**
   * Count of servers in cache matching this specification.
   */
  @visibility(Lifecycle.Read)
  serverCount?: int32;
}

/**
 * List of log files.
 */
model CapturedLogList is Azure.Core.Page<CapturedLog>;

/**
 * Log file.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CapturedLog extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Properties of a log file.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: CapturedLogProperties;
}

/**
 * Properties of a log file.
 */
model CapturedLogProperties {
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
   * Size (in KB) of the log file.
   */
  sizeInKb?: int64;

  /**
   * Type of log file. Can be 'ServerLogs' or 'UpgradeLogs'.
   */
  type?: string;

  /**
   * URL to download the log file from.
   */
  url?: string;
}

/**
 * List of configurations (also known as server parameters).
 */
model ConfigurationList is Azure.Core.Page<Configuration>;

/**
 * Properties of a configuration (also known as server parameter).
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConfigurationProperties {
  /**
   * Value of the configuration (also known as server parameter). Required to update the value assigned to a specific modifiable configuration.
   */
  value?: string;

  /**
   * Description of the configuration (also known as server parameter).
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Value assigned by default to the configuration (also known as server parameter).
   */
  @visibility(Lifecycle.Read)
  defaultValue?: string;

  /**
   * Data type of the configuration (also known as server parameter).
   */
  @visibility(Lifecycle.Read)
  dataType?: ConfigurationDataType;

  /**
   * Allowed values of the configuration (also known as server parameter).
   */
  @visibility(Lifecycle.Read)
  allowedValues?: string;

  /**
   * Source of the value assigned to the configuration (also known as server parameter). Required to update the value assigned to a specific modifiable configuration.
   */
  source?: string;

  /**
   * Indicates if it's a dynamic (true) or static (false) configuration (also known as server parameter). Static server parameters require a server restart after changing the value assigned to them, for the change to take effect. Dynamic server parameters do not require a server restart after changing the value assigned to them, for the change to take effect.
   */
  @visibility(Lifecycle.Read)
  isDynamicConfig?: boolean;

  /**
   * Indicates if it's a read-only (true) or modifiable (false) configuration (also known as server parameter).
   */
  @visibility(Lifecycle.Read)
  isReadOnly?: boolean;

  /**
   * Indicates if the value assigned to the configuration (also known as server parameter) is pending a server restart for it to take effect.
   */
  @visibility(Lifecycle.Read)
  isConfigPendingRestart?: boolean;

  /**
   * Units in which the configuration (also known as server parameter) value is expressed.
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * Link pointing to the documentation of the configuration (also known as server parameter).
   */
  @visibility(Lifecycle.Read)
  documentationLink?: string;
}

/**
 * Configuration (also known as server parameter).
 */
model ConfigurationForUpdate {
  /**
   * Properties of a configuration (also known as server parameter).
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ConfigurationProperties;
}

/**
 * Properties of a database.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseProperties {
  /**
   * Character set of the database.
   */
  @pattern("^[a-zA-Z]+\\w*$")
  charset?: string;

  /**
   * Collation of the database.
   */
  @pattern("^[a-zA-Z\\-]+([. ]|\\w)*$")
  collation?: string;
}

/**
 * List of all databases in a server.
 */
model DatabaseList is Azure.Core.Page<Database>;

/**
 * Properties of a firewall rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FirewallRuleProperties {
  /**
   * IP address defining the start of the range of addresses of a firewall rule. Must be expressed in IPv4 format.
   */
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  startIpAddress: string;

  /**
   * IP address defining the end of the range of addresses of a firewall rule. Must be expressed in IPv4 format.
   */
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")
  endIpAddress: string;
}

/**
 * List of firewall rules.
 */
model FirewallRuleList is Azure.Core.Page<FirewallRule>;

/**
 * A request that is made for pre-backup.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties: BackupsLongTermRetentionResponseProperties;
}

/**
 * Response for the pre-backup request.
 */
model BackupsLongTermRetentionResponseProperties {
  /**
   * Number of storage containers the plugin will use during backup. More than one containers may be used for size limitations, parallelism, or redundancy etc.
   */
  numberOfContainers: int32;
}

/**
 * The request that is made for a long term retention backup.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupsLongTermRetentionRequest extends BackupRequestBase {
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
  sasUriList: secretString[];
}

/**
 * Response for the LTR backup API call
 */
model BackupsLongTermRetentionResponse {
  /**
   * Long Term Retention Backup Operation Resource Properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: LtrBackupOperationResponseProperties;
}

/**
 * Response for the backup request.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @minValue(0)
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
model LtrServerBackupOperationList
  is Azure.Core.Page<BackupsLongTermRetentionOperation>;

/**
 * Migration.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrationProperties {
  /**
   * Identifier of a migration.
   */
  @visibility(Lifecycle.Read)
  migrationId?: string;

  /**
   * Current status of a migration.
   */
  @visibility(Lifecycle.Read)
  currentStatus?: MigrationStatus;

  /**
   * Identifier of the private endpoint migration instance.
   */
  migrationInstanceResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Mode used to perform the migration: Online or Offline.
   */
  migrationMode?: MigrationMode;

  /**
   * Supported option for a migration.
   */
  migrationOption?: MigrationOption;

  /**
   * Source server type used for the migration: ApsaraDB_RDS, AWS, AWS_AURORA, AWS_EC2, AWS_RDS, AzureVM, Crunchy_PostgreSQL, Digital_Ocean_Droplets, Digital_Ocean_PostgreSQL, EDB, EDB_Oracle_Server, EDB_PostgreSQL, GCP, GCP_AlloyDB, GCP_CloudSQL, GCP_Compute, Heroku_PostgreSQL, Huawei_Compute, Huawei_RDS, OnPremises, PostgreSQLCosmosDB, PostgreSQLFlexibleServer, PostgreSQLSingleServer, or Supabase_PostgreSQL
   */
  sourceType?: SourceType;

  /**
   * SSL mode used by a migration. Default SSL mode for 'PostgreSQLSingleServer' is 'VerifyFull'. Default SSL mode for other source types is 'Prefer'.
   */
  sslMode?: SslMode;

  /**
   * Metadata of source database server.
   */
  @visibility(Lifecycle.Read)
  sourceDbServerMetadata?: DbServerMetadata;

  /**
   * Metadata of target database server.
   */
  @visibility(Lifecycle.Read)
  targetDbServerMetadata?: DbServerMetadata;

  @doc("Identifier of the source database server resource, when 'sourceType' is 'PostgreSQLSingleServer'. For other source types this must be set to ipaddress:port@username or hostname:port@username.")
  sourceDbServerResourceId?: string;

  /**
   * Fully qualified domain name (FQDN) or IP address of the source server. This property is optional. When provided, the migration service will always use it to connect to the source server.
   */
  sourceDbServerFullyQualifiedDomainName?: string;

  /**
   * Identifier of the target database server resource.
   */
  @visibility(Lifecycle.Read)
  targetDbServerResourceId?: string;

  /**
   * Fully qualified domain name (FQDN) or IP address of the target server. This property is optional. When provided, the migration service will always use it to connect to the target server.
   */
  targetDbServerFullyQualifiedDomainName?: string;

  /**
   * Migration secret parameters.
   */
  secretParameters?: MigrationSecretParameters;

  /**
   * Names of databases to migrate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  @maxItems(50)
  dbsToMigrate?: string[];

  /**
   * Indicates whether to setup logical replication on source server, if needed.
   */
  setupLogicalReplicationOnSourceDbIfNeeded?: LogicalReplicationOnSourceServer;

  /**
   * Indicates if databases on the target server can be overwritten when already present. If set to 'False', when the migration workflow detects that the database already exists on the target server, it will wait for a confirmation.
   */
  overwriteDbsInTarget?: OverwriteDatabasesOnTargetServer;

  /**
   * Start time (UTC) for migration window.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  migrationWindowStartTimeInUtc?: utcDateTime;

  /**
   * End time (UTC) for migration window.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  migrationWindowEndTimeInUtc?: utcDateTime;

  /**
   * Indicates if roles and permissions must be migrated.
   */
  migrateRoles?: MigrateRolesAndPermissions;

  /**
   * Indicates if data migration must start right away.
   */
  startDataMigration?: StartDataMigration;

  /**
   * Indicates if cutover must be triggered for the entire migration.
   */
  triggerCutover?: TriggerCutover;

  /**
   * When you want to trigger cutover for specific databases set 'triggerCutover' to 'True' and the names of the specific databases in this array.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  dbsToTriggerCutoverOn?: string[];

  /**
   * Indicates if cancel must be triggered for the entire migration.
   */
  cancel?: Cancel;

  /**
   * When you want to trigger cancel for specific databases set 'triggerCutover' to 'True' and the names of the specific databases in this array.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  dbsToCancelMigrationOn?: string[];
}

/**
 * State of migration.
 */
model MigrationStatus {
  /**
   * State of migration.
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Error message, if any, for the migration state.
   */
  @visibility(Lifecycle.Read)
  error?: string;

  /**
   * Current migration sub state details.
   */
  @visibility(Lifecycle.Read)
  currentSubStateDetails?: MigrationSubstateDetails;
}

/**
 * Details of migration substate.
 */
model MigrationSubstateDetails {
  /**
   * Substate of migration.
   */
  @visibility(Lifecycle.Read)
  currentSubState?: MigrationSubstate;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dbDetails?: Record<DatabaseMigrationState>;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validationDetails?: ValidationDetails;
}

/**
 * Migration state of a database.
 */
model DatabaseMigrationState {
  /**
   * Name of database.
   */
  databaseName?: string;

  /**
   * Migration state of a database.
   */
  migrationState?: MigrationDatabaseState;

  /**
   * Migration operation of a database.
   */
  migrationOperation?: string;

  /**
   * Start time of a migration state.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * End time of a migration state.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Number of tables queued for the migration of a database.
   */
  fullLoadQueuedTables?: int32;

  /**
   * Number of tables encountering errors during the migration of a database.
   */
  fullLoadErroredTables?: int32;

  /**
   * Number of tables loading during the migration of a database.
   */
  fullLoadLoadingTables?: int32;

  /**
   * Number of tables loaded during the migration of a database.
   */
  fullLoadCompletedTables?: int32;

  /**
   * Change Data Capture update counter.
   */
  cdcUpdateCounter?: int32;

  /**
   * Change Data Capture delete counter.
   */
  cdcDeleteCounter?: int32;

  /**
   * Change Data Capture insert counter.
   */
  cdcInsertCounter?: int32;

  /**
   * Change Data Capture applied changes counter.
   */
  appliedChanges?: int32;

  /**
   * Change Data Capture incoming changes counter.
   */
  incomingChanges?: int32;

  /**
   * Lag in seconds between source and target during online phase.
   */
  latency?: int32;

  /**
   * Error message, if any, for the migration state.
   */
  message?: string;
}

/**
 * Details for the validation for migration.
 */
model ValidationDetails {
  /**
   * Validation status for migration.
   */
  status?: ValidationState;

  /**
   * Start time (UTC) for validation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validationStartTimeInUtc?: utcDateTime;

  /**
   * End time (UTC) for validation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validationEndTimeInUtc?: utcDateTime;

  /**
   * Details of server level validations.
   */
  @identifiers(#[])
  serverLevelValidationDetails?: ValidationSummaryItem[];

  /**
   * Details of server level validations.
   */
  @identifiers(#["databaseName"])
  dbLevelValidationDetails?: DbLevelValidationStatus[];
}

/**
 * Validation summary object.
 */
model ValidationSummaryItem {
  /**
   * Validation type.
   */
  type?: string;

  /**
   * Validation status for migration.
   */
  state?: ValidationState;

  /**
   * Validation messages.
   */
  @identifiers(#[])
  messages?: ValidationMessage[];
}

/**
 * Validation message object.
 */
model ValidationMessage {
  /**
   * Severity of validation message.
   */
  state?: ValidationState;

  /**
   * Validation message string.
   */
  message?: string;
}

/**
 * Validation status summary for a database.
 */
model DbLevelValidationStatus {
  /**
   * Name of database.
   */
  databaseName?: string;

  /**
   * Start time of a database level validation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * End time of a database level validation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Summary of database level validations.
   */
  @identifiers(#[])
  summary?: ValidationSummaryItem[];
}

/**
 * Database server metadata.
 */
model DbServerMetadata {
  /**
   * Location of database server.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Major version of PostgreSQL database engine.
   */
  version?: string;

  /**
   * Storage size (in MB) for database server.
   */
  storageMb?: int32;

  /**
   * Compute tier and size of the database server. This object is empty for an Azure Database for PostgreSQL single server.
   */
  sku?: ServerSku;
}

/**
 * Compute information of a server.
 */
model ServerSku {
  /**
   * Compute tier and size of the database server. This object is empty for an Azure Database for PostgreSQL single server.
   */
  name?: string;

  /**
   * Tier of the compute assigned to a server.
   */
  tier?: SkuTier;
}

/**
 * Migration secret parameters.
 */
model MigrationSecretParameters {
  /**
   * Credentials of administrator users for source and target servers.
   */
  @secret
  adminCredentials: AdminCredentials;

  /**
   * Gets or sets the name of the user for the source server. This user doesn't need to be an administrator.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  sourceServerUsername?: string;

  /**
   * Gets or sets the name of the user for the target server. This user doesn't need to be an administrator.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  targetServerUsername?: string;
}

/**
 * Credentials of administrator users for source and target servers.
 */
model AdminCredentials {
  /**
   * Password for the user of the source server.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  sourceServerPassword: string;

  /**
   * Password for the user of the target server.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  targetServerPassword: string;
}

/**
 * Migration.
 */
model MigrationResourceForPatch {
  /**
   * Migration properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: MigrationPropertiesForPatch;

  /**
   * Application-specific metadata in the form of key-value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Migration properties.
 */
model MigrationPropertiesForPatch {
  @doc("Identifier of the source database server resource, when 'sourceType' is 'PostgreSQLSingleServer'. For other source types this must be set to ipaddress:port@username or hostname:port@username.")
  sourceDbServerResourceId?: string;

  /**
   * Fully qualified domain name (FQDN) or IP address of the source server. This property is optional. When provided, the migration service will always use it to connect to the source server.
   */
  sourceDbServerFullyQualifiedDomainName?: string;

  /**
   * Fully qualified domain name (FQDN) or IP address of the target server. This property is optional. When provided, the migration service will always use it to connect to the target server.
   */
  targetDbServerFullyQualifiedDomainName?: string;

  /**
   * Migration secret parameters.
   */
  secretParameters?: MigrationSecretParametersForPatch;

  /**
   * Names of databases to migrate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  @maxItems(50)
  dbsToMigrate?: string[];

  /**
   * Indicates whether to setup logical replication on source server, if needed.
   */
  setupLogicalReplicationOnSourceDbIfNeeded?: LogicalReplicationOnSourceServer;

  /**
   * Indicates if databases on the target server can be overwritten when already present. If set to 'False', when the migration workflow detects that the database already exists on the target server, it will wait for a confirmation.
   */
  overwriteDbsInTarget?: OverwriteDatabasesOnTargetServer;

  /**
   * Start time (UTC) for migration window.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  migrationWindowStartTimeInUtc?: utcDateTime;

  /**
   * Indicates if roles and permissions must be migrated.
   */
  migrateRoles?: MigrateRolesAndPermissions;

  /**
   * Indicates if data migration must start right away.
   */
  startDataMigration?: StartDataMigration;

  /**
   * Indicates if cutover must be triggered for the entire migration.
   */
  triggerCutover?: TriggerCutover;

  /**
   * When you want to trigger cutover for specific databases set 'triggerCutover' to 'True' and the names of the specific databases in this array.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  dbsToTriggerCutoverOn?: string[];

  /**
   * Indicates if cancel must be triggered for the entire migration.
   */
  cancel?: Cancel;

  /**
   * When you want to trigger cancel for specific databases set 'triggerCutover' to 'True' and the names of the specific databases in this array.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  dbsToCancelMigrationOn?: string[];

  /**
   * Mode used to perform the migration: Online or Offline.
   */
  migrationMode?: MigrationMode;
}

/**
 * Migration secret parameters.
 */
model MigrationSecretParametersForPatch {
  /**
   * Credentials of administrator users for source and target servers.
   */
  @secret
  adminCredentials?: AdminCredentialsForPatch;

  /**
   * Gets or sets the name of the user for the source server. This user doesn't need to be an administrator.
   */
  @visibility(Lifecycle.Update)
  sourceServerUsername?: string;

  /**
   * Gets or sets the name of the user for the target server. This user doesn't need to be an administrator.
   */
  @visibility(Lifecycle.Update)
  targetServerUsername?: string;
}

/**
 * Credentials of administrator users for source and target servers.
 */
model AdminCredentialsForPatch {
  /**
   * Password for the user of the source server.
   */
  @visibility(Lifecycle.Update)
  @secret
  sourceServerPassword?: string;

  /**
   * Password for the user of the target server.
   */
  @visibility(Lifecycle.Update)
  @secret
  targetServerPassword?: string;
}

/**
 * List of migrations.
 */
model MigrationList is Azure.Core.Page<Migration>;

/**
 * Availability of a migration name.
 */
model MigrationNameAvailability {
  /**
   * Name of the migration to check for validity and availability.
   */
  name: string;

  /**
   * Type of resource.
   */
  type: string;

  /**
   * Indicates if the migration name is available.
   */
  @visibility(Lifecycle.Read)
  nameAvailable?: boolean;

  /**
   * Migration name availability reason.
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
 * Availability of a name.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NameAvailabilityModel
  extends Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse {
  /**
   * Name for which validity and availability was checked.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Type of resource. It can be 'Microsoft.DBforPostgreSQL/flexibleServers' or 'Microsoft.DBforPostgreSQL/flexibleServers/virtualendpoints'.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * REST API operation definition.
 */
model Operation {
  /**
   * Name of the operation being performed on this particular object.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Localized display information for this particular operation or action.
   */
  @visibility(Lifecycle.Read)
  display?: OperationDisplay;

  /**
   * Indicates if the operation is a data action.
   */
  isDataAction?: boolean;

  /**
   * Intended executor of the operation.
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
   * Name of the resource provider.
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * Type of resource on which the operation is performed.
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * Name of the operation.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * Description of the operation.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * List of private endpoint connections.
 */
model PrivateEndpointConnectionList
  is Azure.Core.Page<PrivateEndpointConnection>;

/**
 * A list of private link resources
 */
model PrivateLinkResourceList is Azure.Core.Page<PrivateLinkResource>;

/**
 * Capability for the PostgreSQL server
 */
model QuotaUsageList is Azure.Core.Page<QuotaUsage>;

/**
 * Quota usage for servers
 */
model QuotaUsage {
  /**
   * Name of quota usage for servers
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
 * A list of servers.
 */
model ServerList is Azure.Core.Page<Server>;

/**
 * Compute information of a server.
 */
model Sku {
  /**
   * Name by which is known a given compute size assigned to a server.
   */
  name: string;

  /**
   * Tier of the compute assigned to a server.
   */
  tier: SkuTier;
}

/**
 * Identities associated with a server.
 */
model UserAssignedIdentity {
  /**
   * Map of user assigned managed identities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserIdentity>;

  /**
   * Identifier of the object of the service principal associated to the user assigned managed identity.
   */
  principalId?: string;

  /**
   * Types of identities associated with a server.
   */
  type: IdentityType;

  /**
   * Identifier of the tenant of a server.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * User assigned managed identity associated with a server.
 */
model UserIdentity {
  /**
   * Identifier of the object of the service principal associated to the user assigned managed identity.
   */
  principalId?: string;

  /**
   * Identifier of the client of the service principal associated to the user assigned managed identity.
   */
  clientId?: string;
}

/**
 * Properties of a server.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerProperties {
  /**
   * Name of the login designated as the first password based administrator assigned to your instance of PostgreSQL. Must be specified the first time that you enable password based authentication on a server. Once set to a given value, it cannot be changed for the rest of the life of a server. If you disable password based authentication on a server which had it enabled, this password based role isn't deleted.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorLogin?: string;

  /**
   * Password assigned to the administrator login. As long as password authentication is enabled, this password can be changed at any time.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  administratorLoginPassword?: string;

  /**
   * Major version of PostgreSQL database engine.
   */
  version?: PostgresMajorVersion;

  /**
   * Minor version of PostgreSQL database engine.
   */
  @visibility(Lifecycle.Read)
  minorVersion?: string;

  /**
   * Possible states of a server.
   */
  @visibility(Lifecycle.Read)
  state?: ServerState;

  /**
   * Fully qualified domain name of a server.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  /**
   * Storage properties of a server.
   */
  storage?: Storage;

  /**
   * Authentication configuration properties of a server.
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
   * Network properties of a server. Only required if you want your server to be integrated into a virtual network provided by customer.
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
   * Identifier of the server to be used as the source of the new server. Required when 'createMode' is 'PointInTimeRestore', 'GeoRestore', 'Replica', or 'ReviveDropped'. This property is returned only when the target server is a read replica.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceServerResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DBforPostgreSQL/flexibleServers";
    }
  ]>;

  /**
   * Creation time (in ISO8601 format) of the backup which you want to restore in the new server. It's required when 'createMode' is 'PointInTimeRestore', 'GeoRestore', or 'ReviveDropped'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  pointInTimeUTC?: utcDateTime;

  /**
   * Availability zone of a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  availabilityZone?: string = "";

  /**
   * Role of the server in a replication set.
   */
  replicationRole?: ReplicationRole;

  /**
   * Maximum number of read replicas allowed for a server.
   */
  @visibility(Lifecycle.Read)
  replicaCapacity?: int32;

  /**
   * Read replica properties of a server. Required only in case that you want to promote a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  replica?: Replica;

  /**
   * Creation mode of a new server.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  createMode?: CreateMode;

  /**
   * List of private endpoint connections associated with the specified server.
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
 * Storage properties of a server.
 */
model Storage {
  /**
   * Size of storage assigned to a server.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageSizeGB?: int32;

  /**
   * Flag to enable or disable the automatic growth of storage size of a server when available space is nearing zero and conditions allow for automatically growing storage size.
   */
  autoGrow?: StorageAutoGrow;

  /**
   * Storage tier of a server.
   */
  tier?: AzureManagedDiskPerformanceTier;

  /**
   * Maximum IOPS supported for storage. Required when type of storage is PremiumV2_LRS or UltraSSD_LRS.
   */
  iops?: int32;

  /**
   * Maximum throughput supported for storage. Required when type of storage is PremiumV2_LRS or UltraSSD_LRS.
   */
  throughput?: int32;

  /**
   * Type of storage assigned to a server. Allowed values are Premium_LRS, PremiumV2_LRS, or UltraSSD_LRS. If not specified, it defaults to Premium_LRS.
   */
  type?: StorageType;
}

/**
 * Authentication configuration properties of a server.
 */
model AuthConfig {
  /**
   * Indicates if the server supports Microsoft Entra authentication.
   */
  activeDirectoryAuth?: MicrosoftEntraAuth;

  /**
   * Indicates if the server supports password based authentication.
   */
  passwordAuth?: PasswordBasedAuth = PasswordBasedAuth.Enabled;

  /**
   * Identifier of the tenant of the delegated resource.
   */
  tenantId?: string = "";
}

/**
 * Data encryption properties of a server.
 */
model DataEncryption {
  /**
   * URI of the key in Azure Key Vault used for data encryption of the primary storage associated to a server.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  primaryKeyURI?: string;

  /**
   * Identifier of the user assigned managed identity used to access the key in Azure Key Vault for data encryption of the primary storage associated to a server.
   */
  primaryUserAssignedIdentityId?: string;

  /**
   * Identifier of the user assigned managed identity used to access the key in Azure Key Vault for data encryption of the geographically redundant storage associated to a server that is configured to support geographically redundant backups.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  geoBackupKeyURI?: string;

  /**
   * Identifier of the user assigned managed identity used to access the key in Azure Key Vault for data encryption of the geographically redundant storage associated to a server that is configured to support geographically redundant backups.
   */
  geoBackupUserAssignedIdentityId?: string;

  /**
   * Data encryption type used by a server.
   */
  type?: DataEncryptionType;

  /**
   * Status of key used by a server configured with data encryption based on customer managed key, to encrypt the primary storage associated to the server.
   */
  @visibility(Lifecycle.Read)
  primaryEncryptionKeyStatus?: EncryptionKeyStatus;

  /**
   * Status of key used by a server configured with data encryption based on customer managed key, to encrypt the geographically redundant storage associated to the server when it is configured to support geographically redundant backups.
   */
  @visibility(Lifecycle.Read)
  geoBackupEncryptionKeyStatus?: EncryptionKeyStatus;
}

/**
 * Backup properties of a server.
 */
model Backup {
  /**
   * Backup retention days for the server.
   */
  backupRetentionDays?: int32 = 7;

  /**
   * Indicates if the server is configured to create geographically redundant backups.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  geoRedundantBackup?: GeographicallyRedundantBackup = GeographicallyRedundantBackup.Disabled;

  /**
   * Earliest restore point time (ISO8601 format) for a server.
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
   * Indicates if public network access is enabled or not. This is only supported for servers that are not integrated into a virtual network which is owned and provided by customer when server is deployed.
   */
  publicNetworkAccess?: ServerPublicNetworkAccessState;

  /**
   * Resource identifier of the delegated subnet. Required during creation of a new server, in case you want the server to be integrated into your own virtual network. For an update operation, you only have to provide this property if you want to change the value assigned for the private DNS zone.
   */
  delegatedSubnetResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Identifier of the private DNS zone. Required during creation of a new server, in case you want the server to be integrated into your own virtual network. For an update operation, you only have to provide this property if you want to change the value assigned for the private DNS zone.
   */
  privateDnsZoneArmResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateDnsZones";
    }
  ]>;
}

/**
 * High availability properties of a server.
 */
model HighAvailability {
  /**
   * High availability mode for a server.
   */
  mode?: PostgreSqlFlexibleServerHighAvailabilityMode = PostgreSqlFlexibleServerHighAvailabilityMode.Disabled;

  /**
   * Possible states of the standby server created when high availability is set to SameZone or ZoneRedundant.
   */
  @visibility(Lifecycle.Read)
  state?: HighAvailabilityState;

  /**
   * Availability zone associated to the standby server created when high availability is set to SameZone or ZoneRedundant.
   */
  standbyAvailabilityZone?: string = "";
}

/**
 * Maintenance window properties of a server.
 */
model MaintenanceWindow {
  /**
   * Indicates whether custom window is enabled or disabled.
   */
  customWindow?: string = "Disabled";

  /**
   * Start hour to be used for maintenance window.
   */
  startHour?: int32 = 0;

  /**
   * Start minute to be used for maintenance window.
   */
  startMinute?: int32 = 0;

  /**
   * Day of the week to be used for maintenance window.
   */
  dayOfWeek?: int32 = 0;
}

/**
 * Replica properties of a server.
 */
model Replica {
  /**
   * Role of the server in a replication set.
   */
  role?: ReplicationRole;

  /**
   * Maximum number of read replicas allowed for a server.
   */
  @visibility(Lifecycle.Read)
  capacity?: int32;

  /**
   * Indicates the replication state of a read replica. This property is returned only when the target server is a read replica. Possible  values are Active, Broken, Catchup, Provisioning, Reconfiguring, and Updating
   */
  @visibility(Lifecycle.Read)
  replicationState?: ReplicationState;

  /**
   * Type of operation to apply on the read replica. This property is write only. Standalone means that the read replica will be promoted to a standalone server, and will become a completely independent entity from the replication set. Switchover means that the read replica will roles with the primary server.
   */
  @visibility(Lifecycle.Update)
  promoteMode?: ReadReplicaPromoteMode;

  /**
   * Data synchronization option to use when processing the operation specified in the promoteMode property. This property is write only.
   */
  @visibility(Lifecycle.Update)
  promoteOption?: ReadReplicaPromoteOption;
}

/**
 * Cluster properties of a server.
 */
model Cluster {
  /**
   * Number of nodes assigned to the elastic cluster.
   */
  clusterSize?: int32 = 0;

  /**
   * Default database name for the elastic cluster.
   */
  defaultDatabaseName?: string;
}

/**
 * Represents a server to be updated.
 */
model ServerForPatch {
  /**
   * Compute tier and size of a server.
   */
  sku?: SkuForPatch;

  /**
   * Describes the identity of the application.
   */
  identity?: UserAssignedIdentity;

  /**
   * Properties of the server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ServerPropertiesForPatch;

  /**
   * Application-specific metadata in the form of key-value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Compute information of a server.
 */
model SkuForPatch {
  /**
   * Name by which is known a given compute size assigned to a server.
   */
  name?: string;

  /**
   * Tier of the compute assigned to a server.
   */
  tier?: SkuTier;
}

/**
 * Properties of a server.
 */
model ServerPropertiesForPatch {
  /**
   * Name of the login designated as the first password based administrator assigned to your instance of PostgreSQL. Must be specified the first time that you enable password based authentication on a server. Once set to a given value, it cannot be changed for the rest of the life of a server. If you disable password based authentication on a server which had it enabled, this password based role isn't deleted.
   */
  @visibility(Lifecycle.Read)
  administratorLogin?: string;

  /**
   * Password assigned to the administrator login. As long as password authentication is enabled, this password can be changed at any time.
   */
  @visibility(Lifecycle.Update)
  @secret
  administratorLoginPassword?: string;

  /**
   * Major version of PostgreSQL database engine.
   */
  version?: PostgresMajorVersion;

  /**
   * Storage properties of a server.
   */
  storage?: Storage;

  /**
   * Backup properties of a server.
   */
  backup?: BackupForPatch;

  /**
   * High availability properties of a server.
   */
  highAvailability?: HighAvailabilityForPatch;

  /**
   * Maintenance window properties of a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  maintenanceWindow?: MaintenanceWindowForPatch;

  /**
   * Authentication configuration properties of a server.
   */
  authConfig?: AuthConfigForPatch;

  /**
   * Data encryption properties of a server.
   */
  dataEncryption?: DataEncryption;

  /**
   * Availability zone of a server.
   */
  availabilityZone?: string = "";

  /**
   * Update mode of an existing server.
   */
  @visibility(Lifecycle.Update)
  createMode?: CreateModeForPatch;

  /**
   * Role of the server in a replication set.
   */
  replicationRole?: ReplicationRole;

  /**
   * Read replica properties of a server. Required only in case that you want to promote a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  replica?: Replica;

  /**
   * Network properties of a server. Only required if you want your server to be integrated into a virtual network provided by customer.
   */
  network?: Network;

  /**
   * Cluster properties of a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  cluster?: Cluster;
}

/**
 * Backup properties of a server.
 */
model BackupForPatch {
  /**
   * Backup retention days for the server.
   */
  backupRetentionDays?: int32;

  /**
   * Indicates if the server is configured to create geographically redundant backups.
   */
  @visibility(Lifecycle.Read)
  geoRedundantBackup?: GeographicallyRedundantBackup;

  /**
   * Earliest restore point time (ISO8601 format) for a server.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;
}

/**
 * High availability properties of a server.
 */
model HighAvailabilityForPatch {
  /**
   * High availability mode for a server.
   */
  mode?: PostgreSqlFlexibleServerHighAvailabilityMode;

  /**
   * Possible states of the standby server created when high availability is set to SameZone or ZoneRedundant.
   */
  @visibility(Lifecycle.Read)
  state?: HighAvailabilityState;

  /**
   * Availability zone associated to the standby server created when high availability is set to SameZone or ZoneRedundant.
   */
  standbyAvailabilityZone?: string = "";
}

/**
 * Maintenance window properties of a server.
 */
model MaintenanceWindowForPatch {
  /**
   * Indicates whether custom window is enabled or disabled.
   */
  customWindow?: string;

  /**
   * Start hour to be used for maintenance window.
   */
  startHour?: int32;

  /**
   * Start minute to be used for maintenance window.
   */
  startMinute?: int32;

  /**
   * Day of the week to be used for maintenance window.
   */
  dayOfWeek?: int32;
}

/**
 * Authentication configuration properties of a server.
 */
model AuthConfigForPatch {
  /**
   * Indicates if the server supports Microsoft Entra authentication.
   */
  activeDirectoryAuth?: MicrosoftEntraAuth;

  /**
   * Indicates if the server supports password based authentication.
   */
  passwordAuth?: PasswordBasedAuth;

  /**
   * Identifier of the tenant of the delegated resource.
   */
  tenantId?: string;
}

/**
 * PostgreSQL database engine restart parameters.
 */
model RestartParameter {
  /**
   * Indicates if restart the PostgreSQL database engine should failover or switch over from primary to standby. This only works if server has high availability enabled.
   */
  restartWithFailover?: boolean;

  /**
   * Failover mode.
   */
  failoverMode?: FailoverMode;
}

/**
 * List of available object recommendations.
 */
model ObjectRecommendationList is Azure.Core.Page<ObjectRecommendation>;

/**
 * Object recommendation properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ObjectRecommendation
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Always empty.
   */
  kind?: string;

  /**
   * Properties of an object recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  properties?: ObjectRecommendationProperties;
}

/**
 * Object recommendation properties.
 */
model ObjectRecommendationProperties {
  /**
   * Creation time (UTC) of this recommendation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  initialRecommendedTime?: utcDateTime;

  /**
   * Last time (UTC) that this recommendation was produced.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRecommendedTime?: utcDateTime;

  /**
   * Number of times this recommendation has been produced.
   */
  timesRecommended?: int32;

  /**
   * List of identifiers for all queries identified as targets for improvement if the recommendation is applied. The list is only populated for CREATE INDEX recommendations.
   */
  improvedQueryIds?: int64[];

  /**
   * Reason for this recommendation.
   */
  recommendationReason?: string;

  /**
   * Current state.
   */
  currentState?: string;

  /**
   * Type for this recommendation.
   */
  recommendationType?: RecommendationTypeEnum;

  /**
   * Implementation details for the recommended action.
   */
  implementationDetails?: ObjectRecommendationPropertiesImplementationDetails;

  /**
   * Workload information for the recommended action.
   */
  analyzedWorkload?: ObjectRecommendationPropertiesAnalyzedWorkload;

  /**
   * Estimated impact of this recommended action.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["dimensionName"])
  estimatedImpact?: ImpactRecord[];

  /**
   * Recommendation details for the recommended action.
   */
  @visibility(Lifecycle.Read)
  details?: ObjectRecommendationDetails;
}

/**
 * Implementation details for the recommended action.
 */
model ObjectRecommendationPropertiesImplementationDetails {
  /**
   * Method of implementation for recommended action.
   */
  method?: string;

  /**
   * Implementation script for the recommended action.
   */
  script?: string;
}

/**
 * Workload information for the recommended action.
 */
model ObjectRecommendationPropertiesAnalyzedWorkload {
  /**
   * Start time (UTC) of the workload analyzed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time (UTC) of the workload analyzed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Number of queries from the workload that were examined to produce this recommendation. For DROP INDEX recommendations it's 0 (zero).
   */
  queryCount?: int32;
}

/**
 * Impact on some metric if this recommended action is applied.
 */
model ImpactRecord {
  /**
   * Dimension name.
   */
  dimensionName?: string;

  /**
   * Dimension unit.
   */
  unit?: string;

  /**
   * Optional property that can be used to store the identifier of the query, if the metric is for a specific query.
   */
  queryId?: int64;

  /**
   * Absolute value.
   */
  absoluteValue?: float64;
}

/**
 * Recommendation details for the recommended action.
 */
model ObjectRecommendationDetails {
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
   * Index columns.
   */
  indexColumns?: string[];

  /**
   * Index included columns.
   */
  includedColumns?: string[];
}

/**
 * List of server tuning options.
 */
model TuningOptionsList is Azure.Core.Page<TuningOptions>;

/**
 * Pair of virtual endpoints for a server.
 */
model VirtualEndpointResourceForPatch {
  /**
   * Properties of the pair of virtual endpoints.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: VirtualEndpointResourceProperties;
}

/**
 * Properties of a pair of virtual endpoints.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VirtualEndpointResourceProperties {
  /**
   * Type of endpoint for the virtual endpoints.
   */
  endpointType?: VirtualEndpointType;

  /**
   * List of servers that one of the virtual endpoints can refer to.
   */
  members?: string[];

  /**
   * List of virtual endpoints for a server.
   */
  @visibility(Lifecycle.Read)
  virtualEndpoints?: string[];
}

/**
 * List of virtual endpoints.
 */
model VirtualEndpointsList is Azure.Core.Page<VirtualEndpoint>;

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
model VirtualNetworkSubnetUsageModel {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#["subnetName"])
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

/**
 * Private DNS suffix.
 */
@mediaTypeHint("application/json")
scalar PrivateDnsZoneSuffix extends string;

/**
 * Custom error response for the service.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
model CustomErrorResponse {
  @body
  error: Azure.ResourceManager.ErrorResponse;

  @header("x-ms-error-code")
  @doc("ErrorCode string in the event of a failure.")
  errorCode?: string;

  @header("x-ms-request-id")
  @doc("A unique ID for the current operation, service generated. All the resource providers must return this value in the response headers to facilitate debugging.")
  requestId?: string;
}

@secret
scalar secretString extends string;

model OperationList is Azure.Core.Page<Operation>;

/**
 * The state of the network migration operation.
 */
union NetworkMigrationState {
  string,

  /**
   * The network migration is pending.
   */
  Pending: "Pending",

  /**
   * The network migration is in progress.
   */
  InProgress: "InProgress",

  /**
   * The network migration succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * The network migration failed.
   */
  Failed: "Failed",

  /**
   * The network migration cancellation is in progress.
   */
  CancelInProgress: "CancelInProgress",

  /**
   * The network migration was cancelled.
   */
  Cancelled: "Cancelled",
}

/**
 * The status of a network migration operation.
 */
model MigrateNetworkStatus {
  /**
   * The ID of the subscription.
   */
  subscriptionId?: string;

  /**
   * The name of the resource group.
   */
  resourceGroupName?: string;

  /**
   * The name of the server.
   */
  serverName?: string;

  /**
   * The state of the network migration operation.
   */
  @visibility(Lifecycle.Read)
  state?: NetworkMigrationState;
}

@@visibility(AdvancedThreatProtectionSettingsList.value, Lifecycle.Read);
@@visibility(CapabilityList.value, Lifecycle.Read);
@@visibility(MigrationList.value, Lifecycle.Read);
@@visibility(PrivateEndpointConnectionList.value, Lifecycle.Read);
@@visibility(PrivateLinkResourceList.value, Lifecycle.Read);
@@visibility(QuotaUsageList.value, Lifecycle.Read);
@@identifiers(CapabilityList.value, #["name"]);
@@identifiers(ObjectRecommendationList.value, #["name"]);
@@identifiers(OperationList.value, #["name"]);
@@identifiers(QuotaUsageList.value, #["name"]);
@@identifiers(TuningOptionsList.value, #["name"]);
