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
model MonitoringTagRule is ProxyResource<MonitoringTagRulesProperties> {
  @doc("Rule set name")
  @path
  @key("ruleSetName")
  @segment("tagRules")
  name: string;
}

@armResourceOperations
interface MonitoringTagRules {
  @doc("Get a tag rule set for a given monitor resource.")
  get is ArmResourceRead<MonitoringTagRule>;
  @doc("Create or update a tag rule set for a given monitor resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MonitoringTagRule>;
  @doc("List the tag rules for a given monitor resource.")
  list is ArmResourceListByParent<MonitoringTagRule>;
}
