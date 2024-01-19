import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ElasticMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Elastic;
@doc("Capture logs and metrics of Azure resources based on ARM tags.")
@parentResource(ElasticMonitorResource)
model MonitoringTagRules is ProxyResource<MonitoringTagRulesProperties> {
  @doc("Tag Rule Set resource name")
  @path
  @key("ruleSetName")
  @segment("tagRules")
  name: string;
}

@armResourceOperations
@projectedName("client", "MonitoringTagRules")
interface MonitoringTagRulesOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a tag rule set for a given monitor resource.")
  @operationId("TagRules_Get")
  get is ArmResourceRead<MonitoringTagRules>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a tag rule set for a given monitor resource.")
  @operationId("TagRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MonitoringTagRules>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a tag rule set for a given monitor resource.")
  @operationId("TagRules_Delete")
  delete is ArmResourceDeleteAsync<MonitoringTagRules>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the tag rules for a given monitor resource.")
  @operationId("TagRules_List")
  list is ArmResourceListByParent<MonitoringTagRules>;
}

@@projectedName(MonitoringTagRulesOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(MonitoringTagRulesOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(MonitoringTagRulesOperationGroup.createOrUpdate::parameters.resource,
  "request body of MonitoringTagRules"
);
