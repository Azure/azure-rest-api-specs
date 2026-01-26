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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ExpressRouteCrossConnection extends Resource {
  properties?: ExpressRouteCrossConnectionProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("crossConnectionName")
  @segment("expressRouteCrossConnections")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias ExpressRouteCrossConnectionPeeringOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

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
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings",
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations(#{ allowStaticRoutes: true })
interface ExpressRouteCrossConnections {
  /**
   * Gets details about the specified ExpressRouteCrossConnection.
   */
  @autoRoute
  get is ArmResourceRead<ExpressRouteCrossConnection, Error = CloudError>;

  /**
   * Update the specified ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExpressRouteCrossConnection,
    Response = ArmResourceUpdatedResponse<ExpressRouteCrossConnection> &
      ArmAsyncOperationHeader,
    Error = CloudError
  >;

  /**
   * Updates an express route cross connection tags.
   */
  @patch(#{ implicitOptionality: false })
  @autoRoute
  updateTags is ArmCustomPatchSync<
    ExpressRouteCrossConnection,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Retrieves all the ExpressRouteCrossConnections in a resource group.
   */
  @autoRoute
  listByResourceGroup is ArmResourceListByParent<
    ExpressRouteCrossConnection,
    Error = CloudError
  >;

  /**
   * Retrieves all the ExpressRouteCrossConnections in a subscription.
   */
  @autoRoute
  list is ArmListBySubscription<
    ExpressRouteCrossConnection,
    Parameters = {
      /**
       * The filter to apply on the operation. For example, you can use $filter=name eq '{circuitServiceKey}'.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = CloudError
  >;

  /**
   * Gets the currently advertised ARP table associated with the express route cross connection in a resource group.
   */
  @post
  @autoRoute
  listArpTable is ArmResourceRead<
    ExpressRouteCrossConnection,
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
    Response = ArmResponse<ExpressRouteCircuitsArpTableListResult> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ExpressRouteCircuitsArpTableListResult> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Gets the route table summary associated with the express route cross connection in a resource group.
   */
  @post
  @autoRoute
  listRoutesTableSummary is ArmResourceRead<
    ExpressRouteCrossConnection,
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
    Response = ArmResponse<ExpressRouteCrossConnectionsRoutesTableSummaryListResult> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ExpressRouteCrossConnectionsRoutesTableSummaryListResult> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Gets the currently advertised routes table associated with the express route cross connection in a resource group.
   */
  @post
  @autoRoute
  listRoutesTable is ArmResourceRead<
    ExpressRouteCrossConnection,
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
    Response = ArmResponse<ExpressRouteCircuitsRoutesTableListResult> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ExpressRouteCircuitsRoutesTableListResult> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Gets all peerings in a specified ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteCrossConnectionPeerings_List")
  @list
  @get
  @autoRoute
  @action("peerings")
  expressRouteCrossConnectionPeeringsList is ArmResourceActionSync<
    ExpressRouteCrossConnection,
    void,
    ArmResponse<ExpressRouteCrossConnectionPeeringList>,
    Error = CloudError
  >;

  /**
   * Deletes the specified peering from the ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteCrossConnectionPeerings_Delete")
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}")
  delete is ExpressRouteCrossConnectionPeeringOps.ActionAsync<
    ExpressRouteCrossConnection,
    void,
    void,
    Response = {
      @body body: void;
    } | ArmAcceptedLroResponse | NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets the specified peering for the ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteCrossConnectionPeerings_Get")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}")
  expressRouteCrossConnectionPeeringsGet is ExpressRouteCrossConnectionPeeringOps.ActionSync<
    ExpressRouteCrossConnection,
    void,
    Response = ArmResponse<ExpressRouteCrossConnectionPeering>,
    OverrideErrorType = CloudError
  >;

  /**
   * Creates or updates a peering in the specified ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteCrossConnectionPeerings_CreateOrUpdate")
  @put
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  expressRouteCrossConnectionPeeringsCreateOrUpdate is ExpressRouteCrossConnectionPeeringOps.ActionAsync<
    ExpressRouteCrossConnection,
    ExpressRouteCrossConnectionPeering,
    void,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ExpressRouteCrossConnectionPeering> &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = ArmResponse<ExpressRouteCrossConnectionPeering> | ArmResourceCreatedResponse<
      ExpressRouteCrossConnectionPeering,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = ExpressRouteCrossConnectionPeering> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    OverrideErrorType = CloudError
  >;
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
@@doc(ExpressRouteCrossConnections.expressRouteCrossConnectionPeeringsCreateOrUpdate::parameters.body,
  "Parameters supplied to the create or update ExpressRouteCrossConnection peering operation."
);
