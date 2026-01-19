import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ConnectedVMwarevSphere;

interface Operations extends Azure.ResourceManager.Operations {}

enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
  Created,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum OsType {
  Windows,
  Linux,
  Other,
}

enum NICType {
  vmxnet3,
  vmxnet2,
  vmxnet,
  e1000,
  e1000e,
  pcnet32,
}

enum PowerOnBootOption {
  enabled,
  disabled,
}

enum IPAddressAllocationMethod {
  unset,
  dynamic,
  static,
  linklayer,
  random,
  other,
}

enum DiskMode {
  persistent,
  independent_persistent,
  independent_nonpersistent,
}

enum DiskType {
  flat,
  pmem,
  rawphysical,
  rawvirtual,
  sparse,
  sesparse,
  `unknown`,
}

enum FirmwareType {
  bios,
  efi,
}

enum InventoryType {
  ResourcePool,
  VirtualMachine,
  VirtualMachineTemplate,
  VirtualNetwork,
  Cluster,
  Datastore,
  Host,
}

enum ScsiControllerType {
  lsilogic,
  buslogic,
  pvscsi,
  lsilogicsas,
}

enum VirtualScsiSharing {
  noSharing,
  physicalSharing,
  virtualSharing,
}

enum ProvisioningAction {
  install,
  uninstall,
  repair,
}

@doc("Lists the operations available.")
model OperationsList is Azure.Core.Page<Operation>;

@doc("Describes the properties of a Resource Pool.")
model ResourcePoolProperties {
  @doc("Gets or sets a unique identifier for this resource.")
  @visibility("read")
  uuid?: string;

  @doc("Gets or sets the ARM Id of the vCenter resource in which this resource pool resides.")
  vCenterId?: string;

  @doc("Gets or sets the vCenter MoRef (Managed Object Reference) ID for the resource pool.")
  moRefId?: string;

  @doc("Gets or sets the inventory Item ID for the resource pool.")
  inventoryItemId?: string;

  @doc("Gets or sets the vCenter Managed Object name for the resource pool.")
  @visibility("read")
  moName?: string;

  @doc("""
Gets or sets CPUSharesLevel which specifies the CPU allocation level for this pool.
This property is used in relative allocation between resource consumers.
""")
  @visibility("read")
  cpuSharesLevel?: string;

  @doc("""
Gets or sets CPUReservationMHz which specifies the CPU size in MHz that is guaranteed
to be available.
""")
  @visibility("read")
  cpuReservationMHz?: int32;

  @doc("""
Gets or sets CPULimitMHz which specifies a CPU usage limit in MHz.
Utilization will not exceed this limit even if there are available resources.
""")
  @visibility("read")
  cpuLimitMHz?: int32;

  @doc("""
Gets or sets CPUSharesLevel which specifies the memory allocation level for this pool.
This property is used in relative allocation between resource consumers.
""")
  @visibility("read")
  memSharesLevel?: string;

  @doc("""
Gets or sets MemReservationMB which specifies the guaranteed available memory in
megabytes.
""")
  @visibility("read")
  memReservationMB?: int32;

  @doc("""
Gets or sets MemLimitMB specifies a memory usage limit in megabytes.
Utilization will not exceed the specified limit even if there are available resources.
""")
  @visibility("read")
  memLimitMB?: int32;

  @doc("Gets the used physical memory on the pool in GB.")
  @visibility("read")
  memOverallUsageGB?: int32;

  @doc("Gets the total amount of physical memory on the pool in GB.")
  @visibility("read")
  memCapacityGB?: int32;

  @doc("Gets the used CPU usage across all cores on the pool in MHz.")
  @visibility("read")
  cpuOverallUsageMHz?: int32;

  @doc("Gets the max CPU usage across all cores on the pool in MHz.")
  @visibility("read")
  cpuCapacityMHz?: int32;

  @doc("Gets the name of the corresponding resource in Kubernetes.")
  @visibility("read")
  customResourceName?: string;

  @doc("Gets the datastore ARM ids.")
  @visibility("read")
  datastoreIds?: string[];

  @doc("Gets the network ARM ids.")
  @visibility("read")
  networkIds?: string[];

  @doc("The resource status information.")
  @visibility("read")
  statuses?: ResourceStatus[];

  @doc("Gets the provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The resource status information.")
model ResourceStatus {
  @doc("The type of the condition.")
  @visibility("read")
  type?: string;

  @doc("Status of the condition.")
  @visibility("read")
  status?: string;

  @doc("The reason for the condition's status.")
  @visibility("read")
  reason?: string;

  @doc("A human readable message indicating details about the status.")
  @visibility("read")
  message?: string;

  @doc("Severity with which to treat failures of this type of condition.")
  @visibility("read")
  severity?: string;

  @doc("The last update time for this condition.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedAt?: utcDateTime;
}

@doc("The extended location.")
model ExtendedLocation {
  @doc("The extended location type.")
  type?: string;

  @doc("The extended location name.")
  name?: string;
}

@doc("Describes the properties of a Cluster.")
model ClusterProperties {
  @doc("Gets or sets a unique identifier for this resource.")
  @visibility("read")
  uuid?: string;

  @doc("Gets or sets the ARM Id of the vCenter resource in which this cluster resides.")
  vCenterId?: string;

  @doc("Gets or sets the vCenter MoRef (Managed Object Reference) ID for the cluster.")
  moRefId?: string;

  @doc("Gets or sets the inventory Item ID for the cluster.")
  inventoryItemId?: string;

  @doc("Gets or sets the vCenter Managed Object name for the cluster.")
  @visibility("read")
  moName?: string;

  @doc("The resource status information.")
  @visibility("read")
  statuses?: ResourceStatus[];

  @doc("Gets the name of the corresponding resource in Kubernetes.")
  @visibility("read")
  customResourceName?: string;

  @doc("Gets the used physical memory on the cluster in GB.")
  @visibility("read")
  usedMemoryGB?: int32;

  @doc("Gets the total amount of physical memory on the cluster in GB.")
  @visibility("read")
  totalMemoryGB?: int32;

  @doc("Gets the used CPU usage across all cores on the cluster in MHz.")
  @visibility("read")
  usedCpuMHz?: int32;

  @doc("Gets the max CPU usage across all cores on the cluster in MHz.")
  @visibility("read")
  totalCpuMHz?: int32;

  @doc("Gets the datastore ARM ids.")
  @visibility("read")
  datastoreIds?: string[];

  @doc("Gets the network ARM ids.")
  @visibility("read")
  networkIds?: string[];

  @doc("Gets the provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Describes the properties of a Host.")
model HostProperties {
  @doc("Gets or sets a unique identifier for this resource.")
  @visibility("read")
  uuid?: string;

  @doc("Gets or sets the ARM Id of the vCenter resource in which this host resides.")
  vCenterId?: string;

  @doc("Gets or sets the vCenter MoRef (Managed Object Reference) ID for the host.")
  moRefId?: string;

  @doc("Gets or sets the inventory Item ID for the host.")
  inventoryItemId?: string;

  @doc("Gets or sets the vCenter Managed Object name for the host.")
  @visibility("read")
  moName?: string;

  @doc("The resource status information.")
  @visibility("read")
  statuses?: ResourceStatus[];

  @doc("Gets the name of the corresponding resource in Kubernetes.")
  @visibility("read")
  customResourceName?: string;

  @doc("Gets the used physical memory on the host in GB.")
  @visibility("read")
  overallMemoryUsageGB?: int32;

  @doc("Gets the total amount of physical memory on the host in GB.")
  @visibility("read")
  memorySizeGB?: int32;

  @doc("Gets the used CPU usage across all cores in MHz.")
  @visibility("read")
  overallCpuUsageMHz?: int32;

  @doc("Gets the max CPU usage across all cores in MHz.")
  @visibility("read")
  cpuMhz?: int32;

  @doc("Gets the datastore ARM ids.")
  @visibility("read")
  datastoreIds?: string[];

  @doc("Gets the network ARM ids.")
  @visibility("read")
  networkIds?: string[];

  @doc("Gets the provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Describes the properties of a Datastore.")
model DatastoreProperties {
  @doc("Gets or sets a unique identifier for this resource.")
  @visibility("read")
  uuid?: string;

  @doc("Gets or sets the ARM Id of the vCenter resource in which this datastore resides.")
  vCenterId?: string;

  @doc("Gets or sets the vCenter MoRef (Managed Object Reference) ID for the datastore.")
  moRefId?: string;

  @doc("Gets or sets the inventory Item ID for the datastore.")
  inventoryItemId?: string;

  @doc("Gets or sets the vCenter Managed Object name for the datastore.")
  @visibility("read")
  moName?: string;

  @doc("The resource status information.")
  @visibility("read")
  statuses?: ResourceStatus[];

  @doc("Gets the name of the corresponding resource in Kubernetes.")
  @visibility("read")
  customResourceName?: string;

  @doc("Gets or sets Maximum capacity of this datastore in GBs.")
  @visibility("read")
  capacityGB?: int32;

  @doc("Gets or sets Available space of this datastore in GBs.")
  @visibility("read")
  freeSpaceGB?: int32;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Describes the properties of a VCenter.")
model VCenterProperties {
  @doc("Gets or sets a unique identifier for this resource.")
  @visibility("read")
  uuid?: string;

  @doc("Gets or sets the FQDN/IPAddress of the vCenter.")
  fqdn: string;

  @doc("Gets or sets the port of the vCenter.")
  port?: int32;

  @doc("Gets or sets the version of the vCenter.")
  @visibility("read")
  version?: string;

  @doc("Gets or sets the instance UUID of the vCenter.")
  @visibility("read")
  instanceUuid?: string;

  @doc("Gets or sets the connection status to the vCenter.")
  @visibility("read")
  connectionStatus?: string;

  @doc("Gets the name of the corresponding resource in Kubernetes.")
  @visibility("read")
  customResourceName?: string;

  @doc("Username / Password Credentials to connect to vcenter.")
  credentials?: VICredential;

  @doc("The resource status information.")
  @visibility("read")
  statuses?: ResourceStatus[];

  @doc("Gets the provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Username / Password Credentials to connect to vcenter.")
model VICredential {
  @doc("Gets or sets username to connect with the vCenter.")
  username?: string;

  @doc("Gets or sets the password to connect with the vCenter.")
  @visibility("create", "update")
  password?: string;
}

@doc("Describes the properties of a Virtual Machine Template.")
model VirtualMachineTemplateProperties {
  @doc("Gets or sets a unique identifier for this resource.")
  @visibility("read")
  uuid?: string;

  @doc("Gets or sets the ARM Id of the vCenter resource in which this template resides.")
  vCenterId?: string;

  @doc("""
Gets or sets the vCenter MoRef (Managed Object Reference) ID for the virtual machine
template.
""")
  moRefId?: string;

  @doc("Gets or sets the inventory Item ID for the virtual machine template.")
  inventoryItemId?: string;

  @doc("Gets or sets the vCenter Managed Object name for the virtual machine template.")
  @visibility("read")
  moName?: string;

  @doc("Gets or sets memory size in MBs for the template.")
  @visibility("read")
  memorySizeMB?: int32;

  @doc("Gets or sets the number of vCPUs for the template.")
  @visibility("read")
  numCPUs?: int32;

  @doc("""
Gets or sets the number of cores per socket for the template.
Defaults to 1 if unspecified.
""")
  @visibility("read")
  numCoresPerSocket?: int32;

  @doc("Gets or sets the type of the os.")
  @visibility("read")
  osType?: OsType;

  @doc("Gets or sets os name.")
  @visibility("read")
  osName?: string;

  @doc("Gets or sets the folder path of the template.")
  @visibility("read")
  folderPath?: string;

  @doc("Gets or sets the network interfaces of the template.")
  @visibility("read")
  networkInterfaces?: NetworkInterface[];

  @doc("Gets or sets the disks the template.")
  @visibility("read")
  disks?: VirtualDisk[];

  @doc("Gets the name of the corresponding resource in Kubernetes.")
  @visibility("read")
  customResourceName?: string;

  @doc("Gets or sets the current version status of VMware Tools installed in the guest operating system.")
  @visibility("read")
  toolsVersionStatus?: string;

  @doc("Gets or sets the current version of VMware Tools.")
  @visibility("read")
  toolsVersion?: string;

  @doc("Firmware type")
  @visibility("read")
  firmwareType?: FirmwareType;

  @doc("The resource status information.")
  @visibility("read")
  statuses?: ResourceStatus[];

  @doc("Gets the provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Network Interface model")
model NetworkInterface {
  @doc("Gets or sets the name of the network interface.")
  name?: string;

  @doc("Gets or sets the label of the virtual network in vCenter that the nic is connected to.")
  @visibility("read")
  label?: string;

  @doc("Gets or sets the nic ip addresses.")
  @visibility("read")
  ipAddresses?: string[];

  @doc("Gets or sets the NIC MAC address.")
  @visibility("read")
  macAddress?: string;

  @doc("Gets or sets the ARM Id of the network resource to connect the virtual machine.")
  networkId?: string;

  @doc("NIC type")
  nicType?: NICType;

  @doc("Gets or sets the power on boot.")
  powerOnBoot?: PowerOnBootOption;

  @doc("""
Gets or sets the vCenter MoRef (Managed Object Reference) ID of the virtual network
that the nic is connected to.
""")
  @visibility("read")
  networkMoRefId?: string;

  @doc("Gets or sets the name of the virtual network in vCenter that the nic is connected to.")
  @visibility("read")
  networkMoName?: string;

  @doc("Gets or sets the device key value.")
  deviceKey?: int32;

  @doc("Gets or sets the ipsettings.")
  ipSettings?: NicIPSettings;
}

@doc("Defines the network interface ip settings.")
model NicIPSettings {
  @doc("Gets or sets the nic allocation method.")
  allocationMethod?: IPAddressAllocationMethod;

  @doc("Gets or sets the dns servers.")
  dnsServers?: string[];

  @doc("Gets or sets the gateway.")
  gateway?: string[];

  @doc("Gets or sets the ip address for the nic.")
  ipAddress?: string;

  @doc("Gets or sets the mask.")
  subnetMask?: string;

  @doc("Gets or sets the primary server.")
  @visibility("read")
  primaryWinsServer?: string;

  @doc("Gets or sets the secondary server.")
  @visibility("read")
  secondaryWinsServer?: string;

  @doc("Gets or sets the IP address information being reported for this NIC. This contains the same IPv4 information above plus IPV6 information.")
  @visibility("read")
  ipAddressInfo?: NicIPAddressSettings[];
}

@doc("IP address information for a virtual network adapter reported by the fabric.")
model NicIPAddressSettings {
  @doc("Gets the ip address allocation method.")
  @visibility("read")
  allocationMethod?: string;

  @doc("Gets the ip address for the nic.")
  @visibility("read")
  ipAddress?: string;

  @doc("Gets the mask.")
  @visibility("read")
  subnetMask?: string;
}

@doc("Virtual disk model")
model VirtualDisk {
  @doc("Gets or sets the name of the virtual disk.")
  name?: string;

  @doc("Gets or sets the label of the virtual disk in vCenter.")
  @visibility("read")
  label?: string;

  @doc("Gets or sets the disk object id.")
  @visibility("read")
  diskObjectId?: string;

  @doc("Gets or sets the disk total size.")
  diskSizeGB?: int32;

  @doc("Gets or sets the device key value.")
  deviceKey?: int32;

  @doc("Gets or sets the disk mode.")
  diskMode?: DiskMode;

  @doc("Gets or sets the controller id.")
  controllerKey?: int32;

  @doc("Gets or sets the unit number of the disk on the controller.")
  unitNumber?: int32;

  @doc("Gets or sets the device name.")
  deviceName?: string;

  @doc("Gets or sets the disk backing type.")
  diskType?: DiskType;
}

@doc("Describes the properties of a Virtual Network.")
model VirtualNetworkProperties {
  @doc("Gets or sets a unique identifier for this resource.")
  @visibility("read")
  uuid?: string;

  @doc("Gets or sets the ARM Id of the vCenter resource in which this template resides.")
  vCenterId?: string;

  @doc("Gets or sets the vCenter MoRef (Managed Object Reference) ID for the virtual network.")
  moRefId?: string;

  @doc("Gets or sets the inventory Item ID for the virtual network.")
  inventoryItemId?: string;

  @doc("Gets or sets the vCenter Managed Object name for the virtual network.")
  @visibility("read")
  moName?: string;

  @doc("Gets the name of the corresponding resource in Kubernetes.")
  @visibility("read")
  customResourceName?: string;

  @doc("The resource status information.")
  @visibility("read")
  statuses?: ResourceStatus[];

  @doc("Gets the provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Describes the properties of an Inventory Item.")
@discriminator("inventoryType")
model InventoryItemProperties {
  @doc("Gets or sets the tracked resource id corresponding to the inventory resource.")
  managedResourceId?: string;

  @doc("Gets or sets the MoRef (Managed Object Reference) ID for the inventory item.")
  moRefId?: string;

  @doc("Gets or sets the vCenter Managed Object name for the inventory item.")
  moName?: string;

  @doc("Gets the provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Describes the properties of a Virtual Machine Instance.")
model VirtualMachineInstanceProperties {
  @doc("Placement properties.")
  placementProfile?: PlacementProfile;

  @doc("OS properties.")
  osProfile?: OsProfileForVMInstance;

  @doc("Hardware properties.")
  hardwareProfile?: HardwareProfile;

  @doc("Network properties.")
  networkProfile?: NetworkProfile;

  @doc("Storage properties.")
  storageProfile?: StorageProfile;

  @doc("Gets the security profile.")
  securityProfile?: SecurityProfile;

  @doc("Gets the infrastructure profile.")
  infrastructureProfile?: InfrastructureProfile;

  @doc("Gets the power state of the virtual machine.")
  @visibility("read")
  powerState?: string;

  @doc("The resource status information.")
  @visibility("read")
  statuses?: ResourceStatus[];

  @doc("Gets the provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Gets or sets a unique identifier for the vm resource.")
  @visibility("read")
  resourceUid?: string;
}

@doc("Specifies the compute and storage placement settings for the virtual machine.")
model PlacementProfile {
  @doc("Gets or sets the ARM Id of the resourcePool resource on which this virtual machine will deploy.")
  resourcePoolId?: string;

  @doc("Gets or sets the ARM Id of the cluster resource on which this virtual machine will deploy.")
  clusterId?: string;

  @doc("Gets or sets the ARM Id of the host resource on which this virtual machine will deploy.")
  hostId?: string;

  @doc("Gets or sets the ARM Id of the datastore resource on which the data for the virtual machine will be kept.")
  datastoreId?: string;
}

@doc("Specifies the operating system settings for the virtual machine.")
model OsProfileForVMInstance {
  @doc("Gets or sets computer name.")
  computerName?: string;

  @doc("Gets or sets administrator username.")
  adminUsername?: string;

  @doc("Sets administrator password.")
  @visibility("create", "update")
  adminPassword?: string;

  @doc("Gets or sets the guestId.")
  guestId?: string;

  @doc("Gets or sets the type of the os.")
  osType?: OsType;

  @doc("Gets or sets os sku.")
  @visibility("read")
  osSku?: string;

  @doc("Gets or sets the current running status of VMware Tools running in the guest operating system.")
  @visibility("read")
  toolsRunningStatus?: string;

  @doc("Gets or sets the current version status of VMware Tools installed in the guest operating system.")
  @visibility("read")
  toolsVersionStatus?: string;

  @doc("Gets or sets the current version of VMware Tools.")
  @visibility("read")
  toolsVersion?: string;
}

@doc("Specifies the hardware settings for the virtual machine.")
model HardwareProfile {
  @doc("Gets or sets memory size in MBs for the vm.")
  memorySizeMB?: int32;

  @doc("Gets or sets the number of vCPUs for the vm.")
  numCPUs?: int32;

  @doc("Gets or sets the number of cores per socket for the vm. Defaults to 1 if unspecified.")
  numCoresPerSocket?: int32;

  @doc("Gets or sets a value indicating whether virtual processors can be added while this virtual machine is running.")
  @visibility("read")
  cpuHotAddEnabled?: boolean;

  @doc("Gets or sets a value indicating whether virtual processors can be removed while this virtual machine is running.")
  @visibility("read")
  cpuHotRemoveEnabled?: boolean;

  @doc("Gets or sets a value indicating whether memory can be added while this virtual machine is running.")
  @visibility("read")
  memoryHotAddEnabled?: boolean;
}

@doc("Specifies the network interfaces of the virtual machine.")
model NetworkProfile {
  @doc("Gets or sets the list of network interfaces associated with the virtual machine.")
  networkInterfaces?: NetworkInterface[];
}

@doc("Specifies the storage settings for the virtual machine disks.")
model StorageProfile {
  @doc("Gets or sets the list of virtual disks associated with the virtual machine.")
  disks?: VirtualDisk[];

  @doc("Gets or sets the list of virtual SCSI controllers associated with the virtual machine.")
  @visibility("read")
  scsiControllers?: VirtualScsiController[];
}

@doc("This data object type contains the properties of a SCSI controller device attached to a virtual machine that is reported by the controller.")
model VirtualScsiController {
  @doc("Gets or sets the controller type.")
  type?: ScsiControllerType;

  @doc("Gets or sets the key of the controller.")
  controllerKey?: int32;

  @doc("Gets or sets the bus number of the controller.")
  busNumber?: int32;

  @doc("Gets or sets the SCSI controller unit number.")
  scsiCtlrUnitNumber?: int32;

  @doc("Gets or sets the sharing mode.")
  sharing?: VirtualScsiSharing;
}

@doc("Specifies the Security profile settings for the virtual machine.")
model SecurityProfile {
  @doc("Specifies the security settings like secure boot used while creating the virtual machine.")
  uefiSettings?: UefiSettings;
}

@doc("Specifies the security settings like secure boot used while creating the virtual machine.")
model UefiSettings {
  @doc("Specifies whether secure boot should be enabled on the virtual machine.")
  secureBootEnabled?: boolean;
}

@doc("Specifies the vCenter infrastructure specific settings for the virtual machine.")
model InfrastructureProfile {
  @doc("Gets or sets the ARM Id of the template resource to deploy the virtual machine.")
  templateId?: string;

  @doc("Gets or sets the ARM Id of the vCenter resource in which this resource pool resides.")
  vCenterId?: string;

  @doc("Gets or sets the vCenter MoRef (Managed Object Reference) ID for the virtual machine.")
  @visibility("read")
  moRefId?: string;

  @doc("Gets or sets the inventory Item ID for the virtual machine.")
  inventoryItemId?: string;

  @doc("Gets or sets the vCenter Managed Object name for the virtual machine.")
  @visibility("read")
  moName?: string;

  @doc("Gets or sets the folder path of the vm.")
  @visibility("read")
  folderPath?: string;

  @doc("Gets or sets the instance uuid of the vm.")
  @visibility("read")
  instanceUuid?: string;

  @doc("Gets or sets the SMBIOS UUID of the vm.")
  smbiosUuid?: string;

  @doc("Firmware type")
  firmwareType?: FirmwareType;

  @doc("Gets the name of the corresponding resource in Kubernetes.")
  @visibility("read")
  customResourceName?: string;
}

@doc("Specifies the storage settings for the virtual machine disks.")
model StorageProfileUpdate {
  @doc("Gets or sets the list of virtual disks associated with the virtual machine.")
  disks?: VirtualDiskUpdate[];
}

@doc("Defines the virtual disk update.")
model VirtualDiskUpdate {
  @doc("Gets or sets the name of the virtual disk.")
  name?: string;

  @doc("Gets or sets the disk total size.")
  diskSizeGB?: int32;

  @doc("Gets or sets the device key value.")
  deviceKey?: int32;

  @doc("Gets or sets the disk mode.")
  diskMode?: DiskMode;

  @doc("Gets or sets the controller id.")
  controllerKey?: int32;

  @doc("Gets or sets the unit number of the disk on the controller.")
  unitNumber?: int32;

  @doc("Gets or sets the device name.")
  deviceName?: string;

  @doc("Gets or sets the disk backing type.")
  diskType?: DiskType;
}

@doc("Specifies the network interfaces of the virtual machine.")
model NetworkProfileUpdate {
  @doc("Gets or sets the list of network interfaces associated with the virtual machine.")
  networkInterfaces?: NetworkInterfaceUpdate[];
}

@doc("Defines the network interface update.")
model NetworkInterfaceUpdate {
  @doc("Gets or sets the name of the network interface.")
  name?: string;

  @doc("Gets or sets the ARM Id of the network resource to connect the virtual machine.")
  networkId?: string;

  @doc("NIC type")
  nicType?: NICType;

  @doc("Gets or sets the power on boot.")
  powerOnBoot?: PowerOnBootOption;

  @doc("Gets or sets the device key value.")
  deviceKey?: int32;
}

@doc("Defines the stop action properties.")
model StopVirtualMachineOptions {
  @doc("Gets or sets a value indicating whether to request non-graceful VM shutdown. True value for this flag indicates non-graceful shutdown whereas false indicates otherwise. Defaults to false.")
  skipShutdown?: boolean;
}

@doc("Describes the properties of Hybrid Identity Metadata for a Virtual Machine.")
model VmInstanceHybridIdentityMetadataProperties {
  @doc("The unique identifier for the resource.")
  resourceUid?: string;

  @doc("Gets or sets the Public Key.")
  publicKey?: string;

  @doc("Gets the provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Describes the properties of a Virtual Machine Guest Agent.")
model GuestAgentProperties {
  @doc("Gets or sets a unique identifier for this resource.")
  @visibility("read")
  uuid?: string;

  @doc("Username / Password Credentials to provision guest agent.")
  credentials?: GuestCredential;

  @doc("The resource id of the private link scope this machine is assigned to, if any.")
  privateLinkScopeResourceId?: ResourceIdentifier;

  @doc("HTTP Proxy configuration for the VM.")
  httpProxyConfig?: HttpProxyConfiguration;

  @doc("Gets or sets the guest agent provisioning action.")
  provisioningAction?: ProvisioningAction;

  @doc("Gets or sets the guest agent status.")
  @visibility("read")
  status?: string;

  @doc("Gets the name of the corresponding resource in Kubernetes.")
  @visibility("read")
  customResourceName?: string;

  @doc("The resource status information.")
  @visibility("read")
  statuses?: ResourceStatus[];

  @doc("Gets the provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Username / Password Credentials to connect to guest.")
model GuestCredential {
  @doc("Gets or sets username to connect with the guest.")
  username?: string;

  @doc("Gets or sets the password to connect with the guest.")
  @visibility("create", "update")
  password?: string;
}

@doc("HTTP Proxy configuration for the VM.")
model HttpProxyConfiguration {
  @doc("Gets or sets httpsProxy url.")
  httpsProxy?: string;
}

@doc("Condition defines an extension to status.")
model Condition {
  @doc("Status of the condition.")
  @visibility("read")
  status?: string;

  @doc("The reason for the condition's status.")
  @visibility("read")
  reason?: string;

  @doc("A human readable message indicating details about the status.")
  @visibility("read")
  message?: string;

  @doc("Severity with which to treat failures of this type of condition.")
  @visibility("read")
  severity?: string;
}

@doc("The resource pool inventory item.")
model ResourcePoolInventoryItem extends InventoryItemProperties {
  @doc("Parent resourcePool inventory resource details.")
  parent?: InventoryItemDetails;

  @doc("They inventory type.")
  inventoryType: "ResourcePool";
}

@doc("Describes the properties of an Inventory Item reference.")
model InventoryItemDetails {
  @doc("Gets or sets the inventory Item ID for the resource.")
  inventoryItemId?: string;

  @doc("Gets or sets the vCenter Managed Object name for the resource.")
  moName?: string;

  @doc("The inventory type.")
  inventoryType?: InventoryType;
}

@doc("The VM inventory item.")
model VirtualMachineInventoryItem extends InventoryItemProperties {
  @doc("Gets or sets the type of the os.")
  osType?: OsType;

  @doc("Gets or sets os name.")
  osName?: string;

  @doc("Gets or sets the nic ip addresses.")
  ipAddresses?: string[];

  @doc("Gets or sets the folder path of the vm.")
  folderPath?: string;

  @doc("Host inventory resource details.")
  host?: InventoryItemDetails;

  @doc("ResourcePool inventory resource details.")
  resourcePool?: InventoryItemDetails;

  @doc("Cluster inventory resource details.")
  cluster?: InventoryItemDetails;

  @doc("Gets or sets the instance uuid of the vm.")
  instanceUuid?: string;

  @doc("Gets or sets the SMBIOS UUID of the vm.")
  smbiosUuid?: string;

  @doc("Gets the power state of the virtual machine.")
  @visibility("read")
  powerState?: string;

  @doc("Gets or sets the current running status of VMware Tools running in the guest operating system.")
  @visibility("read")
  toolsRunningStatus?: string;

  @doc("Gets or sets the current version status of VMware Tools installed in the guest operating system.")
  @visibility("read")
  toolsVersionStatus?: string;

  @doc("Gets or sets the current version of VMware Tools.")
  @visibility("read")
  toolsVersion?: string;

  @doc("They inventory type.")
  inventoryType: "VirtualMachine";
}

@doc("The VM Template inventory item.")
model VirtualMachineTemplateInventoryItem extends InventoryItemProperties {
  @doc("Gets or sets memory size in MBs for the template.")
  memorySizeMB?: int32;

  @doc("Gets or sets the number of vCPUs for the template.")
  numCPUs?: int32;

  @doc("""
Gets or sets the number of cores per socket for the template.
Defaults to 1 if unspecified.
""")
  numCoresPerSocket?: int32;

  @doc("Gets or sets the type of the os.")
  osType?: OsType;

  @doc("Gets or sets os name.")
  osName?: string;

  @doc("Gets or sets the current version status of VMware Tools installed in the guest operating system.")
  @visibility("read")
  toolsVersionStatus?: string;

  @doc("Gets or sets the current version of VMware Tools.")
  @visibility("read")
  toolsVersion?: string;

  @doc("Gets or sets the folder path of the template.")
  folderPath?: string;

  @doc("They inventory type.")
  inventoryType: "VirtualMachineTemplate";
}

@doc("The Virtual network inventory item.")
model VirtualNetworkInventoryItem extends InventoryItemProperties {
  @doc("They inventory type.")
  inventoryType: "VirtualNetwork";
}

@doc("The cluster inventory item.")
model ClusterInventoryItem extends InventoryItemProperties {
  @doc("They inventory type.")
  inventoryType: "Cluster";
}

@doc("The datastore inventory item.")
model DatastoreInventoryItem extends InventoryItemProperties {
  @doc("Gets or sets Maximum capacity of this datastore, in GBs.")
  capacityGB?: int32;

  @doc("Gets or sets Available space of this datastore, in GBs.")
  freeSpaceGB?: int32;

  @doc("They inventory type.")
  inventoryType: "Datastore";
}

@doc("The host inventory item.")
model HostInventoryItem extends InventoryItemProperties {
  @doc("Parent host inventory resource details.")
  parent?: InventoryItemDetails;

  @doc("They inventory type.")
  inventoryType: "Host";
}
