import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;

namespace Microsoft.ContainerService;

// =============================================================================
// MeshRevisionProfile resource and operations
// =============================================================================

/**
 * Mesh revision profile for a mesh.
 */
@parentResource(SubscriptionLocationResource)
model MeshRevisionProfile is ProxyResource<MeshRevisionProfileProperties> {
  ...ResourceNameParameter<
    Resource = MeshRevisionProfile,
    KeyName = "mode",
    SegmentName = "meshRevisionProfiles",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
}

@@maxLength(MeshRevisionProfile.name, 24);
@@minLength(MeshRevisionProfile.name, 1);
@@doc(MeshRevisionProfile.name, "The mode of the mesh.");
@@doc(MeshRevisionProfile.properties,
  "Mesh revision profile properties for a mesh"
);

@armResourceOperations(#{ omitTags: true })
interface MeshRevisionProfiles {
  /**
   * Contains extra metadata on the revision, including supported revisions, cluster compatibility and available upgrades
   */
  @tag("ManagedClusters")
  @summary("Gets a mesh revision profile for a specified mesh in the specified location.")
  getMeshRevisionProfile is ArmResourceRead<
    MeshRevisionProfile,
    BaseParameters = Foundations.SubscriptionBaseParameters
  >;

  /**
   * Contains extra metadata on each revision, including supported revisions, cluster compatibility and available upgrades
   */
  @tag("ManagedClusters")
  @summary("Lists mesh revision profiles for all meshes in the specified location.")
  listMeshRevisionProfiles is ArmResourceListByParent<
    MeshRevisionProfile,
    BaseParameters = Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<MeshRevisionProfileList>
  >;
}

// =============================================================================
// MeshRevisionProfile models
// =============================================================================

/**
 * Holds an array of MeshRevisionsProfiles
 */
model MeshRevisionProfileList is Azure.Core.Page<MeshRevisionProfile>;

/**
 * Mesh revision profile properties for a mesh
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AKS uses custom provisioning states beyond standard ARM states. Using string type for forward compatibility."
model MeshRevisionProfileProperties {
  /** Available mesh revisions. */
  @identifiers(#[])
  meshRevisions?: MeshRevision[];
}
