import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
/**
 * Mesh revision profile for a mesh.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@locationResource
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  MeshRevisionProfileProperties
)
model MeshRevisionProfile extends ProxyResourceBase {
  /**
   * The mode of the mesh.
   */
  @maxLength(24)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @path
  @key("mode")
  @segment("meshRevisionProfiles")
  @visibility("read")
  name: string;

  /**
   * Mesh revision profile properties for a mesh
   */
  @extension("x-ms-client-flatten", true)
  properties?: MeshRevisionProfileProperties;
}

@armResourceOperations
interface MeshRevisionProfiles {
  /**
   * Contains extra metadata on the revision, including supported revisions, cluster compatibility and available upgrades
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedClusters_GetMeshRevisionProfile")
  getMeshRevisionProfile is ArmResourceRead<MeshRevisionProfile>;

  /**
   * Contains extra metadata on each revision, including supported revisions, cluster compatibility and available upgrades
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedClusters_ListMeshRevisionProfiles")
  listMeshRevisionProfiles is ArmResourceListByParent<MeshRevisionProfile>;
}
