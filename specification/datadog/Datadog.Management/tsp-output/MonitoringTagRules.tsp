import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DatadogMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Datadog;
@doc("Capture logs and metrics of Azure resources based on ARM tags.")
@parentResource(DatadogMonitorResource)
model MonitoringTagRules is ProxyResource<MonitoringTagRulesProperties> {
  @doc("Rule set name")
  @key("ruleSetName")
  @segment("tagRules")
  name: string;
}

@armResourceOperations
@projectedName("client", "TagRules")
interface MonitoringTagRules_TagRules {
  @doc("Get a tag rule set for a given monitor resource.")
  get is ArmResourceRead<MonitoringTagRules>;

  @doc("Create or update a tag rule set for a given monitor resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MonitoringTagRules>;

  @doc("List the tag rules for a given monitor resource.")
  list is ArmResourceListByParent<MonitoringTagRules>;
}
