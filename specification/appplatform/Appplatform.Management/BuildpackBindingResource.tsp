import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BuilderResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Buildpack Binding Resource object
 */
@parentResource(BuilderResource)
model BuildpackBindingResource
  is Azure.ResourceManager.ProxyResource<BuildpackBindingProperties> {
  ...ResourceNameParameter<
    Resource = BuildpackBindingResource,
    KeyName = "buildpackBindingName",
    SegmentName = "buildpackBindings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BuildpackBindingResources {
  /**
   * Get a buildpack binding by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildpackBinding_Get")
  get is ArmResourceRead<BuildpackBindingResource>;

  /**
   * Create or update a buildpack binding.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildpackBinding_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BuildpackBindingResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Operation to delete a Buildpack Binding
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("BuildpackBinding_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    BuildpackBindingResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all buildpack bindings in a builder.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildpackBinding_List")
  list is ArmResourceListByParent<
    BuildpackBindingResource,
    Response = ArmResponse<BuildpackBindingResourceCollection>
  >;
}

@@doc(BuildpackBindingResource.name, "The name of the Buildpack Binding Name");
@@doc(BuildpackBindingResource.properties, "Properties of a buildpack binding");
@@doc(BuildpackBindingResources.createOrUpdate::parameters.resource,
  "The target buildpack binding for the create or update operation"
);
