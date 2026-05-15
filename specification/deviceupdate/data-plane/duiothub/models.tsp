import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace DeviceUpdateClient;

/**
 * Step type.
 */
union StepType {
  string,

  /**
   * Step type that performs code execution.
   */
  Inline: "inline",

  /**
   * Step type that installs another update.
   */
  Reference: "reference",
}

/**
 * Operation status.
 */
union OperationStatus {
  string,

  /**
   * Background operation created but not started yet.
   */
  NotStarted: "NotStarted",

  /**
   * Background operation is currently running.
   */
  Running: "Running",

  /**
   * Background operation finished with success.
   */
  Succeeded: "Succeeded",

  /**
   * Background operation finished with failure.
   */
  Failed: "Failed",
}

/**
 * Deployment state.
 */
union DeviceDeploymentState {
  string,

  /**
   * Deployment has completed with success.
   */
  Succeeded: "Succeeded",

  /**
   * Deployment is in progress.
   */
  InProgress: "InProgress",

  /**
   * Deployment was canceled.
   */
  Canceled: "Canceled",

  /**
   * Deployment has completed with failure.
   */
  Failed: "Failed",
}

/**
 * The device import type.
 */
union ImportType {
  string,

  /**
   * Import only devices but not modules.
   */
  Devices: "Devices",

  /**
   * Import only modules but not devices.
   */
  Modules: "Modules",

  /**
   * Import both devices and modules.
   */
  All: "All",
}

/**
 * Supported group types.
 */
union GroupType {
  string,

  /**
   * IoT Hub tag based group, all devices in the group share an ADUGroup tag value.
   */
  IoTHubTag: "IoTHubTag",

  /**
   * Default group for untagged devices.
   */
  DefaultNoTag: "DefaultNoTag",
}

/**
 * Deployment state.
 */
union DeploymentState {
  string,

  /**
   * The deployment can be sent to devices targeted in the deployment.
   */
  Active: "Active",

  /**
   * The deployment can be sent to some devices targeted in the deployment but at
   * least 1 subgroup is in a failed state.
   */
  ActiveWithSubgroupFailures: "ActiveWithSubgroupFailures",

  /**
   * The deployment will not be sent to any devices.  Consult error for more details
   * about what failed.
   */
  Failed: "Failed",

  /**
   * A newer deployment for this group has been created and no devices in the group
   * will receive this deployment.
   */
  Inactive: "Inactive",

  /**
   * The deployment has been canceled and no devices will receive it.
   */
  Canceled: "Canceled",
}

/**
 * Device class subgroup deployment state.
 */
union DeviceClassSubgroupDeploymentState {
  string,

  /**
   * The subgroup deployment can be sent to devices targeted in the deployment.
   */
  Active: "Active",

  /**
   * The subgroup deployment failed and will not be sent to any devices.
   */
  Failed: "Failed",

  /**
   * A newer deployment for this subgroup has been created and no devices in the
   * subgroup will receive this deployment.
   */
  Inactive: "Inactive",

  /**
   * The subgroup deployment has been canceled and no devices will receive it.
   */
  Canceled: "Canceled",
}

/**
 * Device health states
 */
union DeviceHealthState {
  string,

  /**
   * Agent is healthy
   */
  healthy: "healthy",

  /**
   * Agent is in an unhealthy state
   */
  unhealthy: "unhealthy",
}

/**
 * Health check result
 */
union HealthCheckResult {
  string,

  /**
   * Health check succeeded
   */
  success: "success",

  /**
   * Health check failed due to user error
   */
  userError: "userError",
}

/**
 * Operation status filter.
 */
union OperationFilterStatus {
  string,

  /**
   * Running
   */
  Running: "Running",

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",
}

/**
 * The list of updates.
 */
model UpdateList is Azure.Core.Page<Update>;

/**
 * Key-value pairs representing update compatibility information.
 */
@extension("minProperties", 1)
@extension("maxProperties", 5)
model Compatibility is Record<string>;

/**
 * Update metadata.
 */
model Update {
  /**
   * Update identity.
   */
  updateId: UpdateId;

  /**
   * Update description specified by creator.
   */
  @maxLength(512)
  @minLength(1)
  description?: string;

  /**
   * Friendly update name specified by importer.
   */
  @maxLength(512)
  @minLength(1)
  friendlyName?: string;

  /**
   * Whether the update can be deployed to a device on its own.
   */
  isDeployable?: boolean = true;

  /**
   * Update type. Deprecated in latest import manifest schema.
   */
  updateType?: string;

  /**
   * String interpreted by Device Update client to determine if the update is
   * installed on the device. Deprecated in latest import manifest schema.
   */
  installedCriteria?: string;

  /**
   * List of update compatibility information.
   */
  @minItems(1)
  @maxItems(10)
  compatibility: Compatibility[];

  /**
   * Update install instructions.
   */
  instructions?: Instructions;

  /**
   * List of update identities that reference this update.
   */
  @minItems(1)
  referencedBy?: UpdateId[];

  /**
   * Update aggregate scan result (calculated from payload file scan results).
   */
  scanResult?: string;

  /**
   * Schema version of manifest used to import the update.
   */
  manifestVersion: string;

  /**
   * Date and time in UTC when the update was imported.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  importedDateTime: utcDateTime;

  /**
   * Date and time in UTC when the update was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime: utcDateTime;

  /**
   * Update ETag.
   */
  etag?: string;
}

/**
 * Update identifier.
 */
model UpdateId {
  /**
   * Update provider.
   */
  provider: string;

  /**
   * Update name.
   */
  name: string;

  /**
   * Update version.
   */
  version: string;
}

/**
 * Update install instructions container.
 */
model Instructions {
  /**
   * Collection of installation steps.
   */
  @minItems(1)
  @maxItems(10)
  steps: Step[];
}

/**
 * Update install instruction step.
 */
@extension("minProperties", 2)
model Step {
  /**
   * Step type.
   */
  type?: StepType = StepType.Inline;

  /**
   * Step description.
   */
  @maxLength(64)
  @minLength(1)
  description?: string;

  /**
   * Identity of handler that will execute this step. Required if step type is
   * inline.
   */
  @maxLength(32)
  @minLength(1)
  handler?: string;

  /**
   * Parameters to be passed to handler during execution.
   */
  handlerProperties?: Record<unknown>;

  /**
   * Collection of file names to be passed to handler during execution. Required if
   * step type is inline.
   */
  @minItems(1)
  @maxItems(5)
  files?: string[];

  /**
   * Referenced child update identity.  Required if step type is reference.
   */
  updateId?: UpdateId;
}

/**
 * Common error response.
 */
@error
model ErrorResponse {
  /**
   * The error details.
   */
  error: Error;
}

/**
 * Error details.
 */
model Error {
  /**
   * Server defined error code.
   */
  code: string;

  /**
   * A human-readable representation of the error.
   */
  message: string;

  /**
   * The target of the error.
   */
  target?: string;

  /**
   * An array of errors that led to the reported error.
   */
  details?: Error[];

  /**
   * An object containing more specific information than the current object about
   * the error.
   */
  innererror?: InnerError;

  /**
   * Date and time in UTC when the error occurred.
   */
  occurredDateTime?: utcDateTime;
}

/**
 * An object containing more specific information than the current object about
 * the error.
 */
model InnerError {
  /**
   * A more specific error code than what was provided by the containing error.
   */
  code: string;

  /**
   * A human-readable representation of the error.
   */
  message?: string;

  /**
   * The internal error or exception message.
   */
  errorDetail?: string;

  /**
   * An object containing more specific information than the current object about
   * the error.
   */
  innerError?: InnerError;
}

/**
 * Update input data list (array of update items to import).
 */
@minItems(1)
@maxItems(11)
model ImportUpdateInput is ImportUpdateInputItem[];

/**
 * Import update input item metadata.
 */
model ImportUpdateInputItem {
  /**
   * Import manifest metadata like source URL, file size/hashes, etc.
   */
  importManifest: ImportManifestMetadata;

  /**
   * Friendly update name.
   */
  @maxLength(512)
  @minLength(1)
  friendlyName?: string;

  /**
   * One or more update file properties like filename and source URL.
   */
  @minItems(1)
  @maxItems(5)
  files?: FileImportMetadata[];
}

/**
 * Metadata describing the import manifest, a document which describes the files
 * and other metadata about an update version.
 */
model ImportManifestMetadata {
  /**
   * Azure Blob location from which the import manifest can be downloaded by Device
   * Update for IoT Hub. This is typically a read-only SAS-protected blob URL with
   * an expiration set to at least 4 hours.
   */
  url: string;

  /**
   * File size in number of bytes.
   */
  sizeInBytes: int64;

  /**
   * A JSON object containing the hash(es) of the file. At least SHA256 hash is
   * required. This object can be thought of as a set of key-value pairs where the
   * key is the hash algorithm, and the value is the hash of the file calculated
   * using that algorithm.
   */
  @extension("minProperties", 1)
  hashes: Record<string>;
}

/**
 * Metadata describing an update file.
 */
model FileImportMetadata {
  /**
   * Update file name as specified inside import manifest.
   */
  filename: string;

  /**
   * Azure Blob location from which the update file can be downloaded by Device
   * Update for IoT Hub. This is typically a read-only SAS-protected blob URL with
   * an expiration set to at least 4 hours.
   */
  url: string;
}

/**
 * The list of strings with server paging support.
 */
model StringsList {
  /** The collection of pageable items. */
  @pageItems value: string[];

  /** The link to the next page of items. */
  @nextLink nextLink?: string;
}

/**
 * Update file metadata.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model UpdateFile extends UpdateFileBase {
  /**
   * File identity, generated by server at import time.
   */
  fileId: string;

  /**
   * Optional related files metadata used together DownloadHandler metadata to
   * download payload file.
   */
  relatedFiles?: UpdateFileBase[];

  /**
   * Optional download handler for utilizing related files to download payload file.
   */
  downloadHandler?: UpdateFileDownloadHandler;

  /**
   * File ETag.
   */
  etag?: string;
}

/**
 * Update file basic metadata.
 */
model UpdateFileBase {
  /**
   * File name.
   */
  fileName: string;

  /**
   * File size in number of bytes.
   */
  sizeInBytes: int64;

  /**
   * Mapping of hashing algorithm to base64 encoded hash values.
   */
  @extension("minProperties", 1)
  hashes: Record<string>;

  /**
   * File MIME type.
   */
  mimeType?: string;

  /**
   * Anti-malware scan result.
   */
  scanResult?: string;

  /**
   * Anti-malware scan details.
   */
  scanDetails?: string;

  /**
   * Optional file properties (not consumed by service but pass-through to device).
   */
  properties?: Record<string>;
}

/**
 * Download handler for utilizing related files to download payload file.
 */
model UpdateFileDownloadHandler {
  /**
   * Download handler identifier.
   */
  id: string;
}

/**
 * The list of operations with server paging support.
 */
model UpdateOperationsList is Azure.Core.Page<UpdateOperation>;

/**
 * Operation metadata.
 */
model UpdateOperation {
  /**
   * Operation Id.
   */
  operationId: string;

  /**
   * Operation status.
   */
  status: OperationStatus;

  /**
   * The update being imported or deleted. For import, this property will only be
   * populated after import manifest is processed successfully.
   */
  update?: UpdateInfo;

  /**
   * Location of the imported update when operation is successful.
   */
  resourceLocation?: string;

  /**
   * Operation error encountered, if any.
   */
  error?: Error;

  /**
   * Operation correlation identity that can used by Microsoft Support for
   * troubleshooting.
   */
  traceId?: string;

  /**
   * Date and time in UTC when the operation status was last updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActionDateTime: utcDateTime;

  /**
   * Date and time in UTC when the operation was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime: utcDateTime;

  /**
   * Operation ETag.
   */
  etag?: string;
}

/**
 * Update information.
 */
model UpdateInfo {
  /**
   * Update identifier.
   */
  updateId: UpdateId;

  /**
   * Update description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Friendly update name.
   */
  @visibility(Lifecycle.Read)
  friendlyName?: string;
}

/**
 * The list of device classes.
 */
model DeviceClassesList is Azure.Core.Page<DeviceClass>;

/**
 * Device class metadata.
 */
model DeviceClass {
  /**
   * The device class identifier. This is generated from the model Id and the compat
   * properties reported by the device update agent in the Device Update PnP
   * interface in IoT Hub. It is a hex-encoded SHA1 hash.
   */
  deviceClassId: string;

  /**
   * The device class friendly name. This can be updated by callers after the device
   * class has been automatically created.
   */
  friendlyName?: string;

  /**
   * The device class properties that are used to calculate the device class Id
   */
  deviceClassProperties: DeviceClassProperties;

  /**
   * Update that is the highest version compatible with this device class.
   */
  bestCompatibleUpdate?: UpdateInfo;
}

/**
 * The device class properties that are used to calculate the device class Id
 */
model DeviceClassProperties {
  /**
   * The Device Update agent contract model.
   */
  contractModel?: ContractModel;

  /**
   * The compat properties of the device class. This object can be thought of as a
   * set of key-value pairs where the key is the name of the compatibility property
   * and the value is the value of the compatibility property. There will always be
   * at least 1 compat property
   */
  compatProperties: Record<string>;
}

/**
 * The Device Update agent contract model.
 */
model ContractModel {
  /**
   * The Device Update agent contract model Id of the device class. This is also
   * used to calculate the device class Id.
   */
  id: string;

  /**
   * The Device Update agent contract model name of the device class. Intended to be
   * a more readable form of the contract model Id.
   */
  name: string;
}

/**
 * Device Class JSON Merge Patch request body
 */
model PatchBody {
  /**
   * The device class friendly name. Friendly name can be 1-100 characters,
   * alphanumeric, dot, and dash.
   */
  friendlyName: string;
}

/**
 * List of update information.
 */
model UpdateInfoList is Azure.Core.Page<UpdateInfo>;

/**
 * The list of devices.
 */
model DevicesList is Azure.Core.Page<Device>;

/**
 * Device metadata.
 */
model Device {
  /**
   * Device identity.
   */
  deviceId: string;

  /**
   * Device module identity.
   */
  moduleId?: string;

  /**
   * Device class identity.
   */
  deviceClassId: string;

  /**
   * Device group identity.
   */
  groupId?: string;

  /**
   * The update that device last attempted to install.
   */
  lastAttemptedUpdate?: UpdateInfo;

  /**
   * State of the device in its last deployment.
   */
  deploymentStatus?: DeviceDeploymentState;

  /**
   * Currently installed update on device.
   */
  installedUpdate?: UpdateInfo;

  /**
   * Boolean flag indicating whether the latest update (the best compatible update
   * for the device's device class and group) is installed on the device
   */
  onLatestUpdate: boolean;

  /**
   * The deployment identifier for the last deployment to the device
   */
  lastDeploymentId?: string;

  /**
   * Last install result.
   */
  lastInstallResult?: InstallResult;
}

/**
 * The install result of an update and any step results under it.
 */
model InstallResult {
  /**
   * Install result code.
   */
  resultCode: int32;

  /**
   * Install extended result code
   */
  extendedResultCode: int32;

  /**
   * A string containing further details about the install result
   */
  resultDetails?: string;

  /**
   * Array of step results
   */
  stepResults?: StepResult[];
}

/**
 * The step result under an update.
 */
model StepResult {
  /**
   * The update that this step installs if it is of reference type.
   */
  update?: UpdateInfo;

  /**
   * Step description.
   */
  description?: string;

  /**
   * Install result code.
   */
  resultCode: int32;

  /**
   * Install extended result code
   */
  extendedResultCode: int32;

  /**
   * A string containing further details about the install result
   */
  resultDetails?: string;
}

/**
 * Update compliance information.
 */
model UpdateCompliance {
  /**
   * Total number of devices.
   */
  totalDeviceCount: int32;

  /**
   * Number of devices on the latest update.
   */
  onLatestUpdateDeviceCount: int32;

  /**
   * Number of devices with a newer update available.
   */
  newUpdatesAvailableDeviceCount: int32;

  /**
   * Number of devices with update in-progress.
   */
  updatesInProgressDeviceCount: int32;
}

/**
 * The list of groups.
 */
model GroupsList is Azure.Core.Page<Group>;

/**
 * Group details.
 */
model Group {
  /**
   * Group identity. This is created from the value of the ADUGroup tag in the Iot
   * Hub's device/module twin or $default for devices with no tag.
   */
  groupId: string;

  /**
   * Group type.
   */
  groupType: GroupType;

  /**
   * Date and time when the update was created.
   */
  createdDateTime: string;

  /**
   * The number of devices in the group.
   */
  deviceCount?: int32;

  /**
   * The count of subgroups with new updates available.
   */
  subgroupsWithNewUpdatesAvailableCount?: int32;

  /**
   * The count of subgroups with updates in progress.
   */
  subgroupsWithUpdatesInProgressCount?: int32;

  /**
   * The count of subgroups with devices on the latest update.
   */
  subgroupsWithOnLatestUpdateCount?: int32;

  /**
   * The active deployment Ids for the group
   */
  deployments?: string[];
}

/**
 * The list of updatable devices for a device class subgroup.
 */
model DeviceClassSubgroupUpdatableDevicesList
  is Azure.Core.Page<DeviceClassSubgroupUpdatableDevices>;

/**
 * Device class subgroup, update information, and the number of devices for which
 * the update is applicable.
 */
model DeviceClassSubgroupUpdatableDevices {
  /**
   * The group Id
   */
  groupId: string;

  /**
   * The device class subgroup's device class Id
   */
  deviceClassId: string;

  /**
   * Update information.
   */
  update: UpdateInfo;

  /**
   * Total number of devices for which the update is applicable.
   */
  deviceCount: int32;
}

/**
 * The list of deployments.
 */
model DeploymentsList is Azure.Core.Page<Deployment>;

/**
 * Deployment metadata.
 */
model Deployment {
  /**
   * The caller-provided deployment identifier. This cannot be longer than 73
   * characters, must be all lower-case, and cannot contain '&', '^', '[', ']', '{',
   * '}', '|', '<', '>', forward slash, backslash, or double quote. The Updates view
   * in the Azure Portal IoT Hub resource generates a GUID for deploymentId when you
   * create a deployment.
   */
  deploymentId: string;

  /**
   * The deployment start datetime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime: utcDateTime;

  /**
   * Update information for the update in the deployment.
   */
  update: UpdateInfo;

  /**
   * The group identity for the devices the deployment is intended to update.
   */
  groupId: string;

  /**
   * The device class subgroups the deployment is compatible with and subgroup
   * deployments have been created for. This is not provided by the caller during
   * CreateOrUpdateDeployment but is automatically determined by Device Update
   */
  deviceClassSubgroups?: string[];

  /**
   * Boolean flag indicating whether the deployment was canceled.
   */
  isCanceled?: boolean;

  /**
   * Boolean flag indicating whether the deployment has been retried.
   */
  isRetried?: boolean;

  /**
   * The rollback policy for the deployment.
   */
  rollbackPolicy?: CloudInitiatedRollbackPolicy;

  /**
   * Boolean flag indicating whether the deployment is a rollback deployment.
   */
  isCloudInitiatedRollback?: boolean;
}

/**
 * Rollback policy for deployment
 */
model CloudInitiatedRollbackPolicy {
  /**
   * Update to rollback to.
   */
  update: UpdateInfo;

  /**
   * Failure conditions to initiate rollback policy.
   */
  failure: CloudInitiatedRollbackPolicyFailure;
}

/**
 * Failure conditions to initiate rollback policy
 */
model CloudInitiatedRollbackPolicyFailure {
  /**
   * Percentage of devices that failed.
   */
  devicesFailedPercentage: int32;

  /**
   * Number of devices that failed.
   */
  devicesFailedCount: int32;
}

/**
 * Deployment status metadata.
 */
model DeploymentStatus {
  /**
   * The group identity
   */
  groupId: string;

  /**
   * The state of the deployment.
   */
  deploymentState: DeploymentState;

  /**
   * The error details of the Failed state.  This is not present if the deployment
   * state is not Failed.
   */
  error?: Error;

  /**
   * The collection of device class subgroup status objects
   */
  subgroupStatus: DeviceClassSubgroupDeploymentStatus[];
}

/**
 * Device class subgroup deployment status metadata.
 */
model DeviceClassSubgroupDeploymentStatus {
  /**
   * The group identity
   */
  groupId: string;

  /**
   * The device class subgroup identity
   */
  deviceClassId: string;

  /**
   * The state of the subgroup deployment.
   */
  deploymentState: DeviceClassSubgroupDeploymentState;

  /**
   * The error details of the Failed state.  This is not present if the deployment
   * state is not Failed.
   */
  error?: Error;

  /**
   * The total number of devices in the deployment.
   */
  totalDevices?: int32;

  /**
   * The number of devices that are currently in deployment.
   */
  devicesInProgressCount?: int32;

  /**
   * The number of devices that have completed deployment with a failure.
   */
  devicesCompletedFailedCount?: int32;

  /**
   * The number of devices which have successfully completed deployment.
   */
  devicesCompletedSucceededCount?: int32;

  /**
   * The number of devices which have had their deployment canceled.
   */
  devicesCanceledCount?: int32;
}

/**
 * The list of device class subgroups within a group.
 */
model DeviceClassSubgroupsList is Azure.Core.Page<DeviceClassSubgroup>;

/**
 * Device class subgroup details. A device class subgroup is a subset of devices
 * in a group that share the same device class id.
 */
model DeviceClassSubgroup {
  /**
   * Device class subgroup identity. This is generated from the model Id and the
   * compat properties reported by the device update agent in the Device Update PnP
   * interface in IoT Hub. It is a hex-encoded SHA1 hash.
   */
  deviceClassId: string;

  /**
   * Group identity.
   */
  groupId: string;

  /**
   * Date and time when the device class subgroup was created.
   */
  createdDateTime: string;

  /**
   * The number of devices in the device class subgroup.
   */
  deviceCount?: int32;

  /**
   * The active deployment Id for the device class subgroup.
   */
  deploymentId?: string;
}

/**
 * The list of deployment device states.
 */
model DeploymentDeviceStatesList is Azure.Core.Page<DeploymentDeviceState>;

/**
 * Deployment device status.
 */
model DeploymentDeviceState {
  /**
   * Device identity.
   */
  deviceId: string;

  /**
   * Device module identity.
   */
  moduleId?: string;

  /**
   * The number of times this deployment has been retried on this device.
   */
  retryCount: int32;

  /**
   * Boolean flag indicating whether this device is in a newer deployment and can no
   * longer retry this deployment.
   */
  movedOnToNewDeployment: boolean;

  /**
   * Deployment device state.
   */
  deviceState: DeviceDeploymentState;
}

/**
 * Operation metadata.
 */
model DeviceOperation {
  /**
   * Operation Id.
   */
  operationId: string;

  /**
   * Operation status.
   */
  status: OperationStatus;

  /**
   * Operation error encountered, if any.
   */
  error?: Error;

  /**
   * Operation correlation identity that can used by Microsoft Support for
   * troubleshooting.
   */
  traceId?: string;

  /**
   * Date and time in UTC when the operation status was last updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActionDateTime: utcDateTime;

  /**
   * Date and time in UTC when the operation was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime: utcDateTime;

  /**
   * Operation ETag.
   */
  etag?: string;
}

/**
 * The list of device operations with server paging support.
 */
model DeviceOperationsList is Azure.Core.Page<DeviceOperation>;

/**
 * Diagnostics request body
 */
model LogCollection {
  /**
   * The log collection id.
   */
  @extension("x-ms-client-name", "logCollectionId")
  operationId?: string;

  /**
   * Array of Device Update agent ids
   */
  deviceList: DeviceUpdateAgentId[];

  /**
   * Description of the diagnostics operation.
   */
  @maxLength(512)
  description?: string;

  /**
   * The timestamp when the operation was created.
   */
  @visibility(Lifecycle.Read)
  createdDateTime?: string;

  /**
   * A timestamp for when the current state was entered.
   */
  @visibility(Lifecycle.Read)
  lastActionDateTime?: string;

  /**
   * Operation status.
   */
  @visibility(Lifecycle.Read)
  status?: OperationStatus;
}

/**
 * Device Update agent id
 */
model DeviceUpdateAgentId {
  /**
   * Device Id
   */
  deviceId: string;

  /**
   * Module Id
   */
  moduleId?: string;
}

/**
 * The list of log collections with server paging support.
 */
model LogCollectionList is Azure.Core.Page<LogCollection>;

/**
 * Device diagnostics operation detailed status
 */
model LogCollectionOperationDetailedStatus {
  /**
   * The device diagnostics operation id.
   */
  @extension("x-ms-client-name", "logCollectionId")
  operationId?: string;

  /**
   * The timestamp when the operation was created.
   */
  createdDateTime?: string;

  /**
   * A timestamp for when the current state was entered.
   */
  lastActionDateTime?: string;

  /**
   * Operation status.
   */
  status?: OperationStatus;

  /**
   * Status of the devices in the operation
   */
  deviceStatus?: LogCollectionOperationDeviceStatus[];

  /**
   * Device diagnostics operation description.
   */
  description?: string;
}

/**
 * Diagnostics operation device status
 */
model LogCollectionOperationDeviceStatus {
  /**
   * Device id
   */
  deviceId: string;

  /**
   * Module id.
   */
  moduleId?: string;

  /**
   * Log upload status
   */
  status: OperationStatus;

  /**
   * Log upload result code
   */
  resultCode?: string;

  /**
   * Log upload extended result code
   */
  extendedResultCode?: string;

  /**
   * Log upload location
   */
  logLocation?: string;
}

/**
 * Array of Device Health, with server paging support.
 */
model DeviceHealthList is Azure.Core.Page<DeviceHealth>;

/**
 * Device Health
 */
model DeviceHealth {
  /**
   * Device id
   */
  deviceId: string;

  /**
   * Module id
   */
  moduleId?: string;

  /**
   * Aggregate device health state
   */
  state: DeviceHealthState;

  /**
   * Digital twin model Id
   */
  digitalTwinModelId?: string;

  /**
   * Array of health checks and their results
   */
  healthChecks: HealthCheck[];
}

/**
 * Health check
 */
model HealthCheck {
  /**
   * Health check name
   */
  name?: string;

  /**
   * Health check result
   */
  result?: HealthCheckResult;
}

/**
 * Device filter.
 */
model DeviceFilter {
  /**
   * Device group identity.
   */
  groupId?: string;

  /**
   * Device class identity.
   */
  deviceClassId?: string;

  /**
   * State of the device in its last deployment.
   */
  deploymentStatus?: DeviceDeploymentState;
}

/**
 * Device class subgroups filter. Filters device class subgroups based on device
 * class compat property names and values
 */
model DeviceClassSubgroupFilter {
  /**
   * The name of the compat property to use in the filter. E.g.
   * compatProperties/manufacturer
   */
  compatPropertyName?: string;

  /**
   * The value the compat property to use in the filter. E.g. Contoso
   */
  compatPropertyValue?: string;
}

/**
 * Device class filter. Filters device classes based on device class friendly name
 */
model DeviceClassFilter {
  /**
   * The friendly name of the device class to use in the filter
   */
  friendlyName?: string;
}

/**
 * Update filter.
 */
model UpdateFilter {
  /**
   * Update isDeployable property.
   */
  isDeployable?: boolean;
}

/**
 * Operation status filter.
 */
model OperationFilter {
  /**
   * Operation status filter.
   */
  status?: OperationFilterStatus;
}

/**
 * Groups order by.
 */
model GroupOrderBy {
  /**
   * The group Id.
   */
  groupId?: string;

  /**
   * The group device count.
   */
  deviceCount?: string;

  /**
   * The group created date.
   */
  createdDate?: string;

  /**
   * The number of subgroups with new updates available
   */
  subgroupsWithNewUpdatesAvailableCount?: string;

  /**
   * The number of subgroups with updates in progress
   */
  subgroupsWithUpdatesInProgressCount?: string;

  /**
   * The number of subgroups with devices on the latest update
   */
  subgroupsOnLatestUpdateCount?: string;
}

/**
 * Deployment order by.
 */
model DeploymentOrderBy {
  /**
   * The deployment start datetime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;
}

/**
 * Deployment device state filter.
 */
model DeploymentDeviceStatesFilter {
  /**
   * Device Identifier.
   */
  deviceId?: string;

  /**
   * Device module Identifier.
   */
  moduleId?: string;

  /**
   * The deployment device state.
   */
  deviceState?: DeviceDeploymentState;
}

/**
 * The list of log collections with detailed status, with server paging support.
 */
model LogCollectionDetailedStatusList
  is Azure.Core.Page<LogCollectionOperationDetailedStatus>;

/**
 * Device health filter.
 */
model DeviceHealthFilter {
  /**
   * Device health state
   */
  state?: DeviceHealthState;

  /**
   * Device Id
   */
  deviceId?: string;

  /**
   * Module Id
   */
  moduleId?: string;
}
