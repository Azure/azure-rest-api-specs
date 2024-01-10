import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Dynatrace.Observability;
@doc("Tag rules for a monitor resource")
@parentResource(MonitorResource)
model TagRule is ProxyResource<MonitoringTagRulesProperties> {
  @doc("Monitor resource name")
  @key("ruleSetName")
  @segment("tagRules")
  name: string;
}

@armResourceOperations
interface TagRules {
  @doc("Get a TagRule")
  get is ArmResourceRead<TagRule>;

  @doc("Create a TagRule")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<TagRule>;

  @doc("Update a TagRule")
  update is ArmCustomPatchSync<TagRule, TagRuleUpdate>;

  @doc("Delete a TagRule")
  delete is ArmResourceDeleteAsync<TagRule>;

  @doc("List all TagRule by monitorName")
  list is ArmResourceListByParent<TagRule>;
}
