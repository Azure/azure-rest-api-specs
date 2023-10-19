import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.DeviceUpdate;

/** Step type */
enum StepType {
  /** Step type that performs code execution. */
  Inline,

  /** Step type that installs another update. */
  Reference,
}

/** Operation status */
enum OperationStatus {
  /** Background operation created but not started yet. */
  NotStarted,

  /** Background operation is currently running. */
  Running,

  /** Background operation finished with success. */
  Succeeded,

  /** Background operation finished with failure. */
  Failed,
}

/** Device deployement state */
enum DeviceDeploymentState {
  /** Deployment has completed with success. */
  Succeeded,

  /** Deployment is in progress. */
  InProgress,

  /** Deployment was canceled. */
  Canceled,

  /** Deployment has completed with failure. */
  Failed,
}

/** Import type */
enum ImportType {
  /** Import only devices but not modules. */
  Devices,

  /** Import only modules but not devices. */
  Modules,

  /** Import both devices and modules. */
  All,
}

/** Group type */
enum GroupType {
  /** IoT Hub tag based group, all devices in the group share an ADUGroup tag value. */
  IoTHubTag,

  /** Default group for untagged devices. */
  DefaultNoTag,
}

/** Deployment state */
enum DeploymentState {
  /** The deployment can be sent to devices targeted in the deployment. */
  Active,

  /**
   * The deployment can be sent to some devices targeted in the deployment but at least 1 subgroup is in a failed state.
   */
  ActiveWithSubgroupFailures,

  /**
   * The deployment will not be sent to any devices.  Consult error for more details about what failed.
   */
  Failed,

  /**
   * A newer deployment for this group has been created and no devices in the group will receive this deployment.
   */
  Inactive,

  /** The deployment has been canceled and no devices will receive it. */
  Canceled,
}

enum DeviceClassSubgroupDeploymentState {
  /** The subgroup deployment can be sent to devices targeted in the deployment. */
  Active,

  /** The subgroup deployment failed and will not be sent to any devices. */
  Failed,

  /**
   * A newer deployment for this subgroup has been created and no devices in the subgroup will receive this deployment.
   */
  Inactive,

  /** The subgroup deployment has been canceled and no devices will receive it. */
  Canceled,
}

/** Device health state */
enum DeviceHealthState {
  /** Agent is healthy */
  healthy,

  /** Agent is in an unhealthy state */
  unhealthy,
}

/** Health check result */
enum HealthCheckResult {
  /** Health check succeeded */
  success,

  /** Health check failed due to user error */
  userError,
}

/**
 * Operation filter status
 */
enum OperationFilterStatus {
  /** Running */
  Running,

  /** Not started */
  NotStarted,
}

// TODO virtual resource?
/** The Device Update for IoT Hub account instance. */
@resource("deviceUpdate")
model Instance {
  /** The Device Update for IoT Hub account instance identifier. */
  @key
  @visibility("read")
  instanceId: string;
}

/** The list of updates. */
model UpdateList is Azure.Core.Page<Update>;

/** Update metadata. */
model Update {
  /** Update identity. */
  updateId: UpdateId;

  /** Update description specified by creator. */
  description?: string;

  /** Friendly update name specified by importer. */
  friendlyName?: string;

  /** Whether the update can be deployed to a device on its own. */
  isDeployable?: boolean;

  /** Update type. Deprecated in latest import manifest schema. */
  updateType?: string;

  /**
   * String interpreted by Device Update client to determine if the update is
   * installed on the device. Deprecated in latest import manifest schema.
   */
  installedCriteria?: string;

  /** List of update compatibility information. */
  compatibility: Record<string>[];

  /** Update install instructions. */
  instructions?: Instructions;

  /** List of update identities that reference this update. */
  referencedBy?: UpdateId[];

  /** Update aggregate scan result (calculated from payload file scan results). */
  scanResult?: string;

  /** Schema version of manifest used to import the update. */
  manifestVersion: string;

  /** Date and time in UTC when the update was imported. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  importedDateTime: utcDateTime;

  /** Date and time in UTC when the update was created. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime: utcDateTime;

  /** Update ETag. */
  etag?: string;
}

/** Update identifier. */
model UpdateId {
  /** Update provider. */
  provider: string;

  /** Update name. */
  name: string;

  /** Update version. */
  version: string;
}

model Instructions {
  /** Collection of installation steps. */
  steps: Step[];
}

/** Update install instruction step. */
model Step {
  /** Step type. */
  type?: StepType;

  /** Step description. */
  description?: string;

  @doc("""
Identity of handler that will execute this step. Required if step type is
inline.
""")
  handler?: string;

  /** Parameters to be passed to handler during execution. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Properties can be anything"
  handlerProperties?: Record<unknown>;

  @doc("""
Collection of file names to be passed to handler during execution. Required if
step type is inline.
""")
  files?: string[];

  /** Referenced child update identity.  Required if step type is reference. */
  updateId?: UpdateId;
}

/** Common error response. */
@error
model ErrorResponse {
  /** The error details. */
  error: Error;
}

/** Error details. */
model Error {
  /** Server defined error code. */
  code: string;

  /** A human-readable representation of the error. */
  message: string;

  /** The target of the error. */
  target?: string;

  /** An array of errors that led to the reported error. */
  details?: Error[];

  @doc("""
An object containing more specific information than the current object about
the error.
""")
  innererror?: InnerError;

  /** Date and time in UTC when the error occurred. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  occurredDateTime?: utcDateTime;
}

@doc("""
An object containing more specific information than the current object about
the error.
""")
model InnerError {
  /** A more specific error code than what was provided by the containing error. */
  code: string;

  /** A human-readable representation of the error. */
  message?: string;

  /** The internal error or exception message. */
  errorDetail?: string;

  @doc("""
An object containing more specific information than the current object about
the error.
""")
  innerError?: InnerError;
}

/** Import update input item metadata. */
model ImportUpdateInputItem {
  /** Import manifest metadata like source URL, file size/hashes, etc. */
  importManifest: ImportManifestMetadata;

  /** Friendly update name. */
  friendlyName?: string;

  /** One or more update file properties like filename and source URL. */
  files?: FileImportMetadata[];
}

/** Import update input metadata. */
@minItems(1)
@maxItems(11)
model ImportUpdateInput is ImportUpdateInputItem[];

@doc("""
Metadata describing the import manifest, a document which describes the files
and other metadata about an update version.
""")
model ImportManifestMetadata {
  @doc("""
Azure Blob location from which the import manifest can be downloaded by Device
Update for IoT Hub. This is typically a read-only SAS-protected blob URL with
an expiration set to at least 4 hours.
""")
  url: string;

  /** File size in number of bytes. */
  sizeInBytes: int32;

  @doc("""
A JSON object containing the hash(es) of the file. At least SHA256 hash is
required. This object can be thought of as a set of key-value pairs where the
key is the hash algorithm, and the value is the hash of the file calculated
using that algorithm.
""")
  hashes: Record<string>;
}

/** Metadata describing an update file. */
model FileImportMetadata {
  /** Update file name as specified inside import manifest. */
  filename: string;

  @doc("""
Azure Blob location from which the update file can be downloaded by Device
Update for IoT Hub. This is typically a read-only SAS-protected blob URL with
an expiration set to at least 4 hours.
""")
  url: string;
}

/**
 * The list of strings with server paging support.
 */
@Azure.Core.pagedResult
model StringsList {
  /** The collection of pageable items. */
  @Azure.Core.items
  value: string[];

  /** The link to the next page of items */
  @Azure.Core.nextLink
  nextLink?: string;
}

/** Update file metadata. */
model UpdateFile {
  ...UpdateFileBase;

  /** File identity, generated by server at import time. */
  fileId: string;

  @doc("""
Optional related files metadata used together DownloadHandler metadata to
download payload file.
""")
  relatedFiles?: UpdateFileBase[];

  /** Optional download handler for utilizing related files to download payload file. */
  downloadHandler?: UpdateFileDownloadHandler;

  /** File ETag. */
  etag?: string;
}

/** Update file basic metadata. */
model UpdateFileBase {
  /** File name. */
  fileName: string;

  /** File size in number of bytes. */
  sizeInBytes: int32;

  /** Mapping of hashing algorithm to base64 encoded hash values. */
  hashes: Record<string>;

  /** File MIME type. */
  mimeType?: string;

  /** Anti-malware scan result. */
  scanResult?: string;

  /** Anti-malware scan details. */
  scanDetails?: string;

  /** Optional file properties (not consumed by service but pass-through to device). */
  properties?: Record<string>;
}

/** Download handler for utilizing related files to download payload file. */
model UpdateFileDownloadHandler {
  /** Download handler identifier. */
  id: string;
}

/** The list of operations with server paging support. */
model UpdateOperationsList is Azure.Core.Page<UpdateOperation>;

/** Operation metadata. */
model UpdateOperation {
  /** Operation Id. */
  operationId: string;

  /** Operation status. */
  status: OperationStatus;

  @doc("""
The update being imported or deleted. For import, this property will only be
populated after import manifest is processed successfully.
""")
  update?: UpdateInfo;

  /** Location of the imported update when operation is successful. */
  resourceLocation?: string;

  /** Operation error encountered, if any. */
  error?: Error;

  @doc("""
Operation correlation identity that can used by Microsoft Support for
troubleshooting.
""")
  traceId?: string;

  /** Date and time in UTC when the operation status was last updated. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActionDateTime: utcDateTime;

  /** Date and time in UTC when the operation was created. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime: utcDateTime;

  /** Operation ETag. */
  etag?: string;
}

/** Update information. */
model UpdateInfo {
  /** Update identifier. */
  updateId: UpdateId;

  /** Update description. */
  @visibility("read")
  description?: string;

  /** Friendly update name. */
  @visibility("read")
  friendlyName?: string;
}

/** The list of device classes. */
model DeviceClassesList is Azure.Core.Page<DeviceClass>;

/** Device class metadata. */
model DeviceClass {
  @doc("""
The device class identifier. This is generated from the model Id and the compat
properties reported by the device update agent in the Device Update PnP
interface in IoT Hub. It is a hex-encoded SHA1 hash.
""")
  deviceClassId: string;

  @doc("""
The device class friendly name. This can be updated by callers after the device
class has been automatically created.
""")
  friendlyName?: string;

  /** The device class properties that are used to calculate the device class Id */
  deviceClassProperties: DeviceClassProperties;

  /** Update that is the highest version compatible with this device class. */
  bestCompatibleUpdate?: UpdateInfo;
}

/** The device class properties that are used to calculate the device class Id */
model DeviceClassProperties {
  /** The Device Update agent contract model. */
  contractModel?: ContractModel;

  @doc("""
The compat properties of the device class. This object can be thought of as a
set of key-value pairs where the key is the name of the compatibility property
and the value is the value of the compatibility property. There will always be
at least 1 compat property
""")
  compatProperties: Record<string>;
}

/** The Device Update agent contract model. */
model ContractModel {
  @doc("""
The Device Update agent contract model Id of the device class. This is also
used to calculate the device class Id.
""")
  id: string;

  @doc("""
The Device Update agent contract model name of the device class. Intended to be
a more readable form of the contract model Id.
""")
  name: string;
}

/** Device Class JSON Merge Patch request body */
model PatchBody {
  @doc("""
The device class friendly name. Friendly name can be 1-100 characters,
alphanumeric, dot, and dash.
""")
  friendlyName: string;
}

/** List of update information. */
model UpdateInfoList is Azure.Core.Page<UpdateInfo>;

/** The list of devices. */
model DevicesList is Azure.Core.Page<Device>;

/** Device metadata. */
model Device {
  /** Device identity. */
  deviceId: string;

  /** Device module identity. */
  moduleId?: string;

  /** Device class identity. */
  deviceClassId: string;

  /** Device group identity. */
  groupId?: string;

  /** The update that device last attempted to install. */
  lastAttemptedUpdate?: UpdateInfo;

  /** State of the device in its last deployment. */
  deploymentStatus?: DeviceDeploymentState;

  /** Currently installed update on device. */
  installedUpdate?: UpdateInfo;

  @doc("""
Boolean flag indicating whether the latest update (the best compatible update
for the device's device class and group) is installed on the device
""")
  onLatestUpdate: boolean;

  /** The deployment identifier for the last deployment to the device */
  lastDeploymentId?: string;

  /** Last install result. */
  lastInstallResult?: InstallResult;
}

/** The install result of an update and any step results under it. */
model InstallResult {
  /** Install result code. */
  resultCode: int32;

  /** Install extended result code */
  extendedResultCode: int32;

  /** A string containing further details about the install result */
  resultDetails?: string;

  /** Array of step results */
  stepResults?: StepResult[];
}

/** The step result under an update. */
model StepResult {
  /** The update that this step installs if it is of reference type. */
  update?: UpdateInfo;

  /** Step description. */
  description?: string;

  /** Install result code. */
  resultCode: int32;

  /** Install extended result code */
  extendedResultCode: int32;

  /** A string containing further details about the install result */
  resultDetails?: string;
}

/** Update compliance information. */
model UpdateCompliance {
  /** Total number of devices. */
  totalDeviceCount: int32;

  /** Number of devices on the latest update. */
  onLatestUpdateDeviceCount: int32;

  /** Number of devices with a newer update available. */
  newUpdatesAvailableDeviceCount: int32;

  /** Number of devices with update in-progress. */
  updatesInProgressDeviceCount: int32;
}

/**
 * The list of limits of how many of each resource are currently in use and how
 * many are allowed.
 */
model LimitsResponse {
  @doc("""
The list of current counts of each limited resource and the maximum quota that
are allowed.
""")
  counters?: Counters;
}

@doc("""
The list of counts of each limited resource with both current usage and overall
quota.
""")
model Counters {
  /** The current usage and quota of devices. */
  deviceCount?: UsageQuotaCounter;

  /** The current usage and quota of device classes. */
  deviceClassCount?: UsageQuotaCounter;

  /** The current usage and quota of device groups. */
  deviceGroupCount?: UsageQuotaCounter;

  /** The current usage and quota of active deployments. */
  activeDeploymentCount?: UsageQuotaCounter;

  /** The current usage and quota of deployments. */
  deploymentCount?: UsageQuotaCounter;
}

/** A counter with both usage and quota information. */
model UsageQuotaCounter {
  /** The current number of the resource that exist */
  usage?: int32;

  /** The maximum number of the resource that can be created */
  quota?: int32;
}

/** Group details. */
@resource("management/groups")
@parentResource(Instance)
model Group {
  /**
   * Group identity. This is created from the value of the ADUGroup tag in the Iot
   * Hub's device/module twin or $default for devices with no tag.
   */
  @key
  @path
  @visibility("read")
  groupId: string;

  /** Group type. */
  groupType: GroupType;

  /** Date and time when the update was created. */
  createdDateTime: string;

  /** The number of devices in the group. */
  deviceCount?: int32;

  /** The count of subgroups with new updates available. */
  subgroupsWithNewUpdatesAvailableCount?: int32;

  /** The count of subgroups with updates in progress. */
  subgroupsWithUpdatesInProgressCount?: int32;

  /** The count of subgroups with devices on the latest update. */
  subgroupsWithOnLatestUpdateCount?: int32;

  /** The active deployment Ids for the group */
  deployments?: string[];
}

/** The list of updatable devices for a device class subgroup. */
model DeviceClassSubgroupUpdatableDevicesList
  is Azure.Core.Page<DeviceClassSubgroupUpdatableDevices>;

@doc("""
Device class subgroup, update information, and the number of devices for which
the update is applicable.
""")
model DeviceClassSubgroupUpdatableDevices {
  /** The group Id */
  groupId: string;

  /** The device class subgroup's device class Id */
  deviceClassId: string;

  /** Update information. */
  update: UpdateInfo;

  /** Total number of devices for which the update is applicable. */
  deviceCount: int32;
}

/** The list of deployments. */
model DeploymentsList is Azure.Core.Page<Deployment>;

/** Deployment metadata. */
model Deployment {
  @doc("""
The caller-provided deployment identifier. This cannot be longer than 73
characters, must be all lower-case, and cannot contain '&', '^', '[', ']', '{',
'}', '|', '<', '>', forward slash, backslash, or double quote. The Updates view
in the Azure Portal IoT Hub resource generates a GUID for deploymentId when you
create a deployment.
""")
  deploymentId: string;

  /** The deployment start datetime. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime: utcDateTime;

  /** Update information for the update in the deployment. */
  update: UpdateInfo;

  /** The group identity for the devices the deployment is intended to update. */
  groupId: string;

  @doc("""
The device class subgroups the deployment is compatible with and subgroup
deployments have been created for. This is not provided by the caller during
CreateOrUpdateDeployment but is automatically determined by Device Update
""")
  deviceClassSubgroups?: string[];

  /** Boolean flag indicating whether the deployment was canceled. */
  isCanceled?: boolean;

  /** Boolean flag indicating whether the deployment has been retried. */
  isRetried?: boolean;

  /** The rollback policy for the deployment. */
  rollbackPolicy?: CloudInitiatedRollbackPolicy;

  /** Boolean flag indicating whether the deployment is a rollback deployment. */
  isCloudInitiatedRollback?: boolean;
}

/** Rollback policy for deployment */
model CloudInitiatedRollbackPolicy {
  /** Update to rollback to. */
  update: UpdateInfo;

  /** Failure conditions to initiate rollback policy. */
  failure: CloudInitiatedRollbackPolicyFailure;
}

/** Failure conditions to initiate rollback policy */
model CloudInitiatedRollbackPolicyFailure {
  /** Percentage of devices that failed. */
  devicesFailedPercentage: int32;

  /** Number of devices that failed. */
  devicesFailedCount: int32;
}

/** Deployment status metadata. */
model DeploymentStatus {
  /** The group identity */
  groupId: string;

  /** The state of the deployment. */
  deploymentState: DeploymentState;

  @doc("""
The error details of the Failed state.  This is not present if the deployment
state is not Failed.
""")
  error?: Error;

  /** The collection of device class subgroup status objects */
  subgroupStatus: DeviceClassSubgroupDeploymentStatus[];
}

/** Device class subgroup deployment status metadata. */
model DeviceClassSubgroupDeploymentStatus {
  /** The group identity */
  groupId: string;

  /** The device class subgroup identity */
  deviceClassId: string;

  /** The state of the subgroup deployment. */
  deploymentState: DeviceClassSubgroupDeploymentState;

  @doc("""
The error details of the Failed state.  This is not present if the deployment
state is not Failed.
""")
  error?: Error;

  /** The total number of devices in the deployment. */
  totalDevices?: int32;

  /** The number of devices that are currently in deployment. */
  devicesInProgressCount?: int32;

  /** The number of devices that have completed deployment with a failure. */
  devicesCompletedFailedCount?: int32;

  /** The number of devices which have successfully completed deployment. */
  devicesCompletedSucceededCount?: int32;

  /** The number of devices which have had their deployment canceled. */
  devicesCanceledCount?: int32;
}

/**
 * Device class subgroup details. A device class subgroup is a subset of devices
 * in a group that share the same device class id.
 */
@resource("deviceClassSubgroups")
@parentResource(Group)
model DeviceClassSubgroup {
  /**
   * Device class subgroup identity. This is generated from the model Id and the
   * compat properties reported by the device update agent in the Device Update PnP
   * interface in IoT Hub. It is a hex-encoded SHA1 hash.
   */
  @key
  @path
  @visibility("read")
  deviceClassId: string;

  /** Group identity. */
  groupId: string;

  /** Date and time when the device class subgroup was created. */
  createdDateTime: string;

  /** The number of devices in the device class subgroup. */
  deviceCount?: int32;

  /** The active deployment Id for the device class subgroup. */
  deploymentId?: string;
}

/** The list of deployment device states. */
model DeploymentDeviceStatesList is Azure.Core.Page<DeploymentDeviceState>;

/** Deployment device status. */
model DeploymentDeviceState {
  /** Device identity. */
  deviceId: string;

  /** Device module identity. */
  moduleId?: string;

  /** The number of times this deployment has been retried on this device. */
  retryCount: int32;

  @doc("""
Boolean flag indicating whether this device is in a newer deployment and can no
longer retry this deployment.
""")
  movedOnToNewDeployment: boolean;

  /** Deployment device state. */
  deviceState: DeviceDeploymentState;
}

/** Operation metadata. */
@resource("management/operations")
@parentResource(Instance)
model DeviceOperation {
  /** Operation Id. */
  @key
  @path
  @visibility("read")
  operationId: string;

  /** Operation status. */
  status: OperationStatus;

  /** Operation error encountered, if any. */
  error?: Error;

  /**
   *  Operation correlation identity that can used by Microsoft Support for troubleshooting.
   */
  traceId?: string;

  /** Date and time in UTC when the operation status was last updated. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActionDateTime: utcDateTime;

  /** Date and time in UTC when the operation was created. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime: utcDateTime;

  /** Operation ETag. */
  etag?: string;
}

/** Diagnostics request body */
@resource("management/deviceDiagnostics/logCollections")
@parentResource(Instance)
model LogCollection {
  /** The log collection id. */
  @key
  @path
  @visibility("read")
  operationId: string;

  /** Array of Device Update agent ids */
  deviceList: DeviceUpdateAgentId[];

  /** Description of the diagnostics operation. */
  description?: string;

  /** The timestamp when the operation was created. */
  @visibility("read")
  createdDateTime?: string;

  /** A timestamp for when the current state was entered. */
  @visibility("read")
  lastActionDateTime?: string;

  /** Operation status. */
  @visibility("read")
  status?: OperationStatus;
}

/** Device Update agent id */
model DeviceUpdateAgentId {
  /** Device Id */
  deviceId: string;

  /** Module Id */
  moduleId?: string;
}

/** Device diagnostics operation detailed status */
model LogCollectionOperationDetailedStatus {
  /** The device diagnostics operation id. */
  @projectedName("json", "operationId")
  logCollectionId?: string;

  /** The timestamp when the operation was created. */
  createdDateTime?: string;

  /** A timestamp for when the current state was entered. */
  lastActionDateTime?: string;

  /** Operation status. */
  status?: OperationStatus;

  /** Status of the devices in the operation */
  deviceStatus?: LogCollectionOperationDeviceStatus[];

  /** Device diagnostics operation description. */
  description?: string;
}

/** Diagnostics operation device status */
model LogCollectionOperationDeviceStatus {
  /** Device id */
  deviceId: string;

  /** Module id. */
  moduleId?: string;

  /** Log upload status */
  status: OperationStatus;

  /** Log upload result code */
  resultCode?: string;

  /** Log upload extended result code */
  extendedResultCode?: string;

  /** Log upload location */
  logLocation?: string;
}

/** Device Health */
@resource("management/deviceDiagnostics/deviceHealth")
@parentResource(Instance)
model DeviceHealth {
  /** Device id */
  @key
  @path
  @visibility("read")
  deviceId: string;

  /** Module id */
  moduleId?: string;

  /** Aggregate device health state */
  state: DeviceHealthState;

  /** Digital twin model Id */
  digitalTwinModelId?: string;

  /** Array of health checks and their results */
  healthChecks: HealthCheck[];
}

/** Health check */
model HealthCheck {
  /** Health check name */
  name?: string;

  /** Health check result */
  result?: HealthCheckResult;
}

/** Device filter. */
model DeviceFilter {
  /** Device group identity. */
  groupId?: string;

  /** Device class identity. */
  deviceClassId?: string;

  /** State of the device in its last deployment. */
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

  /** The value the compat property to use in the filter. E.g. Contoso */
  compatPropertyValue?: string;
}

/** Device class filter. Filters device classes based on device class friendly name */
model DeviceClassFilter {
  /** The friendly name of the device class to use in the filter */
  friendlyName?: string;
}

/** Update filter. */
model UpdateFilter {
  /** Update isDeployable property. */
  isDeployable?: boolean;
}

/** Operation status filter. */
model OperationFilter {
  /** Operation status filter. */
  status?: OperationFilterStatus;
}

/** Groups order by. */
model GroupOrderBy {
  /** The group Id. */
  groupId?: string;

  /** The group device count. */
  deviceCount?: string;

  /** The group created date. */
  createdDate?: string;

  /** The number of subgroups with new updates available */
  subgroupsWithNewUpdatesAvailableCount?: string;

  /** The number of subgroups with updates in progress */
  subgroupsWithUpdatesInProgressCount?: string;

  /** The number of subgroups with devices on the latest update */
  subgroupsOnLatestUpdateCount?: string;
}

/** Deployment order by. */
model DeploymentOrderBy {
  /** The deployment start datetime. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;
}

/** Deployment device state filter. */
model DeploymentDeviceStatesFilter {
  /** Device Identifier. */
  deviceId?: string;

  /** Device module Identifier. */
  moduleId?: string;

  /** The deployment device state. */
  deviceState?: DeviceDeploymentState;
}

/** The list of log collections with detailed status, with server paging support. */
model LogCollectionDetailedStatusList {
  /** The collection of pageable items. */
  value: LogCollectionOperationDetailedStatus[];

  /** The link to the next page of items. */
  nextLink?: string;
}

/** Device health filter. */
model DeviceHealthFilter {
  /** Device health state */
  state?: DeviceHealthState;

  /** Device Id */
  deviceId?: string;

  /** Module Id */
  moduleId?: string;
}
