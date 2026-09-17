import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "../models.tsp";
import "./ExternalResourceEnums.tsp";

using Azure.ResourceManager;
using Versioning;
using Rest;

namespace Microsoft.NetApp;

/**
 * SVM Peer resource, represents a peer relationship between an external SVM and an Azure NetApp Files SVM
 */
@added(Versions.v2026_08_15_preview)
@parentResource(ClusterPeer)
model SvmPeer is Azure.ResourceManager.ProxyResource<SvmPeerProperties> {
  ...ResourceNameParameter<
    Resource = SvmPeer,
    KeyName = "svmPeerId",
    SegmentName = "svmPeers",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$"
  >;
}

/**
 * SVM Peer properties
 */
@added(Versions.v2026_08_15_preview)
model SvmPeerProperties {
  /**
   * Azure lifecycle management
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;

  /**
   * Command to accept the peer relationship
   */
  @visibility(Lifecycle.Read)
  acceptCommand?: string;

  /**
   * Name of the Azure Net App Files (ANF) SVM
   */
  @visibility(Lifecycle.Read)
  anfSvmName?: string;

  /**
   * Resource ID of the external SVM
   */
  @visibility(Lifecycle.Read)
  externalSvmResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/externalClusters/externalSvms";
    }
  ]>;

  /**
   * Status of the peer relationship
   */
  @visibility(Lifecycle.Read)
  status?: SvmPeerStatus;

  /**
   * Peer types; expected values include "Replication" or "Cache"
   */
  @visibility(Lifecycle.Read)
  peerTypes?: SvmPeerType[];

  /**
   * Resource IDs of Hybrid Replication resources associated with this SVM peer
   */
  @visibility(Lifecycle.Read)
  hybridReplicationResourceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/hybridReplications";
    }
  ]>[];

  /**
   * Resource IDs of External Cache Connections associated with this SVM peer
   */
  @visibility(Lifecycle.Read)
  externalCacheConnectionResourceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/externalCacheConnections";
    }
  ]>[];
}

/**
 * List of SVM Peer resources
 */
@added(Versions.v2026_08_15_preview)
model SvmPeerList is Azure.Core.Page<SvmPeer>;

@added(Versions.v2026_08_15_preview)
@armResourceOperations
interface SvmPeers {
  /**
   * Get the SVM Peer
   */
  get is ArmResourceRead<SvmPeer>;

  /**
   * List and describe all SVM Peers under a Cluster Peer
   */
  listByParent is ArmResourceListByParent<SvmPeer>;
}
