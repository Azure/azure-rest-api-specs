import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.StorageSync;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Type of the Incoming Traffic Policy
 */
enum IncomingTrafficPolicy {
  AllowAllTraffic,
  AllowVirtualNetworksOnly,
}

/**
 * The private endpoint connection status.
 */
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

/**
 * The current provisioning state.
 */
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

/**
 * State of change enumeration activity
 */
enum CloudEndpointChangeEnumerationActivityState {
  InitialEnumerationInProgress,
  EnumerationInProgress,
}

/**
 * State of the total counts of change enumeration activity
 */
enum CloudEndpointChangeEnumerationTotalCountsState {
  Calculating,
  Final,
}

/**
 * Change Detection Mode. Applies to a directory specified in directoryPath parameter.
 */
enum ChangeDetectionMode {
  Default,
  Recursive,
}

/**
 * Type of the Feature Status
 */
enum FeatureStatus {
  on,
  off,
}

/**
 * Policy for how namespace and files are recalled during FastDr
 */
enum InitialDownloadPolicy {
  NamespaceOnly,
  NamespaceThenModifiedFiles,
  AvoidTieredFiles,
}

/**
 * Policy for enabling follow-the-sun business models: link local cache to cloud behavior to pre-populate before local access.
 */
enum LocalCacheMode {
  DownloadNewAndModifiedFiles,
  UpdateLocallyCachedFiles,
}

/**
 * Policy for how the initial upload sync session is performed.
 */
enum InitialUploadPolicy {
  ServerAuthoritative,
  Merge,
}

/**
 * Type of the server endpoint health state
 */
enum ServerEndpointHealthState {
  Unavailable,
  Healthy,
  Error,
}

/**
 * Type of the sync activity state
 */
enum ServerEndpointSyncActivityState {
  Upload,
  Download,
  UploadAndDownload,
}

/**
 * Sync mode for the server endpoint.
 */
enum ServerEndpointSyncMode {
  Regular,
  NamespaceDownload,
  InitialUpload,
  SnapshotUpload,
  InitialFullDownload,
}

/**
 * Type of the Health state
 */
enum ServerEndpointOfflineDataTransferState {
  InProgress,
  Stopping,
  NotRunning,
  Complete,
}

/**
 * Type of the cloud tiering low disk mode state
 */
enum CloudTieringLowDiskModeState {
  Enabled,
  Disabled,
}

/**
 * Type of the registered server agent version status
 */
enum RegisteredServerAgentVersionStatus {
  Ok,
  NearExpiry,
  Expired,
  Blocked,
}

/**
 * Type of the Workflow Status
 */
enum WorkflowStatus {
  active,
  expired,
  succeeded,
  aborted,
  failed,
}

/**
 * Type of the Operation Direction
 */
enum OperationDirection {
  do,
  undo,
  cancel,
}

/**
 * State of Azure Subscription
 */
enum Reason {
  Registered,
  Unregistered,
  Warned,
  Suspended,
  Deleted,
}

/**
 * Type of the ProgressType
 */
enum ProgressType {
  none,
  initialize,
  download,
  upload,
  recall,
}

/**
 * Gets the reason that a Storage Sync Service name could not be used. The Reason element is only returned if NameAvailable is false.
 */
@fixed
enum NameAvailabilityReason {
  Invalid,
  AlreadyExists,
}

/**
 * The operation supported by storage sync.
 */
model OperationEntity {
  /**
   * Operation name: {provider}/{resource}/{operation}.
   */
  name?: string;

  /**
   * The operation supported by storage sync.
   */
  display?: OperationDisplayInfo;

  /**
   * The origin.
   */
  origin?: string;

  /**
   * Properties of the operations resource.
   */
  properties?: OperationProperties;
}

/**
 * The operation supported by storage sync.
 */
model OperationDisplayInfo {
  /**
   * The description of the operation.
   */
  description?: string;

  /**
   * The action that users can perform, based on their permission level.
   */
  operation?: string;

  /**
   * Service provider: Microsoft StorageSync.
   */
  provider?: string;

  /**
   * Resource on which the operation is performed.
   */
  resource?: string;
}

/**
 * Properties of the operations resource.
 */
model OperationProperties {
  /**
   * Service specification for the operations resource.
   */
  serviceSpecification?: OperationResourceServiceSpecification;
}

/**
 * Service specification.
 */
model OperationResourceServiceSpecification {
  /**
   * List of metric specifications.
   */
  metricSpecifications?: OperationResourceMetricSpecification[];
}

/**
 * Operation Display Resource object.
 */
model OperationResourceMetricSpecification {
  /**
   * Name of the metric.
   */
  name?: string;

  /**
   * Display name for the metric.
   */
  displayName?: string;

  /**
   * Display description for the metric.
   */
  displayDescription?: string;

  /**
   * Unit for the metric.
   */
  unit?: string;

  /**
   * Aggregation type for the metric.
   */
  aggregationType?: string;

  /**
   * Supported aggregation types for the metric.
   */
  supportedAggregationTypes?: string[];

  /**
   * Fill gaps in the metric with zero.
   */
  fillGapWithZero?: boolean;

  /**
   * Dimensions for the metric specification.
   */
  dimensions?: OperationResourceMetricSpecificationDimension[];
}

/**
 * OperationResourceMetricSpecificationDimension object.
 */
model OperationResourceMetricSpecificationDimension {
  /**
   * Name of the dimension.
   */
  name?: string;

  /**
   * Display name of the dimensions.
   */
  displayName?: string;

  /**
   * Indicates metric should be exported for Shoebox.
   */
  toBeExportedForShoebox?: boolean;
}

/**
 * Error type
 */
@error
model StorageSyncError {
  /**
   * Error details of the given entry.
   */
  error?: StorageSyncApiError;

  /**
   * Error details of the given entry.
   */
  innererror?: StorageSyncApiError;
}

/**
 * Error type
 */
model StorageSyncApiError {
  /**
   * Error code of the given entry.
   */
  code?: string;

  /**
   * Error message of the given entry.
   */
  message?: string;

  /**
   * Target of the given error entry.
   */
  target?: string;

  /**
   * Error details of the given entry.
   */
  details?: StorageSyncErrorDetails;

  /**
   * Inner error details of the given entry.
   */
  innererror?: StorageSyncInnerErrorDetails;
}

/**
 * Error Details object.
 */
model StorageSyncErrorDetails {
  /**
   * Error code of the given entry.
   */
  code?: string;

  /**
   * Error message of the given entry.
   */
  message?: string;

  /**
   * Target of the given entry.
   */
  target?: string;

  /**
   * Request URI of the given entry.
   */
  requestUri?: string;

  /**
   * Exception type of the given entry.
   */
  exceptionType?: string;

  /**
   * HTTP method of the given entry.
   */
  httpMethod?: string;

  /**
   * Hashed message of the given entry.
   */
  hashedMessage?: string;

  /**
   * HTTP error code of the given entry.
   */
  httpErrorCode?: string;
}

/**
 * Error Details object.
 */
model StorageSyncInnerErrorDetails {
  /**
   * Call stack of the error.
   */
  callStack?: string;

  /**
   * Error message of the error.
   */
  message?: string;

  /**
   * Exception of the inner error.
   */
  innerException?: string;

  /**
   * Call stack of the inner error.
   */
  innerExceptionCallStack?: string;
}

/**
 * Parameters for a check name availability request.
 */
model CheckNameAvailabilityParameters {
  /**
   * The name to check for availability
   */
  name: string;

  /**
   * The resource type. Must be set to Microsoft.StorageSync/storageSyncServices
   */
  type: "Microsoft.StorageSync/storageSyncServices";
}

/**
 * The CheckNameAvailability operation response.
 */
model CheckNameAvailabilityResult {
  /**
   * Gets a boolean value that indicates whether the name is available for you to use. If true, the name is available. If false, the name has already been taken or invalid and cannot be used.
   */
  @visibility("read")
  nameAvailable?: boolean;

  /**
   * Gets the reason that a Storage Sync Service name could not be used. The Reason element is only returned if NameAvailable is false.
   */
  @visibility("read")
  reason?: NameAvailabilityReason;

  /**
   * Gets an error message explaining the Reason value in more detail.
   */
  @visibility("read")
  message?: string;
}

/**
 * The parameters used when creating a storage sync service.
 */
model StorageSyncServiceCreateParameters {
  /**
   * Required. Gets or sets the location of the resource. This will be one of the supported and registered Azure Geo Regions (e.g. West US, East US, Southeast Asia, etc.). The geo region of a resource cannot be changed once it is created, but if an identical geo region is specified on update, the request will succeed.
   */
  location: string;

  /**
   * Gets or sets a list of key value pairs that describe the resource. These tags can be used for viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key with a length no greater than 128 characters and a value with a length no greater than 256 characters.
   */
  tags?: Record<string>;

  /**
   * The parameters used to create the storage sync service.
   */
  @extension("x-ms-client-flatten", true)
  properties?: StorageSyncServiceCreateParametersProperties;
}

/**
 * StorageSyncService Properties object.
 */
model StorageSyncServiceCreateParametersProperties {
  /**
   * Incoming Traffic Policy
   */
  incomingTrafficPolicy?: IncomingTrafficPolicy;
}

/**
 * Storage Sync Service Properties object.
 */
model StorageSyncServiceProperties {
  /**
   * Incoming Traffic Policy
   */
  incomingTrafficPolicy?: IncomingTrafficPolicy;

  /**
   * Storage Sync service status.
   */
  @visibility("read")
  storageSyncServiceStatus?: int32;

  /**
   * Storage Sync service Uid
   */
  @visibility("read")
  storageSyncServiceUid?: string;

  /**
   * StorageSyncService Provisioning State
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * StorageSyncService lastWorkflowId
   */
  @visibility("read")
  lastWorkflowId?: string;

  /**
   * Resource Last Operation Name
   */
  @visibility("read")
  lastOperationName?: string;

  /**
   * List of private endpoint connection associated with the specified storage sync service
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

/**
 * Properties of the PrivateEndpointConnectProperties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private end point.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility("read")
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
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Parameters for updating an Storage sync service.
 */
model StorageSyncServiceUpdateParameters {
  /**
   * The user-specified tags associated with the storage sync service.
   */
  tags?: Record<string>;

  /**
   * The properties of the server endpoint.
   */
  @extension("x-ms-client-flatten", true)
  properties?: StorageSyncServiceUpdateProperties;
}

/**
 * StorageSyncService Properties object.
 */
model StorageSyncServiceUpdateProperties {
  /**
   * Incoming Traffic Policy
   */
  incomingTrafficPolicy?: IncomingTrafficPolicy;
}

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  value?: PrivateLinkResource[];
}

/**
 * A private link resource
 */
model PrivateLinkResource extends Resource {
  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * SyncGroup Properties object.
 */
model SyncGroupProperties {
  /**
   * Unique Id
   */
  @visibility("read")
  uniqueId?: string;

  /**
   * Sync group status
   */
  @visibility("read")
  syncGroupStatus?: string;
}

/**
 * The parameters used when creating a sync group.
 */
model SyncGroupCreateParameters extends ProxyResource {
  /**
   * The parameters used to create the sync group
   */
  @extension("x-ms-client-flatten", true)
  properties?: Record<unknown>;
}

/**
 * The parameters used when creating a cloud endpoint.
 */
model CloudEndpointCreateParameters extends ProxyResource {
  /**
   * The parameters used to create the cloud endpoint.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CloudEndpointCreateParametersProperties;
}

/**
 * CloudEndpoint Properties object.
 */
model CloudEndpointCreateParametersProperties {
  /**
   * Storage Account Resource Id
   */
  storageAccountResourceId?: string;

  /**
   * Azure file share name
   */
  azureFileShareName?: string;

  /**
   * Storage Account Tenant Id
   */
  storageAccountTenantId?: string;

  /**
   * Friendly Name
   */
  friendlyName?: string;
}

/**
 * CloudEndpoint Properties object.
 */
model CloudEndpointProperties {
  /**
   * Storage Account Resource Id
   */
  storageAccountResourceId?: string;

  /**
   * Azure file share name
   */
  azureFileShareName?: string;

  /**
   * Storage Account Tenant Id
   */
  storageAccountTenantId?: string;

  /**
   * Partnership Id
   */
  partnershipId?: string;

  /**
   * Friendly Name
   */
  friendlyName?: string;

  /**
   * Backup Enabled
   */
  @visibility("read")
  backupEnabled?: string;

  /**
   * CloudEndpoint Provisioning State
   */
  provisioningState?: string;

  /**
   * CloudEndpoint lastWorkflowId
   */
  lastWorkflowId?: string;

  /**
   * Resource Last Operation Name
   */
  lastOperationName?: string;

  /**
   * Cloud endpoint change enumeration status
   */
  @visibility("read")
  changeEnumerationStatus?: CloudEndpointChangeEnumerationStatus;
}

/**
 * Cloud endpoint change enumeration status object
 */
model CloudEndpointChangeEnumerationStatus {
  /**
   * Last updated timestamp
   */
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * Status of last completed change enumeration
   */
  @visibility("read")
  lastEnumerationStatus?: CloudEndpointLastChangeEnumerationStatus;

  /**
   * Change enumeration activity
   */
  @visibility("read")
  activity?: CloudEndpointChangeEnumerationActivity;
}

/**
 * Cloud endpoint change enumeration status object
 */
model CloudEndpointLastChangeEnumerationStatus {
  /**
   * Timestamp when change enumeration started
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedTimestamp?: utcDateTime;

  /**
   * Timestamp when change enumeration completed
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completedTimestamp?: utcDateTime;

  /**
   * Count of files in the namespace
   */
  @visibility("read")
  namespaceFilesCount?: int64;

  /**
   * Count of directories in the namespace
   */
  @visibility("read")
  namespaceDirectoriesCount?: int64;

  /**
   * Namespace size in bytes
   */
  @visibility("read")
  namespaceSizeBytes?: int64;

  /**
   * Timestamp of when change enumeration is expected to run again
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextRunTimestamp?: utcDateTime;
}

/**
 * Cloud endpoint change enumeration activity object
 */
model CloudEndpointChangeEnumerationActivity {
  /**
   * Last updated timestamp
   */
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * Change enumeration operation state
   */
  @visibility("read")
  operationState?: CloudEndpointChangeEnumerationActivityState;

  /**
   * When non-zero, indicates an issue that is delaying change enumeration
   */
  @visibility("read")
  statusCode?: int32;

  /**
   * Timestamp when change enumeration started
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedTimestamp?: utcDateTime;

  /**
   * Count of files processed
   */
  @visibility("read")
  processedFilesCount?: int64;

  /**
   * Count of directories processed
   */
  @visibility("read")
  processedDirectoriesCount?: int64;

  /**
   * Total count of files enumerated
   */
  @visibility("read")
  totalFilesCount?: int64;

  /**
   * Total count of directories enumerated
   */
  @visibility("read")
  totalDirectoriesCount?: int64;

  /**
   * Total enumerated size in bytes
   */
  @visibility("read")
  totalSizeBytes?: int64;

  /**
   * Progress percentage for change enumeration run, excluding processing of deletes
   */
  @visibility("read")
  @maxValue(100)
  progressPercent?: int32;

  /**
   * Estimate of time remaining for the enumeration run
   */
  @visibility("read")
  minutesRemaining?: int32;

  /**
   * Change enumeration total counts state
   */
  @visibility("read")
  totalCountsState?: CloudEndpointChangeEnumerationTotalCountsState;

  /**
   * Progress percentage for processing deletes. This is done separately from the rest of the enumeration run
   */
  @visibility("read")
  @maxValue(100)
  deletesProgressPercent?: int32;
}

/**
 * Backup request
 */
model BackupRequest {
  /**
   * Azure File Share.
   */
  azureFileShare?: string;
}

/**
 * Post Backup Response
 */
model PostBackupResponse {
  /**
   * Post Backup Response Properties
   */
  @extension("x-ms-client-flatten", true)
  backupMetadata?: PostBackupResponseProperties;
}

/**
 * Post Backup Response Properties object.
 */
model PostBackupResponseProperties {
  /**
   * cloud endpoint Name.
   */
  @visibility("read")
  cloudEndpointName?: string;
}

/**
 * Pre Restore request object.
 */
model PreRestoreRequest {
  /**
   * Pre Restore partition.
   */
  partition?: string;

  /**
   * Pre Restore replica group.
   */
  replicaGroup?: string;

  /**
   * Pre Restore request id.
   */
  requestId?: string;

  /**
   * Pre Restore Azure file share uri.
   */
  azureFileShareUri?: string;

  /**
   * Pre Restore Azure status.
   */
  status?: string;

  /**
   * Pre Restore Azure source azure file share uri.
   */
  sourceAzureFileShareUri?: string;

  /**
   * Pre Restore backup metadata property bag.
   */
  backupMetadataPropertyBag?: string;

  /**
   * Pre Restore restore file spec array.
   */
  restoreFileSpec?: RestoreFileSpec[];

  /**
   * Pre Restore pause wait for sync drain time period in seconds.
   */
  pauseWaitForSyncDrainTimePeriodInSeconds?: int32;
}

/**
 * Restore file spec.
 */
model RestoreFileSpec {
  /**
   * Restore file spec path
   */
  path?: string;

  /**
   * Restore file spec isdir
   */
  isdir?: boolean;
}

/**
 * Post Restore Request
 */
model PostRestoreRequest {
  /**
   * Post Restore partition.
   */
  partition?: string;

  /**
   * Post Restore replica group.
   */
  replicaGroup?: string;

  /**
   * Post Restore request id.
   */
  requestId?: string;

  /**
   * Post Restore Azure file share uri.
   */
  azureFileShareUri?: string;

  /**
   * Post Restore Azure status.
   */
  status?: string;

  /**
   * Post Restore Azure source azure file share uri.
   */
  sourceAzureFileShareUri?: string;

  /**
   * Post Restore Azure failed file list.
   */
  failedFileList?: string;

  /**
   * Post Restore restore file spec array.
   */
  restoreFileSpec?: RestoreFileSpec[];
}

/**
 * The parameters used when calling trigger change detection action on cloud endpoint.
 */
model TriggerChangeDetectionParameters {
  /**
   * Relative path to a directory Azure File share for which change detection is to be performed.
   */
  directoryPath?: string;

  /**
   * Change Detection Mode. Applies to a directory specified in directoryPath parameter.
   */
  changeDetectionMode?: ChangeDetectionMode;

  /**
   * Array of relative paths on the Azure File share to be included in the change detection. Can be files and directories.
   */
  paths?: string[];
}

/**
 * Cloud endpoint AFS file share metadata signing certificate public keys.
 */
model CloudEndpointAfsShareMetadataCertificatePublicKeys {
  /**
   * The first public key.
   */
  @visibility("read")
  firstKey?: string;

  /**
   * The second public key.
   */
  @visibility("read")
  secondKey?: string;
}

/**
 * The parameters used when creating a server endpoint.
 */
model ServerEndpointCreateParameters extends ProxyResource {
  /**
   * The parameters used to create the server endpoint.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ServerEndpointCreateParametersProperties;
}

/**
 * ServerEndpoint Properties object.
 */
model ServerEndpointCreateParametersProperties {
  /**
   * Server Local path.
   */
  serverLocalPath?: string;

  /**
   * Cloud Tiering.
   */
  cloudTiering?: FeatureStatus;

  /**
   * Level of free space to be maintained by Cloud Tiering if it is enabled.
   */
  @maxValue(100)
  volumeFreeSpacePercent?: int32 = 20;

  /**
   * Tier files older than days.
   */
  @maxValue(2147483647)
  tierFilesOlderThanDays?: int32;

  /**
   * Friendly Name
   */
  friendlyName?: string;

  /**
   * Server Resource Id.
   */
  serverResourceId?: string;

  /**
   * Offline data transfer
   */
  offlineDataTransfer?: FeatureStatus;

  /**
   * Offline data transfer share name
   */
  offlineDataTransferShareName?: string;

  /**
   * Policy for how namespace and files are recalled during FastDr.
   */
  initialDownloadPolicy?: InitialDownloadPolicy;

  /**
   * Policy for enabling follow-the-sun business models: link local cache to cloud behavior to pre-populate before local access.
   */
  localCacheMode?: LocalCacheMode;

  /**
   * Policy for how the initial upload sync session is performed.
   */
  initialUploadPolicy?: InitialUploadPolicy;
}

/**
 * ServerEndpoint Properties object.
 */
model ServerEndpointProperties {
  /**
   * Server Local path.
   */
  serverLocalPath?: string;

  /**
   * Cloud Tiering.
   */
  cloudTiering?: FeatureStatus;

  /**
   * Level of free space to be maintained by Cloud Tiering if it is enabled.
   */
  @maxValue(100)
  volumeFreeSpacePercent?: int32;

  /**
   * Tier files older than days.
   */
  @maxValue(2147483647)
  tierFilesOlderThanDays?: int32;

  /**
   * Friendly Name
   */
  friendlyName?: string;

  /**
   * Server Resource Id.
   */
  serverResourceId?: string;

  /**
   * ServerEndpoint Provisioning State
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * ServerEndpoint lastWorkflowId
   */
  @visibility("read")
  lastWorkflowId?: string;

  /**
   * Resource Last Operation Name
   */
  @visibility("read")
  lastOperationName?: string;

  /**
   * Server Endpoint sync status
   */
  @visibility("read")
  syncStatus?: ServerEndpointSyncStatus;

  /**
   * Offline data transfer
   */
  offlineDataTransfer?: FeatureStatus;

  /**
   * Offline data transfer storage account resource ID
   */
  @visibility("read")
  offlineDataTransferStorageAccountResourceId?: string;

  /**
   * Offline data transfer storage account tenant ID
   */
  @visibility("read")
  offlineDataTransferStorageAccountTenantId?: string;

  /**
   * Offline data transfer share name
   */
  offlineDataTransferShareName?: string;

  /**
   * Cloud tiering status. Only populated if cloud tiering is enabled.
   */
  @visibility("read")
  cloudTieringStatus?: ServerEndpointCloudTieringStatus;

  /**
   * Recall status. Only populated if cloud tiering is enabled.
   */
  @visibility("read")
  recallStatus?: ServerEndpointRecallStatus;

  /**
   * Policy for how namespace and files are recalled during FastDr.
   */
  initialDownloadPolicy?: InitialDownloadPolicy;

  /**
   * Policy for enabling follow-the-sun business models: link local cache to cloud behavior to pre-populate before local access.
   */
  localCacheMode?: LocalCacheMode;

  /**
   * Policy for how the initial upload sync session is performed.
   */
  initialUploadPolicy?: InitialUploadPolicy;

  /**
   * Server name
   */
  @visibility("read")
  serverName?: string;
}

/**
 * Server Endpoint sync status
 */
model ServerEndpointSyncStatus {
  /**
   * Download Health Status.
   */
  @visibility("read")
  downloadHealth?: ServerEndpointHealthState;

  /**
   * Upload Health Status.
   */
  @visibility("read")
  uploadHealth?: ServerEndpointHealthState;

  /**
   * Combined Health Status.
   */
  @visibility("read")
  combinedHealth?: ServerEndpointHealthState;

  /**
   * Sync activity
   */
  @visibility("read")
  syncActivity?: ServerEndpointSyncActivityState;

  /**
   * Total count of persistent files not syncing (combined upload + download).
   */
  @visibility("read")
  totalPersistentFilesNotSyncingCount?: int64;

  /**
   * Last Updated Timestamp
   */
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * Upload Status
   */
  @visibility("read")
  uploadStatus?: ServerEndpointSyncSessionStatus;

  /**
   * Download Status
   */
  @visibility("read")
  downloadStatus?: ServerEndpointSyncSessionStatus;

  /**
   * Upload sync activity
   */
  @visibility("read")
  uploadActivity?: ServerEndpointSyncActivityStatus;

  /**
   * Download sync activity
   */
  @visibility("read")
  downloadActivity?: ServerEndpointSyncActivityStatus;

  /**
   * Offline Data Transfer State
   */
  @visibility("read")
  offlineDataTransferStatus?: ServerEndpointOfflineDataTransferState;

  /**
   * Background data download activity
   */
  @visibility("read")
  backgroundDataDownloadActivity?: ServerEndpointBackgroundDataDownloadActivity;
}

/**
 * Sync Session status object.
 */
model ServerEndpointSyncSessionStatus {
  /**
   * Last sync result (HResult)
   */
  @visibility("read")
  lastSyncResult?: int32;

  /**
   * Last sync timestamp
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTimestamp?: utcDateTime;

  /**
   * Last sync success timestamp
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncSuccessTimestamp?: utcDateTime;

  /**
   * Last sync per item error count.
   */
  @visibility("read")
  lastSyncPerItemErrorCount?: int64;

  /**
   * Count of persistent files not syncing.
   */
  @visibility("read")
  persistentFilesNotSyncingCount?: int64;

  /**
   * Count of transient files not syncing.
   */
  @visibility("read")
  transientFilesNotSyncingCount?: int64;

  /**
   * Array of per-item errors coming from the last sync session.
   */
  @visibility("read")
  filesNotSyncingErrors?: ServerEndpointFilesNotSyncingError[];

  /**
   * Sync mode
   */
  @visibility("read")
  lastSyncMode?: ServerEndpointSyncMode;
}

/**
 * Files not syncing error object
 */
model ServerEndpointFilesNotSyncingError {
  /**
   * Error code (HResult)
   */
  @visibility("read")
  errorCode?: int32;

  /**
   * Count of persistent files not syncing with the specified error code
   */
  @visibility("read")
  persistentCount?: int64;

  /**
   * Count of transient files not syncing with the specified error code
   */
  @visibility("read")
  transientCount?: int64;
}

/**
 * Sync Session status object.
 */
model ServerEndpointSyncActivityStatus {
  /**
   * Timestamp when properties were updated
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Per item error count
   */
  @visibility("read")
  perItemErrorCount?: int64;

  /**
   * Applied item count.
   */
  @visibility("read")
  appliedItemCount?: int64;

  /**
   * Total item count (if available)
   */
  @visibility("read")
  totalItemCount?: int64;

  /**
   * Applied bytes
   */
  @visibility("read")
  appliedBytes?: int64;

  /**
   * Total bytes (if available)
   */
  @visibility("read")
  totalBytes?: int64;

  /**
   * Sync mode
   */
  @visibility("read")
  syncMode?: ServerEndpointSyncMode;

  /**
   * Session minutes remaining (if available)
   */
  @visibility("read")
  sessionMinutesRemaining?: int32;
}

/**
 * Background data download activity object
 */
model ServerEndpointBackgroundDataDownloadActivity {
  /**
   * Timestamp when properties were updated
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Timestamp when the operation started
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedTimestamp?: utcDateTime;

  /**
   * Progress percentage
   */
  @visibility("read")
  @maxValue(100)
  percentProgress?: int32;

  /**
   * Running count of bytes downloaded
   */
  @visibility("read")
  downloadedBytes?: int64;
}

/**
 * Server endpoint cloud tiering status object.
 */
model ServerEndpointCloudTieringStatus {
  /**
   * Last updated timestamp
   */
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * Cloud tiering health state.
   */
  @visibility("read")
  health?: ServerEndpointHealthState;

  /**
   * The last updated timestamp of health state
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  healthLastUpdatedTimestamp?: utcDateTime;

  /**
   * Last cloud tiering result (HResult)
   */
  @visibility("read")
  lastCloudTieringResult?: int32;

  /**
   * Last cloud tiering success timestamp
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessTimestamp?: utcDateTime;

  /**
   * Information regarding how much local space cloud tiering is saving.
   */
  @visibility("read")
  spaceSavings?: CloudTieringSpaceSavings;

  /**
   * Information regarding how well the local cache on the server is performing.
   */
  @visibility("read")
  cachePerformance?: CloudTieringCachePerformance;

  /**
   * Information regarding files that failed to be tiered
   */
  @visibility("read")
  filesNotTiering?: CloudTieringFilesNotTiering;

  /**
   * Status of the volume free space policy
   */
  @visibility("read")
  volumeFreeSpacePolicyStatus?: CloudTieringVolumeFreeSpacePolicyStatus;

  /**
   * Status of the date policy
   */
  @visibility("read")
  datePolicyStatus?: CloudTieringDatePolicyStatus;

  /**
   * Information regarding the low disk mode state
   */
  @visibility("read")
  lowDiskMode?: CloudTieringLowDiskMode;
}

/**
 * Server endpoint cloud tiering status object.
 */
model CloudTieringSpaceSavings {
  /**
   * Last updated timestamp
   */
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * Volume size
   */
  @visibility("read")
  volumeSizeBytes?: int64;

  /**
   * Total size of content in the azure file share
   */
  @visibility("read")
  totalSizeCloudBytes?: int64;

  /**
   * Cached content size on the server
   */
  @visibility("read")
  cachedSizeBytes?: int64;

  /**
   * Percentage of cached size over total size
   */
  @visibility("read")
  @maxValue(100)
  spaceSavingsPercent?: int32;

  /**
   * Count of bytes saved on the server
   */
  @visibility("read")
  spaceSavingsBytes?: int64;
}

/**
 * Server endpoint cloud tiering status object.
 */
model CloudTieringCachePerformance {
  /**
   * Last updated timestamp
   */
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * Count of bytes that were served from the local server
   */
  @visibility("read")
  cacheHitBytes?: int64;

  /**
   * Count of bytes that were served from the cloud
   */
  @visibility("read")
  cacheMissBytes?: int64;

  /**
   * Percentage of total bytes (hit + miss) that were served from the local server
   */
  @visibility("read")
  @maxValue(100)
  cacheHitBytesPercent?: int32;
}

/**
 * Server endpoint cloud tiering status object.
 */
model CloudTieringFilesNotTiering {
  /**
   * Last updated timestamp
   */
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * Last cloud tiering result (HResult)
   */
  @visibility("read")
  totalFileCount?: int64;

  /**
   * Array of tiering errors
   */
  @visibility("read")
  errors?: FilesNotTieringError[];
}

/**
 * Files not tiering error object
 */
model FilesNotTieringError {
  /**
   * Error code (HResult)
   */
  @visibility("read")
  errorCode?: int32;

  /**
   * Count of files with this error
   */
  @visibility("read")
  fileCount?: int64;
}

/**
 * Status of the volume free space policy
 */
model CloudTieringVolumeFreeSpacePolicyStatus {
  /**
   * Last updated timestamp
   */
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * In the case where multiple server endpoints are present in a volume, an effective free space policy is applied.
   */
  @visibility("read")
  @maxValue(100)
  effectiveVolumeFreeSpacePolicy?: int32;

  /**
   * Current volume free space percentage.
   */
  @visibility("read")
  @maxValue(100)
  currentVolumeFreeSpacePercent?: int32;
}

/**
 * Status of the date policy
 */
model CloudTieringDatePolicyStatus {
  /**
   * Last updated timestamp
   */
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * Most recent access time of tiered files
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  tieredFilesMostRecentAccessTimestamp?: utcDateTime;
}

/**
 * Information regarding the low disk mode state
 */
model CloudTieringLowDiskMode {
  /**
   * Last updated timestamp
   */
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * Low disk mode state
   */
  @visibility("read")
  state?: CloudTieringLowDiskModeState;
}

/**
 * Server endpoint recall status object.
 */
model ServerEndpointRecallStatus {
  /**
   * Last updated timestamp
   */
  @visibility("read")
  @projectedName("json", "lastUpdatedTimestamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * Total count of recall errors.
   */
  @visibility("read")
  totalRecallErrorsCount?: int64;

  /**
   * Array of recall errors
   */
  @visibility("read")
  recallErrors?: ServerEndpointRecallError[];
}

/**
 * Server endpoint recall error object
 */
model ServerEndpointRecallError {
  /**
   * Error code (HResult)
   */
  @visibility("read")
  errorCode?: int32;

  /**
   * Count of occurences of the error
   */
  @visibility("read")
  count?: int64;
}

/**
 * Parameters for updating an Server Endpoint.
 */
model ServerEndpointUpdateParameters {
  /**
   * The properties of the server endpoint.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ServerEndpointUpdateProperties;
}

/**
 * ServerEndpoint Update Properties object.
 */
model ServerEndpointUpdateProperties {
  /**
   * Cloud Tiering.
   */
  cloudTiering?: FeatureStatus;

  /**
   * Level of free space to be maintained by Cloud Tiering if it is enabled.
   */
  @maxValue(100)
  volumeFreeSpacePercent?: int32;

  /**
   * Tier files older than days.
   */
  @maxValue(2147483647)
  tierFilesOlderThanDays?: int32;

  /**
   * Offline data transfer
   */
  offlineDataTransfer?: FeatureStatus;

  /**
   * Offline data transfer share name
   */
  offlineDataTransferShareName?: string;

  /**
   * Policy for enabling follow-the-sun business models: link local cache to cloud behavior to pre-populate before local access.
   */
  localCacheMode?: LocalCacheMode;
}

/**
 * The parameters used when calling recall action on server endpoint.
 */
model RecallActionParameters {
  /**
   * Pattern of the files.
   */
  pattern?: string;

  /**
   * Recall path.
   */
  recallPath?: string;
}

/**
 * RegisteredServer Properties object.
 */
model RegisteredServerProperties {
  /**
   * Registered Server Certificate
   */
  serverCertificate?: string;

  /**
   * Registered Server Agent Version
   */
  agentVersion?: string;

  /**
   * Registered Server Agent Version Status
   */
  @visibility("read")
  agentVersionStatus?: RegisteredServerAgentVersionStatus;

  /**
   * Registered Server Agent Version Expiration Date
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agentVersionExpirationDate?: utcDateTime;

  /**
   * Registered Server OS Version
   */
  serverOSVersion?: string;

  /**
   * Registered Server Management Error Code
   */
  serverManagementErrorCode?: int32;

  /**
   * Registered Server last heart beat
   */
  lastHeartBeat?: string;

  /**
   * Registered Server Provisioning State
   */
  provisioningState?: string;

  /**
   * Registered Server serverRole
   */
  serverRole?: string;

  /**
   * Registered Server clusterId
   */
  clusterId?: string;

  /**
   * Registered Server clusterName
   */
  clusterName?: string;

  /**
   * Registered Server serverId
   */
  serverId?: string;

  /**
   * Registered Server storageSyncServiceUid
   */
  storageSyncServiceUid?: string;

  /**
   * Registered Server lastWorkflowId
   */
  lastWorkflowId?: string;

  /**
   * Resource Last Operation Name
   */
  lastOperationName?: string;

  /**
   * Resource discoveryEndpointUri
   */
  discoveryEndpointUri?: string;

  /**
   * Resource Location
   */
  resourceLocation?: string;

  /**
   * Service Location
   */
  serviceLocation?: string;

  /**
   * Friendly Name
   */
  friendlyName?: string;

  /**
   * Management Endpoint Uri
   */
  managementEndpointUri?: string;

  /**
   * Telemetry Endpoint Uri
   */
  monitoringEndpointUri?: string;

  /**
   * Monitoring Configuration
   */
  monitoringConfiguration?: string;

  /**
   * Server name
   */
  @visibility("read")
  serverName?: string;
}

/**
 * The parameters used when creating a registered server.
 */
model RegisteredServerCreateParameters extends ProxyResource {
  /**
   * The parameters used to create the registered server.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RegisteredServerCreateParametersProperties;
}

/**
 * RegisteredServer Create Properties object.
 */
model RegisteredServerCreateParametersProperties {
  /**
   * Registered Server Certificate
   */
  serverCertificate?: string;

  /**
   * Registered Server Agent Version
   */
  agentVersion?: string;

  /**
   * Registered Server OS Version
   */
  serverOSVersion?: string;

  /**
   * Registered Server last heart beat
   */
  lastHeartBeat?: string;

  /**
   * Registered Server serverRole
   */
  serverRole?: string;

  /**
   * Registered Server clusterId
   */
  clusterId?: string;

  /**
   * Registered Server clusterName
   */
  clusterName?: string;

  /**
   * Registered Server serverId
   */
  serverId?: string;

  /**
   * Friendly Name
   */
  friendlyName?: string;
}

/**
 * Trigger Rollover Request.
 */
model TriggerRolloverRequest {
  /**
   * Certificate Data
   */
  serverCertificate?: string;
}

/**
 * Workflow Properties object.
 */
model WorkflowProperties {
  /**
   * last step name
   */
  lastStepName?: string;

  /**
   * workflow status.
   */
  status?: WorkflowStatus;

  /**
   * operation direction.
   */
  operation?: OperationDirection;

  /**
   * workflow steps
   */
  steps?: string;

  /**
   * workflow last operation identifier.
   */
  lastOperationId?: string;

  /**
   * workflow command name.
   */
  @visibility("read")
  commandName?: string;

  /**
   * workflow created timestamp.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimestamp?: utcDateTime;

  /**
   * workflow last status timestamp.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusTimestamp?: utcDateTime;
}

/**
 * Subscription State object.
 */
model SubscriptionState {
  /**
   * State of Azure Subscription
   */
  state?: Reason;

  /**
   * Is Transitioning
   */
  @visibility("read")
  istransitioning?: boolean;

  /**
   * Subscription state properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: Record<unknown>;
}

/**
 * Resource Move Info.
 */
model ResourcesMoveInfo {
  /**
   * Target resource group.
   */
  targetResourceGroup?: string;

  /**
   * Collection of Resources.
   */
  resources?: string[];
}

/**
 * Operation Display Resource object.
 */
model OperationDisplayResource {
  /**
   * Operation Display Resource Provider.
   */
  provider?: string;

  /**
   * Operation Display Resource.
   */
  resource?: string;

  /**
   * Operation Display Resource Operation.
   */
  operation?: string;

  /**
   * Operation Display Resource Description.
   */
  description?: string;
}

/**
 * Operation status object
 */
model OperationStatus {
  /**
   * Operation Id
   */
  @visibility("read")
  name?: string;

  /**
   * Operation status
   */
  @visibility("read")
  status?: string;

  /**
   * Start time of the operation
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the operation
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Error details.
   */
  @visibility("read")
  error?: StorageSyncApiError;
}

/**
 * Operation status object
 */
model LocationOperationStatus {
  /**
   * Operation resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Operation Id
   */
  @visibility("read")
  name?: string;

  /**
   * Operation status
   */
  @visibility("read")
  status?: string;

  /**
   * Start time of the operation
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the operation
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Error details.
   */
  @visibility("read")
  error?: StorageSyncApiError;

  /**
   * Percent complete.
   */
  @visibility("read")
  percentComplete?: int32;
}
