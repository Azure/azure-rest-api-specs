import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformGateway.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Spring Cloud Gateway route config resource")
@parentResource(AppPlatformGateway)
model AppPlatformGatewayRouteConfig
  is ProxyResource<GatewayRouteConfigProperties> {
  @doc("The name of the Spring Cloud Gateway route config.")
  @path
  @key("routeConfigName")
  @segment("routeConfigs")
  name: string;
}

@armResourceOperations
interface AppPlatformGatewayRouteConfigs {
  @doc("Get the Spring Cloud Gateway route configs.")
  get is ArmResourceRead<AppPlatformGatewayRouteConfig>;
  @doc("Create the default Spring Cloud Gateway route configs or update the existing Spring Cloud Gateway route configs.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppPlatformGatewayRouteConfig>;
  @doc("Delete the Spring Cloud Gateway route config.")
  delete is ArmResourceDeleteAsync<AppPlatformGatewayRouteConfig>;
  @doc("Handle requests to list all Spring Cloud Gateway route configs.")
  list is ArmResourceListByParent<AppPlatformGatewayRouteConfig>;
}
