import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

@doc("EdgeMachine details.")
model EdgeMachine
  is Azure.ResourceManager.TrackedResource<EdgeMachineProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachine,
    KeyName = "edgeMachineName",
    SegmentName = "edgeMachines",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;
  ...ManagedServiceIdentityProperty;
}

@doc("Edge Machine Kind.")
union EdgeMachineKind {
  string,

  @doc("EdgeMachine resource created using Zero-touch provisioning flow")
  Standard: "Standard",

  @doc("EdgeMachine resource created for brownfield HCI customers without zero touch")
  Dedicated: "Dedicated",
}

@armResourceOperations
interface EdgeMachines {
  /**
   * Get a EdgeDevice
   */
  get is ArmResourceRead<EdgeMachine>;

  /**
   * Create a EdgeDevice
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeMachine>;

  /**
   * Delete a EdgeDevice
   */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachine>;

  @doc("List all edge machines in a resource group.")
  listByResourceGroup is ArmResourceListByParent<EdgeMachine>;

  @doc("List all edge machines in a subscription.")
  listBySubscription is ArmListBySubscription<EdgeMachine>;

  @doc("Update an edgeMachine")
  @parameterVisibility
  update is ArmCustomPatchAsync<EdgeMachine, EdgeMachinePatch>;
}

@@doc(EdgeMachine.name, "Name of Device");

//////////////////////models//////////////////////

@doc("Properties for edge machine.")
model EdgeMachineProperties {
  @doc("Edge Machine type.")
  @visibility("read", "create")
  kind?: EdgeMachineKind;

  @doc("The provisioning state of a resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Resource group where the onboarding arc machine instance created.")
  onboardingMachineResourceGroupId?: Azure.Core.armResourceIdentifier;

  @doc("Optional property to create arc machine in custom resource group.")
  arcMachineResourceGroupId?: Azure.Core.armResourceIdentifier;

  @doc("Arc machine instance resource id.")
  arcMachineResourceId?: Azure.Core.armResourceIdentifier;

  @doc("Link to Arc Gateway ARM resource Id")
  arcGatewayResourceId?: Azure.Core.armResourceIdentifier;

  @doc("Service fetches common configuration from site.")
  siteDetails?: SiteDetails;

  @doc("A machine can only be assigned to single device pool")
  @visibility("read")
  devicePoolResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/devicePools";
    }
  ]>;

  @doc("OS configuration status details ")
  @visibility("read")
  machineState?: EdgeMachineState;

  @doc("selection labels that can be used by CMP to decide which all machines can be part of this device pool")
  @OpenAPI.extension("x-ms-identifiers", ["labelName"])
  labels?: Labels[];

  @doc("Tracks the ID of the consuming resource, marking the machine as in-use.")
  @visibility("read")
  claimedBy?: Azure.Core.armResourceIdentifier;

  @doc("Reported properties for edge machine.")
  @visibility("read")
  reportedProperties?: ReportedProperties;
}

@doc("Site Details consists of common configurations.")
model SiteDetails {
  @doc("Site resource Id set EM resource creation, once set can be reset only on EdgeMachine Reset API invocation.")
  siteResourceId: Azure.Core.armResourceIdentifier;

  @doc("Edge Device configuration received from site common configuration.")
  @visibility("read")
  deviceConfiguration?: DeviceConfiguration;
}

@doc("Model for patching edge machine.")
model EdgeMachinePatch {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  @doc("Properties for patching edge machine.")
  properties?: EdgeMachinePatchProperties;
}

@doc("Properties for patching edge machine.")
model EdgeMachinePatchProperties {
  @doc("Service fetches common configuration from site.")
  siteDetails?: SiteDetails;

  @doc("selection labels that can be used by CMP to decide which all machines can be part of this device pool")
  @OpenAPI.extension("x-ms-identifiers", ["labelName"])
  labels?: Labels[];
}

@doc("selection labels that can be used by CMP to decide which all machines can be part of this device pool")
model Labels {
  @doc("Name of label")
  labelName?: string;

  @doc("Value of label")
  labelValue?: string;
}

@doc("OS State")
union EdgeMachineState {
  string,

  @doc("Created when EdgeMachine resource created")
  Created: "Created",

  @doc("EdgeMachine state during device discovery and registration")
  Registering: "Registering",

  @doc("EdgeMachine state when machine configured with restricted OS and not provisioned to deploy workloads")
  Unpurposed: "Unpurposed",

  @doc("EdgeMachine state when transitioning from initial OS to target OS")
  Transitioning: "Transitioning",

  @doc("EdgeMachine state when machine configured with target OS to deploy workloads")
  Purposed: "Purposed",

  @doc("EdgeMachine state when OS updates are in-progress")
  Updating: "Updating",

  @doc("EdgeMachine state when transitioning from target OS to restricted OS")
  Resetting: "Resetting",

  @doc("EdgeMachine failed state and only option to recover is to re-provisioning machine")
  Failed: "Failed",
}

@doc("Order Item Details")
model OrderDetails {
  @visibility("read")
  @doc("Details for voucher ownership")
  deviceIdentity?: string;

  @visibility("read")
  @doc("TPM endorsement key")
  tpmEndorsementKey?: string;
}

@doc("The provisioning state of a resource.")
union ProvisioningState {
  string,

  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",

  @doc("Resource creation is in progress.")
  InProgress: "InProgress",

  @doc("The resource provision state is not specified")
  NotSpecified: "NotSpecified",

  @doc("The resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",
}

@doc("Reported properties for edge machine.")
model ReportedProperties {
  @doc("Network details for edge machine.")
  @visibility("read")
  networkProfile?: NetworkProfile;

  @doc("OS Properties for edge machine.")
  @visibility("read")
  osProfile?: OsProfile;

  @doc("Hardware related information for edge machine.")
  @visibility("read")
  hardwareProfile?: HardwareProfile;

  @doc("Storage related information for edge machine.")
  @visibility("read")
  storageProfile?: StorageProfile;

  @doc("Solution builder extension (SBE) deployment package information.")
  @visibility("read")
  sbeDeploymentPackageInfo?: SbeDeploymentPackageInfo;

  @doc("Extension details for edge machine.")
  @visibility("read")
  extensionProfile?: ExtensionProfile;
}

@doc("NetworkProfile of edge machine.")
model NetworkProfile {
  @doc("List of NIC Details of edge machine.")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["adapterName"])
  nicDetails?: NicDetail[];

  @doc("List of switch Details of edge machine.")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["switchName"])
  switchDetails?: SwitchDetail[];
}

@doc("NIC Details of edge machine.")
model NicDetail {
  /**
   * Adapter Name of NIC
   */
  @visibility("read")
  adapterName?: string;

  /**
   * Interface Description of NIC
   */
  @visibility("read")
  interfaceDescription?: string;

  /**
   * Component Id of NIC
   */
  @visibility("read")
  componentId?: string;

  /**
   * Driver Version of NIC
   */
  @visibility("read")
  driverVersion?: string;

  /**
   * Subnet Mask of NIC
   */
  @visibility("read")
  ip4Address?: string;

  /**
   * Subnet Mask of NIC
   */
  @visibility("read")
  subnetMask?: string;

  /**
   * Default Gateway of NIC
   */
  @visibility("read")
  defaultGateway?: string;

  /**
   * DNS Servers for NIC
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  dnsServers?: string[];

  /**
   * Default Isolation of Management NIC
   */
  @visibility("read")
  defaultIsolationId?: string;

  /**
   * MAC address information of NIC.
   */
  @visibility("read")
  macAddress?: string;

  /**
   * The slot attached to the NIC.
   */
  @visibility("read")
  slot?: string;

  /**
   * The switch attached to the NIC, if any.
   */
  @visibility("read")
  switchName?: string;

  /**
   * The type of NIC, physical, virtual, management.
   */
  @visibility("read")
  nicType?: string;

  /**
   * The VLAN ID of the physical NIC.
   */
  @visibility("read")
  vlanId?: string;

  /**
   * The status of NIC, up, disconnected.
   */
  @visibility("read")
  nicStatus?: string;

  /**
   * Describes the RDMA capability of the network adapter.
   */
  @visibility("read")
  rdmaCapability?: RdmaCapability = RdmaCapability.Disabled;
}

@doc("Switch Details of edge machine.")
model SwitchDetail {
  /**
   * The name of the switch.
   */
  @visibility("read")
  switchName?: string;

  /**
   * The type of the switch. e.g. external, internal.
   */
  @visibility("read")
  switchType?: string;

  /**
   * This represents extensions installed on virtualSwitch.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["extensionName"])
  extensions?: SwitchExtension[];
}

/**
 * This represents extensions installed on virtualSwitch.
 */
model SwitchExtension {
  /**
   * Unique identifier for virtualSwitch.
   */
  @visibility("read")
  switchId?: string;

  /**
   * This will show extension name for virtualSwitch.
   */
  @visibility("read")
  extensionName?: string;

  /**
   * This represents whether extension is enabled on virtualSwitch.
   */
  @visibility("read")
  extensionEnabled?: boolean;
}

/**
 * OS configurations for HCI device.
 */
model OsProfile {
  /**
   * The boot type of the device. e.g. UEFI, Legacy etc
   */
  @visibility("read")
  bootType?: string;

  /**
   * Version of assembly present on device
   */
  @visibility("read")
  assemblyVersion?: string;

  /**
   * OS type (“windows", “linux”)
   */
  @visibility("read")
  osType?: string;

  /**
   * OS SKU (e.g., “ Microsoft Azure Linux ROE“, “Azure Stack HCI", "Microsoft Azure Linux 3.0")
   */
  @visibility("read")
  osSku?: string;

  /**
   * OS Version
   */
  @visibility("read")
  osVersion?: string;
}

/**
 * Describes the RDMA capability of the network adapter.
 */
union RdmaCapability {
  string,

  /**
   * Network Adapter on the device is RDMA Capable
   */
  Enabled: "Enabled",

  /**
   * Network Adapter on the device is RDMA Capable
   */
  Disabled: "Disabled",
}

/**
 * Hardware profile for the machine
 */
model HardwareProfile {
  /**
   * Number of cpu cores in the machine
   */
  @visibility("read")
  cpuCores?: int64;

  /**
   * Number of cpu sockets in the machine
   */
  @visibility("read")
  cpuSockets?: int64;

  /**
   * Memory capacity of the machine
   */
  @visibility("read")
  memoryCapacityInGb?: int64;

  /**
   * Model info of the machine
   */
  @visibility("read")
  `model`?: string;

  /**
   * manufacturer info of the machine
   */
  @visibility("read")
  manufacturer?: string;

  /**
   * Serial number of the machine
   */
  @visibility("read")
  serialNumber?: string;

  /**
   * Process type of the machine
   */
  @visibility("read")
  processorType?: string;
}

@doc("StorageProfile of edge machine.")
model StorageProfile {
  @doc("Number of storage disks in the device with $CanPool as true.")
  @visibility("read")
  poolableDisksCount?: int64;
}

/**
 * Solution builder extension (SBE) deployment package information.
 */
model SbeDeploymentPackageInfo {
  /**
   * SBE deployment validation code.
   */
  @visibility("read")
  code?: string;

  /**
   * A detailed message that explains the SBE package validation result.
   */
  @visibility("read")
  message?: string;

  /**
   * This represents discovered update results for matching updates and store it as SBE manifest.
   */
  @visibility("read")
  sbeManifest?: string;
}

/**
 * Extensions details for edge device.
 */
model ExtensionProfile {
  /**
   * List of Arc extensions installed on edge device.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["extensionName"])
  extensions?: Extension[];
}

/**
 * Arc extension installed on edge device.
 */
model Extension {
  /**
   * Arc extension name installed on edge device.
   */
  @visibility("read")
  extensionName?: string;

  /**
   * Arc extension state from arc machine extension.
   */
  @visibility("read")
  state?: ArcExtensionState;

  /**
   * Error details while installing Arc extension.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  errorDetails?: ErrorDetailModel[];

  /**
   * Exception details while installing Arc extension.
   */
  @visibility("read")
  exception?: string;

  /**
   * Arc Extension Azure resource id.
   */
  @visibility("read")
  extensionResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Extension version installed.
   */
  @visibility("read")
  typeHandlerVersion?: string;

  /**
   * Extension managed by user or Azure.
   */
  @visibility("read")
  managedBy?: ExtensionManagedBy;
}

/**
 * Arc extension installation state.
 */
union ArcExtensionState {
  string,

  /**
   * Arc extension state is not specified.
   */
  NotSpecified: "NotSpecified",

  /**
   * Arc extension state is Succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * Arc extension state is Failed.
   */
  Failed: "Failed",

  /**
   * Arc extension state is Canceled.
   */
  Canceled: "Canceled",

  /**
   * Arc extension state is Accepted when extension installation triggered.
   */
  Accepted: "Accepted",

  /**
   * Arc extension is in Creating State.
   */
  Creating: "Creating",

  /**
   * Arc extension is in Updating State.
   */
  Updating: "Updating",

  /**
   * Arc extension is in Moving State.
   */
  Moving: "Moving",

  /**
   * Arc extension is in Deleting State.
   */
  Deleting: "Deleting",

  /**
   * Arc extension is in Deleted State.
   */
  Deleted: "Deleted",
}

/**
 * details of validation failure
 */
model ErrorDetailModel {
  /**
   * Exception details while installing extension.
   */
  @visibility("read")
  exception?: string;
}

/**
 * Extension managed by user or Azure.
 */
union ExtensionManagedBy {
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
