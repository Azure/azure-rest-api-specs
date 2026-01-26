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
 * ExpressRouteCircuit resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ExpressRouteCircuit extends Resource {
  properties?: ExpressRouteCircuitPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("circuitName")
  @segment("expressRouteCircuits")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ExpressRouteCircuitSku;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations
interface ExpressRouteCircuits {
  /**
   * Gets information about the specified express route circuit.
   */
  get is ArmResourceRead<ExpressRouteCircuit, Error = CloudError>;

  /**
   * Creates or updates an express route circuit.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExpressRouteCircuit,
    Error = CloudError
  >;

  /**
   * Updates an express route circuit tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ExpressRouteCircuit,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified express route circuit.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRouteCircuit,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the express route circuits in a resource group.
   */
  list is ArmResourceListByParent<ExpressRouteCircuit, Error = CloudError>;

  /**
   * Gets all the express route circuits in a subscription.
   */
  listAll is ArmListBySubscription<ExpressRouteCircuit, Error = CloudError>;

  /**
   * Gets all the stats from an express route circuit in a resource group.
   */
  @get
  @action("stats")
  getStats is ArmResourceActionSync<
    ExpressRouteCircuit,
    void,
    ArmResponse<ExpressRouteCircuitStats>,
    Error = CloudError
  >;
}

@@doc(ExpressRouteCircuit.name, "The name of express route circuit.");
@@doc(ExpressRouteCircuit.properties,
  "Properties of the express route circuit."
);
@@doc(ExpressRouteCircuits.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update express route circuit operation."
);
@@doc(ExpressRouteCircuits.updateTags::parameters.properties,
  "Parameters supplied to update express route circuit tags."
);
