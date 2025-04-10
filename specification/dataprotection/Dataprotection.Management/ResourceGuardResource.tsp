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
  get is ArmResourceRead<ResourceGuardResource>;

  /**
   * Creates or updates a ResourceGuard resource belonging to a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_Put")
  put is ArmResourceCreateOrReplaceSync<ResourceGuardResource>;

  /**
   * Updates a ResourceGuard resource belonging to a resource group. For example, updating tags for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("ResourceGuards_Patch")
  patch is ArmCustomPatchSync<
    ResourceGuardResource,
    PatchModel = PatchResourceGuardInput
  >;

  /**
   * Deletes a ResourceGuard resource from the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_Delete")
  delete is ArmResourceDeleteSync<ResourceGuardResource>;

  /**
   * Returns ResourceGuards collection belonging to a ResourceGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetResourcesInResourceGroup")
  getResourcesInResourceGroup is ArmResourceListByParent<
    ResourceGuardResource,
    Response = ArmResponse<ResourceGuardResourceList>
  >;

  /**
   * Returns ResourceGuards collection belonging to a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetResourcesInSubscription")
  getResourcesInSubscription is ArmListBySubscription<
    ResourceGuardResource,
    Response = ArmResponse<ResourceGuardResourceList>
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
