// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace AlertRuleRecommendationsClient;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AlertRuleRecommendationsOperationGroup {
  /**
   * Retrieve alert rule recommendations for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AlertRuleRecommendations_ListByResource")
  @autoRoute
  @get
  @action("alertRuleRecommendations")
  listByResource is ArmProviderActionSync<
    Response = AlertRuleRecommendationsListResponse,
    Scope = ExtensionResourceActionScope
  >;
  /**
   * Retrieve alert rule recommendations for a target type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AlertRuleRecommendations_ListByTargetType")
  @autoRoute
  @get
  @action("alertRuleRecommendations")
  listByTargetType is ArmProviderActionSync<
    Response = AlertRuleRecommendationsListResponse,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The recommendations target type.
       */
      @query("targetType")
      targetType: string;
    }
  >;
}
