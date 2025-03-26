import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "./main.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.ScVmm;

interface Operations extends Azure.ResourceManager.Operations {}

alias VmmServerId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.ScVmm/vmmServers";
  }
]>;

alias VirtualNetworkId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.ScVmm/virtualNetwork";
  }
]>;

/** A reusable query option to force delete a resource. */
model QueryForceDelete {
  /** Forces the resource to be deleted. */
  @query("force")
  force?: ForceDelete;
}

/** The provisioning state of the resource. */
union ProvisioningState {
  string,
  Azure.ResourceManager.ResourceProvisioningState,

  /** The resource is provisioning. */
  Provisioning: "Provisioning",

  /** The resource is updating. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource has been accepted. */
  Accepted: "Accepted",

  /** The resource was created. */
  Created: "Created",
}

/** Virtual machine operating system type. */
union OsType {
  /** Windows operating system. */
  Windows: "Windows",

  /** Linux operating system. */
  Linux: "Linux",

  /** Other operating system. */
  Other: "Other",

  string,
}

/** Network address allocation method. */
union AllocationMethod {
  /** Dynamically allocated address. */
  Dynamic: "Dynamic",

  /** Statically allocated address. */
  Static: "Static",

  string,
}

/** Guest agent provisioning action. */
union ProvisioningAction {
  /** Install guest agent. */
  install: "install",

  /** Uninstall guest agent. */
  uninstall: "uninstall",

  /** Repair guest agent. */
  repair: "repair",

  string,
}

/** Limit CPU for migration. */
union LimitCpuForMigration {
  /** Enable limit CPU for migration. */
  `true`: "true",

  /** Disable limit CPU for migration. */
  `false`: "false",

  string,
}

/** Dynamic memory enabled. */
union DynamicMemoryEnabled {
  /** Enable dynamic memory. */
  `true`: "true",

  /** Disable dynamic memory. */
  `false`: "false",

  string,
}

/** Highly available. */
union IsHighlyAvailable {
  /** Enable highly available. */
  `true`: "true",

  /** Disable highly available. */
  `false`: "false",

  string,
}

/** Create diff disk. */
union CreateDiffDisk {
  /** Enable create diff disk. */
  `true`: "true",

  /** Disable create diff disk. */
  `false`: "false",

  string,
}

/** Customizable. */
union IsCustomizable {
  /** Enable customizable. */
  `true`: "true",

  /** Disable customizable. */
  `false`: "false",

  string,
}

/** Skip shutdown. */
union SkipShutdown {
  /** Enable skip shutdown. */
  `true`: "true",

  /** Disable skip shutdown. */
  `false`: "false",

  string,
}

/** Force Delete */
union ForceDelete {
  /** Enable force delete. */
  `true`: "true",

  /** Disable force delete. */
  `false`: "false",

  string,
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
  @visibility(Lifecycle.Read)
  connectionStatus?: string;

  /** Gets any error message if connection to vmmServer is having any issue. */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /** Unique ID of vmmServer. */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /** Version is the version of the vmmSever. */
  @visibility(Lifecycle.Read)
  version?: string;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Credentials to connect to VmmServer. */
model VmmCredential {
  /** Username to use to connect to VmmServer. */
  username?: string;

  /** Password to use to connect to VmmServer. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  password?: string;
}

/** The extended location. */
model ExtendedLocation {
  /** The extended location type. */
  type?: string;

  /** The extended location name. */
  name?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations";
    }
  ]>;
}

/** Defines the resource properties. */
model CloudProperties {
  /** Gets or sets the inventory Item ID for the resource. */
  inventoryItemId?: string;

  /** Unique ID of the cloud. */
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  uuid?: string;

  /** ARM Id of the vmmServer resource in which this resource resides. */
  vmmServerId?: VmmServerId;

  /** Name of the cloud in VmmServer. */
  @visibility(Lifecycle.Read)
  cloudName?: string;

  /** Capacity of the cloud. */
  @visibility(Lifecycle.Read)
  cloudCapacity?: CloudCapacity;

  /** List of QoS policies available for the cloud. */
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "storageQoSPolicies")
  storageQosPolicies?: StorageQosPolicy[];

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Cloud Capacity model */
model CloudCapacity {
  /** CPUCount specifies the maximum number of CPUs that can be allocated in the cloud. */
  @visibility(Lifecycle.Read) cpuCount?: int64;

  /** MemoryMB specifies a memory usage limit in megabytes. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is distinct from Mb"
  @visibility(Lifecycle.Read) memoryMB?: int64;

  /** VMCount gives the max number of VMs that can be deployed in the cloud. */
  @visibility(Lifecycle.Read) vmCount?: int64;
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
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  uuid?: string;

  /** ARM Id of the vmmServer resource in which this resource resides. */
  vmmServerId?: VmmServerId;

  /** Name of the virtual network in vmmServer. */
  @visibility(Lifecycle.Read)
  networkName?: string;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Defines the resource properties. */
model VirtualMachineTemplateProperties {
  /** Gets or sets the inventory Item ID for the resource. */
  inventoryItemId?: string;

  /** Unique ID of the virtual machine template. */
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  uuid?: string;

  /** ARM Id of the vmmServer resource in which this resource resides. */
  vmmServerId?: VmmServerId;

  /** Gets the type of the os. */
  @visibility(Lifecycle.Read)
  osType?: OsType;

  /** Gets os name. */
  @visibility(Lifecycle.Read)
  osName?: string;

  /** Gets computer name. */
  @visibility(Lifecycle.Read)
  computerName?: string;

  /** MemoryMB is the desired size of a virtual machine's memory, in MB. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is distinct from Mb"
  @visibility(Lifecycle.Read)
  memoryMB?: int32;

  /** Gets the desired number of vCPUs for the vm. */
  @visibility(Lifecycle.Read)
  cpuCount?: int32;

  /** Gets a value indicating whether to enable processor compatibility mode for live migration of VMs. */
  @visibility(Lifecycle.Read)
  limitCpuForMigration?: LimitCpuForMigration;

  /** Gets a value indicating whether to enable dynamic memory or not. */
  @visibility(Lifecycle.Read)
  dynamicMemoryEnabled?: DynamicMemoryEnabled;

  /** Gets a value indicating whether the vm template is customizable or not. */
  @visibility(Lifecycle.Read)
  isCustomizable?: IsCustomizable;

  /** Gets the max dynamic memory for the vm. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is distinct from Mb"
  @visibility(Lifecycle.Read)
  dynamicMemoryMaxMB?: int32;

  /** Gets the min dynamic memory for the vm. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is distinct from Mb"
  @visibility(Lifecycle.Read)
  dynamicMemoryMinMB?: int32;

  /** Gets highly available property. */
  @visibility(Lifecycle.Read)
  isHighlyAvailable?: IsHighlyAvailable;

  /** Gets the generation for the vm. */
  @visibility(Lifecycle.Read)
  generation?: int32;

  /** Gets the network interfaces of the template. */
  @visibility(Lifecycle.Read)
  @identifiers(#["name", "nicId"])
  networkInterfaces?: NetworkInterface[];

  /** Gets the disks of the template. */
  @visibility(Lifecycle.Read)
  @identifiers(#["diskId", "name"])
  disks?: VirtualDisk[];

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Network Interface model */
model NetworkInterface {
  /** Gets or sets the name of the network interface. */
  name?: string;

  /** Gets the display name of the network interface as shown in the vmmServer. This is the fallback label for a NIC when the name is not set. */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /** Gets the nic ipv4 addresses. */
  @visibility(Lifecycle.Read)
  ipv4Addresses?: string[];

  /** Gets the nic ipv6 addresses. */
  @visibility(Lifecycle.Read)
  ipv6Addresses?: string[];

  /** Gets or sets the nic MAC address. */
  macAddress?: string;

  /** Gets or sets the ARM Id of the Microsoft.ScVmm/virtualNetwork resource to connect the nic. */
  virtualNetworkId?: VirtualNetworkId;

  /** Gets the name of the virtual network in vmmServer that the nic is connected to. */
  @visibility(Lifecycle.Read)
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
model NetworkInterfaceUpdate is UpdateableProperties<NetworkInterface>;

/** Virtual disk model */
model VirtualDisk {
  /** Gets or sets the name of the disk. */
  name?: string;

  /** Gets the display name of the virtual disk as shown in the vmmServer. This is the fallback label for a disk when the name is not set. */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /** Gets or sets the disk id. */
  diskId?: string;

  /** Gets or sets the disk total size. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "GB is distinct from Gb"
  diskSizeGB?: int32;

  /** Gets the max disk size. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "GB is distinct from Gb"
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  volumeType?: string;

  /** Gets the disk vhd format type. */
  @visibility(Lifecycle.Read)
  vhdFormatType?: string;

  /** Gets or sets the disk id in the template. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  templateDiskId?: string;

  /** The QoS policy for the disk. */
  @encodedName("application/json", "storageQoSPolicy")
  storageQosPolicy?: StorageQosPolicyDetails;

  /** Gets or sets a value indicating diff disk. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  createDiffDisk?: CreateDiffDisk;
}

/** Virtual Disk Update model */
model VirtualDiskUpdate is UpdateableProperties<VirtualDisk>;

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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** The inventory type */
union InventoryType {
  /** Cloud inventory type */
  Cloud: "Cloud",

  /** VirtualNetwork inventory type */
  VirtualNetwork: "VirtualNetwork",

  /** VirtualMachine inventory type */
  VirtualMachine: "VirtualMachine",

  /** VirtualMachineTemplate inventory type */
  VirtualMachineTemplate: "VirtualMachineTemplate",

  string,
}

/** Defines the resource properties. */
@discriminator("inventoryType")
model InventoryItemProperties {
  /** They inventory type. */
  inventoryType: InventoryType;

  /** Gets the tracked resource id corresponding to the inventory resource. */
  @visibility(Lifecycle.Read)
  managedResourceId?: string;

  /** Gets the UUID (which is assigned by Vmm) for the inventory item. */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /** Gets the Managed Object name in Vmm for the inventory item. */
  @visibility(Lifecycle.Read)
  inventoryItemName?: string;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Defines the resource properties. */
model VirtualMachineInstanceProperties {
  /** Availability Sets in vm. */
  availabilitySets?: AvailabilitySetListItem[];

  /** OS properties. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  @visibility(Lifecycle.Read)
  powerState?: string;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Virtual Machine Instance Properties Update model */
model VirtualMachineInstanceUpdateProperties
  is UpdateableProperties<OmitProperties<
    VirtualMachineInstanceProperties,

      | "hardwareProfile"
      | "networkProfile"
      | "storageProfile"
      | "infrastructureProfile"
  >> {
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
  id?: Azure.Core.armResourceIdentifier<[
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
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  adminPassword?: string;

  /** Gets or sets computer name. */
  computerName?: string;

  /** Gets the type of the os. */
  @visibility(Lifecycle.Read)
  osType?: OsType;

  /** Gets os sku. */
  @visibility(Lifecycle.Read)
  osSku?: string;

  /** Gets os version. */
  @visibility(Lifecycle.Read)
  osVersion?: string;

  /** Gets or sets the domain name. */
  @added(Versions.v2024_06_01)
  domainName?: string;

  /** Gets or sets the domain username. */
  @added(Versions.v2024_06_01)
  domainUsername?: string;

  /** Password of the domain the VM has to join. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  @added(Versions.v2024_06_01)
  domainPassword?: string;

  /** Gets or sets the workgroup. */
  @added(Versions.v2024_06_01)
  workgroup?: string;

  /** Gets or sets the product key.Input format xxxxx-xxxxx-xxxxx-xxxxx-xxxxx */
  @visibility(Lifecycle.Create)
  @secret
  @added(Versions.v2024_06_01)
  productKey?: string;

  /** Gets or sets the index value of the timezone. */
  @added(Versions.v2024_06_01)
  timezone?: int32;

  /** Get or sets the commands to be run once at the time of creation separated by semicolons. */
  @added(Versions.v2024_06_01)
  runOnceCommands?: string;
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
  @visibility(Lifecycle.Read)
  isHighlyAvailable?: IsHighlyAvailable;
}

/** Defines the resource update properties. */
model HardwareProfileUpdate is UpdateableProperties<HardwareProfile>;

/** Defines the resource properties. */
model NetworkProfile {
  /** Gets or sets the list of network interfaces associated with the virtual machine. */
  @identifiers(#["name", "nicId"])
  networkInterfaces?: NetworkInterface[];
}

/** Defines the resource update properties. */
model NetworkProfileUpdate
  is UpdateableProperties<OmitProperties<NetworkProfile, "networkInterfaces">> {
  /** Gets or sets the list of network interfaces associated with the virtual machine. */
  @identifiers(#["name", "nicId"])
  networkInterfaces?: NetworkInterfaceUpdate[];
}

/** Defines the resource properties. */
model StorageProfile {
  /** Gets or sets the list of virtual disks associated with the virtual machine. */
  @identifiers(#["diskId", "name"])
  disks?: VirtualDisk[];
}

/** Defines the resource update properties. */
model StorageProfileUpdate
  is UpdateableProperties<OmitProperties<StorageProfile, "disks">> {
  /** Gets or sets the list of virtual disks associated with the virtual machine. */
  @identifiers(#["diskId", "name"])
  disks?: VirtualDiskUpdate[];
}

/** Specifies the vmmServer infrastructure specific settings for the virtual machine instance. */
model InfrastructureProfile {
  /** Gets or sets the inventory Item ID for the resource. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inventoryItemId?: string;

  /** ARM Id of the vmmServer resource in which this resource resides. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmmServerId?: VmmServerId;

  /** ARM Id of the cloud resource to use for deploying the vm. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  cloudId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ScVmm/clouds";
    }
  ]>;

  /** ARM Id of the template resource to use for deploying the vm. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  templateId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ScVmm/virtualMachineTemplates";
    }
  ]>;

  /** VMName is the name of VM on the SCVmm server. */
  @minLength(1)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmName?: string;

  /** Unique ID of the virtual machine. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  uuid?: string;

  /** Last restored checkpoint in the vm. */
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "lastRestoredVMCheckpoint")
  lastRestoredVmCheckpoint?: Checkpoint;

  /** Checkpoints in the vm. */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Workaround for emitter problem"
  @visibility(Lifecycle.Read)
  @identifiers(#["checkpointID"])
  checkpoints?: Checkpoint[];

  /** Type of checkpoint supported for the vm. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  checkpointType?: string;

  /** Gets or sets the generation for the vm. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  generation?: int32;

  /** Gets or sets the bios guid for the vm. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  biosGuid?: string;
}

/** Specifies the vmmServer infrastructure specific update settings for the virtual machine instance. */
model InfrastructureProfileUpdate
  is UpdateableProperties<InfrastructureProfile>;

/** Defines the resource properties. */
model Checkpoint {
  /** Gets ID of parent of the checkpoint. */
  @encodedName("application/json", "parentCheckpointID")
  parentCheckpointId?: string;

  /** Gets ID of the checkpoint. */
  @encodedName("application/json", "checkpointID")
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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
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
  @visibility(Lifecycle.Read)
  uuid?: string;

  /** Username / Password Credentials to provision guest agent. */
  credentials?: GuestCredential;

  /** HTTP Proxy configuration for the VM. */
  httpProxyConfig?: HttpProxyConfiguration;

  /** Gets or sets the guest agent provisioning action. */
  provisioningAction?: ProvisioningAction;

  /** Gets the guest agent status. */
  @visibility(Lifecycle.Read)
  status?: string;

  /** Gets the name of the corresponding resource in Kubernetes. */
  @visibility(Lifecycle.Read)
  customResourceName?: string;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The resource id of the private link scope this machine is assigned to, if any. */
  @added(Versions.v2024_06_01)
  privateLinkScopeResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/privateLinkScopes";
    }
  ]>;
}

/** Username / Password Credentials to connect to guest. */
model GuestCredential {
  /** Gets or sets username to connect with the guest. */
  username: string;

  /** Gets or sets the password to connect with the guest. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
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
  @visibility(Lifecycle.Read)
  cpuCount?: int32;

  /** MemoryMB is the desired size of a virtual machine's memory, in MB. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is distinct from Mb"
  @visibility(Lifecycle.Read)
  memoryMB?: int32;

  /** Gets the type of the os. */
  @visibility(Lifecycle.Read)
  osType?: OsType;

  /** Gets os name. */
  @visibility(Lifecycle.Read)
  osName?: string;

  /** They inventory type. */
  inventoryType: InventoryType.VirtualMachineTemplate;
}

/** The Virtual machine inventory item. */
model VirtualMachineInventoryItem extends InventoryItemProperties {
  /** Gets the type of the os. */
  @visibility(Lifecycle.Read)
  osType?: OsType;

  /** Gets os name. */
  @visibility(Lifecycle.Read)
  osName?: string;

  /** Gets os version. */
  @visibility(Lifecycle.Read)
  osVersion?: string;

  /** Gets the power state of the virtual machine. */
  @visibility(Lifecycle.Read)
  powerState?: string;

  /** Gets or sets the nic ip addresses. */
  ipAddresses?: string[];

  /** Cloud inventory resource details where the VM is present. */
  cloud?: InventoryItemDetails;

  /** Gets the bios guid. */
  @visibility(Lifecycle.Read)
  biosGuid?: string;

  /** Gets the tracked resource id corresponding to the inventory resource. */
  @visibility(Lifecycle.Read)
  managedMachineResourceId?: Azure.Core.armResourceIdentifier<[]>;

  /** They inventory type. */
  inventoryType: InventoryType.VirtualMachine;
}
