import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.AzureLargeInstance;

interface Operations extends Azure.ResourceManager.Operations {}

enum AzureLargeInstanceHardwareTypeNamesEnum {
  Cisco_UCS,
  HPE,
  SDFLEX,
}

enum AzureLargeInstanceSizeNamesEnum {
  S72m,
  S144m,
  S72,
  S144,
  S192,
  S192m,
  S192xm,
  S96,
  S112,
  S224,
  S224m,
  S224om,
  S224oo,
  S224oom,
  S224ooo,
  S224se,
  S384,
  S384m,
  S384xm,
  S384xxm,
  S448,
  S448m,
  S448om,
  S448oo,
  S448oom,
  S448ooo,
  S448se,
  S576m,
  S576xm,
  S672,
  S672m,
  S672om,
  S672oo,
  S672oom,
  S672ooo,
  S768,
  S768m,
  S768xm,
  S896,
  S896m,
  S896om,
  S896oo,
  S896oom,
  S896ooo,
  S960m,
}

enum AzureLargeInstancePowerStateEnum {
  starting,
  started,
  stopping,
  stopped,
  restarting,
  `unknown`,
}

enum AzureLargeInstanceProvisioningStatesEnum {
  Accepted,
  Creating,
  Updating,
  Failed,
  Succeeded,
  Deleting,
  Migrating,
  Canceled,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum AzureLargeInstanceForcePowerState {
  active,
  inactive,
}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum ProvisioningState {
  Accepted,
  Creating,
  Updating,
  Failed,
  Succeeded,
  Deleting,
  Canceled,
  Migrating,
}

@doc("Describes the properties of an Azure Large Instance.")
model AzureLargeInstanceProperties {
  @doc("Specifies the hardware settings for the Azure Large Instance.")
  hardwareProfile?: HardwareProfile;

  @doc("Specifies the storage settings for the Azure Large Instance disks.")
  storageProfile?: StorageProfile;

  @doc("Specifies the operating system settings for the Azure Large Instance.")
  osProfile?: OSProfile;

  @doc("Specifies the network settings for the Azure Large Instance.")
  networkProfile?: NetworkProfile;

  @doc("Specifies the Azure Large Instance unique ID.")
  @visibility("read")
  azureLargeInstanceId?: string;

  @doc("Resource power state")
  @visibility("read")
  powerState?: AzureLargeInstancePowerStateEnum;

  @doc("Resource proximity placement group")
  @visibility("read")
  proximityPlacementGroup?: string;

  @doc("Hardware revision of an Azure Large Instance")
  @visibility("read")
  hwRevision?: string;

  @doc("""
ARM ID of another AzureLargeInstance that will share a network with this
AzureLargeInstance
""")
  partnerNodeId?: string;

  @doc("State of provisioning of the AzureLargeInstance")
  @visibility("read")
  provisioningState?: AzureLargeInstanceProvisioningStatesEnum;
}

@doc("Specifies the hardware settings for the Azure Large Instance.")
model HardwareProfile {
  @doc("Name of the hardware type (vendor and/or their product name)")
  @visibility("read")
  hardwareType?: AzureLargeInstanceHardwareTypeNamesEnum;

  @doc("Specifies the Azure Large Instance SKU.")
  @visibility("read")
  azureLargeInstanceSize?: AzureLargeInstanceSizeNamesEnum;
}

@doc("Specifies the storage settings for the Azure Large Instance disks.")
model StorageProfile {
  @doc("IP Address to connect to storage.")
  @visibility("read")
  nfsIpAddress?: string;

  @doc("""
Specifies information about the operating system disk used by Azure Large
Instance.
""")
  osDisks?: Disk[];
}

@doc("Specifies the disk information fo the Azure Large Instance")
model Disk {
  @doc("The disk name.")
  name?: string;

  @doc("Specifies the size of an empty data disk in gigabytes.")
  diskSizeGB?: int32;

  @doc("""
Specifies the logical unit number of the data disk. This value is used to
identify data disks within the VM and therefore must be unique for each data
disk attached to a VM.
""")
  @visibility("read")
  lun?: int32;
}

@doc("Specifies the operating system settings for the Azure Large Instance.")
model OSProfile {
  @doc("Specifies the host OS name of the Azure Large Instance.")
  computerName?: string;

  @doc("This property allows you to specify the type of the OS.")
  @visibility("read")
  osType?: string;

  @doc("Specifies version of operating system.")
  @visibility("read")
  version?: string;

  @doc("Specifies the SSH public key used to access the operating system.")
  sshPublicKey?: string;
}

@doc("Specifies the network settings for the Azure Large Instance disks.")
model NetworkProfile {
  @doc("Specifies the network interfaces for the Azure Large Instance.")
  networkInterfaces?: IpAddress[];

  @doc("Specifies the circuit id for connecting to express route.")
  @visibility("read")
  circuitId?: string;
}

@doc("Specifies the IP address of the network interface.")
model IpAddress {
  @doc("Specifies the IP address of the network interface.")
  ipAddress?: string;
}

@doc("""
The active state empowers the server with the ability to forcefully terminate
and halt any existing processes that may be running on the server
""")
model ForceState {
  @doc("Whether to force restart by shutting all processes.")
  forceState?: AzureLargeInstanceForcePowerState;
}

@doc("Tags field of the AzureLargeInstance instance.")
model Tags {
  @doc("Tags field of the AzureLargeInstance instance.")
  tags?: Record<string>;
}

@doc("Describes the properties of an AzureLargeStorageInstance.")
model AzureLargeStorageInstanceProperties {
  @doc("Specifies the AzureLargeStorageInstance unique ID.")
  azureLargeStorageInstanceUniqueIdentifier?: string;

  @doc("Specifies the storage properties for the AzureLargeStorage instance.")
  storageProperties?: StorageProperties;
}

@doc("described the storage properties of the azure large storage instance")
model StorageProperties {
  @doc("State of provisioning of the AzureLargeStorageInstance")
  provisioningState?: ProvisioningState;

  @doc("the offering type for which the resource is getting provisioned")
  offeringType?: string;

  @doc("the storage protocol for which the resource is getting provisioned")
  storageType?: string;

  @doc("the kind of storage instance")
  generation?: string;

  @doc("the hardware type of the storage instance")
  hardwareType?: string;

  @doc("the workload for which the resource is getting provisioned")
  workloadType?: string;

  @doc("the billing related information for the resource")
  storageBillingProperties?: StorageBillingProperties;
}

@doc("Describes the billing related details of the AzureLargeStorageInstance.")
model StorageBillingProperties {
  @doc("the billing mode for the storage instance")
  billingMode?: string;

  @doc("the SKU type that is provisioned")
  sku?: string;
}
