import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
// FIXME: AlertRule has no properties property
@doc("Alert rule.")
model AlertRule is ProxyResource<{}> {
  @doc("Alert rule ID")
  @path
  @key("ruleId")
  @segment("alertRules")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface AlertRules {
  @doc("Gets the alert rule.")
  get is ArmResourceRead<AlertRule>;
  @doc("Creates or updates the alert rule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AlertRule>;
  @doc("Delete the alert rule.")
  delete is ArmResourceDeleteSync<AlertRule>;
  @doc("Gets all alert rules.")
  list is ArmResourceListByParent<AlertRule>;
}
