import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ExpressRouteCircuit.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Peering in an ExpressRouteCircuit resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@parentResource(ExpressRouteCircuit)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ExpressRouteCircuitPeering extends SubResourceModel {
  properties?: ExpressRouteCircuitPeeringPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("peeringName")
  @segment("peerings")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias ArpTablesgOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the express route port. */
    @path
    @segment("expressRouteCircuits")
    @key
    circuitName: string;

    /** The name of the peering. */
    @path
    @segment("peerings")
    @key
    peeringName: string;
  },
  {
    /** The name of the arpTables. */
    @path
    @segment("arpTables")
    @key
    devicePath: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/arpTables/{devicePath}",
  }
>;

alias RouteTablesOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the express route port. */
    @path
    @segment("expressRouteCircuits")
    @key
    circuitName: string;

    /** The name of the peering. */
    @path
    @segment("peerings")
    @key
    peeringName: string;
  },
  {
    /** The name of the routeTables. */
    @path
    @segment("routeTables")
    @key
    devicePath: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTables/{devicePath}",
  }
>;

alias RouteTablesSummaryOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the express route port. */
    @path
    @segment("expressRouteCircuits")
    @key
    circuitName: string;

    /** The name of the peering. */
    @path
    @segment("peerings")
    @key
    peeringName: string;
  },
  {
    /** The name of the routeTablesSummary. */
    @path
    @segment("routeTablesSummary")
    @key
    devicePath: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTablesSummary/{devicePath}",
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations(#{ allowStaticRoutes: true })
interface ExpressRouteCircuitPeerings {
  /**
   * Gets the specified peering for the express route circuit.
   */
  @autoRoute
  get is ArmResourceRead<ExpressRouteCircuitPeering, Error = CloudError>;

  /**
   * Creates or updates a peering in the specified express route circuits.
   */
  @autoRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExpressRouteCircuitPeering,
    Error = CloudError
  >;

  /**
   * Deletes the specified peering from the specified express route circuit.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRouteCircuitPeering,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all peerings in a specified express route circuit.
   */
  @autoRoute
  list is ArmResourceListByParent<
    ExpressRouteCircuitPeering,
    Error = CloudError
  >;

  /**
   * Gets the currently advertised ARP table associated with the express route circuit in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteCircuits_ListArpTable")
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/arpTables/{devicePath}")
  listArpTable is ArpTablesgOps.ActionAsync<
    ExpressRouteCircuitPeering,
    void,
    void,
    Response = ArmResponse<ExpressRouteCircuitsArpTableListResult> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ExpressRouteCircuitsArpTableListResult> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets the currently advertised routes table associated with the express route circuit in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteCircuits_ListRoutesTable")
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTables/{devicePath}")
  listRoutesTable is RouteTablesOps.ActionAsync<
    ExpressRouteCircuitPeering,
    void,
    void,
    Response = ArmResponse<ExpressRouteCircuitsRoutesTableListResult> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ExpressRouteCircuitsRoutesTableListResult> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets the currently advertised routes table summary associated with the express route circuit in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteCircuits_ListRoutesTableSummary")
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTablesSummary/{devicePath}")
  listRoutesTableSummary is RouteTablesSummaryOps.ActionAsync<
    ExpressRouteCircuitPeering,
    void,
    void,
    Response = ArmResponse<ExpressRouteCircuitsRoutesTableSummaryListResult> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ExpressRouteCircuitsRoutesTableSummaryListResult> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets all stats from an express route circuit in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteCircuits_GetPeeringStats")
  @get
  @action("stats")
  @autoRoute
  getPeeringStats is ArmResourceActionSync<
    ExpressRouteCircuitPeering,
    void,
    ArmResponse<ExpressRouteCircuitStats>,
    Error = CloudError
  >;
}

@@doc(ExpressRouteCircuitPeering.name, "The name of the peering.");
@@doc(ExpressRouteCircuitPeering.properties,
  "Properties of the express route circuit peering."
);
@@doc(ExpressRouteCircuitPeerings.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update express route circuit peering operation."
);
