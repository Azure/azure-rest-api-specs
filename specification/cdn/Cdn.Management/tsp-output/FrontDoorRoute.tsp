import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AFDEndpoint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Cdn;
@doc("Friendly Routes name mapping to the any Routes or secret related information.")
@parentResource(AFDEndpoint)
model FrontDoorRoute is ProxyResource<RouteProperties> {
  @doc("Name of the routing rule.")
  @path
  @key("routeName")
  @segment("routes")
  name: string;
}

@armResourceOperations
interface FrontDoorRoutes {
  @doc("Gets an existing route with the specified route name under the specified subscription, resource group, profile, and AzureFrontDoor endpoint.")
  get is ArmResourceRead<FrontDoorRoute>;
  @doc("Creates a new route with the specified route name under the specified subscription, resource group, profile, and AzureFrontDoor endpoint.")
  create is ArmResourceCreateOrUpdateAsync<FrontDoorRoute>;
  @doc("Updates an existing route with the specified route name under the specified subscription, resource group, profile, and AzureFrontDoor endpoint.")
  update is ArmResourcePatchAsync<FrontDoorRoute, RouteProperties>;
  @doc("Deletes an existing route with the specified route name under the specified subscription, resource group, profile, and AzureFrontDoor endpoint.")
  delete is ArmResourceDeleteAsync<FrontDoorRoute>;
  @doc("Lists all of the existing origins within a profile.")
  listByEndpoint is ArmResourceListByParent<FrontDoorRoute>;
}
