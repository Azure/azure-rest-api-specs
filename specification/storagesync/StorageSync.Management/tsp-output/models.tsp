import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.StorageSync;

interface Operations extends Azure.ResourceManager.Operations {}

enum IncomingTrafficPolicy {
  AllowAllTraffic,
  AllowVirtualNetworksOnly,
}

enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum CloudEndpointChangeEnumerationActivityState {
  InitialEnumerationInProgress,
  EnumerationInProgress,
}

enum CloudEndpointChangeEnumerationTotalCountsState {
  Calculating,
  Final,
}

enum ChangeDetectionMode {
  Default,
  Recursive,
}

enum FeatureStatus {
  on,
  off,
}

enum InitialDownloadPolicy {
  NamespaceOnly,
  NamespaceThenModifiedFiles,
  AvoidTieredFiles,
}

enum LocalCacheMode {
  DownloadNewAndModifiedFiles,
  UpdateLocallyCachedFiles,
}

enum InitialUploadPolicy {
  ServerAuthoritative,
  Merge,
}

enum ServerEndpointHealthState {
  Unavailable,
  Healthy,
  Error,
}

enum ServerEndpointSyncActivityState {
  Upload,
  Download,
  UploadAndDownload,
}

enum ServerEndpointSyncMode {
  Regular,
  NamespaceDownload,
  InitialUpload,
  SnapshotUpload,
  InitialFullDownload,
}

enum ServerEndpointOfflineDataTransferState {
  InProgress,
  Stopping,
  NotRunning,
  Complete,
}

enum CloudTieringLowDiskModeState {
  Enabled,
  Disabled,
}

enum RegisteredServerAgentVersionStatus {
  Ok,
  NearExpiry,
  Expired,
  Blocked,
}

enum WorkflowStatus {
  active,
  expired,
  succeeded,
  aborted,
  failed,
}

enum OperationDirection {
  do,
  undo,
  cancel,
}

enum Reason {
  Registered,
  Unregistered,
  Warned,
  Suspended,
  Deleted,
}

enum ProgressType {
  none,
  initialize,
  download,
  upload,
  recall,
}
@Azure.Core.fixed
enum NameAvailabilityReason {
  Invalid,
  AlreadyExists,
}

@doc("The list of storage sync operations.")
model OperationEntityListResult is Azure.Core.Page<OperationEntity>;

@doc("The operation supported by storage sync.")
model OperationEntity {
  @doc("Operation name: {provider}/{resource}/{operation}.")
  name?: string;

  @doc("The operation supported by storage sync.")
  display?: OperationDisplayInfo;

  @doc("The origin.")
  origin?: string;

  @doc("Properties of the operations resource.")
  properties?: OperationProperties;
}

@doc("The operation supported by storage sync.")
model OperationDisplayInfo {
  @doc("The description of the operation.")
  description?: string;

  @doc("The action that users can perform, based on their permission level.")
  operation?: string;

  @doc("Service provider: Microsoft StorageSync.")
  provider?: string;

  @doc("Resource on which the operation is performed.")
  resource?: string;
}

@doc("Properties of the operations resource.")
model OperationProperties {
  @doc("Service specification for the operations resource.")
  serviceSpecification?: OperationResourceServiceSpecification;
}

@doc("Service specification.")
model OperationResourceServiceSpecification {
  @doc("List of metric specifications.")
  metricSpecifications?: OperationResourceMetricSpecification[];
}

@doc("Operation Display Resource object.")
model OperationResourceMetricSpecification {
  @doc("Name of the metric.")
  name?: string;

  @doc("Display name for the metric.")
  displayName?: string;

  @doc("Display description for the metric.")
  displayDescription?: string;

  @doc("Unit for the metric.")
  unit?: string;

  @doc("Aggregation type for the metric.")
  aggregationType?: string;

  @doc("Supported aggregation types for the metric.")
  supportedAggregationTypes?: string[];

  @doc("Fill gaps in the metric with zero.")
  fillGapWithZero?: boolean;

  @doc("Dimensions for the metric specification.")
  dimensions?: OperationResourceMetricSpecificationDimension[];
}

@doc("OperationResourceMetricSpecificationDimension object.")
model OperationResourceMetricSpecificationDimension {
  @doc("Name of the dimension.")
  name?: string;

  @doc("Display name of the dimensions.")
  displayName?: string;

  @doc("Indicates metric should be exported for Shoebox.")
  toBeExportedForShoebox?: boolean;
}

@doc("Error type")
@error
model StorageSyncError {
  @doc("Error details of the given entry.")
  error?: StorageSyncApiError;

  @doc("Error details of the given entry.")
  innererror?: StorageSyncApiError;
}

@doc("Error type")
model StorageSyncApiError {
  @doc("Error code of the given entry.")
  code?: string;

  @doc("Error message of the given entry.")
  message?: string;

  @doc("Target of the given error entry.")
  target?: string;

  @doc("Error details of the given entry.")
  details?: StorageSyncErrorDetails;

  @doc("Inner error details of the given entry.")
  innererror?: StorageSyncInnerErrorDetails;
}

@doc("Error Details object.")
model StorageSyncErrorDetails {
  @doc("Error code of the given entry.")
  code?: string;

  @doc("Error message of the given entry.")
  message?: string;

  @doc("Target of the given entry.")
  target?: string;

  @doc("Request URI of the given entry.")
  requestUri?: string;

  @doc("Exception type of the given entry.")
  exceptionType?: string;

  @doc("HTTP method of the given entry.")
  httpMethod?: string;

  @doc("Hashed message of the given entry.")
  hashedMessage?: string;

  @doc("HTTP error code of the given entry.")
  httpErrorCode?: string;
}

@doc("Error Details object.")
model StorageSyncInnerErrorDetails {
  @doc("Call stack of the error.")
  callStack?: string;

  @doc("Error message of the error.")
  message?: string;

  @doc("Exception of the inner error.")
  innerException?: string;

  @doc("Call stack of the inner error.")
  innerExceptionCallStack?: string;
}

@doc("Parameters for a check name availability request.")
model CheckNameAvailabilityParameters {
  @doc("The name to check for availability")
  name: string;

  @doc("The resource type. Must be set to Microsoft.StorageSync/storageSyncServices")
  type: "Microsoft.StorageSync/storageSyncServices";
}

@doc("The CheckNameAvailability operation response.")
model CheckNameAvailabilityResult {
  @doc("Gets a boolean value that indicates whether the name is available for you to use. If true, the name is available. If false, the name has already been taken or invalid and cannot be used.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("Gets the reason that a Storage Sync Service name could not be used. The Reason element is only returned if NameAvailable is false.")
  @visibility("read")
  reason?: NameAvailabilityReason;

  @doc("Gets an error message explaining the Reason value in more detail.")
  @visibility("read")
  message?: string;
}

@doc("The parameters used when creating a storage sync service.")
model StorageSyncServiceCreateParameters {
  @doc("Required. Gets or sets the location of the resource. This will be one of the supported and registered Azure Geo Regions (e.g. West US, East US, Southeast Asia, etc.). The geo region of a resource cannot be changed once it is created, but if an identical geo region is specified on update, the request will succeed.")
  location: string;

  @doc("Gets or sets a list of key value pairs that describe the resource. These tags can be used for viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key with a length no greater than 128 characters and a value with a length no greater than 256 characters.")
  tags?: Record<string>;

  @doc("The parameters used to create the storage sync service.")
  properties?: StorageSyncServiceCreateParametersProperties;
}

@doc("StorageSyncService Properties object.")
model StorageSyncServiceCreateParametersProperties {
  @doc("Incoming Traffic Policy")
  incomingTrafficPolicy?: IncomingTrafficPolicy;
}

@doc("Storage Sync Service Properties object.")
model StorageSyncServiceProperties {
  @doc("Incoming Traffic Policy")
  incomingTrafficPolicy?: IncomingTrafficPolicy;

  @doc("Storage Sync service status.")
  @visibility("read")
  storageSyncServiceStatus?: int32;

  @doc("Storage Sync service Uid")
  @visibility("read")
  storageSyncServiceUid?: string;

  @doc("StorageSyncService Provisioning State")
  @visibility("read")
  provisioningState?: string;

  @doc("StorageSyncService lastWorkflowId")
  @visibility("read")
  lastWorkflowId?: string;

  @doc("Resource Last Operation Name")
  @visibility("read")
  lastOperationName?: string;

  @doc("List of private endpoint connection associated with the specified storage sync service")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

@doc("Properties of the PrivateEndpointConnectProperties.")
model PrivateEndpointConnectionProperties {
  @doc("The resource of private end point.")
  privateEndpoint?: PrivateEndpoint;

  @doc("A collection of information about the state of the connection between service consumer and provider.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  @doc("The provisioning state of the private endpoint connection resource.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

@doc("The Private Endpoint resource.")
model PrivateEndpoint {
  @doc("The ARM identifier for Private Endpoint")
  @visibility("read")
  id?: string;
}

@doc("A collection of information about the state of the connection between service consumer and provider.")
model PrivateLinkServiceConnectionState {
  @doc("Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.")
  status?: PrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: string;
}

@doc("A list of private link resources")
model PrivateLinkResourceListResult {
  @doc("Array of private link resources")
  value?: PrivateLinkResource[];
}

@doc("A private link resource")
model PrivateLinkResource {
  ...Resource;

  @doc("Resource properties.")
  properties?: PrivateLinkResourceProperties;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource Private link DNS zone name.")
  requiredZoneNames?: string[];
}

@doc("SyncGroup Properties object.")
model SyncGroupProperties {
  @doc("Unique Id")
  @visibility("read")
  uniqueId?: string;

  @doc("Sync group status")
  @visibility("read")
  syncGroupStatus?: string;
}

@doc("The parameters used when creating a sync group.")
model SyncGroupCreateParameters {
  ...ProxyResource;

  @doc("The parameters used to create the sync group")
  properties?: Record<unknown>;
}

@doc("The parameters used when creating a cloud endpoint.")
model CloudEndpointCreateParameters {
  ...ProxyResource;

  @doc("The parameters used to create the cloud endpoint.")
  properties?: CloudEndpointCreateParametersProperties;
}

@doc("CloudEndpoint Properties object.")
model CloudEndpointCreateParametersProperties {
  @doc("Storage Account Resource Id")
  storageAccountResourceId?: string;

  @doc("Azure file share name")
  azureFileShareName?: string;

  @doc("Storage Account Tenant Id")
  storageAccountTenantId?: string;

  @doc("Friendly Name")
  friendlyName?: string;
}

@doc("CloudEndpoint Properties object.")
model CloudEndpointProperties {
  @doc("Storage Account Resource Id")
  storageAccountResourceId?: string;

  @doc("Azure file share name")
  azureFileShareName?: string;

  @doc("Storage Account Tenant Id")
  storageAccountTenantId?: string;

  @doc("Partnership Id")
  partnershipId?: string;

  @doc("Friendly Name")
  friendlyName?: string;

  @doc("Backup Enabled")
  @visibility("read")
  backupEnabled?: string;

  @doc("CloudEndpoint Provisioning State")
  provisioningState?: string;

  @doc("CloudEndpoint lastWorkflowId")
  lastWorkflowId?: string;

  @doc("Resource Last Operation Name")
  lastOperationName?: string;

  @doc("Cloud endpoint change enumeration status")
  @visibility("read")
  changeEnumerationStatus?: CloudEndpointChangeEnumerationStatus;
}

@doc("Cloud endpoint change enumeration status object")
model CloudEndpointChangeEnumerationStatus {
  @doc("Last updated timestamp")
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  @doc("Status of last completed change enumeration")
  @visibility("read")
  lastEnumerationStatus?: CloudEndpointLastChangeEnumerationStatus;

  @doc("Change enumeration activity")
  @visibility("read")
  activity?: CloudEndpointChangeEnumerationActivity;
}

@doc("Cloud endpoint change enumeration status object")
model CloudEndpointLastChangeEnumerationStatus {
  @doc("Timestamp when change enumeration started")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedTimestamp?: utcDateTime;

  @doc("Timestamp when change enumeration completed")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completedTimestamp?: utcDateTime;

  @doc("Count of files in the namespace")
  @visibility("read")
  namespaceFilesCount?: int32;

  @doc("Count of directories in the namespace")
  @visibility("read")
  namespaceDirectoriesCount?: int32;

  @doc("Namespace size in bytes")
  @visibility("read")
  namespaceSizeBytes?: int32;

  @doc("Timestamp of when change enumeration is expected to run again")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextRunTimestamp?: utcDateTime;
}

@doc("Cloud endpoint change enumeration activity object")
model CloudEndpointChangeEnumerationActivity {
  @doc("Last updated timestamp")
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  @doc("Change enumeration operation state")
  @visibility("read")
  operationState?: CloudEndpointChangeEnumerationActivityState;

  @doc("When non-zero, indicates an issue that is delaying change enumeration")
  @visibility("read")
  statusCode?: int32;

  @doc("Timestamp when change enumeration started")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedTimestamp?: utcDateTime;

  @doc("Count of files processed")
  @visibility("read")
  processedFilesCount?: int32;

  @doc("Count of directories processed")
  @visibility("read")
  processedDirectoriesCount?: int32;

  @doc("Total count of files enumerated")
  @visibility("read")
  totalFilesCount?: int32;

  @doc("Total count of directories enumerated")
  @visibility("read")
  totalDirectoriesCount?: int32;

  @doc("Total enumerated size in bytes")
  @visibility("read")
  totalSizeBytes?: int32;

  @doc("Progress percentage for change enumeration run, excluding processing of deletes")
  @visibility("read")
  progressPercent?: int32;

  @doc("Estimate of time remaining for the enumeration run")
  @visibility("read")
  minutesRemaining?: int32;

  @doc("Change enumeration total counts state")
  @visibility("read")
  totalCountsState?: CloudEndpointChangeEnumerationTotalCountsState;

  @doc("Progress percentage for processing deletes. This is done separately from the rest of the enumeration run")
  @visibility("read")
  deletesProgressPercent?: int32;
}

@doc("Backup request")
model BackupRequest {
  @doc("Azure File Share.")
  azureFileShare?: string;
}

@doc("Post Backup Response")
model PostBackupResponse {
  @doc("Post Backup Response Properties")
  backupMetadata?: PostBackupResponseProperties;
}

@doc("Post Backup Response Properties object.")
model PostBackupResponseProperties {
  @doc("cloud endpoint Name.")
  @visibility("read")
  cloudEndpointName?: string;
}

@doc("Pre Restore request object.")
model PreRestoreRequest {
  @doc("Pre Restore partition.")
  partition?: string;

  @doc("Pre Restore replica group.")
  replicaGroup?: string;

  @doc("Pre Restore request id.")
  requestId?: string;

  @doc("Pre Restore Azure file share uri.")
  azureFileShareUri?: string;

  @doc("Pre Restore Azure status.")
  status?: string;

  @doc("Pre Restore Azure source azure file share uri.")
  sourceAzureFileShareUri?: string;

  @doc("Pre Restore backup metadata property bag.")
  backupMetadataPropertyBag?: string;

  @doc("Pre Restore restore file spec array.")
  restoreFileSpec?: RestoreFileSpec[];

  @doc("Pre Restore pause wait for sync drain time period in seconds.")
  pauseWaitForSyncDrainTimePeriodInSeconds?: int32;
}

@doc("Restore file spec.")
model RestoreFileSpec {
  @doc("Restore file spec path")
  path?: string;

  @doc("Restore file spec isdir")
  isdir?: boolean;
}

@doc("Post Restore Request")
model PostRestoreRequest {
  @doc("Post Restore partition.")
  partition?: string;

  @doc("Post Restore replica group.")
  replicaGroup?: string;

  @doc("Post Restore request id.")
  requestId?: string;

  @doc("Post Restore Azure file share uri.")
  azureFileShareUri?: string;

  @doc("Post Restore Azure status.")
  status?: string;

  @doc("Post Restore Azure source azure file share uri.")
  sourceAzureFileShareUri?: string;

  @doc("Post Restore Azure failed file list.")
  failedFileList?: string;

  @doc("Post Restore restore file spec array.")
  restoreFileSpec?: RestoreFileSpec[];
}

@doc("The parameters used when calling trigger change detection action on cloud endpoint.")
model TriggerChangeDetectionParameters {
  @doc("Relative path to a directory Azure File share for which change detection is to be performed.")
  directoryPath?: string;

  @doc("Change Detection Mode. Applies to a directory specified in directoryPath parameter.")
  changeDetectionMode?: ChangeDetectionMode;

  @doc("Array of relative paths on the Azure File share to be included in the change detection. Can be files and directories.")
  paths?: string[];
}

@doc("Cloud endpoint AFS file share metadata signing certificate public keys.")
model CloudEndpointAfsShareMetadataCertificatePublicKeys {
  @doc("The first public key.")
  @visibility("read")
  firstKey?: string;

  @doc("The second public key.")
  @visibility("read")
  secondKey?: string;
}

@doc("The parameters used when creating a server endpoint.")
model ServerEndpointCreateParameters {
  ...ProxyResource;

  @doc("The parameters used to create the server endpoint.")
  properties?: ServerEndpointCreateParametersProperties;
}

@doc("ServerEndpoint Properties object.")
model ServerEndpointCreateParametersProperties {
  @doc("Server Local path.")
  serverLocalPath?: string;

  @doc("Cloud Tiering.")
  cloudTiering?: FeatureStatus;

  @doc("Level of free space to be maintained by Cloud Tiering if it is enabled.")
  volumeFreeSpacePercent?: int32;

  @doc("Tier files older than days.")
  tierFilesOlderThanDays?: int32;

  @doc("Friendly Name")
  friendlyName?: string;

  @doc("Server Resource Id.")
  serverResourceId?: string;

  @doc("Offline data transfer")
  offlineDataTransfer?: FeatureStatus;

  @doc("Offline data transfer share name")
  offlineDataTransferShareName?: string;

  @doc("Policy for how namespace and files are recalled during FastDr.")
  initialDownloadPolicy?: InitialDownloadPolicy;

  @doc("Policy for enabling follow-the-sun business models: link local cache to cloud behavior to pre-populate before local access.")
  localCacheMode?: LocalCacheMode;

  @doc("Policy for how the initial upload sync session is performed.")
  initialUploadPolicy?: InitialUploadPolicy;
}

@doc("ServerEndpoint Properties object.")
model ServerEndpointProperties {
  @doc("Server Local path.")
  serverLocalPath?: string;

  @doc("Cloud Tiering.")
  cloudTiering?: FeatureStatus;

  @doc("Level of free space to be maintained by Cloud Tiering if it is enabled.")
  volumeFreeSpacePercent?: int32;

  @doc("Tier files older than days.")
  tierFilesOlderThanDays?: int32;

  @doc("Friendly Name")
  friendlyName?: string;

  @doc("Server Resource Id.")
  serverResourceId?: string;

  @doc("ServerEndpoint Provisioning State")
  @visibility("read")
  provisioningState?: string;

  @doc("ServerEndpoint lastWorkflowId")
  @visibility("read")
  lastWorkflowId?: string;

  @doc("Resource Last Operation Name")
  @visibility("read")
  lastOperationName?: string;

  @doc("Server Endpoint sync status")
  @visibility("read")
  syncStatus?: ServerEndpointSyncStatus;

  @doc("Offline data transfer")
  offlineDataTransfer?: FeatureStatus;

  @doc("Offline data transfer storage account resource ID")
  @visibility("read")
  offlineDataTransferStorageAccountResourceId?: string;

  @doc("Offline data transfer storage account tenant ID")
  @visibility("read")
  offlineDataTransferStorageAccountTenantId?: string;

  @doc("Offline data transfer share name")
  offlineDataTransferShareName?: string;

  @doc("Cloud tiering status. Only populated if cloud tiering is enabled.")
  @visibility("read")
  cloudTieringStatus?: ServerEndpointCloudTieringStatus;

  @doc("Recall status. Only populated if cloud tiering is enabled.")
  @visibility("read")
  recallStatus?: ServerEndpointRecallStatus;

  @doc("Policy for how namespace and files are recalled during FastDr.")
  initialDownloadPolicy?: InitialDownloadPolicy;

  @doc("Policy for enabling follow-the-sun business models: link local cache to cloud behavior to pre-populate before local access.")
  localCacheMode?: LocalCacheMode;

  @doc("Policy for how the initial upload sync session is performed.")
  initialUploadPolicy?: InitialUploadPolicy;

  @doc("Server name")
  @visibility("read")
  serverName?: string;
}

@doc("Server Endpoint sync status")
model ServerEndpointSyncStatus {
  @doc("Download Health Status.")
  @visibility("read")
  downloadHealth?: ServerEndpointHealthState;

  @doc("Upload Health Status.")
  @visibility("read")
  uploadHealth?: ServerEndpointHealthState;

  @doc("Combined Health Status.")
  @visibility("read")
  combinedHealth?: ServerEndpointHealthState;

  @doc("Sync activity")
  @visibility("read")
  syncActivity?: ServerEndpointSyncActivityState;

  @doc("Total count of persistent files not syncing (combined upload + download).")
  @visibility("read")
  totalPersistentFilesNotSyncingCount?: int32;

  @doc("Last Updated Timestamp")
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  @doc("Upload Status")
  @visibility("read")
  uploadStatus?: ServerEndpointSyncSessionStatus;

  @doc("Download Status")
  @visibility("read")
  downloadStatus?: ServerEndpointSyncSessionStatus;

  @doc("Upload sync activity")
  @visibility("read")
  uploadActivity?: ServerEndpointSyncActivityStatus;

  @doc("Download sync activity")
  @visibility("read")
  downloadActivity?: ServerEndpointSyncActivityStatus;

  @doc("Offline Data Transfer State")
  @visibility("read")
  offlineDataTransferStatus?: ServerEndpointOfflineDataTransferState;

  @doc("Background data download activity")
  @visibility("read")
  backgroundDataDownloadActivity?: ServerEndpointBackgroundDataDownloadActivity;
}

@doc("Sync Session status object.")
model ServerEndpointSyncSessionStatus {
  @doc("Last sync result (HResult)")
  @visibility("read")
  lastSyncResult?: int32;

  @doc("Last sync timestamp")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTimestamp?: utcDateTime;

  @doc("Last sync success timestamp")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncSuccessTimestamp?: utcDateTime;

  @doc("Last sync per item error count.")
  @visibility("read")
  lastSyncPerItemErrorCount?: int32;

  @doc("Count of persistent files not syncing.")
  @visibility("read")
  persistentFilesNotSyncingCount?: int32;

  @doc("Count of transient files not syncing.")
  @visibility("read")
  transientFilesNotSyncingCount?: int32;

  @doc("Array of per-item errors coming from the last sync session.")
  @visibility("read")
  filesNotSyncingErrors?: ServerEndpointFilesNotSyncingError[];

  @doc("Sync mode")
  @visibility("read")
  lastSyncMode?: ServerEndpointSyncMode;
}

@doc("Files not syncing error object")
model ServerEndpointFilesNotSyncingError {
  @doc("Error code (HResult)")
  @visibility("read")
  errorCode?: int32;

  @doc("Count of persistent files not syncing with the specified error code")
  @visibility("read")
  persistentCount?: int32;

  @doc("Count of transient files not syncing with the specified error code")
  @visibility("read")
  transientCount?: int32;
}

@doc("Sync Session status object.")
model ServerEndpointSyncActivityStatus {
  @doc("Timestamp when properties were updated")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  @doc("Per item error count")
  @visibility("read")
  perItemErrorCount?: int32;

  @doc("Applied item count.")
  @visibility("read")
  appliedItemCount?: int32;

  @doc("Total item count (if available)")
  @visibility("read")
  totalItemCount?: int32;

  @doc("Applied bytes")
  @visibility("read")
  appliedBytes?: int32;

  @doc("Total bytes (if available)")
  @visibility("read")
  totalBytes?: int32;

  @doc("Sync mode")
  @visibility("read")
  syncMode?: ServerEndpointSyncMode;

  @doc("Session minutes remaining (if available)")
  @visibility("read")
  sessionMinutesRemaining?: int32;
}

@doc("Background data download activity object")
model ServerEndpointBackgroundDataDownloadActivity {
  @doc("Timestamp when properties were updated")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  @doc("Timestamp when the operation started")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedTimestamp?: utcDateTime;

  @doc("Progress percentage")
  @visibility("read")
  percentProgress?: int32;

  @doc("Running count of bytes downloaded")
  @visibility("read")
  downloadedBytes?: int32;
}

@doc("Server endpoint cloud tiering status object.")
model ServerEndpointCloudTieringStatus {
  @doc("Last updated timestamp")
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  @doc("Cloud tiering health state.")
  @visibility("read")
  health?: ServerEndpointHealthState;

  @doc("The last updated timestamp of health state")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  healthLastUpdatedTimestamp?: utcDateTime;

  @doc("Last cloud tiering result (HResult)")
  @visibility("read")
  lastCloudTieringResult?: int32;

  @doc("Last cloud tiering success timestamp")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessTimestamp?: utcDateTime;

  @doc("Information regarding how much local space cloud tiering is saving.")
  @visibility("read")
  spaceSavings?: CloudTieringSpaceSavings;

  @doc("Information regarding how well the local cache on the server is performing.")
  @visibility("read")
  cachePerformance?: CloudTieringCachePerformance;

  @doc("Information regarding files that failed to be tiered")
  @visibility("read")
  filesNotTiering?: CloudTieringFilesNotTiering;

  @doc("Status of the volume free space policy")
  @visibility("read")
  volumeFreeSpacePolicyStatus?: CloudTieringVolumeFreeSpacePolicyStatus;

  @doc("Status of the date policy")
  @visibility("read")
  datePolicyStatus?: CloudTieringDatePolicyStatus;

  @doc("Information regarding the low disk mode state")
  @visibility("read")
  lowDiskMode?: CloudTieringLowDiskMode;
}

@doc("Server endpoint cloud tiering status object.")
model CloudTieringSpaceSavings {
  @doc("Last updated timestamp")
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  @doc("Volume size")
  @visibility("read")
  volumeSizeBytes?: int32;

  @doc("Total size of content in the azure file share")
  @visibility("read")
  totalSizeCloudBytes?: int32;

  @doc("Cached content size on the server")
  @visibility("read")
  cachedSizeBytes?: int32;

  @doc("Percentage of cached size over total size")
  @visibility("read")
  spaceSavingsPercent?: int32;

  @doc("Count of bytes saved on the server")
  @visibility("read")
  spaceSavingsBytes?: int32;
}

@doc("Server endpoint cloud tiering status object.")
model CloudTieringCachePerformance {
  @doc("Last updated timestamp")
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  @doc("Count of bytes that were served from the local server")
  @visibility("read")
  cacheHitBytes?: int32;

  @doc("Count of bytes that were served from the cloud")
  @visibility("read")
  cacheMissBytes?: int32;

  @doc("Percentage of total bytes (hit + miss) that were served from the local server")
  @visibility("read")
  cacheHitBytesPercent?: int32;
}

@doc("Server endpoint cloud tiering status object.")
model CloudTieringFilesNotTiering {
  @doc("Last updated timestamp")
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  @doc("Last cloud tiering result (HResult)")
  @visibility("read")
  totalFileCount?: int32;

  @doc("Array of tiering errors")
  @visibility("read")
  errors?: FilesNotTieringError[];
}

@doc("Files not tiering error object")
model FilesNotTieringError {
  @doc("Error code (HResult)")
  @visibility("read")
  errorCode?: int32;

  @doc("Count of files with this error")
  @visibility("read")
  fileCount?: int32;
}

@doc("Status of the volume free space policy")
model CloudTieringVolumeFreeSpacePolicyStatus {
  @doc("Last updated timestamp")
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  @doc("In the case where multiple server endpoints are present in a volume, an effective free space policy is applied.")
  @visibility("read")
  effectiveVolumeFreeSpacePolicy?: int32;

  @doc("Current volume free space percentage.")
  @visibility("read")
  currentVolumeFreeSpacePercent?: int32;
}

@doc("Status of the date policy")
model CloudTieringDatePolicyStatus {
  @doc("Last updated timestamp")
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  @doc("Most recent access time of tiered files")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  tieredFilesMostRecentAccessTimestamp?: utcDateTime;
}

@doc("Information regarding the low disk mode state")
model CloudTieringLowDiskMode {
  @doc("Last updated timestamp")
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  @doc("Low disk mode state")
  @visibility("read")
  state?: CloudTieringLowDiskModeState;
}

@doc("Server endpoint recall status object.")
model ServerEndpointRecallStatus {
  @doc("Last updated timestamp")
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  @doc("Total count of recall errors.")
  @visibility("read")
  totalRecallErrorsCount?: int32;

  @doc("Array of recall errors")
  @visibility("read")
  recallErrors?: ServerEndpointRecallError[];
}

@doc("Server endpoint recall error object")
model ServerEndpointRecallError {
  @doc("Error code (HResult)")
  @visibility("read")
  errorCode?: int32;

  @doc("Count of occurences of the error")
  @visibility("read")
  count?: int32;
}

@doc("The parameters used when calling recall action on server endpoint.")
model RecallActionParameters {
  @doc("Pattern of the files.")
  pattern?: string;

  @doc("Recall path.")
  recallPath?: string;
}

@doc("RegisteredServer Properties object.")
model RegisteredServerProperties {
  @doc("Registered Server Certificate")
  serverCertificate?: string;

  @doc("Registered Server Agent Version")
  agentVersion?: string;

  @doc("Registered Server Agent Version Status")
  @visibility("read")
  agentVersionStatus?: RegisteredServerAgentVersionStatus;

  @doc("Registered Server Agent Version Expiration Date")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agentVersionExpirationDate?: utcDateTime;

  @doc("Registered Server OS Version")
  serverOSVersion?: string;

  @doc("Registered Server Management Error Code")
  serverManagementErrorCode?: int32;

  @doc("Registered Server last heart beat")
  lastHeartBeat?: string;

  @doc("Registered Server Provisioning State")
  provisioningState?: string;

  @doc("Registered Server serverRole")
  serverRole?: string;

  @doc("Registered Server clusterId")
  clusterId?: string;

  @doc("Registered Server clusterName")
  clusterName?: string;

  @doc("Registered Server serverId")
  serverId?: string;

  @doc("Registered Server storageSyncServiceUid")
  storageSyncServiceUid?: string;

  @doc("Registered Server lastWorkflowId")
  lastWorkflowId?: string;

  @doc("Resource Last Operation Name")
  lastOperationName?: string;

  @doc("Resource discoveryEndpointUri")
  discoveryEndpointUri?: string;

  @doc("Resource Location")
  resourceLocation?: string;

  @doc("Service Location")
  serviceLocation?: string;

  @doc("Friendly Name")
  friendlyName?: string;

  @doc("Management Endpoint Uri")
  managementEndpointUri?: string;

  @doc("Telemetry Endpoint Uri")
  monitoringEndpointUri?: string;

  @doc("Monitoring Configuration")
  monitoringConfiguration?: string;

  @doc("Server name")
  @visibility("read")
  serverName?: string;
}

@doc("The parameters used when creating a registered server.")
model RegisteredServerCreateParameters {
  ...ProxyResource;

  @doc("The parameters used to create the registered server.")
  properties?: RegisteredServerCreateParametersProperties;
}

@doc("RegisteredServer Create Properties object.")
model RegisteredServerCreateParametersProperties {
  @doc("Registered Server Certificate")
  serverCertificate?: string;

  @doc("Registered Server Agent Version")
  agentVersion?: string;

  @doc("Registered Server OS Version")
  serverOSVersion?: string;

  @doc("Registered Server last heart beat")
  lastHeartBeat?: string;

  @doc("Registered Server serverRole")
  serverRole?: string;

  @doc("Registered Server clusterId")
  clusterId?: string;

  @doc("Registered Server clusterName")
  clusterName?: string;

  @doc("Registered Server serverId")
  serverId?: string;

  @doc("Friendly Name")
  friendlyName?: string;
}

@doc("Trigger Rollover Request.")
model TriggerRolloverRequest {
  @doc("Certificate Data")
  serverCertificate?: string;
}

@doc("Workflow Properties object.")
model WorkflowProperties {
  @doc("last step name")
  lastStepName?: string;

  @doc("workflow status.")
  status?: WorkflowStatus;

  @doc("operation direction.")
  operation?: OperationDirection;

  @doc("workflow steps")
  steps?: string;

  @doc("workflow last operation identifier.")
  lastOperationId?: string;

  @doc("workflow command name.")
  @visibility("read")
  commandName?: string;

  @doc("workflow created timestamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimestamp?: utcDateTime;

  @doc("workflow last status timestamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusTimestamp?: utcDateTime;
}

@doc("Subscription State object.")
model SubscriptionState {
  @doc("State of Azure Subscription")
  state?: Reason;

  @doc("Is Transitioning")
  @visibility("read")
  istransitioning?: boolean;

  @doc("Subscription state properties.")
  properties?: Record<unknown>;
}

@doc("Resource Move Info.")
model ResourcesMoveInfo {
  @doc("Target resource group.")
  targetResourceGroup?: string;

  @doc("Collection of Resources.")
  resources?: string[];
}

@doc("Operation Display Resource object.")
model OperationDisplayResource {
  @doc("Operation Display Resource Provider.")
  provider?: string;

  @doc("Operation Display Resource.")
  resource?: string;

  @doc("Operation Display Resource Operation.")
  operation?: string;

  @doc("Operation Display Resource Description.")
  description?: string;
}

@doc("Operation status object")
model OperationStatus {
  @doc("Operation Id")
  @visibility("read")
  name?: string;

  @doc("Operation status")
  @visibility("read")
  status?: string;

  @doc("Start time of the operation")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time of the operation")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Error details.")
  @visibility("read")
  error?: StorageSyncApiError;
}

@doc("Operation status object")
model LocationOperationStatus {
  @doc("Operation resource Id")
  @visibility("read")
  id?: string;

  @doc("Operation Id")
  @visibility("read")
  name?: string;

  @doc("Operation status")
  @visibility("read")
  status?: string;

  @doc("Start time of the operation")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time of the operation")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Error details.")
  @visibility("read")
  error?: StorageSyncApiError;

  @doc("Percent complete.")
  @visibility("read")
  percentComplete?: int32;
}
