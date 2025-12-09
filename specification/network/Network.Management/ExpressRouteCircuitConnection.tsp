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
@parentResource(ExpressRouteCircuitPeering)
model ExpressRouteCircuitConnection
  is Azure.ResourceManager.ProxyResource<ExpressRouteCircuitConnectionPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ExpressRouteCircuitConnection,
    KeyName = "connectionName",
    SegmentName = "connections",
    NamePattern = ""
  >;

  /** A unique read-only string that changes whenever the resource is updated. */
  @visibility(Lifecycle.Read)
  etag?: string;
}

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
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
