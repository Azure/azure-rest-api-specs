import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

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
}

@armResourceOperations
interface ResourceGuardResources {
  /**
   * Returns a ResourceGuard belonging to a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_Get")
  get is ArmResourceRead<Resource = ResourceGuardResource, Error = CloudError>;

  /**
   * Creates or updates a ResourceGuard resource belonging to a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_Put")
  put is ArmResourceCreateOrReplaceSync<
    Resource = ResourceGuardResource,
    Error = CloudError
  >;

  /**
   * Updates a ResourceGuard resource belonging to a resource group. For example, updating tags for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("ResourceGuards_Patch")
  patch is ArmCustomPatchSync<
    ResourceGuardResource,
    PatchModel = PatchResourceGuardInput,
    Error = CloudError
  >;

  /**
   * Deletes a ResourceGuard resource from the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_Delete")
  delete is ArmResourceDeleteSync<
    Resource = ResourceGuardResource,
    Error = CloudError
  >;

  /**
   * Returns ResourceGuards collection belonging to a ResourceGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetResourcesInResourceGroup")
  @list
  getResourcesInResourceGroup is ArmResourceListByParent<
    ResourceGuardResource,
    Response = ArmResponse<ResourceGuardResourceList>,
    Error = CloudError
  >;

  /**
   * Returns ResourceGuards collection belonging to a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetResourcesInSubscription")
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
