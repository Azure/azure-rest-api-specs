import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;
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
