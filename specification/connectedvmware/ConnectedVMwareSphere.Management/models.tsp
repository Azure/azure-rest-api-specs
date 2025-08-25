import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ConnectedVMwarevSphere;

/**
 * The current deployment state of resource.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Created: "Created",
}

/**
 * Defines the different types of VM guest operating systems.
 */
union OsType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Windows: "Windows",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Linux: "Linux",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Other: "Other",
}

/**
 * NIC type
 */
union NICType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmxnet3: "vmxnet3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmxnet2: "vmxnet2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vmxnet: "vmxnet",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  e1000: "e1000",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  e1000e: "e1000e",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  pcnet32: "pcnet32",
}

/**
 * Defines the options for power on boot.
 */
union PowerOnBootOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disabled: "disabled",
}

/**
 * IP address allocation method.
 */
union IPAddressAllocationMethod {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  unset: "unset",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dynamic: "dynamic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  static: "static",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  linklayer: "linklayer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  random: "random",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  other: "other",
}

/**
 * Defines the different types of disk modes.
 */
union DiskMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  persistent: "persistent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  independent_persistent: "independent_persistent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  independent_nonpersistent: "independent_nonpersistent",
}

/**
 * Defines the different types of disks.
 */
union DiskType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  flat: "flat",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  pmem: "pmem",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rawphysical: "rawphysical",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rawvirtual: "rawvirtual",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sparse: "sparse",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sesparse: "sesparse",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `unknown`: "unknown",
}

/**
 * Firmware type
 */
union FirmwareType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bios: "bios",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  efi: "efi",
}

/**
 * The inventory type.
 */
union InventoryType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ResourcePool: "ResourcePool",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VirtualMachine: "VirtualMachine",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VirtualMachineTemplate: "VirtualMachineTemplate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VirtualNetwork: "VirtualNetwork",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cluster: "Cluster",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Datastore: "Datastore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Host: "Host",
}

/**
 * Defines the different types of SCSI controllers.
 */
union SCSIControllerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  lsilogic: "lsilogic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  buslogic: "buslogic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  pvscsi: "pvscsi",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  lsilogicsas: "lsilogicsas",
}

/**
 * Defines the sharing mode for sharing the SCSI bus.
 */
union VirtualSCSISharing {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  noSharing: "noSharing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  physicalSharing: "physicalSharing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  virtualSharing: "virtualSharing",
}

/**
 * Defines the different types of operations for guest agent.
 */
union ProvisioningAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  install: "install",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  uninstall: "uninstall",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  repair: "repair",
}

/**
 * Describes the properties of a Resource Pool.
 */
model ResourcePoolProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  moName?: string;

  /**
   * Gets or sets CPUSharesLevel which specifies the CPU allocation level for this pool.
   * This property is used in relative allocation between resource consumers.
   */
  @visibility(Lifecycle.Read)
  cpuSharesLevel?: string;

  /**
   * Gets or sets CPUReservationMHz which specifies the CPU size in MHz that is guaranteed
   * to be available.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  cpuReservationMHz?: int64;

  /**
   * Gets or sets CPULimitMHz which specifies a CPU usage limit in MHz.
   * Utilization will not exceed this limit even if there are available resources.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  cpuLimitMHz?: int64;

  /**
   * Gets or sets CPUSharesLevel which specifies the memory allocation level for this pool.
   * This property is used in relative allocation between resource consumers.
   */
  @visibility(Lifecycle.Read)
  memSharesLevel?: string;

  /**
   * Gets or sets MemReservationMB which specifies the guaranteed available memory in
   * megabytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  memReservationMB?: int64;

  /**
   * Gets or sets MemLimitMB specifies a memory usage limit in megabytes.
   * Utilization will not exceed the specified limit even if there are available resources.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  memLimitMB?: int64;

  /**
   * Gets the used physical memory on the pool in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  memOverallUsageGB?: int64;

  /**
   * Gets the total amount of physical memory on the pool in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  memCapacityGB?: int64;

  /**
   * Gets the used CPU usage across all cores on the pool in MHz.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  cpuOverallUsageMHz?: int64;

  /**
   * Gets the max CPU usage across all cores on the pool in MHz.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  cpuCapacityMHz?: int64;

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility(Lifecycle.Read)
  customResourceName?: string;

  /**
   * Gets the datastore ARM ids.
   */
  @visibility(Lifecycle.Read)
  datastoreIds?: string[];

  /**
   * Gets the network ARM ids.
   */
  @visibility(Lifecycle.Read)
  networkIds?: string[];

  /**
   * The resource status information.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  statuses?: ResourceStatus[];

  /**
   * Gets the provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The resource status information.
 */
model ResourceStatus {
  /**
   * The type of the condition.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Status of the condition.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The reason for the condition's status.
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * A human readable message indicating details about the status.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Severity with which to treat failures of this type of condition.
   */
  @visibility(Lifecycle.Read)
  severity?: string;

  /**
   * The last update time for this condition.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * List of ResourcePools.
 */
model ResourcePoolsList is Azure.Core.Page<ResourcePool>;

/**
 * Describes the properties of a Cluster.
 */
model ClusterProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  moName?: string;

  /**
   * The resource status information.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  statuses?: ResourceStatus[];

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility(Lifecycle.Read)
  customResourceName?: string;

  /**
   * Gets the used physical memory on the cluster in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  usedMemoryGB?: int64;

  /**
   * Gets the total amount of physical memory on the cluster in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  totalMemoryGB?: int64;

  /**
   * Gets the used CPU usage across all cores on the cluster in MHz.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  usedCpuMHz?: int64;

  /**
   * Gets the max CPU usage across all cores on the cluster in MHz.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  totalCpuMHz?: int64;

  /**
   * Gets the datastore ARM ids.
   */
  @visibility(Lifecycle.Read)
  datastoreIds?: string[];

  /**
   * Gets the network ARM ids.
   */
  @visibility(Lifecycle.Read)
  networkIds?: string[];

  /**
   * Gets the provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * List of Clusters.
 */
model ClustersList is Azure.Core.Page<Cluster>;

/**
 * Describes the properties of a Host.
 */
model HostProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  moName?: string;

  /**
   * The resource status information.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  statuses?: ResourceStatus[];

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility(Lifecycle.Read)
  customResourceName?: string;

  /**
   * Gets the used physical memory on the host in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  overallMemoryUsageGB?: int64;

  /**
   * Gets the total amount of physical memory on the host in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  memorySizeGB?: int64;

  /**
   * Gets the used CPU usage across all cores in MHz.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  overallCpuUsageMHz?: int64;

  /**
   * Gets the max CPU usage across all cores in MHz.
   */
  @visibility(Lifecycle.Read)
  cpuMhz?: int64;

  /**
   * Gets the datastore ARM ids.
   */
  @visibility(Lifecycle.Read)
  datastoreIds?: string[];

  /**
   * Gets the network ARM ids.
   */
  @visibility(Lifecycle.Read)
  networkIds?: string[];

  /**
   * Gets the provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * List of Hosts.
 */
model HostsList is Azure.Core.Page<Host>;

/**
 * Describes the properties of a Datastore.
 */
model DatastoreProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  moName?: string;

  /**
   * The resource status information.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  statuses?: ResourceStatus[];

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility(Lifecycle.Read)
  customResourceName?: string;

  /**
   * Gets or sets Maximum capacity of this datastore in GBs.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  capacityGB?: int64;

  /**
   * Gets or sets Available space of this datastore in GBs.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  freeSpaceGB?: int64;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * List of Datastores.
 */
model DatastoresList is Azure.Core.Page<Datastore>;

/**
 * Describes the properties of a VCenter.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VCenterProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Gets or sets the instance UUID of the vCenter.
   */
  @visibility(Lifecycle.Read)
  instanceUuid?: string;

  /**
   * Gets or sets the connection status to the vCenter.
   */
  @visibility(Lifecycle.Read)
  connectionStatus?: string;

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility(Lifecycle.Read)
  customResourceName?: string;

  /**
   * Username / Password Credentials to connect to vcenter.
   */
  credentials?: VICredential;

  /**
   * The resource status information.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  statuses?: ResourceStatus[];

  /**
   * Gets the provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Username / Password Credentials to connect to vcenter.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VICredential {
  /**
   * Gets or sets username to connect with the vCenter.
   */
  username?: string;

  /**
   * Gets or sets the password to connect with the vCenter.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  password?: string;
}

/**
 * List of VCenters.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VCentersList is Azure.Core.Page<VCenter>;

/**
 * Describes the properties of a Virtual Machine Template.
 */
model VirtualMachineTemplateProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /**
   * Gets or sets the ARM Id of the vCenter resource in which this template resides.
   */
  vCenterId?: string;

  /**
   * Gets or sets the vCenter MoRef (Managed Object Reference) ID for the virtual machine
   * template.
   */
  moRefId?: string;

  /**
   * Gets or sets the inventory Item ID for the virtual machine template.
   */
  inventoryItemId?: string;

  /**
   * Gets or sets the vCenter Managed Object name for the virtual machine template.
   */
  @visibility(Lifecycle.Read)
  moName?: string;

  /**
   * Gets or sets memory size in MBs for the template.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  memorySizeMB?: int32;

  /**
   * Gets or sets the number of vCPUs for the template.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  numCPUs?: int32;

  /**
   * Gets or sets the number of cores per socket for the template.
   * Defaults to 1 if unspecified.
   */
  @visibility(Lifecycle.Read)
  numCoresPerSocket?: int32;

  /**
   * Gets or sets the type of the os.
   */
  @visibility(Lifecycle.Read)
  osType?: OsType;

  /**
   * Gets or sets os name.
   */
  @visibility(Lifecycle.Read)
  osName?: string;

  /**
   * Gets or sets the folder path of the template.
   */
  @visibility(Lifecycle.Read)
  folderPath?: string;

  /**
   * Gets or sets the network interfaces of the template.
   */
  @visibility(Lifecycle.Read)
  networkInterfaces?: NetworkInterface[];

  /**
   * Gets or sets the disks the template.
   */
  @visibility(Lifecycle.Read)
  disks?: VirtualDisk[];

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility(Lifecycle.Read)
  customResourceName?: string;

  /**
   * Gets or sets the current version status of VMware Tools installed in the guest operating system.
   */
  @visibility(Lifecycle.Read)
  toolsVersionStatus?: string;

  /**
   * Gets or sets the current version of VMware Tools.
   */
  @visibility(Lifecycle.Read)
  toolsVersion?: string;

  /**
   * Firmware type
   */
  @visibility(Lifecycle.Read)
  firmwareType?: FirmwareType;

  /**
   * The resource status information.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  statuses?: ResourceStatus[];

  /**
   * Gets the provisioning state.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  label?: string;

  /**
   * Gets or sets the nic ip addresses.
   */
  @visibility(Lifecycle.Read)
  ipAddresses?: string[];

  /**
   * Gets or sets the NIC MAC address.
   */
  @visibility(Lifecycle.Read)
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
   * that the nic is connected to.
   */
  @visibility(Lifecycle.Read)
  networkMoRefId?: string;

  /**
   * Gets or sets the name of the virtual network in vCenter that the nic is connected to.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  primaryWinsServer?: string;

  /**
   * Gets or sets the secondary server.
   */
  @visibility(Lifecycle.Read)
  secondaryWinsServer?: string;

  /**
   * Gets or sets the IP address information being reported for this NIC. This contains the same IPv4 information above plus IPV6 information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ipAddressInfo?: NicIPAddressSettings[];
}

/**
 * IP address information for a virtual network adapter reported by the fabric.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NicIPAddressSettings {
  /**
   * Gets the ip address allocation method.
   */
  @visibility(Lifecycle.Read)
  allocationMethod?: string;

  /**
   * Gets the ip address for the nic.
   */
  @visibility(Lifecycle.Read)
  ipAddress?: string;

  /**
   * Gets the mask.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  label?: string;

  /**
   * Gets or sets the disk object id.
   */
  @visibility(Lifecycle.Read)
  diskObjectId?: string;

  /**
   * Gets or sets the disk total size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * List of VirtualMachineTemplates.
 */
model VirtualMachineTemplatesList is Azure.Core.Page<VirtualMachineTemplate>;

/**
 * Describes the properties of a Virtual Network.
 */
model VirtualNetworkProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  moName?: string;

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility(Lifecycle.Read)
  customResourceName?: string;

  /**
   * The resource status information.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  statuses?: ResourceStatus[];

  /**
   * Gets the provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * List of VirtualNetworks.
 */
model VirtualNetworksList is Azure.Core.Page<VirtualNetwork>;

/**
 * Describes the properties of an Inventory Item.
 */
@discriminator("inventoryType")
model InventoryItemProperties {
  /**
   * They inventory type.
   */
  inventoryType: InventoryType;

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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

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

/**
 * List of InventoryItems.
 */
model InventoryItemsList is Azure.Core.Page<InventoryItem>;

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
  @visibility(Lifecycle.Read)
  powerState?: string;

  /**
   * The resource status information.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  statuses?: ResourceStatus[];

  /**
   * Gets the provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets a unique identifier for the vm resource.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Create, Lifecycle.Update)
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
  @visibility(Lifecycle.Read)
  osSku?: string;

  /**
   * Gets or sets the current running status of VMware Tools running in the guest operating system.
   */
  @visibility(Lifecycle.Read)
  toolsRunningStatus?: string;

  /**
   * Gets or sets the current version status of VMware Tools installed in the guest operating system.
   */
  @visibility(Lifecycle.Read)
  toolsVersionStatus?: string;

  /**
   * Gets or sets the current version of VMware Tools.
   */
  @visibility(Lifecycle.Read)
  toolsVersion?: string;

  /**
   * Windows Configuration.
   */
  windowsConfiguration?: WindowsConfiguration;
}

/**
 * Specifies the Windows Configuration settings for the virtual machine.
 */
model WindowsConfiguration {
  /**
   * Sets full name of the owner of the vm.
   */
  fullName?: string;

  /**
   * Sets org name to which the owner of the vm belongs.
   */
  orgName?: string;

  /**
   * Sets domain name that vm should join.
   */
  domainName?: string;

  /**
   * Sets domain username.
   */
  domainUsername?: string;

  /**
   * Sets domain user password.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  domainUserPassword?: string;

  /**
   * Sets work group name that vm should join.
   */
  workGroupName?: string;

  /**
   * Sets product id of the vm.
   */
  productId?: string;

  /**
   * Sets a value indicating whether auto logon is enabled.
   */
  autoLogon?: boolean;

  /**
   * Sets auto logon count.
   */
  autoLogonCount?: int32;

  /**
   * Specifies the time zone of the virtual machine. e.g. "Pacific Standard Time". Time zone name correspond to time zones listed at Microsoft Time Zone name values(https://learn.microsoft.com/en-us/previous-versions/windows/embedded/ms912391(v=winembedded.11)).
   */
  timeZone?: string;

  /**
   * Sets first logon commands
   */
  firstLogonCommands?: string[];
}

/**
 * Specifies the hardware settings for the virtual machine.
 */
model HardwareProfile {
  /**
   * Gets or sets memory size in MBs for the vm.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  memorySizeMB?: int32;

  /**
   * Gets or sets the number of vCPUs for the vm.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  numCPUs?: int32;

  /**
   * Gets or sets the number of cores per socket for the vm. Defaults to 1 if unspecified.
   */
  numCoresPerSocket?: int32;

  /**
   * Gets or sets a value indicating whether virtual processors can be added while this virtual machine is running.
   */
  @visibility(Lifecycle.Read)
  cpuHotAddEnabled?: boolean;

  /**
   * Gets or sets a value indicating whether virtual processors can be removed while this virtual machine is running.
   */
  @visibility(Lifecycle.Read)
  cpuHotRemoveEnabled?: boolean;

  /**
   * Gets or sets a value indicating whether memory can be added while this virtual machine is running.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  scsiControllers?: VirtualSCSIController[];
}

/**
 * This data object type contains the properties of a SCSI controller device attached to a virtual machine that is reported by the controller.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VirtualSCSIController {
  /**
   * Gets or sets the controller type.
   */
  type?: SCSIControllerType;

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
  sharing?: VirtualSCSISharing;
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
  @visibility(Lifecycle.Read)
  moRefId?: string;

  /**
   * Gets or sets the inventory Item ID for the virtual machine.
   */
  inventoryItemId?: string;

  /**
   * Gets or sets the vCenter Managed Object name for the virtual machine.
   */
  @visibility(Lifecycle.Read)
  moName?: string;

  /**
   * Gets or sets the folder path of the vm.
   */
  @visibility(Lifecycle.Read)
  folderPath?: string;

  /**
   * Gets or sets the instance uuid of the vm.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * List of VirtualMachineInstances.
 */
model VirtualMachineInstancesList is Azure.Core.Page<VirtualMachineInstance>;

/**
 * Defines the stop action properties.
 */
model StopVirtualMachineOptions {
  /**
   * Gets or sets a value indicating whether to request non-graceful VM shutdown. True value for this flag indicates non-graceful shutdown whereas false indicates otherwise. Defaults to false.
   */
  skipShutdown?: boolean = false;
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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * List of HybridIdentityMetadata.
 */
model VmInstanceHybridIdentityMetadataList
  is Azure.Core.Page<VmInstanceHybridIdentityMetadata>;

/**
 * Describes the properties of a Virtual Machine Guest Agent.
 */
model GuestAgentProperties {
  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /**
   * Username / Password Credentials to provision guest agent.
   */
  credentials?: GuestCredential;

  /**
   * The resource id of the private link scope this machine is assigned to, if any.
   */
  privateLinkScopeResourceId?: Azure.Core.armResourceIdentifier;

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
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Gets the name of the corresponding resource in Kubernetes.
   */
  @visibility(Lifecycle.Read)
  customResourceName?: string;

  /**
   * The resource status information.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  statuses?: ResourceStatus[];

  /**
   * Gets the provisioning state.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Create, Lifecycle.Update)
  password?: string;

  /**
   * Private key used to authenticate to a virtual machine through ssh.
   */
  privateKey?: string;
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
 * List of GuestAgent.
 */
model GuestAgentList is Azure.Core.Page<GuestAgent>;

/**
 * Virtual disk model
 */
model VirtualDiskInventory {
  /**
   * Gets or sets the name of the virtual disk.
   */
  diskName?: string;

  /**
   * Gets or sets the label of the virtual disk in vCenter.
   */
  @visibility(Lifecycle.Read)
  label?: string;

  /**
   * Gets or sets the disk total size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  diskSizeGB?: int32;

  /**
   * Gets or sets the device key value.
   */
  @visibility(Lifecycle.Read)
  deviceKey?: int32;

  /**
   * Gets or sets the disk mode.
   */
  @visibility(Lifecycle.Read)
  diskMode?: DiskMode;

  /**
   * Gets or sets the controller id.
   */
  @visibility(Lifecycle.Read)
  controllerKey?: int32;

  /**
   * Gets or sets the unit number of the disk on the controller.
   */
  @visibility(Lifecycle.Read)
  unitNumber?: int32;

  /**
   * Gets or sets the device name.
   */
  @visibility(Lifecycle.Read)
  deviceName?: string;

  /**
   * Gets or sets the disk file name.
   */
  @visibility(Lifecycle.Read)
  fileName?: string;

  /**
   * Gets or sets the disk backing type.
   */
  @visibility(Lifecycle.Read)
  diskType?: DiskType;

  /**
   * Gets or sets the eagerly scrub property of disk.
   */
  @visibility(Lifecycle.Read)
  eagerlyScrub?: boolean;

  /**
   * Gets or sets the thin provisioning property of disk.
   */
  @visibility(Lifecycle.Read)
  thinProvisioned?: boolean;

  /**
   * Gets or sets the controller type.
   */
  @visibility(Lifecycle.Read)
  controllerType?: string;

  /**
   * Gets or sets a unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  uuid?: string;
}

/**
 * Condition defines an extension to status.
 */
model Condition {
  /**
   * Status of the condition.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The reason for the condition's status.
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * A human readable message indicating details about the status.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Severity with which to treat failures of this type of condition.
   */
  @visibility(Lifecycle.Read)
  severity?: string;
}

/**
 * Specifies the network interfaces of the virtual machine.
 */
model NetworkProfileInventory {
  /**
   * Gets or sets the list of network interfaces associated with the virtual machine.
   */
  @OpenAPI.extension("x-ms-identifiers", #["networkMoRefId"])
  networkInterfaces?: NetworkInterfaceInventory[];
}

/**
 * Inventory Network Interface model
 */
model NetworkInterfaceInventory {
  /**
   * Gets or sets the label of the virtual network in vCenter that the nic is connected to.
   */
  @visibility(Lifecycle.Read)
  label?: string;

  /**
   * Gets or sets the nic ip addresses.
   */
  @visibility(Lifecycle.Read)
  ipAddresses?: string[];

  /**
   * Gets or sets the NIC MAC address.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * NIC type
   */
  @visibility(Lifecycle.Read)
  nicType?: NICType;

  /**
   * Gets or sets the vCenter MoRef (Managed Object Reference) ID of the virtual network
   * that the nic is connected to.
   */
  @visibility(Lifecycle.Read)
  networkMoRefId?: string;

  /**
   * Gets or sets the name of the virtual network in vCenter that the nic is connected to.
   */
  @visibility(Lifecycle.Read)
  networkMoName?: string;

  /**
   * Gets or sets the device key value.
   */
  @visibility(Lifecycle.Read)
  deviceKey?: int32;
}

/**
 * Specifies the storage settings for the virtual machine disks.
 */
model StorageProfileInventory {
  /**
   * Gets or sets the list of virtual disks associated with the virtual machine.
   */
  @OpenAPI.extension("x-ms-identifiers", #["uuid"])
  disks?: VirtualDiskInventory[];
}

/**
 * The resource pool inventory item.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  powerState?: string;

  /**
   * Gets or sets the current running status of VMware Tools running in the guest operating system.
   */
  @visibility(Lifecycle.Read)
  toolsRunningStatus?: string;

  /**
   * Gets or sets the current version status of VMware Tools installed in the guest operating system.
   */
  @visibility(Lifecycle.Read)
  toolsVersionStatus?: string;

  /**
   * Gets or sets the current version of VMware Tools.
   */
  @visibility(Lifecycle.Read)
  toolsVersion?: string;

  /**
   * Firmware type
   */
  @visibility(Lifecycle.Read)
  firmwareType?: FirmwareType;

  /**
   * Gets a value indicating whether change tracking is supported.
   */
  @visibility(Lifecycle.Read)
  changeTrackingSupported?: boolean;

  /**
   * Gets a value indicating whether change tracking is enabled.
   */
  @visibility(Lifecycle.Read)
  changeTrackingEnabled?: boolean;

  /**
   * Gets a value indicating the maximum possible number of snapshots.
   */
  @visibility(Lifecycle.Read)
  maxSnapshots?: int32;

  /**
   * Gets a value indicating the number of snapshots on the vm.
   */
  @visibility(Lifecycle.Read)
  numberOfSnapshots?: int32;

  /**
   * Gets or sets the disk Enabled UUID of the vm.
   */
  @visibility(Lifecycle.Read)
  diskEnabledUuid?: string;

  /**
   * Gets the computer name.
   */
  @visibility(Lifecycle.Read)
  computerName?: string;

  /**
   * Gets or sets memory size in MBs for the vm.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  memorySizeMB?: int32;

  /**
   * Gets or sets the number of vCPU for the vm.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  numCPUs?: int32;

  /**
   * Storage properties.
   */
  storageProfile?: StorageProfileInventory;

  /**
   * Network properties.
   */
  networkProfile?: NetworkProfileInventory;

  /**
   * They inventory type.
   */
  inventoryType: "VirtualMachine";
}

/**
 * The VM Template inventory item.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VirtualMachineTemplateInventoryItem extends InventoryItemProperties {
  /**
   * Gets or sets memory size in MBs for the template.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  memorySizeMB?: int32;

  /**
   * Gets or sets the number of vCPUs for the template.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  numCPUs?: int32;

  /**
   * Gets or sets the number of cores per socket for the template.
   * Defaults to 1 if unspecified.
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
  @visibility(Lifecycle.Read)
  toolsVersionStatus?: string;

  /**
   * Gets or sets the current version of VMware Tools.
   */
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VirtualNetworkInventoryItem extends InventoryItemProperties {
  /**
   * They inventory type.
   */
  inventoryType: "VirtualNetwork";
}

/**
 * The cluster inventory item.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ClusterInventoryItem extends InventoryItemProperties {
  /**
   * They inventory type.
   */
  inventoryType: "Cluster";
}

/**
 * The datastore inventory item.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatastoreInventoryItem extends InventoryItemProperties {
  /**
   * Gets or sets Maximum capacity of this datastore, in GBs.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  capacityGB?: int64;

  /**
   * Gets or sets Available space of this datastore, in GBs.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  freeSpaceGB?: int64;

  /**
   * They inventory type.
   */
  inventoryType: "Datastore";
}

/**
 * The host inventory item.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HostInventoryItem extends InventoryItemProperties {
  /**
   * Parent host inventory resource details.
   */
  parent?: InventoryItemDetails;

  /**
   * Gets or sets the number of cores per socket on the host.
   */
  @visibility(Lifecycle.Read)
  numCoresPerSocket?: int32;

  /**
   * Gets or sets the number of sockets on the host.
   */
  @visibility(Lifecycle.Read)
  numSockets?: int32;

  /**
   * Gets or sets the version of the host.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Gets or sets the cpu model of the host.
   */
  @visibility(Lifecycle.Read)
  cpuModel?: string;

  /**
   * Gets the total amount of physical memory on the host in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  memorySizeGB?: int64;

  /**
   * Gets or sets the power state of the host.
   */
  @visibility(Lifecycle.Read)
  powerState?: string;

  /**
   * They inventory type.
   */
  inventoryType: "Host";
}

/**
 * A list of REST API operations supported by an Azure Resource Provider. It contains an URL link to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model operationsList is Azure.Core.Page<operation>;

/**
 * Details of a REST API operation, returned from the Resource Provider Operations API
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model operation {
  /** 
    The name of the operation, as per Resource-Based Access Control (RBAC). Examples: "Microsoft.Compute/virtualMachines/write", "Microsoft.Compute/virtualMachines/capture/action"
     */
  name?: string;

  /** 
    Whether the operation applies to data-plane. This is "true" for data-plane operations and "false" for Azure Resource Manager/control-plane operations.
     */
  isDataAction?: boolean;

  /** Localized display information for this particular operation. */
  display?: OperationDisplay;
}

/**
 * Localized display information for and operation.
 */
model OperationDisplay {
  /** Provider name */
  provider?: string;

  /** Resource name */
  resource?: string;

  /** Operation name */
  operation?: string;

  /** Description of the operation */
  description?: string;
}

@@secret(GuestCredential.password);
@@secret(GuestCredential.privateKey);
@@secret(OsProfileForVMInstance.adminPassword);
