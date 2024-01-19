import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
@doc("Describes the suppression rule")
@subscriptionResource
model AlertsSuppressionRule is ProxyResource<AlertsSuppressionRuleProperties> {
  @doc("The unique name of the suppression alert rule")
  @path
  @key("alertsSuppressionRuleName")
  @segment("alertsSuppressionRules")
  name: string;
}

@armResourceOperations
interface AlertsSuppressionRules {
  @doc("Get dismiss rule, with name: {alertsSuppressionRuleName}, for the given subscription")
  get is ArmResourceRead<AlertsSuppressionRule>;

  @doc("Update existing rule or create new rule if it doesn't exist")
  update is ArmResourceCreateOrReplaceSync<AlertsSuppressionRule>;

  @doc("Delete dismiss alert rule for this subscription.")
  delete is ArmResourceDeleteSync<AlertsSuppressionRule>;

  @doc("List of all the dismiss rules for the given subscription")
  list is ArmResourceListByParent<
    AlertsSuppressionRule,
    {
      ...BaseParameters<AlertsSuppressionRule>;

      @doc("Type of the alert to get rules for")
      @query("AlertType")
      AlertType?: string;
    }
  >;
}

@@projectedName(AlertsSuppressionRules.update::parameters.resource,
  "json",
  "alertsSuppressionRule"
);
@@extension(AlertsSuppressionRules.update::parameters.resource,
  "x-ms-client-name",
  "alertsSuppressionRule"
);
@@doc(AlertsSuppressionRules.update::parameters.resource,
  "Suppression rule object"
);
