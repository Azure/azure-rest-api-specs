import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.AzureStackHCI;

/**
 * Network Profile details - child resource of Cluster.
 */
@added(Versions.v2026_03_15_preview)
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

/**
 * CRUD operations for Network Profiles.
 */
@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface NetworkProfiles {
  /**
   * Get a Network Profile.
   */
  get is ArmResourceRead<NetworkProfile>;

  /**
   * Create a Network Profile.
   */
  create is ArmResourceCreateOrReplaceSync<NetworkProfile>;

  /**
   * Update a Network Profile.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<NetworkProfile, NetworkProfile>;

  /**
   * Delete a Network Profile.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NetworkProfile>;

  /**
   * List NetworkProfile resources by Cluster.
   */
  listByCluster is ArmResourceListByParent<NetworkProfile>;
}

/////////////////// Models ///////////////////

/**
 * Network Profile properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@added(Versions.v2026_03_15_preview)
model NetworkProfileProperties {
  /**
   * Network profile properties reported from the cluster.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: NetworkProfileReportedProperties;

  /**
   * Network profile resource Last sync timestamp.
   */
  @visibility(Lifecycle.Read)
  lastSyncTimestamp?: utcDateTime;

  /**
   * Network profile resource Last sync status.
   */
  @visibility(Lifecycle.Read)
  lastSyncStatus?: string;
}

/**
 * Network Profile properties reported by the cluster.
 */
@added(Versions.v2026_03_15_preview)
model NetworkProfileReportedProperties {
  /**
   * The IPv4 addresses of the cluster.
   */
  @visibility(Lifecycle.Read)
  clusterIpv4Addresses?: string[];

  /**
   * The IPv6 addresses of the cluster.
   */
  @visibility(Lifecycle.Read)
  clusterIpv6Addresses?: string[];

  /**
   * The subnet associated with the cluster.
   */
  @visibility(Lifecycle.Read)
  subnet?: string;

  /**
   * Whether auto-selection for VM migration network is enabled.
   */
  @visibility(Lifecycle.Read)
  autoSelectMigrationNetwork?: boolean;

  /**
   * Whether network naming is enabled.
   */
  @visibility(Lifecycle.Read)
  enableNetworkNaming?: boolean;

  /**
   * Whether auto-selection for VM migration performance is enabled.
   */
  @visibility(Lifecycle.Read)
  autoSelectVmMigrationPerformance?: boolean;

  /**
   * The maximum number of VM migrations allowed.
   */
  @visibility(Lifecycle.Read)
  maxVmMigration?: int32;

  /**
   * The performance type for VM migration.
   */
  @visibility(Lifecycle.Read)
  vmMigrationPerformance?: string;

  /**
   * Maximum bandwidth for SMB migration.
   */
  @visibility(Lifecycle.Read)
  maxSmbMigrationBandwidth?: string;

  /**
   * Details of nodes in the network profile.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  nodes?: NetworkProfileNode[];

  /**
   * Details of physical adapters.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  physicalAdapters?: NetworkProfilePhysicalAdapter[];

  /**
   * Details of virtual switches.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  virtualSwitches?: NetworkProfileVirtualSwitch[];

  /**
   * Details of networks.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  networks?: NetworkProfileNetwork[];

  /**
   * Details of virtual adapters.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  virtualAdapters?: NetworkProfileVirtualAdapter[];

  /**
   * Details of network intents.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  intents?: NetworkProfileIntent[];
}

/**
 * Details of a node in the network profile.
 */
@added(Versions.v2026_03_15_preview)
model NetworkProfileNode {
  /**
   * The node ID.
   */
  id: string;

  /**
   * The physical adapter IDs associated with the node.
   */
  physicalAdapterIds?: string[];

  /**
   * The virtual switch IDs associated with the node.
   */
  virtualSwitchIds?: string[];

  /**
   * The arc status of the node.
   */
  arcStatus?: string;

  /**
   * The Azure resource id of Arc machine of the corresponding node.
   */
  arcMachineId?: Azure.Core.armResourceIdentifier;
}

/**
 * Details of a physical adapter.
 */
@added(Versions.v2026_03_15_preview)
model NetworkProfilePhysicalAdapter {
  /**
   * The physical adapter ID.
   */
  id: string;

  /**
   * The name of the physical adapter.
   */
  name?: string;

  /**
   * The description of the physical adapter.
   */
  description?: string;

  /**
   * The VLAN associated with the physical adapter.
   */
  vlan?: int32;

  /**
   * The IPv4 addresses of the physical adapter.
   */
  ipv4Addresses?: string[];

  /**
   * The IPv6 addresses of the physical adapter.
   */
  ipv6Addresses?: string[];

  /**
   * The driver version of the physical adapter.
   */
  driverVersion?: string;

  /**
   * The node ID the physical adapter is associated with.
   */
  nodeId?: string;
}

/**
 * Details of a virtual switch.
 */
@added(Versions.v2026_03_15_preview)
model NetworkProfileVirtualSwitch {
  /**
   * The virtual switch ID.
   */
  id: string;

  /**
   * The name of the virtual switch.
   */
  name?: string;

  /**
   * The virtual adapter IDs associated with the virtual switch.
   */
  virtualAdapterIds?: string[];

  /**
   * The physical adapter IDs associated with the virtual switch.
   */
  physicalAdapterIds?: string[];

  /**
   * The physical adapter names associated with the virtual switch.
   */
  physicalAdapterNames?: string[];

  /**
   * The virtual adapter names associated with the virtual switch.
   */
  virtualAdapterNames?: string[];

  /**
   * The intent ID associated with the virtual switch.
   */
  intentId?: string;
}

/**
 * Details of a network.
 */
@added(Versions.v2026_03_15_preview)
@discriminator("type")
model NetworkProfileNetwork {
  /**
   * The network ID.
   */
  id: string;

  /**
   * The name of the network.
   */
  name?: string;

  /**
   * The type of the network.
   */
  type: NetworkProfileNetworkType;

  /**
   * The VLAN associated with the network.
   */
  vlan?: int32;

  /**
   * The intent ID associated with the network.
   */
  intentId?: string;
}

/**
 * Details of a storage network.
 */
@added(Versions.v2026_03_15_preview)
model NetworkProfileStorageNetwork extends NetworkProfileNetwork {
  /**
   * The type of the network.
   */
  type: NetworkProfileNetworkType.Storage;

  /**
   * Whether the network supports direct access.
   */
  networkDirect?: string;
}

/**
 * Details of a logical network.
 */
@added(Versions.v2026_03_15_preview)
model NetworkProfileLogicalNetwork extends NetworkProfileNetwork {
  /**
   * The type of the network.
   */
  type: NetworkProfileNetworkType.Logical;

  /**
   * IP address space of the logical network.
   */
  addressSpace?: string;
}

/**
 * Details of a virtual adapter.
 */
@added(Versions.v2026_03_15_preview)
model NetworkProfileVirtualAdapter {
  /**
   * The virtual adapter ID.
   */
  id: string;

  /**
   * The name of the virtual adapter.
   */
  name?: string;

  /**
   * The VLAN associated with the virtual adapter.
   */
  vlan?: int32;

  /**
   * The IPv4 addresses of the virtual adapter.
   */
  ipv4Addresses?: string[];

  /**
   * The IPv6 addresses of the virtual adapter.
   */
  ipv6Addresses?: string[];
}

/**
 * Details of a network intent.
 */
@added(Versions.v2026_03_15_preview)
model NetworkProfileIntent {
  /**
   * The intent ID.
   */
  id: string;

  /**
   * The name of the intent.
   */
  name?: string;

  /**
   * Whether this is a compute type intent.
   */
  isComputeType?: boolean;

  /**
   * Whether this is a storage type intent.
   */
  isStorageType?: boolean;

  /**
   * Whether this is a management type intent.
   */
  isManagementType?: boolean;

  /**
   * The physical adapter IDs associated with the intent.
   */
  physicalAdapterIds?: string[];

  /**
   * The virtual adapter IDs associated with the intent.
   */
  virtualAdapterIds?: string[];

  /**
   * The virtual switch IDs associated with the intent.
   */
  virtualSwitchIds?: string[];

  /**
   * The network IDs associated with the intent.
   */
  networkIds?: string[];

  /**
   * The physical adapter names associated with the intent.
   */
  physicalAdapterNames?: string[];

  /**
   * The virtual adapter names associated with the intent.
   */
  virtualAdapterNames?: string[];

  /**
   * The virtual switch names associated with the intent.
   */
  virtualSwitchNames?: string[];

  /**
   * The network names associated with the intent.
   */
  networkNames?: string[];
}

/**
 * Types of networks.
 */
@added(Versions.v2026_03_15_preview)
union NetworkProfileNetworkType {
  string,

  /** Storage network type. */
  Storage: "Storage",

  /** Logical network type. */
  Logical: "Logical",
}
