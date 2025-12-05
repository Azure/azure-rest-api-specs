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
 * A common class for general resource information.
 */
model VirtualNetworkGatewayConnection
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<
    VirtualNetworkGatewayConnectionPropertiesFormat,
    false
  > {
  ...ResourceNameParameter<
    Resource = VirtualNetworkGatewayConnection,
    KeyName = "virtualNetworkGatewayConnectionName",
    SegmentName = "connections",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface VirtualNetworkGatewayConnections {
  /**
   * Gets the specified virtual network gateway connection by resource group.
   */
  get is ArmResourceRead<VirtualNetworkGatewayConnection, Error = CloudError>;

  /**
   * Creates or updates a virtual network gateway connection in the specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetworkGatewayConnection,
    Error = CloudError
  >;

  /**
   * Updates a virtual network gateway connection tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<
    VirtualNetworkGatewayConnection,
    PatchModel = TagsObject,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = VirtualNetworkGatewayConnection> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Deletes the specified virtual network Gateway connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetworkGatewayConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * The List VirtualNetworkGatewayConnections operation retrieves all the virtual network gateways connections created.
   */
  list is ArmResourceListByParent<
    VirtualNetworkGatewayConnection,
    Error = CloudError
  >;

  /**
   * Gets a xml format representation for vpn device configuration script.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualNetworkGateways_VpnDeviceConfigurationScript")
  @action("vpndeviceconfigurationscript")
  vpnDeviceConfigurationScript is ArmResourceActionSync<
    VirtualNetworkGatewayConnection,
    VpnDeviceScriptParameters,
    ArmResponse<stringApplicationJson>,
    Error = CloudError
  >;

  /**
   * The Put VirtualNetworkGatewayConnectionSharedKey operation sets the virtual network gateway connection shared key for passed virtual network gateway connection in the specified resource group through Network resource provider.
   */
  @put
  @action("sharedkey")
  setSharedKey is ArmResourceActionAsyncBase<
    VirtualNetworkGatewayConnection,
    ConnectionSharedKey,
    ArmResponse<ConnectionSharedKey> | ArmResourceCreatedResponse<
      ConnectionSharedKey,
      LroHeaders = ArmAsyncOperationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualNetworkGatewayConnection>,
    Error = CloudError
  >;

  /**
   * The Get VirtualNetworkGatewayConnectionSharedKey operation retrieves information about the specified virtual network gateway connection shared key through Network resource provider.
   */
  @get
  @action("sharedkey")
  getSharedKey is ArmResourceActionSync<
    VirtualNetworkGatewayConnection,
    void,
    ArmResponse<ConnectionSharedKey>,
    Error = CloudError
  >;

  /**
   * The VirtualNetworkGatewayConnectionResetSharedKey operation resets the virtual network gateway connection shared key for passed virtual network gateway connection in the specified resource group through Network resource provider.
   */
  @action("sharedkey/reset")
  resetSharedKey is ArmResourceActionAsync<
    VirtualNetworkGatewayConnection,
    ConnectionResetSharedKey,
    ConnectionResetSharedKey,
    Error = CloudError
  >;

  /**
   * Starts packet capture on virtual network gateway connection in the specified resource group.
   */
  startPacketCapture is ArmResourceActionAsync<
    VirtualNetworkGatewayConnection,
    VpnPacketCaptureStartParameters,
    ArmResponse<stringApplicationJson>,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Stops packet capture on virtual network gateway connection in the specified resource group.
   */
  stopPacketCapture is ArmResourceActionAsync<
    VirtualNetworkGatewayConnection,
    VpnPacketCaptureStopParameters,
    ArmResponse<stringApplicationJson>,
    Error = CloudError
  >;

  /**
   * Lists IKE Security Associations for the virtual network gateway connection in the specified resource group.
   */
  @action("getikesas")
  getIkeSas is ArmResourceActionAsync<
    VirtualNetworkGatewayConnection,
    void,
    ArmResponse<stringApplicationJson>,
    Error = CloudError
  >;

  /**
   * Resets the virtual network gateway connection specified.
   */
  @action("resetconnection")
  resetConnection is ArmResourceActionAsyncBase<
    VirtualNetworkGatewayConnection,
    Request = void,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualNetworkGatewayConnection>,
    Error = CloudError
  >;
}

@@doc(VirtualNetworkGatewayConnection.name,
  "The name of the virtual network gateway connection."
);
@@doc(VirtualNetworkGatewayConnection.properties,
  "Properties of the virtual network gateway connection."
);
@@doc(VirtualNetworkGatewayConnections.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update virtual network gateway connection operation."
);
@@doc(VirtualNetworkGatewayConnections.updateTags::parameters.properties,
  "Parameters supplied to update virtual network gateway connection tags."
);
@@doc(VirtualNetworkGatewayConnections.vpnDeviceConfigurationScript::parameters.body,
  "Parameters supplied to the generate vpn device script operation."
);
@@doc(VirtualNetworkGatewayConnections.setSharedKey::parameters.body,
  "Parameters supplied to the Begin Set Virtual Network Gateway connection Shared key operation throughNetwork resource provider."
);
@@doc(VirtualNetworkGatewayConnections.resetSharedKey::parameters.body,
  "Parameters supplied to the begin reset virtual network gateway connection shared key operation through network resource provider."
);
@@doc(VirtualNetworkGatewayConnections.startPacketCapture::parameters.body,
  "Virtual network gateway packet capture parameters supplied to start packet capture on gateway connection."
);
@@doc(VirtualNetworkGatewayConnections.stopPacketCapture::parameters.body,
  "Virtual network gateway packet capture parameters supplied to stop packet capture on gateway connection."
);
