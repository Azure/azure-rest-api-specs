namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface GlobalReachConnections {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("GlobalReachConnections_List")
  list is ArmResourceListByParent<
    GlobalReachConnection,
    Response = ArmResponse<ResourceList<GlobalReachConnection>>
  >;

  get is ArmResourceRead<GlobalReachConnection>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    GlobalReachConnection,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<GlobalReachConnection>;
}

@@clientName(GlobalReachConnections.createOrUpdate::parameters.resource,
  "globalReachConnection"
);

@doc("Global Reach Connection provisioning state")
union GlobalReachConnectionProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is updating")
  Updating: "Updating",
}

@doc("Global Reach Connection status")
union GlobalReachConnectionStatus {
  string,

  @doc("is connected")
  Connected: "Connected",

  @doc("is connecting")
  Connecting: "Connecting",

  @doc("is disconnected")
  Disconnected: "Disconnected",
}

@doc("A global reach connection resource")
@parentResource(PrivateCloud)
model GlobalReachConnection is ProxyResource<GlobalReachConnectionProperties> {
  @doc("Name of the global reach connection")
  @pattern("^[-\\w\\._]+$")
  @key("globalReachConnectionName")
  @path
  @segment("globalReachConnections")
  name: string;
}

@doc("The properties of a global reach connection")
model GlobalReachConnectionProperties {
  @doc("The state of the  ExpressRoute Circuit Authorization provisioning")
  @visibility("read")
  provisioningState?: GlobalReachConnectionProvisioningState;

  @doc("""
    The network used for global reach carved out from the original network block
    provided for the private cloud
    """)
  @visibility("read")
  addressPrefix?: string;

  @doc("""
    Authorization key from the peer express route used for the global reach
    connection
    """)
  authorizationKey?: string;

  @doc("The connection status of the global reach connection")
  @visibility("read")
  circuitConnectionStatus?: GlobalReachConnectionStatus;

  @doc("""
    Identifier of the ExpressRoute Circuit to peer with in the global reach
    connection
    """)
  peerExpressRouteCircuit?: string;

  @doc("""
    The ID of the Private Cloud's ExpressRoute Circuit that is participating in the
    global reach connection
    """)
  expressRouteId?: string;
}
