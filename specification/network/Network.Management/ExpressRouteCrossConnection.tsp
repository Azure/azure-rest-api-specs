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

@armResourceOperations
interface ExpressRouteCrossConnections {
  /**
   * Gets details about the specified ExpressRouteCrossConnection.
   */
  get is ArmResourceRead<ExpressRouteCrossConnection>;

  /**
   * Update the specified ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExpressRouteCrossConnection,
    Response = ArmResourceUpdatedResponse<ExpressRouteCrossConnection>
  >;

  /**
   * Updates an express route cross connection tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ExpressRouteCrossConnection,
    PatchModel = TagsObject
  >;

  /**
   * Retrieves all the ExpressRouteCrossConnections in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<ExpressRouteCrossConnection>;

  /**
   * Retrieves all the ExpressRouteCrossConnections in a subscription.
   */
  list is ArmListBySubscription<
    ExpressRouteCrossConnection,
    Parameters = {
      /**
       * The filter to apply on the operation. For example, you can use $filter=name eq '{circuitServiceKey}'.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Gets the currently advertised ARP table associated with the express route cross connection in a resource group.
   */
  @list
  @action("/arpTables/{devicePath}")
  listArpTable is ArmResourceActionAsync<
    ExpressRouteCrossConnection,
    void,
    ArmResponse<ExpressRouteCircuitsArpTableListResult>,
    Parameters = {
      /**
       * The name of the peering.
       */
      @path
      peeringName: string;

      /**
       * The path of the device.
       */
      @path
      devicePath: string;
    }
  >;

  /**
   * Gets the route table summary associated with the express route cross connection in a resource group.
   */
  @list
  @action("/routeTablesSummary/{devicePath}")
  listRoutesTableSummary is ArmResourceActionAsync<
    ExpressRouteCrossConnection,
    void,
    ArmResponse<ExpressRouteCrossConnectionsRoutesTableSummaryListResult>,
    Parameters = {
      /**
       * The name of the peering.
       */
      @path
      peeringName: string;

      /**
       * The path of the device.
       */
      @path
      devicePath: string;
    }
  >;

  /**
   * Gets the currently advertised routes table associated with the express route cross connection in a resource group.
   */
  @list
  @action("/routeTables/{devicePath}")
  listRoutesTable is ArmResourceActionAsync<
    ExpressRouteCrossConnection,
    void,
    ArmResponse<ExpressRouteCircuitsRoutesTableListResult>,
    Parameters = {
      /**
       * The name of the peering.
       */
      @path
      peeringName: string;

      /**
       * The path of the device.
       */
      @path
      devicePath: string;
    }
  >;

  /**
   * Gets all peerings in a specified ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCrossConnectionPeerings_List")
  @list
  @get
  @action("peerings")
  expressRouteCrossConnectionPeeringsList is ArmResourceActionSync<
    ExpressRouteCrossConnection,
    void,
    ArmResponse<ExpressRouteCrossConnectionPeeringList>
  >;

  /**
   * Deletes the specified peering from the ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCrossConnectionPeerings_Delete")
  @delete
  @action("{peeringName}")
  delete is ArmResourceActionAsync<
    ExpressRouteCrossConnection,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * The name of the peering.
       */
      @path
      peeringName: string;
    }
  >;

  /**
   * Gets the specified peering for the ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCrossConnectionPeerings_Get")
  @get
  @action("{peeringName}")
  expressRouteCrossConnectionPeeringsGet is ArmResourceActionSync<
    ExpressRouteCrossConnection,
    void,
    ArmResponse<ExpressRouteCrossConnectionPeering>,
    Parameters = {
      /**
       * The name of the peering.
       */
      @path
      peeringName: string;
    }
  >;

  /**
   * Creates or updates a peering in the specified ExpressRouteCrossConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteCrossConnectionPeerings_CreateOrUpdate")
  @put
  @action("{peeringName}")
  expressRouteCrossConnectionPeeringsCreateOrUpdate is ArmResourceActionAsyncBase<
    ExpressRouteCrossConnection,
    ExpressRouteCrossConnectionPeering,
    ArmResponse<ExpressRouteCrossConnectionPeering> | ArmResourceCreatedResponse<ExpressRouteCrossConnectionPeering>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ExpressRouteCrossConnection>,
    Parameters = {
      /**
       * The name of the peering.
       */
      @path
      peeringName: string;
    }
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
