import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GatewayResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Spring Cloud Gateway route config resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(GatewayResource)
@includeInapplicableMetadataInPayload(false)
model GatewayRouteConfigResource extends ProxyResource {
  /**
   * The name of the Spring Cloud Gateway route config.
   */
  @path
  @key("routeConfigName")
  @segment("routeConfigs")
  @visibility("read")
  name: string;

  /**
   * API route config of the Spring Cloud Gateway
   */
  @extension("x-ms-client-flatten", true)
  properties?: GatewayRouteConfigProperties;
}

@armResourceOperations
interface GatewayRouteConfigResources {
  /**
   * Get the Spring Cloud Gateway route configs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GatewayRouteConfigs_Get")
  get is ArmResourceRead<GatewayRouteConfigResource>;

  /**
   * Create the default Spring Cloud Gateway route configs or update the existing Spring Cloud Gateway route configs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GatewayRouteConfigs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<GatewayRouteConfigResource>;

  /**
   * Delete the Spring Cloud Gateway route config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GatewayRouteConfigs_Delete")
  delete is ArmResourceDeleteAsync<GatewayRouteConfigResource>;

  /**
   * Handle requests to list all Spring Cloud Gateway route configs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GatewayRouteConfigs_List")
  list is ArmResourceListByParent<GatewayRouteConfigResource>;
}

@@projectedName(GatewayRouteConfigResources.createOrUpdate::parameters.resource,
  "json",
  "gatewayRouteConfigResource"
);
@@extension(GatewayRouteConfigResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "gatewayRouteConfigResource"
);
@@doc(GatewayRouteConfigResources.createOrUpdate::parameters.resource,
  "The Spring Cloud Gateway route config for the create or update operation"
);
