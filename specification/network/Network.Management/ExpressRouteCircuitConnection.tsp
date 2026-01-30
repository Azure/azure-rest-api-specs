import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ExpressRouteCircuitPeering.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Express Route Circuit Connection in an ExpressRouteCircuitPeering resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@parentResource(ExpressRouteCircuitPeering)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ExpressRouteCircuitConnection extends SubResourceModel {
  properties?: ExpressRouteCircuitConnectionPropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("connectionName")
  @segment("connections")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations
interface ExpressRouteCircuitConnections {
  /**
   * Gets the specified Express Route Circuit Connection from the specified express route circuit.
   */
  get is ArmResourceRead<ExpressRouteCircuitConnection, Error = CloudError>;

  /**
   * Creates or updates a Express Route Circuit Connection in the specified express route circuits.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExpressRouteCircuitConnection,
    Error = CloudError
  >;

  /**
   * Deletes the specified Express Route Circuit Connection from the specified express route circuit.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRouteCircuitConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all global reach connections associated with a private peering in an express route circuit.
   */
  list is ArmResourceListByParent<
    ExpressRouteCircuitConnection,
    Error = CloudError
  >;
}

@@doc(ExpressRouteCircuitConnection.name,
  "The name of the express route circuit connection."
);
@@doc(ExpressRouteCircuitConnection.properties,
  "Properties of the express route circuit connection."
);
@@doc(ExpressRouteCircuitConnections.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update express route circuit connection operation."
);
