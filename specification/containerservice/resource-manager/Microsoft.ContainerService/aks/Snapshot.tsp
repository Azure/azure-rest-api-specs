import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ContainerService;
/**
 * A node pool snapshot resource.
 */
model Snapshot is Azure.ResourceManager.TrackedResource<SnapshotProperties> {
  ...ResourceNameParameter<
    Resource = Snapshot,
    KeyName = "resourceName",
    SegmentName = "snapshots",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
}

@armResourceOperations
interface Snapshots {
  /**
   * Gets a snapshot.
   */
  get is ArmResourceRead<Snapshot>;

  /**
   * Creates or updates a snapshot.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Snapshot>;

  /**
   * Updates tags on a snapshot.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<Snapshot, PatchModel = TagsObject>;

  /**
   * Deletes a snapshot.
   */
  delete is ArmResourceDeleteSync<Snapshot>;

  /**
   * Lists snapshots in the specified subscription and resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Snapshot>;

  /**
   * Gets a list of snapshots in the specified subscription.
   */
  list is ArmListBySubscription<Snapshot>;
}

@@maxLength(Snapshot.name, 63);
@@minLength(Snapshot.name, 1);
@@doc(Snapshot.name, "The name of the managed cluster resource.");
@@doc(Snapshot.properties, "Properties of a snapshot.");
@@doc(Snapshots.createOrUpdate::parameters.resource,
  "The snapshot to create or update."
);
@@doc(Snapshots.updateTags::parameters.properties,
  "Parameters supplied to the Update snapshot Tags operation."
);
