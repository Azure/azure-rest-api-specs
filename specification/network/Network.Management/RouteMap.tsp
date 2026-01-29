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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
@parentResource(VirtualHub)
@Http.Private.includeInapplicableMetadataInPayload(false)
model RouteMap extends ReadOnlySubResourceModel {
  properties?: RouteMapProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("routeMapName")
  @segment("routeMaps")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface RouteMaps {
  /**
   * Retrieves the details of a RouteMap.
   */
  get is ArmResourceRead<RouteMap, Error = CloudError>;

  /**
   * Creates a RouteMap if it doesn't exist else updates the existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RouteMap,
    Error = CloudError
  >;

  /**
   * Deletes a RouteMap.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    RouteMap,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Retrieves the details of all RouteMaps.
   */
  list is ArmResourceListByParent<
    RouteMap,
    Response = ArmResponse<ListRouteMapsResult>,
    Error = CloudError
  >;
}

@@doc(RouteMap.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(RouteMap.properties, "Properties of the RouteMap resource.");
@@doc(RouteMaps.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update a RouteMap."
);
