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

@armResourceOperations
interface ExpressRouteCircuitPeerings {
  /**
   * Gets the specified peering for the express route circuit.
   */
  get is ArmResourceRead<ExpressRouteCircuitPeering>;

  /**
   * Creates or updates a peering in the specified express route circuits.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExpressRouteCircuitPeering>;

  /**
   * Deletes the specified peering from the specified express route circuit.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRouteCircuitPeering,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all peerings in a specified express route circuit.
   */
  list is ArmResourceListByParent<ExpressRouteCircuitPeering>;

  /**
   * Gets the currently advertised ARP table associated with the express route circuit in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCircuits_ListArpTable")
  @list
  @action("/arpTables/{devicePath}")
  listArpTable is ArmResourceActionAsync<
    ExpressRouteCircuitPeering,
    void,
    ArmResponse<ExpressRouteCircuitsArpTableListResult>,
    Parameters = {
      /**
       * The path of the device.
       */
      @path
      devicePath: string;
    }
  >;

  /**
   * Gets the currently advertised routes table associated with the express route circuit in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCircuits_ListRoutesTable")
  @list
  @action("/routeTables/{devicePath}")
  listRoutesTable is ArmResourceActionAsync<
    ExpressRouteCircuitPeering,
    void,
    ArmResponse<ExpressRouteCircuitsRoutesTableListResult>,
    Parameters = {
      /**
       * The path of the device.
       */
      @path
      devicePath: string;
    }
  >;

  /**
   * Gets the currently advertised routes table summary associated with the express route circuit in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCircuits_ListRoutesTableSummary")
  @list
  @action("/routeTablesSummary/{devicePath}")
  listRoutesTableSummary is ArmResourceActionAsync<
    ExpressRouteCircuitPeering,
    void,
    ArmResponse<ExpressRouteCircuitsRoutesTableSummaryListResult>,
    Parameters = {
      /**
       * The path of the device.
       */
      @path
      devicePath: string;
    }
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
    ArmResponse<ExpressRouteCircuitStats>
  >;
}

@@doc(ExpressRouteCircuitPeering.name, "The name of the peering.");
@@doc(ExpressRouteCircuitPeering.properties,
  "Properties of the express route circuit peering."
);
@@doc(ExpressRouteCircuitPeerings.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update express route circuit peering operation."
);
