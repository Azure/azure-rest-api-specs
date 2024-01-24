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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedCluster)
@Azure.ResourceManager.Private.armResourceInternal(MeshUpgradeProfileProperties)
@includeInapplicableMetadataInPayload(false)
model MeshUpgradeProfile extends ProxyResourceBase {
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

  /**
   * Mesh upgrade profile properties for a major.minor release.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MeshUpgradeProfileProperties;
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
