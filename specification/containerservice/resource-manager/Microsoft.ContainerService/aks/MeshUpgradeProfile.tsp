import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
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

@armResourceOperations
interface MeshUpgradeProfiles {
  /**
   * Gets available upgrades for a service mesh in a cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedClusters_GetMeshUpgradeProfile")
  getMeshUpgradeProfile is ArmResourceRead<MeshUpgradeProfile>;

  /**
   * Lists available upgrades for all service meshes in a specific cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedClusters_ListMeshUpgradeProfiles")
  listMeshUpgradeProfiles is ArmResourceListByParent<
    MeshUpgradeProfile,
    Response = ArmResponse<MeshUpgradeProfileList>
  >;
}

@@maxLength(MeshUpgradeProfile.name, 24);
@@minLength(MeshUpgradeProfile.name, 1);
@@doc(MeshUpgradeProfile.name, "The mode of the mesh.");
@@doc(MeshUpgradeProfile.properties,
  "Mesh upgrade profile properties for a major.minor release."
);
