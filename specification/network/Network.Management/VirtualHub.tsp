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

@armResourceOperations
interface VirtualHubs {
  /**
   * Retrieves the details of a VirtualHub.
   */
  get is ArmResourceRead<VirtualHub>;

  /**
   * Creates a VirtualHub resource if it doesn't exist else updates the existing VirtualHub.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualHub>;

  /**
   * Updates VirtualHub tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<VirtualHub, PatchModel = TagsObject>;

  /**
   * Deletes a VirtualHub.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualHub,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the VirtualHubs in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    VirtualHub,
    Response = ArmResponse<ListVirtualHubsResult>
  >;

  /**
   * Lists all the VirtualHubs in a subscription.
   */
  list is ArmListBySubscription<
    VirtualHub,
    Response = ArmResponse<ListVirtualHubsResult>
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
    OptionalRequestBody = true
  >;

  /**
   * Gets the inbound routes configured for the Virtual Hub on a particular connection.
   */
  @list
  @action("inboundRoutes")
  getInboundRoutes is ArmResourceActionAsync<
    VirtualHub,
    GetInboundRoutesParameters,
    ArmResponse<EffectiveRouteMapRouteList>
  >;

  /**
   * Gets the outbound routes configured for the Virtual Hub on a particular connection.
   */
  @list
  @action("outboundRoutes")
  getOutboundRoutes is ArmResourceActionAsync<
    VirtualHub,
    GetOutboundRoutesParameters,
    ArmResponse<EffectiveRouteMapRouteList>
  >;

  /**
   * Creates a hub virtual network connection if it doesn't exist else updates the existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HubVirtualNetworkConnections_CreateOrUpdate")
  @put
  @action("{connectionName}")
  hubVirtualNetworkConnectionsCreateOrUpdate is ArmResourceActionAsyncBase<
    VirtualHub,
    HubVirtualNetworkConnection,
    ArmResponse<HubVirtualNetworkConnection> | ArmResourceCreatedResponse<HubVirtualNetworkConnection>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualHub>,
    Parameters = {
      /**
       * The name of the HubVirtualNetworkConnection.
       */
      @path
      connectionName: string;
    }
  >;

  /**
   * Deletes a HubVirtualNetworkConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HubVirtualNetworkConnections_Delete")
  @delete
  @action("{connectionName}")
  hubVirtualNetworkConnectionsDelete is ArmResourceActionAsync<
    VirtualHub,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * The name of the HubVirtualNetworkConnection.
       */
      @path
      connectionName: string;
    }
  >;

  /**
   * Retrieves the details of a HubVirtualNetworkConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HubVirtualNetworkConnections_Get")
  @get
  @action("{connectionName}")
  hubVirtualNetworkConnectionsGet is ArmResourceActionSync<
    VirtualHub,
    void,
    ArmResponse<HubVirtualNetworkConnection>,
    Parameters = {
      /**
       * The name of the vpn connection.
       */
      @path
      connectionName: string;
    }
  >;

  /**
   * Retrieves the details of all HubVirtualNetworkConnections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HubVirtualNetworkConnections_List")
  @list
  @get
  @action("hubVirtualNetworkConnections")
  hubVirtualNetworkConnectionsList is ArmResourceActionSync<
    VirtualHub,
    void,
    ArmResponse<ListHubVirtualNetworkConnectionsResult>
  >;

  /**
   * Retrieves the details of a VirtualHubRouteTableV2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualHubRouteTableV2s_Get")
  @get
  @action("{routeTableName}")
  virtualHubRouteTableV2sGet is ArmResourceActionSync<
    VirtualHub,
    void,
    ArmResponse<VirtualHubRouteTableV2>,
    Parameters = {
      /**
       * The name of the VirtualHubRouteTableV2.
       */
      @path
      routeTableName: string;
    }
  >;

  /**
   * Creates a VirtualHubRouteTableV2 resource if it doesn't exist else updates the existing VirtualHubRouteTableV2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualHubRouteTableV2s_CreateOrUpdate")
  @put
  @action("{routeTableName}")
  virtualHubRouteTableV2sCreateOrUpdate is ArmResourceActionAsyncBase<
    VirtualHub,
    VirtualHubRouteTableV2,
    ArmResponse<VirtualHubRouteTableV2> | ArmResourceCreatedResponse<VirtualHubRouteTableV2>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualHub>,
    Parameters = {
      /**
       * The name of the VirtualHubRouteTableV2.
       */
      @path
      routeTableName: string;
    }
  >;

  /**
   * Deletes a VirtualHubRouteTableV2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualHubRouteTableV2s_Delete")
  @delete
  @action("{routeTableName}")
  virtualHubRouteTableV2sDelete is ArmResourceActionAsync<
    VirtualHub,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * The name of the VirtualHubRouteTableV2.
       */
      @path
      routeTableName: string;
    }
  >;

  /**
   * Retrieves the details of all VirtualHubRouteTableV2s.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualHubRouteTableV2s_List")
  @list
  @get
  @action("routeTables")
  virtualHubRouteTableV2sList is ArmResourceActionSync<
    VirtualHub,
    void,
    ArmResponse<ListVirtualHubRouteTableV2SResult>
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
