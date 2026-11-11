import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "../models.tsp";
import "./ExternalResourceEnums.tsp";

using Azure.ResourceManager;
using Versioning;
using Rest;
using Http;

namespace Microsoft.NetApp;

/**
 * External Cache Connection resource, representing a cache connection relationship between External and Azure NetApp Files volumes
 */
@added(Versions.v2026_08_15_preview)
@resource("externalCacheConnections")
model ExternalCacheConnection
  is Azure.ResourceManager.TrackedResource<ExternalCacheConnectionProperties> {
  ...ResourceNameParameter<
    Resource = ExternalCacheConnection,
    KeyName = "externalCacheConnectionName",
    SegmentName = "externalCacheConnections",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$"
  >;
}

/**
 * External Cache Connection properties
 */
@added(Versions.v2026_08_15_preview)
model ExternalCacheConnectionProperties {
  /**
   * Current status of the operation
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;

  /**
   * Origin volume resource ID, the ANF volume that acts as the origin for the cache connection
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  originVolumeResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes";
    }
  ]>;

  /**
   * Name of the cache associated with this connection
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @pattern("^[a-zA-Z][a-zA-Z0-9_]{0,196}$")
  externalCacheName: string;

  /**
   * External SVM resource ID, the external storage virtual machine associated with this cache connection
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  externalSvmResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/externalClusters/externalSvms";
    }
  ]>;

  /**
   * The Azure Resource URI for a delegated subnet used for cluster peering
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  clusterPeerSubnetResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Resource ID of the cluster peer
   */
  @visibility(Lifecycle.Read)
  clusterPeerResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/externalClusters/clusterPeers";
    }
  ]>;

  /**
   * Resource ID of the SVM peer
   */
  @visibility(Lifecycle.Read)
  svmPeerResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/externalClusters/clusterPeers/svmPeers";
    }
  ]>;

  /**
   * Setup information for the external cache connection
   */
  @visibility(Lifecycle.Read)
  setupInformation?: SetupInformation;
}

/**
 * List of External Cache Connection resources
 */
@added(Versions.v2026_08_15_preview)
model ExternalCacheConnectionList is Azure.Core.Page<ExternalCacheConnection>;

@added(Versions.v2026_08_15_preview)
@armResourceOperations
interface ExternalCacheConnections {
  /**
   * Get the External Cache Connection
   */
  get is ArmResourceRead<ExternalCacheConnection>;

  /**
   * Create or update the specified External Cache Connection
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExternalCacheConnection>;

  /**
   * Patch the specified External Cache Connection
   */
  @patch
  update is ArmCustomPatchAsync<
    ExternalCacheConnection,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ExternalCacheConnection>
  >;

  /**
   * Delete the specified External Cache Connection
   */
  delete is ArmResourceDeleteWithoutOkAsync<ExternalCacheConnection>;

  /**
   * List all External Cache Connections in the resource group
   */
  listByResourceGroup is ArmResourceListByParent<
    ExternalCacheConnection,
    Response = ArmResponse<ExternalCacheConnectionList>
  >;

  /**
   * List all External Cache Connections in the subscription
   */
  listBySubscription is ArmListBySubscription<
    ExternalCacheConnection,
    Response = ArmResponse<ExternalCacheConnectionList>
  >;
}
