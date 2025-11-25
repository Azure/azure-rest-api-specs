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
model VpnGateway
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<VpnGatewayProperties> {
  ...ResourceNameParameter<
    Resource = VpnGateway,
    KeyName = "gatewayName",
    SegmentName = "vpnGateways",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias VpnConnectionOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    connectionName: string;
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

@armResourceOperations
interface VpnGateways {
  /**
   * Retrieves the details of a virtual wan vpn gateway.
   */
  get is ArmResourceRead<VpnGateway, Error = CloudError>;

  /**
   * Creates a virtual wan vpn gateway if it doesn't exist else updates the existing gateway.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VpnGateway, Error = CloudError>;

  /**
   * Updates virtual wan vpn gateway tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<VpnGateway,
    PatchModel = TagsObject,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = VpnGateway> &
      Azure.Core.Foundations.RetryAfterHeader
  , Error = CloudError>;

  /**
   * Deletes a virtual wan vpn gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<VpnGateway,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,  Error = CloudError>;

  /**
   * Lists all the VpnGateways in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<VpnGateway,
    Response = ArmResponse<ListVpnGatewaysResult>
  , Error = CloudError>;

  /**
   * Lists all the VpnGateways in a subscription.
   */
  list is ArmListBySubscription<VpnGateway,
    Response = ArmResponse<ListVpnGatewaysResult>
  , Error = CloudError>;

  /**
   * Resets the primary of the vpn gateway in the specified resource group.
   */
  reset is ArmResourceActionAsync<VpnGateway,
    void,
    ArmResponse<VpnGateway>,
    Parameters = {
      /**
       * VpnGateway ipConfigurationId to specify the gateway instance.
       */
      @query("ipConfigurationId")
      ipConfigurationId?: string;
    }
  , Error = CloudError>;

  /**
   * Starts packet capture on vpn gateway in the specified resource group.
   */
  @action("startpacketcapture")
  startPacketCapture is ArmResourceActionAsync<VpnGateway,
    VpnGatewayPacketCaptureStartParameters,
    ArmResponse<stringApplicationJson>,
    OptionalRequestBody = true
  , Error = CloudError>;

  /**
   * Stops packet capture on vpn gateway in the specified resource group.
   */
  @action("stoppacketcapture")
  stopPacketCapture is ArmResourceActionAsync<VpnGateway,
    VpnGatewayPacketCaptureStopParameters,
    ArmResponse<stringApplicationJson>,
    OptionalRequestBody = true
  , Error = CloudError>;

  /**
   * Retrieves the details of a vpn connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnConnections_Get")
  @get
  vpnConnectionsGet is VpnConnectionOps.Read<
    VpnGateway,
    Response = ArmResponse<VpnConnection>,
    OverrideErrorType = CloudError
  >;

  /**
   * Creates a vpn connection to a scalable vpn gateway if it doesn't exist else updates the existing connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnConnections_CreateOrUpdate")
  @put
  vpnConnectionsCreateOrUpdate is VpnConnectionOps.CreateOrUpdateAsync<
    VpnGateway,
    Response = ArmResponse<VpnConnection> | ArmResourceCreatedResponse<VpnConnection>,
    Request = VpnConnection
,    OverrideErrorType = CloudError>;

  /**
   * Deletes a vpn connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnConnections_Delete")
  @delete
  vpnConnectionsDelete is VpnConnectionOps.DeleteWithoutOkAsync<
    VpnGateway,
    Response = OkResponse | NoContentResponse
,    OverrideErrorType = CloudError>;

  /**
   * Starts packet capture on Vpn connection in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnConnections_StartPacketCapture")
  @action("startpacketcapture")
  vpnConnectionsStartPacketCapture is VpnConnection2Ops.ActionAsync<
    VpnGateway,
    VpnConnectionPacketCaptureStartParameters,
    ArmResponse<stringApplicationJson>,
    OptionalRequestBody = true
  >;

  /**
   * Stops packet capture on Vpn connection in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnConnections_StopPacketCapture")
  @action("stoppacketcapture")
  vpnConnectionsStopPacketCapture is VpnConnection2Ops.ActionAsync<
    VpnGateway,
    VpnConnectionPacketCaptureStopParameters,
    ArmResponse<stringApplicationJson>,
    OptionalRequestBody = true
  >;

  /**
   * Retrieves all vpn connections for a particular virtual wan vpn gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnConnections_ListByVpnGateway")
  @list
  @get
  listByVpnGateway is VpnConnectionOps.List<
    VpnGateway,
    Response = ArmResponse<ListVpnConnectionsResult>,
    OverrideErrorType = CloudError
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
@@doc(VpnGateways.vpnConnectionsCreateOrUpdate::parameters.resource,
  "Parameters supplied to create or Update a VPN Connection."
);
@@doc(VpnGateways.vpnConnectionsStartPacketCapture::parameters.body,
  "Vpn Connection packet capture parameters supplied to start packet capture on gateway connection."
);
@@doc(VpnGateways.vpnConnectionsStopPacketCapture::parameters.body,
  "Vpn Connection packet capture parameters supplied to stop packet capture on gateway connection."
);
