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
 * Peer Express Route Circuit Connection in an ExpressRouteCircuitPeering resource.
 */
@parentResource(ExpressRouteCircuitPeering)
model PeerExpressRouteCircuitConnection
  is Azure.ResourceManager.ProxyResource<PeerExpressRouteCircuitConnectionPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = PeerExpressRouteCircuitConnection,
    KeyName = "connectionName",
    SegmentName = "peerConnections",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

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

@@doc(PeerExpressRouteCircuitConnection.name,
  "The name of the peer express route circuit connection."
);
@@doc(PeerExpressRouteCircuitConnection.properties,
  "Properties of the peer express route circuit connection."
);
