import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NewRelicMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace NewRelic.Observability;
/**
 * A tag rule belonging to NewRelic account
 */
@parentResource(NewRelicMonitorResource)
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
interface TagRulesOperations
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the Monitors resource */
        @path
        @segment("monitors")
        @pattern("")
        monitorName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = TagRule,
        KeyName = "ruleSetName",
        SegmentName = "tagRules",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface TagRules {
  /**
   * Retrieves the details of the tag rules for a specific New Relic monitor resource, providing insight into its setup and status
   */
  get is TagRulesOperations.Read<TagRule>;

  /**
   * Creates a new set of tag rules for a specific New Relic monitor resource, determining which Azure resources are monitored based on their tags
   */
  createOrUpdate is TagRulesOperations.CreateOrUpdateAsync<TagRule>;

  /**
   * Updates the tag rules for a specific New Relic monitor resource, allowing you to modify the rules that control which Azure resources are monitored
   */
  @patch(#{ implicitOptionality: false })
  update is TagRulesOperations.CustomPatchSync<
    TagRule,
    PatchModel = TagRuleUpdate
  >;

  /**
   * Deletes a tag rule set for a given New Relic monitor resource, removing fine-grained control over observability based on resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is TagRulesOperations.DeleteWithoutOkAsync<
    TagRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all tag rules associated with a specific New Relic monitor resource, helping you manage and audit the rules that control resource monitoring
   */
  listByNewRelicMonitorResource is TagRulesOperations.List<TagRule>;
}

@@doc(TagRule.name, "Name of the TagRule");
@@doc(TagRule.properties,
  "The resource-specific properties for this resource."
);
