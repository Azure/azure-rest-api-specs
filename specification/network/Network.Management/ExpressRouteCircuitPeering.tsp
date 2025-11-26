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
@parentResource(ExpressRouteCircuit)
model ExpressRouteCircuitPeering
  is Azure.ResourceManager.ProxyResource<ExpressRouteCircuitPeeringPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ExpressRouteCircuitPeering,
    KeyName = "peeringName",
    SegmentName = "peerings",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias ArpTablesgOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

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
  }
>;

alias RouteTablesOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

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
  }
>;

alias RouteTablesSummaryOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

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
  }
>;

@armResourceOperations
interface ExpressRouteCircuitPeerings {
  /**
   * Gets the specified peering for the express route circuit.
   */
  get is ArmResourceRead<ExpressRouteCircuitPeering, Error = CloudError>;

  /**
   * Creates or updates a peering in the specified express route circuits.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExpressRouteCircuitPeering,
    Error = CloudError
  >;

  /**
   * Deletes the specified peering from the specified express route circuit.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRouteCircuitPeering,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all peerings in a specified express route circuit.
   */
  list is ArmResourceListByParent<
    ExpressRouteCircuitPeering,
    Error = CloudError
  >;

  /**
   * Gets the currently advertised ARP table associated with the express route circuit in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCircuits_ListArpTable")
  @post
  listArpTable is ArpTablesgOps.Read<
    ExpressRouteCircuitPeering,
    Response = ArmResponse<ExpressRouteCircuitsArpTableListResult> | ArmAcceptedLroResponse
  >;

  /**
   * Gets the currently advertised routes table associated with the express route circuit in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCircuits_ListRoutesTable")
  @post
  listRoutesTable is RouteTablesOps.Read<
    ExpressRouteCircuitPeering,
    Response = ArmResponse<ExpressRouteCircuitsRoutesTableListResult> | ArmAcceptedLroResponse
  >;

  /**
   * Gets the currently advertised routes table summary associated with the express route circuit in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCircuits_ListRoutesTableSummary")
  @post
  listRoutesTableSummary is RouteTablesSummaryOps.Read<
    ExpressRouteCircuitPeering,
    Response = ArmResponse<ExpressRouteCircuitsRoutesTableSummaryListResult> | ArmAcceptedLroResponse
  >;

  /**
   * Gets all stats from an express route circuit in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCircuits_GetPeeringStats")
  @get
  @action("stats")
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
