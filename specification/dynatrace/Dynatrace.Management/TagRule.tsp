import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Dynatrace.Observability;
/**
 * Tag rules for a monitor resource
 */
@parentResource(MonitorResource)
model TagRule
  is Azure.ResourceManager.ProxyResource<MonitoringTagRulesProperties, false> {
  ...ResourceNameParameter<
    Resource = TagRule,
    KeyName = "ruleSetName",
    SegmentName = "tagRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TagRules {
  /**
   * Get a TagRule
   */
  get is ArmResourceRead<TagRule>;

  /**
   * Create a TagRule
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TagRule>;

  /**
   * Delete a TagRule
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    TagRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all TagRule by monitorName
   */
  list is ArmResourceListByParent<TagRule>;
}

@@doc(TagRule.name, "Monitor resource name");
@@doc(TagRule.properties,
  "The resource-specific properties for this resource."
);
