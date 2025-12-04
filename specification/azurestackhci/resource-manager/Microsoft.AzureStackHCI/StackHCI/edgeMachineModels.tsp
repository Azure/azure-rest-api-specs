import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

/** Edge Machine Kind. */
@added(Versions.v2025_12_01_preview)
union EdgeMachineKind {
  string,

  /** EdgeMachine resource created using Zero-touch provisioning. */
  Standard: "Standard",

  /** EdgeMachine resource created for brownfield HCI customers without zero touch provisioning. */
  Dedicated: "Dedicated",
}

/** Properties for edge machine. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineProperties {
  /** Edge Machine type. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  edgeMachineKind?: EdgeMachineKind;

  /** The provisioning state of a resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: EdgeMachineProvisioningState;

  /** Unique, immutable resource id. */
  @visibility(Lifecycle.Read)
  cloudId?: string;

  /** Optional property to create arc machine in custom resource group. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  arcMachineResourceGroupId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Resources/resourceGroups";
    }
  ]>;

  /** Arc machine instance resource id. */
  arcMachineResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/machines";
    }
  ]>;

  /** Link to Arc Gateway ARM resource Id */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  arcGatewayResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/gateways";
    }
  ]>;

  /** Service fetches common configuration from site. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  siteDetails?: SiteDetails;

  /** Ownership voucher details for provisioned machine. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ownershipVoucherDetails?: OwnershipVoucherDetails;

  /** Details for device provisioning. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  provisioningDetails?: ProvisioningDetails;

  /** A machine can only be assigned to single device pool */
  @visibility(Lifecycle.Read)
  devicePoolResourceId?: string;

  /** OS configuration status details */
  @visibility(Lifecycle.Read)
  machineState?: EdgeMachineState;

  /** machine connectivity status */
  @visibility(Lifecycle.Read)
  connectivityStatus?: EdgeMachineConnectivityStatus;

  /** Tracks the ID of the consuming resource, setting the machine as in-use. */
  @visibility(Lifecycle.Read)
  claimedBy?: string;

  /** Reported properties for edge machine. */
  @visibility(Lifecycle.Read)
  reportedProperties?: EdgeMachineReportedProperties;

  /** operation status details for edge machine. */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  operationDetails?: OperationDetail[];

  /** Last time data updated to service. */
  @visibility(Lifecycle.Read)
  lastSyncTimestamp?: utcDateTime;
}

/** Model for patching edge machine. */
@added(Versions.v2025_12_01_preview)
model EdgeMachinePatch {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * Details for device provisioning.
 */
@added(Versions.v2025_12_01_preview)
model ProvisioningDetails {
  /** Operating system profile. */
  osProfile: OsProvisionProfile;

  /** User configuration. */
  @minItems(1)
  @Azure.ResourceManager.identifiers(#["userName"])
  userDetails?: UserDetails[];
}

/**
 * Details for ownership voucher.
 */
@added(Versions.v2025_12_01_preview)
model OwnershipVoucherDetails {
  /** Ownership voucher in base64 encoded format */
  @secret
  ownershipVoucher: string;

  /** Owner key type */
  ownerKeyType: OwnerKeyType;
}

/**
 * Type of owner key in the voucher
 */
@added(Versions.v2025_12_01_preview)
union OwnerKeyType {
  string,

  /** Owner is Microsoft managed key */
  MicrosoftManaged: "MicrosoftManaged",
}

/** operation detail. */
@added(Versions.v2025_12_01_preview)
model OperationDetail {
  /** operation name. */
  @visibility(Lifecycle.Read)
  name?: string;

  /** operation id. */
  @visibility(Lifecycle.Read)
  id?: string;

  /** operation type. */
  @visibility(Lifecycle.Read)
  type?: string;

  /** operation resource id. */
  @visibility(Lifecycle.Read)
  resourceId?: armResourceIdentifier;

  /** operation description. */
  @visibility(Lifecycle.Read)
  description?: string;

  /** operation status. */
  @visibility(Lifecycle.Read)
  status?: string;

  /** error details. */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

/** Overall connectivity status for the machine resource. */
@added(Versions.v2025_12_01_preview)
union EdgeMachineConnectivityStatus {
  string,

  /** The connectivity status of the machine resource is not specified. */
  NotSpecified: "NotSpecified",

  /** The machine resource is disconnected. */
  Disconnected: "Disconnected",

  /** The machine resource is connected. */
  Connected: "Connected",
}

/** Site Details consists of common configurations. */
@added(Versions.v2025_12_01_preview)
model SiteDetails {
  /** Site resource Id to be set during Edge Machine resource creation. */
  siteResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/sites";
    }
  ]>;

  /** Edge Device configuration received from site common configuration. */
  deviceConfiguration?: EdgeMachineDeviceConfiguration;
}

/** OS State */
@added(Versions.v2025_12_01_preview)
union EdgeMachineState {
  string,

  /** Created when EdgeMachine resource created */
  Created: "Created",

  /** EdgeMachine state during device discovery and registration */
  Registering: "Registering",

  /** EdgeMachine state when machine configured with restricted OS and not provisioned to deploy workloads */
  Unpurposed: "Unpurposed",

  /** EdgeMachine state when transitioning from initial OS to target OS */
  Transitioning: "Transitioning",

  /** EdgeMachine state when machine configured with target OS to deploy workloads */
  Purposed: "Purposed",

  /** EdgeMachine state when OS updates are in-progress */
  Updating: "Updating",

  /** EdgeMachine state when transitioning from target OS to restricted OS */
  Resetting: "Resetting",

  /** EdgeMachine failed state and only option to recover is to re-provisioning machine */
  Failed: "Failed",

  /** Preparing EdgeMachine */
  Preparing: "Preparing",
}

/** The provisioning state of a resource. */
@added(Versions.v2025_12_01_preview)
union EdgeMachineProvisioningState {
  string,

  /** The resource provision state is not specified */
  NotSpecified: "NotSpecified",

  /** Resource has been created. */
  Succeeded: "Succeeded",

  /** Resource creation failed. */
  Failed: "Failed",

  /** Resource creation was canceled. */
  Canceled: "Canceled",

  /** Resource creation is in progress. */
  InProgress: "InProgress",

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",
}

/** Reported properties for edge machine. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineReportedProperties {
  /** Last time data reported. */
  @visibility(Lifecycle.Read)
  lastUpdated?: utcDateTime;

  /** Network details for edge machine. */
  @visibility(Lifecycle.Read)
  networkProfile?: NetworkProfile;

  /** OS Properties for edge machine. */
  @visibility(Lifecycle.Read)
  osProfile?: OsProfile;

  /** Hardware related information for edge machine. */
  @visibility(Lifecycle.Read)
  hardwareProfile?: HardwareProfile;

  /** Storage related information for edge machine. */
  @visibility(Lifecycle.Read)
  storageProfile?: StorageProfile;

  /** Solution builder extension (SBE) deployment package information. */
  @visibility(Lifecycle.Read)
  sbeDeploymentPackageInfo?: EdgeMachineSbeDeploymentPackageInfo;

  /** Extension details for edge machine. */
  @visibility(Lifecycle.Read)
  extensionProfile?: EdgeMachineExtensionProfile;
}

/** NetworkProfile of edge machine. */
@added(Versions.v2025_12_01_preview)
model NetworkProfile {
  /** List of Network Interface Card (NIC) Details of edge machine. */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["adapterName"])
  nicDetails?: EdgeMachineNicDetail[];

  /** List of switch Details of edge machine. */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["switchName"])
  switchDetails?: EdgeMachineSwitchDetail[];
}

/** Network Interface Card (NIC) Details of edge machine. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineNicDetail {
  /**
   * Adapter Name of NIC
   */
  @visibility(Lifecycle.Read)
  adapterName?: string;

  /**
   * Interface Description of NIC
   */
  @visibility(Lifecycle.Read)
  interfaceDescription?: string;

  /**
   * Component Id of NIC
   */
  @visibility(Lifecycle.Read)
  componentId?: string;

  /**
   * Driver Version of NIC
   */
  @visibility(Lifecycle.Read)
  driverVersion?: string;

  /**
   * Subnet Mask of NIC
   */
  @visibility(Lifecycle.Read)
  ip4Address?: string;

  /**
   * Subnet Mask of NIC
   */
  @visibility(Lifecycle.Read)
  subnetMask?: string;

  /**
   * Default Gateway of NIC
   */
  @visibility(Lifecycle.Read)
  defaultGateway?: string;

  /**
   * DNS Servers for NIC
   */
  @visibility(Lifecycle.Read)
  dnsServers?: string[];

  /**
   * Default Isolation of Management NIC
   */
  @visibility(Lifecycle.Read)
  defaultIsolationId?: string;

  /**
   * MAC address information of NIC.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * The slot attached to the NIC.
   */
  @visibility(Lifecycle.Read)
  slot?: string;

  /**
   * The switch attached to the NIC, if any.
   */
  @visibility(Lifecycle.Read)
  switchName?: string;

  /**
   * The type of NIC, physical, virtual, management.
   */
  @visibility(Lifecycle.Read)
  nicType?: string;

  /**
   * The VLAN ID of the physical NIC.
   */
  @visibility(Lifecycle.Read)
  vlanId?: string;

  /**
   * The status of NIC, up, disconnected.
   */
  @visibility(Lifecycle.Read)
  nicStatus?: string;

  /**
   * Describes the RDMA capability of the network adapter.
   */
  @visibility(Lifecycle.Read)
  rdmaCapability?: EdgeMachineRdmaCapability = EdgeMachineRdmaCapability.Disabled;
}

/** Switch Details of edge machine. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineSwitchDetail {
  /**
   * The name of the switch.
   */
  @visibility(Lifecycle.Read)
  switchName?: string;

  /**
   * The type of the switch. e.g. external, internal.
   */
  @visibility(Lifecycle.Read)
  switchType?: string;

  /**
   * This represents extensions installed on virtualSwitch.
   */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["extensionName"])
  extensions?: EdgeMachineSwitchExtension[];
}

/**
 * This represents extensions installed on virtualSwitch.
 */
@added(Versions.v2025_12_01_preview)
model EdgeMachineSwitchExtension {
  /**
   * Unique identifier for virtualSwitch.
   */
  @visibility(Lifecycle.Read)
  switchId?: string;

  /**
   * This will show extension name for virtualSwitch.
   */
  @visibility(Lifecycle.Read)
  extensionName?: string;

  /**
   * This represents whether extension is enabled on virtualSwitch.
   */
  @visibility(Lifecycle.Read)
  extensionEnabled?: boolean;
}

/**
 * OS configurations for HCI device.
 */
@added(Versions.v2025_12_01_preview)
model OsProfile {
  /**
   * The boot type of the device. e.g. UEFI, Legacy etc
   */
  @visibility(Lifecycle.Read)
  bootType?: string;

  /**
   * Version of assembly present on device
   */
  @visibility(Lifecycle.Read)
  assemblyVersion?: string;

  /**
   * OS type (“windows", “linux”)
   */
  @visibility(Lifecycle.Read)
  osType?: string;

  /**
   * OS SKU (e.g., “ Microsoft Azure Linux ROE“, “Azure Stack HCI", "Microsoft Azure Linux 3.0")
   */
  @visibility(Lifecycle.Read)
  osSku?: string;

  /**
   * OS Version
   */
  @visibility(Lifecycle.Read)
  osVersion?: string;

  /**
   * OS Build Number
   */
  @visibility(Lifecycle.Read)
  buildNumber?: string;

  /**
   * OS Base Image Version
   */
  @visibility(Lifecycle.Read)
  baseImageVersion?: string;

  /**
   * OS Image Version
   */
  @visibility(Lifecycle.Read)
  imageVersion?: string;
}

/**
 * Describes the RDMA capability of the network adapter.
 */
@added(Versions.v2025_12_01_preview)
union EdgeMachineRdmaCapability {
  string,

  /**
   * Network Adapter on the device is RDMA Capable
   */
  Enabled: "Enabled",

  /**
   * Network Adapter on the device isn't RDMA Capable
   */
  Disabled: "Disabled",
}

/**
 * Hardware profile for the machine
 */
@added(Versions.v2025_12_01_preview)
model HardwareProfile {
  /**
   * Number of cpu cores in the machine
   */
  @visibility(Lifecycle.Read)
  cpuCores?: int64;

  /**
   * Number of cpu sockets in the machine
   */
  @visibility(Lifecycle.Read)
  cpuSockets?: int64;

  /**
   * Memory capacity of the machine
   */
  @visibility(Lifecycle.Read)
  memoryCapacityInGb?: int64;

  /**
   * Model info of the machine
   */
  @visibility(Lifecycle.Read)
  `model`?: string;

  /**
   * manufacturer info of the machine
   */
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  /**
   * Serial number of the machine
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * Process type of the machine
   */
  @visibility(Lifecycle.Read)
  processorType?: string;
}

/** StorageProfile of edge machine. */
@added(Versions.v2025_12_01_preview)
model StorageProfile {
  /** Number of storage disks in the device with $CanPool as true. */
  @visibility(Lifecycle.Read)
  poolableDisksCount?: int64;
}

/**
 * Solution builder extension (SBE) deployment package information.
 */
@added(Versions.v2025_12_01_preview)
model EdgeMachineSbeDeploymentPackageInfo {
  /**
   * SBE deployment validation code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * A detailed message that explains the SBE package validation result.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * This represents discovered update results for matching updates and store it as SBE manifest.
   */
  @visibility(Lifecycle.Read)
  sbeManifest?: string;
}

/**
 * Extensions details for edge device.
 */
@added(Versions.v2025_12_01_preview)
model EdgeMachineExtensionProfile {
  /**
   * List of Arc extensions installed on edge device.
   */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["extensionName"])
  extensions?: EdgeMachineExtension[];
}

/**
 * Arc extension installed on edge device.
 */
@added(Versions.v2025_12_01_preview)
model EdgeMachineExtension {
  /**
   * Arc extension name installed on edge device.
   */
  @visibility(Lifecycle.Read)
  extensionName?: string;

  /**
   * Arc extension state from arc machine extension.
   */
  @visibility(Lifecycle.Read)
  state?: EdgeMachineArcExtensionState;

  /**
   * Error details while installing Arc extension.
   */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  errorDetails?: ErrorDetailModel[];

  /**
   * Exception details while installing Arc extension.
   */
  @visibility(Lifecycle.Read)
  exception?: string;

  /**
   * Arc Extension Azure resource id.
   */
  @visibility(Lifecycle.Read)
  extensionResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Extension version installed.
   */
  @visibility(Lifecycle.Read)
  typeHandlerVersion?: string;

  /**
   * Extension managed by user or Azure.
   */
  @visibility(Lifecycle.Read)
  managedBy?: EdgeMachineExtensionManagedBy;
}

/**
 * Arc extension installation state.
 */
@added(Versions.v2025_12_01_preview)
union EdgeMachineArcExtensionState {
  string,

  /**
   * Arc extension state is not specified.
   */
  NotSpecified: "NotSpecified",

  /**
   * Arc extension state is Accepted when extension installation triggered.
   */
  Accepted: "Accepted",

  /**
   * Arc extension state is Canceled.
   */
  Canceled: "Canceled",

  /**
   * Arc extension is in Creating State.
   */
  Creating: "Creating",

  /**
   * Arc extension is in Deleted State.
   */
  Deleted: "Deleted",

  /**
   * Arc extension is in Deleting State.
   */
  Deleting: "Deleting",

  /**
   * Arc extension state is Failed.
   */
  Failed: "Failed",

  /**
   * Arc extension is in Moving State.
   */
  Moving: "Moving",

  /**
   * Arc extension state is Succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * Arc extension is in Updating State.
   */
  Updating: "Updating",
}

/**
 * details of validation failure
 */
@added(Versions.v2025_12_01_preview)
model ErrorDetailModel {
  /**
   * Exception details while installing extension.
   */
  @visibility(Lifecycle.Read)
  exception?: string;
}

/**
 * Extension managed by user or Azure.
 */
@added(Versions.v2025_12_01_preview)
union EdgeMachineExtensionManagedBy {
  string,

  /**
   * Extension managed by user.
   */
  User: "User",

  /**
   * Extension managed by Azure.
   */
  Azure: "Azure",
}

/** EdgeMachine Job properties */
@added(Versions.v2025_12_01_preview)
@discriminator("jobType")
model EdgeMachineJobProperties {
  /** Job Type to support polymorphic resource. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  jobType: EdgeMachineJobType;

  /** Deployment mode to trigger job. */
  deploymentMode?: EdgeMachineDeploymentMode;

  /** Job provisioning state */
  @visibility(Lifecycle.Read)
  provisioningState?: EdgeMachineProvisioningState;

  /** Unique, immutable job id. */
  @visibility(Lifecycle.Read)
  jobId?: string;

  /** The UTC date and time at which the job started. */
  @visibility(Lifecycle.Read)
  startTimeUtc?: utcDateTime;

  /** The UTC date and time at which the job completed. */
  @visibility(Lifecycle.Read)
  endTimeUtc?: utcDateTime;

  /** Status of Edge device job. */
  @visibility(Lifecycle.Read)
  status?: EdgeMachineJobStatus;

  /** error details. */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

/** Job Type supported. */
@added(Versions.v2025_12_01_preview)
union EdgeMachineJobType {
  string,

  /** Job to collect logs from the device. */
  CollectLog: "CollectLog",

  /** Job to provide remote support to the device. */
  RemoteSupport: "RemoteSupport",

  /** Job to provision operating system in the device. */
  ProvisionOs: "ProvisionOs",

  /** Job to download OS packages on to the device */
  DownloadOs: "DownloadOs",
}

/** Represents the various statuses a job can have throughout its lifecycle. */
@added(Versions.v2025_12_01_preview)
union EdgeMachineJobStatus {
  string,

  /** The job status has not been specified. */
  NotSpecified: "NotSpecified",

  /** The job is currently undergoing validation. */
  ValidationInProgress: "ValidationInProgress",

  /** The job has successfully passed validation. */
  ValidationSuccess: "ValidationSuccess",

  /** The job has failed validation. */
  ValidationFailed: "ValidationFailed",

  /** The job's deployment is currently in progress. */
  DeploymentInProgress: "DeploymentInProgress",

  /** The job's deployment has failed. */
  DeploymentFailed: "DeploymentFailed",

  /** The job has been successfully deployed. */
  DeploymentSuccess: "DeploymentSuccess",

  /** The job has succeeded. */
  Succeeded: "Succeeded",

  /** The job has failed. */
  Failed: "Failed",

  /** The job has been canceled. */
  Canceled: "Canceled",

  /** The job is paused. */
  Paused: "Paused",

  /** The job is scheduled to run. */
  Scheduled: "Scheduled",
}

/** Properties for adding a server in the cluster. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineRemoteSupportJobProperties extends EdgeMachineJobProperties {
  /** Job Type to support polymorphic resource. */
  jobType: EdgeMachineJobType.RemoteSupport;

  /** Remote support access level. */
  accessLevel: EdgeMachineRemoteSupportAccessLevel;

  /** Remote support expiration timestamp. */
  expirationTimestamp: utcDateTime;

  /** Remote support type. */
  type: EdgeMachineRemoteSupportType;

  /** log collection job reported properties. */
  @visibility(Lifecycle.Read)
  reportedProperties?: EdgeMachineRemoteSupportReportedProperties;
}

/** Represents the properties of an Azure Linux restricted operating environment Provision Os job. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineProvisionOsJobProperties extends EdgeMachineJobProperties {
  /** Job Type to support polymorphic resource. */
  jobType: EdgeMachineJobType.ProvisionOs;

  /** Os Provisioning request. */
  provisioningRequest: ProvisioningRequest;

  /** Reported Properties for Provision Os job */
  reportedProperties?: EdgeMachineProvisionOsReportedProperties;
}

/** Download Request properties */
@added(Versions.v2025_12_01_preview)
model DownloadRequest {
  /** Target operating system to support polymorphic resource. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  target: ProvisioningOsType;

  /** Operating system profile. */
  osProfile: DownloadOsProfile;
}

/** Represents the properties of Download Os job. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineDownloadOsJobProperties extends EdgeMachineJobProperties {
  /** Job Type to support polymorphic resource. */
  jobType: EdgeMachineJobType.DownloadOs;

  /** Download OS request. */
  downloadRequest: DownloadRequest;

  /** Reported Properties for Download Os job */
  reportedProperties?: EdgeMachineProvisionOsReportedProperties;
}

/** Reported Properties for Provision Os job */
@added(Versions.v2025_12_01_preview)
model EdgeMachineProvisionOsReportedProperties {
  ...EdgeMachineJobReportedProperties;
}

/** Represents a provisioning request. */
@added(Versions.v2025_12_01_preview)
model ProvisioningRequest {
  /** Target operating system to support polymorphic resource. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  target: ProvisioningOsType;

  /** Operating system profile. */
  osProfile: OsProvisionProfile;

  /** User configuration. */
  @Azure.ResourceManager.identifiers(#["userName"])
  userDetails?: UserDetails[];

  /** Onboarding configuration. */
  onboardingConfiguration?: OnboardingConfiguration;

  /** Device configuration. */
  deviceConfiguration?: EdgeMachineDeviceConfiguration;

  /** Base64 encoded custom configuration for CAPI to use */
  customConfiguration?: string;
}

/** Represents the provisioning operating system type. */
@added(Versions.v2025_12_01_preview)
union ProvisioningOsType {
  string,

  /** AzureLinux OS. */
  AzureLinux: "AzureLinux",

  /** HCI OS. */
  HCI: "HCI",
}

/** Represents the reported properties of a remote support job. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineRemoteSupportReportedProperties {
  ...EdgeMachineJobReportedProperties;

  /** Optional settings for configuring the node for remote support. */
  @visibility(Lifecycle.Read)
  nodeSettings?: EdgeMachineRemoteSupportNodeSettings;

  /** Details of the remote support session. */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["sessionId"])
  sessionDetails?: EdgeMachineRemoteSupportSession[];
}

/** Represents the settings of a remote support node. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineRemoteSupportNodeSettings {
  /** The state of the remote support node. */
  @visibility(Lifecycle.Read)
  state?: string;

  /** The timestamp when the node settings were created, in UTC. */
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  /** The timestamp when the node settings were last updated, in UTC. */
  @visibility(Lifecycle.Read)
  updatedAt?: utcDateTime;

  /** The current connection status of the remote support session. */
  @visibility(Lifecycle.Read)
  connectionStatus?: string;

  /** The error message, if any, from the last connection attempt. */
  @visibility(Lifecycle.Read)
  connectionErrorMessage?: string;
}

/** Represents a remote support session. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineRemoteSupportSession {
  /** Unique session Id. */
  @visibility(Lifecycle.Read)
  sessionId?: string;

  /** The start time of the remote support session, in UTC. */
  @visibility(Lifecycle.Read)
  sessionStartTime?: utcDateTime;

  /** The end time of the remote support session, in UTC. */
  @visibility(Lifecycle.Read)
  sessionEndTime?: utcDateTime;

  /** The level of access granted during the remote support session. */
  @visibility(Lifecycle.Read)
  accessLevel?: EdgeMachineRemoteSupportAccessLevel;

  /** The location where the session transcript is stored. */
  @visibility(Lifecycle.Read)
  transcriptLocation?: string;
}

/** Defines the level of remote support access granted. */
@added(Versions.v2025_12_01_preview)
union EdgeMachineRemoteSupportAccessLevel {
  /** A custom access level provided as a string. */
  string,

  /** No remote support access is granted. */
  None: "None",

  /** Access is limited to diagnostics information only. */
  Diagnostics: "Diagnostics",

  /** Access includes diagnostics information and the ability to perform repairs. */
  DiagnosticsAndRepair: "DiagnosticsAndRepair",
}

/** Defines the type of remote support action to be performed on an edge device. */
@added(Versions.v2025_12_01_preview)
union EdgeMachineRemoteSupportType {
  /** A custom action type provided as a string. */
  string,

  /** Enables remote support for the edge device. */
  Enable: "Enable",

  /** Revokes remote support access for the edge device. */
  Revoke: "Revoke",
}

/** Properties for pausing a server in the cluster. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineCollectLogJobProperties extends EdgeMachineJobProperties {
  /** ClusterJob Type to support polymorphic resource. */
  jobType: EdgeMachineJobType.CollectLog;

  /** From date for log collection. */
  fromDate: utcDateTime;

  /** To date for log collection. */
  toDate: utcDateTime;

  /** To date for log collection. */
  @visibility(Lifecycle.Read)
  lastLogGenerated?: utcDateTime;

  /** log collection job reported properties. */
  @visibility(Lifecycle.Read)
  reportedProperties?: EdgeMachineLogCollectionReportedProperties;
}

/** Represents the reported properties of a log collection job. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineLogCollectionReportedProperties {
  ...EdgeMachineJobReportedProperties;

  /** Details of the log collection session. */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["correlationId"])
  logCollectionSessionDetails?: EdgeMachineLogCollectionSession[];
}

/** Represents a session for collecting logs from an edge device. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineLogCollectionSession {
  /** The timestamp when log collection started, in ISO 8601 format. */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /** The timestamp when log collection ended, in ISO 8601 format. */
  @visibility(Lifecycle.Read)
  endTime?: string;

  /** The total time logs were collected for, in ISO 8601 duration format. */
  @visibility(Lifecycle.Read)
  timeCollected?: string;

  /** The size of the collected logs in bytes. */
  @visibility(Lifecycle.Read)
  logSize?: int32;

  /** The status of the log collection session. */
  @visibility(Lifecycle.Read)
  status?: EdgeMachineDeviceLogCollectionStatus;

  /** A unique identifier for correlating this log collection session with other operations or sessions. */
  @visibility(Lifecycle.Read)
  correlationId?: string;
}

/** Reported Properties for job triggered from cloud. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineJobReportedProperties {
  /** The percentage of the job that is complete. */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /** Validation status of job. */
  @visibility(Lifecycle.Read)
  validationStatus?: EdgeMachineEceActionStatus;

  /** Deployment status of job. */
  @visibility(Lifecycle.Read)
  deploymentStatus?: EdgeMachineEceActionStatus;
}

/** Represents the status of a log collection operation. */
@added(Versions.v2025_12_01_preview)
union EdgeMachineDeviceLogCollectionStatus {
  /** A custom status provided as a string. */
  string,

  /** Log collection operation has not been initiated. */
  NotStarted: "NotStarted",

  /** Indicates that the log collection operation is currently running. */
  Running: "Running",

  /** Indicates that the log collection operation has failed. */
  Failed: "Failed",

  /** Indicates that the log collection operation has completed successfully. */
  Succeeded: "Succeeded",

  /** Indicates that the log collection operation has completed successfully. */
  Canceled: "Canceled",
}

/** Validation / deployment status details for Job. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineEceActionStatus {
  /** Job status. */
  @visibility(Lifecycle.Read)
  status?: string;

  /** List of steps of Edge device job. */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  steps?: EdgeMachineStep[];
}

/** Deployment mode to trigger job. */
@added(Versions.v2025_12_01_preview)
union EdgeMachineDeploymentMode {
  string,

  /** Validate ECE action deployment for a cluster. */
  Validate: "Validate",

  /** Deploy ECE action deployment for a cluster. */
  Deploy: "Deploy",
}

/** Step details during job execution. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineStep {
  /** Name of step. */
  @visibility(Lifecycle.Read)
  name?: string;

  /** Description of step. */
  @visibility(Lifecycle.Read)
  description?: string;

  /** FullStepIndex of step. */
  @visibility(Lifecycle.Read)
  fullStepIndex?: string;

  /** Start time in utc of step. */
  @visibility(Lifecycle.Read)
  startTimeUtc?: string;

  /** End time in utc of step. */
  @visibility(Lifecycle.Read)
  endTimeUtc?: string;

  /** Status of step. Allowed values are 'Error', 'Success', 'InProgress' */
  @visibility(Lifecycle.Read)
  status?: string;

  /** List of nested steps during job execution.. */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  steps?: EdgeMachineStep[];

  /** List of exceptions in job execution. */
  @visibility(Lifecycle.Read)
  exception?: string[];

  /** Error information for the step */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

/** Operating system profile. */
@added(Versions.v2025_12_01_preview)
model OsProvisionProfile {
  /** Name of the operating system. */
  osName?: string;

  /** Type of the operating system. */
  osType?: string;

  /** Version of the operating system. */
  osVersion?: string;

  /** Location of the operating system image. */
  osImageLocation?: string;

  /** Validated Solution Recipe version to be used for the job */
  vsrVersion?: string;

  /** Hash of the OS package downloaded */
  imageHash?: string;

  /** GPG Public Key used for package verification */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "GPG Public Key is not sensitive information"
  gpgPubKey?: string;

  /** Operation sub type of OS Provisioning */
  operationType?: OSOperationType = OSOperationType.Provision;
}

/** Operating system profile. */
@added(Versions.v2025_12_01_preview)
model DownloadOsProfile {
  /** Name of the operating system. */
  osName?: string;

  /** Type of the operating system. */
  osType?: string;

  /** Version of the operating system. */
  osVersion?: string;

  /** Location of the operating system image. */
  osImageLocation?: string;

  /** Validated Solution Recipe version to be used for the job */
  vsrVersion?: string;

  /** Hash of the OS package downloaded */
  imageHash?: string;

  /** GPG Public Key used for package verification */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "GPG Public Key is not sensitive information"
  gpgPubKey?: string;
}

/** OS Provision Operation type */
@added(Versions.v2025_12_01_preview)
union OSOperationType {
  string,

  /** OS Provisioning operation */
  Provision: "Provision",

  /** OS Update operation */
  Update: "Update",

  /** OS ReImage operation */
  ReImage: "ReImage",
}

/** Type of secret used for authentication. */
@added(Versions.v2025_12_01_preview)
union SecretType {
  string,

  /** Key Vault based authentication */
  KeyVault: "KeyVault",

  /** SSH Public Key based authentication */
  SshPubKey: "SshPubKey",
}

/** User configuration. */
@added(Versions.v2025_12_01_preview)
model UserDetails {
  /** Name of the user. */
  userName: string;

  /** Type of the secret used for authentication. */
  secretType: SecretType;

  /** Location of the secret used for authentication. */
  secretLocation?: string;

  /** SSH Public Key for the user. */
  sshPubKey?: string[];
}

/** Onboarding resource type. */
@added(Versions.v2025_12_01_preview)
union OnboardingResourceType {
  string,

  /** Hybrid Compute Machine. */
  HybridComputeMachine: "HybridComputeMachine",
}

/** Onboarding configuration. */
@added(Versions.v2025_12_01_preview)
model OnboardingConfiguration {
  /** Type of the onboarding resource to support polymorphic resource. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  type?: OnboardingResourceType;

  /** Resource ID. */
  resourceId?: Azure.Core.armResourceIdentifier;

  /** Location of the resource. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;

  /** Tenant ID of the resource. */
  tenantId?: string;

  /** Azure Arc virtual machine ID. */
  arcVirtualMachineId?: string;
}

/** Device configuration. */
@added(Versions.v2025_12_01_preview)
model EdgeMachineDeviceConfiguration {
  /** Network configuration. */
  network?: NetworkConfiguration;

  /** Hostname of the device. */
  hostName?: string;

  /** Web proxy configuration. */
  webProxy?: WebProxyConfiguration;

  /** Time configuration. */
  time?: TimeConfiguration;

  /** Storage configuration. */
  storage?: StorageConfiguration;
}

/** Network configuration. */
@added(Versions.v2025_12_01_preview)
model NetworkConfiguration {
  /** List of network adapters. */
  @Azure.ResourceManager.identifiers(#[])
  networkAdapters?: NetworkAdapter[];
}

/** Storage configuration. */
@added(Versions.v2025_12_01_preview)
model StorageConfiguration {
  /** Partition size. */
  partitionSize?: string;
}

/** Network adapter configuration. */
@added(Versions.v2025_12_01_preview)
model NetworkAdapter {
  /** Type of IP assignment. */
  ipAssignmentType: IpAssignmentType;

  /** IP address. */
  ipAddress?: string;

  /** Adapter Name. */
  adapterName?: string;

  /** MAC address. */
  macAddress?: string;

  /** IP address range. */
  ipAddressRange?: IpAddressRange;

  /** Gateway id. */
  gateway?: string;

  /** Subnet mask. */
  subnetMask?: string;

  /** Array of DNS addresses. */
  dnsAddressArray?: string[];

  /** VLAN ID for the network setup. */
  vlanId?: string;
}

/** IP assignment types */
@added(Versions.v2025_12_01_preview)
union IpAssignmentType {
  string,

  /** Automatic IP assignment */
  Automatic: "Automatic",

  /** Manual IP assignment */
  Manual: "Manual",
}

/** IP address range configuration. */
@added(Versions.v2025_12_01_preview)
model IpAddressRange {
  /** Start IP address. */
  startIp: string;

  /** End IP address. */
  endIp: string;
}

/** Web proxy configuration. */
@added(Versions.v2025_12_01_preview)
model WebProxyConfiguration {
  /** Connection URI of the web proxy. */
  connectionUri?: url;

  /** Port of the web proxy. */
  @pattern("^[0-9]{0,5}$")
  port?: string;

  /** Bypass list for the web proxy. */
  bypassList?: url[];
}

/** Time configuration. */
@added(Versions.v2025_12_01_preview)
model TimeConfiguration {
  /** Primary NTP server. */
  primaryTimeServer?: string;

  /** Secondary NTP server. */
  secondaryTimeServer?: string;

  /** Time zone. */
  timeZone?: string;
}

/** Validate Ownership Voucher Request */
@added(Versions.v2025_12_01_preview)
model ValidateOwnershipVouchersRequest {
  /** Ownership Voucher Details. */
  @identifiers(#[])
  @minItems(1)
  ownershipVoucherDetails: OwnershipVoucherDetails[];
}

/** Validate Ownership Voucher Response */
@added(Versions.v2025_12_01_preview)
model ValidateOwnershipVouchersResponse {
  /** Ownership Voucher Validation Details. */
  @identifiers(#["id"])
  ownershipVoucherValidationDetails: OwnershipVoucherValidationDetails[];
}

/** Ownership Voucher Validation Details */
@added(Versions.v2025_12_01_preview)
model OwnershipVoucherValidationDetails {
  /** The ownership voucher validation status. */
  validationStatus?: OwnershipVoucherValidationStatus;

  /** Serial number of the device. */
  serialNumber?: string;

  /** FDO guid of the Ownership Voucher. */
  id?: string;

  /** Name of the manufacturer. */
  manufacturer?: string;

  /** Name of the model. */
  modelName?: string;

  /** Version of the Ownership Voucher format */
  version?: string;

  /** Azure Machine Id of the Ownership voucher */
  azureMachineId?: string;

  /** Error details if the validation failed. */
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/** Ownership Voucher validation Status. */
@added(Versions.v2025_12_01_preview)
union OwnershipVoucherValidationStatus {
  string,

  /** Voucher evaluated as valid. */
  Valid: "Valid",

  /** Voucher evaluated as invalid. */
  Invalid: "Invalid",
}
