import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;
/**
 * Mesh membership of a managed cluster.
 */
@parentResource(ManagedCluster)
@added(Versions.v2025_10_02_preview)
model MeshMembership
  is Azure.ResourceManager.ProxyResource<MeshMembershipProperties> {
  ...ResourceNameParameter<
    Resource = MeshMembership,
    KeyName = "meshMembershipName",
    SegmentName = "meshMemberships",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9]{0,62}$"
  >;

  /**
   * The fully qualified resource ID of the resource that manages this resource. Indicates if this resource is managed by another Azure resource. If this is present, complete mode deployment will not delete the resource if it is removed from the template since it is managed by another resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  managedBy?: string;

  ...Azure.ResourceManager.EntityTagProperty;
}

@armResourceOperations
@added(Versions.v2025_10_02_preview)
interface MeshMemberships {
  /**
   * Gets the mesh membership of a managed cluster.
   */
  get is ArmResourceRead<MeshMembership>;

  /**
   * Creates or updates the mesh membership of a managed cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    MeshMembership,
    LroHeaders = ArmLroLocationHeader<FinalResult = MeshMembership> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the mesh membership of a managed cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<MeshMembership>;

  /**
   * Lists mesh memberships in a managed cluster.
   */
  listByManagedCluster is ArmResourceListByParent<
    MeshMembership,
    Response = ArmResponse<MeshMembershipsListResult>
  >;
}

@@maxLength(MeshMembership.name, 63);
@@minLength(MeshMembership.name, 1);
@@doc(MeshMembership.name, "The name of the mesh membership.");
@@doc(MeshMembership.properties,
  "Mesh membership properties of a managed cluster."
);
@@doc(MeshMemberships.createOrUpdate::parameters.resource,
  "The mesh membership to create or update."
);
