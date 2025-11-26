import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualHub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * RouteTable resource in a virtual hub.
 */
@parentResource(VirtualHub)
model HubRouteTable
  is Azure.ResourceManager.ProxyResource<HubRouteTableProperties> {
  ...ResourceNameParameter<
    Resource = HubRouteTable,
    KeyName = "routeTableName",
    SegmentName = "hubRouteTables",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface HubRouteTables {
  /**
   * Retrieves the details of a RouteTable.
   */
  get is ArmResourceRead<HubRouteTable, Error = CloudError>;

  /**
   * Creates a RouteTable resource if it doesn't exist else updates the existing RouteTable.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    HubRouteTable,
    Error = CloudError
  >;

  /**
   * Deletes a RouteTable.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    HubRouteTable,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Retrieves the details of all RouteTables.
   */
  list is ArmResourceListByParent<
    HubRouteTable,
    Response = ArmResponse<ListHubRouteTablesResult>,
    Error = CloudError
  >;
}

@@doc(HubRouteTable.name, "The name of the RouteTable.");
@@doc(HubRouteTable.properties, "Properties of the RouteTable resource.");
@@doc(HubRouteTables.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update RouteTable."
);
