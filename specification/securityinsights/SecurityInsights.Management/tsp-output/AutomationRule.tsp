import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;

model AutomationRule is ProxyResource<AutomationRuleProperties> {
  @doc("Automation rule ID")
  @path
  @key("automationRuleId")
  @segment("automationRules")
  name: string;
}

@armResourceOperations
interface AutomationRules {
  @doc("Gets the automation rule.")
  get is ArmResourceRead<AutomationRule>;
  @doc("Creates or updates the automation rule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomationRule>;
  @doc("Delete the automation rule.")
  delete is ArmResourceDeleteSync<AutomationRule>;
  @doc("Gets all automation rules.")
  list is ArmResourceListByParent<AutomationRule>;
}
