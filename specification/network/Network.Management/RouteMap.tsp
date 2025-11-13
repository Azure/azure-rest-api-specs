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
 * The RouteMap child resource of a Virtual hub.
 */
@parentResource(VirtualHub)
model RouteMap is Azure.ResourceManager.ProxyResource<RouteMapProperties> {
  ...ResourceNameParameter<
    Resource = RouteMap,
    KeyName = "routeMapName",
    SegmentName = "routeMaps",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface RouteMaps {
  /**
   * Retrieves the details of a RouteMap.
   */
  get is ArmResourceRead<RouteMap>;

  /**
   * Creates a RouteMap if it doesn't exist else updates the existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<RouteMap>;

  /**
   * Deletes a RouteMap.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    RouteMap,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves the details of all RouteMaps.
   */
  list is ArmResourceListByParent<
    RouteMap,
    Response = ArmResponse<ListRouteMapsResult>
  >;
}

@@doc(RouteMap.name, "The name of the RouteMap.");
@@doc(RouteMap.properties, "Properties of the RouteMap resource.");
@@doc(RouteMaps.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update a RouteMap."
);
