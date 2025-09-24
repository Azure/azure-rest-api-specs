import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ClientGenerator.Core;

namespace Microsoft.DBforMySQL;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AdministratorName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ActiveDirectory: "ActiveDirectory",
}

/**
 * Type of the sever administrator.
 */
union AdministratorType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ActiveDirectory: "ActiveDirectory",
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

/**
 * Backup Format for the current backup. (CollatedFormat is INTERNAL – DO NOT USE)
 */
union BackupFormat {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CollatedFormat: "CollatedFormat",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Raw: "Raw",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union BackupType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FULL: "FULL",
}

/**
 * The current provisioning state.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * Source of the configuration.
 */
union ConfigurationSource {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `system-default`: "system-default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `user-override`: "user-override",
}

/**
 * If is the configuration read only.
 */
union IsReadOnly {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * If is the configuration pending restart or not.
 */
union IsConfigPendingRestart {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * If is the configuration dynamic.
 */
union IsDynamicConfig {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * Whether to reset all server parameters to default.
 */
union ResetAllToDefault {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * Type of managed service identity.
 */
union ManagedServiceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserAssigned: "UserAssigned",
}

/**
 * The tier of the particular SKU, e.g. GeneralPurpose.
 */
union ServerSkuTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Burstable: "Burstable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GeneralPurpose: "GeneralPurpose",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MemoryOptimized: "MemoryOptimized",
}

/**
 * The major version of a server. 8.0.21 stands for MySQL 8.0, 5.7.44 stands for MySQL 5.7
 */
union ServerVersion {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `5.7`: "5.7",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `8.0.21`: "8.0.21",
}

/**
 * The mode to create a new MySQL server.
 */
union CreateMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PointInTimeRestore: "PointInTimeRestore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Replica: "Replica",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GeoRestore: "GeoRestore",
}

/**
 * The replication role.
 */
union ReplicationRole {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Source: "Source",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Replica: "Replica",
}

/**
 * The state of a server.
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
}

/**
 * Enum to indicate whether value is 'Enabled' or 'Disabled'
 */
union EnableStatusEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Enum to indicate whether storage sku value is 'ZoneRedundancy' or 'LocalRedundancy'
 */
union StorageRedundancyEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LocalRedundancy: "LocalRedundancy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ZoneRedundancy: "ZoneRedundancy",
}

/**
 * High availability mode for a server.
 */
union HighAvailabilityMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ZoneRedundant: "ZoneRedundant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SameZone: "SameZone",
}

/**
 * The state of server high availability.
 */
union HighAvailabilityState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotEnabled: "NotEnabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CreatingStandby: "CreatingStandby",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Healthy: "Healthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FailingOver: "FailingOver",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RemovingStandby: "RemovingStandby",
}

/**
 * Enum to indicate the patch strategy of a server
 */
union PatchStrategy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Regular: "Regular",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VirtualCanary: "VirtualCanary",
}

/**
 * The batch of maintenance when enabled the custom managed maintenance window of a server.
 */
union BatchOfMaintenance {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Batch1: "Batch1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Batch2: "Batch2",
}

/**
 * Storage type of import source.
 */
union ImportSourceStorageType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBlob: "AzureBlob",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AdvancedThreatProtectionName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
}

/**
 * Specifies the state of the Advanced Threat Protection, whether it is enabled or disabled on the server.
 */
union AdvancedThreatProtectionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The current provisioning state.
 */
union AdvancedThreatProtectionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * Identifies the type of source operation
 */
union ObjectType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BackupAndExportResponse: "BackupAndExportResponse",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ImportFromStorageResponse: "ImportFromStorageResponse",
}

/**
 * The type of this maintenance.
 */
union MaintenanceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RoutineMaintenance: "RoutineMaintenance",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MinorVersionUpgrade: "MinorVersionUpgrade",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SecurityPatches: "SecurityPatches",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HotFixes: "HotFixes",
}

/**
 * The current status of this maintenance.
 */
union MaintenanceState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scheduled: "Scheduled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReScheduled: "ReScheduled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InPreparation: "InPreparation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Processing: "Processing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union MaintenanceProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * The operation status
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum OperationStatus {
  /**
   * The operation has been accepted but hasn't started.
   */
  Pending,

  /**
   * The operation is running
   */
  InProgress,

  /**
   * The operation Succeeded
   */
  Succeeded,

  /**
   * The operation Failed
   */
  Failed,

  /**
   * The cancellation in progress
   */
  CancelInProgress,

  /**
   * The operation has been Canceled
   */
  Canceled,
}

/**
 * The key type, AzureKeyVault for enable cmk, SystemManaged for disable cmk.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DataEncryptionType {
  AzureKeyVault,
  SystemManaged,
}

/**
 * The properties of an administrator.
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
  login?: string;

  /**
   * SID (object ID) of the server administrator.
   */
  sid?: string;

  /**
   * Tenant ID of the administrator.
   */
  tenantId?: string;

  /**
   * The resource id of the identity used for AAD Authentication.
   */
  identityResourceId?: string;
}

/**
 * The properties of a server backup.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerBackupProperties {
  /**
   * Backup type.
   */
  backupType?: string;

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
 * BackupAndExport API Request
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupAndExportRequest extends BackupRequestBase {
  /**
   * Backup Target Store Details
   */
  targetDetails: BackupStoreDetails;
}

/**
 * Details about the target where the backup content will be stored.
 */
@discriminator("objectType")
model BackupStoreDetails {
  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

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
 * Backup Settings
 */
model BackupSettings {
  /**
   * The name of the backup.
   */
  @pattern("(^[a-z0-9]$)|(^[a-z0-9][a-z0-9-]*[a-z0-9]$)")
  backupName: string;

  /**
   * Backup Format for the current backup. (CollatedFormat is INTERNAL – DO NOT USE)
   */
  backupFormat?: BackupFormat;
}

/**
 * Represents BackupAndExportAPI Response
 */
model BackupAndExportResponse
  is Azure.ResourceManager.ProxyResource<BackupAndExportResponseProperties> {
  ...ErrorResponse;

  /**
   * The name of the backup and export response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/resource-name" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @key("backupAndExportResponseName")
  @segment("backupAndExportResponses")
  name: string;

  /**
   * The operation status
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  status?: OperationStatus;

  /**
   * Start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  startTime?: utcDateTime;

  /**
   * End time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endTime?: utcDateTime;

  /**
   * Operation progress (0-100).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @maxValue(100)
  @minValue(0)
  percentComplete?: float64;
}

/**
 * BackupAndExport Response Properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupAndExportResponseProperties {
  /**
   * Size of datasource in bytes
   */
  datasourceSizeInBytes?: int64;

  /**
   * Data transferred in bytes
   */
  dataTransferredInBytes?: int64;

  /**
   * Metadata related to backup to be stored for restoring resource in key-value pairs.
   */
  backupMetadata?: string;
}

/**
 * Represents ValidateBackup API Response
 */
model ValidateBackupResponse {
  /**
   * The response properties of a pre backup operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ValidateBackupResponseProperties;
}

/**
 * ValidateBackup Response Properties
 */
model ValidateBackupResponseProperties {
  /**
   * Estimated no of storage containers required for resource data to be backed up.
   */
  numberOfContainers?: int32;
}

/**
 * The properties of a server backup.
 */
model ServerBackupPropertiesV2 {
  /**
   * Backup name
   */
  backupNameV2?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  backupType?: BackupType;

  /**
   * Backup completed time (ISO8601 format).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completedTime?: utcDateTime;

  /**
   * Backup source
   */
  source?: string;

  /**
   * The provisioning state of backup resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The properties of a configuration.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConfigurationProperties {
  /**
   * Value of the configuration.
   */
  value?: string;

  /**
   * Current value of the configuration.
   */
  currentValue?: string;

  /**
   * Description of the configuration.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The link used to get the document from community or Azure site.
   */
  @visibility(Lifecycle.Read)
  documentationLink?: string;

  /**
   * Default value of the configuration.
   */
  @visibility(Lifecycle.Read)
  defaultValue?: string;

  /**
   * Data type of the configuration.
   */
  @visibility(Lifecycle.Read)
  dataType?: string;

  /**
   * Allowed values of the configuration.
   */
  @visibility(Lifecycle.Read)
  allowedValues?: string;

  /**
   * Source of the configuration.
   */
  source?: ConfigurationSource;

  /**
   * If is the configuration read only.
   */
  @visibility(Lifecycle.Read)
  isReadOnly?: IsReadOnly;

  /**
   * If is the configuration pending restart or not.
   */
  @visibility(Lifecycle.Read)
  isConfigPendingRestart?: IsConfigPendingRestart;

  /**
   * If is the configuration dynamic.
   */
  @visibility(Lifecycle.Read)
  isDynamicConfig?: IsDynamicConfig;
}

/**
 * A list of server configurations to update.
 */
model ConfigurationListForBatchUpdate {
  /**
   * The list of server configurations.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  value?: ConfigurationForBatchUpdate[];

  /**
   * Whether to reset all server parameters to default.
   */
  resetAllToDefault?: ResetAllToDefault;
}

/**
 * Represents a Configuration.
 */
model ConfigurationForBatchUpdate {
  /**
   * Name of the configuration.
   */
  name?: string;

  /**
   * The properties can be updated for a configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ConfigurationForBatchUpdateProperties;
}

/**
 * The properties can be updated for a configuration.
 */
model ConfigurationForBatchUpdateProperties {
  /**
   * Value of the configuration.
   */
  @doc("Value of the configuration.")
  value?: string;

  /**
   * Source of the configuration.
   */
  @doc("Source of the configuration.")
  source?: string;
}

/**
 * The properties of a database.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseProperties {
  /**
   * The charset of the database.
   */
  charset?: string;

  /**
   * The collation of the database.
   */
  collation?: string;
}

/**
 * The properties of a server firewall rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Properties to configure Identity for Bring your Own Keys
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MySQLServerIdentity {
  /**
   * ObjectId from the KeyVault
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * TenantId from the KeyVault
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Type of managed service identity.
   */
  type?: ManagedServiceIdentityType;

  /**
   * Metadata of user assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Billing information related properties of a server.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MySQLServerSku {
  /**
   * The name of the sku, e.g. Standard_D32s_v3.
   */
  name: string;

  /**
   * The tier of the particular SKU, e.g. GeneralPurpose.
   */
  tier: ServerSkuTier;
}

/**
 * The properties of a server.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerProperties {
  /**
   * The administrator's login name of a server. Can only be specified when the server is being created (and is required for creation).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorLogin?: string;

  /**
   * The password of the administrator login (required for server creation).
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  administratorLoginPassword?: string;

  /**
   * Major version of MySQL. 8.0.21 stands for MySQL 8.0, 5.7.44 stands for MySQL 5.7
   */
  version?: ServerVersion;

  /**
   * Major version and actual engine version
   */
  @visibility(Lifecycle.Read)
  fullVersion?: string;

  /**
   * availability Zone information of the server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  availabilityZone?: string;

  /**
   * The mode to create a new MySQL server.
   */
  @visibility(Lifecycle.Create)
  createMode?: CreateMode;

  /**
   * The source MySQL server id.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceServerResourceId?: string;

  /**
   * Restore point creation time (ISO8601 format), specifying the time to restore from.
   */
  @visibility(Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restorePointInTime?: utcDateTime;

  /**
   * The replication role.
   */
  replicationRole?: ReplicationRole;

  /**
   * The maximum number of replicas that a primary server can have.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  replicaCapacity?: int32;

  /**
   * The Data Encryption for CMK.
   */
  dataEncryption?: DataEncryption;

  /**
   * The state of a server.
   */
  @visibility(Lifecycle.Read)
  state?: ServerState;

  /**
   * The fully qualified domain name of a server.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  /**
   * The server database port. Can only be specified when the server is being created.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  databasePort?: int32;

  /**
   * Storage related properties of a server.
   */
  storage?: Storage;

  /**
   * Backup related properties of a server.
   */
  backup?: Backup;

  /**
   * High availability related properties of a server.
   */
  highAvailability?: HighAvailability;

  /**
   * Network related properties of a server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  network?: Network;

  /**
   * PrivateEndpointConnections related properties of a server.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Maintenance policy of a server.
   */
  maintenancePolicy?: MaintenancePolicy;

  /**
   * Maintenance window of a server. Known issue: cannot be set during server creation or updated with other properties during server update; must be updated separately.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  maintenanceWindow?: MaintenanceWindow;

  /**
   * Source properties for import from storage.
   */
  importSourceProperties?: ImportSourceProperties;
}

/**
 * The date encryption for cmk.
 */
model DataEncryption {
  /**
   * Primary user identity resource id
   */
  primaryUserAssignedIdentityId?: string;

  /**
   * Primary key uri
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  primaryKeyURI?: string;

  /**
   * Geo backup user identity resource id as identity can't cross region, need identity in same region as geo backup
   */
  geoBackupUserAssignedIdentityId?: string;

  /**
   * Geo backup key uri as key vault can't cross region, need cmk in same region as geo backup
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  geoBackupKeyURI?: string;

  /**
   * The key type, AzureKeyVault for enable cmk, SystemManaged for disable cmk.
   */
  type?: DataEncryptionType;
}

/**
 * Storage Profile properties of a server
 */
model Storage {
  /**
   * Max storage size allowed for a server.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageSizeGB?: int32;

  /**
   * Storage IOPS for a server.
   */
  iops?: int32;

  /**
   * Enable Storage Auto Grow or not.
   */
  autoGrow?: EnableStatusEnum = "Disabled";

  /**
   * Enable Log On Disk or not.
   */
  logOnDisk?: EnableStatusEnum = "Disabled";

  /**
   * The sku name of the server storage.
   */
  @visibility(Lifecycle.Read)
  storageSku?: string;

  /**
   * Enable IO Auto Scaling or not.
   */
  autoIoScaling?: EnableStatusEnum = "Enabled";

  /**
   * The redundant type of the server storage. The parameter is used for server creation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageRedundancy?: StorageRedundancyEnum = "LocalRedundancy";
}

/**
 * Storage Profile properties of a server
 */
model Backup {
  /**
   * Backup retention days for the server.
   */
  backupRetentionDays?: int32;

  /**
   * Backup interval hours for the server.
   */
  backupIntervalHours?: int32;

  /**
   * Whether or not geo redundant backup is enabled.
   */
  geoRedundantBackup?: EnableStatusEnum = "Disabled";

  /**
   * Earliest restore point creation time (ISO8601 format)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;
}

/**
 * High availability properties of a server
 */
model HighAvailability {
  /**
   * High availability mode for a server.
   */
  mode?: HighAvailabilityMode;

  /**
   * The state of server high availability.
   */
  @visibility(Lifecycle.Read)
  state?: HighAvailabilityState;

  /**
   * Availability zone of the standby server.
   */
  standbyAvailabilityZone?: string;
}

/**
 * Network related properties of a server
 */
model Network {
  /**
   * Whether or not public network access is allowed for this server. Value is 'Disabled' when server has VNet integration.
   */
  publicNetworkAccess?: EnableStatusEnum;

  /**
   * Delegated subnet resource id used to setup vnet for a server.
   */
  delegatedSubnetResourceId?: string;

  /**
   * Private DNS zone resource id.
   */
  privateDnsZoneResourceId?: string;
}

/**
 * Maintenance policy of a server.
 */
model MaintenancePolicy {
  /**
   * The patch strategy of this server
   */
  patchStrategy?: PatchStrategy;
}

/**
 * Maintenance window of a server.
 */
model MaintenanceWindow {
  /**
   * indicates whether custom window is enabled or disabled
   */
  customWindow?: string;

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

  /**
   * The batch of maintenance when enabled the custom managed maintenance window of a server.
   */
  batchOfMaintenance?: BatchOfMaintenance;
}

/**
 * Import source related properties.
 */
model ImportSourceProperties {
  /**
   * Storage type of import source.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageType?: ImportSourceStorageType;

  /**
   * Uri of the import source storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageUrl?: string;

  /**
   * Sas token for accessing source storage. Read and list permissions are required for sas token.
   */
  @visibility(Lifecycle.Create)
  @secret
  sasToken?: string;

  /**
   * Relative path of data directory in storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataDirPath?: string;
}

/**
 * Parameters allowed to update for a server.
 */
model ServerForUpdate {
  /**
   * The cmk identity for the server.
   */
  identity?: MySQLServerIdentity;

  /**
   * The SKU (pricing tier) of the server.
   */
  sku?: MySQLServerSku;

  /**
   * The properties that can be updated for a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ServerPropertiesForUpdate;

  /**
   * Application-specific metadata in the form of key-value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * The properties that can be updated for a server.
 */
model ServerPropertiesForUpdate {
  /**
   * The password of the administrator login.
   */
  @secret
  administratorLoginPassword?: string;

  /**
   * Server version.
   */
  version?: ServerVersion;

  /**
   * Storage related properties of a server.
   */
  storage?: Storage;

  /**
   * Backup related properties of a server.
   */
  backup?: Backup;

  /**
   * High availability related properties of a server.
   */
  highAvailability?: HighAvailability;

  /**
   * Maintenance policy of a server.
   */
  maintenancePolicy?: MaintenancePolicy;

  /**
   * Maintenance window of a server.
   */
  maintenanceWindow?: MaintenanceWindow;

  /**
   * The replication role of the server.
   */
  replicationRole?: ReplicationRole;

  /**
   * The Data Encryption for CMK.
   */
  dataEncryption?: DataEncryption;

  /**
   * Network related properties of a server
   */
  network?: Network;
}

/**
 * High availability validation properties of a server
 */
model HighAvailabilityValidationEstimation {
  /**
   * Estimated seconds of downtime for the deployment.
   */
  @visibility(Lifecycle.Read)
  estimatedDowntime?: int32;

  /**
   * Scheduled Availability zone of the standby server.
   */
  @visibility(Lifecycle.Read)
  scheduledStandbyAvailabilityZone?: string;

  /**
   * Expected Availability zone of the standby server.
   */
  expectedStandbyAvailabilityZone?: string;
}

/**
 * Server restart parameters.
 */
model ServerRestartParameter {
  /**
   * Whether or not failover to standby server when restarting a server with high availability enabled.
   */
  restartWithFailover?: EnableStatusEnum;

  /**
   * The maximum allowed failover time in seconds.
   */
  maxFailoverSeconds?: int32;
}

/**
 * Server Gtid set parameters: Replication with Global Transaction Identifiers.
 */
model ServerGtidSetParameter {
  /**
   * The Gtid set of server.
   */
  gtidSet?: string;
}

/**
 * Parameters to detach Vnet.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerDetachVNetParameter {
  /**
   * Whether or not public network access is allowed for this server. Value is 'Disabled' when server has VNet integration.
   */
  publicNetworkAccess?: EnableStatusEnum;
}

/**
 * Properties of an Advanced Threat Protection setting.
 */
model AdvancedThreatProtectionProperties {
  /**
   * Specifies the UTC creation time of the policy.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Specifies the state of the Advanced Threat Protection, whether it is enabled or disabled or a state has not been applied yet on the specific database or server.
   */
  state?: AdvancedThreatProtectionState;

  /**
   * Provisioning state of the Threat Protection.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AdvancedThreatProtectionProvisioningState;
}

/**
 * Parameters allowed to update advanced threat protection for a server.
 */
model AdvancedThreatProtectionForUpdate {
  /**
   * Resource update properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: AdvancedThreatProtectionUpdateProperties;
}

/**
 * Properties of Advanced Threat Protection that can be updated.
 */
model AdvancedThreatProtectionUpdateProperties {
  /**
   * Specifies the state of the Advanced Threat Protection, whether it is enabled or disabled or a state has not been applied yet on the specific database or server.
   */
  state: AdvancedThreatProtectionState;
}

/**
 * Represents a logFile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LogFile extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The properties of a logFile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: LogFileProperties;
}

/**
 * The properties of a logFile.
 */
model LogFileProperties {
  /**
   * The size in kb of the logFile.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sizeInKB?: int64;

  /**
   * Creation timestamp of the log file.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Type of the log file.
   */
  type?: string;

  /**
   * Last modified timestamp of the log file.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * The url to download the log file from.
   */
  url?: string;
}

/**
 * location capability
 */
model CapabilitiesListResult {
  /**
   * Array of Capability settings
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("The CapabilityProperties items on this page")
  @visibility(Lifecycle.Read)
  @pageItems
  value?: CapabilityProperties[];

  /**
   * Link to the next page of results, if applicable
   */
  @doc("The link to the next page of items")
  @nextLink
  nextLink?: url;
}

/**
 * Location capabilities.
 */
model CapabilityProperties {
  /**
   * zone name
   */
  @visibility(Lifecycle.Read)
  zone?: string;

  /**
   * Supported high availability mode
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedHAMode?: string[];

  /**
   * supported geo backup regions
   */
  @visibility(Lifecycle.Read)
  supportedGeoBackupRegions?: string[];

  /**
   * A list of supported flexible server editions.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  supportedFlexibleServerEditions?: ServerEditionCapability[];
}

/**
 * Server edition capabilities.
 */
model ServerEditionCapability {
  /**
   * Server edition name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * A list of supported storage editions
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  supportedStorageEditions?: StorageEditionCapability[];

  /**
   * A list of supported server versions.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  supportedServerVersions?: ServerVersionCapability[];
}

/**
 * storage edition capability
 */
model StorageEditionCapability {
  /**
   * storage edition name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The minimal supported storage size.
   */
  @visibility(Lifecycle.Read)
  minStorageSize?: int64;

  /**
   * The maximum supported storage size.
   */
  @visibility(Lifecycle.Read)
  maxStorageSize?: int64;

  /**
   * Minimal backup retention days
   */
  @visibility(Lifecycle.Read)
  minBackupRetentionDays?: int64;

  /**
   * Maximum backup retention days
   */
  @visibility(Lifecycle.Read)
  maxBackupRetentionDays?: int64;

  /**
   * Minimal backup interval hours
   */
  @visibility(Lifecycle.Read)
  minBackupIntervalHours?: int64;

  /**
   * Maximum backup interval hours
   */
  @visibility(Lifecycle.Read)
  maxBackupIntervalHours?: int64;
}

/**
 * Server version capabilities.
 */
model ServerVersionCapability {
  /**
   * server version
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * A list of supported Skus
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  supportedSkus?: SkuCapability[];
}

/**
 * Sku capability
 */
model SkuCapability {
  /**
   * vCore name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * supported vCores
   */
  @visibility(Lifecycle.Read)
  vCores?: int64;

  /**
   * supported IOPS
   */
  @visibility(Lifecycle.Read)
  supportedIops?: int64;

  /**
   * supported memory per vCore in MB
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedMemoryPerVCoreMB?: int64;
}

/**
 * location capability set
 */
model CapabilitySetsList {
  /**
   * Array of CapabilitySets settings
   */
  @doc("The CapabilitySetsList items on this page")
  @visibility(Lifecycle.Read)
  @pageItems
  value?: Capability[];

  /**
   * Link to the next page of results, if applicable
   */
  @doc("The link to the next page of items")
  @nextLink
  nextLink?: url;
}

/**
 * Location capability.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CapabilityPropertiesV2 {
  /**
   * supported geo backup regions
   */
  @visibility(Lifecycle.Read)
  supportedGeoBackupRegions?: string[];

  /**
   * A list of supported flexible server editions.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  supportedFlexibleServerEditions?: ServerEditionCapabilityV2[];

  /**
   * A list of supported server versions.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  supportedServerVersions?: ServerVersionCapabilityV2[];

  /**
   * A list of supported features.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  supportedFeatures?: FeatureProperty[];
}

/**
 * Server edition capabilities.
 */
model ServerEditionCapabilityV2 {
  /**
   * Server edition name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Default Sku name
   */
  @visibility(Lifecycle.Read)
  defaultSku?: string;

  /**
   * Default storage size
   */
  @visibility(Lifecycle.Read)
  defaultStorageSize?: int32;

  /**
   * A list of supported storage editions
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  supportedStorageEditions?: StorageEditionCapability[];

  /**
   * A list of supported Skus
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  supportedSkus?: SkuCapabilityV2[];
}

/**
 * Sku capability
 */
model SkuCapabilityV2 {
  /**
   * vCore name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * supported vCores
   */
  @visibility(Lifecycle.Read)
  vCores?: int64;

  /**
   * supported IOPS
   */
  @visibility(Lifecycle.Read)
  supportedIops?: int64;

  /**
   * supported memory per vCore in MB
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedMemoryPerVCoreMB?: int64;

  /**
   * Supported zones
   */
  @visibility(Lifecycle.Read)
  supportedZones?: string[];

  /**
   * Supported high availability mode
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  supportedHAMode?: string[];
}

/**
 * Server version capabilities.
 */
model ServerVersionCapabilityV2 {
  /**
   * server version
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * Server version capabilities.
 */
model FeatureProperty {
  /**
   * feature name
   */
  @visibility(Lifecycle.Read)
  featureName?: string;

  /**
   * feature value
   */
  @visibility(Lifecycle.Read)
  featureValue?: string;
}

/**
 * Virtual network subnet usage parameter
 */
model VirtualNetworkSubnetUsageParameter {
  /**
   * Virtual network resource id.
   */
  virtualNetworkResourceId?: string;
}

/**
 * Virtual network subnet usage data.
 */
model VirtualNetworkSubnetUsageResult {
  /**
   * The location name.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The subscription id.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * A list of delegated subnet usage
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  delegatedSubnetsUsage?: DelegatedSubnetUsage[];
}

/**
 * Delegated subnet usage data.
 */
model DelegatedSubnetUsage {
  /**
   * name of the subnet
   */
  @visibility(Lifecycle.Read)
  subnetName?: string;

  /**
   * Number of used delegated subnets
   */
  @visibility(Lifecycle.Read)
  usage?: int64;
}

/**
 * Request from client to check resource name availability.
 */
model NameAvailabilityRequest {
  /**
   * Resource name to verify.
   */
  name: string;

  /**
   * Resource type used for verification.
   */
  type?: string;
}

/**
 * Represents a resource name availability.
 */
model NameAvailability {
  /**
   * Error Message.
   */
  message?: string;

  /**
   * Indicates whether the resource name is available.
   */
  nameAvailable?: boolean;

  /**
   * Reason for name being unavailable.
   */
  reason?: string;
}

/**
 * Represents Operation Results API Response
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OperationStatusExtendedResult
  extends Azure.ResourceManager.CommonTypes.OperationStatusResult {
  /**
   * The extended properties of Operation Results
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: Record<unknown>;
}

/**
 * Represents Operation Results API Response
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OperationProgressResult
  extends Azure.ResourceManager.CommonTypes.OperationStatusResult {
  /**
   * The response properties specific to the operation
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: OperationProgressResponseType;
}

/**
 * Represents the response properties specific to the operation
 */
@discriminator("objectType")
model OperationProgressResponseType {
  /**
   * Identifies the type of source operation
   */
  objectType: ObjectType;
}

/**
 * The response of get private dns zone suffix.
 */
model GetPrivateDnsZoneSuffixResponse {
  /**
   * Represents the private DNS zone suffix.
   */
  privateDnsZoneSuffix?: string;
}

/**
 * The properties of a maintenance resource.
 */
model MaintenanceProperties {
  /**
   * A string defines maintenance type.
   */
  @visibility(Lifecycle.Read)
  maintenanceType?: MaintenanceType;

  /**
   * A string describes the maintenance status
   */
  @visibility(Lifecycle.Read)
  maintenanceState?: MaintenanceState;

  /**
   * The start time for a maintenance.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maintenanceStartTime?: utcDateTime;

  /**
   * The end time for a maintenance.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maintenanceEndTime?: utcDateTime;

  /**
   * The start time for a maintenance execution.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maintenanceExecutionStartTime?: utcDateTime;

  /**
   * The end time for a maintenance execution.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maintenanceExecutionEndTime?: utcDateTime;

  /**
   * The min time the maintenance can be rescheduled.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maintenanceAvailableScheduleMinTime?: utcDateTime;

  /**
   * The max time the maintenance can be rescheduled.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maintenanceAvailableScheduleMaxTime?: utcDateTime;

  /**
   * The maintenance title.
   */
  @visibility(Lifecycle.Read)
  maintenanceTitle?: string;

  /**
   * The maintenance description.
   */
  @visibility(Lifecycle.Read)
  maintenanceDescription?: string;

  /**
   * Provisioning state of the Maintenance.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: MaintenanceProvisioningState;
}

/**
 * Represents a maintenance update parameter.
 */
model MaintenanceUpdate {
  /**
   * The properties of a maintenance update parameter
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: MaintenancePropertiesForUpdate;
}

/**
 * The properties of a maintenance update parameter.
 */
model MaintenancePropertiesForUpdate {
  /**
   * The start time for a maintenance.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maintenanceStartTime?: utcDateTime;
}

/**
 * FullBackupStoreDetails is used for scenarios where backup data is streamed/copied over to a storage destination.
 */
model FullBackupStoreDetails extends BackupStoreDetails {
  /**
   * SASUriList of storage containers where backup data is to be streamed/copied.
   */
  sasUriList: string[];

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "FullBackupStoreDetails";
}

/**
 * The properties of a server backup.
 */
model ProvisioningStateProperties {
  /**
   * The provisioning state of backup resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Server backup properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Provisioning extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The properties of provisioning.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ProvisioningStateProperties;
}

/**
 * Metadata of user assigned identity.
 */
model UserAssignedIdentity {
  /**
   * Principal Id of user assigned identity
   */
  @visibility(Lifecycle.Read)
  @clientName("PrincipalId")
  principalId?: string;

  /**
   * Client Id of user assigned identity
   */
  @visibility(Lifecycle.Read)
  @clientName("ClientId")
  clientId?: string;
}

/**
 * Tags object for patch operations.
 */
model TagsObject {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * BackupAndExport Response Properties
 */
model BackupAndExportResponseType extends OperationProgressResponseType {
  /**
   * Size of datasource in bytes
   */
  datasourceSizeInBytes?: int64;

  /**
   * Data transferred in bytes
   */
  dataTransferredInBytes?: int64;

  /**
   * Metadata related to backup to be stored for restoring resource in key-value pairs.
   */
  backupMetadata?: string;

  /**
   * Identifies the type of source operation
   */
  objectType: "BackupAndExportResponse";
}

/**
 * ImportFromStorage Response Properties
 */
model ImportFromStorageResponseType extends OperationProgressResponseType {
  /**
   * The estimated time of operation completion.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  estimatedCompletionTime?: utcDateTime;

  /**
   * Identifies the type of source operation
   */
  objectType: "ImportFromStorageResponse";
}

/**
 * The property of a server's location.
 */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@OpenAPI.extension("x-ms-parameter-location", "method")
model LocationNameParameter {
  /**
   * The name of the location.
   */
  @minLength(1)
  @pattern("^[ \\w]+$")
  @path
  @segment("locations")
  locationName: string;
}

/**
 * A List of azure ad administrators.
 */
model AdministratorListResult {
  /**
   * The list of azure ad administrator of a server.
   */
  @pageItems
  value?: AzureADAdministrator[];

  /**
   * The link used to get the next page of operations.
   */
  @nextLink
  nextLink?: url;
}

/**
 * The response of a AdvancedThreatProtection list operation.
 */
model AdvancedThreatProtectionListResult {
  /**
   * Array of Advanced Threat Protection settings
   */
  @doc("The AdvancedThreatProtection items on this page")
  @visibility(Lifecycle.Read)
  @pageItems
  value?: AdvancedThreatProtection[];

  /**
   * Link to the next page of results, if applicable
   */
  @doc("The link to the next page of items")
  @nextLink
  nextLink?: url;
}

/**
 * The response of a Configuration list operation.
 */
model ConfigurationListResult {
  /**
   * Array of Configuration
   */
  @doc("The Configuration items on this page")
  @pageItems
  @TypeSpec.pageItems
  value?: Configuration[];

  /**
   * Link to the next page of results, if applicable
   */
  @doc("The link to the next page of items")
  @TypeSpec.nextLink
  nextLink?: url;
}

/**
 * The response of a Database list operation.
 */
model DatabaseListResult {
  /**
   * Array of Database
   */
  @doc("The Database items on this page")
  @pageItems
  value?: Database[];

  /**
   * Link to the next page of results, if applicable
   */
  @doc("The link to the next page of items")
  @nextLink
  nextLink?: url;
}

/**
 * The response of a FirewallRule list operation.
 */
model FirewallRuleListResult {
  /**
   * Array of FirewallRule
   */
  @doc("The FirewallRule items on this page")
  @pageItems
  value?: FirewallRule[];

  /**
   * Link to the next page of results, if applicable
   */
  @doc("The link to the next page of items")
  @nextLink
  nextLink?: url;
}

/**
 * The response of a LogFile list operation.
 */
model LogFileListResult {
  /**
   * Array of LogFile
   */
  @doc("The LogFile items on this page")
  @pageItems
  value?: LogFile[];

  /**
   * Link to the next page of results, if applicable
   */
  @doc("The link to the next page of items")
  @nextLink
  nextLink?: url;
}

/**
 * The response of a Maintenance list operation.
 */
model MaintenanceListResult {
  /**
   * Array of Maintenance
   */
  @doc("The Maintenance items on this page")
  @pageItems
  value?: Maintenance[];

  /**
   * Link to the next page of results, if applicable
   */
  @doc("The link to the next page of items")
  @nextLink
  nextLink?: url;
}

/**
 * The response of a ServerBackup list operation.
 */
model ServerBackupListResult {
  /**
   * Array of ServerBackup
   */
  @doc("The ServerBackup items on this page")
  @pageItems
  value?: ServerBackup[];

  /**
   * Link to the next page of results, if applicable
   */
  @doc("The link to the next page of items")
  @nextLink
  nextLink?: url;
}

/**
 * The response of a ServerBackupV2 list operation.
 */
model ServerBackupV2ListResult {
  /**
   * Array of ServerBackupV2
   */
  @doc("The ServerBackupV2 items on this page")
  @pageItems
  value?: ServerBackupV2[];

  /**
   * Link to the next page of results, if applicable
   */
  @doc("The link to the next page of items")
  @nextLink
  nextLink?: url;
}

/**
 * The response of a Server list operation.
 */
model ServerListResult {
  /**
   * Array of Server
   */
  @doc("The Server items on this page")
  @pageItems
  value?: Server[];

  /**
   * Link to the next page of results, if applicable
   */
  @doc("The link to the next page of items")
  @nextLink
  nextLink?: url;
}

/**
 * The static parameters for a subscription based resource
 */
model SubscriptionBaseParameters {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...LocationNameParameter;
}

/**
 * The static parameters for a resource group based resource
 */
model OperationListResult {
  /**
   * The list of operations supported by the Microsoft.DBforMySQL FlexibleServers resource provider.
   */
  @doc("The Operation items on this page")
  @pageItems
  value?: Operation[];

  /**
   * The link used to get the next page of operations.
   */
  @doc("The link to the next page of items")
  @nextLink
  nextLink?: url;
}

/**
 * Details of a REST API operation, returned from the Resource Provider Operations API
 */
model Operation {
  /** 
    The name of the operation, as per Resource-Based Access Control (RBAC). Examples: "Microsoft.Compute/virtualMachines/write", "Microsoft.Compute/virtualMachines/capture/action"
     */
  @visibility(Lifecycle.Read)
  name?: string;

  /** Localized display information for this particular operation. */
  display?: OperationDisplay;

  /** 
    The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
     */
  @visibility(Lifecycle.Read)
  origin?: Origin;

  /**
   * Additional descriptions for the operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Required for backward compatibility"
  properties?: Record<unknown>;
}

/**
 * Display metadata associated with the operation.
 */
model OperationDisplay {
  /** 
  The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /** 
    The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
     */
  @visibility(Lifecycle.Read)
  resource?: string;

  /** 
    The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
     */
  @visibility(Lifecycle.Read)
  operation?: string;

  /** The short, localized friendly description of the operation; suitable for tool tips and detailed views. */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  /** Indicates the operation is initiated by a user. */
  user: "user",

  /** Indicates the operation is initiated by a system. */
  system: "system",

  /** Indicates the operation is initiated by a user or system. */
  `user,system`: "user,system",

  string,
}
