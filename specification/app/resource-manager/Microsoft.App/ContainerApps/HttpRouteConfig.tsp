import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ManagedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.App;

/**
 * A set of host names and http request routing rules for a Container App Environment
 */
@parentResource(ManagedEnvironment)
model HttpRouteConfig
  is Azure.ResourceManager.ProxyResource<HttpRouteConfigProperties> {
  ...ResourceNameParameter<
    Resource = HttpRouteConfig,
    KeyName = "httpRouteName",
    SegmentName = "httpRouteConfigs",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;
}

alias HttpRouteConfigOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the managed environment. */
    @path
    @segment("managedEnvironments")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    environmentName: string;
  },
  {
    /** Name of the Http Route Config. */
    @path
    @segment("httpRouteConfigs")
    @key
    @pattern("^[a-z][a-z0-9]*$")
    @minLength(3)
    @maxLength(63)
    httpRouteName: string;
  },
  ErrorType = DefaultErrorResponse
>;

@armResourceOperations
@tag("HttpRouteConfig")
interface HttpRouteConfigs {
  /**
   * Get the specified Managed Http Route Config.
   */
  @summary("Get the specified Http Route Config.")
  get is HttpRouteConfigOps.Read<HttpRouteConfig>;

  /**
   * Create or Update a Http Route Config.
   */
  @summary("Create or Update a Http Route Config.")
  createOrUpdate is HttpRouteConfigOps.CreateOrUpdateSync<
    HttpRouteConfig,
    OptionalRequestBody = true
  >;

  /**
   * Patches an http route config resource. Only patching of tags is supported
   */
  @patch(#{ implicitOptionality: false })
  @summary("Update tags of a Http Route Config object")
  update is ArmCustomPatchSync<
    HttpRouteConfig,
    PatchModel = HttpRouteConfig,
    Error = DefaultErrorResponse
  >;

  /**
   * Deletes the specified Managed Http Route.
   */
  @summary("Deletes the specified Http Route Config.")
  delete is ArmResourceDeleteWithoutOkAsync<HttpRouteConfig>;

  /**
   * Get the Managed Http Routes in a given managed environment.
   */
  @summary("List the Http Route Configs in a given managed environment.")
  list is HttpRouteConfigOps.List<
    HttpRouteConfig,
    Response = ArmResponse<HttpRouteConfigCollection>
  >;
}

@@maxLength(HttpRouteConfig.name, 63);
@@minLength(HttpRouteConfig.name, 3);
@@doc(HttpRouteConfig.name, "Name of the Http Route Config Resource.");
@@doc(HttpRouteConfig.properties, "Http Route Config properties");
@@doc(
  HttpRouteConfigs.createOrUpdate::parameters.resource,
  "Http Route config to be created or updated"
);
@@doc(
  HttpRouteConfigs.update::parameters.properties,
  "Properties of http route config that need to be updated"
);
