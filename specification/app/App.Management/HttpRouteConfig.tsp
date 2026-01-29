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

@armResourceOperations
interface HttpRouteConfigs {
  /**
   * Get the specified Managed Http Route Config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HttpRouteConfig_Get")
  get is ArmResourceRead<HttpRouteConfig>;

  /**
   * Create or Update a Http Route Config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HttpRouteConfig_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<HttpRouteConfig>;

  /**
   * Patches an http route config resource. Only patching of tags is supported
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HttpRouteConfig_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<HttpRouteConfig, PatchModel = HttpRouteConfig>;

  /**
   * Deletes the specified Managed Http Route.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HttpRouteConfig_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<HttpRouteConfig>;

  /**
   * Get the Managed Http Routes in a given managed environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HttpRouteConfig_List")
  list is ArmResourceListByParent<
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
