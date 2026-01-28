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
 * VirtualHub Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
model VirtualHub extends ResourceWithRequiredLocation {
  properties?: VirtualHubProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("virtualHubName")
  @segment("virtualHubs")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Kind of service virtual hub. This is metadata used for the Azure portal experience for Route Server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: string;
}

alias HubVirtualNetworkConnectionOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the Virtual Hub. */
    @path
    @segment("virtualHubs")
    @key
    virtualHubName: string;
  },
  {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("hubVirtualNetworkConnections")
    @key
    connectionName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}",
  }
>;

alias VirtualHubRouteTableV2Ops = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the Virtual Hub. */
    @path
    @segment("virtualHubs")
    @key
    virtualHubName: string;
  },
  {
    /** The name of the VirtualHubRouteTableV2. */
    @path
    @segment("routeTables")
    @key
    routeTableName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface VirtualHubs {
  /**
   * Retrieves the details of a VirtualHub.
   */
  @autoRoute
  get is ArmResourceRead<VirtualHub, Error = CloudError>;

  /**
   * Creates a VirtualHub resource if it doesn't exist else updates the existing VirtualHub.
   */
  @autoRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualHub,
    Error = CloudError
  >;

  /**
   * Updates VirtualHub tags.
   */
  @patch(#{ implicitOptionality: false })
  @autoRoute
  updateTags is ArmCustomPatchSync<
    VirtualHub,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes a VirtualHub.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualHub,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all the VirtualHubs in a resource group.
   */
  @autoRoute
  listByResourceGroup is ArmResourceListByParent<
    VirtualHub,
    Response = ArmResponse<ListVirtualHubsResult>,
    Error = CloudError
  >;

  /**
   * Lists all the VirtualHubs in a subscription.
   */
  @autoRoute
  list is ArmListBySubscription<
    VirtualHub,
    Response = ArmResponse<ListVirtualHubsResult>,
    Error = CloudError
  >;

  /**
   * Gets the effective routes configured for the Virtual Hub resource or the specified resource .
   */
  @list
  @action("effectiveRoutes")
  @autoRoute
  getEffectiveVirtualHubRoutes is ArmResourceActionAsync<
    VirtualHub,
    EffectiveRoutesParameters,
    VirtualHubEffectiveRouteList,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Gets the inbound routes configured for the Virtual Hub on a particular connection.
   */
  @list
  @action("inboundRoutes")
  @autoRoute
  getInboundRoutes is ArmResourceActionAsync<
    VirtualHub,
    GetInboundRoutesParameters,
    EffectiveRouteMapRouteList,
    Error = CloudError
  >;

  /**
   * Gets the outbound routes configured for the Virtual Hub on a particular connection.
   */
  @list
  @action("outboundRoutes")
  @autoRoute
  getOutboundRoutes is ArmResourceActionAsync<
    VirtualHub,
    GetOutboundRoutesParameters,
    EffectiveRouteMapRouteList,
    Error = CloudError
  >;

  /**
   * Creates a hub virtual network connection if it doesn't exist else updates the existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("HubVirtualNetworkConnections_CreateOrUpdate")
  @put
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}")
  hubVirtualNetworkConnectionsCreateOrUpdate is HubVirtualNetworkConnectionOps.ActionAsync<
    VirtualHub,
    HubVirtualNetworkConnection,
    void,
    Response = ArmResponse<HubVirtualNetworkConnection> | ArmResourceCreatedResponse<
      HubVirtualNetworkConnection,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = HubVirtualNetworkConnection> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes a HubVirtualNetworkConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("HubVirtualNetworkConnections_Delete")
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}")
  hubVirtualNetworkConnectionsDelete is HubVirtualNetworkConnectionOps.ActionAsync<
    VirtualHub,
    void,
    void,
    Response = {
      @body body: void;
    } | ArmAcceptedLroResponse | NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieves the details of a HubVirtualNetworkConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("HubVirtualNetworkConnections_Get")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}")
  hubVirtualNetworkConnectionsGet is HubVirtualNetworkConnectionOps.ActionSync<
    VirtualHub,
    void,
    Response = ArmResponse<HubVirtualNetworkConnection>,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieves the details of all HubVirtualNetworkConnections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("HubVirtualNetworkConnections_List")
  @list
  @get
  @autoRoute
  @action("hubVirtualNetworkConnections")
  hubVirtualNetworkConnectionsList is ArmResourceActionSync<
    VirtualHub,
    void,
    ArmResponse<ListHubVirtualNetworkConnectionsResult>,
    Error = CloudError
  >;

  /**
   * Retrieves the details of a VirtualHubRouteTableV2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualHubRouteTableV2s_Get")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}")
  virtualHubRouteTableV2sGet is VirtualHubRouteTableV2Ops.ActionSync<
    VirtualHub,
    void,
    Response = ArmResponse<VirtualHubRouteTableV2>,
    OverrideErrorType = Error
  >;

  /**
   * Creates a VirtualHubRouteTableV2 resource if it doesn't exist else updates the existing VirtualHubRouteTableV2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualHubRouteTableV2s_CreateOrUpdate")
  @put
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}")
  virtualHubRouteTableV2sCreateOrUpdate is VirtualHubRouteTableV2Ops.ActionAsync<
    VirtualHub,
    VirtualHubRouteTableV2,
    void,
    Response = ArmResponse<VirtualHubRouteTableV2> | ArmResourceCreatedResponse<
      VirtualHubRouteTableV2,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = VirtualHubRouteTableV2> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    OverrideErrorType = Error
  >;

  /**
   * Deletes a VirtualHubRouteTableV2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualHubRouteTableV2s_Delete")
  @delete
  virtualHubRouteTableV2sDelete is VirtualHubRouteTableV2Ops.ActionAsync<
    VirtualHub,
    void,
    void,
    Response = {
      @body body: void;
    } | ArmAcceptedLroResponse | NoContentResponse,
    OverrideErrorType = Error
  >;

  /**
   * Retrieves the details of all VirtualHubRouteTableV2s.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualHubRouteTableV2s_List")
  @list
  @get
  @action("routeTables")
  virtualHubRouteTableV2sList is ArmResourceActionSync<
    VirtualHub,
    void,
    ArmResponse<ListVirtualHubRouteTableV2SResult>,
    Error = Error
  >;
}

@@doc(VirtualHub.name, "The name of the VirtualHub.");
@@doc(VirtualHub.properties, "Properties of the virtual hub.");
@@doc(VirtualHubs.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update VirtualHub."
);
@@doc(VirtualHubs.updateTags::parameters.properties,
  "Parameters supplied to update VirtualHub tags."
);
@@doc(VirtualHubs.getEffectiveVirtualHubRoutes::parameters.body,
  "Parameters supplied to get the effective routes for a specific resource."
);
@@doc(VirtualHubs.getInboundRoutes::parameters.body,
  "Parameters supplied to get the inbound routes for a connection resource."
);
@@doc(VirtualHubs.getOutboundRoutes::parameters.body,
  "Parameters supplied to get the outbound routes for a connection resource."
);
@@doc(VirtualHubs.hubVirtualNetworkConnectionsCreateOrUpdate::parameters.body,
  "Parameters supplied to create or update a hub virtual network connection."
);
@@doc(VirtualHubs.virtualHubRouteTableV2sCreateOrUpdate::parameters.body,
  "Parameters supplied to create or update VirtualHubRouteTableV2."
);
