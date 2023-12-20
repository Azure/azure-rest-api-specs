import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Describes the suppression rule")
@subscriptionResource
model SecurityAlertsSuppressionRule
  is ProxyResource<AlertsSuppressionRuleProperties> {
  @doc("The unique name of the suppression alert rule")
  @path
  @key("alertsSuppressionRuleName")
  @segment("alertsSuppressionRules")
  name: string;
}

@armResourceOperations
interface SecurityAlertsSuppressionRules {
  @doc("Get dismiss rule, with name: {alertsSuppressionRuleName}, for the given subscription")
  get is ArmResourceRead<SecurityAlertsSuppressionRule>;
  @doc("Update existing rule or create new rule if it doesn't exist")
  update is ArmResourceCreateOrReplaceSync<SecurityAlertsSuppressionRule>;
  @doc("Delete dismiss alert rule for this subscription.")
  delete is ArmResourceDeleteSync<SecurityAlertsSuppressionRule>;
  @doc("List of all the dismiss rules for the given subscription")
  list is ArmResourceListByParent<
    SecurityAlertsSuppressionRule,
    {
      ...BaseParameters<SecurityAlertsSuppressionRule>;

      @doc("Type of the alert to get rules for")
      @query("AlertType")
      AlertType?: string;
    }
  >;
}
