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
 * P2SVpnGateway Resource.
 */
model P2SVpnGateway
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<P2SVpnGatewayProperties> {
  ...ResourceNameParameter<
    Resource = P2SVpnGateway,
    KeyName = "gatewayName",
    SegmentName = "p2svpnGateways",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias P2SVpnGatewayOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** The name of the P2S Vpn Gateway. */
    @path
    @segment("p2svpnGateways")
    @key
    p2sVpnGatewayName: string;
  }
>;

@armResourceOperations
interface P2SVpnGateways {
  /**
   * Retrieves the details of a virtual wan p2s vpn gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("P2sVpnGateways_Get")
  get is ArmResourceRead<P2SVpnGateway>;

  /**
   * Creates a virtual wan p2s vpn gateway if it doesn't exist else updates the existing gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("P2sVpnGateways_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<P2SVpnGateway>;

  /**
   * Updates virtual wan p2s vpn gateway tags.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("P2sVpnGateways_UpdateTags")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<
    P2SVpnGateway,
    PatchModel = TagsObject,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = P2SVpnGateway> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a virtual wan p2s vpn gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("P2sVpnGateways_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    P2SVpnGateway,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the P2SVpnGateways in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("P2sVpnGateways_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    P2SVpnGateway,
    Response = ArmResponse<ListP2SVpnGatewaysResult>
  >;

  /**
   * Lists all the P2SVpnGateways in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("P2sVpnGateways_List")
  list is ArmListBySubscription<
    P2SVpnGateway,
    Response = ArmResponse<ListP2SVpnGatewaysResult>
  >;

  /**
   * Resets the primary of the p2s vpn gateway in the specified resource group.
   */
  reset is ArmResourceActionAsync<
    P2SVpnGateway,
    void,
    ArmResponse<P2SVpnGateway>
  >;

  /**
   * Generates VPN profile for P2S client of the P2SVpnGateway in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("P2sVpnGateways_GenerateVpnProfile")
  @action("generatevpnprofile")
  generateVpnProfile is ArmResourceActionAsync<
    P2SVpnGateway,
    P2SVpnProfileParameters,
    ArmResponse<VpnProfileResponse>
  >;

  /**
   * Gets the connection health of P2S clients of the virtual wan P2SVpnGateway in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("P2sVpnGateways_GetP2sVpnConnectionHealth")
  getP2sVpnConnectionHealth is ArmResourceActionAsync<
    P2SVpnGateway,
    void,
    ArmResponse<P2SVpnGateway>
  >;

  /**
   * Gets the sas url to get the connection health detail of P2S clients of the virtual wan P2SVpnGateway in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("P2sVpnGateways_GetP2sVpnConnectionHealthDetailed")
  getP2sVpnConnectionHealthDetailed is ArmResourceActionAsync<
    P2SVpnGateway,
    P2SVpnConnectionHealthRequest,
    ArmResponse<P2SVpnConnectionHealth>
  >;

  /**
   * Disconnect P2S vpn connections of the virtual wan P2SVpnGateway in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("P2sVpnGateways_DisconnectP2sVpnConnections")
  disconnectP2sVpnConnections is P2SVpnGatewayOps.ActionAsync<
    P2SVpnGateway,
    P2SVpnConnectionRequest,
    OkResponse
  >;
}

@@doc(P2SVpnGateway.name, "The name of the gateway.");
@@doc(P2SVpnGateway.properties, "Properties of the P2SVpnGateway.");
@@doc(P2SVpnGateways.createOrUpdate::parameters.resource,
  "Parameters supplied to create or Update a virtual wan p2s vpn gateway."
);
@@doc(P2SVpnGateways.updateTags::parameters.properties,
  "Parameters supplied to update a virtual wan p2s vpn gateway tags."
);
@@doc(P2SVpnGateways.generateVpnProfile::parameters.body,
  "Parameters supplied to the generate P2SVpnGateway VPN client package operation."
);
@@doc(P2SVpnGateways.getP2sVpnConnectionHealthDetailed::parameters.body,
  "Request parameters supplied to get p2s vpn connections detailed health."
);
@@doc(P2SVpnGateways.disconnectP2sVpnConnections::parameters.body,
  "The parameters are supplied to disconnect p2s vpn connections."
);
