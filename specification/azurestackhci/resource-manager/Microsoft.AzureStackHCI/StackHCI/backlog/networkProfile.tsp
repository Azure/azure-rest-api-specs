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

@doc("Network Profile details.")
@parentResource(Cluster)
model NetworkProfile
  is Azure.ResourceManager.ProxyResource<NetworkProfileProperties> {
  ...ResourceNameParameter<
    Resource = NetworkProfile,
    KeyName = "networkProfileName",
    SegmentName = "networkProfiles",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;
}

@armResourceOperations
interface NetworkProfiles {
  @doc("Get Network Profile.")
  get is ArmResourceRead<NetworkProfile>;

  @doc("Create a Network Profile.")
  create is ArmResourceCreateOrReplaceSync<NetworkProfile>;

  @doc("Update a Network Profile.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<NetworkProfile, NetworkProfile>;

  @doc("Delete a Network Profile.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkProfile>;

  @doc("List NetworkProfile resources by Clusters")
  listByCluster is ArmResourceListByParent<NetworkProfile>;
}

@@doc(NetworkProfile.name, "Name of NetworkProfile");

///////////////////models///////////

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Network Profile properties.")
model NetworkProfileProperties {
  @doc("Network profile properties reported from the cluster.")
  @visibility(Lifecycle.Read)
  reportedProperties?: NetworkProfileReportedProperties;

  @doc("Network profile resource Last sync timestamp.")
  @visibility(Lifecycle.Read)
  lastSyncTimestamp?: utcDateTime;

  @doc("Network profile resource Last sync status.")
  @visibility(Lifecycle.Read)
  lastSyncStatus?: string;
}

@doc("Network Profile properties reported by the cluster.")
model NetworkProfileReportedProperties {
  @doc("The IPv4 addresses of the cluster.")
  @visibility(Lifecycle.Read)
  clusterIpv4Addresses?: string[];

  @doc("The IPv6 addresses of the cluster.")
  @visibility(Lifecycle.Read)
  clusterIpv6Addresses?: string[];

  @doc("The subnet associated with the cluster.")
  @visibility(Lifecycle.Read)
  subnet?: string;

  @doc("Whether auto-selection for VM migration network is enabled.")
  @visibility(Lifecycle.Read)
  autoSelectMigrationNetwork?: boolean;

  @doc("Whether network naming is enabled.")
  @visibility(Lifecycle.Read)
  enableNetworkNaming?: boolean;

  @doc("Whether auto-selection for VM migration performance is enabled.")
  @visibility(Lifecycle.Read)
  autoSelectVmMigrationPerformance?: boolean;

  @doc("The maximum number of VM migrations allowed.")
  @visibility(Lifecycle.Read)
  maxVmMigration?: int32;

  @doc("The performance type for VM migration.")
  @visibility(Lifecycle.Read)
  vmMigrationPerformance?: string;

  @doc("Maximum bandwidth for SMB migration.")
  @visibility(Lifecycle.Read)
  maxSmbMigrationBandwidth?: string;

  @doc("Details of nodes in the network profile.")
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  nodes?: Node[];

  @doc("Details of physical adapters.")
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  physicalAdapters?: PhysicalAdapter[];

  @doc("Details of virtual switches.")
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  virtualSwitches?: VirtualSwitch[];

  @doc("Details of networks.")
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  networks?: Network[];

  @doc("Details of virtual adapters.")
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  virtualAdapters?: VirtualAdapter[];

  @doc("Details of network intents.")
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  intents?: NetworkIntent[];
}

@doc("Details of a node in the network profile.")
model Node {
  @doc("The node ID.")
  id: string;

  @doc("The physical adapter IDs associated with the node.")
  physicalAdapterIds?: string[];

  @doc("The virtual switch IDs associated with the node.")
  virtualSwitchIds?: string[];

  @doc("The arc status of the node.")
  arcStatus?: string;

  @doc("The Azure resource id of Arc machine of the corresponding node.")
  arcMachineId?: Azure.Core.armResourceIdentifier;
}

@doc("Details of a physical adapter.")
model PhysicalAdapter {
  @doc("The physical adapter ID.")
  id: string;

  @doc("The name of the physical adapter.")
  name?: string;

  @doc("The description of the physical adapter.")
  description?: string;

  @doc("The VLAN associated with the physical adapter.")
  vlan?: int32;

  @doc("The IPv4 addresses of the physical adapter.")
  ipv4Addresses?: string[];

  @doc("The IPv6 addresses of the physical adapter.")
  ipv6Addresses?: string[];

  @doc("The driver version of the physical adapter.")
  driverVersion?: string;

  @doc("The node ID the physical adapter is associated with.")
  nodeId?: string;
}

@doc("Details of a virtual switch.")
model VirtualSwitch {
  @doc("The virtual switch ID.")
  id: string;

  @doc("The name of the virtual switch.")
  name?: string;

  @doc("The virtual adapter IDs associated with the virtual switch.")
  virtualAdapterIds?: string[];

  @doc("The physical adapter IDs associated with the virtual switch.")
  physicalAdapterIds?: string[];

  @doc("The physical adapter names associated with the virtual switch.")
  physicalAdapterNames?: string[];

  @doc("The virtual adapter names  associated with the virtual switch.")
  virtualAdapterNames?: string[];

  @doc("The intent ID associated with the virtual switch.")
  intentId?: string;
}

@doc("Details of a network.")
@discriminator("type")
model Network {
  @doc("The network ID.")
  id: string;

  @doc("The name of the network.")
  name?: string;

  @doc("The type of the network.")
  type: NetworkType;

  @doc("The VLAN associated with the network.")
  vlan?: int32;

  @doc("The intent ID associated with the network.")
  intentId?: string;
}

@doc("Details of a storage network.")
model StorageNetwork extends Network {
  @doc("The type of the network.")
  type: NetworkType.Storage;

  @doc("Whether the network supports direct access.")
  networkDirect?: string;
}

@doc("Details of a logical network.")
model LogicalNetwork extends Network {
  @doc("The type of the network.")
  type: NetworkType.Logical;

  @doc("IP address space of the logical network.")
  addressSpace?: string;
}

@doc("Details of a virtual adapter.")
model VirtualAdapter {
  @doc("The virtual adapter ID.")
  id: string;

  @doc("The name of the virtual adapter.")
  name?: string;

  @doc("The VLAN associated with the virtual adapter.")
  vlan?: int32;

  @doc("The IPv4 addresses of the virtual adapter.")
  ipv4Addresses?: string[];

  @doc("The IPv6 addresses of the virtual adapter.")
  ipv6Addresses?: string[];
}

@doc("Details of a network intent.")
model NetworkIntent {
  @doc("The intent ID.")
  id: string;

  @doc("The name of the intent.")
  name?: string;

  @doc("Whether this is a compute type intent.")
  isComputeType?: boolean;

  @doc("Whether this is a storage type intent.")
  isStorageType?: boolean;

  @doc("Whether this is a management type intent.")
  isManagementType?: boolean;

  @doc("The physical adapter IDs associated with the intent.")
  physicalAdapterIds?: string[];

  @doc("The virtual adapter IDs associated with the intent.")
  virtualAdapterIds?: string[];

  @doc("The virtual switch IDs associated with the intent.")
  virtualSwitchIds?: string[];

  @doc("The network IDs associated with the intent.")
  networkIds?: string[];

  @doc("The physical adapter names associated with the intent.")
  physicalAdapterNames?: string[];

  @doc("The virtual adapter names associated with the intent.")
  virtualAdapterNames?: string[];

  @doc("The virtual switch names associated with the intent.")
  virtualSwitchNames?: string[];

  @doc("The network names associated with the intent.")
  networkNames?: string[];
}

@doc("Types of networks.")
union NetworkType {
  string,

  @doc("Storage network type.")
  Storage: "Storage",

  @doc("Logical network type.")
  Logical: "Logical",
}
