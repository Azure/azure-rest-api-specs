import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ContainerService;

// =============================================================================
// MeshUpgradeProfile resource and operations
// =============================================================================

/**
 * Upgrade profile for given mesh.
 */
@parentResource(ManagedCluster)
model MeshUpgradeProfile
  is Azure.ResourceManager.ProxyResource<MeshUpgradeProfileProperties> {
  ...ResourceNameParameter<
    Resource = MeshUpgradeProfile,
    KeyName = "mode",
    SegmentName = "meshUpgradeProfiles",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
}

@@maxLength(MeshUpgradeProfile.name, 24);
@@minLength(MeshUpgradeProfile.name, 1);
@@doc(MeshUpgradeProfile.name, "The mode of the mesh.");
@@doc(MeshUpgradeProfile.properties,
  "Mesh upgrade profile properties for a major.minor release."
);

@armResourceOperations(#{ omitTags: true })
interface MeshUpgradeProfiles {
  /**
   * Gets available upgrades for a service mesh in a cluster.
   */
  @tag("ManagedClusters")
  getMeshUpgradeProfile is ArmResourceRead<MeshUpgradeProfile>;

  /**
   * Lists available upgrades for all service meshes in a specific cluster.
   */
  @tag("ManagedClusters")
  listMeshUpgradeProfiles is ArmResourceListByParent<
    MeshUpgradeProfile,
    Response = ArmResponse<MeshUpgradeProfileList>
  >;
}

// =============================================================================
// MeshUpgradeProfile models
// =============================================================================

/**
 * Holds an array of MeshUpgradeProfiles
 */
model MeshUpgradeProfileList is Azure.Core.Page<MeshUpgradeProfile>;

/**
 * Mesh upgrade profile properties for a major.minor release.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MeshUpgradeProfileProperties extends MeshRevision {}
