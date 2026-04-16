import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Builder.tsp";

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
interface Builds {
  /**
   * Get a BuildResource
   */
  get is ArmResourceRead<BuildResource>;

  /**
   * Create a BuildResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BuildResource>;

  /**
   * Delete a BuildResource
   */
  delete is ArmResourceDeleteWithoutOkAsync<BuildResource>;

  /**
   * List BuildResource resources by BuilderResource
   */
  list is ArmResourceListByParent<
    BuildResource,
    Response = ArmResponse<BuildCollection>
  >;

  /**
   * Gets the token used to connect to the endpoint where source code can be uploaded for a build.
   */
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
@@doc(Builds.createOrUpdate::parameters.resource,
  "Resource create or update parameters."
);
