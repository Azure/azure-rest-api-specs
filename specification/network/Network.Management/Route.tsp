import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RouteTable.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Route resource.
 */
@parentResource(RouteTable)
model Route is Azure.ResourceManager.ProxyResource<RoutePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = Route,
    KeyName = "routeName",
    SegmentName = "routes",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface Routes {
  /**
   * Gets the specified route from a route table.
   */
  get is ArmResourceRead<Route>;

  /**
   * Creates or updates a route in the specified route table.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Route>;

  /**
   * Deletes the specified route from a route table.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Route,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all routes in a route table.
   */
  list is ArmResourceListByParent<Route>;
}

@@doc(Route.name, "The name of the route.");
@@doc(Route.properties, "Properties of the route.");
@@doc(Routes.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update route operation."
);
