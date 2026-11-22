import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./shared-models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Network;

/**
 * ExpressRouteCrossConnection resource.
 */
@featureFile(Features.expressRoute)
model ExpressRouteCrossConnection
  is ResourceInstance<ExpressRouteCrossConnectionProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "The generic resource marker exposes this legacy resource name without a pattern."
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

/**
 * Resource identity for a peering in an ExpressRoute cross connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The resource-only identity reuses the existing serialized peering schema."
@Azure.ResourceManager.Legacy.externalTypeRef("#/definitions/ExpressRouteCrossConnectionPeering")
@featureFile(Features.expressRoute)
@parentResource(ExpressRouteCrossConnection)
model ExpressRouteCrossConnectionPeeringResource
  is ChildResourceWithoutPropertiesInstance<{}> {
  /** The name of the peering. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "The generic resource marker exposes this legacy resource name without a pattern."
  @visibility(Lifecycle.Read)
  @path
  @key("peeringName")
  @segment("peerings")
  name: string;
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

alias ExpressRouteCrossConnectionPeeringListOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the ExpressRouteCrossConnection (service key of the circuit). */
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
alias ExpressRouteCrossConnectionArpTablesOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the ExpressRouteCrossConnection (service key of the circuit). */
    @path
    @segment("expressRouteCrossConnections")
    @key
    crossConnectionName: string;

    /** The name of the peering. */
    @path
    @segment("peerings")
    @key
    peeringName: string;
  },
  {
    /** The path of the device. */
    @path
    @segment("arpTables")
    @key
    devicePath: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/arpTables/{devicePath}",
  }
>;

alias ExpressRouteCrossConnectionRouteTablesOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the ExpressRouteCrossConnection (service key of the circuit). */
    @path
    @segment("expressRouteCrossConnections")
    @key
    crossConnectionName: string;

    /** The name of the peering. */
    @path
    @segment("peerings")
    @key
    peeringName: string;
  },
  {
    /** The path of the device. */
    @path
    @segment("routeTables")
    @key
    devicePath: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTables/{devicePath}",
  }
>;

alias ExpressRouteCrossConnectionRouteTablesSummaryOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the ExpressRouteCrossConnection (service key of the circuit). */
    @path
    @segment("expressRouteCrossConnections")
    @key
    crossConnectionName: string;

    /** The name of the peering. */
    @path
    @segment("peerings")
    @key
    peeringName: string;
  },
  {
    /** The path of the device. */
    @path
    @segment("routeTablesSummary")
    @key
    devicePath: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTablesSummary/{devicePath}",
  }
>;

@doc("Azure operation completed successfully.")
model ExpressRouteCrossConnectionPeeringDeleteOkResult {
  /** The HTTP status code. */
  @statusCode statusCode: 200;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@featureFile(Features.expressRoute)
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface ExpressRouteCrossConnections {
  /**
   * Gets details about the specified ExpressRouteCrossConnection.
   */
  @tag("ExpressRouteCrossConnections")
  @autoRoute
  get is ArmResourceRead<ExpressRouteCrossConnection, Error = CloudError>;

  /**
   * Update the specified ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ExpressRouteCrossConnections")
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
  @tag("ExpressRouteCrossConnections")
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
  @tag("ExpressRouteCrossConnections")
  @autoRoute
  listByResourceGroup is ArmResourceListByParent<
    ExpressRouteCrossConnection,
    Error = CloudError
  >;

  /**
   * Retrieves all the ExpressRouteCrossConnections in a subscription.
   */
  @tag("ExpressRouteCrossConnections")
  @autoRoute
  list is ArmListBySubscriptionWithResourceName<
    ExpressRouteCrossConnection,
    OverrideResourceName = "ExpressRouteCrossConnection",
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
  @tag("ExpressRouteCrossConnectionArpTable")
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/arpTables/{devicePath}")
  listArpTable is ExpressRouteCrossConnectionArpTablesOps.ActionAsync<
    ExpressRouteCrossConnectionPeeringResource,
    void,
    void,
    Response =
      | ArmResponse<ExpressRouteCircuitsArpTableListResult>
      | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ExpressRouteCircuitsArpTableListResult> &
          Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError,
    OverrideResourceName = "ExpressRouteCrossConnectionPeering"
  >;

  /**
   * Gets the route table summary associated with the express route cross connection in a resource group.
   */
  @tag("ExpressRouteCrossConnectionRouteTableSummary")
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTablesSummary/{devicePath}")
  listRoutesTableSummary is ExpressRouteCrossConnectionRouteTablesSummaryOps.ActionAsync<
    ExpressRouteCrossConnectionPeeringResource,
    void,
    void,
    Response =
      | ArmResponse<ExpressRouteCrossConnectionsRoutesTableSummaryListResult>
      | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ExpressRouteCrossConnectionsRoutesTableSummaryListResult> &
          Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError,
    OverrideResourceName = "ExpressRouteCrossConnectionPeering"
  >;

  /**
   * Gets the currently advertised routes table associated with the express route cross connection in a resource group.
   */
  @tag("ExpressRouteCrossConnectionRouteTable")
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTables/{devicePath}")
  listRoutesTable is ExpressRouteCrossConnectionRouteTablesOps.ActionAsync<
    ExpressRouteCrossConnectionPeeringResource,
    void,
    void,
    Response =
      | ArmResponse<ExpressRouteCircuitsRoutesTableListResult>
      | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ExpressRouteCircuitsRoutesTableListResult> &
          Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError,
    OverrideResourceName = "ExpressRouteCrossConnectionPeering"
  >;

  /**
   * Gets all peerings in a specified ExpressRouteCrossConnection.
   */
  @tag("ExpressRouteCrossConnectionPeerings")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings")
  expressRouteCrossConnectionPeeringsList is ExpressRouteCrossConnectionPeeringListOps.List<
    ExpressRouteCrossConnectionPeeringResource,
    Response = ArmResponse<ExpressRouteCrossConnectionPeeringList>,
    OverrideErrorType = CloudError,
    OverrideRouteOptions = #{
      route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings",
    },
    OverrideResourceName = "ExpressRouteCrossConnectionPeering"
  >;

  /**
   * Deletes the specified peering from the ExpressRouteCrossConnection.
   */
  @tag("ExpressRouteCrossConnectionPeerings")
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}")
  delete is ExpressRouteCrossConnectionPeeringOps.DeleteWithoutOkAsync<
    ExpressRouteCrossConnectionPeeringResource,
    Response =
      | ExpressRouteCrossConnectionPeeringDeleteOkResult
      | ArmAcceptedLroResponse<LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
          ArmLroLocationHeader<FinalResult = void>>
      | NoContentResponse,
    OverrideErrorType = CloudError,
    OverrideResourceName = "ExpressRouteCrossConnectionPeering"
  >;

  /**
   * Gets the specified peering for the ExpressRouteCrossConnection.
   */
  @tag("ExpressRouteCrossConnectionPeerings")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}")
  expressRouteCrossConnectionPeeringsGet is ExpressRouteCrossConnectionPeeringOps.Read<
    ExpressRouteCrossConnectionPeeringResource,
    Response = ArmResponse<ExpressRouteCrossConnectionPeering>,
    OverrideErrorType = CloudError,
    OverrideResourceName = "ExpressRouteCrossConnectionPeering"
  >;

  /**
   * Creates or updates a peering in the specified ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ExpressRouteCrossConnectionPeerings")
  @put
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  expressRouteCrossConnectionPeeringsCreateOrUpdate is ExpressRouteCrossConnectionPeeringOps.CreateOrUpdateAsync<
    ExpressRouteCrossConnectionPeeringResource,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ExpressRouteCrossConnectionPeering> &
      Azure.Core.Foundations.RetryAfterHeader,
    Response =
      | ArmResponse<ExpressRouteCrossConnectionPeering>
      | ArmResourceCreatedResponse<
          ExpressRouteCrossConnectionPeering,
          LroHeaders = ArmAsyncOperationHeader<FinalResult = ExpressRouteCrossConnectionPeering> &
            Azure.Core.Foundations.RetryAfterHeader
        >,
    OverrideErrorType = CloudError,
    Request = ExpressRouteCrossConnectionPeering,
    OverrideResourceName = "ExpressRouteCrossConnectionPeering"
  >;

  /**
   * Validates express route circuit migration for a cross connection.
   */
  @tag("ExpressRouteCrossConnections")
  @action("validateCircuitMigration")
  @added(Versions.v2026_01_01)
  @Azure.Core.useFinalStateVia("location")
  validateCircuitMigration is ArmResourceActionAsync<
    ExpressRouteCrossConnection,
    MigrateExpressRouteCircuitValidateAndHealthCheckRequest,
    MigrateExpressRouteCircuitValidateResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = MigrateExpressRouteCircuitValidateResponse>,
    Error = CloudError
  >;

  /**
   * Gets migration health information for an express route circuit cross connection.
   */
  @tag("ExpressRouteCrossConnections")
  @action("getCircuitMigrationInfo")
  @added(Versions.v2026_01_01)
  @Azure.Core.useFinalStateVia("location")
  getCircuitMigrationInfo is ArmResourceActionAsync<
    ExpressRouteCrossConnection,
    MigrateExpressRouteCircuitValidateAndHealthCheckRequest,
    MigrateExpressRouteCircuitHealthCheckResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = MigrateExpressRouteCircuitHealthCheckResponse>,
    Error = CloudError
  >;

  /**
   * Prepares an express route circuit migration for a cross connection.
   */
  @tag("ExpressRouteCrossConnections")
  @action("prepareCircuitMigration")
  @added(Versions.v2026_01_01)
  @Azure.Core.useFinalStateVia("location")
  prepareCircuitMigration is ArmResourceActionAsync<
    ExpressRouteCrossConnection,
    MigrateExpressRouteCircuitRequest,
    MigrateExpressRouteCircuitHealthCheckResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = MigrateExpressRouteCircuitHealthCheckResponse>,
    Error = CloudError
  >;

  /**
   * Shuts down BGP sessions as part of an express route circuit migration for a cross connection.
   */
  @tag("ExpressRouteCrossConnections")
  @action("shutDownBgpForCircuitMigration")
  @added(Versions.v2026_01_01)
  @Azure.Core.useFinalStateVia("location")
  shutDownBgpForCircuitMigration is ArmResourceActionAsync<
    ExpressRouteCrossConnection,
    MigrateExpressRouteCircuitRequest,
    MigrateExpressRouteCircuitHealthCheckResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = MigrateExpressRouteCircuitHealthCheckResponse>,
    Error = CloudError
  >;

  /**
   * Restores BGP sessions as part of an express route circuit migration for a cross connection.
   */
  @tag("ExpressRouteCrossConnections")
  @action("restoreBgpForCircuitMigration")
  @added(Versions.v2026_01_01)
  @Azure.Core.useFinalStateVia("location")
  restoreBgpForCircuitMigration is ArmResourceActionAsync<
    ExpressRouteCrossConnection,
    MigrateExpressRouteCircuitRequest,
    MigrateExpressRouteCircuitHealthCheckResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = MigrateExpressRouteCircuitHealthCheckResponse>,
    Error = CloudError
  >;

  /**
   * Executes the express route circuit migration for a cross connection.
   */
  @tag("ExpressRouteCrossConnections")
  @action("migrateCircuit")
  @added(Versions.v2026_01_01)
  @Azure.Core.useFinalStateVia("location")
  migrateCircuit is ArmResourceActionAsync<
    ExpressRouteCrossConnection,
    MigrateExpressRouteCircuitRequest,
    MigrateExpressRouteCircuitHealthCheckResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = MigrateExpressRouteCircuitHealthCheckResponse>,
    Error = CloudError
  >;

  /**
   * Commits the express route circuit migration for a cross connection.
   */
  @tag("ExpressRouteCrossConnections")
  @action("commitCircuitMigration")
  @added(Versions.v2026_01_01)
  @Azure.Core.useFinalStateVia("location")
  commitCircuitMigration is ArmResourceActionAsync<
    ExpressRouteCrossConnection,
    MigrateExpressRouteCircuitRequest,
    MigrateExpressRouteCircuitHealthCheckResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = MigrateExpressRouteCircuitHealthCheckResponse>,
    Error = CloudError
  >;

  /**
   * Rolls back the express route circuit migration for a cross connection.
   */
  @tag("ExpressRouteCrossConnections")
  @action("rollbackCircuitMigration")
  @added(Versions.v2026_01_01)
  @Azure.Core.useFinalStateVia("location")
  rollbackCircuitMigration is ArmResourceActionAsync<
    ExpressRouteCrossConnection,
    MigrateExpressRouteCircuitRequest,
    MigrateExpressRouteCircuitHealthCheckResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = MigrateExpressRouteCircuitHealthCheckResponse>,
    Error = CloudError
  >;
}

@@doc(
  ExpressRouteCrossConnection.name,
  "The name of the ExpressRouteCrossConnection (service key of the circuit)."
);
@@doc(
  ExpressRouteCrossConnection.properties,
  "Properties of the express route cross connection."
);
@@doc(
  ExpressRouteCrossConnections.createOrUpdate::parameters.resource,
  "Parameters supplied to the update express route crossConnection operation."
);
@@doc(
  ExpressRouteCrossConnections.updateTags::parameters.properties,
  "Parameters supplied to update express route cross connection tags."
);
@@doc(
  ExpressRouteCrossConnections.expressRouteCrossConnectionPeeringsCreateOrUpdate::parameters.resource,
  "Parameters supplied to the create or update ExpressRouteCrossConnection peering operation."
);
@@doc(
  ExpressRouteCrossConnections.validateCircuitMigration::parameters.body,
  "Parameters supplied to validate express route circuit migration."
);
@@doc(
  ExpressRouteCrossConnections.getCircuitMigrationInfo::parameters.body,
  "Parameters supplied to get express route circuit migration information."
);
@@doc(
  ExpressRouteCrossConnections.prepareCircuitMigration::parameters.body,
  "Parameters supplied to prepare the express route circuit migration."
);
@@doc(
  ExpressRouteCrossConnections.shutDownBgpForCircuitMigration::parameters.body,
  "Parameters supplied to shut down BGP for the express route circuit migration."
);
@@doc(
  ExpressRouteCrossConnections.restoreBgpForCircuitMigration::parameters.body,
  "Parameters supplied to restore BGP for the express route circuit migration."
);
@@doc(
  ExpressRouteCrossConnections.migrateCircuit::parameters.body,
  "Parameters supplied to execute the express route circuit migration."
);
@@doc(
  ExpressRouteCrossConnections.commitCircuitMigration::parameters.body,
  "Parameters supplied to commit the express route circuit migration."
);
@@doc(
  ExpressRouteCrossConnections.rollbackCircuitMigration::parameters.body,
  "Parameters supplied to roll back the express route circuit migration."
);
