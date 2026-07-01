import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ExpressRouteCircuitPeering.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Network;
/**
 * Peer Express Route Circuit Connection in an ExpressRouteCircuitPeering resource.
 */
@featureFile(Features.expressRoute)
@parentResource(ExpressRouteCircuitPeering)
model PeerExpressRouteCircuitConnection
  is SubResourceInstance<PeerExpressRouteCircuitConnectionPropertiesFormat> {
  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("connectionName")
  @segment("peerConnections")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@featureFile(Features.expressRoute)
@armResourceOperations
interface PeerExpressRouteCircuitConnections {
  /**
   * Gets the specified Peer Express Route Circuit Connection from the specified express route circuit.
   */
  get is ArmResourceRead<PeerExpressRouteCircuitConnection, Error = CloudError>;

  /**
   * Gets all global reach peer connections associated with a private peering in an express route circuit.
   */
  list is ArmResourceListByParent<
    PeerExpressRouteCircuitConnection,
    Error = CloudError
  >;
}

@@doc(
  PeerExpressRouteCircuitConnection.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(
  PeerExpressRouteCircuitConnection.properties,
  "Properties of the peer express route circuit connection."
);
