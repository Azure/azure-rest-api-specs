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
 * ExpressRouteCrossConnection resource.
 */
model ExpressRouteCrossConnection
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ExpressRouteCrossConnectionProperties> {
  ...ResourceNameParameter<
    Resource = ExpressRouteCrossConnection,
    KeyName = "crossConnectionName",
    SegmentName = "expressRouteCrossConnections",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias ExpressRouteCrossConnectionPeeringOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name for the express route cross connection. */
    @path
    @segment("expressRouteCrossConnections")
    @key
    crossConnectionName: string;
  },
  {
    /** The name of the peering. */
    @path
    @segment("peerings")
    @key
    peeringName: string;
  }
>;

@armResourceOperations
interface ExpressRouteCrossConnections {
  /**
   * Gets details about the specified ExpressRouteCrossConnection.
   */
  get is ArmResourceRead<ExpressRouteCrossConnection, Error = CloudError>;

  /**
   * Update the specified ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExpressRouteCrossConnection,
    Response = ArmResourceUpdatedResponse<ExpressRouteCrossConnection> &
      ArmAsyncOperationHeader
  >;

  /**
   * Updates an express route cross connection tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<ExpressRouteCrossConnection,
    PatchModel = TagsObject, Error = CloudError>;

  /**
   * Retrieves all the ExpressRouteCrossConnections in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<ExpressRouteCrossConnection, Error = CloudError>;

  /**
   * Retrieves all the ExpressRouteCrossConnections in a subscription.
   */
  list is ArmListBySubscription<ExpressRouteCrossConnection,
    Parameters = {
      /**
       * The filter to apply on the operation. For example, you can use $filter=name eq '{circuitServiceKey}'.
       */
      @query("$filter")
      $filter?: string;
    }, Error = CloudError>;

  /**
   * Gets the currently advertised ARP table associated with the express route cross connection in a resource group.
   */
  @post
  listArpTable is ArmResourceRead<ExpressRouteCrossConnection,
    Parameters = {
      /**
       * The name of the peering.
       */
      @path
      @segment("peerings")
      peeringName: string;

      /**
       * The path of the device.
       */
      @path
      @segment("arpTables")
      devicePath: string;
    },
    Response = ArmResponse<ExpressRouteCircuitsArpTableListResult> | ArmAcceptedLroResponse
  >;

  /**
   * Gets the route table summary associated with the express route cross connection in a resource group.
   */
  @post
  listRoutesTableSummary is ArmResourceRead<ExpressRouteCrossConnection,
    Parameters = {
      /**
       * The name of the peering.
       */
      @path
      @segment("peerings")
      peeringName: string;

      /**
       * The path of the device.
       */
      @path
      @segment("routeTablesSummary")
      devicePath: string;
    },
    Response = ArmResponse<ExpressRouteCrossConnectionsRoutesTableSummaryListResult> | ArmAcceptedLroResponse
  >;

  /**
   * Gets the currently advertised routes table associated with the express route cross connection in a resource group.
   */
  @post
  listRoutesTable is ArmResourceRead<ExpressRouteCrossConnection,
    Parameters = {
      /**
       * The name of the peering.
       */
      @path
      @segment("peerings")
      peeringName: string;

      /**
       * The path of the device.
       */
      @path
      @segment("routeTables")
      devicePath: string;
    },
    Response = ArmResponse<ExpressRouteCircuitsRoutesTableListResult> | ArmAcceptedLroResponse
  >;

  /**
   * Gets all peerings in a specified ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCrossConnectionPeerings_List")
  @list
  @get
  expressRouteCrossConnectionPeeringsList is ExpressRouteCrossConnectionPeeringOps.List<
    ExpressRouteCrossConnection,
    Response = ArmResponse<ExpressRouteCrossConnectionPeeringList>,
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes the specified peering from the ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCrossConnectionPeerings_Delete")
  @delete
  delete is ExpressRouteCrossConnectionPeeringOps.DeleteWithoutOkAsync<
    ExpressRouteCrossConnection,
    Response = OkResponse | ArmAcceptedLroResponse | NoContentResponse
,    OverrideErrorType = CloudError>;

  /**
   * Gets the specified peering for the ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCrossConnectionPeerings_Get")
  @get
  expressRouteCrossConnectionPeeringsGet is ExpressRouteCrossConnectionPeeringOps.Read<
    ExpressRouteCrossConnection,
    Response = ArmResponse<ExpressRouteCrossConnectionPeering>,
    OverrideErrorType = CloudError
  >;

  /**
   * Creates or updates a peering in the specified ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCrossConnectionPeerings_CreateOrUpdate")
  @put
  @Azure.Core.useFinalStateVia("azure-async-operation")
  expressRouteCrossConnectionPeeringsCreateOrUpdate is ExpressRouteCrossConnectionPeeringOps.CreateOrUpdateAsync<
    ExpressRouteCrossConnection,
    Response = ArmResponse<ExpressRouteCrossConnectionPeering> | ArmResourceCreatedResponse<ExpressRouteCrossConnectionPeering>,
    Request = ExpressRouteCrossConnectionPeering
,    OverrideErrorType = CloudError>;
}

@@doc(ExpressRouteCrossConnection.name,
  "The name of the ExpressRouteCrossConnection (service key of the circuit)."
);
@@doc(ExpressRouteCrossConnection.properties,
  "Properties of the express route cross connection."
);
@@doc(ExpressRouteCrossConnections.createOrUpdate::parameters.resource,
  "Parameters supplied to the update express route crossConnection operation."
);
@@doc(ExpressRouteCrossConnections.updateTags::parameters.properties,
  "Parameters supplied to update express route cross connection tags."
);
@@doc(ExpressRouteCrossConnections.expressRouteCrossConnectionPeeringsCreateOrUpdate::parameters.resource,
  "Parameters supplied to the create or update ExpressRouteCrossConnection peering operation."
);
