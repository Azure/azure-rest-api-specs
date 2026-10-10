import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "../models.tsp";
import "./ExternalResourceEnums.tsp";

using Azure.ResourceManager;
using Azure.Core;
using Versioning;
using Rest;

namespace Microsoft.NetApp;

/**
 * Cluster Peer resource, represents a peer relationship between an external cluster and an Azure NetApp Files cluster
 */
@added(Versions.v2026_08_15_preview)
@parentResource(ExternalCluster)
model ClusterPeer
  is Azure.ResourceManager.ProxyResource<ClusterPeerProperties> {
  ...ResourceNameParameter<
    Resource = ClusterPeer,
    KeyName = "peerId",
    SegmentName = "clusterPeers",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$"
  >;
}

/**
 * External Resource Network Interfaces
 */
@added(Versions.v2026_08_15_preview)
model ExternalResourceNetworkInterfaces {
  /**
   * Network Interface Resource ID
   */
  networkInterfaceResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/networkInterfaces";
    }
  ]>;

  /**
   * Peer IP address used for peering
   */
  @example("10.10.10.10")
  peerIpAddress: ipV4Address;
}

/**
 * Cluster Peer properties
 */
@added(Versions.v2026_08_15_preview)
model ClusterPeerProperties {
  /**
   * Azure lifecycle management
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;

  /**
   * Name of the Azure NetApp Files (ANF) cluster
   */
  @visibility(Lifecycle.Read)
  anfClusterName?: string;

  /**
   * Name of the external ONTAP cluster, discovered during cluster peering
   */
  @visibility(Lifecycle.Read)
  @maxLength(44)
  ontapClusterName?: string;

  /**
   * The ONTAP version of the external cluster.
   */
  @visibility(Lifecycle.Read)
  ontapVersion?: string;

  /**
   * Status of the peer relationship
   */
  @visibility(Lifecycle.Read)
  status?: ClusterPeerStatus;

  /**
   * External volume replication resource IDs
   */
  @visibility(Lifecycle.Read)
  hybridReplicationResourceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/hybridReplications";
    }
  ]>[];

  /**
   * External cache connection resource IDs
   */
  @visibility(Lifecycle.Read)
  externalCacheConnectionResourceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/externalCacheConnections";
    }
  ]>[];

  /**
   * Command to execute to create the peer relationship
   */
  @visibility(Lifecycle.Read)
  @example("cluster peer create -peer-addr 1.2.3.4")
  command?: string;

  /**
   * Network interfaces created that allow communications between the clusters
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["networkInterfaceResourceId"])
  networkInterfaces?: ExternalResourceNetworkInterfaces[];

  /**
   * Cluster Peer Subnet Resource ID
   */
  @visibility(Lifecycle.Read)
  clusterPeerSubnetResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;
}

/**
 * List of Cluster Peer resources
 */
@added(Versions.v2026_08_15_preview)
model ClusterPeerList is Azure.Core.Page<ClusterPeer>;

@added(Versions.v2026_08_15_preview)
@armResourceOperations
interface ClusterPeers {
  /**
   * Get the Cluster Peer
   */
  get is ArmResourceRead<ClusterPeer>;

  /**
   * List all Cluster Peers under an External Cluster
   */
  listByParent is ArmResourceListByParent<ClusterPeer>;
}
