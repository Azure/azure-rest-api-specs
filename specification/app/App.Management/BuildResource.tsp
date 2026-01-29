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

namespace Microsoft.App;
/**
 * Information pertaining to an individual build.
 */
@parentResource(BuilderResource)
model BuildResource is Azure.ResourceManager.ProxyResource<BuildProperties> {
  ...ResourceNameParameter<
    Resource = BuildResource,
    KeyName = "buildName",
    SegmentName = "builds",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface BuildResources {
  /**
   * Get a BuildResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Builds_Get")
  get is ArmResourceRead<BuildResource>;

  /**
   * Create a BuildResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Builds_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BuildResource>;

  /**
   * Delete a BuildResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Builds_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<BuildResource>;

  /**
   * List BuildResource resources by BuilderResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildsByBuilderResource_List")
  list is ArmResourceListByParent<
    BuildResource,
    Response = ArmResponse<BuildCollection>
  >;

  /**
   * Gets the token used to connect to the endpoint where source code can be uploaded for a build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildAuthToken_List")
  @action("listAuthToken")
  buildAuthTokenList is ArmResourceActionSync<
    BuildResource,
    void,
    ArmResponse<BuildToken>
  >;
}

@@maxLength(BuildResource.name, 64);
@@minLength(BuildResource.name, 2);
@@doc(BuildResource.name, "The name of a build.");
@@doc(BuildResource.properties,
  "The resource-specific properties for this resource."
);
@@doc(BuildResources.createOrUpdate::parameters.resource,
  "Resource create or update parameters."
);
