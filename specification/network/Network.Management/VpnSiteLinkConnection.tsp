import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VpnGateway.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * VpnSiteLinkConnection Resource.
 */
@parentResource(VpnGateway)
model VpnSiteLinkConnection
  is Azure.ResourceManager.ProxyResource<VpnSiteLinkConnectionProperties> {
  ...ResourceNameParameter<
    Resource = VpnSiteLinkConnection,
    KeyName = "linkConnectionName",
    SegmentName = "vpnLinkConnections",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias VpnSiteLinkConnectionsOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
  },
  {
    /** The name of the vpn link connection. */
    @path
    @segment("vpnLinkConnections")
    @key
    linkConnectionName: string;
  }
>;

@armResourceOperations
interface VpnSiteLinkConnections {
  /**
   * Retrieves the details of a vpn site link connection.
   */
  get is VpnSiteLinkConnectionsOps.Read<
    VpnSiteLinkConnection,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieves all vpn site link connections for a particular virtual wan vpn gateway vpn connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnLinkConnections_ListByVpnConnection")
  listByVpnConnection is ArmResourceListByParent<
    VpnSiteLinkConnection,
    Parameters = {
      /** The name of the vpn connection. */
      @path
      @segment("vpnConnections")
      @key
      connectionName: string;
    },
    Response = ArmResponse<ListVpnSiteLinkConnectionsResult>,
    Error = CloudError
  >;

  /**
   * Resets the VpnLink connection specified.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnLinkConnections_ResetConnection")
  @action("resetconnection")
  resetConnection is VpnSiteLinkConnectionsOps.ActionAsync<
    VpnSiteLinkConnection,
    Request = void,
    Result = ArmAcceptedLroResponse,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Lists IKE Security Associations for Vpn Site Link Connection in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnLinkConnections_GetIkeSas")
  @action("getikesas")
  getIkeSas is VpnSiteLinkConnectionsOps.ActionAsync<
    VpnSiteLinkConnection,
    void,
    ArmResponse<stringApplicationJson>,
    OverrideErrorType = CloudError
  >;
}

@@doc(VpnSiteLinkConnection.name, "The name of the vpn connection.");
@@doc(VpnSiteLinkConnection.properties,
  "Properties of the VPN site link connection."
);
