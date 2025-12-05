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
    NamePattern = "^[a-zA-Z]*$"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    TagRule,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
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
