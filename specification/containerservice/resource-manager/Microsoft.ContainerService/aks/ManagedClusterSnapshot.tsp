import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;

// =============================================================================
// ManagedClusterSnapshot resource and operations
// =============================================================================

/**
 * A managed cluster snapshot resource.
 */
@added(Versions.v2025_10_02_preview)
model ManagedClusterSnapshot
  is Azure.ResourceManager.TrackedResource<ManagedClusterSnapshotProperties> {
  ...ResourceNameParameter<
    Resource = ManagedClusterSnapshot,
    KeyName = "resourceName",
    SegmentName = "managedclustersnapshots",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
}

@@maxLength(ManagedClusterSnapshot.name, 63);
@@minLength(ManagedClusterSnapshot.name, 1);
@@doc(ManagedClusterSnapshot.name, "The name of the managed cluster resource.");
@@doc(ManagedClusterSnapshot.properties,
  "Properties of a managed cluster snapshot."
);
@@doc(ManagedClusterSnapshots.createOrUpdate::parameters.resource,
  "The managed cluster snapshot to create or update."
);
@@doc(ManagedClusterSnapshots.updateTags::parameters.properties,
  "Parameters supplied to the Update managed cluster snapshot Tags operation."
);

@armResourceOperations
@added(Versions.v2025_10_02_preview)
interface ManagedClusterSnapshots {
  /**
   * Gets a managed cluster snapshot.
   */
  get is ArmResourceRead<ManagedClusterSnapshot>;

  /**
   * Creates or updates a managed cluster snapshot.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedClusterSnapshot>;

  /**
   * Updates tags on a managed cluster snapshot.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ManagedClusterSnapshot,
    PatchModel = TagsObject
  >;

  /**
   * Deletes a managed cluster snapshot.
   */
  delete is ArmResourceDeleteSync<ManagedClusterSnapshot>;

  /**
   * Lists managed cluster snapshots in the specified subscription and resource group.
   */
  listByResourceGroup is ArmResourceListByParent<ManagedClusterSnapshot>;

  /**
   * Gets a list of managed cluster snapshots in the specified subscription.
   */
  list is ArmListBySubscription<ManagedClusterSnapshot>;
}

// =============================================================================
// ManagedClusterSnapshot models
// =============================================================================

/**
 * Properties for a managed cluster snapshot.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model ManagedClusterSnapshotProperties {
  /**
   * CreationData to be used to specify the source resource ID to create this snapshot.
   */
  creationData?: CreationData;

  /**
   * The type of a snapshot. The default is NodePool.
   */
  snapshotType?: SnapshotType = SnapshotType.NodePool;

  /**
   * What the properties will be showed when getting managed cluster snapshot. Those properties are read-only.
   */
  @visibility(Lifecycle.Read)
  managedClusterPropertiesReadOnly?: ManagedClusterPropertiesForSnapshot;
}

/**
 * managed cluster properties for snapshot, these properties are read only.
 */
@added(Versions.v2025_10_02_preview)
model ManagedClusterPropertiesForSnapshot {
  /**
   * The current kubernetes version.
   */
  kubernetesVersion?: string;

  /**
   * The current managed cluster sku.
   */
  sku?: ManagedClusterSKU;

  /**
   * Whether the cluster has enabled Kubernetes Role-Based Access Control or not.
   */
  enableRbac?: boolean;

  /**
   * The current network profile.
   */
  @visibility(Lifecycle.Read)
  networkProfile?: NetworkProfileForSnapshot;
}

/**
 * network profile for managed cluster snapshot, these properties are read only.
 */
@added(Versions.v2025_10_02_preview)
model NetworkProfileForSnapshot {
  /**
   * networkPlugin for managed cluster snapshot.
   */
  networkPlugin?: NetworkPlugin;

  /**
   * NetworkPluginMode for managed cluster snapshot.
   */
  networkPluginMode?: NetworkPluginMode;

  /**
   * networkPolicy for managed cluster snapshot.
   */
  networkPolicy?: NetworkPolicy;

  /**
   * networkMode for managed cluster snapshot.
   */
  networkMode?: NetworkMode;

  /**
   * loadBalancerSku for managed cluster snapshot.
   */
  loadBalancerSku?: LoadBalancerSku;
}
