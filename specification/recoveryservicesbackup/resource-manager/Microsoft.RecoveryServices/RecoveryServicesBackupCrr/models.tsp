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

namespace Microsoft.RecoveryServices;

/**
 * Unit of the usage.
 */
union UsagesUnit {
  string,

  /**
   * Count
   */
  Count: "Count",

  /**
   * Bytes
   */
  Bytes: "Bytes",

  /**
   * Seconds
   */
  Seconds: "Seconds",

  /**
   * Percent
   */
  Percent: "Percent",

  /**
   * CountPerSecond
   */
  CountPerSecond: "CountPerSecond",

  /**
   * BytesPerSecond
   */
  BytesPerSecond: "BytesPerSecond",
}

/**
 * Backup management type to execute the current job.
 */
union BackupManagementType {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * AzureIaasVM
   */
  AzureIaasVM: "AzureIaasVM",

  /**
   * MAB
   */
  MAB: "MAB",

  /**
   * DPM
   */
  DPM: "DPM",

  /**
   * AzureBackupServer
   */
  AzureBackupServer: "AzureBackupServer",

  /**
   * AzureSql
   */
  AzureSql: "AzureSql",

  /**
   * AzureStorage
   */
  AzureStorage: "AzureStorage",

  /**
   * AzureWorkload
   */
  AzureWorkload: "AzureWorkload",

  /**
   * DefaultBackup
   */
  DefaultBackup: "DefaultBackup",
}

/**
 * Operation status.
 */
union OperationStatusValues {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

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
 * Storage type
 */
union StorageType {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * GeoRedundant
   */
  GeoRedundant: "GeoRedundant",

  /**
   * LocallyRedundant
   */
  LocallyRedundant: "LocallyRedundant",

  /**
   * ZoneRedundant
   */
  ZoneRedundant: "ZoneRedundant",

  /**
   * ReadAccessGeoZoneRedundant
   */
  ReadAccessGeoZoneRedundant: "ReadAccessGeoZoneRedundant",
}

/**
 * Locked or Unlocked. Once a machine is registered against a resource, the storageTypeState is always Locked.
 */
union StorageTypeState {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

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
 * Type of workload this item represents.
 */
union DataSourceType {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * VM
   */
  VM: "VM",

  /**
   * FileFolder
   */
  FileFolder: "FileFolder",

  /**
   * AzureSqlDb
   */
  AzureSqlDb: "AzureSqlDb",

  /**
   * SQLDB
   */
  SQLDB: "SQLDB",

  /**
   * Exchange
   */
  Exchange: "Exchange",

  /**
   * Sharepoint
   */
  Sharepoint: "Sharepoint",

  /**
   * VMwareVM
   */
  VMwareVM: "VMwareVM",

  /**
   * SystemState
   */
  SystemState: "SystemState",

  /**
   * Client
   */
  Client: "Client",

  /**
   * GenericDataSource
   */
  GenericDataSource: "GenericDataSource",

  /**
   * SQLDataBase
   */
  SQLDataBase: "SQLDataBase",

  /**
   * AzureFileShare
   */
  AzureFileShare: "AzureFileShare",

  /**
   * SAPHanaDatabase
   */
  SAPHanaDatabase: "SAPHanaDatabase",

  /**
   * SAPAseDatabase
   */
  SAPAseDatabase: "SAPAseDatabase",
}

/**
 * Create mode to indicate recovery of existing soft deleted data source or creation of new data source.
 */
union CreateMode {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Default
   */
  Default: "Default",

  /**
   * Recover
   */
  Recover: "Recover",
}

/**
 * Backup management type for this container.
 */
union Type {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * BackupProtectedItemCountSummary
   */
  BackupProtectedItemCountSummary: "BackupProtectedItemCountSummary",

  /**
   * BackupProtectionContainerCountSummary
   */
  BackupProtectionContainerCountSummary: "BackupProtectionContainerCountSummary",
}

/**
 * Backup state of this backup item.
 */
union ProtectionState {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * IRPending
   */
  IRPending: "IRPending",

  /**
   * Protected
   */
  Protected: "Protected",

  /**
   * ProtectionError
   */
  ProtectionError: "ProtectionError",

  /**
   * ProtectionStopped
   */
  ProtectionStopped: "ProtectionStopped",

  /**
   * ProtectionPaused
   */
  ProtectionPaused: "ProtectionPaused",
}

/**
 * backups running status for this backup item.
 */
union HealthStatus {
  string,

  /**
   * Passed
   */
  Passed: "Passed",

  /**
   * ActionRequired
   */
  ActionRequired: "ActionRequired",

  /**
   * ActionSuggested
   */
  ActionSuggested: "ActionSuggested",

  /**
   * Invalid
   */
  Invalid: "Invalid",
}

/**
 * Resource Health Status
 */
union ResourceHealthStatus {
  string,

  /**
   * Healthy
   */
  Healthy: "Healthy",

  /**
   * TransientDegraded
   */
  TransientDegraded: "TransientDegraded",

  /**
   * PersistentDegraded
   */
  PersistentDegraded: "PersistentDegraded",

  /**
   * TransientUnhealthy
   */
  TransientUnhealthy: "TransientUnhealthy",

  /**
   * PersistentUnhealthy
   */
  PersistentUnhealthy: "PersistentUnhealthy",

  /**
   * Invalid
   */
  Invalid: "Invalid",
}

/**
 * Type of this recovery.
 */
union RecoveryType {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * OriginalLocation
   */
  OriginalLocation: "OriginalLocation",

  /**
   * AlternateLocation
   */
  AlternateLocation: "AlternateLocation",

  /**
   * RestoreDisks
   */
  RestoreDisks: "RestoreDisks",

  /**
   * Offline
   */
  Offline: "Offline",
}

/**
 * Options to resolve copy conflicts.
 */
union CopyOptions {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * CreateCopy
   */
  CreateCopy: "CreateCopy",

  /**
   * Skip
   */
  Skip: "Skip",

  /**
   * Overwrite
   */
  Overwrite: "Overwrite",

  /**
   * FailOnConflict
   */
  FailOnConflict: "FailOnConflict",
}

/**
 * Restore Type (FullShareRestore or ItemLevelRestore)
 */
union RestoreRequestType {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * FullShareRestore
   */
  FullShareRestore: "FullShareRestore",

  /**
   * ItemLevelRestore
   */
  ItemLevelRestore: "ItemLevelRestore",
}

/**
 * Backup state of the backed up item.
 */
union ProtectedItemState {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * IRPending
   */
  IRPending: "IRPending",

  /**
   * Protected
   */
  Protected: "Protected",

  /**
   * ProtectionError
   */
  ProtectionError: "ProtectionError",

  /**
   * ProtectionStopped
   */
  ProtectionStopped: "ProtectionStopped",

  /**
   * ProtectionPaused
   */
  ProtectionPaused: "ProtectionPaused",
}

/**
 * Last backup operation status. Possible values: Healthy, Unhealthy.
 */
union LastBackupStatus {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Healthy
   */
  Healthy: "Healthy",

  /**
   * Unhealthy
   */
  Unhealthy: "Unhealthy",

  /**
   * IRPending
   */
  IRPending: "IRPending",
}

/**
 * Health status of the backup item, evaluated based on last heartbeat received
 */
union ProtectedItemHealthStatus {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Healthy
   */
  Healthy: "Healthy",

  /**
   * Unhealthy
   */
  Unhealthy: "Unhealthy",

  /**
   * NotReachable
   */
  NotReachable: "NotReachable",

  /**
   * IRPending
   */
  IRPending: "IRPending",
}

/**
 * Type of restore point
 */
union RestorePointType {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Full
   */
  Full: "Full",

  /**
   * Log
   */
  Log: "Log",

  /**
   * Differential
   */
  Differential: "Differential",

  /**
   * Incremental
   */
  Incremental: "Incremental",
}

/**
 * Can Overwrite if Target DataBase already exists
 */
union OverwriteOptions {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * FailOnConflict
   */
  FailOnConflict: "FailOnConflict",

  /**
   * Overwrite
   */
  Overwrite: "Overwrite",
}

/**
 * Defines whether the current recovery mode is file restore or database restore
 */
union RecoveryMode {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * FileRecovery
   */
  FileRecovery: "FileRecovery",

  /**
   * WorkloadRecovery
   */
  WorkloadRecovery: "WorkloadRecovery",
}

/**
 * Type of data directory mapping
 */
union SQLDataDirectoryType {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Data
   */
  Data: "Data",

  /**
   * Log
   */
  Log: "Log",
}

/**
 * RestorePoint type
 */
union RestorePointQueryType {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Full
   */
  Full: "Full",

  /**
   * Log
   */
  Log: "Log",

  /**
   * Differential
   */
  Differential: "Differential",

  /**
   * FullAndDifferential
   */
  FullAndDifferential: "FullAndDifferential",

  /**
   * All
   */
  All: "All",

  /**
   * Incremental
   */
  Incremental: "Incremental",
}

/**
 * Status of the job.
 */
union JobStatus {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

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
   * CompletedWithWarnings
   */
  CompletedWithWarnings: "CompletedWithWarnings",

  /**
   * Cancelled
   */
  Cancelled: "Cancelled",

  /**
   * Cancelling
   */
  Cancelling: "Cancelling",
}

/**
 * Type of operation.
 */
union JobOperationType {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Register
   */
  Register: "Register",

  /**
   * UnRegister
   */
  UnRegister: "UnRegister",

  /**
   * ConfigureBackup
   */
  ConfigureBackup: "ConfigureBackup",

  /**
   * Backup
   */
  Backup: "Backup",

  /**
   * Restore
   */
  Restore: "Restore",

  /**
   * DisableBackup
   */
  DisableBackup: "DisableBackup",

  /**
   * DeleteBackupData
   */
  DeleteBackupData: "DeleteBackupData",

  /**
   * CrossRegionRestore
   */
  CrossRegionRestore: "CrossRegionRestore",

  /**
   * Undelete
   */
  Undelete: "Undelete",

  /**
   * UpdateCustomerManagedKey
   */
  UpdateCustomerManagedKey: "UpdateCustomerManagedKey",
}

/**
 * Server type of MAB container.
 */
union MabServerType {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * IaasVMContainer
   */
  IaasVMContainer: "IaasVMContainer",

  /**
   * IaasVMServiceContainer
   */
  IaasVMServiceContainer: "IaasVMServiceContainer",

  /**
   * DPMContainer
   */
  DPMContainer: "DPMContainer",

  /**
   * AzureBackupServerContainer
   */
  AzureBackupServerContainer: "AzureBackupServerContainer",

  /**
   * MABContainer
   */
  MABContainer: "MABContainer",

  /**
   * Cluster
   */
  Cluster: "Cluster",

  /**
   * AzureSqlContainer
   */
  AzureSqlContainer: "AzureSqlContainer",

  /**
   * Windows
   */
  Windows: "Windows",

  /**
   * VCenter
   */
  VCenter: "VCenter",

  /**
   * VMAppContainer
   */
  VMAppContainer: "VMAppContainer",

  /**
   * SQLAGWorkLoadContainer
   */
  SQLAGWorkLoadContainer: "SQLAGWorkLoadContainer",

  /**
   * StorageContainer
   */
  StorageContainer: "StorageContainer",

  /**
   * GenericContainer
   */
  GenericContainer: "GenericContainer",
}

/**
 * Workload type of backup item.
 */
union WorkloadType {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * VM
   */
  VM: "VM",

  /**
   * FileFolder
   */
  FileFolder: "FileFolder",

  /**
   * AzureSqlDb
   */
  AzureSqlDb: "AzureSqlDb",

  /**
   * SQLDB
   */
  SQLDB: "SQLDB",

  /**
   * Exchange
   */
  Exchange: "Exchange",

  /**
   * Sharepoint
   */
  Sharepoint: "Sharepoint",

  /**
   * VMwareVM
   */
  VMwareVM: "VMwareVM",

  /**
   * SystemState
   */
  SystemState: "SystemState",

  /**
   * Client
   */
  Client: "Client",

  /**
   * GenericDataSource
   */
  GenericDataSource: "GenericDataSource",

  /**
   * SQLDataBase
   */
  SQLDataBase: "SQLDataBase",

  /**
   * AzureFileShare
   */
  AzureFileShare: "AzureFileShare",

  /**
   * SAPHanaDatabase
   */
  SAPHanaDatabase: "SAPHanaDatabase",

  /**
   * SAPAseDatabase
   */
  SAPAseDatabase: "SAPAseDatabase",
}

/**
 * Health State for the backed up item.
 */
union HealthState {
  string,

  /**
   * Passed
   */
  Passed: "Passed",

  /**
   * ActionRequired
   */
  ActionRequired: "ActionRequired",

  /**
   * ActionSuggested
   */
  ActionSuggested: "ActionSuggested",

  /**
   * Invalid
   */
  Invalid: "Invalid",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum JobSupportedAction {
  /**
   * Invalid
   */
  Invalid,

  /**
   * Cancellable
   */
  Cancellable,

  /**
   * Retriable
   */
  Retriable,
}

/**
 * Recovery point tier type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum RecoveryPointTierType {
  /**
   * Invalid
   */
  Invalid,

  /**
   * InstantRP
   */
  InstantRP,

  /**
   * HardenedRP
   */
  HardenedRP,

  /**
   * ArchivedRP
   */
  ArchivedRP,
}

/**
 * Recovery point tier status.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum RecoveryPointTierStatus {
  /**
   * Invalid
   */
  Invalid,

  /**
   * Valid
   */
  Valid,

  /**
   * Disabled
   */
  Disabled,

  /**
   * Deleted
   */
  Deleted,

  /**
   * Rehydrated
   */
  Rehydrated,
}

/**
 * Backup management usage for vault.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Non-discriminated resource envelope wrapper on a passive stamp: `extends` preserves the emitted allOf composition; `is`/spread would inline the base and `@discriminator` would mis-declare a non-polymorphic base."
model BackupManagementUsageList extends ResourceList {
  /**
   * The list of backup management usages for the given vault.
   */
  @pageItems
  value?: BackupManagementUsage[];
}

/**
 * Backup management usages of a vault.
 */
model BackupManagementUsage {
  /**
   * Unit of the usage.
   */
  unit?: UsagesUnit;

  /**
   * Quota period of usage.
   */
  quotaPeriod?: string;

  /**
   * Next reset time of usage.
   */
  nextResetTime?: utcDateTime;

  /**
   * Current value of usage.
   */
  currentValue?: int64;

  /**
   * Limit of usage.
   */
  limit?: int64;

  /**
   * Name of usage.
   */
  name?: NameInfo;
}

/**
 * The name of usage.
 */
model NameInfo {
  /**
   * Value of usage.
   */
  value?: string;

  /**
   * Localized value of usage.
   */
  localizedValue?: string;
}

/**
 * The resource management error response.
 */
@error
model NewErrorResponse {
  /**
   * The error object.
   */
  error?: NewErrorResponseError;
}

/**
 * The error object.
 */
model NewErrorResponseError {
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  @visibility(Lifecycle.Read)
  details?: NewErrorResponse[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  additionalInfo?: ErrorAdditionalInfo[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Non-discriminated resource envelope wrapper on a passive stamp: `extends` preserves the emitted allOf composition; `is`/spread would inline the base and `@discriminator` would mis-declare a non-polymorphic base."
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AadPropertiesResource extends Resource {
  /**
   * AADPropertiesResource properties
   */
  properties?: AadProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AadProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  servicePrincipalClientId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  tenantId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  authority?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  audience?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  servicePrincipalObjectId?: string;
}

/**
 * ARM Resource.
 */
model Resource {
  /**
   * Resource Id represents the complete path to the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name associated with the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type represents the complete path of the form Namespace/ResourceType/ResourceType/...
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location.
   */
  location?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Optional ETag.
   */
  eTag?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CrossRegionRestoreRequest {
  /**
   * Access details for cross region restore
   */
  crossRegionRestoreAccessDetails?: CrrAccessToken;

  /**
   * Request object for triggering restore
   */
  restoreRequest?: RestoreRequest;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@discriminator("objectType")
model CrrAccessToken {
  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Passive stamp: reproduces a frozen plain-string discriminator; modeling it as an extensible union changes the emitted schema (enum/x-ms-enum), so the plain string is retained to preserve the frozen wire."
  objectType: string;

  /**
   * Access token used for authentication
   */
  accessTokenString?: string;

  /**
   * Subscription Id of the source vault
   */
  subscriptionId?: string;

  /**
   * Resource Group name of the source vault
   */
  resourceGroupName?: string;

  /**
   * Resource Name of the source vault
   */
  resourceName?: string;

  /**
   * Resource Id of the source vault
   */
  resourceId?: string;

  /**
   * Protected item container id
   */
  protectionContainerId?: int64;

  /**
   * Recovery Point Id
   */
  recoveryPointId?: string;

  /**
   * Recovery Point Time
   */
  recoveryPointTime?: string;

  /**
   * Container Unique name
   */
  containerName?: string;

  /**
   * Container Type
   */
  containerType?: string;

  /**
   * Backup Management Type
   */
  backupManagementType?: string;

  /**
   * Datasource Type
   */
  datasourceType?: string;

  /**
   * Datasource Friendly Name
   */
  datasourceName?: string;

  /**
   * Datasource Id
   */
  datasourceId?: string;

  /**
   * Datasource Container Unique Name
   */
  datasourceContainerName?: string;

  /**
   * CoordinatorServiceStampId to be used by BCM in restore call
   */
  coordinatorServiceStampId?: string;

  /**
   * CoordinatorServiceStampUri to be used by BCM in restore call
   */
  coordinatorServiceStampUri?: string;

  /**
   * ProtectionServiceStampId to be used by BCM in restore call
   */
  protectionServiceStampId?: string;

  /**
   * ProtectionServiceStampUri to be used by BCM in restore call
   */
  protectionServiceStampUri?: string;

  /**
   * Extended Information about the token like FileSpec etc.
   */
  tokenExtendedInformation?: string;

  /**
   * Recovery point Tier Information
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  rpTierInformation?: Record<string>;

  /**
   * Recovery point information: Original SA option
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Faithful migration: this property name is part of the published stable/2023-01-15 wire contract and must be preserved (property casing is API surface)."
  rpOriginalSAOption?: boolean;

  /**
   * Recovery point information: Managed virtual machine
   */
  rpIsManagedVirtualMachine?: boolean;

  /**
   * Recovery point information: VM size description
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Faithful migration: this property name is part of the published stable/2023-01-15 wire contract and must be preserved (property casing is API surface)."
  rpVMSizeDescription?: string;

  /**
   * Active region name of BMS Stamp
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Faithful migration: this property name is part of the published stable/2023-01-15 wire contract and must be preserved (property casing is API surface)."
  bMSActiveRegion?: string;
}

/**
 * Base class for restore request. Workload-specific restore requests are derived from this class.
 */
@discriminator("objectType")
model RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Passive stamp: reproduces a frozen plain-string discriminator; modeling it as an extensible union changes the emitted schema (enum/x-ms-enum), so the plain string is retained to preserve the frozen wire."
  objectType: string;
}

/**
 * Request object for fetching CRR jobs.
 */
model CrrJobRequest {
  /**
   * Entire ARM resource id of the resource
   */
  resourceId?: string;

  /**
   * Job Name of the job to be fetched
   */
  jobName?: string;
}

/**
 * Defines workload agnostic properties for a job.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Non-discriminated resource envelope wrapper on a passive stamp: `extends` preserves the emitted allOf composition; `is`/spread would inline the base and `@discriminator` would mis-declare a non-polymorphic base."
model JobResource extends Resource {
  /**
   * JobResource properties
   */
  properties?: Job;
}

/**
 * Defines workload agnostic properties for a job.
 */
@discriminator("jobType")
model Job {
  /**
   * Friendly name of the entity on which the current job is executing.
   */
  entityFriendlyName?: string;

  /**
   * Backup management type to execute the current job.
   */
  backupManagementType?: BackupManagementType;

  /**
   * The operation name.
   */
  operation?: string;

  /**
   * Job status.
   */
  status?: string;

  /**
   * The start time.
   */
  startTime?: utcDateTime;

  /**
   * The end time.
   */
  endTime?: utcDateTime;

  /**
   * ActivityId of job.
   */
  activityId?: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Passive stamp: reproduces a frozen plain-string discriminator; modeling it as an extensible union changes the emitted schema (enum/x-ms-enum), so the plain string is retained to preserve the frozen wire."
  jobType: string;
}

/**
 * List of Job resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Non-discriminated resource envelope wrapper on a passive stamp: `extends` preserves the emitted allOf composition; `is`/spread would inline the base and `@discriminator` would mis-declare a non-polymorphic base."
model JobResourceList extends ResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: JobResource[];
}

/**
 * Base for all lists of resources.
 */
model ResourceList {
  /**
   * The uri to fetch the next page of resources. Call ListNext() fetches next page of resources.
   */
  nextLink?: string;
}

/**
 * Operation status.
 */
model OperationStatus {
  /**
   * ID of the operation.
   */
  id?: string;

  /**
   * Name of the operation.
   */
  name?: string;

  /**
   * Operation status.
   */
  status?: OperationStatusValues;

  /**
   * Operation start time. Format: ISO-8601.
   */
  startTime?: utcDateTime;

  /**
   * Operation end time. Format: ISO-8601.
   */
  endTime?: utcDateTime;

  /**
   * Error information related to this operation.
   */
  error?: OperationStatusError;

  /**
   * Additional information associated with this operation.
   */
  properties?: OperationStatusExtendedInfo;
}

/**
 * Error information associated with operation status call.
 */
model OperationStatusError {
  /**
   * Error code of the operation failure.
   */
  code?: string;

  /**
   * Error message displayed if the operation failure.
   */
  message?: string;
}

/**
 * Base class for additional information of operation status.
 */
@discriminator("objectType")
model OperationStatusExtendedInfo {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Passive stamp: reproduces a frozen plain-string discriminator; modeling it as an extensible union changes the emitted schema (enum/x-ms-enum), so the plain string is retained to preserve the frozen wire."
  objectType: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Non-discriminated resource envelope wrapper on a passive stamp: `extends` preserves the emitted allOf composition; `is`/spread would inline the base and `@discriminator` would mis-declare a non-polymorphic base."
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CrrAccessTokenResource extends Resource {
  /**
   * CrrAccessTokenResource properties
   */
  properties?: CrrAccessToken;
}

/**
 * The resource storage details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model BackupResourceConfig {
  /**
   * Storage type
   */
  storageModelType?: StorageType;

  /**
   * Storage type.
   */
  storageType?: StorageType;

  /**
   * Locked or Unlocked. Once a machine is registered against a resource, the storageTypeState is always Locked.
   */
  storageTypeState?: StorageTypeState;

  /**
   * Opt in details of Cross Region Restore feature.
   */
  crossRegionRestoreFlag?: boolean;
}

/**
 * List of RecoveryPoint resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Non-discriminated resource envelope wrapper on a passive stamp: `extends` preserves the emitted allOf composition; `is`/spread would inline the base and `@discriminator` would mis-declare a non-polymorphic base."
model RecoveryPointResourceList extends ResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: RecoveryPointResource[];
}

/**
 * Base class for backup copies. Workload-specific backup copies are derived from this class.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@discriminator("objectType")
model RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Passive stamp: reproduces a frozen plain-string discriminator; modeling it as an extensible union changes the emitted schema (enum/x-ms-enum), so the plain string is retained to preserve the frozen wire."
  objectType: string;
}

/**
 * List of ProtectedItem resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Non-discriminated resource envelope wrapper on a passive stamp: `extends` preserves the emitted allOf composition; `is`/spread would inline the base and `@discriminator` would mis-declare a non-polymorphic base."
model ProtectedItemResourceList extends ResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: ProtectedItemResource[];
}

/**
 * Base class for backup items.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Non-discriminated resource envelope wrapper on a passive stamp: `extends` preserves the emitted allOf composition; `is`/spread would inline the base and `@discriminator` would mis-declare a non-polymorphic base."
model ProtectedItemResource extends Resource {
  /**
   * ProtectedItemResource properties
   */
  properties?: ProtectedItem;
}

/**
 * Base class for backup items.
 */
@discriminator("protectedItemType")
model ProtectedItem {
  /**
   * backup item type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Passive stamp: reproduces a frozen plain-string discriminator; modeling it as an extensible union changes the emitted schema (enum/x-ms-enum), so the plain string is retained to preserve the frozen wire."
  protectedItemType: string;

  /**
   * Type of backup management for the backed up item.
   */
  backupManagementType?: BackupManagementType;

  /**
   * Type of workload this item represents.
   */
  workloadType?: DataSourceType;

  /**
   * Unique name of container
   */
  containerName?: string;

  /**
   * ARM ID of the resource to be backed up.
   */
  sourceResourceId?: string;

  /**
   * ID of the backup policy with which this item is backed up.
   */
  policyId?: string;

  /**
   * Timestamp when the last (latest) backup copy was created for this backup item.
   */
  lastRecoveryPoint?: utcDateTime;

  /**
   * Name of the backup set the backup item belongs to
   */
  backupSetName?: string;

  /**
   * Create mode to indicate recovery of existing soft deleted data source or creation of new data source.
   */
  createMode?: CreateMode;

  /**
   * Time for deferred deletion in UTC
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Faithful migration: this property name is part of the published stable/2023-01-15 wire contract and must be preserved (property casing is API surface)."
  deferredDeleteTimeInUTC?: utcDateTime;

  /**
   * Flag to identify whether the DS is scheduled for deferred delete
   */
  isScheduledForDeferredDelete?: boolean;

  /**
   * Time remaining before the DS marked for deferred delete is permanently deleted
   */
  deferredDeleteTimeRemaining?: string;

  /**
   * Flag to identify whether the deferred deleted DS is to be purged soon
   */
  isDeferredDeleteScheduleUpcoming?: boolean;

  /**
   * Flag to identify that deferred deleted DS is to be moved into Pause state
   */
  isRehydrate?: boolean;

  /**
   * ResourceGuardOperationRequests on which LAC check will be performed
   */
  resourceGuardOperationRequests?: string[];
}

/**
 * Query parameters to fetch backup summaries.
 */
model BmsBackupSummariesQueryObject {
  /**
   * Backup management type for this container.
   */
  type?: Type;
}

/**
 * Azure File Share workload-specific backup item.
 */
model AzureFileshareProtectedItem extends ProtectedItem {
  /**
   * Friendly name of the fileshare represented by this backup item.
   */
  friendlyName?: string;

  /**
   * Backup status of this backup item.
   */
  protectionStatus?: string;

  /**
   * Backup state of this backup item.
   */
  protectionState?: ProtectionState;

  /**
   * backups running status for this backup item.
   */
  healthStatus?: HealthStatus;

  /**
   * Last backup operation status. Possible values: Healthy, Unhealthy.
   */
  lastBackupStatus?: string;

  /**
   * Timestamp of the last backup operation on this backup item.
   */
  lastBackupTime?: utcDateTime;

  /**
   * Health details of different KPIs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  kpisHealths?: Record<KpiResourceHealthDetails>;

  /**
   * Additional information with this backup item.
   */
  extendedInfo?: AzureFileshareProtectedItemExtendedInfo;

  /**
   * backup item type.
   */
  protectedItemType: "AzureFileShareProtectedItem";
}

/**
 * KPI Resource Health Details
 */
model KpiResourceHealthDetails {
  /**
   * Resource Health Status
   */
  resourceHealthStatus?: ResourceHealthStatus;

  /**
   * Resource Health Status
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  resourceHealthDetails?: ResourceHealthDetails[];
}

/**
 * Health Details for backup items.
 */
model ResourceHealthDetails {
  /**
   * Health Code
   */
  @visibility(Lifecycle.Read)
  code?: int32;

  /**
   * Health Title
   */
  @visibility(Lifecycle.Read)
  title?: string;

  /**
   * Health Message
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Health Recommended Actions
   */
  @visibility(Lifecycle.Read)
  recommendations?: string[];
}

/**
 * Additional information about Azure File Share backup item.
 */
model AzureFileshareProtectedItemExtendedInfo {
  /**
   * The oldest backup copy available for this item in the service.
   */
  oldestRecoveryPoint?: utcDateTime;

  /**
   * Number of available backup copies associated with this backup item.
   */
  recoveryPointCount?: int32;

  /**
   * Indicates consistency of policy object and policy applied to this backup item.
   */
  policyState?: string;

  /**
   * Indicates the state of this resource. Possible values are from enum ResourceState {Invalid, Active, SoftDeleted, Deleted}
   */
  @visibility(Lifecycle.Read)
  resourceState?: string;

  /**
   * The resource state sync time for this backup item.
   */
  @visibility(Lifecycle.Read)
  resourceStateSyncTime?: utcDateTime;
}

/**
 * Azure File Share workload specific backup copy.
 */
model AzureFileShareRecoveryPoint extends RecoveryPoint {
  /**
   * Type of the backup copy. Specifies whether it is a crash consistent backup or app consistent.
   */
  @visibility(Lifecycle.Read)
  recoveryPointType?: string;

  /**
   * Time at which this backup copy was created.
   */
  @visibility(Lifecycle.Read)
  recoveryPointTime?: utcDateTime;

  /**
   * Contains Url to the snapshot of fileshare, if applicable
   */
  @visibility(Lifecycle.Read)
  fileShareSnapshotUri?: string;

  /**
   * Contains recovery point size
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Faithful migration: this property name is part of the published stable/2023-01-15 wire contract and must be preserved (property casing is API surface)."
  @visibility(Lifecycle.Read)
  recoveryPointSizeInGB?: int32;

  /**
   * Properties of Recovery Point
   */
  recoveryPointProperties?: RecoveryPointProperties;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureFileShareRecoveryPoint";
}

/**
 * Properties of Recovery Point
 */
model RecoveryPointProperties {
  /**
   * Expiry time of Recovery Point in UTC.
   */
  expiryTime?: string;

  /**
   * Rule name tagged on Recovery Point that governs life cycle
   */
  ruleName?: string;

  /**
   * Bool to indicate whether RP is in soft delete state or not
   */
  isSoftDeleted?: boolean;
}

/**
 * AzureFileShare Restore Request
 */
model AzureFileShareRestoreRequest extends RestoreRequest {
  /**
   * Type of this recovery.
   */
  recoveryType?: RecoveryType;

  /**
   * Source storage account ARM Id
   */
  sourceResourceId?: string;

  /**
   * Options to resolve copy conflicts.
   */
  copyOptions?: CopyOptions;

  /**
   * Restore Type (FullShareRestore or ItemLevelRestore)
   */
  restoreRequestType?: RestoreRequestType;

  /**
   * List of Source Files/Folders(which need to recover) and TargetFolderPath details
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  restoreFileSpecs?: RestoreFileSpecs[];

  /**
   * Target File Share Details
   */
  targetDetails?: TargetAfsRestoreInfo;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureFileShareRestoreRequest";
}

/**
 * Restore file specs like file path, type and target folder path info.
 */
model RestoreFileSpecs {
  /**
   * Source File/Folder path
   */
  path?: string;

  /**
   * Indicates what the Path variable stands for
   */
  fileSpecType?: string;

  /**
   * Destination folder path in target FileShare
   */
  targetFolderPath?: string;
}

/**
 * Target Azure File Share Info.
 */
model TargetAfsRestoreInfo {
  /**
   * File share name
   */
  name?: string;

  /**
   * Target file share resource ARM ID
   */
  targetResourceId?: string;
}

/**
 * IaaS VM workload-specific backup item representing the Classic Compute VM.
 */
model AzureIaasClassicComputeVmProtectedItem extends ProtectedItem {
  /**
   * backup item type.
   */
  protectedItemType: "Microsoft.ClassicCompute/virtualMachines";

  ...AzureIaasVmProtectedItemProperties;
}

/**
 * Shared properties for IaaS VM workload-specific backup items.
 */
alias AzureIaasVmProtectedItemProperties = {
  /**
   * Friendly name of the VM represented by this backup item.
   */
  friendlyName?: string;

  /**
   * Fully qualified ARM ID of the virtual machine represented by this item.
   */
  virtualMachineId?: string;

  /**
   * Backup status of this backup item.
   */
  protectionStatus?: string;

  /**
   * Backup state of this backup item.
   */
  protectionState?: ProtectionState;

  /**
   * Health status of protected item.
   */
  healthStatus?: HealthStatus;

  /**
   * Health details on this backup item.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  healthDetails?: AzureIaasVmHealthDetails[];

  /**
   * Health details of different KPIs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  kpisHealths?: Record<KpiResourceHealthDetails>;

  /**
   * Last backup operation status.
   */
  lastBackupStatus?: string;

  /**
   * Timestamp of the last backup operation on this backup item.
   */
  lastBackupTime?: utcDateTime;

  /**
   * Data ID of the protected item.
   */
  protectedItemDataId?: string;

  /**
   * Additional information for this backup item.
   */
  extendedInfo?: AzureIaasVmProtectedItemExtendedInfo;

  /**
   * Extended Properties for Azure IaasVM Backup.
   */
  extendedProperties?: ExtendedProperties;
};

/**
 * IaaS VM workload-specific backup item.
 */
model AzureIaasVmProtectedItem extends ProtectedItem {
  /**
   * backup item type.
   */
  protectedItemType: "AzureIaaSVMProtectedItem";

  ...AzureIaasVmProtectedItemProperties;
}

/**
 * Azure IaaS VM workload-specific Health Details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Faithful migration: AzureIaasVmHealthDetails is an empty specialization in the frozen stable/2023-01-15 contract."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Non-discriminated resource envelope wrapper on a passive stamp: `extends` preserves the emitted allOf composition; `is`/spread would inline the base and `@discriminator` would mis-declare a non-polymorphic base."
model AzureIaasVmHealthDetails extends ResourceHealthDetails {}

/**
 * Additional information on Azure IaaS VM specific backup item.
 */
model AzureIaasVmProtectedItemExtendedInfo {
  /**
   * The oldest backup copy available for this backup item.
   */
  oldestRecoveryPoint?: utcDateTime;

  /**
   * Number of backup copies available for this backup item.
   */
  recoveryPointCount?: int32;

  /**
   * Specifies if backup policy associated with the backup item is inconsistent.
   */
  policyInconsistent?: boolean;
}

/**
 * Extended Properties for Azure IaasVM Backup.
 */
model ExtendedProperties {
  /**
   * Extended Properties for Disk Exclusion.
   */
  diskExclusionProperties?: DiskExclusionProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DiskExclusionProperties {
  /**
   * List of Disks' Logical Unit Numbers (LUN) to be used for VM Protection.
   */
  diskLunList?: int32[];

  /**
   * Flag to indicate whether DiskLunList is to be included/ excluded from backup.
   */
  isInclusionList?: boolean;
}

/**
 * IaaS VM workload-specific backup item representing the Azure Resource Manager VM.
 */
model AzureIaasComputeVmProtectedItem extends ProtectedItem {
  /**
   * backup item type.
   */
  protectedItemType: "Microsoft.Compute/virtualMachines";

  ...AzureIaasVmProtectedItemProperties;
}

/**
 * Azure IaaS VM workload-specific error information.
 */
model AzureIaasVmErrorInfo {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * Title: Typically, the entity that the error pertains to.
   */
  @visibility(Lifecycle.Read)
  errorTitle?: string;

  /**
   * Localized error string.
   */
  @visibility(Lifecycle.Read)
  errorString?: string;

  /**
   * List of localized recommendations for above error code.
   */
  @visibility(Lifecycle.Read)
  recommendations?: string[];
}

/**
 * Azure IaaS VM workload-specific job object.
 */
model AzureIaaSVMJob extends Job {
  /**
   * Time elapsed during the execution of this job.
   */
  duration?: duration;

  /**
   * Gets or sets the state/actions applicable on this job like cancel/retry.
   */
  actionsInfo?: JobSupportedAction[];

  /**
   * Error details on execution of this job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  errorDetails?: AzureIaasVmErrorInfo[];

  /**
   * Specifies whether the backup item is a Classic or an Azure Resource Manager VM.
   */
  virtualMachineVersion?: string;

  /**
   * Additional information for this job.
   */
  extendedInfo?: AzureIaasVmJobExtendedInfo;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  jobType: "AzureIaaSVMJob";
}

/**
 * Azure IaaS VM workload-specific additional information for job.
 */
model AzureIaasVmJobExtendedInfo {
  /**
   * List of tasks associated with this job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  tasksList?: AzureIaasVmJobTaskDetails[];

  /**
   * Job properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  propertyBag?: Record<string>;

  /**
   * Job internal properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  internalPropertyBag?: Record<string>;

  /**
   * Indicates progress of the job. Null if it has not started or completed.
   */
  progressPercentage?: float64;

  /**
   * Time remaining for execution of this job.
   */
  estimatedRemainingDuration?: string;

  /**
   * Non localized error message on job execution.
   */
  dynamicErrorMessage?: string;
}

/**
 * Azure IaaS VM workload-specific job task details.
 */
model AzureIaasVmJobTaskDetails {
  /**
   * The task display name.
   */
  taskId?: string;

  /**
   * The start time.
   */
  startTime?: utcDateTime;

  /**
   * The end time.
   */
  endTime?: utcDateTime;

  /**
   * The instanceId.
   */
  instanceId?: string;

  /**
   * Time elapsed for task.
   */
  duration?: duration;

  /**
   * The status.
   */
  status?: string;

  /**
   * Progress of the task.
   */
  progressPercentage?: float64;

  /**
   * Details about execution of the task.
   * eg: number of bytes transferred etc
   */
  taskExecutionDetails?: string;
}

/**
 * Azure SQL workload-specific backup item.
 */
model AzureSqlProtectedItem extends ProtectedItem {
  /**
   * Internal ID of a backup item. Used by Azure SQL Backup engine to contact Recovery Services.
   */
  protectedItemDataId?: string;

  /**
   * Backup state of the backed up item.
   */
  protectionState?: ProtectedItemState;

  /**
   * Additional information for this backup item.
   */
  extendedInfo?: AzureSqlProtectedItemExtendedInfo;

  /**
   * backup item type.
   */
  protectedItemType: "Microsoft.Sql/servers/databases";
}

/**
 * Additional information on Azure Sql specific protected item.
 */
model AzureSqlProtectedItemExtendedInfo {
  /**
   * The oldest backup copy available for this item in the service.
   */
  oldestRecoveryPoint?: utcDateTime;

  /**
   * Number of available backup copies associated with this backup item.
   */
  recoveryPointCount?: int32;

  /**
   * State of the backup policy associated with this backup item.
   */
  policyState?: string;
}

/**
 * Azure storage specific error information
 */
model AzureStorageErrorInfo {
  /**
   * Error code.
   */
  errorCode?: int32;

  /**
   * Localized error string.
   */
  errorString?: string;

  /**
   * List of localized recommendations for above error code.
   */
  recommendations?: string[];
}

/**
 * Azure storage specific job.
 */
model AzureStorageJob extends Job {
  /**
   * Time elapsed during the execution of this job.
   */
  duration?: duration;

  /**
   * Gets or sets the state/actions applicable on this job like cancel/retry.
   */
  actionsInfo?: JobSupportedAction[];

  /**
   * Error details on execution of this job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  errorDetails?: AzureStorageErrorInfo[];

  /**
   * Specifies friendly name of the storage account.
   */
  storageAccountName?: string;

  /**
   * Specifies whether the Storage account is a Classic or an Azure Resource Manager Storage account.
   */
  storageAccountVersion?: string;

  /**
   * Additional information about the job.
   */
  extendedInfo?: AzureStorageJobExtendedInfo;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  jobType: "AzureStorageJob";
}

/**
 * Azure Storage workload-specific additional information for job.
 */
model AzureStorageJobExtendedInfo {
  /**
   * List of tasks for this job
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  tasksList?: AzureStorageJobTaskDetails[];

  /**
   * Job properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  propertyBag?: Record<string>;

  /**
   * Non localized error message on job execution.
   */
  dynamicErrorMessage?: string;
}

/**
 * Azure storage workload specific job task details.
 */
model AzureStorageJobTaskDetails {
  /**
   * The task display name.
   */
  taskId?: string;

  /**
   * The status.
   */
  status?: string;
}

/**
 * Shared properties for Azure VM workload-specific protected items.
 */
alias AzureVmWorkloadProtectedItemProperties = {
  /**
   * Friendly name of the DB represented by this backup item.
   */
  friendlyName?: string;

  /**
   * Host/Cluster Name for instance or AG
   */
  serverName?: string;

  /**
   * Parent name of the DB such as Instance or Availability Group.
   */
  parentName?: string;

  /**
   * Parent type of protected item, example: for a DB, standalone server or distributed
   */
  parentType?: string;

  /**
   * Backup status of this backup item.
   */
  protectionStatus?: string;

  /**
   * Backup state of this backup item.
   */
  protectionState?: ProtectionState;

  /**
   * Last backup operation status. Possible values: Healthy, Unhealthy.
   */
  lastBackupStatus?: LastBackupStatus;

  /**
   * Timestamp of the last backup operation on this backup item.
   */
  lastBackupTime?: utcDateTime;

  /**
   * Error details in last backup
   */
  lastBackupErrorDetail?: ErrorDetail;

  /**
   * Data ID of the protected item.
   */
  protectedItemDataSourceId?: string;

  /**
   * Health status of the backup item, evaluated based on last heartbeat received
   */
  protectedItemHealthStatus?: ProtectedItemHealthStatus;

  /**
   * Additional information for this backup item.
   */
  extendedInfo?: AzureVmWorkloadProtectedItemExtendedInfo;

  /**
   * Health details of different KPIs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  kpisHealths?: Record<KpiResourceHealthDetails>;
};

/**
 * Azure VM workload-specific protected item.
 */
model AzureVmWorkloadProtectedItem extends ProtectedItem {
  /**
   * backup item type.
   */
  protectedItemType: "AzureVmWorkloadProtectedItem";

  ...AzureVmWorkloadProtectedItemProperties;
}

/**
 * Error Detail class which encapsulates Code, Message and Recommendations.
 */
model ErrorDetail {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error Message related to the Code.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * List of recommendation strings.
   */
  @visibility(Lifecycle.Read)
  recommendations?: string[];
}

/**
 * Additional information on Azure Workload for SQL specific backup item.
 */
model AzureVmWorkloadProtectedItemExtendedInfo {
  /**
   * The oldest backup copy available for this backup item.
   */
  oldestRecoveryPoint?: utcDateTime;

  /**
   * Number of backup copies available for this backup item.
   */
  recoveryPointCount?: int32;

  /**
   * Indicates consistency of policy object and policy applied to this backup item.
   */
  policyState?: string;
}

/**
 * Azure VM workload-specific protected item representing SAP ASE Database.
 */
model AzureVmWorkloadSapAseDatabaseProtectedItem extends ProtectedItem {
  /**
   * backup item type.
   */
  protectedItemType: "AzureVmWorkloadSAPAseDatabase";

  ...AzureVmWorkloadProtectedItemProperties;
}

/**
 * Azure VM workload-specific protected item representing SAP HANA Database.
 */
model AzureVmWorkloadSapHanaDatabaseProtectedItem extends ProtectedItem {
  /**
   * backup item type.
   */
  protectedItemType: "AzureVmWorkloadSAPHanaDatabase";

  ...AzureVmWorkloadProtectedItemProperties;
}

/**
 * Azure VM workload-specific protected item representing SQL Database.
 */
model AzureVmWorkloadSqlDatabaseProtectedItem extends ProtectedItem {
  /**
   * backup item type.
   */
  protectedItemType: "AzureVmWorkloadSQLDatabase";

  ...AzureVmWorkloadProtectedItemProperties;
}

/**
 * Azure storage specific error information
 */
model AzureWorkloadErrorInfo {
  /**
   * Error code.
   */
  errorCode?: int32;

  /**
   * Localized error string.
   */
  errorString?: string;

  /**
   * Title: Typically, the entity that the error pertains to.
   */
  errorTitle?: string;

  /**
   * List of localized recommendations for above error code.
   */
  recommendations?: string[];

  /**
   * Additional details for above error code.
   */
  additionalDetails?: string;
}

/**
 * Azure storage specific job.
 */
model AzureWorkloadJob extends Job {
  /**
   * Workload type of the job
   */
  workloadType?: string;

  /**
   * Time elapsed during the execution of this job.
   */
  duration?: duration;

  /**
   * Gets or sets the state/actions applicable on this job like cancel/retry.
   */
  actionsInfo?: JobSupportedAction[];

  /**
   * Error details on execution of this job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  errorDetails?: AzureWorkloadErrorInfo[];

  /**
   * Additional information about the job.
   */
  extendedInfo?: AzureWorkloadJobExtendedInfo;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  jobType: "AzureWorkloadJob";
}

/**
 * Azure VM workload-specific additional information for job.
 */
model AzureWorkloadJobExtendedInfo {
  /**
   * List of tasks for this job
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  tasksList?: AzureWorkloadJobTaskDetails[];

  /**
   * Job properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  propertyBag?: Record<string>;

  /**
   * Non localized error message on job execution.
   */
  dynamicErrorMessage?: string;
}

/**
 * Azure VM workload specific job task details.
 */
model AzureWorkloadJobTaskDetails {
  /**
   * The task display name.
   */
  taskId?: string;

  /**
   * The status.
   */
  status?: string;
}

/**
 * Recovery point specific to PointInTime
 */
model AzureWorkloadPointInTimeRecoveryPoint extends RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadPointInTimeRecoveryPoint";

  ...AzureWorkloadRecoveryPointProperties;
  ...AzureWorkloadPointInTimeRecoveryPointProperties;
}

alias AzureWorkloadPointInTimeRecoveryPointProperties = {
  /**
   * List of log ranges
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  timeRanges?: PointInTimeRange[];
};

/**
 * Provides details for log ranges
 */
model PointInTimeRange {
  /**
   * Start time of the time range for log recovery.
   */
  startTime?: utcDateTime;

  /**
   * End time of the time range for log recovery.
   */
  endTime?: utcDateTime;
}

alias AzureWorkloadRecoveryPointProperties = {
  /**
   * UTC time at which recovery point was created
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Faithful migration: this property name is part of the published stable/2023-01-15 wire contract and must be preserved (property casing is API surface)."
  @visibility(Lifecycle.Read)
  recoveryPointTimeInUTC?: utcDateTime;

  /**
   * Type of restore point
   */
  @visibility(Lifecycle.Read)
  type?: RestorePointType;

  /**
   * Recovery point tier information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  recoveryPointTierDetails?: RecoveryPointTierInformation[];

  /**
   * Eligibility of RP to be moved to another tier
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  recoveryPointMoveReadinessInfo?: Record<RecoveryPointMoveReadinessInfo>;

  /**
   * Properties of Recovery Point
   */
  recoveryPointProperties?: RecoveryPointProperties;
};

/**
 * Workload specific recovery point, specifically encapsulates full/diff recovery point
 */
model AzureWorkloadRecoveryPoint extends RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadRecoveryPoint";

  ...AzureWorkloadRecoveryPointProperties;
}

/**
 * Recovery point tier information.
 */
model RecoveryPointTierInformation {
  /**
   * Recovery point tier type.
   */
  type?: RecoveryPointTierType;

  /**
   * Recovery point tier status.
   */
  status?: RecoveryPointTierStatus;

  /**
   * Recovery point tier status.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  extendedInfo?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model RecoveryPointMoveReadinessInfo {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  isReadyForMove?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  additionalInfo?: string;
}

/**
 * AzureWorkload SAP Hana -specific restore. Specifically for PointInTime/Log restore
 */
model AzureWorkloadPointInTimeRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadPointInTimeRestoreRequest";

  /**
   * PointInTime value
   */
  pointInTime?: utcDateTime;

  ...AzureWorkloadRestoreRequestProperties;
}

/**
 * AzureWorkload-specific restore.
 */
model AzureWorkloadRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadRestoreRequest";

  ...AzureWorkloadRestoreRequestProperties;
}

alias AzureWorkloadRestoreRequestProperties = {
  /**
   * Type of this recovery.
   */
  recoveryType?: RecoveryType;

  /**
   * Fully qualified ARM ID of the VM on which workload that was running is being recovered.
   */
  sourceResourceId?: string;

  /**
   * Workload specific property bag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  propertyBag?: Record<string>;

  /**
   * Details of target database
   */
  targetInfo?: TargetRestoreInfo;

  /**
   * Defines whether the current recovery mode is file restore or database restore
   */
  recoveryMode?: RecoveryMode;

  /**
   * This is the complete ARM Id of the target VM
   * For e.g. /subscriptions/{subId}/resourcegroups/{rg}/provider/Microsoft.Compute/virtualmachines/{vm}
   */
  targetVirtualMachineId?: string;
};

/**
 * Details about target workload during restore operation.
 */
model TargetRestoreInfo {
  /**
   * Can Overwrite if Target DataBase already exists
   */
  overwriteOption?: OverwriteOptions;

  /**
   * Resource Id name of the container in which Target DataBase resides
   */
  containerId?: string;

  /**
   * Database name InstanceName/DataBaseName for SQL or System/DbName for SAP Hana
   */
  databaseName?: string;

  /**
   * Target directory location for restore as files.
   */
  targetDirectoryForFileRestore?: string;
}

/**
 * Recovery point specific to PointInTime in SAPHana
 */
model AzureWorkloadSapHanaPointInTimeRecoveryPoint extends RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSAPHanaPointInTimeRecoveryPoint";

  ...AzureWorkloadRecoveryPointProperties;
  ...AzureWorkloadPointInTimeRecoveryPointProperties;
}

alias AzureWorkloadSapHanaPointInTimeRestoreRequestProperties = {
  /**
   * PointInTime value
   */
  pointInTime?: utcDateTime;
};

/**
 * AzureWorkload SAP Hana -specific restore. Specifically for PointInTime/Log restore
 */
model AzureWorkloadSapHanaPointInTimeRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSAPHanaPointInTimeRestoreRequest";

  ...AzureWorkloadSapHanaPointInTimeRestoreRequestProperties;
  ...AzureWorkloadRestoreRequestProperties;
}

/**
 * AzureWorkload SAP Hana-specific restore.
 */
model AzureWorkloadSapHanaRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSAPHanaRestoreRequest";

  ...AzureWorkloadRestoreRequestProperties;
}

/**
 * SAPHana specific recoverypoint, specifically encapsulates full/diff recoverypoints
 */
model AzureWorkloadSapHanaRecoveryPoint extends RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSAPHanaRecoveryPoint";

  ...AzureWorkloadRecoveryPointProperties;
}

/**
 * Recovery point specific to PointInTime
 */
model AzureWorkloadSqlPointInTimeRecoveryPoint extends RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSQLPointInTimeRecoveryPoint";

  /**
   * List of log ranges
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  timeRanges?: PointInTimeRange[];

  ...AzureWorkloadSqlRecoveryPointProperties;
  ...AzureWorkloadRecoveryPointProperties;
}

/**
 * SQL specific recoverypoint, specifically encapsulates full/diff recoverypoint along with extended info
 */
model AzureWorkloadSqlRecoveryPoint extends RecoveryPoint {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSQLRecoveryPoint";

  ...AzureWorkloadSqlRecoveryPointProperties;
  ...AzureWorkloadRecoveryPointProperties;
}

alias AzureWorkloadSqlRecoveryPointProperties = {
  /**
   * Extended Info that provides data directory details. Will be populated in two cases:
   * When a specific recovery point is accessed using GetRecoveryPoint
   * Or when ListRecoveryPoints is called for Log RP only with ExtendedInfo query filter
   */
  extendedInfo?: AzureWorkloadSqlRecoveryPointExtendedInfo;
};

/**
 * Extended info class details
 */
model AzureWorkloadSqlRecoveryPointExtendedInfo {
  /**
   * UTC time at which data directory info was captured
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Faithful migration: this property name is part of the published stable/2023-01-15 wire contract and must be preserved (property casing is API surface)."
  @visibility(Lifecycle.Read)
  dataDirectoryTimeInUTC?: utcDateTime;

  /**
   * List of data directory paths during restore operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  @visibility(Lifecycle.Read)
  dataDirectoryPaths?: SqlDataDirectory[];
}

/**
 * SQLDataDirectory info
 */
model SqlDataDirectory {
  /**
   * Type of data directory mapping
   */
  type?: SQLDataDirectoryType;

  /**
   * File path
   */
  path?: string;

  /**
   * Logical name of the file
   */
  logicalName?: string;
}

alias AzureWorkloadSqlPointInTimeRestoreRequestProperties = {
  /**
   * PointInTime value
   */
  pointInTime?: utcDateTime;
};

/**
 * AzureWorkload SQL -specific restore. Specifically for PointInTime/Log restore
 */
model AzureWorkloadSqlPointInTimeRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSQLPointInTimeRestoreRequest";

  ...AzureWorkloadSqlPointInTimeRestoreRequestProperties;
  ...AzureWorkloadSqlRestoreRequestProperties;
  ...AzureWorkloadRestoreRequestProperties;
}

/**
 * AzureWorkload SQL -specific restore. Specifically for full/diff restore
 */
model AzureWorkloadSqlRestoreRequest extends RestoreRequest {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "AzureWorkloadSQLRestoreRequest";

  ...AzureWorkloadSqlRestoreRequestProperties;
  ...AzureWorkloadRestoreRequestProperties;
}

alias AzureWorkloadSqlRestoreRequestProperties = {
  /**
   * Default option set to true. If this is set to false, alternate data directory must be provided
   */
  shouldUseAlternateTargetLocation?: boolean;

  /**
   * SQL specific property where user can chose to set no-recovery when restore operation is tried
   */
  isNonRecoverable?: boolean;

  /**
   * Data directory details
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  alternateDirectoryPaths?: SqlDataDirectoryMapping[];
};

/**
 * Encapsulates information regarding data directory
 */
model SqlDataDirectoryMapping {
  /**
   * Type of data directory mapping
   */
  mappingType?: SQLDataDirectoryType;

  /**
   * Restore source logical name path
   */
  sourceLogicalName?: string;

  /**
   * Restore source path
   */
  sourcePath?: string;

  /**
   * Target path
   */
  targetPath?: string;
}

/**
 * BEK is bitlocker encryption key.
 */
model BekDetails {
  /**
   * Secret is BEK.
   */
  secretUrl?: string;

  /**
   * ID of the Key Vault where this Secret is stored.
   */
  secretVaultId?: string;

  /**
   * BEK data.
   */
  secretData?: string;
}

/**
 * Filters to list backup copies.
 */
model BmsrpQueryObject {
  /**
   * Backup copies created after this time.
   */
  startDate?: utcDateTime;

  /**
   * Backup copies created before this time.
   */
  endDate?: utcDateTime;

  /**
   * RestorePoint type
   */
  restorePointQueryType?: RestorePointQueryType;

  /**
   * In Get Recovery Point, it tells whether extended information about recovery point is asked.
   */
  extendedInfo?: boolean;

  /**
   * Whether the RP can be moved to another tier
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Faithful migration: preserving the established wire property name from the RecoveryServicesBackup contract; renaming would be a breaking change."
  moveReadyRPOnly?: boolean;

  /**
   * Flag to indicate whether Soft Deleted RPs should be included/excluded from result.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Faithful migration: preserving the established wire property name from the RecoveryServicesBackup contract; renaming would be a breaking change."
  includeSoftDeletedRP?: boolean;
}

/**
 * Request object for fetching CRR jobs.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Non-discriminated resource envelope wrapper on a passive stamp: `extends` preserves the emitted allOf composition; `is`/spread would inline the base and `@discriminator` would mis-declare a non-polymorphic base."
model CrrJobRequestResource extends Resource {
  /**
   * CrrJobRequestResource properties
   */
  properties?: CrrJobRequest;
}

/**
 * Client script details for file / folder restore.
 */
model ClientScriptForConnect {
  /**
   * File content of the client script for file / folder restore.
   */
  scriptContent?: string;

  /**
   * File extension of the client script for file / folder restore - .ps1 , .sh , etc.
   */
  scriptExtension?: string;

  /**
   * OS type - Windows, Linux etc. for which this file / folder restore client script works.
   */
  osType?: string;

  /**
   * URL of Executable from where to source the content. If this is not null then ScriptContent should not be used
   */
  url?: string;

  /**
   * Mandatory suffix that should be added to the name of script that is given for download to user.
   * If its null or empty then , ignore it.
   */
  scriptNameSuffix?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Non-discriminated resource envelope wrapper on a passive stamp: `extends` preserves the emitted allOf composition; `is`/spread would inline the base and `@discriminator` would mis-declare a non-polymorphic base."
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CrossRegionRestoreRequestResource extends Resource {
  /**
   * CrossRegionRestoreRequestResource properties
   */
  properties?: CrossRegionRestoreRequest;
}

/**
 * Disk information
 */
model DiskInformation {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  lun?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  name?: string;
}

/**
 * DPM workload-specific error information.
 */
model DpmErrorInfo {
  /**
   * Localized error string.
   */
  errorString?: string;

  /**
   * List of localized recommendations for above error code.
   */
  recommendations?: string[];
}

/**
 * DPM workload-specific job object.
 */
model DpmJob extends Job {
  /**
   * Time elapsed for job.
   */
  duration?: duration;

  /**
   * DPM server name managing the backup item or backup job.
   */
  dpmServerName?: string;

  /**
   * Name of cluster/server protecting current backup item, if any.
   */
  containerName?: string;

  /**
   * Type of container.
   */
  containerType?: string;

  /**
   * Type of backup item.
   */
  workloadType?: string;

  /**
   * The state/actions applicable on this job like cancel/retry.
   */
  actionsInfo?: JobSupportedAction[];

  /**
   * The errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  errorDetails?: DpmErrorInfo[];

  /**
   * Additional information for this job.
   */
  extendedInfo?: DpmJobExtendedInfo;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  jobType: "DpmJob";
}

/**
 * Additional information on the DPM workload-specific job.
 */
model DpmJobExtendedInfo {
  /**
   * List of tasks associated with this job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  tasksList?: DpmJobTaskDetails[];

  /**
   * The job properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  propertyBag?: Record<string>;

  /**
   * Non localized error message on job execution.
   */
  dynamicErrorMessage?: string;
}

/**
 * DPM workload-specific job task details.
 */
model DpmJobTaskDetails {
  /**
   * The task display name.
   */
  taskId?: string;

  /**
   * The start time.
   */
  startTime?: utcDateTime;

  /**
   * The end time.
   */
  endTime?: utcDateTime;

  /**
   * Time elapsed for task.
   */
  duration?: duration;

  /**
   * The status.
   */
  status?: string;
}

/**
 * Additional information on Backup engine specific backup item.
 */
model DpmProtectedItem extends ProtectedItem {
  /**
   * Friendly name of the managed item
   */
  friendlyName?: string;

  /**
   * Backup Management server protecting this backup item
   */
  backupEngineName?: string;

  /**
   * Protection state of the backup engine
   */
  protectionState?: ProtectedItemState;

  /**
   * Extended info of the backup item.
   */
  extendedInfo?: DpmProtectedItemExtendedInfo;

  /**
   * backup item type.
   */
  protectedItemType: "DPMProtectedItem";
}

/**
 * Additional information of DPM Protected item.
 */
model DpmProtectedItemExtendedInfo {
  /**
   * Attribute to provide information on various DBs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  protectableObjectLoadPath?: Record<string>;

  /**
   * To check if backup item is disk protected.
   */
  protected?: boolean;

  /**
   * To check if backup item is cloud protected.
   */
  isPresentOnCloud?: boolean;

  /**
   * Last backup status information on backup item.
   */
  lastBackupStatus?: string;

  /**
   * Last refresh time on backup item.
   */
  lastRefreshedAt?: utcDateTime;

  /**
   * Oldest cloud recovery point time.
   */
  oldestRecoveryPoint?: utcDateTime;

  /**
   * cloud recovery point count.
   */
  recoveryPointCount?: int32;

  /**
   * Oldest disk recovery point time.
   */
  onPremiseOldestRecoveryPoint?: utcDateTime;

  /**
   * latest disk recovery point time.
   */
  onPremiseLatestRecoveryPoint?: utcDateTime;

  /**
   * disk recovery point count.
   */
  onPremiseRecoveryPointCount?: int32;

  /**
   * To check if backup item is collocated.
   */
  isCollocated?: boolean;

  /**
   * Protection group name of the backup item.
   */
  protectionGroupName?: string;

  /**
   * Used Disk storage in bytes.
   */
  diskStorageUsedInBytes?: string;

  /**
   * total Disk storage in bytes.
   */
  totalDiskStorageSizeInBytes?: string;
}

/**
 * Details needed if the VM was encrypted at the time of backup.
 */
model EncryptionDetails {
  /**
   * Identifies whether this backup copy represents an encrypted VM at the time of backup.
   */
  encryptionEnabled?: boolean;

  /**
   * Key Url.
   */
  kekUrl?: string;

  /**
   * Secret Url.
   */
  secretKeyUrl?: string;

  /**
   * ID of Key Vault where KEK is stored.
   */
  kekVaultId?: string;

  /**
   * ID of Key Vault where Secret is stored.
   */
  secretKeyVaultId?: string;
}

/**
 * Base class for backup items.
 */
model GenericProtectedItem extends ProtectedItem {
  /**
   * Friendly name of the container.
   */
  friendlyName?: string;

  /**
   * Indicates consistency of policy object and policy applied to this backup item.
   */
  policyState?: string;

  /**
   * Backup state of this backup item.
   */
  protectionState?: ProtectionState;

  /**
   * Data Plane Service ID of the protected item.
   */
  protectedItemId?: int64;

  /**
   * Loosely coupled (type, value) associations (example - parent of a protected item)
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  sourceAssociations?: Record<string>;

  /**
   * Name of this backup item's fabric.
   */
  fabricName?: string;

  /**
   * backup item type.
   */
  protectedItemType: "GenericProtectedItem";
}

/**
 * Generic backup copy.
 */
model GenericRecoveryPoint extends RecoveryPoint {
  /**
   * Friendly name of the backup copy.
   */
  friendlyName?: string;

  /**
   * Type of the backup copy.
   */
  recoveryPointType?: string;

  /**
   * Time at which this backup copy was created.
   */
  recoveryPointTime?: utcDateTime;

  /**
   * Additional information associated with this backup copy.
   */
  recoveryPointAdditionalInfo?: string;

  /**
   * Properties of Recovery Point
   */
  recoveryPointProperties?: RecoveryPointProperties;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "GenericRecoveryPoint";
}

/**
 * IaaS VM workload specific backup copy.
 */
model IaasVmRecoveryPoint extends RecoveryPoint {
  /**
   * Type of the backup copy.
   */
  @visibility(Lifecycle.Read)
  recoveryPointType?: string;

  /**
   * Time at which this backup copy was created.
   */
  @visibility(Lifecycle.Read)
  recoveryPointTime?: utcDateTime;

  /**
   * Additional information associated with this backup copy.
   */
  @visibility(Lifecycle.Read)
  recoveryPointAdditionalInfo?: string;

  /**
   * Storage type of the VM whose backup copy is created.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Faithful migration: this property name is part of the published stable/2023-01-15 wire contract and must be preserved (property casing is API surface)."
  @visibility(Lifecycle.Read)
  sourceVMStorageType?: string;

  /**
   * Identifies whether the VM was encrypted when the backup copy is created.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Faithful migration: this property name is part of the published stable/2023-01-15 wire contract and must be preserved (property casing is API surface)."
  @visibility(Lifecycle.Read)
  isSourceVMEncrypted?: boolean;

  /**
   * Required details for recovering an encrypted VM. Applicable only when IsSourceVMEncrypted is true.
   */
  keyAndSecret?: KeyAndSecretDetails;

  /**
   * Is the session to recover items from this backup copy still active.
   */
  isInstantIlrSessionActive?: boolean;

  /**
   * Recovery point tier information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  recoveryPointTierDetails?: RecoveryPointTierInformation[];

  /**
   * Whether VM is with Managed Disks
   */
  isManagedVirtualMachine?: boolean;

  /**
   * Virtual Machine Size
   */
  virtualMachineSize?: string;

  /**
   * Original Storage Account Option
   */
  originalStorageAccountOption?: boolean;

  /**
   * OS type
   */
  osType?: string;

  /**
   * Disk configuration
   */
  recoveryPointDiskConfiguration?: RecoveryPointDiskConfiguration;

  /**
   * Identifies the zone of the VM at the time of backup. Applicable only for zone-pinned Vms
   */
  zones?: string[];

  /**
   * Eligibility of RP to be moved to another tier
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  recoveryPointMoveReadinessInfo?: Record<RecoveryPointMoveReadinessInfo>;

  /**
   * Properties of Recovery Point
   */
  recoveryPointProperties?: RecoveryPointProperties;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "IaasVMRecoveryPoint";
}

/**
 * BEK is bitlocker key.
 * KEK is encryption key for BEK
 * If the VM was encrypted then we will store following details :
 * 1. Secret(BEK) - Url + Backup Data + vaultId.
 * 2. Key(KEK) - Url + Backup Data + vaultId.
 * 3. EncryptionMechanism
 * BEK and KEK can potentially have different vault ids.
 */
model KeyAndSecretDetails {
  /**
   * KEK is encryption key for BEK.
   */
  kekDetails?: KekDetails;

  /**
   * BEK is bitlocker encryption key.
   */
  bekDetails?: BekDetails;

  /**
   * Encryption mechanism: None/ SinglePass/ DoublePass
   */
  encryptionMechanism?: string;
}

/**
 * KEK is encryption key for BEK.
 */
model KekDetails {
  /**
   * Key is KEK.
   */
  keyUrl?: string;

  /**
   * Key Vault ID where this Key is stored.
   */
  keyVaultId?: string;

  /**
   * KEK data.
   */
  keyBackupData?: string;
}

/**
 * Disk configuration
 */
model RecoveryPointDiskConfiguration {
  /**
   * Number of disks included in backup
   */
  numberOfDisksIncludedInBackup?: int32;

  /**
   * Number of disks attached to the VM
   */
  numberOfDisksAttachedToVm?: int32;

  /**
   * Information of disks included in backup
   */
  includedDiskList?: DiskInformation[];

  /**
   * Information of disks excluded from backup
   */
  excludedDiskList?: DiskInformation[];
}

/**
 * IaaS VM workload-specific restore.
 */
model IaasVmRestoreRequest extends RestoreRequest {
  /**
   * ID of the backup copy to be recovered.
   */
  recoveryPointId?: string;

  /**
   * Type of this recovery.
   */
  recoveryType?: RecoveryType;

  /**
   * Fully qualified ARM ID of the VM which is being recovered.
   */
  sourceResourceId?: string;

  /**
   * This is the complete ARM Id of the VM that will be created.
   * For e.g. /subscriptions/{subId}/resourcegroups/{rg}/provider/Microsoft.Compute/virtualmachines/{vm}
   */
  targetVirtualMachineId?: string;

  /**
   * This is the ARM Id of the resource group that you want to create for this Virtual machine and other artifacts.
   * For e.g. /subscriptions/{subId}/resourcegroups/{rg}
   */
  targetResourceGroupId?: string;

  /**
   * Fully qualified ARM ID of the storage account to which the VM has to be restored.
   */
  storageAccountId?: string;

  /**
   * This is the virtual network Id of the vnet that will be attached to the virtual machine.
   * User will be validated for join action permissions in the linked access.
   */
  virtualNetworkId?: string;

  /**
   * Subnet ID, is the subnet ID associated with the to be restored VM. For Classic VMs it would be
   * {VnetID}/Subnet/{SubnetName} and, for the Azure Resource Manager VMs it would be ARM resource ID used to represent
   * the subnet.
   */
  subnetId?: string;

  /**
   * Fully qualified ARM ID of the domain name to be associated to the VM being restored. This applies only to Classic
   * Virtual Machines.
   */
  targetDomainNameId?: string;

  /**
   * Region in which the virtual machine is restored.
   */
  region?: string;

  /**
   * Affinity group associated to VM to be restored. Used only for Classic Compute Virtual Machines.
   */
  affinityGroup?: string;

  /**
   * Should a new cloud service be created while restoring the VM. If this is false, VM will be restored to the same
   * cloud service as it was at the time of backup.
   */
  createNewCloudService?: boolean;

  /**
   * Original Storage Account Option
   */
  originalStorageAccountOption?: boolean;

  /**
   * Details needed if the VM was encrypted at the time of backup.
   */
  encryptionDetails?: EncryptionDetails;

  /**
   * List of Disk LUNs for partial restore
   */
  restoreDiskLunList?: int32[];

  /**
   * Flag to denote of an Unmanaged disk VM should be restored with Managed disks.
   */
  restoreWithManagedDisks?: boolean;

  /**
   * DiskEncryptionSet's ID - needed if the VM needs to be encrypted at rest during restore with customer managed key.
   */
  diskEncryptionSetId?: string;

  /**
   * Target zone where the VM and its disks should be restored.
   */
  zones?: string[];

  /**
   * Managed Identity information required to access customer storage account.
   */
  identityInfo?: IdentityInfo;

  /**
   * IaaS VM workload specific restore details for restores using managed identity.
   */
  identityBasedRestoreDetails?: IdentityBasedRestoreDetails;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "IaasVMRestoreRequest";
}

/**
 * Encapsulates Managed Identity related information
 */
model IdentityInfo {
  /**
   * To differentiate if the managed identity is system assigned or user assigned
   */
  isSystemAssignedIdentity?: boolean;

  /**
   * Managed Identity Resource Id
   * Optional: Might not be required in the case of system assigned managed identity
   */
  managedIdentityResourceId?: string;
}

/**
 * IaaS VM workload specific restore details for restores using managed identity
 */
model IdentityBasedRestoreDetails {
  /**
   * Gets the class type.
   */
  objectType?: string;

  /**
   * Fully qualified ARM ID of the target storage account.
   */
  targetStorageAccountId?: string;
}

/**
 * Target details for file / folder restore.
 */
model InstantItemRecoveryTarget {
  /**
   * List of client scripts.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  clientScripts?: ClientScriptForConnect[];
}

/**
 * Filters to list backup items.
 */
model BmsAadPropertiesQueryObject {
  /**
   * Backup management type for the backed up item.
   */
  backupManagementType?: BackupManagementType;
}

/**
 * Filters to list the jobs.
 */
model JobQueryObject {
  /**
   * Status of the job.
   */
  status?: JobStatus;

  /**
   * Type of backup management for the job.
   */
  backupManagementType?: BackupManagementType;

  /**
   * Type of operation.
   */
  operation?: JobOperationType;

  /**
   * JobID represents the job uniquely.
   */
  jobId?: string;

  /**
   * Job has started at this time. Value is in UTC.
   */
  startTime?: utcDateTime;

  /**
   * Job has ended at this time. Value is in UTC.
   */
  endTime?: utcDateTime;
}

/**
 * MAB workload-specific error information.
 */
model MabErrorInfo {
  /**
   * Localized error string.
   */
  @visibility(Lifecycle.Read)
  errorString?: string;

  /**
   * List of localized recommendations.
   */
  @visibility(Lifecycle.Read)
  recommendations?: string[];
}

/**
 * MAB workload-specific backup item.
 */
model MabFileFolderProtectedItem extends ProtectedItem {
  /**
   * Friendly name of this backup item.
   */
  friendlyName?: string;

  /**
   * Name of the computer associated with this backup item.
   */
  computerName?: string;

  /**
   * Status of last backup operation.
   */
  lastBackupStatus?: string;

  /**
   * Timestamp of the last backup operation on this backup item.
   */
  lastBackupTime?: utcDateTime;

  /**
   * Protected, ProtectionStopped, IRPending or ProtectionError
   */
  protectionState?: string;

  /**
   * Sync time for deferred deletion in UTC
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Faithful migration: this property name is part of the published stable/2023-01-15 wire contract and must be preserved (property casing is API surface)."
  deferredDeleteSyncTimeInUTC?: int64;

  /**
   * Additional information with this backup item.
   */
  extendedInfo?: MabFileFolderProtectedItemExtendedInfo;

  /**
   * backup item type.
   */
  protectedItemType: "MabFileFolderProtectedItem";
}

/**
 * Additional information on the backed up item.
 */
model MabFileFolderProtectedItemExtendedInfo {
  /**
   * Last time when the agent data synced to service.
   */
  lastRefreshedAt?: utcDateTime;

  /**
   * The oldest backup copy available.
   */
  oldestRecoveryPoint?: utcDateTime;

  /**
   * Number of backup copies associated with the backup item.
   */
  recoveryPointCount?: int32;
}

/**
 * MAB workload-specific job.
 */
model MabJob extends Job {
  /**
   * Time taken by job to run.
   */
  duration?: duration;

  /**
   * The state/actions applicable on jobs like cancel/retry.
   */
  actionsInfo?: JobSupportedAction[];

  /**
   * Name of server protecting the DS.
   */
  mabServerName?: string;

  /**
   * Server type of MAB container.
   */
  mabServerType?: MabServerType;

  /**
   * Workload type of backup item.
   */
  workloadType?: WorkloadType;

  /**
   * The errors.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  errorDetails?: MabErrorInfo[];

  /**
   * Additional information on the job.
   */
  extendedInfo?: MabJobExtendedInfo;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  jobType: "MabJob";
}

/**
 * Additional information for the MAB workload-specific job.
 */
model MabJobExtendedInfo {
  /**
   * List of tasks for this job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Faithful migration: the original array property has no x-ms-identifiers in stable/2023-01-15; emitting identifiers would change the frozen contract."
  tasksList?: MabJobTaskDetails[];

  /**
   * The job properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  propertyBag?: Record<string>;

  /**
   * Non localized error message specific to this job.
   */
  dynamicErrorMessage?: string;
}

/**
 * MAB workload-specific job task details.
 */
model MabJobTaskDetails {
  /**
   * The task display name.
   */
  taskId?: string;

  /**
   * The start time.
   */
  startTime?: utcDateTime;

  /**
   * The end time.
   */
  endTime?: utcDateTime;

  /**
   * Time elapsed for task.
   */
  duration?: duration;

  /**
   * The status.
   */
  status?: string;
}

/**
 * Operation status job extended info.
 */
model OperationStatusJobExtendedInfo extends OperationStatusExtendedInfo {
  /**
   * ID of the job created for this protected item.
   */
  jobId?: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "OperationStatusJobExtendedInfo";
}

/**
 * Operation status extended info for list of jobs.
 */
model OperationStatusJobsExtendedInfo extends OperationStatusExtendedInfo {
  /**
   * IDs of the jobs created for the protected item.
   */
  jobIds?: string[];

  /**
   * Stores all the failed jobs along with the corresponding error codes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  failedJobsError?: Record<string>;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "OperationStatusJobsExtendedInfo";
}

/**
 * Operation status extended info for ILR provision action.
 */
model OperationStatusProvisionIlrExtendedInfo
  extends OperationStatusExtendedInfo {
  /**
   * Target details for file / folder restore.
   */
  recoveryTarget?: InstantItemRecoveryTarget;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "OperationStatusProvisionILRExtendedInfo";
}

/**
 * Operation status extended info for Updated Recovery Point.
 */
model OperationStatusRecoveryPointExtendedInfo
  extends OperationStatusExtendedInfo {
  /**
   * Recovery Point info with updated source snapshot URI
   */
  updatedRecoveryPoint?: RecoveryPoint;

  /**
   * In case the share is in soft-deleted state, populate this field with deleted backup item
   */
  deletedBackupItemVersion?: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "OperationStatusRecoveryPointExtendedInfo";
}

/**
 * Filters to list backup items.
 */
model ProtectedItemQueryObject {
  /**
   * Health State for the backed up item.
   */
  healthState?: HealthState;

  /**
   * Backup management type for the backed up item.
   */
  backupManagementType?: BackupManagementType;

  /**
   * Type of workload this item represents.
   */
  itemType?: DataSourceType;

  /**
   * Backup policy name associated with the backup item.
   */
  policyName?: string;

  /**
   * Name of the container.
   */
  containerName?: string;

  /**
   * Backup Engine name
   */
  backupEngineName?: string;

  /**
   * Friendly name of protected item
   */
  friendlyName?: string;

  /**
   * Name of the fabric.
   */
  fabricName?: string;

  /**
   * Name of the backup set.
   */
  backupSetName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model WorkloadCrrAccessToken extends CrrAccessToken {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  protectableObjectUniqueName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  protectableObjectFriendlyName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  protectableObjectWorkloadType?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  protectableObjectProtectionState?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  protectableObjectContainerHostOsName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  protectableObjectParentLogicalContainerName?: string;

  /**
   * Container Id
   */
  containerId?: string;

  /**
   * Policy Name
   */
  policyName?: string;

  /**
   * Policy Id
   */
  policyId?: string;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "WorkloadCrrAccessToken";
}
