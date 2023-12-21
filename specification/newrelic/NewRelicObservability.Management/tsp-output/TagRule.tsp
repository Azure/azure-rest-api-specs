import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NewRelicMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NewRelicObservability;
@doc("A tag rule belonging to NewRelic account")
@parentResource(NewRelicMonitorResource)
model TagRule is ProxyResource<MonitoringTagRulesProperties> {
  @doc("Name of the TagRule")
  @path
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
  update is ArmResourcePatchSync<TagRule, MonitoringTagRulesProperties>;
  @doc("Delete a TagRule")
  delete is ArmResourceDeleteAsync<TagRule>;
  @doc("List TagRule resources by NewRelicMonitorResource")
  listByNewRelicMonitorResource is ArmResourceListByParent<TagRule>;
}
