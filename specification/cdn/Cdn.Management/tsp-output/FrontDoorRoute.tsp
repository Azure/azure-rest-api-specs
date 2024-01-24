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
/**
 * Friendly Routes name mapping to the any Routes or secret related information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AFDEndpoint)
@Azure.ResourceManager.Private.armResourceInternal(RouteProperties)
@includeInapplicableMetadataInPayload(false)
model FrontDoorRoute extends ProxyResource {
  /**
   * Name of the routing rule.
   */
  @path
  @key("routeName")
  @segment("routes")
  name: string;

  /**
   * The JSON object that contains the properties of the Routes to create.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RouteProperties;
}

@armResourceOperations
interface FrontDoorRoutes {
  /**
   * Gets an existing route with the specified route name under the specified subscription, resource group, profile, and AzureFrontDoor endpoint.
   */
  get is ArmResourceRead<FrontDoorRoute>;

  /**
   * Creates a new route with the specified route name under the specified subscription, resource group, profile, and AzureFrontDoor endpoint.
   */
  create is ArmResourceCreateOrReplaceAsync<
    FrontDoorRoute,
    BaseParameters<FrontDoorRoute>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates an existing route with the specified route name under the specified subscription, resource group, profile, and AzureFrontDoor endpoint.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    FrontDoorRoute,
    RouteUpdateParameters,
    BaseParameters<FrontDoorRoute>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes an existing route with the specified route name under the specified subscription, resource group, profile, and AzureFrontDoor endpoint.
   */
  delete is ArmResourceDeleteAsync<
    FrontDoorRoute,
    BaseParameters<FrontDoorRoute>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists all of the existing origins within a profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorRoutes_ListByEndpoint")
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
