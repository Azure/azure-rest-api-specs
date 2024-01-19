import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NewRelicMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace NewRelic.Observability;
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
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    TagRule,
    BaseParameters<TagRule>,
    ArmAsyncOperationHeader
  >;

  @doc("Update a TagRule")
  update is ArmCustomPatchSync<TagRule, TagRuleUpdate>;

  @doc("Delete a TagRule")
  delete is ArmResourceDeleteAsync<
    TagRule,
    BaseParameters<TagRule>,
    ArmAsyncOperationHeader
  >;

  @doc("List TagRule resources by NewRelicMonitorResource")
  listByNewRelicMonitorResource is ArmResourceListByParent<TagRule>;
}
