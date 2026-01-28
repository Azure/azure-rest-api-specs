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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(VirtualHub)
@Http.Private.includeInapplicableMetadataInPayload(false)
model HubRouteTable extends SubResourceModel {
  properties?: HubRouteTableProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("routeTableName")
  @segment("hubRouteTables")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
@@doc(HubRouteTable.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(HubRouteTable.properties, "Properties of the RouteTable resource.");
@@doc(HubRouteTables.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update RouteTable."
);
