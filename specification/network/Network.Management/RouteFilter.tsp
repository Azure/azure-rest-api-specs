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
    }
  >;

  /**
   * Creates or updates a route filter in a specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<RouteFilter>;

  /**
   * Updates tags of a route filter.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<RouteFilter, PatchModel = TagsObject>;

  /**
   * Deletes the specified route filter.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    RouteFilter,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all route filters in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<RouteFilter>;

  /**
   * Gets all route filters in a subscription.
   */
  list is ArmListBySubscription<RouteFilter>;

  /**
   * Deletes the specified rule from a route filter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RouteFilterRules_Delete")
  @delete
  @action("{ruleName}")
  routeFilterRulesDelete is ArmResourceActionAsync<
    RouteFilter,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * The name of the rule.
       */
      @path
      ruleName: string;
    },
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets the specified rule from a route filter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RouteFilterRules_Get")
  @get
  @action("{ruleName}")
  routeFilterRulesGet is ArmResourceActionSync<
    RouteFilter,
    void,
    ArmResponse<RouteFilterRule>,
    Parameters = {
      /**
       * The name of the rule.
       */
      @path
      ruleName: string;
    }
  >;

  /**
   * Creates or updates a route in the specified route filter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RouteFilterRules_CreateOrUpdate")
  @put
  @action("{ruleName}")
  routeFilterRulesCreateOrUpdate is ArmResourceActionAsyncBase<
    RouteFilter,
    RouteFilterRule,
    ArmResponse<RouteFilterRule> | ArmResourceCreatedResponse<RouteFilterRule>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<RouteFilter>,
    Parameters = {
      /**
       * The name of the route filter rule.
       */
      @path
      ruleName: string;
    }
  >;

  /**
   * Gets all RouteFilterRules in a route filter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RouteFilterRules_ListByRouteFilter")
  @list
  @get
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
