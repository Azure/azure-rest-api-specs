import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ElasticMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Elastic;
/**
 * Capture logs and metrics of Azure resources based on ARM tags.
 */
@parentResource(ElasticMonitorResource)
model MonitoringTagRules
  is Azure.ResourceManager.ProxyResource<MonitoringTagRulesProperties> {
  ...ResourceNameParameter<
    Resource = MonitoringTagRules,
    KeyName = "ruleSetName",
    SegmentName = "tagRules",
    NamePattern = "^.*$"
  >;
}

@armResourceOperations
interface TagRules {
  /**
   * Get a tag rule set for a given monitor resource.
   */
  get is ArmResourceRead<
    MonitoringTagRules,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create or update a tag rule set for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    MonitoringTagRules,
    Response = ArmResourceUpdatedResponse<MonitoringTagRules>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Delete a tag rule set for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    MonitoringTagRules,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List the tag rules for a given monitor resource.
   */
  list is ArmResourceListByParent<
    MonitoringTagRules,
    Response = ArmResponse<MonitoringTagRulesListResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;
}

@@doc(MonitoringTagRules.name, "Tag Rule Set resource name");
@@doc(MonitoringTagRules.properties, "Properties of the monitoring tag rules.");
@@doc(TagRules.createOrUpdate::parameters.resource,
  "request body of MonitoringTagRules"
);
