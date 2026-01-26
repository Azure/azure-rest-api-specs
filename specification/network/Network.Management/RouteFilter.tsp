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
 * Route Filter Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@Http.Private.includeInapplicableMetadataInPayload(false)
model RouteFilter extends ResourceWithRequiredLocation {
  properties?: RouteFilterPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("routeFilterName")
  @segment("routeFilters")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias RouteFilterRuleOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the route filter. */
    @path
    @segment("routeFilters")
    @key
    routeFilterName: string;
  },
  {
    /** The name of the route filter rule. */
    @path
    @segment("routeFilterRules")
    @key
    ruleName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}",
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations(#{ allowStaticRoutes: true })
interface RouteFilters {
  /**
   * Gets the specified route filter.
   */
  @autoRoute
  get is ArmResourceRead<
    RouteFilter,
    Parameters = {
      /**
       * Expands referenced express route bgp peering resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
  >;

  /**
   * Creates or updates a route filter in a specified resource group.
   */
  @autoRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RouteFilter,
    Error = CloudError
  >;

  /**
   * Updates tags of a route filter.
   */
  @autoRoute
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    RouteFilter,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified route filter.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @autoRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    RouteFilter,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all route filters in a resource group.
   */
  @autoRoute
  listByResourceGroup is ArmResourceListByParent<
    RouteFilter,
    Error = CloudError
  >;

  /**
   * Gets all route filters in a subscription.
   */
  @autoRoute
  list is ArmListBySubscription<RouteFilter, Error = CloudError>;

  /**
   * Deletes the specified rule from a route filter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("RouteFilterRules_Delete")
  @delete
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}")
  routeFilterRulesDelete is RouteFilterRuleOps.ActionAsync<
    RouteFilter,
    void,
    void,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = {
      @body body: void;
    } | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets the specified rule from a route filter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("RouteFilterRules_Get")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}")
  routeFilterRulesGet is RouteFilterRuleOps.ActionSync<
    RouteFilter,
    void,
    Response = ArmResponse<RouteFilterRule>,
    OverrideErrorType = CloudError
  >;

  /**
   * Creates or updates a route in the specified route filter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("RouteFilterRules_CreateOrUpdate")
  @put
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}")
  routeFilterRulesCreateOrUpdate is RouteFilterRuleOps.ActionAsync<
    RouteFilter,
    RouteFilterRule,
    void,
    Response = ArmResponse<RouteFilterRule> | ArmResourceCreatedResponse<
      RouteFilterRule,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = RouteFilterRule> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets all RouteFilterRules in a route filter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("RouteFilterRules_ListByRouteFilter")
  @list
  @get
  @autoRoute
  @action("routeFilterRules")
  listByRouteFilter is ArmResourceActionSync<
    RouteFilter,
    void,
    ArmResponse<RouteFilterRuleListResult>
  >;
}

@@doc(RouteFilter.name, "The name of the route filter.");
@@doc(RouteFilter.properties, "Properties of the route filter.");
@@doc(RouteFilters.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update route filter operation."
);
@@doc(RouteFilters.updateTags::parameters.properties,
  "Parameters supplied to update route filter tags."
);
@@doc(RouteFilters.routeFilterRulesCreateOrUpdate::parameters.body,
  "Parameters supplied to the create or update route filter rule operation."
);
