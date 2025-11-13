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
model RouteTable
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<RouteTablePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = RouteTable,
    KeyName = "routeTableName",
    SegmentName = "routeTables",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

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
    }
  >;

  /**
   * Create or updates a route table in a specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<RouteTable>;

  /**
   * Updates a route table tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<RouteTable, PatchModel = TagsObject>;

  /**
   * Deletes the specified route table.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    RouteTable,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all route tables in a resource group.
   */
  list is ArmResourceListByParent<RouteTable>;

  /**
   * Gets all route tables in a subscription.
   */
  listAll is ArmListBySubscription<RouteTable>;
}

@@doc(RouteTable.name, "The name of the route table.");
@@doc(RouteTable.properties, "Properties of the route table.");
@@doc(RouteTables.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update route table operation."
);
@@doc(RouteTables.updateTags::parameters.properties,
  "Parameters supplied to update route table tags."
);
