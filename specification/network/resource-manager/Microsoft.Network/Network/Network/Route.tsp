import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RouteTable.tsp";
import "../Common/Route.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface Routes {
  /**
   * Gets the specified route from a route table.
   */
  get is ArmResourceRead<Route, Error = CloudError>;

  /**
   * Creates or updates a route in the specified route table.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Route, Error = CloudError>;

  /**
   * Deletes the specified route from a route table.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Route,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all routes in a route table.
   */
  list is ArmResourceListByParent<Route, Error = CloudError>;
}

@@doc(Route.name, "The name of the route.");
@@doc(Route.properties, "Properties of the route.");
@@doc(Routes.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update route operation."
);
