import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;

model AutomationRule
  is Azure.ResourceManager.ProxyResource<AutomationRuleProperties, false> {
  ...ResourceNameParameter<
    Resource = AutomationRule,
    KeyName = "automationRuleId",
    SegmentName = "automationRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AutomationRules {
  /**
   * Gets the automation rule.
   */
  get is Extension.Read<
    OperationalInsights,
    AutomationRule,
    Error = CloudError
  >;

  /**
   * Creates or updates the automation rule.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    AutomationRule,
    Error = CloudError
  >;

  /**
   * Delete the automation rule.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    AutomationRule,
    Error = CloudError
  >;

  /**
   * Gets all automation rules.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    AutomationRule,
    Response = ArmResponse<AutomationRulesList>,
    Error = CloudError
  >;
}

@@doc(AutomationRule.name, "Automation rule ID");
@@doc(AutomationRule.properties, "Automation rule properties");
@@doc(AutomationRules.createOrUpdate::parameters.resource,
  "The automation rule"
);
