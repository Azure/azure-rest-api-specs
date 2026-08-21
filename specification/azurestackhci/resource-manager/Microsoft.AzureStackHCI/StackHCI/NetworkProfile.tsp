import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;

/**
 * Network Profile details - child resource of Cluster.
 */
@added(Versions.v2026_10_15_preview)
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
@added(Versions.v2026_10_15_preview)
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
   * Delete a Network Profile.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NetworkProfile>;

  /**
   * List NetworkProfile resources by Cluster.
   */
  listByCluster is ArmResourceListByParent<NetworkProfile>;
}
