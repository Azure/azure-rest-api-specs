import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace DeviceUpdateClient;

enum StepType {
  @doc("Step type that performs code execution.") Inline,
  @doc("Step type that installs another update.") Reference,
}

enum OperationStatus {
  @doc("Background operation created but not started yet.") NotStarted,
  @doc("Background operation is currently running.") Running,
  @doc("Background operation finished with success.") Succeeded,
  @doc("Background operation finished with failure.") Failed,
}

enum DeviceDeploymentState {
  @doc("Deployment has completed with success.") Succeeded,
  @doc("Deployment is in progress.") InProgress,
  @doc("Deployment was canceled.") Canceled,
  @doc("Deployment has completed with failure.") Failed,
}

enum ImportType {
  @doc("Import only devices but not modules.") Devices,
  @doc("Import only modules but not devices.") Modules,
  @doc("Import both devices and modules.") All,
}

enum GroupType {
  @doc("IoT Hub tag based group, all devices in the group share an ADUGroup tag value.")
  IoTHubTag,
  @doc("Default group for untagged devices.") DefaultNoTag,
}

enum DeploymentState {
  @doc("The deployment can be sent to devices targeted in the deployment.")
  Active,
  @doc("""
The deployment can be sent to some devices targeted in the deployment but at
least 1 subgroup is in a failed state.
""")
  ActiveWithSubgroupFailures,
  @doc("""
The deployment will not be sent to any devices.  Consult error for more details
about what failed.
""")
  Failed,
  @doc("""
A newer deployment for this group has been created and no devices in the group
will receive this deployment.
""")
  Inactive,
  @doc("The deployment has been canceled and no devices will receive it.")
  Canceled,
}

enum DeviceClassSubgroupDeploymentState {
  @doc("The subgroup deployment can be sent to devices targeted in the deployment.")
  Active,
  @doc("The subgroup deployment failed and will not be sent to any devices.")
  Failed,
  @doc("""
A newer deployment for this subgroup has been created and no devices in the
subgroup will receive this deployment.
""")
  Inactive,
  @doc("The subgroup deployment has been canceled and no devices will receive it.")
  Canceled,
}

enum DeviceHealthState {
  @doc("Agent is healthy") healthy,
  @doc("Agent is in an unhealthy state") unhealthy,
}

enum HealthCheckResult {
  @doc("Health check succeeded") success,
  @doc("Health check failed due to user error") userError,
}

enum OperationFilterStatus {
  Running,
  NotStarted,
}

@doc("The list of updates.")
model UpdateList is Azure.Core.Page<Update>;

@doc("Update metadata.")
model Update {
  @doc("Update identity.")
  updateId: UpdateId;

  @doc("Update description specified by creator.")
  description?: string;

  @doc("Friendly update name specified by importer.")
  friendlyName?: string;

  @doc("Whether the update can be deployed to a device on its own.")
  isDeployable?: boolean;

  @doc("Update type. Deprecated in latest import manifest schema.")
  updateType?: string;

  @doc("""
String interpreted by Device Update client to determine if the update is
installed on the device. Deprecated in latest import manifest schema.
""")
  installedCriteria?: string;

  @doc("List of update compatibility information.")
  compatibility: Record<string>[];

  @doc("Update install instructions.")
  instructions?: Instructions;

  @doc("List of update identities that reference this update.")
  referencedBy?: UpdateId[];

  @doc("Update aggregate scan result (calculated from payload file scan results).")
  scanResult?: string;

  @doc("Schema version of manifest used to import the update.")
  manifestVersion: string;

  @doc("Date and time in UTC when the update was imported.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  importedDateTime: utcDateTime;

  @doc("Date and time in UTC when the update was created.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime: utcDateTime;

  @doc("Update ETag.")
  etag?: string;
}

@doc("Update identifier.")
model UpdateId {
  @doc("Update provider.")
  provider: string;

  @doc("Update name.")
  name: string;

  @doc("Update version.")
  version: string;
}

model Instructions {
  @doc("Collection of installation steps.")
  steps: Step[];
}

@doc("Update install instruction step.")
model Step {
  @doc("Step type.")
  type?: StepType;

  @doc("Step description.")
  description?: string;

  @doc("""
Identity of handler that will execute this step. Required if step type is
inline.
""")
  handler?: string;

  @doc("Parameters to be passed to handler during execution.")
  handlerProperties?: unknown;

  @doc("""
Collection of file names to be passed to handler during execution. Required if
step type is inline.
""")
  files?: string[];

  @doc("Referenced child update identity.  Required if step type is reference.")
  updateId?: UpdateId;
}

@doc("Common error response.")
@error
model ErrorResponse {
  @doc("The error details.")
  error: Error;
}

@doc("Error details.")
model Error {
  @doc("Server defined error code.")
  code: string;

  @doc("A human-readable representation of the error.")
  message: string;

  @doc("The target of the error.")
  target?: string;

  @doc("An array of errors that led to the reported error.")
  details?: Error[];

  @doc("""
An object containing more specific information than the current object about
the error.
""")
  innererror?: InnerError;

  @doc("Date and time in UTC when the error occurred.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  occurredDateTime?: utcDateTime;
}

@doc("""
An object containing more specific information than the current object about
the error.
""")
model InnerError {
  @doc("A more specific error code than what was provided by the containing error.")
  code: string;

  @doc("A human-readable representation of the error.")
  message?: string;

  @doc("The internal error or exception message.")
  errorDetail?: string;

  @doc("""
An object containing more specific information than the current object about
the error.
""")
  innerError?: InnerError;
}

@doc("Import update input item metadata.")
model ImportUpdateInputItem {
  @doc("Import manifest metadata like source URL, file size/hashes, etc.")
  importManifest: ImportManifestMetadata;

  @doc("Friendly update name.")
  friendlyName?: string;

  @doc("One or more update file properties like filename and source URL.")
  files?: FileImportMetadata[];
}

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

  @doc("File size in number of bytes.")
  sizeInBytes: int32;

  @doc("""
A JSON object containing the hash(es) of the file. At least SHA256 hash is
required. This object can be thought of as a set of key-value pairs where the
key is the hash algorithm, and the value is the hash of the file calculated
using that algorithm.
""")
  hashes: Record<string>;
}

@doc("Metadata describing an update file.")
model FileImportMetadata {
  @doc("Update file name as specified inside import manifest.")
  filename: string;

  @doc("""
Azure Blob location from which the update file can be downloaded by Device
Update for IoT Hub. This is typically a read-only SAS-protected blob URL with
an expiration set to at least 4 hours.
""")
  url: string;
}

@doc("The list of strings with server paging support.")
model StringsList is Azure.Core.Page<string>;

@doc("Update file metadata.")
model UpdateFile {
  ...UpdateFileBase;

  @doc("File identity, generated by server at import time.")
  fileId: string;

  @doc("""
Optional related files metadata used together DownloadHandler metadata to
download payload file.
""")
  relatedFiles?: UpdateFileBase[];

  @doc("Optional download handler for utilizing related files to download payload file.")
  downloadHandler?: UpdateFileDownloadHandler;

  @doc("File ETag.")
  etag?: string;
}

@doc("Update file basic metadata.")
model UpdateFileBase {
  @doc("File name.")
  fileName: string;

  @doc("File size in number of bytes.")
  sizeInBytes: int32;

  @doc("Mapping of hashing algorithm to base64 encoded hash values.")
  hashes: Record<string>;

  @doc("File MIME type.")
  mimeType?: string;

  @doc("Anti-malware scan result.")
  scanResult?: string;

  @doc("Anti-malware scan details.")
  scanDetails?: string;

  @doc("Optional file properties (not consumed by service but pass-through to device).")
  properties?: Record<string>;
}

@doc("Download handler for utilizing related files to download payload file.")
model UpdateFileDownloadHandler {
  @doc("Download handler identifier.")
  id: string;
}

@doc("The list of operations with server paging support.")
model UpdateOperationsList is Azure.Core.Page<UpdateOperation>;

@doc("Operation metadata.")
model UpdateOperation {
  @doc("Operation Id.")
  operationId: string;

  @doc("Operation status.")
  status: OperationStatus;

  @doc("""
The update being imported or deleted. For import, this property will only be
populated after import manifest is processed successfully.
""")
  update?: UpdateInfo;

  @doc("Location of the imported update when operation is successful.")
  resourceLocation?: string;

  @doc("Operation error encountered, if any.")
  error?: Error;

  @doc("""
Operation correlation identity that can used by Microsoft Support for
troubleshooting.
""")
  traceId?: string;

  @doc("Date and time in UTC when the operation status was last updated.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActionDateTime: utcDateTime;

  @doc("Date and time in UTC when the operation was created.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime: utcDateTime;

  @doc("Operation ETag.")
  etag?: string;
}

@doc("Update information.")
model UpdateInfo {
  @doc("Update identifier.")
  updateId: UpdateId;

  @doc("Update description.")
  @visibility("read")
  description?: string;

  @doc("Friendly update name.")
  @visibility("read")
  friendlyName?: string;
}

@doc("The list of device classes.")
model DeviceClassesList is Azure.Core.Page<DeviceClass>;

@doc("Device class metadata.")
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

  @doc("The device class properties that are used to calculate the device class Id")
  deviceClassProperties: DeviceClassProperties;

  @doc("Update that is the highest version compatible with this device class.")
  bestCompatibleUpdate?: UpdateInfo;
}

@doc("The device class properties that are used to calculate the device class Id")
model DeviceClassProperties {
  @doc("The Device Update agent contract model.")
  contractModel?: ContractModel;

  @doc("""
The compat properties of the device class. This object can be thought of as a
set of key-value pairs where the key is the name of the compatibility property
and the value is the value of the compatibility property. There will always be
at least 1 compat property
""")
  compatProperties: Record<string>;
}

@doc("The Device Update agent contract model.")
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

@doc("Device Class JSON Merge Patch request body")
model PatchBody {
  @doc("""
The device class friendly name. Friendly name can be 1-100 characters,
alphanumeric, dot, and dash.
""")
  friendlyName: string;
}

@doc("List of update information.")
model UpdateInfoList is Azure.Core.Page<UpdateInfo>;

@doc("The list of devices.")
model DevicesList is Azure.Core.Page<Device>;

@doc("Device metadata.")
model Device {
  @doc("Device identity.")
  deviceId: string;

  @doc("Device module identity.")
  moduleId?: string;

  @doc("Device class identity.")
  deviceClassId: string;

  @doc("Device group identity.")
  groupId?: string;

  @doc("The update that device last attempted to install.")
  lastAttemptedUpdate?: UpdateInfo;

  @doc("State of the device in its last deployment.")
  deploymentStatus?: DeviceDeploymentState;

  @doc("Currently installed update on device.")
  installedUpdate?: UpdateInfo;

  @doc("""
Boolean flag indicating whether the latest update (the best compatible update
for the device's device class and group) is installed on the device
""")
  onLatestUpdate: boolean;

  @doc("The deployment identifier for the last deployment to the device")
  lastDeploymentId?: string;

  @doc("Last install result.")
  lastInstallResult?: InstallResult;
}

@doc("The install result of an update and any step results under it.")
model InstallResult {
  @doc("Install result code.")
  resultCode: int32;

  @doc("Install extended result code")
  extendedResultCode: int32;

  @doc("A string containing further details about the install result")
  resultDetails?: string;

  @doc("Array of step results")
  stepResults?: StepResult[];
}

@doc("The step result under an update.")
model StepResult {
  @doc("The update that this step installs if it is of reference type.")
  update?: UpdateInfo;

  @doc("Step description.")
  description?: string;

  @doc("Install result code.")
  resultCode: int32;

  @doc("Install extended result code")
  extendedResultCode: int32;

  @doc("A string containing further details about the install result")
  resultDetails?: string;
}

@doc("Update compliance information.")
model UpdateCompliance {
  @doc("Total number of devices.")
  totalDeviceCount: int32;

  @doc("Number of devices on the latest update.")
  onLatestUpdateDeviceCount: int32;

  @doc("Number of devices with a newer update available.")
  newUpdatesAvailableDeviceCount: int32;

  @doc("Number of devices with update in-progress.")
  updatesInProgressDeviceCount: int32;
}

@doc("""
The list of limits of how many of each resource are currently in use and how
many are allowed.
""")
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
  @doc("The current usage and quota of devices.")
  deviceCount?: UsageQuotaCounter;

  @doc("The current usage and quota of device classes.")
  deviceClassCount?: UsageQuotaCounter;

  @doc("The current usage and quota of device groups.")
  deviceGroupCount?: UsageQuotaCounter;

  @doc("The current usage and quota of active deployments.")
  activeDeploymentCount?: UsageQuotaCounter;

  @doc("The current usage and quota of deployments.")
  deploymentCount?: UsageQuotaCounter;
}

@doc("A counter with both usage and quota information.")
model UsageQuotaCounter {
  @doc("The current number of the resource that exist")
  usage?: int32;

  @doc("The maximum number of the resource that can be created")
  quota?: int32;
}

@doc("The list of groups.")
model GroupsList is Azure.Core.Page<Group>;

@doc("Group details.")
model Group {
  @doc("""
Group identity. This is created from the value of the ADUGroup tag in the Iot
Hub's device/module twin or $default for devices with no tag.
""")
  groupId: string;

  @doc("Group type.")
  groupType: GroupType;

  @doc("Date and time when the update was created.")
  createdDateTime: string;

  @doc("The number of devices in the group.")
  deviceCount?: int32;

  @doc("The count of subgroups with new updates available.")
  subgroupsWithNewUpdatesAvailableCount?: int32;

  @doc("The count of subgroups with updates in progress.")
  subgroupsWithUpdatesInProgressCount?: int32;

  @doc("The count of subgroups with devices on the latest update.")
  subgroupsWithOnLatestUpdateCount?: int32;

  @doc("The active deployment Ids for the group")
  deployments?: string[];
}

@doc("The list of updatable devices for a device class subgroup.")
model DeviceClassSubgroupUpdatableDevicesList
  is Azure.Core.Page<DeviceClassSubgroupUpdatableDevices>;

@doc("""
Device class subgroup, update information, and the number of devices for which
the update is applicable.
""")
model DeviceClassSubgroupUpdatableDevices {
  @doc("The group Id")
  groupId: string;

  @doc("The device class subgroup's device class Id")
  deviceClassId: string;

  @doc("Update information.")
  update: UpdateInfo;

  @doc("Total number of devices for which the update is applicable.")
  deviceCount: int32;
}

@doc("The list of deployments.")
model DeploymentsList is Azure.Core.Page<Deployment>;

@doc("Deployment metadata.")
model Deployment {
  @doc("""
The caller-provided deployment identifier. This cannot be longer than 73
characters, must be all lower-case, and cannot contain '&', '^', '[', ']', '{',
'}', '|', '<', '>', forward slash, backslash, or double quote. The Updates view
in the Azure Portal IoT Hub resource generates a GUID for deploymentId when you
create a deployment.
""")
  deploymentId: string;

  @doc("The deployment start datetime.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime: utcDateTime;

  @doc("Update information for the update in the deployment.")
  update: UpdateInfo;

  @doc("The group identity for the devices the deployment is intended to update.")
  groupId: string;

  @doc("""
The device class subgroups the deployment is compatible with and subgroup
deployments have been created for. This is not provided by the caller during
CreateOrUpdateDeployment but is automatically determined by Device Update
""")
  deviceClassSubgroups?: string[];

  @doc("Boolean flag indicating whether the deployment was canceled.")
  isCanceled?: boolean;

  @doc("Boolean flag indicating whether the deployment has been retried.")
  isRetried?: boolean;

  @doc("The rollback policy for the deployment.")
  rollbackPolicy?: CloudInitiatedRollbackPolicy;

  @doc("Boolean flag indicating whether the deployment is a rollback deployment.")
  isCloudInitiatedRollback?: boolean;
}

@doc("Rollback policy for deployment")
model CloudInitiatedRollbackPolicy {
  @doc("Update to rollback to.")
  update: UpdateInfo;

  @doc("Failure conditions to initiate rollback policy.")
  failure: CloudInitiatedRollbackPolicyFailure;
}

@doc("Failure conditions to initiate rollback policy")
model CloudInitiatedRollbackPolicyFailure {
  @doc("Percentage of devices that failed.")
  devicesFailedPercentage: int32;

  @doc("Number of devices that failed.")
  devicesFailedCount: int32;
}

@doc("Deployment status metadata.")
model DeploymentStatus {
  @doc("The group identity")
  groupId: string;

  @doc("The state of the deployment.")
  deploymentState: DeploymentState;

  @doc("""
The error details of the Failed state.  This is not present if the deployment
state is not Failed.
""")
  error?: Error;

  @doc("The collection of device class subgroup status objects")
  subgroupStatus: DeviceClassSubgroupDeploymentStatus[];
}

@doc("Device class subgroup deployment status metadata.")
model DeviceClassSubgroupDeploymentStatus {
  @doc("The group identity")
  groupId: string;

  @doc("The device class subgroup identity")
  deviceClassId: string;

  @doc("The state of the subgroup deployment.")
  deploymentState: DeviceClassSubgroupDeploymentState;

  @doc("""
The error details of the Failed state.  This is not present if the deployment
state is not Failed.
""")
  error?: Error;

  @doc("The total number of devices in the deployment.")
  totalDevices?: int32;

  @doc("The number of devices that are currently in deployment.")
  devicesInProgressCount?: int32;

  @doc("The number of devices that have completed deployment with a failure.")
  devicesCompletedFailedCount?: int32;

  @doc("The number of devices which have successfully completed deployment.")
  devicesCompletedSucceededCount?: int32;

  @doc("The number of devices which have had their deployment canceled.")
  devicesCanceledCount?: int32;
}

@doc("The list of device class subgroups within a group.")
model DeviceClassSubgroupsList is Azure.Core.Page<DeviceClassSubgroup>;

@doc("""
Device class subgroup details. A device class subgroup is a subset of devices
in a group that share the same device class id.
""")
model DeviceClassSubgroup {
  @doc("""
Device class subgroup identity. This is generated from the model Id and the
compat properties reported by the device update agent in the Device Update PnP
interface in IoT Hub. It is a hex-encoded SHA1 hash.
""")
  deviceClassId: string;

  @doc("Group identity.")
  groupId: string;

  @doc("Date and time when the device class subgroup was created.")
  createdDateTime: string;

  @doc("The number of devices in the device class subgroup.")
  deviceCount?: int32;

  @doc("The active deployment Id for the device class subgroup.")
  deploymentId?: string;
}

@doc("The list of deployment device states.")
model DeploymentDeviceStatesList is Azure.Core.Page<DeploymentDeviceState>;

@doc("Deployment device status.")
model DeploymentDeviceState {
  @doc("Device identity.")
  deviceId: string;

  @doc("Device module identity.")
  moduleId?: string;

  @doc("The number of times this deployment has been retried on this device.")
  retryCount: int32;

  @doc("""
Boolean flag indicating whether this device is in a newer deployment and can no
longer retry this deployment.
""")
  movedOnToNewDeployment: boolean;

  @doc("Deployment device state.")
  deviceState: DeviceDeploymentState;
}

@doc("Operation metadata.")
model DeviceOperation {
  @doc("Operation Id.")
  operationId: string;

  @doc("Operation status.")
  status: OperationStatus;

  @doc("Operation error encountered, if any.")
  error?: Error;

  @doc("""
Operation correlation identity that can used by Microsoft Support for
troubleshooting.
""")
  traceId?: string;

  @doc("Date and time in UTC when the operation status was last updated.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActionDateTime: utcDateTime;

  @doc("Date and time in UTC when the operation was created.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime: utcDateTime;

  @doc("Operation ETag.")
  etag?: string;
}

@doc("The list of device operations with server paging support.")
model DeviceOperationsList is Azure.Core.Page<DeviceOperation>;

@doc("Diagnostics request body")
model LogCollection {
  @doc("The log collection id.")
  @projectedName("json", "operationId")
  logCollectionId?: string;

  @doc("Array of Device Update agent ids")
  deviceList: DeviceUpdateAgentId[];

  @doc("Description of the diagnostics operation.")
  description?: string;

  @doc("The timestamp when the operation was created.")
  @visibility("read")
  createdDateTime?: string;

  @doc("A timestamp for when the current state was entered.")
  @visibility("read")
  lastActionDateTime?: string;

  @doc("Operation status.")
  @visibility("read")
  status?: OperationStatus;
}

@doc("Device Update agent id")
model DeviceUpdateAgentId {
  @doc("Device Id")
  deviceId: string;

  @doc("Module Id")
  moduleId?: string;
}

@doc("The list of log collections with server paging support.")
model LogCollectionList is Azure.Core.Page<LogCollection>;

@doc("Device diagnostics operation detailed status")
model LogCollectionOperationDetailedStatus {
  @doc("The device diagnostics operation id.")
  @projectedName("json", "operationId")
  logCollectionId?: string;

  @doc("The timestamp when the operation was created.")
  createdDateTime?: string;

  @doc("A timestamp for when the current state was entered.")
  lastActionDateTime?: string;

  @doc("Operation status.")
  status?: OperationStatus;

  @doc("Status of the devices in the operation")
  deviceStatus?: LogCollectionOperationDeviceStatus[];

  @doc("Device diagnostics operation description.")
  description?: string;
}

@doc("Diagnostics operation device status")
model LogCollectionOperationDeviceStatus {
  @doc("Device id")
  deviceId: string;

  @doc("Module id.")
  moduleId?: string;

  @doc("Log upload status")
  status: OperationStatus;

  @doc("Log upload result code")
  resultCode?: string;

  @doc("Log upload extended result code")
  extendedResultCode?: string;

  @doc("Log upload location")
  logLocation?: string;
}

@doc("Array of Device Health, with server paging support.")
model DeviceHealthList is Azure.Core.Page<DeviceHealth>;

@doc("Device Health")
model DeviceHealth {
  @doc("Device id")
  deviceId: string;

  @doc("Module id")
  moduleId?: string;

  @doc("Aggregate device health state")
  state: DeviceHealthState;

  @doc("Digital twin model Id")
  digitalTwinModelId?: string;

  @doc("Array of health checks and their results")
  healthChecks: HealthCheck[];
}

@doc("Health check")
model HealthCheck {
  @doc("Health check name")
  name?: string;

  @doc("Health check result")
  result?: HealthCheckResult;
}

@doc("Device filter.")
model DeviceFilter {
  @doc("Device group identity.")
  groupId?: string;

  @doc("Device class identity.")
  deviceClassId?: string;

  @doc("State of the device in its last deployment.")
  deploymentStatus?: DeviceDeploymentState;
}

@doc("""
Device class subgroups filter. Filters device class subgroups based on device
class compat property names and values
""")
model DeviceClassSubgroupFilter {
  @doc("""
The name of the compat property to use in the filter. E.g.
compatProperties/manufacturer
""")
  compatPropertyName?: string;

  @doc("The value the compat property to use in the filter. E.g. Contoso")
  compatPropertyValue?: string;
}

@doc("Device class filter. Filters device classes based on device class friendly name")
model DeviceClassFilter {
  @doc("The friendly name of the device class to use in the filter")
  friendlyName?: string;
}

@doc("Update filter.")
model UpdateFilter {
  @doc("Update isDeployable property.")
  isDeployable?: boolean;
}

@doc("Operation status filter.")
model OperationFilter {
  @doc("Operation status filter.")
  status?: OperationFilterStatus;
}

@doc("Groups order by.")
model GroupOrderBy {
  @doc("The group Id.")
  groupId?: string;

  @doc("The group device count.")
  deviceCount?: string;

  @doc("The group created date.")
  createdDate?: string;

  @doc("The number of subgroups with new updates available")
  subgroupsWithNewUpdatesAvailableCount?: string;

  @doc("The number of subgroups with updates in progress")
  subgroupsWithUpdatesInProgressCount?: string;

  @doc("The number of subgroups with devices on the latest update")
  subgroupsOnLatestUpdateCount?: string;
}

@doc("Deployment order by.")
model DeploymentOrderBy {
  @doc("The deployment start datetime.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;
}

@doc("Deployment device state filter.")
model DeploymentDeviceStatesFilter {
  @doc("Device Identifier.")
  deviceId?: string;

  @doc("Device module Identifier.")
  moduleId?: string;

  @doc("The deployment device state.")
  deviceState?: DeviceDeploymentState;
}

@doc("The list of log collections with detailed status, with server paging support.")
model LogCollectionDetailedStatusList {
  @doc("The collection of pageable items.")
  value: LogCollectionOperationDetailedStatus[];

  @doc("The link to the next page of items.")
  nextLink?: string;
}

@doc("Device health filter.")
model DeviceHealthFilter {
  @doc("Device health state")
  state?: DeviceHealthState;

  @doc("Device Id")
  deviceId?: string;

  @doc("Module Id")
  moduleId?: string;
}
