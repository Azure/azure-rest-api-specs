import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.StorageSync;

/**
 * Type of the Incoming Traffic Policy
 */
union IncomingTrafficPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AllowAllTraffic: "AllowAllTraffic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AllowVirtualNetworksOnly: "AllowVirtualNetworksOnly",
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
 * State of change enumeration activity
 */
union CloudEndpointChangeEnumerationActivityState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InitialEnumerationInProgress: "InitialEnumerationInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  EnumerationInProgress: "EnumerationInProgress",
}

/**
 * State of the total counts of change enumeration activity
 */
union CloudEndpointChangeEnumerationTotalCountsState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Calculating: "Calculating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Final: "Final",
}

/**
 * Change Detection Mode. Applies to a directory specified in directoryPath parameter.
 */
union ChangeDetectionMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Recursive: "Recursive",
}

/**
 * Type of the Feature Status
 */
union FeatureStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  on: "on",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  off: "off",
}

/**
 * Policy for how namespace and files are recalled during FastDr
 */
union InitialDownloadPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NamespaceOnly: "NamespaceOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NamespaceThenModifiedFiles: "NamespaceThenModifiedFiles",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AvoidTieredFiles: "AvoidTieredFiles",
}

/**
 * Policy for enabling follow-the-sun business models: link local cache to cloud behavior to pre-populate before local access.
 */
union LocalCacheMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DownloadNewAndModifiedFiles: "DownloadNewAndModifiedFiles",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UpdateLocallyCachedFiles: "UpdateLocallyCachedFiles",
}

/**
 * Policy for how the initial upload sync session is performed.
 */
union InitialUploadPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ServerAuthoritative: "ServerAuthoritative",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Merge: "Merge",
}

/**
 * Type of the server endpoint health state
 */
union ServerEndpointHealthState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unavailable: "Unavailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Healthy: "Healthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
}

/**
 * Type of the sync activity state
 */
union ServerEndpointSyncActivityState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Upload: "Upload",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Download: "Download",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UploadAndDownload: "UploadAndDownload",
}

/**
 * Sync mode for the server endpoint.
 */
union ServerEndpointSyncMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Regular: "Regular",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NamespaceDownload: "NamespaceDownload",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InitialUpload: "InitialUpload",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SnapshotUpload: "SnapshotUpload",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InitialFullDownload: "InitialFullDownload",
}

/**
 * Type of the Health state
 */
union ServerEndpointOfflineDataTransferState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stopping: "Stopping",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotRunning: "NotRunning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Complete: "Complete",
}

/**
 * Type of the cloud tiering low disk mode state
 */
union CloudTieringLowDiskModeState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Server provisioning status
 */
union ServerProvisioningStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotStarted: "NotStarted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ready_SyncNotFunctional: "Ready_SyncNotFunctional",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ready_SyncFunctional: "Ready_SyncFunctional",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
}

/**
 * Type of the registered server agent version status
 */
union RegisteredServerAgentVersionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ok: "Ok",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NearExpiry: "NearExpiry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Expired: "Expired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Blocked: "Blocked",
}

/**
 * Type of the Server Auth type
 */
union ServerAuthType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Certificate: "Certificate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
}

/**
 * Type of the Workflow Status
 */
union WorkflowStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  active: "active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  expired: "expired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  succeeded: "succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  aborted: "aborted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  failed: "failed",
}

/**
 * Type of the Operation Direction
 */
union OperationDirection {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  do: "do",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  undo: "undo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  cancel: "cancel",
}

/**
 * State of Azure Subscription
 */
union Reason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Registered: "Registered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unregistered: "Unregistered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Warned: "Warned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
}

/**
 * Type of the ProgressType
 */
union ProgressType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  none: "none",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  initialize: "initialize",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  download: "download",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  upload: "upload",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recall: "recall",
}

/**
 * Gets the reason that a Storage Sync Service name could not be used. The Reason element is only returned if NameAvailable is false.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#["name"])
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
   * Lock Aggregation type for the metric.
   */
  lockAggregationType?: string;

  /**
   * Dimensions for the metric specification.
   */
  @identifiers(#["name"])
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
  type: Type;
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum Type {
  `Microsoft.StorageSync/storageSyncServices`,
}

/**
 * The CheckNameAvailability operation response.
 */
model CheckNameAvailabilityResult {
  /**
   * Gets a boolean value that indicates whether the name is available for you to use. If true, the name is available. If false, the name has already been taken or invalid and cannot be used.
   */
  @visibility(Lifecycle.Read)
  nameAvailable?: boolean;

  /**
   * Gets the reason that a Storage Sync Service name could not be used. The Reason element is only returned if NameAvailable is false.
   */
  @visibility(Lifecycle.Read)
  reason?: NameAvailabilityReason;

  /**
   * Gets an error message explaining the Reason value in more detail.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * The parameters used when creating a storage sync service.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageSyncServiceCreateParameters
  extends Azure.ResourceManager.CommonTypes.TrackedResource {
  /**
   * managed identities for the Storage Sync to interact with other Azure services without maintaining any secrets or credentials in code.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * The parameters used to create the storage sync service.
   */
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

  /**
   * Use Identity authorization when customer have finished setup RBAC permissions.
   */
  useIdentity?: boolean;
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
  @visibility(Lifecycle.Read)
  storageSyncServiceStatus?: int32;

  /**
   * Storage Sync service Uid
   */
  @visibility(Lifecycle.Read)
  storageSyncServiceUid?: string;

  /**
   * StorageSyncService Provisioning State
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Use Identity authorization when customer have finished setup RBAC permissions.
   */
  @visibility(Lifecycle.Read)
  useIdentity?: boolean;

  /**
   * StorageSyncService lastWorkflowId
   */
  @visibility(Lifecycle.Read)
  lastWorkflowId?: string;

  /**
   * Resource Last Operation Name
   */
  @visibility(Lifecycle.Read)
  lastOperationName?: string;

  /**
   * List of private endpoint connection associated with the specified storage sync service
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["properties/privateEndpoint/id"])
  privateEndpointConnections?: PrivateEndpointConnection[];
}

/**
 * Parameters for updating an Storage sync service.
 */
model StorageSyncServiceUpdateParameters {
  /**
   * The user-specified tags associated with the storage sync service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * managed identities for the Container App to interact with other Azure services without maintaining any secrets or credentials in code.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * The properties of the server endpoint.
   */
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

  /**
   * Use Identity authorization when customer have finished setup RBAC permissions.
   */
  useIdentity?: boolean;
}

/**
 * Array of StorageSyncServices
 */
model StorageSyncServiceArray {
  /**
   * Collection of StorageSyncServices.
   */
  @pageItems
  @identifiers(#["id"])
  value?: StorageSyncService[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Array of SyncGroup
 */
model SyncGroupArray {
  /**
   * Collection of SyncGroup.
   */
  @pageItems
  @identifiers(#["id"])
  value?: SyncGroup[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * SyncGroup Properties object.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SyncGroupProperties {
  /**
   * Unique Id
   */
  @visibility(Lifecycle.Read)
  uniqueId?: string;

  /**
   * Sync group status
   */
  @visibility(Lifecycle.Read)
  syncGroupStatus?: string;
}

/**
 * The parameters used when creating a sync group.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SyncGroupCreateParameters
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The parameters used to create the sync group
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: unknown;
}

/**
 * The parameters used when creating a cloud endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CloudEndpointCreateParameters
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The parameters used to create the cloud endpoint.
   */
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
  @visibility(Lifecycle.Read)
  backupEnabled?: string;

  /**
   * CloudEndpoint Provisioning State
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  changeEnumerationStatus?: CloudEndpointChangeEnumerationStatus;
}

/**
 * Cloud endpoint change enumeration status object
 */
model CloudEndpointChangeEnumerationStatus {
  /**
   * Last updated timestamp
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimestamp?: utcDateTime;

  /**
   * Status of last completed change enumeration
   */
  @visibility(Lifecycle.Read)
  lastEnumerationStatus?: CloudEndpointLastChangeEnumerationStatus;

  /**
   * Change enumeration activity
   */
  @visibility(Lifecycle.Read)
  activity?: CloudEndpointChangeEnumerationActivity;
}

/**
 * Cloud endpoint change enumeration status object
 */
model CloudEndpointLastChangeEnumerationStatus {
  /**
   * Timestamp when change enumeration started
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedTimestamp?: utcDateTime;

  /**
   * Timestamp when change enumeration completed
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completedTimestamp?: utcDateTime;

  /**
   * Count of files in the namespace
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  namespaceFilesCount?: int64;

  /**
   * Count of directories in the namespace
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  namespaceDirectoriesCount?: int64;

  /**
   * Namespace size in bytes
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  namespaceSizeBytes?: int64;

  /**
   * Timestamp of when change enumeration is expected to run again
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimestamp?: utcDateTime;

  /**
   * Change enumeration operation state
   */
  @visibility(Lifecycle.Read)
  operationState?: CloudEndpointChangeEnumerationActivityState;

  /**
   * When non-zero, indicates an issue that is delaying change enumeration
   */
  @visibility(Lifecycle.Read)
  statusCode?: int32;

  /**
   * Timestamp when change enumeration started
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedTimestamp?: utcDateTime;

  /**
   * Count of files processed
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  processedFilesCount?: int64;

  /**
   * Count of directories processed
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  processedDirectoriesCount?: int64;

  /**
   * Total count of files enumerated
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  totalFilesCount?: int64;

  /**
   * Total count of directories enumerated
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  totalDirectoriesCount?: int64;

  /**
   * Total enumerated size in bytes
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  totalSizeBytes?: int64;

  /**
   * Progress percentage for change enumeration run, excluding processing of deletes
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(100)
  progressPercent?: int32;

  /**
   * Estimate of time remaining for the enumeration run
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  minutesRemaining?: int32;

  /**
   * Change enumeration total counts state
   */
  @visibility(Lifecycle.Read)
  totalCountsState?: CloudEndpointChangeEnumerationTotalCountsState;

  /**
   * Progress percentage for processing deletes. This is done separately from the rest of the enumeration run
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(100)
  deletesProgressPercent?: int32;
}

/**
 * Array of CloudEndpoint
 */
model CloudEndpointArray {
  /**
   * Collection of CloudEndpoint.
   */
  @pageItems
  @identifiers(#["id"])
  value?: CloudEndpoint[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
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
  backupMetadata?: PostBackupResponseProperties;
}

/**
 * Post Backup Response Properties object.
 */
model PostBackupResponseProperties {
  /**
   * cloud endpoint Name.
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#["path"])
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
  @identifiers(#["path"])
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @visibility(Lifecycle.Read)
  firstKey?: string;

  /**
   * The second public key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @visibility(Lifecycle.Read)
  secondKey?: string;
}

/**
 * The parameters used when creating a server endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerEndpointCreateParameters
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The parameters used to create the server endpoint.
   */
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
  @minValue(0)
  @maxValue(100)
  volumeFreeSpacePercent?: int32 = 20;

  /**
   * Tier files older than days.
   */
  @minValue(0)
  @maxValue(2147483647)
  tierFilesOlderThanDays?: int32 = 0;

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
  initialDownloadPolicy?: InitialDownloadPolicy = InitialDownloadPolicy.NamespaceThenModifiedFiles;

  /**
   * Policy for enabling follow-the-sun business models: link local cache to cloud behavior to pre-populate before local access.
   */
  localCacheMode?: LocalCacheMode = LocalCacheMode.UpdateLocallyCachedFiles;

  /**
   * Policy for how the initial upload sync session is performed.
   */
  initialUploadPolicy?: InitialUploadPolicy = InitialUploadPolicy.Merge;
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
  @minValue(0)
  @maxValue(100)
  volumeFreeSpacePercent?: int32;

  /**
   * Tier files older than days.
   */
  @minValue(0)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * ServerEndpoint lastWorkflowId
   */
  @visibility(Lifecycle.Read)
  lastWorkflowId?: string;

  /**
   * Resource Last Operation Name
   */
  @visibility(Lifecycle.Read)
  lastOperationName?: string;

  /**
   * Server Endpoint sync status
   */
  @visibility(Lifecycle.Read)
  syncStatus?: ServerEndpointSyncStatus;

  /**
   * Offline data transfer
   */
  offlineDataTransfer?: FeatureStatus;

  /**
   * Offline data transfer storage account resource ID
   */
  @visibility(Lifecycle.Read)
  offlineDataTransferStorageAccountResourceId?: string;

  /**
   * Offline data transfer storage account tenant ID
   */
  @visibility(Lifecycle.Read)
  offlineDataTransferStorageAccountTenantId?: string;

  /**
   * Offline data transfer share name
   */
  offlineDataTransferShareName?: string;

  /**
   * Cloud tiering status. Only populated if cloud tiering is enabled.
   */
  @visibility(Lifecycle.Read)
  cloudTieringStatus?: ServerEndpointCloudTieringStatus;

  /**
   * Recall status. Only populated if cloud tiering is enabled.
   */
  @visibility(Lifecycle.Read)
  recallStatus?: ServerEndpointRecallStatus;

  /**
   * Policy for how namespace and files are recalled during FastDr.
   */
  initialDownloadPolicy?: InitialDownloadPolicy = InitialDownloadPolicy.NamespaceThenModifiedFiles;

  /**
   * Policy for enabling follow-the-sun business models: link local cache to cloud behavior to pre-populate before local access.
   */
  localCacheMode?: LocalCacheMode = LocalCacheMode.UpdateLocallyCachedFiles;

  /**
   * Policy for how the initial upload sync session is performed.
   */
  initialUploadPolicy?: InitialUploadPolicy = InitialUploadPolicy.Merge;

  /**
   * Server name
   */
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * Server Endpoint provisioning status
   */
  serverEndpointProvisioningStatus?: ServerEndpointProvisioningStatus;
}

/**
 * Server Endpoint sync status
 */
model ServerEndpointSyncStatus {
  /**
   * Download Health Status.
   */
  @visibility(Lifecycle.Read)
  downloadHealth?: ServerEndpointHealthState;

  /**
   * Upload Health Status.
   */
  @visibility(Lifecycle.Read)
  uploadHealth?: ServerEndpointHealthState;

  /**
   * Combined Health Status.
   */
  @visibility(Lifecycle.Read)
  combinedHealth?: ServerEndpointHealthState;

  /**
   * Sync activity
   */
  @visibility(Lifecycle.Read)
  syncActivity?: ServerEndpointSyncActivityState;

  /**
   * Total count of persistent files not syncing (combined upload + download).
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  totalPersistentFilesNotSyncingCount?: int64;

  /**
   * Last Updated Timestamp
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimestamp?: utcDateTime;

  /**
   * Upload Status
   */
  @visibility(Lifecycle.Read)
  uploadStatus?: ServerEndpointSyncSessionStatus;

  /**
   * Download Status
   */
  @visibility(Lifecycle.Read)
  downloadStatus?: ServerEndpointSyncSessionStatus;

  /**
   * Upload sync activity
   */
  @visibility(Lifecycle.Read)
  uploadActivity?: ServerEndpointSyncActivityStatus;

  /**
   * Download sync activity
   */
  @visibility(Lifecycle.Read)
  downloadActivity?: ServerEndpointSyncActivityStatus;

  /**
   * Offline Data Transfer State
   */
  @visibility(Lifecycle.Read)
  offlineDataTransferStatus?: ServerEndpointOfflineDataTransferState;

  /**
   * Background data download activity
   */
  @visibility(Lifecycle.Read)
  backgroundDataDownloadActivity?: ServerEndpointBackgroundDataDownloadActivity;
}

/**
 * Sync Session status object.
 */
model ServerEndpointSyncSessionStatus {
  /**
   * Last sync result (HResult)
   */
  @visibility(Lifecycle.Read)
  lastSyncResult?: int32;

  /**
   * Last sync timestamp
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTimestamp?: utcDateTime;

  /**
   * Last sync success timestamp
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncSuccessTimestamp?: utcDateTime;

  /**
   * Last sync per item error count.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  lastSyncPerItemErrorCount?: int64;

  /**
   * Count of persistent files not syncing.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  persistentFilesNotSyncingCount?: int64;

  /**
   * Count of transient files not syncing.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  transientFilesNotSyncingCount?: int64;

  /**
   * Array of per-item errors coming from the last sync session.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["errorCode"])
  filesNotSyncingErrors?: ServerEndpointFilesNotSyncingError[];

  /**
   * Sync mode
   */
  @visibility(Lifecycle.Read)
  lastSyncMode?: ServerEndpointSyncMode;
}

/**
 * Files not syncing error object
 */
model ServerEndpointFilesNotSyncingError {
  /**
   * Error code (HResult)
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * Count of persistent files not syncing with the specified error code
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  persistentCount?: int64;

  /**
   * Count of transient files not syncing with the specified error code
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  transientCount?: int64;
}

/**
 * Sync Session status object.
 */
model ServerEndpointSyncActivityStatus {
  /**
   * Timestamp when properties were updated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Per item error count
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  perItemErrorCount?: int64;

  /**
   * Applied item count.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  appliedItemCount?: int64;

  /**
   * Total item count (if available)
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  totalItemCount?: int64;

  /**
   * Applied bytes
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  appliedBytes?: int64;

  /**
   * Total bytes (if available)
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  totalBytes?: int64;

  /**
   * Sync mode
   */
  @visibility(Lifecycle.Read)
  syncMode?: ServerEndpointSyncMode;

  /**
   * Session minutes remaining (if available)
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  sessionMinutesRemaining?: int32;
}

/**
 * Background data download activity object
 */
model ServerEndpointBackgroundDataDownloadActivity {
  /**
   * Timestamp when properties were updated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Timestamp when the operation started
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedTimestamp?: utcDateTime;

  /**
   * Progress percentage
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(100)
  percentProgress?: int32;

  /**
   * Running count of bytes downloaded
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  downloadedBytes?: int64;
}

/**
 * Server endpoint cloud tiering status object.
 */
model ServerEndpointCloudTieringStatus {
  /**
   * Last updated timestamp
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimestamp?: utcDateTime;

  /**
   * Cloud tiering health state.
   */
  @visibility(Lifecycle.Read)
  health?: ServerEndpointHealthState;

  /**
   * The last updated timestamp of health state
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  healthLastUpdatedTimestamp?: utcDateTime;

  /**
   * Last cloud tiering result (HResult)
   */
  @visibility(Lifecycle.Read)
  lastCloudTieringResult?: int32;

  /**
   * Last cloud tiering success timestamp
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessTimestamp?: utcDateTime;

  /**
   * Information regarding how much local space cloud tiering is saving.
   */
  @visibility(Lifecycle.Read)
  spaceSavings?: CloudTieringSpaceSavings;

  /**
   * Information regarding how well the local cache on the server is performing.
   */
  @visibility(Lifecycle.Read)
  cachePerformance?: CloudTieringCachePerformance;

  /**
   * Information regarding files that failed to be tiered
   */
  @visibility(Lifecycle.Read)
  filesNotTiering?: CloudTieringFilesNotTiering;

  /**
   * Status of the volume free space policy
   */
  @visibility(Lifecycle.Read)
  volumeFreeSpacePolicyStatus?: CloudTieringVolumeFreeSpacePolicyStatus;

  /**
   * Status of the date policy
   */
  @visibility(Lifecycle.Read)
  datePolicyStatus?: CloudTieringDatePolicyStatus;

  /**
   * Information regarding the low disk mode state
   */
  @visibility(Lifecycle.Read)
  lowDiskMode?: CloudTieringLowDiskMode;
}

/**
 * Server endpoint cloud tiering status object.
 */
model CloudTieringSpaceSavings {
  /**
   * Last updated timestamp
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimestamp?: utcDateTime;

  /**
   * Volume size
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  volumeSizeBytes?: int64;

  /**
   * Total size of content in the azure file share
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  totalSizeCloudBytes?: int64;

  /**
   * Cached content size on the server
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  cachedSizeBytes?: int64;

  /**
   * Percentage of cached size over total size
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(100)
  spaceSavingsPercent?: int32;

  /**
   * Count of bytes saved on the server
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  spaceSavingsBytes?: int64;
}

/**
 * Server endpoint cloud tiering status object.
 */
model CloudTieringCachePerformance {
  /**
   * Last updated timestamp
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimestamp?: utcDateTime;

  /**
   * Count of bytes that were served from the local server
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  cacheHitBytes?: int64;

  /**
   * Count of bytes that were served from the cloud
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  cacheMissBytes?: int64;

  /**
   * Percentage of total bytes (hit + miss) that were served from the local server
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimestamp?: utcDateTime;

  /**
   * Last cloud tiering result (HResult)
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  totalFileCount?: int64;

  /**
   * Array of tiering errors
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["errorCode"])
  errors?: FilesNotTieringError[];
}

/**
 * Files not tiering error object
 */
model FilesNotTieringError {
  /**
   * Error code (HResult)
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * Count of files with this error
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  fileCount?: int64;
}

/**
 * Status of the volume free space policy
 */
model CloudTieringVolumeFreeSpacePolicyStatus {
  /**
   * Last updated timestamp
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimestamp?: utcDateTime;

  /**
   * In the case where multiple server endpoints are present in a volume, an effective free space policy is applied.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(100)
  effectiveVolumeFreeSpacePolicy?: int32;

  /**
   * Current volume free space percentage.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimestamp?: utcDateTime;

  /**
   * Most recent access time of tiered files
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimestamp?: utcDateTime;

  /**
   * Low disk mode state
   */
  @visibility(Lifecycle.Read)
  state?: CloudTieringLowDiskModeState;
}

/**
 * Server endpoint recall status object.
 */
model ServerEndpointRecallStatus {
  /**
   * Last updated timestamp
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimestamp?: utcDateTime;

  /**
   * Total count of recall errors.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  totalRecallErrorsCount?: int64;

  /**
   * Array of recall errors
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["errorCode"])
  recallErrors?: ServerEndpointRecallError[];
}

/**
 * Server endpoint recall error object
 */
model ServerEndpointRecallError {
  /**
   * Error code (HResult)
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * Count of occurences of the error
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  count?: int64;
}

/**
 * Server endpoint provisioning status information
 */
model ServerEndpointProvisioningStatus {
  /**
   * Server Endpoint provisioning status
   */
  @visibility(Lifecycle.Read)
  provisioningStatus?: ServerProvisioningStatus;

  /**
   * Server Endpoint provisioning type
   */
  @visibility(Lifecycle.Read)
  provisioningType?: string;

  /**
   * Provisioning Step status information for each step in the provisioning process
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  provisioningStepStatuses?: ServerEndpointProvisioningStepStatus[];
}

/**
 * Server endpoint provisioning step status object.
 */
model ServerEndpointProvisioningStepStatus {
  /**
   * Name of the provisioning step
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Status of the provisioning step
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Start time of the provisioning step
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Estimated completion time of the provisioning step in minutes
   */
  @visibility(Lifecycle.Read)
  minutesLeft?: int32;

  /**
   * Estimated progress percentage
   */
  @visibility(Lifecycle.Read)
  progressPercentage?: int32;

  /**
   * End time of the provisioning step
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Error code (HResult) for the provisioning step
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * Additional information for the provisioning step
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  additionalInformation?: Record<string>;
}

/**
 * Parameters for updating an Server Endpoint.
 */
model ServerEndpointUpdateParameters {
  /**
   * The properties of the server endpoint.
   */
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
  @minValue(0)
  @maxValue(100)
  volumeFreeSpacePercent?: int32;

  /**
   * Tier files older than days.
   */
  @minValue(0)
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
  localCacheMode?: LocalCacheMode = LocalCacheMode.UpdateLocallyCachedFiles;
}

/**
 * Array of ServerEndpoint
 */
model ServerEndpointArray {
  /**
   * Collection of ServerEndpoint.
   */
  @pageItems
  @identifiers(#["id"])
  value?: ServerEndpoint[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
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
 * Array of RegisteredServer
 */
model RegisteredServerArray {
  /**
   * Collection of Registered Server.
   */
  @pageItems
  @identifiers(#["id"])
  value?: RegisteredServer[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
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
  @visibility(Lifecycle.Read)
  agentVersionStatus?: RegisteredServerAgentVersionStatus;

  /**
   * Registered Server Agent Version Expiration Date
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agentVersionExpirationDate?: utcDateTime;

  /**
   * Registered Server OS Version
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * Server Application Id
   */
  applicationId?: string;

  /**
   * Apply server with newly discovered ApplicationId if available.
   */
  @visibility(Lifecycle.Read)
  identity?: boolean;

  /**
   * Latest Server Application Id discovered from the server. It is not yet applied.
   */
  latestApplicationId?: string;

  /**
   * Server auth type.
   */
  @visibility(Lifecycle.Read)
  activeAuthType?: ServerAuthType;
}

/**
 * The parameters used when creating a registered server.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RegisteredServerCreateParameters
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The parameters used to create the registered server.
   */
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  /**
   * Server ServicePrincipal Id
   */
  applicationId?: string;

  /**
   * Apply server with newly discovered ApplicationId if available.
   */
  identity?: boolean;
}

/**
 * The parameters used when updating a registered server.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RegisteredServerUpdateParameters
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The parameters used to update the registered server.
   */
  properties?: RegisteredServerUpdateProperties;
}

/**
 * RegisteredServer Update Properties object.
 */
model RegisteredServerUpdateProperties {
  /**
   * Apply server with newly discovered ApplicationId if available.
   */
  identity?: boolean;

  /**
   * Apply server with new ServicePrincipal Id
   */
  applicationId?: string;
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
 * Array of Workflow
 */
model WorkflowArray {
  /**
   * Collection of workflow items.
   */
  @pageItems
  @identifiers(#["id"])
  value?: Workflow[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Workflow Properties object.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  commandName?: string;

  /**
   * workflow created timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimestamp?: utcDateTime;

  /**
   * workflow last status timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusTimestamp?: utcDateTime;
}

/**
 * Operation status object
 */
model OperationStatus {
  /**
   * Operation Id
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Operation status
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Start time of the operation
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the operation
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Error details.
   */
  @visibility(Lifecycle.Read)
  error?: StorageSyncApiError;
}

/**
 * Operation status object
 */
model LocationOperationStatus {
  /**
   * Operation resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Operation Id
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Operation status
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Start time of the operation
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the operation
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Error details.
   */
  @visibility(Lifecycle.Read)
  error?: StorageSyncApiError;

  /**
   * Percent complete.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;
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
  @visibility(Lifecycle.Read)
  istransitioning?: boolean;

  /**
   * Subscription state properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

model OperationEntityListResult is Azure.Core.Page<OperationEntity>;
@@identifiers(OperationEntityListResult.value, #["name"]);

/**
 * Standard OK response with Azure request tracking headers.
 */
model CustomOkResponse {
  @doc("HTTP 200 OK status code")
  @statusCode
  _: 200;

  @header("x-ms-correlation-request-id")
  @doc("correlation request id.")
  correlationRequestId?: string;

  @header("x-ms-request-id")
  @doc("request id.")
  requestId?: string;
}

/**
 * List of private endpoint connections associated with the specified resource.
 */
model PrivateEndpointConnectionListResult {
  /**
   * List of private endpoint connections associated with the specified resource.
   */
  @pageItems
  value?: PrivateEndpointConnection[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}
