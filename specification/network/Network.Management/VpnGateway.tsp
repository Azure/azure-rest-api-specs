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
 * VpnGateway Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
@Http.Private.includeInapplicableMetadataInPayload(false)
model VpnGateway extends ResourceWithRequiredLocation {
  properties?: VpnGatewayProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("gatewayName")
  @segment("vpnGateways")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias VpnConnectionOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the vpn gateway. */
    @path
    @segment("vpnGateways")
    @key
    gatewayName: string;
  },
  {
    /** The name of the vpn connection. */
    @path
    @segment("vpnConnections")
    @key
    connectionName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}",
  }
>;

alias VpnConnection2Ops = Azure.ResourceManager.Legacy.LegacyOperations<
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
  },
  {
    /** The name of the vpn connection. */
    @path
    @segment("vpnConnections")
    @key
    vpnConnectionName: string;
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface VpnGateways {
  /**
   * Retrieves the details of a virtual wan vpn gateway.
   */
  @autoRoute
  get is ArmResourceRead<VpnGateway, Error = CloudError>;

  /**
   * Creates a virtual wan vpn gateway if it doesn't exist else updates the existing gateway.
   */
  @autoRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VpnGateway,
    Error = CloudError
  >;

  /**
   * Updates virtual wan vpn gateway tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<
    VpnGateway,
    PatchModel = TagsObject,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = VpnGateway> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Deletes a virtual wan vpn gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    VpnGateway,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all the VpnGateways in a resource group.
   */
  @autoRoute
  listByResourceGroup is ArmResourceListByParent<
    VpnGateway,
    Response = ArmResponse<ListVpnGatewaysResult>,
    Error = CloudError
  >;

  /**
   * Lists all the VpnGateways in a subscription.
   */
  @autoRoute
  list is ArmListBySubscription<
    VpnGateway,
    Response = ArmResponse<ListVpnGatewaysResult>,
    Error = CloudError
  >;

  /**
   * Resets the primary of the vpn gateway in the specified resource group.
   */
  @autoRoute
  reset is ArmResourceActionAsync<
    VpnGateway,
    void,
    VpnGateway,
    Parameters = {
      /**
       * VpnGateway ipConfigurationId to specify the gateway instance.
       */
      @query("ipConfigurationId")
      ipConfigurationId?: string;
    },
    Error = CloudError
  >;

  /**
   * Starts packet capture on vpn gateway in the specified resource group.
   */
  @action("startpacketcapture")
  @autoRoute
  startPacketCapture is ArmResourceActionAsync<
    VpnGateway,
    VpnGatewayPacketCaptureStartParameters,
    {
      @body body: stringApplicationJson;
    },
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Stops packet capture on vpn gateway in the specified resource group.
   */
  @action("stoppacketcapture")
  @autoRoute
  stopPacketCapture is ArmResourceActionAsync<
    VpnGateway,
    VpnGatewayPacketCaptureStopParameters,
    {
      @body body: stringApplicationJson;
    },
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Retrieves the details of a vpn connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VpnConnections_Get")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}")
  vpnConnectionsGet is VpnConnectionOps.ActionSync<
    VpnGateway,
    void,
    Response = ArmResponse<VpnConnection>,
    OverrideErrorType = CloudError
  >;

  /**
   * Creates a vpn connection to a scalable vpn gateway if it doesn't exist else updates the existing connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VpnConnections_CreateOrUpdate")
  @put
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}")
  vpnConnectionsCreateOrUpdate is VpnConnectionOps.ActionAsync<
    VpnGateway,
    VpnConnection,
    void,
    Response = ArmResponse<VpnConnection> | ArmResourceCreatedResponse<
      VpnConnection,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = VpnConnection> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes a vpn connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VpnConnections_Delete")
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}")
  vpnConnectionsDelete is VpnConnectionOps.ActionAsync<
    VpnGateway,
    void,
    void,
    Response = {
      @body body: void;
    } | ArmAcceptedLroResponse | NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Starts packet capture on Vpn connection in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VpnConnections_StartPacketCapture")
  @action("startpacketcapture")
  @autoRoute
  vpnConnectionsStartPacketCapture is VpnConnection2Ops.ActionAsync<
    VpnGateway,
    VpnConnectionPacketCaptureStartParameters,
    {
      @body body: stringApplicationJson;
    },
    OptionalRequestBody = true,
    OverrideErrorType = CloudError
  >;

  /**
   * Stops packet capture on Vpn connection in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VpnConnections_StopPacketCapture")
  @action("stoppacketcapture")
  @autoRoute
  vpnConnectionsStopPacketCapture is VpnConnection2Ops.ActionAsync<
    VpnGateway,
    VpnConnectionPacketCaptureStopParameters,
    {
      @body body: stringApplicationJson;
    },
    OptionalRequestBody = true,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieves all vpn connections for a particular virtual wan vpn gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VpnConnections_ListByVpnGateway")
  @list
  @get
  @action("vpnConnections")
  @autoRoute
  listByVpnGateway is ArmResourceActionSync<
    VpnGateway,
    void,
    ArmResponse<ListVpnConnectionsResult>,
    Error = CloudError
  >;
}

@@doc(VpnGateway.name, "The name of the gateway.");
@@doc(VpnGateway.properties, "Properties of the VPN gateway.");
@@doc(VpnGateways.createOrUpdate::parameters.resource,
  "Parameters supplied to create or Update a virtual wan vpn gateway."
);
@@doc(VpnGateways.updateTags::parameters.properties,
  "Parameters supplied to update a virtual wan vpn gateway tags."
);
@@doc(VpnGateways.startPacketCapture::parameters.body,
  "Vpn gateway packet capture parameters supplied to start packet capture on vpn gateway."
);
@@doc(VpnGateways.stopPacketCapture::parameters.body,
  "Vpn gateway packet capture parameters supplied to stop packet capture on vpn gateway."
);
@@doc(VpnGateways.vpnConnectionsCreateOrUpdate::parameters.body,
  "Parameters supplied to create or Update a VPN Connection."
);
@@doc(VpnGateways.vpnConnectionsStartPacketCapture::parameters.body,
  "Vpn Connection packet capture parameters supplied to start packet capture on gateway connection."
);
@@doc(VpnGateways.vpnConnectionsStopPacketCapture::parameters.body,
  "Vpn Connection packet capture parameters supplied to stop packet capture on gateway connection."
);
