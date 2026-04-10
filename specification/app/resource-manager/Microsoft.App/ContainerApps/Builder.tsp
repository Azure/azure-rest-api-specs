import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Information about the SourceToCloud builder resource.
 */
model BuilderResource
  is Azure.ResourceManager.TrackedResource<BuilderProperties> {
  ...ResourceNameParameter<
    Resource = BuilderResource,
    KeyName = "builderName",
    SegmentName = "builders",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Builders {
  /**
   * Get a BuilderResource
   */
  get is ArmResourceRead<BuilderResource>;

  /**
   * Create or update a BuilderResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BuilderResource>;

  /**
   * Update a BuilderResource
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    BuilderResource,
    PatchModel = BuilderResourceUpdate
  >;

  /**
   * Delete a BuilderResource
   */
  delete is ArmResourceDeleteWithoutOkAsync<BuilderResource>;

  /**
   * List BuilderResource resources by resource group
   */
  listByResourceGroup is ArmResourceListByParent<
    BuilderResource,
    Response = ArmResponse<BuilderCollection>
  >;

  /**
   * List BuilderResource resources by subscription ID
   */
  listBySubscription is ArmListBySubscription<
    BuilderResource,
    Response = ArmResponse<BuilderCollection>
  >;
}

@@maxLength(BuilderResource.name, 32);
@@minLength(BuilderResource.name, 2);
@@doc(BuilderResource.name, "The name of the builder.");
@@doc(BuilderResource.properties,
  "The resource-specific properties for this resource."
);
