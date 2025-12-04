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
model RouteFilter
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<RouteFilterPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = RouteFilter,
    KeyName = "routeFilterName",
    SegmentName = "routeFilters",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias RouteFilterRuleOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

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
  }
>;
@armResourceOperations
interface RouteFilters {
  /**
   * Gets the specified route filter.
   */
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RouteFilter,
    Error = CloudError
  >;

  /**
   * Updates tags of a route filter.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    RouteFilter,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified route filter.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    RouteFilter,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all route filters in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    RouteFilter,
    Error = CloudError
  >;

  /**
   * Gets all route filters in a subscription.
   */
  list is ArmListBySubscription<RouteFilter, Error = CloudError>;

  /**
   * Deletes the specified rule from a route filter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RouteFilterRules_Delete")
  @delete
  @Azure.Core.useFinalStateVia("azure-async-operation")
  routeFilterRulesDelete is RouteFilterRuleOps.DeleteWithoutOkAsync<
    RouteFilter,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets the specified rule from a route filter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RouteFilterRules_Get")
  @get
  routeFilterRulesGet is RouteFilterRuleOps.Read<
    RouteFilter,
    Response = ArmResponse<RouteFilterRule>,
    OverrideErrorType = CloudError
  >;

  /**
   * Creates or updates a route in the specified route filter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RouteFilterRules_CreateOrUpdate")
  @put
  @Azure.Core.useFinalStateVia("azure-async-operation")
  routeFilterRulesCreateOrUpdate is RouteFilterRuleOps.CreateOrUpdateAsync<
    RouteFilter,
    Response = ArmResponse<RouteFilterRule> | ArmResourceCreatedResponse<RouteFilterRule>,
    Request = RouteFilterRule,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets all RouteFilterRules in a route filter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RouteFilterRules_ListByRouteFilter")
  @list
  @get
  listByRouteFilter is RouteFilterRuleOps.List<
    RouteFilter,
    Response = ArmResponse<RouteFilterRuleListResult>,
    OverrideErrorType = CloudError
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
@@doc(RouteFilters.routeFilterRulesCreateOrUpdate::parameters.resource,
  "Parameters supplied to the create or update route filter rule operation."
);
