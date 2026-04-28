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

namespace AlertsSuppressionRulesAPI;
/**
 * Describes the suppression rule
 */
@subscriptionResource
model AlertsSuppressionRule
  is Azure.ResourceManager.ProxyResource<AlertsSuppressionRuleProperties> {
  ...ResourceNameParameter<
    Resource = AlertsSuppressionRule,
    KeyName = "alertsSuppressionRuleName",
    SegmentName = "alertsSuppressionRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AlertsSuppressionRules {
  /**
   * Get dismiss rule, with name: {alertsSuppressionRuleName}, for the given subscription
   */
  get is ArmResourceRead<
    AlertsSuppressionRule,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Update existing rule or create new rule if it doesn't exist
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  update is ArmResourceCreateOrReplaceSync<
    AlertsSuppressionRule,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResourceUpdatedResponse<AlertsSuppressionRule>,
    Error = CloudError
  >;

  /**
   * Delete dismiss alert rule for this subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<
    AlertsSuppressionRule,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * List of all the dismiss rules for the given subscription
   */
  list is ArmResourceListByParent<
    AlertsSuppressionRule,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * Type of the alert to get rules for
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("AlertType")
      AlertType?: string;
    },
    Response = ArmResponse<AlertsSuppressionRulesList>,
    Error = CloudError
  >;
}

@@doc(AlertsSuppressionRule.name,
  "The unique name of the suppression alert rule"
);
@@doc(AlertsSuppressionRule.properties,
  "describes AlertsSuppressionRule properties"
);
@@doc(AlertsSuppressionRules.update::parameters.resource,
  "Suppression rule object"
);
