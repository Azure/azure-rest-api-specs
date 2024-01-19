import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Dynatrace.Observability;
@doc("Tag rules for a monitor resource")
@parentResource(MonitorResource)
model TagRule is ProxyResource<MonitoringTagRulesProperties> {
  @doc("Monitor resource name")
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

  @doc("List all TagRule by monitorName")
  list is ArmResourceListByParent<TagRule>;
}

@@projectedName(TagRules.update::parameters.properties, "json", "resource");
@@extension(TagRules.update::parameters.properties,
  "x-ms-client-name",
  "resource"
);
