import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./GatewayResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppPlatform;
@doc("Spring Cloud Gateway route config resource")
@parentResource(GatewayResource)
model GatewayRouteConfigResource
  is ProxyResource<GatewayRouteConfigProperties> {
  @doc("The name of the Spring Cloud Gateway route config.")
  @key("routeConfigName")
  @segment("routeConfigs")
  name: string;
}

@armResourceOperations
@projectedName("client", "GatewayRouteConfigs")
interface GatewayRouteConfigResources_GatewayRouteConfigs {
  @doc("Get the Spring Cloud Gateway route configs.")
  get is ArmResourceRead<GatewayRouteConfigResource>;

  @doc("Create the default Spring Cloud Gateway route configs or update the existing Spring Cloud Gateway route configs.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GatewayRouteConfigResource>;

  @doc("Delete the Spring Cloud Gateway route config.")
  delete is ArmResourceDeleteAsync<GatewayRouteConfigResource>;

  @doc("Handle requests to list all Spring Cloud Gateway route configs.")
  list is ArmResourceListByParent<GatewayRouteConfigResource>;
}
