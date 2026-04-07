import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;

// ==================== Cluster Volume Resource ====================

/**
 * Cluster Volume resource representing a storage volume on a Cluster.
 */
@added(Versions.v2026_03_15_preview)
@parentResource(Cluster)
model ClusterVolume
  is Azure.ResourceManager.ProxyResource<ClusterVolumeProperties> {
  ...ResourceNameParameter<
    Resource = ClusterVolume,
    KeyName = "volumeName",
    SegmentName = "volumes",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
}

/**
 * Operations for Cluster Volumes.
 */
@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface ClusterVolumes {
  /** Get a specific volume on a Cluster. */
  get is ArmResourceRead<ClusterVolume>;

  /** List all volumes on a Cluster. */
  list is ArmResourceListByParent<ClusterVolume>;
}
