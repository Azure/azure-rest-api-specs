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

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias AutomationRuleWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface AutomationRules {
  /**
   * Gets the automation rule.
   */
  get is ArmResourceRead<AutomationRule>;

  /**
   * Creates or updates the automation rule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomationRule>;

  /**
   * Delete the automation rule.
   */
  delete is ArmResourceDeleteSync<
    AutomationRule,
    Response = ArmResponse<{}> | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all automation rules.
   */
  list is ArmResourceListByParent<
    AutomationRule,
    Response = ArmResponse<AutomationRulesList>
  >;
}

@@doc(AutomationRule.name, "Automation rule ID");
@@doc(AutomationRule.properties, "Automation rule properties");
@@doc(AutomationRules.createOrUpdate::parameters.resource,
  "The automation rule"
);
