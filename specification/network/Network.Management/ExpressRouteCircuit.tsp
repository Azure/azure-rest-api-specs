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
model ExpressRouteCircuit
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ExpressRouteCircuitPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ExpressRouteCircuit,
    KeyName = "circuitName",
    SegmentName = "expressRouteCircuits",
    NamePattern = ""
  >;

  /**
   * The SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: ExpressRouteCircuitSku;

  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface ExpressRouteCircuits {
  /**
   * Gets information about the specified express route circuit.
   */
  get is ArmResourceRead<ExpressRouteCircuit, Error = CloudError>;

  /**
   * Creates or updates an express route circuit.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExpressRouteCircuit, Error = CloudError>;

  /**
   * Updates an express route circuit tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<ExpressRouteCircuit,
    PatchModel = TagsObject, Error = CloudError>;

  /**
   * Deletes the specified express route circuit.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<ExpressRouteCircuit,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,  Error = CloudError>;

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
  getStats is ArmResourceActionSync<ExpressRouteCircuit,
    void,
    ArmResponse<ExpressRouteCircuitStats>
  , Error = CloudError>;
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
