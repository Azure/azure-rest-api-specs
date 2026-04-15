import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.StorageCache;

/**
 * Result of the request to list import jobs. It contains a list of import jobs and a URL link to get the next set of results.
 */
model ImportJobsListResult {
  /**
   * List of import jobs.
   */
  @pageItems
  value?: ImportJob[];

  /**
   * URL to get the next set of import job list results, if there are any.
   */
  @nextLink
  nextLink?: url;
}

/**
 * Result of the request to list expansion jobs. It contains a list of expansion jobs and a URL link to get the next set of results.
 */
model ExpansionJobsListResult {
  /**
   * List of expansion jobs.
   */
  @pageItems
  value?: ExpansionJob[];

  /**
   * URL to get the next set of expansion job list results, if there are any.
   */
  @nextLink
  nextLink?: url;
}

/**
 * Result of the request to list auto import jobs. It contains a list of auto import jobs and a URL link to get the next set of results.
 */
model AutoImportJobsListResult {
  /**
   * List of auto import jobs.
   */
  @pageItems
  value?: AutoImportJob[];

  /**
   * URL to get the next set of auto import job list results, if there are any.
   */
  @nextLink
  nextLink?: url;
}

/**
 * Result of the request to list auto export jobs. It contains a list of auto export jobs and a URL link to get the next set of results.
 */
model AutoExportJobsListResult {
  /**
   * List of auto export jobs.
   */
  @pageItems
  value?: AutoExportJob[];

  /**
   * URL to get the next set of auto export job list results, if there are any.
   */
  @nextLink
  nextLink?: url;
}

/**
 * Result of the request to list Resource Provider operations. It contains a list of operations and a URL link to get the next set of results.
 */
model ApiOperationListResult {
  /**
   * List of Resource Provider operations supported by the Microsoft.StorageCache resource provider.
   */
  @identifiers(#[])
  @pageItems
  value?: ApiOperation[];

  /**
   * URL to get the next set of operation list results if there are any.
   */
  @nextLink
  nextLink?: url;
}

/**
 * Result of the request to list AML file systems. It contains a list of AML file systems and a URL link to get the next set of results.
 */
model AmlFilesystemsListResult {
  /**
   * List of AML file systems.
   */
  @pageItems
  value?: AmlFilesystem[];

  /**
   * URL to get the next set of AML file system list results, if there are any.
   */
  @nextLink
  nextLink?: url;
}

/**
 * Result of the request to list caches. It contains a list of caches and a URL link to get the next set of results.
 */
model CachesListResult {
  /**
   * List of caches.
   */
  @pageItems
  value?: Cache[];

  /**
   * URL to get the next set of cache list results, if there are any.
   */
  @nextLink
  nextLink?: url;
}
/**
 * List of AML file system health states.
 */
union AmlFilesystemHealthStateType {
  string,

  /**
   * Unavailable
   */
  Unavailable: "Unavailable",

  /**
   * Available
   */
  Available: "Available",

  /**
   * Degraded
   */
  Degraded: "Degraded",

  /**
   * Transitioning
   */
  Transitioning: "Transitioning",

  /**
   * Maintenance
   */
  Maintenance: "Maintenance",

  /**
   * Expanding
   */
  Expanding: "Expanding",
}

/**
 * ARM provisioning state.
 */
union AmlFilesystemProvisioningStateType {
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
   * Creating
   */
  Creating: "Creating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * The state of the archive operation
 */
union ArchiveStatusType {
  string,

  /**
   * NotConfigured
   */
  NotConfigured: "NotConfigured",

  /**
   * Idle
   */
  Idle: "Idle",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Cancelling
   */
  Cancelling: "Cancelling",

  /**
   * FSScanInProgress
   */
  FSScanInProgress: "FSScanInProgress",
}

/**
 * Squash mode of the AML file system. 'All': User and Group IDs on files will be squashed to the provided values for all users on non-trusted systems. 'RootOnly': User and Group IDs on files will be squashed to provided values for solely the root user on non-trusted systems. 'None': No squashing of User and Group IDs is performed for any users on any systems.
 */
union AmlFilesystemSquashMode {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * RootOnly
   */
  RootOnly: "RootOnly",

  /**
   * All
   */
  All: "All",
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

/**
 * ARM provisioning state.
 */
union AutoExportJobProvisioningStateType {
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
   * Creating
   */
  Creating: "Creating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * The administrative status of the auto export job. Possible values: 'Enable', 'Disable'. Passing in a value of 'Disable' will disable the current active auto export job. By default it is set to 'Enable'.
 */
union AutoExportJobAdminStatus {
  string,

  /**
   * Enable
   */
  Enable: "Enable",

  /**
   * Disable
   */
  Disable: "Disable",
}

/**
 * The operational state of auto export. InProgress indicates the export is running.  Disabling indicates the user has requested to disable the export but the disabling is still in progress. Disabled indicates auto export has been disabled.  DisableFailed indicates the disabling has failed.  Failed means the export was unable to continue, due to a fatal error.
 */
union AutoExportStatusType {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Disabling
   */
  Disabling: "Disabling",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * DisableFailed
   */
  DisableFailed: "DisableFailed",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * ARM provisioning state.
 */
union ImportJobProvisioningStateType {
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
   * Creating
   */
  Creating: "Creating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * The administrative status of the import job. Possible values: 'Active', 'Cancel'. Passing in a value of 'Cancel' will cancel the current active import job. By default it is set to 'Active'.
 */
union ImportJobAdminStatus {
  string,

  /**
   * Active
   */
  Active: "Active",

  /**
   * Cancel
   */
  Cancel: "Cancel",
}

/**
 * How the import job will handle conflicts. For example, if the import job is trying to bring in a directory, but a file is at that path, how it handles it. Fail indicates that the import job should stop immediately and not do anything with the conflict. Skip indicates that it should pass over the conflict. OverwriteIfDirty causes the import job to delete and re-import the file or directory if it is a conflicting type, is dirty, or was not previously imported. OverwriteAlways extends OverwriteIfDirty to include releasing files that had been restored but were not dirty. Please reference https://learn.microsoft.com/en-us/azure/azure-managed-lustre/ for a thorough explanation of these resolution modes.
 */
union ConflictResolutionMode {
  string,

  /**
   * Fail
   */
  Fail: "Fail",

  /**
   * Skip
   */
  Skip: "Skip",

  /**
   * OverwriteIfDirty
   */
  OverwriteIfDirty: "OverwriteIfDirty",

  /**
   * OverwriteAlways
   */
  OverwriteAlways: "OverwriteAlways",
}

/**
 * The operational state of the import job. InProgress indicates the import is still running. Canceled indicates it has been canceled by the user. Completed indicates import finished, successfully importing all discovered blobs into the Lustre namespace. CompletedPartial indicates the import finished but some blobs either were found to be conflicting and could not be imported or other errors were encountered. Failed means the import was unable to complete due to a fatal error.
 */
union ImportStatusType {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Cancelling
   */
  Cancelling: "Cancelling",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * CompletedPartial
   */
  CompletedPartial: "CompletedPartial",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * ARM provisioning state.
 */
union AutoImportJobPropertiesProvisioningState {
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
   * Creating
   */
  Creating: "Creating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * The administrative status of the auto import job. Possible values: 'Enable', 'Disable'. Passing in a value of 'Disable' will disable the current active auto import job. By default it is set to 'Enable'.
 */
union AutoImportJobPropertiesAdminStatus {
  string,

  /**
   * Enable
   */
  Enable: "Enable",

  /**
   * Disable
   */
  Disable: "Disable",
}

/**
 * The state of the auto import operation.
 */
union AutoImportJobState {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Disabling
   */
  Disabling: "Disabling",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The administrative status of the auto import job. Possible values: 'Enable', 'Disable'. Passing in a value of 'Disable' will disable the current active auto import job. By default it is set to 'Enable'.
 */
union AutoImportJobUpdatePropertiesAdminStatus {
  string,

  /**
   * Enable
   */
  Enable: "Enable",

  /**
   * Disable
   */
  Disable: "Disable",
}

/**
 * ARM provisioning state, see https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#provisioningstate-property
 */
union ExpansionJobPropertiesProvisioningState {
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
   * Creating
   */
  Creating: "Creating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * The operational state of the expansion job. InProgress indicates the expansion is still running. Completed indicates expansion finished successfully. Failed means the expansion was unable to complete due to a fatal error. Deleting indicates the expansion is being rolled back.
 */
union ExpansionJobStatusType {
  string,

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
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * RollingBack
   */
  RollingBack: "RollingBack",
}

/**
 * The status of the AML file system subnet check.
 */
union FilesystemSubnetStatusType {
  string,

  /**
   * Ok
   */
  Ok: "Ok",

  /**
   * Invalid
   */
  Invalid: "Invalid",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union MetricAggregationType {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * None
   */
  None: "None",

  /**
   * Average
   */
  Average: "Average",

  /**
   * Minimum
   */
  Minimum: "Minimum",

  /**
   * Maximum
   */
  Maximum: "Maximum",

  /**
   * Total
   */
  Total: "Total",

  /**
   * Count
   */
  Count: "Count",
}

/**
 * The reason for the restriction. As of now this can be "QuotaId" or "NotAvailableForSubscription". "QuotaId" is set when the SKU has requiredQuotas parameter as the subscription does not belong to that quota. "NotAvailableForSubscription" is related to capacity at the datacenter.
 */
union ReasonCode {
  string,

  /**
   * QuotaId
   */
  QuotaId: "QuotaId",

  /**
   * NotAvailableForSubscription
   */
  NotAvailableForSubscription: "NotAvailableForSubscription",
}

/**
 * List of cache health states. Down is when the cluster is not responding.  Degraded is when its functioning but has some alerts. Transitioning when it is creating or deleting. Unknown will be returned in old api versions when a new value is added in future versions. WaitingForKey is when the create is waiting for the system assigned identity to be given access to the encryption key in the encryption settings.
 */
union HealthStateType {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Healthy
   */
  Healthy: "Healthy",

  /**
   * Degraded
   */
  Degraded: "Degraded",

  /**
   * Down
   */
  Down: "Down",

  /**
   * Transitioning
   */
  Transitioning: "Transitioning",

  /**
   * Stopping
   */
  Stopping: "Stopping",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Upgrading
   */
  Upgrading: "Upgrading",

  /**
   * Flushing
   */
  Flushing: "Flushing",

  /**
   * WaitingForKey
   */
  WaitingForKey: "WaitingForKey",

  /**
   * StartFailed
   */
  StartFailed: "StartFailed",

  /**
   * UpgradeFailed
   */
  UpgradeFailed: "UpgradeFailed",
}

/**
 * ARM provisioning state, see https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#provisioningstate-property
 */
union ProvisioningStateType {
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
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * True if there is a firmware update ready to install on this cache. The firmware will automatically be installed after firmwareUpdateDeadline if not triggered earlier via the upgrade operation.
 */
union FirmwareStatusType {
  string,

  /**
   * available
   */
  available: "available",

  /**
   * unavailable
   */
  unavailable: "unavailable",
}

/**
 * Scope for this rule. The scope and filter determine which clients match the rule.
 */
union NfsAccessRuleScope {
  string,

  /**
   * default
   */
  default: "default",

  /**
   * network
   */
  network: "network",

  /**
   * host
   */
  host: "host",
}

/**
 * Access allowed by this rule.
 */
union NfsAccessRuleAccess {
  string,

  /**
   * no
   */
  no: "no",

  /**
   * ro
   */
  ro: "ro",

  /**
   * rw
   */
  rw: "rw",
}

/**
 * True if the HPC Cache is joined to the Active Directory domain.
 */
union DomainJoinedType {
  string,

  /**
   * Yes
   */
  Yes: "Yes",

  /**
   * No
   */
  No: "No",

  /**
   * Error
   */
  Error: "Error",
}

/**
 * This setting determines how the cache gets username and group names for clients.
 */
union UsernameSource {
  string,

  /**
   * AD
   */
  AD: "AD",

  /**
   * LDAP
   */
  LDAP: "LDAP",

  /**
   * File
   */
  File: "File",

  /**
   * None
   */
  None: "None",
}

/**
 * Indicates whether or not the HPC Cache has performed the username download successfully.
 */
union UsernameDownloadedType {
  string,

  /**
   * Yes
   */
  Yes: "Yes",

  /**
   * No
   */
  No: "No",

  /**
   * Error
   */
  Error: "Error",
}

/**
 * The state of the priming operation.
 */
union PrimingJobState {
  string,

  /**
   * Queued
   */
  Queued: "Queued",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Paused
   */
  Paused: "Paused",

  /**
   * Complete
   */
  Complete: "Complete",
}

/**
 * Type of the Storage Target.
 */
union StorageTargetType {
  string,

  /**
   * nfs3
   */
  nfs3: "nfs3",

  /**
   * clfs
   */
  clfs: "clfs",

  /**
   * unknown
   */
  `unknown`: "unknown",

  /**
   * blobNfs
   */
  blobNfs: "blobNfs",
}

/**
 * Storage target operational state.
 */
union OperationalStateType {
  string,

  /**
   * Ready
   */
  Ready: "Ready",

  /**
   * Busy
   */
  Busy: "Busy",

  /**
   * Suspended
   */
  Suspended: "Suspended",

  /**
   * Flushing
   */
  Flushing: "Flushing",
}

/**
 * The type of identity used for the resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AmlFilesystemIdentityType {
  /**
   * UserAssigned
   */
  UserAssigned,

  /**
   * None
   */
  None,
}

/**
 * Day of the week on which the maintenance window will occur.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum MaintenanceDayOfWeekType {
  /**
   * Monday
   */
  Monday,

  /**
   * Tuesday
   */
  Tuesday,

  /**
   * Wednesday
   */
  Wednesday,

  /**
   * Thursday
   */
  Thursday,

  /**
   * Friday
   */
  Friday,

  /**
   * Saturday
   */
  Saturday,

  /**
   * Sunday
   */
  Sunday,
}

/**
 * The type of identity used for the cache
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CacheIdentityType {
  /**
   * SystemAssigned
   */
  SystemAssigned,

  /**
   * UserAssigned
   */
  UserAssigned,

  /**
   * SystemAssigned, UserAssigned
   */
  `SystemAssigned, UserAssigned`,

  /**
   * None
   */
  None,
}

/**
 * Managed Identity properties.
 */
model AmlFilesystemIdentity {
  /**
   * The principal ID for the user-assigned identity of the resource.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID associated with the resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the resource.
   */
  type?: AmlFilesystemIdentityType;

  /**
   * A dictionary where each key is a user assigned identity resource ID, and each key's value is an empty dictionary.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<userAssignedIdentitiesValue>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model userAssignedIdentitiesValue {
  /**
   * The principal ID of the user-assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client ID of the user-assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * SKU for the resource.
 */
model SkuName {
  /**
   * SKU name for this resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name?: string;
}

/**
 * Properties of the AML file system.
 */
model AmlFilesystemProperties {
  /**
   * The size of the AML file system, in TiB. This might be rounded up.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageCapacityTiB: float32;

  /**
   * The current storage capacity of the AML file system, in TiB. This reflects the actual capacity including any expansions.
   */
  @visibility(Lifecycle.Read)
  currentStorageCapacityTiB?: float32;

  /**
   * The unique identifier of the AML file system cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  clusterUuid?: string;

  /**
   * Health of the AML file system.
   */
  @visibility(Lifecycle.Read)
  health?: AmlFilesystemHealth;

  /**
   * ARM provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AmlFilesystemProvisioningStateType;

  /**
   * Subnet used for managing the AML file system and for client-facing operations. This subnet should have at least a /24 subnet mask within the VNET's address space.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  filesystemSubnet: string;

  /**
   * Client information for the AML file system.
   */
  @visibility(Lifecycle.Read)
  clientInfo?: AmlFilesystemClientInfo;

  /**
   * Throughput provisioned in MB per sec, calculated as storageCapacityTiB * per-unit storage throughput
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  throughputProvisionedMBps?: int32;

  /**
   * Specifies encryption settings of the AML file system.
   */
  encryptionSettings?: AmlFilesystemEncryptionSettings;

  /**
   * Start time of a 30-minute weekly maintenance window.
   */
  maintenanceWindow: AmlFilesystemPropertiesMaintenanceWindow;

  /**
   * Hydration and archive settings and status
   */
  hsm?: AmlFilesystemPropertiesHsm;

  /**
   * Specifies root squash settings of the AML file system.
   */
  rootSquashSettings?: AmlFilesystemRootSquashSettings;
}

/**
 * An indication of AML file system health. Gives more information about health than just that related to provisioning.
 */
model AmlFilesystemHealth {
  /**
   * List of AML file system health states.
   */
  state?: AmlFilesystemHealthStateType;

  /**
   * Server-defined error code for the AML file system health
   */
  statusCode?: string;

  /**
   * Describes the health state.
   */
  statusDescription?: string;
}

/**
 * AML file system client information
 */
model AmlFilesystemClientInfo {
  /**
   * The IPv4 address used by clients to mount the AML file system's Lustre Management Service (MGS).
   */
  @visibility(Lifecycle.Read)
  mgsAddress?: string;

  /**
   * Recommended command to mount the AML file system
   */
  @visibility(Lifecycle.Read)
  mountCommand?: string;

  /**
   * The version of Lustre running in the AML file system
   */
  @visibility(Lifecycle.Read)
  lustreVersion?: string;

  /**
   * Container Storage Interface information for the AML file system.
   */
  @visibility(Lifecycle.Read)
  containerStorageInterface?: AmlFilesystemContainerStorageInterface;
}

/**
 * AML file system container storage interface information
 */
model AmlFilesystemContainerStorageInterface {
  /**
   * Recommended AKS Persistent Volume Claim for the CSI driver, in Base64 encoded YAML
   */
  @visibility(Lifecycle.Read)
  persistentVolumeClaim?: string;

  /**
   * Recommended AKS Persistent Volume for the CSI driver, in Base64 encoded YAML
   */
  @visibility(Lifecycle.Read)
  persistentVolume?: string;

  /**
   * Recommended AKS Storage Class for the CSI driver, in Base64 encoded YAML
   */
  @visibility(Lifecycle.Read)
  storageClass?: string;
}

/**
 * AML file system encryption settings.
 */
model AmlFilesystemEncryptionSettings {
  /**
   * Specifies the location of the encryption key in Key Vault.
   */
  keyEncryptionKey?: KeyVaultKeyReference;
}

/**
 * Describes a reference to key vault key.
 */
model KeyVaultKeyReference {
  /**
   * The URL referencing a key encryption key in key vault.
   */
  keyUrl: string;

  /**
   * Describes a resource Id to source key vault.
   */
  sourceVault: KeyVaultKeyReferenceSourceVault;
}

/**
 * Describes a resource Id to source key vault.
 */
model KeyVaultKeyReferenceSourceVault {
  /**
   * Resource Id.
   */
  id?: string;
}

/**
 * Start time of a 30-minute weekly maintenance window.
 */
model AmlFilesystemPropertiesMaintenanceWindow {
  /**
   * Day of the week on which the maintenance window will occur.
   */
  dayOfWeek?: MaintenanceDayOfWeekType;

  /**
   * The time of day (in UTC) to start the maintenance window.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pattern("^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$")
  timeOfDayUTC?: string;
}

/**
 * Hydration and archive settings and status
 */
model AmlFilesystemPropertiesHsm {
  /**
   * Specifies HSM settings of the AML file system.
   */
  settings?: AmlFilesystemHsmSettings;

  /**
   * Archive status
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["filesystemPath"])
  archiveStatus?: AmlFilesystemArchive[];
}

/**
 * AML file system HSM settings.
 */
model AmlFilesystemHsmSettings {
  /**
   * Resource ID of storage container used for hydrating the namespace and archiving from the namespace. The resource provider must have permission to create SAS tokens on the storage account.
   */
  container: string;

  /**
   * Resource ID of storage container used for logging events and errors.  Must be a separate container in the same storage account as the hydration and archive container. The resource provider must have permission to create SAS tokens on the storage account.
   */
  loggingContainer: string;

  /**
   * Only blobs in the non-logging container that start with this path/prefix get imported into the cluster namespace. This is only used during initial creation of the AML file system. It automatically creates an import job resource that can be deleted.
   */
  importPrefix?: string = "/";

  /**
   * Only blobs in the non-logging container that start with one of the paths/prefixes in this array get imported into the cluster namespace. This is only used during initial creation of the AML file system and has '/' as the default value. It automatically creates an import job resource that can be deleted.
   */
  importPrefixesInitial?: string[];
}

/**
 * Information about the AML file system archive
 */
model AmlFilesystemArchive {
  /**
   * Lustre file system path to archive relative to the file system root.  Specify '/' to archive all modified data.
   */
  @visibility(Lifecycle.Read)
  filesystemPath?: string;

  /**
   * The status of the archive
   */
  @visibility(Lifecycle.Read)
  status?: AmlFilesystemArchiveStatus;
}

/**
 * The status of the archive
 */
model AmlFilesystemArchiveStatus {
  /**
   * The state of the archive operation
   */
  @visibility(Lifecycle.Read)
  state?: ArchiveStatusType;

  /**
   * The time of the last completed archive operation
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletionTime?: utcDateTime;

  /**
   * The time the latest archive operation started
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStartedTime?: utcDateTime;

  /**
   * The completion percentage of the archive operation
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * Server-defined error code for the archive operation
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * Server-defined error message for the archive operation
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

/**
 * AML file system squash settings.
 */
model AmlFilesystemRootSquashSettings {
  /**
   * Squash mode of the AML file system. 'All': User and Group IDs on files will be squashed to the provided values for all users on non-trusted systems. 'RootOnly': User and Group IDs on files will be squashed to provided values for solely the root user on non-trusted systems. 'None': No squashing of User and Group IDs is performed for any users on any systems.
   */
  mode?: AmlFilesystemSquashMode;

  /**
   * Semicolon separated NID IP Address list(s) to be added to the TrustedSystems.
   */
  noSquashNidLists?: string;

  /**
   * User ID to squash to.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  squashUID?: int64;

  /**
   * Group ID to squash to.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  squashGID?: int64;

  /**
   * AML file system squash status.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * An error response.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
@error
model CloudError {
  /**
   * The body of the error.
   */
  error?: CloudErrorBody;
}

/**
 * An error response.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A list of additional details about the error.
   */
  @identifiers(#[])
  details?: CloudErrorBody[];

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;
}

/**
 * An AML file system update instance.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AmlFilesystemUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Properties of the AML file system.
   */
  properties?: AmlFilesystemUpdateProperties;
}

/**
 * Properties of the AML file system.
 */
model AmlFilesystemUpdateProperties {
  /**
   * Specifies encryption settings of the AML file system.
   */
  encryptionSettings?: AmlFilesystemEncryptionSettings;

  /**
   * Start time of a 30-minute weekly maintenance window.
   */
  maintenanceWindow?: AmlFilesystemUpdatePropertiesMaintenanceWindow;

  /**
   * Specifies root squash settings of the AML file system.
   */
  rootSquashSettings?: AmlFilesystemRootSquashSettings;
}

/**
 * Start time of a 30-minute weekly maintenance window.
 */
model AmlFilesystemUpdatePropertiesMaintenanceWindow {
  /**
   * Day of the week on which the maintenance window will occur.
   */
  dayOfWeek?: MaintenanceDayOfWeekType;

  /**
   * The time of day (in UTC) to start the maintenance window.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pattern("^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$")
  timeOfDayUTC?: string;
}

/**
 * Information required to execute the archive operation
 */
model AmlFilesystemArchiveInfo {
  /**
   * Lustre file system path to archive relative to the file system root.  Specify '/' to archive all modified data.
   */
  filesystemPath?: string = "/";
}

/**
 * Properties of the auto export job.
 */
model AutoExportJobProperties {
  /**
   * ARM provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AutoExportJobProvisioningStateType;

  /**
   * The administrative status of the auto export job. Possible values: 'Enable', 'Disable'. Passing in a value of 'Disable' will disable the current active auto export job. By default it is set to 'Enable'.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  adminStatus?: AutoExportJobAdminStatus = AutoExportJobAdminStatus.Enable;

  /**
   * An array of blob paths/prefixes that get auto exported to the cluster namespace. It has '/' as the default value. Number of maximum allowed paths for now is 1.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  autoExportPrefixes?: string[];

  /**
   * The status of the auto export
   */
  @visibility(Lifecycle.Read)
  status?: AutoExportJobPropertiesStatus;
}

/**
 * The status of the auto export
 */
model AutoExportJobPropertiesStatus {
  /**
   * The operational state of auto export. InProgress indicates the export is running.  Disabling indicates the user has requested to disable the export but the disabling is still in progress. Disabled indicates auto export has been disabled.  DisableFailed indicates the disabling has failed.  Failed means the export was unable to continue, due to a fatal error.
   */
  state?: AutoExportStatusType;

  /**
   * Server-defined status code for auto export job.
   */
  @visibility(Lifecycle.Read)
  statusCode?: string;

  /**
   * Server-defined status message for auto export job.
   */
  @visibility(Lifecycle.Read)
  statusMessage?: string;

  /**
   * Total files exported since the start of the export. This is accumulative, some files may be counted repeatedly.
   */
  @visibility(Lifecycle.Read)
  totalFilesExported?: int64;

  /**
   * Total data (in MiB) exported since the start of the export. This is accumulative, some files may be counted repeatedly.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  totalMiBExported?: int64;

  /**
   * Total files failed to be export since the last successfully completed iteration. This is accumulative, some files may be counted repeatedly.
   */
  @visibility(Lifecycle.Read)
  totalFilesFailed?: int64;

  /**
   * Number of iterations completed since the start of the export.
   */
  @visibility(Lifecycle.Read)
  exportIterationCount?: int32;

  /**
   * Time (in UTC) of the last successfully completed export iteration. Look at logging container for details.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulIterationCompletionTimeUTC?: utcDateTime;

  /**
   * Files discovered for export in current iteration. It may increase while more export items are found.
   */
  @visibility(Lifecycle.Read)
  currentIterationFilesDiscovered?: int64;

  /**
   * Data (in MiB) discovered for export in current iteration. It may increase while more export items are found.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  currentIterationMiBDiscovered?: int64;

  /**
   * Files that have been exported in current iteration.
   */
  @visibility(Lifecycle.Read)
  currentIterationFilesExported?: int64;

  /**
   * Data (in MiB) that have been exported in current iteration.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  currentIterationMiBExported?: int64;

  /**
   * Files failed to export in current iteration.
   */
  @visibility(Lifecycle.Read)
  currentIterationFilesFailed?: int64;

  /**
   * The time (in UTC) the latest auto export job started.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStartedTimeUTC?: utcDateTime;

  /**
   * The time (in UTC) of the last completed auto export job.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletionTimeUTC?: utcDateTime;
}

/**
 * An auto export job update instance.
 */
model AutoExportJobUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: AutoExportJobUpdateProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutoExportJobUpdateProperties {
  /**
   * The administrative status of the auto export job. Possible values: 'Enable', 'Disable'. Passing in a value of 'Disable' will disable the current active auto export job. By default it is set to 'Enable'.
   */
  adminStatus?: AutoExportJobAdminStatus;
}

/**
 * Properties of the import job.
 */
model ImportJobProperties {
  /**
   * ARM provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ImportJobProvisioningStateType;

  /**
   * The administrative status of the import job. Possible values: 'Active', 'Cancel'. Passing in a value of 'Cancel' will cancel the current active import job. By default it is set to 'Active'.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  adminStatus?: ImportJobAdminStatus = ImportJobAdminStatus.Active;

  /**
   * An array of blob paths/prefixes that get imported into the cluster namespace. It has '/' as the default value.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  importPrefixes?: string[];

  /**
   * How the import job will handle conflicts. For example, if the import job is trying to bring in a directory, but a file is at that path, how it handles it. Fail indicates that the import job should stop immediately and not do anything with the conflict. Skip indicates that it should pass over the conflict. OverwriteIfDirty causes the import job to delete and re-import the file or directory if it is a conflicting type, is dirty, or was not previously imported. OverwriteAlways extends OverwriteIfDirty to include releasing files that had been restored but were not dirty. Please reference https://learn.microsoft.com/en-us/azure/azure-managed-lustre/ for a thorough explanation of these resolution modes.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  conflictResolutionMode?: ConflictResolutionMode = ConflictResolutionMode.Fail;

  /**
   * Total non-conflict oriented errors the import job will tolerate before exiting with failure. -1 means infinite. 0 means exit immediately and is the default.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  maximumErrors?: int32 = 0;

  /**
   * The status of the import
   */
  @visibility(Lifecycle.Read)
  status?: ImportJobPropertiesStatus;
}

/**
 * The status of the import
 */
model ImportJobPropertiesStatus {
  /**
   * The operational state of the import job. InProgress indicates the import is still running. Canceled indicates it has been canceled by the user. Completed indicates import finished, successfully importing all discovered blobs into the Lustre namespace. CompletedPartial indicates the import finished but some blobs either were found to be conflicting and could not be imported or other errors were encountered. Failed means the import was unable to complete due to a fatal error.
   */
  @visibility(Lifecycle.Read)
  state?: ImportStatusType;

  /**
   * The status message of the import job.
   */
  @visibility(Lifecycle.Read)
  statusMessage?: string;

  /**
   * The total blob objects walked.
   */
  @visibility(Lifecycle.Read)
  totalBlobsWalked?: int64;

  /**
   * A recent and frequently updated rate of blobs walked per second.
   */
  @visibility(Lifecycle.Read)
  blobsWalkedPerSecond?: int64;

  /**
   * The total blobs that have been imported since import began.
   */
  @visibility(Lifecycle.Read)
  totalBlobsImported?: int64;

  /**
   * New or modified files that have been imported into the filesystem.
   */
  @visibility(Lifecycle.Read)
  importedFiles?: int64;

  /**
   * New or modified directories that have been imported into the filesystem.
   */
  @visibility(Lifecycle.Read)
  importedDirectories?: int64;

  /**
   * Newly added symbolic links into the filesystem.
   */
  @visibility(Lifecycle.Read)
  importedSymlinks?: int64;

  /**
   * Files that already exist in the filesystem and have not been modified.
   */
  @visibility(Lifecycle.Read)
  preexistingFiles?: int64;

  /**
   * Directories that already exist in the filesystem and have not been modified.
   */
  @visibility(Lifecycle.Read)
  preexistingDirectories?: int64;

  /**
   * Symbolic links that already exist in the filesystem and have not been modified.
   */
  @visibility(Lifecycle.Read)
  preexistingSymlinks?: int64;

  /**
   * A recent and frequently updated rate of total files, directories, and symlinks imported per second.
   */
  @visibility(Lifecycle.Read)
  blobsImportedPerSecond?: int64;

  /**
   * The time (in UTC) of the last completed import job.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletionTime?: utcDateTime;

  /**
   * The time (in UTC) the latest import job started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStartedTime?: utcDateTime;

  /**
   * Number of errors in the import job.
   */
  @visibility(Lifecycle.Read)
  totalErrors?: int32;

  /**
   * Number of conflicts in the import job.
   */
  @visibility(Lifecycle.Read)
  totalConflicts?: int32;
}

/**
 * An import job update instance.
 */
model ImportJobUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ImportJobUpdateProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ImportJobUpdateProperties {
  /**
   * The administrative status of the import job. Possible values: 'Active', 'Cancel'. Passing in a value of 'Cancel' will cancel the current active import job.
   */
  adminStatus?: ImportJobAdminStatus;
}

/**
 * Properties of the auto import job.
 */
model AutoImportJobProperties {
  /**
   * ARM provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AutoImportJobPropertiesProvisioningState;

  /**
   * The administrative status of the auto import job. Possible values: 'Enable', 'Disable'. Passing in a value of 'Disable' will disable the current active auto import job. By default it is set to 'Enable'.
   */
  adminStatus?: AutoImportJobPropertiesAdminStatus = AutoImportJobPropertiesAdminStatus.Enable;

  /**
   * An array of blob paths/prefixes that get auto imported to the cluster namespace. It has '/' as the default value. Number of maximum allowed paths is 100.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  autoImportPrefixes?: string[];

  /**
   * How the auto import job will handle conflicts. For example, if the auto import job is trying to bring in a directory, but a file is at that path, how it handles it. Fail indicates that the auto import job should stop immediately and not do anything with the conflict. Skip indicates that it should pass over the conflict. OverwriteIfDirty causes the auto import job to delete and re-import the file or directory if it is a conflicting type, is dirty, or is currently released. OverwriteAlways extends OverwriteIfDirty to include releasing files that had been restored but were not dirty. Please reference https://learn.microsoft.com/en-us/azure/azure-managed-lustre/blob-integration#conflict-resolution-mode for a thorough explanation of these resolution modes.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  conflictResolutionMode?: ConflictResolutionMode = ConflictResolutionMode.Skip;

  /**
   * Whether or not to enable deletions during auto import. This only affects overwrite-dirty.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  enableDeletions?: boolean = false;

  /**
   * Total non-conflict-oriented errors (e.g., OS errors) Import will tolerate before exiting with failure. -1 means infinite. 0 means exit immediately on any error.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  maximumErrors?: int64;

  /**
   * The status of the auto import job.
   */
  @visibility(Lifecycle.Read)
  status?: AutoImportJobPropertiesStatus;
}

/**
 * The status of the auto import job.
 */
model AutoImportJobPropertiesStatus {
  /**
   * The state of the auto import operation.
   */
  @visibility(Lifecycle.Read)
  state?: AutoImportJobState;

  /**
   * Server-defined status code for auto import job.
   */
  @visibility(Lifecycle.Read)
  statusCode?: string;

  /**
   * Server-defined status message for auto import job.
   */
  @visibility(Lifecycle.Read)
  statusMessage?: string;

  /**
   * Date and time of when the currently running full scan began.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scanStartTime?: utcDateTime;

  /**
   * Date and time of when the full scan ended.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scanEndTime?: utcDateTime;

  /**
   * Total number of blobs walked during full scan.
   */
  @visibility(Lifecycle.Read)
  totalBlobsWalked?: int64;

  /**
   * Rate of blobs walked during full scan.
   */
  @visibility(Lifecycle.Read)
  rateOfBlobWalk?: int64;

  /**
   * Total number of blobs imported during full scan.
   */
  @visibility(Lifecycle.Read)
  totalBlobsImported?: int64;

  /**
   * Rate of blob import during full scan.
   */
  @visibility(Lifecycle.Read)
  rateOfBlobImport?: int64;

  /**
   * Number of files imported during full scan.
   */
  @visibility(Lifecycle.Read)
  importedFiles?: int64;

  /**
   * Number of directories imported during full scan.
   */
  @visibility(Lifecycle.Read)
  importedDirectories?: int64;

  /**
   * Number of symlinks imported during full scan.
   */
  @visibility(Lifecycle.Read)
  importedSymlinks?: int64;

  /**
   * Number of preexisting files during full scan.
   */
  @visibility(Lifecycle.Read)
  preexistingFiles?: int64;

  /**
   * Number of preexisting directories during full scan.
   */
  @visibility(Lifecycle.Read)
  preexistingDirectories?: int64;

  /**
   * Number of preexisting symlinks during full scan.
   */
  @visibility(Lifecycle.Read)
  preexistingSymlinks?: int64;

  /**
   * Total errors encountered during full scan.
   */
  @visibility(Lifecycle.Read)
  totalErrors?: int64;

  /**
   * Total conflicts encountered during full scan.
   */
  @visibility(Lifecycle.Read)
  totalConflicts?: int64;

  /**
   * The storage account blob change feed status of the auto import job.
   */
  @visibility(Lifecycle.Read)
  blobSyncEvents?: AutoImportJobPropertiesStatusBlobSyncEvents;

  /**
   * The time (in UTC) the latest auto import job started.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStartedTimeUTC?: utcDateTime;

  /**
   * The time (in UTC) of the last completed auto import job.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletionTimeUTC?: utcDateTime;
}

/**
 * The storage account blob change feed status of the auto import job.
 */
model AutoImportJobPropertiesStatusBlobSyncEvents {
  /**
   * Number of files imported during auto import.
   */
  @visibility(Lifecycle.Read)
  importedFiles?: int64;

  /**
   * Number of directories imported during auto import.
   */
  @visibility(Lifecycle.Read)
  importedDirectories?: int64;

  /**
   * Number of symlinks imported during auto import.
   */
  @visibility(Lifecycle.Read)
  importedSymlinks?: int64;

  /**
   * Number of preexisting files during auto import.
   */
  @visibility(Lifecycle.Read)
  preexistingFiles?: int64;

  /**
   * Number of preexisting directories during auto import.
   */
  @visibility(Lifecycle.Read)
  preexistingDirectories?: int64;

  /**
   * Number of preexisting symlinks during auto import.
   */
  @visibility(Lifecycle.Read)
  preexistingSymlinks?: int64;

  /**
   * Total number of blobs imported during auto import.
   */
  @visibility(Lifecycle.Read)
  totalBlobsImported?: int64;

  /**
   * Rate of blob import per second during auto import.
   */
  @visibility(Lifecycle.Read)
  rateOfBlobImport?: int64;

  /**
   * Total errors encountered during auto import.
   */
  @visibility(Lifecycle.Read)
  totalErrors?: int64;

  /**
   * Total conflicts encountered during auto import.
   */
  @visibility(Lifecycle.Read)
  totalConflicts?: int64;

  /**
   * Number of deletions during auto import.
   */
  @visibility(Lifecycle.Read)
  deletions?: int64;

  /**
   * Date and time of the last Change Feed event consumed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastChangeFeedEventConsumedTime?: utcDateTime;

  /**
   * Date and time when last fully synchronized.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTimeFullySynchronized?: utcDateTime;
}

/**
 * An auto import job update instance.
 */
model AutoImportJobUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: AutoImportJobUpdateProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutoImportJobUpdateProperties {
  /**
   * The administrative status of the auto import job. Possible values: 'Enable', 'Disable'. Passing in a value of 'Disable' will disable the current active auto import job. By default it is set to 'Enable'.
   */
  adminStatus?: AutoImportJobUpdatePropertiesAdminStatus;
}

/**
 * Properties of the expansion job.
 */
model ExpansionJobProperties {
  /**
   * ARM provisioning state, see https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#provisioningstate-property
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ExpansionJobPropertiesProvisioningState;

  /**
   * The new storage capacity in TiB for the AML file system after expansion. This must be a multiple of the Sku step size, and greater than the current storage capacity of the AML file system.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  newStorageCapacityTiB?: float32;

  /**
   * The status of the expansion job.
   */
  @visibility(Lifecycle.Read)
  status?: ExpansionJobPropertiesStatus;
}

/**
 * The status of the expansion job.
 */
model ExpansionJobPropertiesStatus {
  /**
   * The operational state of the expansion job. InProgress indicates the expansion is still running. Completed indicates expansion finished successfully. Failed means the expansion was unable to complete due to a fatal error. Deleting indicates the expansion is being rolled back.
   */
  @visibility(Lifecycle.Read)
  state?: ExpansionJobStatusType;

  /**
   * Server-defined status code for expansion job.
   */
  @visibility(Lifecycle.Read)
  statusCode?: string;

  /**
   * Server-defined status message for expansion job.
   */
  @visibility(Lifecycle.Read)
  statusMessage?: string;

  /**
   * The percentage of expansion job completion.
   */
  @visibility(Lifecycle.Read)
  @maxValue(100)
  @minValue(0)
  percentComplete?: float32;

  /**
   * The time (in UTC) the expansion job started.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUTC?: utcDateTime;

  /**
   * The time (in UTC) when the expansion job completed. Only populated when job reaches a terminal state.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completionTimeUTC?: utcDateTime;
}

/**
 * An expansion job update instance.
 */
model ExpansionJobUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Information required to validate the subnet that will be used in AML file system create
 */
model AmlFilesystemSubnetInfo {
  /**
   * Subnet used for managing the AML file system and for client-facing operations. This subnet should have at least a /24 subnet mask within the VNET's address space.
   */
  filesystemSubnet?: string;

  /**
   * The size of the AML file system, in TiB.
   */
  storageCapacityTiB?: float32;

  /**
   * SKU for the resource.
   */
  sku?: SkuName;

  /**
   * Region that the AML file system will be created in.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

/**
 * The error details provided when the checkAmlFSSubnets call fails.
 */
@error
model AmlFilesystemCheckSubnetError {
  /**
   * The error details for the AML file system's subnet.
   */
  filesystemSubnet?: AmlFilesystemCheckSubnetErrorFilesystemSubnet;
}

model BadRequestResponse is AmlFilesystemCheckSubnetError {
  ...Response<400>;
}

/**
 * The error details for the AML file system's subnet.
 */
model AmlFilesystemCheckSubnetErrorFilesystemSubnet {
  /**
   * The status of the AML file system subnet check.
   */
  status?: FilesystemSubnetStatusType;

  /**
   * The details of the AML file system subnet check.
   */
  message?: string;
}

/**
 * Information required to get the number of available IP addresses a subnet should have that will be used in AML file system create
 */
model RequiredAmlFilesystemSubnetsSizeInfo {
  /**
   * The size of the AML file system, in TiB.
   */
  storageCapacityTiB?: float32;

  /**
   * SKU for the resource.
   */
  sku?: SkuName;
}

/**
 * Information about the number of available IP addresses that are required for the AML file system.
 */
model RequiredAmlFilesystemSubnetsSize {
  /**
   * The number of available IP addresses that are required for the AML file system.
   */
  filesystemSubnetSize?: int32;
}

/**
 * REST API operation description: see https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/openapi-authoring-automated-guidelines.md#r3023-operationsapiimplementation
 */
model ApiOperation {
  /**
   * The object that represents the operation.
   */
  display?: ApiOperationDisplay;

  /**
   * Origin of the operation.
   */
  origin?: string;

  /**
   * The flag that indicates whether the operation applies to data plane.
   */
  isDataAction?: boolean;

  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * Additional details about an operation.
   */
  properties?: ApiOperationProperties;
}

/**
 * The object that represents the operation.
 */
model ApiOperationDisplay {
  /**
   * Operation type: Read, write, delete, etc.
   */
  operation?: string;

  /**
   * Service provider: Microsoft.StorageCache
   */
  provider?: string;

  /**
   * Resource on which the operation is performed: Cache, etc.
   */
  resource?: string;

  /**
   * The description of the operation
   */
  description?: string;
}

/**
 * Additional details about an operation.
 */
model ApiOperationProperties {
  /**
   * Specification of the all the metrics provided for a resource type.
   */
  serviceSpecification?: ApiOperationPropertiesServiceSpecification;
}

/**
 * Specification of the all the metrics provided for a resource type.
 */
model ApiOperationPropertiesServiceSpecification {
  /**
   * Details about operations related to metrics.
   */
  @identifiers(#["name"])
  metricSpecifications?: MetricSpecification[];

  /**
   * Details about operations related to logs.
   */
  @identifiers(#["name"])
  logSpecifications?: LogSpecification[];
}

/**
 * Details about operation related to metrics.
 */
model MetricSpecification {
  /**
   * The name of the metric.
   */
  name?: string;

  /**
   * Localized display name of the metric.
   */
  displayName?: string;

  /**
   * The description of the metric.
   */
  displayDescription?: string;

  /**
   * The unit that the metric is measured in.
   */
  unit?: string;

  /**
   * The type of metric aggregation.
   */
  aggregationType?: string;

  /**
   * Support metric aggregation type.
   */
  supportedAggregationTypes?: MetricAggregationType[];

  /**
   * Type of metrics.
   */
  metricClass?: string;

  /**
   * Dimensions of the metric
   */
  @identifiers(#[])
  dimensions?: MetricDimension[];
}

/**
 * Specifications of the Dimension of metrics.
 */
model MetricDimension {
  /**
   * Name of the dimension
   */
  name?: string;

  /**
   * Localized friendly display name of the dimension
   */
  displayName?: string;

  /**
   * Internal name of the dimension.
   */
  internalName?: string;

  /**
   * To be exported to shoe box.
   */
  toBeExportedForShoebox?: boolean;
}

/**
 * Details about operation related to logs.
 */
model LogSpecification {
  /**
   * The name of the log.
   */
  name?: string;

  /**
   * Localized display name of the log.
   */
  displayName?: string;
}

/**
 * The response from the List Cache SKUs operation.
 */
model ResourceSkusResult {
  /**
   * The list of SKUs available for the subscription.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: ResourceSku[];

  /**
   * The URI to fetch the next page of cache SKUs.
   */
  @nextLink
  nextLink?: url;
}

/**
 * A resource SKU.
 */
model ResourceSku {
  /**
   * The type of resource the SKU applies to.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * A list of capabilities of this SKU, such as throughput or ops/sec.
   */
  @identifiers(#["name"])
  capabilities?: ResourceSkuCapabilities[];

  /**
   * The set of locations where the SKU is available. This is the supported and registered Azure Geo Regions (e.g., West US, East US, Southeast Asia, etc.).
   */
  @visibility(Lifecycle.Read)
  locations?: string[];

  /**
   * The set of locations where the SKU is available.
   */
  @identifiers(#[])
  locationInfo?: ResourceSkuLocationInfo[];

  /**
   * The name of this SKU.
   */
  name?: string;

  /**
   * The restrictions preventing this SKU from being used. This is empty if there are no restrictions.
   */
  @identifiers(#[])
  restrictions?: Restriction[];
}

/**
 * A resource SKU capability.
 */
model ResourceSkuCapabilities {
  /**
   * Name of a capability, such as ops/sec.
   */
  name?: string;

  /**
   * Quantity, if the capability is measured by quantity.
   */
  value?: string;
}

/**
 * Resource SKU location information.
 */
model ResourceSkuLocationInfo {
  /**
   * Location where this SKU is available.
   */
  location?: string;

  /**
   * Zones if any.
   */
  zones?: string[];
}

/**
 * The restrictions preventing this SKU from being used.
 */
model Restriction {
  /**
   * The type of restrictions. In this version, the only possible value for this is location.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The value of restrictions. If the restriction type is set to location, then this would be the different locations where the SKU is restricted.
   */
  @visibility(Lifecycle.Read)
  values?: string[];

  /**
   * The reason for the restriction. As of now this can be "QuotaId" or "NotAvailableForSubscription". "QuotaId" is set when the SKU has requiredQuotas parameter as the subscription does not belong to that quota. "NotAvailableForSubscription" is related to capacity at the datacenter.
   */
  reasonCode?: ReasonCode;
}

/**
 * A list of cache usage models.
 */
model UsageModelsResult {
  /**
   * The list of usage models available for the subscription.
   */
  @identifiers(#["modelName"])
  @pageItems
  value?: UsageModel[];

  /**
   * The URI to fetch the next page of cache usage models.
   */
  @nextLink
  nextLink?: url;
}

/**
 * A usage model.
 */
model UsageModel {
  /**
   * Localized information describing this usage model.
   */
  display?: UsageModelDisplay;

  /**
   * Non-localized keyword name for this usage model.
   */
  modelName?: string;

  /**
   * The type of Storage Target to which this model is applicable (only nfs3 as of this version).
   */
  targetType?: string;
}

/**
 * Localized information describing this usage model.
 */
model UsageModelDisplay {
  /**
   * String to display for this usage model.
   */
  description?: string;
}

/**
 * The status of operation.
 */
model AscOperation {
  /**
   * The operation Id.
   */
  id?: string;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * The start time of the operation.
   */
  startTime?: string;

  /**
   * The end time of the operation.
   */
  endTime?: string;

  /**
   * The status of the operation.
   */
  status?: string;

  /**
   * The error detail of the operation if any.
   */
  error?: AscOperationErrorResponse;

  /**
   * Additional operation-specific properties
   */
  properties?: AscOperationProperties;
}

/**
 * Describes the format of Error response.
 */
model AscOperationErrorResponse {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  message?: string;
}

/**
 * Additional operation-specific output.
 */
model AscOperationProperties {
  /**
   * Additional operation-specific output.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  output?: Record<unknown>;
}

/**
 * Result of the request to list resource usages. It contains a list of resource usages & limits and a URL link to get the next set of results.
 */
model ResourceUsagesListResult {
  /**
   * List of usages and limits for resources controlled by the Microsoft.StorageCache resource provider.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  value?: ResourceUsage[];

  /**
   * URL to get the next set of resource usage list results if there are any.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: url;
}

/**
 * The usage and limit (quota) for a resource.
 */
model ResourceUsage {
  /**
   * The limit (quota) for this resource.
   */
  @minValue(0)
  @visibility(Lifecycle.Read)
  limit?: int32;

  /**
   * Unit that the limit and usages are expressed in, such as 'Count'.
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * The current usage of this resource.
   */
  @minValue(0)
  @visibility(Lifecycle.Read)
  currentValue?: int32;

  /**
   * Naming information for this resource type.
   */
  @visibility(Lifecycle.Read)
  name?: ResourceUsageName;
}

/**
 * Naming information for this resource type.
 */
model ResourceUsageName {
  /**
   * Canonical name for this resource type.
   */
  value?: string;

  /**
   * Localized name for this resource type.
   */
  localizedValue?: string;
}

/**
 * Cache identity properties.
 */
model CacheIdentity {
  /**
   * The principal ID for the system-assigned identity of the cache.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID associated with the cache.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the cache
   */
  type?: CacheIdentityType;

  /**
   * A dictionary where each key is a user assigned identity resource ID, and each key's value is an empty dictionary.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<userAssignedIdentitiesValue>;
}

/**
 * Properties of the cache.
 */
model CacheProperties {
  /**
   * The size of this Cache, in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  cacheSizeGB?: int32;

  /**
   * Health of the cache.
   */
  @visibility(Lifecycle.Read)
  health?: CacheHealth;

  /**
   * Array of IPv4 addresses that can be used by clients mounting this cache.
   */
  @visibility(Lifecycle.Read)
  mountAddresses?: string[];

  /**
   * ARM provisioning state, see https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#provisioningstate-property
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningStateType;

  /**
   * Subnet used for the cache.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnet?: string;

  /**
   * Upgrade status of the cache.
   */
  @visibility(Lifecycle.Read)
  upgradeStatus?: CacheUpgradeStatus;

  /**
   * Upgrade settings of the cache.
   */
  upgradeSettings?: CacheUpgradeSettings;

  /**
   * Specifies network settings of the cache.
   */
  networkSettings?: CacheNetworkSettings;

  /**
   * Specifies encryption settings of the cache.
   */
  encryptionSettings?: CacheEncryptionSettings;

  /**
   * Specifies security settings of the cache.
   */
  securitySettings?: CacheSecuritySettings;

  /**
   * Specifies Directory Services settings of the cache.
   */
  directoryServicesSettings?: CacheDirectorySettings;

  /**
   * Availability zones for resources. This field should only contain a single element in the array.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  zones?: string[];

  /**
   * Specifies the priming jobs defined in the cache.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  primingJobs?: PrimingJob[];

  /**
   * Specifies the space allocation percentage for each storage target in the cache.
   */
  @visibility(Lifecycle.Read)
  spaceAllocation?: StorageTargetSpaceAllocation[];
}

/**
 * An indication of cache health. Gives more information about health than just that related to provisioning.
 */
model CacheHealth {
  /**
   * List of cache health states. Down is when the cluster is not responding.  Degraded is when its functioning but has some alerts. Transitioning when it is creating or deleting. Unknown will be returned in old api versions when a new value is added in future versions. WaitingForKey is when the create is waiting for the system assigned identity to be given access to the encryption key in the encryption settings.
   */
  state?: HealthStateType;

  /**
   * Describes explanation of state.
   */
  statusDescription?: string;

  /**
   * Outstanding conditions that need to be investigated and resolved.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  conditions?: Condition[];
}

/**
 * Outstanding conditions that will need to be resolved.
 */
model Condition {
  /**
   * The time when the condition was raised.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * The issue requiring attention.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Properties describing the software upgrade state of the cache.
 */
model CacheUpgradeStatus {
  /**
   * Version string of the firmware currently installed on this cache.
   */
  @visibility(Lifecycle.Read)
  currentFirmwareVersion?: string;

  /**
   * True if there is a firmware update ready to install on this cache. The firmware will automatically be installed after firmwareUpdateDeadline if not triggered earlier via the upgrade operation.
   */
  @visibility(Lifecycle.Read)
  firmwareUpdateStatus?: FirmwareStatusType;

  /**
   * Time at which the pending firmware update will automatically be installed on the cache.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firmwareUpdateDeadline?: utcDateTime;

  /**
   * Time of the last successful firmware update.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastFirmwareUpdate?: utcDateTime;

  /**
   * When firmwareUpdateAvailable is true, this field holds the version string for the update.
   */
  @visibility(Lifecycle.Read)
  pendingFirmwareVersion?: string;
}

/**
 * Cache Upgrade Settings.
 */
model CacheUpgradeSettings {
  /**
   * True if the user chooses to select an installation time between now and firmwareUpdateDeadline. Else the firmware will automatically be installed after firmwareUpdateDeadline if not triggered earlier via the upgrade operation.
   */
  upgradeScheduleEnabled?: boolean;

  /**
   * When upgradeScheduleEnabled is true, this field holds the user-chosen upgrade time. At the user-chosen time, the firmware update will automatically be installed on the cache.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledTime?: utcDateTime;
}

/**
 * Cache network settings.
 */
model CacheNetworkSettings {
  /**
   * The IPv4 maximum transmission unit configured for the subnet.
   */
  @maxValue(1500)
  @minValue(576)
  mtu?: int32 = 1500;

  /**
   * Array of additional IP addresses used by this cache.
   */
  @visibility(Lifecycle.Read)
  utilityAddresses?: string[];

  /**
   * DNS servers for the cache to use.  It will be set from the network configuration if no value is provided.
   */
  dnsServers?: string[];

  /**
   * DNS search domain
   */
  dnsSearchDomain?: string;

  /**
   * NTP server IP Address or FQDN for the cache to use. The default is time.windows.com.
   */
  ntpServer?: string = "time.windows.com";
}

/**
 * Cache encryption settings.
 */
model CacheEncryptionSettings {
  /**
   * Specifies the location of the key encryption key in key vault.
   */
  @secret
  keyEncryptionKey?: KeyVaultKeyReference;

  /**
   * Specifies whether the service will automatically rotate to the newest version of the key in the key vault.
   */
  rotationToLatestKeyVersionEnabled?: boolean;
}

/**
 * Cache security settings.
 */
model CacheSecuritySettings {
  /**
   * NFS access policies defined for this cache.
   */
  @identifiers(#["name"])
  accessPolicies?: NfsAccessPolicy[];
}

/**
 * A set of rules describing access policies applied to NFSv3 clients of the cache.
 */
model NfsAccessPolicy {
  /**
   * Name identifying this policy. Access Policy names are not case sensitive.
   */
  name: string;

  /**
   * The set of rules describing client accesses allowed under this policy.
   */
  @identifiers(#[])
  accessRules: NfsAccessRule[];
}

/**
 * Rule to place restrictions on portions of the cache namespace being presented to clients.
 */
model NfsAccessRule {
  /**
   * Scope for this rule. The scope and filter determine which clients match the rule.
   */
  scope: NfsAccessRuleScope;

  /**
   * Filter applied to the scope for this rule. The filter's format depends on its scope. 'default' scope matches all clients and has no filter value. 'network' scope takes a filter in CIDR format (for example, 10.99.1.0/24). 'host' takes an IP address or fully qualified domain name as filter. If a client does not match any filter rule and there is no default rule, access is denied.
   */
  filter?: string;

  /**
   * Access allowed by this rule.
   */
  access: NfsAccessRuleAccess;

  /**
   * Allow SUID semantics.
   */
  suid?: boolean;

  /**
   * For the default policy, allow access to subdirectories under the root export. If this is set to no, clients can only mount the path '/'. If set to yes, clients can mount a deeper path, like '/a/b'.
   */
  submountAccess?: boolean;

  /**
   * Map root accesses to anonymousUID and anonymousGID.
   */
  rootSquash?: boolean;

  /**
   * UID value that replaces 0 when rootSquash is true. 65534 will be used if not provided.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  anonymousUID?: string;

  /**
   * GID value that replaces 0 when rootSquash is true. This will use the value of anonymousUID if not provided.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  anonymousGID?: string;
}

/**
 * Cache Directory Services settings.
 */
model CacheDirectorySettings {
  /**
   * Specifies settings for joining the HPC Cache to an Active Directory domain.
   */
  activeDirectory?: CacheActiveDirectorySettings;

  /**
   * Specifies settings for Extended Groups. Extended Groups allows users to be members of more than 16 groups.
   */
  usernameDownload?: CacheUsernameDownloadSettings;
}

/**
 * Active Directory settings used to join a cache to a domain.
 */
model CacheActiveDirectorySettings {
  /**
   * Primary DNS IP address used to resolve the Active Directory domain controller's fully qualified domain name.
   */
  primaryDnsIpAddress: string;

  /**
   * Secondary DNS IP address used to resolve the Active Directory domain controller's fully qualified domain name.
   */
  secondaryDnsIpAddress?: string;

  /**
   * The fully qualified domain name of the Active Directory domain controller.
   */
  domainName: string;

  /**
   * The Active Directory domain's NetBIOS name.
   */
  domainNetBiosName: string;

  /**
   * The NetBIOS name to assign to the HPC Cache when it joins the Active Directory domain as a server. Length must 1-15 characters from the class [-0-9a-zA-Z].
   */
  @pattern("^[-0-9a-zA-Z]{1,15}$")
  cacheNetBiosName: string;

  /**
   * True if the HPC Cache is joined to the Active Directory domain.
   */
  @visibility(Lifecycle.Read)
  domainJoined?: DomainJoinedType;

  /**
   * Active Directory admin credentials used to join the HPC Cache to a domain.
   */
  credentials?: CacheActiveDirectorySettingsCredentials;
}

/**
 * Active Directory admin credentials used to join the HPC Cache to a domain.
 */
model CacheActiveDirectorySettingsCredentials {
  /**
   * Username of the Active Directory domain administrator. This value is stored encrypted and not returned on response.
   */
  username: string;

  /**
   * Plain text password of the Active Directory domain administrator. This value is stored encrypted and not returned on response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @secret
  password?: string;
}

/**
 * Settings for Extended Groups username and group download.
 */
model CacheUsernameDownloadSettings {
  /**
   * Whether or not Extended Groups is enabled.
   */
  extendedGroups?: boolean;

  /**
   * This setting determines how the cache gets username and group names for clients.
   */
  usernameSource?: UsernameSource = UsernameSource.None;

  /**
   * The URI of the file containing group information (in /etc/group file format). This field must be populated when 'usernameSource' is set to 'File'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  groupFileURI?: string;

  /**
   * The URI of the file containing user information (in /etc/passwd file format). This field must be populated when 'usernameSource' is set to 'File'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userFileURI?: string;

  /**
   * The fully qualified domain name or IP address of the LDAP server to use.
   */
  ldapServer?: string;

  /**
   * The base distinguished name for the LDAP domain.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ldapBaseDN?: string;

  /**
   * Whether or not the LDAP connection should be encrypted.
   */
  encryptLdapConnection?: boolean = false;

  /**
   * Determines if the certificates must be validated by a certificate authority. When true, caCertificateURI must be provided.
   */
  requireValidCertificate?: boolean = false;

  /**
   * Determines if the certificate should be automatically downloaded. This applies to 'caCertificateURI' only if 'requireValidCertificate' is true.
   */
  autoDownloadCertificate?: boolean = false;

  /**
   * The URI of the CA certificate to validate the LDAP secure connection. This field must be populated when 'requireValidCertificate' is set to true.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  caCertificateURI?: string;

  /**
   * Indicates whether or not the HPC Cache has performed the username download successfully.
   */
  @visibility(Lifecycle.Read)
  usernameDownloaded?: UsernameDownloadedType;

  /**
   * When present, these are the credentials for the secure LDAP connection.
   */
  credentials?: CacheUsernameDownloadSettingsCredentials;
}

/**
 * When present, these are the credentials for the secure LDAP connection.
 */
model CacheUsernameDownloadSettingsCredentials {
  /**
   * The Bind Distinguished Name identity to be used in the secure LDAP connection. This value is stored encrypted and not returned on response.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  bindDn?: string;

  /**
   * The Bind password to be used in the secure LDAP connection. This value is stored encrypted and not returned on response.
   */
  @secret
  bindPassword?: string;
}

/**
 * A priming job instance.
 */
model PrimingJob {
  /**
   * The priming job name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[-0-9a-zA-Z_]{1,80}$")
  primingJobName: string;

  /**
   * The URL for the priming manifest file to download. This file must be readable from the HPC Cache. When the file is in Azure blob storage the URL should include a Shared Access Signature (SAS) granting read permissions on the blob.
   */
  @secret
  @visibility(Lifecycle.Create)
  primingManifestUrl: string;

  /**
   * The unique identifier of the priming job.
   */
  @visibility(Lifecycle.Read)
  @pattern("^[-0-9a-zA-Z_]{1,80}$")
  primingJobId?: string;

  /**
   * The state of the priming operation.
   */
  @visibility(Lifecycle.Read)
  primingJobState?: PrimingJobState;

  /**
   * The status code of the priming job.
   */
  @visibility(Lifecycle.Read)
  primingJobStatus?: string;

  /**
   * The job details or error information if any.
   */
  @visibility(Lifecycle.Read)
  primingJobDetails?: string;

  /**
   * The current progress of the priming job, as a percentage.
   */
  @visibility(Lifecycle.Read)
  @maxValue(100)
  @minValue(0)
  primingJobPercentComplete?: float64;
}

/**
 * Storage Target space allocation properties.
 */
model StorageTargetSpaceAllocation {
  /**
   * Name of the storage target.
   */
  @pattern("^[-0-9a-zA-Z_]{1,80}$")
  name?: string;

  /**
   * The percentage of cache space allocated for this storage target
   */
  @maxValue(100)
  @minValue(1)
  allocationPercentage?: int32;
}

/**
 * SKU for the cache.
 */
model CacheSku {
  /**
   * SKU name for this cache.
   */
  name?: string;
}

/**
 * A list of Storage Targets.
 */
model StorageTargetsResult {
  /**
   * The list of Storage Targets defined for the cache.
   */
  @pageItems
  value?: StorageTarget[];

  /**
   * The URI to fetch the next page of Storage Targets.
   */
  @nextLink
  nextLink?: url;
}
/**
 * Properties of the Storage Target.
 */
model StorageTargetProperties {
  /**
   * List of cache namespace junctions to target for namespace associations.
   */
  @identifiers(#[])
  junctions?: NamespaceJunction[];

  /**
   * Type of the Storage Target.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  targetType: StorageTargetType;

  /**
   * ARM provisioning state, see https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#provisioningstate-property
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningStateType;

  /**
   * Storage target operational state.
   */
  state?: OperationalStateType;

  /**
   * Properties when targetType is nfs3.
   */
  nfs3?: Nfs3Target;

  /**
   * Properties when targetType is clfs.
   */
  clfs?: ClfsTarget;

  /**
   * Properties when targetType is unknown.
   */
  `unknown`?: UnknownTarget;

  /**
   * Properties when targetType is blobNfs.
   */
  blobNfs?: BlobNfsTarget;

  /**
   * The percentage of cache space allocated for this storage target
   */
  @visibility(Lifecycle.Read)
  @maxValue(100)
  @minValue(1)
  allocationPercentage?: int32;
}

/**
 * A namespace junction.
 */
model NamespaceJunction {
  /**
   * Namespace path on a cache for a Storage Target.
   */
  namespacePath?: string;

  /**
   * Path in Storage Target to which namespacePath points.
   */
  targetPath?: string;

  /**
   * NFS export where targetPath exists.
   */
  nfsExport?: string;

  /**
   * Name of the access policy applied to this junction.
   */
  nfsAccessPolicy?: string = "default";
}

/**
 * Properties pertaining to the Nfs3Target
 */
model Nfs3Target {
  /**
   * IP address or host name of an NFSv3 host (e.g., 10.0.44.44).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[-.,0-9a-zA-Z]+$")
  target?: string;

  /**
   * Identifies the StorageCache usage model to be used for this storage target.
   */
  usageModel?: string;

  /**
   * Amount of time (in seconds) the cache waits before it checks the back-end storage for file updates.
   */
  verificationTimer?: int32;

  /**
   * Amount of time (in seconds) the cache waits after the last file change before it copies the changed file to back-end storage.
   */
  writeBackTimer?: int32;
}

/**
 * Properties pertaining to the ClfsTarget
 */
model ClfsTarget {
  /**
   * Resource ID of storage container.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  target?: string;
}

/**
 * Properties pertaining to the UnknownTarget
 */
model UnknownTarget {
  /**
   * Dictionary of string->string pairs containing information about the Storage Target.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  attributes?: Record<string>;
}

/**
 * Properties pertaining to the BlobNfsTarget.
 */
model BlobNfsTarget {
  /**
   * Resource ID of the storage container.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  target?: string;

  /**
   * Identifies the StorageCache usage model to be used for this storage target.
   */
  usageModel?: string;

  /**
   * Amount of time (in seconds) the cache waits before it checks the back-end storage for file updates.
   */
  verificationTimer?: int32;

  /**
   * Amount of time (in seconds) the cache waits after the last file change before it copies the changed file to back-end storage.
   */
  writeBackTimer?: int32;
}

/**
 * Resource used by a cache.
 */
model StorageTargetResource {
  /**
   * Name of the Storage Target.
   */
  @visibility(Lifecycle.Read)
  @pattern("^[-0-9a-zA-Z_]{1,80}$")
  name?: string;

  /**
   * Resource ID of the Storage Target.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Type of the Storage Target; Microsoft.StorageCache/Cache/StorageTarget
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Region name string.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The system meta data relating to this resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Object containing the priming job ID.
 */
model PrimingJobIdParameter {
  /**
   * The unique identifier of the priming job.
   */
  @pattern("^[-0-9a-zA-Z_]{1,80}$")
  primingJobId: string;
}
