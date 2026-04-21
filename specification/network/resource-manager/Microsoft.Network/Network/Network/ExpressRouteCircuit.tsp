import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Network;
/**
 * ExpressRouteCircuit resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ExpressRouteCircuit extends Common.Resource {
  properties?: ExpressRouteCircuitPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("circuitName")
  @segment("expressRouteCircuits")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ExpressRouteCircuitSku;
}

alias CircuitLinkFailoverOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
  },
  {
    /** The name of the express route circuit. */
    @path
    @segment("expressRouteCircuits")
    @key
    expressRouteCircuitName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{expressRouteCircuitName}",
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface ExpressRouteCircuits {
  /**
   * Gets information about the specified express route circuit.
   */
  @tag("ExpressRouteCircuits")
  get is ArmResourceRead<ExpressRouteCircuit, Error = CloudError>;

  /**
   * Creates or updates an express route circuit.
   */
  @tag("ExpressRouteCircuits")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExpressRouteCircuit,
    Error = CloudError
  >;

  /**
   * Updates an express route circuit tags.
   */
  @tag("ExpressRouteCircuits")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ExpressRouteCircuit,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified express route circuit.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ExpressRouteCircuits")
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRouteCircuit,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the express route circuits in a resource group.
   */
  @tag("ExpressRouteCircuits")
  list is ArmResourceListByParent<ExpressRouteCircuit, Error = CloudError>;

  /**
   * Gets all the express route circuits in a subscription.
   */
  @tag("ExpressRouteCircuits")
  listAll is ArmListBySubscription<ExpressRouteCircuit, Error = CloudError>;

  /**
   * Gets all the stats from an express route circuit in a resource group.
   */
  @tag("ExpressRouteCircuitStats")
  @get
  @action("stats")
  getStats is ArmResourceActionSync<
    ExpressRouteCircuit,
    void,
    ArmResponse<ExpressRouteCircuitStats>,
    Error = CloudError
  >;

  /**
   * This operation retrieves the details of all the failover tests performed on the ExpressRoute circuit for different peering locations
   */
  @tag("ExpressRouteCircuits")
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{expressRouteCircuitName}/getCircuitLinkFailoverAllTestsDetails")
  getCircuitLinkFailoverAllTestsDetails is CircuitLinkFailoverOps.ActionAsync<
    ExpressRouteCircuit,
    void,
    void,
    Response = ArmResponse<ExpressRouteCircuitLinkFailoverAllTestsDetails> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ExpressRouteCircuitLinkFailoverAllTestsDetails> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Parameters = {
      /**
       * The type of failover test
       */
      @query("failoverTestType")
      failoverTestType: ExpressRouteFailoverTestType;

      /**
       * Fetch only the latest tests for each peering location
       */
      @query("fetchLatest")
      fetchLatest: boolean;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * This operation retrieves the details of a particular failover test performed on the circuit based on the test Guid
   */
  @tag("ExpressRouteCircuits")
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{expressRouteCircuitName}/getCircuitLinkFailoverSingleTestDetails")
  getCircuitLinkFailoverSingleTestDetails is CircuitLinkFailoverOps.ActionAsync<
    ExpressRouteCircuit,
    void,
    void,
    Response = ArmResponse<ExpressRouteCircuitLinkFailoverSingleTestDetailsObject> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ExpressRouteCircuitLinkFailoverSingleTestDetailsObject> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Parameters = {
      /**
       * The unique Guid value which identifies the test
       */
      @query("failoverTestId")
      failoverTestId: string;

      /**
       * The type of link on which failover test was performed
       */
      @query("linkType")
      linkType: ExpressRouteFailoverLinkType;

      /**
       * The type of maintenance test category
       */
      @query("circuitMaintenanceCategory")
      circuitMaintenanceCategory: MaintenanceTestCategory;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * This operation starts failover simulation on the circuit for the specified link type
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Matching existing swagger response"
  @tag("ExpressRouteCircuits")
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{expressRouteCircuitName}/startCircuitLinkFailoverTest")
  startCircuitLinkFailoverTest is CircuitLinkFailoverOps.ActionAsync<
    ExpressRouteCircuit,
    void,
    void,
    Response = ArmResponse<{
      @body body: {};
    }> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    Parameters = {
      /**
       * The type of link on which failover test was performed
       */
      @query("linkType")
      linkType: ExpressRouteFailoverLinkType;

      /**
       * The type of maintenance that can occur during an ExpressRoute Circuit failover test
       */
      @query("circuitMaintenanceCategory")
      circuitMaintenanceCategory: MaintenanceTestCategory;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * This operation stops an ongoing failover simulation on the circuit for the specified link type
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Matching existing swagger response"
  @tag("ExpressRouteCircuits")
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{expressRouteCircuitName}/stopCircuitLinkFailoverTest")
  stopCircuitLinkFailoverTest is CircuitLinkFailoverOps.ActionAsync<
    ExpressRouteCircuit,
    ExpressRouteLinkFailoverStopApiParameters,
    void,
    Response = ArmResponse<{
      @body body: {};
    }> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;
}

@@doc(ExpressRouteCircuit.name, "The name of express route circuit.");
@@doc(ExpressRouteCircuit.properties,
  "Properties of the express route circuit."
);
@@doc(ExpressRouteCircuits.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update express route circuit operation."
);
@@doc(ExpressRouteCircuits.updateTags::parameters.properties,
  "Parameters supplied to update express route circuit tags."
);
@@doc(ExpressRouteCircuits.stopCircuitLinkFailoverTest::parameters.body,
  "ExpressRoute Circuit stop simulation parameters supplied to stop failover simulation on express route circuit."
);
