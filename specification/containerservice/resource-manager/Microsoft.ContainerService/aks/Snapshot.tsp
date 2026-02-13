import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ContainerService;

// =============================================================================
// Snapshot resource and operations
// =============================================================================

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

// =============================================================================
// Snapshot models
// =============================================================================

/**
 * Properties used to configure a node pool snapshot.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SnapshotProperties {
  /**
   * CreationData to be used to specify the source agent pool resource ID to create this snapshot.
   */
  creationData?: CreationData;

  /**
   * The type of a snapshot. The default is NodePool.
   */
  snapshotType?: SnapshotType = SnapshotType.NodePool;

  /**
   * The version of Kubernetes.
   */
  @visibility(Lifecycle.Read)
  kubernetesVersion?: string;

  /**
   * The version of node image.
   */
  @visibility(Lifecycle.Read)
  nodeImageVersion?: string;

  /**
   * The operating system type. The default is Linux.
   */
  @visibility(Lifecycle.Read)
  osType?: OSType = OSType.Linux;

  /**
   * Specifies the OS SKU used by the agent pool. The default is Ubuntu if OSType is Linux. The default is Windows2019 when Kubernetes <= 1.24 or Windows2022 when Kubernetes >= 1.25 if OSType is Windows.
   */
  @visibility(Lifecycle.Read)
  osSku?: OSSKU;

  /**
   * The size of the VM.
   */
  @visibility(Lifecycle.Read)
  vmSize?: string;

  /**
   * Whether to use a FIPS-enabled OS.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  enableFIPS?: boolean;
}
