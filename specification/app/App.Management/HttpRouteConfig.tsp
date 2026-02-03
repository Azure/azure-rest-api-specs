import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Advanced Ingress routing for path/header based routing for a Container App Environment
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HttpRouteConfig_Get")
  @summary("Get the specified Managed Http Route Config.")
  get is HttpRouteConfigOps.Read<HttpRouteConfig>;

  /**
   * Create or Update a Http Route Config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HttpRouteConfig_CreateOrUpdate")
  @summary("Create or Update a Http Route Config.")
  @summary("Update tags of a manged http route object")
  createOrUpdate is HttpRouteConfigOps.CreateOrUpdateSync<
    HttpRouteConfig,
    OptionalRequestBody = true
  >;

  /**
   * Patches an http route config resource. Only patching of tags is supported
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HttpRouteConfig_Update")
  @patch(#{ implicitOptionality: false })
  @summary("Update tags of a manged http route object")
  update is ArmCustomPatchSync<
    HttpRouteConfig,
    PatchModel = HttpRouteConfig,
    Error = DefaultErrorResponse
  >;

  /**
   * Deletes the specified Managed Http Route.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HttpRouteConfig_Delete")
  @summary("Deletes the specified Managed Http Route.")
  delete is ArmResourceDeleteWithoutOkAsync<HttpRouteConfig>;

  /**
   * Get the Managed Http Routes in a given managed environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HttpRouteConfig_List")
  @summary("Get the Managed Http Routes in a given managed environment.")
  list is HttpRouteConfigOps.List<
    HttpRouteConfig,
    Response = ArmResponse<HttpRouteConfigCollection>
  >;
}

@@maxLength(HttpRouteConfig.name, 63);
@@minLength(HttpRouteConfig.name, 3);
@@doc(HttpRouteConfig.name, "Name of the Http Route Config Resource.");
@@doc(HttpRouteConfig.properties, "Http Route Config properties");
@@doc(HttpRouteConfigs.createOrUpdate::parameters.resource,
  "Http Route config to be created or updated"
);
@@doc(HttpRouteConfigs.update::parameters.properties,
  "Properties of http route config that need to be updated"
);
