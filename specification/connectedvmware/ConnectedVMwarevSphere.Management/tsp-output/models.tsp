import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ConnectedVMwarevSphere;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The current deployment state of resource.
 */
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

/**
 * Defines the different types of VM guest operating systems.
 */
enum OsType {
  Windows,
  Linux,
  Other,
}

/**
 * NIC type
 */
enum NICType {
  vmxnet3,
  vmxnet2,
  vmxnet,
  e1000,
  e1000e,
  pcnet32,
}

/**
 * Defines the options for power on boot.
 */
enum PowerOnBootOption {
  enabled,
  disabled,
}

/**
 * IP address allocation method.
 */
enum IPAddressAllocationMethod {
  unset,
  dynamic,
  static,
  linklayer,
  random,
  other,
}

/**
 * Defines the different types of disk modes.
 */
enum DiskMode {
  persistent,
  independent_persistent,
  independent_nonpersistent,
}

/**
 * Defines the different types of disks.
 */
enum DiskType {
  flat,
  pmem,
  rawphysical,
  rawvirtual,
  sparse,
  sesparse,
  `unknown`,
}

/**
 * Firmware type
 */
enum FirmwareType {
  bios,
  efi,
}

/**
 * The inventory type.
 */
enum InventoryType {
  ResourcePool,
  VirtualMachine,
  VirtualMachineTemplate,
  VirtualNetwork,
  Cluster,
  Datastore,
  Host,
}

/**
 * Defines the different types of SCSI controllers.
 */
enum ScsiControllerType {
  lsilogic,
  buslogic,
  pvscsi,
  lsilogicsas,
}

/**
 * Defines the sharing mode for sharing the SCSI bus.
 */
enum VirtualScsiSharing {
  noSharing,
  physicalSharing,
  virtualSharing,
}

/**
 * Defines the different types of operations for guest agent.
 */
enum ProvisioningAction {
  install,
  uninstall,
  repair,
}

/**
 * Describes the properties of a Resource Pool.
 */
model ResourcePoolProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility("read")
  uuid?: string;

  /**
   * Gets or sets the ARM Id of the vCenter resource in which this resource pool resides.
   */
  vCenterId?: string;

  /**
   * Gets or sets the vCenter MoRef (Managed Object Reference) ID for the resource pool.
   */
  moRefId?: string;

  /**
   * Gets or sets the inventory Item ID for the resource pool.
   */
  inventoryItemId?: string;

  /**
   * Gets or sets the vCenter Managed Object name for the resource pool.
   */
  @visibility("read")
  moName?: string;

  /**
* Gets or sets CPUSharesLevel which specifies the CPU allocation level for this pool.
This property is used in relative allocation between resource consumers.
*/
  @visibility("read")
  cpuSharesLevel?: string;

  /**
* Gets or sets CPUReservationMHz which specifies the CPU size in MHz that is guaranteed
to be available.
*/
  @visibility("read")
  cpuReservationMHz?: int64;

  /**
* Gets or sets CPULimitMHz which specifies a CPU usage limit in MHz.
Utilization will not exceed this limit even if there are available resources.
*/
  @visibility("read")
  cpuLimitMHz?: int64;

  /**
* Gets or sets CPUSharesLevel which specifies the memory allocation level for this pool.
This property is used in relative allocation between resource consumers.
*/
  @visibility("read")
  memSharesLevel?: string;

  /**
* Gets or sets MemReservationMB which specifies the guaranteed available memory in
megabytes.
*/
  @visibility("read")
  memReservationMB?: int64;

  /**
* Gets or sets MemLimitMB specifies a memory usage limit in megabytes.
Utilization will not exceed the specified limit even if there are available resources.
*/
  @visibility("read")
  memLimitMB?: int64;

  /**
   * Gets the used physical memory on the pool in GB.
   */
  @visibility("read")
  memOverallUsageGB?: int64;

  /**
   * Gets the total amount of physical memory on the pool in GB.
   */
  @visibility("read")
  memCapacityGB?: int64;

  /**
   * Gets the used CPU usage across all cores on the pool in MHz.
   */
  @visibility("read")
  cpuOverallUsageMHz?: int64;

  /**
   * Gets the max CPU usage across all cores on the pool in MHz.
   */
  @visibility("read")
  cpuCapacityMHz?: int64;

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility("read")
  customResourceName?: string;

  /**
   * Gets the datastore ARM ids.
   */
  @visibility("read")
  datastoreIds?: string[];

  /**
   * Gets the network ARM ids.
   */
  @visibility("read")
  networkIds?: string[];

  /**
   * The resource status information.
   */
  @visibility("read")
  statuses?: ResourceStatus[];

  /**
   * Gets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The resource status information.
 */
model ResourceStatus {
  /**
   * The type of the condition.
   */
  @visibility("read")
  type?: string;

  /**
   * Status of the condition.
   */
  @visibility("read")
  status?: string;

  /**
   * The reason for the condition's status.
   */
  @visibility("read")
  reason?: string;

  /**
   * A human readable message indicating details about the status.
   */
  @visibility("read")
  message?: string;

  /**
   * Severity with which to treat failures of this type of condition.
   */
  @visibility("read")
  severity?: string;

  /**
   * The last update time for this condition.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedAt?: utcDateTime;
}

/**
 * The extended location.
 */
model ExtendedLocation {
  /**
   * The extended location type.
   */
  type?: string;

  /**
   * The extended location name.
   */
  name?: string;
}

/**
 * Object containing updates for patch operations.
 */
model ResourcePatch {
  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Describes the properties of a Cluster.
 */
model ClusterProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility("read")
  uuid?: string;

  /**
   * Gets or sets the ARM Id of the vCenter resource in which this cluster resides.
   */
  vCenterId?: string;

  /**
   * Gets or sets the vCenter MoRef (Managed Object Reference) ID for the cluster.
   */
  moRefId?: string;

  /**
   * Gets or sets the inventory Item ID for the cluster.
   */
  inventoryItemId?: string;

  /**
   * Gets or sets the vCenter Managed Object name for the cluster.
   */
  @visibility("read")
  moName?: string;

  /**
   * The resource status information.
   */
  @visibility("read")
  statuses?: ResourceStatus[];

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility("read")
  customResourceName?: string;

  /**
   * Gets the used physical memory on the cluster in GB.
   */
  @visibility("read")
  usedMemoryGB?: int64;

  /**
   * Gets the total amount of physical memory on the cluster in GB.
   */
  @visibility("read")
  totalMemoryGB?: int64;

  /**
   * Gets the used CPU usage across all cores on the cluster in MHz.
   */
  @visibility("read")
  usedCpuMHz?: int64;

  /**
   * Gets the max CPU usage across all cores on the cluster in MHz.
   */
  @visibility("read")
  totalCpuMHz?: int64;

  /**
   * Gets the datastore ARM ids.
   */
  @visibility("read")
  datastoreIds?: string[];

  /**
   * Gets the network ARM ids.
   */
  @visibility("read")
  networkIds?: string[];

  /**
   * Gets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Describes the properties of a Host.
 */
model HostProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility("read")
  uuid?: string;

  /**
   * Gets or sets the ARM Id of the vCenter resource in which this host resides.
   */
  vCenterId?: string;

  /**
   * Gets or sets the vCenter MoRef (Managed Object Reference) ID for the host.
   */
  moRefId?: string;

  /**
   * Gets or sets the inventory Item ID for the host.
   */
  inventoryItemId?: string;

  /**
   * Gets or sets the vCenter Managed Object name for the host.
   */
  @visibility("read")
  moName?: string;

  /**
   * The resource status information.
   */
  @visibility("read")
  statuses?: ResourceStatus[];

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility("read")
  customResourceName?: string;

  /**
   * Gets the used physical memory on the host in GB.
   */
  @visibility("read")
  overallMemoryUsageGB?: int64;

  /**
   * Gets the total amount of physical memory on the host in GB.
   */
  @visibility("read")
  memorySizeGB?: int64;

  /**
   * Gets the used CPU usage across all cores in MHz.
   */
  @visibility("read")
  overallCpuUsageMHz?: int64;

  /**
   * Gets the max CPU usage across all cores in MHz.
   */
  @visibility("read")
  cpuMhz?: int64;

  /**
   * Gets the datastore ARM ids.
   */
  @visibility("read")
  datastoreIds?: string[];

  /**
   * Gets the network ARM ids.
   */
  @visibility("read")
  networkIds?: string[];

  /**
   * Gets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Describes the properties of a Datastore.
 */
model DatastoreProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility("read")
  uuid?: string;

  /**
   * Gets or sets the ARM Id of the vCenter resource in which this datastore resides.
   */
  vCenterId?: string;

  /**
   * Gets or sets the vCenter MoRef (Managed Object Reference) ID for the datastore.
   */
  moRefId?: string;

  /**
   * Gets or sets the inventory Item ID for the datastore.
   */
  inventoryItemId?: string;

  /**
   * Gets or sets the vCenter Managed Object name for the datastore.
   */
  @visibility("read")
  moName?: string;

  /**
   * The resource status information.
   */
  @visibility("read")
  statuses?: ResourceStatus[];

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility("read")
  customResourceName?: string;

  /**
   * Gets or sets Maximum capacity of this datastore in GBs.
   */
  @visibility("read")
  capacityGB?: int64;

  /**
   * Gets or sets Available space of this datastore in GBs.
   */
  @visibility("read")
  freeSpaceGB?: int64;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Describes the properties of a VCenter.
 */
model VCenterProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility("read")
  uuid?: string;

  /**
   * Gets or sets the FQDN/IPAddress of the vCenter.
   */
  fqdn: string;

  /**
   * Gets or sets the port of the vCenter.
   */
  @maxValue(65535)
  @minValue(1)
  port?: int32;

  /**
   * Gets or sets the version of the vCenter.
   */
  @visibility("read")
  version?: string;

  /**
   * Gets or sets the instance UUID of the vCenter.
   */
  @visibility("read")
  instanceUuid?: string;

  /**
   * Gets or sets the connection status to the vCenter.
   */
  @visibility("read")
  connectionStatus?: string;

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility("read")
  customResourceName?: string;

  /**
   * Username / Password Credentials to connect to vcenter.
   */
  credentials?: VICredential;

  /**
   * The resource status information.
   */
  @visibility("read")
  statuses?: ResourceStatus[];

  /**
   * Gets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Username / Password Credentials to connect to vcenter.
 */
model VICredential {
  /**
   * Gets or sets username to connect with the vCenter.
   */
  username?: string;

  /**
   * Gets or sets the password to connect with the vCenter.
   */
  @visibility("create", "update")
  password?: string;
}

/**
 * Describes the properties of a Virtual Machine Template.
 */
model VirtualMachineTemplateProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility("read")
  uuid?: string;

  /**
   * Gets or sets the ARM Id of the vCenter resource in which this template resides.
   */
  vCenterId?: string;

  /**
* Gets or sets the vCenter MoRef (Managed Object Reference) ID for the virtual machine
template.
*/
  moRefId?: string;

  /**
   * Gets or sets the inventory Item ID for the virtual machine template.
   */
  inventoryItemId?: string;

  /**
   * Gets or sets the vCenter Managed Object name for the virtual machine template.
   */
  @visibility("read")
  moName?: string;

  /**
   * Gets or sets memory size in MBs for the template.
   */
  @visibility("read")
  memorySizeMB?: int32;

  /**
   * Gets or sets the number of vCPUs for the template.
   */
  @visibility("read")
  numCPUs?: int32;

  /**
* Gets or sets the number of cores per socket for the template.
Defaults to 1 if unspecified.
*/
  @visibility("read")
  numCoresPerSocket?: int32;

  /**
   * Gets or sets the type of the os.
   */
  @visibility("read")
  osType?: OsType;

  /**
   * Gets or sets os name.
   */
  @visibility("read")
  osName?: string;

  /**
   * Gets or sets the folder path of the template.
   */
  @visibility("read")
  folderPath?: string;

  /**
   * Gets or sets the network interfaces of the template.
   */
  @visibility("read")
  networkInterfaces?: NetworkInterface[];

  /**
   * Gets or sets the disks the template.
   */
  @visibility("read")
  disks?: VirtualDisk[];

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility("read")
  customResourceName?: string;

  /**
   * Gets or sets the current version status of VMware Tools installed in the guest operating system.
   */
  @visibility("read")
  toolsVersionStatus?: string;

  /**
   * Gets or sets the current version of VMware Tools.
   */
  @visibility("read")
  toolsVersion?: string;

  /**
   * Firmware type
   */
  @visibility("read")
  firmwareType?: FirmwareType;

  /**
   * The resource status information.
   */
  @visibility("read")
  statuses?: ResourceStatus[];

  /**
   * Gets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Network Interface model
 */
model NetworkInterface {
  /**
   * Gets or sets the name of the network interface.
   */
  name?: string;

  /**
   * Gets or sets the label of the virtual network in vCenter that the nic is connected to.
   */
  @visibility("read")
  label?: string;

  /**
   * Gets or sets the nic ip addresses.
   */
  @visibility("read")
  ipAddresses?: string[];

  /**
   * Gets or sets the NIC MAC address.
   */
  @visibility("read")
  macAddress?: string;

  /**
   * Gets or sets the ARM Id of the network resource to connect the virtual machine.
   */
  networkId?: string;

  /**
   * NIC type
   */
  nicType?: NICType;

  /**
   * Gets or sets the power on boot.
   */
  powerOnBoot?: PowerOnBootOption;

  /**
* Gets or sets the vCenter MoRef (Managed Object Reference) ID of the virtual network
that the nic is connected to.
*/
  @visibility("read")
  networkMoRefId?: string;

  /**
   * Gets or sets the name of the virtual network in vCenter that the nic is connected to.
   */
  @visibility("read")
  networkMoName?: string;

  /**
   * Gets or sets the device key value.
   */
  deviceKey?: int32;

  /**
   * Gets or sets the ipsettings.
   */
  ipSettings?: NicIPSettings;
}

/**
 * Defines the network interface ip settings.
 */
model NicIPSettings {
  /**
   * Gets or sets the nic allocation method.
   */
  allocationMethod?: IPAddressAllocationMethod;

  /**
   * Gets or sets the dns servers.
   */
  dnsServers?: string[];

  /**
   * Gets or sets the gateway.
   */
  gateway?: string[];

  /**
   * Gets or sets the ip address for the nic.
   */
  ipAddress?: string;

  /**
   * Gets or sets the mask.
   */
  subnetMask?: string;

  /**
   * Gets or sets the primary server.
   */
  @visibility("read")
  primaryWinsServer?: string;

  /**
   * Gets or sets the secondary server.
   */
  @visibility("read")
  secondaryWinsServer?: string;

  /**
   * Gets or sets the IP address information being reported for this NIC. This contains the same IPv4 information above plus IPV6 information.
   */
  @visibility("read")
  ipAddressInfo?: NicIPAddressSettings[];
}

/**
 * IP address information for a virtual network adapter reported by the fabric.
 */
model NicIPAddressSettings {
  /**
   * Gets the ip address allocation method.
   */
  @visibility("read")
  allocationMethod?: string;

  /**
   * Gets the ip address for the nic.
   */
  @visibility("read")
  ipAddress?: string;

  /**
   * Gets the mask.
   */
  @visibility("read")
  subnetMask?: string;
}

/**
 * Virtual disk model
 */
model VirtualDisk {
  /**
   * Gets or sets the name of the virtual disk.
   */
  name?: string;

  /**
   * Gets or sets the label of the virtual disk in vCenter.
   */
  @visibility("read")
  label?: string;

  /**
   * Gets or sets the disk object id.
   */
  @visibility("read")
  diskObjectId?: string;

  /**
   * Gets or sets the disk total size.
   */
  diskSizeGB?: int32;

  /**
   * Gets or sets the device key value.
   */
  deviceKey?: int32;

  /**
   * Gets or sets the disk mode.
   */
  diskMode?: DiskMode;

  /**
   * Gets or sets the controller id.
   */
  controllerKey?: int32;

  /**
   * Gets or sets the unit number of the disk on the controller.
   */
  unitNumber?: int32;

  /**
   * Gets or sets the device name.
   */
  deviceName?: string;

  /**
   * Gets or sets the disk backing type.
   */
  diskType?: DiskType;
}

/**
 * Describes the properties of a Virtual Network.
 */
model VirtualNetworkProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility("read")
  uuid?: string;

  /**
   * Gets or sets the ARM Id of the vCenter resource in which this template resides.
   */
  vCenterId?: string;

  /**
   * Gets or sets the vCenter MoRef (Managed Object Reference) ID for the virtual network.
   */
  moRefId?: string;

  /**
   * Gets or sets the inventory Item ID for the virtual network.
   */
  inventoryItemId?: string;

  /**
   * Gets or sets the vCenter Managed Object name for the virtual network.
   */
  @visibility("read")
  moName?: string;

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility("read")
  customResourceName?: string;

  /**
   * The resource status information.
   */
  @visibility("read")
  statuses?: ResourceStatus[];

  /**
   * Gets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Describes the properties of an Inventory Item.
 */
@discriminator("inventoryType")
model InventoryItemProperties {
  /**
   * Gets or sets the tracked resource id corresponding to the inventory resource.
   */
  managedResourceId?: string;

  /**
   * Gets or sets the MoRef (Managed Object Reference) ID for the inventory item.
   */
  moRefId?: string;

  /**
   * Gets or sets the vCenter Managed Object name for the inventory item.
   */
  moName?: string;

  /**
   * Gets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: ResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Describes the properties of a Virtual Machine Instance.
 */
model VirtualMachineInstanceProperties {
  /**
   * Placement properties.
   */
  placementProfile?: PlacementProfile;

  /**
   * OS properties.
   */
  osProfile?: OsProfileForVMInstance;

  /**
   * Hardware properties.
   */
  hardwareProfile?: HardwareProfile;

  /**
   * Network properties.
   */
  networkProfile?: NetworkProfile;

  /**
   * Storage properties.
   */
  storageProfile?: StorageProfile;

  /**
   * Gets the security profile.
   */
  securityProfile?: SecurityProfile;

  /**
   * Gets the infrastructure profile.
   */
  infrastructureProfile?: InfrastructureProfile;

  /**
   * Gets the power state of the virtual machine.
   */
  @visibility("read")
  powerState?: string;

  /**
   * The resource status information.
   */
  @visibility("read")
  statuses?: ResourceStatus[];

  /**
   * Gets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets a unique identifier for the vm resource.
   */
  @visibility("read")
  resourceUid?: string;
}

/**
 * Specifies the compute and storage placement settings for the virtual machine.
 */
model PlacementProfile {
  /**
   * Gets or sets the ARM Id of the resourcePool resource on which this virtual machine will deploy.
   */
  resourcePoolId?: string;

  /**
   * Gets or sets the ARM Id of the cluster resource on which this virtual machine will deploy.
   */
  clusterId?: string;

  /**
   * Gets or sets the ARM Id of the host resource on which this virtual machine will deploy.
   */
  hostId?: string;

  /**
   * Gets or sets the ARM Id of the datastore resource on which the data for the virtual machine will be kept.
   */
  datastoreId?: string;
}

/**
 * Specifies the operating system settings for the virtual machine.
 */
model OsProfileForVMInstance {
  /**
   * Gets or sets computer name.
   */
  computerName?: string;

  /**
   * Gets or sets administrator username.
   */
  adminUsername?: string;

  /**
   * Sets administrator password.
   */
  @visibility("create", "update")
  adminPassword?: string;

  /**
   * Gets or sets the guestId.
   */
  guestId?: string;

  /**
   * Gets or sets the type of the os.
   */
  osType?: OsType;

  /**
   * Gets or sets os sku.
   */
  @visibility("read")
  osSku?: string;

  /**
   * Gets or sets the current running status of VMware Tools running in the guest operating system.
   */
  @visibility("read")
  toolsRunningStatus?: string;

  /**
   * Gets or sets the current version status of VMware Tools installed in the guest operating system.
   */
  @visibility("read")
  toolsVersionStatus?: string;

  /**
   * Gets or sets the current version of VMware Tools.
   */
  @visibility("read")
  toolsVersion?: string;
}

/**
 * Specifies the hardware settings for the virtual machine.
 */
model HardwareProfile {
  /**
   * Gets or sets memory size in MBs for the vm.
   */
  memorySizeMB?: int32;

  /**
   * Gets or sets the number of vCPUs for the vm.
   */
  numCPUs?: int32;

  /**
   * Gets or sets the number of cores per socket for the vm. Defaults to 1 if unspecified.
   */
  numCoresPerSocket?: int32;

  /**
   * Gets or sets a value indicating whether virtual processors can be added while this virtual machine is running.
   */
  @visibility("read")
  cpuHotAddEnabled?: boolean;

  /**
   * Gets or sets a value indicating whether virtual processors can be removed while this virtual machine is running.
   */
  @visibility("read")
  cpuHotRemoveEnabled?: boolean;

  /**
   * Gets or sets a value indicating whether memory can be added while this virtual machine is running.
   */
  @visibility("read")
  memoryHotAddEnabled?: boolean;
}

/**
 * Specifies the network interfaces of the virtual machine.
 */
model NetworkProfile {
  /**
   * Gets or sets the list of network interfaces associated with the virtual machine.
   */
  networkInterfaces?: NetworkInterface[];
}

/**
 * Specifies the storage settings for the virtual machine disks.
 */
model StorageProfile {
  /**
   * Gets or sets the list of virtual disks associated with the virtual machine.
   */
  disks?: VirtualDisk[];

  /**
   * Gets or sets the list of virtual SCSI controllers associated with the virtual machine.
   */
  @visibility("read")
  scsiControllers?: VirtualScsiController[];
}

/**
 * This data object type contains the properties of a SCSI controller device attached to a virtual machine that is reported by the controller.
 */
model VirtualScsiController {
  /**
   * Gets or sets the controller type.
   */
  type?: ScsiControllerType;

  /**
   * Gets or sets the key of the controller.
   */
  controllerKey?: int32;

  /**
   * Gets or sets the bus number of the controller.
   */
  busNumber?: int32;

  /**
   * Gets or sets the SCSI controller unit number.
   */
  scsiCtlrUnitNumber?: int32;

  /**
   * Gets or sets the sharing mode.
   */
  sharing?: VirtualScsiSharing;
}

/**
 * Specifies the Security profile settings for the virtual machine.
 */
model SecurityProfile {
  /**
   * Specifies the security settings like secure boot used while creating the virtual machine.
   */
  uefiSettings?: UefiSettings;
}

/**
 * Specifies the security settings like secure boot used while creating the virtual machine.
 */
model UefiSettings {
  /**
   * Specifies whether secure boot should be enabled on the virtual machine.
   */
  secureBootEnabled?: boolean;
}

/**
 * Specifies the vCenter infrastructure specific settings for the virtual machine.
 */
model InfrastructureProfile {
  /**
   * Gets or sets the ARM Id of the template resource to deploy the virtual machine.
   */
  templateId?: string;

  /**
   * Gets or sets the ARM Id of the vCenter resource in which this resource pool resides.
   */
  vCenterId?: string;

  /**
   * Gets or sets the vCenter MoRef (Managed Object Reference) ID for the virtual machine.
   */
  @visibility("read")
  moRefId?: string;

  /**
   * Gets or sets the inventory Item ID for the virtual machine.
   */
  inventoryItemId?: string;

  /**
   * Gets or sets the vCenter Managed Object name for the virtual machine.
   */
  @visibility("read")
  moName?: string;

  /**
   * Gets or sets the folder path of the vm.
   */
  @visibility("read")
  folderPath?: string;

  /**
   * Gets or sets the instance uuid of the vm.
   */
  @visibility("read")
  instanceUuid?: string;

  /**
   * Gets or sets the SMBIOS UUID of the vm.
   */
  smbiosUuid?: string;

  /**
   * Firmware type
   */
  firmwareType?: FirmwareType;

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility("read")
  customResourceName?: string;
}

/**
 * Defines the virtualMachineInstanceUpdate.
 */
model VirtualMachineInstanceUpdate {
  /**
   * Resource properties.
   */
  properties?: VirtualMachineInstanceUpdateProperties;
}

/**
 * Describes the properties of a Virtual Machine.
 */
model VirtualMachineInstanceUpdateProperties {
  /**
   * Specifies the hardware settings for the virtual machine.
   */
  hardwareProfile?: HardwareProfile;

  /**
   * Specifies the storage settings for the virtual machine disks.
   */
  storageProfile?: StorageProfileUpdate;

  /**
   * Specifies the network interfaces of the virtual machine.
   */
  networkProfile?: NetworkProfileUpdate;
}

/**
 * Specifies the storage settings for the virtual machine disks.
 */
model StorageProfileUpdate {
  /**
   * Gets or sets the list of virtual disks associated with the virtual machine.
   */
  disks?: VirtualDiskUpdate[];
}

/**
 * Defines the virtual disk update.
 */
model VirtualDiskUpdate {
  /**
   * Gets or sets the name of the virtual disk.
   */
  name?: string;

  /**
   * Gets or sets the disk total size.
   */
  diskSizeGB?: int32;

  /**
   * Gets or sets the device key value.
   */
  deviceKey?: int32;

  /**
   * Gets or sets the disk mode.
   */
  diskMode?: DiskMode;

  /**
   * Gets or sets the controller id.
   */
  controllerKey?: int32;

  /**
   * Gets or sets the unit number of the disk on the controller.
   */
  unitNumber?: int32;

  /**
   * Gets or sets the device name.
   */
  deviceName?: string;

  /**
   * Gets or sets the disk backing type.
   */
  diskType?: DiskType;
}

/**
 * Specifies the network interfaces of the virtual machine.
 */
model NetworkProfileUpdate {
  /**
   * Gets or sets the list of network interfaces associated with the virtual machine.
   */
  networkInterfaces?: NetworkInterfaceUpdate[];
}

/**
 * Defines the network interface update.
 */
model NetworkInterfaceUpdate {
  /**
   * Gets or sets the name of the network interface.
   */
  name?: string;

  /**
   * Gets or sets the ARM Id of the network resource to connect the virtual machine.
   */
  networkId?: string;

  /**
   * NIC type
   */
  nicType?: NICType;

  /**
   * Gets or sets the power on boot.
   */
  powerOnBoot?: PowerOnBootOption;

  /**
   * Gets or sets the device key value.
   */
  deviceKey?: int32;
}

/**
 * Defines the stop action properties.
 */
model StopVirtualMachineOptions {
  /**
   * Gets or sets a value indicating whether to request non-graceful VM shutdown. True value for this flag indicates non-graceful shutdown whereas false indicates otherwise. Defaults to false.
   */
  skipShutdown?: boolean;
}

/**
 * Describes the properties of Hybrid Identity Metadata for a Virtual Machine.
 */
model VmInstanceHybridIdentityMetadataProperties {
  /**
   * The unique identifier for the resource.
   */
  resourceUid?: string;

  /**
   * Gets or sets the Public Key.
   */
  publicKey?: string;

  /**
   * Gets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Describes the properties of a Virtual Machine Guest Agent.
 */
model GuestAgentProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility("read")
  uuid?: string;

  /**
   * Username / Password Credentials to provision guest agent.
   */
  credentials?: GuestCredential;

  /**
   * The resource id of the private link scope this machine is assigned to, if any.
   */
  privateLinkScopeResourceId?: ResourceIdentifier;

  /**
   * HTTP Proxy configuration for the VM.
   */
  httpProxyConfig?: HttpProxyConfiguration;

  /**
   * Gets or sets the guest agent provisioning action.
   */
  provisioningAction?: ProvisioningAction;

  /**
   * Gets or sets the guest agent status.
   */
  @visibility("read")
  status?: string;

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility("read")
  customResourceName?: string;

  /**
   * The resource status information.
   */
  @visibility("read")
  statuses?: ResourceStatus[];

  /**
   * Gets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Username / Password Credentials to connect to guest.
 */
model GuestCredential {
  /**
   * Gets or sets username to connect with the guest.
   */
  username?: string;

  /**
   * Gets or sets the password to connect with the guest.
   */
  @visibility("create", "update")
  password?: string;
}

/**
 * HTTP Proxy configuration for the VM.
 */
model HttpProxyConfiguration {
  /**
   * Gets or sets httpsProxy url.
   */
  httpsProxy?: string;
}

/**
 * Condition defines an extension to status.
 */
model Condition {
  /**
   * Status of the condition.
   */
  @visibility("read")
  status?: string;

  /**
   * The reason for the condition's status.
   */
  @visibility("read")
  reason?: string;

  /**
   * A human readable message indicating details about the status.
   */
  @visibility("read")
  message?: string;

  /**
   * Severity with which to treat failures of this type of condition.
   */
  @visibility("read")
  severity?: string;
}

/**
 * The resource pool inventory item.
 */
model ResourcePoolInventoryItem extends InventoryItemProperties {
  /**
   * Parent resourcePool inventory resource details.
   */
  parent?: InventoryItemDetails;

  /**
   * They inventory type.
   */
  inventoryType: "ResourcePool";
}

/**
 * Describes the properties of an Inventory Item reference.
 */
model InventoryItemDetails {
  /**
   * Gets or sets the inventory Item ID for the resource.
   */
  inventoryItemId?: string;

  /**
   * Gets or sets the vCenter Managed Object name for the resource.
   */
  moName?: string;

  /**
   * The inventory type.
   */
  inventoryType?: InventoryType;
}

/**
 * The VM inventory item.
 */
model VirtualMachineInventoryItem extends InventoryItemProperties {
  /**
   * Gets or sets the type of the os.
   */
  osType?: OsType;

  /**
   * Gets or sets os name.
   */
  osName?: string;

  /**
   * Gets or sets the nic ip addresses.
   */
  ipAddresses?: string[];

  /**
   * Gets or sets the folder path of the vm.
   */
  folderPath?: string;

  /**
   * Host inventory resource details.
   */
  host?: InventoryItemDetails;

  /**
   * ResourcePool inventory resource details.
   */
  resourcePool?: InventoryItemDetails;

  /**
   * Cluster inventory resource details.
   */
  cluster?: InventoryItemDetails;

  /**
   * Gets or sets the instance uuid of the vm.
   */
  instanceUuid?: string;

  /**
   * Gets or sets the SMBIOS UUID of the vm.
   */
  smbiosUuid?: string;

  /**
   * Gets the power state of the virtual machine.
   */
  @visibility("read")
  powerState?: string;

  /**
   * Gets or sets the current running status of VMware Tools running in the guest operating system.
   */
  @visibility("read")
  toolsRunningStatus?: string;

  /**
   * Gets or sets the current version status of VMware Tools installed in the guest operating system.
   */
  @visibility("read")
  toolsVersionStatus?: string;

  /**
   * Gets or sets the current version of VMware Tools.
   */
  @visibility("read")
  toolsVersion?: string;

  /**
   * They inventory type.
   */
  inventoryType: "VirtualMachine";
}

/**
 * The VM Template inventory item.
 */
model VirtualMachineTemplateInventoryItem extends InventoryItemProperties {
  /**
   * Gets or sets memory size in MBs for the template.
   */
  memorySizeMB?: int32;

  /**
   * Gets or sets the number of vCPUs for the template.
   */
  numCPUs?: int32;

  /**
* Gets or sets the number of cores per socket for the template.
Defaults to 1 if unspecified.
*/
  numCoresPerSocket?: int32;

  /**
   * Gets or sets the type of the os.
   */
  osType?: OsType;

  /**
   * Gets or sets os name.
   */
  osName?: string;

  /**
   * Gets or sets the current version status of VMware Tools installed in the guest operating system.
   */
  @visibility("read")
  toolsVersionStatus?: string;

  /**
   * Gets or sets the current version of VMware Tools.
   */
  @visibility("read")
  toolsVersion?: string;

  /**
   * Gets or sets the folder path of the template.
   */
  folderPath?: string;

  /**
   * They inventory type.
   */
  inventoryType: "VirtualMachineTemplate";
}

/**
 * The Virtual network inventory item.
 */
model VirtualNetworkInventoryItem extends InventoryItemProperties {
  /**
   * They inventory type.
   */
  inventoryType: "VirtualNetwork";
}

/**
 * The cluster inventory item.
 */
model ClusterInventoryItem extends InventoryItemProperties {
  /**
   * They inventory type.
   */
  inventoryType: "Cluster";
}

/**
 * The datastore inventory item.
 */
model DatastoreInventoryItem extends InventoryItemProperties {
  /**
   * Gets or sets Maximum capacity of this datastore, in GBs.
   */
  capacityGB?: int64;

  /**
   * Gets or sets Available space of this datastore, in GBs.
   */
  freeSpaceGB?: int64;

  /**
   * They inventory type.
   */
  inventoryType: "Datastore";
}

/**
 * The host inventory item.
 */
model HostInventoryItem extends InventoryItemProperties {
  /**
   * Parent host inventory resource details.
   */
  parent?: InventoryItemDetails;

  /**
   * They inventory type.
   */
  inventoryType: "Host";
}
