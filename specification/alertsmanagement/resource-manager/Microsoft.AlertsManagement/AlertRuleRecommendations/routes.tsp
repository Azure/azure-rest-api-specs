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

namespace Microsoft.AlertsManagement;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AlertRuleRecommendationsOperationGroup {
  /**
   * Retrieve alert rule recommendations for a resource.
   */
  @autoRoute
  @get
  @action("alertRuleRecommendations")
  @list
  listByResource is ArmProviderActionSync<
    Response = AlertRuleRecommendationsListResponse,
    Scope = ExtensionResourceActionScope
  >;
  /**
   * Retrieve alert rule recommendations for a target type.
   */
  @autoRoute
  @get
  @action("alertRuleRecommendations")
  @list
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
