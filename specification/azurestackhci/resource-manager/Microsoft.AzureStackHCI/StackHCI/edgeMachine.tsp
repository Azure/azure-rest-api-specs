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

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("EdgeMachine details.")
model EdgeMachine
  is Azure.ResourceManager.TrackedResource<EdgeMachineProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachine,
    KeyName = "edgeMachineName",
    SegmentName = "edgeMachines",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
  ...ManagedServiceIdentityProperty;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@armResourceOperations
interface EdgeMachines {
  @doc("Get an edge machine.")
  get is ArmResourceRead<EdgeMachine>;

  @doc("Create or update an edge machine.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeMachine>;

  @doc("Update an edge machine.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<EdgeMachine, EdgeMachinePatch>;

  @doc("Delete an edge machine.")
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachine>;

  @doc("List all edge machines in a resource group.")
  listByResourceGroup is ArmResourceListByParent<EdgeMachine>;

  @doc("List all edge machines in a subscription.")
  listBySubscription is ArmListBySubscription<EdgeMachine>;
}

@@doc(EdgeMachine.name, "Name of Device");

////////////////////// models //////////////////////

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Edge Machine Kind.")
union EdgeMachineKind {
  string,

  @doc("EdgeMachine resource created using Zero-touch provisioning.")
  Standard: "Standard",

  @doc("EdgeMachine resource created for brownfield HCI customers without zero touch provisioning.")
  Dedicated: "Dedicated",
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Properties for edge machine.")
model EdgeMachineProperties {
  @doc("Edge Machine type.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  edgeMachineKind?: EdgeMachineKind;

  @doc("The provisioning state of a resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Unique, immutable resource id.")
  @visibility(Lifecycle.Read)
  cloudId?: string;

  @doc("Optional property to create arc machine in custom resource group.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  arcMachineResourceGroupId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Resources/resourceGroups";
    }
  ]>;

  @doc("Arc machine instance resource id.")
  arcMachineResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/machines";
    }
  ]>;

  @doc("Link to Arc Gateway ARM resource Id")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  arcGatewayResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/gateways";
    }
  ]>;

  @doc("Service fetches common configuration from site.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  siteDetails?: SiteDetails;

  @doc("Ownership voucher details for provisioned machine.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ownershipVoucherDetails?: OwnershipVoucherDetails;

  @doc("Details for device provisioning.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  provisioningDetails?: ProvisioningDetails;

  @doc("A machine can only be assigned to single device pool")
  @visibility(Lifecycle.Read)
  devicePoolResourceId?: string;

  @doc("OS configuration status details ")
  @visibility(Lifecycle.Read)
  machineState?: EdgeMachineState;

  @doc("machine connectivity status")
  @visibility(Lifecycle.Read)
  connectivityStatus?: EdgeMachineConnectivityStatus;

  @doc("Tracks the ID of the consuming resource, setting the machine as in-use.")
  @visibility(Lifecycle.Read)
  claimedBy?: string;

  @doc("Reported properties for edge machine.")
  @visibility(Lifecycle.Read)
  reportedProperties?: EdgeMachineReportedProperties;

  @doc("operation status details for edge machine.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  operationDetails?: OperationDetail[];

  @doc("Last time data updated to service.")
  @visibility(Lifecycle.Read)
  lastSyncTimestamp?: utcDateTime;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Model for patching edge machine.")
model EdgeMachinePatch {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * Details for device provisioning.
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
model ProvisioningDetails {
  @doc("Operating system profile.")
  osProfile: OsProvisionProfile;

  @doc("User configuration.")
  @minItems(1)
  @Azure.ResourceManager.identifiers(#["userName"])
  userDetails?: UserDetails[];
}

/**
 * Details for ownership voucher.
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
model OwnershipVoucherDetails {
  @doc("Ownership voucher in base64 encoded format")
  @secret
  ownershipVoucher: string;

  @doc("Owner key type")
  ownerKeyType: OwnerKeyType;
}

/**
 * Type of owner key in the voucher
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
union OwnerKeyType {
  string,

  @doc("Owner is Microsoft managed key")
  MicrosoftManaged: "MicrosoftManaged",
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("operation detail.")
model OperationDetail {
  @doc("operation name.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("operation id.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("operation type.")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("operation resource id.")
  @visibility(Lifecycle.Read)
  resourceId?: armResourceIdentifier;

  @doc("operation description.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("operation status.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("error details.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Overall connectivity status for the machine resource.")
union EdgeMachineConnectivityStatus {
  string,

  @doc("The connectivity status of the machine resource is not specified.")
  NotSpecified: "NotSpecified",

  @doc("The machine resource is disconnected.")
  Disconnected: "Disconnected",

  @doc("The machine resource is connected.")
  Connected: "Connected",
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Site Details consists of common configurations.")
model SiteDetails {
  @doc("Site resource Id to be set during Edge Machine resource creation.")
  siteResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/sites";
    }
  ]>;

  @doc("Edge Device configuration received from site common configuration.")
  deviceConfiguration?: TargetDeviceConfiguration;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
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

  @doc("Preparing EdgeMachine")
  Preparing: "Preparing",
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Reported properties for edge machine.")
model EdgeMachineReportedProperties {
  @doc("Last time data reported.")
  @visibility(Lifecycle.Read)
  lastUpdated?: utcDateTime;

  @doc("Network details for edge machine.")
  @visibility(Lifecycle.Read)
  networkProfile?: EdgeMachineNetworkProfile;

  @doc("OS Properties for edge machine.")
  @visibility(Lifecycle.Read)
  osProfile?: OsProfile;

  @doc("Hardware related information for edge machine.")
  @visibility(Lifecycle.Read)
  hardwareProfile?: HardwareProfile;

  @doc("Storage related information for edge machine.")
  @visibility(Lifecycle.Read)
  storageProfile?: StorageProfile;

  @doc("Solution builder extension (SBE) deployment package information.")
  @visibility(Lifecycle.Read)
  sbeDeploymentPackageInfo?: SbeDeploymentPackageInfo;

  @doc("Extension details for edge machine.")
  @visibility(Lifecycle.Read)
  extensionProfile?: ExtensionProfile;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("NetworkProfile of edge machine.")
model EdgeMachineNetworkProfile {
  @doc("List of Network Interface Card (NIC) Details of edge machine.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["adapterName"])
  nicDetails?: EdgeMachineNicDetail[];

  @doc("List of switch Details of edge machine.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["switchName"])
  switchDetails?: SwitchDetail[];
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Network Interface Card (NIC) Details of edge machine.")
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
  rdmaCapability?: RdmaCapability = RdmaCapability.Disabled;
}

/**
 * OS configurations for HCI device.
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
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
 * Hardware profile for the machine
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
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

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("StorageProfile of edge machine.")
model StorageProfile {
  @doc("Number of storage disks in the device with $CanPool as true.")
  @visibility(Lifecycle.Read)
  poolableDisksCount?: int64;
}
/**
 * details of validation failure
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
model ErrorDetailModel {
  /**
   * Exception details while installing extension.
   */
  @visibility(Lifecycle.Read)
  exception?: string;
}
