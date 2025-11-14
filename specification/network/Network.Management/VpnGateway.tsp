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

@armResourceOperations
interface VpnGateways {
  /**
   * Retrieves the details of a virtual wan vpn gateway.
   */
  get is ArmResourceRead<VpnGateway>;

  /**
   * Creates a virtual wan vpn gateway if it doesn't exist else updates the existing gateway.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VpnGateway>;

  /**
   * Updates virtual wan vpn gateway tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<
    VpnGateway,
    PatchModel = TagsObject,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = VpnGateway> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a virtual wan vpn gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VpnGateway,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the VpnGateways in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    VpnGateway,
    Response = ArmResponse<ListVpnGatewaysResult>
  >;

  /**
   * Lists all the VpnGateways in a subscription.
   */
  list is ArmListBySubscription<
    VpnGateway,
    Response = ArmResponse<ListVpnGatewaysResult>
  >;

  /**
   * Resets the primary of the vpn gateway in the specified resource group.
   */
  reset is ArmResourceActionAsync<
    VpnGateway,
    void,
    ArmResponse<VpnGateway>,
    Parameters = {
      /**
       * VpnGateway ipConfigurationId to specify the gateway instance.
       */
      @query("ipConfigurationId")
      ipConfigurationId?: string;
    }
  >;

  /**
   * Starts packet capture on vpn gateway in the specified resource group.
   */
  @action("startpacketcapture")
  startPacketCapture is ArmResourceActionAsync<
    VpnGateway,
    VpnGatewayPacketCaptureStartParameters,
    ArmResponse<string>,
    OptionalRequestBody = true
  >;

  /**
   * Stops packet capture on vpn gateway in the specified resource group.
   */
  @action("stoppacketcapture")
  stopPacketCapture is ArmResourceActionAsync<
    VpnGateway,
    VpnGatewayPacketCaptureStopParameters,
    ArmResponse<string>,
    OptionalRequestBody = true
  >;

  /**
   * Retrieves the details of a vpn connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnConnections_Get")
  @get
  @action("{connectionName}")
  vpnConnectionsGet is ArmResourceActionSync<
    VpnGateway,
    void,
    ArmResponse<VpnConnection>,
    Parameters = {
      /**
       * The name of the vpn connection.
       */
      @path
      connectionName: string;
    }
  >;

  /**
   * Creates a vpn connection to a scalable vpn gateway if it doesn't exist else updates the existing connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnConnections_CreateOrUpdate")
  @put
  @action("{connectionName}")
  vpnConnectionsCreateOrUpdate is ArmResourceActionAsyncBase<
    VpnGateway,
    VpnConnection,
    ArmResponse<VpnConnection> | ArmResourceCreatedResponse<VpnConnection>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VpnGateway>,
    Parameters = {
      /**
       * The name of the connection.
       */
      @path
      connectionName: string;
    }
  >;

  /**
   * Deletes a vpn connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnConnections_Delete")
  @delete
  @action("{connectionName}")
  vpnConnectionsDelete is ArmResourceActionAsyncBase<
    VpnGateway,
    void,
    Response = OkResponse | NoContentResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VpnGateway>,
    Parameters = {
      /**
       * The name of the connection.
       */
      @path
      connectionName: string;
    }
  >;

  /**
   * Starts packet capture on Vpn connection in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnConnections_StartPacketCapture")
  @action("startpacketcapture")
  vpnConnectionsStartPacketCapture is ArmResourceActionAsync<
    VpnGateway,
    VpnConnectionPacketCaptureStartParameters,
    ArmResponse<string>,
    Parameters = {
      /**
       * The name of the vpn connection.
       */
      @path
      vpnConnectionName: string;
    },
    OptionalRequestBody = true
  >;

  /**
   * Stops packet capture on Vpn connection in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnConnections_StopPacketCapture")
  @action("stoppacketcapture")
  vpnConnectionsStopPacketCapture is ArmResourceActionAsync<
    VpnGateway,
    VpnConnectionPacketCaptureStopParameters,
    ArmResponse<string>,
    Parameters = {
      /**
       * The name of the vpn connection.
       */
      @path
      vpnConnectionName: string;
    },
    OptionalRequestBody = true
  >;

  /**
   * Retrieves all vpn connections for a particular virtual wan vpn gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnConnections_ListByVpnGateway")
  @list
  @get
  @action("vpnConnections")
  listByVpnGateway is ArmResourceActionSync<
    VpnGateway,
    void,
    ArmResponse<ListVpnConnectionsResult>
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
