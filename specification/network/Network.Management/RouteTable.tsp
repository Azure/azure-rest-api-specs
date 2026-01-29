import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Route table resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model RouteTable extends Resource {
  properties?: RouteTablePropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("routeTableName")
  @segment("routeTables")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface RouteTables {
  /**
   * Gets the specified route table.
   */
  get is ArmResourceRead<
    RouteTable,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
  >;

  /**
   * Create or updates a route table in a specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RouteTable,
    Error = CloudError
  >;

  /**
   * Updates a route table tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    RouteTable,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified route table.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    RouteTable,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all route tables in a resource group.
   */
  list is ArmResourceListByParent<RouteTable, Error = CloudError>;

  /**
   * Gets all route tables in a subscription.
   */
  listAll is ArmListBySubscription<RouteTable, Error = CloudError>;
}

@@doc(RouteTable.name, "The name of the route table.");
@@doc(RouteTable.properties, "Properties of the route table.");
@@doc(RouteTables.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update route table operation."
);
@@doc(RouteTables.updateTags::parameters.properties,
  "Parameters supplied to update route table tags."
);
