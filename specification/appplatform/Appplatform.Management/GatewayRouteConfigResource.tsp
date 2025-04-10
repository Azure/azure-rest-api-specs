import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GatewayResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Spring Cloud Gateway route config resource
 */
@parentResource(GatewayResource)
model GatewayRouteConfigResource
  is Azure.ResourceManager.ProxyResource<GatewayRouteConfigProperties> {
  ...ResourceNameParameter<
    Resource = GatewayRouteConfigResource,
    KeyName = "routeConfigName",
    SegmentName = "routeConfigs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GatewayRouteConfigResources {
  /**
   * Get the Spring Cloud Gateway route configs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GatewayRouteConfigs_Get")
  get is ArmResourceRead<GatewayRouteConfigResource>;

  /**
   * Create the default Spring Cloud Gateway route configs or update the existing Spring Cloud Gateway route configs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GatewayRouteConfigs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GatewayRouteConfigResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the Spring Cloud Gateway route config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("GatewayRouteConfigs_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    GatewayRouteConfigResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handle requests to list all Spring Cloud Gateway route configs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GatewayRouteConfigs_List")
  list is ArmResourceListByParent<
    GatewayRouteConfigResource,
    Response = ArmResponse<GatewayRouteConfigResourceCollection>
  >;
}

@@doc(GatewayRouteConfigResource.name,
  "The name of the Spring Cloud Gateway route config."
);
@@doc(GatewayRouteConfigResource.properties,
  "API route config of the Spring Cloud Gateway"
);
@@doc(GatewayRouteConfigResources.createOrUpdate::parameters.resource,
  "The Spring Cloud Gateway route config for the create or update operation"
);
