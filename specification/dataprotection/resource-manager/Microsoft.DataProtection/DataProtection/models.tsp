import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DataProtection;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AlertsState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Provisioning state of the BackupVault resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
}

/**
 * Resource move state for backup vault
 */
union ResourceMoveState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PrepareFailed: "PrepareFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CommitFailed: "CommitFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PrepareTimedout: "PrepareTimedout",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CommitTimedout: "CommitTimedout",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CriticalFailure: "CriticalFailure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PartialSuccess: "PartialSuccess",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MoveSucceeded: "MoveSucceeded",
}

/**
 * State of soft delete
 */
union SoftDeleteState {
  string,

  /**
   * Soft Delete is turned off for the BackupVault
   */
  Off: "Off",

  /**
   * Soft Delete is enabled for the BackupVault but can be turned off
   */
  On: "On",

  /**
   * Soft Delete is permanently enabled for the BackupVault and the setting cannot be changed
   */
  AlwaysOn: "AlwaysOn",
}

/**
 * Immutability state
 */
union ImmutabilityState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unlocked: "Unlocked",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Locked: "Locked",
}

/**
 * Encryption state of the Backup Vault.
 */
union EncryptionState {
  string,

  /**
   * CMK encryption is enabled on the Backup Vault
   */
  Enabled: "Enabled",

  /**
   * CMK encryption is disabled on the Backup Vault. User can not set this state once Encryption State is 'Enabled'.
   */
  Disabled: "Disabled",

  /**
   * CMK encryption is in inconsistent state on the Backup Vault. This state indicates that user needs to retry the encryption settings operation immediately to correct the state.
   */
  Inconsistent: "Inconsistent",
}

/**
 * The identity type. 'SystemAssigned' and 'UserAssigned' are mutually exclusive. 'SystemAssigned' will use implicitly created managed identity.
 */
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserAssigned: "UserAssigned",
}

/**
 * Enabling/Disabling the Double Encryption state
 */
union InfrastructureEncryptionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Gets or sets the type of the datastore.
 */
union StorageSettingStoreTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ArchiveStore: "ArchiveStore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OperationalStore: "OperationalStore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VaultStore: "VaultStore",
}

/**
 * Gets or sets the type.
 */
union StorageSettingTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GeoRedundant: "GeoRedundant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LocallyRedundant: "LocallyRedundant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ZoneRedundant: "ZoneRedundant",
}

/**
 * CrossSubscriptionRestore state
 */
union CrossSubscriptionRestoreState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PermanentlyDisabled: "PermanentlyDisabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
}

/**
 * CrossRegionRestore state
 */
union CrossRegionRestoreState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
}

/**
 * Secure Score of Backup Vault
 */
union SecureScoreLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Minimum: "Minimum",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Adequate: "Adequate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Maximum: "Maximum",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSupported: "NotSupported",
}

/**
 * Security Level of Backup Vault
 */
union BCDRSecurityLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Poor: "Poor",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Fair: "Fair",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Good: "Good",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Excellent: "Excellent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSupported: "NotSupported",
}

/**
 * Type of the specific object - used for deserializing
 */
union ResourcePropertiesObjectType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DefaultResourceProperties: "DefaultResourceProperties",
}

/**
 * type of datastore; Operational/Vault/Archive
 */
union DataStoreTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OperationalStore: "OperationalStore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VaultStore: "VaultStore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ArchiveStore: "ArchiveStore",
}

/**
 * Specifies the protection status of the resource
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConfiguringProtection: "ConfiguringProtection",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConfiguringProtectionFailed: "ConfiguringProtectionFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProtectionConfigured: "ProtectionConfigured",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProtectionStopped: "ProtectionStopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SoftDeleted: "SoftDeleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SoftDeleting: "SoftDeleting",
}

/**
 * Specifies the current protection state of the resource
 */
union CurrentProtectionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotProtected: "NotProtected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConfiguringProtection: "ConfiguringProtection",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProtectionConfigured: "ProtectionConfigured",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BackupSchedulesSuspended: "BackupSchedulesSuspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RetentionSchedulesSuspended: "RetentionSchedulesSuspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProtectionStopped: "ProtectionStopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProtectionError: "ProtectionError",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConfiguringProtectionFailed: "ConfiguringProtectionFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SoftDeleting: "SoftDeleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SoftDeleted: "SoftDeleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UpdatingProtection: "UpdatingProtection",
}

/**
 * Specifies the type of validation. In case of DeepValidation, all validations from /validateForBackup API will run again.
 */
union ValidationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ShallowValidation: "ShallowValidation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeepValidation: "DeepValidation",
}

/**
 * Recovery Option
 */
union RecoveryOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FailIfExists: "FailIfExists",
}

/**
 * Gets or sets the type of the source data store.
 */
union SourceDataStoreType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ArchiveStore: "ArchiveStore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SnapshotStore: "SnapshotStore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OperationalStore: "OperationalStore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VaultStore: "VaultStore",
}

/**
 * Priority to be used for rehydration. Values High or Standard
 */
union RehydrationPriority {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  High: "High",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
}

/**
 * Field indicating sync type e.g. to sync only in case of failure or in all cases
 */
union SyncType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ForceResync: "ForceResync",
}

/**
 * Gets or sets the type of the source data store.
 */
union RestoreSourceDataStoreType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OperationalStore: "OperationalStore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VaultStore: "VaultStore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ArchiveStore: "ArchiveStore",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union RehydrationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CREATE_IN_PROGRESS: "CREATE_IN_PROGRESS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  COMPLETED: "COMPLETED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DELETE_IN_PROGRESS: "DELETE_IN_PROGRESS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DELETED: "DELETED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FAILED: "FAILED",
}

/**
 * Specifies recovery point completeness. Partial (i.e., only some of the intended items were backed up), or Completed (i.e., ALL intended items were backed up).
 */
union RecoveryPointCompletionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Partial: "Partial",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AKSVolumeTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureDisk: "AzureDisk",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureFileShareSMB: "AzureFileShareSMB",
}

/**
 * backup support feature type.
 */
union FeatureType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DataSourceType: "DataSourceType",
}

/**
 * feature support status
 */
union FeatureSupportStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSupported: "NotSupported",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AlphaPreview: "AlphaPreview",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PrivatePreview: "PrivatePreview",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PublicPreview: "PublicPreview",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GenerallyAvailable: "GenerallyAvailable",
}

/**
 * Gets or sets the PV (Persistent Volume) Restore Mode property. This property sets whether volumes needs to be restored.
 */
union PersistentVolumeRestoreMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RestoreWithVolumeData: "RestoreWithVolumeData",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RestoreWithoutVolumeData: "RestoreWithoutVolumeData",
}

/**
 * Gets or sets the Conflict Policy property. This property sets policy during conflict of resources during restore.
 */
union ExistingResourcePolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Skip: "Skip",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Patch: "Patch",
}

/**
 * Denotes the target location where the data will be restored,
 * string value for the enum {Microsoft.Internal.AzureBackup.DataProtection.Common.Interface.RestoreTargetLocationType}
 */
union RestoreTargetLocationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBlobs: "AzureBlobs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureFiles: "AzureFiles",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AbsoluteMarker {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AllBackup: "AllBackup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FirstOfDay: "FirstOfDay",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FirstOfMonth: "FirstOfMonth",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FirstOfWeek: "FirstOfWeek",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FirstOfYear: "FirstOfYear",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DayOfWeek {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Friday: "Friday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Monday: "Monday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Saturday: "Saturday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sunday: "Sunday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Thursday: "Thursday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Tuesday: "Tuesday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Wednesday: "Wednesday",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union Month {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  April: "April",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  August: "August",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  December: "December",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  February: "February",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  January: "January",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  July: "July",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  June: "June",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  March: "March",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  May: "May",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  November: "November",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  October: "October",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  September: "September",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union WeekNumber {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  First: "First",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Fourth: "Fourth",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Last: "Last",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Second: "Second",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Third: "Third",
}

/**
 * Gets or sets the type of secret store
 */
union SecretStoreType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureKeyVault: "AzureKeyVault",
}

/**
 * List of BackupVault resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupVaultResourceList extends DppResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: BackupVaultResource[];
}

/**
 * Backup Vault
 */
model BackupVault {
  /**
   * Monitoring Settings
   */
  monitoringSettings?: MonitoringSettings;

  /**
   * Provisioning state of the BackupVault resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Resource move state for backup vault
   */
  @visibility(Lifecycle.Read)
  resourceMoveState?: ResourceMoveState;

  /**
   * Resource move details for backup vault
   */
  @visibility(Lifecycle.Read)
  resourceMoveDetails?: ResourceMoveDetails;

  /**
   * Security Settings
   */
  securitySettings?: SecuritySettings;

  /**
   * Storage Settings
   */
  @identifiers(#[])
  storageSettings: StorageSetting[];

  /**
   * Is vault protected by resource guard
   */
  @visibility(Lifecycle.Read)
  isVaultProtectedByResourceGuard?: boolean;

  /**
   * Feature Settings
   */
  featureSettings?: FeatureSettings;

  /**
   * Secure Score of Backup Vault
   */
  @visibility(Lifecycle.Read)
  secureScore?: SecureScoreLevel;

  /**
   * Security Level of Backup Vault
   */
  @visibility(Lifecycle.Read)
  bcdrSecurityLevel?: BCDRSecurityLevel;

  /**
   * ResourceGuardOperationRequests on which LAC check will be performed
   */
  resourceGuardOperationRequests?: string[];

  /**
   * List of replicated regions for Backup Vault
   */
  replicatedRegions?: string[];
}

/**
 * Monitoring Settings
 */
model MonitoringSettings {
  /**
   * Settings for Azure Monitor based alerts
   */
  azureMonitorAlertSettings?: AzureMonitorAlertSettings;
}

/**
 * Settings for Azure Monitor based alerts
 */
model AzureMonitorAlertSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  alertsForAllJobFailures?: AlertsState;
}

/**
 * ResourceMoveDetails will be returned in response to GetResource call from ARM
 */
model ResourceMoveDetails {
  /**
   * CorrelationId of latest ResourceMove operation attempted
   */
  operationId?: string;

  /**
   * Start time in UTC of latest ResourceMove operation attempted. ISO 8601 format.
   */
  startTimeUtc?: string;

  /**
   * Completion time in UTC of latest ResourceMove operation attempted. ISO 8601 format.
   */
  completionTimeUtc?: string;

  /**
   * ARM resource path of source resource
   */
  sourceResourcePath?: string;

  /**
   * ARM resource path of target resource used in latest ResourceMove operation
   */
  targetResourcePath?: string;
}

/**
 * Class containing security settings of vault
 */
model SecuritySettings {
  /**
   * Soft delete related settings
   */
  softDeleteSettings?: SoftDeleteSettings;

  /**
   * Immutability Settings at vault level
   */
  immutabilitySettings?: ImmutabilitySettings;

  /**
   * Customer Managed Key details of the resource.
   */
  encryptionSettings?: EncryptionSettings;
}

/**
 * Soft delete related settings
 */
model SoftDeleteSettings {
  /**
   * State of soft delete
   */
  state?: SoftDeleteState;

  /**
   * Soft delete retention duration
   */
  retentionDurationInDays?: float64;
}

/**
 * Immutability Settings at vault level
 */
model ImmutabilitySettings {
  /**
   * Immutability state
   */
  state?: ImmutabilityState;
}

/**
 * Customer Managed Key details of the resource.
 */
model EncryptionSettings {
  /**
   * Encryption state of the Backup Vault.
   */
  state?: EncryptionState;

  /**
   * The properties of the Key Vault which hosts CMK
   */
  keyVaultProperties?: CmkKeyVaultProperties;

  /**
   * The details of the managed identity used for CMK
   */
  kekIdentity?: CmkKekIdentity;

  /**
   * Enabling/Disabling the Double Encryption state
   */
  infrastructureEncryption?: InfrastructureEncryptionState;
}

/**
 * The properties of the Key Vault which hosts CMK
 */
model CmkKeyVaultProperties {
  /**
   * The key uri of the Customer Managed Key
   */
  keyUri?: string;
}

/**
 * The details of the managed identity used for CMK
 */
model CmkKekIdentity {
  /**
   * The identity type. 'SystemAssigned' and 'UserAssigned' are mutually exclusive. 'SystemAssigned' will use implicitly created managed identity.
   */
  identityType?: IdentityType;

  /**
   * The managed identity to be used which has access permissions to the Key Vault. Provide a value here in case identity types: 'UserAssigned' only.
   */
  identityId?: string;
}

/**
 * Storage setting
 */
model StorageSetting {
  /**
   * Gets or sets the type of the datastore.
   */
  datastoreType?: StorageSettingStoreTypes;

  /**
   * Gets or sets the type.
   */
  type?: StorageSettingTypes;
}

/**
 * Class containing feature settings of vault
 */
model FeatureSettings {
  /**
   * CrossSubscriptionRestore Settings
   */
  crossSubscriptionRestoreSettings?: CrossSubscriptionRestoreSettings;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  crossRegionRestoreSettings?: CrossRegionRestoreSettings;
}

/**
 * CrossSubscriptionRestore Settings
 */
model CrossSubscriptionRestoreSettings {
  /**
   * CrossSubscriptionRestore state
   */
  state?: CrossSubscriptionRestoreState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CrossRegionRestoreSettings {
  /**
   * CrossRegionRestore state
   */
  state?: CrossRegionRestoreState;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DppTrackedResource extends DppBaseTrackedResource {
  /**
   * Input Managed Identity Details
   */
  identity?: DppIdentityDetails;
}

/**
 * Identity details
 */
model DppIdentityDetails {
  /**
   * The object ID of the service principal object for the managed identity that is used to grant role-based access to an Azure resource.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * A Globally Unique Identifier (GUID) that represents the Azure AD tenant where the resource is now a member.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The identityType which can be either SystemAssigned, UserAssigned, 'SystemAssigned,UserAssigned' or None
   */
  type?: string;

  /**
   * Gets or sets the user assigned identities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<Azure.ResourceManager.Foundations.UserAssignedIdentity>;
}

/**
 * Deletion info for a tracked resource (Backup Vault)
 */
@added(Versions.v2025_09_01)
model ResourceDeletionInfo {
  /**
   * Specifies time of deletion for the tracked resource (Backup Vault)
   */
  @visibility(Lifecycle.Read)
  deletionTime?: utcDateTime;

  /**
   * Specifies the scheduled purge time for the tracked resource (Backup Vault)
   */
  @visibility(Lifecycle.Read)
  scheduledPurgeTime?: utcDateTime;

  /**
   * Delete activity ID for troubleshooting the deletion of the tracked resource
   */
  @visibility(Lifecycle.Read)
  deleteActivityId?: string;
}

/**
 * Deleted Backup Vault - uses composition with BackupVault and additional deletion metadata
 */
@added(Versions.v2025_09_01)
model DeletedBackupVault {
  ...BackupVault;

  /**
   * Resource Id of the original backup vault
   */
  @visibility(Lifecycle.Read)
  originalBackupVaultId: string;

  /**
   * Resource name of the original backup vault
   */
  @visibility(Lifecycle.Read)
  originalBackupVaultName: string;

  /**
   * Resource path of the original backup vault
   */
  @visibility(Lifecycle.Read)
  originalBackupVaultResourcePath: string;

  /**
   * Deletion info for the tracked resource (Backup Vault)
   */
  @visibility(Lifecycle.Read)
  resourceDeletionInfo: ResourceDeletionInfo;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DppBaseTrackedResource {
  /**
   * Optional ETag.
   */
  eTag?: string;

  /**
   * Resource Id represents the complete path to the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource location.
   */
  location?: string;

  /**
   * Resource name associated with the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Resource type represents the complete path of the form Namespace/ResourceType/ResourceType/...
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

/**
 * ListResource
 */
model DppResourceList {
  /**
   * The uri to fetch the next page of resources. Call ListNext() fetches next page of resources.
   */
  @nextLink
  nextLink?: string;
}

/**
 * An error response from Azure Backup.
 */
@error
model CloudError {
  /**
   * The resource management error response.
   */
  error?: Error;
}

/**
 * The resource management error response.
 */
model Error {
  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  additionalInfo?: Azure.ResourceManager.Foundations.ErrorAdditionalInfo[];

  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  details?: Error[];

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
}

/**
 * Operation Job Extended Info
 */
model OperationJobExtendedInfo extends OperationExtendedInfo {
  /**
   * Name or Arm Id of the job created for this operation.
   */
  jobId?: string;

  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  objectType: "OperationJobExtendedInfo";
}

/**
 * Operation Extended Info
 */
@discriminator("objectType")
model OperationExtendedInfo {
  /**
   * This property will be used as the discriminator for deciding the specific types in the polymorphic chain of types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Operation Resource
 */
model OperationResource {
  /**
   * End time of the operation
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Required if status == failed or status == canceled. This is the OData v4 error format, used by the RPC and will go into the v2.2 Azure REST API guidelines.
   * The full set of optional properties (e.g. inner errors / details) can be found in the "Error Response" section.
   */
  error?: Error;

  /**
   * It should match what is used to GET the operation result
   */
  id?: string;

  /**
   * It must match the last segment of the "id" field, and will typically be a GUID / system generated value
   */
  name?: string;

  /**
   * End time of the operation
   */
  properties?: OperationExtendedInfo;

  /**
   * Start time of the operation
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  status?: string;
}

/**
 * Patch Request content for Microsoft.DataProtection resources
 */
model PatchResourceRequestInput {
  /**
   * Input Managed Identity Details
   */
  identity?: DppIdentityDetails;

  /**
   * Resource properties.
   */
  properties?: PatchBackupVaultInput;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Backup Vault Contract for Patch Backup Vault API.
 */
model PatchBackupVaultInput {
  /**
   * Monitoring Settings
   */
  monitoringSettings?: MonitoringSettings;

  /**
   * Security Settings
   */
  securitySettings?: SecuritySettings;

  /**
   * Feature Settings
   */
  featureSettings?: FeatureSettings;

  /**
   * ResourceGuardOperationRequests on which LAC check will be performed
   */
  resourceGuardOperationRequests?: string[];
}

/**
 * CheckNameAvailability Request
 */
model CheckNameAvailabilityRequest {
  /**
   * Resource name for which availability needs to be checked
   */
  name?: string;

  /**
   * Describes the Resource type: Microsoft.DataProtection/BackupVaults
   */
  type?: string;
}

/**
 * CheckNameAvailability Result
 */
model CheckNameAvailabilityResult {
  /**
   * Gets or sets the message.
   */
  message?: string;

  /**
   * Gets or sets a value indicating whether [name available].
   */
  nameAvailable?: boolean;

  /**
   * Gets or sets the reason.
   */
  reason?: string;
}

/**
 * Base class for Backup Feature support
 */
@discriminator("objectType")
model FeatureValidationRequestBase {
  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Base class for Backup Feature support
 */
@discriminator("objectType")
model FeatureValidationResponseBase {
  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Available operation details.
 */
model ClientDiscoveryValueForSingleApi {
  /**
   * Contains the localized display information for this particular operation
   */
  display?: ClientDiscoveryDisplay;

  /**
   * Name of the Operation.
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * The intended executor of the operation;governs the display of the operation in the RBAC UX and the audit logs UX
   */
  origin?: string;

  /**
   * Properties for the given operation.
   */
  properties?: ClientDiscoveryForProperties;
}

/**
 * Localized display information of an operation.
 */
model ClientDiscoveryDisplay {
  /**
   * Description of the operation having details of what operation is about.
   */
  description?: string;

  /**
   * Operations Name itself.
   */
  operation?: string;

  /**
   * Name of the provider for display purposes
   */
  provider?: string;

  /**
   * ResourceType for which this Operation can be performed.
   */
  resource?: string;
}

/**
 * Class to represent shoebox properties in json client discovery.
 */
model ClientDiscoveryForProperties {
  /**
   * Operation properties.
   */
  serviceSpecification?: ClientDiscoveryForServiceSpecification;
}

/**
 * Class to represent shoebox service specification in json client discovery.
 */
model ClientDiscoveryForServiceSpecification {
  /**
   * List of log specifications of this operation.
   */
  @identifiers(#[])
  logSpecifications?: ClientDiscoveryForLogSpecification[];
}

/**
 * Class to represent shoebox log specification in json client discovery.
 */
model ClientDiscoveryForLogSpecification {
  /**
   * blob duration of shoebox log specification
   */
  blobDuration?: string;

  /**
   * Localized display name
   */
  displayName?: string;

  /**
   * Name for shoebox log specification.
   */
  name?: string;
}

/**
 * List of BaseBackupPolicy resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BaseBackupPolicyResourceList extends DppResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: BaseBackupPolicyResource[];
}

/**
 * BackupPolicy base
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("objectType")
model BaseBackupPolicy {
  /**
   * Type of datasource for the backup management
   */
  datasourceTypes: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Resource class
 */
model DppResource {
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
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

/**
 * BackupInstance Resource list response
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupInstanceResourceList extends DppResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: BackupInstanceResource[];
}

/**
 * Backup Instance
 */
model BackupInstance {
  /**
   * Gets or sets the Backup Instance friendly name.
   */
  friendlyName?: string;

  /**
   * Gets or sets the data source information.
   */
  dataSourceInfo: Datasource;

  /**
   * Gets or sets the data source set information.
   */
  dataSourceSetInfo?: DatasourceSet;

  /**
   * Gets or sets the policy information.
   */
  policyInfo: PolicyInfo;

  /**
   * ResourceGuardOperationRequests on which LAC check will be performed
   */
  resourceGuardOperationRequests?: string[];

  /**
   * Specifies the protection status of the resource
   */
  @visibility(Lifecycle.Read)
  protectionStatus?: ProtectionStatusDetails;

  /**
   * Specifies the current protection state of the resource
   */
  @visibility(Lifecycle.Read)
  currentProtectionState?: CurrentProtectionState;

  /**
   * Specifies the protection error of the resource
   */
  @visibility(Lifecycle.Read)
  protectionErrorDetails?: UserFacingError;

  /**
   * Specifies the provisioning state of the resource i.e. provisioning/updating/Succeeded/Failed
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Credentials to use to authenticate with data source provider.
   */
  datasourceAuthCredentials?: AuthCredentials;

  /**
   * Specifies the type of validation. In case of DeepValidation, all validations from /validateForBackup API will run again.
   */
  validationType?: ValidationType;

  /**
   * Contains information of the Identity Details for the BI.
   * If it is null, default will be considered as System Assigned.
   */
  identityDetails?: IdentityDetails;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Datasource to be backed up
 */
model Datasource {
  /**
   * DatasourceType of the resource.
   */
  datasourceType?: string;

  /**
   * Type of Datasource object, used to initialize the right inherited type
   */
  objectType?: string;

  /**
   * Full ARM ID of the resource. For azure resources, this is ARM ID. For non azure resources, this will be the ID created by backup service via Fabric/Vault.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceID: string;

  /**
   * Location of datasource.
   */
  resourceLocation?: string;

  /**
   * Unique identifier of the resource in the context of parent.
   */
  resourceName?: string;

  /**
   * Resource Type of Datasource.
   */
  resourceType?: string;

  /**
   * Uri of the resource.
   */
  resourceUri?: string;

  /**
   * Properties specific to data source
   */
  resourceProperties?: BaseResourceProperties;
}

/**
 * Properties which are specific to datasource/datasourceSets
 */
@discriminator("objectType")
model BaseResourceProperties {
  /**
   * Type of the specific object - used for deserializing
   */
  objectType: ResourcePropertiesObjectType;
}

/**
 * DatasourceSet details of datasource to be backed up
 */
model DatasourceSet {
  /**
   * DatasourceType of the resource.
   */
  datasourceType?: string;

  /**
   * Type of Datasource object, used to initialize the right inherited type
   */
  objectType?: string;

  /**
   * Full ARM ID of the resource. For azure resources, this is ARM ID. For non azure resources, this will be the ID created by backup service via Fabric/Vault.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceID: string;

  /**
   * Location of datasource.
   */
  resourceLocation?: string;

  /**
   * Unique identifier of the resource in the context of parent.
   */
  resourceName?: string;

  /**
   * Resource Type of Datasource.
   */
  resourceType?: string;

  /**
   * Uri of the resource.
   */
  resourceUri?: string;

  /**
   * Properties specific to data source set
   */
  resourceProperties?: BaseResourceProperties;
}

/**
 * Policy Info in backupInstance
 */
model PolicyInfo {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  policyId: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  policyVersion?: string;

  /**
   * Policy parameters for the backup instance
   */
  policyParameters?: PolicyParameters;
}

/**
 * Parameters in Policy
 */
model PolicyParameters {
  /**
   * Gets or sets the DataStore Parameters
   */
  @identifiers(#[])
  dataStoreParametersList?: DataStoreParameters[];

  /**
   * Gets or sets the Backup Data Source Parameters
   */
  @identifiers(#[])
  backupDatasourceParametersList?: BackupDatasourceParameters[];
}

/**
 * Parameters for DataStore
 */
@discriminator("objectType")
model DataStoreParameters {
  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;

  /**
   * type of datastore; Operational/Vault/Archive
   */
  dataStoreType: DataStoreTypes;
}

/**
 * Parameters for Backup Datasource
 */
@discriminator("objectType")
model BackupDatasourceParameters {
  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Protection status details
 */
model ProtectionStatusDetails {
  /**
   * Specifies the protection status error of the resource
   */
  errorDetails?: UserFacingError;

  /**
   * Specifies the protection status of the resource
   */
  status?: Status;
}

/**
 * Error object used by layers that have access to localized content, and propagate that to user
 */
model UserFacingError {
  /**
   * Unique code for this error
   */
  code?: string;

  /**
   * Additional related Errors
   */
  @identifiers(#[])
  details?: UserFacingError[];

  /**
   * Inner Error
   */
  innerError?: InnerError;

  /**
   * Whether the operation will be retryable or not
   */
  isRetryable?: boolean;

  /**
   * Whether the operation is due to a user error or service error
   */
  isUserError?: boolean;

  /**
   * Any key value pairs that can be injected inside error object
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  message?: string;

  /**
   * RecommendedAction � localized.
   */
  recommendedAction?: string[];

  /**
   * Target of the error.
   */
  target?: string;
}

/**
 * Inner Error
 */
model InnerError {
  /**
   * Any Key value pairs that can be provided to the client for additional  verbose information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalInfo?: Record<string>;

  /**
   * Unique code for this error
   */
  code?: string;

  /**
   * Child Inner Error, to allow Nesting.
   */
  embeddedInnerError?: InnerError;
}

/**
 * Base class for different types of authentication credentials.
 */
@discriminator("objectType")
model AuthCredentials {
  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IdentityDetails {
  /**
   * Specifies if the BI is protected by System Identity.
   */
  useSystemAssignedIdentity?: boolean;

  /**
   * ARM URL for User Assigned Identity.
   */
  userAssignedIdentityArmUrl?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DppProxyResource {
  /**
   * Proxy Resource Id represents the complete path to the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Proxy Resource name associated with the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Proxy Resource type represents the complete path of the form Namespace/ResourceType/ResourceType/...
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Proxy Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

/**
 * Trigger backup request
 */
model TriggerBackupRequest {
  /**
   * Name for the Rule of the Policy which needs to be applied for this backup
   */
  backupRuleOptions: AdHocBackupRuleOptions;
}

/**
 * Adhoc backup rules
 */
model AdHocBackupRuleOptions {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ruleName: string;

  /**
   * Adhoc backup trigger option
   */
  triggerOption: AdhocBackupTriggerOption;
}

/**
 * Adhoc backup trigger option
 */
model AdhocBackupTriggerOption {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  retentionTagOverride?: string;
}

/**
 * Validate for backup request
 */
model ValidateForBackupRequest {
  /**
   * Backup Instance
   */
  backupInstance: BackupInstance;
}

/**
 * Validate for modify backup request
 */
model ValidateForModifyBackupRequest {
  /**
   * Backup Instance
   */
  backupInstance: BackupInstance;
}

/**
 * Azure backup recoveryPoint resource list
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureBackupRecoveryPointResourceList extends DppResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: AzureBackupRecoveryPointResource[];
}

/**
 * Azure backup recoveryPoint
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("objectType")
model AzureBackupRecoveryPoint {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Information about BI whose secondary RecoveryPoints are requested
 * Source region and
 * BI ARM path
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FetchSecondaryRPsRequestParameters {
  /**
   * Source region in which BackupInstance is located
   */
  sourceRegion?: string;

  /**
   * ARM Path of BackupInstance
   */
  sourceBackupInstanceId?: string;
}

/**
 * Cross Region Restore Request Object
 */
model CrossRegionRestoreRequestObject {
  /**
   * Gets or sets the restore request object.
   */
  restoreRequestObject: AzureBackupRestoreRequest;

  /**
   * Cross region restore details.
   */
  crossRegionRestoreDetails: CrossRegionRestoreDetails;
}

/**
 * Azure backup restore request
 */
@discriminator("objectType")
model AzureBackupRestoreRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;

  /**
   * Gets or sets the restore target information.
   */
  restoreTargetInfo: RestoreTargetInfoBase;

  /**
   * Gets or sets the type of the source data store.
   */
  sourceDataStoreType: SourceDataStoreType;

  /**
   * Fully qualified Azure Resource Manager ID of the datasource which is being recovered.
   */
  sourceResourceId?: string;

  /**
   * ResourceGuardOperationRequests on which LAC check will be performed
   */
  resourceGuardOperationRequests?: string[];

  /**
   * Contains information of the Identity Details for the BI.
   * If it is null, default will be considered as System Assigned.
   */
  identityDetails?: IdentityDetails;
}

/**
 * Base class common to RestoreTargetInfo and RestoreFilesTargetInfo
 */
@discriminator("objectType")
model RestoreTargetInfoBase {
  /**
   * Type of Datasource object, used to initialize the right inherited type
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;

  /**
   * Recovery Option
   */
  recoveryOption: RecoveryOption;

  /**
   * Target Restore region
   */
  restoreLocation?: string;
}

/**
 * Cross Region Restore details
 */
model CrossRegionRestoreDetails {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceRegion: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceBackupInstanceId: string;
}

/**
 * Cross Region Restore Request Object
 */
model ValidateCrossRegionRestoreRequestObject {
  /**
   * Gets or sets the restore request object.
   */
  restoreRequestObject: AzureBackupRestoreRequest;

  /**
   * Cross region restore details.
   */
  crossRegionRestoreDetails: CrossRegionRestoreDetails;
}

/**
 * Details of CRR Job to be fetched
 */
model CrossRegionRestoreJobRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceRegion: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceBackupVaultId: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  jobId: string;
}

/**
 * AzureBackup Job Class
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureBackupJob {
  /**
   * Job Activity Id
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  activityID: string;

  /**
   * Name of the Backup Instance
   */
  backupInstanceFriendlyName: string;

  /**
   * ARM ID of the Backup Instance
   */
  @visibility(Lifecycle.Read)
  backupInstanceId?: string;

  /**
   * ARM ID of the DataSource
   */
  dataSourceId: string;

  /**
   * Location of the DataSource
   */
  dataSourceLocation: string;

  /**
   * User Friendly Name of the DataSource
   */
  dataSourceName: string;

  /**
   * Data Source Set Name of the DataSource
   */
  dataSourceSetName?: string;

  /**
   * Type of DataSource
   */
  dataSourceType: string;

  /**
   * Total run time of the job. ISO 8601 format.
   */
  duration?: string;

  /**
   * EndTime of the job(in UTC)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * A List, detailing the errors related to the job
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errorDetails?: UserFacingError[];

  /**
   * Extended Information about the job
   */
  @visibility(Lifecycle.Read)
  extendedInfo?: JobExtendedInfo;

  /**
   * Indicated that whether the job is adhoc(true) or scheduled(false)
   */
  isUserTriggered: boolean;

  /**
   * It indicates the type of Job i.e. Backup:full/log/diff ;Restore:ALR/OLR; Tiering:Backup/Archive ; Management:ConfigureProtection/UnConfigure
   */
  operation: string;

  /**
   * It indicates the type of Job i.e. Backup/Restore/Tiering/Management
   */
  operationCategory: string;

  /**
   * ARM ID of the policy
   */
  @visibility(Lifecycle.Read)
  policyId?: string;

  /**
   * Name of the policy
   */
  @visibility(Lifecycle.Read)
  policyName?: string;

  /**
   * Indicated whether progress is enabled for the job
   */
  progressEnabled: boolean;

  /**
   * Url which contains job's progress
   */
  @visibility(Lifecycle.Read)
  progressUrl?: string;

  /**
   * Priority to be used for rehydration
   */
  @visibility(Lifecycle.Read)
  rehydrationPriority?: string;

  /**
   * It indicates the sub type of operation i.e. in case of Restore it can be ALR/OLR
   */
  @visibility(Lifecycle.Read)
  restoreType?: string;

  /**
   * Resource Group Name of the Datasource
   */
  sourceResourceGroup: string;

  /**
   * SubscriptionId corresponding to the DataSource
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceSubscriptionID: string;

  /**
   * StartTime of the job(in UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  /**
   * Status of the job like InProgress/Completed/Failed/Cancelled/CompletedWithWarnings/Cancelling/Paused
   */
  status: string;

  /**
   * Subscription Id of the corresponding backup vault
   */
  subscriptionId: string;

  /**
   * List of supported actions
   */
  supportedActions: string[];

  /**
   * Name of the vault
   */
  vaultName: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceDataStoreName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  destinationDataStoreName?: string;
}

/**
 * Extended Information about the job
 */
model JobExtendedInfo {
  /**
   * Job's Additional Details
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalDetails?: Record<string>;

  /**
   * State of the Backup Instance
   */
  @visibility(Lifecycle.Read)
  backupInstanceState?: string;

  /**
   * Number of bytes transferred
   */
  @visibility(Lifecycle.Read)
  dataTransferredInBytes?: float64;

  /**
   * Destination where restore is done
   */
  @visibility(Lifecycle.Read)
  recoveryDestination?: string;

  /**
   * Details of the Source Recovery Point
   */
  @visibility(Lifecycle.Read)
  sourceRecoverPoint?: RestoreJobRecoveryPointDetails;

  /**
   * List of Sub Tasks of the job
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  subTasks?: JobSubTask[];

  /**
   * Details of the Target Recovery Point
   */
  @visibility(Lifecycle.Read)
  targetRecoverPoint?: RestoreJobRecoveryPointDetails;

  /**
   * A List, detailing the warnings related to the job
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  warningDetails?: UserFacingWarningDetail[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RestoreJobRecoveryPointDetails {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPointID?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPointTime?: utcDateTime;
}

/**
 * Details of Job's Sub Task
 */
model JobSubTask {
  /**
   * Additional details of Sub Tasks
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalDetails?: Record<string>;

  /**
   * Task Id of the Sub Task
   */
  taskId: int32;

  /**
   * Name of the Sub Task
   */
  taskName: string;

  /**
   * Progress of the Sub Task
   */
  @visibility(Lifecycle.Read)
  taskProgress?: string;

  /**
   * Status of the Sub Task
   */
  taskStatus: string;
}

/**
 * Warning object used by layers that have access to localized content, and propagate that to user
 */
model UserFacingWarningDetail {
  /**
   * Name of resource for which warning is raised.
   */
  resourceName?: string;

  /**
   * Error details for the warning.
   */
  warning: UserFacingError;
}

/**
 * Details of Backup Vault for which CRR Jobs are to be fetched
 */
model CrossRegionRestoreJobsRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceRegion: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceBackupVaultId: string;
}

/**
 * List of AzureBackup Job resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureBackupJobResourceList extends DppResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: AzureBackupJobResource[];
}

/**
 * Azure Backup Rehydrate Request
 */
model AzureBackupRehydrationRequest {
  /**
   * Id of the recovery point to be recovered
   */
  recoveryPointId: string;

  /**
   * Priority to be used for rehydration. Values High or Standard
   */
  rehydrationPriority?: RehydrationPriority;

  /**
   * Retention duration in ISO 8601 format i.e P10D .
   */
  rehydrationRetentionDuration: string;
}

/**
 * Request body of Stop protection when MUA is Enabled
 */
model StopProtectionRequest {
  /**
   * ResourceGuardOperationRequests on which LAC check will be performed
   */
  resourceGuardOperationRequests?: string[];
}

/**
 * Request body of Suspend backup when MUA is Enabled
 */
model SuspendBackupRequest {
  /**
   * ResourceGuardOperationRequests on which LAC check will be performed
   */
  resourceGuardOperationRequests?: string[];
}

/**
 * Sync BackupInstance Request
 */
model SyncBackupInstanceRequest {
  /**
   * Field indicating sync type e.g. to sync only in case of failure or in all cases
   */
  syncType?: SyncType;
}

/**
 * Validate restore request object
 */
model ValidateRestoreRequestObject {
  /**
   * Gets or sets the restore request object.
   */
  restoreRequestObject: AzureBackupRestoreRequest;
}

/**
 * List Restore Ranges Request
 */
model AzureBackupFindRestorableTimeRangesRequest {
  /**
   * Gets or sets the type of the source data store.
   */
  sourceDataStoreType: RestoreSourceDataStoreType;

  /**
   * Start time for the List Restore Ranges request. ISO 8601 format.
   */
  startTime?: string;

  /**
   * End time for the List Restore Ranges request. ISO 8601 format.
   */
  endTime?: string;
}

/**
 * List Restore Ranges Response
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureBackupFindRestorableTimeRangesResponseResource extends DppResource {
  /**
   * AzureBackupFindRestorableTimeRangesResponseResource properties
   */
  properties?: AzureBackupFindRestorableTimeRangesResponse;
}

/**
 * List Restore Ranges Response
 */
model AzureBackupFindRestorableTimeRangesResponse {
  /**
   * Returns the Restore Ranges available on the Backup Instance.
   */
  @identifiers(#[])
  restorableTimeRanges?: RestorableTimeRange[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RestorableTimeRange {
  /**
   * Start time for the available restore range
   */
  startTime: string;

  /**
   * End time for the available restore range
   */
  endTime: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType?: string;
}

/**
 * The result for export jobs containing blob details.
 */
model ExportJobsResult {
  /**
   * URL of the blob into which the serialized string of list of jobs is exported.
   */
  @visibility(Lifecycle.Read)
  blobUrl?: string;

  /**
   * SAS key to access the blob.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @visibility(Lifecycle.Read)
  blobSasKey?: string;

  /**
   * URL of the blob into which the ExcelFile is uploaded.
   */
  @visibility(Lifecycle.Read)
  excelFileBlobUrl?: string;

  /**
   * SAS key to access the ExcelFile blob.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @visibility(Lifecycle.Read)
  excelFileBlobSasKey?: string;
}

/**
 * List of DeletedBackupInstance resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DeletedBackupInstanceResourceList extends DppResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: DeletedBackupInstanceResource[];
}

/**
 * Deleted Backup Instance
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DeletedBackupInstance extends BackupInstance {
  /**
   * Deletion info of Backup Instance
   */
  @visibility(Lifecycle.Read)
  deletionInfo?: DeletionInfo;
}

/**
 * Deletion Info
 */
model DeletionInfo {
  /**
   * Specifies time of deletion
   */
  @visibility(Lifecycle.Read)
  deletionTime?: string;

  /**
   * Specifies billing end date
   */
  @visibility(Lifecycle.Read)
  billingEndDate?: string;

  /**
   * Specifies purge time
   */
  @visibility(Lifecycle.Read)
  scheduledPurgeTime?: string;

  /**
   * Delete activity ID for troubleshooting purpose
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  deleteActivityID?: string;
}

/**
 * List of ResourceGuard resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceGuardResourceList extends DppTrackedResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: ResourceGuardResource[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceGuard {
  /**
   * Provisioning state of the BackupVault resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * This flag indicates whether auto approval is allowed or not.
   */
  @visibility(Lifecycle.Read)
  allowAutoApprovals?: boolean;

  /**
   * {readonly} List of operation details those are protected by the ResourceGuard resource
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  resourceGuardOperations?: ResourceGuardOperation[];

  /**
   * List of critical operations which are not protected by this resourceGuard
   */
  vaultCriticalOperationExclusionList?: string[];

  /**
   * Description about the pre-req steps to perform all the critical operations.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * This class contains all the details about a critical operation.
 */
model ResourceGuardOperation {
  /**
   * Name of the critical operation.
   */
  @visibility(Lifecycle.Read)
  vaultCriticalOperation?: string;

  /**
   * Type of resource request.
   */
  @visibility(Lifecycle.Read)
  requestResourceType?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DppTrackedResourceList {
  /**
   * The uri to fetch the next page of resources. Call ListNext() fetches next page of resources.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Patch Request content for Microsoft.DataProtection Resource Guard resources
 */
model PatchResourceGuardInput {
  /**
   * Resource Guard tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Base for all lists of V2 resources.
 */
model DppBaseResourceList is Azure.Core.Page<DppBaseResource>;

/**
 * List of ResourceGuardProxyBase resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceGuardProxyBaseResourceList extends DppResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: ResourceGuardProxyBaseResource[];
}

/**
 * ResourceGuardProxyBase object, used in ResourceGuardProxyBaseResource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceGuardProxyBase {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGuardResourceId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  resourceGuardOperationDetails?: ResourceGuardOperationDetail[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  lastUpdatedTime?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string;
}

/**
 * VaultCritical Operation protected by a resource guard
 */
model ResourceGuardOperationDetail {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vaultCriticalOperation?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  defaultResourceRequest?: string;
}

/**
 * Request body of unlock delete API.
 */
model UnlockDeleteRequest {
  /**
   * ResourceGuardOperationRequests on which LAC check will be performed
   */
  resourceGuardOperationRequests?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceToBeDeleted?: string;
}

/**
 * Response of Unlock Delete API.
 */
model UnlockDeleteResponse {
  /**
   * This is the time when unlock delete privileges will get expired.
   */
  unlockDeleteExpiryTime?: string;
}

/**
 * Delete option with duration
 */
model AbsoluteDeleteOption extends DeleteOption {
  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "AbsoluteDeleteOption";
}

/**
 * Delete Option
 */
@discriminator("objectType")
model DeleteOption {
  /**
   * Duration of deletion after given timespan
   */
  duration: string;

  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecoveryPointsFilters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  restorePointDataStoreId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isVisible?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  startDate?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endDate?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedInfo?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  restorePointState?: string;
}

/**
 * Adhoc backup tagging criteria
 */
model AdhocBasedTaggingCriteria {
  /**
   * Retention tag information
   */
  tagInfo?: RetentionTag;
}

/**
 * Retention tag
 */
model RetentionTag {
  /**
   * Retention Tag version.
   */
  @visibility(Lifecycle.Read)
  eTag?: string;

  /**
   * Retention Tag version.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Retention Tag Name to relate it to retention rule.
   */
  tagName: string;
}

/**
 * Adhoc trigger context
 */
model AdhocBasedTriggerContext extends TriggerContext {
  /**
   * Tagging Criteria containing retention tag for adhoc backup.
   */
  taggingCriteria: AdhocBasedTaggingCriteria;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "AdhocBasedTriggerContext";
}

/**
 * Trigger context
 */
@discriminator("objectType")
model TriggerContext {
  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Azure backup discrete RecoveryPoint
 */
model AzureBackupDiscreteRecoveryPoint extends AzureBackupRecoveryPoint {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  friendlyName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPointDataStoresDetails?: RecoveryPointDataStoreDetails[];

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPointTime: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  policyName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  policyVersion?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPointId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPointType?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  retentionTagName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  retentionTagVersion?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * Specifies recovery point completeness. Partial (i.e., only some of the intended items were backed up), or Completed (i.e., ALL intended items were backed up).
   */
  recoveryPointState?: RecoveryPointCompletionState;

  objectType: "AzureBackupDiscreteRecoveryPoint";
}

/**
 * RecoveryPoint datastore details
 */
model RecoveryPointDataStoreDetails {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  creationTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  expiryTime?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  id?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metaData?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  state?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  visible?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rehydrationExpiryTime?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  rehydrationStatus?: RehydrationStatus;
}

/**
 * List Restore Ranges Request
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureBackupFindRestorableTimeRangesRequestResource
  extends DppWorkerRequest {
  /**
   * AzureBackupFindRestorableTimeRangesRequestResource content
   */
  content?: AzureBackupFindRestorableTimeRangesRequest;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DppWorkerRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  uri?: string;

  /**
   * Dictionary of <components·ikn5y4·schemas·dppworkerrequest·properties·headers·additionalproperties>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  headers?: Record<string[]>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  supportedGroupVersions?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  cultureInfo?: string;

  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpMethod?: string;
}

/**
 * Azure backup parameters
 */
model AzureBackupParams extends BackupParameters {
  /**
   * BackupType ; Full/Incremental etc
   */
  backupType: string;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "AzureBackupParams";
}

/**
 * BackupParameters base
 */
@discriminator("objectType")
model BackupParameters {
  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Azure backup recoveryPoint based restore request
 */
model AzureBackupRecoveryPointBasedRestoreRequest
  extends AzureBackupRestoreRequest {
  ...AzureBackupRestoreCommon;
  objectType: "AzureBackupRecoveryPointBasedRestoreRequest";
}
/**
 * AzureBackup Restore common properties
 */
model AzureBackupRestoreCommon {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recoveryPointId: string;
}
/**
 * AzureBackup Restore with Rehydration Request
 */
model AzureBackupRestoreWithRehydrationRequest
  extends AzureBackupRestoreRequest {
  ...AzureBackupRestoreCommon;

  /**
   * Priority to be used for rehydration. Values High or Standard
   */
  rehydrationPriority: RehydrationPriority;

  /**
   * Retention duration in ISO 8601 format i.e P10D .
   */
  rehydrationRetentionDuration: string;

  objectType: "AzureBackupRestoreWithRehydrationRequest";
}

/**
 * AzureBackup RecoveryPointTime Based Restore Request
 */
model AzureBackupRecoveryTimeBasedRestoreRequest
  extends AzureBackupRestoreRequest {
  /**
   * The recovery time in ISO 8601 format example - 2020-08-14T17:30:00.0000000Z.
   */
  recoveryPointTime: string;

  objectType: "AzureBackupRecoveryTimeBasedRestoreRequest";
}

/**
 * Azure backup rule
 */
model AzureBackupRule extends BasePolicyRule {
  /**
   * BackupParameters base
   */
  backupParameters?: BackupParameters;

  /**
   * DataStoreInfo base
   */
  dataStore: DataStoreInfoBase;

  /**
   * Trigger context
   */
  trigger: TriggerContext;

  objectType: "AzureBackupRule";
}

/**
 * DataStoreInfo base
 */
model DataStoreInfoBase {
  /**
   * type of datastore; Operational/Vault/Archive
   */
  dataStoreType: DataStoreTypes;

  /**
   * Type of Datasource object, used to initialize the right inherited type
   */
  objectType: string;
}

/**
 * BasePolicy Rule
 */
@discriminator("objectType")
model BasePolicyRule {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Parameters for Operational-Tier DataStore
 */
model AzureOperationalStoreParameters extends DataStoreParameters {
  /**
   * Gets or sets the Snapshot Resource Group Uri.
   */
  resourceGroupId?: string;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "AzureOperationalStoreParameters";
}

/**
 * Parameters for Kubernetes Cluster Backup Datasource
 */
model KubernetesClusterBackupDatasourceParameters
  extends BackupDatasourceParameters {
  /**
   * Gets or sets the volume snapshot property. This property if enabled will take volume snapshots during backup.
   */
  snapshotVolumes: boolean;

  /**
   * Gets or sets the include volume types property. This property sets the volume types to be included during backup.
   */
  includedVolumeTypes?: AKSVolumeTypes[];

  /**
   * Gets or sets the include cluster resources property. This property if enabled will include cluster scope resources during backup.
   */
  includeClusterScopeResources: boolean;

  /**
   * Gets or sets the include namespaces property. This property sets the namespaces to be included during backup.
   */
  includedNamespaces?: string[];

  /**
   * Gets or sets the exclude namespaces property. This property sets the namespaces to be excluded during backup.
   */
  excludedNamespaces?: string[];

  /**
   * Gets or sets the include resource types property. This property sets the resource types to be included during backup.
   */
  includedResourceTypes?: string[];

  /**
   * Gets or sets the exclude resource types property. This property sets the resource types to be excluded during backup.
   */
  excludedResourceTypes?: string[];

  /**
   * Gets or sets the LabelSelectors property. This property sets the resource with such label selectors to be included during backup.
   */
  labelSelectors?: string[];

  /**
   * Gets or sets the backup hook references. This property sets the hook reference to be executed during backup.
   */
  @identifiers(#[])
  backupHookReferences?: NamespacedNameResource[];

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "KubernetesClusterBackupDatasourceParameters";
}

/**
 * Class to refer resources which contains namespace and name
 */
model NamespacedNameResource {
  /**
   * Name of the resource
   */
  name?: string;

  /**
   * Namespace in which the resource exists
   */
  `namespace`?: string;
}

/**
 * Parameters to be used during configuration of backup of blobs
 */
model BlobBackupDatasourceParameters extends BackupDatasourceParameters {
  ...BlobBackupDatasourceCommonParameters;

  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: "BlobBackupDatasourceParameters";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BlobBackupDatasourceCommonParameters {
  /**
   * List of containers to be backed up during configuration of backup of blobs
   */
  containersList: string[];
}

/**
 * Parameters to be used during configuration of backup of azure data lake storage account blobs
 */
model AdlsBlobBackupDatasourceParameters extends BackupDatasourceParameters {
  ...BlobBackupDatasourceCommonParameters;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "AdlsBlobBackupDatasourceParameters";
}

/**
 * Azure retention rule
 */
model AzureRetentionRule extends BasePolicyRule {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isDefault?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  lifecycles: SourceLifeCycle[];

  objectType: "AzureRetentionRule";
}

/**
 * Source LifeCycle
 */
model SourceLifeCycle {
  /**
   * Delete Option
   */
  deleteAfter: DeleteOption;

  /**
   * DataStoreInfo base
   */
  sourceDataStore: DataStoreInfoBase;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  targetDataStoreCopySettings?: TargetCopySetting[];
}

/**
 * Target copy settings
 */
model TargetCopySetting {
  /**
   * It can be CustomCopyOption or ImmediateCopyOption.
   */
  copyAfter: CopyOption;

  /**
   * Info of target datastore
   */
  dataStore: DataStoreInfoBase;
}

/**
 * Options to copy
 */
@discriminator("objectType")
model CopyOption {
  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * BackupCriteria base class
 */
@discriminator("objectType")
model BackupCriteria {
  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Rule based backup policy
 */
model BackupPolicy extends BaseBackupPolicy {
  /**
   * Policy rule dictionary that contains rules for each backuptype i.e Full/Incremental/Logs etc
   */
  @identifiers(#[])
  policyRules: BasePolicyRule[];

  objectType: "BackupPolicy";
}

/**
 * Schedule for backup
 */
model BackupSchedule {
  /**
   * Repeating time interval which supports the ISO 8601 format and unsupported or partially supported formats.
   *
   * Supported ISO 8601 Time Formats
   *
   * The following time formats were verified to be successfully parsed and supported:
   * - T14:30:45.123 → Thh:mm:ss.sss (with milliseconds)
   * - T14:30:45 → Thh:mm:ss (standard time format)
   * - T14:30 → Thh:mm (hour and minute only)
   *
   * All of the above may include time zone indicators like 'Z', '+05:30', '-08:00'.
   *
   * Examples of supported timestamps:
   * - 2023-10-15T14:30:45Z
   * - 2023-10-15T14:30:45.123+05:30
   * - 2023-10-15T14:30Z
   *
   * Unsupported or partially supported formats:
   * - T143045.123 or T143045 (no colons)
   * - T14.500 (decimal hours)
   * - T14 (hour only)
   * - T14:30.500 (minute fractions)
   * - T24:00:00 (invalid)
   * - T23:59:60 (leap second)
   */
  repeatingTimeIntervals: string[];

  /**
   * Time Zone for a schedule.
   *
   * Supported timezone indicators include:
   * - 'Z' for UTC
   * - '+00:00'
   * - '+05:30'
   * - '-08:00'
   *
   * Examples:
   * - 2023-10-15T14:30:45Z
   * - 2023-10-15T14:30:45.123+05:30
   * - 2023-10-15T14:30-08:00
   */
  timeZone?: string;
}

/**
 * Copy on Expiry Option
 */
model CopyOnExpiryOption extends CopyOption {
  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "CopyOnExpiryOption";
}

/**
 * Duration based custom options to copy
 */
model CustomCopyOption extends CopyOption {
  /**
   * Data copied after given timespan
   */
  duration?: string;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "CustomCopyOption";
}

/**
 * Day of the week
 */
model Day {
  /**
   * Date of the month
   */
  date?: int32;

  /**
   * Whether Date is last date of month
   */
  isLast?: boolean;
}

/**
 * Default source properties
 */
model DefaultResourceProperties extends BaseResourceProperties {
  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "DefaultResourceProperties";
}

/**
 * Base class for feature object
 */
model FeatureValidationRequest extends FeatureValidationRequestBase {
  /**
   * backup support feature type.
   */
  featureType?: FeatureType;

  /**
   * backup support feature name.
   */
  featureName?: string;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "FeatureValidationRequest";
}

/**
 * Feature Validation Response
 */
model FeatureValidationResponse extends FeatureValidationResponseBase {
  /**
   * backup support feature type.
   */
  featureType?: FeatureType;

  /**
   * Response features
   */
  @identifiers(#[])
  features?: SupportedFeature[];

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "FeatureValidationResponse";
}

/**
 * Elements class for feature request
 */
model SupportedFeature {
  /**
   * support feature type.
   */
  featureName?: string;

  /**
   * feature support status
   */
  supportStatus?: FeatureSupportStatus;

  /**
   * support feature type.
   */
  exposureControlledFeatures?: string[];
}

/**
 * Immediate copy Option
 */
model ImmediateCopyOption extends CopyOption {
  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "ImmediateCopyOption";
}

/**
 * Class to contain criteria for item level restore
 */
@discriminator("objectType")
model ItemLevelRestoreCriteria {
  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: string;
}

/**
 * Restore target info for Item level restore operation
 */
model ItemLevelRestoreTargetInfo extends RestoreTargetInfoBase {
  /**
   * Restore Criteria
   */
  @identifiers(#[])
  restoreCriteria: ItemLevelRestoreCriteria[];

  /**
   * Information of target DS
   */
  datasourceInfo: Datasource;

  /**
   * Information of target DS Set
   */
  datasourceSetInfo?: DatasourceSet;

  /**
   * Credentials to use to authenticate with data source provider.
   */
  datasourceAuthCredentials?: AuthCredentials;

  /**
   * Type of Datasource object, used to initialize the right inherited type
   */
  objectType: "ItemLevelRestoreTargetInfo";
}

/**
 * Prefix criteria to be used to during restore
 */
model ItemPathBasedRestoreCriteria extends ItemLevelRestoreCriteria {
  /**
   * The path of the item to be restored. It could be the full path of the item or the path relative to the backup item
   */
  itemPath: string;

  /**
   * Flag to specify if the path is relative to backup item or full path
   */
  isPathRelativeToBackupItem: boolean;

  /**
   * The list of prefix strings to be used as filter criteria during restore. These are relative to the item path specified.
   */
  subItemPathPrefix?: string[];

  /**
   * Rename the item to be restored. Restore will rename the itemPath to this new name if the value is specified otherwise the itemPath will be restored as same name.
   */
  renameTo?: string;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "ItemPathBasedRestoreCriteria";
}

/**
 * Item Level target info for restore operation
 */
model RangeBasedItemLevelRestoreCriteria extends ItemLevelRestoreCriteria {
  /**
   * minimum value for range prefix match
   */
  minMatchingValue?: string;

  /**
   * maximum value for range prefix match
   */
  maxMatchingValue?: string;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "RangeBasedItemLevelRestoreCriteria";
}

/**
 * Item Level kubernetes storage class target info for restore operation
 */
model KubernetesStorageClassRestoreCriteria extends ItemLevelRestoreCriteria {
  /**
   * Selected storage class name
   */
  selectedStorageClassName?: string;

  /**
   * Provisioner of the storage class
   */
  provisioner?: string;

  /**
   * Type of the specific object - used for deserializing
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType: "KubernetesStorageClassRestoreCriteria";
}

/**
 * Item Level kubernetes persistent volume target info for restore operation
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model KubernetesPVRestoreCriteria extends ItemLevelRestoreCriteria {
  /**
   * Selected persistent volume claim name
   */
  name?: string;

  /**
   * Selected storage class name for restore operation
   */
  storageClassName?: string;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "KubernetesPVRestoreCriteria";
}

/**
 * kubernetes Cluster Backup target info for restore operation
 */
model KubernetesClusterRestoreCriteria extends ItemLevelRestoreCriteria {
  /**
   * Gets or sets the include cluster resources property. This property if enabled will include cluster scope resources during restore.
   */
  includeClusterScopeResources: boolean;

  /**
   * Gets or sets the include namespaces property. This property sets the namespaces to be included during restore.
   */
  includedNamespaces?: string[];

  /**
   * Gets or sets the exclude namespaces property. This property sets the namespaces to be excluded during restore.
   */
  excludedNamespaces?: string[];

  /**
   * Gets or sets the include resource types property. This property sets the resource types to be included during restore.
   */
  includedResourceTypes?: string[];

  /**
   * Gets or sets the exclude resource types property. This property sets the resource types to be excluded during restore.
   */
  excludedResourceTypes?: string[];

  /**
   * Gets or sets the LabelSelectors property. This property sets the resource with such label selectors to be included during restore.
   */
  labelSelectors?: string[];

  /**
   * Gets or sets the PV (Persistent Volume) Restore Mode property. This property sets whether volumes needs to be restored.
   */
  persistentVolumeRestoreMode?: PersistentVolumeRestoreMode;

  /**
   * Gets or sets the Conflict Policy property. This property sets policy during conflict of resources during restore.
   */
  conflictPolicy?: ExistingResourcePolicy;

  /**
   * Gets or sets the Namespace Mappings property. This property sets if namespace needs to be change during restore.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  namespaceMappings?: Record<string>;

  /**
   * Gets or sets the restore hook references. This property sets the hook reference to be executed during restore.
   */
  @identifiers(#[])
  restoreHookReferences?: NamespacedNameResource[];

  /**
   * Gets or sets the resource modifier reference. This property sets the reference for resource modifier during restore.
   */
  resourceModifierReference?: NamespacedNameResource;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "KubernetesClusterRestoreCriteria";
}

/**
 * kubernetes Cluster Backup target info for restore operation from vault
 */
model KubernetesClusterVaultTierRestoreCriteria
  extends ItemLevelRestoreCriteria {
  /**
   * Gets or sets the include cluster resources property. This property if enabled will include cluster scope resources during restore from vault.
   */
  includeClusterScopeResources: boolean;

  /**
   * Gets or sets the include namespaces property. This property sets the namespaces to be included during restore from vault.
   */
  includedNamespaces?: string[];

  /**
   * Gets or sets the exclude namespaces property. This property sets the namespaces to be excluded during restore from vault.
   */
  excludedNamespaces?: string[];

  /**
   * Gets or sets the include resource types property. This property sets the resource types to be included during restore from vault.
   */
  includedResourceTypes?: string[];

  /**
   * Gets or sets the exclude resource types property. This property sets the resource types to be excluded during restore from vault.
   */
  excludedResourceTypes?: string[];

  /**
   * Gets or sets the LabelSelectors property. This property sets the resource with such label selectors to be included during restore from vault.
   */
  labelSelectors?: string[];

  /**
   * Gets or sets the PV (Persistent Volume) Restore Mode property. This property sets whether volumes needs to be restored from vault.
   */
  persistentVolumeRestoreMode?: PersistentVolumeRestoreMode;

  /**
   * Gets or sets the Conflict Policy property. This property sets policy during conflict of resources during restore from vault.
   */
  conflictPolicy?: ExistingResourcePolicy;

  /**
   * Gets or sets the Namespace Mappings property. This property sets if namespace needs to be change during restore from vault.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  namespaceMappings?: Record<string>;

  /**
   * Gets or sets the restore hook references. This property sets the hook reference to be executed during restore from vault.
   */
  @identifiers(#[])
  restoreHookReferences?: NamespacedNameResource[];

  /**
   * Gets or sets the staging RG Id for creating staging disks and snapshots during restore from vault.
   */
  stagingResourceGroupId?: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the staging Storage Account Id for creating backup extension object store data during restore from vault.
   */
  stagingStorageAccountId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * Gets or sets the resource modifier reference. This property sets the reference for resource modifier during restore.
   */
  resourceModifierReference?: NamespacedNameResource;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "KubernetesClusterVaultTierRestoreCriteria";
}

/**
 * Class encapsulating restore as files target parameters
 */
model RestoreFilesTargetInfo extends RestoreTargetInfoBase {
  /**
   * Destination of RestoreAsFiles operation, when destination is not a datasource
   */
  targetDetails: TargetDetails;

  /**
   * Type of Datasource object, used to initialize the right inherited type
   */
  objectType: "RestoreFilesTargetInfo";
}

/**
 * Class encapsulating target details, used where the destination is not a datasource
 */
model TargetDetails {
  /**
   * Restore operation may create multiple files inside location pointed by Url
   * Below will be the common prefix for all of them
   */
  filePrefix: string;

  /**
   * Denotes the target location where the data will be restored,
   * string value for the enum {Microsoft.Internal.AzureBackup.DataProtection.Common.Interface.RestoreTargetLocationType}
   */
  restoreTargetLocationType: RestoreTargetLocationType;

  /**
   * Url denoting the restore destination. It can point to container / file share etc
   */
  url: string;

  /**
   * Full ARM Id denoting the restore destination. It is the ARM Id pointing to container / file share
   * This is optional if the target subscription can be identified with the URL field. If not
   * then this is needed if CrossSubscriptionRestore field of BackupVault is in any of the disabled states
   */
  targetResourceArmId?: string;
}

/**
 * Class encapsulating restore target parameters
 */
model RestoreTargetInfo extends RestoreTargetInfoBase {
  /**
   * Information of target DS
   */
  datasourceInfo: Datasource;

  /**
   * Information of target DS Set
   */
  datasourceSetInfo?: DatasourceSet;

  /**
   * Credentials to use to authenticate with data source provider.
   */
  datasourceAuthCredentials?: AuthCredentials;

  /**
   * Type of Datasource object, used to initialize the right inherited type
   */
  objectType: "RestoreTargetInfo";
}

/**
 * Schedule based backup criteria
 */
model ScheduleBasedBackupCriteria extends BackupCriteria {
  /**
   * it contains absolute values like "AllBackup" / "FirstOfDay" / "FirstOfWeek" / "FirstOfMonth"
   * and should be part of AbsoluteMarker enum
   */
  absoluteCriteria?: AbsoluteMarker[];

  /**
   * This is day of the month from 1 to 28 other wise last of month
   */
  @identifiers(#[])
  daysOfMonth?: Day[];

  /**
   * It should be Sunday/Monday/T..../Saturday
   */
  daysOfTheWeek?: DayOfWeek[];

  /**
   * It should be January/February/....../December
   */
  monthsOfYear?: Month[];

  /**
   * List of schedule times for backup
   */
  scheduleTimes?: utcDateTime[];

  /**
   * It should be First/Second/Third/Fourth/Last
   */
  weeksOfTheMonth?: WeekNumber[];

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "ScheduleBasedBackupCriteria";
}

/**
 * Schedule based trigger context
 */
model ScheduleBasedTriggerContext extends TriggerContext {
  /**
   * Schedule for this backup
   */
  schedule: BackupSchedule;

  /**
   * List of tags that can be applicable for given schedule.
   */
  @identifiers(#[])
  taggingCriteria: TaggingCriteria[];

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "ScheduleBasedTriggerContext";
}

/**
 * Tagging criteria
 */
model TaggingCriteria {
  /**
   * Criteria which decides whether the tag can be applied to a triggered backup.
   */
  @identifiers(#[])
  criteria?: BackupCriteria[];

  /**
   * Specifies if tag is default.
   */
  isDefault: boolean;

  /**
   * Retention Tag priority.
   */
  taggingPriority: int64;

  /**
   * Retention tag information
   */
  tagInfo: RetentionTag;
}

/**
 * Secret store based authentication credentials.
 */
model SecretStoreBasedAuthCredentials extends AuthCredentials {
  /**
   * Secret store resource
   */
  secretStoreResource?: SecretStoreResource;

  /**
   * Type of the specific object - used for deserializing
   */
  objectType: "SecretStoreBasedAuthCredentials";
}

/**
 * Class representing a secret store resource.
 */
model SecretStoreResource {
  /**
   * Uri to get to the resource
   */
  uri?: string;

  /**
   * Gets or sets the type of secret store
   */
  secretStoreType: SecretStoreType;

  /**
   * Gets or sets value stored in secret store resource
   */
  value?: string;
}
