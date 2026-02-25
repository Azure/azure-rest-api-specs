import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;

// =============================================================================
// MeshMembership resource and operations
// =============================================================================

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This field is allowed at the top-level as per the ARM resource specification."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  managedBy?: string;

  ...Azure.ResourceManager.EntityTagProperty;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MeshMembership>;

  /**
   * Deletes the mesh membership of a managed cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    MeshMembership,
    LroHeaders = ArmAsyncOperationHeaderWithLocation &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists mesh memberships in a managed cluster.
   */
  listByManagedCluster is ArmResourceListByParent<
    MeshMembership,
    Response = ArmResponse<MeshMembershipsListResult>
  >;
}

// =============================================================================
// MeshMembership models
// =============================================================================

/**
 * The provisioning state of the last accepted operation.
 */
@added(Versions.v2025_10_02_preview)
union MeshMembershipProvisioningState {
  string,

  /**
   * Resource creation was canceled.
   */
  Canceled: "Canceled",

  /**
   * The Mesh Membership is being created.
   */
  Creating: "Creating",

  /**
   * The Mesh Membership is being deleted.
   */
  Deleting: "Deleting",

  /**
   * Resource creation failed.
   */
  Failed: "Failed",

  /**
   * Resource has been created.
   */
  Succeeded: "Succeeded",

  /**
   * The Mesh Membership is being updated.
   */
  Updating: "Updating",
}

/**
 * Mesh membership properties of a managed cluster.
 */
@added(Versions.v2025_10_02_preview)
model MeshMembershipProperties {
  /**
   * The current provisioning state of the Mesh Membership.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: MeshMembershipProvisioningState;

  /**
   * The ARM resource id for the managed mesh member. This is of the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AppLink/applinks/{appLinkName}/appLinkMembers/{appLinkMemberName}'. Visit https://aka.ms/applink for more information.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
  managedMeshID: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AppLink/applinks";
    }
  ]>;
}

/**
 * The result of a request to list mesh memberships in a managed cluster.
 */
@added(Versions.v2025_10_02_preview)
model MeshMembershipsListResult {
  /**
   * The list of mesh memberships.
   */
  @pageItems
  value: MeshMembership[];

  @doc("The URL to get the next set of mesh membership results.")
  @nextLink
  nextLink?: ResourceLocation<MeshMembership>;
}
