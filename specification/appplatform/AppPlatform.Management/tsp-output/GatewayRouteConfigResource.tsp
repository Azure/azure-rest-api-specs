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
@doc("Spring Cloud Gateway route config resource")
@parentResource(GatewayResource)
model GatewayRouteConfigResource
  is ProxyResource<GatewayRouteConfigProperties> {
  @doc("The name of the Spring Cloud Gateway route config.")
  @path
  @key("routeConfigName")
  @segment("routeConfigs")
  name: string;
}

@armResourceOperations
interface GatewayRouteConfigResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the Spring Cloud Gateway route configs.")
  @operationId("GatewayRouteConfigs_Get")
  get is ArmResourceRead<GatewayRouteConfigResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create the default Spring Cloud Gateway route configs or update the existing Spring Cloud Gateway route configs.")
  @operationId("GatewayRouteConfigs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GatewayRouteConfigResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the Spring Cloud Gateway route config.")
  @operationId("GatewayRouteConfigs_Delete")
  delete is ArmResourceDeleteAsync<GatewayRouteConfigResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handle requests to list all Spring Cloud Gateway route configs.")
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
