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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@parentResource(RouteTable)
@Http.Private.includeInapplicableMetadataInPayload(false)
model Route extends SubResourceModel {
  properties?: RoutePropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("routeName")
  @segment("routes")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@@doc(Route.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(Route.type, "Resource type.");

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
