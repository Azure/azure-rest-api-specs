import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

namespace Microsoft.AzureLargeInstance;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Enum of the hardware options (vendor and/or their product name) for an Azure Large Instance")
union AzureLargeInstanceHardwareTypeNamesEnum {
  string,

  @doc("Hardware type of UCS from vendor Cisco")
  "Cisco_UCS",

  @doc("Hardware type of HPE from vendor Hewlett Packard Enterprise")
  "HPE",

  @doc("Hardware type of SDFLEX")
  "SDFLEX",
}

@doc("Enum of available model types (each of which have their own storage / memory sizes) for an Azure Large Instance type. See https://learn.microsoft.com/azure/sap/large-instances/hana-available-skus")
union AzureLargeInstanceSizeNamesEnum {
  string,

  @doc("Type I class SKU that can't be purchased anymore")
  "S72m",

  @doc("Type I class SKU that can't be purchased anymore")
  "S144m",

  @doc("Type I class SKU that can't be purchased anymore")
  "S72",

  @doc("Type I class SKU that can't be purchased anymore")
  "S144",

  @doc("Type I class SKU that can't be purchased anymore")
  "S192",

  @doc("Type I class SKU that can't be purchased anymore")
  "S192m",

  @doc("Type I class SKU that can't be purchased anymore")
  "S192xm",

  @doc("2 sockets, 96 CPU threads, 48 CPU cores, 768 GB total memory, 768 GB DRAM, 3.0 TB storage, Cisco_UCS hardware type")
  "S96",

  @doc("No longer offered or used.")
  "S112",

  @doc("4 sockets, 224 CPU threads, 112 CPU cores, 3 TB total memory, 3 TB DRAM, 6.3 TB storage, Cisco_UCS hardware type")
  "S224",

  @doc("4 sockets, 224 CPU threads, 112 CPU cores, 6 TB total memory, 6 TB DRAM, 10.5 TB storage, Cisco_UCS hardware type")
  "S224m",

  @doc("4 sockets, 224 CPU threads, 112 CPU cores, 6 TB total memory, 3 TB DRAM, 3 TB memory optane, 10.5 TB storage, Cisco_UCS hardware type")
  "S224om",

  @doc("4 sockets, 224 CPU threads, 112 CPU cores, 4.5 TB total memory, 1.5 TB DRAM, 3 TB memory optane, 8.4 TB storage, Cisco_UCS hardware type")
  "S224oo",

  @doc("4 sockets, 224 CPU threads, 112 CPU cores, 9 TB total memory, 3 TB DRAM, 6 TB memory optane, 14.8 TB storage, Cisco_UCS hardware type")
  "S224oom",

  @doc("4 sockets, 224 CPU threads, 112 CPU cores, 7.5TB total memory, 1.5 TB DRAM, 6 TB memory optane, 12.7 TB storage, Cisco_UCS hardware type")
  "S224ooo",

  @doc("4 sockets, 448 CPU threads, 6 TB total memory, SDFLEX hardware type")
  "S224se",

  @doc("8 sockets, 384 CPU threads, 192 CPU cores, 4 TB total memory, 4 TB DRAM, 16 TB storage, HPEMc990x hardware type")
  "S384",

  @doc("8 sockets, 384 CPU threads, 192 CPU cores, 6 TB total memory, 6 TB DRAM, 18 TB storage, HPEMc990x hardware type")
  "S384m",

  @doc("8 sockets, 384 CPU threads, 192 CPU cores, 8 TB total memory, 8 TB DRAM, 22 TB storage, HPEMc990x hardware type")
  "S384xm",

  @doc("8 sockets, 384 CPU threads, 12 TB total memory, HPEMc990x hardware type")
  "S384xxm",

  @doc("8 sockets, 448 CPU threads, 224 CPU cores, 6 TB total memory, 6 TB DRAM, 10.5 TB storage, SDFLEX hardware type")
  "S448",

  @doc("8 sockets, 448 CPU threads, 224 CPU cores, 12 TB total memory, 12 TB DRAM, 18.9 TB storage, SDFLEX hardware type")
  "S448m",

  @doc("8 sockets, 448 CPU threads, 224 CPU cores, 12 TB total memory, 6 TB DRAM, 6 TB memory optane, 18.9 TB storage, SDFLEX hardware type")
  "S448om",

  @doc("8 sockets, 448 CPU threads, 224 CPU cores, 9 TB total memory, 3 TB DRAM, 6 TB memory optane, 14.8 TB storage, SDFLEX hardware type")
  "S448oo",

  @doc("8 sockets, 448 CPU threads, 224 CPU cores, 18 TB total memory, 6 TB DRAM, 12 memory optane, 27.4 TB storage, SDFLEX hardware type")
  "S448oom",

  @doc("8 sockets, 448 CPU threads, 224 CPU cores, 15 TB total memory, 3 TB DRAM, 12 memory optane, 23.2 TB storage, SDFLEX hardware type")
  "S448ooo",

  @doc("8 sockets, 448 CPU threads, 12 TB total memory, SDFLEX hardware type")
  "S448se",

  @doc("12 sockets, 576 CPU threads, 288 CPU cores, 12 TB total memory, 12 TB DRAM, 28 TB storage, HPEMc990x hardware type")
  "S576m",

  @doc("12 sockets, 576 CPU threads, 288 CPU cores, 18 TB total memory, HPEMc990x hardware type")
  "S576xm",

  @doc("12 sockets, 672 CPU threads, 336 CPU cores, 9 TB total memory, 9 TB DRAM, 14.7 TB storage, SDFLEX hardware type")
  "S672",

  @doc("12 sockets, 672 CPU threads, 336 CPU cores, 18 TB total memory, 18 TB DRAM, 27.4 TB storage, SDFLEX hardware type")
  "S672m",

  @doc("12 sockets, 672 CPU threads, 336 CPU cores, 18 TB total memory, 9 TB DRAM, 9 TB memory optane, 27.4 TB storage, SDFLEX hardware type")
  "S672om",

  @doc("12 sockets, 672 CPU threads, 336 CPU cores, 13.5 TB total memory, 4.5 TB DRAM, 9 TB memory optane, 21.1 TB storage, SDFLEX hardware type")
  "S672oo",

  @doc("12 sockets, 672 CPU threads, 336 CPU cores, 27 TB total memory, 9 TB DRAM, 18 TB memory optane, 40 TB storage, SDFLEX hardware type")
  "S672oom",

  @doc("12 sockets, 672 CPU threads, 336 CPU cores, 22.5 TB total memory, 4.5 TB DRAM, 18 TB memory optane, 33.7 TB storage, SDFLEX hardware type")
  "S672ooo",

  @doc("No longer offered or used.")
  "S768",

  @doc("16 sockets, 768 CPU threads, 384 CPU cores, 16 TB total memory, 16 TB DRAM, 36 TB storage, HPEMc990x hardware type")
  "S768m",

  @doc("16 sockets, 768 CPU threads, 384 CPU cores, 24 TB total memory, 24 TB DRAM, 56 TB storage, HPEMc990x hardware type")
  "S768xm",

  @doc("16 sockets, 896 CPU threads, 448 CPU cores, 12 TB total memory, 12 TB DRAM, 18.9 TB storage, SDFLEX hardware type")
  "S896",

  @doc("16 sockets, 896 CPU threads, 448 CPU cores, 24 TB	total memory, 24 TB DRAM, 35.8 TB storage, SDFLEX hardware type")
  "S896m",

  @doc("16 sockets, 896 CPU threads, 448 CPU cores, 24 TB	total memory, 12 TB DRAM, 12 TB memory optane, 35.8 TB storage, SDFLEX hardware type")
  "S896om",

  @doc("16 sockets, 896 CPU threads, 448 CPU cores, 18 TB  total memory, 6 TB DRAM, 12 TB memory optane, 27.4 TB storage, SDFLEX hardware type")
  "S896oo",

  @doc("16 sockets, 896 CPU threads, 448 CPU cores, 36 TB total memory, 12 TB DRAM, 24 TB memory optane, 52.7 TB storage, SDFLEX hardware type")
  "S896oom",

  @doc("16 sockets, 896 CPU threads, 448 CPU cores, 30 TB total memory, 6 TB DRAM, 24 TB memory optane, 44.3 TB storage, SDFLEX hardware type")
  "S896ooo",

  @doc("20 sockets, 960 CPU threads, 480 CPU cores, 20 TB total memory, 20 TB DRAM, 46 TB storage, HPEMc990x hardware type")
  "S960m",
}

@doc("Power states that an Azure Large Instance can be in")
union AzureLargeInstancePowerStateEnum {
  string,

  @doc("Starting means that the Azure Large Instance resource is turning on.")
  "starting",

  @doc("Started means that the Azure Large Instance resource has been powered on.")
  "started",

  @doc("Stopping means that the Azure Large Instance resource is shutting down.")
  "stopping",

  @doc("Stopped means that the Azure Large Instance resource has shut down.")
  "stopped",

  @doc("Restarting means that the Azure Large Instance resource is restarting.")
  "restarting",

  @doc("Unknown means that the state of the Azure Large Instance is unknown.")
  "unknown",
}

@doc("Provisioning states that an Azure Large Instance can be in")
union AzureLargeInstanceProvisioningStatesEnum {
  string,

  @doc("Accepted means Azure Large Instance resource provisioning has been accepted.")
  Accepted: "Accepted",

  @doc("Creating means Azure Large Instance resource is being created.")
  Creating: "Creating",

  @doc("Updating means an existing Azure Large Instance resource is being updated")
  Updating: "Updating",

  @doc("Failed means Azure Large Instance resource is in failed state")
  Failed: "Failed",

  @doc("Succeeded means Azure Large Instance resource creation succeeded during last create/update")
  Succeeded: "Succeeded",

  @doc("Deleting means Azure Large Instance resource is in the process of being deleted")
  Deleting: "Deleting",

  @doc("Migrating means Azure Large Instance resource is being migrated from one subscription or resource group to another")
  Migrating: "Migrating",

  @doc("Cancelled Azure Large Instance resource operation has been cancelled")
  Canceled: "Canceled",
}

@doc("The type of identity that created the resource: User, Application, ManagedIdentity")
union CreatedByType {
  string,

  @doc("An AAD user. The createdByType/lastModifiedBy property will be a user principal name (email address).")
  "User",

  @doc("An AAD application. The createdByType/lastModifiedBy property will be the Application Id.")
  "Application",

  @doc("A Managed Identity. The createdByType/lastModifiedBy property will be the ManagedIdentity resource Id")
  "ManagedIdentity",

  @doc("A key")
  "Key",
}

@doc("Enum of two possible values to determine if the ALI instance restart operation should forcefully terminate and halt any existing processes that may be running on the server or not.")
union AzureLargeInstanceForcePowerState {
  string,

  @doc("Active means that the restart operation will terminate and halt existing processes that may be running on the server")
  "active",

  @doc("Inactive means that the restart operation will not terminate and halt existing processes that may be running on the server")
  "inactive",
}

@doc("An enum of possible operation states for an AzureLargeStorageInstances")
union ProvisioningState {
  string,

  @doc("Accepted means ARM resource has been accepted.")
  "Accepted",

  @doc("Creating means ARM resource is being created.")
  "Creating",

  @doc("Updating means an existing ARM resource is being updated")
  "Updating",

  @doc("Failed means resource is in failed state")
  "Failed",

  @doc("Succeeded means resource creation succeeded during last create/update")
  "Succeeded",

  @doc("Deleting means resource is in the process of being deleted")
  "Deleting",

  @doc("Cancelled means resource operation has been cancelled")
  "Canceled",

  @doc("Migrating means resource is being migrated from one subscription or resource group to another")
  "Migrating",
}

@doc("Describes the properties of an Azure Large Instance.")
model AzureLargeInstanceProperties {
  @doc("Specifies the hardware settings for the Azure Large Instance.")
  hardwareProfile?: HardwareProfile;

  @doc("Specifies the storage settings for the Azure Large Instance disks.")
  storageProfile?: StorageProfile;

  @doc("Specifies the operating system settings for the Azure Large Instance.")
  osProfile?: OsProfile;

  @doc("Specifies the network settings for the Azure Large Instance.")
  networkProfile?: NetworkProfile;

  @removed(Versions.v2024_08_01_preview)
  @renamedFrom(Versions.v2024_08_01_preview, "azureLargeInstanceId")
  @doc("Specifies the Azure Large Instance unique ID.")
  @visibility(Lifecycle.Read)
  azureLargeInstanceIdOld?: string;

  @added(Versions.v2024_08_01_preview)
  @doc("Specifies the Azure Large Instance unique ID.")
  azureLargeInstanceId?: string;

  @removed(Versions.v2024_08_01_preview)
  @renamedFrom(Versions.v2024_08_01_preview, "powerState")
  @doc("Resource power state")
  @visibility(Lifecycle.Read)
  powerStateOld?: AzureLargeInstancePowerStateEnum;

  @added(Versions.v2024_08_01_preview)
  @doc("Resource power state")
  powerState?: AzureLargeInstancePowerStateEnum;

  @removed(Versions.v2024_08_01_preview)
  @renamedFrom(Versions.v2024_08_01_preview, "proximityPlacementGroup")
  @doc("Resource proximity placement group")
  @visibility(Lifecycle.Read)
  proximityPlacementGroupOld?: string;

  @added(Versions.v2024_08_01_preview)
  @doc("Resource proximity placement group")
  proximityPlacementGroup?: string;

  @removed(Versions.v2024_08_01_preview)
  @renamedFrom(Versions.v2024_08_01_preview, "hwRevision")
  @doc("Hardware revision of an Azure Large Instance")
  @visibility(Lifecycle.Read)
  hwRevisionOld?: string;

  @added(Versions.v2024_08_01_preview)
  @doc("Hardware revision of an Azure Large Instance")
  hwRevision?: string;

  @doc("""
    ARM ID of another AzureLargeInstance that will share a network with this
    AzureLargeInstance
    """)
  @removed(Versions.v2024_04_10)
  partnerNodeId?: string;

  @doc("State of provisioning of the AzureLargeInstance")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureLargeInstanceProvisioningStatesEnum;
}

@doc("Specifies the hardware settings for the Azure Large Instance.")
model HardwareProfile {
  @removed(Versions.v2024_08_01_preview)
  @renamedFrom(Versions.v2024_08_01_preview, "hardwareType")
  @doc("Name of the hardware type (vendor and/or their product name)")
  @visibility(Lifecycle.Read)
  hardwareTypeOld?: AzureLargeInstanceHardwareTypeNamesEnum;

  @added(Versions.v2024_08_01_preview)
  @doc("Name of the hardware type (vendor and/or their product name)")
  hardwareType?: AzureLargeInstanceHardwareTypeNamesEnum;

  @removed(Versions.v2024_08_01_preview)
  @renamedFrom(Versions.v2024_08_01_preview, "azureLargeInstanceSize")
  @doc("Specifies the Azure Large Instance SKU.")
  @visibility(Lifecycle.Read)
  azureLargeInstanceSizeOld?: AzureLargeInstanceSizeNamesEnum;

  @added(Versions.v2024_08_01_preview)
  @doc("Specifies the Azure Large Instance SKU.")
  azureLargeInstanceSize?: AzureLargeInstanceSizeNamesEnum;
}

@doc("Specifies the storage settings for the Azure Large Instance disks.")
model StorageProfile {
  @removed(Versions.v2024_08_01_preview)
  @renamedFrom(Versions.v2024_08_01_preview, "nfsIpAddress")
  @doc("IP Address to connect to storage.")
  @visibility(Lifecycle.Read)
  nfsIpAddressOld?: string;

  @added(Versions.v2024_08_01_preview)
  @doc("IP Address to connect to storage.")
  nfsIpAddress?: string;

  @doc("""
    Specifies information about the operating system disk used by Azure Large
    Instance.
    """)
  @identifiers(#[])
  osDisks?: Disk[];
}

@doc("Specifies the disk information fo the Azure Large Instance")
model Disk {
  @doc("The disk name.")
  name?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Avoiding name change to prevent compatibility issues with existing bareMetalInfrastructure service and apis"
  @doc("Specifies the size of an empty data disk in gigabytes.")
  diskSizeGB?: int32;

  @doc("""
    Specifies the logical unit number of the data disk. This value is used to
    identify data disks within the VM and therefore must be unique for each data
    disk attached to a VM.
    """)
  @visibility(Lifecycle.Read)
  lun?: int32;
}

@doc("Specifies the operating system settings for the Azure Large Instance.")
model OsProfile {
  @doc("Specifies the host OS name of the Azure Large Instance.")
  computerName?: string;

  @removed(Versions.v2024_08_01_preview)
  @renamedFrom(Versions.v2024_08_01_preview, "osType")
  @doc("This property allows you to specify the type of the OS.")
  @visibility(Lifecycle.Read)
  osTypeOld?: string;

  @added(Versions.v2024_08_01_preview)
  @doc("This property allows you to specify the type of the OS.")
  osType?: string;

  @removed(Versions.v2024_08_01_preview)
  @renamedFrom(Versions.v2024_08_01_preview, "version")
  @doc("Specifies version of operating system.")
  @visibility(Lifecycle.Read)
  versionOld?: string;

  @added(Versions.v2024_08_01_preview)
  @doc("Specifies version of operating system.")
  version?: string;

  @doc("Specifies the SSH public key used to access the operating system.")
  sshPublicKey?: string;
}

@doc("Specifies the network settings for the Azure Large Instance disks.")
model NetworkProfile {
  @doc("Specifies the network interfaces for the Azure Large Instance.")
  @identifiers(#[])
  networkInterfaces?: IpAddress[];

  @removed(Versions.v2024_08_01_preview)
  @doc("Specifies the circuit id for connecting to express route.")
  @renamedFrom(Versions.v2024_08_01_preview, "circuitId")
  @visibility(Lifecycle.Read)
  circuitIdOld?: string;

  @added(Versions.v2024_08_01_preview)
  @doc("Specifies the circuit id for connecting to express route.")
  circuitId?: string;
}

@doc("Specifies the IP address of the network interface.")
model IpAddress {
  @doc("Specifies the IP address of the network interface.")
  @clientName("ipAddressValue", "csharp")
  ipAddress?: string;
}

@doc("""
  The active state empowers the server with the ability to forcefully terminate
  and halt any existing processes that may be running on the server
  """)
model ForceState {
  @doc("Whether to force restart by shutting all processes.")
  @clientName("forceStateValue", "csharp")
  forceState?: AzureLargeInstanceForcePowerState;
}

@doc("Tags field of the AzureLargeInstance instance.")
model Tags {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags is an acceptable use."
  @clientName("tagsValue", "csharp")
  @doc("Tags field of the AzureLargeInstance instance.")
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "legacy API"
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
  hardwareType?: AzureLargeInstanceHardwareTypeNamesEnum;

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

@doc("The type used for updating tags in AzureLargeStorageInstance resources.")
model AzureLargeStorageInstanceTagsUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags is an acceptable use."
  @clientName("tagsValue", "csharp")
  @doc("Resource tags.")
  tags?: Record<string>;

  ...ManagedServiceIdentityProperty;
}
@@added(AzureLargeStorageInstanceTagsUpdate.identity,
  Versions.v2024_08_01_preview
);
