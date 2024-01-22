import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
/**
 * Upgrade profile for given mesh.
 */
@parentResource(ManagedCluster)
model MeshUpgradeProfile is ProxyResource<MeshUpgradeProfileProperties> {
  /**
   * The mode of the mesh.
   */
  @maxLength(24)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @path
  @key("mode")
  @segment("meshUpgradeProfiles")
  name: string;
}

@armResourceOperations
interface MeshUpgradeProfiles {
  /**
   * Gets available upgrades for a service mesh in a cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedClusters_GetMeshUpgradeProfile")
  getMeshUpgradeProfile is ArmResourceRead<MeshUpgradeProfile>;

  /**
   * Lists available upgrades for all service meshes in a specific cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedClusters_ListMeshUpgradeProfiles")
  listMeshUpgradeProfiles is ArmResourceListByParent<MeshUpgradeProfile>;
}
