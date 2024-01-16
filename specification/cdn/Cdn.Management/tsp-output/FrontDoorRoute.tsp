import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AFDEndpoint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
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
  create is ArmResourceCreateOrUpdateAsync<
    FrontDoorRoute,
    BaseParameters<FrontDoorRoute>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates an existing route with the specified route name under the specified subscription, resource group, profile, and AzureFrontDoor endpoint.")
  update is ArmCustomPatchAsync<
    FrontDoorRoute,
    RouteUpdateParameters,
    BaseParameters<FrontDoorRoute>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes an existing route with the specified route name under the specified subscription, resource group, profile, and AzureFrontDoor endpoint.")
  delete is ArmResourceDeleteAsync<
    FrontDoorRoute,
    BaseParameters<FrontDoorRoute>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists all of the existing origins within a profile.")
  listByEndpoint is ArmResourceListByParent<FrontDoorRoute>;
}

@@projectedName(FrontDoorRoutes.create::parameters.resource, "json", "route");
@@extension(FrontDoorRoutes.create::parameters.resource,
  "x-ms-client-name",
  "route"
);
@@doc(FrontDoorRoutes.create::parameters.resource, "Route properties");
@@projectedName(FrontDoorRoutes.update::parameters.properties,
  "json",
  "routeUpdateProperties"
);
@@extension(FrontDoorRoutes.update::parameters.properties,
  "x-ms-client-name",
  "routeUpdateProperties"
);
@@doc(FrontDoorRoutes.update::parameters.properties, "Route update properties");
