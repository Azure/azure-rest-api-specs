import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ElasticMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Elastic;
@doc("Capture logs and metrics of Azure resources based on ARM tags.")
@parentResource(ElasticMonitorResource)
model MonitoringTagRules is ProxyResource<MonitoringTagRulesProperties> {
  @doc("Tag Rule Set resource name")
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

  @doc("Delete a tag rule set for a given monitor resource.")
  delete is ArmResourceDeleteAsync<MonitoringTagRules>;

  @doc("List the tag rules for a given monitor resource.")
  list is ArmResourceListByParent<MonitoringTagRules>;
}
