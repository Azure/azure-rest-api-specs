import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DeviceUpdate;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provisioning state.
 */
union ProvisioningState {
  string,

  /**
   * Provisioning State Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Provisioning State Deleted
   */
  Deleted: "Deleted",

  /**
   * Provisioning State Failed
   */
  Failed: "Failed",

  /**
   * Provisioning State Canceled
   */
  Canceled: "Canceled",

  /**
   * Provisioning State Accepted
   */
  Accepted: "Accepted",

  /**
   * Provisioning State Creating
   */
  Creating: "Creating",

  /**
   * Provisioning State Deleting
   */
  Deleting: "Deleting",
}

/**
 * Device Update Account Sku
 */
union SKU {
  string,

  /**
   * Free SKU
   */
  Free: "Free",

  /**
   * Standard SKU
   */
  Standard: "Standard",

  /**
   * StandardCache SKU
   */
  @added(Versions.v2025_04_01_preview)
  StandardCache: "StandardCache",
}

/**
 * Whether the location is primary or failover
 */
union Role {
  string,

  /**
   * Primary Location
   */
  Primary: "Primary",

  /**
   * Failover Location
   */
  Failover: "Failover",
}

/**
 * The type of a MQTT Broker
 */
union BrokerType {
  string,

  /**
   * Azure EventGrid MQTT Broker
   */
  EventGrid: "EventGrid",

  /**
   * Generic MQTT Broker (non-EventGrid)
   */
  Generic: "Generic",
}

/**
 * The type of devices managed by this account
 */
union DeviceType {
  string,

  /**
   * Microsoft.DeviceRegistry/devices
   */
  DeviceRegistryDevice: "DeviceRegistryDevice",

  /**
   * Microsoft.HybridCompute/machines.
   */
  HybridComputeMachine: "HybridComputeMachine",

  /**
   * All device types supported by Device Update service.
   */
  AllDeviceTypes: "AllDeviceTypes",
}

/**
 * The scope of the enrollment
 */
union ScopeType {
  string,

  /**
   * Subscription scope
   */
  Subscription: "Subscription",

  /**
   * Resource group scope
   */
  ResourceGroup: "ResourceGroup",
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Common type, does not have documentation in any version."
union ManagedServiceIdentityType {
  string,
  None: "None",
  SystemAssigned: "SystemAssigned",
  UserAssigned: "UserAssigned",
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * The deployment action the agent take
 */
union DeploymentAction {
  string,

  /**
   * Apply the deployment to the agent
   */
  ApplyDeployment: "ApplyDeployment",
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
 * The agent enrollment state.
 */
union AgentEnrollmentState {
  string,

  /**
   * Agent enrollment succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * Agent enrollment failed.
   */
  Failed: "Failed",

  /**
   * Agent enrollment is in progress.
   */
  InProgress: "InProgress",
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
   * The deployment can be sent to some devices targeted in the deployment but at least 1 subgroup is in a failed state.
   */
  ActiveWithSubgroupFailures: "ActiveWithSubgroupFailures",

  /**
   * The deployment will not be sent to any devices.  Consult error for more details about what failed.
   */
  Failed: "Failed",

  /**
   * A newer deployment for this group has been created and no devices in the group will receive this deployment.
   */
  Inactive: "Inactive",

  /**
   * The deployment has been canceled and no devices will receive it.
   */
  Canceled: "Canceled",
}

/**
 * Device class subgroup deployment state
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
   * A newer deployment for this subgroup has been created and no devices in the subgroup will receive this deployment.
   */
  Inactive: "Inactive",

  /**
   * The subgroup deployment has been canceled and no devices will receive it.
   */
  Canceled: "Canceled",
}

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
 * Hash algorithm
 */
union HashAlgorithm {
  string,

  /**
   * Hash algorithm type
   */
  sha256: "sha256",
}

/**
 * Hash value
 */
model HashValue {
  /**
   * Hash algorithm
   */
  algorithm: HashAlgorithm;

  /**
   * Hash value
   */
  value: string;
}

/**
 * The extended location type. Allowed values: 'CustomLocation', 'EdgeZone'
 */
union ExtendedLocationType {
  string,

  /**
   * The custom location extended location type.
   */
  CustomLocation: "CustomLocation",

  /**
   * The edge zone extended location type.
   */
  EdgeZone: "EdgeZone",
}

/**
 * The extended location.
 */
model ExtendedLocation {
  /**
   * The extended location type.
   */
  type?: ExtendedLocationType;

  /**
   *  The extended location name.
   */
  name?: string;
}

/**
 * Device Update update account properties.
 */
model UpdateAccountProperties {
  /**
   * Provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Device Update Account Sku
   */
  sku?: SKU = SKU.Standard;

  /**
   * CMK encryption at rest properties
   */
  encryption?: Encryption;

  /**
   * Device Update update account primary and failover location details
   */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  locations?: Location[];

  /**
   * MQTT Brokers used for device communication.
   */
  @madeOptional(Versions.v2024_10_01_preview)
  @Azure.ResourceManager.identifiers(#[])
  mqttBrokers?: MqttBroker[];

  /**
   * The type of devices managed by this account.
   */
  @added(Versions.v2024_10_01_preview)
  deviceType: DeviceType;

  /**
   * Subscription or resource group used for device enrollment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deviceEnrollmentScope: string;

  /**
   * User assigned managed identity used for device enrollment and broker communication.
   */
  serviceManagedIdentityResourceId: string;

  /**
   * Device enrollment scopes
   */
  @added(Versions.v2025_04_01_preview)
  @Azure.ResourceManager.identifiers(#[])
  deviceEnrollmentScopes?: DeviceEnrollmentScope[];

  /**
   * The cache storage account resource id used to import content.
   */
  @added(Versions.v2025_04_01_preview)
  cacheStorageResourceId?: string;
}

/**
 * The CMK encryption settings on the Device Update account.
 */
model Encryption {
  /**
   * The URI of the key vault
   */
  keyVaultKeyUri?: string;

  /**
   * The full resourceId of the user assigned identity to be used for key vault access. Identity has to be also assigned to the Account
   */
  userAssignedIdentity?: string;
}

/**
 * Update Account location
 */
model Location {
  /**
   * Optional location name
   */
  name?: string;

  /**
   * Whether the location is primary or failover
   */
  role?: Role = Role.Primary;
}

/**
 * The MQTT Broker
 */
model MqttBroker {
  /**
   * The full resourceId of the Event Grid Namespace. Required if using Azure EventGrid broker
   */
  resourceId?: string;

  /**
   * MQTT Broker endpoint. Required if not using Azure EventGrid broker
   */
  mqttHostName?: string;

  /**
   * The type of a MQTT Broker
   */
  type: BrokerType = BrokerType.EventGrid;
}

/**
 * The DeviceEnrollmentScope
 */
model DeviceEnrollmentScope {
  /**
   * Subscription or resource group used for device enrollment.
   */
  scopeId: string;

  /**
   * The scope type
   */
  scopeType: ScopeType = ScopeType.Subscription;

  /**
   * The cache information
   */
  cache?: Cache;
}

/**
 * The Cache information
 */
model Cache {
  /**
   * The Arc extension resource id
   */
  arcExtensionResourceId: string;

  /**
   * The cache download url
   */
  cacheDownloadEndpoint: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

@removed(Versions.v2025_04_01_preview)
model ManagedServiceIdentityUpdate
  is OptionalProperties<UpdateableProperties<Azure.ResourceManager.Foundations.ManagedServiceIdentity>>;

/**
 * Request payload used to update an existing Update Account.
 */
model UpdateAccountUpdate is TagUpdate {
  /**
   * The type of identity used for the resource.
   */
  @typeChangedFrom(Versions.v2025_04_01_preview, ManagedServiceIdentityUpdate)
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;

  /**
   * The geo-location where the resource lives
   */
  @removed(Versions.v2025_04_01_preview)
  location?: string;
}

/**
 * Request payload used to update an existing resource's tags.
 */
model TagUpdate {
  /**
   * List of key value pairs that describe the resource. This will overwrite the existing tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  tags?: Record<string>;
}

/**
 * Active Deployment properties.
 */
model ActiveDeploymentProperties {
  /**
   * Provisioning state.
   */
  @removed(Versions.v2024_10_01_preview)
  @renamedFrom(Versions.v2024_10_01_preview, "provisioningState")
  provisioningStateOld?: ProvisioningState;

  /**
   * Provisioning state.
   */
  @added(Versions.v2024_10_01_preview)
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The deployment Id
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deploymentId: string;

  /**
   * The start date for the active deployment
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime: utcDateTime;

  /**
   * The device class Id
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deviceClassId: string;

  /**
   * The update protocol
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  updateProtocol: UpdateProtocol;

  /**
   * The deployment workflow metadata
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  workflow: DeploymentWorkflow;

  /**
   * The update manifest that contains all of the metadata for the active deployment
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  updateManifest: string;

  /**
   * The update manifest signature that is used to validate the integrity of the update manifest
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  updateManifestSignature: string;
}

/**
 * The update protocol representing the version of the device update protocol the agent supports.
 */
model UpdateProtocol {
  /**
   * The update protocol identifier
   */
  id?: int32;
}

/**
 * Deployment workflow metadata.
 */
model DeploymentWorkflow {
  /**
   * Deployment identifier.
   */
  id: string;

  /**
   * Deployment action.
   */
  action: DeploymentAction;

  /**
   * Datetime when the call requested the deployment be retried.
   */
  retryTimestamp?: string;
}

/**
 * Device Update Agent properties.
 */
model AgentProperties {
  /**
   * Provisioning state.
   */
  @removed(Versions.v2024_10_01_preview)
  @renamedFrom(Versions.v2024_10_01_preview, "provisioningState")
  provisioningStateOld?: ProvisioningState;

  /**
   * Provisioning state.
   */
  @added(Versions.v2024_10_01_preview)
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * This is the external device Id of the Microsoft.Devices/Device resource referenced by this agent
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  agentId?: string;

  /**
   * This is the ID of the device class of this agent
   */
  deviceClassId?: string;

  /**
   * This is the resource Id of the Microsoft.Devices/Device resource referenced by this agent
   */
  deviceResourceId: string;

  /**
   * This is the active MQTT broker endpoint for this agent
   */
  activeMqttBrokerEndpoint?: string;

  /**
   * This is the compatibility info for the agent that indicates what version of the device update protocol it supports and its compat properties.
   */
  agentInfo?: AgentInfo;

  /**
   * This is the metadata about the latest deployment the agent has attempted
   */
  latestDeploymentInfo?: DeploymentInfo;

  /**
   * The current installed update Id on this agent
   */
  installedUpdateId?: UpdateId;

  /**
   * Enrollment status
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  enrollmentStatus: AgentEnrollmentStatus;

  /**
   * This is the device UUID for this agent
   */
  deviceUuid: string;

  /**
   * This is the ID of the group this agent belongs to, which corresponds to the value of the resource tag with key "ADUGroup", if exists.
   */
  @added(Versions.v2025_05_01_preview)
  groupId?: string;
}

/**
 * The agent info for the agent that indicates what updates it is compatible with.
 */
model AgentInfo {
  /**
   * The update protocol representing the version of the device update protocol the agent supports
   */
  updateProtocol?: UpdateProtocol;

  /**
   * The compat properties of the agent. This object can be thought of as a set of key-value pairs where the key is the name of the compatibility property and the value is the value of the compatibility property. There will always be at least 1 compat property and no more than 5
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tag-like, user-defined properties"
  compatibilityProperties?: Record<string>;

  /**
   * The sequence number of the agent info used to distinguish whether the agent info needs to be updated from the agent
   */
  sequenceNumber?: int64;
}

/**
 * The agent metadata for a deployment.
 */
model DeploymentInfo {
  /**
   * The deployment workflow metadata
   */
  workflow?: DeploymentWorkflow;

  /**
   * The update Id for the deployment
   */
  updateId?: UpdateId;

  /**
   * The state the agent is in this deployment
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  state?: DeviceDeploymentState;

  /**
   * The deployment install result
   */
  installResult?: InstallResult;
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
 * The install result of an update and any step results under it.
 */
model InstallResult {
  /**
   * Install result code.
   */
  resultCode: int64;

  /**
   * Install extended result code
   */
  extendedResultCode: int64;

  /**
   * A string containing further details about the install result
   */
  resultDetails?: string;

  /**
   * Array of step results
   */
  @Azure.ResourceManager.identifiers(#[])
  stepResults?: StepResult[];
}

/**
 * The step result under an update.
 */
model StepResult {
  /**
   * The update that this step installs if it is of reference type.
   */
  updateId?: UpdateId;

  /**
   * Step description.
   */
  description?: string;

  /**
   * Install result code.
   */
  resultCode: int64;

  /**
   * Install extended result code
   */
  extendedResultCode: int64;

  /**
   * A string containing further details about the install result
   */
  resultDetails?: string;
}

/**
 * Agent enrollment status.
 */
model AgentEnrollmentStatus {
  /**
   * The agent enrollment state.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  state: AgentEnrollmentState;

  /**
   * The agent enrollment error detail. This is only populated when state is Failed
   */
  error?: ErrorDetail;
}

/**
 * The list of updatable devices for a device class.
 */
model DeviceClassUpdatableDevicesList {
  /**
   * The list of device classes and the highest version update details for each.
   */
  @Azure.ResourceManager.identifiers(#[])
  deviceClassHighestVersionUpdates: DeviceClassUpdatableDevices[];
}

/**
 * Device compatibility class Id, update Id, and the number of devices that need the update.
 */
model DeviceClassUpdatableDevices {
  /**
   * The device compatibility class Id
   */
  deviceClassId: string;

  /**
   * Update Id.
   */
  updateId: UpdateId;

  /**
   * Total number of devices in the device class that need the update.
   */
  deviceCount: int32;
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
   * Number of devices on the highest version update.
   */
  onHighestVersionUpdateDeviceCount: int32;

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
 * Deployment properties.
 */
model DeploymentProperties {
  /**
   * Provisioning state.
   */
  @removed(Versions.v2024_10_01_preview)
  @renamedFrom(Versions.v2024_10_01_preview, "provisioningState")
  provisioningStateOld?: ProvisioningState;

  /**
   * Provisioning state.
   */
  @added(Versions.v2024_10_01_preview)
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The caller-provided deployment identifier. This cannot be longer than 73 characters, must be all lower-case, and cannot contain '&', '^', '[', ']', '{', '}', '|', '<', '>', forward slash, backslash, or double quote.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deploymentId: string;

  /**
   * The deployment start datetime.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime: utcDateTime;

  /**
   * UpdateId that is deployed as part of this deployment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  updateId: UpdateId;

  /**
   * The device classes the deployment is compatible with. This is not provided by the caller during creating the deployment but is automatically determined by Device Update
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deviceClasses?: string[];
}

/**
 * The list of deployment device states.
 */
model DeploymentDeviceStatesList is Azure.Core.Page<DeploymentDeviceState>;
@@Azure.ResourceManager.identifiers(DeploymentDeviceStatesList.value, #[]);

/**
 * Deployment device status.
 */
model DeploymentDeviceState {
  /**
   * Agent identity.
   */
  agentId: string;

  /**
   * The number of times this deployment has been retried on this device.
   */
  retryCount: int32;

  /**
   * Boolean flag indicating whether this device is in a newer deployment and can no longer retry this deployment.
   */
  movedOnToNewDeployment: boolean;

  /**
   * Deployment device state.
   */
  @visibility(Lifecycle.Read)
  deviceState: DeviceDeploymentState;
}

/**
 * Deployment status metadata.
 */
model DeploymentStatus {
  /**
   * The state of the deployment.
   */
  deploymentState: DeploymentState;

  /**
   * The error details of the Failed state.  This is not present if the deployment state is not Failed.
   */
  error?: ErrorDetail;

  /**
   * The collection of device class subgroup status objects
   */
  @Azure.ResourceManager.identifiers(#[])
  subgroupStatus: DeviceClassSubgroupDeploymentStatus[];
}

/**
 * Device class subgroup deployment status metadata.
 */
model DeviceClassSubgroupDeploymentStatus {
  /**
   * The device class subgroup identity
   */
  deviceClassId: string;

  /**
   * The state of the subgroup deployment.
   */
  deploymentState: DeviceClassSubgroupDeploymentState;

  /**
   * The error details of the Failed state.  This is not present if the deployment state is not Failed.
   */
  error?: ErrorDetail;

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
 * Device Update Device Class properties.
 */
model DeviceClassProperties {
  /**
   * Provisioning state.
   */
  @removed(Versions.v2024_10_01_preview)
  @renamedFrom(Versions.v2024_10_01_preview, "provisioningState")
  provisioningStateOld?: ProvisioningState;

  /**
   * Provisioning state.
   */
  @added(Versions.v2024_10_01_preview)
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * This is the ID of the Device Class
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deviceClassId: string;

  /**
   * This is the compatibility info for the device class that will be used to check compatibility with updates.
   */
  deviceClassInfo: DeviceClassInfo;

  /**
   * UpdateId that is the highest version compatible with this device compatibility class.
   */
  highestVersionCompatibleUpdateId?: UpdateId;

  /**
   * The list of installable update Ids.
   */
  @identifiers(#[])
  installableUpdates?: UpdateId[];
}

/**
 * The compatibility info for the device class that indicates what updates it is compatible with.
 */
model DeviceClassInfo {
  /**
   * The update protocol representing the version of the device update protocol the agent supports
   */
  updateProtocol?: UpdateProtocol;

  /**
   * The compat properties of the device class. This object can be thought of as a set of key-value pairs where the key is the name of the compatibility property and the value is the value of the compatibility property. There will always be at least 1 compat property and no more than 5
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tag-like, user-defined properties"
  compatibilityProperties?: Record<string>;
}

/**
 * Import Update API request body.
 */
model ImportUpdateRequest {
  /**
   * Import update input metadata.
   */
  @Azure.ResourceManager.identifiers(#[])
  importUpdateInput: ImportUpdateInputItem[];

  /**
   * Whether enable anti-malware scan
   */
  enableScan?: boolean;
}

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
  @Azure.ResourceManager.identifiers(#[])
  @minItems(0)
  @maxItems(10)
  files?: FileImportMetadata[];
}

/**
 * Metadata describing the import manifest, a document which describes the files and other metadata about an update version.
 */
model ImportManifestMetadata {
  /**
   * Azure Blob location from which the import manifest can be downloaded by Device Update for IoT Hub. This is typically a read-only SAS-protected blob URL with an expiration set to at least 4 hours.
   */
  url: string;

  /**
   * File size in number of bytes.
   */
  sizeInBytes: int64;

  /**
   * A JSON object containing the hash(es) of the file. At least SHA256 hash is required. This object can be thought of as a set of key-value pairs where the key is the hash algorithm, and the value is the hash of the file calculated using that algorithm.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  @removed(Versions.v2025_04_01_preview)
  @renamedFrom(Versions.v2025_04_01_preview, "hashes")
  hashesOld: Record<string>;

  /**
   * An array containing the hash(es) of the file. At least one item is required containing SHA256 hash algorithm and the value being the hash of the file calculated using that algorithm.
   */
  @added(Versions.v2025_04_01_preview)
  @Azure.ResourceManager.identifiers(#[])
  @minItems(1)
  hashes: HashValue[];
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
   * Azure Blob location from which the update file can be downloaded by Device Update for IoT Hub. This is typically a read-only SAS-protected blob URL with an expiration set to at least 4 hours.
   */
  url: string;
}

/**
 * Update properties.
 */
model UpdateProperties {
  /**
   * Provisioning state.
   */
  @added(Versions.v2024_10_01_preview)
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

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
   * List of update compatibility information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  @Azure.ResourceManager.identifiers(#[])
  compatibility: Record<string>[];

  /**
   * Update install instructions.
   */
  instructions: Instructions;

  /**
   * List of update identities that reference this update.
   */
  @Azure.ResourceManager.identifiers(#["provider", "name", "version"])
  referencedBy?: UpdateId[];

  /**
   * List of update file metadata.
   */
  @Azure.ResourceManager.identifiers(#["fileName"])
  files?: UpdateFile[];

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
}

/**
 * Instructions consisting of installation steps.
 */
model Instructions {
  /**
   * Collection of installation steps.
   */
  @minItems(1)
  @maxItems(10)
  @Azure.ResourceManager.identifiers(#[])
  steps: Step[];
}

/**
 * Update install instruction step.
 */
model Step {
  /**
   * Step type.
   */
  type?: StepType;

  /**
   * Step description.
   */
  @maxLength(64)
  @minLength(1)
  description?: string;

  /**
   * Identity of handler that will execute this step. Required if step type is inline.
   */
  @maxLength(32)
  @minLength(1)
  handler?: string;

  /**
   * Parameters to be passed to handler during execution.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Legacy"
  handlerProperties?: {};

  /**
   * Collection of file names to be passed to handler during execution. Required if step type is inline.
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
 * Update file metadata.
 */
model UpdateFile is UpdateFileBase {
  /**
   * Optional related files metadata used together DownloadHandler metadata to download payload file.
   */
  @Azure.ResourceManager.identifiers(#[])
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  @removed(Versions.v2025_04_01_preview)
  @renamedFrom(Versions.v2025_04_01_preview, "hashes")
  hashesOld: Record<string>;

  /**
   * Mapping of hashing algorithm to base64 encoded hash values.
   */
  @added(Versions.v2025_04_01_preview)
  @Azure.ResourceManager.identifiers(#[])
  @minItems(1)
  hashes: HashValue[];

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
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
