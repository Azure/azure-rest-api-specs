import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.ScVmm;

interface Operations extends Azure.ResourceManager.Operations {}

alias VmmServerId = ResourceIdentifier<[
  {
    type: "Microsoft.ScVmm/vmmServers";
  }
]>;

alias VirtualNetworkId = ResourceIdentifier<[
  {
    type: "Microsoft.ScVmm/virtualNetwork";
  }
]>;

/** A reusable query option to force delete a resource. */
model QueryForceDelete {
  /** Forces the resource to be deleted. */
  @query("force")
  force?: boolean;
}

/** The provisioning state of the resource. */
enum ResourceProvisioningState {
  ...Azure.ResourceManager.ResourceProvisioningState,

  /** The resource is provisioning. */
  Provisioning,

  /** The resource is updating. */
  Updating,

  /** The resource is being deleted. */
  Deleting,

  /** The resource has been accepted. */
  Accepted,

  /** The resource was created. */
  Created,
}

/** Virtual machine operating system type. */
enum OsType {
  /** Windows operating system. */
  Windows,

  /** Linux operating system. */
  Linux,

  /** Other operating system. */
  Other,
}

/** Network address allocation method. */
enum AllocationMethod {
  /** Dynamically allocated address. */
  Dynamic,

  /** Statically allocated address. */
  Static,
}

/** Guest agent provisioning action. */
enum ProvisioningAction {
  /** Install guest agent. */
  install,

  /** Uninstall guest agent. */
  uninstall,

  /** Repair guest agent. */
  repair,
}

/** Limit CPU for migration. */
enum LimitCpuForMigration {
  /** Enable limit CPU for migration. */
  `true`,

  /** Disable limit CPU for migration. */
  `false`,
}

/** Dynamic memory enabled. */
enum DynamicMemoryEnabled {
  /** Enable dynamic memory. */
  `true`,

  /** Disable dynamic memory. */
  `false`,
}

/** Highly available. */
enum IsHighlyAvailable {
  /** Enable highly available. */
  `true`,

  /** Disable highly available. */
  `false`,
}

/** Create diff disk. */
enum CreateDiffDisk {
  /** Enable create diff disk. */
  `true`,

  /** Disable create diff disk. */
  `false`,
}

/** Customizable. */
enum IsCustomizable {
  /** Enable customizable. */
  `true`,

  /** Disable customizable. */
  `false`,
}

/** Skip shutdown. */
enum SkipShutdown {
  /** Enable skip shutdown. */
  `true`,

  /** Disable skip shutdown. */
  `false`,
}

/** Defines the resource properties. */
model VmmServerProperties {
  /** Credentials to connect to VmmServer. */
  credentials?: VmmCredential;

  /** Fqdn is the hostname/ip of the vmmServer. */
  @minLength(1)
  fqdn: string;

  /** Port is the port on which the vmmServer is listening. */
  @minValue(1)
  @maxValue(65535)
  port?: int32;

  /** Gets the connection status to the vmmServer. */
  @visibility("read")
  connectionStatus?: string;

  /** Gets any error message if connection to vmmServer is having any issue. */
  @visibility("read")
  errorMessage?: string;

  /** Unique ID of vmmServer. */
  @visibility("read")
  uuid?: string;

  /** Version is the version of the vmmSever. */
  @visibility("read")
  version?: string;

  /** Provisioning state of the resource. */
  @visibility("read")
  provisioningState?: Microsoft.ScVmm.ResourceProvisioningState;
}

/** Credentials to connect to VmmServer. */
model VmmCredential {
  /** Username to use to connect to VmmServer. */
  username?: string;

  /** Password to use to connect to VmmServer. */
  @visibility("create", "update")
  @secret
  password?: string;
}

/** The extended location. */
model ExtendedLocation {
  /** The extended location type. */
  type?: string;

  /** The extended location name. */
  name?: string;
}

/** Defines the resource properties. */
model CloudProperties {
  /** Gets or sets the inventory Item ID for the resource. */
  inventoryItemId?: string;

  /** Unique ID of the cloud. */
  @minLength(1)
  uuid?: string;

  /** ARM Id of the vmmServer resource in which this resource resides. */
  vmmServerId?: VmmServerId;

  /** Name of the cloud in VmmServer. */
  @visibility("read")
  cloudName?: string;

  /** Capacity of the cloud. */
  @visibility("read")
  cloudCapacity?: CloudCapacity;

  /** List of QoS policies available for the cloud. */
  @visibility("read")
  @projectedName("json", "storageQoSPolicies")
  storageQosPolicies?: StorageQosPolicy[];

  /** Provisioning state of the resource. */
  @visibility("read")
  provisioningState?: Microsoft.ScVmm.ResourceProvisioningState;
}

/** Cloud Capacity model */
model CloudCapacity {
  /** CPUCount specifies the maximum number of CPUs that can be allocated in the cloud. */
  @visibility("read") cpuCount?: int64;

  /** MemoryMB specifies a memory usage limit in megabytes. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is distinct from Mb"
  @visibility("read") memoryMB?: int64;

  /** VMCount gives the max number of VMs that can be deployed in the cloud. */
  @visibility("read") vmCount?: int64;
}

/** The StorageQoSPolicy definition. */
model StorageQosPolicy {
  /** The name of the policy. */
  name?: string;

  /** The ID of the QoS policy. */
  id?: string;

  /** The maximum IO operations per second. */
  iopsMaximum?: int64;

  /** The minimum IO operations per second. */
  iopsMinimum?: int64;

  /** The Bandwidth Limit for internet traffic. */
  bandwidthLimit?: int64;

  /** The underlying policy. */
  policyId?: string;
}

/** Defines the resource properties. */
model VirtualNetworkProperties {
  /** Gets or sets the inventory Item ID for the resource. */
  inventoryItemId?: string;

  /** Unique ID of the virtual network. */
  @minLength(1)
  uuid?: string;

  /** ARM Id of the vmmServer resource in which this resource resides. */
  vmmServerId?: VmmServerId;

  /** Name of the virtual network in vmmServer. */
  @visibility("read")
  networkName?: string;

  /** Provisioning state of the resource. */
  @visibility("read")
  provisioningState?: Microsoft.ScVmm.ResourceProvisioningState;
}

/** Defines the resource properties. */
model VirtualMachineTemplateProperties {
  /** Gets or sets the inventory Item ID for the resource. */
  inventoryItemId?: string;

  /** Unique ID of the virtual machine template. */
  @minLength(1)
  uuid?: string;

  /** ARM Id of the vmmServer resource in which this resource resides. */
  vmmServerId?: VmmServerId;

  /** Gets the type of the os. */
  @visibility("read")
  osType?: OsType;

  /** Gets os name. */
  @visibility("read")
  osName?: string;

  /** Gets computer name. */
  @visibility("read")
  computerName?: string;

  /** MemoryMB is the desired size of a virtual machine's memory, in MB. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is distinct from Mb"
  @visibility("read")
  memoryMB?: int32;

  /** Gets the desired number of vCPUs for the vm. */
  @visibility("read")
  cpuCount?: int32;

  /** Gets a value indicating whether to enable processor compatibility mode for live migration of VMs. */
  @visibility("read")
  limitCpuForMigration?: LimitCpuForMigration;

  /** Gets a value indicating whether to enable dynamic memory or not. */
  @visibility("read")
  dynamicMemoryEnabled?: DynamicMemoryEnabled;

  /** Gets a value indicating whether the vm template is customizable or not. */
  @visibility("read")
  isCustomizable?: IsCustomizable;

  /** Gets the max dynamic memory for the vm. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is distinct from Mb"
  @visibility("read")
  dynamicMemoryMaxMB?: int32;

  /** Gets the min dynamic memory for the vm. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is distinct from Mb"
  @visibility("read")
  dynamicMemoryMinMB?: int32;

  /** Gets highly available property. */
  @visibility("read")
  isHighlyAvailable?: IsHighlyAvailable;

  /** Gets the generation for the vm. */
  @visibility("read")
  generation?: int32;

  /** Gets the network interfaces of the template. */
  @visibility("read")
  @extension("x-ms-identifiers", ["name", "nicId"])
  networkInterfaces?: NetworkInterface[];

  /** Gets the disks of the template. */
  @visibility("read")
  @extension("x-ms-identifiers", ["diskId", "name"])
  disks?: VirtualDisk[];

  /** Provisioning state of the resource. */
  @visibility("read")
  provisioningState?: Microsoft.ScVmm.ResourceProvisioningState;
}

/** Network Interface model */
model NetworkInterface {
  /** Gets or sets the name of the network interface. */
  name?: string;

  /** Gets the display name of the network interface as shown in the vmmServer. This is the fallback label for a NIC when the name is not set. */
  @visibility("read")
  displayName?: string;

  /** Gets the nic ipv4 addresses. */
  @visibility("read")
  ipv4Addresses?: string[];

  /** Gets the nic ipv6 addresses. */
  @visibility("read")
  ipv6Addresses?: string[];

  /** Gets or sets the nic MAC address. */
  macAddress?: string;

  /** Gets or sets the ARM Id of the Microsoft.ScVmm/virtualNetwork resource to connect the nic. */
  virtualNetworkId?: VirtualNetworkId;

  /** Gets the name of the virtual network in vmmServer that the nic is connected to. */
  @visibility("read")
  networkName?: string;

  /** Gets or sets the ipv4 address type. */
  ipv4AddressType?: AllocationMethod;

  /** Gets or sets the ipv6 address type. */
  ipv6AddressType?: AllocationMethod;

  /** Gets or sets the mac address type. */
  macAddressType?: AllocationMethod;

  /** Gets or sets the nic id. */
  nicId?: string;
}

/** Network Interface Update model */
model NetworkInterfaceUpdate is UpdateableProperties<NetworkInterface> {}

/** Virtual disk model */
model VirtualDisk {
  /** Gets or sets the name of the disk. */
  name?: string;

  /** Gets the display name of the virtual disk as shown in the vmmServer. This is the fallback label for a disk when the name is not set. */
  @visibility("read")
  displayName?: string;

  /** Gets or sets the disk id. */
  diskId?: string;

  /** Gets or sets the disk total size. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "GB is distinct from Gb"
  diskSizeGB?: int32;

  /** Gets the max disk size. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "GB is distinct from Gb"
  @visibility("read")
  maxDiskSizeGB?: int32;

  /** Gets or sets the disk bus. */
  bus?: int32;

  /** Gets or sets the disk lun. */
  lun?: int32;

  /** Gets or sets the disk bus type. */
  busType?: string;

  /** Gets or sets the disk vhd type. */
  vhdType?: string;

  /** Gets the disk volume type. */
  @visibility("read")
  volumeType?: string;

  /** Gets the disk vhd format type. */
  @visibility("read")
  vhdFormatType?: string;

  /** Gets or sets the disk id in the template. */
  @visibility("read", "create")
  templateDiskId?: string;

  /** The QoS policy for the disk. */
  @projectedName("json", "storageQoSPolicy")
  storageQosPolicy?: StorageQosPolicyDetails;

  /** Gets or sets a value indicating diff disk. */
  @visibility("read", "create")
  createDiffDisk?: CreateDiffDisk;
}

/** Virtual Disk Update model */
model VirtualDiskUpdate is UpdateableProperties<VirtualDisk> {}

/** The StorageQoSPolicyDetails definition. */
model StorageQosPolicyDetails {
  /** The name of the policy. */
  name?: string;

  /** The ID of the QoS policy. */
  id?: string;
}

/** Defines the resource properties. */
model AvailabilitySetProperties {
  /** Name of the availability set. */
  @minLength(1)
  availabilitySetName?: string;

  /** ARM Id of the vmmServer resource in which this resource resides. */
  vmmServerId?: VmmServerId;

  /** Provisioning state of the resource. */
  @visibility("read")
  provisioningState?: Microsoft.ScVmm.ResourceProvisioningState;
}

/** The inventory type */
enum InventoryType {
  /** Cloud inventory type */
  Cloud: "Cloud",

  /** VirtualNetwork inventory type */
  VirtualNetwork: "VirtualNetwork",

  /** VirtualMachine inventory type */
  VirtualMachine: "VirtualMachine",

  /** VirtualMachineTemplate inventory type */
  VirtualMachineTemplate: "VirtualMachineTemplate",
}

/** Defines the resource properties. */
@discriminator("inventoryType")
model InventoryItemProperties {
  /** They inventory type. */
  inventoryType: InventoryType;

  /** Gets the tracked resource id corresponding to the inventory resource. */
  @visibility("read")
  managedResourceId?: string;

  /** Gets the UUID (which is assigned by Vmm) for the inventory item. */
  @visibility("read")
  uuid?: string;

  /** Gets the Managed Object name in Vmm for the inventory item. */
  @visibility("read")
  inventoryItemName?: string;

  /** Provisioning state of the resource. */
  @visibility("read")
  provisioningState?: Microsoft.ScVmm.ResourceProvisioningState;
}

/** Defines the resource properties. */
model VirtualMachineInstanceProperties {
  /** Availability Sets in vm. */
  availabilitySets?: AvailabilitySetListItem[];

  /** OS properties. */
  @visibility("read", "create")
  osProfile?: OsProfileForVmInstance;

  /** Hardware properties. */
  hardwareProfile?: HardwareProfile;

  /** Network properties. */
  networkProfile?: NetworkProfile;

  /** Storage properties. */
  storageProfile?: StorageProfile;

  /** Gets the infrastructure profile. */
  infrastructureProfile?: InfrastructureProfile;

  /** Gets the power state of the virtual machine. */
  @visibility("read")
  powerState?: string;

  /** Provisioning state of the resource. */
  @visibility("read")
  provisioningState?: Microsoft.ScVmm.ResourceProvisioningState;
}

/** Virtual Machine Instance Properties Update model */
model VirtualMachineInstanceUpdateProperties is UpdateableProperties<OmitProperties<VirtualMachineInstanceProperties,"hardwareProfile" | "networkProfile" | "storageProfile" | "infrastructureProfile">> {
  /** Hardware properties. */
  hardwareProfile?: HardwareProfileUpdate;

  /** Network properties. */
  networkProfile?: NetworkProfileUpdate;

  /** Storage properties. */
  storageProfile?: StorageProfileUpdate;

  /** Gets the infrastructure profile. */
  infrastructureProfile?: InfrastructureProfileUpdate;
}

/** Availability Set model */
model AvailabilitySetListItem {
  /** Gets the ARM Id of the microsoft.scvmm/availabilitySets resource. */
  id?: ResourceIdentifier<[
    {
      type: "Microsoft.ScVmm/availabilitySets";
    }
  ]>;

  /** Gets or sets the name of the availability set. */
  name?: string;
}

/** Defines the resource properties. */
model OsProfileForVmInstance {
  /** Admin password of the virtual machine. */
  @visibility("create", "update")
  @secret
  adminPassword?: string;

  /** Gets or sets computer name. */
  computerName?: string;

  /** Gets the type of the os. */
  @visibility("read")
  osType?: OsType;

  /** Gets os sku. */
  @visibility("read")
  osSku?: string;

  /** Gets os version. */
  @visibility("read")
  osVersion?: string;
}

/** Defines the resource properties. */
model HardwareProfile {
  /** MemoryMB is the size of a virtual machine's memory, in MB. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is distinct from Mb"
  memoryMB?: int32;

  /** Gets or sets the number of vCPUs for the vm. */
  cpuCount?: int32;

  /** Gets or sets a value indicating whether to enable processor compatibility mode for live migration of VMs. */
  limitCpuForMigration?: LimitCpuForMigration;

  /** Gets or sets a value indicating whether to enable dynamic memory or not. */
  dynamicMemoryEnabled?: DynamicMemoryEnabled;

  /** Gets or sets the max dynamic memory for the vm. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is distinct from Mb"
  dynamicMemoryMaxMB?: int32;

  /** Gets or sets the min dynamic memory for the vm. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is distinct from Mb"
  dynamicMemoryMinMB?: int32;

  /** Gets highly available property. */
  @visibility("read")
  isHighlyAvailable?: IsHighlyAvailable;
}

/** Defines the resource update properties. */
model HardwareProfileUpdate is UpdateableProperties<HardwareProfile> {}

/** Defines the resource properties. */
model NetworkProfile {
  /** Gets or sets the list of network interfaces associated with the virtual machine. */
  @extension("x-ms-identifiers", ["name", "nicId"])
  networkInterfaces?: NetworkInterface[];
}

/** Defines the resource update properties. */
model NetworkProfileUpdate is UpdateableProperties<OmitProperties<NetworkProfile, "networkInterfaces">> {
  /** Gets or sets the list of network interfaces associated with the virtual machine. */
  @extension("x-ms-identifiers", ["name", "nicId"])
  networkInterfaces?: NetworkInterfaceUpdate[];
}

/** Defines the resource properties. */
model StorageProfile {
  /** Gets or sets the list of virtual disks associated with the virtual machine. */
  @extension("x-ms-identifiers", ["diskId", "name"])
  disks?: VirtualDisk[];
}

/** Defines the resource update properties. */
model StorageProfileUpdate is UpdateableProperties<OmitProperties<StorageProfile, "disks">> {
  /** Gets or sets the list of virtual disks associated with the virtual machine. */
  @extension("x-ms-identifiers", ["diskId", "name"])
  disks?: VirtualDiskUpdate[];
}

/** Specifies the vmmServer infrastructure specific settings for the virtual machine instance. */
model InfrastructureProfile {
  /** Gets or sets the inventory Item ID for the resource. */
  @visibility("read", "create")
  inventoryItemId?: string;

  /** ARM Id of the vmmServer resource in which this resource resides. */
  @visibility("read", "create")
  vmmServerId?: VmmServerId;

  /** ARM Id of the cloud resource to use for deploying the vm. */
  @visibility("read", "create")
  cloudId?: ResourceIdentifier<[
    {
      type: "Microsoft.ScVmm/clouds";
    }
  ]>;

  /** ARM Id of the template resource to use for deploying the vm. */
  @visibility("read", "create")
  templateId?: ResourceIdentifier<[
    {
      type: "Microsoft.ScVmm/virtualMachineTemplates";
    }
  ]>;

  /** VMName is the name of VM on the SCVmm server. */
  @minLength(1)
  @visibility("read", "create")
  vmName?: string;

  /** Unique ID of the virtual machine. */
  @visibility("read", "create")
  uuid?: string;

  /** Last restored checkpoint in the vm. */
  @visibility("read")
  @projectedName("json", "lastRestoredVMCheckpoint")
  lastRestoredVmCheckpoint?: Checkpoint;

  /** Checkpoints in the vm. */
  @visibility("read")
  @extension("x-ms-identifiers", ["checkpointID"])
  checkpoints?: Checkpoint[];

  /** Type of checkpoint supported for the vm. */
  @visibility("read", "create", "update")
  checkpointType?: string;

  /** Gets or sets the generation for the vm. */
  @visibility("read", "create")
  generation?: int32;

  /** Gets or sets the bios guid for the vm. */
  @visibility("read", "create")
  biosGuid?: string;
}

/** Specifies the vmmServer infrastructure specific update settings for the virtual machine instance. */
model InfrastructureProfileUpdate is UpdateableProperties<InfrastructureProfile> {}

/** Defines the resource properties. */
model Checkpoint {
  /** Gets ID of parent of the checkpoint. */
  @projectedName("json", "parentCheckpointID")
  parentCheckpointId?: string;

  /** Gets ID of the checkpoint. */
  @projectedName("json", "checkpointID")
  checkpointId?: string;

  /** Gets name of the checkpoint. */
  name?: string;

  /** Gets description of the checkpoint. */
  description?: string;
}

/** Defines the stop action properties. */
model StopVirtualMachineOptions {
  /** Gets or sets a value indicating whether to request non-graceful VM shutdown. True value for this flag indicates non-graceful shutdown whereas false indicates otherwise. Defaults to false. */
  skipShutdown?: SkipShutdown = SkipShutdown.`false`;
}

/** Describes the properties of Hybrid Identity Metadata for a Virtual Machine. */
model VmInstanceHybridIdentityMetadataProperties {
  /** The unique identifier for the resource. */
  resourceUid?: string;

  /** Gets or sets the Public Key. */
  publicKey?: string;

  /** Provisioning state of the resource. */
  @visibility("read")
  provisioningState?: Microsoft.ScVmm.ResourceProvisioningState;
}

/** Defines the create checkpoint action properties. */
model VirtualMachineCreateCheckpoint {
  /** Name of the checkpoint. */
  name?: string;

  /** Description of the checkpoint. */
  description?: string;
}

/** Defines the delete checkpoint action properties. */
model VirtualMachineDeleteCheckpoint {
  /** ID of the checkpoint to be deleted. */
  id?: string;
}

/** Defines the restore checkpoint action properties. */
model VirtualMachineRestoreCheckpoint {
  /** ID of the checkpoint to be restored to. */
  id?: string;
}

/** Defines the resource properties. */
model GuestAgentProperties {
  /** Gets a unique identifier for this resource. */
  @visibility("read")
  uuid?: string;

  /** Username / Password Credentials to provision guest agent. */
  credentials?: GuestCredential;

  /** HTTP Proxy configuration for the VM. */
  httpProxyConfig?: HttpProxyConfiguration;

  /** Gets or sets the guest agent provisioning action. */
  provisioningAction?: ProvisioningAction;

  /** Gets the guest agent status. */
  @visibility("read")
  status?: string;

  /** Gets the name of the corresponding resource in Kubernetes. */
  @visibility("read")
  customResourceName?: string;

  /** Provisioning state of the resource. */
  @visibility("read")
  provisioningState?: Microsoft.ScVmm.ResourceProvisioningState;
}

/** Username / Password Credentials to connect to guest. */
model GuestCredential {
  /** Gets or sets username to connect with the guest. */
  username: string;

  /** Gets or sets the password to connect with the guest. */
  @visibility("create", "update")
  @secret
  password: string;
}

/** HTTP Proxy configuration for the VM. */
model HttpProxyConfiguration {
  /** Gets or sets httpsProxy url. */
  httpsProxy?: string;
}

/** Defines the resource properties. */
model InventoryItemDetails {
  /** Gets or sets the inventory Item ID for the resource. */
  inventoryItemId?: string;

  /** Gets or sets the Managed Object name in Vmm for the resource. */
  inventoryItemName?: string;
}

/** The Cloud inventory item. */
model CloudInventoryItem extends InventoryItemProperties {
  /** They inventory type. */
  inventoryType: InventoryType.Cloud;
}

/** The Virtual network inventory item. */
model VirtualNetworkInventoryItem extends InventoryItemProperties {
  /** They inventory type. */
  inventoryType: InventoryType.VirtualNetwork;
}

/** The Virtual machine template inventory item. */
model VirtualMachineTemplateInventoryItem extends InventoryItemProperties {
  /** Gets the desired number of vCPUs for the vm. */
  @visibility("read")
  cpuCount?: int32;

  /** MemoryMB is the desired size of a virtual machine's memory, in MB. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is distinct from Mb"
  @visibility("read")
  memoryMB?: int32;

  /** Gets the type of the os. */
  @visibility("read")
  osType?: OsType;

  /** Gets os name. */
  @visibility("read")
  osName?: string;

  /** They inventory type. */
  inventoryType: InventoryType.VirtualMachineTemplate;
}

/** The Virtual machine inventory item. */
model VirtualMachineInventoryItem extends InventoryItemProperties {
  /** Gets the type of the os. */
  @visibility("read")
  osType?: OsType;

  /** Gets os name. */
  @visibility("read")
  osName?: string;

  /** Gets os version. */
  @visibility("read")
  osVersion?: string;

  /** Gets the power state of the virtual machine. */
  @visibility("read")
  powerState?: string;

  /** Gets or sets the nic ip addresses. */
  ipAddresses?: string[];

  /** Cloud inventory resource details where the VM is present. */
  cloud?: InventoryItemDetails;

  /** Gets the bios guid. */
  @visibility("read")
  biosGuid?: string;

  /** Gets the tracked resource id corresponding to the inventory resource. */
  @visibility("read")
  managedMachineResourceId?: ResourceIdentifier<[]>;

  /** They inventory type. */
  inventoryType: InventoryType.VirtualMachine;
}
