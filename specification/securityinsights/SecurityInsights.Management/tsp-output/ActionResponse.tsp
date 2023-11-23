import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AlertRule.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
@doc("Action for alert rule.")
@parentResource(AlertRule)
model ActionResponse is ProxyResource<ActionResponseProperties> {
  @doc("Action ID")
  @path
  @key("actionId")
  @segment("actions")
  name: string;
}

@armResourceOperations
interface ActionResponses {
  @doc("Gets the action of alert rule.")
  get is ArmResourceRead<ActionResponse>;
  @doc("Creates or updates the action of alert rule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ActionResponse>;
  @doc("Delete the action of alert rule.")
  delete is ArmResourceDeleteSync<ActionResponse>;
  @doc("Gets all actions of alert rule.")
  listByAlertRule is ArmResourceListByParent<ActionResponse>;
}
