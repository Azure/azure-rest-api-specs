import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DynatraceMonitor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Dynatrace;
@doc("Tag rules for a monitor resource")
@parentResource(DynatraceMonitor)
model DynatraceTagRule is ProxyResource<MonitoringTagRulesProperties> {
  @doc("Monitor resource name")
  @path
  @key("ruleSetName")
  @segment("tagRules")
  name: string;
}

@armResourceOperations
interface DynatraceTagRules {
  @doc("Get a TagRule")
  get is ArmResourceRead<DynatraceTagRule>;
  @doc("Create a TagRule")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DynatraceTagRule>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Update a TagRule")
  update is ArmCustomPatchSync<DynatraceTagRule, TagRuleUpdate>;
  @doc("Delete a TagRule")
  delete is ArmResourceDeleteAsync<DynatraceTagRule>;
  @doc("List all TagRule by monitorName")
  list is ArmResourceListByParent<DynatraceTagRule>;
}
