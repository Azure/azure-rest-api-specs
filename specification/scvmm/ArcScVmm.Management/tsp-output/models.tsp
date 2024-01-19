import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ScVmm;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Defines the different types of VM guest operating systems.")
enum OsType {
  Windows,
  Linux,
  Other,
}

@doc("Gets or sets a value indicating whether to enable processor compatibility mode for live migration of VMs.")
enum LimitCpuForMigration {
  `false`,
  `true`,
}

@doc("Gets or sets a value indicating whether to enable dynamic memory or not.")
enum DynamicMemoryEnabled {
  `false`,
  `true`,
}

@doc("Allocation method.")
enum AllocationMethod {
  Dynamic,
  Static,
}

@doc("Gets or sets a value indicating diff disk.")
enum CreateDiffDisk {
  `false`,
  `true`,
}

@doc("Gets or sets a value indicating whether the vm template is customizable or not.")
enum IsCustomizable {
  `false`,
  `true`,
}

@doc("The inventory type.")
enum InventoryType {
  Cloud,
  VirtualNetwork,
  VirtualMachineTemplate,
  VirtualMachine,
}

@doc("Defines the resource properties.")
model VMMServerProperties {
  @doc("Credentials to connect to VMMServer.")
  credentials?: VMMServerPropertiesCredentials;

  @doc("Fqdn is the hostname/ip of the vmmServer.")
  @minLength(1)
  fqdn: string;

  @doc("Port is the port on which the vmmServer is listening.")
  @maxValue(65535)
  @minValue(1)
  port?: int32;

  @doc("Gets or sets the connection status to the vmmServer.")
  @visibility("read")
  connectionStatus?: string;

  @doc("Gets or sets any error message if connection to vmmServer is having any issue.")
  @visibility("read")
  errorMessage?: string;

  @doc("Unique ID of vmmServer.")
  @visibility("read")
  uuid?: string;

  @doc("Version is the version of the vmmSever.")
  @visibility("read")
  version?: string;

  @doc("Gets or sets the provisioning state.")
  @visibility("read")
  provisioningState?: string;
}

@doc("Credentials to connect to VMMServer.")
model VMMServerPropertiesCredentials {
  @doc("Username to use to connect to VMMServer.")
  username?: string;

  @doc("Credentials to use to connect to VMMServer.")
  @visibility("create", "update")
  password?: string;
}

@doc("The extended location.")
model ExtendedLocation {
  @doc("The extended location type.")
  type?: string;

  @doc("The extended location name.")
  name?: string;
}

@doc("Error definition.")
model ErrorDefinition {
  @doc("Service specific error code which serves as the substatus for the HTTP error code.")
  @visibility("read")
  code?: string;

  @doc("Description of the error.")
  @visibility("read")
  message?: string;

  @doc("Internal error details.")
  @visibility("read")
  details?: ErrorDefinition[];
}

@doc("Object containing tags updates for patch operations.")
model ResourcePatch {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Results of the request to list operations.")
model ResourceProviderOperation {
  @doc("Indicates whether the operation applies to data-plane.")
  isDataAction?: string;

  @doc("Operation name, in format of {provider}/{resource}/{operation}.")
  name?: string;

  @doc("Display metadata associated with the operation.")
  display?: ResourceProviderOperationDisplay;
}

@doc("Display metadata associated with the operation.")
model ResourceProviderOperationDisplay {
  @doc("The resource provider.")
  provider?: string;

  @doc("Resource on which the operation is performed.")
  resource?: string;

  @doc("Type of operation: read, write, delete, etc.")
  operation?: string;

  @doc("Description of this operation.")
  description?: string;
}

@doc("Defines the resource properties.")
model CloudProperties {
  @doc("Gets or sets the inventory Item ID for the resource.")
  inventoryItemId?: string;

  @doc("Unique ID of the cloud.")
  @minLength(1)
  uuid?: string;

  @doc("ARM Id of the vmmServer resource in which this resource resides.")
  vmmServerId?: string;

  @doc("Name of the cloud in VMMServer.")
  @visibility("read")
  cloudName?: string;

  @doc("Capacity of the cloud.")
  @visibility("read")
  cloudCapacity?: CloudCapacity;

  @doc("List of QoS policies available for the cloud.")
  @visibility("read")
  storageQoSPolicies?: StorageQoSPolicy[];

  @doc("Gets or sets the provisioning state.")
  @visibility("read")
  provisioningState?: string;
}

@doc("Cloud Capacity model")
model CloudCapacity {
  @doc("CPUCount specifies the maximum number of CPUs that can be allocated in the cloud.")
  cpuCount?: int32;

  @doc("MemoryMB specifies a memory usage limit in megabytes.")
  memoryMB?: int32;

  @doc("VMCount gives the max number of VMs that can be deployed in the cloud.")
  vmCount?: int32;
}

@doc("The StorageQoSPolicy definition.")
model StorageQoSPolicy {
  @doc("The name of the policy.")
  name?: string;

  @doc("The ID of the QoS policy.")
  id?: string;

  @doc("The maximum IO operations per second.")
  iopsMaximum?: int32;

  @doc("The minimum IO operations per second.")
  iopsMinimum?: int32;

  @doc("The Bandwidth Limit for internet traffic.")
  bandwidthLimit?: int32;

  @doc("The underlying policy.")
  policyId?: string;
}

@doc("Defines the resource properties.")
model VirtualNetworkProperties {
  @doc("Gets or sets the inventory Item ID for the resource.")
  inventoryItemId?: string;

  @doc("Unique ID of the virtual network.")
  @minLength(1)
  uuid?: string;

  @doc("ARM Id of the vmmServer resource in which this resource resides.")
  vmmServerId?: string;

  @doc("Name of the virtual network in vmmServer.")
  @visibility("read")
  networkName?: string;

  @doc("Gets or sets the provisioning state.")
  @visibility("read")
  provisioningState?: string;
}

@doc("Defines the resource properties.")
model VirtualMachineProperties {
  @doc("Gets or sets the inventory Item ID for the resource.")
  inventoryItemId?: string;

  @doc("ARM Id of the vmmServer resource in which this resource resides.")
  vmmServerId?: string;

  @doc("ARM Id of the cloud resource to use for deploying the vm.")
  cloudId?: string;

  @doc("ARM Id of the template resource to use for deploying the vm.")
  templateId?: string;

  @doc("Type of checkpoint supported for the vm.")
  checkpointType?: string;

  @doc("Checkpoints in the vm.")
  checkpoints?: Checkpoint[];

  @doc("Availability Sets in vm.")
  availabilitySets?: AvailabilitySetListItem[];

  @doc("OS properties.")
  osProfile?: OsProfile;

  @doc("Hardware properties.")
  hardwareProfile?: HardwareProfile;

  @doc("Network properties.")
  networkProfile?: NetworkProfile;

  @doc("Storage properties.")
  storageProfile?: StorageProfile;

  @doc("VMName is the name of VM on the SCVMM server.")
  @minLength(1)
  vmName?: string;

  @doc("Unique ID of the virtual machine.")
  uuid?: string;

  @doc("Gets or sets the generation for the vm.")
  generation?: int32;

  @doc("Gets the power state of the virtual machine.")
  @visibility("read")
  powerState?: string;

  @doc("Gets or sets the provisioning state.")
  @visibility("read")
  provisioningState?: string;
}

@doc("Defines the resource properties.")
model Checkpoint {
  @doc("Gets ID of parent of the checkpoint.")
  parentCheckpointID?: string;

  @doc("Gets ID of the checkpoint.")
  checkpointID?: string;

  @doc("Gets name of the checkpoint.")
  name?: string;

  @doc("Gets description of the checkpoint.")
  description?: string;
}

@doc("Availability Set model")
model AvailabilitySetListItem {
  @doc("Gets the ARM Id of the microsoft.scvmm/availabilitySets resource.")
  id?: string;

  @doc("Gets or sets the name of the availability set.")
  name?: string;
}

@doc("Defines the resource properties.")
model OsProfile {
  @doc("Admin password of the virtual machine.")
  @visibility("create", "update")
  adminPassword?: string;

  @doc("Gets or sets computer name.")
  computerName?: string;

  @doc("Gets or sets the type of the os.")
  @visibility("read")
  osType?: OsType;

  @doc("Gets or sets os name.")
  @visibility("read")
  osName?: string;
}

@doc("Defines the resource properties.")
model HardwareProfile {
  @doc("MemoryMB is the size of a virtual machine's memory, in MB.")
  memoryMB?: int32;

  @doc("Gets or sets the number of vCPUs for the vm.")
  cpuCount?: int32;

  @doc("Gets or sets a value indicating whether to enable processor compatibility mode for live migration of VMs.")
  limitCpuForMigration?: LimitCpuForMigration;

  @doc("Gets or sets a value indicating whether to enable dynamic memory or not.")
  dynamicMemoryEnabled?: DynamicMemoryEnabled;

  @doc("Gets or sets the max dynamic memory for the vm.")
  dynamicMemoryMaxMB?: int32;

  @doc("Gets or sets the min dynamic memory for the vm.")
  dynamicMemoryMinMB?: int32;

  @doc("Gets highly available property.")
  isHighlyAvailable?: string;
}

@doc("Defines the resource properties.")
model NetworkProfile {
  @doc("Gets or sets the list of network interfaces associated with the virtual machine.")
  networkInterfaces?: NetworkInterfaces[];
}

@doc("Network Interface model")
model NetworkInterfaces {
  @doc("Gets or sets the name of the network interface.")
  name?: string;

  @doc("Gets the display name of the network interface as shown in the vmmServer. This is the fallback label for a NIC when the name is not set.")
  @visibility("read")
  displayName?: string;

  @doc("Gets or sets the nic ipv4 addresses.")
  @visibility("read")
  ipv4Addresses?: string[];

  @doc("Gets or sets the nic ipv6 addresses.")
  @visibility("read")
  ipv6Addresses?: string[];

  @doc("Gets or sets the nic MAC address.")
  macAddress?: string;

  @doc("Gets or sets the ARM Id of the Microsoft.ScVmm/virtualNetwork resource to connect the nic.")
  virtualNetworkId?: string;

  @doc("Gets or sets the name of the virtual network in vmmServer that the nic is connected to.")
  @visibility("read")
  networkName?: string;

  @doc("Gets or sets the ipv4 address type.")
  ipv4AddressType?: AllocationMethod;

  @doc("Gets or sets the ipv6 address type.")
  ipv6AddressType?: AllocationMethod;

  @doc("Gets or sets the mac address type.")
  macAddressType?: AllocationMethod;

  @doc("Gets or sets the nic id.")
  nicId?: string;
}

@doc("Defines the resource properties.")
model StorageProfile {
  @doc("Gets or sets the list of virtual disks associated with the virtual machine.")
  disks?: VirtualDisk[];
}

@doc("Virtual disk model")
model VirtualDisk {
  @doc("Gets or sets the name of the disk.")
  name?: string;

  @doc("Gets the display name of the virtual disk as shown in the vmmServer. This is the fallback label for a disk when the name is not set.")
  @visibility("read")
  displayName?: string;

  @doc("Gets or sets the disk id.")
  diskId?: string;

  @doc("Gets or sets the disk total size.")
  diskSizeGB?: int32;

  @doc("Gets or sets the max disk size.")
  @visibility("read")
  maxDiskSizeGB?: int32;

  @doc("Gets or sets the disk bus.")
  bus?: int32;

  @doc("Gets or sets the disk lun.")
  lun?: int32;

  @doc("Gets or sets the disk bus type.")
  busType?: string;

  @doc("Gets or sets the disk vhd type.")
  vhdType?: string;

  @doc("Gets or sets the disk volume type.")
  @visibility("read")
  volumeType?: string;

  @doc("Gets the disk vhd format type.")
  @visibility("read")
  vhdFormatType?: string;

  @doc("Gets or sets the disk id in the template.")
  templateDiskId?: string;

  @doc("The QoS policy for the disk.")
  storageQoSPolicy?: StorageQoSPolicyDetails;

  @doc("Gets or sets a value indicating diff disk.")
  createDiffDisk?: CreateDiffDisk;
}

@doc("The StorageQoSPolicyDetails definition.")
model StorageQoSPolicyDetails {
  @doc("The name of the policy.")
  name?: string;

  @doc("The ID of the QoS policy.")
  id?: string;
}

@doc("Defines the virtualMachineUpdate.")
model VirtualMachineUpdate {
  @doc("Defines the resource properties.")
  properties?: VirtualMachineUpdateProperties;

  @doc("Gets or sets the Resource tags.")
  tags?: Record<string>;
}

@doc("Defines the resource properties.")
model VirtualMachineUpdateProperties {
  @doc("Defines the resource properties.")
  hardwareProfile?: HardwareProfileUpdate;

  @doc("Defines the resource properties.")
  storageProfile?: StorageProfileUpdate;

  @doc("Defines the resource properties.")
  networkProfile?: NetworkProfileUpdate;

  @doc("Availability Sets in vm.")
  availabilitySets?: AvailabilitySetListItem[];
}

@doc("Defines the resource properties.")
model HardwareProfileUpdate {
  @doc("MemoryMB is the size of a virtual machine's memory, in MB.")
  memoryMB?: int32;

  @doc("Gets or sets the number of vCPUs for the vm.")
  cpuCount?: int32;

  @doc("Gets or sets a value indicating whether to enable processor compatibility mode for live migration of VMs.")
  limitCpuForMigration?: LimitCpuForMigration;

  @doc("Gets or sets a value indicating whether to enable dynamic memory or not.")
  dynamicMemoryEnabled?: DynamicMemoryEnabled;

  @doc("Gets or sets the max dynamic memory for the vm.")
  dynamicMemoryMaxMB?: int32;

  @doc("Gets or sets the min dynamic memory for the vm.")
  dynamicMemoryMinMB?: int32;
}

@doc("Defines the resource properties.")
model StorageProfileUpdate {
  @doc("Gets or sets the list of virtual disks associated with the virtual machine.")
  disks?: VirtualDiskUpdate[];
}

@doc("Virtual disk model")
model VirtualDiskUpdate {
  @doc("Gets or sets the name of the disk.")
  name?: string;

  @doc("Gets or sets the disk id.")
  diskId?: string;

  @doc("Gets or sets the disk total size.")
  diskSizeGB?: int32;

  @doc("Gets or sets the disk bus.")
  bus?: int32;

  @doc("Gets or sets the disk lun.")
  lun?: int32;

  @doc("Gets or sets the disk bus type.")
  busType?: string;

  @doc("Gets or sets the disk vhd type.")
  vhdType?: string;

  @doc("The QoS policy for the disk.")
  storageQoSPolicy?: StorageQoSPolicyDetails;
}

@doc("Defines the resource properties.")
model NetworkProfileUpdate {
  @doc("Gets or sets the list of network interfaces associated with the virtual machine.")
  networkInterfaces?: NetworkInterfacesUpdate[];
}

@doc("Network Interface model")
model NetworkInterfacesUpdate {
  @doc("Gets or sets the name of the network interface.")
  name?: string;

  @doc("Gets or sets the nic MAC address.")
  macAddress?: string;

  @doc("Gets or sets the ARM Id of the Microsoft.ScVmm/virtualNetwork resource to connect the nic.")
  virtualNetworkId?: string;

  @doc("Gets or sets the ipv4 address type.")
  ipv4AddressType?: AllocationMethod;

  @doc("Gets or sets the ipv6 address type.")
  ipv6AddressType?: AllocationMethod;

  @doc("Gets or sets the mac address type.")
  macAddressType?: AllocationMethod;

  @doc("Gets or sets the nic id.")
  nicId?: string;
}

@doc("Defines the stop action properties.")
model StopVirtualMachineOptions {
  @doc("Gets or sets a value indicating whether to request non-graceful VM shutdown. True value for this flag indicates non-graceful shutdown whereas false indicates otherwise. Defaults to false.")
  skipShutdown?: boolean;
}

@doc("Defines the create checkpoint action properties.")
model VirtualMachineCreateCheckpoint {
  @doc("Name of the checkpoint.")
  name?: string;

  @doc("Description of the checkpoint.")
  description?: string;
}

@doc("Defines the delete checkpoint action properties.")
model VirtualMachineDeleteCheckpoint {
  @doc("ID of the checkpoint to be deleted.")
  id?: string;
}

@doc("Defines the restore checkpoint action properties.")
model VirtualMachineRestoreCheckpoint {
  @doc("ID of the checkpoint to be restored to.")
  id?: string;
}

@doc("Defines the resource properties.")
model VirtualMachineTemplateProperties {
  @doc("Gets or sets the inventory Item ID for the resource.")
  inventoryItemId?: string;

  @doc("Unique ID of the virtual machine template.")
  @minLength(1)
  uuid?: string;

  @doc("ARM Id of the vmmServer resource in which this resource resides.")
  vmmServerId?: string;

  @doc("Gets or sets the type of the os.")
  @visibility("read")
  osType?: OsType;

  @doc("Gets or sets os name.")
  @visibility("read")
  osName?: string;

  @doc("Gets or sets computer name.")
  @visibility("read")
  computerName?: string;

  @doc("MemoryMB is the desired size of a virtual machine's memory, in MB.")
  @visibility("read")
  memoryMB?: int32;

  @doc("Gets or sets the desired number of vCPUs for the vm.")
  @visibility("read")
  cpuCount?: int32;

  @doc("Gets or sets a value indicating whether to enable processor compatibility mode for live migration of VMs.")
  @visibility("read")
  limitCpuForMigration?: LimitCpuForMigration;

  @doc("Gets or sets a value indicating whether to enable dynamic memory or not.")
  @visibility("read")
  dynamicMemoryEnabled?: DynamicMemoryEnabled;

  @doc("Gets or sets a value indicating whether the vm template is customizable or not.")
  @visibility("read")
  isCustomizable?: IsCustomizable;

  @doc("Gets or sets the max dynamic memory for the vm.")
  @visibility("read")
  dynamicMemoryMaxMB?: int32;

  @doc("Gets or sets the min dynamic memory for the vm.")
  @visibility("read")
  dynamicMemoryMinMB?: int32;

  @doc("Gets highly available property.")
  @visibility("read")
  isHighlyAvailable?: string;

  @doc("Gets or sets the generation for the vm.")
  @visibility("read")
  generation?: int32;

  @doc("Gets or sets the network interfaces of the template.")
  @visibility("read")
  networkInterfaces?: NetworkInterfaces[];

  @doc("Gets or sets the disks of the template.")
  @visibility("read")
  disks?: VirtualDisk[];

  @doc("Gets or sets the provisioning state.")
  @visibility("read")
  provisioningState?: string;
}

@doc("Defines the resource properties.")
model AvailabilitySetProperties {
  @doc("Name of the availability set.")
  @minLength(1)
  availabilitySetName?: string;

  @doc("ARM Id of the vmmServer resource in which this resource resides.")
  vmmServerId?: string;

  @doc("Gets or sets the provisioning state.")
  @visibility("read")
  provisioningState?: string;
}

@doc("Defines the resource properties.")
@discriminator("inventoryType")
model InventoryItemProperties {
  @doc("Gets the tracked resource id corresponding to the inventory resource.")
  @visibility("read")
  managedResourceId?: string;

  @doc("Gets the UUID (which is assigned by VMM) for the inventory item.")
  @visibility("read")
  uuid?: string;

  @doc("Gets the Managed Object name in VMM for the inventory item.")
  @visibility("read")
  inventoryItemName?: string;

  @doc("Gets the provisioning state.")
  @visibility("read")
  provisioningState?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("Defines the resource properties.")
model InventoryItemDetails {
  @doc("Gets or sets the inventory Item ID for the resource.")
  inventoryItemId?: string;

  @doc("Gets or sets the Managed Object name in VMM for the resource.")
  inventoryItemName?: string;
}

@doc("The Cloud inventory item.")
model CloudInventoryItem extends InventoryItemProperties {
  @doc("They inventory type.")
  inventoryType: "Cloud";
}

@doc("The Virtual network inventory item.")
model VirtualNetworkInventoryItem extends InventoryItemProperties {
  @doc("They inventory type.")
  inventoryType: "VirtualNetwork";
}

@doc("The Virtual machine template inventory item.")
model VirtualMachineTemplateInventoryItem extends InventoryItemProperties {
  @doc("Gets or sets the desired number of vCPUs for the vm.")
  @visibility("read")
  cpuCount?: int32;

  @doc("MemoryMB is the desired size of a virtual machine's memory, in MB.")
  @visibility("read")
  memoryMB?: int32;

  @doc("Gets or sets the type of the os.")
  @visibility("read")
  osType?: OsType;

  @doc("Gets or sets os name.")
  @visibility("read")
  osName?: string;

  @doc("They inventory type.")
  inventoryType: "VirtualMachineTemplate";
}

@doc("The Virtual machine inventory item.")
model VirtualMachineInventoryItem extends InventoryItemProperties {
  @doc("Gets or sets the type of the os.")
  @visibility("read")
  osType?: OsType;

  @doc("Gets or sets os name.")
  @visibility("read")
  osName?: string;

  @doc("Gets the power state of the virtual machine.")
  @visibility("read")
  powerState?: string;

  @doc("Gets or sets the nic ip addresses.")
  ipAddresses?: string[];

  @doc("Cloud inventory resource details where the VM is present.")
  cloud?: InventoryItemDetails;

  @doc("They inventory type.")
  inventoryType: "VirtualMachine";
}
