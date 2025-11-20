import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VpnSiteLinkConnection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * SharedKey Resource .
 */
@singleton("default")
@parentResource(VpnSiteLinkConnection)
model ConnectionSharedKeyResult
  is Azure.ResourceManager.ProxyResource<SharedKeyProperties> {
  ...ResourceNameParameter<
    Resource = ConnectionSharedKeyResult,
    KeyName = "sharedKey",
    SegmentName = "sharedKeys",
    NamePattern = ""
  >;
}

alias VpnLinkConnectionSharedKeyOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the vpn gateway. */
    @path
    @segment("vpnGateways")
    @key
    gatewayName: string;

    /** The name of the vpn connection. */
    @path
    @segment("vpnConnections")
    @key
    connectionName: string;

    /** The name of the vpn link connection. */
    @path
    @segment("vpnLinkConnections")
    @key
    linkConnectionName: string;
  },
  {
    /** The name of the shared key. */
    @path
    @segment("sharedKeys")
    @key
    sharedKey: "default";
  }
>;

@armResourceOperations
interface ConnectionSharedKeyResults {
  /**
   * Gets the shared key of VpnLink connection specified.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnLinkConnections_GetDefaultSharedKey")
  getDefaultSharedKey is VpnLinkConnectionSharedKeyOps.Read<ConnectionSharedKeyResult>;

  /**
   * Sets or auto generates the shared key based on the user input. If users give a shared key value, it does the set operation. If key length is given, the operation creates a random key of the pre-defined length.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnLinkConnections_SetOrInitDefaultSharedKey")
  setOrInitDefaultSharedKey is VpnLinkConnectionSharedKeyOps.CreateOrUpdateAsync<ConnectionSharedKeyResult>;

  /**
   * Lists all shared keys of VpnLink connection specified.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnLinkConnections_GetAllSharedKeys")
  getAllSharedKeys is VpnLinkConnectionSharedKeyOps.List<
    ConnectionSharedKeyResult,
    Response = ArmResponse<ConnectionSharedKeyResultList>
  >;

  /**
   * Gets the value of the shared key of VpnLink connection specified.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnLinkConnections_ListDefaultSharedKey")
  @action("listSharedKey")
  listDefaultSharedKey is VpnLinkConnectionSharedKeyOps.ActionSync<
    ConnectionSharedKeyResult,
    void,
    ArmResponse<ConnectionSharedKeyResult>
  >;
}

@@doc(ConnectionSharedKeyResult.name, "");
@@doc(ConnectionSharedKeyResult.properties, "Properties of the shared key.");
@@doc(ConnectionSharedKeyResults.setOrInitDefaultSharedKey::parameters.resource,
  "Parameters supplied to set or auto generate the shared key for the vpn link connection."
);
