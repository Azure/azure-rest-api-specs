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
model VirtualHub
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<VirtualHubProperties> {
  ...ResourceNameParameter<
    Resource = VirtualHub,
    KeyName = "virtualHubName",
    SegmentName = "virtualHubs",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;

  /**
   * Kind of service virtual hub. This is metadata used for the Azure portal experience for Route Server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  kind?: string;
}

alias HubVirtualNetworkConnectionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the Virtual Hub. */
    @path
    @segment("virtualHubs")
    @key
    virtualHubName: string;
  },
  {
    @path
    @segment("hubVirtualNetworkConnections")
    @key
    connectionName: string;
  }
>;

alias VirtualHubRouteTableV2Ops = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

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
  }
>;

@armResourceOperations
interface VirtualHubs {
  /**
   * Retrieves the details of a VirtualHub.
   */
  get is ArmResourceRead<VirtualHub, Error = CloudError>;

  /**
   * Creates a VirtualHub resource if it doesn't exist else updates the existing VirtualHub.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualHub,
    Error = CloudError
  >;

  /**
   * Updates VirtualHub tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    VirtualHub,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes a VirtualHub.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualHub,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all the VirtualHubs in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    VirtualHub,
    Response = ArmResponse<ListVirtualHubsResult>,
    Error = CloudError
  >;

  /**
   * Lists all the VirtualHubs in a subscription.
   */
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
  getEffectiveVirtualHubRoutes is ArmResourceActionAsync<
    VirtualHub,
    EffectiveRoutesParameters,
    ArmResponse<VirtualHubEffectiveRouteList>,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Gets the inbound routes configured for the Virtual Hub on a particular connection.
   */
  @list
  @action("inboundRoutes")
  getInboundRoutes is ArmResourceActionAsync<
    VirtualHub,
    GetInboundRoutesParameters,
    ArmResponse<EffectiveRouteMapRouteList>,
    Error = CloudError
  >;

  /**
   * Gets the outbound routes configured for the Virtual Hub on a particular connection.
   */
  @list
  @action("outboundRoutes")
  getOutboundRoutes is ArmResourceActionAsync<
    VirtualHub,
    GetOutboundRoutesParameters,
    ArmResponse<EffectiveRouteMapRouteList>,
    Error = CloudError
  >;

  /**
   * Creates a hub virtual network connection if it doesn't exist else updates the existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HubVirtualNetworkConnections_CreateOrUpdate")
  @put
  @Azure.Core.useFinalStateVia("azure-async-operation")
  hubVirtualNetworkConnectionsCreateOrUpdate is HubVirtualNetworkConnectionOps.CreateOrUpdateAsync<
    VirtualHub,
    Response = ArmResponse<HubVirtualNetworkConnection> | ArmResourceCreatedResponse<HubVirtualNetworkConnection>,
    Request = HubVirtualNetworkConnection,
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes a HubVirtualNetworkConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HubVirtualNetworkConnections_Delete")
  @delete
  hubVirtualNetworkConnectionsDelete is HubVirtualNetworkConnectionOps.DeleteSync<
    VirtualHub,
    Response = OkResponse | ArmAcceptedLroResponse | NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieves the details of a HubVirtualNetworkConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HubVirtualNetworkConnections_Get")
  @get
  hubVirtualNetworkConnectionsGet is HubVirtualNetworkConnectionOps.Read<
    VirtualHub,
    Response = ArmResponse<HubVirtualNetworkConnection>,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieves the details of all HubVirtualNetworkConnections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HubVirtualNetworkConnections_List")
  @list
  @get
  hubVirtualNetworkConnectionsList is HubVirtualNetworkConnectionOps.List<
    VirtualHub,
    Response = ArmResponse<ListHubVirtualNetworkConnectionsResult>,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieves the details of a VirtualHubRouteTableV2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualHubRouteTableV2s_Get")
  @get
  virtualHubRouteTableV2sGet is VirtualHubRouteTableV2Ops.Read<
    VirtualHub,
    Response = ArmResponse<VirtualHubRouteTableV2>,
    OverrideErrorType = Error
  >;

  /**
   * Creates a VirtualHubRouteTableV2 resource if it doesn't exist else updates the existing VirtualHubRouteTableV2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualHubRouteTableV2s_CreateOrUpdate")
  @put
  @Azure.Core.useFinalStateVia("azure-async-operation")
  virtualHubRouteTableV2sCreateOrUpdate is VirtualHubRouteTableV2Ops.CreateOrUpdateAsync<
    VirtualHub,
    Response = ArmResponse<VirtualHubRouteTableV2> | ArmResourceCreatedResponse<VirtualHubRouteTableV2>,
    Request = VirtualHubRouteTableV2,
    OverrideErrorType = Error
  >;

  /**
   * Deletes a VirtualHubRouteTableV2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualHubRouteTableV2s_Delete")
  @delete
  virtualHubRouteTableV2sDelete is VirtualHubRouteTableV2Ops.DeleteWithoutOkAsync<
    VirtualHub,
    Response = OkResponse | ArmAcceptedLroResponse | NoContentResponse,
    OverrideErrorType = Error
  >;

  /**
   * Retrieves the details of all VirtualHubRouteTableV2s.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualHubRouteTableV2s_List")
  @list
  @get
  virtualHubRouteTableV2sList is VirtualHubRouteTableV2Ops.List<
    VirtualHub,
    Response = ArmResponse<ListVirtualHubRouteTableV2SResult>,
    OverrideErrorType = CloudError
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
@@doc(VirtualHubs.hubVirtualNetworkConnectionsCreateOrUpdate::parameters.resource,
  "Parameters supplied to create or update a hub virtual network connection."
);
@@doc(VirtualHubs.virtualHubRouteTableV2sCreateOrUpdate::parameters.resource,
  "Parameters supplied to create or update VirtualHubRouteTableV2."
);
