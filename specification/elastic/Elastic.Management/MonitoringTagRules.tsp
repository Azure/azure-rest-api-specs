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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface TagRulesCreateOrUpdateResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("monitors")
        @pattern("^.*$")
        monitorName: string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("tagRules")
        @pattern("^.*$")
        ruleSetName: string,
      },
      ErrorType = ResourceProviderDefaultErrorResponse
    > {}

@armResourceOperations
interface TagRules {
  /**
   * Get detailed information about a tag rule set for a given Elastic monitor resource.
   */
  get is ArmResourceRead<
    MonitoringTagRules,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create or update a tag rule set for a given Elastic monitor resource, enabling fine-grained control over observability based on resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is TagRulesCreateOrUpdateResourceOps.CreateOrUpdateAsync<
    MonitoringTagRules,
    Response = ArmResourceUpdatedResponse<MonitoringTagRules>,
    OptionalRequestBody = true
  >;

  /**
   * Delete a tag rule set for a given Elastic monitor resource, removing fine-grained control over observability based on resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    MonitoringTagRules,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all tag rules for a given Elastic monitor resource, helping you manage fine-grained control over observability based on resource tags.
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
