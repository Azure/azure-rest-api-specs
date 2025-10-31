import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;

model ResourceGuardResource
  is Azure.ResourceManager.TrackedResource<ResourceGuard> {
  ...ResourceNameParameter<
    Resource = ResourceGuardResource,
    KeyName = "resourceGuardsName",
    SegmentName = "resourceGuards",
    NamePattern = ""
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Optional ETag.")
  eTag?: string;
}

@armResourceOperations
interface ResourceGuardResources {
  /**
   * Returns a ResourceGuard belonging to a resource group.
   */
  get is ArmResourceRead<Resource = ResourceGuardResource, Error = CloudError>;

  /**
   * Creates or updates a ResourceGuard resource belonging to a resource group.
   */
  put is ArmResourceCreateOrReplaceSync<
    Resource = ResourceGuardResource,
    Error = CloudError
  >;

  /**
   * Updates a ResourceGuard resource belonging to a resource group. For example, updating tags for a resource.
   */
  @patch(#{ implicitOptionality: false })
  patch is ArmCustomPatchSync<
    ResourceGuardResource,
    PatchModel = PatchResourceGuardInput,
    Error = CloudError
  >;

  /**
   * Deletes a ResourceGuard resource from the resource group.
   */
  delete is ArmResourceDeleteSync<
    Resource = ResourceGuardResource,
    Error = CloudError
  >;

  /**
   * Returns ResourceGuards collection belonging to a ResourceGroup.
   */
  @list
  getResourcesInResourceGroup is ArmResourceListByParent<
    ResourceGuardResource,
    Response = ArmResponse<ResourceGuardResourceList>,
    Error = CloudError
  >;

  /**
   * Returns ResourceGuards collection belonging to a subscription.
   */
  @list
  getResourcesInSubscription is ArmListBySubscription<
    ResourceGuardResource,
    Response = ArmResponse<ResourceGuardResourceList>,
    Error = CloudError
  >;
}

@@doc(ResourceGuardResource.name, "The name of ResourceGuard");
@@doc(ResourceGuardResource.properties, "ResourceGuardResource properties");
@@doc(ResourceGuardResources.put::parameters.resource,
  "Request body for operation"
);
@@doc(ResourceGuardResources.patch::parameters.properties,
  "Request body for operation"
);
