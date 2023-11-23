import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
// FIXME: AlertRuleTemplate has no properties property
@doc("Alert rule template.")
model AlertRuleTemplate is ProxyResource<{}> {
  @doc("Alert rule template ID")
  @path
  @key("alertRuleTemplateId")
  @segment("alertRuleTemplates")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface AlertRuleTemplates {
  @doc("Gets the alert rule template.")
  get is ArmResourceRead<AlertRuleTemplate>;
  @doc("Gets all alert rule templates.")
  list is ArmResourceListByParent<AlertRuleTemplate>;
}
