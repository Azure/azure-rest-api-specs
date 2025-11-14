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

@armResourceOperations
interface VpnSiteLinkConnections {
  /**
   * Retrieves the details of a vpn site link connection.
   */
  get is ArmResourceRead<VpnSiteLinkConnection>;

  /**
   * Retrieves all vpn site link connections for a particular virtual wan vpn gateway vpn connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnLinkConnections_ListByVpnConnection")
  listByVpnConnection is ArmResourceListByParent<
    VpnSiteLinkConnection,
    Response = ArmResponse<ListVpnSiteLinkConnectionsResult>
  >;

  /**
   * Resets the VpnLink connection specified.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnLinkConnections_ResetConnection")
  @action("resetconnection")
  resetConnection is ArmResourceActionAsyncBase<
    VpnSiteLinkConnection,
    Request = void,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VpnSiteLinkConnection>
  >;

  /**
   * Lists IKE Security Associations for Vpn Site Link Connection in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnLinkConnections_GetIkeSas")
  @action("getikesas")
  getIkeSas is ArmResourceActionAsync<
    VpnSiteLinkConnection,
    void,
    ArmResponse<string>
  >;
}

@@doc(VpnSiteLinkConnection.name, "The name of the vpn connection.");
@@doc(VpnSiteLinkConnection.properties,
  "Properties of the VPN site link connection."
);
