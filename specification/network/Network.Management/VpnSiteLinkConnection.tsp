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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
@parentResource(VpnGateway)
@Http.Private.includeInapplicableMetadataInPayload(false)
model VpnSiteLinkConnection extends SubResourceModel {
  properties?: VpnSiteLinkConnectionProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("linkConnectionName")
  @segment("vpnLinkConnections")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VpnLinkConnections_ResetConnection")
  @action("resetconnection")
  resetConnection is VpnSiteLinkConnectionsOps.ActionAsync<
    VpnSiteLinkConnection,
    Request = void,
    Result = void,
    Response = ArmAcceptedLroResponse,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Lists IKE Security Associations for Vpn Site Link Connection in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VpnLinkConnections_GetIkeSas")
  @action("getikesas")
  getIkeSas is VpnSiteLinkConnectionsOps.ActionAsync<
    VpnSiteLinkConnection,
    void,
    {
      @body body: stringApplicationJson;
    },
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(VpnSiteLinkConnection.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(VpnSiteLinkConnection.properties,
  "Properties of the VPN site link connection."
);
