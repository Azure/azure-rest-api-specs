import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatadogMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Datadog;
/**
 * Capture logs and metrics of Azure resources based on ARM tags.
 */
@parentResource(DatadogMonitorResource)
model MonitoringTagRules
  is Azure.ResourceManager.ProxyResource<MonitoringTagRulesProperties> {
  ...ResourceNameParameter<
    Resource = MonitoringTagRules,
    KeyName = "ruleSetName",
    SegmentName = "tagRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TagRulesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * Monitor resource name
         */
        @path
        @segment("monitors")
        monitorName: string,
      },
      {
        /**
         * Rule set name
         */
        @path
        @segment("tagRules")
        ruleSetName: string,
      },
      ErrorResponse
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface TagRules {
  /**
   * Get a tag rule set for a given monitor resource.
   */
  get is ArmResourceRead<MonitoringTagRules>;

  /**
   * Create or update a tag rule set for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is TagRulesOps.CreateOrUpdateAsync<
    MonitoringTagRules,
    Response = ArmResourceUpdatedResponse<MonitoringTagRules>,
    OptionalRequestBody = true
  >;

  /**
   * List the tag rules for a given monitor resource.
   */
  list is ArmResourceListByParent<
    MonitoringTagRules,
    Response = ArmResponse<MonitoringTagRulesListResponse>
  >;
}

@@doc(MonitoringTagRules.name, "Rule set name");
@@doc(MonitoringTagRules.properties,
  "Definition of the properties for a TagRules resource."
);
@@doc(TagRules.createOrUpdate::parameters.resource, "");
